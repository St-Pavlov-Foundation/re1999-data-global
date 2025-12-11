module("modules.logic.versionactivity3_1.yeshumei.model.YeShuMeiPointMo", package.seeall)

local var_0_0 = class("YeShuMeiPointMo")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._mo = arg_1_1
	arg_1_0.id = arg_1_1.id
	arg_1_0.typeId = arg_1_1.typeId
	arg_1_0.posX = arg_1_1.posX
	arg_1_0.posY = arg_1_1.posY
	arg_1_0.state = YeShuMeiEnum.StateType.Normal
	arg_1_0.connected = false
end

function var_0_0.updatePos(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.posX = arg_2_1
	arg_2_0.posY = arg_2_2
end

function var_0_0.updateTypeId(arg_3_0, arg_3_1)
	arg_3_0.typeId = arg_3_1
end

function var_0_0.getPosXY(arg_4_0)
	return arg_4_0.posX, arg_4_0.posY
end

function var_0_0.setState(arg_5_0, arg_5_1)
	arg_5_0.state = arg_5_1
end

function var_0_0.getState(arg_6_0)
	return arg_6_0.state
end

function var_0_0.setConnect(arg_7_0)
	arg_7_0.connected = true
end

function var_0_0.getConnect(arg_8_0)
	return arg_8_0.connected
end

function var_0_0.clearPoint(arg_9_0)
	arg_9_0.state = YeShuMeiEnum.StateType.Normal
	arg_9_0.connected = false
end

function var_0_0.getId(arg_10_0)
	return arg_10_0.id
end

function var_0_0.isInCanConnectionRange(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0, var_11_1, var_11_2, var_11_3 = YeShuMeiConfig.instance:getConstValueNumber(YeShuMeiEnum.ConnectRange)

	return MathUtil.isPointInCircleRange(arg_11_0.posX, arg_11_0.posY, var_11_0, arg_11_1, arg_11_2)
end

function var_0_0.getStr(arg_12_0)
	return string.format("id = %d, typeId = %d, posX = %d, posY = %d", arg_12_0.id, arg_12_0.typeId, arg_12_0.posX, arg_12_0.posY)
end

return var_0_0
