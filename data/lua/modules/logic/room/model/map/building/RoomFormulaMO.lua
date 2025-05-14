module("modules.logic.room.model.map.building.RoomFormulaMO", package.seeall)

local var_0_0 = pureTable("RoomFormulaMO")
local var_0_1 = 1
local var_0_2 = true
local var_0_3 = false

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.formulaId, arg_1_0.treeLevel = RoomProductionHelper.changeStrUID2FormulaIdAndTreeLevel(arg_1_1.id)
	arg_1_0.config = RoomConfig.instance:getFormulaConfig(arg_1_0.formulaId)

	if not arg_1_0.config then
		logError("找不到配方id: " .. tostring(arg_1_0.formulaId))
	end

	arg_1_0:setIsLast(arg_1_1.isLast)
	arg_1_0:setParentStrId(arg_1_1.parentStrId)
	arg_1_0:resetIsExpandTree()
end

function var_0_0.getId(arg_2_0)
	return arg_2_0.id
end

function var_0_0.getFormulaId(arg_3_0)
	return arg_3_0.formulaId
end

function var_0_0.getFormulaCombineCount(arg_4_0)
	if not arg_4_0.formulaCombineCount then
		arg_4_0:resetFormulaCombineCount()
	end

	return arg_4_0.formulaCombineCount
end

function var_0_0.getIsExpandTree(arg_5_0)
	return arg_5_0.isExpandTree
end

function var_0_0.getConfig(arg_6_0)
	return arg_6_0.config
end

function var_0_0.getFormulaTreeLevel(arg_7_0)
	if not arg_7_0.treeLevel then
		arg_7_0:setFormulaTreeLevel(RoomFormulaModel.DEFAULT_TREE_LEVEL)
	end

	return arg_7_0.treeLevel
end

function var_0_0.getIsLast(arg_8_0)
	return arg_8_0.isLast
end

function var_0_0.getParentStrId(arg_9_0)
	return arg_9_0.parentStrId
end

function var_0_0.isTreeFormula(arg_10_0)
	return arg_10_0.treeLevel ~= RoomFormulaModel.DEFAULT_TREE_LEVEL
end

function var_0_0.resetFormulaCombineCount(arg_11_0)
	local var_11_0 = var_0_1
	local var_11_1 = arg_11_0:getId()
	local var_11_2 = RoomProductionHelper.getFormulaNeedQuantity(var_11_1)
	local var_11_3 = 0
	local var_11_4 = arg_11_0:getFormulaId()
	local var_11_5 = RoomProductionHelper.getFormulaProduceItem(var_11_4)

	if var_11_5 then
		var_11_3 = ItemModel.instance:getItemQuantity(var_11_5.type, var_11_5.id)
	end

	local var_11_6 = var_11_3 - var_11_2

	if var_11_6 < 0 then
		var_11_0 = math.abs(var_11_6)
	end

	arg_11_0:setFormulaCombineCount(var_11_0)
end

function var_0_0.resetIsExpandTree(arg_12_0)
	arg_12_0:setIsExpandTree(var_0_3)
end

function var_0_0.setFormulaCombineCount(arg_13_0, arg_13_1)
	arg_13_1 = arg_13_1 > 0 and arg_13_1 or var_0_1
	arg_13_0.formulaCombineCount = arg_13_1

	arg_13_0:syncChildFormulaCombineCount()

	local var_13_0 = arg_13_0:getId()

	RoomMapController.instance:dispatchEvent(RoomEvent.RefreshFormulaCombineCount, var_13_0)
end

function var_0_0.syncChildFormulaCombineCount(arg_14_0)
	if not arg_14_0:getIsExpandTree() then
		return
	end

	local var_14_0 = arg_14_0:getFormulaId()
	local var_14_1 = arg_14_0:getFormulaCombineCount()
	local var_14_2 = arg_14_0:getFormulaTreeLevel()
	local var_14_3 = RoomProductionHelper.getCostItemListWithFormulaId(var_14_0)

	for iter_14_0, iter_14_1 in ipairs(var_14_3) do
		if iter_14_1.formulaId and iter_14_1.formulaId ~= 0 then
			local var_14_4 = RoomProductionHelper.getFormulaStrUID(iter_14_1.formulaId, var_14_2 + 1)
			local var_14_5 = RoomFormulaModel.instance:getFormulaMo(var_14_4, true)

			if var_14_5 then
				local var_14_6 = var_0_1
				local var_14_7 = iter_14_1.quantity * var_14_1
				local var_14_8 = ItemModel.instance:getItemQuantity(iter_14_1.type, iter_14_1.id) - var_14_7

				if var_14_8 < 0 then
					var_14_6 = math.abs(var_14_8)
				end

				var_14_5:setFormulaCombineCount(var_14_6)
			end
		end
	end
end

function var_0_0.setFormulaTreeLevel(arg_15_0, arg_15_1)
	if arg_15_1 < 0 then
		arg_15_1 = RoomFormulaModel.DEFAULT_TREE_LEVEL
	elseif arg_15_1 > RoomFormulaModel.MAX_FORMULA_TREE_LEVEL then
		arg_15_1 = RoomFormulaModel.MAX_FORMULA_TREE_LEVEL
	end

	arg_15_0.treeLevel = arg_15_1
end

function var_0_0.setIsLast(arg_16_0, arg_16_1)
	if arg_16_1 == nil then
		arg_16_1 = var_0_2
	end

	arg_16_0.isLast = arg_16_1
end

function var_0_0.setParentStrId(arg_17_0, arg_17_1)
	arg_17_0.parentStrId = arg_17_1
end

function var_0_0.setIsExpandTree(arg_18_0, arg_18_1)
	arg_18_0.isExpandTree = arg_18_1
end

return var_0_0
