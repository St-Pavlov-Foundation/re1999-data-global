module("modules.logic.survival.model.shelter.SurvivalIntrudeFightMo", package.seeall)

local var_0_0 = pureTable("SurvivalIntrudeFightMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.fightId = arg_1_1.fightId
	arg_1_0.status = arg_1_1.status
	arg_1_0.stageNo = arg_1_1.stageNo
	arg_1_0.beginTime = arg_1_1.beginTime
	arg_1_0.endTime = arg_1_1.endTime
	arg_1_0.currRound = arg_1_1.currRound
	arg_1_0.schemes = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.schemes) do
		arg_1_0.schemes[iter_1_1.id] = iter_1_1.repress
	end

	if arg_1_0.fightId > 0 then
		arg_1_0.fightCo = lua_survival_shelter_intrude_fight.configDict[arg_1_0.fightId]
		arg_1_0.intrudeSchemeMos = {}

		local var_1_0 = 0

		arg_1_0.cleanPoints = string.splitToNumber(arg_1_0.fightCo.cleanpoint, "|")

		for iter_1_2, iter_1_3 in ipairs(arg_1_1.schemes) do
			local var_1_1 = arg_1_0.cleanPoints[iter_1_2]

			if var_1_0 < var_1_1 then
				var_1_0 = var_1_1
			end

			arg_1_0.intrudeSchemeMos[iter_1_2] = SurvivalIntrudeSchemeMo.New()

			arg_1_0.intrudeSchemeMos[iter_1_2]:setData(iter_1_3, var_1_1)
		end

		arg_1_0.maxCleanPoint = var_1_0
	end

	arg_1_0.repressNpcIds = arg_1_1.repressNpcIds
	arg_1_0.usedHeroId = {}
	arg_1_0.usedEquipPlan = {}
	arg_1_0.maxRound = #arg_1_1.rounds

	for iter_1_4, iter_1_5 in ipairs(arg_1_1.rounds) do
		for iter_1_6, iter_1_7 in ipairs(iter_1_5.heroes) do
			arg_1_0.usedHeroId[iter_1_7.heroId] = iter_1_4
		end

		arg_1_0.usedEquipPlan[iter_1_5.equipPlanId] = iter_1_4
	end

	arg_1_0.intrudeMonsterInfo = arg_1_1.monsters

	SurvivalShelterNpcMonsterListModel.instance:setSelectNpcByList(arg_1_0.repressNpcIds)
end

function var_0_0.getIntrudeSchemeMo(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0.intrudeSchemeMos) do
		if iter_2_1.survivalIntrudeScheme.id == arg_2_1 then
			return iter_2_1
		end
	end
end

function var_0_0.isNotStart(arg_3_0)
	return SurvivalShelterModel.instance:getWeekInfo().day < arg_3_0.beginTime
end

function var_0_0.canShowEntity(arg_4_0)
	local var_4_0 = SurvivalShelterModel.instance:getWeekInfo().day

	return var_4_0 >= arg_4_0.beginTime and var_4_0 <= arg_4_0.endTime and arg_4_0.status <= SurvivalEnum.ShelterMonsterFightState.Fail
end

function var_0_0.canFight(arg_5_0)
	return SurvivalShelterModel.instance:getWeekInfo().day == arg_5_0.endTime and (arg_5_0.status == SurvivalEnum.ShelterMonsterFightState.NoStart or arg_5_0.status == SurvivalEnum.ShelterMonsterFightState.Fighting)
end

function var_0_0.needKillBoss(arg_6_0)
	return SurvivalShelterModel.instance:getWeekInfo().day >= arg_6_0.endTime and arg_6_0.status == SurvivalEnum.ShelterMonsterFightState.Fighting
end

function var_0_0.canSelectNpc(arg_7_0)
	return arg_7_0:canFight() and arg_7_0.status == SurvivalEnum.ShelterMonsterFightState.NoStart
end

function var_0_0.canEnterSelectNpc(arg_8_0)
	return arg_8_0.status == SurvivalEnum.ShelterMonsterFightState.NoStart
end

function var_0_0.getUseRoundByHeroId(arg_9_0, arg_9_1)
	if arg_9_0.usedHeroId ~= nil then
		for iter_9_0, iter_9_1 in pairs(arg_9_0.usedHeroId) do
			if iter_9_0 == arg_9_1 then
				return iter_9_1
			end
		end
	end

	return nil
end

function var_0_0.getUseRoundByHeroUid(arg_10_0, arg_10_1)
	if arg_10_0.usedHeroId ~= nil then
		for iter_10_0, iter_10_1 in pairs(arg_10_0.usedHeroId) do
			local var_10_0 = HeroModel.instance:getByHeroId(iter_10_0)

			if var_10_0 and var_10_0.uid == arg_10_1 then
				return iter_10_1
			end
		end
	end

	return nil
end

function var_0_0.canShowReset(arg_11_0)
	return SurvivalShelterModel.instance:getWeekInfo().day >= arg_11_0.beginTime and (arg_11_0.status == SurvivalEnum.ShelterMonsterFightState.Fighting or arg_11_0.status == SurvivalEnum.ShelterMonsterFightState.Fail) and #arg_11_0.intrudeMonsterInfo > 0
end

function var_0_0.canShowFightBtn(arg_12_0)
	return arg_12_0.status ~= SurvivalEnum.ShelterMonsterFightState.Fail
end

function var_0_0.canAbandon(arg_13_0)
	return arg_13_0.status == SurvivalEnum.ShelterMonsterFightState.NoStart or arg_13_0.status == SurvivalEnum.ShelterMonsterFightState.Fighting
end

function var_0_0.isFighting(arg_14_0)
	return arg_14_0.status == SurvivalEnum.ShelterMonsterFightState.Fighting
end

function var_0_0.setWin(arg_15_0)
	arg_15_0.status = SurvivalEnum.ShelterMonsterFightState.Win
end

function var_0_0.getBattleId(arg_16_0)
	return arg_16_0.fightCo.battleId
end

function var_0_0.getMaxCleanPoint(arg_17_0)
	local var_17_0 = SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.DecodingFix, arg_17_0.maxCleanPoint)

	return (math.floor(var_17_0))
end

return var_0_0
