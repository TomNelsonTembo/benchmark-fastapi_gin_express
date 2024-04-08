import uvicorn
from blacksheep import Application


app = Application()

@app.router.route("/test/")
async def root():
    return {"status": 200, "message": "success"}

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=44777, log_level="info", access_log=False)