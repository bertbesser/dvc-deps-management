# Conversion to HTML
```
pandoc -f markdown-implicit_figures -s -t html --highlight-style dvc-highlight-style.theme --syntax-definition=bash.xml ../blog-article.md  | xclip -sel clip
```
