-- Project Logger
-- Copyright (c) 2026 osuranjack1638
-- Licensed under the Apache License 2.0.
-- See the LICENSE file in the project root for license information.

local ProjectLogger = {}

local Config = require(script.Config)

local tracking = {}


function ProjectLogger.Log(message, options, ...)
	if Config.DisableLogging then return end
	options = options or {}
	
	local messageType = options.messageType or "default"
	
	if messageType == "default" then
		print(string.format(message, ...))
	elseif messageType == "warning" then
		warn(string.format(message, ...))
	elseif messageType == "error" then
		error(string.format(message, ...))
	end
end

function ProjectLogger.Track(toTrack, trackWithName)
	assert(type(trackWithName) == "string", "The name of the object being tracked must be a string.")
	
	if type(toTrack) == "function" then
		tracking[trackWithName] = {
			amountsCalled = 0,
			lastTimeToRun = 0,
			amountsFailed = 0,
			successRate = 0,
			fastestRun = math.huge,
			slowestRun = 0,
			totalRunTime = 0,
			averageRunTime = 0
		}
		
		local function newToTrack(...)
			local startTime = os.clock()
			
			local results = table.pack(pcall(toTrack, ...))
			local success = results[1]
			
			local endTime = os.clock()
			
			local newTracking = tracking[trackWithName]
			newTracking.amountsCalled += 1
			
			local lastTimeToRun = (endTime - startTime) * 1000
			newTracking.lastTimeToRun = lastTimeToRun
			newTracking.totalRunTime += lastTimeToRun
			newTracking.averageRunTime = newTracking.totalRunTime / newTracking.amountsCalled
			
			if lastTimeToRun < newTracking.fastestRun then
				newTracking.fastestRun = lastTimeToRun
			end
			
			if lastTimeToRun > newTracking.slowestRun then
				newTracking.slowestRun = lastTimeToRun
			end
			
			if not success then
				newTracking.amountsFailed += 1
			end
			
			local totalSuccess = newTracking.amountsCalled - newTracking.amountsFailed
			newTracking.successRate = (totalSuccess / newTracking.amountsCalled) * 100
			
			if success then
				return table.unpack(results, 2, results.n)
			else
				error(results[2], 2)
			end
		end
		
		local function getTrackingData()
			return tracking[trackWithName]
		end
		
		return newToTrack, getTrackingData
	else
		local function cantTrackMessage(...)
			ProjectLogger.Log("[%s] Attempted to track an object that cannot be tracked. Please check the object again. (%s)", {messageType="warning"}, "Project Logger", trackWithName)
		end
		
		return cantTrackMessage
	end
end

function ProjectLogger.DisableLogging()
	Config.DisableLogging = true
end

function ProjectLogger.EnableLogging()
	Config.DisableLogging = false
end


return ProjectLogger
