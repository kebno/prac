from flask import Flask, render_template
from flask_flatpages import FlatPages

DEBUG = True
FLATPAGES_AUTO_RELOAD = DEBUG
FLATPAGES_EXTENSION = '.md'
FLATPAGES_ROOT = 'content'
POST_DIR = 'posts'
PAGE_DIR = 'pages'
SITE_NAME = 'A Homepage'
SERVER_PORT = 8000


app = Flask(__name__)
app.config.from_object(__name__)
flatpages = FlatPages(app)

@app.route("/")
def index():
    '''On the index page of our blog, show a list of blog posts'''
    posts = [p for p in flatpages if p.path.startswith(POST_DIR)]
    return render_template('index.html', posts=posts)

@app.route('/pages/<name>')
def page(name):
    '''For non-blogpost type pages, e.g. About'''
    path = '{}/{}'.format(PAGE_DIR, name)
    page = flatpages.get_or_404(path)
    return render_template('page.html', page=page)

@app.route('/posts/<name>')
def post(name):
    '''For blogpost type pages'''
    path = '{}/{}'.format(POST_DIR, name)
    post = flatpages.get_or_404(path)
    return render_template('post.html', post=post)

if __name__ == "__main__":
	app.run(port=8000)
