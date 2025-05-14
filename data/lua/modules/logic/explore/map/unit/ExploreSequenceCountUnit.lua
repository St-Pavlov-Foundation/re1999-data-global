module("modules.logic.explore.map.unit.ExploreSequenceCountUnit", package.seeall)

local var_0_0 = class("ExploreSequenceCountUnit", ExploreBaseDisplayUnit)

function var_0_0.onTrigger(arg_1_0)
	if arg_1_0.mo:isInteractEnabled() == false then
		return
	end

	if arg_1_0.mo:isInteractActiveState() == false then
		ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.UnitIdLock + arg_1_0.id)
		ExploreController.instance:getMap():getHero():stopMoving()
		ExploreModel.instance:setStepPause(true)
		arg_1_0:playAnim(ExploreAnimEnum.AnimName.nToA)
		arg_1_0:setInteractActive(true)
	end
end

function var_0_0.onAnimEnd(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_2 == ExploreAnimEnum.AnimName.active then
		ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.UnitIdLock + arg_2_0.id)

		if arg_2_0.mo:isInteractActiveState() then
			local var_2_0 = {
				stepType = ExploreEnum.StepType.CheckCounter,
				id = arg_2_0.id
			}

			ExploreStepController.instance:insertClientStep(var_2_0, 1)
			arg_2_0:tryTrigger()
			ExploreStepController.instance:startStep()
		else
			arg_2_0:playAnim(ExploreAnimEnum.AnimName.aToN)
		end

		ExploreModel.instance:setStepPause(false)
	end

	var_0_0.super.onAnimEnd(arg_2_0, arg_2_1, arg_2_2)
end

return var_0_0
