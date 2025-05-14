module("modules.logic.versionactivity1_3.armpipe.model.ArmPuzzlePipeModel", package.seeall)

local var_0_0 = class("ArmPuzzlePipeModel", BaseModel)

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
	arg_2_0._isHasPlaceOP = false
end

function var_0_0.initByEpisodeCo(arg_3_0, arg_3_1)
	arg_3_0._cfgElement = arg_3_1

	if arg_3_0._cfgElement then
		arg_3_0._isHasPlaceOP = false

		local var_3_0 = Activity124Config.instance:getMapCo(arg_3_1.activityId, arg_3_1.mapId)

		arg_3_0:initData()
		arg_3_0:initPuzzle(var_3_0.tilebase)
		arg_3_0:initPuzzlePlace(var_3_0.objects)
	end
end

function var_0_0.initData(arg_4_0)
	arg_4_0._gridDatas = {}

	local var_4_0, var_4_1 = arg_4_0:getGameSize()
	local var_4_2

	for iter_4_0 = 1, var_4_0 do
		for iter_4_1 = 1, var_4_1 do
			arg_4_0._gridDatas[iter_4_0] = arg_4_0._gridDatas[iter_4_0] or {}

			local var_4_3 = ArmPuzzlePipeMO.New()

			var_4_3:init(iter_4_0, iter_4_1)

			arg_4_0._gridDatas[iter_4_0][iter_4_1] = var_4_3
		end
	end

	arg_4_0._startX = -var_4_0 * 0.5 - 0.5
	arg_4_0._startY = -var_4_1 * 0.5 - 0.5
end

function var_0_0.initPuzzle(arg_5_0, arg_5_1)
	arg_5_0._entryList = {}
	arg_5_0._pathIndexList = {}
	arg_5_0._pathIndexDict = {}
	arg_5_0._pathNumListDict = {}
	arg_5_0._placeDataDict = {}

	local var_5_0 = string.split(arg_5_1, ",")
	local var_5_1 = 0
	local var_5_2, var_5_3 = arg_5_0:getGameSize()

	if #var_5_0 >= var_5_2 * var_5_3 then
		local var_5_4 = 1

		for iter_5_0 = 1, var_5_2 do
			for iter_5_1 = 1, var_5_3 do
				local var_5_5 = var_5_0[var_5_4]
				local var_5_6 = arg_5_0._gridDatas[iter_5_0][iter_5_1]

				var_5_6:setParamStr(var_5_5)

				if var_5_6:isEntry() then
					table.insert(arg_5_0._entryList, var_5_6)
					arg_5_0:_initPathByMO(var_5_6)
				end

				if var_5_6.typeId == ArmPuzzlePipeEnum.type.zhanwei then
					arg_5_0._placeDataDict[var_5_6] = var_5_5
					arg_5_0._isHasPlaceOP = true
				end

				var_5_4 = var_5_4 + 1
			end
		end
	end

	for iter_5_2, iter_5_3 in pairs(arg_5_0._pathNumListDict) do
		if iter_5_3 and #iter_5_3 > 1 then
			table.sort(iter_5_3, var_0_0._numIndexSort)
		end
	end
end

function var_0_0.initPuzzlePlace(arg_6_0, arg_6_1)
	arg_6_0._placeTypeDataDict = {
		[ArmPuzzlePipeEnum.type.straight] = 0,
		[ArmPuzzlePipeEnum.type.corner] = 0,
		[ArmPuzzlePipeEnum.type.t_shape] = 0
	}

	local var_6_0 = GameUtil.splitString2(arg_6_1, true, ",", "#")

	if var_6_0 then
		for iter_6_0, iter_6_1 in ipairs(var_6_0) do
			if #iter_6_1 >= 2 and arg_6_0._placeTypeDataDict[iter_6_1[1]] then
				arg_6_0._isHasPlaceOP = true
				arg_6_0._placeTypeDataDict[iter_6_1[1]] = iter_6_1[2]
			end
		end
	end
end

function var_0_0._numIndexSort(arg_7_0, arg_7_1)
	if arg_7_0 ~= arg_7_1 then
		return arg_7_0 < arg_7_1
	end
end

function var_0_0._initPathByMO(arg_8_0, arg_8_1)
	if arg_8_1:isEntry() then
		if not arg_8_0._pathIndexDict[arg_8_1.pathIndex] then
			arg_8_0._pathIndexDict[arg_8_1.pathIndex] = true

			table.insert(arg_8_0._pathIndexList, arg_8_1.pathIndex)
		end

		if arg_8_1.pathType == ArmPuzzlePipeEnum.PathType.Order then
			local var_8_0 = arg_8_1.pathIndex
			local var_8_1 = arg_8_1.numIndex

			arg_8_0._pathNumListDict[var_8_0] = arg_8_0._pathNumListDict[var_8_0] or {}

			if tabletool.indexOf(arg_8_0._pathNumListDict[var_8_0], var_8_1) == nil then
				table.insert(arg_8_0._pathNumListDict[var_8_0], var_8_1)
			end
		end
	end
end

function var_0_0.resetEntryConnect(arg_9_0)
	local var_9_0, var_9_1 = arg_9_0:getGameSize()

	for iter_9_0 = 1, var_9_0 do
		for iter_9_1 = 1, var_9_1 do
			arg_9_0._gridDatas[iter_9_0][iter_9_1]:cleanEntrySet()
		end
	end
end

function var_0_0.setGameClear(arg_10_0, arg_10_1)
	arg_10_0._isGameClear = arg_10_1
end

function var_0_0.isHasPlace(arg_11_0)
	return arg_11_0._isHasPlaceOP
end

function var_0_0.isHasPlaceByTypeId(arg_12_0, arg_12_1)
	if arg_12_0._placeTypeDataDict and arg_12_0._placeTypeDataDict[arg_12_1] > 0 then
		return true
	end

	return false
end

function var_0_0.getPlaceNum(arg_13_0, arg_13_1)
	local var_13_0 = 0

	if arg_13_0._placeTypeDataDict and arg_13_0._placeTypeDataDict[arg_13_1] then
		var_13_0 = arg_13_0._placeTypeDataDict[arg_13_1]

		for iter_13_0, iter_13_1 in pairs(arg_13_0._placeDataDict) do
			if iter_13_0.typeId == arg_13_1 then
				var_13_0 = var_13_0 - 1
			end
		end
	end

	return math.max(0, var_13_0)
end

function var_0_0.getData(arg_14_0, arg_14_1, arg_14_2)
	return arg_14_0._gridDatas[arg_14_1][arg_14_2]
end

function var_0_0.isPlaceByXY(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_0:getPlaceStrByXY(arg_15_1, arg_15_2) then
		return true
	end

	return false
end

function var_0_0.getPlaceStrByXY(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_0._placeDataDict then
		local var_16_0 = arg_16_0:getData(arg_16_1, arg_16_2)

		if var_16_0 then
			return arg_16_0._placeDataDict[var_16_0]
		end
	end
end

function var_0_0.setPlaceSelectXY(arg_17_0, arg_17_1, arg_17_2)
	arg_17_0._placeSelectX = arg_17_1
	arg_17_0._placeSelectY = arg_17_2
end

function var_0_0.getPlaceSelectXY(arg_18_0)
	return arg_18_0._placeSelectX, arg_18_0._placeSelectY
end

function var_0_0.isPlaceSelectXY(arg_19_0, arg_19_1, arg_19_2)
	if arg_19_1 == nil or arg_19_2 == nil then
		return false
	end

	return arg_19_0._placeSelectX == arg_19_1 and arg_19_0._placeSelectY == arg_19_2
end

function var_0_0.getGameSize(arg_20_0)
	return var_0_0.constWidth, var_0_0.constHeight
end

function var_0_0.getGameClear(arg_21_0)
	return arg_21_0._isGameClear
end

function var_0_0.getEntryList(arg_22_0)
	return arg_22_0._entryList
end

function var_0_0.getEpisodeCo(arg_23_0)
	return arg_23_0._cfgElement
end

function var_0_0.getPathIndexList(arg_24_0)
	return arg_24_0._pathIndexList
end

function var_0_0.getIndexByMO(arg_25_0, arg_25_1)
	if arg_25_1.pathType == ArmPuzzlePipeEnum.PathType.Order and arg_25_0._pathNumListDict[arg_25_1.pathIndex] then
		return tabletool.indexOf(arg_25_0._pathNumListDict[arg_25_1.pathIndex], arg_25_1.numIndex) or -1
	end

	return 0
end

function var_0_0.isHasPathIndex(arg_26_0, arg_26_1)
	return arg_26_0._pathIndexDict and arg_26_0._pathIndexDict[arg_26_1] or false
end

function var_0_0.getRelativePosition(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4)
	return (arg_27_0._startX + arg_27_1) * arg_27_3, (arg_27_0._startY + arg_27_2) * arg_27_4
end

function var_0_0.getIndexByTouchPos(arg_28_0, arg_28_1, arg_28_2, arg_28_3, arg_28_4)
	local var_28_0 = math.floor((arg_28_1 - (arg_28_0._startX + 0.5) * arg_28_3) / arg_28_3)
	local var_28_1 = math.floor((arg_28_2 - (arg_28_0._startY + 0.5) * arg_28_4) / arg_28_4)
	local var_28_2, var_28_3 = arg_28_0:getGameSize()

	if var_28_0 >= 0 and var_28_0 < var_28_2 and var_28_1 >= 0 and var_28_1 < var_28_3 then
		return var_28_0 + 1, var_28_1 + 1
	end

	return -1, -1
end

var_0_0.instance = var_0_0.New()

return var_0_0
