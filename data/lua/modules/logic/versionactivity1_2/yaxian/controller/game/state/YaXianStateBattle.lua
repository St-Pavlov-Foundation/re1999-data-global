module("modules.logic.versionactivity1_2.yaxian.controller.game.state.YaXianStateBattle", package.seeall)

slot0 = class("YaXianStateBattle", YaXianStateBase)

function slot0.start(slot0)
	slot0.stateType = YaXianGameEnum.GameStateType.Battle

	logNormal("YaXianStateBattle start")

	if YaXianGameModel.instance:gameIsLoadDone() then
		slot0:startBattle()
	else
		YaXianGameController.instance:registerCallback(YaXianEvent.OnGameLoadDone, slot0.onGameLoadDone, slot0)
	end
end

function slot0.onGameLoadDone(slot0)
	YaXianGameController.instance:unregisterCallback(YaXianEvent.OnGameLoadDone, slot0.onGameLoadDone, slot0)
	slot0:startBattle()
end

function slot0.startBattle(slot0)
	slot0.playerInteractItem = YaXianGameController.instance:getPlayerInteractItem()
	slot0.enemyInteractItem = YaXianGameController.instance:getInteractItem(slot0.originData.interactId)

	AudioMgr.instance:trigger(AudioEnum.YaXian.Fight)
	slot0.playerInteractItem:showEffect(YaXianGameEnum.EffectType.Fight)
	slot0.enemyInteractItem:showEffect(YaXianGameEnum.EffectType.Fight, slot0.openTipView, slot0)
end

function slot0.openTipView(slot0)
	ViewMgr.instance:openView(ViewName.YaXianGameTipView, {
		interactId = slot0.originData.interactId
	})
end

function slot0.dispose(slot0)
	YaXianGameController.instance:unregisterCallback(YaXianEvent.OnGameLoadDone, slot0.onGameLoadDone, slot0)
	slot0.playerInteractItem:cancelEffectTask()
	slot0.enemyInteractItem:cancelEffectTask()
	uv0.super.dispose(slot0)
end

return slot0
