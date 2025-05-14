module("modules.logic.rouge.map.view.map.RougeMapDragView", package.seeall)

local var_0_0 = class("RougeMapDragView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goFullScreen = gohelper.findChild(arg_1_0.viewGO, "#go_fullscreen")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.drag = SLFramework.UGUI.UIDragListener.Get(arg_4_0.goFullScreen)

	arg_4_0.drag:AddDragBeginListener(arg_4_0._onBeginDrag, arg_4_0)
	arg_4_0.drag:AddDragListener(arg_4_0._onDrag, arg_4_0)
	arg_4_0.drag:AddDragEndListener(arg_4_0._onEndDrag, arg_4_0)

	arg_4_0.mainCamera = CameraMgr.instance:getMainCamera()
	arg_4_0.refPos = arg_4_0.goFullScreen.transform.position
end

function var_0_0._onBeginDrag(arg_5_0)
	if not RougeMapModel.instance:isNormalLayer() then
		return
	end

	arg_5_0.startPosX = RougeMapHelper.getWorldPos(UnityEngine.Input.mousePosition, arg_5_0.mainCamera, arg_5_0.refPos)
end

function var_0_0._onDrag(arg_6_0)
	if not RougeMapModel.instance:isNormalLayer() then
		return
	end

	if not arg_6_0.startPosX then
		return
	end

	local var_6_0 = RougeMapHelper.getWorldPos(UnityEngine.Input.mousePosition, arg_6_0.mainCamera, arg_6_0.refPos)
	local var_6_1 = var_6_0 - arg_6_0.startPosX
	local var_6_2 = RougeMapModel.instance:getMapPosX()

	RougeMapModel.instance:setMapPosX(var_6_2 + var_6_1)

	arg_6_0.startPosX = var_6_0
end

function var_0_0._onEndDrag(arg_7_0)
	arg_7_0.startPosX = nil
end

function var_0_0.onClose(arg_8_0)
	if arg_8_0.drag then
		arg_8_0.drag:RemoveDragBeginListener()
		arg_8_0.drag:RemoveDragListener()
		arg_8_0.drag:RemoveDragEndListener()
	end
end

return var_0_0
