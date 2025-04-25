module("modules.logic.guide.controller.trigger.GuideTriggerDestinyStone", package.seeall)

slot0 = class("GuideTriggerDestinyStone", BaseGuideTrigger)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	CharacterDestinyController.instance:registerCallback(CharacterDestinyEvent.OnUnlockSlot, slot0._OnUnlockSlot, slot0)
	CharacterDestinyController.instance:registerCallback(CharacterDestinyEvent.OnUseStoneReply, slot0._OnUseStone, slot0)
	CharacterController.instance:registerCallback(CharacterEvent.successHeroRankUp, slot0._characterLevelUp, slot0)
	CharacterController.instance:registerCallback(CharacterEvent.successHeroLevelUp, slot0._characterLevelUp, slot0)
end

function slot0.assertGuideSatisfy(slot0, slot1, slot2)
	if slot1 == tonumber(slot2) then
		return true
	end
end

function slot0._characterLevelUp(slot0)
	if slot0.heroMo and slot0.heroMo:isOwnHero() and slot0.heroMo:isCanOpenDestinySystem() then
		slot0:checkStartGuide(23301)
	end
end

function slot0._onOpenView(slot0, slot1, slot2)
	if slot1 == ViewName.CharacterView then
		if slot2 and slot3:isOwnHero() and slot3:isCanOpenDestinySystem() then
			slot0:checkStartGuide(23301)
		end

		slot0.heroMo = slot3
	end

	if slot1 == ViewName.CharacterDestinySlotView and slot2.heroMo and slot3:isOwnHero() then
		if slot3.destinyStoneMo:isUnlockSlot() then
			slot0:checkStartGuide(23302)
		end

		if slot3.destinyStoneMo.curUseStoneId ~= 0 then
			slot0:checkStartGuide(23303)
		end
	end
end

function slot0._OnUnlockSlot(slot0)
	slot0:checkStartGuide(23302)
end

function slot0._OnUseStone(slot0, slot1, slot2)
	slot0:checkStartGuide(23303)
end

return slot0
