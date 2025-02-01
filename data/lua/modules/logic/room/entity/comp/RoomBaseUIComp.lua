module("modules.logic.room.entity.comp.RoomBaseUIComp", package.seeall)

slot0 = class("RoomBaseUIComp", LuaCompBase)
slot0.fadeMin = 5
slot0.fadeMax = 7
slot0.alphaChangeMinimum = 0.02

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._uiGO = nil
	slot0._uiGOTrs = nil
	slot0._scene = GameSceneMgr.instance:getCurScene()
end

function slot0.addEventListeners(slot0)
	RoomMapController.instance:registerCallback(RoomEvent.BendingAmountUpdate, slot0.refreshPosition, slot0)
	RoomMapController.instance:registerCallback(RoomEvent.CameraTransformUpdate, slot0.refreshPosition, slot0)
	RoomMapController.instance:registerCallback(RoomEvent.TouchClickUI3D, slot0._onTouchClick, slot0)
end

function slot0.removeEventListeners(slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.BendingAmountUpdate, slot0.refreshPosition, slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.CameraTransformUpdate, slot0.refreshPosition, slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.TouchClickUI3D, slot0._onTouchClick, slot0)
end

function slot0.beforeDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._delayReturnUI, slot0)
	slot0:_delayReturnUI()
	slot0:removeEventListeners()
end

function slot0.refreshPosition(slot0)
	if not slot0._uiGOTrs then
		return
	end

	slot2, slot0._uiGOTrs.rotation, slot4 = RoomBendingHelper.worldToBending(slot0:getUIWorldPos())

	transformhelper.setPos(slot0._uiGOTrs, slot2.x, slot2.y, slot2.z)

	if slot0._gocontainerTrs then
		transformhelper.setLocalRotation(slot0._gocontainerTrs, slot4.x, slot4.y, slot4.z)
	end

	slot0:refreshCanvasGroup()
end

function slot0.refreshCanvasGroup(slot0)
	if not slot0._uiGO or not slot0._canvasGroup then
		return
	end

	slot1, slot2, slot3 = transformhelper.getPos(slot0._uiGOTrs)
	slot4 = slot0._scene.camera:getCameraPosition()
	slot8 = 1

	if uv0.fadeMax <= Vector2.Distance(Vector2(slot1, slot3), Vector2(slot4.x, slot4.z)) then
		slot8 = 0
	elseif slot7 <= uv0.fadeMin then
		slot8 = 1
	elseif slot0._lastAlpha and math.abs(slot0._lastAlpha - (1 - (slot7 - uv0.fadeMin) / (uv0.fadeMax - uv0.fadeMin))) < uv0.alphaChangeMinimum then
		slot8 = slot0._lastAlpha
	end

	slot9 = slot8 > 0.25

	if slot0._lastAlpha ~= slot8 then
		slot0._lastAlpha = slot8
		slot0._canvasGroup.alpha = slot8

		if slot0._arrowRenderer then
			slot0._arrowRenderer:SetAlpha(slot8)
		end
	end

	if slot0._lastBlocksRaycasts ~= slot9 then
		slot0._lastBlocksRaycasts = slot9
		slot0._canvasGroup.blocksRaycasts = slot9
	end
end

function slot0._onTouchClick(slot0, slot1, slot2)
	if slot0._uiGO and slot1 and slot1.transform:IsChildOf(slot0._uiGOTrs) and not slot0._isReturning then
		slot0:onClick(slot1, slot2)
	end
end

function slot0.getUI(slot0)
	if slot0._isReturning then
		slot0._isReturning = false

		TaskDispatcher.cancelTask(slot0._delayReturnUI, slot0)
		slot0._baseAnimator:Play("room_task_in", 0, 1)

		return
	end

	if string.nilorempty(slot0._res) then
		return
	end

	if not slot0._uiGO then
		slot0._uiGO = RoomUIPool.getInstance(slot0._res, slot0._name)
		slot0._uiGOTrs = slot0._uiGO.transform
		slot0._gocontainer = gohelper.findChild(slot0._uiGO, "go_container")
		slot0._gocontainerTrs = slot0._gocontainer.transform
		slot0._canvasGroup = slot0._uiGO:GetComponent(typeof(UnityEngine.CanvasGroup))
		slot0._baseAnimator = slot0._uiGO:GetComponent(typeof(UnityEngine.Animator))

		slot0._baseAnimator:Play("room_task_in", 0, 0)

		if gohelper.findChild(slot0._uiGO, "tubiao") then
			slot0._arrowRenderer = slot1:GetComponent(typeof(UnityEngine.CanvasRenderer))

			if slot0._lastAlpha then
				slot0._arrowRenderer:SetAlpha(slot0._lastAlpha)
			end
		end

		slot0:initUI()
	end

	return slot0._uiGO
end

function slot0.returnUI(slot0)
	if slot0._isReturning then
		return
	end

	slot0._isReturning = false

	TaskDispatcher.cancelTask(slot0._delayReturnUI, slot0)

	if string.nilorempty(slot0._res) then
		return
	end

	if slot0._uiGO then
		slot0._isReturning = true

		slot0._baseAnimator:Play("room_task_out", 0, 0)
		TaskDispatcher.runDelay(slot0._delayReturnUI, slot0, 0.3)
	end
end

function slot0._delayReturnUI(slot0)
	slot0._isReturning = false

	if slot0._uiGO then
		slot0:destoryUI()
		RoomUIPool.returnInstance(slot0._res, slot0._uiGO)

		slot0._uiGO = nil
		slot0._uiGOTrs = nil
		slot0._gocontainer = nil
		slot0._gocontainerTrs = nil
		slot0._canvasGroup = nil
		slot0._arrowRenderer = nil
		slot0._baseAnimator = nil
	end
end

function slot0.initUI(slot0)
end

function slot0.getUIWorldPos(slot0)
end

function slot0.onClick(slot0)
end

return slot0
