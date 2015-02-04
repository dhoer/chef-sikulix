# SikuliX Cookbook

[![Cookbook Version](http://img.shields.io/cookbook/v/sikulix.svg?style=flat-square)][cookbook]
[![Build Status](http://img.shields.io/travis/dhoer/chef-sikulix.svg?style=flat-square)][travis]
[![GitHub Issues](http://img.shields.io/github/issues/dhoer/chef-sikulix.svg?style=flat-square)][github]

[cookbook]: https://supermarket.chef.io/cookbooks/sikulix
[travis]: https://travis-ci.org/dhoer/chef-sikulix
[github]: https://github.com/dhoer/chef-sikulix/issues

This cookbook installs SikuliX (http://www.sikulix.com/).

## Requirements

- Java must be installed
- Chef 11

### Platforms

- Ubuntu
- Windows

### Cookbooks

These cookbooks are referenced with suggests, so be sure to depend on the cookbooks that apply:

- apt
- windows

## Usage

Include the sikulix default recipe in your run list or recipe.

**IMPORTANT!**

Since there are a variety of setup options to choose from, all option attributes default to `false`.
You must select each setup option to install by setting its corresponding attribute to `true`.

Example

```ruby
default_attributes(
  :sikulix => {
     :setup => {
       "java_api" => true
     }
   }
)
```

or

```ruby
node.set['sikulix']['setup']['java_api'] = true
```


## Attributes

Pack1: I want SikuliX, containing the Sikuli IDE and allowing to run Sikuli scripts from commandline.

- `node['sikulix']['setup']['ide_jython']` - Python language level 2.7. Default `false`.
- `node['sikulix']['setup']['ide_jruby']` - Ruby language level 1.9 and 2.0. Default `false`.

Pack2: I want to develop in Java, Jython or other Java aware scripting language using NetBeans, Eclipse, or other IDE's.

- `node['sikulix']['setup']['java_api']` - Default `false`.  

I want to use the Tesseract based OCR features (You Should know what you are doing!).

- `node['sikulix']['setup']['tesseract_ocr']` - Default `false`. 

I want the packages to be usable on Windows, Mac, Linux (they contain the stuff for all systems - one pack for all).
With these options not selected, the setup process will only add system specific native stuff (Windows: support for
both Java 32-Bit and Java 64-Bit is added).

- `node['sikulix']['setup']['system_all']` - Default `false`. 
- `node['sikulix']['setup']['system_windows']` - Default `false`. 
- `node['sikulix']['setup']['system_mac']` - Default `false`. 
- `node['sikulix']['setup']['system_linux']` - Default `false`.

Other:

- `node['sikulix']['setup']['buildv']` - Build libVisionProxy.so. Default `false`.
- `node['sikulix']['setup']['notest']` - Skip validation after install. Default `false`.
- `node['sikulix']['setup']['clean']` - Clean directory. Default `false`.

## Getting Help

- Ask specific questions on [Stack Overflow](http://stackoverflow.com/questions/tagged/chef-sikulix).
- Report bugs and discuss potential features in [Github issues](https://github.com/dhoer/chef-sikulix/issues).

## Contributing

Please refer to [CONTRIBUTING](https://github.com/dhoer/chef-sikulix/blob/master/CONTRIBUTING.md).

## License

MIT - see the accompanying [LICENSE](https://github.com/dhoer/chef-sikulix/blob/master/LICENSE.md) file for details.
