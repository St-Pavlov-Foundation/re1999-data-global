module("modules.logic.versionactivity1_8.dungeon.model.Activity157RepairGameModel", package.seeall)

local var_0_0 = class("Activity157RepairGameModel", BaseModel)

local function var_0_1(arg_1_0, arg_1_1)
	return arg_1_0 < arg_1_1
end

function var_0_0.onInit(arg_2_0)
	arg_2_0._startX = nil
	arg_2_0._startY = nil
	arg_2_0._mapPipeGridDict = nil
end

function var_0_0.reInit(arg_3_0)
	arg_3_0:onInit()
end

function var_0_0.setGameDataBeforeEnter(arg_4_0, arg_4_1)
	local var_4_0 = Activity157Model.instance:getActId()

	arg_4_0:setCurComponentId(arg_4_1)
	arg_4_0:initMapGrid()

	local var_4_1 = Activity157Config.instance:getAct157RepairMapTilebase(var_4_0, arg_4_1)

	arg_4_0:initPuzzle(var_4_1)

	local var_4_2 = Activity157Config.instance:getAct157RepairMapObjects(var_4_0, arg_4_1)

	arg_4_0:initPuzzlePlace(var_4_2)
end

function var_0_0.setCurComponentId(arg_5_0, arg_5_1)
	arg_5_0._curComponentId = arg_5_1
end

function var_0_0.resetGameData(arg_6_0)
	local var_6_0 = arg_6_0:getCurComponentId()

	arg_6_0:setGameDataBeforeEnter(var_6_0)
end

function var_0_0.setGameClear(arg_7_0, arg_7_1)
	arg_7_0._isGameClear = arg_7_1
end

function var_0_0.initMapGrid(arg_8_0)
	arg_8_0._mapPipeGridDict = {}

	local var_8_0, var_8_1 = arg_8_0:getGameSize()
	local var_8_2

	for iter_8_0 = 1, var_8_0 do
		for iter_8_1 = 1, var_8_1 do
			arg_8_0._mapPipeGridDict[iter_8_0] = arg_8_0._mapPipeGridDict[iter_8_0] or {}

			local var_8_3 = Activity157PipeGridMo.New()

			var_8_3:init(iter_8_0, iter_8_1)

			arg_8_0._mapPipeGridDict[iter_8_0][iter_8_1] = var_8_3
		end
	end

	arg_8_0._startX = -var_8_0 * 0.5 - 0.5
	arg_8_0._startY = -var_8_1 * 0.5 - 0.5
end

function var_0_0.initPuzzle(arg_9_0, arg_9_1)
	arg_9_0._entryList = {}
	arg_9_0._pathIndexList = {}
	arg_9_0._pathIndexDict = {}
	arg_9_0._pathNumListDict = {}
	arg_9_0._placeDataDict = {}

	local var_9_0 = string.split(arg_9_1, ",")
	local var_9_1, var_9_2 = arg_9_0:getGameSize()

	if #var_9_0 >= var_9_1 * var_9_2 then
		local var_9_3 = 1

		for iter_9_0 = 1, var_9_1 do
			for iter_9_1 = 1, var_9_2 do
				local var_9_4 = var_9_0[var_9_3]
				local var_9_5 = arg_9_0._mapPipeGridDict[iter_9_0][iter_9_1]

				var_9_5:setParamStr(var_9_4)

				if var_9_5:isEntry() then
					table.insert(arg_9_0._entryList, var_9_5)
					arg_9_0:_initPathByMO(var_9_5)
				end

				if var_9_5.typeId == ArmPuzzlePipeEnum.type.zhanwei then
					arg_9_0._placeDataDict[var_9_5] = var_9_4
					arg_9_0._isHasPlaceOP = true
				end

				var_9_3 = var_9_3 + 1
			end
		end
	end

	for iter_9_2, iter_9_3 in pairs(arg_9_0._pathNumListDict) do
		if iter_9_3 and #iter_9_3 > 1 then
			table.sort(iter_9_3, var_0_1)
		end
	end
end

function var_0_0._initPathByMO(arg_10_0, arg_10_1)
	if arg_10_1:isEntry() then
		if not arg_10_0._pathIndexDict[arg_10_1.pathIndex] then
			arg_10_0._pathIndexDict[arg_10_1.pathIndex] = true

			table.insert(arg_10_0._pathIndexList, arg_10_1.pathIndex)
		end

		if arg_10_1.pathType == ArmPuzzlePipeEnum.PathType.Order then
			local var_10_0 = arg_10_1.pathIndex
			local var_10_1 = arg_10_1.numIndex

			arg_10_0._pathNumListDict[var_10_0] = arg_10_0._pathNumListDict[var_10_0] or {}

			if tabletool.indexOf(arg_10_0._pathNumListDict[var_10_0], var_10_1) == nil then
				table.insert(arg_10_0._pathNumListDict[var_10_0], var_10_1)
			end
		end
	end
end

function var_0_0.initPuzzlePlace(arg_11_0, arg_11_1)
	arg_11_0._placeTypeDataDict = {
		[ArmPuzzlePipeEnum.type.straight] = 0,
		[ArmPuzzlePipeEnum.type.corner] = 0,
		[ArmPuzzlePipeEnum.type.t_shape] = 0
	}

	local var_11_0 = GameUtil.splitString2(arg_11_1, true, ",", "#")

	if var_11_0 then
		for iter_11_0, iter_11_1 in ipairs(var_11_0) do
			if #iter_11_1 >= 2 and arg_11_0._placeTypeDataDict[iter_11_1[1]] then
				arg_11_0._isHasPlaceOP = true
				arg_11_0._placeTypeDataDict[iter_11_1[1]] = iter_11_1[2]
			end
		end
	end
end

function var_0_0.resetEntryConnect(arg_12_0)
	local var_12_0, var_12_1 = arg_12_0:getGameSize()

	for iter_12_0 = 1, var_12_0 do
		for iter_12_1 = 1, var_12_1 do
			arg_12_0._mapPipeGridDict[iter_12_0][iter_12_1]:cleanEntrySet()
		end
	end
end

function var_0_0.getGameSize(arg_13_0)
	local var_13_0 = 0
	local var_13_1 = 0
	local var_13_2 = Activity157Model.instance:getActId()
	local var_13_3 = Activity157Config.instance:getAct157Const(var_13_2, Activity157Enum.ConstId.FactoryRepairGameMapSize)

	if not string.nilorempty(var_13_3) then
		local var_13_4 = string.split(var_13_3, "#")

		var_13_0 = tonumber(var_13_4[1]) or 0
		var_13_1 = tonumber(var_13_4[2]) or 0
	end

	return var_13_0, var_13_1
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

function var_0_0.getRelativePosition(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	return (arg_15_0._startX + arg_15_1) * arg_15_3, (arg_15_0._startY + arg_15_2) * arg_15_4
end

function var_0_0.getEntryList(arg_16_0)
	return arg_16_0._entryList
end

function var_0_0.getData(arg_17_0, arg_17_1, arg_17_2)
	return arg_17_0._mapPipeGridDict[arg_17_1][arg_17_2]
end

function var_0_0.getIndexByMO(arg_18_0, arg_18_1)
	if arg_18_1.pathType == ArmPuzzlePipeEnum.PathType.Order and arg_18_0._pathNumListDict[arg_18_1.pathIndex] then
		return tabletool.indexOf(arg_18_0._pathNumListDict[arg_18_1.pathIndex], arg_18_1.numIndex) or -1
	end

	return 0
end

function var_0_0.getGameClear(arg_19_0)
	return arg_19_0._isGameClear
end

function var_0_0.getCurComponentId(arg_20_0)
	return arg_20_0._curComponentId
end

function var_0_0.isHasPlace(arg_21_0)
	return arg_21_0._isHasPlaceOP
end

function var_0_0.isHasPlaceByTypeId(arg_22_0, arg_22_1)
	if arg_22_0._placeTypeDataDict and arg_22_0._placeTypeDataDict[arg_22_1] > 0 then
		return true
	end

	return false
end

function var_0_0.isPlaceByXY(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_0:getPlaceStrByXY(arg_23_1, arg_23_2) then
		return true
	end

	return false
end

function var_0_0.getPlaceStrByXY(arg_24_0, arg_24_1, arg_24_2)
	if arg_24_0._placeDataDict then
		local var_24_0 = arg_24_0:getData(arg_24_1, arg_24_2)

		if var_24_0 then
			return arg_24_0._placeDataDict[var_24_0]
		end
	end
end

function var_0_0.setPlaceSelectXY(arg_25_0, arg_25_1, arg_25_2)
	arg_25_0._placeSelectX = arg_25_1
	arg_25_0._placeSelectY = arg_25_2
end

function var_0_0.getPlaceSelectXY(arg_26_0)
	return arg_26_0._placeSelectX, arg_26_0._placeSelectY
end

function var_0_0.isPlaceSelectXY(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_1 == nil or arg_27_2 == nil then
		return false
	end

	return arg_27_0._placeSelectX == arg_27_1 and arg_27_0._placeSelectY == arg_27_2
end

function var_0_0.getPlaceNum(arg_28_0, arg_28_1)
	local var_28_0 = 0

	if arg_28_0._placeTypeDataDict and arg_28_0._placeTypeDataDict[arg_28_1] then
		var_28_0 = arg_28_0._placeTypeDataDict[arg_28_1]

		for iter_28_0, iter_28_1 in pairs(arg_28_0._placeDataDict) do
			if iter_28_0.typeId == arg_28_1 then
				var_28_0 = var_28_0 - 1
			end
		end
	end

	return math.max(0, var_28_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
