ssh-user = softlang@linux.uni-koblenz.de
www-dir = /home/softlang/www

paper.pdf: *.tex *.bib Makefile *.sty
#	pdflatex paper
#	bibtex paper
	pdflatex paper
	pdflatex paper

clean:
	rm -f *.pdf *.toc *.blg *.bbl *.log *.aux *.dvi *.ps *.out *.spl

upload: create-webdir
	scp -r -p paper.pdf ${ssh-user}:${www-dir}/slepro/fsml.pdf
	make upload-html

upload-html:
	scp -r -p index.html ${ssh-user}:${www-dir}/fsml

create-webdir:
	ssh ${ssh-user} mkdir -p ${www-dir}/fsml
	ssh ${ssh-user} mkdir -p ${www-dir}/slepro

