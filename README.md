Salt configuration for workstations
============
[![Build Status](https://travis-ci.org/jacksoncage/salt-workstation.svg)](https://travis-ci.org/jacksoncage/salt-workstation)

Salt configuration for configure and setup my current workstation. Optimized for my current setup which is a Thinkpad X220 running debian jessie.

Influenced by [linux-salted](https://github.com/TTimo/linux-salted) and [yourlabs salt formulas testing](http://blog.yourlabs.org/post/118987515453/testing-saltstack-formulas-on-travis-ci), dotfiles are influenced/copied from [Jessie Frazelle](https://github.com/jessfraz/dotfiles).

### Setup and apply

#### Automatic

Checkout this repo and run the included install script which will run all manual steps.

```
make install
make apply
```


#### Manual


##### 1. Install salt-minion

```
curl -L https://bootstrap.saltstack.com -o install_salt.sh
sudo sh install_salt.sh
```

##### 2. Set salt to run masterless

To instruct the minion to not look for a master, the file_client configuration option needs to be set in the minion configuration file.

In `/ect/salt/minion` set `file_client: local`

```
 echo "master: localhost \
file_client: local" > /etc/salt/minion
```

*NOTE: When running Salt in masterless mode, do not run the salt-minion daemon. Otherwise, it will attempt to connect to a master and fail. The salt-call command stands on its own and does not need the salt-minion daemon.*

#### 3. Apply state

Now you ready to apply states or configure the entire system with a highstate.

```
salt-call --local state.highstate -l debug
```

you can also apply each state individual

```
salt-call --local state.sls base -l debug
```

### Testing

This command will apply highstate on localhost with the example pillar.

```
salt-call state.highstate --local --retcode-passthrough --file-root=$(pwd)/state --pillar-root=$(pwd)/pillar -l debug
```

#### inside a container

```
docker run --rm -it \
  --name=thinkpad \
  -h thinkpad \
  -e SALT_NAME=thinkpad \
  -e SALT_USE=minion \
  -v `pwd`/:/srv/salt:rw \
  -v /etc/localtime:/etc/localtime \
  quay.io/jacksoncage/salt
  salt-call state.highstate \
  --local --retcode-passthrough \
  --file-root=$(pwd)/state \
  --pillar-root=$(pwd)/pillar
```
