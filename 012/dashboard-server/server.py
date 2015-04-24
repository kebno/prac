#!/bin/python

from flask import Flask, render_template
import random, subprocess

app = Flask(__name__)

@app.route('/')
def hello_world():
	return render_template('dashboard.html', N_images=random.randint(1,9999),mb_used=random.randint(1,9999),disk_percent_used=random.randint(0,99))

@app.route('/date/')
def get_time():
    p = subprocess.Popen('date', shell=True, stdout=subprocess.PIPE,executable='/bin/bash')
    return p.communicate()[0]

if __name__ == '__main__':
	app.run(debug=True,host='0.0.0.0')
