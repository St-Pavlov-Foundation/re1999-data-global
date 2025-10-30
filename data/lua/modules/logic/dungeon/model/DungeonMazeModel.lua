module("modules.logic.dungeon.model.DungeonMazeModel", package.seeall)

local var_0_0 = class("DungeonMazeModel", BaseModel)

var_0_0.constWidth = 5
var_0_0.constHeight = 5
var_0_0.defaultMapId = 1001

local var_0_1 = 1

function var_0_0.reInit(arg_1_0)
	return
end

function var_0_0.release(arg_2_0)
	return
end

function var_0_0.initData(arg_3_0, arg_3_1)
	arg_3_0._cellDatas = {}
	arg_3_0._cellDataDict = {}
	arg_3_0._playerChaosValue = 0
	arg_3_0._skillState = DungeonMazeEnum.skillState.usable
	arg_3_0._skillCooling = 0
	arg_3_0._destinationCell = nil
	arg_3_0._defaultChaosAddValue = tonumber(DungeonGameConfig.instance:getMazeGameConst(var_0_1).size)
	arg_3_0._chaosAddValue = arg_3_0._defaultChaosAddValue
	arg_3_0._mapId = arg_3_1 and arg_3_1 or var_0_0.defaultMapId

	local var_3_0 = DungeonGameConfig.instance:getMazeMap(arg_3_0._mapId)
	local var_3_1, var_3_2 = arg_3_0:getGameSize()

	for iter_3_0 = 1, var_3_1 do
		for iter_3_1 = 1, var_3_2 do
			local var_3_3 = var_3_0[(iter_3_0 - 1) * var_3_1 + iter_3_1]

			arg_3_0._cellDatas[iter_3_0] = arg_3_0._cellDatas[iter_3_0] or {}

			local var_3_4 = DungeonMazeCellData.New()

			var_3_4:init(iter_3_0, iter_3_1)

			var_3_4.value = var_3_3.celltype
			var_3_4.obstacleDialog = var_3_3.dialogid
			var_3_4.eventId = var_3_3.evenid
			var_3_4.cellId = var_3_3.cellId
			var_3_4.pass = var_3_3.celltype == 1 or var_3_3.celltype == 2 or var_3_3.celltype == 3
			arg_3_0._cellDatas[iter_3_0][iter_3_1] = var_3_4
			arg_3_0._cellDataDict[var_3_4.cellId] = var_3_4

			if var_3_4.value == 2 then
				arg_3_0._destinationCell = var_3_4
			elseif var_3_4.value == 3 then
				arg_3_0._curCell = var_3_4
			end
		end
	end

	for iter_3_2 = 1, var_3_1 do
		for iter_3_3 = 1, var_3_2 do
			local var_3_5 = arg_3_0._cellDatas[iter_3_2][iter_3_3]
			local var_3_6 = arg_3_0._cellDatas[iter_3_2][iter_3_3 - 1]
			local var_3_7 = arg_3_0._cellDatas[iter_3_2][iter_3_3 + 1]
			local var_3_8 = arg_3_0._cellDatas[iter_3_2 - 1] and arg_3_0._cellDatas[iter_3_2 - 1][iter_3_3]
			local var_3_9 = arg_3_0._cellDatas[iter_3_2 + 1] and arg_3_0._cellDatas[iter_3_2 + 1][iter_3_3]

			var_3_5.connectSet = {
				[DungeonMazeEnum.dir.left] = var_3_6,
				[DungeonMazeEnum.dir.right] = var_3_7,
				[DungeonMazeEnum.dir.up] = var_3_8,
				[DungeonMazeEnum.dir.down] = var_3_9
			}
		end
	end
end

function var_0_0.getGameSize(arg_4_0)
	if not arg_4_0._mazeSize then
		arg_4_0._mazeSize = {}

		local var_4_0 = DungeonGameConfig.instance:getMazeGameConst(arg_4_0._mapId).size

		if var_4_0 then
			local var_4_1 = string.splitToNumber(var_4_0, "#")

			arg_4_0._mazeSize.width = var_4_1[1]
			arg_4_0._mazeSize.height = var_4_1[2]
		else
			arg_4_0._mazeSize.width = var_0_0.constWidth
			arg_4_0._mazeSize.height = var_0_0.constHeight
		end
	end

	return arg_4_0._mazeSize.width, arg_4_0._mazeSize.height
end

function var_0_0.setCurCellData(arg_5_0, arg_5_1)
	arg_5_0._curCell = arg_5_1
end

function var_0_0.getCurCellData(arg_6_0)
	return arg_6_0._curCell
end

function var_0_0.getCellData(arg_7_0, arg_7_1, arg_7_2)
	return arg_7_0._cellDatas[arg_7_1][arg_7_2]
end

function var_0_0.getNearestCellToDestination(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = false

	if arg_8_1 == nil then
		var_8_0 = true
		arg_8_0._cellRecord = {}
	end

	arg_8_3 = arg_8_3 or 0
	arg_8_1 = arg_8_1 or arg_8_0._curCell

	local var_8_1 = arg_8_1.x
	local var_8_2 = arg_8_1.y

	if arg_8_1.value == 2 then
		arg_8_0._cellRecord[arg_8_1.cellId] = false

		return arg_8_1, arg_8_3
	end

	local var_8_3 = 99
	local var_8_4

	for iter_8_0, iter_8_1 in pairs(DungeonMazeEnum.dir) do
		local var_8_5 = arg_8_1.connectSet[iter_8_1]
		local var_8_6 = false

		if var_8_5 and var_8_5.pass and var_8_5 ~= arg_8_2 and not arg_8_0._cellRecord[var_8_5.cellId] then
			arg_8_0._cellRecord[var_8_5.cellId] = true

			local var_8_7, var_8_8 = arg_8_0:getNearestCellToDestination(var_8_5, arg_8_1, arg_8_3 + 1)

			if var_8_7 ~= nil and var_8_8 <= var_8_3 then
				var_8_3 = var_8_8
				var_8_4 = arg_8_1

				if var_8_0 then
					var_8_4 = var_8_7
				end
			end
		end
	end

	if var_8_0 then
		return var_8_4
	end

	arg_8_0._cellRecord[arg_8_1.cellId] = false

	return var_8_4, var_8_3
end

function var_0_0.addChaosValue(arg_9_0, arg_9_1)
	if arg_9_1 then
		arg_9_0._playerChaosValue = arg_9_0._playerChaosValue + arg_9_1
		arg_9_0._chaosAddValue = arg_9_1
	else
		arg_9_0._playerChaosValue = arg_9_0._playerChaosValue + arg_9_0._defaultChaosAddValue
	end
end

function var_0_0.getAddChaosValue(arg_10_0)
	return arg_10_0._chaosAddValue
end

function var_0_0.getChaosValue(arg_11_0)
	return arg_11_0._playerChaosValue
end

function var_0_0.UnpateSkillState(arg_12_0, arg_12_1)
	if arg_12_1 then
		if arg_12_0._skillState == DungeonMazeEnum.skillState.using then
			arg_12_0._skillState = DungeonMazeEnum.skillState.cooling
		end

		if arg_12_0._skillCooling > 0 then
			arg_12_0._skillCooling = arg_12_0._skillCooling - 1
		end

		if arg_12_0._skillCooling == 0 then
			arg_12_0._skillState = DungeonMazeEnum.skillState.usable
		end
	else
		if arg_12_0._skillCooling > 0 then
			return false
		end

		arg_12_0._skillCooling = 2
		arg_12_0._skillState = DungeonMazeEnum.skillState.using
	end
end

function var_0_0.GetSkillState(arg_13_0)
	return arg_13_0._skillState, arg_13_0._skillCooling
end

function var_0_0.SaveCurProgress(arg_14_0)
	local var_14_0 = arg_14_0._curCell.x
	local var_14_1 = arg_14_0._curCell.y
	local var_14_2 = arg_14_0._playerChaosValue
	local var_14_3 = arg_14_0._skillState
	local var_14_4 = arg_14_0._skillCooling
	local var_14_5 = ""

	for iter_14_0, iter_14_1 in ipairs(arg_14_0._cellDataDict) do
		if iter_14_1.toggled then
			if var_14_5 == "" then
				var_14_5 = iter_14_0
			else
				var_14_5 = var_14_5 .. "#" .. iter_14_0
			end
		end
	end

	local var_14_6 = string.format("%d,%d,%d,%d,%d,%s", var_14_0, var_14_1, var_14_2, var_14_3, var_14_4, var_14_5)

	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.DungeonMazeKey), var_14_6)
end

function var_0_0.HasLocalProgress(arg_15_0)
	local var_15_0 = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.DungeonMazeKey), "")

	return var_15_0 and not string.nilorempty(var_15_0)
end

function var_0_0.ClearProgress(arg_16_0)
	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.DungeonMazeKey), "")
end

function var_0_0.LoadProgress(arg_17_0)
	local var_17_0 = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.DungeonMazeKey), "")

	if string.nilorempty(var_17_0) then
		return false
	end

	local var_17_1 = string.split(var_17_0, ",")
	local var_17_2 = tonumber(var_17_1[1])
	local var_17_3 = tonumber(var_17_1[2])
	local var_17_4 = tonumber(var_17_1[3])
	local var_17_5 = tonumber(var_17_1[4])
	local var_17_6 = tonumber(var_17_1[5])
	local var_17_7 = var_17_1[6]

	if var_17_2 and var_17_3 and var_17_4 and var_17_5 and var_17_6 then
		arg_17_0._curCell = arg_17_0._cellDatas[var_17_2][var_17_3]
		arg_17_0._playerChaosValue = var_17_4
		arg_17_0._skillState = var_17_5
		arg_17_0._skillCooling = var_17_6
	end

	if var_17_7 and not string.nilorempty(var_17_7) then
		local var_17_8 = string.splitToNumber(var_17_7, "#")

		for iter_17_0, iter_17_1 in ipairs(var_17_8) do
			local var_17_9 = arg_17_0._cellDataDict[iter_17_1]

			if var_17_9 then
				var_17_9.toggled = true
			end
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
