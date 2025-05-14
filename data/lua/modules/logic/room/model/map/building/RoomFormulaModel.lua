module("modules.logic.room.model.map.building.RoomFormulaModel", package.seeall)

local var_0_0 = class("RoomFormulaModel", BaseModel)

var_0_0.DEFAULT_TREE_LEVEL = 1
var_0_0.MAX_FORMULA_TREE_LEVEL = 4

function var_0_0.onInit(arg_1_0)
	arg_1_0:_clearData()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:_clearData()
end

function var_0_0.clear(arg_3_0)
	var_0_0.super.clear(arg_3_0)
	arg_3_0:_clearData()
end

function var_0_0._clearData(arg_4_0)
	return
end

function var_0_0.initFormula(arg_5_0)
	arg_5_0:clear()

	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(lua_formula.configList) do
		local var_5_1 = RoomProductionHelper.getFormulaStrUID(iter_5_1.id, var_0_0.DEFAULT_TREE_LEVEL)

		table.insert(var_5_0, {
			id = var_5_1
		})
	end

	arg_5_0:addFormulaList(var_5_0)
end

function var_0_0.addFormulaList(arg_6_0, arg_6_1)
	if not arg_6_1 or #arg_6_1 <= 0 then
		return
	end

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		arg_6_0:addFormula(iter_6_1)
	end
end

function var_0_0.addFormula(arg_7_0, arg_7_1)
	if not arg_7_1 then
		return
	end

	local var_7_0 = RoomFormulaMO.New()

	var_7_0:init(arg_7_1)

	if not var_7_0:getConfig() then
		return
	end

	arg_7_0:addAtLast(var_7_0)

	return var_7_0
end

function var_0_0.getAllTopTreeLevelFormulaMoList(arg_8_0)
	local var_8_0 = {}
	local var_8_1 = arg_8_0:getList()

	for iter_8_0, iter_8_1 in ipairs(var_8_1) do
		if iter_8_1:getFormulaTreeLevel() == var_0_0.DEFAULT_TREE_LEVEL then
			table.insert(var_8_0, iter_8_1)
		end
	end

	return var_8_0
end

function var_0_0.getAllTopTreeLevelCount(arg_9_0)
	return #arg_9_0:getAllTopTreeLevelFormulaMoList()
end

function var_0_0.getTopTreeLevelFormulaMoList(arg_10_0, arg_10_1)
	local var_10_0 = {}
	local var_10_1 = arg_10_0:getAllTopTreeLevelFormulaMoList()

	for iter_10_0, iter_10_1 in ipairs(var_10_1) do
		if iter_10_1.config.showType == arg_10_1 then
			table.insert(var_10_0, iter_10_1)
		end
	end

	return var_10_0
end

function var_0_0.getTopTreeLevelFormulaCount(arg_11_0, arg_11_1)
	return #arg_11_0:getTopTreeLevelFormulaMoList(arg_11_1)
end

function var_0_0.getFormulaMo(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = arg_12_0:getById(arg_12_1)

	if not var_12_0 and not arg_12_2 then
		logError("RoomFormulaModel:getFormulaMo error, can't find RoomFormulaMo:" .. (arg_12_1 or "nil"))
	end

	return var_12_0
end

function var_0_0.getFormulaMoWithInfo(arg_13_0, arg_13_1, arg_13_2)
	if string.nilorempty(arg_13_1) then
		return
	end

	local var_13_0 = arg_13_0:getById(arg_13_1)

	if var_13_0 then
		var_13_0:init(arg_13_2)
		var_13_0:resetFormulaCombineCount()
	else
		var_13_0 = arg_13_0:addFormula(arg_13_2)
	end

	return var_13_0
end

function var_0_0.getFormulaIsLast(arg_14_0, arg_14_1)
	local var_14_0 = true
	local var_14_1 = arg_14_0:getFormulaMo(arg_14_1)

	if var_14_1 then
		var_14_0 = var_14_1:getIsLast()
	end

	return var_14_0
end

function var_0_0.getFormulaParentStrId(arg_15_0, arg_15_1)
	local var_15_0
	local var_15_1 = var_0_0.instance:getFormulaMo(arg_15_1)

	if var_15_1 then
		var_15_0 = var_15_1:getParentStrId()
	end

	return var_15_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
