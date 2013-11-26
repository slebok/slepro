ssh-user = softlang@linux.uni-koblenz.de
www-dir = /home/softlang/www/slepro

paper.pdf: *.tex *.bib Makefile *.sty
#	pdflatex paper
#	bibtex paper
	pdflatex paper
	pdflatex paper

clean:
	rm -f *.pdf *.toc *.blg *.bbl *.log *.aux *.dvi *.ps *.out *.spl

upload: create-webdir
	scp -r -p paper.pdf ${ssh-user}:${www-dir}/ueber.pdf

upload-html:
#	scp -r -p index.html ${ssh-user}:${www-dir}

create-webdir:
	ssh ${ssh-user} mkdir -p ${www-dir}

