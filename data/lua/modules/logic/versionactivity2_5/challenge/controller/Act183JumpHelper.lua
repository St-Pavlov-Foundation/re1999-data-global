module("modules.logic.versionactivity2_5.challenge.controller.Act183JumpHelper", package.seeall)

local var_0_0 = _M

function var_0_0.activate()
	return
end

local var_0_1 = VersionActivity2_7Enum.ActivityId.Challenge
local var_0_2 = VersionActivityFixedHelper.getVersionActivityEnum().ActivityId.EnterView

function var_0_0.fightExitHandleFunc(arg_2_0, arg_2_1)
	local var_2_0 = DungeonModel.instance.curSendEpisodeId

	DungeonModel.instance.lastSendEpisodeId = var_2_0
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_2_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.Act183MainView)

		local var_3_0 = Act183Config.instance:getEpisodeCo(var_2_0)
		local var_3_1 = var_3_0 and var_3_0.activityId

		VersionActivityFixedEnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, var_3_1)
		Act183Controller.instance:openAct183MainView(nil, function()
			local var_4_0 = Act183Helper.generateDungeonViewParams2(var_2_0)

			Act183Controller.instance:openAct183DungeonView(var_4_0)
		end)
	end)
end

function var_0_0.canJumpToAct183(arg_5_0, arg_5_1)
	local var_5_0, var_5_1, var_5_2 = ActivityHelper.getActivityStatusAndToast(var_0_2)

	if var_5_0 ~= ActivityEnum.ActivityStatus.Normal then
		return false, var_5_1, var_5_2
	end

	local var_5_3, var_5_4, var_5_5 = ActivityHelper.getActivityStatusAndToast(var_0_1)

	if var_5_3 ~= ActivityEnum.ActivityStatus.Normal then
		return false, var_5_4, var_5_5
	end

	local var_5_6 = string.splitToNumber(arg_5_1, "#")
	local var_5_7 = var_5_6 and var_5_6[2]

	if not Act183Config.instance:isGroupExist(var_0_1, var_5_7) then
		return false, ToastEnum.EpisodeNotExist, JumpController.DefaultToastParam
	end

	local var_5_8 = Act183Model.instance:getActInfo():getGroupEpisodeMo(var_5_7)

	if (var_5_8 and var_5_8:getStatus()) == Act183Enum.GroupStatus.Locked then
		return false, ToastEnum.Act183GroupNotOpen, JumpController.DefaultToastParam
	end

	return true, JumpController.DefaultToastId, JumpController.DefaultToastParam
end

function var_0_0.jumpToAct183(arg_6_0, arg_6_1)
	local var_6_0 = VersionActivityFixedHelper.getVersionActivityEnterViewName()

	table.insert(arg_6_0.waitOpenViewNames, var_6_0)
	table.insert(arg_6_0.waitOpenViewNames, ViewName.Act183MainView)
	table.insert(arg_6_0.waitOpenViewNames, ViewName.Act183DungeonView)
	table.insert(arg_6_0.closeViewNames, ViewName.Act183TaskView)
	VersionActivityFixedEnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		local var_7_0 = string.splitToNumber(arg_6_1, "#")
		local var_7_1 = var_7_0 and var_7_0[2]
		local var_7_2 = Act183Helper.generateDungeonViewParams3(var_0_1, var_7_1)

		if not ViewMgr.instance:isOpen(ViewName.Act183MainView) then
			Act183Controller.instance:openAct183MainView(nil, function()
				Act183Controller.instance:openAct183DungeonView(var_7_2)
			end)
		else
			Act183Controller.instance:openAct183DungeonView(var_7_2)
		end
	end)

	return JumpEnum.JumpResult.Success
end

local var_0_3 = {
	[VersionActivity2_7Enum.ActivityId.Challenge] = var_0_0.fightExitHandleFunc
}

local function var_0_4()
	for iter_9_0, iter_9_1 in pairs(var_0_3) do
		EnterActivityViewOnExitFightSceneHelper["enterActivity" .. iter_9_0] = iter_9_1
	end
end

;(function()
	var_0_4()
end)()

return var_0_0
