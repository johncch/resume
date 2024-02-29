FILE = resume.md

all: resume.pdf resume.txt resume.html resume.docx resume.tex

%.pdf:
	pandoc $(FILE) -t html --template templates/resume.html --css=templates/style.css --section-divs -o output/$@ --pdf-engine=weasyprint --pdf-engine-opt=--pdf-variant=pdf/ua-1 --metadata-file=metadata.yaml

%.txt:
	pandoc $(FILE) -f markdown -t plain -o output/$@

%.html:
	pandoc $(FILE) -f markdown -t html -c templates/style.css --section-divs -o output/$@ --self-contained 

%.docx:
	pandoc $(FILE) -o output/$@

%.tex:
	pandoc $(FILE) -t context -o output/$@
