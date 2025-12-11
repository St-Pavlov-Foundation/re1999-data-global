module("modules.logic.fight.entity.FightEntityBuffMgr", package.seeall)

local var_0_0 = class("FightEntityBuffMgr", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.buffDic = {}
end

function var_0_0.addBuff(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.uid

	if arg_2_0.buffDic[var_2_0] then
		return
	end

	arg_2_0.buffDic[var_2_0] = arg_2_0:newClass(FightEntityBuffObject, arg_2_1)

	arg_2_0.buffDic[var_2_0]:onAddBuff()
end

function var_0_0.removeBuff(arg_3_0, arg_3_1)
	if not arg_3_0.buffDic[arg_3_1] then
		return
	end

	arg_3_0.buffDic[arg_3_1]:onRemoveBuff(arg_3_1)
	arg_3_0.buffDic[arg_3_1]:disposeSelf()

	arg_3_0.buffDic[arg_3_1] = nil
end

function var_0_0.updateBuff(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.uid

	if not arg_4_0.buffDic[var_4_0] then
		return
	end

	arg_4_0.buffDic[var_4_0]:onUpdateBuff(var_4_0, arg_4_1)
end

function var_0_0.onDestructor(arg_5_0)
	return
end

return var_0_0
