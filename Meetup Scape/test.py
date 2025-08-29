import time
import requests
from bs4 import BeautifulSoup
import pandas as pd
import concurrent.futures

# open meetup site with BeautifulSoup and handle errors
def open_site(url):
    try:
        page = requests.get(url)
        soup = BeautifulSoup(page.content, 'html.parser')
        return soup
    except:
        return None
