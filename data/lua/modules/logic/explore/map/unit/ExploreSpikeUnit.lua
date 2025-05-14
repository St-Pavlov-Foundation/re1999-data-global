module("modules.logic.explore.map.unit.ExploreSpikeUnit", package.seeall)

local var_0_0 = class("ExploreSpikeUnit", ExploreBaseDisplayUnit)

function var_0_0.onResLoaded(arg_1_0)
	arg_1_0:beginTriggerSpike()
	gohelper.addAkGameObject(arg_1_0.go)
end

function var_0_0.beginTriggerSpike(arg_2_0)
	arg_2_0:setInteractActive(false)
	arg_2_0.animComp:playAnim(ExploreAnimEnum.AnimName.normal)
	arg_2_0:setSpikeActive(false)
	TaskDispatcher.runDelay(arg_2_0.activeSpike, arg_2_0, arg_2_0.mo.intervalTime)
end

function var_0_0.activeSpike(arg_3_0)
	arg_3_0:beginAudio()
	arg_3_0:setSpikeActive(true)
	arg_3_0:setInteractActive(true)
end

function var_0_0.inactiveSpike(arg_4_0)
	arg_4_0:beginAudio()
	arg_4_0:setSpikeActive(true)
	arg_4_0:setInteractActive(false)
end

function var_0_0.isInFOV(arg_5_0)
	return true
end

function var_0_0.setInFOV(arg_6_0)
	return
end

function var_0_0.onAnimEnd(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0:stopAudio()

	if arg_7_2 == ExploreAnimEnum.AnimName.normal then
		arg_7_0:setSpikeActive(false)
		TaskDispatcher.runDelay(arg_7_0.activeSpike, arg_7_0, arg_7_0.mo.intervalTime)
	elseif arg_7_2 == ExploreAnimEnum.AnimName.active then
		arg_7_0:setSpikeActive(true)
		TaskDispatcher.runDelay(arg_7_0.inactiveSpike, arg_7_0, arg_7_0.mo.keepTime)
	end
end

function var_0_0.setSpikeActive(arg_8_0, arg_8_1)
	arg_8_0._spikeAcitve = arg_8_1

	if arg_8_1 and arg_8_0.roleStay then
		TaskDispatcher.runDelay(arg_8_0.delayCheckCanTrigger, arg_8_0, 0.3)
	end
end

function var_0_0.onRoleEnter(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_3:isRole() then
		arg_9_0.roleStay = true

		if arg_9_0._spikeAcitve then
			TaskDispatcher.runDelay(arg_9_0.delayCheckCanTrigger, arg_9_0, 0.3)
		end
	end
end

function var_0_0.onRoleLeave(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_3:isRole() then
		arg_10_0.roleStay = false

		TaskDispatcher.cancelTask(arg_10_0.delayCheckCanTrigger, arg_10_0)
	end
end

function var_0_0.delayCheckCanTrigger(arg_11_0)
	if arg_11_0._spikeAcitve and arg_11_0.roleStay then
		arg_11_0:tryTrigger()
	end
end

function var_0_0.tryTrigger(arg_12_0, ...)
	if not arg_12_0._spikeAcitve then
		return
	end

	ExploreController.instance:getMap():getHero():stopMoving(true)
	ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.Spike)
	var_0_0.super.tryTrigger(arg_12_0, ...)
end

function var_0_0.beginAudio(arg_13_0)
	if not arg_13_0.mo.playAudio then
		return
	end

	local var_13_0 = ExploreController.instance:getMap():getHero()

	if ExploreHelper.getDistance(var_13_0.nodePos, arg_13_0.nodePos) > ExploreConstValue.TrapAudioMaxDis then
		return
	end

	if not arg_13_0._playingAudio then
		AudioMgr.instance:trigger(AudioEnum.Explore.TrapStart, arg_13_0.go)

		arg_13_0._playingAudio = true
	end
end

function var_0_0.stopAudio(arg_14_0)
	if arg_14_0._playingAudio then
		AudioMgr.instance:trigger(AudioEnum.Explore.TrapEnd, arg_14_0.go)

		arg_14_0._playingAudio = false
	end
end

function var_0_0.pauseTriggerSpike(arg_15_0)
	arg_15_0.roleStay = false
	arg_15_0._spikeAcitve = false

	arg_15_0.animComp:playAnim(ExploreAnimEnum.AnimName.active)
	TaskDispatcher.cancelTask(arg_15_0.activeSpike, arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0.inactiveSpike, arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0.delayCheckCanTrigger, arg_15_0)
end

function var_0_0.onDestroy(arg_16_0)
	arg_16_0:stopAudio()
	TaskDispatcher.cancelTask(arg_16_0.activeSpike, arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0.inactiveSpike, arg_16_0)
	TaskDispatcher.cancelTask(arg_16_0.delayCheckCanTrigger, arg_16_0)
	var_0_0.super.onDestroy(arg_16_0)
end

return var_0_0
