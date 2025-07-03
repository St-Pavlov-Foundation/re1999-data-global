module("modules.logic.versionactivity2_7.act191.model.Act191HeroQuickEditListModel", package.seeall)

local var_0_0 = class("Act191HeroQuickEditListModel", ListScrollModel)

function var_0_0.initData(arg_1_0)
	arg_1_0.moList = {}
	arg_1_0._index2HeroIdMap = {}

	local var_1_0 = Activity191Model.instance:getActInfo():getGameInfo()

	for iter_1_0, iter_1_1 in ipairs(var_1_0.warehouseInfo.hero) do
		local var_1_1 = {
			heroId = iter_1_1.heroId,
			star = iter_1_1.star,
			exp = iter_1_1.exp
		}

		var_1_1.config = Activity191Config.instance:getRoleCoByNativeId(var_1_1.heroId, var_1_1.star)

		local var_1_2 = var_1_0:getBattleHeroInfoInTeam(var_1_1.heroId)

		if var_1_2 then
			arg_1_0._index2HeroIdMap[var_1_2.index] = var_1_1.heroId
		else
			local var_1_3 = var_1_0:getSubHeroInfoInTeam(var_1_1.heroId)

			if var_1_3 then
				arg_1_0._index2HeroIdMap[var_1_3.index + 4] = var_1_1.heroId
			end
		end

		arg_1_0.moList[#arg_1_0.moList + 1] = var_1_1
	end

	arg_1_0:filterData(nil, Activity191Enum.SortRule.Down)

	for iter_1_2, iter_1_3 in ipairs(arg_1_0._scrollViews) do
		iter_1_3:selectCell(1, false)
	end
end

function var_0_0.selectHero(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_2 then
		local var_2_0 = arg_2_0:findEmptyPos()

		if var_2_0 ~= 0 then
			arg_2_0._index2HeroIdMap[var_2_0] = arg_2_1
		end
	else
		local var_2_1 = arg_2_0:getHeroTeamPos(arg_2_1)

		arg_2_0._index2HeroIdMap[var_2_1] = nil
	end
end

function var_0_0.getHeroTeamPos(arg_3_0, arg_3_1)
	if arg_3_0._index2HeroIdMap then
		for iter_3_0, iter_3_1 in pairs(arg_3_0._index2HeroIdMap) do
			if iter_3_1 == arg_3_1 then
				return iter_3_0
			end
		end
	end

	return 0
end

function var_0_0.findEmptyPos(arg_4_0)
	for iter_4_0 = 1, 8 do
		if not arg_4_0._index2HeroIdMap[iter_4_0] then
			return iter_4_0
		end
	end

	return 0
end

function var_0_0.filterData(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0

	if arg_5_1 then
		var_5_0 = {}

		for iter_5_0, iter_5_1 in ipairs(arg_5_0.moList) do
			local var_5_1 = string.split(iter_5_1.config.tag, "#")

			if tabletool.indexOf(var_5_1, arg_5_1) then
				var_5_0[#var_5_0 + 1] = iter_5_1
			end
		end
	else
		var_5_0 = tabletool.copy(arg_5_0.moList)
	end

	table.sort(var_5_0, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_5_0:getHeroTeamPos(arg_6_0.heroId)

		var_6_0 = var_6_0 == 0 and 999 or var_6_0

		local var_6_1 = arg_5_0:getHeroTeamPos(arg_6_1.heroId)

		var_6_1 = var_6_1 == 0 and 999 or var_6_1

		if var_6_0 == var_6_1 then
			if arg_6_0.config.quality == arg_6_1.config.quality then
				if arg_6_0.config.exLevel == arg_6_1.config.exLevel then
					return arg_6_0.config.id < arg_6_1.config.id
				else
					return arg_6_0.config.exLevel > arg_6_1.config.exLevel
				end
			elseif arg_5_2 == Activity191Enum.SortRule.Down then
				return arg_6_0.config.quality > arg_6_1.config.quality
			else
				return arg_6_0.config.quality < arg_6_1.config.quality
			end
		else
			return var_6_0 < var_6_1
		end
	end)
	arg_5_0:setList(var_5_0)
end

function var_0_0.getHeroIdMap(arg_7_0)
	return arg_7_0._index2HeroIdMap or {}
end

var_0_0.instance = var_0_0.New()

return var_0_0
