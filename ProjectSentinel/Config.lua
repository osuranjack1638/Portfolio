-- Project Sentinel
-- Copyright (c) 2026 osuranjack1638
-- Licensed under the Apache License 2.0.
-- See the LICENSE file in the project root for license information.


local ProjectSentinelConfig = {}

ProjectSentinelConfig.TestValues = {}
ProjectSentinelConfig.TestValues.Number = {1, 2, 3, 4, 5, 99, 99, 0, 100000, -100000, math.huge, -math.huge}
ProjectSentinelConfig.TestValues.Float = {1.1, 3.5, -3.2, 1923.9283, -2832.9202, 0.0, 12.3, -93.1, 111111111.2, -99999.3}
ProjectSentinelConfig.TestValues.String = {"Hey", "1", "string", "hey I am a string that is longer than the others", "a", "999", "true", "false", "nil", "break"}
ProjectSentinelConfig.TestValues.Boolean = {true, false, nil}
ProjectSentinelConfig.TestValues.Instance = {game:GetService("ReplicatedStorage"), Instance.new("Part"), game:GetService("Players"), game}
ProjectSentinelConfig.TestValues.Vector3 = {Vector3.new(1, 2, 3), Vector3.new(1, 1, 1), Vector3.new(0, 0, 0), Vector3.new(100, 100, 100), Vector3.new(-100, -100, -100), Vector3.new(1.1, 2.2, 3.3), Vector3.new(-1.1, -2.2, -3.3), Vector3.new(9999999, 9999999, 9999999), Vector3.new(-9999999, -9999999, -9999999)}
ProjectSentinelConfig.TestValues.CFrame = {CFrame.new(1, 2, 3), CFrame.new(1, 2, 3, 4, 5, 6, 7), CFrame.new(1.1, 2.2, 3.3), CFrame.new(-1.1, -2.2, -3.3), CFrame.new(99999, 99999, 99999), CFrame.new(-99999, -99999, -99999)}
ProjectSentinelConfig.TestValues.Color3 = {Color3.fromRGB(255, 255, 255), Color3.fromRGB(0, 0, 0), Color3.fromRGB(100, 100, 100), Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 255, 0), Color3.fromRGB(0, 0, 255), Color3.new(213, 123, 92), Color3.fromHSV(21, 234, 123), Color3.fromHex("#FFF")}
ProjectSentinelConfig.TestValues.Table = {{1, -2, 3, -4}, {"1", "true", "false", "hey, I am a string that is longer than the others"}, {true, false}, {1.3, 9.4, 102.4, -123.4}, {932938, -83902, 87932.32, -82732.21}, {"hey", true, 123, 934.12, -23, -823.12, nil}, {}, {{"hey", 23, 92.3, -9283.45, 8213.12}}, {{}}}
ProjectSentinelConfig.TestValues.Vector2 = {Vector2.new(1, 2), Vector2.new(1, 1), Vector2.new(0, 0), Vector2.new(100, 100), Vector2.new(-100, -100), Vector2.new(1.1, 2.2), Vector2.new(-1.1, -2.2), Vector2.new(99999, 99999), Vector2.new(-99999, -99999), Vector2.new(1, 2.5), Vector2.new(1.5, 2)}

ProjectSentinelConfig.DontTestFunctionsWithName = {"Kick", "ClearAll", "ClearInventory", "New"}
ProjectSentinelConfig.MaxWorkers = 1

return ProjectSentinelConfig
