module("modules.logic.versionactivity2_5.common.VersionActivity2_5JumpHandleFunc", package.seeall)

local var_0_0 = class("VersionActivity2_5JumpHandleFunc")

function var_0_0.jumpTo12301(arg_1_0)
	VersionActivity2_5EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12502(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1[2]
	local var_2_1 = arg_2_1[3]

	table.insert(arg_2_0.waitOpenViewNames, ViewName.VersionActivity2_5EnterView)
	table.insert(arg_2_0.closeViewNames, ViewName.VersionActivity2_5DungeonMapLevelView)
	VersionActivity2_5DungeonModel.instance:setMapNeedTweenState(true)

	if var_2_1 then
		VersionActivity2_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			VersionActivity2_5DungeonController.instance:openVersionActivityDungeonMapView(nil, var_2_1, function()
				ViewMgr.instance:openView(ViewName.VersionActivity2_5DungeonMapLevelView, {
					isJump = true,
					episodeId = var_2_1
				})
			end)
		end, nil, var_2_0, true)
	else
		VersionActivity2_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_5DungeonController.openVersionActivityDungeonMapView, VersionActivity2_5DungeonController.instance, var_2_0, true)
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12503(arg_5_0, arg_5_1)
	VersionActivity2_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_5DungeonController.openStoreView, VersionActivity2_5DungeonController.instance, VersionActivity2_5Enum.ActivityId.Dungeon, true)

	return JumpEnum.JumpResult.Success
end

function var_0_0.enterRoleActivity(arg_6_0)
	RoleActivityController.instance:enterActivity(arg_6_0)
end

function var_0_0.jumpTo11602(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1[2]
	local var_7_1 = arg_7_1[3]

	table.insert(arg_7_0.waitOpenViewNames, ViewName.VersionActivity2_5EnterView)
	table.insert(arg_7_0.closeViewNames, ViewName.VersionActivity1_6DungeonMapLevelView)

	if var_7_1 then
		VersionActivity2_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			VersionActivity1_6DungeonController.instance:openVersionActivityDungeonMapView(nil, var_7_1, function()
				ViewMgr.instance:openView(ViewName.VersionActivity1_6DungeonMapLevelView, {
					isJump = true,
					episodeId = var_7_1
				})
			end)
		end, nil, var_7_0, true)
	else
		VersionActivity2_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity1_6DungeonController.openVersionActivityDungeonMapView, VersionActivity1_6DungeonController.instance, var_7_0, true)
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12514(arg_10_0, arg_10_1)
	table.insert(arg_10_0.waitOpenViewNames, ViewName.VersionActivity2_5EnterView)
	VersionActivity2_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(arg_10_0.waitOpenViewNames, ViewName.ReactivityStoreView)
		ReactivityController.instance:openReactivityStoreView(VersionActivity2_5Enum.ActivityId.Reactivity)
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12505(arg_12_0, arg_12_1)
	table.insert(arg_12_0.waitOpenViewNames, ViewName.VersionActivity2_5EnterView)
	table.insert(arg_12_0.waitOpenViewNames, ViewName.Act183MainView)
	table.insert(arg_12_0.waitOpenViewNames, ViewName.Act183DungeonView)
	table.insert(arg_12_0.closeViewNames, ViewName.Act183TaskView)
	VersionActivity2_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		local var_13_0 = arg_12_1 and arg_12_1[3]
		local var_13_1 = Act183Config.instance:getEpisodeCo(var_13_0)
		local var_13_2 = var_13_1 and var_13_1.type
		local var_13_3 = var_13_1 and var_13_1.groupId
		local var_13_4 = Act183Helper.generateDungeonViewParams(var_13_2, var_13_3)

		if not ViewMgr.instance:isOpen(ViewName.Act183MainView) then
			Act183Controller.instance:openAct183MainView(nil, function()
				Act183Controller.instance:openAct183DungeonView(var_13_4)
			end)
		else
			Act183Controller.instance:openAct183DungeonView(var_13_4)
		end
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12512(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1[2]

	VersionActivity2_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, var_15_0, true)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12513(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1[2]

	VersionActivity2_5EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, var_16_0, true)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12520(arg_17_0, arg_17_1)
	Activity187Controller.instance:openAct187View()

	return JumpEnum.JumpResult.Success
end

return var_0_0
