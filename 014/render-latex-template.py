# code from user “queueoverflow” at https://stackoverflow.com/questions/14878729

import jinja2
import math

# Setting up Jinja
env = jinja2.Environment(
    "%<", ">%",
    "<<", ">>",
    "[§", "§]",
    loader=jinja2.FileSystemLoader(".")
)
template = env.get_template("fig-display.tex")

# Rendering LaTeX document with values.
with open("out.tex", "w") as f:
    f.write(template.render(**locals()))
