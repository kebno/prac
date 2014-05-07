# Getting dressed

# An explicit rule assigns the commands for several targets
coat shoes mobile sweater socks trousers\
shirt pants undershirt: ; @echo put on $@; touch $@

# Implicit rules state the prerequisites


# target    prerequisite           command
# --------------------------------------------
coat:	    shoes mobile sweater
shoes:      socks trousers
mobile:     trousers
sweater:    shirt
trousers:   pants shirt
shirt:      undershirt
