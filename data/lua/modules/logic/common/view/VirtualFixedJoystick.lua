module("modules.logic.common.view.VirtualFixedJoystick", package.seeall)

local var_0_0 = class("VirtualFixedJoystick", LuaCompBase)
local var_0_1 = 1
local var_0_2 = 0.5
local var_0_3 = 0

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._gobg = gohelper.findChild(arg_1_0.go, "#go_background")
	arg_1_0._transbg = arg_1_0._gobg.transform
	arg_1_0._transbg.pivot.x = var_0_2
	arg_1_0._transbg.pivot.y = var_0_2
	arg_1_0._radius = arg_1_0._transbg.sizeDelta.x / 2
	arg_1_0._gohandle = gohelper.findChild(arg_1_0.go, "#go_background/#go_handle")
	arg_1_0._transhandle = arg_1_0._gohandle.transform
	arg_1_0._transhandle.anchorMin.x = var_0_2
	arg_1_0._transhandle.anchorMin.y = var_0_2
	arg_1_0._transhandle.anchorMax.x = var_0_2
	arg_1_0._transhandle.anchorMax.y = var_0_2
	arg_1_0._transhandle.pivot.x = var_0_2
	arg_1_0._transhandle.pivot.y = var_0_2
	arg_1_0._input = Vector2.zero
	arg_1_0._click = SLFramework.UGUI.UIClickListener.Get(arg_1_0.go)
	arg_1_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_1_0.go)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0._click:AddClickDownListener(arg_2_0._onClickDown, arg_2_0)
	arg_2_0._drag:AddDragListener(arg_2_0._onDrag, arg_2_0)
	arg_2_0._click:AddClickUpListener(arg_2_0._onClickUp, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0._click:RemoveClickDownListener()
	arg_3_0._drag:RemoveDragListener()
	arg_3_0._click:RemoveClickUpListener()
end

function var_0_0._onClickDown(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if arg_4_0._dragging then
		return
	end

	arg_4_0._dragging = true

	arg_4_0:_handleInput(arg_4_2)
end

function var_0_0._onDrag(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_0._dragging then
		return
	end

	arg_5_0:_handleInput(arg_5_2.position)
end

function var_0_0._handleInput(arg_6_0, arg_6_1)
	local var_6_0, var_6_1 = recthelper.screenPosToAnchorPos2(arg_6_1, arg_6_0._transbg)
	local var_6_2 = (var_6_0 - var_0_3) / arg_6_0._radius
	local var_6_3 = (var_6_1 - var_0_3) / arg_6_0._radius

	arg_6_0:setInPutValue(var_6_2, var_6_3)
end

function var_0_0._onClickUp(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if not arg_7_0._dragging then
		return
	end

	arg_7_0:reset()
end

function var_0_0.setInPutValue(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._input.x = arg_8_1 or var_0_3
	arg_8_0._input.y = arg_8_2 or var_0_3

	if arg_8_0._input.magnitude > var_0_1 then
		arg_8_0._input = arg_8_0._input.normalized
	end

	arg_8_0:refreshHandlePos()
end

function var_0_0.refreshHandlePos(arg_9_0)
	local var_9_0 = arg_9_0._input.x * arg_9_0._radius
	local var_9_1 = arg_9_0._input.y * arg_9_0._radius
	local var_9_2 = GameUtil.clamp(var_9_0, -arg_9_0._radius, arg_9_0._radius)
	local var_9_3 = GameUtil.clamp(var_9_1, -arg_9_0._radius, arg_9_0._radius)

	transformhelper.setLocalPosXY(arg_9_0._transhandle, var_9_2, var_9_3)
end

function var_0_0.getIsDragging(arg_10_0)
	return arg_10_0._dragging
end

function var_0_0.getInputValue(arg_11_0)
	return arg_11_0._input
end

function var_0_0.reset(arg_12_0)
	arg_12_0:setInPutValue()

	arg_12_0._dragging = false
end

function var_0_0.onDestroy(arg_13_0)
	return
end

return var_0_0
