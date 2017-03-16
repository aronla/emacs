# Install emacs on OS X
1. Install newest emacs using brew
2. Using Automator, create a script containing:

```javascript
PATH="/usr/local/bin/:{$PATH}"
export PATH
emacsclient -c --no-wait -alternate-editor="" "$@"
```

Make sure that the automator script accepts argeuments as input, not stdin.

3. Add the following lines to the .fish_config
```
alias em "emacsclient -c --no-wait --alternate-editor=''"
alias emn "emacsclient -c -nw --alternate-editor=''"
```

The `--no-wait` makes the command immediately return to the prompt.
