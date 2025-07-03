module("modules.logic.herogroup.model.HeroGroupEditListModel", package.seeall)

local var_0_0 = class("HeroGroupEditListModel", ListScrollModel)

function var_0_0.setMoveHeroId(arg_1_0, arg_1_1)
	arg_1_0._moveHeroId = arg_1_1
end

function var_0_0.getMoveHeroIndex(arg_2_0)
	return arg_2_0._moveHeroIndex
end

function var_0_0.copyCharacterCardList(arg_3_0, arg_3_1)
	local var_3_0

	if HeroGroupTrialModel.instance:isOnlyUseTrial() then
		var_3_0 = {}
	else
		var_3_0 = CharacterBackpackCardListModel.instance:getCharacterCardList()
	end

	local var_3_1 = {}
	local var_3_2 = {}

	arg_3_0._inTeamHeroUids = {}

	local var_3_3 = 1
	local var_3_4 = 1
	local var_3_5 = HeroSingleGroupModel.instance:getList()

	for iter_3_0, iter_3_1 in ipairs(var_3_5) do
		if iter_3_1.trial or not iter_3_1.aid and tonumber(iter_3_1.heroUid) > 0 and not var_3_2[iter_3_1.heroUid] then
			if iter_3_1.trial then
				table.insert(var_3_1, HeroGroupTrialModel.instance:getById(iter_3_1.heroUid))
			else
				table.insert(var_3_1, HeroModel.instance:getById(iter_3_1.heroUid))
			end

			if arg_3_0.specialHero == iter_3_1.heroUid then
				arg_3_0._inTeamHeroUids[iter_3_1.heroUid] = 2
				var_3_3 = var_3_4
			else
				arg_3_0._inTeamHeroUids[iter_3_1.heroUid] = 1
				var_3_4 = var_3_4 + 1
			end

			var_3_2[iter_3_1.heroUid] = true
		end
	end

	local var_3_6 = CharacterModel.instance:getRankState()
	local var_3_7 = CharacterModel.instance:getBtnTag(CharacterEnum.FilterType.HeroGroup)

	HeroGroupTrialModel.instance:sortByLevelAndRare(var_3_7 == 1, var_3_6[var_3_7] == 1)

	local var_3_8 = HeroGroupTrialModel.instance:getFilterList()

	for iter_3_2, iter_3_3 in ipairs(var_3_8) do
		if not var_3_2[iter_3_3.uid] then
			table.insert(var_3_1, iter_3_3)
		end
	end

	for iter_3_4, iter_3_5 in ipairs(var_3_1) do
		if arg_3_0._moveHeroId and iter_3_5.heroId == arg_3_0._moveHeroId then
			arg_3_0._moveHeroId = nil
			arg_3_0._moveHeroIndex = iter_3_4

			break
		end
	end

	local var_3_9 = #var_3_1
	local var_3_10 = arg_3_0.isTowerBattle
	local var_3_11 = arg_3_0.isWeekWalk_2
	local var_3_12 = {}

	if var_3_10 then
		for iter_3_6 = #var_3_1, 1, -1 do
			if TowerModel.instance:isHeroBan(var_3_1[iter_3_6].heroId) then
				table.insert(var_3_12, var_3_1[iter_3_6])
				table.remove(var_3_1, iter_3_6)
			end
		end
	end

	for iter_3_7, iter_3_8 in ipairs(var_3_0) do
		if not var_3_2[iter_3_8.uid] then
			var_3_2[iter_3_8.uid] = true

			if arg_3_0.adventure then
				if WeekWalkModel.instance:getCurMapHeroCd(iter_3_8.heroId) > 0 then
					table.insert(var_3_12, iter_3_8)
				else
					table.insert(var_3_1, iter_3_8)
				end
			elseif var_3_11 then
				if WeekWalk_2Model.instance:getCurMapHeroCd(iter_3_8.heroId) > 0 then
					table.insert(var_3_12, iter_3_8)
				else
					table.insert(var_3_1, iter_3_8)
				end
			elseif var_3_10 then
				if TowerModel.instance:isHeroBan(iter_3_8.heroId) then
					table.insert(var_3_12, iter_3_8)
				else
					table.insert(var_3_1, iter_3_8)
				end
			elseif arg_3_0._moveHeroId and iter_3_8.heroId == arg_3_0._moveHeroId then
				arg_3_0._moveHeroId = nil
				arg_3_0._moveHeroIndex = var_3_9 + 1

				table.insert(var_3_1, arg_3_0._moveHeroIndex, iter_3_8)
			else
				table.insert(var_3_1, iter_3_8)
			end
		end
	end

	if arg_3_0.adventure or var_3_10 or var_3_11 then
		tabletool.addValues(var_3_1, var_3_12)
	end

	arg_3_0:setList(var_3_1)

	if arg_3_1 and #var_3_1 > 0 and var_3_3 > 0 and #arg_3_0._scrollViews > 0 then
		for iter_3_9, iter_3_10 in ipairs(arg_3_0._scrollViews) do
			iter_3_10:selectCell(var_3_3, true)
		end

		if var_3_1[var_3_3] then
			return var_3_1[var_3_3]
		end
	end
end

function var_0_0.isRepeatHero(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_0._inTeamHeroUids then
		return false
	end

	for iter_4_0 in pairs(arg_4_0._inTeamHeroUids) do
		local var_4_0 = arg_4_0:getById(iter_4_0)

		if not var_4_0 then
			logError("heroId:" .. arg_4_1 .. ", " .. "uid:" .. arg_4_2 .. "数据为空")

			return false
		end

		if var_4_0.heroId == arg_4_1 and arg_4_2 ~= var_4_0.uid then
			return true
		end
	end

	return false
end

function var_0_0.isTrialLimit(arg_5_0)
	if not arg_5_0._inTeamHeroUids then
		return false
	end

	local var_5_0 = 0

	for iter_5_0 in pairs(arg_5_0._inTeamHeroUids) do
		if arg_5_0:getById(iter_5_0):isTrial() then
			var_5_0 = var_5_0 + 1
		end
	end

	return var_5_0 >= HeroGroupTrialModel.instance:getLimitNum()
end

function var_0_0.cancelAllSelected(arg_6_0)
	if arg_6_0._scrollViews then
		for iter_6_0, iter_6_1 in ipairs(arg_6_0._scrollViews) do
			local var_6_0 = iter_6_1:getFirstSelect()
			local var_6_1 = arg_6_0:getIndex(var_6_0)

			iter_6_1:selectCell(var_6_1, false)
		end
	end
end

function var_0_0.isInTeamHero(arg_7_0, arg_7_1)
	return arg_7_0._inTeamHeroUids and arg_7_0._inTeamHeroUids[arg_7_1]
end

function var_0_0.setParam(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	arg_8_0.specialHero = arg_8_1
	arg_8_0.adventure = arg_8_2
	arg_8_0.isTowerBattle = arg_8_3
	arg_8_0._groupType = arg_8_4
	arg_8_0.isWeekWalk_2 = arg_8_4 == HeroGroupEnum.GroupType.WeekWalk_2
end

var_0_0.instance = var_0_0.New()

return var_0_0
