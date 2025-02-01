module("modules.logic.guide.controller.action.impl.WaitGuideActionFightDragCard", package.seeall)

slot0 = class("WaitGuideActionFightDragCard", BaseGuideAction)

function slot0.onStart(slot0, slot1)
	uv0.super.onStart(slot0, slot1)

	slot2 = string.splitToNumber(slot0.actionParam, "#")
	slot3 = slot2[1]
	slot4 = {}

	for slot8 = 2, #slot2 do
		table.insert(slot4, slot2[slot8])
	end

	GuideViewMgr.instance:enableDrag(true)
	GuideModel.instance:setFlag(GuideModel.GuideFlag.FightMoveCard, {
		from = slot3,
		tos = slot4
	}, slot0.guideId)
	FightController.instance:registerCallback(FightEvent.OnGuideDragCard, slot0._onGuideDragCard, slot0)
end

function slot0._onGuideDragCard(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnGuideDragCard, slot0._onGuideDragCard, slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	GuideViewMgr.instance:enableDrag(false)
	GuideModel.instance:setFlag(GuideModel.GuideFlag.FightMoveCard, nil, slot0.guideId)
	FightController.instance:unregisterCallback(FightEvent.OnGuideDragCard, slot0._onGuideDragCard, slot0)
end

return slot0
