module("modules.logic.versionactivity3_0.maLiAnNaAct201.view.comp.MaLiAnNaLineGameComp", package.seeall)

local var_0_0 = class("MaLiAnNaLineGameComp", MaLiAnNaLineBaseComp)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._goRailWay = gohelper.findChild(arg_1_1, "RailWay")
	arg_1_0._goHighWay = gohelper.findChild(arg_1_1, "HighWay")
end

function var_0_0.updateInfo(arg_2_0, arg_2_1)
	if arg_2_1 == nil then
		return
	end

	arg_2_0._data = arg_2_1

	local var_2_0, var_2_1 = arg_2_1:getBeginPos()
	local var_2_2, var_2_3 = arg_2_1:getEndPos()
	local var_2_4, var_2_5, var_2_6, var_2_7 = MathUtil.calculateVisiblePoints(var_2_0, var_2_1, Activity201MaLiAnNaEnum.defaultHideLineRange, var_2_2, var_2_3, Activity201MaLiAnNaEnum.defaultHideLineRange)

	gohelper.setActive(arg_2_0._goRailWay, arg_2_0._data._roadType == Activity201MaLiAnNaEnum.RoadType.RailWay)
	gohelper.setActive(arg_2_0._goHighWay, arg_2_0._data._roadType == Activity201MaLiAnNaEnum.RoadType.HighWay)
	arg_2_0:updateItem(var_2_4, var_2_5, var_2_6, var_2_7)
end

function var_0_0.updateItem(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	transformhelper.setLocalPosXY(arg_3_0._tr, arg_3_1, arg_3_2)

	local var_3_0 = MathUtil.vec2_length(arg_3_1, arg_3_2, arg_3_3, arg_3_4)

	recthelper.setHeight(arg_3_0._tr, var_3_0)

	local var_3_1 = MathUtil.calculateV2Angle(arg_3_3, arg_3_4, arg_3_1, arg_3_2)

	transformhelper.setEulerAngles(arg_3_0._tr, 0, 0, var_3_1 - 90)
end

return var_0_0
