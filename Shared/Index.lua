-- Get all and loaded packages (we don't wanna require an already loaded package like this one, or a loading screen, and any manually specified in server conf)
local packages, loaded
if Server then
	packages = Server.GetPackages(false)
	loaded = Server.GetPackages(true)
else
	packages = Client.GetPackages(false)
	loaded = Client.GetPackages(true)
end

-- Turn loaded array into a hashmap for quick lookup
for _, package in ipairs(loaded) do
	loaded[package] = true
end

-- Get persistent data
local persistentData = Package.GetPersistentData()
if not persistentData.blacklist then
	persistentData.blacklist = {}
	Package.SetPersistentData("blacklist", {})
end

-- Turn blacklist array into a hashmap for quick lookup
local blacklist = {}
for _, package in ipairs(persistentData.blacklist) do
	loaded[package] = true
end

-- Load every unloaded package
for _, package in pairs(packages) do
	if not loaded[package] and not blacklist[package] then
		Package.RequirePackage(package)
	end
end

-- Let all the packages we just loaded know that everything's ready for cross communication
Events.Call("VMCondenserLoaded")
