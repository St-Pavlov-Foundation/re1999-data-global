module("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_Day5", package.seeall)

slot1 = class("V2a2_WarmUpLeftView_Day5", require("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_DayBase"))

function slot1.onInitView(slot0)
	slot0._simageicon1 = gohelper.findChildSingleImage(slot0.viewGO, "before/#simage_icon1")
	slot0._goValidArea = gohelper.findChild(slot0.viewGO, "before/#go_ValidArea")
	slot0._btn1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "before/#btn_1")
	slot0._simageicon2 = gohelper.findChildSingleImage(slot0.viewGO, "after/#simage_icon2")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot1.addEvents(slot0)
	slot0._btn1:AddClickListener(slot0._btn1OnClick, slot0)
end

function slot1.removeEvents(slot0)
	slot0._btn1:RemoveClickListener()
end

slot2 = {
	Clicked = 1
}

function slot1._btn1OnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_common_click_20220226)
end

function slot1.ctor(slot0, slot1)
	uv0.ctor(slot0, slot1)

	slot0._dragEnabled = false
	slot0._needWaitCount = 0
end

function slot1._editableInitView(slot0)
	uv0._editableInitView(slot0)

	slot0._guideGo = gohelper.findChild(slot0.viewGO, "guide_day5")
	slot0._startGo = slot0._btn1.gameObject
	slot0._startTrans = slot0._startGo.transform
	slot0._startX, slot0._startY = recthelper.getAnchor(slot0._startTrans)
	slot0._startAnimation = slot0._startGo:GetComponent(gohelper.Type_Animation)
	slot0._endGo = slot0._goValidArea
	slot0._endTrans = slot0._endGo.transform

	CommonDragHelper.instance:registerDragObj(slot0._startGo, slot0._onBeginDrag, slot0._onDrag, slot0._onEndDrag, slot0._checkCanDrag, slot0)
end

function slot1.onDestroyView(slot0)
	CommonDragHelper.instance:unregisterDragObj(slot0._startGo)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_youyu_yure_cut_loop_20220229)
	uv0.onDestroyView(slot0)
end

function slot1._checkCanDrag(slot0)
	return not slot0:_canDrag()
end

function slot1._canDrag(slot0)
	return slot0._dragEnabled
end

function slot1._onBeginDrag(slot0, slot1, slot2)
	if not slot0:_canDrag() then
		return
	end

	slot0._startAnimation.enabled = false

	uv0._onDragBegin(slot0)
end

function slot1._onDrag(slot0, slot1, slot2)
	if not slot0:_canDrag() then
		return
	end

	if gohelper.isMouseOverGo(slot0._endTrans, slot2.position) then
		CommonDragHelper.instance:setGlobalEnabled(false)

		slot0._dragEnabled = false

		slot0:saveState(uv0.Clicked)
		slot0:_onStateClicked()
	end
end

function slot1._onEndDrag(slot0, slot1, slot2)
	if not slot0:_canDrag() then
		return
	end

	slot0:tweenAnchorPos(slot0._startTrans, slot0._startX, slot0._startY)
end

function slot1._onStateClicked(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_youyu_yure_cut_loop_20220227)
	slot0:playAnim_before_click(slot0._click_before_doneCb, slot0)
end

function slot1._click_before_doneCb(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_youyu_yure_cut_loop_20220229)

	slot0._needWaitCount = 2

	slot0:playAnim_before_out(slot0._onAfterDone, slot0)
	slot0:playAnim_after_in(slot0._onAfterDone, slot0)
end

function slot1._onAfterDone(slot0)
	slot0._needWaitCount = slot0._needWaitCount - 1

	if slot0._needWaitCount > 0 then
		return
	end

	slot0:saveStateDone(true)
	slot0:setActive_before(false)
	slot0:setActive_after(true)
	slot0:openDesc()
end

function slot1.setData(slot0)
	uv0.setData(slot0)

	slot1 = slot0:checkIsDone()

	slot0:setActive_before(not slot1)
	slot0:setActive_after(slot1)
	slot0:playAnimRaw_before_idle(0, 1)

	slot0._startAnimation.enabled = true

	if slot1 then
		slot0._dragEnabled = false
	elseif slot0:getState() == 0 then
		slot0._dragEnabled = true

		recthelper.setAnchor(slot0._startTrans, slot0._startX, slot0._startY)
	elseif uv1.Clicked == slot2 then
		slot0._dragEnabled = false

		slot0:_onStateClicked()
	else
		logError("[V2a2_WarmUpLeftView_Day5] invalid state:" .. slot2)
	end
end

return slot1
