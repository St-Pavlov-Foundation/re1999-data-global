module("modules.logic.explore.map.unit.ExploreSequenceCountUnit", package.seeall)

slot0 = class("ExploreSequenceCountUnit", ExploreBaseDisplayUnit)

function slot0.onTrigger(slot0)
	if slot0.mo:isInteractEnabled() == false then
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

function slot0.onAnimEnd(slot0, slot1, slot2)
	if slot2 == ExploreAnimEnum.AnimName.active then
		ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.UnitIdLock + slot0.id)

		if slot0.mo:isInteractActiveState() then
			ExploreStepController.instance:insertClientStep({
				stepType = ExploreEnum.StepType.CheckCounter,
				id = slot0.id
			}, 1)
			slot0:tryTrigger()
			ExploreStepController.instance:startStep()
		else
			slot0:playAnim(ExploreAnimEnum.AnimName.aToN)
		end

		ExploreModel.instance:setStepPause(false)
	end

	uv0.super.onAnimEnd(slot0, slot1, slot2)
end

return slot0
