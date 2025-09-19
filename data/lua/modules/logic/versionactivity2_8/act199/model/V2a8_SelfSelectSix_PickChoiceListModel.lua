module("modules.logic.versionactivity2_8.act199.model.V2a8_SelfSelectSix_PickChoiceListModel", package.seeall)

local var_0_0 = class("V2a8_SelfSelectSix_PickChoiceListModel", MixScrollModel)

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
	local var_5_1 = {}
	local var_5_2 = {}
	local var_5_3 = {}
	local var_5_4 = {}

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		local var_5_5 = SummonCustomPickChoiceMO.New()

		var_5_5:init(iter_5_1)

		if var_5_5:hasHero() then
			if var_5_5:checkHeroFullExSkillLevel() then
				table.insert(var_5_4, var_5_5)
			else
				table.insert(var_5_2, var_5_5)
			end
		else
			table.insert(var_5_3, var_5_5)
		end
	end

	table.sort(var_5_2, var_0_1)
	table.sort(var_5_3, var_0_1)
	table.sort(var_5_4, var_0_1)

	if #var_5_2 > 0 then
		table.insert(var_5_1, {
			isUnlock = true,
			isTitle = true,
			langTitle = luaLang("p_v2a2_fivestarsupgradepickchoiceview_txt_title2")
		})
		table.insert(var_5_1, {
			isUnlock = true,
			heroIdList = var_5_2
		})
	end

	if #var_5_3 > 0 then
		table.insert(var_5_1, {
			isTitle = true,
			langTitle = luaLang("p_achievementlevelview_unget")
		})
		table.insert(var_5_1, {
			heroIdList = var_5_3
		})
	end

	if #var_5_4 > 0 then
		local var_5_6 = false

		if #var_5_2 < 1 then
			var_5_6 = true
		end

		table.insert(var_5_1, {
			isTitle = true,
			isFull = true,
			langTitle = luaLang("anniversary_bonus_max")
		})
		table.insert(var_5_1, {
			heroIdList = var_5_4,
			isUnlock = var_5_6
		})
	end

	arg_5_0:setList(var_5_1)
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

	V2a8_SelfSelectSix_PickChoiceController.instance:dispatchEvent(V2a8_SelfSelectSix_PickChoiceEvent.OnCustomPickListChanged)
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
	local var_14_0 = Activity199Config.instance:getSummonConfigById(arg_14_0._actId)

	if var_14_0 then
		local var_14_1 = var_14_0.heroIds

		return (string.splitToNumber(var_14_1, "#"))
	end

	return {}
end

function var_0_0.getInfoList(arg_15_0, arg_15_1)
	arg_15_0._mixCellInfo = {}

	local var_15_0 = arg_15_0:getList()

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		local var_15_1 = iter_15_1.isTitle
		local var_15_2 = 1
		local var_15_3 = 7

		if not var_15_1 then
			var_15_2 = math.ceil(#iter_15_1.heroIdList / var_15_3)
		end

		local var_15_4 = var_15_1 and 0 or 1
		local var_15_5 = var_15_1 and 66 or 200 * var_15_2
		local var_15_6 = SLFramework.UGUI.MixCellInfo.New(var_15_4, var_15_5, nil)

		table.insert(arg_15_0._mixCellInfo, var_15_6)
	end

	return arg_15_0._mixCellInfo
end

function var_0_0.clearAllSelect(arg_16_0)
	arg_16_0._selectIdMap = {}
	arg_16_0._selectIdList = {}
end

var_0_0.instance = var_0_0.New()

return var_0_0
