'''
Asynchronous image loading
==========================

Test of the widget AsyncImage.
We are just putting it in a CenteredAsyncImage for beeing able to center the
image on screen without doing upscale like the original AsyncImage.
'''

from kivy.app import App
from kivy.uix.image import AsyncImage
from kivy.uix.boxlayout import BoxLayout
from kivy.uix.slider import Slider
from kivy.lang import Builder
from kivy.uix.label import Label
from kivy.uix.button import Button

Builder.load_string('''
<LabeledSlider>:
        orientation: 'horizontal'
        size_hint_y: None
        height: '48dp'

        Label:
                id: name_label
                text: root.name
        Label:
                text: '{} {}'.format(s1.value, root.units)
        Slider:
                id: s1
                min: root.minval 
                max: root.maxval
                step: root.step
                # Needs checking of if touch down happened on it and then act on the up.
                on_touch_down: root.touchdown(True) if self.collide_point(*args[1].pos) else root.touchdown(None)
                on_touch_up: root.update_param(self.value) if root.down else None  
''')


class LabeledSlider(BoxLayout):
    def __init__(self,name,units,minval,maxval,step, **kwargs):
        self.name = name
        self.units = units
        self.minval = minval
        self.maxval = maxval
        self.step = step
        super(LabeledSlider, self).__init__(**kwargs)

    def touchdown(self,state):
        self.down = state

    def update_param(self,val):
        print("{} slider at {}".format(self.name,val))
        # Reset touch down flag
        self.down = None
    
class TestAsyncApp(App):
    def build(self):
        layout = BoxLayout(orientation='vertical')
        layout.add_widget(Button(text='Hello There'))
        
        fslider = LabeledSlider('Frequency',units='Hz',minval=0,maxval=2000,step=1)
        zslider = LabeledSlider('Source Depth',units='m',minval=0,maxval=500,step=1)
        layout.add_widget(fslider)
        layout.add_widget(zslider)

        return layout

if __name__ == '__main__':
    TestAsyncApp().run()
