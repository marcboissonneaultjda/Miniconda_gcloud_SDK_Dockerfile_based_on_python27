import sys

sys.path.append('/opt/miniconda/lib/python2.7/site-packages')

from flask import Flask
from google.appengine.ext import ndb
import traceback




class Cop(ndb.Model):
    name = ndb.StringProperty()

app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello World!+!'

@app.route('/insert_cop')
def insert_cop():
    try:
        Cop(name="Steve").put()
        return 'insert_cop ok'
    except:
        return traceback.format_exc()

@app.route('/path')
def sys_path():
    try:
        return str(sys.path)
    except:
        return traceback.format_exc()

@app.route('/import_pandas')
def import_pandas():
    try:
        from pandas import DataFrame
        return "import_pandas ok"
    except:
        return traceback.format_exc()

@app.route('/c')
def c_dependencies():
    try:
        import numpy
        numpy.array([[1,2], [3,4]])
        return "c_dependencies ok"
    except:
        return traceback.format_exc()

print(str(sys.path))

if __name__ == '__main__':
    app.run()



