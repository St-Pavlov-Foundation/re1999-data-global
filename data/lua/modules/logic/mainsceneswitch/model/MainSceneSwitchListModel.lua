module("modules.logic.mainsceneswitch.model.MainSceneSwitchListModel", package.seeall)

local var_0_0 = class("MainSceneSwitchListModel", MixScrollModel)

function var_0_0._getSceneList(arg_1_0)
	local var_1_0 = MainSceneSwitchModel.instance:getCurSceneId()
	local var_1_1 = {}

	for iter_1_0, iter_1_1 in ipairs(lua_scene_switch.configList) do
		if iter_1_1.id == var_1_0 then
			table.insert(var_1_1, 1, iter_1_1)
		else
			table.insert(var_1_1, iter_1_1)
		end
	end

	return var_1_1
end

function var_0_0.initList(arg_2_0)
	local var_2_0 = arg_2_0:_getSceneList()

	arg_2_0:setList(var_2_0)
end

function var_0_0.getFirstUnlockSceneIndex(arg_3_0)
	local var_3_0 = arg_3_0:_getSceneList()

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		if iter_3_1.defaultUnlock ~= 1 and ItemModel.instance:getItemCount(iter_3_1.itemId) > 0 then
			return iter_3_0
		end
	end

	return 0
end

function var_0_0.clearList(arg_4_0)
	arg_4_0._selectedCellIndex = nil
	arg_4_0._cellInfoList = nil

	arg_4_0:clear()
end

function var_0_0.getSelectedCellIndex(arg_5_0)
	return arg_5_0._selectedCellIndex
end

function var_0_0.selectCellIndex(arg_6_0, arg_6_1)
	arg_6_0._selectedCellIndex = arg_6_1

	arg_6_0:refreshScroll()
end

function var_0_0.refreshScroll(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0._scrollViews) do
		iter_7_1:refreshScroll()
	end
end

function var_0_0.getInfoList(arg_8_0, arg_8_1)
	arg_8_0._cellInfoList = arg_8_0._cellInfoList or {}

	local var_8_0 = arg_8_0:getList()

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		local var_8_1 = arg_8_0._cellInfoList[iter_8_0] or SLFramework.UGUI.MixCellInfo.New(MainSceneSwitchEnum.ItemTypeUnSelected, MainSceneSwitchEnum.ItemHeight, iter_8_0)

		if iter_8_0 == arg_8_0._selectedCellIndex then
			var_8_1.type = MainSceneSwitchEnum.ItemTypeSelected
			var_8_1.lineLength = MainSceneSwitchEnum.ItemHeight
		else
			var_8_1.type = MainSceneSwitchEnum.ItemTypeUnSelected
			var_8_1.lineLength = MainSceneSwitchEnum.ItemUnSelectedHeight
		end

		arg_8_0._cellInfoList[iter_8_0] = var_8_1
	end

	return arg_8_0._cellInfoList
end

var_0_0.instance = var_0_0.New()

return var_0_0
