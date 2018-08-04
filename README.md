# Domain Redirector

Domain Redirector gives you a Digital Ocean droplet based on a custom machine image (based on Ubuntu 18) which provides you with a basic nginx webserver that is designed to allow you to manage web redirects easily.

## Configuring

Copy the example config files:

```bash
cp ./config/nginx-default.conf.tpl ./config/nginx-default.conf
cp ./config/tf.json.tpl ./config/tf.json
```

Add your DO API Key to `./config/tf.json` and make any required adjustments to the default values.

Add your redirect server blocks to `./config/nginx-default.conf`. Each domain should live in it's own block - scroll to the bottom to see an example block.

## Building

Now we have the configuration for the build, we can start the build process with:

```bash
make build
```

This will invoke a packer command to build the base image and store it in DO.

It will inject the nginx configuration information so it simply needs deploying after it has been built:

## Deploying

```bash
make deploy
```

Running `make deploy` initialises the TF project and installs the required modules before proceeding to deploy the image to a droplet and create a floating IP address (if this is your first run).

## Future Development

 - [ ] add domains to DO TF so that the floating IP address can automatically be deployed to the correct zones.
 - [ ] secure the Ubuntu image by removing any cruft from the base image.
 