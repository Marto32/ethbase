# ethbase
A boilerplate development environment for Ethereum

# Usage

## Requirements

 * [Vagrant](https://www.vagrantup.com/downloads.html)
 * [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
 * [git](https://git-scm.com/) to clone this repo

## Setting up the VM

1. Clone this repository by running `git clone https://github.com/Marto32/ethbase.git`
2. Change to the `ethbase` directory (`cd ethbase`)
3. Run `vagrant up` and the machine will build and provision itself
4. Enter the VM by running `vagrant ssh`

That's it!

By default, the `/vagrant` folder in the VM is synced to the ethbase directory on your host machine.

## Ethereum packages installed

 * [pyethapp](https://github.com/ethereum/pyethapp)

