all: docx pdf odt txt

docx: $(patsubst %.md,%.docx,$(wildcard */*.md))

pdf: $(patsubst %.md,%.pdf,$(wildcard */*.md))

odt: $(patsubst %.md,%.odt,$(wildcard */*.md))

txt: $(patsubst %.md,%.txt,$(wildcard */*.md))

%.docx: %.odt
	soffice --headless --convert-to docx $< --outdir $(<D)

%.pdf: %.odt
	soffice --headless --convert-to pdf $< --outdir $(<D)

%.odt: %.md Makefile
	make $(@D)/reference.odt
	pandoc --from=markdown --to=odt -o $@ --reference-doc=$(@D)/reference.odt $<

%.txt: %.md
	ln -snf $< $@

%/reference.odt:
	[ -r $@ ] || pandoc -o "$@" --print-default-data-file reference.odt

