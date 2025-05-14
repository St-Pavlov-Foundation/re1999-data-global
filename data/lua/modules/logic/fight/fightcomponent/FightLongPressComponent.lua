module("modules.logic.fight.fightcomponent.FightLongPressComponent", package.seeall)

local var_0_0 = class("FightLongPressComponent", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0._longPressArr = {
		0.5,
		99999
	}
	arg_1_0._pressDic = {}
end

function var_0_0.registLongPress(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = arg_2_1:GetInstanceID()

	arg_2_0._pressDic[var_2_0] = arg_2_1

	arg_2_1:SetLongPressTime(arg_2_0._longPressArr)
	arg_2_1:AddLongPressListener(arg_2_2, arg_2_3, arg_2_4)
end

function var_0_0.registHover(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = arg_3_1:GetInstanceID()

	arg_3_0._pressDic[var_3_0] = arg_3_1

	arg_3_1:AddHoverListener(arg_3_2, arg_3_3)
end

function var_0_0.removeLongPress(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:GetInstanceID()

	if arg_4_0._pressDic[var_4_0] then
		arg_4_0._pressDic[var_4_0]:RemoveLongPressListener()
	end
end

function var_0_0.removeHover(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:GetInstanceID()

	if arg_5_0._pressDic[var_5_0] then
		arg_5_0._pressDic[var_5_0]:RemoveHoverListener()
	end
end

function var_0_0.onDestructor(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0._pressDic) do
		iter_6_1:RemoveLongPressListener()
		iter_6_1:RemoveHoverListener()
	end
end

return var_0_0
