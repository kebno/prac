#!/bin/python

from flask import Flask, render_template, jsonify, send_file
import subprocess, os, json

app = Flask(__name__)

@app.route('/')
def hello_world():
	return render_template('dashboard.html')

@app.route('/status/')
def get_time():
    p = subprocess.Popen(os.getcwd() + '/get_tl_status.sh', cwd=os.getcwd(), shell=True, stdout=subprocess.PIPE,executable='/bin/bash')
    return jsonify(json.loads(p.communicate()[0]))

@app.route('/latest-image')
def latest_image():
    return send_file('latest-image.jpg',cache_timeout=1)

if __name__ == '__main__':
	app.run(debug=True,host='0.0.0.0')
