module("modules.logic.seasonver.act166.model.Season166HeroGroupEditModel", package.seeall)

local var_0_0 = class("Season166HeroGroupEditModel", ListScrollModel)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.activityId = arg_1_1
	arg_1_0.episodeId = arg_1_2
	arg_1_0.episodeCO = DungeonConfig.instance:getEpisodeCO(arg_1_0.episodeId)
end

function var_0_0.copyCharacterCardList(arg_2_0, arg_2_1)
	local var_2_0

	if HeroGroupTrialModel.instance:isOnlyUseTrial() then
		var_2_0 = {}
	else
		var_2_0 = tabletool.copy(CharacterBackpackCardListModel.instance:getCharacterCardList())
	end

	local var_2_1 = {}
	local var_2_2 = {}

	arg_2_0._inTeamHeroUids = {}

	local var_2_3 = 1
	local var_2_4 = 1
	local var_2_5 = Season166HeroSingleGroupModel.instance:getList()
	local var_2_6 = Season166HeroSingleGroupModel.instance.assistMO

	for iter_2_0, iter_2_1 in ipairs(var_2_5) do
		if iter_2_1.trial or not iter_2_1.aid and tonumber(iter_2_1.heroUid) > 0 and not var_2_2[iter_2_1.heroUid] then
			if iter_2_1.trial then
				table.insert(var_2_1, HeroGroupTrialModel.instance:getById(iter_2_1.heroUid))
			elseif var_2_6 and iter_2_1.heroUid == var_2_6.heroUid then
				table.insert(var_2_1, var_2_6:getHeroMO())
			else
				table.insert(var_2_1, HeroModel.instance:getById(iter_2_1.heroUid))
			end

			if arg_2_0.specialHero == iter_2_1.heroUid then
				arg_2_0._inTeamHeroUids[iter_2_1.heroUid] = 2
				var_2_3 = var_2_4
			else
				arg_2_0._inTeamHeroUids[iter_2_1.heroUid] = 1
				var_2_4 = var_2_4 + 1
			end

			var_2_2[iter_2_1.heroUid] = true
		end
	end

	local var_2_7 = HeroGroupTrialModel.instance:getFilterList()

	for iter_2_2, iter_2_3 in ipairs(var_2_7) do
		if not var_2_2[iter_2_3.uid] then
			table.insert(var_2_1, iter_2_3)
		end
	end

	local var_2_8 = #var_2_1

	for iter_2_4, iter_2_5 in ipairs(var_2_0) do
		if not var_2_2[iter_2_5.uid] then
			var_2_2[iter_2_5.uid] = true

			table.insert(var_2_1, iter_2_5)
		end
	end

	if Season166HeroGroupModel.instance:isSeason166Episode() then
		arg_2_0.sortIndexMap = {}

		for iter_2_6, iter_2_7 in ipairs(var_2_1) do
			arg_2_0.sortIndexMap[iter_2_7] = iter_2_6
		end

		table.sort(var_2_1, var_0_0.indexMapSortFunc)
	end

	arg_2_0:setList(var_2_1)

	if arg_2_1 and #var_2_1 > 0 and var_2_3 > 0 and #arg_2_0._scrollViews > 0 then
		for iter_2_8, iter_2_9 in ipairs(arg_2_0._scrollViews) do
			iter_2_9:selectCell(var_2_3, true)
		end

		if var_2_1[var_2_3] then
			return var_2_1[var_2_3]
		end
	end
end

function var_0_0.indexMapSortFunc(arg_3_0, arg_3_1)
	return var_0_0.instance.sortIndexMap[arg_3_0] < var_0_0.instance.sortIndexMap[arg_3_1]
end

function var_0_0.cancelAllSelected(arg_4_0)
	if arg_4_0._scrollViews then
		for iter_4_0, iter_4_1 in ipairs(arg_4_0._scrollViews) do
			local var_4_0 = iter_4_1:getFirstSelect()
			local var_4_1 = arg_4_0:getIndex(var_4_0)

			iter_4_1:selectCell(var_4_1, false)
		end
	end
end

function var_0_0.isInTeamHero(arg_5_0, arg_5_1)
	return arg_5_0._inTeamHeroUids and arg_5_0._inTeamHeroUids[arg_5_1]
end

function var_0_0.getEquipMOByHeroUid(arg_6_0, arg_6_1)
	local var_6_0 = Season166HeroGroupModel.instance:getCurGroupMO()

	if not var_6_0 then
		return
	end

	local var_6_1 = tabletool.indexOf(var_6_0.heroList, arg_6_1)

	if var_6_1 then
		local var_6_2 = var_6_0:getPosEquips(var_6_1 - 1)

		if var_6_2 and var_6_2.equipUid and #var_6_2.equipUid > 0 then
			local var_6_3 = var_6_2.equipUid[1]

			if var_6_3 and var_6_3 ~= Season166Enum.EmptyUid then
				return EquipModel.instance:getEquip(var_6_3)
			end
		end
	end
end

function var_0_0.getAssistHeroList(arg_7_0)
	local var_7_0 = {}
	local var_7_1 = Season166HeroSingleGroupModel.instance.assistMO

	if var_7_1 and Season166HeroGroupModel.instance:isSeason166Episode(arg_7_0.episodeId) then
		table.insert(var_7_0, var_7_1:getHeroMO())
	end

	return var_7_0
end

function var_0_0.isRepeatHero(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0._inTeamHeroUids then
		return false
	end

	for iter_8_0 in pairs(arg_8_0._inTeamHeroUids) do
		local var_8_0 = arg_8_0:getById(iter_8_0)

		if var_8_0 and var_8_0.heroId == arg_8_1 and arg_8_2 ~= var_8_0.uid then
			return true
		end
	end

	return false
end

function var_0_0.isTrialLimit(arg_9_0)
	if not arg_9_0._inTeamHeroUids then
		return false
	end

	local var_9_0 = 0

	for iter_9_0 in pairs(arg_9_0._inTeamHeroUids) do
		if arg_9_0:getById(iter_9_0):isTrial() then
			var_9_0 = var_9_0 + 1
		end
	end

	return var_9_0 >= HeroGroupTrialModel.instance:getLimitNum()
end

function var_0_0.setParam(arg_10_0, arg_10_1)
	arg_10_0.specialHero = arg_10_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
