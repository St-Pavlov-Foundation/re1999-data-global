module("modules.logic.versionactivity1_3.armpipe.controller.ArmPuzzlePipeRule", package.seeall)

local var_0_0 = class("ArmPuzzlePipeRule")
local var_0_1 = ArmPuzzlePipeEnum.dir.left
local var_0_2 = ArmPuzzlePipeEnum.dir.right
local var_0_3 = ArmPuzzlePipeEnum.dir.down
local var_0_4 = ArmPuzzlePipeEnum.dir.up
local var_0_5 = 0

function var_0_0.ctor(arg_1_0)
	arg_1_0._ruleChange = {
		[0] = 0,
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
		[2468] = 2468
	}
	arg_1_0._ruleConnect = {}

	for iter_1_0, iter_1_1 in pairs(arg_1_0._ruleChange) do
		local var_1_0 = {}
		local var_1_1 = iter_1_0

		while var_1_1 > 0 do
			local var_1_2 = var_1_1 % 10

			var_1_1 = math.floor(var_1_1 / 10)
			var_1_0[var_1_2] = true
		end

		arg_1_0._ruleConnect[iter_1_0] = var_1_0
	end

	arg_1_0._ruleConnect[var_0_5] = {
		[var_0_2] = false,
		[var_0_1] = false,
		[var_0_3] = false,
		[var_0_4] = false
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
	if arg_4_1.typeId == ArmPuzzlePipeEnum.type.first or arg_4_1.typeId == ArmPuzzlePipeEnum.type.last then
		return arg_4_1.entryCount >= 1
	end

	return arg_4_1.entryCount >= ArmPuzzlePipeEnum.pipeEntryClearCount and arg_4_1:getConnectValue() >= ArmPuzzlePipeEnum.pipeEntryClearDecimal
end

function var_0_0.getReachTable(arg_5_0)
	local var_5_0 = {}
	local var_5_1 = {}
	local var_5_2 = {}
	local var_5_3 = {}
	local var_5_4 = ArmPuzzlePipeModel.instance:getEntryList()

	table.sort(var_5_4, var_0_0._sortOrderList)

	for iter_5_0, iter_5_1 in ipairs(var_5_4) do
		table.insert(var_5_2, iter_5_1)

		local var_5_5, var_5_6 = arg_5_0:_getSearchPipeResult(iter_5_1, var_5_2)

		var_5_1[iter_5_1] = var_5_6
		var_5_0[iter_5_1] = var_5_5
		iter_5_1.entryCount = #var_5_6

		if iter_5_1.pathType == ArmPuzzlePipeEnum.PathType.Order then
			table.insert(var_5_3, iter_5_1)
		end
	end

	if #var_5_3 > 0 then
		arg_5_0:_mergeReachDir(var_5_0)
		table.sort(var_5_3, var_0_0._sortOrderList)

		local var_5_7 = false

		for iter_5_2, iter_5_3 in ipairs(var_5_3) do
			if iter_5_3.typeId == ArmPuzzlePipeEnum.type.first then
				var_5_7 = iter_5_3.entryCount > 0
			else
				if not var_5_7 then
					iter_5_3:cleanEntrySet()

					iter_5_3.entryCount = 0
					var_5_1[iter_5_3] = {}
					var_5_0[iter_5_3] = {}
				end

				if var_5_7 and not arg_5_0:getIsEntryClear(iter_5_3) then
					var_5_7 = false
				end
			end
		end

		arg_5_0:_cleaConnMark()
	end

	return var_5_0, var_5_1
end

function var_0_0._cleaConnMark(arg_6_0)
	for iter_6_0 = 1, arg_6_0._gameWidth do
		for iter_6_1 = 1, arg_6_0._gameHeight do
			local var_6_0 = ArmPuzzlePipeModel.instance:getData(iter_6_0, iter_6_1)

			var_6_0.entryCount = var_6_0.entryCount, var_6_0:cleanEntrySet()
		end
	end
end

function var_0_0._sortOrderList(arg_7_0, arg_7_1)
	if arg_7_0.pathIndex ~= arg_7_1.pathIndex then
		return arg_7_0.pathIndex < arg_7_1.pathIndex
	end

	if arg_7_0.numIndex ~= arg_7_1.numIndex then
		return arg_7_0.numIndex < arg_7_1.numIndex
	end
end

function var_0_0._getSearchPipeResult(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = {}
	local var_8_1 = {}

	while #arg_8_2 > 0 do
		local var_8_2 = table.remove(arg_8_2)

		arg_8_0:_addToOpenSet(var_8_2, var_8_1, arg_8_2, var_8_0)
	end

	for iter_8_0 = #var_8_0, 1, -1 do
		local var_8_3 = var_8_0[iter_8_0]

		if not arg_8_0:_checkEntryConnect(arg_8_1, var_8_3) or arg_8_1 == var_8_3 then
			var_8_1[var_8_3] = nil

			table.remove(var_8_0, iter_8_0)
		end
	end

	if #var_8_0 < 1 then
		var_8_1 = {}
	end

	return var_8_1, var_8_0
end

function var_0_0._checkEntryConnect(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_2.pathIndex ~= arg_9_1.pathIndex or arg_9_2.pathType ~= arg_9_1.pathType then
		return false
	end

	if arg_9_2.pathType == ArmPuzzlePipeEnum.PathType.Order then
		local var_9_0 = ArmPuzzlePipeModel.instance
		local var_9_1 = var_9_0:getIndexByMO(arg_9_2)
		local var_9_2 = var_9_0:getIndexByMO(arg_9_1)

		if math.abs(var_9_2 - var_9_1) ~= 1 then
			return false
		end
	end

	return true
end

function var_0_0._addToOpenSet(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	for iter_10_0, iter_10_1 in pairs(arg_10_1.connectSet) do
		local var_10_0, var_10_1, var_10_2 = var_0_0.getIndexByDir(arg_10_1.x, arg_10_1.y, iter_10_0)

		if var_10_0 > 0 and var_10_0 <= arg_10_0._gameWidth and var_10_1 > 0 and var_10_1 <= arg_10_0._gameHeight then
			local var_10_3 = ArmPuzzlePipeModel.instance:getData(var_10_0, var_10_1)

			if not arg_10_2[var_10_3] then
				arg_10_2[var_10_3] = true

				if var_10_3:isEntry() then
					table.insert(arg_10_4, var_10_3)
				else
					table.insert(arg_10_3, var_10_3)
				end
			end
		end
	end

	arg_10_2[arg_10_1] = true
end

function var_0_0._mergeReachDir(arg_11_0, arg_11_1)
	local var_11_0 = {}
	local var_11_1 = {}

	for iter_11_0, iter_11_1 in pairs(arg_11_1) do
		table.insert(var_11_0, iter_11_1)
		table.insert(var_11_1, iter_11_0)
	end

	local var_11_2 = #var_11_0

	for iter_11_2 = 1, var_11_2 do
		local var_11_3 = {}

		for iter_11_3 = iter_11_2 + 1, var_11_2 do
			local var_11_4 = var_11_1[iter_11_2]
			local var_11_5 = var_11_1[iter_11_3]

			if arg_11_0:_checkEntryConnect(var_11_4, var_11_5) then
				local var_11_6 = var_11_0[iter_11_2]
				local var_11_7 = var_11_0[iter_11_3]

				for iter_11_4, iter_11_5 in pairs(var_11_6) do
					if var_11_7[iter_11_4] then
						var_11_3[iter_11_4] = var_11_4.pathIndex
					end
				end

				arg_11_0:_markReachDir(var_11_3)
			end
		end
	end
end

function var_0_0._markReachDir(arg_12_0, arg_12_1)
	for iter_12_0, iter_12_1 in pairs(arg_12_1) do
		for iter_12_2, iter_12_3 in pairs(iter_12_0.connectSet) do
			local var_12_0, var_12_1, var_12_2 = var_0_0.getIndexByDir(iter_12_0.x, iter_12_0.y, iter_12_2)

			if var_12_0 > 0 and var_12_0 <= arg_12_0._gameWidth and var_12_1 > 0 and var_12_1 <= arg_12_0._gameHeight then
				local var_12_3 = ArmPuzzlePipeModel.instance:getData(var_12_0, var_12_1)

				if arg_12_1[var_12_3] then
					iter_12_0.entryConnect[iter_12_2] = true
					var_12_3.entryConnect[var_12_2] = true
					iter_12_0.connectPathIndex = iter_12_1
					var_12_3.connectPathIndex = iter_12_1
				end
			end
		end
	end
end

function var_0_0._unmarkBranch(arg_13_0)
	for iter_13_0 = 1, arg_13_0._gameWidth do
		for iter_13_1 = 1, arg_13_0._gameHeight do
			local var_13_0 = ArmPuzzlePipeModel.instance:getData(iter_13_0, iter_13_1)

			arg_13_0:_unmarkSearchNode(var_13_0)
		end
	end
end

function var_0_0._unmarkSearchNode(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1

	while var_14_0 ~= nil do
		if tabletool.len(var_14_0.entryConnect) == 1 and not var_14_0:isEntry() then
			local var_14_1

			for iter_14_0, iter_14_1 in pairs(var_14_0.entryConnect) do
				var_14_1 = iter_14_0
			end

			local var_14_2, var_14_3, var_14_4 = var_0_0.getIndexByDir(var_14_0.x, var_14_0.y, var_14_1)
			local var_14_5 = ArmPuzzlePipeModel.instance:getData(var_14_2, var_14_3)

			var_14_0.entryConnect[var_14_1] = nil
			var_14_5.entryConnect[var_14_4] = nil
			var_14_0 = var_14_5
		else
			var_14_0 = nil
		end
	end
end

function var_0_0.setSingleConnection(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
	if arg_15_1 > 0 and arg_15_1 <= arg_15_0._gameWidth and arg_15_2 > 0 and arg_15_2 <= arg_15_0._gameHeight then
		local var_15_0 = ArmPuzzlePipeModel.instance:getData(arg_15_1, arg_15_2)
		local var_15_1 = arg_15_0._ruleConnect[var_15_0.value]
		local var_15_2 = arg_15_0._ruleConnect[arg_15_5.value]
		local var_15_3 = var_15_1[arg_15_3] and var_15_2[arg_15_4]
		local var_15_4

		var_15_4 = var_15_0.connectSet[arg_15_3] == true

		if var_15_3 then
			var_15_0.connectSet[arg_15_3] = true
			arg_15_5.connectSet[arg_15_4] = true
		else
			var_15_0.connectSet[arg_15_3] = nil
			arg_15_5.connectSet[arg_15_4] = nil
		end
	end
end

function var_0_0.changeDirection(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = ArmPuzzlePipeModel.instance:getData(arg_16_1, arg_16_2)
	local var_16_1 = arg_16_0._ruleChange[var_16_0.value]

	if var_16_1 then
		var_16_0.value = var_16_1
	end

	return var_16_0
end

function var_0_0.getRandomSkipSet(arg_17_0)
	local var_17_0 = {}
	local var_17_1 = ArmPuzzlePipeModel.instance:getEntryList()
	local var_17_2, var_17_3 = ArmPuzzlePipeModel.instance:getGameSize()

	for iter_17_0, iter_17_1 in ipairs(var_17_1) do
		var_17_0[iter_17_1] = true

		local var_17_4 = iter_17_1.x
		local var_17_5 = iter_17_1.y

		arg_17_0:_insertToSet(var_17_4 - 1, var_17_5, var_17_0)
		arg_17_0:_insertToSet(var_17_4 + 1, var_17_5, var_17_0)
		arg_17_0:_insertToSet(var_17_4, var_17_5 - 1, var_17_0)
		arg_17_0:_insertToSet(var_17_4, var_17_5 + 1, var_17_0)
	end

	return var_17_0
end

function var_0_0._insertToSet(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if arg_18_1 > 0 and arg_18_1 <= arg_18_0._gameWidth and arg_18_2 > 0 and arg_18_2 <= arg_18_0._gameHeight then
		arg_18_3[ArmPuzzlePipeModel.instance:getData(arg_18_1, arg_18_2)] = true
	end
end

function var_0_0.getIndexByDir(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_2 == var_0_1 then
		return arg_19_0 - 1, arg_19_1, var_0_2
	elseif arg_19_2 == var_0_2 then
		return arg_19_0 + 1, arg_19_1, var_0_1
	elseif arg_19_2 == var_0_4 then
		return arg_19_0, arg_19_1 + 1, var_0_3
	elseif arg_19_2 == var_0_3 then
		return arg_19_0, arg_19_1 - 1, var_0_4
	end
end

return var_0_0
