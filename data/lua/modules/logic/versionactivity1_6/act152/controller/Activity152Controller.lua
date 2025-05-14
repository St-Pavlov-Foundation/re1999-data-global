module("modules.logic.versionactivity1_6.act152.controller.Activity152Controller", package.seeall)

local var_0_0 = class("Activity152Controller", BaseController)

function var_0_0._getJoinConditionEpisodeId(arg_1_0)
	if arg_1_0._joinConditionEpisodeId then
		return arg_1_0._joinConditionEpisodeId
	end

	local var_1_0 = ActivityConfig.instance:getActivityCo(ActivityEnum.Activity.NewYearEve).joinCondition

	if string.nilorempty(var_1_0) then
		return nil
	end

	local var_1_1 = tonumber((string.gsub(var_1_0, "EpisodeFinish=", "")))

	arg_1_0._joinConditionEpisodeId = var_1_1

	return var_1_1
end

function var_0_0._unexpectError(arg_2_0)
	arg_2_0:_unregisterListenCheckActUnlock()

	local var_2_0 = ActivityConfig.instance:getActivityCo(ActivityEnum.Activity.NewYearEve).joinCondition

	logError("Activity152Controller _unexpectError actId=" .. tostring(ActivityEnum.Activity.NewYearEve) .. " joinCondition=" .. tostring(var_2_0))
end

function var_0_0._unregisterListenCheckActUnlock(arg_3_0)
	DungeonController.instance:unregisterCallback(DungeonEvent.OnUpdateDungeonInfo, arg_3_0._onUpdateDungeonInfo, arg_3_0)
end

function var_0_0._onUpdateDungeonInfo(arg_4_0)
	if ActivityHelper.getActivityStatus(ActivityEnum.Activity.NewYearEve, true) ~= ActivityEnum.ActivityStatus.Normal then
		return
	end

	local var_4_0 = arg_4_0:_getJoinConditionEpisodeId()

	if not var_4_0 then
		arg_4_0:_unexpectError()

		return
	end

	if DungeonModel.instance:hasPassLevel(var_4_0) then
		ActivityRpc.instance:sendGetActivityInfosRequest(function(arg_5_0, arg_5_1)
			if arg_5_1 ~= 0 then
				return
			end

			arg_4_0:_unregisterListenCheckActUnlock()
			arg_4_0:_startCheckGiftUnlock()
		end)
	end
end

function var_0_0.onInit(arg_6_0)
	return
end

function var_0_0.reInit(arg_7_0)
	arg_7_0._joinConditionEpisodeId = nil

	arg_7_0:_unregisterListenCheckActUnlock()
	DungeonController.instance:registerCallback(DungeonEvent.OnUpdateDungeonInfo, arg_7_0._onUpdateDungeonInfo, arg_7_0)

	if arg_7_0._popupFlow then
		arg_7_0._popupFlow:destroy()

		arg_7_0._popupFlow = nil
	end

	TaskDispatcher.cancelTask(arg_7_0._checkGiftUnlock, arg_7_0)
end

function var_0_0.addConstEvents(arg_8_0)
	DungeonController.instance:registerCallback(DungeonEvent.OnUpdateDungeonInfo, arg_8_0._onUpdateDungeonInfo, arg_8_0)
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, arg_8_0._checkActivityInfo, arg_8_0)
	MainController.instance:registerCallback(MainEvent.OnMainPopupFlowFinish, arg_8_0._startCheckGiftUnlock, arg_8_0)
	GameStateMgr.instance:registerCallback(GameStateEvent.onApplicationPause, arg_8_0._onApplicationPause, arg_8_0)
end

function var_0_0._checkActivityInfo(arg_9_0)
	if ActivityModel.instance:isActOnLine(ActivityEnum.Activity.NewYearEve) then
		Activity152Rpc.instance:sendGet152InfoRequest(ActivityEnum.Activity.NewYearEve)
	end
end

function var_0_0._onApplicationPause(arg_10_0, arg_10_1)
	if arg_10_1 then
		arg_10_0:_startCheckGiftUnlock()
	end
end

function var_0_0._startCheckGiftUnlock(arg_11_0)
	if not ActivityModel.instance:isActOnLine(ActivityEnum.Activity.NewYearEve) then
		return
	end

	if arg_11_0._popupFlow then
		arg_11_0._popupFlow:destroy()

		arg_11_0._popupFlow = nil
	end

	local var_11_0 = Activity152Model.instance:getPresentUnaccepted()

	TaskDispatcher.cancelTask(arg_11_0._checkGiftUnlock, arg_11_0)

	local var_11_1 = #var_11_0 > 0 and 0.5 or Activity152Model.instance:getNextUnlockLimitTime() + 0.5

	if var_11_1 > 0 then
		TaskDispatcher.runDelay(arg_11_0._checkGiftUnlock, arg_11_0, var_11_1)
	end
end

function var_0_0._checkGiftUnlock(arg_12_0)
	arg_12_0._popupFlow = FlowSequence.New()

	arg_12_0._popupFlow:addWork(Activity152PatFaceWork.New())
	arg_12_0._popupFlow:registerDoneListener(arg_12_0._stopShowSequence, arg_12_0)
	arg_12_0._popupFlow:start()
end

function var_0_0._stopShowSequence(arg_13_0)
	if arg_13_0._popupFlow then
		arg_13_0._popupFlow:destroy()

		arg_13_0._popupFlow = nil
	end

	arg_13_0:_startCheckGiftUnlock()
end

function var_0_0.openNewYearGiftView(arg_14_0, arg_14_1)
	ViewMgr.instance:openView(ViewName.NewYearEveGiftView, arg_14_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
