module("modules.logic.versionactivity2_4.wuerlixi.model.WuErLiXiMapNodeMo", package.seeall)

local var_0_0 = pureTable("WuErLiXiMapNodeMo")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.x = arg_1_1[1]
	arg_1_0.y = arg_1_1[2]
	arg_1_0.id = 100 * arg_1_0.x + arg_1_0.y
	arg_1_0.nodeType = arg_1_1[3]
	arg_1_0.unit = nil
	arg_1_0.ray = nil
	arg_1_0.initUnit = 0
end

function var_0_0.hasActUnit(arg_2_0)
	return arg_2_0.initUnit == 0 and arg_2_0.unit
end

function var_0_0.setUnit(arg_3_0, arg_3_1)
	if not arg_3_0.unit then
		arg_3_0.unit = WuErLiXiMapUnitMo.New()
	end

	arg_3_0.unit:init(arg_3_1)

	arg_3_0.initUnit = arg_3_0.unit.id
end

function var_0_0.setUnitByUnitMo(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if not arg_4_0.unit then
		arg_4_0.unit = WuErLiXiMapUnitMo.New()
	end

	arg_4_0.unit:initByUnitMo(arg_4_1, arg_4_2, arg_4_3)
end

function var_0_0.getNodeUnit(arg_5_0)
	return arg_5_0.unit
end

function var_0_0.setUnitActive(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if not arg_6_0.unit then
		return
	end

	arg_6_0.unit:setUnitActive(arg_6_1, arg_6_2, arg_6_3)
end

function var_0_0.setDir(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_0.unit then
		return
	end

	arg_7_0.unit:setDir(arg_7_1)

	if not arg_7_2 then
		return
	end

	arg_7_0:setUnitOutDirByRayDir(arg_7_2)
end

function var_0_0.setUnitOutDirByRayDir(arg_8_0, arg_8_1)
	if not arg_8_0.unit or not arg_8_1 then
		return
	end

	arg_8_0.unit:setUnitOutDirByRayDir(arg_8_1)
end

function var_0_0.isUnitActive(arg_9_0, arg_9_1)
	if not arg_9_0.unit then
		return false
	end

	return arg_9_0.unit:isUnitActive(arg_9_1)
end

function var_0_0.clearUnit(arg_10_0)
	arg_10_0.unit = nil
end

function var_0_0.isNodeShowActive(arg_11_0)
	if not arg_11_0.unit then
		return false
	end

	if arg_11_0.unit.unitType == WuErLiXiEnum.UnitType.SignalEnd then
		return arg_11_0.ray
	elseif arg_11_0.unit.unitType == WuErLiXiEnum.UnitType.Obstacle then
		return arg_11_0.initUnit == 0
	end

	return arg_11_0.unit:isUnitActive()
end

function var_0_0.isRayEmitterNode(arg_12_0)
	if not arg_12_0.unit then
		return false
	end

	return arg_12_0.unit:isRayEmitterUnit()
end

function var_0_0.setUnitByActUnitMo(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	if not arg_13_0.unit then
		arg_13_0.unit = WuErLiXiMapUnitMo.New()
	end

	arg_13_0.unit:initByActUnitMo(arg_13_1, arg_13_2, arg_13_3)
end

function var_0_0.getUnitSignalOutDir(arg_14_0)
	if not arg_14_0.unit then
		return
	end

	return arg_14_0.unit:getUnitSignalOutDir()
end

function var_0_0.setUnitOutDirByRayDir(arg_15_0, arg_15_1)
	if not arg_15_0.unit then
		return
	end

	return arg_15_0.unit:setUnitOutDirByRayDir(arg_15_1)
end

function var_0_0.isUnitFreeType(arg_16_0)
	if not arg_16_0.unit then
		return false
	end

	return arg_16_0.initUnit ~= 0
end

function var_0_0.couldSetRay(arg_17_0, arg_17_1)
	if arg_17_0.unit then
		if arg_17_0.x ~= arg_17_0.unit.x or arg_17_0.y ~= arg_17_0.unit.y then
			return false
		end

		if not arg_17_0.unit:couldSetRay(arg_17_1) then
			return false
		end
	end

	return true
end

function var_0_0.setNodeRay(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	if arg_18_0.unit and not arg_18_0.unit:couldSetRay(arg_18_2) then
		arg_18_0.ray = nil

		return
	end

	if not arg_18_0.ray then
		arg_18_0.ray = WuErLiXiMapRayMo.New()

		arg_18_0.ray:init(arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	else
		arg_18_0.ray:reset(arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	end
end

function var_0_0.getNodeRay(arg_19_0)
	return arg_19_0.ray
end

function var_0_0.clearNodeRay(arg_20_0, arg_20_1)
	if not arg_20_0.ray or arg_20_0.ray.rayId ~= arg_20_1 then
		return
	end

	arg_20_0.ray = nil
end

return var_0_0
