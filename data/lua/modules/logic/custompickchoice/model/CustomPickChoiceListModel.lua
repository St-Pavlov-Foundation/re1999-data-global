module("modules.logic.custompickchoice.model.CustomPickChoiceListModel", package.seeall)

local var_0_0 = class("CustomPickChoiceListModel", BaseModel)

local function var_0_1(arg_1_0, arg_1_1)
	local var_1_0 = HeroModel.instance:getByHeroId(arg_1_0.id)
	local var_1_1 = HeroModel.instance:getByHeroId(arg_1_1.id)
	local var_1_2 = var_1_0 ~= nil
	local var_1_3 = var_1_1 ~= nil

	if var_1_2 ~= var_1_3 then
		return var_1_3
	end

	local var_1_4 = var_1_0 and var_1_0.exSkillLevel or -1
	local var_1_5 = var_1_1 and var_1_1.exSkillLevel or -1

	if var_1_4 ~= var_1_5 then
		if var_1_4 == 5 or var_1_5 == 5 then
			return var_1_4 ~= 5
		end

		return var_1_5 < var_1_4
	end

	return arg_1_0.id > arg_1_1.id
end

function var_0_0.onInit(arg_2_0)
	arg_2_0._selectIdList = {}
	arg_2_0._selectIdMap = {}
	arg_2_0.allHeroList = {}
	arg_2_0.noGainList = {}
	arg_2_0.ownList = {}
	arg_2_0.maxSelectCount = nil
end

function var_0_0.reInit(arg_3_0)
	arg_3_0:onInit()
end

function var_0_0.initData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:onInit()
	arg_4_0:initList(arg_4_1)

	arg_4_0.maxSelectCount = arg_4_2 or 1
end

function var_0_0.initList(arg_5_0, arg_5_1)
	arg_5_0.noGainList = {}
	arg_5_0.ownList = {}
	arg_5_0.allHeroList = {}

	if not arg_5_1 then
		return
	end

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		local var_5_0 = SummonCustomPickChoiceMO.New()

		var_5_0:init(iter_5_1)

		if var_5_0:hasHero() then
			table.insert(arg_5_0.ownList, var_5_0)
		else
			table.insert(arg_5_0.noGainList, var_5_0)
		end

		table.insert(arg_5_0.allHeroList, var_5_0)
	end

	table.sort(arg_5_0.ownList, var_0_1)
end

function var_0_0.setSelectId(arg_6_0, arg_6_1)
	if not arg_6_0._selectIdList then
		return
	end

	if arg_6_0._selectIdMap[arg_6_1] then
		arg_6_0._selectIdMap[arg_6_1] = nil

		tabletool.removeValue(arg_6_0._selectIdList, arg_6_1)
	else
		arg_6_0._selectIdMap[arg_6_1] = true

		table.insert(arg_6_0._selectIdList, arg_6_1)
	end
end

function var_0_0.clearAllSelect(arg_7_0)
	arg_7_0._selectIdMap = {}
	arg_7_0._selectIdList = {}
end

function var_0_0.getSelectIds(arg_8_0)
	return arg_8_0._selectIdList
end

function var_0_0.getSelectCount(arg_9_0)
	if arg_9_0._selectIdList then
		return #arg_9_0._selectIdList
	end

	return 0
end

function var_0_0.getMaxSelectCount(arg_10_0)
	return arg_10_0.maxSelectCount
end

function var_0_0.isHeroIdSelected(arg_11_0, arg_11_1)
	if arg_11_0._selectIdMap then
		return arg_11_0._selectIdMap[arg_11_1] ~= nil
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
