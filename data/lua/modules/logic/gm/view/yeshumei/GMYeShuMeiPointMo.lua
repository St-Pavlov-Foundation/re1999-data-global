module("modules.logic.gm.view.yeshumei.GMYeShuMeiPointMo", package.seeall)

local var_0_0 = class("GMYeShuMeiPointMo")

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_2
	arg_1_0.typeId = arg_1_1
	arg_1_0.posX = 0
	arg_1_0.posY = 0
end

function var_0_0.initMo(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.id = arg_2_1
	arg_2_0.x = arg_2_2
	arg_2_0.y = arg_2_3
	arg_2_0.state = YeShuMeiEnum.StateType.Noraml
	arg_2_0.connected = false
end

function var_0_0.updatePos(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.posX = arg_3_1
	arg_3_0.posY = arg_3_2
end

function var_0_0.updateTypeId(arg_4_0, arg_4_1)
	arg_4_0.typeId = arg_4_1
end

function var_0_0.getPosXY(arg_5_0)
	return arg_5_0.posX, arg_5_0.posY
end

function var_0_0.getId(arg_6_0)
	return arg_6_0.id
end

function var_0_0.getStr(arg_7_0)
	return string.format("id = %d, typeId = %d, posX = %d, posY = %d", arg_7_0.id, arg_7_0.typeId, arg_7_0.posX, arg_7_0.posY)
end

return var_0_0
