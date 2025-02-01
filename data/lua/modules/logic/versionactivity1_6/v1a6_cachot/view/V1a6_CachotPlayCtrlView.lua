module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotPlayCtrlView", package.seeall)

slot0 = class("V1a6_CachotPlayCtrlView", BaseView)

function slot0.onInitView(slot0)
	slot0._goCtrl = gohelper.findChild(slot0.viewGO, "#go_control")
	slot0._icon = gohelper.findChildImage(slot0.viewGO, "#go_control/bg")
	slot0._iconCanvasGroup = gohelper.onceAddComponent(slot0._icon, gohelper.Type_CanvasGroup)
	slot0._iconTrans = slot0._icon.transform

	if gohelper.findChild(slot0.viewGO, "#go_interact") then
		slot0._gouninteract = gohelper.findChild(slot1, "uninteract")
		slot0._gointeract = gohelper.findChild(slot1, "interactale")
		slot0._btninteract = gohelper.findChildButton(slot1, "#btn_interactclick")
		slot0._gointeractaleKey = gohelper.findChild(slot1, "#btn_interactclick/#go_interactaleKey")
		slot2 = GuideModel.instance:getById(16502)

		gohelper.setActive(slot0._gointeractaleKey, (BootNativeUtil.isWindows() or SDKMgr.instance:isEmulator()) and slot2 ~= nil and slot2.isFinish)
	end
end

function slot0.addEvents(slot0)
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._goCtrl)

	slot0._drag:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEnd, slot0)
	slot0._drag:AddDragListener(slot0._onDrag, slot0)

	if slot0._btninteract then
		slot0._btninteract:AddClickListener(slot0.onInteract, slot0)
		V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.NearEventMoChange, slot0._onNearEventChange, slot0)
		V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.ClickNearEvent, slot0.onInteract, slot0)

		if BootNativeUtil.isWindows() or SDKMgr.instance:isEmulator() then
			TaskDispatcher.runRepeat(slot0._checkInteract, slot0, 0)
		end
	end

	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, slot0.cancelDrag, slot0)
end

function slot0.removeEvents(slot0)
	slot0._drag:RemoveDragBeginListener()
	slot0._drag:RemoveDragEndListener()
	slot0._drag:RemoveDragListener()

	if slot0._btninteract then
		slot0._btninteract:RemoveClickListener()
		V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.NearEventMoChange, slot0._onNearEventChange, slot0)
		V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.ClickNearEvent, slot0.onInteract, slot0)
		TaskDispatcher.cancelTask(slot0._checkInteract, slot0, 0)
	end

	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, slot0.cancelDrag, slot0)
end

function slot0.onOpen(slot0)
	slot0:_onNearEventChange()

	slot0._iconCanvasGroup.alpha = 0.5

	TaskDispatcher.runRepeat(slot0._checkInput, slot0, 0, -1)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._checkInput, slot0)
	TaskDispatcher.cancelTask(slot0._delayTriggerEvent, slot0)
	TaskDispatcher.cancelTask(slot0._checkInteract, slot0, 0)
	UIBlockMgr.instance:endBlock("BeginTriggerEvent")

	V1a6_CachotRoomModel.instance.isLockPlayerMove = false
end

function slot0._onDragBegin(slot0)
	slot0._beginDrag = true
	slot0._iconCanvasGroup.alpha = 1
end

function slot0._onDragEnd(slot0)
	slot0:cancelDrag()

	slot0._beginDrag = false
end

function slot0._onDrag(slot0, slot1, slot2)
	if not slot0._beginDrag then
		return
	end

	slot4 = Mathf.Clamp(recthelper.screenPosToAnchorPos(slot2.position, slot0._goCtrl.transform).x, -180, 180)

	recthelper.setAnchorX(slot0._iconTrans, slot4)

	if slot4 <= 10 and slot4 >= -10 then
		slot0._dragValue = nil

		return
	end

	slot0._dragValue = slot4 > 0 and 1 or -1
end

function slot0._checkInput(slot0)
	slot1 = 0

	if UnityEngine.Input.GetKey(UnityEngine.KeyCode.LeftArrow) or UnityEngine.Input.GetKey(UnityEngine.KeyCode.A) then
		slot1 = -1
	elseif UnityEngine.Input.GetKey(UnityEngine.KeyCode.RightArrow) or UnityEngine.Input.GetKey(UnityEngine.KeyCode.D) then
		slot1 = 1
	end

	if slot1 ~= 0 and not slot0._beginDrag then
		slot0:onPlayerMove(slot1)
	elseif slot0._beginDrag and slot0._dragValue then
		slot0:onPlayerMove(slot0._dragValue)
	else
		V1a6_CachotRoomModel.instance:setIsMoving(false)
	end

	if UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Return) then
		slot0:onInteract()
	end
end

function slot0.onPlayerMove(slot0, slot1)
	if not slot0:canMove() then
		V1a6_CachotRoomModel.instance:setIsMoving(false)

		return
	end

	V1a6_CachotRoomModel.instance:setIsMoving(true)
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.PlayerMove, slot1)
end

function slot0._onNearEventChange(slot0)
	if not slot0._gouninteract then
		return
	end

	slot1 = V1a6_CachotRoomModel.instance:getNearEventMo()

	gohelper.setActive(slot0._gouninteract, not slot1)
	gohelper.setActive(slot0._gointeract, slot1)

	if slot1 then
		V1a6_CachotCollectionController.instance:dispatchEvent(V1a6_CachotEvent.GuideNearEvent)
	end
end

function slot0._checkInteract(slot0)
	if not slot0:canMove() then
		return
	end

	if UnityEngine.Input.GetKeyDown(UnityEngine.KeyCode.Space) then
		slot0:onInteract()
	end
end

function slot0.onInteract(slot0)
	if not V1a6_CachotRoomModel.instance:getNearEventMo() then
		return
	end

	if V1a6_CachotRoomModel.instance.isLockPlayerMove then
		return false
	end

	UIBlockMgr.instance:startBlock("BeginTriggerEvent")
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.BeginTriggerEvent, slot1)

	V1a6_CachotRoomModel.instance.isLockPlayerMove = true

	TaskDispatcher.runDelay(slot0._delayTriggerEvent, slot0, 1.067)
end

function slot0._delayTriggerEvent(slot0)
	if not V1a6_CachotRoomModel.instance:getNearEventMo() then
		return
	end

	UIBlockMgr.instance:endBlock("BeginTriggerEvent")

	V1a6_CachotRoomModel.instance.isLockPlayerMove = false

	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.TriggerEvent)

	if V1a6_CachotRoomModel.instance:getNowBattleEventMo() then
		V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.PlayerTriggerInteract, slot2)
	else
		RogueRpc.instance:sendRogueEventStartRequest(V1a6_CachotEnum.ActivityId, slot1.eventId)
	end
end

function slot0.canMove(slot0)
	if V1a6_CachotRoomModel.instance.isLockPlayerMove then
		return false
	end

	if PopupController.instance:getPopupCount() == 1 and ViewMgr.instance:isOpen(ViewName.GuideView) then
		return true
	end

	if slot1 > 0 then
		return false
	end

	return ViewHelper.instance:checkViewOnTheTop(ViewName.V1a6_CachotRoomView) or ViewHelper.instance:checkViewOnTheTop(ViewName.V1a6_CachotMainView)
end

function slot0.cancelDrag(slot0)
	if not slot0._beginDrag then
		return
	end

	slot0._beginDrag = nil
	slot0._dragValue = nil
	slot0._iconCanvasGroup.alpha = 0.5

	recthelper.setAnchorX(slot0._iconTrans, 0)
end

return slot0
