# Based on http://stackoverflow.com/a/2401181
import tkinter as tk
import time

class App(tk.Tk):
    def __init__(self, parent):
        tk.Tk.__init__(self, parent)
        self.parent = parent
        self.initialize()

    def initialize(self):
        self.grid()

        # The Time Text
        self.time_text = tk.StringVar() # allows triggering of watcher functions
        self.time_text.set("+3:58")

        # The Data Update Text
        self.data_update_text = tk.StringVar()
        self.data_update_text.set("Last Updated Long Ago")

        # First Row
        self.time_label = tk.Label(self, textvariable=self.time_text,
                font=("Helvetica", 100))
        self.time_label.grid(column=0,row=1,columnspan=2,sticky="N")

        # Second Row
        self.msg_label = tk.Label(self, textvariable=self.data_update_text, font=("Helvetica", 10))
        self.msg_label.grid(column=0,row=2,sticky='EW')
        
        self.update_button = tk.Button(self, text=u'Update Time Data', 
                font=("Helvetica", 10), command=self.on_button_click)
        self.update_button.grid(column=1, row=2, sticky='N')

        # Manage window resizing
        self.grid_columnconfigure(0,weight=1) # resize column 0, weight of 1
        self.resizable(False,False) # Prevent Resizing


    def on_button_click(self):
        self.data_update_text.set("Updated at " + time.strftime("%H:%M:%S"))

    def render(self):
        self.label.configure(text=new_text)
        self.root.after(1000, self.clock_tick_handler)


if __name__  == "__main__":
    app = App(None)
    app.title('Natural Clock')
    app.mainloop()


'''
        self.label = tk.Label(text="", font=("Helvetica", 40))
        self.label.pack()

    def update_clock(self, text):
        now = time.strftime("%H:%M:%S")
        self.label.configure(text=now)
        self.root.after(1000, self.update_clock)
'''

####  BACKGROUND INFO FOR LATER? ####
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



