# hoefling-private-overlay
Custom overlay to reuse on different machines

# Packages
``app-emulation/docker``
``app-portage/gs-pypi``
``dev-python/cython``
``dev-tex/gitdags``
``dev-tex/xcolor-solarized``
``dev-util/idea-ultimate``
``dev-util/wingide``

# Installation

Create new settings file for the overlay in ``/etc/portage/repos.conf/`` dir:

```sh

$ cat <<EOM >/etc/portage/repos.conf/hoefling-private.conf
[hoefling-private]
location = /usr/local/overlay/hoefling-private
sync-type = git
sync-uri = https://github.com/hoefling/hoefling-private-overlay.git
auto-sync = yes
EOM
```

or modify ``/etc/portage/repos.conf`` file if you maintain it as one:

```sh

$ cat <<EOM >>/etc/portage/repos.conf
[hoefling-private]
location = /usr/local/overlay/hoefling-private
sync-type = git
sync-uri = https://github.com/hoefling/hoefling-private-overlay.git
auto-sync = yes
EOM
```

Refer to [``repos.conf`` page in Gentoo Wiki](https://wiki.gentoo.org/wiki//etc/portage/repos.conf) for more details.

# Repoman status
[![Build Status](https://travis-ci.org/hoefling/hoefling-private-overlay.svg?branch=master)](https://travis-ci.org/hoefling/hoefling-private-overlay)
