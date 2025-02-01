module("modules.logic.versionactivity1_2.yaxian.controller.game.work.YaXianInteractEffectWork", package.seeall)

slot0 = class("YaXianInteractEffectWork", BaseWork)

function slot0.ctor(slot0, slot1, slot2)
	slot0.interactItem = YaXianGameController.instance:getInteractItem(slot1)
	slot0.effectType = slot2
end

function slot0.onStart(slot0)
	slot0.interactItem:showEffect(slot0.effectType, slot0.effectDoneCallback, slot0)
end

function slot0.effectDoneCallback(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	slot0.interactItem:cancelEffectTask()
end

return slot0
