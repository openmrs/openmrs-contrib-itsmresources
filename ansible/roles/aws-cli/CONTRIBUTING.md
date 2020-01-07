Contributing
============

Contributions are welcome and appreciated! All contributors will be credited in
`AUTHORS`.

Types of Contributions
----------------------

You can contribute in several different ways:

### Report bugs

Report bugs at https://github.com/badpacketsllc/ansible-aws-cli/issues.

If you are reporting a bug, please include:

- Expected behavior and observed behavior.
- How to reproduce the bug.
- Any information you think would be helpful in finding the bug's root cause.

### Fix Bugs

Look through the GitHub issues for bugs. Feel free to contribute any fixes you
might have.

### Implement Features

Look through the GitHub issues for features. Feel free to contribute any
features you wish to implement.

### Write Documentation

More clarity is always better. Add documentation to `README.md`, in the test
suite (located in `./molecule/default`) or wherever you feel is appropriate.

Setting up a development environment
------------------------------------

1. Fork the `ansible-aws_cli` repo on GitHub.
2. Clone your fork locally:

```shell
    $ git clone git@github.com:your_name_here/ansible-aws-cli.git
```

3. [Install molecule](https://molecule.readthedocs.io/en/latest/#quick-start).

4. Create a branch for local development
```shell
    $ git checkout -b description-of-bug-or-feature
````

Now you can make your changes locally.

5. When you're done making changes, check that your changes pass the tests:

```shell
    $ pip3 install tox
    $ tox
```

6. Commit your changes and push your branch to GitHub:

```shell
    $ git add .
    $ git commit -m "Your detailed description of your changes."
    $ git push origin name-of-your-bugfix-or-feature
```

7. Submit a pull request through the GitHub website.

Responsibilities
----------------

1. Create issues for any bugs, changes or enhancements.
2. Be welcoming and nice as outlined in our Code of Conduct (https://www.contributor-covenant.org/version/1/4/code-of-conduct).
