module("modules.logic.room.model.map.RoomMapHexPointModel", package.seeall)

local var_0_0 = class("RoomMapHexPointModel", BaseModel)

function var_0_0.ctor(arg_1_0)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._rangeHexPointsDict = {}
	arg_1_0._zeroList = {}
	arg_1_0._hexPointDict = {}
	arg_1_0._hexPointList = {}
	arg_1_0._indexDict = {}
	arg_1_0._rangesHexPointsDic = {}
	arg_1_0._outIndex2HexDict = {}
end

function var_0_0.onInit(arg_2_0)
	arg_2_0:_clearData()
end

function var_0_0.reInit(arg_3_0)
	arg_3_0:_clearData()
end

function var_0_0.clear(arg_4_0)
	var_0_0.super.clear(arg_4_0)
	arg_4_0:_clearData()
end

function var_0_0._clearData(arg_5_0)
	return
end

function var_0_0.init(arg_6_0)
	local var_6_0 = CommonConfig.instance:getConstNum(ConstEnum.RoomMapMaxRadius) or 10
	local var_6_1 = HexPoint(0, 0)

	arg_6_0._zeroList = {
		var_6_1
	}
	arg_6_0._hexPointList = {
		var_6_1
	}

	local var_6_2 = arg_6_0._rangesHexPointsDic

	for iter_6_0 = 1, var_6_0 do
		local var_6_3 = var_6_2[iter_6_0]

		if not var_6_3 then
			var_6_3 = var_6_1:getOnRanges(iter_6_0)
			var_6_2[iter_6_0] = var_6_3
		end

		tabletool.addValues(arg_6_0._hexPointList, var_6_3)
	end

	arg_6_0._hexPointDict = {}
	arg_6_0._indexDict = {}

	for iter_6_1, iter_6_2 in ipairs(arg_6_0._hexPointList) do
		arg_6_0:_add2KeyValue(arg_6_0._hexPointDict, iter_6_2.x, iter_6_2.y, iter_6_2)
		arg_6_0:_add2KeyValue(arg_6_0._indexDict, iter_6_2.x, iter_6_2.y, iter_6_1)
	end
end

function var_0_0.getIndex(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = arg_7_0:_get2KeyValue(arg_7_0._indexDict, arg_7_1, arg_7_2)

	if not var_7_0 then
		var_7_0 = HexMath.hexXYToSpiralIndex(arg_7_1, arg_7_2)

		arg_7_0:_add2KeyValue(arg_7_0._indexDict, arg_7_1, arg_7_2, var_7_0)
	end

	return var_7_0
end

function var_0_0.getHexPoint(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0:_get2KeyValue(arg_8_0._hexPointDict, arg_8_1, arg_8_2)

	if not var_8_0 then
		var_8_0 = HexPoint(arg_8_1, arg_8_2)

		arg_8_0:_add2KeyValue(arg_8_0._hexPointDict, arg_8_1, arg_8_2, var_8_0)
	end

	return var_8_0
end

function var_0_0.getHexPointByIndex(arg_9_0, arg_9_1)
	return arg_9_0._hexPointList[arg_9_1]
end

function var_0_0.getHexPointList(arg_10_0)
	return arg_10_0._hexPointList
end

function var_0_0.getOnRangeHexPointList(arg_11_0, arg_11_1)
	if arg_11_1 < 1 then
		return arg_11_0._zeroList
	end

	return arg_11_0._rangesHexPointsDic[arg_11_1]
end

function var_0_0._add2KeyValue(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	arg_12_1[arg_12_2] = arg_12_1[arg_12_2] or {}
	arg_12_1[arg_12_2][arg_12_3] = arg_12_4
end

function var_0_0._get2KeyValue(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_1[arg_13_2]

	return var_13_0 and var_13_0[arg_13_3]
end

var_0_0.instance = var_0_0.New()

return var_0_0
