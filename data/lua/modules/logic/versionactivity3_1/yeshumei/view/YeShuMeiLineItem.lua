module("modules.logic.versionactivity3_1.yeshumei.view.YeShuMeiLineItem", package.seeall)

local var_0_0 = class("YeShuMeiLineItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._tr = arg_1_1.transform

	gohelper.setActive(arg_1_0.go, false)

	arg_1_0._godisturb = gohelper.findChild(arg_1_1, "#go_disturb")
	arg_1_0._goconnected = gohelper.findChild(arg_1_1, "#go_connected")
end

function var_0_0.addEventListeners(arg_2_0)
	return
end

function var_0_0.removeEventListeners(arg_3_0)
	return
end

function var_0_0.initData(arg_4_0, arg_4_1)
	arg_4_0._mo = arg_4_1
	arg_4_0.id = arg_4_1.id

	arg_4_0:updateUI()
end

function var_0_0.updateUI(arg_5_0)
	local var_5_0 = arg_5_0._mo:getState() ~= YeShuMeiEnum.StateType.Noraml

	gohelper.setActive(arg_5_0._goconnected, not var_5_0)
	gohelper.setActive(arg_5_0._godisturb, var_5_0)
end

function var_0_0.updatePoint(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._point1 = arg_6_1
	arg_6_0._point2 = arg_6_2

	arg_6_0:updateByPoint()
end

function var_0_0.addPoint(arg_7_0, arg_7_1)
	if arg_7_0._point1 == nil then
		arg_7_0._point1 = arg_7_1
	end

	if arg_7_0._point2 == nil and arg_7_0._point1.id ~= arg_7_1.id then
		arg_7_0._point2 = arg_7_1
	end

	arg_7_0:updateByPoint()
end

function var_0_0.updateByPoint(arg_8_0)
	if arg_8_0._point1 ~= nil and arg_8_0._point2 ~= nil then
		local var_8_0, var_8_1 = arg_8_0._point1:getLocalPos()
		local var_8_2, var_8_3 = arg_8_0._point2:getLocalPos()

		arg_8_0:updateItem(var_8_0, var_8_1, var_8_2, var_8_3)
		arg_8_0._mo:updatePos(var_8_0, var_8_1, var_8_2, var_8_3)
		arg_8_0._mo:updatePoint(arg_8_0._point1.id, arg_8_0._point2.id)
	end
end

function var_0_0.updateItem(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4)
	transformhelper.setLocalPosXY(arg_9_0._tr, arg_9_1, arg_9_2)

	local var_9_0 = MathUtil.vec2_length(arg_9_1, arg_9_2, arg_9_3, arg_9_4)

	recthelper.setWidth(arg_9_0._tr, var_9_0)

	local var_9_1 = MathUtil.calculateV2Angle(arg_9_3, arg_9_4, arg_9_1, arg_9_2)

	transformhelper.setEulerAngles(arg_9_0._tr, 0, 0, var_9_1)
end

function var_0_0.onDestroy(arg_10_0)
	gohelper.destroy(arg_10_0.go)
end

return var_0_0
