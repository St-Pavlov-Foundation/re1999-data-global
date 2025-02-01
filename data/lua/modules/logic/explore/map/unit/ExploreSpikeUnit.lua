module("modules.logic.explore.map.unit.ExploreSpikeUnit", package.seeall)

slot0 = class("ExploreSpikeUnit", ExploreBaseDisplayUnit)

function slot0.onResLoaded(slot0)
	slot0:beginTriggerSpike()
	gohelper.addAkGameObject(slot0.go)
end

function slot0.beginTriggerSpike(slot0)
	slot0:setInteractActive(false)
	slot0.animComp:playAnim(ExploreAnimEnum.AnimName.normal)
	slot0:setSpikeActive(false)
	TaskDispatcher.runDelay(slot0.activeSpike, slot0, slot0.mo.intervalTime)
end

function slot0.activeSpike(slot0)
	slot0:beginAudio()
	slot0:setSpikeActive(true)
	slot0:setInteractActive(true)
end

function slot0.inactiveSpike(slot0)
	slot0:beginAudio()
	slot0:setSpikeActive(true)
	slot0:setInteractActive(false)
end

function slot0.isInFOV(slot0)
	return true
end

function slot0.setInFOV(slot0)
end

function slot0.onAnimEnd(slot0, slot1, slot2)
	slot0:stopAudio()

	if slot2 == ExploreAnimEnum.AnimName.normal then
		slot0:setSpikeActive(false)
		TaskDispatcher.runDelay(slot0.activeSpike, slot0, slot0.mo.intervalTime)
	elseif slot2 == ExploreAnimEnum.AnimName.active then
		slot0:setSpikeActive(true)
		TaskDispatcher.runDelay(slot0.inactiveSpike, slot0, slot0.mo.keepTime)
	end
end

function slot0.setSpikeActive(slot0, slot1)
	slot0._spikeAcitve = slot1

	if slot1 and slot0.roleStay then
		TaskDispatcher.runDelay(slot0.delayCheckCanTrigger, slot0, 0.3)
	end
end

function slot0.onRoleEnter(slot0, slot1, slot2, slot3)
	if slot3:isRole() then
		slot0.roleStay = true

		if slot0._spikeAcitve then
			TaskDispatcher.runDelay(slot0.delayCheckCanTrigger, slot0, 0.3)
		end
	end
end

function slot0.onRoleLeave(slot0, slot1, slot2, slot3)
	if slot3:isRole() then
		slot0.roleStay = false

		TaskDispatcher.cancelTask(slot0.delayCheckCanTrigger, slot0)
	end
end

function slot0.delayCheckCanTrigger(slot0)
	if slot0._spikeAcitve and slot0.roleStay then
		slot0:tryTrigger()
	end
end

function slot0.tryTrigger(slot0, ...)
	if not slot0._spikeAcitve then
		return
	end

	ExploreController.instance:getMap():getHero():stopMoving(true)
	ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.Spike)
	uv0.super.tryTrigger(slot0, ...)
end

function slot0.beginAudio(slot0)
	if not slot0.mo.playAudio then
		return
	end

	if ExploreConstValue.TrapAudioMaxDis < ExploreHelper.getDistance(ExploreController.instance:getMap():getHero().nodePos, slot0.nodePos) then
		return
	end

	if not slot0._playingAudio then
		AudioMgr.instance:trigger(AudioEnum.Explore.TrapStart, slot0.go)

		slot0._playingAudio = true
	end
end

function slot0.stopAudio(slot0)
	if slot0._playingAudio then
		AudioMgr.instance:trigger(AudioEnum.Explore.TrapEnd, slot0.go)

		slot0._playingAudio = false
	end
end

function slot0.pauseTriggerSpike(slot0)
	slot0.roleStay = false
	slot0._spikeAcitve = false

	slot0.animComp:playAnim(ExploreAnimEnum.AnimName.active)
	TaskDispatcher.cancelTask(slot0.activeSpike, slot0)
	TaskDispatcher.cancelTask(slot0.inactiveSpike, slot0)
	TaskDispatcher.cancelTask(slot0.delayCheckCanTrigger, slot0)
end

function slot0.onDestroy(slot0)
	slot0:stopAudio()
	TaskDispatcher.cancelTask(slot0.activeSpike, slot0)
	TaskDispatcher.cancelTask(slot0.inactiveSpike, slot0)
	TaskDispatcher.cancelTask(slot0.delayCheckCanTrigger, slot0)
	uv0.super.onDestroy(slot0)
end

return slot0
