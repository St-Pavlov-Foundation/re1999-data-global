module("modules.logic.versionactivity1_2.yaxian.controller.game.state.YaXianStateFinishEvent", package.seeall)

slot0 = class("YaXianStateFinishEvent", YaXianStateBase)
slot0.BLOCK_KEY = "YaXianStateFinishEvent"

function slot0.start(slot0)
	slot0.stateType = YaXianGameEnum.GameStateType.FinishEvent
	slot0.gameLoadDone = YaXianGameModel.instance:gameIsLoadDone()
	slot0.openingLoadingView = ViewMgr.instance:isOpen(ViewName.LoadingView)

	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(uv0.BLOCK_KEY)

	if slot0.gameLoadDone and not slot0.openingLoadingView then
		slot0:onFinish()
	else
		if not slot0.gameLoadDone then
			YaXianGameController.instance:registerCallback(YaXianEvent.OnGameLoadDone, slot0.onGameLoadDone, slot0)
		end

		if slot0.openingLoadingView then
			ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0.onCloseViewFinish, slot0)
		end
	end
end

function slot0.onGameLoadDone(slot0)
	YaXianGameController.instance:unregisterCallback(YaXianEvent.OnGameLoadDone, slot0.onGameLoadDone, slot0)

	slot0.gameLoadDone = true

	slot0:checkCanStartFinishEvent()
end

function slot0.onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.LoadingView then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0.onCloseViewFinish, slot0)

		slot0.openingLoadingView = false

		slot0:checkCanStartFinishEvent()
	end
end

function slot0.checkCanStartFinishEvent(slot0)
	if slot0.gameLoadDone and not slot0.openingLoadingView then
		slot0:onFinish()
	end
end

function slot0.onFinish(slot0)
	if slot0.originData.preEvent and slot1.eventType == YaXianGameEnum.GameStateType.Battle then
		slot0:startFinishBattleAnimation(slot0.sendRequest, slot0)

		return
	end

	slot0:sendRequest()
end

function slot0.startFinishBattleAnimation(slot0, slot1, slot2)
	slot3, slot4 = nil

	if EnterActivityViewOnExitFightSceneHelper.recordMO.fightResult ~= FightEnum.FightResult.Succ then
		slot3 = YaXianGameController.instance:getInteractItem(slot0.originData.preEvent.interactId)
		slot4 = YaXianGameController.instance:getPlayerInteractItem()
	else
		slot3 = slot5
		slot4 = slot6
	end

	slot3:showEffect(YaXianGameEnum.EffectType.FightSuccess)
	slot4:showEffect(YaXianGameEnum.EffectType.Die, slot1, slot2)
end

function slot0.sendRequest(slot0)
	Activity115Rpc.instance:sendAct115EventEndRequest(YaXianGameEnum.ActivityId, slot0.onReceiveReply, slot0)
end

function slot0.onReceiveReply(slot0, slot1, slot2)
	if slot2 == 0 then
		YaXianGameController.instance:dispatchEvent(YaXianEvent.OnStateFinish, slot0.stateType)
	end

	UIBlockMgr.instance:endBlock(uv0.BLOCK_KEY)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function slot0.dispose(slot0)
	YaXianGameController.instance:unregisterCallback(YaXianEvent.OnGameLoadDone, slot0.onGameLoadDone, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0.onCloseViewFinish, slot0)
	uv0.super.dispose(slot0)
end

return slot0
