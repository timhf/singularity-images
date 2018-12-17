SINGULARITY_FILES=$(shell find * -type f -name Singularity)
IMAGES=$(subst /,\:,$(subst /Singularity,,$(SINGULARITY_FILES)))
DEPENDS=.depends.mk

.PHONY: all clean $(IMAGES)

all: $(IMAGES)

clean:
    rm -f $(DEPENDS)

$(IMAGES): %:
		sudo singularity build .. $@
