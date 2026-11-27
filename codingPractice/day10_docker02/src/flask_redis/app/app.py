from functools import cache
import os
import redis
from flask import Flask

#Create and instance of Flask Library
app = Flask(__name__)

#Create a client connection to redis server
cache = redis.Redis(
    host = os.getenv("REDIS_HOST", "redis"),
    port = os.os.getenv("REDIS_PORT", "6379"),
    )

#Decorator map the homepage '/' to firstapp function
@app.route("/")

def firstapp():
    count = cache.incr("hits")
    return f"This is my first flask redis app. I have been tested {count} time(s).\n"


