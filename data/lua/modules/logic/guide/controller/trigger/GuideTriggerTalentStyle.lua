module("modules.logic.guide.controller.trigger.GuideTriggerTalentStyle", package.seeall)

slot0 = class("GuideTriggerTalentStyle", BaseGuideTrigger)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	CharacterController.instance:registerCallback(CharacterEvent.onReturnTalentView, slot0._onReturnTalentView, slot0)
end

function slot0.assertGuideSatisfy(slot0, slot1, slot2)
	if not slot1 then
		return false
	end

	return tonumber(slot2) <= slot1
end

function slot0._checkStartGuide(slot0, slot1)
	if HeroModel.instance:getByHeroId(slot1) then
		slot0:checkStartGuide(slot2.talent)
	end
end

function slot0._onOpenView(slot0, slot1, slot2)
	if slot1 == ViewName.CharacterTalentView then
		slot0:_checkStartGuide(slot2.heroid)
	end
end

function slot0._onReturnTalentView(slot0, slot1)
	slot0:_checkStartGuide(slot1)
end

return slot0
