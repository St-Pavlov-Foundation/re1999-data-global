module("modules.logic.fight.model.data.FightProtoCacheDataMgr", package.seeall)

local var_0_0 = FightDataClass("FightProtoCacheDataMgr", FightDataMgrBase)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.roundProtoList = {}
	arg_1_0.fightProtoList = {}
end

function var_0_0.addFightProto(arg_2_0, arg_2_1)
	table.insert(arg_2_0.fightProtoList, arg_2_1)
end

function var_0_0.addRoundProto(arg_3_0, arg_3_1)
	table.insert(arg_3_0.roundProtoList, arg_3_1)
end

function var_0_0.getLastRoundProto(arg_4_0)
	return arg_4_0.roundProtoList[#arg_4_0.roundProtoList]
end

function var_0_0.getPreRoundProto(arg_5_0)
	return arg_5_0.roundProtoList[#arg_5_0.roundProtoList - 1]
end

function var_0_0.getLastRoundNum(arg_6_0)
	local var_6_0 = arg_6_0:getPreRoundProto()

	if var_6_0 then
		return var_6_0.curRound
	end
end

function var_0_0.getRoundNumByRoundProto(arg_7_0, arg_7_1)
	local var_7_0

	for iter_7_0, iter_7_1 in ipairs(arg_7_0.roundProtoList) do
		if iter_7_1 == arg_7_1 then
			var_7_0 = arg_7_0.roundProtoList[iter_7_0 - 1]

			break
		end
	end

	if var_7_0 then
		return var_7_0.curRound
	end
end

return var_0_0
