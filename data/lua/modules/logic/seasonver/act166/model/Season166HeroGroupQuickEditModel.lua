module("modules.logic.seasonver.act166.model.Season166HeroGroupQuickEditModel", package.seeall)

local var_0_0 = class("Season166HeroGroupQuickEditModel", ListScrollModel)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.activityId = arg_1_1
	arg_1_0.episodeId = arg_1_2
	arg_1_0.episodeCO = DungeonConfig.instance:getEpisodeCO(arg_1_0.episodeId)
end

function var_0_0.copyQuickEditCardList(arg_2_0)
	local var_2_0

	if HeroGroupTrialModel.instance:isOnlyUseTrial() then
		var_2_0 = {}
	else
		var_2_0 = tabletool.copy(CharacterBackpackCardListModel.instance:getCharacterCardList())
	end

	local var_2_1 = {}
	local var_2_2 = {}

	arg_2_0._inTeamHeroUidMap = {}
	arg_2_0._inTeamHeroUidList = {}
	arg_2_0._originalHeroUidList = {}
	arg_2_0._selectUid = nil

	local var_2_3 = Season166HeroGroupModel.instance:getCurGroupMO()

	for iter_2_0, iter_2_1 in ipairs(var_2_3.heroList) do
		local var_2_4 = Season166HeroGroupModel.instance:isPositionOpen(iter_2_0)

		if tonumber(iter_2_1) > 0 and not var_2_2[iter_2_1] then
			local var_2_5 = arg_2_0:getHeroMO(iter_2_1)

			table.insert(var_2_1, var_2_5)

			if var_2_4 then
				arg_2_0._inTeamHeroUidMap[iter_2_1] = 1
			end

			var_2_2[iter_2_1] = true
		else
			local var_2_6 = Season166HeroSingleGroupModel.instance:getByIndex(iter_2_0)

			if var_2_6 and var_2_6.trial then
				table.insert(var_2_1, HeroGroupTrialModel.instance:getById(iter_2_1))

				if var_2_4 then
					arg_2_0._inTeamHeroUidMap[iter_2_1] = 1
				end

				var_2_2[iter_2_1] = true
			end
		end

		if var_2_4 then
			table.insert(arg_2_0._inTeamHeroUidList, iter_2_1)
			table.insert(arg_2_0._originalHeroUidList, iter_2_1)
		end
	end

	local var_2_7 = HeroGroupTrialModel.instance:getFilterList()

	for iter_2_2, iter_2_3 in ipairs(var_2_7) do
		if not var_2_2[iter_2_3.uid] then
			table.insert(var_2_1, iter_2_3)
		end
	end

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
end

function var_0_0.indexMapSortFunc(arg_3_0, arg_3_1)
	return var_0_0.instance.sortIndexMap[arg_3_0] < var_0_0.instance.sortIndexMap[arg_3_1]
end

function var_0_0.getHeroMO(arg_4_0, arg_4_1)
	local var_4_0 = HeroModel.instance:getById(arg_4_1)
	local var_4_1 = Season166HeroGroupModel.instance:isSeason166TrainEpisode(arg_4_0.episodeId)

	if not var_4_0 and var_4_1 then
		local var_4_2 = Season166HeroSingleGroupModel.instance.assistMO

		if var_4_2 and var_4_2.heroUid == arg_4_1 then
			return var_4_2:getHeroMO()
		end
	else
		return var_4_0
	end
end

function var_0_0.keepSelect(arg_5_0, arg_5_1)
	arg_5_0._selectIndex = arg_5_1

	local var_5_0 = arg_5_0:getList()

	if #arg_5_0._scrollViews > 0 then
		for iter_5_0, iter_5_1 in ipairs(arg_5_0._scrollViews) do
			iter_5_1:selectCell(arg_5_1, true)
		end

		if var_5_0[arg_5_1] then
			return var_5_0[arg_5_1]
		end
	end
end

function var_0_0.isInTeamHero(arg_6_0, arg_6_1)
	return arg_6_0._inTeamHeroUidMap and arg_6_0._inTeamHeroUidMap[arg_6_1]
end

function var_0_0.getHeroTeamPos(arg_7_0, arg_7_1)
	if arg_7_0._inTeamHeroUidList then
		for iter_7_0, iter_7_1 in ipairs(arg_7_0._inTeamHeroUidList) do
			if iter_7_1 == arg_7_1 then
				return iter_7_0
			end
		end
	end

	return 0
end

function var_0_0.selectHero(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getHeroTeamPos(arg_8_1)

	if var_8_0 ~= 0 then
		arg_8_0._inTeamHeroUidList[var_8_0] = "0"
		arg_8_0._inTeamHeroUidMap[arg_8_1] = nil

		arg_8_0:onModelUpdate()

		arg_8_0._selectUid = nil

		return true
	else
		local var_8_1 = 0

		for iter_8_0 = 1, #arg_8_0._inTeamHeroUidList do
			local var_8_2 = arg_8_0._inTeamHeroUidList[iter_8_0]

			if var_8_2 == 0 or var_8_2 == "0" then
				arg_8_0._inTeamHeroUidList[iter_8_0] = arg_8_1
				arg_8_0._inTeamHeroUidMap[arg_8_1] = 1

				arg_8_0:onModelUpdate()

				return true
			end
		end

		arg_8_0._selectUid = arg_8_1
	end

	return false
end

function var_0_0.isRepeatHero(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_0._inTeamHeroUidMap then
		return false
	end

	for iter_9_0 in pairs(arg_9_0._inTeamHeroUidMap) do
		local var_9_0 = arg_9_0:getById(iter_9_0)

		if var_9_0 and var_9_0.heroId == arg_9_1 and arg_9_2 ~= var_9_0.uid then
			return true
		end
	end

	return false
end

function var_0_0.isTrialLimit(arg_10_0)
	if not arg_10_0._inTeamHeroUidMap then
		return false
	end

	local var_10_0 = 0

	for iter_10_0 in pairs(arg_10_0._inTeamHeroUidMap) do
		if arg_10_0:getById(iter_10_0):isTrial() then
			var_10_0 = var_10_0 + 1
		end
	end

	return var_10_0 >= HeroGroupTrialModel.instance:getLimitNum()
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
	for iter_15_0 = 1, #arg_15_0._inTeamHeroUidList do
		if arg_15_0._inTeamHeroUidList[iter_15_0] == "0" then
			return false
		end
	end

	return true
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
