module("modules.logic.guide.controller.action.impl.WaitGuideActionUseActPoint", package.seeall)

slot0 = class("WaitGuideActionUseActPoint", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)
	FightController.instance:registerCallback(FightEvent.OnMoveHandCard, slot0._OnMoveHandCard, slot0)
	FightController.instance:registerCallback(FightEvent.OnPlayHandCard, slot0._OnPlayHandCard, slot0)
end

function slot0._OnPlayHandCard(slot0)
	slot0:onDone(true)
end

function slot0._OnMoveHandCard(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnMoveHandCard, slot0._OnMoveHandCard, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnPlayHandCard, slot0._OnPlayHandCard, slot0)
end

return slot0
