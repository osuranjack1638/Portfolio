-- Project Sentinel
-- Copyright (c) 2026 osuranjack1638
-- Licensed under the Apache License 2.0.
-- See the LICENSE file in the project root for license information.


local ProjectSentinel = {}

local Config = require(script.Config)

local RunService = game:GetService("RunService")


function ProjectSentinel.Test(toTest, options)
	local totalTests = 0
	local totalSuccess = 0
	local totalFailures = 0
	local activeWorkers = 0
	
	local allErrors = {}
	local failedIn = {}
	local testQueue = {}
	options = options or {}
	
	local function queueTests(testValues, groupName, runOptions)
		local toRun = runOptions["toRun"]
		
		for _, value in ipairs(testValues) do
			table.insert(testQueue, {value = value, groupName = groupName, toRun = toRun})
		end
	end
	
	local function queueAllTests(runOptions)
		local dontTest = options["dontTest"] or {}
		
		for groupName, testValues in pairs(Config.TestValues) do
			local continueToFunction = false
			for _, dontTestValue in pairs(dontTest) do
				if dontTestValue == groupName then
					continueToFunction = true
					break
				end
			end
			
			if continueToFunction then
				continue
			end
			
			queueTests(testValues, groupName, runOptions)
		end
	end
	
	local function Worker()
		activeWorkers += 1
		
		task.spawn(function()
			while #testQueue > 0 do
				local job = table.remove(testQueue, 1)
				if not job then break end
				
				local success, err = pcall(function()
					job.toRun(job.value)
				end)
				
				if success then
					totalSuccess += 1
				elseif not success and err then
					totalFailures += 1
					table.insert(allErrors, err)
					table.insert(failedIn, job.groupName)
				end
				
				totalTests += 1
			end
			
			activeWorkers -= 1
		end)
	end
	
	local function isOOP()
		if typeof(toTest) ~= "table" or typeof(toTest) == "Instance" then return false end
		
		if toTest.__ProjectSentinelOOP then
			return true
		end
		
		local metaTable = getmetatable(toTest)
		if metaTable then
			local success, indexResult = pcall(function()
				return metaTable.__index
			end)
			if success and typeof(indexResult) == "table" then
				return true
			end
		end
		
		return false
	end
	
	print("----------- Starting Test Of Project Sentinel -----------")
	print("There might be too many outputs if the tested object has print/warn statements inside")
	task.wait(1)
	
	local startTime = os.clock()
	
	if typeof(toTest) == "function" then
		local runOptions = {["toRun"] = toTest}		

		queueAllTests(runOptions)
	elseif isOOP() then
		local runOptions = {}
		
		local targetTable = toTest
		local metaTable = getmetatable(toTest)
		if metaTable and typeof(metaTable.__index) == "table" then
			targetTable = metaTable.__index
		end
		
		for name, value in pairs(targetTable) do
			if typeof(value) == "function" then
				local continueToFunction = false
				
				for _, funcName in pairs(Config.DontTestFunctionsWithName) do
					if funcName == name then
						continueToFunction = true
						break
					end
				end
				
				if continueToFunction then
					continue
				end
				
				local function toRun(testValue)
					value(toTest, testValue)
				end
				
				runOptions["toRun"] = toRun
				
				queueAllTests(runOptions)
			end
		end
	elseif typeof(toTest) == "table" then
		local runOptions = {}
		
		for name, value in pairs(toTest) do
			if typeof(value) == "function" then
				local continueToFunction = false
				
				for _, funcName in pairs(Config.DontTestFunctionsWithName) do
					if funcName == name then
						continueToFunction = true
						break
					end
				end

				if continueToFunction then
					continue
				end
				
				runOptions["toRun"] = value
				
				queueAllTests(runOptions)
			end
		end
	elseif toTest:IsA("BindableEvent") then
		local function toRun(value)
			toTest:Fire(value)
		end
		
		local runOptions = {["toRun"] = toRun}
		
		queueAllTests(runOptions)
	elseif toTest:IsA("RemoteEvent") then
		local function toRun(value)
			if RunService:IsServer() then
				local player = options["player"]
				if player then
					toTest:FireClient(player, value)
				else
					toTest:FireAllClients(value)
				end
			else
				toTest:FireServer(value)
			end
		end
		
		local runOptions = {["toRun"] = toRun}
		
		queueAllTests(runOptions)
	end
	
	local workerCount = math.min(Config.MaxWorkers, #testQueue)
	for i = 1, workerCount do
		Worker()
	end
	
	while activeWorkers > 0 or #testQueue > 0 do
		task.wait()
	end
	
	local endTime = os.clock()
	
	print("----------- Project Sentinel Testing Finished -----------")
	print("Time taken:", (endTime - startTime) * 1000, "ms (1000ms = 1second)")
	print("Average time per test:", ((endTime - startTime) * 1000)/totalTests, "ms")
	print("Total tests:", totalTests)
	print("Total success':", totalSuccess)
	print("Total failures:", totalFailures)
	print("Tested a:", typeof(toTest))
	
	if #failedIn > 0 then
		print("---- List Of Failed Tests ----")
		for _, failedTest in ipairs(failedIn) do
			print("-", failedTest)
		end
	end
	
	if #allErrors > 0 then
		print("---- List Of Errors ----")
		for _, err in ipairs(allErrors) do
			print("-", err)
		end
	end
end

return ProjectSentinel
