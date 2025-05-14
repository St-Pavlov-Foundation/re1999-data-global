module("modules.logic.dungeon.controller.DungeonPuzzleCircuitRule", package.seeall)

local var_0_0 = class("DungeonPuzzleCircuitRule")
local var_0_1 = DungeonPuzzleCircuitEnum.dir.left
local var_0_2 = DungeonPuzzleCircuitEnum.dir.right
local var_0_3 = DungeonPuzzleCircuitEnum.dir.down
local var_0_4 = DungeonPuzzleCircuitEnum.dir.up

function var_0_0.ctor(arg_1_0)
	arg_1_0._ruleChange = {
		[28] = 46,
		[248] = 468,
		[24] = 48,
		[46] = 28,
		[48] = 68,
		[246] = 248,
		[268] = 246,
		[468] = 268,
		[26] = 24,
		[68] = 26
	}
	arg_1_0._ruleConnect = {}

	for iter_1_0, iter_1_1 in pairs(arg_1_0._ruleChange) do
		if iter_1_0 ~= 0 then
			local var_1_0 = {}
			local var_1_1 = iter_1_0

			while var_1_1 > 0 do
				local var_1_2 = var_1_1 % 10

				var_1_1 = (var_1_1 - var_1_2) / 10
				var_1_0[var_1_2] = true
			end

			arg_1_0._ruleConnect[iter_1_0] = var_1_0
		end
	end

	arg_1_0._ruleTypeConnect = {}
	arg_1_0._ruleTypeConnect[DungeonPuzzleCircuitEnum.type.power1] = {
		[var_0_2] = true,
		[var_0_1] = true
	}
	arg_1_0._ruleTypeConnect[DungeonPuzzleCircuitEnum.type.power2] = {
		[var_0_3] = true,
		[var_0_4] = true
	}
	arg_1_0._ruleTypeConnect[DungeonPuzzleCircuitEnum.type.capacitance] = {
		[var_0_2] = true,
		[var_0_1] = true,
		[var_0_3] = true,
		[var_0_4] = true
	}
	arg_1_0._ruleTypeConnect[DungeonPuzzleCircuitEnum.type.wrong] = {
		[var_0_2] = true,
		[var_0_1] = true,
		[var_0_3] = true,
		[var_0_4] = true
	}
end

function var_0_0.changeDirection(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = DungeonPuzzleCircuitModel.instance:getData(arg_2_1, arg_2_2)

	if not var_2_0 then
		return
	end

	local var_2_1 = arg_2_0._ruleChange[var_2_0.value]

	if var_2_1 then
		var_2_0.value = var_2_1
	end

	return var_2_0
end

function var_0_0.getOldCircuitList(arg_3_0)
	return arg_3_0._oldCircuiteList
end

function var_0_0.getOldCapacitanceList(arg_4_0)
	return arg_4_0._oldCapacitanceList
end

function var_0_0.getOldWrongList(arg_5_0)
	return arg_5_0._oldWrongList
end

function var_0_0.getCircuitList(arg_6_0)
	return arg_6_0._circuitList
end

function var_0_0.getCapacitanceList(arg_7_0)
	return arg_7_0._capacitanceList
end

function var_0_0.getWrongList(arg_8_0)
	return arg_8_0._wrongList
end

function var_0_0.isWin(arg_9_0)
	return arg_9_0._win
end

function var_0_0.refreshAllConnection(arg_10_0)
	arg_10_0._oldCircuiteList = arg_10_0._circuitList
	arg_10_0._oldCapacitanceList = arg_10_0._capacitanceList

	arg_10_0:_powerConnect()

	arg_10_0._oldWrongList = arg_10_0._wrongList

	arg_10_0:_wrongConnect()
end

function var_0_0._wrongConnect(arg_11_0)
	arg_11_0._wrongList = {}

	local var_11_0 = DungeonPuzzleCircuitModel.instance:getWrongList()

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		local var_11_1 = iter_11_1.x
		local var_11_2 = iter_11_1.y

		arg_11_0:_addWrongList(arg_11_0:_findSingle(var_11_1 - 1, var_11_2, var_0_3, var_0_4, iter_11_1))
		arg_11_0:_addWrongList(arg_11_0:_findSingle(var_11_1 + 1, var_11_2, var_0_4, var_0_3, iter_11_1))
		arg_11_0:_addWrongList(arg_11_0:_findSingle(var_11_1, var_11_2 + 1, var_0_1, var_0_2, iter_11_1))
		arg_11_0:_addWrongList(arg_11_0:_findSingle(var_11_1, var_11_2 - 1, var_0_2, var_0_1, iter_11_1))
	end
end

function var_0_0._addWrongList(arg_12_0, arg_12_1)
	if not arg_12_1 then
		return
	end

	arg_12_0._wrongList[arg_12_1.id] = arg_12_1
end

function var_0_0._powerConnect(arg_13_0)
	arg_13_0._closeList = {}
	arg_13_0._powerList = {}
	arg_13_0._capacitanceList = {}
	arg_13_0._circuitList = {}

	local var_13_0 = DungeonPuzzleCircuitModel.instance:getPowerList()
	local var_13_1 = DungeonPuzzleCircuitModel.instance:getCapacitanceList()

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		if iter_13_1.type == DungeonPuzzleCircuitEnum.type.power1 then
			arg_13_0:_findConnectPath(iter_13_1)

			if #arg_13_0._powerList == #var_13_0 and #arg_13_0._capacitanceList == #var_13_1 then
				arg_13_0._win = true

				return
			end
		end
	end
end

function var_0_0._findConnectPath(arg_14_0, arg_14_1)
	local var_14_0 = {
		arg_14_1
	}

	while #var_14_0 > 0 do
		local var_14_1 = table.remove(var_14_0)

		if not arg_14_0._closeList[var_14_1.id] then
			if var_14_1.type == DungeonPuzzleCircuitEnum.type.power1 or var_14_1.type == DungeonPuzzleCircuitEnum.type.power2 then
				table.insert(arg_14_0._powerList, var_14_1)
			elseif var_14_1.type == DungeonPuzzleCircuitEnum.type.capacitance then
				table.insert(arg_14_0._capacitanceList, var_14_1)
			end
		end

		arg_14_0._closeList[var_14_1.id] = var_14_1

		if var_14_1.type ~= DungeonPuzzleCircuitEnum.type.capacitance and var_14_1.type ~= DungeonPuzzleCircuitEnum.type.wrong then
			if var_14_1.type >= DungeonPuzzleCircuitEnum.type.straight and var_14_1.type <= DungeonPuzzleCircuitEnum.type.t_shape then
				table.insert(arg_14_0._circuitList, var_14_1)
			end

			local var_14_2 = var_14_1.x
			local var_14_3 = var_14_1.y

			arg_14_0:_addToOpenList(arg_14_0:_findSingle(var_14_2 - 1, var_14_3, var_0_3, var_0_4, var_14_1), var_14_0, arg_14_0._closeList)
			arg_14_0:_addToOpenList(arg_14_0:_findSingle(var_14_2 + 1, var_14_3, var_0_4, var_0_3, var_14_1), var_14_0, arg_14_0._closeList)
			arg_14_0:_addToOpenList(arg_14_0:_findSingle(var_14_2, var_14_3 + 1, var_0_1, var_0_2, var_14_1), var_14_0, arg_14_0._closeList)
			arg_14_0:_addToOpenList(arg_14_0:_findSingle(var_14_2, var_14_3 - 1, var_0_2, var_0_1, var_14_1), var_14_0, arg_14_0._closeList)
		end
	end
end

function var_0_0._addToOpenList(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	if not arg_15_1 or not arg_15_2 or not arg_15_3 or arg_15_3[arg_15_1.id] then
		return
	end

	table.insert(arg_15_2, arg_15_1)
end

function var_0_0._findAround(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_1.x
	local var_16_1 = arg_16_1.y

	arg_16_0:_findSingle(var_16_0 - 1, var_16_1, var_0_3, var_0_4, arg_16_1)
	arg_16_0:_findSingle(var_16_0 + 1, var_16_1, var_0_4, var_0_3, arg_16_1)
	arg_16_0:_findSingle(var_16_0, var_16_1 + 1, var_0_1, var_0_2, arg_16_1)
	arg_16_0:_findSingle(var_16_0, var_16_1 - 1, var_0_2, var_0_1, arg_16_1)
end

function var_0_0._findSingle(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4, arg_17_5)
	if arg_17_1 > 0 and arg_17_1 <= DungeonPuzzleCircuitModel.constHeight and arg_17_2 > 0 and arg_17_2 <= DungeonPuzzleCircuitModel.constWidth then
		local var_17_0 = DungeonPuzzleCircuitModel.instance:getData(arg_17_1, arg_17_2)

		if not var_17_0 then
			return
		end

		local var_17_1 = arg_17_0:_getConnectRule(var_17_0)
		local var_17_2 = arg_17_0:_getConnectRule(arg_17_5)

		return var_17_1[arg_17_3] and var_17_2[arg_17_4] and var_17_0
	end
end

function var_0_0._getConnectRule(arg_18_0, arg_18_1)
	return arg_18_0._ruleConnect[arg_18_1.value] or arg_18_0._ruleTypeConnect[arg_18_1.type]
end

return var_0_0
