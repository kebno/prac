# Based on http://stackoverflow.com/a/2401181
import tkinter as tk
import time

class App():
    def __init__(self):
        self.root = tk.Tk()
        self.label = tk.Label(text="", font=("Helvetica", 40))
        self.label.pack()
        self.update_clock()
        self.root.mainloop()

    def update_clock(self):
        now = time.strftime("%H:%M:%S")
        self.label.configure(text=now)
        self.root.after(1000, self.update_clock)

app=App()


# get data
# curl --output data.txt --data "FFX=1&xxy=2014&type=0&st=CA&place=San+Diego&ZZZ=END" http://aa.usno.navy.mil/cgi-bin/aa_rstablew.pl 
# strip header and footer from USNO table file
#sed '/</d' data.txt | sed '10,40!d' > table.txt


# read rows 
#   rows = [[x for x in line.split()[:-1]] for line in file]
# convert to lists from the columns
#   cols = [list(col) for col in zip(*rows)]
# Put them all together
#  sunrise, sunset = [], []
#  for x in range(1,13):
#      sunrise.append(cols[(x*2-1)])
#      sunset.append(cols[(x*2)])a
# Create a dict of the data, with JDOY as key
# Now write them out into a new file
#  for x in range(1, 365+1):
#      data_dict = {x: (sunrise[x], sunset[x]) for x in range(1, 365+1)}



