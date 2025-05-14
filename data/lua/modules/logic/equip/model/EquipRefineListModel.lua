module("modules.logic.equip.model.EquipRefineListModel", package.seeall)

local var_0_0 = class("EquipRefineListModel", ListScrollModel)

var_0_0.SelectStatusEnum = {
	Selected = 2,
	OutMaxRefineLv = 1,
	Success = 0
}

function var_0_0.onInit(arg_1_0)
	arg_1_0.selectedEquipMoList = {}
	arg_1_0.selectedEquipUidDict = {}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0.selectedEquipMoList = {}
	arg_2_0.selectedEquipUidDict = {}
end

function var_0_0.initData(arg_3_0, arg_3_1)
	arg_3_0.targetEquipMo = arg_3_1
	arg_3_0.targetEquipRefineLv = arg_3_1.refineLv

	local var_3_0 = arg_3_0.targetEquipMo.config

	if not string.nilorempty(var_3_0.useSpRefine) then
		arg_3_0.useSpRefineList = string.splitToNumber(var_3_0.useSpRefine, "#")
	end

	arg_3_0.data = {}

	local var_3_1 = EquipModel.instance:getEquips()

	for iter_3_0, iter_3_1 in ipairs(var_3_1) do
		if arg_3_0:canAddToData(iter_3_1) then
			table.insert(arg_3_0.data, iter_3_1)
		end
	end
end

function var_0_0.canAddToData(arg_4_0, arg_4_1)
	if arg_4_1.equipId == EquipConfig.instance:getEquipUniversalId() then
		return true
	end

	if arg_4_1.equipId == arg_4_0.targetEquipMo.equipId and arg_4_1.uid ~= arg_4_0.targetEquipMo.uid and arg_4_1.config.isExpEquip ~= 1 then
		return true
	end

	if arg_4_0.useSpRefineList and tabletool.indexOf(arg_4_0.useSpRefineList, arg_4_1.equipId) then
		return true
	end

	return false
end

function var_0_0.sortData(arg_5_0)
	table.sort(arg_5_0.data, EquipHelper.sortRefineList)
end

function var_0_0.refreshData(arg_6_0)
	arg_6_0:setList(arg_6_0.data)
end

function var_0_0.getDataCount(arg_7_0)
	return GameUtil.getTabLen(arg_7_0.data)
end

function var_0_0.selectEquip(arg_8_0, arg_8_1)
	if arg_8_0.selectedEquipUidDict[arg_8_1.uid] then
		return var_0_0.SelectStatusEnum.Selected
	end

	if arg_8_0:getAddRefineLv() + arg_8_0.targetEquipRefineLv >= EquipConfig.instance:getEquipRefineLvMax() then
		return var_0_0.SelectStatusEnum.OutMaxRefineLv
	end

	arg_8_0.selectedEquipUidDict[arg_8_1.uid] = true

	table.insert(arg_8_0.selectedEquipMoList, arg_8_1)
	arg_8_0:setSelectedEquipMoList()
	EquipController.instance:dispatchEvent(EquipEvent.OnRefineSelectedEquipChange)

	return var_0_0.SelectStatusEnum.Success
end

function var_0_0.deselectEquip(arg_9_0, arg_9_1)
	arg_9_0.selectedEquipUidDict[arg_9_1.uid] = nil

	local var_9_0 = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.selectedEquipMoList) do
		if iter_9_1.uid ~= arg_9_1.uid then
			table.insert(var_9_0, iter_9_1)
		end
	end

	arg_9_0.selectedEquipMoList = var_9_0

	arg_9_0:setSelectedEquipMoList()
	EquipController.instance:dispatchEvent(EquipEvent.OnRefineSelectedEquipChange)
end

function var_0_0.clearSelectedEquipList(arg_10_0)
	arg_10_0.selectedEquipMoList = {}
	arg_10_0.selectedEquipUidDict = {}

	EquipRefineSelectedListModel.instance:updateList()
end

function var_0_0.setSelectedEquipMoList(arg_11_0)
	EquipRefineSelectedListModel.instance:updateList(arg_11_0.selectedEquipMoList)
end

function var_0_0.getSelectedEquipMoList(arg_12_0)
	return arg_12_0.selectedEquipMoList
end

function var_0_0.getSelectedEquipUidList(arg_13_0)
	local var_13_0 = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_0.selectedEquipMoList) do
		table.insert(var_13_0, iter_13_1.uid)
	end

	return var_13_0
end

function var_0_0.getAddRefineLv(arg_14_0)
	local var_14_0 = 0

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.selectedEquipMoList) do
		var_14_0 = var_14_0 + iter_14_1.refineLv
	end

	return var_14_0
end

function var_0_0.isSelected(arg_15_0, arg_15_1)
	if not arg_15_1 then
		return false
	end

	return arg_15_0.selectedEquipUidDict[arg_15_1.uid]
end

function var_0_0.clearData(arg_16_0)
	arg_16_0:clear()

	arg_16_0.selectedEquipMoList = {}
	arg_16_0.selectedEquipUidDict = {}
	arg_16_0.useSpRefineList = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
