# GPG public key repository

GPG can be used to share confidential data and to have access to secrets in ansible (using git-crypt).
This folder stores public keys from any recipient.

# Add your key to this repository
Install GPG (using homebrew or any other method available in <https://www.gnupg.org/download/>)

You can verify if you have any GPG key already created:
`$ gpg --list-secret-keys --keyid-format LONG`

If you have a key pair, export the public part and add to this repository:
`$ gpg --output ./myself.gpg --export myself@myemail.com`
A full guide can be found in <https://www.gnupg.org/gph/en/manual/x56.html>

Commit this file to this repository and push to master.


# Generating a GPG key pair
If you don't have a key pair, you can generate one.

A detailed guide on how to create GPG keypairs can be found in:
  - <https://help.github.com/articles/generating-a-new-gpg-key/>
  - <https://www.gnupg.org/gph/en/manual/c14.html#AEN25>

`$ gpg --gen-key`
You can use a key with 4096 bits, no expiration date.
Make sure to use a _strong_ passphrase. Keep it on your password manager
(keepass, 1password, lastpass, anything). Losing the passphrase will cause you to lose all
the access to whatever that key is protecting.

# Decrypt and encrypt data using a GPG public key

<https://www.gnupg.org/gph/en/manual/x56.html#AEN83>
<https://www.gnupg.org/gph/en/manual/x110.html>

In order to encrypt some file, import the public key of the recipient:
`$ gpg --import someone.gpg`

And then you can encrypt a file using that key:
`$ gpg --output file.gpg --encrypt --recipient someone@email.org file`


You can now send _file.gpg_ any way you prefer.

If you receive a file encrypted with your key, you can decrypt it using:
`$ gpg --output file --decrypt file.gpg`

You'll be asked to type your passphrase. 
