module("modules.logic.fight.model.mo.FightBuffMO", package.seeall)

local var_0_0 = pureTable("FightBuffMO")

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.time = tonumber(arg_2_1.uid)
	arg_2_0.entityId = arg_2_2
	arg_2_0.id = arg_2_1.uid
	arg_2_0.uid = arg_2_1.uid
	arg_2_0.buffId = arg_2_1.buffId
	arg_2_0.duration = arg_2_1.duration
	arg_2_0.exInfo = arg_2_1.exInfo
	arg_2_0.fromUid = arg_2_1.fromUid
	arg_2_0.count = arg_2_1.count

	local var_2_0 = arg_2_0:getCO()

	if not var_2_0 then
		logError("buff表找不到id:" .. arg_2_0.buffId)
	end

	arg_2_0.name = var_2_0 and var_2_0.name or ""
	arg_2_0.actCommonParams = arg_2_1.actCommonParams or ""
	arg_2_0.layer = arg_2_1.layer or 0
	arg_2_0.type = arg_2_1.type or FightEnum.BuffType.Normal
	arg_2_0.actInfo = {}

	local var_2_1 = arg_2_1.actInfo

	if var_2_1 then
		for iter_2_0 = 1, #var_2_1 do
			arg_2_0.actInfo[iter_2_0] = FightBuffActInfoData.New(var_2_1[iter_2_0])
		end
	end

	arg_2_0.clientNum = 0
end

function var_0_0.clone(arg_3_0)
	local var_3_0 = var_0_0.New()

	var_3_0:init(arg_3_0, arg_3_0.entityId)

	return var_3_0
end

function var_0_0.getCO(arg_4_0)
	return lua_skill_buff.configDict[arg_4_0.buffId]
end

function var_0_0.setClientNum(arg_5_0, arg_5_1)
	arg_5_0.clientNum = arg_5_1
end

return var_0_0
