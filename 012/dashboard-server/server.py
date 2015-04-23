#!/bin/python

from flask import Flask, render_template
import random

app = Flask(__name__)

@app.route('/')
def hello_world():
	return render_template('dashboard.html', N_images=random.randint(1,9999),mb_used=random.randint(1,9999),disk_percent_used=random.randint(0,99))

if __name__ == '__main__':
	app.run(host='0.0.0.0')
