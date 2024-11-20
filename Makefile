SRC_DIR = book
BUILD_DIR = build
DOCS_DIR = docs
THEMES_DIR = $(SRC_DIR)/themes

# Files
BOOK_FILE = $(SRC_DIR)/book.adoc
HTML_OUTPUT = $(DOCS_DIR)/index.html
EPUB_OUTPUT = $(BUILD_DIR)/book.epub
PDF_OUTPUT = $(BUILD_DIR)/book.pdf

# CSS and themes
CSS_FILE = styles.css
PDF_THEME = $(THEMES_DIR)/dark-theme.yml

.PHONY: all html epub pdf clean

# Default target: builds all outputs
all: html epub pdf

# HTML target: builds the HTML version and places it in the docs directory
html: $(HTML_OUTPUT)

$(HTML_OUTPUT): $(BOOK_FILE) $(CSS_FILE)
	@mkdir -p $(DOCS_DIR)
	$(ASCIIDOCTOR) -a stylesheet=$(CSS_FILE) -D $(DOCS_DIR) -o index.html $(BOOK_FILE)

# EPUB target: builds the EPUB version and places it in the build directory
epub: $(EPUB_OUTPUT)
	podman run --rm \
		-v "$(pwd):/documents/" \
		asciidoctor/docker-asciidoctor \
		asciidoctor-epub3 \
		-D "build" \
		-a pdf-themesdir="./book/themes" \
		-a pdf-theme="dark-theme.yml" \
		-a pdf-fontsdir="./book/fonts" \
		"./book/book.adoc"

# Rule for book.adoc to ensure it's detected
$(BOOK_FILE): 
	@echo "Detected changes in $(BOOK_FILE)"

# Rule for book.adoc to ensure it's detected
$(CSS_FILE): 
	@echo "Detected changes in $(CSS_FILE)"


$(EPUB_OUTPUT): $(BOOK_FILE)
	@mkdir -p $(BUILD_DIR)
	$(ASCIIDOCTOR_EPUB3) -D $(BUILD_DIR) -o book.epub $(BOOK_FILE)

# PDF target: builds the PDF version and places it in the build directory
pdf: $(PDF_OUTPUT)

$(PDF_OUTPUT): $(BOOK_FILE) $(PDF_THEME)
	@mkdir -p $(BUILD_DIR)
	$(ASCIIDOCTOR_PDF) -a pdf-theme=$(PDF_THEME) -D $(BUILD_DIR) -o book.pdf $(BOOK_FILE)

# Clean target: removes build and docs directories
clean:
	rm -rf $(BUILD_DIR) $(DOCS_DIR)
