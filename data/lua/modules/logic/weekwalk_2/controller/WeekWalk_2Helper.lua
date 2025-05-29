module("modules.logic.weekwalk_2.controller.WeekWalk_2Helper", package.seeall)

local var_0_0 = class("WeekWalk_2Helper")

function var_0_0.setCupIcon(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1 and arg_1_1.result or 0

	UISpriteSetMgr.instance:setWeekWalkSprite(arg_1_0, "weekwalkheart_star" .. var_1_0)
end

function var_0_0.setCupEffect(arg_2_0, arg_2_1)
	if not arg_2_0 then
		return
	end

	local var_2_0 = arg_2_1 and arg_2_1.result or WeekWalk_2Enum.CupType.None

	var_0_0.setCupEffectByResult(arg_2_0, var_2_0)
end

function var_0_0.setCupEffectByResult(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0.transform
	local var_3_1 = var_3_0.childCount
	local var_3_2 = "star0" .. arg_3_1

	for iter_3_0 = 1, var_3_1 do
		local var_3_3 = var_3_0:GetChild(iter_3_0 - 1)

		gohelper.setActive(var_3_3, var_3_3.name == var_3_2)
	end
end

return var_0_0
