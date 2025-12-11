module("modules.logic.clickuiswitch.model.ClickUISwitchListModel", package.seeall)

local var_0_0 = class("ClickUISwitchListModel", MixScrollModel)

function var_0_0._getUIList(arg_1_0)
	if arg_1_0._clickUIMoList then
		table.sort(arg_1_0._clickUIMoList, arg_1_0._sort)

		return arg_1_0._clickUIMoList
	end

	arg_1_0._clickUIMoList = {}

	for iter_1_0, iter_1_1 in ipairs(lua_scene_click.configList) do
		local var_1_0 = {
			id = iter_1_1.id,
			co = iter_1_1
		}

		table.insert(arg_1_0._clickUIMoList, var_1_0)
	end

	table.sort(arg_1_0._clickUIMoList, arg_1_0._sort)

	return arg_1_0._clickUIMoList
end

function var_0_0._sort(arg_2_0, arg_2_1)
	if arg_2_0.id == ClickUISwitchModel.instance:getCurUseUI() then
		return true
	end

	if arg_2_1.id == ClickUISwitchModel.instance:getCurUseUI() then
		return false
	end

	return arg_2_0.id < arg_2_1.id
end

function var_0_0.initList(arg_3_0)
	local var_3_0 = arg_3_0:_getUIList()

	arg_3_0:setMoList(var_3_0)
	arg_3_0:selectCellIndex(1)
end

function var_0_0._getIndexById(arg_4_0, arg_4_1, arg_4_2)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		if iter_4_1.co.id == arg_4_2 then
			return iter_4_0
		end
	end
end

function var_0_0.setMoList(arg_5_0, arg_5_1)
	arg_5_0:setList(arg_5_1)

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._scrollViews) do
		for iter_5_2 = 0, #arg_5_0._cellInfoList - 1 do
			local var_5_0 = iter_5_1:getCsScroll():GetRenderCell(iter_5_2)

			if var_5_0 then
				gohelper.setActive(var_5_0.gameObject, iter_5_2 < #arg_5_1)
			end
		end
	end
end

function var_0_0.clearList(arg_6_0)
	arg_6_0._selectedCellIndex = nil
	arg_6_0._cellInfoList = nil

	arg_6_0:clear()
end

function var_0_0.getSelectedCellIndex(arg_7_0)
	return arg_7_0._selectedCellIndex
end

function var_0_0.selectCellIndex(arg_8_0, arg_8_1)
	arg_8_0._selectedCellIndex = arg_8_1

	arg_8_0:refreshScroll()
end

function var_0_0.selectCellIndexBy(arg_9_0, arg_9_1)
	arg_9_1 = arg_9_1 or ClickUISwitchModel.instance:getCurUseUI()

	local var_9_0 = arg_9_0:getList()
	local var_9_1 = arg_9_0:_getIndexById(var_9_0, arg_9_1)

	arg_9_0:selectCellIndex(var_9_1)
end

function var_0_0.refreshScroll(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0._scrollViews) do
		iter_10_1:refreshScroll()
	end
end

function var_0_0.getInfoList(arg_11_0, arg_11_1)
	arg_11_0._cellInfoList = arg_11_0._cellInfoList or {}

	local var_11_0 = arg_11_0:getList()

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		local var_11_1 = arg_11_0._cellInfoList[iter_11_0] or SLFramework.UGUI.MixCellInfo.New(ClickUISwitchEnum.ItemTypeUnSelected, ClickUISwitchEnum.ItemHeight, iter_11_0)

		if iter_11_0 == arg_11_0._selectedCellIndex then
			var_11_1.type = ClickUISwitchEnum.ItemTypeSelected
			var_11_1.lineLength = ClickUISwitchEnum.ItemHeight
		else
			var_11_1.type = ClickUISwitchEnum.ItemTypeUnSelected
			var_11_1.lineLength = ClickUISwitchEnum.ItemUnSelectedHeight
		end

		arg_11_0._cellInfoList[iter_11_0] = var_11_1
	end

	return arg_11_0._cellInfoList
end

var_0_0.instance = var_0_0.New()

return var_0_0
