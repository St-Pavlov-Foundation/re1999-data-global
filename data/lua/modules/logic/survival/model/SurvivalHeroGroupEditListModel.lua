module("modules.logic.survival.model.SurvivalHeroGroupEditListModel", package.seeall)

local var_0_0 = class("SurvivalHeroGroupEditListModel", HeroGroupEditListModel)

function var_0_0.copyCharacterCardList(arg_1_0, arg_1_1)
	local var_1_0
	local var_1_1 = SurvivalShelterModel.instance:getWeekInfo()
	local var_1_2 = var_1_1.inSurvival
	local var_1_3

	if HeroGroupTrialModel.instance:isOnlyUseTrial() then
		var_1_0 = {}
	elseif var_1_2 then
		var_1_3 = SurvivalMapModel.instance:getSceneMo().teamInfo
		var_1_0 = {}

		for iter_1_0 in pairs(var_1_3.heroUids) do
			table.insert(var_1_0, (var_1_3:getHeroMo(iter_1_0)))
		end
	else
		var_1_0 = CharacterBackpackCardListModel.instance:getCharacterCardList()
	end

	local var_1_4 = {}
	local var_1_5 = {}

	arg_1_0._inTeamHeroUids = {}

	local var_1_6 = 1
	local var_1_7 = 1
	local var_1_8 = HeroSingleGroupModel.instance:getList()

	for iter_1_1, iter_1_2 in ipairs(var_1_8) do
		if iter_1_2.trial or not iter_1_2.aid and tonumber(iter_1_2.heroUid) > 0 and not var_1_5[iter_1_2.heroUid] then
			if iter_1_2.trial then
				table.insert(var_1_4, HeroGroupTrialModel.instance:getById(iter_1_2.heroUid))
			elseif var_1_2 then
				table.insert(var_1_4, (var_1_3:getHeroMo(iter_1_2.heroUid)))
			else
				table.insert(var_1_4, HeroModel.instance:getById(iter_1_2.heroUid))
			end

			if arg_1_0.specialHero == iter_1_2.heroUid then
				arg_1_0._inTeamHeroUids[iter_1_2.heroUid] = 2
				var_1_6 = var_1_7
			else
				arg_1_0._inTeamHeroUids[iter_1_2.heroUid] = 1
				var_1_7 = var_1_7 + 1
			end

			var_1_5[iter_1_2.heroUid] = true
		end
	end

	local var_1_9 = CharacterModel.instance:getRankState()
	local var_1_10 = CharacterModel.instance:getBtnTag(CharacterEnum.FilterType.HeroGroup)

	HeroGroupTrialModel.instance:sortByLevelAndRare(var_1_10 == 1, var_1_9[var_1_10] == 1)

	local var_1_11 = HeroGroupTrialModel.instance:getFilterList()

	for iter_1_3, iter_1_4 in ipairs(var_1_11) do
		if not var_1_5[iter_1_4.uid] then
			table.insert(var_1_4, iter_1_4)
		end
	end

	for iter_1_5, iter_1_6 in ipairs(var_1_4) do
		if arg_1_0._moveHeroId and iter_1_6.heroId == arg_1_0._moveHeroId then
			arg_1_0._moveHeroId = nil
			arg_1_0._moveHeroIndex = iter_1_5

			break
		end
	end

	local var_1_12 = {}

	for iter_1_7, iter_1_8 in ipairs(var_1_0) do
		if not var_1_5[iter_1_8.uid] then
			var_1_5[iter_1_8.uid] = true

			if var_1_1:getHeroMo(iter_1_8.heroId).health <= 0 or arg_1_0:getSelectByIndex(iter_1_8.heroId) ~= nil then
				table.insert(var_1_12, iter_1_8)
			else
				table.insert(var_1_4, iter_1_8)
			end
		end
	end

	tabletool.addValues(var_1_4, var_1_12)
	arg_1_0:setList(var_1_4)

	if arg_1_1 and #var_1_4 > 0 and var_1_6 > 0 and #arg_1_0._scrollViews > 0 then
		for iter_1_9, iter_1_10 in ipairs(arg_1_0._scrollViews) do
			iter_1_10:selectCell(var_1_6, true)
		end

		if var_1_4[var_1_6] then
			return var_1_4[var_1_6]
		end
	end
end

function var_0_0.getSelectByIndex(arg_2_0, arg_2_1)
	local var_2_0 = SurvivalShelterModel.instance:getWeekInfo()

	if not var_2_0.inSurvival then
		return (var_2_0:getMonsterFight():getUseRoundByHeroId(arg_2_1))
	end

	return nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
