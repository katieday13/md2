all: docx pdf odt txt

INPUTS = $(wildcard */*.md)

DOCX = $(patsubst %.md,%.docx,$(INPUTS))
docx: $(DOCX)

PDF = $(patsubst %.md,%.pdf,$(INPUTS))
pdf: $(PDF)

ODT = $(patsubst %.md,%.odt,$(INPUTS))
odt: $(ODT)

TXT = $(patsubst %.md,%.txt,$(INPUTS))
txt: $(TXT)

REFERENCE = $(addsuffix reference.odt,$(dir $(INPUTS)))
reference: $(REFERENCE)

.SECONDEXPANSION:

%.docx: %.odt
	soffice --headless --convert-to docx $< --outdir $(<D)

%.pdf: %.odt
	soffice --headless --convert-to pdf $< --outdir $(<D)

%.odt: %.md Makefile $$(@D)/reference.odt
#	make $(@D)/reference.odt
	pandoc --from=markdown --to=odt -o $@ --reference-doc=$(@D)/reference.odt $<

%.txt: %.md
	ln -snfr $< $@

%/reference.odt:
	[ -r $@ ] || pandoc -o "$@" --print-default-data-file reference.odt

clean:
	rm -vf $(DOCX) $(PDF) $(ODT) $(TXT) || :
