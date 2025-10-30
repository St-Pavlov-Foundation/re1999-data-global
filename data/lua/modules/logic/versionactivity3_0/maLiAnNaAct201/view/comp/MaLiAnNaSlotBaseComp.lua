module("modules.logic.versionactivity3_0.maLiAnNaAct201.view.comp.MaLiAnNaSlotBaseComp", package.seeall)

local var_0_0 = class("MaLiAnNaSlotBaseComp", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._tr = arg_1_1.transform
end

function var_0_0.initPos(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._localPosX = arg_2_1
	arg_2_0._localPosY = arg_2_2

	transformhelper.setLocalPosXY(arg_2_0._tr, arg_2_1, arg_2_2)
end

function var_0_0.getLocalPos(arg_3_0)
	return arg_3_0._localPosX, arg_3_0._localPosY
end

return var_0_0
