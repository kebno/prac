import sys
from flask import Flask, render_template
from flask_flatpages import FlatPages, pygments_style_defs
from flask_frozen import Freezer
from flaskext.markdown import Markdown

DEBUG = True
FLATPAGES_AUTO_RELOAD = DEBUG
FLATPAGES_EXTENSION = '.md'
FLATPAGES_ROOT = 'content'
POST_DIR = 'posts'
PAGE_DIR = 'pages'
SITE_NAME = 'A Homepage'
SERVER_PORT = 8000


app = Flask(__name__)
flatpages = FlatPages(app)
freezer = Freezer(app)
md = Markdown(app, extensions = ['codehilite'] )
app.config.from_object(__name__)

@app.route("/")
def index():
    '''On the index page of our blog, show a list of blog posts'''
    posts = [p for p in flatpages if p.path.startswith(POST_DIR)]
    pages = [p for p in flatpages if p.path.startswith(PAGE_DIR)]    
    return render_template('index.html', posts=posts, pages=pages)

@app.route('/pages/<name>/')
def page(name):
    '''For non-blogpost type pages, e.g. About'''
    path = '{}/{}'.format(PAGE_DIR, name)
    page = flatpages.get_or_404(path)
    return render_template('page.html', page=page)

@app.route('/posts/<name>/')
def post(name):
    '''For blogpost type pages'''
    path = '{}/{}'.format(POST_DIR, name)
    post = flatpages.get_or_404(path)
    return render_template('post.html', post=post)

@app.route('/static/pygments.css')
def pygments_css():
    return pygments_style_defs('tango'), 200, {'Content-Type': 'text/css'}

if __name__ == "__main__":
    if len(sys.argv) > 1 and sys.argv[1] == "build":
        freezer.freeze()
    else:
        app.run(port=8000)
