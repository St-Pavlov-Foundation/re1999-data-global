module("modules.logic.explore.map.unit.ExploreBaseLightUnit", package.seeall)

local var_0_0 = class("ExploreBaseLightUnit", ExploreBaseMoveUnit)

function var_0_0.initComponents(arg_1_0, ...)
	var_0_0.super.initComponents(arg_1_0, ...)
	arg_1_0:addComp("lightComp", ExploreUnitLightComp)
end

function var_0_0.onInFOVChange(arg_2_0, arg_2_1)
	if arg_2_1 then
		arg_2_0:setupRes()
		TaskDispatcher.cancelTask(arg_2_0._releaseDisplayGo, arg_2_0)
	else
		TaskDispatcher.runDelay(arg_2_0._releaseDisplayGo, arg_2_0, ExploreConstValue.CHECK_INTERVAL.UnitObjDestory)
	end
end

function var_0_0.setActiveAnim(arg_3_0, arg_3_1)
	if arg_3_1 then
		arg_3_0:playAnim(ExploreAnimEnum.AnimName.nToA)
	else
		arg_3_0:playAnim(ExploreAnimEnum.AnimName.aToN)
	end
end

function var_0_0.onActiveChange(arg_4_0, arg_4_1)
	return
end

function var_0_0.getIdleAnim(arg_5_0)
	if not arg_5_0.mo:isInteractEnabled() then
		return ExploreAnimEnum.AnimName.unable
	elseif not arg_5_0:haveLight() then
		return ExploreAnimEnum.AnimName.normal
	else
		return ExploreAnimEnum.AnimName.active
	end
end

return var_0_0
