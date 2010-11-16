# GitAway

GitAway is a git central repository system that is modeled after github,
but is not intended to replace github.  The purpose of GitAway is
to provide a private gibhub-like system that can be used in private
development environments that may exist on private or public networks.

# Scale

Github supports millions of repositories and hundreds of thousands
of uses.  GitAway intends to support thousands of repositories and
hundreds of users.  Gitaway runs on one server.  While it is possible
to deploy it to the github scale (with a LOT of work), it is not designed 
to operate in that way.

## Goals

The goals of GitAway are basic and are as follows:

* Do not duplicate github
* Do not replace paid github services (thin ice here)
* Do not replace github:fi (even thinner ice here)
* Provide the most useful features.  80% solution

## Features

As stated before, this is not intended to be an exact clone of github.  While
it is modeled very heavily on github, I do not intend to duplicate
every feature.  Only the most commonly used tasks (as defined by me) are
included.

* User Repositories
* * Public Repositories
* * Private Repositories
* Repository Navigation
* * Branches
* * Trees
* Collaboration
* * Forking
* * Multi-user access to repositories
* Repository Access
* * SSH through SSH public keys
* * Read-only http

## Non-Features

There are some features that are explicitly not on the list to be
included.  Reasons for not including a feature are, low demand,
expensive in time/resources to implement, task can be done using
another tool, etc.  These non-features are...

* Network graph display (difficult/resource intenstive)
* gist (supported for free elsewhere)
* wiki (This is a single-tool package, do wikis elsewhere)
* Static page hosting (Host elsewhere)
* Event history
* Crazy sshd modification for authentication

## Possible Features

Possible features are things that are not on the high-priority list, but
may be useful for collaborative development.

* Pull requests (high on the list)
* Problem tracking (low on the list, almost a non-feature)
