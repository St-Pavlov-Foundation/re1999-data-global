module("modules.logic.fight.fightcomponent.FightClickComponent", package.seeall)

local var_0_0 = class("FightClickComponent", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0._clickDic = {}
end

function var_0_0.registClick(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = arg_2_1:GetInstanceID()

	arg_2_0._clickDic[var_2_0] = arg_2_1

	arg_2_1:AddClickListener(arg_2_2, arg_2_3, arg_2_4)
end

function var_0_0.removeClick(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:GetInstanceID()

	if arg_3_0._clickDic[var_3_0] then
		arg_3_0._clickDic[var_3_0]:RemoveClickListener()

		arg_3_0._clickDic[var_3_0] = nil
	end
end

function var_0_0.onDestructor(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0._clickDic) do
		iter_4_1:RemoveClickListener()
	end
end

return var_0_0
