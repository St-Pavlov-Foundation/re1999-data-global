module("modules.logic.rouge.model.RougeCollectionEnchantListModel", package.seeall)

local var_0_0 = class("RougeCollectionEnchantListModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._enchantList = nil
	arg_1_0._curSelectEnchantId = nil
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:onInit()
	arg_2_0:clear()
end

function var_0_0.onInitData(arg_3_0, arg_3_1)
	arg_3_0._enchantList = arg_3_0:buildEnchantDataTab(arg_3_1)

	arg_3_0:setList(arg_3_0._enchantList)

	local var_3_0 = arg_3_0:getCurSelectEnchantId()

	if arg_3_0:getById(var_3_0) then
		arg_3_0:selectCell(var_3_0, true)
	end
end

function var_0_0.buildEnchantDataTab(arg_4_0, arg_4_1)
	local var_4_0 = RougeCollectionModel.instance:getSlotAreaCollection()
	local var_4_1 = RougeCollectionModel.instance:getBagAreaCollection()
	local var_4_2 = arg_4_0:buildEnchantMOList(var_4_0, var_4_1)
	local var_4_3 = arg_4_1 and arg_4_0.sortFunc or arg_4_0.sortFunc2

	table.sort(var_4_2, var_4_3)

	return var_4_2
end

function var_0_0.buildEnchantMOList(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = {}

	if arg_5_1 then
		for iter_5_0, iter_5_1 in pairs(arg_5_1) do
			arg_5_0:dealCollectionInfo(iter_5_1, var_5_0)
		end
	end

	if arg_5_2 then
		for iter_5_2, iter_5_3 in pairs(arg_5_2) do
			arg_5_0:dealCollectionInfo(iter_5_3, var_5_0)
		end
	end

	return var_5_0
end

function var_0_0.dealCollectionInfo(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = RougeCollectionConfig.instance:getCollectionCfg(arg_6_1.cfgId).type == RougeEnum.CollectionType.Enchant
	local var_6_1

	if var_6_0 then
		local var_6_2 = arg_6_0:createRougeEnchantMO(arg_6_1.id, arg_6_1.cfgId)

		table.insert(arg_6_2, var_6_2)
	else
		local var_6_3 = arg_6_1:getAllEnchantId()
		local var_6_4 = arg_6_1:getAllEnchantCfgId()

		if var_6_3 then
			for iter_6_0, iter_6_1 in pairs(var_6_3) do
				if iter_6_1 > 0 then
					local var_6_5 = var_6_4[iter_6_0]

					if RougeCollectionConfig.instance:getCollectionCfg(var_6_5) then
						local var_6_6 = arg_6_0:createRougeEnchantMO(iter_6_1, var_6_5)

						var_6_6:updateEnchantTargetId(arg_6_1.id)
						table.insert(arg_6_2, var_6_6)
					end
				end
			end
		end
	end
end

function var_0_0.createRougeEnchantMO(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = RougeCollectionMO.New()

	var_7_0:init({
		id = arg_7_1,
		itemId = arg_7_2
	})

	return var_7_0
end

function var_0_0.sortFunc(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:isEnchant2Collection()

	if var_8_0 ~= arg_8_1:isEnchant2Collection() then
		return not var_8_0
	end

	local var_8_1 = RougeCollectionConfig.instance:getCollectionCfg(arg_8_0.cfgId)
	local var_8_2 = RougeCollectionConfig.instance:getCollectionCfg(arg_8_1.cfgId)
	local var_8_3 = var_8_1 and var_8_1.showRare or 0
	local var_8_4 = var_8_2 and var_8_2.showRare or 0

	if var_8_3 ~= var_8_4 then
		return var_8_4 < var_8_3
	end

	return arg_8_0.id < arg_8_1.id
end

function var_0_0.sortFunc2(arg_9_0, arg_9_1)
	local var_9_0 = var_0_0.instance:getById(arg_9_0.id)
	local var_9_1 = var_0_0.instance:getById(arg_9_1.id)
	local var_9_2 = var_9_0 ~= nil
	local var_9_3 = var_9_1 ~= nil

	if var_9_2 ~= var_9_3 then
		return var_9_2
	end

	if var_9_2 and var_9_3 then
		local var_9_4 = var_0_0.instance:getIndex(var_9_0)
		local var_9_5 = var_0_0.instance:getIndex(var_9_1)

		if var_9_4 ~= var_9_5 then
			return var_9_4 < var_9_5
		end
	end

	return arg_9_0.id < arg_9_1.id
end

function var_0_0.executeSortFunc(arg_10_0)
	table.sort(arg_10_0._enchantList, arg_10_0.sortFunc)
	arg_10_0:setList(arg_10_0._enchantList)
end

function var_0_0.isEnchantEmpty(arg_11_0)
	return arg_11_0:getCount() <= 0
end

function var_0_0.selectCell(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0._curSelectEnchantId

	if arg_12_1 and arg_12_1 > 0 then
		arg_12_0:_selectCellInternal(arg_12_1, arg_12_2)
	else
		arg_12_0:_selectCellInternal(var_12_0, false)
	end
end

function var_0_0._selectCellInternal(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0:getById(arg_13_1)
	local var_13_1

	if var_13_0 then
		local var_13_2 = arg_13_0:getIndex(var_13_0)

		var_0_0.super.selectCell(arg_13_0, var_13_2, arg_13_2)

		arg_13_0._curSelectEnchantId = arg_13_2 and var_13_0.id or nil
	end
end

function var_0_0.getCurSelectEnchantId(arg_14_0)
	return arg_14_0._curSelectEnchantId
end

var_0_0.instance = var_0_0.New()

return var_0_0
