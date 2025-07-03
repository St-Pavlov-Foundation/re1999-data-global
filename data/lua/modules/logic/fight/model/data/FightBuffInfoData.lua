module("modules.logic.fight.model.data.FightBuffInfoData", package.seeall)

local var_0_0 = FightDataClass("FightBuffInfoData")

function var_0_0.onConstructor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.time = tonumber(arg_1_1.uid)
	arg_1_0.entityId = arg_1_2
	arg_1_0.buffId = arg_1_1.buffId
	arg_1_0.duration = arg_1_1.duration
	arg_1_0.uid = arg_1_1.uid
	arg_1_0.exInfo = arg_1_1.exInfo
	arg_1_0.fromUid = arg_1_1.fromUid
	arg_1_0.count = arg_1_1.count
	arg_1_0.actCommonParams = arg_1_1.actCommonParams
	arg_1_0.layer = arg_1_1.layer
	arg_1_0.type = arg_1_1.type

	local var_1_0 = arg_1_0:getCO()

	if not var_1_0 then
		logError("buff表找不到id:" .. arg_1_0.buffId)
	end

	arg_1_0.name = var_1_0 and var_1_0.name or ""
	arg_1_0.clientNum = 0
end

function var_0_0.clone(arg_2_0)
	local var_2_0 = var_0_0.New(arg_2_0)

	var_2_0.clientNum = arg_2_0.clientNum
	arg_2_0._last_clone_mo = var_2_0

	return var_2_0
end

function var_0_0.getCO(arg_3_0)
	return lua_skill_buff.configDict[arg_3_0.buffId]
end

function var_0_0.setClientNum(arg_4_0, arg_4_1)
	arg_4_0.clientNum = arg_4_1
end

return var_0_0
