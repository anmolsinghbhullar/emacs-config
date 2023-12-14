# My Personal Emacs Config

Based on my day-to-day needs. I'm a heavy `org` user so there's a bunch of that mixed in as well. Current list of packages:

1. [https://racket-mode.com/](racket-mode) - Racket is (imo) the best Lisp dialect for apple silicon mac(books)
2. [https://github.com/bastibe/org-journal](org-journal) - Intuitive daily/weekly/monthly/yearly journaling (plus, it has built in encryption!)
3. [https://jblevins.org/projects/markdown-mode/](markdown-mode) - I don't like the default syntax highlighting for `.md` files and this also looks good with `.mdx` files as well.
4. [https://company-mode.github.io/](company) - My favourite buffer-completion package. Has support for most languages.
5. [https://github.com/minad/vertico](vertico) - Really good package for minibuffer completion. Has a ton of other useful features I don't make use of that I should.
6. [https://github.com/minad/marginalia](marginalia) - Annotates minibuffer commands (useful for emacs beginners like me)

## Requirements
The config is built and tested on [https://github.com/railwaycat/homebrew-emacsmacport](railwaycat)'s 
emacs port for MacOS. This means if you're using it on another platform/emacs implementation,
then some things _may not_ work. 

The first thing I would do if you use this on another platform is to check and see if 
`racket-mode`'s executable is present in your PATH. You can change the path that it looks 
for with the `racket-program` variable.

## Installation
1. Simply download (or clone) this git repo into your machine and then move it to your home directory and overwrite your current `.emacs.d` directory with this one (I would backup your old one first!).
2. Make sure to change the paths in `org` and `org-journal` (in their respective `use-package` blocks) to suit your own machine's.

### Optional Settings
1. Feel free to customize the file header for each journal entry to suit your needs. You can change it in the function `org-journal-file-header-func`, you can also change the `org-journal-file-type` from `daily` to one that suits your needs better (weekly, monthly or yearly)
2. Feel free to remove the block of code that changes what screens are present on Emacs startup if you don't like seeing org-agenda (or don't use it!).
   3. Feel free to change the backup directory (the directory where Emacs will store all of the backup files of the files you've worked on) if you want to. For example, if you want to move it out of the Emacs directory `.emacs.d/`, you would just change the path present on the `backup-directory-alist` line. Or you can remove them if you always want Emacs to create backups in the directory of the file you're working on.
