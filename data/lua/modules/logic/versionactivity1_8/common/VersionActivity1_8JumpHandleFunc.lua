module("modules.logic.versionactivity1_8.common.VersionActivity1_8JumpHandleFunc", package.seeall)

local var_0_0 = class("VersionActivity1_8JumpHandleFunc")

function var_0_0.jumpTo11803(arg_1_0, arg_1_1)
	VersionActivity1_8EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo11804(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1[2]
	local var_2_1 = arg_2_1[3]

	table.insert(arg_2_0.waitOpenViewNames, ViewName.VersionActivity1_8EnterView)
	table.insert(arg_2_0.closeViewNames, ViewName.VersionActivity1_8DungeonMapLevelView)

	if var_2_1 then
		VersionActivity1_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			VersionActivity1_8DungeonController.instance:openVersionActivityDungeonMapView(nil, var_2_1, function()
				ViewMgr.instance:openView(ViewName.VersionActivity1_8DungeonMapLevelView, {
					isJump = true,
					episodeId = var_2_1
				})
			end)
		end, nil, var_2_0, true)
	else
		VersionActivity1_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity1_8DungeonController.openVersionActivityDungeonMapView, VersionActivity1_8DungeonController.instance, var_2_0, true)
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo11805(arg_5_0, arg_5_1)
	VersionActivity1_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity1_8DungeonController.openStoreView, VersionActivity1_8DungeonController.instance, VersionActivity1_8Enum.ActivityId.Dungeon, true)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo11815(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1 and arg_6_1[3] == 2

	table.insert(arg_6_0.waitOpenViewNames, ViewName.VersionActivity1_8EnterView)
	table.insert(arg_6_0.waitOpenViewNames, ViewName.VersionActivity1_8DungeonMapView)
	table.insert(arg_6_0.waitOpenViewNames, ViewName.VersionActivity1_8FactoryMapView)

	if not var_6_0 then
		table.insert(arg_6_0.closeViewNames, ViewName.VersionActivity1_8FactoryBlueprintView)
	end

	local function var_6_1()
		Activity157Controller.instance:openFactoryMapView(var_6_0)
	end

	local function var_6_2()
		if ViewMgr.instance:isOpen(ViewName.VersionActivity1_8DungeonMapView) then
			var_6_1()
		else
			VersionActivity1_8DungeonController.instance:openVersionActivityDungeonMapView(nil, nil, var_6_1)
		end
	end

	VersionActivity1_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(var_6_2, nil, nil, true)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo11806(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1[2]

	VersionActivity1_8EnterController.instance:openVersionActivityEnterView(ActWeilaController.enterActivity, ActWeilaController.instance, var_9_0)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo11807(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1[2]

	VersionActivity1_8EnterController.instance:openVersionActivityEnterView(ActWindSongController.enterActivity, ActWindSongController.instance, var_10_0)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo11810(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1[2]

	if not ActivityModel.instance:isActOnLine(var_11_0) then
		return JumpEnum.JumpResult.Fail
	end

	table.insert(arg_11_0.waitOpenViewNames, ViewName.ActivityBeginnerView)
	ActivityModel.instance:setTargetActivityCategoryId(var_11_0)
	ActivityController.instance:openActivityBeginnerView()

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo11811(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1[2]

	VersionActivity1_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, var_12_0, true)

	return JumpEnum.JumpResult.Success
end

return var_0_0
