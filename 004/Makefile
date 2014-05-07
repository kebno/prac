# Getting dressed

# Declaration of a variable
articles  = coat shoes mobile sweater socks\
	    trousers shirt pants undershirt

# An explicit rule assigns the commands for several targets
$(articles): ; @echo put on $@; touch $@

# Implicit rules state the prerequisites
# target    prerequisite 
# ------------------------------
coat:	    shoes mobile sweater
shoes:      socks trousers
mobile:     trousers
sweater:    shirt
trousers:   pants shirt
shirt:      undershirt

# Additional feature
.PHONY: naked
naked:       ; @-rm $(articles)
