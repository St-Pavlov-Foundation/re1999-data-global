module("modules.logic.versionactivity2_4.wuerlixi.model.WuErLiXiMapMo", package.seeall)

local var_0_0 = pureTable("WuErLiXiMapMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.mapId = 0
	arg_1_0.mapOffset = {}
	arg_1_0.actUnitDict = {}
	arg_1_0.nodeDict = {}
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.mapId = tonumber(arg_2_1[1])
	arg_2_0.mapOffset = arg_2_1[2]
	arg_2_0.actUnitDict = arg_2_0._toActUnits(arg_2_1[3])
	arg_2_0.nodeDict = arg_2_0._toNodes(arg_2_1[5])
	arg_2_0.lineCount = arg_2_0:_getLineCount()
	arg_2_0.rowCount = arg_2_0:_getRowCount()

	arg_2_0:_setNodeUnits(arg_2_1[4])
end

function var_0_0._toActUnits(arg_3_0)
	local var_3_0 = {}
	local var_3_1 = string.split(arg_3_0, "|")

	for iter_3_0, iter_3_1 in ipairs(var_3_1) do
		local var_3_2 = WuErLiXiMapActUnitMo.New()

		var_3_2:init(iter_3_1)
		table.insert(var_3_0, var_3_2)
	end

	return var_3_0
end

function var_0_0._toNodes(arg_4_0)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_0) do
		local var_4_1 = WuErLiXiMapNodeMo.New()

		var_4_1:init(iter_4_1)

		if not var_4_0[var_4_1.y] then
			var_4_0[var_4_1.y] = {}
		end

		var_4_0[var_4_1.y][var_4_1.x] = var_4_1
	end

	return var_4_0
end

function var_0_0._setNodeUnits(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		arg_5_0.nodeDict[iter_5_1[3]][iter_5_1[2]]:setUnit(iter_5_1)

		local var_5_0 = arg_5_0.nodeDict[iter_5_1[3]][iter_5_1[2]]:getNodeUnit()

		if var_5_0.unitType == WuErLiXiEnum.UnitType.SignalMulti then
			if var_5_0.dir == WuErLiXiEnum.Dir.Up or var_5_0.dir == WuErLiXiEnum.Dir.Down then
				arg_5_0.nodeDict[iter_5_1[3]][iter_5_1[2] - 1]:setUnit(iter_5_1)
				arg_5_0.nodeDict[iter_5_1[3]][iter_5_1[2] + 1]:setUnit(iter_5_1)
			else
				arg_5_0.nodeDict[iter_5_1[3] - 1][iter_5_1[2]]:setUnit(iter_5_1)
				arg_5_0.nodeDict[iter_5_1[3] + 1][iter_5_1[2]]:setUnit(iter_5_1)
			end
		end
	end
end

function var_0_0._getLineCount(arg_6_0)
	local var_6_0 = 0

	for iter_6_0, iter_6_1 in pairs(arg_6_0.nodeDict) do
		var_6_0 = var_6_0 < iter_6_0 and iter_6_0 or var_6_0
	end

	return var_6_0
end

function var_0_0._getRowCount(arg_7_0)
	local var_7_0 = 0

	for iter_7_0, iter_7_1 in pairs(arg_7_0.nodeDict[1]) do
		var_7_0 = var_7_0 < iter_7_0 and iter_7_0 or var_7_0
	end

	return var_7_0
end

function var_0_0.getNodeMo(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0.nodeDict[arg_8_1] then
		return
	end

	return arg_8_0.nodeDict[arg_8_1][arg_8_2]
end

return var_0_0
