Scaffold
========
A mix task for creating new projects based on templates fetched from a Git-repo.

Notice, these projects does not need to be Elixir projects, any file structure should do as a template.

This is work in progress. Stuff will change radically from version to version. This has only been tested on OS X Yosemite. Please contact me about your experiences on other operating systems.

As of yet it is able to create a new project based on data in a local Git repository. Planned features include placeholders and other neat stuff. Please check the projects Github issues and add feature- and pull-requests. Thanks.


Flags
-----

`--template name` will pick the branch *name* as the template. This will default to the *master* branch if omitted.


Setting up the template repo
----------------------------
First you will need a Git repository to store your templates. Create one by using `git init` or start one on a site like Github and clone it to your machine. Fill this repository with the files and folder structure you need for your project templates.

Then you will need to tell scaffold where to look for your newly created template folder. Let us assume that `~/.scaffold` was used as the template folder, and that we have a working Git repository in this folder. Scaffold uses the *.gitconfig*-file to store its settings under the *scaffold* section, so add the repo to the settings with the following command.

```shell
git config --global scaffold.dir ~/.scaffold
```

`mix scaffold` will now look in this folder and use the master branch as its template unless the `--template` flag has been set, as described in the *Flags*-section.


Dependencies
------------
This project uses the awesome [Gitex](https://github.com/awetzel/gitex) project by [Arnaud Wetzel](https://github.com/awetzel/) (released under the MIT License (MIT)) to communicate with the Git repository.

We use the [ConfigParser](https://github.com/easco/configparser_ex) project by [Scott Thompson](https://github.com/easco) to read the content of the users *~/.gitconfig*-file. ConfigParser is released under the BSD license.


License
-------
See the LICENSE file included in the project. If it is not please contact the creator of the project.
