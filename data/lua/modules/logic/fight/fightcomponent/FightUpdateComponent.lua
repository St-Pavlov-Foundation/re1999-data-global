module("modules.logic.fight.fightcomponent.FightUpdateComponent", package.seeall)

local var_0_0 = class("FightUpdateComponent", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0._updateItemList = {}
end

function var_0_0.registUpdate(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = FightUpdateMgr.registUpdate(arg_2_1, arg_2_2, arg_2_3)

	table.insert(arg_2_0._updateItemList, var_2_0)

	return var_2_0
end

function var_0_0.cancelUpdate(arg_3_0, arg_3_1)
	return FightUpdateMgr.cancelUpdate(arg_3_1)
end

function var_0_0.onDestructor(arg_4_0)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0._updateItemList) do
		iter_4_1.isDone = true
	end
end

return var_0_0
