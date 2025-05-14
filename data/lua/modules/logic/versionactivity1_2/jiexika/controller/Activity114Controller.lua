module("modules.logic.versionactivity1_2.jiexika.controller.Activity114Controller", package.seeall)

local var_0_0 = class("Activity114Controller", BaseController)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, arg_3_0._checkActivityInfo, arg_3_0)
	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, arg_3_0.onFightSceneEnter, arg_3_0)
end

function var_0_0.reInit(arg_4_0)
	arg_4_0:markStoryFinish()
end

function var_0_0._checkActivityInfo(arg_5_0, arg_5_1)
	local var_5_0

	if arg_5_1 then
		var_5_0 = ActivityModel.instance:getActMO(arg_5_1)
	else
		for iter_5_0 in pairs(Activity114Config.instance:getAllActivityIds()) do
			if ActivityModel.instance:isActOnLine(iter_5_0) then
				var_5_0 = ActivityModel.instance:getActMO(iter_5_0)

				break
			end
		end
	end

	if not var_5_0 then
		return
	end

	if var_5_0.actType ~= ActivityEnum.ActivityTypeID.JieXiKa then
		return
	end

	if not var_5_0.online and var_5_0.id == Activity114Model.instance.id then
		Activity114Model.instance:setEnd()
	end
end

function var_0_0.onFightSceneEnter(arg_6_0, arg_6_1)
	if arg_6_1 ~= SceneType.Fight then
		return
	end

	local var_6_0 = FightModel.instance:getFightParam()

	if not var_6_0 or var_6_0.episodeId ~= Activity114Enum.episodeId then
		return
	end

	local var_6_1 = Activity114Helper.getEventCoByBattleId(var_6_0.battleId)

	if var_6_1 then
		local var_6_2 = {
			type = var_6_1.config.eventType,
			eventId = var_6_1.config.id
		}

		Activity114Model.instance:buildFlowAndSkipWork(var_6_2)
	end
end

function var_0_0.alertActivityEndMsgBox(arg_7_0)
	if not Activity114Model.instance:isEnd() then
		return
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, function()
		if GameSceneMgr.instance:isFightScene() then
			arg_7_0:dispatchEvent(Activity114Event.OnEventProcessEnd)
		else
			NavigateButtonsView.homeClick()
		end
	end)
end

function var_0_0.openAct114View(arg_9_0)
	local var_9_0

	for iter_9_0 in pairs(Activity114Config.instance:getAllActivityIds()) do
		if ActivityModel.instance:isActOnLine(iter_9_0) then
			var_9_0 = ActivityModel.instance:getActMO(iter_9_0)

			break
		end
	end

	if not var_9_0 then
		GameFacade.showToast(ToastEnum.ActivityEnd)

		return
	end

	Activity114Rpc.instance:sendGet114InfosRequest(var_9_0.id, arg_9_0._openAct114View, arg_9_0)
end

function var_0_0._openAct114View(arg_10_0)
	if Activity114Model.instance:isEnd() then
		GameFacade.showToast(ToastEnum.ActivityEnd)

		return
	end

	if Activity114Model.instance.serverData.battleEventId > 0 then
		local var_10_0 = Activity114Config.instance:getEventCoById(Activity114Model.instance.id, Activity114Model.instance.serverData.battleEventId)

		arg_10_0:enterActivityFight(var_10_0.config.battleId)

		return
	end

	ViewMgr.instance:openView(ViewName.Activity114View)
end

function var_0_0.enterActivityFight(arg_11_0, arg_11_1)
	if not arg_11_1 or arg_11_1 <= 0 then
		error("battleId : " .. tostring(arg_11_1))

		return
	end

	Activity114Rpc.instance:beforeBattle(Activity114Model.instance.id)

	local var_11_0 = Activity114Enum.episodeId
	local var_11_1 = DungeonConfig.instance:getEpisodeCO(var_11_0)

	DungeonFightController.instance:enterFightByBattleId(var_11_1.chapterId, var_11_0, arg_11_1)
end

function var_0_0.markStoryWillFinish(arg_12_0)
	Activity114Model.instance.waitStoryFinish = true

	ViewMgr.instance:registerCallback(ViewEvent.DestroyViewFinish, arg_12_0._onCloseViewFinish, arg_12_0)
	StoryController.instance:registerCallback(StoryEvent.Finish, arg_12_0.markStoryFinish, arg_12_0)
end

function var_0_0._onCloseViewFinish(arg_13_0, arg_13_1)
	if arg_13_1 == ViewName.StoryView then
		arg_13_0:markStoryFinish()
	end
end

function var_0_0.markStoryFinish(arg_14_0)
	Activity114Model.instance.waitStoryFinish = false

	ViewMgr.instance:unregisterCallback(ViewEvent.DestroyViewFinish, arg_14_0._onCloseViewFinish, arg_14_0)
	StoryController.instance:unregisterCallback(StoryEvent.Finish, arg_14_0.markStoryFinish, arg_14_0)
	arg_14_0:dispatchEvent(Activity114Event.StoryFinish)
end

var_0_0.instance = var_0_0.New()

return var_0_0
