# Encrypted ruby?

Ever wanted to pass along a script full of secret data, API keys and pages of your diary,
but didn't want to risk it being read by the wrong person?

This is a single-file ruby program which allows you to create scripts which are only executable with the right key handy.

Your source-code is protected from view without the appropriate key!

Importantly, this script writes the encrypted code in the same file, meaning you only need to pass around the one file, and hand over instructions for how to run it (or have 'em peek in the comments at the start of the script)

## Usage

```sh
$ RBKEY=examplekey ruby rbcrypted.rb run
```

See comments in the script to figure out how to encrypt you own script within.


