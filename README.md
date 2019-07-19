# hoefling-private-overlay
Custom overlay to reuse on different machines

## Installation

### Installation via ``eselect-repository``

This method uses the ``eselect`` module ``eselect-repository``. Issue:

```sh
$ sudo eselect repository add hoefling-private git https://github.com/hoefling/hoefling-private-overlay.git
```

Refer to [``eselect-repository`` module page in Gentoo Wiki](https://wiki.gentoo.org/wiki/Eselect/Repository) for more details.

### Installation via `repos.conf`

This method assumes usage of the new [portage sync capabilities](https://wiki.gentoo.org/wiki/Project:Portage/Sync). Issue:

```sh
$ sudo wget -P /etc/portage/repos.conf/
https://raw.githubusercontent.com/hoefling/hoefling-private-overlay/master/hoefling-private-overlay.conf
```

or create the settings file manually:

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

## Packages
``app-misc/hoefling-env``
``dev-lang/icc``
``dev-lang/ifc``
``dev-lang/python``
``dev-libs/intel-common``
``dev-python/cython``
``dev-python/devpi-client``
``dev-python/devpi-client-extensions``
``dev-python/devpi-common``
``dev-python/pipenv``
``dev-python/yolk3k``
``dev-tex/gitdags``
``dev-tex/xcolor-solarized``
``dev-util/wingide``
``sci-libs/mkl``

## Repoman status
[![Build Status](https://travis-ci.org/hoefling/hoefling-private-overlay.svg?branch=master)](https://travis-ci.org/hoefling/hoefli
