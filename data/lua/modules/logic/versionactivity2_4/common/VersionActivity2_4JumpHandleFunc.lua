module("modules.logic.versionactivity2_4.common.VersionActivity2_4JumpHandleFunc", package.seeall)

local var_0_0 = class("VersionActivity2_4JumpHandleFunc")

function var_0_0.jumpTo12401(arg_1_0)
	VersionActivity2_4EnterController.instance:openVersionActivityEnterView()

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12402(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1[2]
	local var_2_1 = arg_2_1[3]

	table.insert(arg_2_0.waitOpenViewNames, ViewName.VersionActivity2_4EnterView)
	table.insert(arg_2_0.closeViewNames, ViewName.VersionActivity2_4DungeonMapLevelView)
	VersionActivity2_4DungeonModel.instance:setMapNeedTweenState(true)

	if var_2_1 then
		VersionActivity2_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			VersionActivity2_4DungeonController.instance:openVersionActivityDungeonMapView(nil, var_2_1, function()
				ViewMgr.instance:openView(ViewName.VersionActivity2_4DungeonMapLevelView, {
					isJump = true,
					episodeId = var_2_1
				})
			end)
		end, nil, var_2_0, true)
	else
		VersionActivity2_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_4DungeonController.openVersionActivityDungeonMapView, VersionActivity2_4DungeonController.instance, var_2_0, true)
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12403(arg_5_0, arg_5_1)
	VersionActivity2_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_4DungeonController.openStoreView, VersionActivity2_4DungeonController.instance, VersionActivity2_4Enum.ActivityId.Dungeon, true)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12404(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1[2]

	VersionActivity2_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		PinballController.instance:openMainView()
	end, nil, var_6_0)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12405(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1[2]

	VersionActivity2_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		VersionActivity2_4MusicController.instance:openVersionActivity2_4MusicChapterView()
	end, nil, var_8_0)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo11804(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1[2]
	local var_10_1 = arg_10_1[3]

	table.insert(arg_10_0.waitOpenViewNames, ViewName.VersionActivity2_4EnterView)
	table.insert(arg_10_0.closeViewNames, ViewName.VersionActivity1_8DungeonMapLevelView)

	if var_10_1 then
		VersionActivity2_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			VersionActivity1_8DungeonController.instance:openVersionActivityDungeonMapView(nil, var_10_1, function()
				ViewMgr.instance:openView(ViewName.VersionActivity1_8DungeonMapLevelView, {
					isJump = true,
					episodeId = var_10_1
				})
			end)
		end, nil, var_10_0, true)
	else
		VersionActivity2_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(VersionActivity1_8DungeonController.openVersionActivityDungeonMapView, VersionActivity1_8DungeonController.instance, var_10_0, true)
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo11815(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1 and arg_13_1[3] == 2

	table.insert(arg_13_0.waitOpenViewNames, ViewName.VersionActivity2_4EnterView)
	table.insert(arg_13_0.waitOpenViewNames, ViewName.VersionActivity1_8DungeonMapView)
	table.insert(arg_13_0.waitOpenViewNames, ViewName.VersionActivity1_8FactoryMapView)

	if not var_13_0 then
		table.insert(arg_13_0.closeViewNames, ViewName.VersionActivity1_8FactoryBlueprintView)
	end

	local function var_13_1()
		Activity157Controller.instance:openFactoryMapView(var_13_0)
	end

	local function var_13_2()
		if ViewMgr.instance:isOpen(ViewName.VersionActivity1_8DungeonMapView) then
			var_13_1()
		else
			VersionActivity1_8DungeonController.instance:openVersionActivityDungeonMapView(nil, nil, var_13_1)
		end
	end

	VersionActivity2_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(var_13_2, nil, nil, true)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12408(arg_16_0, arg_16_1)
	table.insert(arg_16_0.waitOpenViewNames, ViewName.VersionActivity2_4EnterView)
	VersionActivity2_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(arg_16_0.waitOpenViewNames, ViewName.ReactivityStoreView)
		ReactivityController.instance:openReactivityStoreView(VersionActivity2_4Enum.ActivityId.Reactivity)
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12400(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1[2]

	VersionActivity2_4EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, var_18_0, true)

	return JumpEnum.JumpResult.Success
end

return var_0_0
