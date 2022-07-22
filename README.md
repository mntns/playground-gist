# playground-gist

`playground-gist` lets you share code snippets on the [Rust Playground](https://play.rust-lang.org/) from within Emacs.

## Installation

`playground-gist` is not available on MELPA, which means that you can either install it manually or via [quelpa](https://github.com/quelpa/quelpa). 

### quelpa

Please install [quelpa](https://github.com/quelpa/quelpa) and [quelpa-use-package](https://github.com/quelpa/quelpa-use-package). Then you can simply use the following:

```elisp
(use-package playground-gist 
  :quelpa (playground-gist :fetcher github :repo "mntns/playground-gist"))
```

## Usage

`playground-gist` provides two functions:

- `playground-gist-share-buffer`: Shares the code of the current buffer on the Rust Playground and opens the permalink in your browser.
- `playground-gist-share-region`: Shares the code of the current region on the Rust Playground and opens the permalink in your browser. 
