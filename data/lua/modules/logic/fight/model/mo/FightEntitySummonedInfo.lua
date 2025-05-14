module("modules.logic.fight.model.mo.FightEntitySummonedInfo", package.seeall)

local var_0_0 = pureTable("FightEntitySummonedInfo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.stanceDic = {}
	arg_1_0.dataDic = {}
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.stanceDic = {}
	arg_2_0.dataDic = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		arg_2_0:addData(iter_2_1)
	end
end

function var_0_0.addData(arg_3_0, arg_3_1)
	local var_3_0 = {
		summonedId = arg_3_1.summonedId,
		level = arg_3_1.level,
		uid = arg_3_1.uid,
		fromUid = arg_3_1.fromUid
	}

	arg_3_0.dataDic[arg_3_1.uid] = var_3_0

	local var_3_1 = FightConfig.instance:getSummonedConfig(var_3_0.summonedId, var_3_0.level).stanceId
	local var_3_2 = lua_fight_summoned_stance.configDict[var_3_1]

	if var_3_2 then
		arg_3_0.stanceDic[var_3_1] = arg_3_0.stanceDic[var_3_1] or {}

		for iter_3_0 = 1, 20 do
			if not var_3_2["pos" .. iter_3_0] then
				break
			end

			if #var_3_2["pos" .. iter_3_0] == 0 then
				break
			end

			if not arg_3_0.stanceDic[var_3_1][iter_3_0] then
				arg_3_0.stanceDic[var_3_1][iter_3_0] = var_3_0.uid
				var_3_0.stanceIndex = iter_3_0

				break
			end
		end
	end

	if not var_3_0.stanceIndex then
		logError("挂件位置都被占用了,或者坐标数据没有配置,或者位置表找不到id:" .. var_3_1)

		var_3_0.stanceIndex = 1
	end

	return var_3_0
end

function var_0_0.removeData(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:getData(arg_4_1)
	local var_4_1 = FightConfig.instance:getSummonedConfig(var_4_0.summonedId, var_4_0.level).stanceId

	if arg_4_0.stanceDic[var_4_1] then
		for iter_4_0, iter_4_1 in pairs(arg_4_0.stanceDic[var_4_1]) do
			if iter_4_1 == arg_4_1 then
				arg_4_0.stanceDic[var_4_1][iter_4_0] = nil

				break
			end
		end
	end

	arg_4_0.dataDic[arg_4_1] = nil
end

function var_0_0.getDataDic(arg_5_0)
	return arg_5_0.dataDic
end

function var_0_0.getData(arg_6_0, arg_6_1)
	return arg_6_0.dataDic[arg_6_1]
end

function var_0_0.setLevel(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0.dataDic[arg_7_1]

	if var_7_0 then
		var_7_0.level = arg_7_2
	end
end

return var_0_0
