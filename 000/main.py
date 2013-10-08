# prac 000 - argparse & twisted
import argparse

desc = '''
Setup argparse for basic command line option handling.
Use twisted to do things.
'''
import argparse, sys

def main(argv):
    parser = argparse.ArgumentParser(description=desc)
    parser.add_argument('--forecast', action="store_true", dest="forecast",
                        help='Get weather in Portland')
    parser.add_argument('--host', default='localhost', metavar='Y',
                        help='Connect to host Y')
    parser.add_argument("--port", type=int, default=5001, metavar='X',
                        help="Connect to port X")
    args = parser.parse_args()

    if args.forecast:
        get_forecast()

def get_forecast():
    # the XML doc is from http://w1.weather.gov/xml/current_obs/KPDX.xml

    # for now
    print "Grey and rainy"
    sys.exit()

if __name__ == "__main__":
    main(sys.argv)
