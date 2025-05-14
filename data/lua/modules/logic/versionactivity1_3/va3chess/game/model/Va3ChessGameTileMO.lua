module("modules.logic.versionactivity1_3.va3chess.game.model.Va3ChessGameTileMO", package.seeall)

local var_0_0 = pureTable("Va3ChessGameTileMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1 or arg_1_0.id or 1
	arg_1_0.tileType = 0
	arg_1_0.triggerTypeList = {}
	arg_1_0.finishList = {}
	arg_1_0.triggerStatusDict = {}
end

function var_0_0.addTrigger(arg_2_0, arg_2_1)
	if arg_2_1 and arg_2_1 > 0 and tabletool.indexOf(arg_2_0.triggerTypeList, arg_2_1) == nil then
		table.insert(arg_2_0.triggerTypeList, arg_2_1)
	end
end

function var_0_0.updateTrigger(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_0.triggerStatusDict[arg_3_1] ~= arg_3_2 then
		arg_3_0.triggerStatusDict[arg_3_1] = arg_3_2
	end
end

function var_0_0.getTriggerBrokenStatus(arg_4_0)
	local var_4_0 = arg_4_0:getTriggerStatus(Va3ChessEnum.TileTrigger.Broken)
	local var_4_1 = Va3ChessEnum.TileTrigger.Broken

	var_4_0 = var_4_0 or Va3ChessEnum.TriggerStatus[var_4_1].Normal

	return var_4_0
end

function var_0_0.getTriggerStatus(arg_5_0, arg_5_1)
	if arg_5_0.triggerStatusDict then
		return arg_5_0.triggerStatusDict[arg_5_1]
	end
end

function var_0_0.removeTrigger(arg_6_0, arg_6_1)
	tabletool.removeValue(arg_6_0.triggerTypeList, arg_6_1)
end

function var_0_0.isHasTrigger(arg_7_0, arg_7_1)
	if tabletool.indexOf(arg_7_0.triggerTypeList, arg_7_1) then
		return true
	end

	return false
end

function var_0_0.addFinishTrigger(arg_8_0, arg_8_1)
	if tabletool.indexOf(arg_8_0.finishList, arg_8_1) == nil then
		table.insert(arg_8_0.finishList, arg_8_1)
	end
end

function var_0_0.isFinishTrigger(arg_9_0, arg_9_1)
	local var_9_0 = false

	if tabletool.indexOf(arg_9_0.finishList, arg_9_1) then
		var_9_0 = true
	end

	local var_9_1 = Va3ChessEnum.TileTrigger.Broken

	if arg_9_0:isHasTrigger(arg_9_1) and arg_9_1 == var_9_1 then
		local var_9_2 = arg_9_0:getTriggerBrokenStatus()

		var_9_0 = var_9_0 or var_9_2 == Va3ChessEnum.TriggerStatus[var_9_1].Broken
	end

	return var_9_0
end

function var_0_0.resetFinish(arg_10_0)
	if #arg_10_0.finishList > 0 then
		arg_10_0.finishList = {}
	end
end

function var_0_0.setParamStr(arg_11_0, arg_11_1)
	if string.find(arg_11_1, "|") then
		local var_11_0 = string.split(arg_11_1, "|") or {}

		arg_11_1 = var_11_0[1]
		arg_11_0.baffleTypeData = var_11_0[2]
	end

	local var_11_1 = string.splitToNumber(arg_11_1, "#") or {}
	local var_11_2 = var_11_1[1] or 0

	arg_11_0.originalTileType = var_11_2
	arg_11_0.tileType = var_11_2 > 0 and Va3ChessEnum.TileBaseType.Normal or Va3ChessEnum.TileBaseType.None
	arg_11_0.triggerTypeList = {}

	if var_11_1 and #var_11_1 > 1 then
		for iter_11_0 = 2, #var_11_1 do
			table.insert(arg_11_0.triggerTypeList, var_11_1[iter_11_0])
		end
	end

	arg_11_0:resetFinish()
end

function var_0_0.getBaffleDataList(arg_12_0)
	return (Activity142Helper.getBaffleDataList(arg_12_0.originalTileType, arg_12_0.baffleTypeData))
end

function var_0_0.getOriginalTileType(arg_13_0)
	return arg_13_0.originalTileType
end

function var_0_0.isHasBaffleInDir(arg_14_0, arg_14_1)
	local var_14_0 = false

	return (Activity142Helper.isHasBaffleInDir(arg_14_0.originalTileType, arg_14_1))
end

function var_0_0.getParamStr(arg_15_0)
	local var_15_0 = tostring(arg_15_0.tileType)

	if arg_15_0.triggerTypeList then
		for iter_15_0 = 1, #arg_15_0.triggerTypeList do
			var_15_0 = string.format("%s#%s", var_15_0, arg_15_0.triggerTypeList[iter_15_0])
		end
	end

	return var_15_0
end

return var_0_0
