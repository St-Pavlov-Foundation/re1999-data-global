module("modules.logic.versionactivity2_7.act191.model.Act191HeroEditListModel", package.seeall)

local var_0_0 = class("Act191HeroEditListModel", ListScrollModel)

function var_0_0.initData(arg_1_0, arg_1_1)
	arg_1_0.specialHero = arg_1_1.heroId
	arg_1_0.specialIndex = arg_1_1.index
	arg_1_0.moList = {}
	arg_1_0._index2HeroIdMap = {}

	local var_1_0 = Activity191Model.instance:getActInfo():getGameInfo()

	for iter_1_0, iter_1_1 in ipairs(var_1_0.warehouseInfo.hero) do
		local var_1_1 = {
			heroId = iter_1_1.heroId,
			star = iter_1_1.star,
			exp = iter_1_1.exp
		}

		var_1_1.inTeam = 0
		var_1_1.config = Activity191Config.instance:getRoleCoByNativeId(iter_1_1.heroId, iter_1_1.star)

		local var_1_2 = var_1_0:getBattleHeroInfoInTeam(var_1_1.heroId)

		if var_1_2 then
			var_1_1.inTeam = 2
			arg_1_0._index2HeroIdMap[var_1_2.index] = var_1_1.heroId
		else
			local var_1_3 = var_1_0:getSubHeroInfoInTeam(var_1_1.heroId)

			if var_1_3 then
				var_1_1.inTeam = 1
				arg_1_0._index2HeroIdMap[var_1_3.index + 4] = var_1_1.heroId
			end
		end

		if var_1_1.heroId == arg_1_0.specialHero then
			var_1_1.inTeam = 3
		end

		arg_1_0.moList[#arg_1_0.moList + 1] = var_1_1
	end

	arg_1_0:filterData(nil, Activity191Enum.SortRule.Down)

	if #arg_1_0._scrollViews > 0 and arg_1_0.specialHero and arg_1_0.specialHero ~= 0 then
		for iter_1_2, iter_1_3 in ipairs(arg_1_0._scrollViews) do
			iter_1_3:selectCell(1, true)
		end
	end
end

function var_0_0.filterData(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0

	if arg_2_1 then
		var_2_0 = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.moList) do
			local var_2_1 = string.split(iter_2_1.config.tag, "#")

			if tabletool.indexOf(var_2_1, arg_2_1) then
				var_2_0[#var_2_0 + 1] = iter_2_1
			end
		end
	else
		var_2_0 = tabletool.copy(arg_2_0.moList)
	end

	table.sort(var_2_0, function(arg_3_0, arg_3_1)
		if arg_3_0.inTeam == arg_3_1.inTeam then
			if arg_3_0.config.quality == arg_3_1.config.quality then
				if arg_3_0.config.exLevel == arg_3_1.config.exLevel then
					return arg_3_0.config.id < arg_3_1.config.id
				else
					return arg_3_0.config.exLevel > arg_3_1.config.exLevel
				end
			elseif arg_2_2 == Activity191Enum.SortRule.Down then
				return arg_3_0.config.quality > arg_3_1.config.quality
			else
				return arg_3_0.config.quality < arg_3_1.config.quality
			end
		else
			return arg_3_0.inTeam > arg_3_1.inTeam
		end
	end)
	arg_2_0:setList(var_2_0)
end

function var_0_0.getHeroIdMap(arg_4_0)
	local var_4_0 = arg_4_0._scrollViews[1]

	if var_4_0 then
		local var_4_1 = var_4_0:getFirstSelect()

		if var_4_1 then
			local var_4_2 = true

			for iter_4_0, iter_4_1 in pairs(arg_4_0._index2HeroIdMap) do
				if iter_4_1 == var_4_1.heroId then
					var_4_2 = false

					break
				end
			end

			if var_4_2 then
				arg_4_0._index2HeroIdMap[arg_4_0.specialIndex] = var_4_1.heroId
			end
		else
			arg_4_0._index2HeroIdMap[arg_4_0.specialIndex] = nil
		end
	end

	return arg_4_0._index2HeroIdMap or {}
end

var_0_0.instance = var_0_0.New()

return var_0_0
