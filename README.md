<p align="center">
<img src="https://cloud.githubusercontent.com/assets/1342803/16012068/d98ba914-3155-11e6-8efe-733f35fe67a3.png" width="745" align="middle"/>
</p>

# Vapor Toolbox

Learn more about Vapor Toolbox in the <a href="https://vapor.github.io/documentation/getting-started/install-toolbox.html">documentation</a>.

## Homebrew

```sh
# install Vapor Toolbox
brew install vapor/tap/toolbox
```

## Linux / Manual
```sh
# install Vapor Toolbox
curl -sL toolbox.qutheory.io | bash
```

## Use As Alternate Toolbox for Generating Code
You can use this as an alternate toolbox for code generation.

First, download and build the executable

```
git clone git@github.com:wpuricz/toolbox.git
cd toolbox
swift build
```

Second, setup an alias in your .bash_profile something like:

    alias vt='~/Dev/vapor-apps/toolbox/.build/debug/Executable '

Edit the paths and url in VaporToolbox/Generators/Generators.swift to suit your setup. You can also download and modifytemplates if needed.
<a href="https://gist.github.com/84007a4ceacd92b9ccc22600dfb29b4e.git">https://gist.github.com/84007a4ceacd92b9ccc22600dfb29b4e.git</a>

## Using the Generator Commands

#### Generating a Resource
This will generate a model, controller, route, and a preparation. Note: Dates are not currently supported yet and the update method in the controller will need to have the variables added to it.

    vt generate resource books name:string isbn:string length:int price:double

#### Generating a Skinny Controller
Generates a simple bare bones controller. Alternatively, routes can be added as parameters after the controller name.

    vt generate controller Book

#### Generating a Model
This will generate a model, and a preparation

    vt generate model name:string isbn:string length:int price:double

#### Generating a View
This will generate a leaf template in the Public/views directory

    vt generate view book

#### Generating 

## Using Autocompletion

Download vapor-autocompletion.bash

<a href="https://gist.github.com/wpuricz/578633ac79b5b490df9dc96be6e60036">https://gist.github.com/wpuricz/578633ac79b5b490df9dc96be6e60036</a>

Edit .bash_profile

    source ~/[mypath]/vapor-autocompletion.bash

Reload the bash_profile

    . .bash_profile
