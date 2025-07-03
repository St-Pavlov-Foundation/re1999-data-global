module("modules.logic.fight.model.data.FightPaTaDataMgr", package.seeall)

local var_0_0 = FightDataClass("FightPaTaDataMgr", FightDataMgrBase)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.bossInfoList = {}
end

function var_0_0.sortSkillInfo(arg_2_0, arg_2_1)
	return arg_2_0.powerLow < arg_2_1.powerLow
end

function var_0_0.updateData(arg_3_0, arg_3_1)
	if not arg_3_1.attacker.assistBossInfo then
		return
	end

	local var_3_0 = arg_3_1.attacker.assistBossInfo

	arg_3_0.currCd = var_3_0.currCd
	arg_3_0.cfgCd = var_3_0.cdCfg
	arg_3_0.formId = var_3_0.formId
	arg_3_0.roundUseLimit = var_3_0.roundUseLimit
	arg_3_0.exceedUseFree = var_3_0.exceedUseFree
	arg_3_0.params = var_3_0.params
	arg_3_0.preUsePower = 0
	arg_3_0.preCostCd = 0
	arg_3_0.useCardCount = 0

	arg_3_0:updateSkill(var_3_0.skills)
end

function var_0_0.switchBossSkill(arg_4_0, arg_4_1)
	if not arg_4_1 then
		return
	end

	arg_4_0.currCd = arg_4_1.currCd
	arg_4_0.cfgCd = arg_4_1.cdCfg
	arg_4_0.formId = arg_4_1.formId

	arg_4_0:updateSkill(arg_4_1.skills)
end

function var_0_0.updateSkill(arg_5_0, arg_5_1)
	tabletool.clear(arg_5_0.bossInfoList)

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		local var_5_0 = FightAssistBossSkillInfoMo.New()

		var_5_0:init(iter_5_1)
		table.insert(arg_5_0.bossInfoList, var_5_0)
	end

	table.sort(arg_5_0.bossInfoList, var_0_0.sortSkillInfo)
end

function var_0_0.changeScore(arg_6_0, arg_6_1)
	arg_6_0.score = arg_6_0.score and arg_6_0.score + arg_6_1 or arg_6_1
end

function var_0_0.getScore(arg_7_0)
	return arg_7_0.score
end

function var_0_0.hadCD(arg_8_0)
	return arg_8_0.cfgCd and arg_8_0.cfgCd > 0
end

function var_0_0.getCurCD(arg_9_0)
	return arg_9_0.currCd + arg_9_0.preCostCd
end

function var_0_0.setCurrCD(arg_10_0, arg_10_1)
	arg_10_0.currCd = tonumber(arg_10_1)
end

function var_0_0.getFromId(arg_11_0)
	return arg_11_0.formId + 1
end

function var_0_0.getAssistBossPower(arg_12_0)
	local var_12_0 = arg_12_0:getAssistBossMo()
	local var_12_1 = var_12_0 and var_12_0:getPowerInfo(FightEnum.PowerType.AssistBoss)
	local var_12_2 = var_12_1 and var_12_1.num or 0
	local var_12_3 = var_12_1 and var_12_1.max or 0

	return var_12_2 - arg_12_0.preUsePower, var_12_3
end

function var_0_0.getAssistBossServerPower(arg_13_0)
	local var_13_0 = arg_13_0:getAssistBossMo()
	local var_13_1 = var_13_0 and var_13_0:getPowerInfo(FightEnum.PowerType.AssistBoss)
	local var_13_2 = var_13_1 and var_13_1.num or 0
	local var_13_3 = var_13_1 and var_13_1.max or 0

	return var_13_2, var_13_3
end

function var_0_0.getAssistBossMo(arg_14_0)
	return arg_14_0.dataMgr.entityMgr:getAssistBoss()
end

function var_0_0.playAssistBossSkill(arg_15_0, arg_15_1)
	arg_15_0.preUsePower = arg_15_0.preUsePower + arg_15_0:getNeedPower(arg_15_1)
	arg_15_0.useCardCount = arg_15_0.useCardCount + 1
	arg_15_0.preCostCd = arg_15_0.preCostCd + arg_15_0.cfgCd
end

function var_0_0.getNeedPower(arg_16_0, arg_16_1)
	if arg_16_0.exceedUseFree ~= 0 and arg_16_0.useCardCount >= arg_16_0.exceedUseFree then
		return 0
	end

	return arg_16_1.needPower
end

function var_0_0.playAssistBossSkillBySkillId(arg_17_0, arg_17_1)
	for iter_17_0 = #arg_17_0.bossInfoList, 1, -1 do
		local var_17_0 = arg_17_0.bossInfoList[iter_17_0]

		if var_17_0.skillId == arg_17_1 then
			arg_17_0:playAssistBossSkill(var_17_0)

			return
		end
	end
end

function var_0_0.resetOp(arg_18_0)
	arg_18_0.preUsePower = 0
	arg_18_0.useCardCount = 0
	arg_18_0.preCostCd = 0
end

function var_0_0.canUseSkill(arg_19_0)
	if arg_19_0.roundUseLimit ~= 0 then
		return arg_19_0.useCardCount < arg_19_0.roundUseLimit
	end

	local var_19_0 = lua_tower_const.configDict[115]

	return (var_19_0 and tonumber(var_19_0.value) or 20) > arg_19_0.useCardCount
end

function var_0_0.getCurUseSkillInfo(arg_20_0)
	local var_20_0 = arg_20_0:getAssistBossPower()

	for iter_20_0 = #arg_20_0.bossInfoList, 1, -1 do
		local var_20_1 = arg_20_0.bossInfoList[iter_20_0]

		if var_20_0 >= var_20_1.powerLow and var_20_0 >= arg_20_0:getNeedPower(var_20_1) then
			return var_20_1
		end
	end
end

function var_0_0.getUseCardCount(arg_21_0)
	return arg_21_0.useCardCount
end

function var_0_0.getBossSkillInfoList(arg_22_0)
	return arg_22_0.bossInfoList
end

return var_0_0
