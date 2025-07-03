module("modules.logic.versionactivity2_7.common.VersionActivity2_7JumpHandleFunc", package.seeall)

local var_0_0 = class("VersionActivity2_7JumpHandleFunc")

function var_0_0.jumpTo12003(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1[2]
	local var_1_1 = arg_1_1[3]

	table.insert(arg_1_0.waitOpenViewNames, ViewName.VersionActivity2_7EnterView)
	table.insert(arg_1_0.closeViewNames, ViewName.VersionActivity2_0DungeonMapLevelView)

	if var_1_1 then
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
			VersionActivity2_0DungeonController.instance:openVersionActivityDungeonMapView(nil, var_1_1, function()
				if VersionActivity2_0DungeonModel.instance:getOpenGraffitiEntranceState() then
					ViewMgr.instance:closeView(ViewName.VersionActivity2_0DungeonMapGraffitiEnterView)
				end

				ViewMgr.instance:openView(ViewName.VersionActivity2_0DungeonMapLevelView, {
					isJump = true,
					episodeId = var_1_1
				})
			end)
		end, nil, var_1_0, true)
	else
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_0DungeonController.openVersionActivityDungeonMapView, VersionActivity2_0DungeonController.instance, var_1_0, true)
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12713(arg_4_0, arg_4_1)
	table.insert(arg_4_0.waitOpenViewNames, ViewName.VersionActivity2_7EnterView)
	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(arg_4_0.waitOpenViewNames, ViewName.ReactivityStoreView)
		ReactivityController.instance:openReactivityStoreView(VersionActivity2_7Enum.ActivityId.Reactivity)
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12005(arg_6_0, arg_6_1)
	table.insert(arg_6_0.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	table.insert(arg_6_0.waitOpenViewNames, ViewName.VersionActivity2_0DungeonMapView)
	table.insert(arg_6_0.waitOpenViewNames, ViewName.VersionActivity2_0DungeonGraffitiView)

	local function var_6_0()
		Activity161Controller.instance:openGraffitiView()
	end

	local function var_6_1()
		if ViewMgr.instance:isOpen(ViewName.VersionActivity2_0DungeonMapView) then
			var_6_0()
		else
			VersionActivity2_0DungeonController.instance:openVersionActivityDungeonMapView(nil, nil, var_6_0)
		end
	end

	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(var_6_1, nil, nil, true)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12701(arg_9_0)
	local var_9_0 = VersionActivity2_7Enum.ActivityId.Act191

	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterView(function()
		Activity191Controller.instance:enterActivity(var_9_0)
	end, nil, var_9_0, true)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12706(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1[2]
	local var_11_1 = arg_11_1[3]
	local var_11_2 = VersionActivityFixedHelper.getVersionActivityDungeonMapLevelViewName()

	table.insert(arg_11_0.waitOpenViewNames, ViewName.VersionActivity2_7EnterView)
	table.insert(arg_11_0.closeViewNames, var_11_2)
	VersionActivityFixedDungeonModel.instance:setMapNeedTweenState(true)

	local var_11_3 = VersionActivityFixedHelper.getVersionActivityDungeonController()

	if var_11_1 then
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
			var_11_3.instance:openVersionActivityDungeonMapView(nil, var_11_1, function()
				ViewMgr.instance:openView(var_11_2, {
					isJump = true,
					episodeId = var_11_1
				})
			end)
		end, nil, var_11_0, true)
	else
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(var_11_3.openVersionActivityDungeonMapView, var_11_3.instance, var_11_0, true)
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12707(arg_14_0, arg_14_1)
	local var_14_0 = VersionActivityFixedHelper.getVersionActivityDungeonController()

	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(var_14_0.openStoreView, var_14_0.instance, VersionActivityFixedHelper.getVersionActivityEnum().ActivityId.Dungeon, true)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12714(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1[2]

	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(var_0_0.enterRoleActivity, var_15_0, var_15_0)

	return JumpEnum.JumpResult.Success
end

function var_0_0.enterRoleActivity(arg_16_0)
	RoleActivityController.instance:enterActivity(arg_16_0)
end

function var_0_0.jumpTo12702(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1[2]

	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(nil, nil, var_17_0)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12703(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1[2]

	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(nil, nil, var_18_0)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12704(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1[2]

	VersionActivityFixedHelper.getVersionActivityEnterController():openVersionActivityEnterView(nil, nil, var_19_0)

	return JumpEnum.JumpResult.Success
end

return var_0_0
