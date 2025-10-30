module("modules.logic.versionactivity3_0.common.VersionActivity3_0JumpHandleFunc", package.seeall)

local var_0_0 = class("VersionActivity3_0JumpHandleFunc")

function var_0_0.jumpTo130508(arg_1_0)
	local var_1_0 = VersionActivity3_0Enum.ActivityId.Reactivity

	VersionActivityFixedHelper.getVersionActivityEnterController(3, 0).instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_3DungeonController.openStoreView, VersionActivity2_3DungeonController.instance, var_1_0, true)

	return JumpEnum.JumpResult.Success
end

local function var_0_1(arg_2_0)
	return
end

function var_0_0.jumpTo13004(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1[2]

	if GameBranchMgr.instance:isOnVer(3, 0) then
		VersionActivityFixedHelper.getVersionActivityEnterController(3, 0).instance:openVersionActivityEnterViewIfNotOpened(var_0_1, var_3_0, var_3_0)
	else
		VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(var_0_1, var_3_0, var_3_0)
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12102(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1[2]
	local var_4_1 = arg_4_1[3]

	table.insert(arg_4_0.waitOpenViewNames, ViewName.VersionActivity3_0EnterView)
	table.insert(arg_4_0.closeViewNames, ViewName.VersionActivity2_1DungeonMapLevelView)
	VersionActivity2_1DungeonModel.instance:setMapNeedTweenState(true)

	if var_4_1 then
		VersionActivityFixedHelper.getVersionActivityEnterController(3, 0).instance:openVersionActivityEnterViewIfNotOpened(function()
			VersionActivity2_1DungeonController.instance:openVersionActivityDungeonMapView(nil, var_4_1, function()
				ViewMgr.instance:openView(ViewName.VersionActivity2_1DungeonMapLevelView, {
					isJump = true,
					episodeId = var_4_1
				})
			end)
		end, nil, var_4_0, true)
	else
		VersionActivityFixedHelper.getVersionActivityEnterController(3, 0).instance:openVersionActivityEnterViewIfNotOpened(VersionActivity2_1DungeonController.openVersionActivityDungeonMapView, VersionActivity2_1DungeonController.instance, var_4_0, true)
	end

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo13010(arg_7_0, arg_7_1)
	table.insert(arg_7_0.waitOpenViewNames, ViewName.VersionActivity3_0EnterView)
	VersionActivityFixedHelper.getVersionActivityEnterController(3, 0).instance:openVersionActivityEnterViewIfNotOpened(function()
		table.insert(arg_7_0.waitOpenViewNames, ViewName.ReactivityStoreView)
		ReactivityController.instance:openReactivityStoreView(VersionActivity3_0Enum.ActivityId.Reactivity)
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo12104(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1[2]

	VersionActivityFixedHelper.getVersionActivityEnterController(3, 0).instance:openVersionActivityEnterViewIfNotOpened(function()
		VersionActivity2_1DungeonController.instance:openVersionActivityDungeonMapView(nil, nil, function()
			Activity165Controller.instance:openActivity165EnterView()
		end)
	end, nil, var_9_0)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo13008(arg_12_0, arg_12_1)
	VersionActivity3_0DungeonController.instance:openStoreView()

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo13011(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1[2]
	local var_13_1 = arg_13_1[3]

	table.insert(arg_13_0.waitOpenViewNames, ViewName.VersionActivity3_0EnterView)
	table.insert(arg_13_0.closeViewNames, ViewName.Activity201MaLiAnNaTaskView)

	if var_13_1 and var_13_1 == 1 then
		if ActivityHelper.getActivityStatus(var_13_0) == ActivityEnum.ActivityStatus.Normal then
			local var_13_2 = ActivityConfig.instance:getActivityCo(var_13_0).tryoutEpisode

			if var_13_2 <= 0 then
				logError("没有配置对应的试用关卡")

				return JumpEnum.JumpResult.Fail
			end

			local var_13_3 = DungeonConfig.instance:getEpisodeCO(var_13_2)

			DungeonFightController.instance:enterFight(var_13_3.chapterId, var_13_2)

			return JumpEnum.JumpResult.Success
		else
			local var_13_4, var_13_5 = OpenHelper.getToastIdAndParam(arg_13_0.actCo.openId)

			if var_13_4 and var_13_4 ~= 0 then
				GameFacade.showToast(var_13_4)

				return JumpEnum.JumpResult.Fail
			end

			return JumpEnum.JumpResult.Success
		end
	else
		VersionActivity3_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
			Activity201MaLiAnNaController.instance:enterLevelView()
		end, nil, var_13_0, true)

		return JumpEnum.JumpResult.Success
	end
end

function var_0_0.jumpTo13015(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1[2]

	VersionActivity3_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		ViewMgr.instance:openView(ViewName.KaRongLevelView)
	end, nil, var_15_0, true)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo13000(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1[2]

	VersionActivity3_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		Activity104Controller.instance:openSeasonMainView()
	end, nil, var_17_0, true)

	return JumpEnum.JumpResult.Success
end

function var_0_0.jumpTo13015(arg_19_0, arg_19_1)
	table.insert(arg_19_0.closeViewNames, ViewName.KaRongTaskView)
	table.insert(arg_19_0.closeViewNames, ViewName.KaRongLevelView)

	local var_19_0 = arg_19_1[2]

	VersionActivity3_0EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, var_19_0, true)

	return JumpEnum.JumpResult.Success
end

return var_0_0
