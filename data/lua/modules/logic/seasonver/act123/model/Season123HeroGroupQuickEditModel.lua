module("modules.logic.seasonver.act123.model.Season123HeroGroupQuickEditModel", package.seeall)

local var_0_0 = class("Season123HeroGroupQuickEditModel", ListScrollModel)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.activityId = arg_1_1
	arg_1_0.layer = arg_1_2
	arg_1_0.episodeId = arg_1_3
	arg_1_0.episodeCO = DungeonConfig.instance:getEpisodeCO(arg_1_0.episodeId)
	arg_1_0.stage = arg_1_4
end

function var_0_0.copyQuickEditCardList(arg_2_0)
	local var_2_0 = tabletool.copy(CharacterBackpackCardListModel.instance:getCharacterCardList())
	local var_2_1 = Season123Model.instance:getAssistData(arg_2_0.activityId, arg_2_0.stage)

	if var_2_1 and Season123Controller.isEpisodeFromSeason123(arg_2_0.episodeId) and Season123HeroGroupModel.instance:isEpisodeSeason123() then
		table.insert(var_2_0, var_2_1)
	end

	local var_2_2 = {}
	local var_2_3 = {}

	arg_2_0._inTeamHeroUidMap = {}
	arg_2_0._inTeamHeroUidList = {}
	arg_2_0._originalHeroUidList = {}
	arg_2_0._selectUid = nil

	local var_2_4 = HeroGroupModel.instance:getCurGroupMO()

	for iter_2_0, iter_2_1 in ipairs(var_2_4.heroList) do
		local var_2_5 = HeroGroupModel.instance:isPositionOpen(iter_2_0)

		if iter_2_1 ~= "0" and not var_2_3[iter_2_1] then
			local var_2_6 = Season123HeroUtils.getHeroMO(arg_2_0.activityId, iter_2_1, arg_2_0.stage)

			if arg_2_0:checkSeasonBox(var_2_6) then
				table.insert(var_2_2, var_2_6)

				if var_2_5 then
					arg_2_0._inTeamHeroUidMap[iter_2_1] = 1
				end

				var_2_3[iter_2_1] = true
			end
		end

		if var_2_5 then
			table.insert(arg_2_0._inTeamHeroUidList, iter_2_1)
			table.insert(arg_2_0._originalHeroUidList, iter_2_1)
		end
	end

	local var_2_7 = {}

	for iter_2_2, iter_2_3 in ipairs(var_2_0) do
		if not var_2_3[iter_2_3.uid] and arg_2_0:checkSeasonBox(iter_2_3) then
			var_2_3[iter_2_3.uid] = true

			table.insert(var_2_2, iter_2_3)
		end
	end

	if arg_2_0.adventure then
		tabletool.addValues(var_2_2, var_2_7)
	end

	if Season123HeroGroupModel.instance:isEpisodeSeason123() then
		arg_2_0.sortIndexMap = {}

		for iter_2_4, iter_2_5 in ipairs(var_2_2) do
			arg_2_0.sortIndexMap[iter_2_5] = iter_2_4
		end

		table.sort(var_2_2, var_0_0.sortDead)
	end

	arg_2_0:setList(var_2_2)
end

function var_0_0.sortDead(arg_3_0, arg_3_1)
	local var_3_0 = var_0_0.instance:getHeroIsDead(arg_3_0)
	local var_3_1 = var_0_0.instance:getHeroIsDead(arg_3_1)

	if var_3_0 ~= var_3_1 then
		return var_3_1
	else
		return Season123HeroGroupEditModel.instance.sortIndexMap[arg_3_0] < Season123HeroGroupEditModel.instance.sortIndexMap[arg_3_1]
	end
end

function var_0_0.getHeroIsDead(arg_4_0, arg_4_1)
	if Season123HeroGroupModel.instance:isEpisodeSeason123() then
		local var_4_0 = false
		local var_4_1 = arg_4_0.activityId
		local var_4_2 = arg_4_0.stage
		local var_4_3 = arg_4_0.layer
		local var_4_4 = Season123Model.instance:getSeasonHeroMO(var_4_1, var_4_2, var_4_3, arg_4_1.uid)

		if var_4_4 ~= nil then
			var_4_0 = var_4_4.hpRate <= 0
		end

		return var_4_0
	end

	return false
end

function var_0_0.checkSeasonBox(arg_5_0, arg_5_1)
	if arg_5_0.episodeCO then
		if arg_5_0.episodeCO.type == DungeonEnum.EpisodeType.Season123 then
			return Season123Model.instance:getSeasonHeroMO(arg_5_0.activityId, arg_5_0.stage, arg_5_0.layer, arg_5_1.uid)
		else
			return true
		end
	end

	return false
end

function var_0_0.keepSelect(arg_6_0, arg_6_1)
	arg_6_0._selectIndex = arg_6_1

	local var_6_0 = arg_6_0:getList()

	if #arg_6_0._scrollViews > 0 then
		for iter_6_0, iter_6_1 in ipairs(arg_6_0._scrollViews) do
			iter_6_1:selectCell(arg_6_1, true)
		end

		if var_6_0[arg_6_1] then
			return var_6_0[arg_6_1]
		end
	end
end

function var_0_0.isInTeamHero(arg_7_0, arg_7_1)
	return arg_7_0._inTeamHeroUidMap and arg_7_0._inTeamHeroUidMap[arg_7_1]
end

function var_0_0.getHeroTeamPos(arg_8_0, arg_8_1)
	if arg_8_0._inTeamHeroUidList then
		for iter_8_0, iter_8_1 in pairs(arg_8_0._inTeamHeroUidList) do
			if iter_8_1 == arg_8_1 then
				return iter_8_0
			end
		end
	end

	return 0
end

function var_0_0.selectHero(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:getHeroTeamPos(arg_9_1)

	if var_9_0 ~= 0 then
		arg_9_0._inTeamHeroUidList[var_9_0] = "0"
		arg_9_0._inTeamHeroUidMap[arg_9_1] = nil

		arg_9_0:onModelUpdate()

		arg_9_0._selectUid = nil

		return true
	else
		local var_9_1 = 0

		for iter_9_0 = 1, #arg_9_0._inTeamHeroUidList do
			local var_9_2 = arg_9_0._inTeamHeroUidList[iter_9_0]

			if var_9_2 == 0 or var_9_2 == "0" then
				arg_9_0._inTeamHeroUidList[iter_9_0] = arg_9_1
				arg_9_0._inTeamHeroUidMap[arg_9_1] = 1

				arg_9_0:onModelUpdate()

				return true
			end
		end

		arg_9_0._selectUid = arg_9_1
	end

	return false
end

function var_0_0.getHeroUids(arg_10_0)
	return arg_10_0._inTeamHeroUidList
end

function var_0_0.getHeroUidByPos(arg_11_0, arg_11_1)
	return arg_11_0._inTeamHeroUidList[arg_11_1]
end

function var_0_0.getIsDirty(arg_12_0)
	for iter_12_0 = 1, #arg_12_0._inTeamHeroUidList do
		if arg_12_0._inTeamHeroUidList[iter_12_0] ~= arg_12_0._originalHeroUidList[iter_12_0] then
			return true
		end
	end

	return false
end

function var_0_0.cancelAllSelected(arg_13_0)
	if arg_13_0._scrollViews then
		for iter_13_0, iter_13_1 in ipairs(arg_13_0._scrollViews) do
			local var_13_0 = iter_13_1:getFirstSelect()
			local var_13_1 = arg_13_0:getIndex(var_13_0)

			iter_13_1:selectCell(var_13_1, false)
		end
	end
end

function var_0_0.isTeamFull(arg_14_0)
	for iter_14_0 = 1, #arg_14_0._inTeamHeroUidList do
		local var_14_0 = HeroGroupModel.instance:isPositionOpen(iter_14_0)

		if arg_14_0._inTeamHeroUidList[iter_14_0] == "0" and var_14_0 then
			return false
		end
	end

	return true
end

function var_0_0.setParam(arg_15_0, arg_15_1)
	arg_15_0.adventure = arg_15_1
end

function var_0_0.clear(arg_16_0)
	arg_16_0._inTeamHeroUidMap = nil
	arg_16_0._inTeamHeroUidList = nil
	arg_16_0._originalHeroUidList = nil
	arg_16_0._selectIndex = nil
	arg_16_0._selectUid = nil

	var_0_0.super.clear(arg_16_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
