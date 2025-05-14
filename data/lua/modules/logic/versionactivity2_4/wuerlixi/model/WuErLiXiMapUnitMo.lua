module("modules.logic.versionactivity2_4.wuerlixi.model.WuErLiXiMapUnitMo", package.seeall)

local var_0_0 = pureTable("WuErLiXiMapUnitMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.id = 0
	arg_1_0.x = 0
	arg_1_0.y = 0
	arg_1_0.unitType = 0
	arg_1_0.dir = 0
	arg_1_0.isActive = false
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1[1]
	arg_2_0.x = arg_2_1[2]
	arg_2_0.y = arg_2_1[3]
	arg_2_0.unitType = arg_2_1[4]
	arg_2_0.dir = arg_2_1[5]
	arg_2_0.outDir = arg_2_0.dir
	arg_2_0.isActive = arg_2_0.unitType == WuErLiXiEnum.UnitType.SignalStart or arg_2_0.unitType == WuErLiXiEnum.UnitType.KeyStart
end

function var_0_0.initByActUnitMo(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0.id = arg_3_1.id
	arg_3_0.x = arg_3_2
	arg_3_0.y = arg_3_3
	arg_3_0.unitType = arg_3_1.type
	arg_3_0.dir = arg_3_1.dir
	arg_3_0.outDir = arg_3_0.dir
	arg_3_0.isActive = arg_3_0.unitType == WuErLiXiEnum.UnitType.SignalStart or arg_3_0.unitType == WuErLiXiEnum.UnitType.KeyStart
end

function var_0_0.initByUnitMo(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0.id = arg_4_1.id
	arg_4_0.x = arg_4_2
	arg_4_0.y = arg_4_3
	arg_4_0.unitType = arg_4_1.unitType
	arg_4_0.dir = arg_4_1.dir
	arg_4_0.outDir = arg_4_1.outDir
	arg_4_0.isActive = arg_4_0.unitType == WuErLiXiEnum.UnitType.SignalStart or arg_4_0.unitType == WuErLiXiEnum.UnitType.KeyStart
end

function var_0_0.getId(arg_5_0)
	return arg_5_0.id
end

function var_0_0.isUnitActive(arg_6_0, arg_6_1)
	if arg_6_0.unitType == WuErLiXiEnum.UnitType.SignalStart then
		arg_6_0.isActive = true
	elseif arg_6_0.unitType == WuErLiXiEnum.UnitType.KeyStart then
		arg_6_0.isActive = true
	end

	if arg_6_1 and arg_6_0.unitType == WuErLiXiEnum.UnitType.Reflection then
		return arg_6_1 == WuErLiXiHelper.getOppositeDir(arg_6_0.dir) or arg_6_1 == WuErLiXiHelper.getNextDir(arg_6_0.dir)
	end

	if arg_6_1 and arg_6_0.unitType == WuErLiXiEnum.UnitType.SignalMulti then
		return arg_6_1 == arg_6_0.dir
	end

	return arg_6_0.isActive
end

function var_0_0.couldSetRay(arg_7_0, arg_7_1)
	if arg_7_0.unitType == WuErLiXiEnum.UnitType.SignalStart then
		return false
	elseif arg_7_0.unitType == WuErLiXiEnum.UnitType.KeyStart then
		return false
	elseif arg_7_0.unitType == WuErLiXiEnum.UnitType.Obstacle then
		return false
	elseif arg_7_0.unitType == WuErLiXiEnum.UnitType.Key then
		return arg_7_1 == WuErLiXiEnum.RayType.SwitchSignal
	elseif arg_7_0.unitType == WuErLiXiEnum.UnitType.Switch then
		return arg_7_0.isActive
	end

	return true
end

function var_0_0.setUnitActive(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if not arg_8_1 then
		arg_8_0.isActive = false

		return
	end

	if arg_8_0.unitType == WuErLiXiEnum.UnitType.SignalEnd then
		arg_8_0.isActive = arg_8_2 == WuErLiXiEnum.RayType.NormalSignal
	elseif arg_8_0.unitType == WuErLiXiEnum.UnitType.Reflection then
		if not arg_8_3 then
			arg_8_0.isActive = false

			return
		end

		arg_8_0.isActive = arg_8_3 == WuErLiXiHelper.getOppositeDir(arg_8_0.dir) or arg_8_3 == WuErLiXiHelper.getNextDir(arg_8_0.dir)

		if arg_8_3 == WuErLiXiHelper.getNextDir(arg_8_0.dir) then
			arg_8_0.outDir = arg_8_0.dir
		elseif arg_8_3 == WuErLiXiHelper.getOppositeDir(arg_8_0.dir) then
			arg_8_0.outDir = WuErLiXiHelper.getNextDir(arg_8_3)
		else
			arg_8_0.outDir = nil
		end
	elseif arg_8_0.unitType == WuErLiXiEnum.UnitType.SignalMulti then
		arg_8_0.outDir = arg_8_3 == arg_8_0.dir and arg_8_0.dir or nil
		arg_8_0.isActive = arg_8_3 == arg_8_0.dir
	elseif arg_8_0.unitType == WuErLiXiEnum.UnitType.Key then
		arg_8_0.isActive = arg_8_2 == WuErLiXiEnum.RayType.SwitchSignal
	elseif arg_8_0.unitType == WuErLiXiEnum.UnitType.Switch then
		arg_8_0.isActive = true
	elseif arg_8_0.unitType == WuErLiXiEnum.UnitType.SignalStart then
		arg_8_0.isActive = true
	elseif arg_8_0.unitType == WuErLiXiEnum.UnitType.KeyStart then
		arg_8_0.isActive = true
	else
		arg_8_0.isActive = false
	end
end

function var_0_0.setDir(arg_9_0, arg_9_1)
	arg_9_0.dir = arg_9_1

	if not arg_9_0.isActive then
		arg_9_0.ourDir = nil

		return
	end

	arg_9_0.outDir = arg_9_0.dir
end

function var_0_0.setUnitOutDirByRayDir(arg_10_0, arg_10_1)
	if not arg_10_0.isActive then
		arg_10_0.outDir = nil

		return
	end

	if arg_10_0.unitType == WuErLiXiEnum.UnitType.Reflection then
		if arg_10_1 == WuErLiXiHelper.getNextDir(arg_10_0.dir) then
			arg_10_0.outDir = arg_10_0.dir
		elseif arg_10_1 == WuErLiXiHelper.getOppositeDir(arg_10_0.dir) then
			arg_10_0.outDir = WuErLiXiHelper.getNextDir(arg_10_1)
		else
			arg_10_0.outDir = nil
		end

		return
	end

	arg_10_0.outDir = arg_10_0.isActive and arg_10_0.dir or nil
end

function var_0_0.getUnitSignalOutDir(arg_11_0)
	if not arg_11_0.isActive then
		return
	end

	return arg_11_0.outDir
end

function var_0_0.getUnitDir(arg_12_0)
	return arg_12_0.dir
end

function var_0_0.isIgnoreSignal(arg_13_0)
	if arg_13_0.isActive and arg_13_0.unitType == WuErLiXiEnum.UnitType.Switch then
		return true
	end

	return false
end

function var_0_0.getUnitSignals(arg_14_0, arg_14_1)
	if not arg_14_0.isActive then
		return {}
	end

	local var_14_0 = {}

	if arg_14_0.unitType == WuErLiXiEnum.UnitType.SignalStart then
		table.insert(var_14_0, {
			arg_14_0.x,
			arg_14_0.y
		})
	elseif arg_14_0.unitType == WuErLiXiEnum.UnitType.KeyStart then
		table.insert(var_14_0, {
			arg_14_0.x,
			arg_14_0.y
		})
	elseif arg_14_0.unitType == WuErLiXiEnum.UnitType.Reflection then
		if arg_14_1 then
			if arg_14_1 == WuErLiXiHelper.getNextDir(arg_14_0.dir) or arg_14_1 == WuErLiXiHelper.getOppositeDir(arg_14_0.dir) then
				table.insert(var_14_0, {
					arg_14_0.x,
					arg_14_0.y
				})
			end
		elseif arg_14_0.outDir then
			table.insert(var_14_0, {
				arg_14_0.x,
				arg_14_0.y
			})
		end
	elseif arg_14_0.unitType == WuErLiXiEnum.UnitType.SignalMulti then
		if arg_14_1 then
			if arg_14_1 == arg_14_0.dir then
				if arg_14_0.dir == WuErLiXiEnum.Dir.Up or arg_14_0.dir == WuErLiXiEnum.Dir.Down then
					table.insert(var_14_0, {
						arg_14_0.x - 1,
						arg_14_0.y
					})
					table.insert(var_14_0, {
						arg_14_0.x + 1,
						arg_14_0.y
					})
				else
					table.insert(var_14_0, {
						arg_14_0.x,
						arg_14_0.y - 1
					})
					table.insert(var_14_0, {
						arg_14_0.x,
						arg_14_0.y + 1
					})
				end
			end
		elseif arg_14_0.dir == WuErLiXiEnum.Dir.Up or arg_14_0.dir == WuErLiXiEnum.Dir.Down then
			table.insert(var_14_0, {
				arg_14_0.x - 1,
				arg_14_0.y
			})
			table.insert(var_14_0, {
				arg_14_0.x + 1,
				arg_14_0.y
			})
		else
			table.insert(var_14_0, {
				arg_14_0.x,
				arg_14_0.y - 1
			})
			table.insert(var_14_0, {
				arg_14_0.x,
				arg_14_0.y + 1
			})
		end
	end

	return var_14_0
end

return var_0_0
