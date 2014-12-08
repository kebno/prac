# Natural Clock

A clock with time relative to sunrise/sunset/noon.

## Specification

### Following the guidelines of Designing Programs 2ed

* worldstate: 
  - sunrise time, sunset time, last update time, current time
* setup: user types things into source 
  - Type in sunrise, sunset
* render: worldstate -> image
  - Sets the display text, text and background colors
* clock-tick-handler: worldstate -> worldstate
  - Compute display time
    - sunset - sunrise
    - now > sunrise && now < halftime: display +(now - sunrise)
    - now > sunrise && now > halftime: display -(sunset - now)

  - Call render
* key-stroke-handler: worldstate keyevent -> worldstate
* mouse-event-handler: worldstate mouseevents -> worldstate
* end?
