module("modules.logic.versionactivity3_1.common.VersionActivity3_1JumpHandleFunc", package.seeall)

local var_0_0 = class("VersionActivity3_1JumpHandleFunc")

function var_0_0.jumpTo12402(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1[2]
	local var_1_1 = arg_1_1[3]

	table.insert(arg_1_0.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	table.insert(arg_1_0.closeViewNames, ViewName.VersionActivity2_4DungeonMapLevelView)

	if var_1_1 then
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
			VersionActivity2_4DungeonController.instance:openVersionActivityDungeonMapView(nil, var_1_1, function()
				ViewMgr.instance:openView(ViewName.VersionActivity2_4DungeonMapLevelView, {
					isJump = true,
					episodeId = var_1_1
				})
			end)
		end, nil, var_1_0, true)
	else
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_4DungeonController.openVersionActivityDungeonMapView, VersionActivity2_4DungeonController.instance, var_1_0, true)
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo13114(arg_4_0, arg_4_1)
	table.insert(arg_4_0.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(arg_4_0.waitOpenViewNames, ViewName.ReactivityStoreView)
		ReactivityController.instance:openReactivityStoreView(VersionActivity3_1Enum.ActivityId.Reactivity)
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo13103(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1[2]
	local var_6_1 = arg_6_1[3]
	local var_6_2 = VersionActivityFixedHelper.getVersionActivityDungeonMapLevelViewName()

	table.insert(arg_6_0.waitOpenViewNames, ViewName.VersionActivity3_1EnterView)
	table.insert(arg_6_0.closeViewNames, var_6_2)
	VersionActivityFixedDungeonModel.instance:setMapNeedTweenState(true)

	local var_6_3 = VersionActivityFixedHelper.getVersionActivityDungeonController()

	if var_6_1 then
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
			var_6_3.instance:openVersionActivityDungeonMapView(nil, var_6_1, function()
				ViewMgr.instance:openView(var_6_2, {
					isJump = true,
					episodeId = var_6_1
				})
			end)
		end, nil, var_6_0, true)
	else
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(var_6_3.openVersionActivityDungeonMapView, var_6_3.instance, var_6_0, true)
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo13104(arg_9_0, arg_9_1)
	local var_9_0 = VersionActivityFixedHelper.getVersionActivityDungeonController()

	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(var_9_0.openStoreView, var_9_0.instance, VersionActivityFixedHelper.getVersionActivityEnum().ActivityId.Dungeon, true)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo13117(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1 and arg_10_1[3]

	table.insert(arg_10_0.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity3_1Enum.ActivityId.YeShuMei, true)
		YeShuMeiController.instance:enterLevelView(var_10_0)
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo13106(arg_12_0, arg_12_1)
	table.insert(arg_12_0.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(nil, nil, VersionActivity3_1Enum.ActivityId.Survival, true)
		SurvivalController.instance:openSurvivalView(nil)
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo13105(arg_14_0)
	table.insert(arg_14_0.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(arg_14_0.waitOpenViewNames, ViewName.Act191MainView)
		Activity191Controller.instance:enterActivity(VersionActivity3_1Enum.ActivityId.DouQuQu3)
	end, nil, VersionActivity3_1Enum.ActivityId.DouQuQu3, true)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo13115(arg_16_0)
	table.insert(arg_16_0.waitOpenViewNames, VersionActivityFixedHelper.getVersionActivityEnterViewName())
	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(function()
		Activity191Controller.instance:enterActivity(VersionActivity3_1Enum.ActivityId.DouQuQu3)
		Activity191Controller.instance:openStoreView(VersionActivity3_1Enum.ActivityId.DouQuQu3Store)
	end, nil, VersionActivity3_1Enum.ActivityId.DouQuQu3, true)

	return JumpEnum.JumpResult.Success
end

return var_0_0
