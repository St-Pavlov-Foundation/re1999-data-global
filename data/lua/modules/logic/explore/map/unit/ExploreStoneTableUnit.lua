module("modules.logic.explore.map.unit.ExploreStoneTableUnit", package.seeall)

local var_0_0 = class("ExploreStoneTableUnit", ExploreBaseMoveUnit)

function var_0_0.getIdleAnim(arg_1_0)
	local var_1_0 = var_0_0.super.getIdleAnim(arg_1_0)

	if var_1_0 == ExploreAnimEnum.AnimName.active then
		if arg_1_0.mo:getInteractInfoMO().statusInfo.status ~= 1 then
			var_1_0 = ExploreAnimEnum.AnimName.active
		else
			var_1_0 = ExploreAnimEnum.AnimName.active2
		end
	end

	return var_1_0
end

function var_0_0.canTrigger(arg_2_0)
	if arg_2_0.mo:isInteractActiveState() and arg_2_0.mo:getInteractInfoMO().statusInfo.status ~= 1 then
		return false
	end

	return var_0_0.super.canTrigger(arg_2_0)
end

function var_0_0.tryTrigger(arg_3_0, arg_3_1)
	if ExploreStepController.instance:getCurStepType() == ExploreEnum.StepType.DelUnit then
		return
	end

	return var_0_0.super.tryTrigger(arg_3_0, arg_3_1)
end

function var_0_0.needInteractAnim(arg_4_0)
	return true
end

function var_0_0.onStatus2Change(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0.animComp:isIdleAnim() then
		arg_5_0.animComp:playIdleAnim()
	end
end

return var_0_0
