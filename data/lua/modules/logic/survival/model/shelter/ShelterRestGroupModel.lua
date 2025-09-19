module("modules.logic.survival.model.shelter.ShelterRestGroupModel", package.seeall)

local var_0_0 = class("ShelterRestGroupModel", SurvivalInitGroupModel)

function var_0_0.initViewParam(arg_1_0, arg_1_1)
	arg_1_0.curClickHeroIndex = arg_1_1.index
	arg_1_0.buildingId = arg_1_1.buildingId
	arg_1_0.buildingInfo = SurvivalShelterModel.instance:getWeekInfo():getBuildingInfo(arg_1_0.buildingId)

	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.Survival)
	arg_1_0:refreshHeroList()
end

function var_0_0.refreshHeroList(arg_2_0)
	local var_2_0 = SurvivalShelterModel.instance:getWeekInfo()
	local var_2_1 = var_2_0:getAttr(SurvivalEnum.AttrType.HeroHealthMax)

	arg_2_0.selectHeroDict = {}

	for iter_2_0, iter_2_1 in pairs(arg_2_0.buildingInfo.heros) do
		arg_2_0.selectHeroDict[iter_2_1] = iter_2_0
	end

	local var_2_2 = {}
	local var_2_3 = {}

	for iter_2_2 = 1, arg_2_0:getCarryHeroCount() do
		local var_2_4 = iter_2_2 - 1
		local var_2_5 = arg_2_0.selectHeroDict[var_2_4]

		if var_2_5 then
			local var_2_6 = HeroModel.instance:getByHeroId(var_2_5)

			table.insert(var_2_2, var_2_6)

			var_2_3[var_2_5] = true
		end
	end

	for iter_2_3, iter_2_4 in ipairs(CharacterBackpackCardListModel.instance:getCharacterCardList()) do
		if not var_2_3[iter_2_4.heroId] then
			var_2_3[iter_2_4.heroId] = true

			if var_2_1 > var_2_0:getHeroMo(iter_2_4.heroId).health then
				table.insert(var_2_2, iter_2_4)
			end
		end
	end

	arg_2_0._heroId2Index = {}

	for iter_2_5, iter_2_6 in ipairs(var_2_2) do
		arg_2_0._heroId2Index[iter_2_6.heroId] = iter_2_5
	end

	table.sort(var_2_2, var_0_0.sortHeroList)
	arg_2_0:setList(var_2_2)
end

function var_0_0.sortHeroList(arg_3_0, arg_3_1)
	local var_3_0 = SurvivalShelterModel.instance:getWeekInfo()
	local var_3_1 = var_3_0:getHeroMo(arg_3_0.heroId).health or 0
	local var_3_2 = var_3_0:getHeroMo(arg_3_1.heroId).health or 0

	if var_3_1 ~= var_3_2 then
		return var_3_1 < var_3_2
	end

	local var_3_3 = var_0_0.instance._heroId2Index[arg_3_0.heroId] or 0
	local var_3_4 = var_0_0.instance._heroId2Index[arg_3_1.heroId] or 0

	if var_3_3 ~= var_3_4 then
		return var_3_3 < var_3_4
	end

	return false
end

function var_0_0.getMoIndex(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.selectHeroDict) do
		if iter_4_1 == arg_4_1.heroId then
			return iter_4_0 + 1
		end
	end

	return -1
end

function var_0_0.trySetHeroMo(arg_5_0, arg_5_1)
	if arg_5_1 then
		for iter_5_0, iter_5_1 in pairs(arg_5_0.selectHeroDict) do
			if iter_5_1 == arg_5_1.heroId then
				arg_5_0.selectHeroDict[iter_5_0] = nil

				break
			end
		end
	end

	arg_5_0.selectHeroDict[arg_5_0.curClickHeroIndex - 1] = arg_5_1.heroId
end

function var_0_0.tryAddHeroMo(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in pairs(arg_6_0.selectHeroDict) do
		if iter_6_1 == arg_6_1.heroId then
			arg_6_0.selectHeroDict[iter_6_0] = nil

			return
		end
	end

	for iter_6_2 = 1, arg_6_0:getCarryHeroCount() do
		local var_6_0 = iter_6_2 - 1

		if not arg_6_0.selectHeroDict[var_6_0] then
			arg_6_0.selectHeroDict[var_6_0] = arg_6_1.heroId

			return iter_6_2
		end
	end
end

function var_0_0.getCarryHeroCount(arg_7_0)
	return arg_7_0.buildingInfo:getAttr(SurvivalEnum.AttrType.LoungeRoleNum)
end

function var_0_0.isHeroFull(arg_8_0)
	return tabletool.len(arg_8_0.allSelectHeroMos) == arg_8_0:getCarryHeroCount()
end

function var_0_0.saveHeroGroup(arg_9_0)
	local var_9_0 = arg_9_0:getCarryHeroCount()
	local var_9_1 = {}

	for iter_9_0 = 1, var_9_0 do
		local var_9_2 = arg_9_0.selectHeroDict[iter_9_0 - 1] or 0

		table.insert(var_9_1, var_9_2)
	end

	SurvivalWeekRpc.instance:sendSurvivalBatchHeroChangePositionRequest(var_9_1, arg_9_0.buildingId)
end

var_0_0.instance = var_0_0.New()

return var_0_0
