# Simplify converting Markdown to recruiter friendly formats

## Usage

* Create a directory for your set of markdown files (IE resumes)
* Create your Markdowns (see examples for ideas)
* `make` to update all to all formats
* Edit the directory/reference.odt to handle any style changes, headers, footers.
* `make foo.docx` to convert foo.md to foo.docx

## Concept

This is a thin [GNU Make](https://www.gnu.org/software/make/) wrapper around [pandoc](https://pandoc.org/) and [LibreOffice](https://www.libreoffice.org/).

It renders markdown to an ODT file using pandoc.  It then renders the odt to docx and pdf with LibreOffice.
