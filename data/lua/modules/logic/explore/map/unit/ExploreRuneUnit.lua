module("modules.logic.explore.map.unit.ExploreRuneUnit", package.seeall)

slot0 = class("ExploreRuneUnit", ExploreBaseDisplayUnit)

function slot0.onInit(slot0)
end

function slot0.tryTrigger(slot0)
	slot0._triggerType = ExploreEnum.RuneTriggerType.None

	if ExploreBackpackModel.instance:getById(ExploreModel.instance:getUseItemUid()) and slot2.itemEffect == ExploreEnum.ItemEffect.Active then
		slot3 = slot0.mo:isInteractActiveState()

		if ExploreEnum.RuneStatus.Inactive ~= slot2.status or slot3 then
			if ExploreEnum.RuneStatus.Active == slot4 and slot3 then
				-- Nothing
			elseif ExploreEnum.RuneStatus.Inactive == slot4 and slot3 then
				slot0._triggerType = ExploreEnum.RuneTriggerType.ItemActive

				uv0.super.tryTrigger(slot0)
			elseif ExploreEnum.RuneStatus.Active == slot4 and slot3 == false then
				slot0._triggerType = ExploreEnum.RuneTriggerType.RuneActive

				uv0.super.tryTrigger(slot0)
			end
		end
	end
end

function slot0.canTrigger(slot0)
	if not uv0.super.canTrigger(slot0) then
		return false
	end

	if ExploreModel.instance:getStepPause() then
		return false
	end

	if ExploreBackpackModel.instance:getById(ExploreModel.instance:getUseItemUid()) and slot3.itemEffect == ExploreEnum.ItemEffect.Active then
		slot4 = slot0.mo:isInteractActiveState()

		if ExploreEnum.RuneStatus.Inactive == slot3.status and not slot4 or ExploreEnum.RuneStatus.Active == slot5 and slot4 then
			return false
		elseif ExploreEnum.RuneStatus.Inactive == slot5 and slot4 then
			return true
		elseif ExploreEnum.RuneStatus.Active == slot5 and slot4 == false then
			return true
		end
	end

	return false
end

function slot0.needInteractAnim(slot0)
	return true
end

function slot0.onTriggerDone(slot0)
	if slot0._triggerType == ExploreEnum.RuneTriggerType.ItemActive and slot0._displayTr and ExploreController.instance:getMapWhirl():getWhirl(ExploreEnum.WhirlType.Rune) then
		ExploreModel.instance:setStepPause(true)
		ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.Rune)
		slot1:flyToPos(true, slot0._whirlFlyBack, slot0)

		return
	end

	ExploreController.instance:getMap():getHero():setHeroStatus(ExploreAnimEnum.RoleAnimStatus.Interact, true, false)

	slot0._triggerType = nil
end

function slot0.playAnim(slot0, slot1)
	if slot1 == ExploreAnimEnum.AnimName.nToA and slot0._displayTr and ExploreController.instance:getMapWhirl():getWhirl(ExploreEnum.WhirlType.Rune) then
		ExploreModel.instance:setStepPause(true)
		ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.Rune)
		slot2:flyToPos(false, slot0._realPlayNToA, slot0)

		return
	end

	uv0.super.playAnim(slot0, slot1)
end

function slot0.getHeroDir(slot0)
	return ExploreController.instance:getMap():getHero().dir
end

function slot0.onAnimEnd(slot0, slot1, slot2)
	if slot1 == ExploreAnimEnum.AnimName.nToA or slot1 == ExploreAnimEnum.AnimName.aToN then
		slot0.mo:checkActiveCount()
	end
end

function slot0._whirlFlyBack(slot0)
	if ExploreController.instance:getMapWhirl():getWhirl(ExploreEnum.WhirlType.Rune) then
		slot1:flyBack()
	end
end

function slot0._realPlayNToA(slot0)
	uv0.super.playAnim(slot0, ExploreAnimEnum.AnimName.nToA)
end

return slot0
