module("modules.logic.seasonver.act123.model.Season123HeroGroupEditModel", package.seeall)

local var_0_0 = class("Season123HeroGroupEditModel", ListScrollModel)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.activityId = arg_1_1
	arg_1_0.layer = arg_1_2
	arg_1_0.episodeId = arg_1_3
	arg_1_0.episodeCO = DungeonConfig.instance:getEpisodeCO(arg_1_0.episodeId)
	arg_1_0.stage = arg_1_4
end

function var_0_0.setMoveHeroId(arg_2_0, arg_2_1)
	arg_2_0._moveHeroId = arg_2_1
end

function var_0_0.getMoveHeroIndex(arg_3_0)
	return arg_3_0._moveHeroIndex
end

function var_0_0.copyCharacterCardList(arg_4_0, arg_4_1)
	local var_4_0 = tabletool.copy(CharacterBackpackCardListModel.instance:getCharacterCardList())
	local var_4_1 = Season123Model.instance:getAssistData(arg_4_0.activityId, arg_4_0.stage)

	if var_4_1 and Season123Controller.isEpisodeFromSeason123(arg_4_0.episodeId) and Season123HeroGroupModel.instance:isEpisodeSeason123() then
		table.insert(var_4_0, var_4_1)
	end

	local var_4_2 = {}
	local var_4_3 = {}

	arg_4_0._inTeamHeroUids = {}

	local var_4_4 = 0
	local var_4_5 = 1
	local var_4_6 = HeroSingleGroupModel.instance:getList()

	for iter_4_0, iter_4_1 in ipairs(var_4_6) do
		local var_4_7 = iter_4_1.heroUid

		if not iter_4_1.aid and tonumber(var_4_7) > 0 and not var_4_3[var_4_7] then
			local var_4_8 = Season123HeroUtils.getHeroMO(arg_4_0.activityId, var_4_7, arg_4_0.stage)

			if arg_4_0:checkSeasonBox(var_4_8) then
				table.insert(var_4_2, var_4_8)

				if arg_4_0.specialHero == var_4_7 then
					arg_4_0._inTeamHeroUids[var_4_7] = 2
					var_4_4 = var_4_5
				else
					arg_4_0._inTeamHeroUids[var_4_7] = 1
					var_4_5 = var_4_5 + 1
				end

				var_4_3[var_4_7] = true
			end
		end
	end

	for iter_4_2, iter_4_3 in ipairs(var_4_2) do
		if arg_4_0._moveHeroId and iter_4_3.heroId == arg_4_0._moveHeroId then
			arg_4_0._moveHeroId = nil
			arg_4_0._moveHeroIndex = iter_4_2

			break
		end
	end

	local var_4_9 = #var_4_2

	for iter_4_4, iter_4_5 in ipairs(var_4_0) do
		if not var_4_3[iter_4_5.uid] and arg_4_0:checkSeasonBox(iter_4_5) then
			var_4_3[iter_4_5.uid] = true

			if arg_4_0._moveHeroId and iter_4_5.heroId == arg_4_0._moveHeroId then
				arg_4_0._moveHeroId = nil
				arg_4_0._moveHeroIndex = var_4_9 + 1

				table.insert(var_4_2, arg_4_0._moveHeroIndex, iter_4_5)
			else
				table.insert(var_4_2, iter_4_5)
			end
		end
	end

	if Season123HeroGroupModel.instance:isEpisodeSeason123() then
		arg_4_0.sortIndexMap = {}

		for iter_4_6, iter_4_7 in ipairs(var_4_2) do
			arg_4_0.sortIndexMap[iter_4_7] = iter_4_6
		end

		table.sort(var_4_2, var_0_0.sortDead)
	end

	arg_4_0:setList(var_4_2)

	if arg_4_1 and #var_4_2 > 0 and var_4_4 > 0 and #arg_4_0._scrollViews > 0 then
		for iter_4_8, iter_4_9 in ipairs(arg_4_0._scrollViews) do
			iter_4_9:selectCell(var_4_4, true)
		end

		if var_4_2[var_4_4] then
			return var_4_2[var_4_4]
		end
	end
end

function var_0_0.sortDead(arg_5_0, arg_5_1)
	local var_5_0 = var_0_0.instance:getHeroIsDead(arg_5_0)
	local var_5_1 = var_0_0.instance:getHeroIsDead(arg_5_1)

	if var_5_0 ~= var_5_1 then
		return var_5_1
	else
		return var_0_0.instance.sortIndexMap[arg_5_0] < var_0_0.instance.sortIndexMap[arg_5_1]
	end
end

function var_0_0.getHeroIsDead(arg_6_0, arg_6_1)
	if Season123HeroGroupModel.instance:isEpisodeSeason123() then
		local var_6_0 = false
		local var_6_1 = arg_6_0.activityId
		local var_6_2 = arg_6_0.stage
		local var_6_3 = arg_6_0.layer
		local var_6_4 = Season123Model.instance:getSeasonHeroMO(var_6_1, var_6_2, var_6_3, arg_6_1.uid)

		if var_6_4 ~= nil then
			var_6_0 = var_6_4.hpRate <= 0
		end

		return var_6_0
	end

	return false
end

function var_0_0.checkSeasonBox(arg_7_0, arg_7_1)
	if arg_7_0.episodeCO then
		if arg_7_0.episodeCO.type == DungeonEnum.EpisodeType.Season123 then
			return Season123Model.instance:getSeasonHeroMO(arg_7_0.activityId, arg_7_0.stage, arg_7_0.layer, arg_7_1.uid)
		else
			return true
		end
	end

	return false
end

function var_0_0.cancelAllSelected(arg_8_0)
	if arg_8_0._scrollViews then
		for iter_8_0, iter_8_1 in ipairs(arg_8_0._scrollViews) do
			local var_8_0 = iter_8_1:getFirstSelect()
			local var_8_1 = arg_8_0:getIndex(var_8_0)

			iter_8_1:selectCell(var_8_1, false)
		end
	end
end

function var_0_0.isInTeamHero(arg_9_0, arg_9_1)
	return arg_9_0._inTeamHeroUids and arg_9_0._inTeamHeroUids[arg_9_1]
end

function var_0_0.setParam(arg_10_0, arg_10_1)
	arg_10_0.specialHero = arg_10_1
end

function var_0_0.getEquipMOByHeroUid(arg_11_0, arg_11_1)
	local var_11_0 = HeroGroupModel.instance:getCurGroupMO()

	if not var_11_0 then
		return
	end

	local var_11_1 = tabletool.indexOf(var_11_0.heroList, arg_11_1)

	if var_11_1 then
		local var_11_2 = var_11_0:getPosEquips(var_11_1 - 1)

		if var_11_2 and var_11_2.equipUid and #var_11_2.equipUid > 0 then
			local var_11_3 = var_11_2.equipUid[1]

			if var_11_3 and var_11_3 ~= Activity123Enum.EmptyUid then
				return EquipModel.instance:getEquip(var_11_3)
			end
		end
	end
end

function var_0_0.getAssistHeroList(arg_12_0)
	local var_12_0 = {}
	local var_12_1 = Season123Model.instance:getAssistData(arg_12_0.activityId, arg_12_0.stage)

	if var_12_1 and Season123Controller.isEpisodeFromSeason123(arg_12_0.episodeId) then
		table.insert(var_12_0, var_12_1)
	end

	return var_12_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
