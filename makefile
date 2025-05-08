FILE = resume.md
TEMPFILE = temp_resume.md
VER = $(shell date +%Y.%m)

.PHONY: all clean

define prepare_and_pandoc
	sed "s/{{VER}}/$(VER)/g" $(FILE) > $(TEMPFILE); \
	pandoc $(TEMPFILE) $(1) -o output/$(2); \
	rm -f $(TEMPFILE)
endef

resume.pdf:
	$(call prepare_and_pandoc, -t html --template templates/resume.html --css=templates/style.css --section-divs --pdf-engine=weasyprint --pdf-engine-opt=--pdf-variant=pdf/ua-1 --metadata-file=metadata.yaml,$@)

resume.txt:
	$(call prepare_and_pandoc, -f markdown -t plain,$@)

resume.html:
	$(call prepare_and_pandoc, -f markdown -t html -c templates/style.css --section-divs --self-contained,$@)

resume.docx:
	$(call prepare_and_pandoc,,$@)

resume.tex:
	$(call prepare_and_pandoc, -t context,$@)

all: resume.pdf resume.txt resume.html resume.docx resume.tex

clean:
	rm -f $(TEMPFILE) output/*
