module("modules.common.others.CommonDragHelper", package.seeall)

local var_0_0 = class("CommonDragHelper")

function var_0_0.ctor(arg_1_0)
	arg_1_0._list = {}
	arg_1_0._nowDragData = nil
	arg_1_0.enabled = true
end

function var_0_0.registerDragObj(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7, arg_2_8, arg_2_9, arg_2_10, arg_2_11)
	if not arg_2_1 or gohelper.isNil(arg_2_1) then
		logError("go can not be nil")

		return
	end

	if arg_2_0:getDragData(arg_2_1) then
		logWarn("repeat register")
		arg_2_0:unregisterDragObj(arg_2_1)
	end

	local var_2_0 = {}
	local var_2_1 = SLFramework.UGUI.UIDragListener.Get(arg_2_1)

	var_2_1:AddDragBeginListener(arg_2_0._onBeginDrag, arg_2_0, var_2_0)
	var_2_1:AddDragListener(arg_2_0._onDrag, arg_2_0, var_2_0)
	var_2_1:AddDragEndListener(arg_2_0._onEndDrag, arg_2_0, var_2_0)

	var_2_0.go = arg_2_1
	var_2_0.transform = arg_2_1.transform
	var_2_0.parent = arg_2_1.transform.parent
	var_2_0.beginCallBack = arg_2_2
	var_2_0.dragCallBack = arg_2_3
	var_2_0.endCallBack = arg_2_4
	var_2_0.checkCallBack = arg_2_5
	var_2_0.callObj = arg_2_6
	var_2_0.drag = var_2_1
	var_2_0.params = arg_2_7
	var_2_0.enabled = true
	var_2_0.isNoMove = arg_2_8
	var_2_0.moveOffset = arg_2_9
	var_2_0.dragScale = arg_2_10 or 1
	var_2_0.dragDefaultScale = arg_2_11 or 1

	table.insert(arg_2_0._list, var_2_0)
end

function var_0_0.setCallBack(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5, arg_3_6, arg_3_7)
	local var_3_0 = arg_3_0:getDragData(arg_3_1)

	if not var_3_0 then
		return
	end

	var_3_0.beginCallBack = arg_3_2
	var_3_0.dragCallBack = arg_3_3
	var_3_0.endCallBack = arg_3_4
	var_3_0.checkCallBack = arg_3_5
	var_3_0.callObj = arg_3_6
	var_3_0.params = arg_3_7
end

function var_0_0.refreshParent(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:getDragData(arg_4_1)

	if not var_4_0 then
		return
	end

	var_4_0.parent = var_4_0.transform.parent

	ZProj.TweenHelper.KillByObj(var_4_0.transform)
end

function var_0_0._onBeginDrag(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_1.enabled or not arg_5_0.enabled then
		return
	end

	if arg_5_1.checkCallBack and arg_5_1.checkCallBack(arg_5_1.callObj, arg_5_1.params) then
		return
	end

	if arg_5_0._nowDragData then
		return
	end

	arg_5_0._nowDragData = arg_5_1

	if not arg_5_1.isNoMove then
		arg_5_0:_tweenToPos(arg_5_1, arg_5_2.position)
		gohelper.setAsLastSibling(arg_5_1.go)
	end

	if arg_5_1.dragScale ~= arg_5_1.dragDefaultScale then
		ZProj.TweenHelper.KillByObj(arg_5_1.transform)
		ZProj.TweenHelper.DOScale(arg_5_1.transform, arg_5_1.dragScale, arg_5_1.dragScale, arg_5_1.dragScale, 0.16)
	end

	if arg_5_1.beginCallBack then
		arg_5_1.beginCallBack(arg_5_1.callObj, arg_5_1.params, arg_5_2)
	end
end

function var_0_0._tweenToPos(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_1.moveOffset then
		arg_6_2 = arg_6_2 + arg_6_1.moveOffset
	end

	local var_6_0 = recthelper.screenPosToAnchorPos(arg_6_2, arg_6_1.parent)
	local var_6_1 = arg_6_1.transform
	local var_6_2, var_6_3 = recthelper.getAnchor(var_6_1)

	if math.abs(var_6_2 - var_6_0.x) > 10 or math.abs(var_6_3 - var_6_0.y) > 10 then
		ZProj.TweenHelper.DOAnchorPos(var_6_1, var_6_0.x, var_6_0.y, 0.2)
	else
		recthelper.setAnchor(var_6_1, var_6_0.x, var_6_0.y)
	end
end

function var_0_0._onDrag(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0._nowDragData ~= arg_7_1 then
		return
	end

	if not arg_7_1.isNoMove then
		arg_7_0:_tweenToPos(arg_7_1, arg_7_2.position)
	end

	if arg_7_1.dragCallBack then
		arg_7_1.dragCallBack(arg_7_1.callObj, arg_7_1.params, arg_7_2)
	end
end

function var_0_0._onEndDrag(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_0._nowDragData ~= arg_8_1 then
		return
	end

	if arg_8_1.dragScale ~= arg_8_1.dragDefaultScale then
		ZProj.TweenHelper.DOScale(arg_8_1.transform, arg_8_1.dragDefaultScale, arg_8_1.dragDefaultScale, arg_8_1.dragDefaultScale, 0.16)
	end

	if arg_8_1.endCallBack then
		arg_8_1.endCallBack(arg_8_1.callObj, arg_8_1.params, arg_8_2)
	end

	arg_8_0._nowDragData = nil
end

function var_0_0.setDragEnabled(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_0:getDragData(arg_9_1)

	if not var_9_0 then
		return
	end

	var_9_0.enabled = arg_9_2

	if not arg_9_2 and arg_9_0._nowDragData == var_9_0 then
		arg_9_0:stopDrag(arg_9_1)
	end
end

function var_0_0.setGlobalEnabled(arg_10_0, arg_10_1)
	arg_10_0.enabled = arg_10_1

	if not arg_10_1 and arg_10_0._nowDragData then
		arg_10_0:stopDrag(arg_10_0._nowDragData.go)
	end
end

function var_0_0.getDragData(arg_11_0, arg_11_1)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0._list) do
		if iter_11_1.go == arg_11_1 then
			return iter_11_1, iter_11_0
		end
	end
end

function var_0_0.stopDrag(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0._nowDragData and arg_12_0._nowDragData.go == arg_12_1 then
		if arg_12_2 then
			arg_12_0._nowDragData.endCallBack(arg_12_0._nowDragData.callObj, arg_12_0._nowDragData.params, GamepadController.instance:getMousePosition())
		end

		arg_12_0._nowDragData = nil
	end
end

function var_0_0.unregisterDragObj(arg_13_0, arg_13_1)
	local var_13_0, var_13_1 = arg_13_0:getDragData(arg_13_1)

	if not var_13_0 then
		return
	end

	local var_13_2 = var_13_0.drag

	if not gohelper.isNil(var_13_2) then
		var_13_2:RemoveDragListener()
		var_13_2:RemoveDragBeginListener()
		var_13_2:RemoveDragEndListener()
	end

	table.remove(arg_13_0._list, var_13_1)

	if arg_13_0._nowDragData == var_13_0 then
		arg_13_0._nowDragData = nil
	end
end

function var_0_0.clear(arg_14_0)
	for iter_14_0, iter_14_1 in ipairs(arg_14_0._list) do
		local var_14_0 = iter_14_1.drag

		if not gohelper.isNil(var_14_0) then
			var_14_0:RemoveDragListener()
			var_14_0:RemoveDragBeginListener()
			var_14_0:RemoveDragEndListener()
		end
	end

	arg_14_0._list = {}
	arg_14_0._nowDragData = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
