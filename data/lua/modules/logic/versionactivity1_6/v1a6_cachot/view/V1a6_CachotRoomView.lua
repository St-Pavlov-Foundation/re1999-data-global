module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotRoomView", package.seeall)

slot0 = class("V1a6_CachotRoomView", BaseView)

function slot0.onInitView(slot0)
	slot0._viewAnim = gohelper.findChild(slot0.viewGO, "#go_excessive"):GetComponent(typeof(UnityEngine.Animator))
	slot0._viewAnim.keepAnimatorControllerStateOnDisable = true
	slot0._txttest = gohelper.findChildTextMesh(slot0.viewGO, "#txt_test")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, slot0._checkHaveViewOpen, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.CheckOpenEnding, slot0._checkShowEnding, slot0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.RoomChangeBegin, slot0._beginSwitchScene, slot0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.RoomChangePlayAnim, slot0._endSwitchScene, slot0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnUpdateRogueInfo, slot0.____testShowInfo, slot0)
end

function slot0.removeEvents(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, slot0._checkHaveViewOpen, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.CheckOpenEnding, slot0._checkShowEnding, slot0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.RoomChangeBegin, slot0._beginSwitchScene, slot0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.RoomChangePlayAnim, slot0._endSwitchScene, slot0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnUpdateRogueInfo, slot0.____testShowInfo, slot0)
end

function slot0._checkHaveViewOpen(slot0)
	if slot0:isOpenView() then
		transformhelper.setLocalPos(slot0.viewGO.transform, 0, -99999, 0)
	else
		transformhelper.setLocalPos(slot0.viewGO.transform, 0, 0, 0)
	end

	if not slot1 then
		slot0:_checkShowEnding()
	end
end

function slot0.isOpenView(slot0)
	slot1 = not ViewHelper.instance:checkViewOnTheTop(ViewName.V1a6_CachotRoomView, {
		ViewName.GuideView,
		ViewName.GuideView2,
		ViewName.GuideStepEditor
	})

	if PopupController.instance:getPopupCount() > 0 then
		slot1 = true
	end

	return slot1
end

function slot0._checkShowEnding(slot0)
	if slot0:isOpenView() then
		return
	end

	if V1a6_CachotModel.instance:getRogueEndingInfo() then
		V1a6_CachotController.instance:openV1a6_CachotFinishView()
	end
end

function slot0._onCloseView(slot0, slot1)
	slot0:_checkHaveViewOpen()
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.V1a6_CachotLoadingView then
		gohelper.setActive(slot0.viewGO, false)
		gohelper.setActive(slot0.viewGO, true)
	end
end

function slot0._beginSwitchScene(slot0)
	slot0._viewAnim:Play("open", 0, 0)
	TaskDispatcher.runDelay(slot0._onOpenAnimEnd, slot0, 1)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._onOpenAnimEnd, slot0)
end

function slot0._onOpenAnimEnd(slot0)
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.RoomViewOpenAnimEnd)
end

function slot0._endSwitchScene(slot0, slot1)
	slot0._viewAnim:Play("close", 0, slot1 and 0 or 1)
	slot0.viewContainer:dispatchEvent(V1a6_CachotEvent.RoomChangeAnimEnd)
end

function slot0.onOpen(slot0)
	gohelper.setActive(slot0._txttest, false)

	slot0._isShowGo = true

	slot0:_checkHaveViewOpen()
	slot0._viewAnim:Play("close", 0, 1)
	slot0:____testShowInfo()
end

function slot0.____testShowInfo(slot0)
	if not isDebugBuild then
		return
	end

	slot0._rogueInfo = V1a6_CachotModel.instance:getRogueInfo()

	if not slot0._rogueInfo then
		return
	end

	slot1, slot2 = V1a6_CachotRoomConfig.instance:getRoomIndexAndTotal(slot0._rogueInfo.room)
	slot3 = {}

	for slot7 = 1, #slot0._rogueInfo.currentEvents do
		slot8 = slot0._rogueInfo.currentEvents[slot7]

		table.insert(slot3, slot8.eventId .. ":" .. slot8.status .. ">>" .. slot8.eventData)
	end

	slot0._txttest.text = "" .. string.format("当前房间：%d (%d / %d)\n", slot0._rogueInfo.room, slot1, slot2) .. string.format("当前房间事件：\n" .. table.concat(slot3, "\n"))
end

return slot0
