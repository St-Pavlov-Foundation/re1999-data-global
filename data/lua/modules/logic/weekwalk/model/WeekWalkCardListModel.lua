module("modules.logic.weekwalk.model.WeekWalkCardListModel", package.seeall)

local var_0_0 = class("WeekWalkCardListModel", ListScrollModel)

function var_0_0.verifyCondition(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1
	local var_1_1 = lua_weekwalk_buff.configDict[var_1_0]
	local var_1_2 = tonumber(var_1_1.param)
	local var_1_3 = lua_weekwalk_pray.configDict[var_1_2]
	local var_1_4 = 0
	local var_1_5 = 0
	local var_1_6 = 0
	local var_1_7 = GameUtil.splitString2(var_1_3.sacrificeLimit, true, "|", "#")

	if var_1_7 then
		for iter_1_0, iter_1_1 in ipairs(var_1_7) do
			local var_1_8 = iter_1_1[1]
			local var_1_9 = iter_1_1[2]

			if var_1_8 == 1 then
				var_1_5 = var_1_9
			elseif var_1_8 == 2 then
				var_1_4 = var_1_9
			elseif var_1_8 == 3 then
				var_1_6 = var_1_9
			end
		end
	end

	local var_1_10 = var_1_3.blessingLimit == "1"
	local var_1_11 = arg_1_0:_verify(var_1_5, var_1_4, nil, nil, var_1_6)

	if not var_1_11 then
		GameFacade.showToast(ToastEnum.WeekWalkCardNoHero)

		return false
	end

	local var_1_12 = var_1_5

	if var_1_6 ~= 0 then
		var_1_12 = HeroConfig.instance:getHeroCO(var_1_6).career
	end

	local var_1_13 = var_1_10 and var_1_12 or 0

	if not arg_1_0:_verify(var_1_13, 0, var_1_11, nil, 0) then
		GameFacade.showToast(ToastEnum.WeekWalkCardNoHero)

		return false
	end

	return true
end

function var_0_0._verify(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	local var_2_0 = HeroModel.instance:getList()
	local var_2_1 = WeekWalkModel.instance:getInfo()

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		if arg_2_2 <= iter_2_1.level and (arg_2_5 == 0 or iter_2_1.heroId == arg_2_5) and var_2_1:getHeroHp(iter_2_1.heroId) > 0 and (arg_2_1 == 0 or arg_2_1 == iter_2_1.config.career) and iter_2_1 ~= arg_2_3 and iter_2_1 ~= arg_2_4 then
			return iter_2_1
		end
	end
end

function var_0_0.setCardList(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	local var_3_0 = WeekWalkModel.instance:getInfo()
	local var_3_1 = arg_3_0:getCardList(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)

	table.sort(var_3_1, function(arg_4_0, arg_4_1)
		local var_4_0 = var_3_0:getHeroHp(arg_4_0.heroId) <= 0 and 0 or 1
		local var_4_1 = var_3_0:getHeroHp(arg_4_1.heroId) <= 0 and 0 or 1

		if var_4_0 ~= var_4_1 then
			return var_4_1 < var_4_0
		elseif arg_4_0.level ~= arg_4_1.level then
			return arg_4_0.level > arg_4_1.level
		elseif arg_4_0.config.rare ~= arg_4_1.config.rare then
			return arg_4_0.config.rare > arg_4_1.config.rare
		elseif arg_4_0.createTime ~= arg_4_1.createTime then
			return arg_4_0.createTime <= arg_4_1.createTime
		end

		return arg_4_0.heroId > arg_4_1.heroId
	end)
	arg_3_0:setList(var_3_1)
end

function var_0_0.getCardList(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	local var_5_0 = WeekWalkModel.instance:getInfo()
	local var_5_1 = HeroModel.instance:getList()
	local var_5_2 = {}

	for iter_5_0, iter_5_1 in ipairs(var_5_1) do
		if arg_5_2 <= iter_5_1.level and (arg_5_5 == 0 or iter_5_1.heroId == arg_5_5) and var_5_0:getHeroHp(iter_5_1.heroId) > 0 and (arg_5_1 == 0 or arg_5_1 == iter_5_1.config.career) and iter_5_1 ~= arg_5_3 and iter_5_1 ~= arg_5_4 then
			table.insert(var_5_2, iter_5_1)
		end
	end

	return var_5_2
end

function var_0_0.setCharacterList(arg_6_0, arg_6_1)
	local var_6_0 = WeekWalkModel.instance:getInfo()
	local var_6_1 = {}
	local var_6_2 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		if var_6_0:getHeroHp(iter_6_1.heroId) <= 0 then
			table.insert(var_6_2, iter_6_1)
		else
			table.insert(var_6_1, iter_6_1)
		end
	end

	tabletool.addValues(var_6_1, var_6_2)
	arg_6_0:setList(var_6_1)
end

var_0_0.instance = var_0_0.New()

return var_0_0
