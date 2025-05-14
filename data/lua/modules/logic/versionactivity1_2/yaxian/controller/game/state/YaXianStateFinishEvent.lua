module("modules.logic.versionactivity1_2.yaxian.controller.game.state.YaXianStateFinishEvent", package.seeall)

local var_0_0 = class("YaXianStateFinishEvent", YaXianStateBase)

var_0_0.BLOCK_KEY = "YaXianStateFinishEvent"

function var_0_0.start(arg_1_0)
	arg_1_0.stateType = YaXianGameEnum.GameStateType.FinishEvent
	arg_1_0.gameLoadDone = YaXianGameModel.instance:gameIsLoadDone()
	arg_1_0.openingLoadingView = ViewMgr.instance:isOpen(ViewName.LoadingView)

	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(var_0_0.BLOCK_KEY)

	if arg_1_0.gameLoadDone and not arg_1_0.openingLoadingView then
		arg_1_0:onFinish()
	else
		if not arg_1_0.gameLoadDone then
			YaXianGameController.instance:registerCallback(YaXianEvent.OnGameLoadDone, arg_1_0.onGameLoadDone, arg_1_0)
		end

		if arg_1_0.openingLoadingView then
			ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, arg_1_0.onCloseViewFinish, arg_1_0)
		end
	end
end

function var_0_0.onGameLoadDone(arg_2_0)
	YaXianGameController.instance:unregisterCallback(YaXianEvent.OnGameLoadDone, arg_2_0.onGameLoadDone, arg_2_0)

	arg_2_0.gameLoadDone = true

	arg_2_0:checkCanStartFinishEvent()
end

function var_0_0.onCloseViewFinish(arg_3_0, arg_3_1)
	if arg_3_1 == ViewName.LoadingView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_3_0.onCloseViewFinish, arg_3_0)

		arg_3_0.openingLoadingView = false

		arg_3_0:checkCanStartFinishEvent()
	end
end

function var_0_0.checkCanStartFinishEvent(arg_4_0)
	if arg_4_0.gameLoadDone and not arg_4_0.openingLoadingView then
		arg_4_0:onFinish()
	end
end

function var_0_0.onFinish(arg_5_0)
	local var_5_0 = arg_5_0.originData.preEvent

	if var_5_0 and var_5_0.eventType == YaXianGameEnum.GameStateType.Battle then
		arg_5_0:startFinishBattleAnimation(arg_5_0.sendRequest, arg_5_0)

		return
	end

	arg_5_0:sendRequest()
end

function var_0_0.startFinishBattleAnimation(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0
	local var_6_1
	local var_6_2 = YaXianGameController.instance:getPlayerInteractItem()
	local var_6_3 = YaXianGameController.instance:getInteractItem(arg_6_0.originData.preEvent.interactId)

	if EnterActivityViewOnExitFightSceneHelper.recordMO.fightResult ~= FightEnum.FightResult.Succ then
		var_6_0 = var_6_3
		var_6_1 = var_6_2
	else
		var_6_0 = var_6_2
		var_6_1 = var_6_3
	end

	var_6_0:showEffect(YaXianGameEnum.EffectType.FightSuccess)
	var_6_1:showEffect(YaXianGameEnum.EffectType.Die, arg_6_1, arg_6_2)
end

function var_0_0.sendRequest(arg_7_0)
	Activity115Rpc.instance:sendAct115EventEndRequest(YaXianGameEnum.ActivityId, arg_7_0.onReceiveReply, arg_7_0)
end

function var_0_0.onReceiveReply(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_2 == 0 then
		YaXianGameController.instance:dispatchEvent(YaXianEvent.OnStateFinish, arg_8_0.stateType)
	end

	UIBlockMgr.instance:endBlock(var_0_0.BLOCK_KEY)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function var_0_0.dispose(arg_9_0)
	YaXianGameController.instance:unregisterCallback(YaXianEvent.OnGameLoadDone, arg_9_0.onGameLoadDone, arg_9_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, arg_9_0.onCloseViewFinish, arg_9_0)
	var_0_0.super.dispose(arg_9_0)
end

return var_0_0
