insomniaircd_conf
==============================================================================

This repositories contains config templates for InspIRCd at InsomniaIRC.
The templates are compiles into a realized config by the [`Rakefile`](Rakefile).
The templates may be ERB files which are rendered as part of the compiling
process.

Each server in the IRC network needs a nearly identical config, save for a
few values such as the server name. The settings specific to each server
are stored `servers` hash in the [`network.yaml`](network.yaml) file. The
hash for the current server can be retreived with the `server` method in
ERB templates.

The `network.yaml` file also facilitates linking by allowing you to specify
simply the hostname to link with. The config template figures out the
rest.

IRC configs tend to contain many secrets: linking passwords, oper hashes,
etc. To secure those secrets, each one is encrypted with AES256 and stored
in the `secrets` hash in the network.yaml file. To generate the config you
must set the SECRET_KEY environment variable to the key or place the key
in the secret.key file.

Usage
------------------------------------------------------------------------------

### Directory Stucture

* `network.yaml` contains server specific configs, secrets, and opers.
* `config-src/` contains the templates to process. Files ended in .erb are
  rendered according. All other files are copied verbatim. Directories are
  ignored.
* `conf/` will contain the rendered config after it is compiles.

To compile the configs for the server euclid.insomniairc.net, run:

    SECRET_KEY=SHHH rake compile[euclid.insomniairc.net]

Obviously replacing `SHHH` with your actual AES key.


