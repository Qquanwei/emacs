# markdown-dnd-images.el #

## Overview ##

Drag and drop files from your systems file manager onto your
current buffer and markdown-dnd-images will insert a markdown image
tag for you as well as make a copy of whatever file and put it in a
folder named like so

    ~/.emacs.d/markdown_image_files/images_for_Users_moorer_Documents_test.md/

where the markdown file you are inserting into is named
`/Users/moorer/Documents/test.md`

A new folder will be created for each markdown file you insert
into.

You can drag and drop images from a web browser as well and the
program will try and download the image and put it in the local
folder.

Technically, it doesn't have to be inserted into a buffer currently
in markdown-mode, but it is going to insert the markdown image tag
regardless.

## Installation ##

To load...

Place this file `markdown-dnd-images.el` somewhere in your load
path and put this (or something similiar) in your .emacs file.

    (require 'markdown-dnd-images)

## Notes ##

Spaces in file names will be replaced with underscores.

## TODO ##

Curretnly, this will supercede the normal drag and drop behavior in
all buffers. TODO: only for certain buffers?
