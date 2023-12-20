from selenium import webdriver
from selenium.webdriver.chrome.service import Service as ChromeService
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from chromedriver_py import binary_path
from bs4 import BeautifulSoup
from datetime import timedelta, date
import time as T


def selenium_scraper(url):
    chrome_options = Options()
    chrome_options.add_argument('--headless')  # Run Chrome in headless mode (without GUI)
    chrome_service = ChromeService(executable_path=binary_path)  # Specify the path to chromedriver
    html_content = None

    try:
        # Set up the Chrome driver
        driver = webdriver.Chrome(service=chrome_service, options=chrome_options)
        driver.get(url)

        # Give the page some time to load JavaScript-generated content
        # some entries won't load if the sleep time is too short
        T.sleep(4)

        html_content = driver.page_source

    except Exception as e:
        print(f"Error scraping {url}: {e}")

    finally:
        # Close the driver
        driver.quit()

    return html_content


def search_in_html(html_content):
    soup = BeautifulSoup(html_content, 'html.parser')

    target_element = 'reise-preis__preis'
    # Find all instances of the target HTML element
    target_elements = soup.find_all('span', class_=target_element)

    prices = []

    if target_elements:
        for element in target_elements:
            prices.append(float(element.contents[0].split('\xa0')[0].replace(',', '.')))
    else:
        print(f"No instances of '{target_element}' found in the HTML content.")
    return prices


def calculate_trip(start_date, end_date, direction='munich_to_berlin', trip_days=[5, 6, 7], time='17:00') -> list[
    tuple[float, dict[str, float]]]:
    if not direction in ['munich_to_berlin', 'berlin_to_munich']:
        raise ValueError('Wrong input to parameter \"direction\"')
    day_count = (end_date - start_date).days + 1
    all_prices_to_munich = {}
    all_prices_to_berlin = {}
    for trip_forth_date in (start_date + timedelta(n) for n in range(day_count)):
        date = trip_forth_date.strftime("%Y-%m-%d")
        trip_to_berlin = f'https://www.bahn.de/buchung/fahrplan/suche#sts=true&so=M%C3%BCnchen%20Hbf&zo=Berlin%20Hbf&kl=2&r=13:16:KLASSENLOS:1&soid=A%3D1%40O%3DM%C3%BCnchen%20Hbf%40X%3D11558339%40Y%3D48140229%40U%3D81%40L%3D8000261%40B%3D1%40p%3D1702504538%40i%3DU%C3%97008020347%40&zoid=A%3D1%40O%3DBerlin%20Hbf%40X%3D13369549%40Y%3D52525589%40U%3D81%40L%3D8011160%40B%3D1%40p%3D1702504538%40i%3DU%C3%97008065969%40&sot=ST&zot=ST&soei=8000261&zoei=8011160&hd={date}T{time}:36&hza=D&ar=false&s=true&d=true&hz=%5B%5D&fm=false&bp=false'
        trip_to_munich = f'https://www.bahn.de/buchung/fahrplan/suche#sts=true&so=Berlin%20Hbf&zo=M%C3%BCnchen%20Hbf&kl=2&r=13:16:KLASSENLOS:1&soid=A%3D1%40O%3DBerlin%20Hbf%40X%3D13369549%40Y%3D52525589%40U%3D81%40L%3D8011160%40B%3D1%40p%3D1702504538%40i%3DU%C3%97008065969%40&zoid=A%3D1%40O%3DM%C3%BCnchen%20Hbf%40X%3D11558339%40Y%3D48140229%40U%3D81%40L%3D8000261%40B%3D1%40p%3D1702504538%40i%3DU%C3%97008020347%40&sot=ST&zot=ST&soei=8011160&zoei=8000261&hd={date}T{time}:36&hza=D&ar=false&s=true&d=true&hz=%5B%5D&fm=false&bp=false'

        html_content = selenium_scraper(trip_to_berlin)
        if not html_content is None:
            prices_to_berlin = search_in_html(html_content)
            print(
                f'Trip Munich to Berlin -> day: {date}, cheapest price: {min(prices_to_berlin) if len(prices_to_berlin) > 0 else None}{"€" if len(prices_to_berlin) > 0 else ""}')
            all_prices_to_berlin[date] = min(prices_to_berlin) if len(prices_to_berlin) > 0 else None

        html_content = selenium_scraper(trip_to_munich)
        if not html_content is None:
            prices_to_munich = search_in_html(html_content)
            print(
                f'Trip Berlin to Munich -> day: {date}, cheapest price: {min(prices_to_munich) if len(prices_to_munich) > 0 else None}{"€" if len(prices_to_munich) > 0 else ""}')
            all_prices_to_munich[date] = min(prices_to_munich) if len(prices_to_munich) > 0 else None

    complete_trips = []
    if direction == 'munich_to_berlin':
        all_prices_forth = all_prices_to_berlin
        all_prices_back = all_prices_to_munich
    else:
        all_prices_forth = all_prices_to_munich
        all_prices_back = all_prices_to_berlin
    for num_trip_days in trip_days:
        for trip_forth_date in (start_date + timedelta(n) for n in range(day_count)):
            trip_back_date = trip_forth_date + timedelta(num_trip_days)
            trip_forth_date_str = str(trip_forth_date)
            trip_back_date_str = str(trip_back_date)
            if not trip_back_date_str in all_prices_back.keys() or all_prices_back[
                trip_back_date_str] is None or all_prices_forth[trip_forth_date_str] is None:
                continue

            complete_trips.append(
                (all_prices_forth[trip_forth_date_str] + all_prices_back[trip_back_date_str], {
                    trip_forth_date_str: all_prices_forth[trip_forth_date_str],
                    trip_back_date_str: all_prices_back[trip_back_date_str]}))

    return complete_trips


if __name__ == "__main__":
    start_date = date(2024, 3, 22)
    end_date = date(2024, 4, 7)
    complete_trips = calculate_trip(start_date, end_date, 'berlin_to_munich', [5, 6, 7])
    for k, v in sorted(complete_trips, key=lambda x: x[0]):
        print(f'{k:.2f} -> {v}')
