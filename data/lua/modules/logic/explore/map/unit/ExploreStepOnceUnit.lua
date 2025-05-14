module("modules.logic.explore.map.unit.ExploreStepOnceUnit", package.seeall)

local var_0_0 = class("ExploreStepOnceUnit", ExploreBaseDisplayUnit)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.onRoleEnter(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	if not arg_2_2 then
		return
	end

	arg_2_0._isRoleEnter = true

	if not arg_2_0:canTrigger() then
		return
	end

	if not arg_2_3:isRole() and not arg_2_3.mo.canTriggerGear then
		return
	end

	if arg_2_0.mo:isInteractActiveState() == false then
		ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.UnitIdLock + arg_2_0.id)
		ExploreController.instance:getMap():getHero():stopMoving()
		ExploreModel.instance:setStepPause(true)
		arg_2_0:playAnim(ExploreAnimEnum.AnimName.nToA)
		arg_2_0:setInteractActive(true)
	end
end

function var_0_0.onRoleLeave(arg_3_0)
	arg_3_0._isRoleEnter = false

	var_0_0.super.onRoleLeave(arg_3_0)
end

function var_0_0.needUpdateHeroPos(arg_4_0)
	return arg_4_0._isRoleEnter and (arg_4_0.animComp._curAnim == ExploreAnimEnum.AnimName.nToA or arg_4_0.animComp._curAnim == ExploreAnimEnum.AnimName.aToN)
end

function var_0_0.onAnimEnd(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_2 == ExploreAnimEnum.AnimName.active or arg_5_2 == ExploreAnimEnum.AnimName.normal then
		ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.UnitIdLock + arg_5_0.id)

		local var_5_0 = {
			stepType = ExploreEnum.StepType.CheckCounter,
			id = arg_5_0.id
		}

		ExploreStepController.instance:insertClientStep(var_5_0, 1)
		ExploreStepController.instance:insertClientStep(var_5_0)

		if arg_5_0.mo:isInteractActiveState() then
			arg_5_0:tryTrigger()
		end

		ExploreStepController.instance:startStep()
		ExploreModel.instance:setStepPause(false)
	end

	var_0_0.super.onAnimEnd(arg_5_0, arg_5_1, arg_5_2)
end

function var_0_0.canTrigger(arg_6_0)
	if arg_6_0.mo:isInteractActiveState() then
		return false
	end

	return var_0_0.super.canTrigger(arg_6_0)
end

return var_0_0
