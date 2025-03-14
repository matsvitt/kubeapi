from fastapi import FastAPI
from pydantic import BaseModel
import logging
import os
import json

logging.basicConfig(level=logging.INFO)


logging.info(f"Starting test api v2")

app = FastAPI()

db = {}  # Simulated in-memory database
db_shared = {}  # Simulated in-memory shared database

class Item(BaseModel):
    id: int
    data: str

@app.post("/create")
def create_item(item: Item):
    db[item.id] = item.data
    
    if os.path.exists("/data"):
        with open(f"/data/data{item.id}.json","w") as f:
            json.dump(item.model_dump_json(), f)
            logging.info(f"Data saved to /data/data{item.id}.json") 
    else:
         logging.warning("/data directory does not exist")   
    return {"message": "Item created", "id": item.id}

@app.post("/createshared")
def create_shared_item(item: Item):
    db_shared[item.id] = item.data
    if os.path.exists("/datashared"):
        with open(f"/datashared/data{item.id}.json","w") as f:
            json.dump(item.model_dump_json(), f)
            logging.info(f"Data saved to /datashared/data{item.id}.json") 
    else:
         logging.warning("/data directory does not exist")  
    return {"message": "Shared item created", "id": item.id}

@app.get("/read/{id}")
def read_item(id: int):
    logging.info(f"about to read itm {id}")
    if os.path.exists(f"/data/data{id}.json"):
        with open(f"/data/data{id}.json","r") as f:
            data = json.load(f)
            logging.info(f"Data read from /data/data{id}.json")
            return data
    elif id in db:
        logging.info(f"Data read from in-memory database")
        return {"id": id, "data": db[id] , "source" : "inmemory" }
    return {"error": "Item not found"}

@app.get("/readshared/{id}")
def read_shared_item(id: int):
    logging.info(f"about to share read item {id}")
    if os.path.exists(f"/datashared/data{id}.json"):
        with open(f"/datashared/data{id}.json","r") as f:
            data = json.load(f)
            logging.info(f"Data read from /datashared/data{id}.json")
            return data    
    elif id in db_shared:
        logging.info(f"Data read from in-memory shared database")
        return {"id": id, "data": db_shared[id] , "source" : "inmemory"}
    return {"error": "Shared item not found"}

@app.get("/hello")
def hello():
    return "<html><body><h1>Hi there from fast api!</h1></body></html>"   
