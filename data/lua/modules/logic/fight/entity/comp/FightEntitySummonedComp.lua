module("modules.logic.fight.entity.comp.FightEntitySummonedComp", package.seeall)

local var_0_0 = class("FightEntitySummonedComp", FightBaseClass)

function var_0_0.onLogicEnter(arg_1_0, arg_1_1)
	arg_1_0._entity = arg_1_1

	arg_1_0:com_registFightEvent(FightEvent.SummonedAdd, arg_1_0._onSummonedAdd)
	arg_1_0:_refreshSummoned()
end

function var_0_0._refreshSummoned(arg_2_0)
	local var_2_0 = arg_2_0._entity:getMO():getSummonedInfo():getDataDic()

	for iter_2_0, iter_2_1 in pairs(var_2_0) do
		arg_2_0:_instantiateSummoned(iter_2_1)
	end
end

function var_0_0._instantiateSummoned(arg_3_0, arg_3_1)
	local var_3_0 = "FightEntitySummonedItem" .. arg_3_1.summonedId

	if _G[var_3_0] then
		arg_3_0:newClass(_G[var_3_0], arg_3_0._entity, arg_3_1)
	else
		arg_3_0:newClass(FightEntitySummonedItem, arg_3_0._entity, arg_3_1)
	end
end

function var_0_0._onSummonedAdd(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1 ~= arg_4_0._entity.id then
		return
	end

	arg_4_0:_instantiateSummoned(arg_4_2)
end

function var_0_0.onLogicExit(arg_5_0)
	return
end

return var_0_0
