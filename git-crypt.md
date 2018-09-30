# Encrypted files

A few secret files in this repository are encrypted using [git-crypt](https://www.agwa.name/projects/git-crypt/). Git crypt will keep the files decrypted locally, and push them encrypted. Note it's not possible to revoke access to a certain file; the only solution would be rotate all secrets.

Only people deploying ansible/puppet would need to have access to those secrets.

## Setup

Make sure to install it following the official documentation, or on OSX:
```
brew install git-crypt
```

Install GPG (using homebrew or any other method available in <https://www.gnupg.org/download/>)


## Decrypting files (if you have permission)

Where you have access to your private GPG key, run:

`git-crypt unlock`

## Requesting access

You'll need a GPG key pair.

You can verify if you have any GPG key already created:
`$ gpg --list-secret-keys --keyid-format LONG`

If you have a key pair, export the public part and add to this repository:
`$ gpg --output ./myself.gpg --export myself@myemail.com`
A full guide can be found in <https://www.gnupg.org/gph/en/manual/x56.html>

---

If you don't have a key pair, you can generate one.

A detailed guide on how to create GPG keypairs can be found in:
  - <https://help.github.com/articles/generating-a-new-gpg-key/>
  - <https://www.gnupg.org/gph/en/manual/c14.html#AEN25>

`$ gpg --gen-key`
You can use a key with 4096 bits, no expiration date.
Make sure to use a _strong_ passphrase. Keep it on your password manager
(keepass, 1password, lastpass, anything). Losing the passphrase will cause you to lose all
the access to whatever that key is protecting.

----

Add your key in `gpg-keys` folder, commit and push to master. Notify someone with access to grant you access.  


## Checking who has access

```
$ cd .git-crypt/keys/default/0

$ for key in $(ls); do echo -e "\n\n ==== $key ===="; gpg --list-packets --keyid-format LONG --list-only $key; done
```

## Granting access to a new user

A person with access to the repository needs to run the following commands:

```
$ gpg --import <key_file>.gpg
$ gpg --list-keys
# select the email used in the new key

# trust the key
$ gpg --edit-key <person's email>
>
        trust
        5
        quit

$ git-crypt add-gpg-user <person's email>

```
It should create a new commit, so just push as usual.


## 'Removing' access from a user
Git-crypt doesn't provide an actual remove-access.

<https://github.com/AGWA/git-crypt/pull/72/files>
<https://github.com/AGWA/git-crypt/issues/47#issuecomment-90788733>

We can use some workarounds to prevent users from accessing new commits:

<https://giorgos.sealabs.net/remove-users-from-git-crypt-enabled-repository.html>

```
# check all the access and delete the ones you don't want anymore
$ rm <file>.gpg

$ gpg --list-keys
# make sure you have all remaining public keys imported and trusted

$ cd -
$ ./bin/reencrypt.sh

$ git-crypt unlock

# This command will generate a log of commits, you can squash before pushing it
```
