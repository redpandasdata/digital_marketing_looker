import pandas as pd
import numpy as np
import random
from datetime import datetime, timedelta

np.random.seed(42)

# -----------------------
# PARAMETERS
# -----------------------

N_CUSTOMERS = 1500
N_PRODUCTS = 50
N_ORDERS = 4000
N_SESSIONS = 8000

start_date = datetime(2022,1,1)
end_date = datetime(2024,12,31)

date_range_days = (end_date - start_date).days


# -----------------------
# CUSTOMERS TABLE
# -----------------------

customer_ids = np.arange(1, N_CUSTOMERS+1)

countries = ["France","Germany","Spain","UK","Italy"]
devices = ["mobile","desktop","tablet"]

customers = pd.DataFrame({
    "customer_id": customer_ids,
    "signup_date":[start_date + timedelta(days=random.randint(0,date_range_days)) for _ in customer_ids],
    "country":[random.choice(countries) for _ in customer_ids],
    "age":np.random.randint(18,65,size=N_CUSTOMERS),
    "device_preference":[random.choice(devices) for _ in customer_ids]
})


# -----------------------
# PRODUCTS TABLE
# -----------------------

categories = ["Fitness","Nutrition","Accessories","Wearables","Recovery"]

products = pd.DataFrame({
    "product_id":np.arange(1,N_PRODUCTS+1),
    "category":[random.choice(categories) for _ in range(N_PRODUCTS)],
    "price":np.round(np.random.uniform(10,200,N_PRODUCTS),2)
})


# -----------------------
# MARKETING CHANNELS
# -----------------------

channels = pd.DataFrame({
    "channel_id":[1,2,3,4,5],
    "channel_name":["SEO","Google Ads","Facebook Ads","Email","Affiliate"]
})


# -----------------------
# CAMPAIGNS
# -----------------------

campaigns = pd.DataFrame({
    "campaign_id":np.arange(1,21),
    "channel_id":[random.choice(channels.channel_id) for _ in range(20)],
    "campaign_name":[f"Campaign_{i}" for i in range(1,21)],
    "daily_budget":np.random.randint(100,2000,size=20)
})


# -----------------------
# WEBSITE SESSIONS
# -----------------------

sessions = []

for i in range(1,N_SESSIONS+1):

    session_date = start_date + timedelta(days=random.randint(0,date_range_days))
    customer = random.choice(customer_ids)

    campaign = random.choice(campaigns.campaign_id)

    sessions.append([
        i,
        customer,
        campaign,
        session_date,
        random.randint(1,10),
        random.choice([0,1])
    ])

sessions = pd.DataFrame(sessions,columns=[
    "session_id",
    "customer_id",
    "campaign_id",
    "session_date",
    "pages_viewed",
    "converted"
])


# -----------------------
# ORDERS
# -----------------------

orders = []

for i in range(1,N_ORDERS+1):

    customer = random.choice(customer_ids)
    order_date = start_date + timedelta(days=random.randint(0,date_range_days))

    orders.append([
        i,
        customer,
        order_date,
        random.choice(campaigns.campaign_id)
    ])

orders = pd.DataFrame(orders,columns=[
    "order_id",
    "customer_id",
    "order_date",
    "campaign_id"
])


# -----------------------
# ORDER ITEMS
# -----------------------

order_items = []

order_item_id = 1

for order in orders.order_id:

    n_items = random.randint(1,4)

    for _ in range(n_items):

        product = random.choice(products.product_id)

        price = products.loc[products.product_id==product,"price"].values[0]

        qty = random.randint(1,3)

        order_items.append([
            order_item_id,
            order,
            product,
            qty,
            price
        ])

        order_item_id += 1

order_items = pd.DataFrame(order_items,columns=[
    "order_item_id",
    "order_id",
    "product_id",
    "quantity",
    "unit_price"
])


# -----------------------
# EXPORT CSV
# -----------------------

customers.to_csv("data/customers.csv",index=False)
products.to_csv("data/products.csv",index=False)
channels.to_csv("data/marketing_channels.csv",index=False)
campaigns.to_csv("data/campaigns.csv",index=False)
sessions.to_csv("data/website_sessions.csv",index=False)
orders.to_csv("data/orders.csv",index=False)
order_items.to_csv("data/order_items.csv",index=False)

print("Datasets generated successfully!")