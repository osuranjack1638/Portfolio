local ProjectEvents = {}

local Config = require(script.Config)

local RunService = game:GetService("RunService")
local StorageService = game:GetService(Config.StorageService)
local HttpService = game:GetService("HttpService")

local RemoteFolder = StorageService:FindFirstChild(Config.StorageLocation)
if not RemoteFolder and RunService:IsServer() and Config.AutoCreateStorage then
	RemoteFolder = Instance.new("Folder")
	RemoteFolder.Name = Config.StorageLocation
	RemoteFolder.Parent = StorageService
end

local _Listeners = {}


local function DebugPrint(Message: string)
	if Config.DebugMode or Config.DebugPrint then
		print(string.format("%s [DEBUG] %s", Config.DisplayName, Message))
	end
end

local function DebugWarn(Message: string)
	if Config.DebugMode or Config.DebugWarn then
		warn(string.format("%s [WARNING] %s", Config.DisplayName, Message))
	end
end


local function CheckForUpdates()
	if not RunService:IsServer() or not Config.CheckForUpdates then return end
	
	local success, result = pcall(function()
		return HttpService:GetAsync(Config.RawVersionUrl)
	end)
	
	if success and result then
		local LatestVersionStr = string.match(result, "^%s*(.-)%s*$")
		local LatestVersion = tonumber(LatestVersionStr)
		
		if LatestVersion then
			if LatestVersion > Config.Version then
				warn(string.format("%s A new version is available! [Current: v%.2f | Latest: v%.2f]. Please update from Github.", Config.DisplayName, Config.Version, LatestVersion))
			else
				DebugPrint(string.format("Module version is up to date (v%.2f).", Config.Version))
			end
		end
		
	elseif not success  then
		DebugWarn("Failed to check for updates. Ensure HTTP Requests are enabled. Error: " .. tostring(result))
	end
end

task.defer(CheckForUpdates)

local function GetRemoteEvent(EventName: string): RemoteEvent
	if RunService:IsServer() then
		local Remote = RemoteFolder:FindFirstChild(EventName)
		if not Remote then
			Remote = Instance.new("RemoteEvent")
			Remote.Name = EventName
			Remote.Parent = RemoteFolder
			DebugPrint(string.format("Instantiated new RemoteEvent: '%s'", EventName))
		end
		return Remote
	else
		RemoteFolder = StorageService:WaitForChild(Config.StorageLocation)
		return RemoteFolder:WaitForChild(EventName)
	end
end


function ProjectEvents.Connect(EventName: string, Callback: (...any) -> ())
	local Context = RunService:IsServer() and "Server" or "Client"
	
	if not _Listeners[EventName] then
		_Listeners[EventName] = {
			Callbacks = {},
			RBXConnection = nil
		}
		
		local Remote = GetRemoteEvent(EventName)
		
		if RunService:IsClient() then
			_Listeners[EventName].RBXConnection = Remote.OnClientEvent:Connect(function(...)
				DebugPrint(string.format("Client caught inbound network event: '%s'", EventName))
				for _, listener in ipairs(_Listeners[EventName].Callbacks) do
					task.spawn(listener, ...)
				end
			end)
		elseif RunService:IsServer() then
			_Listeners[EventName].RBXConnection = Remote.OnServerEvent:Connect(function(Player, ...)
				DebugPrint(string.format("Server caught inbound network event: '%s' from player '%s'", EventName, Player and Player.Name or "Unknown"))
				for _, listener in ipairs(_Listeners[EventName].Callbacks) do
					task.spawn(listener, Player, ...)
				end
			end)
		end
	end
	
	table.insert(_Listeners[EventName].Callbacks, Callback)
	DebugPrint(string.format("[%s] Created new listener connection for event: '%s' (Total listeners: %d)", Context, EventName, #_Listeners[EventName].Callbacks))
	
	local Connection = {}
	Connection.Connected = true
	
	function Connection:Disconnect()
		if not self.Connected then return end
		self.Connected = false
		
		local EventData = _Listeners[EventName]
		if not EventData then return end
		
		local Index = table.find(EventData.Callbacks, Callback)
		if Index then
			table.remove(EventData.Callbacks, Index)
		end
		
		if #EventData.Callbacks == 0 then
			if EventData.RBXConnection then
				EventData.RBXConnection:Disconnect()
			end
			_Listeners[EventName] = nil
			
			DebugPrint(string.format("[%s] All listeners removed for event: '%s'. Severed underlying network signal loop.", Context, EventName))
		else
			DebugPrint(string.format("[%s] Destroyed a connection for event: '%s'. (Remaining listeners: %d", Context, EventName, #EventData.Callbacks))
		end
	end
	
	return Connection
end

function ProjectEvents.Fire(EventName: string, SendToClient: boolean?, Player: Player?, ...)
	if RunService:IsServer() then
		if SendToClient then
			local Remote = GetRemoteEvent(EventName)
			if Player then
				DebugPrint(string.format("Server outbounding network event '%s' to specific client: '%s'", EventName, Player.Name))
				Remote:FireClient(Player, ...)
			else
				DebugPrint(string.format("Server broadcasting network event '%s' to ALL connected clients.", EventName))
				Remote:FireAllClients(...)
			end
			
		else
			DebugPrint(string.format("Server firing internal cross-script signal: '%s'", EventName))
			local EventData = _Listeners[EventName]
			if EventData then
				for _, Listener in ipairs(EventData.Callbacks) do
					task.spawn(Listener, ...)
				end
			else
				DebugWarn(string.format("Server fired internal signal '%s' but no server scripts are currently listening to it.", EventName))
			end
		end
		
	else
		DebugPrint(string.format("Client outbounding network event '%s' to sever.", EventName))
		local Remote = GetRemoteEvent(EventName)
		Remote:FireServer(...)
	end
end


return ProjectEvents
