module("modules.logic.dungeon.model.DungeonPuzzlePipeModel", package.seeall)

local var_0_0 = class("DungeonPuzzlePipeModel", BaseModel)

var_0_0.constWidth = 7
var_0_0.constHeight = 5
var_0_0.constEntry = 0

function var_0_0.reInit(arg_1_0)
	arg_1_0:release()
end

function var_0_0.release(arg_2_0)
	arg_2_0._cfgElement = nil
	arg_2_0._startX = nil
	arg_2_0._startY = nil
	arg_2_0._gridDatas = nil
	arg_2_0._isGameClear = false
	arg_2_0._entryList = nil
end

function var_0_0.initByElementCo(arg_3_0, arg_3_1)
	arg_3_0._cfgElement = arg_3_1

	if arg_3_0._cfgElement then
		arg_3_0:initData()

		if not string.nilorempty(arg_3_0._cfgElement.param) then
			arg_3_0:initPuzzle(arg_3_0._cfgElement.param)
		end
	end
end

function var_0_0.initData(arg_4_0)
	arg_4_0._gridDatas = {}

	local var_4_0, var_4_1 = arg_4_0:getGameSize()
	local var_4_2

	for iter_4_0 = 1, var_4_0 do
		for iter_4_1 = 1, var_4_1 do
			arg_4_0._gridDatas[iter_4_0] = arg_4_0._gridDatas[iter_4_0] or {}

			local var_4_3 = DungeonPuzzlePipeMO.New()

			var_4_3:init(iter_4_0, iter_4_1)

			arg_4_0._gridDatas[iter_4_0][iter_4_1] = var_4_3
		end
	end

	arg_4_0._startX = -var_4_0 * 0.5 - 0.5
	arg_4_0._startY = -var_4_1 * 0.5 - 0.5
end

function var_0_0.initPuzzle(arg_5_0, arg_5_1)
	arg_5_0._entryList = {}

	local var_5_0 = string.splitToNumber(arg_5_1, ",")
	local var_5_1 = 0
	local var_5_2, var_5_3 = arg_5_0:getGameSize()

	if #var_5_0 >= var_5_2 * var_5_3 then
		local var_5_4 = 1

		for iter_5_0 = 1, var_5_2 do
			for iter_5_1 = 1, var_5_3 do
				local var_5_5 = var_5_0[var_5_4]
				local var_5_6 = arg_5_0._gridDatas[iter_5_0][iter_5_1]

				var_5_6.value = var_5_5

				if var_5_5 == var_0_0.constEntry then
					table.insert(arg_5_0._entryList, var_5_6)
				end

				var_5_4 = var_5_4 + 1
			end
		end
	end
end

function var_0_0.resetEntryConnect(arg_6_0)
	local var_6_0, var_6_1 = arg_6_0:getGameSize()

	for iter_6_0 = 1, var_6_0 do
		for iter_6_1 = 1, var_6_1 do
			arg_6_0._gridDatas[iter_6_0][iter_6_1]:cleanEntrySet()
		end
	end
end

function var_0_0.setGameClear(arg_7_0, arg_7_1)
	arg_7_0._isGameClear = arg_7_1
end

function var_0_0.getData(arg_8_0, arg_8_1, arg_8_2)
	return arg_8_0._gridDatas[arg_8_1][arg_8_2]
end

function var_0_0.getGameSize(arg_9_0)
	return var_0_0.constWidth, var_0_0.constHeight
end

function var_0_0.getGameClear(arg_10_0)
	return arg_10_0._isGameClear
end

function var_0_0.getEntryList(arg_11_0)
	return arg_11_0._entryList
end

function var_0_0.getElementCo(arg_12_0)
	return arg_12_0._cfgElement
end

function var_0_0.getRelativePosition(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	return (arg_13_0._startX + arg_13_1) * arg_13_3, (arg_13_0._startY + arg_13_2) * arg_13_4
end

function var_0_0.getIndexByTouchPos(arg_14_0, arg_14_1, arg_14_2, arg_14_3, arg_14_4)
	local var_14_0 = math.floor((arg_14_1 - (arg_14_0._startX + 0.5) * arg_14_3) / arg_14_3)
	local var_14_1 = math.floor((arg_14_2 - (arg_14_0._startY + 0.5) * arg_14_4) / arg_14_4)
	local var_14_2, var_14_3 = arg_14_0:getGameSize()

	if var_14_0 >= 0 and var_14_0 < var_14_2 and var_14_1 >= 0 and var_14_1 < var_14_3 then
		return var_14_0 + 1, var_14_1 + 1
	end

	return -1, -1
end

var_0_0.instance = var_0_0.New()

return var_0_0
