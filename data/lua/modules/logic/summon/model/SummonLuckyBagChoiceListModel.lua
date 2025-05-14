module("modules.logic.summon.model.SummonLuckyBagChoiceListModel", package.seeall)

local var_0_0 = class("SummonLuckyBagChoiceListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clear()
end

local function var_0_1(arg_3_0, arg_3_1)
	local var_3_0 = HeroModel.instance:getByHeroId(arg_3_0.id)
	local var_3_1 = HeroModel.instance:getByHeroId(arg_3_1.id)
	local var_3_2 = var_3_0 ~= nil
	local var_3_3 = var_3_1 ~= nil

	if var_3_2 ~= var_3_3 then
		return var_3_3
	end

	local var_3_4 = var_3_0 and var_3_0.exSkillLevel or -1
	local var_3_5 = var_3_1 and var_3_1.exSkillLevel or -1

	if var_3_4 ~= var_3_5 then
		return var_3_4 < var_3_5
	end

	return arg_3_0.id < arg_3_1.id
end

function var_0_0.initDatas(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._poolId = arg_4_2
	arg_4_0._luckyBagId = arg_4_1
	arg_4_0._selectHeroId = nil

	arg_4_0:initList()
end

function var_0_0.initList(arg_5_0)
	local var_5_0 = arg_5_0:getCharIdList()

	arg_5_0.noGainList = {}
	arg_5_0.ownList = {}

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		local var_5_1 = SummonLuckyBagChoiceMO.New()

		var_5_1:init(iter_5_1)

		if var_5_1:hasHero() then
			table.insert(arg_5_0.ownList, var_5_1)
		else
			table.insert(arg_5_0.noGainList, var_5_1)
		end
	end

	table.sort(arg_5_0.ownList, var_0_1)
	table.sort(arg_5_0.noGainList, var_0_1)
end

function var_0_0.setSelectId(arg_6_0, arg_6_1)
	arg_6_0._selectHeroId = arg_6_1
end

function var_0_0.getSelectId(arg_7_0)
	return arg_7_0._selectHeroId
end

function var_0_0.getLuckyBagId(arg_8_0)
	return arg_8_0._luckyBagId
end

function var_0_0.getPoolId(arg_9_0)
	return arg_9_0._poolId
end

function var_0_0.getCharIdList(arg_10_0)
	return SummonConfig.instance:getLuckyBagHeroIds(arg_10_0._poolId, arg_10_0._luckyBagId)
end

var_0_0.instance = var_0_0.New()

return var_0_0
