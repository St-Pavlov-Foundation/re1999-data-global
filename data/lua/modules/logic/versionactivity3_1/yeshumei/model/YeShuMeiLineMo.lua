module("modules.logic.versionactivity3_1.yeshumei.model.YeShuMeiLineMo", package.seeall)

local var_0_0 = class("YeShuMeiLineMo")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1
	arg_1_0.beginPosX = 0
	arg_1_0.beginPosY = 0
	arg_1_0.endPosX = 0
	arg_1_0.endPosY = 0
	arg_1_0._beginPointId = 0
	arg_1_0._endPointId = 0
	arg_1_0.state = YeShuMeiEnum.StateType.Noraml
	arg_1_0.connected = false
end

function var_0_0.updatePos(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0.beginPosX = arg_2_1
	arg_2_0.beginPosY = arg_2_2
	arg_2_0.endPosX = arg_2_3
	arg_2_0.endPosY = arg_2_4
end

function var_0_0.getBeginPos(arg_3_0)
	return arg_3_0.beginPosX, arg_3_0.beginPosY
end

function var_0_0.getEndPos(arg_4_0)
	return arg_4_0.endPosX, arg_4_0.endPosY
end

function var_0_0.updatePoint(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._beginPointId = arg_5_1
	arg_5_0._endPointId = arg_5_2
end

function var_0_0.havePoint(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_0._beginPointId == arg_6_1 and arg_6_0._endPointId == arg_6_2 then
		return true
	end

	if arg_6_0._beginPointId == arg_6_2 and arg_6_0._endPointId == arg_6_1 then
		return true
	end

	return false
end

function var_0_0.checkHaveErrorId(arg_7_0, arg_7_1)
	if arg_7_0._beginPointId == arg_7_1 or arg_7_0._endPointId == arg_7_1 then
		return true
	end

	return false
end

function var_0_0.findHavePoint(arg_8_0, arg_8_1)
	local var_8_0 = false
	local var_8_1

	if arg_8_0._beginPointId == arg_8_1 then
		var_8_0 = true
		var_8_1 = arg_8_0._endPointId
	end

	if arg_8_0._endPointId == arg_8_1 then
		var_8_0 = true
		var_8_1 = arg_8_0._beginPointId
	end

	return var_8_0, var_8_1
end

function var_0_0.setState(arg_9_0, arg_9_1)
	arg_9_0.state = arg_9_1
end

function var_0_0.getState(arg_10_0)
	return arg_10_0.state
end

function var_0_0.getStr(arg_11_0)
	return string.format("id = %d, beginPosX = %d, beginPosY = %d, endPosX = %d, endPosY = %d, beginPointId = %d, endPointId = %d", arg_11_0.id, arg_11_0.beginPosX, arg_11_0.beginPosY, arg_11_0.endPosX, arg_11_0.endPosY, arg_11_0._beginPointId, arg_11_0._endPointId)
end

return var_0_0
