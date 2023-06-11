from flask import Flask
from redis import Redis
import debugpy

app = Flask(__name__)
redis = Redis(host='redis', port=6379)

debugpy.listen(("0.0.0.0", 5678))
debugpy.wait_for_client()

@app.route('/')
def hello():
    redis.incr('hits')
    counter = str(redis.get('hits'),'utf-8')
    return "This webpage has been viewed "+counter+" time(s)!"

@app.route('/healthz')
def healthz():
    return "healthy"

@app.route('/readyz')
def readyz():
    return "ready"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8000, debug=True)
