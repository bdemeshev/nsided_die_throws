# makefile: Rnw -> tex -> pdf
# v 2.0
# .Rnw extension is automatically added
file_name = filler-nsided

all: $(file_name).pdf nsided-cover.pdf

$(file_name).pdf: $(file_name).tex geometric_series.eps
	# protection against biber error
	# http://tex.stackexchange.com/questions/140814/
	rm -rf `biber --cache`

	# create pdf
	# will automatically run pdflatex/biber if necessary
	latexmk -shell-escape $(file_name).tex

	dvips $(file_name).dvi

	ps2pdf $(file_name).ps

	# clean auxillary files
	latexmk -c $(file_name).tex


geometric_series.eps: geometric_series.tex
	latex geometric_series.tex
	dvips -E geometric_series.dvi -o geometric_series.eps
	

nsided-cover.pdf: nsided-cover.tex
	# protection against biber error
	# http://tex.stackexchange.com/questions/140814/
	rm -rf `biber --cache`

	# create pdf
	# will automatically run pdflatex/biber if necessary
	latexmk -xelatex -shell-escape nsided-cover.tex

	# clean auxillary files
	latexmk -c nsided-cover.tex


clean:
	-rm $(file_name).pdf 
	-rm *.fls 
	-rm *.log
	-rm *.out
	-rm *.aux
	-rm *.fdb_latexmk
	-rm *-concordance.tex

