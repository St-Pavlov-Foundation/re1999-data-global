module("modules.logic.survival.model.shelter.SurvivalShelterChooseEquipListModel", package.seeall)

local var_0_0 = class("SurvivalShelterChooseEquipListModel", ListScrollModel)

function var_0_0.setSelectEquip(arg_1_0, arg_1_1)
	if arg_1_0.selectEquipId == arg_1_1 then
		arg_1_0.selectEquipId = 0
	else
		arg_1_0.selectEquipId = arg_1_1
	end

	return true
end

function var_0_0.setSelectPos(arg_2_0, arg_2_1)
	if arg_2_0._selectPos == arg_2_1 then
		return
	end

	arg_2_0._selectPos = arg_2_1

	return true
end

function var_0_0.getSelectPos(arg_3_0)
	return arg_3_0._selectPos
end

function var_0_0.getSelectEquip(arg_4_0)
	return arg_4_0.selectEquipId
end

function var_0_0.clearSelectList(arg_5_0)
	if arg_5_0._equipList ~= nil then
		tabletool.clear(arg_5_0._equipList)
	else
		arg_5_0._equipList = {}
	end
end

function var_0_0.setNeedSelectEquipList(arg_6_0, arg_6_1)
	arg_6_0.selectEquipId = nil
	arg_6_0._pos2Id = nil
	arg_6_0._selectPos = nil

	if arg_6_1 == nil then
		return
	end

	arg_6_0:clearSelectList()

	for iter_6_0 = 1, #arg_6_1 do
		local var_6_0 = SurvivalBagItemMo.New()

		var_6_0:init({
			id = arg_6_1[iter_6_0]
		})
		table.insert(arg_6_0._equipList, var_6_0)
	end
end

function var_0_0.getShowList(arg_7_0)
	return arg_7_0._equipList or {}
end

function var_0_0.setSelectIdToPos(arg_8_0, arg_8_1, arg_8_2)
	arg_8_2 = arg_8_2 ~= nil and arg_8_2 or arg_8_0._selectPos

	if arg_8_2 == nil then
		return
	end

	if arg_8_0._pos2Id == nil then
		arg_8_0._pos2Id = {}
	end

	arg_8_0._pos2Id[arg_8_2] = arg_8_1

	SurvivalController.instance:dispatchEvent(SurvivalEvent.OnSelectFinish)
end

function var_0_0.getAllSelectPosEquip(arg_9_0)
	local var_9_0 = {}

	if arg_9_0._pos2Id then
		for iter_9_0, iter_9_1 in pairs(arg_9_0._pos2Id) do
			table.insert(var_9_0, iter_9_1)
		end
	end

	return var_9_0
end

function var_0_0.getSelectIdByPos(arg_10_0, arg_10_1)
	if arg_10_1 == nil or arg_10_0._pos2Id == nil then
		return nil
	end

	return arg_10_0._pos2Id[arg_10_1]
end

function var_0_0.npcIdIsSelect(arg_11_0, arg_11_1)
	if arg_11_0._pos2Id ~= nil then
		for iter_11_0, iter_11_1 in pairs(arg_11_0._pos2Id) do
			if arg_11_1 == iter_11_1 then
				return iter_11_0
			end
		end
	end

	return nil
end

function var_0_0.filterEquip(arg_12_0, arg_12_1, arg_12_2)
	if not arg_12_1 or not next(arg_12_1) then
		return true
	end

	local var_12_0 = lua_survival_equip.configDict[arg_12_2.id].tag
	local var_12_1 = SurvivalConfig.instance:getSplitTag(var_12_0)
	local var_12_2 = {}

	for iter_12_0, iter_12_1 in ipairs(var_12_1) do
		var_12_2[iter_12_1] = true
	end

	for iter_12_2, iter_12_3 in pairs(arg_12_1) do
		if var_12_2[iter_12_3.type] then
			return true
		end
	end
end

function var_0_0.sort(arg_13_0, arg_13_1)
	return arg_13_0.id < arg_13_1.id
end

function var_0_0.refreshList(arg_14_0, arg_14_1)
	local var_14_0 = {}

	if arg_14_0._equipList then
		for iter_14_0 = 1, #arg_14_0._equipList do
			local var_14_1 = arg_14_0._equipList[iter_14_0]

			if arg_14_0:filterEquip(arg_14_1, var_14_1) then
				table.insert(var_14_0, var_14_1)
			end
		end
	end

	if #var_14_0 > 1 then
		SurvivalBagSortHelper.sortItems(var_14_0, SurvivalEnum.ItemSortType.ItemReward, true)
	end

	arg_14_0:setList(var_14_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
