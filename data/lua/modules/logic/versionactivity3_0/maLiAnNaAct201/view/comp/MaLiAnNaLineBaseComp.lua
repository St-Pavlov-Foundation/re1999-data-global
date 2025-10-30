module("modules.logic.versionactivity3_0.maLiAnNaAct201.view.comp.MaLiAnNaLineBaseComp", package.seeall)

local var_0_0 = class("MaLiAnNaLineBaseComp", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._tr = arg_1_1.transform
end

function var_0_0.updateItem(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	transformhelper.setLocalPosXY(arg_2_0._tr, arg_2_1, arg_2_2)

	local var_2_0 = MathUtil.vec2_length(arg_2_1, arg_2_2, arg_2_3, arg_2_4)

	recthelper.setWidth(arg_2_0._tr, var_2_0)

	local var_2_1 = MathUtil.calculateV2Angle(arg_2_3, arg_2_4, arg_2_1, arg_2_2)

	transformhelper.setEulerAngles(arg_2_0._tr, 0, 0, var_2_1)
end

return var_0_0
