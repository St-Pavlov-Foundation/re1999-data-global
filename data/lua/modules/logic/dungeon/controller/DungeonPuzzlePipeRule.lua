module("modules.logic.dungeon.controller.DungeonPuzzlePipeRule", package.seeall)

local var_0_0 = class("DungeonPuzzlePipeRule")
local var_0_1 = DungeonPuzzleEnum.dir.left
local var_0_2 = DungeonPuzzleEnum.dir.right
local var_0_3 = DungeonPuzzleEnum.dir.down
local var_0_4 = DungeonPuzzleEnum.dir.up

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
		[68] = 26,
		[DungeonPuzzlePipeModel.constEntry] = DungeonPuzzlePipeModel.constEntry
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

	arg_1_0._ruleConnect[DungeonPuzzlePipeModel.constEntry] = {
		[var_0_2] = true,
		[var_0_1] = true,
		[var_0_3] = true,
		[var_0_4] = true
	}
end

function var_0_0.setGameSize(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._gameWidth = arg_2_1
	arg_2_0._gameHeight = arg_2_2
end

function var_0_0.isGameClear(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in pairs(arg_3_1) do
		if not arg_3_0:getIsEntryClear(iter_3_0) then
			return false
		end
	end

	return true
end

function var_0_0.getIsEntryClear(arg_4_0, arg_4_1)
	return arg_4_1.entryCount >= DungeonPuzzleEnum.pipeEntryClearCount and arg_4_1:getConnectValue() >= DungeonPuzzleEnum.pipeEntryClearDecimal
end

function var_0_0.getReachTable(arg_5_0)
	local var_5_0 = {}
	local var_5_1 = {}
	local var_5_2 = {}
	local var_5_3 = DungeonPuzzlePipeModel.instance:getEntryList()

	for iter_5_0, iter_5_1 in ipairs(var_5_3) do
		table.insert(var_5_2, iter_5_1)

		local var_5_4, var_5_5 = arg_5_0:_getSearchPipeResult(iter_5_1, var_5_2)

		var_5_1[iter_5_1] = var_5_5
		var_5_0[iter_5_1] = var_5_4
		iter_5_1.entryCount = #var_5_5
	end

	return var_5_0, var_5_1
end

function var_0_0._getSearchPipeResult(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = {}
	local var_6_1 = {}

	while #arg_6_2 > 0 do
		local var_6_2 = table.remove(arg_6_2)

		if var_6_2:isEntry() and var_6_2 ~= arg_6_1 then
			if not var_6_1[var_6_2] then
				table.insert(var_6_0, var_6_2)
			end
		else
			arg_6_0:_addToOpenSet(var_6_2, var_6_1, arg_6_2)
		end

		var_6_1[var_6_2] = true
	end

	return var_6_1, var_6_0
end

function var_0_0._addToOpenSet(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	for iter_7_0, iter_7_1 in pairs(arg_7_1.connectSet) do
		local var_7_0, var_7_1, var_7_2 = var_0_0.getIndexByDir(arg_7_1.x, arg_7_1.y, iter_7_0)

		if var_7_0 > 0 and var_7_0 <= arg_7_0._gameWidth and var_7_1 > 0 and var_7_1 <= arg_7_0._gameHeight then
			local var_7_3 = DungeonPuzzlePipeModel.instance:getData(var_7_0, var_7_1)

			if not arg_7_2[var_7_3] then
				table.insert(arg_7_3, var_7_3)
			end
		end
	end
end

function var_0_0._mergeReachDir(arg_8_0, arg_8_1)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in pairs(arg_8_1) do
		table.insert(var_8_0, iter_8_1)
	end

	local var_8_1 = #var_8_0

	for iter_8_2 = 1, var_8_1 do
		local var_8_2 = {}

		for iter_8_3 = iter_8_2 + 1, var_8_1 do
			local var_8_3 = var_8_0[iter_8_2]
			local var_8_4 = var_8_0[iter_8_3]

			for iter_8_4, iter_8_5 in pairs(var_8_3) do
				if var_8_4[iter_8_4] then
					var_8_2[iter_8_4] = 1
				end
			end

			arg_8_0:_markReachDir(var_8_2)
		end
	end
end

function var_0_0._markReachDir(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in pairs(arg_9_1) do
		for iter_9_2, iter_9_3 in pairs(iter_9_0.connectSet) do
			local var_9_0, var_9_1, var_9_2 = var_0_0.getIndexByDir(iter_9_0.x, iter_9_0.y, iter_9_2)

			if var_9_0 > 0 and var_9_0 <= arg_9_0._gameWidth and var_9_1 > 0 and var_9_1 <= arg_9_0._gameHeight then
				local var_9_3 = DungeonPuzzlePipeModel.instance:getData(var_9_0, var_9_1)

				if arg_9_1[var_9_3] then
					iter_9_0.entryConnect[iter_9_2] = true
					var_9_3.entryConnect[var_9_2] = true
				end
			end
		end
	end
end

function var_0_0._unmarkBranch(arg_10_0)
	for iter_10_0 = 1, arg_10_0._gameWidth do
		for iter_10_1 = 1, arg_10_0._gameHeight do
			local var_10_0 = DungeonPuzzlePipeModel.instance:getData(iter_10_0, iter_10_1)

			arg_10_0:_unmarkSearchNode(var_10_0)
		end
	end
end

function var_0_0._unmarkSearchNode(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1

	while var_11_0 ~= nil do
		if tabletool.len(var_11_0.entryConnect) == 1 and not var_11_0:isEntry() then
			local var_11_1

			for iter_11_0, iter_11_1 in pairs(var_11_0.entryConnect) do
				var_11_1 = iter_11_0
			end

			local var_11_2, var_11_3, var_11_4 = var_0_0.getIndexByDir(var_11_0.x, var_11_0.y, var_11_1)
			local var_11_5 = DungeonPuzzlePipeModel.instance:getData(var_11_2, var_11_3)

			var_11_0.entryConnect[var_11_1] = nil
			var_11_5.entryConnect[var_11_4] = nil
			var_11_0 = var_11_5
		else
			var_11_0 = nil
		end
	end
end

function var_0_0.setSingleConnection(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5)
	if arg_12_1 > 0 and arg_12_1 <= arg_12_0._gameWidth and arg_12_2 > 0 and arg_12_2 <= arg_12_0._gameHeight then
		local var_12_0 = DungeonPuzzlePipeModel.instance:getData(arg_12_1, arg_12_2)
		local var_12_1 = arg_12_0._ruleConnect[var_12_0.value]
		local var_12_2 = arg_12_0._ruleConnect[arg_12_5.value]
		local var_12_3 = var_12_1[arg_12_3] and var_12_2[arg_12_4]
		local var_12_4

		var_12_4 = var_12_0.connectSet[arg_12_3] == true

		if var_12_3 then
			var_12_0.connectSet[arg_12_3] = true
			arg_12_5.connectSet[arg_12_4] = true
		else
			var_12_0.connectSet[arg_12_3] = nil
			arg_12_5.connectSet[arg_12_4] = nil
		end
	end
end

function var_0_0.changeDirection(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = DungeonPuzzlePipeModel.instance:getData(arg_13_1, arg_13_2)
	local var_13_1 = arg_13_0._ruleChange[var_13_0.value]

	if var_13_1 then
		var_13_0.value = var_13_1
	end

	return var_13_0
end

function var_0_0.getRandomSkipSet(arg_14_0)
	local var_14_0 = {}
	local var_14_1 = DungeonPuzzlePipeModel.instance:getEntryList()
	local var_14_2, var_14_3 = DungeonPuzzlePipeModel.instance:getGameSize()

	for iter_14_0, iter_14_1 in ipairs(var_14_1) do
		var_14_0[iter_14_1] = true

		local var_14_4 = iter_14_1.x
		local var_14_5 = iter_14_1.y

		arg_14_0:_insertToSet(var_14_4 - 1, var_14_5, var_14_0)
		arg_14_0:_insertToSet(var_14_4 + 1, var_14_5, var_14_0)
		arg_14_0:_insertToSet(var_14_4, var_14_5 - 1, var_14_0)
		arg_14_0:_insertToSet(var_14_4, var_14_5 + 1, var_14_0)
	end

	return var_14_0
end

function var_0_0._insertToSet(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	if arg_15_1 > 0 and arg_15_1 <= arg_15_0._gameWidth and arg_15_2 > 0 and arg_15_2 <= arg_15_0._gameHeight then
		arg_15_3[DungeonPuzzlePipeModel.instance:getData(arg_15_1, arg_15_2)] = true
	end
end

function var_0_0.getIndexByDir(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_2 == var_0_1 then
		return arg_16_0 - 1, arg_16_1, var_0_2
	elseif arg_16_2 == var_0_2 then
		return arg_16_0 + 1, arg_16_1, var_0_1
	elseif arg_16_2 == var_0_4 then
		return arg_16_0, arg_16_1 + 1, var_0_3
	elseif arg_16_2 == var_0_3 then
		return arg_16_0, arg_16_1 - 1, var_0_4
	end
end

return var_0_0
