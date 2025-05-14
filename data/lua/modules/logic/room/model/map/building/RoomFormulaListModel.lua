module("modules.logic.room.model.map.building.RoomFormulaListModel", package.seeall)

local var_0_0 = class("RoomFormulaListModel", ListScrollModel)
local var_0_1 = true

var_0_0.FormulaItemAnimationName = {
	collapse = "collapse",
	unfold = "unfold",
	idle = "idle"
}
var_0_0.ANIMATION_WAIT_TIME = 0.15
var_0_0.SET_DATA_WAIT_TIME = 0.01

function var_0_0.onInit(arg_1_0)
	arg_1_0:_clearData()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:_clearData()
end

function var_0_0.clear(arg_3_0)
	arg_3_0:_clearData()
	var_0_0.super.clear(arg_3_0)
end

function var_0_0._clearData(arg_4_0)
	arg_4_0._formulaShowType = nil

	arg_4_0:resetSelectFormulaStrId()
	arg_4_0:resetIsInList()
end

function var_0_0.isSelectedFormula(arg_5_0, arg_5_1)
	if not arg_5_1 then
		return false
	end

	return arg_5_1 == arg_5_0:getSelectFormulaStrId()
end

function var_0_0.changeSelectFormulaToTopLevel(arg_6_0)
	local var_6_0 = arg_6_0:getSelectFormulaStrId()

	if not var_6_0 then
		return
	end

	local var_6_1 = var_0_0.instance:getSelectFormulaMo()

	if var_6_1:getFormulaTreeLevel() == RoomFormulaModel.DEFAULT_TREE_LEVEL then
		return
	end

	local var_6_2 = RoomProductionHelper.getTopLevelFormulaStrId(var_6_0)
	local var_6_3 = RoomFormulaModel.instance:getFormulaMo(var_6_2)

	if var_6_1 and var_6_3 then
		local var_6_4 = var_6_1:getFormulaCombineCount()

		var_6_3:setFormulaCombineCount(var_6_4)
		arg_6_0:setSelectFormulaStrId(var_6_2)
		RoomMapController.instance:dispatchEvent(RoomEvent.ChangeSelectFormulaToTopLevel)
	end
end

function var_0_0.setFormulaList(arg_7_0, arg_7_1)
	arg_7_0:resetAllShowFormulaIsExpandTree()

	local var_7_0 = {}
	local var_7_1 = RoomFormulaModel.instance:getTopTreeLevelFormulaMoList(arg_7_0._formulaShowType)

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		table.insert(var_7_0, iter_7_1)
	end

	arg_7_0.level = arg_7_1

	table.sort(var_7_0, arg_7_0._sortFunction)

	local var_7_2 = arg_7_0:listAddTreeFormula(var_7_0)

	arg_7_0:setList(var_7_2)
end

function var_0_0._sortFunction(arg_8_0, arg_8_1)
	local var_8_0 = var_0_0.instance:getOrder()
	local var_8_1 = var_0_0.instance.level
	local var_8_2, var_8_3, var_8_4, var_8_5 = RoomProductionHelper.isFormulaUnlock(arg_8_0.config.id, var_8_1)
	local var_8_6, var_8_7, var_8_8, var_8_9 = RoomProductionHelper.isFormulaUnlock(arg_8_1.config.id, var_8_1)

	if var_8_2 and not var_8_6 then
		return true
	elseif not var_8_2 and var_8_6 then
		return false
	end

	if var_8_2 and var_8_6 then
		if var_8_0 == RoomBuildingEnum.FormulaOrderType.RareUp and arg_8_0.config.rare ~= arg_8_1.config.rare then
			return arg_8_0.config.rare < arg_8_1.config.rare
		elseif var_8_0 == RoomBuildingEnum.FormulaOrderType.RareDown and arg_8_0.config.rare ~= arg_8_1.config.rare then
			return arg_8_0.config.rare > arg_8_1.config.rare
		elseif var_8_0 == RoomBuildingEnum.FormulaOrderType.CostTimeUp and arg_8_0.config.costTime ~= arg_8_1.config.costTime then
			return arg_8_0.config.costTime < arg_8_1.config.costTime
		elseif var_8_0 == RoomBuildingEnum.FormulaOrderType.CostTimeDown and arg_8_0.config.costTime ~= arg_8_1.config.costTime then
			return arg_8_0.config.costTime > arg_8_1.config.costTime
		elseif var_8_0 == RoomBuildingEnum.FormulaOrderType.OrderUp and arg_8_0.config.order ~= arg_8_1.config.order then
			return arg_8_0.config.order < arg_8_1.config.order
		elseif var_8_0 == RoomBuildingEnum.FormulaOrderType.OrderDown and arg_8_0.config.order ~= arg_8_1.config.order then
			return arg_8_0.config.order > arg_8_1.config.order
		end
	elseif not var_8_2 and not var_8_6 then
		if var_8_4 and not var_8_8 then
			return false
		elseif not var_8_4 and var_8_8 then
			return true
		elseif var_8_4 and var_8_8 then
			if var_8_4 ~= var_8_8 then
				return var_8_4 < var_8_8
			end

			if var_8_5 and not var_8_9 then
				return false
			elseif not var_8_5 and var_8_9 then
				return true
			end
		end
	end

	if arg_8_0.config.order ~= arg_8_1.config.order then
		return arg_8_0.config.order < arg_8_1.config.order
	end

	return arg_8_0.id < arg_8_1.id
end

function var_0_0.expandOrHideTreeFormulaList(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = false

	if not arg_9_0.isInList then
		return var_9_0
	end

	local var_9_1 = arg_9_0:getSelectFormulaStrId()

	if not arg_9_1 then
		arg_9_0:expandTreeFormulaList()

		return var_9_0
	end

	if arg_9_2 then
		local var_9_2

		if string.nilorempty(var_9_1) then
			var_9_2 = arg_9_0:getFormulaListAfterHideTree(RoomFormulaModel.DEFAULT_TREE_LEVEL)
		else
			local var_9_3 = arg_9_0:getSelectFormulaMo()

			if not var_9_3 then
				return var_9_0
			end

			local var_9_4 = var_9_3:getFormulaTreeLevel()

			var_9_2 = arg_9_0:getFormulaListAfterHideTree(var_9_4 + 1)
		end

		TaskDispatcher.runDelay(function()
			arg_9_0:setList(var_9_2)
		end, nil, var_0_0.ANIMATION_WAIT_TIME)

		var_9_0 = true
	else
		local var_9_5 = arg_9_0:getSelectFormulaMo()

		if not var_9_5 then
			return var_9_0
		end

		if var_9_5:getIsExpandTree() then
			arg_9_0:onModelUpdate()
		else
			local var_9_6 = var_9_5:getFormulaTreeLevel()
			local var_9_7 = arg_9_0:getFormulaListAfterHideTree(var_9_6)

			TaskDispatcher.runDelay(function()
				arg_9_0:expandTreeFormulaList(var_9_7)
			end, nil, var_0_0.ANIMATION_WAIT_TIME)

			var_9_0 = true
		end
	end

	return var_9_0
end

function var_0_0.expandTreeFormulaList(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1 or arg_12_0:getList()
	local var_12_1, var_12_2 = arg_12_0:listAddTreeFormula(var_12_0, true)

	arg_12_0:setList(var_12_1)
	TaskDispatcher.runDelay(function()
		RoomMapController.instance:dispatchEvent(RoomEvent.PlayFormulaAnimation, var_12_2, var_0_0.FormulaItemAnimationName.unfold)
	end, nil, var_0_0.SET_DATA_WAIT_TIME)
end

function var_0_0.getFormulaListAfterHideTree(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getList()

	if arg_14_1 > RoomFormulaModel.MAX_FORMULA_TREE_LEVEL then
		return var_14_0
	end

	local var_14_1 = {}
	local var_14_2 = {}

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		local var_14_3 = iter_14_1:getFormulaTreeLevel()

		if arg_14_1 <= var_14_3 then
			iter_14_1:setIsExpandTree(false)

			if arg_14_1 < var_14_3 then
				var_14_1[iter_14_1:getId()] = true
			end
		end

		if var_14_3 <= arg_14_1 then
			table.insert(var_14_2, iter_14_1)
		end
	end

	RoomMapController.instance:dispatchEvent(RoomEvent.PlayFormulaAnimation, var_14_1, var_0_0.FormulaItemAnimationName.collapse)

	return var_14_2
end

function var_0_0.listAddTreeFormula(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = {}
	local var_15_1 = arg_15_0:getIsInList()
	local var_15_2 = arg_15_0:getSelectFormulaStrId()

	if not var_15_2 or not var_15_1 then
		return arg_15_1, var_15_0
	end

	local var_15_3
	local var_15_4

	for iter_15_0, iter_15_1 in ipairs(arg_15_1) do
		if iter_15_1:getId() == var_15_2 then
			var_15_3 = iter_15_0
			var_15_4 = iter_15_1

			break
		end
	end

	if not var_15_3 or not var_15_4 then
		if arg_15_2 then
			logError("RoomFormulaListModel:listAddTreeFormula error,can't find select formula,id:" .. (arg_15_0._selectFormulaStrId or "nil"))
		end

		return arg_15_1, var_15_0
	end

	local var_15_5 = {}

	for iter_15_2 = 1, var_15_3 do
		table.insert(var_15_5, arg_15_1[iter_15_2])
	end

	local var_15_6 = var_15_4:getId()
	local var_15_7 = arg_15_0:_getTreeLevelFormulaList(var_15_6)

	for iter_15_3 = 1, #var_15_7 do
		local var_15_8 = var_15_7[iter_15_3]

		var_15_0[var_15_8:getId()] = true

		table.insert(var_15_5, var_15_8)
	end

	for iter_15_4 = var_15_3 + 1, #arg_15_1 do
		table.insert(var_15_5, arg_15_1[iter_15_4])
	end

	var_15_4:setIsExpandTree(true)

	return var_15_5, var_15_0
end

function var_0_0._getTreeLevelFormulaList(arg_16_0, arg_16_1)
	local var_16_0 = {}

	if not arg_16_1 then
		return var_16_0
	end

	local var_16_1, var_16_2 = RoomProductionHelper.changeStrUID2FormulaIdAndTreeLevel(arg_16_1)
	local var_16_3 = var_16_2 + 1

	if var_16_3 > RoomFormulaModel.MAX_FORMULA_TREE_LEVEL then
		return var_16_0
	end

	local var_16_4 = RoomProductionHelper.getCostMaterialFormulaList(var_16_1)
	local var_16_5 = #var_16_4

	for iter_16_0, iter_16_1 in ipairs(var_16_4) do
		if iter_16_1 and iter_16_1 ~= 0 then
			local var_16_6 = iter_16_0 == var_16_5
			local var_16_7 = RoomProductionHelper.getFormulaStrUID(iter_16_1, var_16_3)
			local var_16_8 = {
				id = var_16_7,
				isLast = var_16_6,
				parentStrId = arg_16_1
			}
			local var_16_9 = RoomFormulaModel.instance:getFormulaMoWithInfo(var_16_7, var_16_8)

			if var_16_9 then
				table.insert(var_16_0, var_16_9)
			end
		end
	end

	return var_16_0
end

function var_0_0.setSelectFormulaStrId(arg_17_0, arg_17_1)
	local var_17_0
	local var_17_1 = arg_17_0:getTopExpandFormulaStrId()

	if var_17_1 and var_17_1 ~= arg_17_1 then
		var_17_0 = RoomFormulaModel.instance:getFormulaMo(var_17_1, true)
	end

	if arg_17_1 then
		local var_17_2, var_17_3 = RoomProductionHelper.changeStrUID2FormulaIdAndTreeLevel(arg_17_1)

		if var_17_2 and var_17_2 ~= 0 then
			if var_17_3 == RoomFormulaModel.DEFAULT_TREE_LEVEL then
				if var_17_0 then
					var_17_0:resetFormulaCombineCount()
				end

				arg_17_0:setTopExpandFormulaStrId(arg_17_1)
			end

			arg_17_0._selectFormulaStrId = arg_17_1
		end
	else
		arg_17_0._selectFormulaStrId = nil

		arg_17_0:resetTopExpandFormulaStrId()

		if var_17_0 then
			var_17_0:resetFormulaCombineCount()
		end
	end
end

function var_0_0.setFormulaShowType(arg_18_0, arg_18_1)
	arg_18_0._formulaShowType = arg_18_1
end

function var_0_0.setOrder(arg_19_0, arg_19_1)
	arg_19_0._order = arg_19_1
end

function var_0_0.setTopExpandFormulaStrId(arg_20_0, arg_20_1)
	if arg_20_1 then
		local var_20_0, var_20_1 = RoomProductionHelper.changeStrUID2FormulaIdAndTreeLevel(arg_20_1)

		if var_20_1 == RoomFormulaModel.DEFAULT_TREE_LEVEL then
			arg_20_0._topExpandFormulaStrId = arg_20_1
		else
			logError("RoomFormulaListModel:setTopExpandFormulaStrId error,id:" .. arg_20_1 .. "isn't top formula")
		end
	else
		arg_20_0._topExpandFormulaStrId = nil
	end
end

function var_0_0.setIsInList(arg_21_0, arg_21_1)
	arg_21_0.isInList = arg_21_1
end

function var_0_0.resetSelectFormulaStrId(arg_22_0)
	arg_22_0:setSelectFormulaStrId()
end

function var_0_0.resetAllShowFormulaIsExpandTree(arg_23_0)
	local var_23_0 = arg_23_0:getList()

	for iter_23_0, iter_23_1 in ipairs(var_23_0) do
		iter_23_1:resetIsExpandTree()
	end
end

function var_0_0.resetIsInList(arg_24_0)
	arg_24_0:setIsInList(var_0_1)
end

function var_0_0.resetTopExpandFormulaStrId(arg_25_0)
	arg_25_0:setTopExpandFormulaStrId()
end

function var_0_0.getSelectFormulaStrId(arg_26_0)
	return arg_26_0._selectFormulaStrId
end

function var_0_0.getSelectFormulaId(arg_27_0)
	local var_27_0 = 0

	if arg_27_0:getSelectFormulaStrId() then
		var_27_0 = RoomProductionHelper.changeStrUID2FormulaIdAndTreeLevel(arg_27_0._selectFormulaStrId)
	end

	return var_27_0
end

function var_0_0.getSelectFormulaMo(arg_28_0)
	local var_28_0 = arg_28_0:getSelectFormulaStrId()

	if var_28_0 then
		return RoomFormulaModel.instance:getFormulaMo(var_28_0)
	end
end

function var_0_0.getOrder(arg_29_0)
	return arg_29_0._order
end

function var_0_0.getTopExpandFormulaStrId(arg_30_0)
	return arg_30_0._topExpandFormulaStrId
end

function var_0_0.getIsInList(arg_31_0)
	if arg_31_0.isInList == nil then
		arg_31_0:resetIsInList()
	end

	return arg_31_0.isInList
end

function var_0_0.getSelectFormulaCombineCount(arg_32_0)
	local var_32_0 = 0
	local var_32_1 = arg_32_0:getSelectFormulaMo()

	if var_32_1 then
		var_32_0 = var_32_1:getFormulaCombineCount()
	end

	return var_32_0
end

function var_0_0.getSelectFormulaStrIdIndex(arg_33_0)
	local var_33_0 = 0
	local var_33_1 = arg_33_0:getSelectFormulaStrId()
	local var_33_2 = arg_33_0:getList()

	for iter_33_0, iter_33_1 in ipairs(var_33_2) do
		if iter_33_1:getId() == var_33_1 then
			var_33_0 = iter_33_0

			break
		end
	end

	return var_33_0
end

function var_0_0.refreshRankDiff(arg_34_0)
	arg_34_0._idIdxList = {}

	local var_34_0 = arg_34_0:getList()

	for iter_34_0, iter_34_1 in ipairs(var_34_0) do
		table.insert(arg_34_0._idIdxList, iter_34_1.id)
	end
end

function var_0_0.clearRankDiff(arg_35_0)
	arg_35_0._idIdxList = nil
end

function var_0_0.getRankDiff(arg_36_0, arg_36_1)
	if arg_36_0._idIdxList and arg_36_1 then
		local var_36_0 = tabletool.indexOf(arg_36_0._idIdxList, arg_36_1.id)
		local var_36_1 = arg_36_0:getIndex(arg_36_1)

		if var_36_0 and var_36_1 then
			return var_36_1 - var_36_0
		end
	end

	return 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
