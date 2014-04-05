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
                text: 'Default'
        Label:
                text: '{} Units'.format(s1.value)
        CarefulSlider:
                id: s1


<CarefulSlider@Slider>:
        min: 0
        max: 2000
        value: 150
        step: 5
        on_touch_up: self.parent.update_param(self.value) if self.collide_point(*args[1].pos) else None

''')


class LabeledSlider(BoxLayout):
    def update_param(self,val):
        print("Slider at {}".format(val)) 
    
class TestAsyncApp(App):
    def build(self):
        layout = BoxLayout(orientation='vertical')
        layout.add_widget(Button(text='Hello There'))
        
        layout.add_widget(LabeledSlider())
        
        return layout
    #CenteredAsyncImage(
    #            source='http://kivy.org/funny-pictures-cat-is-expecting-you.jpg')

if __name__ == '__main__':
    TestAsyncApp().run()
