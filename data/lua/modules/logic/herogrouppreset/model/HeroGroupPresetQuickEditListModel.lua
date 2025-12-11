module("modules.logic.herogrouppreset.model.HeroGroupPresetQuickEditListModel", package.seeall)

local var_0_0 = class("HeroGroupPresetQuickEditListModel", ListScrollModel)

function var_0_0.copyQuickEditCardList(arg_1_0)
	local var_1_0

	if HeroGroupTrialModel.instance:isOnlyUseTrial() then
		var_1_0 = {}
	else
		var_1_0 = CharacterBackpackCardListModel.instance:getCharacterCardList()
	end

	local var_1_1 = {}
	local var_1_2 = {}

	arg_1_0._inTeamHeroUidMap = {}
	arg_1_0._inTeamHeroUidList = {}
	arg_1_0._originalHeroUidList = {}
	arg_1_0._selectUid = nil

	local var_1_3 = HeroGroupPresetSingleGroupModel.instance:getList()

	for iter_1_0, iter_1_1 in ipairs(var_1_3) do
		local var_1_4 = HeroGroupPresetModel.instance:isPositionOpen(iter_1_0)
		local var_1_5 = iter_1_1.heroUid

		if not HeroGroupPresetController.instance:useTrial() and tonumber(var_1_5) < 0 then
			var_1_5 = "0"
		end

		if tonumber(var_1_5) > 0 and not var_1_2[var_1_5] then
			table.insert(var_1_1, HeroModel.instance:getById(var_1_5))

			if var_1_4 then
				arg_1_0._inTeamHeroUidMap[var_1_5] = 1
			end

			var_1_2[var_1_5] = true
		elseif HeroGroupPresetSingleGroupModel.instance:getByIndex(iter_1_0).trial and HeroGroupPresetController.instance:useTrial() then
			table.insert(var_1_1, HeroGroupTrialModel.instance:getById(var_1_5))

			if var_1_4 then
				arg_1_0._inTeamHeroUidMap[var_1_5] = 1
			end

			var_1_2[var_1_5] = true
		end

		if var_1_4 then
			table.insert(arg_1_0._inTeamHeroUidList, var_1_5)
			table.insert(arg_1_0._originalHeroUidList, var_1_5)
		end
	end

	if HeroGroupPresetController.instance:useTrial() then
		local var_1_6 = HeroGroupTrialModel.instance:getFilterList()

		for iter_1_2, iter_1_3 in ipairs(var_1_6) do
			if not var_1_2[iter_1_3.uid] then
				table.insert(var_1_1, iter_1_3)
			end
		end
	end

	local var_1_7 = arg_1_0.isTowerBattle
	local var_1_8 = arg_1_0.isWeekWalk_2
	local var_1_9 = {}

	if var_1_7 then
		for iter_1_4 = #var_1_1, 1, -1 do
			if TowerModel.instance:isHeroBan(var_1_1[iter_1_4].heroId) then
				table.insert(var_1_9, var_1_1[iter_1_4])
				table.remove(var_1_1, iter_1_4)
			end
		end
	end

	for iter_1_5, iter_1_6 in ipairs(var_1_0) do
		if not var_1_2[iter_1_6.uid] then
			var_1_2[iter_1_6.uid] = true

			if arg_1_0.adventure then
				if WeekWalkModel.instance:getCurMapHeroCd(iter_1_6.heroId) > 0 then
					table.insert(var_1_9, iter_1_6)
				else
					table.insert(var_1_1, iter_1_6)
				end
			elseif var_1_8 then
				if WeekWalk_2Model.instance:getCurMapHeroCd(iter_1_6.heroId) > 0 then
					table.insert(var_1_9, iter_1_6)
				else
					table.insert(var_1_1, iter_1_6)
				end
			elseif var_1_7 then
				if TowerModel.instance:isHeroBan(iter_1_6.heroId) then
					table.insert(var_1_9, iter_1_6)
				else
					table.insert(var_1_1, iter_1_6)
				end
			else
				table.insert(var_1_1, iter_1_6)
			end
		end
	end

	if arg_1_0.adventure or var_1_7 or var_1_8 then
		tabletool.addValues(var_1_1, var_1_9)
	end

	arg_1_0:setList(var_1_1)
end

function var_0_0.keepSelect(arg_2_0, arg_2_1)
	arg_2_0._selectIndex = arg_2_1

	local var_2_0 = arg_2_0:getList()

	if #arg_2_0._scrollViews > 0 then
		for iter_2_0, iter_2_1 in ipairs(arg_2_0._scrollViews) do
			iter_2_1:selectCell(arg_2_1, true)
		end

		if var_2_0[arg_2_1] then
			return var_2_0[arg_2_1]
		end
	end
end

function var_0_0.isInTeamHero(arg_3_0, arg_3_1)
	return arg_3_0._inTeamHeroUidMap and arg_3_0._inTeamHeroUidMap[arg_3_1]
end

function var_0_0.getHeroTeamPos(arg_4_0, arg_4_1)
	if arg_4_0._inTeamHeroUidList then
		for iter_4_0, iter_4_1 in pairs(arg_4_0._inTeamHeroUidList) do
			if iter_4_1 == arg_4_1 then
				return iter_4_0
			end
		end
	end

	return 0
end

function var_0_0.selectHero(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:getHeroTeamPos(arg_5_1)

	if var_5_0 ~= 0 then
		arg_5_0._inTeamHeroUidList[var_5_0] = "0"
		arg_5_0._inTeamHeroUidMap[arg_5_1] = nil

		arg_5_0:onModelUpdate()

		arg_5_0._selectUid = nil

		return true
	else
		if arg_5_0:isTeamFull() then
			return false
		end

		local var_5_1 = 0

		for iter_5_0 = 1, #arg_5_0._inTeamHeroUidList do
			local var_5_2 = arg_5_0._inTeamHeroUidList[iter_5_0]

			if var_5_2 == 0 or var_5_2 == "0" then
				arg_5_0._inTeamHeroUidList[iter_5_0] = arg_5_1
				arg_5_0._inTeamHeroUidMap[arg_5_1] = 1

				arg_5_0:onModelUpdate()

				return true
			end
		end

		arg_5_0._selectUid = arg_5_1
	end

	return false
end

function var_0_0.isRepeatHero(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_0._inTeamHeroUidMap then
		return false
	end

	for iter_6_0 in pairs(arg_6_0._inTeamHeroUidMap) do
		local var_6_0 = arg_6_0:getById(iter_6_0)

		if not var_6_0 then
			logError("heroId:" .. arg_6_1 .. ", " .. "uid:" .. arg_6_2 .. "数据为空")

			return false
		end

		if var_6_0.heroId == arg_6_1 and arg_6_2 ~= var_6_0.uid then
			return true
		end
	end

	return false
end

function var_0_0.isTrialLimit(arg_7_0)
	if not arg_7_0._inTeamHeroUidMap then
		return false
	end

	local var_7_0 = 0

	for iter_7_0 in pairs(arg_7_0._inTeamHeroUidMap) do
		if arg_7_0:getById(iter_7_0):isTrial() then
			var_7_0 = var_7_0 + 1
		end
	end

	return var_7_0 >= HeroGroupTrialModel.instance:getLimitNum()
end

function var_0_0.inInTeam(arg_8_0, arg_8_1)
	if not arg_8_0._inTeamHeroUidMap then
		return false
	end

	return arg_8_0._inTeamHeroUidMap[arg_8_1] and true or false
end

function var_0_0.getHeroUids(arg_9_0)
	return arg_9_0._inTeamHeroUidList
end

function var_0_0.getHeroUidByPos(arg_10_0, arg_10_1)
	return arg_10_0._inTeamHeroUidList[arg_10_1]
end

function var_0_0.getIsDirty(arg_11_0)
	for iter_11_0 = 1, #arg_11_0._inTeamHeroUidList do
		if arg_11_0._inTeamHeroUidList[iter_11_0] ~= arg_11_0._originalHeroUidList[iter_11_0] then
			return true
		end
	end

	return false
end

function var_0_0.cancelAllSelected(arg_12_0)
	if arg_12_0._scrollViews then
		for iter_12_0, iter_12_1 in ipairs(arg_12_0._scrollViews) do
			local var_12_0 = iter_12_1:getFirstSelect()
			local var_12_1 = arg_12_0:getIndex(var_12_0)

			iter_12_1:selectCell(var_12_1, false)
		end
	end
end

function var_0_0.isTeamFull(arg_13_0)
	local var_13_0 = HeroGroupPresetModel.instance:getBattleRoleNum() or 0

	for iter_13_0 = 1, math.min(var_13_0, #arg_13_0._inTeamHeroUidList) do
		local var_13_1 = HeroGroupPresetModel.instance:isPositionOpen(iter_13_0)

		if arg_13_0._inTeamHeroUidList[iter_13_0] == "0" and var_13_1 then
			return false
		end
	end

	return true
end

function var_0_0.checkHeroIsError(arg_14_0, arg_14_1)
	if not arg_14_1 or tonumber(arg_14_1) < 0 then
		return
	end

	local var_14_0 = HeroModel.instance:getById(arg_14_1)

	if not var_14_0 then
		return
	end

	if arg_14_0.adventure then
		if WeekWalkModel.instance:getCurMapHeroCd(var_14_0.heroId) > 0 then
			return true
		end
	elseif arg_14_0.isWeekWalk_2 then
		if WeekWalk_2Model.instance:getCurMapHeroCd(var_14_0.heroId) > 0 then
			return true
		end
	elseif arg_14_0.isTowerBattle and TowerModel.instance:isHeroBan(var_14_0.heroId) then
		return true
	end
end

function var_0_0.cancelAllErrorSelected(arg_15_0)
	local var_15_0 = false

	for iter_15_0, iter_15_1 in pairs(arg_15_0._inTeamHeroUidList) do
		if arg_15_0:checkHeroIsError(iter_15_1) then
			var_15_0 = true

			break
		end
	end

	if var_15_0 then
		arg_15_0._inTeamHeroUidList = {}
	end
end

function var_0_0.setParam(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	arg_16_0.adventure = arg_16_1
	arg_16_0.isTowerBattle = arg_16_2
	arg_16_0._groupType = arg_16_3
	arg_16_0.isWeekWalk_2 = arg_16_3 == HeroGroupEnum.GroupType.WeekWalk_2
end

function var_0_0.clear(arg_17_0)
	arg_17_0._inTeamHeroUidMap = nil
	arg_17_0._inTeamHeroUidList = nil
	arg_17_0._originalHeroUidList = nil
	arg_17_0._selectIndex = nil
	arg_17_0._selectUid = nil

	var_0_0.super.clear(arg_17_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
