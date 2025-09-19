module("modules.logic.rouge.model.rpcmo.RougeTeamInfoMO", package.seeall)

local var_0_0 = pureTable("RougeTeamInfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.battleHeroList, arg_1_0.battleHeroMap = GameUtil.rpcInfosToListAndMap(arg_1_1.battleHeroList, RougeBattleHeroMO, "index")
	arg_1_0.heroLifeList, arg_1_0.heroLifeMap = GameUtil.rpcInfosToListAndMap(arg_1_1.heroLifeList, RougeHeroLifeMO, "heroId")
	arg_1_0.heroInfoList, arg_1_0.heroInfoMap = GameUtil.rpcInfosToListAndMap(arg_1_1.heroInfoList, RougeHeroInfoMO, "heroId")
	arg_1_0._assistHeroMO = nil

	if arg_1_1:HasField("assistHeroInfo") then
		local var_1_0 = Season123AssistHeroMO.New()

		var_1_0:init(arg_1_1.assistHeroInfo)

		arg_1_0._assistHeroMO = Season123HeroUtils.createHeroMOByAssistMO(var_1_0)

		if RougeHeroGroupBalanceHelper.getIsBalanceMode() then
			arg_1_0._assistHeroMO:setOtherPlayerIsOpenTalent(true)
		end
	end

	arg_1_0:_initSupportHeroAndSkill()
	arg_1_0:_initTeamList()
	arg_1_0:updateDeadHeroNum()
end

function var_0_0._initSupportHeroAndSkill(arg_2_0)
	arg_2_0._supportSkillMap = {}
	arg_2_0._supportBattleHeroMap = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.battleHeroList) do
		if iter_2_1.supportHeroId > 0 and iter_2_1.supportHeroSkill > 0 then
			local var_2_0 = SkillConfig.instance:getHeroBaseSkillIdDictByExSkillLevel(iter_2_1.supportHeroId, nil, arg_2_0:getAnyHeroMo(iter_2_1.supportHeroId))

			arg_2_0._supportSkillMap[iter_2_1.supportHeroId] = var_2_0 and var_2_0[iter_2_1.supportHeroSkill]
			arg_2_0._supportBattleHeroMap[iter_2_1.index + RougeEnum.FightTeamNormalHeroNum] = {
				heroId = iter_2_1.supportHeroId
			}
		end
	end
end

function var_0_0._initTeamList(arg_3_0)
	arg_3_0._teamMap = {}
	arg_3_0._teamAssistMap = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_0.battleHeroList) do
		if iter_3_1.heroId ~= 0 then
			arg_3_0._teamMap[iter_3_1.heroId] = iter_3_1
		end

		if iter_3_1.supportHeroId ~= 0 then
			arg_3_0._teamAssistMap[iter_3_1.supportHeroId] = iter_3_1
		end
	end
end

function var_0_0.getAssistHeroMo(arg_4_0, arg_4_1)
	if arg_4_1 then
		if arg_4_0._assistHeroMO and arg_4_0._assistHeroMO.heroId == arg_4_1 then
			return arg_4_0._assistHeroMO
		end
	else
		return arg_4_0._assistHeroMO
	end
end

function var_0_0.getAssistHeroMoByUid(arg_5_0, arg_5_1)
	if arg_5_0._assistHeroMO and arg_5_0._assistHeroMO.uid == arg_5_1 then
		return arg_5_0._assistHeroMO
	end
end

function var_0_0.getAnyHeroMo(arg_6_0, arg_6_1)
	return arg_6_0:getAssistHeroMo(arg_6_1) or HeroModel.instance:getByHeroId(arg_6_1)
end

function var_0_0.isAssistHero(arg_7_0, arg_7_1)
	return arg_7_0._assistHeroMO and arg_7_0._assistHeroMO.heroId == arg_7_1
end

function var_0_0.inTeam(arg_8_0, arg_8_1)
	return arg_8_0._teamMap[arg_8_1] ~= nil
end

function var_0_0.inTeamAssist(arg_9_0, arg_9_1)
	return arg_9_0._teamAssistMap[arg_9_1] ~= nil
end

function var_0_0.getAssistTargetHero(arg_10_0, arg_10_1)
	return arg_10_0._teamAssistMap and arg_10_0._teamAssistMap[arg_10_1]
end

function var_0_0.getHeroHp(arg_11_0, arg_11_1)
	return arg_11_0.heroLifeMap[arg_11_1]
end

function var_0_0.getSupportSkillStrList(arg_12_0)
	local var_12_0 = {}

	for iter_12_0 = 1, RougeEnum.FightTeamNormalHeroNum do
		local var_12_1 = arg_12_0.battleHeroMap[iter_12_0]

		if var_12_1 and var_12_1.supportHeroSkill ~= 0 then
			var_12_0[iter_12_0] = string.format("%s#%s", var_12_1.supportHeroId, var_12_1.supportHeroSkill)
		else
			var_12_0[iter_12_0] = ""
		end
	end

	return var_12_0
end

function var_0_0.getSupportSkillIndex(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:getSupportSkill(arg_13_1)

	if not var_13_0 then
		return
	end

	local var_13_1 = arg_13_0:getAnyHeroMo(arg_13_1)

	if not var_13_1 then
		logError(string.format("RougeTeamInfoMO getSupportSkillIndex heroId:%s heroMo nil", arg_13_1))

		return
	end

	local var_13_2 = SkillConfig.instance:getHeroBaseSkillIdDictByExSkillLevel(arg_13_1, nil, var_13_1)

	if not var_13_2 then
		return
	end

	for iter_13_0, iter_13_1 in pairs(var_13_2) do
		if iter_13_1 == var_13_0 then
			return iter_13_0
		end
	end
end

function var_0_0.getSupportSkill(arg_14_0, arg_14_1)
	return arg_14_0._supportSkillMap[arg_14_1]
end

function var_0_0.setSupportSkill(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0._supportSkillMap[arg_15_1] = arg_15_2
end

function var_0_0.getGroupInfos(arg_16_0)
	local var_16_0 = RougeHeroGroupMO.New()
	local var_16_1 = {}
	local var_16_2 = {}

	var_16_0:setMaxHeroCount(RougeEnum.FightTeamHeroNum)

	for iter_16_0 = 1, RougeEnum.FightTeamHeroNum do
		local var_16_3 = arg_16_0.battleHeroMap[iter_16_0] or arg_16_0._supportBattleHeroMap[iter_16_0]
		local var_16_4 = var_16_3 and var_16_3.heroId or 0
		local var_16_5 = HeroModel.instance:getByHeroId(var_16_4)
		local var_16_6 = var_16_3 and var_16_3.equipUid or "0"

		table.insert(var_16_1, var_16_5 and var_16_5.uid or "0")

		if iter_16_0 <= RougeEnum.FightTeamNormalHeroNum then
			local var_16_7 = HeroGroupEquipMO.New()
			local var_16_8 = iter_16_0 - 1

			var_16_7:init({
				index = var_16_8,
				equipUid = {
					var_16_6
				}
			})

			var_16_2[var_16_8] = var_16_7
		end
	end

	var_16_0:init({
		id = 1,
		heroList = var_16_1,
		equips = var_16_2
	})

	return {
		var_16_0
	}
end

function var_0_0.getBattleHeroList(arg_17_0)
	return arg_17_0.battleHeroList
end

function var_0_0.updateTeamLife(arg_18_0, arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
		local var_18_0 = arg_18_0.heroLifeMap[iter_18_1.heroId]

		if var_18_0 then
			var_18_0:update(iter_18_1)
		else
			local var_18_1 = RougeHeroLifeMO.New()

			var_18_1:init(iter_18_1)

			arg_18_0.heroLifeMap[var_18_1.heroId] = var_18_1

			table.insert(arg_18_0.heroLifeList, var_18_1)
		end
	end

	arg_18_0:updateDeadHeroNum()
end

function var_0_0.updateExtraHeroInfo(arg_19_0, arg_19_1)
	for iter_19_0, iter_19_1 in ipairs(arg_19_1) do
		local var_19_0 = arg_19_0.heroInfoMap[iter_19_1.heroId]

		if var_19_0 then
			var_19_0:update(iter_19_1)
		else
			local var_19_1 = RougeHeroInfoMO.New()

			var_19_1:init(iter_19_1)

			arg_19_0.heroInfoMap[var_19_1.heroId] = var_19_1

			table.insert(arg_19_0.heroInfoList, var_19_1)
		end
	end
end

function var_0_0.updateTeamLifeAndDispatchEvent(arg_20_0, arg_20_1)
	local var_20_0 = RougeMapEnum.LifeChangeStatus.Idle

	for iter_20_0, iter_20_1 in ipairs(arg_20_1) do
		local var_20_1 = arg_20_0.heroLifeMap[iter_20_1.heroId]

		if var_20_1 then
			local var_20_2 = RougeMapHelper.getLifeChangeStatus(var_20_1.life, iter_20_1.life)

			if var_20_2 ~= RougeMapEnum.LifeChangeStatus.Idle then
				var_20_0 = var_20_2
			end

			var_20_1:update(iter_20_1)
		else
			local var_20_3 = RougeHeroLifeMO.New()

			var_20_3:init(iter_20_1)

			arg_20_0.heroLifeMap[var_20_3.heroId] = var_20_3

			table.insert(arg_20_0.heroLifeList, var_20_3)
		end
	end

	if var_20_0 ~= RougeMapEnum.LifeChangeStatus.Idle then
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onTeamLifeChange, var_20_0)
	end

	arg_20_0:updateDeadHeroNum()
end

function var_0_0.getAllHeroCount(arg_21_0)
	return #arg_21_0.heroLifeList
end

function var_0_0.getAllHeroId(arg_22_0)
	local var_22_0 = {}

	if arg_22_0.heroLifeList then
		for iter_22_0, iter_22_1 in ipairs(arg_22_0.heroLifeList) do
			local var_22_1 = iter_22_1.heroId

			table.insert(var_22_0, var_22_1)
		end
	end

	return var_22_0
end

function var_0_0.updateDeadHeroNum(arg_23_0)
	arg_23_0.deadHeroNum = 0

	if arg_23_0.heroLifeList then
		for iter_23_0, iter_23_1 in ipairs(arg_23_0.heroLifeList) do
			if iter_23_1.life <= 0 then
				arg_23_0.deadHeroNum = arg_23_0.deadHeroNum + 1
			end
		end
	end
end

function var_0_0.getDeadHeroNum(arg_24_0)
	return arg_24_0.deadHeroNum
end

function var_0_0.getHeroInfo(arg_25_0, arg_25_1)
	return arg_25_0.heroInfoMap and arg_25_0.heroInfoMap[arg_25_1]
end

return var_0_0
