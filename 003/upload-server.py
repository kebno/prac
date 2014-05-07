import os
from flask import Flask, request, url_for
from werkzeug.utils import secure_filename

UPLOAD_FOLDER = '/tmp'
SILENT = True
ALLOWED_EXTENSIONS = set(['txt', 'png', 'jpg', 'jpeg', 'gif'])

app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
app.config['MAX_CONTENT_LENGTH'] = 1024 * 1024 # one megabyte

upload_page = '''
    <!doctype html>
    <title>Upload new File</title>
    <h1>Upload new File</h1>
    <form action="" method=post enctype=multipart/form-data>
      <p><input type=file name=file>
         <input type=submit value=Upload>
    </form>
    '''

def allowed_file(filename):
    return '.' in filename and \
            filename.rsplit('.',1)[1] in ALLOWED_EXTENSIONS

@app.route('/', methods=['GET', 'POST'])
def upload_file():
    if request.method == 'POST':
        file = request.files['file']
        if file and allowed_file(file.filename):
            filename = secure_filename(file.filename)
            file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
            if SILENT:
                return 'Success'
            else:
                return upload_page + '''
                                    <hr>
                                    <h3>Upload Successful</h3>
                                    <hr>'''

    return upload_page

if __name__ == '__main__':
    app.run(host='0.0.0.0')
