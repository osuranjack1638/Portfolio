local Config = {}

-- General Configuration --
Config.Version = 1.00 -- Version of the module
Config.ModuleName = "Project Events" -- Name of the module
Config.DisplayName = "[Project Events]" -- Display name of the module

-- Version Checker Configuration --
Config.CheckForUpdates = true -- Check for module updates
Config.RawVersionUrl = "https://raw.githubusercontent.com/YOUR_GITHUB_USERNAME/YOUR_REPO_NAME/main/version.txt" -- Url used for checking the version (Don't change)

-- Debug Configuration --
Config.DebugMode = true -- Enable debug mode (Enable this to use the other debug options)
Config.DebugPrint = true -- Enable debug prints
Config.DebugWarn = true -- Enable debug warnings

-- Remote Storage Configuration --
Config.StorageService = "ReplicatedStorage" -- Which service the module will store events in
Config.StorageLocation = "ProjectEventsRemotes" -- Which folder inside the storage service will store the remote events
Config.AutoCreateStorage = true -- Auto create the storage folder if it doesn't exist


return Config
