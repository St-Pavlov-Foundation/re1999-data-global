module("modules.logic.versionactivity2_6.common.VersionActivity2_6JumpHandleFunc", package.seeall)

local var_0_0 = class("VersionActivity2_6JumpHandleFunc")

function var_0_0.jumpTo11815(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1 and arg_1_1[3] == 2

	table.insert(arg_1_0.waitOpenViewNames, ViewName.VersionActivity2_6EnterView)
	table.insert(arg_1_0.waitOpenViewNames, ViewName.VersionActivity1_8DungeonMapView)
	table.insert(arg_1_0.waitOpenViewNames, ViewName.VersionActivity1_8FactoryMapView)

	if not var_1_0 then
		table.insert(arg_1_0.closeViewNames, ViewName.VersionActivity1_8FactoryBlueprintView)
	end

	local function var_1_1()
		Activity157Controller.instance:openFactoryMapView(var_1_0)
	end

	local function var_1_2()
		if ViewMgr.instance:isOpen(ViewName.VersionActivity1_8DungeonMapView) then
			var_1_1()
		else
			VersionActivity1_8DungeonController.instance:openVersionActivityDungeonMapView(nil, nil, var_1_1)
		end
	end

	VersionActivity2_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(var_1_2, nil, nil, true)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo11804(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1[2]
	local var_4_1 = arg_4_1[3]

	table.insert(arg_4_0.waitOpenViewNames, ViewName.VersionActivity2_6EnterView)
	table.insert(arg_4_0.closeViewNames, ViewName.VersionActivity1_8DungeonMapLevelView)

	if var_4_1 then
		VersionActivity2_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			VersionActivity1_8DungeonController.instance:openVersionActivityDungeonMapView(nil, var_4_1, function()
				ViewMgr.instance:openView(ViewName.VersionActivity1_8DungeonMapLevelView, {
					isJump = true,
					episodeId = var_4_1
				})
			end)
		end, nil, var_4_0, true)
	else
		VersionActivity2_6EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity1_8DungeonController.openVersionActivityDungeonMapView, VersionActivity1_8DungeonController.instance, var_4_0, true)
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12601(arg_7_0)
	VersionActivity2_6EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12602(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1[2]

	VersionActivity2_6EnterController.instance:openVersionActivityEnterView(nil, nil, var_8_0)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12605(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1[2]

	VersionActivity2_6EnterController.instance:openVersionActivityEnterView(nil, nil, var_9_0)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12603(arg_10_0, arg_10_1)
	VersionActivity2_6DungeonController.instance:openStoreView()

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12606(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1[2]

	VersionActivity2_6EnterController.instance:openVersionActivityEnterView(nil, nil, var_11_0)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12618(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1[2]

	VersionActivity2_6EnterController.instance:openVersionActivityEnterView(nil, nil, var_12_0)

	return JumpEnum.JumpResult.Success
end

return var_0_0
