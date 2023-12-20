from selenium import webdriver
from selenium.webdriver.chrome.service import Service as ChromeService
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.options import Options
from chromedriver_py import binary_path
from bs4 import BeautifulSoup
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
        print(url)

        # Give the page some time to load JavaScript-generated content
        T.sleep(2)

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

    if target_elements:
        print(f"All instances of '{target_element}' found with their children:")
        prices = []
        for element in target_elements:
            print(type(element))
            prices.append(float(element.contents[0].split('\xa0')[0].replace(',', '.')))
            print(element.prettify())  # Print each instance along with its children in a readable format
            print("\n" + "=" * 50 + "\n")  # Separate each instance for better readability
        print(prices)
        print(min(prices))
    else:
        print(f"No instances of '{target_element}' found in the HTML content.")

if __name__ == "__main__":
    # Replace 'https://example.com' with the starting URL
    date = '2023-12-22'
    time = '17:09'
    trip_to_berlin = f'https://www.bahn.de/buchung/fahrplan/suche#sts=true&so=M%C3%BCnchen%20Hbf&zo=Berlin%20Hbf&kl=2&r=13:16:KLASSENLOS:1&soid=A%3D1%40O%3DM%C3%BCnchen%20Hbf%40X%3D11558339%40Y%3D48140229%40U%3D81%40L%3D8000261%40B%3D1%40p%3D1702504538%40i%3DU%C3%97008020347%40&zoid=A%3D1%40O%3DBerlin%20Hbf%40X%3D13369549%40Y%3D52525589%40U%3D81%40L%3D8011160%40B%3D1%40p%3D1702504538%40i%3DU%C3%97008065969%40&sot=ST&zot=ST&soei=8000261&zoei=8011160&hd={date}T{time}:36&hza=D&ar=false&s=true&d=true&hz=%5B%5D&fm=false&bp=false'
    start_url = trip_to_berlin 

    html_content = selenium_scraper(start_url)
    if not html_content is None:
        search_in_html(html_content)
