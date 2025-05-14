module("modules.logic.dungeon.model.DungeonPuzzleCircuitModel", package.seeall)

local var_0_0 = class("DungeonPuzzleCircuitModel", BaseModel)

var_0_0.constWidth = 10
var_0_0.constHeight = 6

function var_0_0.reInit(arg_1_0)
	arg_1_0:release()
end

function var_0_0.release(arg_2_0)
	arg_2_0._cfgElement = nil
	arg_2_0._gridDatas = nil
end

function var_0_0.getElementCo(arg_3_0)
	return arg_3_0._cfgElement
end

function var_0_0.getEditIndex(arg_4_0)
	return arg_4_0._editIndex
end

function var_0_0.setEditIndex(arg_5_0, arg_5_1)
	arg_5_0._editIndex = arg_5_1
end

function var_0_0.initByElementCo(arg_6_0, arg_6_1)
	arg_6_0._cfgElement = arg_6_1

	if arg_6_0._cfgElement then
		arg_6_0:initPuzzle(arg_6_0._cfgElement.param)
	end
end

function var_0_0.initPuzzle(arg_7_0, arg_7_1)
	arg_7_0._powerList = {}
	arg_7_0._wrongList = {}
	arg_7_0._capacitanceList = {}
	arg_7_0._gridDatas = {}

	local var_7_0 = string.split(arg_7_1, ",")
	local var_7_1 = 0
	local var_7_2, var_7_3 = arg_7_0:getGameSize()
	local var_7_4 = 1

	for iter_7_0 = 1, var_7_3 do
		for iter_7_1 = 1, var_7_2 do
			local var_7_5 = var_7_0[var_7_4]

			var_7_4 = var_7_4 + 1

			local var_7_6 = string.splitToNumber(var_7_5, "#")
			local var_7_7 = var_7_6[1]
			local var_7_8 = var_7_6[2]

			if var_7_7 and var_7_7 > 0 then
				local var_7_9 = arg_7_0:_getMo(iter_7_0, iter_7_1)

				var_7_9.type = var_7_7
				var_7_9.value = var_7_8
				var_7_9.rawValue = var_7_8

				if var_7_7 == DungeonPuzzleCircuitEnum.type.power1 or var_7_7 == DungeonPuzzleCircuitEnum.type.power2 then
					table.insert(arg_7_0._powerList, var_7_9)
				elseif var_7_7 == DungeonPuzzleCircuitEnum.type.wrong then
					table.insert(arg_7_0._wrongList, var_7_9)
				elseif var_7_7 == DungeonPuzzleCircuitEnum.type.capacitance then
					table.insert(arg_7_0._capacitanceList, var_7_9)
				end
			end
		end
	end
end

function var_0_0.getPowerList(arg_8_0)
	return arg_8_0._powerList
end

function var_0_0.getWrongList(arg_9_0)
	return arg_9_0._wrongList
end

function var_0_0.getCapacitanceList(arg_10_0)
	return arg_10_0._capacitanceList
end

function var_0_0._getMo(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0._gridDatas[arg_11_1] = arg_11_0._gridDatas[arg_11_1] or {}

	local var_11_0 = DungeonPuzzleCircuitMO.New()

	var_11_0:init(arg_11_1, arg_11_2)

	arg_11_0._gridDatas[arg_11_1][arg_11_2] = var_11_0

	return var_11_0
end

function var_0_0.debugData(arg_12_0)
	local var_12_0
	local var_12_1, var_12_2 = arg_12_0:getGameSize()

	for iter_12_0 = 1, var_12_2 do
		for iter_12_1 = 1, var_12_1 do
			local var_12_3 = arg_12_0:getData(iter_12_0, iter_12_1)
			local var_12_4

			if not var_12_3 or var_12_3.type <= 0 then
				var_12_4 = string.format("%s", 0)
			elseif var_12_3.type >= DungeonPuzzleCircuitEnum.type.straight and var_12_3.type <= DungeonPuzzleCircuitEnum.type.t_shape then
				var_12_4 = string.format("%s#%s", var_12_3.type, var_12_3.value)
			else
				var_12_4 = string.format("%s", var_12_3.type)
			end

			var_12_0 = string.format("%s%s", var_12_0 and var_12_0 .. "," or "", var_12_4)
		end
	end

	print("data:", var_12_0)
end

function var_0_0.getData(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_0._gridDatas[arg_13_1]

	return var_13_0 and var_13_0[arg_13_2]
end

function var_0_0.getGameSize(arg_14_0)
	return var_0_0.constWidth, var_0_0.constHeight
end

function var_0_0.getRelativePosition(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	return (arg_15_2 - 1) * arg_15_3, (arg_15_1 - 1) * -arg_15_4
end

function var_0_0.getIndexByTouchPos(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	arg_16_2 = math.abs(arg_16_2 - 0.5 * arg_16_4)
	arg_16_1 = math.abs(arg_16_1 + 0.5 * arg_16_3)

	local var_16_0 = math.floor(arg_16_2 / arg_16_4)
	local var_16_1 = math.floor(arg_16_1 / arg_16_3)
	local var_16_2, var_16_3 = arg_16_0:getGameSize()

	if var_16_1 >= 0 and var_16_1 < var_16_2 and var_16_0 >= 0 and var_16_0 < var_16_3 then
		return var_16_0 + 1, var_16_1 + 1
	end

	return -1, -1
end

var_0_0.instance = var_0_0.New()

return var_0_0
