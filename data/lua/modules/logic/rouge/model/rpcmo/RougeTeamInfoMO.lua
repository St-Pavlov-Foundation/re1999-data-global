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
			local var_2_0 = SkillConfig.instance:getHeroBaseSkillIdDictByExSkillLevel(iter_2_1.supportHeroId, nil, arg_2_0:getAssistHeroMo(iter_2_1.supportHeroId))

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

function var_0_0.isAssistHero(arg_6_0, arg_6_1)
	return arg_6_0._assistHeroMO and arg_6_0._assistHeroMO.heroId == arg_6_1
end

function var_0_0.inTeam(arg_7_0, arg_7_1)
	return arg_7_0._teamMap[arg_7_1] ~= nil
end

function var_0_0.inTeamAssist(arg_8_0, arg_8_1)
	return arg_8_0._teamAssistMap[arg_8_1] ~= nil
end

function var_0_0.getAssistTargetHero(arg_9_0, arg_9_1)
	return arg_9_0._teamAssistMap and arg_9_0._teamAssistMap[arg_9_1]
end

function var_0_0.getHeroHp(arg_10_0, arg_10_1)
	return arg_10_0.heroLifeMap[arg_10_1]
end

function var_0_0.getSupportSkillStrList(arg_11_0)
	local var_11_0 = {}

	for iter_11_0 = 1, RougeEnum.FightTeamNormalHeroNum do
		local var_11_1 = arg_11_0.battleHeroMap[iter_11_0]

		if var_11_1 and var_11_1.supportHeroSkill ~= 0 then
			var_11_0[iter_11_0] = string.format("%s#%s", var_11_1.supportHeroId, var_11_1.supportHeroSkill)
		else
			var_11_0[iter_11_0] = ""
		end
	end

	return var_11_0
end

function var_0_0.getSupportSkillIndex(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getSupportSkill(arg_12_1)

	if not var_12_0 then
		return
	end

	local var_12_1 = SkillConfig.instance:getHeroBaseSkillIdDictByExSkillLevel(arg_12_1)

	if not var_12_1 then
		return
	end

	for iter_12_0, iter_12_1 in pairs(var_12_1) do
		if iter_12_1 == var_12_0 then
			return iter_12_0
		end
	end
end

function var_0_0.getSupportSkill(arg_13_0, arg_13_1)
	return arg_13_0._supportSkillMap[arg_13_1]
end

function var_0_0.setSupportSkill(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0._supportSkillMap[arg_14_1] = arg_14_2
end

function var_0_0.getGroupInfos(arg_15_0)
	local var_15_0 = RougeHeroGroupMO.New()
	local var_15_1 = {}
	local var_15_2 = {}

	var_15_0:setMaxHeroCount(RougeEnum.FightTeamHeroNum)

	for iter_15_0 = 1, RougeEnum.FightTeamHeroNum do
		local var_15_3 = arg_15_0.battleHeroMap[iter_15_0] or arg_15_0._supportBattleHeroMap[iter_15_0]
		local var_15_4 = var_15_3 and var_15_3.heroId or 0
		local var_15_5 = HeroModel.instance:getByHeroId(var_15_4)
		local var_15_6 = var_15_3 and var_15_3.equipUid or "0"

		table.insert(var_15_1, var_15_5 and var_15_5.uid or "0")

		if iter_15_0 <= RougeEnum.FightTeamNormalHeroNum then
			local var_15_7 = HeroGroupEquipMO.New()
			local var_15_8 = iter_15_0 - 1

			var_15_7:init({
				index = var_15_8,
				equipUid = {
					var_15_6
				}
			})

			var_15_2[var_15_8] = var_15_7
		end
	end

	var_15_0:init({
		id = 1,
		heroList = var_15_1,
		equips = var_15_2
	})

	return {
		var_15_0
	}
end

function var_0_0.getBattleHeroList(arg_16_0)
	return arg_16_0.battleHeroList
end

function var_0_0.updateTeamLife(arg_17_0, arg_17_1)
	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		local var_17_0 = arg_17_0.heroLifeMap[iter_17_1.heroId]

		if var_17_0 then
			var_17_0:update(iter_17_1)
		else
			local var_17_1 = RougeHeroLifeMO.New()

			var_17_1:init(iter_17_1)

			arg_17_0.heroLifeMap[var_17_1.heroId] = var_17_1

			table.insert(arg_17_0.heroLifeList, var_17_1)
		end
	end

	arg_17_0:updateDeadHeroNum()
end

function var_0_0.updateExtraHeroInfo(arg_18_0, arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
		local var_18_0 = arg_18_0.heroInfoMap[iter_18_1.heroId]

		if var_18_0 then
			var_18_0:update(iter_18_1)
		else
			local var_18_1 = RougeHeroInfoMO.New()

			var_18_1:init(iter_18_1)

			arg_18_0.heroInfoMap[var_18_1.heroId] = var_18_1

			table.insert(arg_18_0.heroInfoList, var_18_1)
		end
	end
end

function var_0_0.updateTeamLifeAndDispatchEvent(arg_19_0, arg_19_1)
	local var_19_0 = RougeMapEnum.LifeChangeStatus.Idle

	for iter_19_0, iter_19_1 in ipairs(arg_19_1) do
		local var_19_1 = arg_19_0.heroLifeMap[iter_19_1.heroId]

		if var_19_1 then
			local var_19_2 = RougeMapHelper.getLifeChangeStatus(var_19_1.life, iter_19_1.life)

			if var_19_2 ~= RougeMapEnum.LifeChangeStatus.Idle then
				var_19_0 = var_19_2
			end

			var_19_1:update(iter_19_1)
		else
			local var_19_3 = RougeHeroLifeMO.New()

			var_19_3:init(iter_19_1)

			arg_19_0.heroLifeMap[var_19_3.heroId] = var_19_3

			table.insert(arg_19_0.heroLifeList, var_19_3)
		end
	end

	if var_19_0 ~= RougeMapEnum.LifeChangeStatus.Idle then
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onTeamLifeChange, var_19_0)
	end

	arg_19_0:updateDeadHeroNum()
end

function var_0_0.getAllHeroCount(arg_20_0)
	return #arg_20_0.heroLifeList
end

function var_0_0.getAllHeroId(arg_21_0)
	local var_21_0 = {}

	if arg_21_0.heroLifeList then
		for iter_21_0, iter_21_1 in ipairs(arg_21_0.heroLifeList) do
			local var_21_1 = iter_21_1.heroId

			table.insert(var_21_0, var_21_1)
		end
	end

	return var_21_0
end

function var_0_0.updateDeadHeroNum(arg_22_0)
	arg_22_0.deadHeroNum = 0

	if arg_22_0.heroLifeList then
		for iter_22_0, iter_22_1 in ipairs(arg_22_0.heroLifeList) do
			if iter_22_1.life <= 0 then
				arg_22_0.deadHeroNum = arg_22_0.deadHeroNum + 1
			end
		end
	end
end

function var_0_0.getDeadHeroNum(arg_23_0)
	return arg_23_0.deadHeroNum
end

function var_0_0.getHeroInfo(arg_24_0, arg_24_1)
	return arg_24_0.heroInfoMap and arg_24_0.heroInfoMap[arg_24_1]
end

return var_0_0
