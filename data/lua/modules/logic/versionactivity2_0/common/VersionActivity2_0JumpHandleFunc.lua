module("modules.logic.versionactivity2_0.common.VersionActivity2_0JumpHandleFunc", package.seeall)

local var_0_0 = class("VersionActivity2_0JumpHandleFunc")

function var_0_0.jumpTo12002(arg_1_0, arg_1_1)
	VersionActivity2_0EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12003(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1[2]
	local var_2_1 = arg_2_1[3]

	table.insert(arg_2_0.waitOpenViewNames, ViewName.VersionActivity2_0EnterView)
	table.insert(arg_2_0.closeViewNames, ViewName.VersionActivity2_0DungeonMapLevelView)
	VersionActivity2_0DungeonModel.instance:setMapNeedTweenState(true)

	if var_2_1 then
		VersionActivity2_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			VersionActivity2_0DungeonController.instance:openVersionActivityDungeonMapView(nil, var_2_1, function()
				if VersionActivity2_0DungeonModel.instance:getOpenGraffitiEntranceState() then
					ViewMgr.instance:closeView(ViewName.VersionActivity2_0DungeonMapGraffitiEnterView)
				end

				ViewMgr.instance:openView(ViewName.VersionActivity2_0DungeonMapLevelView, {
					isJump = true,
					episodeId = var_2_1
				})
			end)
		end, nil, var_2_0, true)
	else
		VersionActivity2_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_0DungeonController.openVersionActivityDungeonMapView, VersionActivity2_0DungeonController.instance, var_2_0, true)
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12004(arg_5_0, arg_5_1)
	VersionActivity2_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_0DungeonController.openStoreView, VersionActivity2_0DungeonController.instance, VersionActivity2_0Enum.ActivityId.Dungeon, true)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12005(arg_6_0, arg_6_1)
	table.insert(arg_6_0.waitOpenViewNames, ViewName.VersionActivity2_0EnterView)
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

	VersionActivity2_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(var_6_1, nil, nil, true)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12008(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1[2]

	VersionActivity2_0EnterController.instance:openVersionActivityEnterView(var_0_0.enterRoleActivity, var_9_0, var_9_0)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12009(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1[2]

	VersionActivity2_0EnterController.instance:openVersionActivityEnterView(var_0_0.enterRoleActivity, var_10_0, var_10_0)

	return JumpEnum.JumpResult.Success
end

function var_0_0.enterRoleActivity(arg_11_0)
	RoleActivityController.instance:enterActivity(arg_11_0)
end

function var_0_0.jumpTo12001(arg_12_0, arg_12_1)
	table.insert(arg_12_0.waitOpenViewNames, ViewName.VersionActivity2_0EnterView)
	VersionActivity2_1EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(arg_12_0.waitOpenViewNames, ViewName.ReactivityStoreView)
		ReactivityController.instance:openReactivityStoreView(JumpEnum.ActIdEnum.Act1_5Dungeon)
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12006(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1[2]

	VersionActivity2_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, var_14_0, true)

	return JumpEnum.JumpResult.Success
end

return var_0_0
