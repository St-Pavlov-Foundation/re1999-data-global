module("modules.logic.explore.map.unit.ExploreStepOnceUnit", package.seeall)

slot0 = class("ExploreStepOnceUnit", ExploreBaseDisplayUnit)

function slot0.onInit(slot0)
end

function slot0.onRoleEnter(slot0, slot1, slot2, slot3)
	if not slot2 then
		return
	end

	slot0._isRoleEnter = true

	if not slot0:canTrigger() then
		return
	end

	if not slot3:isRole() and not slot3.mo.canTriggerGear then
		return
	end

	if slot0.mo:isInteractActiveState() == false then
		ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.UnitIdLock + slot0.id)
		ExploreController.instance:getMap():getHero():stopMoving()
		ExploreModel.instance:setStepPause(true)
		slot0:playAnim(ExploreAnimEnum.AnimName.nToA)
		slot0:setInteractActive(true)
	end
end

function slot0.onRoleLeave(slot0)
	slot0._isRoleEnter = false

	uv0.super.onRoleLeave(slot0)
end

function slot0.needUpdateHeroPos(slot0)
	return slot0._isRoleEnter and (slot0.animComp._curAnim == ExploreAnimEnum.AnimName.nToA or slot0.animComp._curAnim == ExploreAnimEnum.AnimName.aToN)
end

function slot0.onAnimEnd(slot0, slot1, slot2)
	if slot2 == ExploreAnimEnum.AnimName.active or slot2 == ExploreAnimEnum.AnimName.normal then
		ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.UnitIdLock + slot0.id)

		slot3 = {
			stepType = ExploreEnum.StepType.CheckCounter,
			id = slot0.id
		}

		ExploreStepController.instance:insertClientStep(slot3, 1)
		ExploreStepController.instance:insertClientStep(slot3)

		if slot0.mo:isInteractActiveState() then
			slot0:tryTrigger()
		end

		ExploreStepController.instance:startStep()
		ExploreModel.instance:setStepPause(false)
	end

	uv0.super.onAnimEnd(slot0, slot1, slot2)
end

function slot0.canTrigger(slot0)
	if slot0.mo:isInteractActiveState() then
		return false
	end

	return uv0.super.canTrigger(slot0)
end

return slot0
