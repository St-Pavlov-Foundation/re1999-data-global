module("modules.logic.weekwalk_2.model.rpcmo.WeekwalkVer2BattleInfoMO", package.seeall)

local var_0_0 = pureTable("WeekwalkVer2BattleInfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.battleId = arg_1_1.battleId
	arg_1_0.status = arg_1_1.status
	arg_1_0.heroGroupSelect = arg_1_1.heroGroupSelect
	arg_1_0.elementId = arg_1_1.elementId
	arg_1_0.cupInfos = GameUtil.rpcInfosToMap(arg_1_1.cupInfos or {}, WeekwalkVer2CupInfoMO, "index")
	arg_1_0.chooseSkillIds = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.chooseSkillIds) do
		table.insert(arg_1_0.chooseSkillIds, iter_1_1)
	end

	arg_1_0.heroIds = {}
	arg_1_0.heroInCDMap = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.heroIds) do
		arg_1_0.heroInCDMap[iter_1_3] = true

		table.insert(arg_1_0.heroIds, iter_1_3)
	end

	arg_1_0.star = arg_1_0.status == WeekWalk_2Enum.BattleStatus.Finished and WeekWalk_2Enum.MaxStar or 0
end

function var_0_0.getCupMaxResult(arg_2_0)
	local var_2_0 = 0

	for iter_2_0, iter_2_1 in pairs(arg_2_0.cupInfos) do
		if var_2_0 < iter_2_1.result then
			var_2_0 = iter_2_1.result
		end
	end

	return var_2_0
end

function var_0_0.heroInCD(arg_3_0, arg_3_1)
	return arg_3_0.heroInCDMap[arg_3_1]
end

function var_0_0.getChooseSkillId(arg_4_0)
	return arg_4_0.chooseSkillIds[1]
end

function var_0_0.setIndex(arg_5_0, arg_5_1)
	arg_5_0.index = arg_5_1
end

function var_0_0.getCupInfo(arg_6_0, arg_6_1)
	return arg_6_0.cupInfos[arg_6_1]
end

return var_0_0
