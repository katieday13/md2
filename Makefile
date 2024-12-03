all: docx pdf odt

docx: $(patsubst %.md,%.docx,$(wildcard */*.md))

pdf: $(patsubst %.md,%.pdf,$(wildcard */*.md))

odt: $(patsubst %.md,%.odt,$(wildcard */*.md))

%.docx: %.odt
	soffice --headless --convert-to docx $< --outdir $(<D)

%.pdf: %.odt
	soffice --headless --convert-to pdf $< --outdir $(<D)

%.odt: %.md
	make $(@D)/reference.odt
	pandoc --from=gfm --to=odt -o $@ --reference-doc=$(@D)/reference.odt $<

%/reference.odt:
	[ -r $@ ] || pandoc -o "$@" --print-default-data-file reference.odt

