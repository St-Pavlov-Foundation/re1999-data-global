module("modules.logic.versionactivity3_0.enter.view.VersionActivity3_0EnterDragView", package.seeall)

local var_0_0 = class("VersionActivity3_0EnterDragView", BaseView)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0._nodeName = arg_1_1
end

function var_0_0.onInitView(arg_2_0)
	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	return
end

function var_0_0.removeEvents(arg_4_0)
	return
end

function var_0_0._editableInitView(arg_5_0)
	if not arg_5_0._nodeName then
		logError(string.format("需要给VersionActivity3_0EnterDragView传递拖动节点名称"))

		return
	end

	local var_5_0 = gohelper.findChild(arg_5_0.viewGO, arg_5_0._nodeName)

	if not var_5_0 then
		logError(string.format("VersionActivity3_0EnterDragView没有找到节点:%s", arg_5_0._nodeName))

		return
	end

	local var_5_1 = arg_5_0.viewContainer:getSetting().otherRes[1]
	local var_5_2 = arg_5_0.viewContainer:getResInst(var_5_1, arg_5_0.viewGO)

	gohelper.setSiblingAfter(var_5_2, var_5_0)

	arg_5_0._drag = SLFramework.UGUI.UIDragListener.Get(var_5_2)

	arg_5_0._drag:AddDragBeginListener(arg_5_0._onDragBegin, arg_5_0)
	arg_5_0._drag:AddDragEndListener(arg_5_0._onDragEnd, arg_5_0)
end

function var_0_0.onOpen(arg_6_0)
	return
end

function var_0_0._onDragBegin(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._dragBeginPos = arg_7_2.position
end

function var_0_0._onDragEnd(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0._dragBeginPos then
		return
	end

	local var_8_0 = arg_8_2.position - arg_8_0._dragBeginPos

	if math.abs(var_8_0.x) < 50 or math.abs(var_8_0.y) > 100 then
		return
	end

	local var_8_1 = var_8_0.x < 0

	VersionActivityBaseController.instance:dispatchEvent(VersionActivityEnterViewEvent.DragOpenAct, var_8_1)
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	if arg_10_0._drag then
		arg_10_0._drag:RemoveDragBeginListener()
		arg_10_0._drag:RemoveDragEndListener()

		arg_10_0._drag = nil
	end
end

return var_0_0
