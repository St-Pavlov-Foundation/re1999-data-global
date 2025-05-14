module("modules.logic.explore.map.unit.ExploreDoorOnceUnit", package.seeall)

local var_0_0 = class("ExploreDoorOnceUnit", ExploreDoor)

function var_0_0.tryTrigger(arg_1_0, ...)
	if not arg_1_0.mo:isInteractActiveState() then
		var_0_0.super.tryTrigger(arg_1_0, ...)
	end
end

function var_0_0.cancelTrigger(arg_2_0, ...)
	if not arg_2_0.mo:isInteractActiveState() then
		var_0_0.super.cancelTrigger(arg_2_0, ...)
	end
end

function var_0_0.getIdleAnim(arg_3_0)
	if arg_3_0.mo:isInteractActiveState() then
		return ExploreAnimEnum.AnimName.active
	else
		return var_0_0.super.getIdleAnim(arg_3_0)
	end
end

function var_0_0.onUpdateCount(arg_4_0, ...)
	if arg_4_0.mo:isInteractActiveState() then
		if arg_4_0.animComp._curAnim ~= ExploreAnimEnum.AnimName.nToA then
			arg_4_0:playAnim(ExploreAnimEnum.AnimName.active)
		end
	else
		var_0_0.super.onUpdateCount(arg_4_0, ...)
	end
end

function var_0_0.onActiveChange(arg_5_0, arg_5_1)
	if arg_5_1 then
		local var_5_0 = arg_5_0.animComp._curAnim

		if var_5_0 and var_5_0 ~= ExploreAnimEnum.AnimName.active and arg_5_0.animComp:isIdleAnim() then
			arg_5_0:playAnim(ExploreAnimEnum.AnimName.nToA)
			arg_5_0:checkShowIcon()

			return
		end
	end

	var_0_0.super.onActiveChange(arg_5_0, arg_5_1)
end

return var_0_0
