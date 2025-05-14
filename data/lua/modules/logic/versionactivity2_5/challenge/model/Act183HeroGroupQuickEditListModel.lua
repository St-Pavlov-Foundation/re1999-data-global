module("modules.logic.versionactivity2_5.challenge.model.Act183HeroGroupQuickEditListModel", package.seeall)

local var_0_0 = class("Act183HeroGroupQuickEditListModel", MixScrollModel)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.activityId = arg_1_1
	arg_1_0.episodeId = arg_1_2
	arg_1_0.episodeCo = DungeonConfig.instance:getEpisodeCO(arg_1_0.episodeId)
	arg_1_0.challengeEpisodeCo = Act183Config.instance:getEpisodeCo(arg_1_0.episodeId)
	arg_1_0.groupEpisodeMo = Act183Model.instance:getGroupEpisodeMo(arg_1_0.challengeEpisodeCo.groupId)
	arg_1_0.groupEpisodeType = arg_1_0.groupEpisodeMo and arg_1_0.groupEpisodeMo:getGroupType()
end

function var_0_0.copyQuickEditCardList(arg_2_0)
	local var_2_0

	if HeroGroupTrialModel.instance:isOnlyUseTrial() then
		var_2_0 = {}
	else
		var_2_0 = CharacterBackpackCardListModel.instance:getCharacterCardList()
	end

	local var_2_1 = {}
	local var_2_2 = {}

	arg_2_0._inTeamHeroUidMap = {}
	arg_2_0._inTeamHeroUidList = {}
	arg_2_0._originalHeroUidList = {}
	arg_2_0._selectUid = nil

	local var_2_3 = HeroSingleGroupModel.instance:getList()

	for iter_2_0, iter_2_1 in ipairs(var_2_3) do
		local var_2_4 = Act183Helper.isHeroGroupPositionOpen(arg_2_0.episodeId, iter_2_0)
		local var_2_5 = iter_2_1.heroUid

		if tonumber(var_2_5) > 0 and not var_2_2[var_2_5] then
			table.insert(var_2_1, HeroModel.instance:getById(var_2_5))

			if var_2_4 then
				arg_2_0._inTeamHeroUidMap[var_2_5] = 1
			end

			var_2_2[var_2_5] = true
		elseif HeroSingleGroupModel.instance:getByIndex(iter_2_0).trial then
			table.insert(var_2_1, HeroGroupTrialModel.instance:getById(var_2_5))

			if var_2_4 then
				arg_2_0._inTeamHeroUidMap[var_2_5] = 1
			end

			var_2_2[var_2_5] = true
		end

		if var_2_4 then
			table.insert(arg_2_0._inTeamHeroUidList, var_2_5)
			table.insert(arg_2_0._originalHeroUidList, var_2_5)
		end
	end

	local var_2_6 = HeroGroupTrialModel.instance:getFilterList()

	for iter_2_2, iter_2_3 in ipairs(var_2_6) do
		if not var_2_2[iter_2_3.uid] then
			table.insert(var_2_1, iter_2_3)
		end
	end

	local var_2_7 = arg_2_0.isTowerBattle
	local var_2_8 = {}

	for iter_2_4, iter_2_5 in ipairs(var_2_0) do
		if not var_2_2[iter_2_5.uid] then
			var_2_2[iter_2_5.uid] = true

			if arg_2_0.adventure then
				if WeekWalkModel.instance:getCurMapHeroCd(iter_2_5.heroId) > 0 then
					table.insert(var_2_8, iter_2_5)
				else
					table.insert(var_2_1, iter_2_5)
				end
			elseif var_2_7 then
				if TowerModel.instance:isHeroBan(iter_2_5.heroId) then
					table.insert(var_2_8, iter_2_5)
				else
					table.insert(var_2_1, iter_2_5)
				end
			else
				table.insert(var_2_1, iter_2_5)
			end
		end
	end

	if arg_2_0.adventure or var_2_7 then
		tabletool.addValues(var_2_1, var_2_8)
	end

	arg_2_0.sortIndexMap = {}

	for iter_2_6, iter_2_7 in ipairs(var_2_1) do
		arg_2_0.sortIndexMap[iter_2_7] = iter_2_6
	end

	table.sort(var_2_1, arg_2_0.indexMapSortFunc)
	arg_2_0:setList(var_2_1)
end

function var_0_0.indexMapSortFunc(arg_3_0, arg_3_1)
	local var_3_0 = var_0_0.instance.episodeId
	local var_3_1 = Act183Model.instance:isHeroRepressInPreEpisode(var_3_0, arg_3_0.heroId)

	if var_3_1 ~= Act183Model.instance:isHeroRepressInPreEpisode(var_3_0, arg_3_1.heroId) then
		return not var_3_1
	end

	return var_0_0.instance.sortIndexMap[arg_3_0] < var_0_0.instance.sortIndexMap[arg_3_1]
end

function var_0_0.keepSelect(arg_4_0, arg_4_1)
	arg_4_0._selectIndex = arg_4_1

	local var_4_0 = arg_4_0:getList()

	if #arg_4_0._scrollViews > 0 then
		for iter_4_0, iter_4_1 in ipairs(arg_4_0._scrollViews) do
			iter_4_1:selectCell(arg_4_1, true)
		end

		if var_4_0[arg_4_1] then
			return var_4_0[arg_4_1]
		end
	end
end

function var_0_0.isInTeamHero(arg_5_0, arg_5_1)
	return arg_5_0._inTeamHeroUidMap and arg_5_0._inTeamHeroUidMap[arg_5_1]
end

function var_0_0.getHeroTeamPos(arg_6_0, arg_6_1)
	if arg_6_0._inTeamHeroUidList then
		for iter_6_0, iter_6_1 in pairs(arg_6_0._inTeamHeroUidList) do
			if iter_6_1 == arg_6_1 then
				return iter_6_0
			end
		end
	end

	return 0
end

function var_0_0.selectHero(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getHeroTeamPos(arg_7_1)

	if var_7_0 ~= 0 then
		arg_7_0._inTeamHeroUidList[var_7_0] = "0"
		arg_7_0._inTeamHeroUidMap[arg_7_1] = nil

		arg_7_0:onModelUpdate()

		arg_7_0._selectUid = nil

		return true
	else
		if arg_7_0:isTeamFull() then
			return false
		end

		local var_7_1 = 0

		for iter_7_0 = 1, #arg_7_0._inTeamHeroUidList do
			local var_7_2 = arg_7_0._inTeamHeroUidList[iter_7_0]

			if var_7_2 == 0 or var_7_2 == "0" then
				arg_7_0._inTeamHeroUidList[iter_7_0] = arg_7_1
				arg_7_0._inTeamHeroUidMap[arg_7_1] = 1

				arg_7_0:onModelUpdate()

				return true
			end
		end

		arg_7_0._selectUid = arg_7_1
	end

	return false
end

function var_0_0.isRepeatHero(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0._inTeamHeroUidMap then
		return false
	end

	for iter_8_0 in pairs(arg_8_0._inTeamHeroUidMap) do
		local var_8_0 = arg_8_0:getById(iter_8_0)

		if var_8_0.heroId == arg_8_1 and arg_8_2 ~= var_8_0.uid then
			return true
		end
	end

	return false
end

function var_0_0.isTrialLimit(arg_9_0)
	if not arg_9_0._inTeamHeroUidMap then
		return false
	end

	local var_9_0 = 0

	for iter_9_0 in pairs(arg_9_0._inTeamHeroUidMap) do
		if arg_9_0:getById(iter_9_0):isTrial() then
			var_9_0 = var_9_0 + 1
		end
	end

	return var_9_0 >= (arg_9_0.episodeCo and arg_9_0.episodeCo.roleNum or ModuleEnum.MaxHeroCountInGroup)
end

function var_0_0.inInTeam(arg_10_0, arg_10_1)
	if not arg_10_0._inTeamHeroUidMap then
		return false
	end

	return arg_10_0._inTeamHeroUidMap[arg_10_1] and true or false
end

function var_0_0.getHeroUids(arg_11_0)
	return arg_11_0._inTeamHeroUidList
end

function var_0_0.getHeroUidByPos(arg_12_0, arg_12_1)
	return arg_12_0._inTeamHeroUidList[arg_12_1]
end

function var_0_0.getIsDirty(arg_13_0)
	for iter_13_0 = 1, #arg_13_0._inTeamHeroUidList do
		if arg_13_0._inTeamHeroUidList[iter_13_0] ~= arg_13_0._originalHeroUidList[iter_13_0] then
			return true
		end
	end

	return false
end

function var_0_0.cancelAllSelected(arg_14_0)
	if arg_14_0._scrollViews then
		for iter_14_0, iter_14_1 in ipairs(arg_14_0._scrollViews) do
			local var_14_0 = iter_14_1:getFirstSelect()
			local var_14_1 = arg_14_0:getIndex(var_14_0)

			iter_14_1:selectCell(var_14_1, false)
		end
	end
end

function var_0_0.isTeamFull(arg_15_0)
	local var_15_0 = HeroGroupModel.instance:getBattleRoleNum() or 0

	for iter_15_0 = 1, math.min(var_15_0, #arg_15_0._inTeamHeroUidList) do
		local var_15_1 = Act183Helper.isHeroGroupPositionOpen(arg_15_0.episodeId, iter_15_0)

		if arg_15_0._inTeamHeroUidList[iter_15_0] == "0" and var_15_1 then
			return false
		end
	end

	return true
end

function var_0_0.checkHeroIsError(arg_16_0, arg_16_1)
	if not arg_16_1 or tonumber(arg_16_1) < 0 then
		return
	end

	local var_16_0 = HeroModel.instance:getById(arg_16_1)

	if not var_16_0 then
		return
	end

	if arg_16_0.adventure then
		if WeekWalkModel.instance:getCurMapHeroCd(var_16_0.heroId) > 0 then
			return true
		end
	elseif arg_16_0.isTowerBattle and TowerModel.instance:isHeroBan(var_16_0.heroId) then
		return true
	end
end

function var_0_0.cancelAllErrorSelected(arg_17_0)
	local var_17_0 = false

	for iter_17_0, iter_17_1 in pairs(arg_17_0._inTeamHeroUidList) do
		if arg_17_0:checkHeroIsError(iter_17_1) then
			var_17_0 = true

			break
		end
	end

	if var_17_0 then
		arg_17_0._inTeamHeroUidList = {}
	end
end

function var_0_0.setParam(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0.adventure = arg_18_1
	arg_18_0.isTowerBattle = arg_18_2
end

function var_0_0.clear(arg_19_0)
	arg_19_0._inTeamHeroUidMap = nil
	arg_19_0._inTeamHeroUidList = nil
	arg_19_0._originalHeroUidList = nil
	arg_19_0._selectIndex = nil
	arg_19_0._selectUid = nil

	var_0_0.super.clear(arg_19_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
