module("modules.logic.versionactivity2_4.wuerlixi.controller.WuErLiXiHelper", package.seeall)

local var_0_0 = class("WuErLiXiHelper")

function var_0_0.getUnitSpriteName(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1 and 2 or 1

	if arg_1_0 == WuErLiXiEnum.UnitType.SignalEnd or arg_1_0 == WuErLiXiEnum.UnitType.Obstacle or arg_1_0 == WuErLiXiEnum.UnitType.Key then
		return string.format("v2a4_wuerlixi_unit_icon%s_%s", arg_1_0, var_1_0)
	end

	return string.format("v2a4_wuerlixi_unit_icon%s", arg_1_0)
end

function var_0_0.getLimitTimeStr()
	local var_2_0 = ActivityModel.instance:getActMO(VersionActivity2_4Enum.ActivityId.WuErLiXi)

	if not var_2_0 then
		return ""
	end

	local var_2_1 = var_2_0:getRealEndTimeStamp() - ServerTime.now()

	if var_2_1 > 0 then
		return TimeUtil.SecondToActivityTimeFormat(var_2_1)
	end

	return ""
end

function var_0_0.getOppositeDir(arg_3_0)
	return math.abs((2 + arg_3_0) % 4)
end

function var_0_0.getNextDir(arg_4_0)
	return (arg_4_0 + 1) % 4
end

function var_0_0.getPreDir(arg_5_0)
	return (4 + arg_5_0 - 1) % 4
end

return var_0_0
