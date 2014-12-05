# SikuliX Cookbook

[![Build Status](https://travis-ci.org/dhoer/chef-sikulix.svg)](https://travis-ci.org/dhoer/chef-sikulix)

This cookbook installs SikuliX (http://www.sikulix.com/) via SikuliX Setup and Remote Server.

## Requirements

- Java must be installed.  Remote server requires Java 8 or greater.
- Chef 11.14.2 and Ruby 1.9.3 or higher.

### Platform

- Ubuntu - Setup only
- Windows

### Cookbooks

- windows

## Recipes

### Install

Installs SikuliX via SikuliX Setup.

Set setup attributes in your attributes file, such as:

```ruby
node['sikulix']['setup']['java_api'] = true
```

Include the sikulix default recipe (or include sikulix in your run list):

```ruby
include_recipe 'sikulix::default'
```

#### Attributes

Pack1: I want SikuliX, containing the Sikuli IDE and allowing to run Sikuli scripts from commandline.

- `node['sikulix']['setup']['ide_jython']` - Python language level 2.7. Default `false`.
- `node['sikulix']['setup']['ide_jruby']` - Ruby language level 1.9 and 2.0. Default `false`.
- `node['sikulix']['setup']['ide_jruby_addons']` - Rspec, Cucumber, ... Default `false`.

Pack2: I want to develop in Java, Jython or other Java aware scripting language using NetBeans, Eclipse, or other IDE's.

- `node['sikulix']['setup']['java_api']` - Default `false`.  

For Mac and Windows only: I plan to use the Tesseract based OCR features (You Should know what you are doing!).

- `node['sikulix']['setup']['tesseract_ocr']` - Default `false`. 

I want the packages to be usable on Windows, Mac, Linux (they contain the stuff for all systems - one pack for all).
With these options not selected, the setup process will only add system specific native stuff (Windows: support for
both Java 32-Bit and Java 64-Bit is added).

- `node['sikulix']['setup']['system']['all']` - Default `false`. 
- `node['sikulix']['setup']['system']['windows']` - Default `false`. 
- `node['sikulix']['setup']['system']['mac']` - Default `false`. 
- `node['sikulix']['setup']['system']['linux']` - Default `false`. 

I want to try the experimental Sikuli Remote feature (getting sikulixremoteserver.jar).

- `node['sikulix']['setup']['remoteserver']` - Default `false`. 

Other:

- `node['sikulix']['setup']['jvm_args']` - Default `-Xmx128m`.

### Remote Server

Installs SikuliX Remote Server via SikuliX Setup and runs it in the foreground on Windows. 

**Note that Remote Server is experimental.**

#### Attributes

- `node['sikulix']['remoteserver']['domain']` - Domain of account to use for automatic logon (optional).
- `node['sikulix']['remoteserver']['username']` - Username of account to use for automatic logon. 
- `node['sikulix']['remoteserver']['password']` - Password of account to use for automatic logon.
Note the password is stored and displayed in the registry editor in plain, unencrypted text.
- `node['sikulix']['remoteserver']['jvm_args']` - JVM arguments (optional).
- `node['sikulix']['remoteserver']['port']` - Defaults to `4041`.

## Getting Help

- Ask specific questions on [Stack Overflow](http://stackoverflow.com/questions/tagged/chef-sikulix).
- Report bugs and discuss potential features in [Github issues](https://github.com/dhoer/chef-sikulix/issues).

## Contributing

Please refer to [CONTRIBUTING](https://github.com/dhoer/chef-sikulix/blob/master/CONTRIBUTING.md).

## License

MIT - see the accompanying [LICENSE](https://github.com/dhoer/chef-sikulix/blob/master/LICENSE.md) file for details.
