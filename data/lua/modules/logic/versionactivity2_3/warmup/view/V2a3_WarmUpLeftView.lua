module("modules.logic.versionactivity2_3.warmup.view.V2a3_WarmUpLeftView", package.seeall)

slot0 = class("V2a3_WarmUpLeftView", BaseView)

function slot0.onInitView(slot0)
	slot0._Middle = gohelper.findChild(slot0.viewGO, "Middle")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

slot1 = -1
slot2 = 0
slot3 = 1
slot4 = SLFramework.AnimatorPlayer
slot5 = ZProj.TweenHelper
slot6 = UIMesh
slot7 = {
	DraggedDone = 1
}

function slot0._editableInitView(slot0)
	slot0._drag = UIDragListenerHelper.New()
	slot0._draggedState = uv0
	slot0._needWaitCount = 0
	slot0._iconGo = gohelper.findChild(slot0._Middle, "#icon")
	slot0._simageicon = gohelper.findChild(slot0._iconGo, "#simage_icon"):GetComponent(typeof(uv1))
	slot0._centerGo = gohelper.findChild(slot0._Middle, "#go_center")
	slot0._centerTrans = slot0._centerGo.transform
	slot0._dragGo = gohelper.findChild(slot0._centerGo, "#go_drag")
	slot0._firstGo = gohelper.findChild(slot0._Middle, "first")
	slot0._dec2Go = gohelper.findChild(slot0._firstGo, "dec2")
	slot0._rudderTran = slot0._dec2Go.transform
	slot0._firstAnimPlayer = uv2.Get(slot0._firstGo)
	slot0._firstAnimator = slot0._firstAnimPlayer.animator
	slot0._iconAnimPlayer = uv2.Get(slot0._iconGo)
	slot0._iconAnimator = slot0._iconAnimPlayer.animator
	slot0._firstAnimator.enabled = false
	slot0._dragEnabled = false

	slot0:_setActive_drag(true)
end

function slot0.onDestroyView(slot0)
	GameUtil.onDestroyViewMember_TweenId(slot0, "_tweener")
	GameUtil.onDestroyViewMember(slot0, "_drag")
end

function slot0.onDataUpdateFirst(slot0)
	slot0._draggedState = slot0:_checkIsDone() and uv0 or uv1

	slot0._drag:create(slot0._dragGo)
	slot0._drag:registerCallback(slot0._drag.EventBegin, slot0._onDragBegin, slot0)
	slot0._drag:registerCallback(slot0._drag.EventDragging, slot0._onDrag, slot0)
	slot0._drag:registerCallback(slot0._drag.EventEnd, slot0._onDragEnd, slot0)

	slot0._centerScreenPosV2 = recthelper.uiPosToScreenPos(slot0._centerTrans)

	slot0:_setActive_icon(slot1)
	slot0:_setActive_rudder(not slot1)
end

function slot0.onDataUpdate(slot0)
	slot0._hasDraggedAngle = 0

	slot0:_refresh()
end

function slot0.onSwitchEpisode(slot0)
	if slot0._draggedState == uv0 and not slot0:_checkIsDone() then
		slot0._draggedState = uv1 - 1
	elseif slot0._draggedState < uv1 and slot1 then
		slot0._draggedState = uv0
	end

	slot0._hasDraggedAngle = 0

	slot0:_refresh()
end

function slot0._episodeId(slot0)
	return slot0.viewContainer:getCurSelectedEpisode()
end

function slot0._getImgResUrl(slot0, slot1)
	return slot0.viewContainer:getImgResUrl(slot0:_episode2Index(slot1))
end

function slot0._episode2Index(slot0, slot1)
	return slot0.viewContainer:episode2Index(slot1 or slot0:_episodeId())
end

function slot0._checkIsDone(slot0, slot1)
	return slot0.viewContainer:checkIsDone(slot1 or slot0:_episodeId())
end

function slot0._saveStateDone(slot0, slot1, slot2)
	slot0.viewContainer:saveStateDone(slot2 or slot0:_episodeId(), slot1)
end

function slot0._saveState(slot0, slot1, slot2)
	assert(slot1 ~= 1999, "please call _saveStateDone instead")
	slot0.viewContainer:saveState(slot2 or slot0:_episodeId(), slot1)
end

function slot0._getState(slot0, slot1, slot2)
	return slot0.viewContainer:getState(slot2 or slot0:_episodeId(), slot1)
end

function slot0._setActive_drag(slot0, slot1)
	gohelper.setActive(slot0._dragGo, slot1)
end

function slot0._setActive_guide(slot0, slot1)
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
	slot0:_clearFrameTimer()
	GameUtil.onDestroyViewMember_TweenId(slot0, "_tweener")
end

function slot0._refresh(slot0)
	slot2 = slot0:_checkIsDone()

	slot0:_loadImage(slot0:_episodeId())
	slot0:_setActive_icon(slot2)
	slot0:_setActive_rudder(not slot2)
	slot0:_setActive_guide(not slot2 and slot0._draggedState <= uv0)

	if slot2 then
		slot0._dragEnabled = false
	elseif slot0:_getState() == 0 then
		slot0._dragEnabled = true

		slot0:_playAnim_Rudder_idle()
	elseif uv1.DraggedDone == slot3 then
		slot0._dragEnabled = false

		slot0:_playAnim_Rudder_click()
	else
		logError("[V2a3_WarmUpLeftView] invalid state:" .. slot3)
	end
end

function slot0._getImgRes(slot0, slot1)
	return slot0.viewContainer:getRes(slot0:_getImgResUrl(slot1))
end

function slot0._loadImage(slot0, slot1)
	slot0._simageicon.texture = slot0:_getImgRes(slot1)

	slot0._simageicon:SetMaterialDirty()
end

function slot0._setActive_icon(slot0, slot1)
	gohelper.setActive(slot0._iconGo, slot1)
end

function slot0._setActive_rudder(slot0, slot1)
	gohelper.setActive(slot0._firstGo, slot1)
end

function slot0._canDrag(slot0)
	return slot0._dragEnabled
end

function slot0._onDragBegin(slot0)
	slot0:_clearFrameTimer()

	if not slot0:_canDrag() then
		return
	end

	slot0:_setActive_guide(false)

	slot0._draggedState = uv0
end

slot8 = 240

function slot0._onDrag(slot0, slot1)
	if not slot0:_canDrag() then
		return
	end

	slot0._hasDraggedAngle = slot0._hasDraggedAngle or 0
	slot2, slot3, slot4 = slot1:quaternionToMouse(slot0._rudderTran, slot0._centerScreenPosV2)

	if slot4 then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_shenghuo_rudder_turn_loop_20234004)
		slot0:_createFTimer()

		slot0._rudderTran.rotation = slot0._rudderTran.rotation * slot2
		slot0._hasDraggedAngle = slot0._hasDraggedAngle + slot3
	end

	if uv0 <= slot0._hasDraggedAngle then
		slot0._dragEnabled = false

		slot0:_saveState(uv1.DraggedDone)
		AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_shenghuo_rudder_turn_loop_20234005)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_shenghuo_rudder_reset_20234006)
		slot0:_playAnim_Rudder_click()
	end
end

function slot0._onDragEnd(slot0)
	slot0:_clearFrameTimer()
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_shenghuo_rudder_turn_loop_20234005)

	if not slot0:_canDrag() then
		return
	end
end

function slot0._resetRudder(slot0, slot1, slot2, slot3)
	GameUtil.onDestroyViewMember_TweenId(slot0, "_tweener")

	slot0._tweener = uv0.DOLocalRotate(slot0._rudderTran, 0, 0, 0, slot1 or 0.7, slot2, slot3, nil, EaseType.OutCirc)
end

function slot0._playAnim_Rudder(slot0, slot1, slot2, slot3)
	slot0._firstAnimator.enabled = true

	slot0._firstAnimPlayer:Play(slot1, slot2, slot3)
end

function slot0._playAnim_Icon(slot0, slot1, slot2, slot3)
	slot0:_setActive_icon(true)

	slot0._iconAnimator.enabled = true

	slot0._iconAnimPlayer:Play(slot1, slot2, slot3)
end

function slot0._playAnim_Rudder_idle(slot0)
	slot0._firstAnimator.enabled = true

	slot0._firstAnimator:Play(UIAnimationName.Idle, 0, 1)
	slot0._firstAnimator:Update(0)

	slot0._firstAnimator.enabled = false
end

function slot0._playAnim_Rudder_click(slot0)
	slot0:_playAnim_Rudder(UIAnimationName.Click, slot0._onAfterClickAnim, slot0)
end

function slot0._onAfterClickAnim(slot0)
	slot0._needWaitCount = 2

	slot0:_playAnim_Rudder(UIAnimationName.Close, slot0._onFinishAnim, slot0)
	slot0:_playAnim_Icon(UIAnimationName.In, slot0._onFinishAnim, slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_taskinterface_2000011)
end

function slot0._onFinishAnim(slot0)
	slot0._needWaitCount = slot0._needWaitCount - 1

	if slot0._needWaitCount > 0 then
		return
	end

	slot0:_saveStateDone(true)
	slot0.viewContainer:openDesc()
end

slot9 = 3
slot10 = 1e-06

function slot0._checkIsDragging(slot0)
	if slot0._checkDraggingCount == uv0 then
		slot0:_clearFrameTimer()
	elseif slot0._checkDraggingCount < uv0 then
		slot0._checkDraggingCount = math.abs(slot0._lastDraggedAngle - slot0._hasDraggedAngle) < uv1 and slot0._checkDraggingCount + 1 or 0
		slot0._lastDraggedAngle = slot0._hasDraggedAngle
	end
end

function slot0._createFTimer(slot0)
	if not slot0._fTimer then
		slot0._fTimer = FrameTimerController.instance:register(slot0._checkIsDragging, slot0, 3, 9)

		slot0._fTimer:Start()
	end
end

function slot0._clearFrameTimer(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_shenghuo_rudder_turn_loop_20234005)
	FrameTimerController.onDestroyViewMember(slot0, "_fTimer")

	slot0._checkDraggingCount = 0
	slot0._lastDraggedAngle = slot0._hasDraggedAngle
end

return slot0
