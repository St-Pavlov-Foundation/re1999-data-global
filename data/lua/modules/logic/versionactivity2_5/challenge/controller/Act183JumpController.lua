module("modules.logic.versionactivity2_5.challenge.controller.Act183JumpController", package.seeall)

local var_0_0 = class("Act183JumpController", BaseController)
local var_0_1 = VersionActivity2_8Enum.ActivityId.Challenge
local var_0_2 = VersionActivity2_8Enum.ActivityId.EnterView

function var_0_0.fightExitHandleFunc(arg_1_0, arg_1_1)
	local var_1_0 = DungeonModel.instance.curSendEpisodeId

	DungeonModel.instance.lastSendEpisodeId = var_1_0
	DungeonModel.instance.curSendEpisodeId = nil

	MainController.instance:enterMainScene(arg_1_0)
	SceneHelper.instance:waitSceneDone(SceneType.Main, function()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.WaitViewOpenCloseLoading, ViewName.Act183MainView)

		local var_2_0 = Act183Config.instance:getEpisodeCo(var_1_0)
		local var_2_1 = var_2_0 and var_2_0.activityId

		VersionActivity2_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(nil, nil, var_2_1)
		Act183Controller.instance:openAct183MainView(nil, function()
			local var_3_0 = Act183Helper.generateDungeonViewParams2(var_1_0)

			Act183Controller.instance:openAct183DungeonView(var_3_0)
		end)
	end)
end

function var_0_0.canJumpToAct183(arg_4_0, arg_4_1)
	local var_4_0, var_4_1, var_4_2 = ActivityHelper.getActivityStatusAndToast(var_0_2)

	if var_4_0 ~= ActivityEnum.ActivityStatus.Normal then
		return false, var_4_1, var_4_2
	end

	local var_4_3, var_4_4, var_4_5 = ActivityHelper.getActivityStatusAndToast(var_0_1)

	if var_4_3 ~= ActivityEnum.ActivityStatus.Normal then
		return false, var_4_4, var_4_5
	end

	local var_4_6 = string.splitToNumber(arg_4_1, "#")
	local var_4_7 = var_4_6 and var_4_6[2]

	if not Act183Config.instance:isGroupExist(var_0_1, var_4_7) then
		return false, ToastEnum.EpisodeNotExist, JumpController.DefaultToastParam
	end

	local var_4_8 = Act183Model.instance:getActInfo():getGroupEpisodeMo(var_4_7)

	if (var_4_8 and var_4_8:getStatus()) == Act183Enum.GroupStatus.Locked then
		return false, ToastEnum.Act183GroupNotOpen, JumpController.DefaultToastParam
	end

	return true, JumpController.DefaultToastId, JumpController.DefaultToastParam
end

function var_0_0.jumpToAct183(arg_5_0, arg_5_1)
	table.insert(arg_5_0.waitOpenViewNames, ViewName.VersionActivity2_8EnterView)
	table.insert(arg_5_0.waitOpenViewNames, ViewName.Act183MainView)
	table.insert(arg_5_0.waitOpenViewNames, ViewName.Act183DungeonView)
	table.insert(arg_5_0.closeViewNames, ViewName.Act183TaskView)
	VersionActivity2_8EnterController.instance:openVersionActivityEnterViewIfNotOpened(function()
		local var_6_0 = string.splitToNumber(arg_5_1, "#")
		local var_6_1 = var_6_0 and var_6_0[2]
		local var_6_2 = Act183Helper.generateDungeonViewParams3(var_0_1, var_6_1)

		if not ViewMgr.instance:isOpen(ViewName.Act183MainView) then
			Act183Controller.instance:openAct183MainView(nil, function()
				Act183Controller.instance:openAct183DungeonView(var_6_2)
			end)
		else
			Act183Controller.instance:openAct183DungeonView(var_6_2)
		end
	end)

	return JumpEnum.JumpResult.Success
end

function var_0_0.canJumpToEnterView(arg_8_0, arg_8_1)
	local var_8_0, var_8_1, var_8_2 = ActivityHelper.getActivityStatusAndToast(var_0_2)

	if var_8_0 ~= ActivityEnum.ActivityStatus.Normal then
		return false, var_8_1, var_8_2
	end

	local var_8_3, var_8_4, var_8_5 = ActivityHelper.getActivityStatusAndToast(var_0_1)

	if var_8_3 ~= ActivityEnum.ActivityStatus.Normal then
		return false, var_8_4, var_8_5
	end

	return true, JumpController.DefaultToastId, JumpController.DefaultToastParam
end

function var_0_0.jumpToEnterView(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1[2]

	VersionActivityFixedHelper.getVersionActivityEnterController().instance:openVersionActivityEnterViewIfNotOpened(nil, nil, var_9_0)

	return JumpEnum.JumpResult.Success
end

local function var_0_3()
	local var_10_0 = DungeonConfig.instance:getChapterCOListByType(DungeonEnum.ChapterType.Act183)
	local var_10_1 = var_0_1 == nil

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		local var_10_2 = iter_10_1.actId

		if var_10_2 ~= 0 then
			EnterActivityViewOnExitFightSceneHelper["enterActivity" .. var_10_2] = var_0_0.fightExitHandleFunc
			var_10_1 = var_10_1 or var_10_2 == var_0_1
		end
	end

	if not var_10_1 then
		logError(string.format("挑战玩法添加战斗返回跳转方法失败!!!失败原因:副本表缺少对应活动项 actId = %s", var_0_1))
	end
end

local function var_0_4()
	if not var_0_1 then
		return
	end

	local var_11_0 = ActivityHelper.getActivityVersion(var_0_1)

	if not var_11_0 then
		return
	end

	local var_11_1 = string.format("VersionActivity%sCanJumpFunc", var_11_0)
	local var_11_2 = _G[var_11_1]

	if var_11_2 then
		var_11_2["canJumpTo" .. var_0_1] = var_0_0.canJumpToEnterView
	else
		logError(string.format("缺少活动跳转检查脚本 cls = %s, actId = %s", var_11_1, var_0_1))
	end

	local var_11_3 = string.format("VersionActivity%sJumpHandleFunc", var_11_0)
	local var_11_4 = _G[var_11_3]

	if var_11_4 then
		var_11_4["jumpTo" .. var_0_1] = var_0_0.jumpToEnterView
	else
		logError(string.format("缺少活动跳转脚本 cls = %s, actId = %s", var_11_3, var_0_1))
	end
end

function var_0_0.addConstEvents(arg_12_0)
	LoginController.instance:registerCallback(LoginEvent.OnGetInfoFinish, arg_12_0._onGetInfoFinish, arg_12_0)
end

function var_0_0._onGetInfoFinish(arg_13_0)
	var_0_3()
	var_0_4()
end

var_0_0.instance = var_0_0.New()

return var_0_0
