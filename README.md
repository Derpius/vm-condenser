# Nanos World Lua VM Condenser

Need a shared global environment between a bunch of your packages?  
Well look no further!

VM Condenser runs along side any packages you still want to be concurrent by only requiring unloaded packages, so you can still get the performance increase where needed, however some applications require a unified global env which this provides.  

## Installation
Set up your server's `Config.toml` to only load packages you want running concurrently (aka separate globals), **every** other package you have installed will be loaded into this VM.  

**Do not leave all package fields in the config blank, depending on the order packages end up getting loaded, this may duplicate only a few or almost all of your installed packages**  

## Configuration
You can set a package load blacklist in `PersistentData.toml` for any packages you don't load from the server config but you don't want this loading either.  

## Hot Reloading
Attempting to reload packages loaded into this VM will cause 2 instances of them to be running, instead reload this package.  
*this goes for all other package commands too*

## Compatibility Issues
Due to the various `Unsubscribe` functions unsubscribing **all** event handlers within the same Lua VM, any packages that don't specify the optional callback parameter to remove only that handler **will** remove **every other package's event handlers loaded into this VM**.  

Some packages may also pollute the global table due to expecting their own environment to work in, although that's bad practice anyway some packages may do this due to not being designed to share an env.  
