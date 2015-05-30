Scaffold
========
A mix task for creating new projects based on templates fetched from a Git-repo.

Notice, these projects does not need to be Elixir projects, any file structure should do as a template.

This is work in progress. Stuff will change radically from version to version. This has only been tested on OS X Yosemite. Please contact me about your experiences on other operating systems.

As of yet it is able to create a new project based on data in a local Git repository. Planned features include placeholders and other neat stuff. Please check the projects Github issues and add feature- and pull-requests. Thanks.


Flags
-----

`--template name` will pick the branch *name* as the template.


Setting up the Git repo
-----------------------
Create a `.scaffold` folder in your home directory and initialize a git repository in it. Alternatively a Git repository could be initialized on a site like Github and cloned into the *.scaffold* directory.

`mix scaffold` will look in this folder and use master as its template unless the `--template` flag has been set, as described in the *Flags*-section.


Dependencies
------------
This project uses the awesome [Gitex](https://github.com/awetzel/gitex) project by [Arnaud Wetzel](https://github.com/awetzel/) (released under the MIT License (MIT)) to communicate with the Git repository.


License
-------
See the LICENSE file included in the project. If it is not please contact the creator of the project.
