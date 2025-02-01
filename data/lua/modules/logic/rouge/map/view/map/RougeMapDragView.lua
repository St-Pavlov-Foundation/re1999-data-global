module("modules.logic.rouge.map.view.map.RougeMapDragView", package.seeall)

slot0 = class("RougeMapDragView", BaseView)

function slot0.onInitView(slot0)
	slot0.goFullScreen = gohelper.findChild(slot0.viewGO, "#go_fullscreen")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0.drag = SLFramework.UGUI.UIDragListener.Get(slot0.goFullScreen)

	slot0.drag:AddDragBeginListener(slot0._onBeginDrag, slot0)
	slot0.drag:AddDragListener(slot0._onDrag, slot0)
	slot0.drag:AddDragEndListener(slot0._onEndDrag, slot0)

	slot0.mainCamera = CameraMgr.instance:getMainCamera()
	slot0.refPos = slot0.goFullScreen.transform.position
end

function slot0._onBeginDrag(slot0)
	if not RougeMapModel.instance:isNormalLayer() then
		return
	end

	slot0.startPosX = RougeMapHelper.getWorldPos(UnityEngine.Input.mousePosition, slot0.mainCamera, slot0.refPos)
end

function slot0._onDrag(slot0)
	if not RougeMapModel.instance:isNormalLayer() then
		return
	end

	if not slot0.startPosX then
		return
	end

	slot1 = RougeMapHelper.getWorldPos(UnityEngine.Input.mousePosition, slot0.mainCamera, slot0.refPos)

	RougeMapModel.instance:setMapPosX(RougeMapModel.instance:getMapPosX() + slot1 - slot0.startPosX)

	slot0.startPosX = slot1
end

function slot0._onEndDrag(slot0)
	slot0.startPosX = nil
end

function slot0.onClose(slot0)
	if slot0.drag then
		slot0.drag:RemoveDragBeginListener()
		slot0.drag:RemoveDragListener()
		slot0.drag:RemoveDragEndListener()
	end
end

return slot0
