module("modules.logic.fightuiswitch.model.FightUISwitchListModel", package.seeall)

local var_0_0 = class("FightUISwitchListModel", MixScrollModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.initMoList(arg_3_0)
	arg_3_0:setMoList()
end

function var_0_0.setMoList(arg_4_0)
	local var_4_0 = FightUISwitchModel.instance:getCurShowStyleClassify()
	local var_4_1 = FightUISwitchModel.instance:getSelectStyleId(var_4_0)
	local var_4_2 = FightUISwitchModel.instance:getStyleMoListByClassify(var_4_0)

	table.sort(var_4_2, var_0_0.sortMo)
	arg_4_0:setList(var_4_2)

	if var_4_1 then
		arg_4_0:onSelect(var_4_1, true)
	else
		for iter_4_0, iter_4_1 in ipairs(var_4_2) do
			if iter_4_1:isUse() then
				arg_4_0:_onSelectByMo(iter_4_1, true)

				return
			end
		end
	end

	for iter_4_2, iter_4_3 in ipairs(arg_4_0._scrollViews) do
		for iter_4_4 = 0, #arg_4_0._cellInfoList - 1 do
			local var_4_3 = iter_4_3:getCsScroll():GetRenderCell(iter_4_4)

			if var_4_3 then
				gohelper.setActive(var_4_3.gameObject, iter_4_4 < #var_4_2)
			end
		end
	end
end

function var_0_0.sortMo(arg_5_0, arg_5_1)
	if arg_5_0:isUse() then
		return true
	end

	if arg_5_1:isUse() then
		return false
	end

	if arg_5_0:isUnlock() ~= arg_5_1:isUnlock() then
		return arg_5_0:isUnlock()
	end

	if arg_5_0:getRare() ~= arg_5_1:getRare() then
		return arg_5_0:getRare() > arg_5_1:getRare()
	end

	return arg_5_0.sort > arg_5_1.sort
end

function var_0_0.onSelect(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0:getById(arg_6_1)

	arg_6_0:_onSelectByMo(var_6_0, arg_6_2)
end

function var_0_0._onSelectByMo(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._selectedCellIndex = arg_7_0:getIndex(arg_7_1)

	arg_7_0:refreshScroll()
end

function var_0_0.getSelectMo(arg_8_0)
	return arg_8_0:getByIndex(arg_8_0._selectedCellIndex)
end

function var_0_0.refreshScroll(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0._scrollViews) do
		iter_9_1:refreshScroll()
	end
end

function var_0_0.getInfoList(arg_10_0, arg_10_1)
	arg_10_0._cellInfoList = arg_10_0._cellInfoList or {}

	local var_10_0 = arg_10_0:getList()

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		local var_10_1 = arg_10_0._cellInfoList[iter_10_0] or SLFramework.UGUI.MixCellInfo.New(MainSceneSwitchEnum.ItemTypeUnSelected, MainSceneSwitchEnum.ItemHeight, iter_10_0)

		if iter_10_0 == arg_10_0._selectedCellIndex then
			var_10_1.type = MainSceneSwitchEnum.ItemTypeSelected
			var_10_1.lineLength = MainSceneSwitchEnum.ItemHeight
		else
			var_10_1.type = MainSceneSwitchEnum.ItemTypeUnSelected
			var_10_1.lineLength = MainSceneSwitchEnum.ItemUnSelectedHeight
		end

		arg_10_0._cellInfoList[iter_10_0] = var_10_1
	end

	return arg_10_0._cellInfoList
end

var_0_0.instance = var_0_0.New()

return var_0_0
