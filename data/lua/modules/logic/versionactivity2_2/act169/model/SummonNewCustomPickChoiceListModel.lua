module("modules.logic.versionactivity2_2.act169.model.SummonNewCustomPickChoiceListModel", package.seeall)

local var_0_0 = class("SummonNewCustomPickChoiceListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:clear()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clear()
end

function var_0_0.initDatas(arg_3_0, arg_3_1)
	arg_3_0._actId = arg_3_1
	arg_3_0._selectIdList = {}
	arg_3_0._selectIdMap = {}

	arg_3_0:initList()
end

var_0_0.SkillLevel2Order = {
	[0] = 50,
	40,
	30,
	20,
	10,
	60
}

local function var_0_1(arg_4_0, arg_4_1)
	local var_4_0 = HeroModel.instance:getByHeroId(arg_4_0.id)
	local var_4_1 = HeroModel.instance:getByHeroId(arg_4_1.id)
	local var_4_2 = var_4_0 ~= nil
	local var_4_3 = var_4_1 ~= nil

	if var_4_2 ~= var_4_3 then
		return var_4_3
	end

	local var_4_4 = var_4_0 and var_4_0.exSkillLevel or -1
	local var_4_5 = var_4_1 and var_4_1.exSkillLevel or -1

	if var_4_4 ~= var_4_5 then
		return (var_0_0.SkillLevel2Order[var_4_4] or 999) < (var_0_0.SkillLevel2Order[var_4_5] or 999)
	end

	return arg_4_0.id < arg_4_1.id
end

function var_0_0.initList(arg_5_0)
	local var_5_0 = arg_5_0:getCharIdList()

	arg_5_0.ownList = {}
	arg_5_0.noGainList = {}

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		local var_5_1 = SummonCustomPickChoiceMO.New()

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

function var_0_0.haveAllRole(arg_6_0)
	return arg_6_0._actId and arg_6_0.noGainList and #arg_6_0.noGainList <= 0
end

function var_0_0.setSelectId(arg_7_0, arg_7_1)
	if not arg_7_0._selectIdList then
		return
	end

	if arg_7_0._selectIdMap[arg_7_1] then
		arg_7_0._selectIdMap[arg_7_1] = nil

		tabletool.removeValue(arg_7_0._selectIdList, arg_7_1)
	else
		arg_7_0._selectIdMap[arg_7_1] = true

		table.insert(arg_7_0._selectIdList, arg_7_1)
	end

	SummonNewCustomPickChoiceController.instance:dispatchEvent(SummonNewCustomPickEvent.OnCustomPickListChanged)
end

function var_0_0.clearSelectIds(arg_8_0)
	arg_8_0._selectIdMap = {}
	arg_8_0._selectIdList = {}
end

function var_0_0.getSelectIds(arg_9_0)
	return arg_9_0._selectIdList
end

function var_0_0.getMaxSelectCount(arg_10_0)
	return SummonNewCustomPickViewModel.instance:getMaxSelectCount(arg_10_0._actId)
end

function var_0_0.getSelectCount(arg_11_0)
	if arg_11_0._selectIdList then
		return #arg_11_0._selectIdList
	end

	return 0
end

function var_0_0.isHeroIdSelected(arg_12_0, arg_12_1)
	if arg_12_0._selectIdMap then
		return arg_12_0._selectIdMap[arg_12_1] ~= nil
	end

	return false
end

function var_0_0.getActivityId(arg_13_0)
	return arg_13_0._actId
end

function var_0_0.getCharIdList(arg_14_0)
	local var_14_0 = SummonNewCustomPickViewConfig.instance:getSummonConfigById(arg_14_0._actId)

	if var_14_0 then
		local var_14_1 = var_14_0.heroIds

		return (string.splitToNumber(var_14_1, "#"))
	end

	return {}
end

var_0_0.instance = var_0_0.New()

return var_0_0
