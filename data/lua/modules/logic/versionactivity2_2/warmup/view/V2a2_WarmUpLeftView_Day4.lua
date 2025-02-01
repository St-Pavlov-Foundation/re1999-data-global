module("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_Day4", package.seeall)

slot1 = class("V2a2_WarmUpLeftView_Day4", require("modules.logic.versionactivity2_2.warmup.view.V2a2_WarmUpLeftView_DayBase"))

function slot1.onInitView(slot0)
	slot0._simageicon1 = gohelper.findChildSingleImage(slot0.viewGO, "before/#simage_icon1")
	slot0._btn1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "before/#btn_1")
	slot0._btn2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "before/#btn_2")
	slot0._btn3 = gohelper.findChildButtonWithAudio(slot0.viewGO, "before/#btn_3")
	slot0._simageicon2 = gohelper.findChildSingleImage(slot0.viewGO, "after/#simage_icon2")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot1.addEvents(slot0)
	slot0._btn1:AddClickListener(slot0._btn1OnClick, slot0)
	slot0._btn2:AddClickListener(slot0._btn2OnClick, slot0)
	slot0._btn3:AddClickListener(slot0._btn3OnClick, slot0)
end

function slot1.removeEvents(slot0)
	slot0._btn1:RemoveClickListener()
	slot0._btn2:RemoveClickListener()
	slot0._btn3:RemoveClickListener()
end

slot2 = SLFramework.AnimatorPlayer

function slot3(slot0)
	for slot5, slot6 in ipairs(slot0) do
		slot1 = (slot6 and "1" or "0") .. ""
	end

	return "_" .. slot1
end

slot4 = {}
slot5 = 0

function slot6(...)
	slot0 = {
		...
	}

	tabletool.revert(slot0)

	uv1[uv0(slot0)] = uv2
	uv2 = uv2 + 1
end

slot7 = false
slot8 = true

slot6(slot7, slot7, slot7)
slot6(slot7, slot7, slot8)
slot6(slot7, slot8, slot7)
slot6(slot7, slot8, slot8)
slot6(slot8, slot7, slot7)
slot6(slot8, slot7, slot8)
slot6(slot8, slot8, slot7)
slot6(slot8, slot8, slot8)

function slot1._btn1OnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_home_role_put_20220223)
end

function slot1._btn2OnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_home_role_put_20220223)
end

function slot1._btn3OnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_home_role_put_20220223)
end

function slot1.ctor(slot0, slot1)
	uv0.ctor(slot0, slot1)

	slot0._context = {
		needWaitCount = 0,
		dragEnabled = false
	}
end

function slot1._editableInitView(slot0)
	uv0._editableInitView(slot0)

	slot0._guideGo = gohelper.findChild(slot0.viewGO, "guide_day4")
	slot0._startDefaultPosList = {}
	slot0._startGoList = slot0:getUserDataTb_()
	slot0._endGoList = slot0:getUserDataTb_()
	slot0._startTransList = slot0:getUserDataTb_()
	slot0._endTransList = slot0:getUserDataTb_()
	slot0._startAnimPlayerList = slot0:getUserDataTb_()

	for slot4 = 1, 3 do
		slot5 = gohelper.findChild(slot0.viewGO, "before/btn_highlight_" .. slot4)
		slot6 = gohelper.findChild(slot0.viewGO, "before/#btn_" .. slot4)
		slot8 = slot6.transform
		slot9, slot10 = recthelper.getAnchor(slot8)

		table.insert(slot0._startDefaultPosList, {
			x = slot9,
			y = slot10
		})
		table.insert(slot0._startGoList, slot6)
		table.insert(slot0._endGoList, slot5)
		table.insert(slot0._startTransList, slot8)
		table.insert(slot0._endTransList, slot5.transform)
		table.insert(slot0._startAnimPlayerList, uv1.Get(slot6))
		CommonDragHelper.instance:registerDragObj(slot6, slot0._onBeginDrag, nil, slot0._onEndDrag, slot0._checkCanDrag, slot0, slot4)
	end
end

slot9 = -313

function slot1._checkCanDrag(slot0)
	slot1 = not slot0:_canDrag()

	if slot0:_isDone3() and slot1 then
		GameFacade.showToast(uv0)
	end

	return slot1
end

function slot1._canDrag(slot0)
	return slot0._context.dragEnabled
end

function slot1._setDragEnabled(slot0, slot1)
	slot0._context.dragEnabled = slot1
end

function slot1._setActive_anim(slot0, slot1)
	slot0._anim_before.enabled = slot1
end

function slot1._onBeginDrag(slot0, slot1, slot2)
	if not slot0:_canDrag() then
		return
	end

	slot0:_setActive_anim(false)
	uv0._onDragBegin(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_home_role_put_20220223)
end

function slot1._onEndDrag(slot0, slot1, slot2)
	if not slot0:_canDrag() then
		return
	end

	slot0._context.lastDragIndex = slot1

	slot0:_setNeedWait(1)
	slot0:setPosToEnd(slot0._endTransList[slot1], slot0._startTransList[slot1], true, nil, slot0._setPostEndTweeen_doneCb, slot0)
end

function slot1._setNeedWait(slot0, slot1)
	slot0._context.needWaitCount = assert(tonumber(slot1))
	slot0._context.dragEnabled = false
end

function slot1._subNeedWait(slot0)
	slot0._context.needWaitCount = slot0._context.needWaitCount - 1
	slot1 = slot0._context.needWaitCount > 0
	slot0._context.dragEnabled = not slot1

	return slot1
end

function slot1._saveState(slot0, slot1)
	if slot0:_getLastState()[slot1] == true then
		return
	end

	slot2[slot1] = true

	slot0:saveState(slot0:_getState(slot2))
end

function slot1._getState(slot0, slot1)
	return uv1[uv0(slot1 or slot0:_getLastState())]
end

function slot1._setPostEndTweeen_doneCb(slot0)
	if slot0:_subNeedWait() then
		return
	end

	slot1 = slot0._context.lastDragIndex

	slot0:_saveState(slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_home_door_effect_put_20220224)
	slot0:_onPutState(slot1, slot0._onPut_doneCb, slot0)
end

function slot1._onPutState(slot0, slot1, slot2, slot3)
	function slot5(slot0)
		gohelper.setActive(slot0._endGoList[uv0], false)

		if uv1 then
			uv1(uv2)
		end
	end

	if not slot0._startAnimPlayerList[slot1].isActiveAndEnabled then
		slot5(slot0)

		return
	end

	slot4:Play("put", slot5, slot0)
end

function slot1._isDone3(slot0)
	return slot0:_getState() == uv0._111
end

function slot1._onPut_doneCb(slot0)
	if slot0:_subNeedWait() then
		return
	end

	if slot0:_isDone3() and not slot0:isFinishInteractive() then
		slot0:markIsFinishedInteractive(true)
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_youyu_yure_release_20220225)
		slot0:_setDragEnabled(false)
		slot0:_setNeedWait(2)
		slot0:playAnim_before_out(slot0._onAfterDone, slot0)
		slot0:playAnim_after_in(slot0._onAfterDone, slot0)
	end
end

function slot1._onAfterDone(slot0)
	if slot0:_subNeedWait() then
		return
	end

	slot0:saveStateDone(true)
	slot0:setActive_before(false)
	slot0:setActive_after(true)
	slot0:openDesc()
end

function slot1.onDestroyView(slot0)
	uv0.onDestroyView(slot0)

	for slot4, slot5 in ipairs(slot0._startGoList) do
		CommonDragHelper.instance:unregisterDragObj(slot5)
	end
end

function slot1._getLastState(slot0)
	if slot0:checkIsDone() then
		slot0._lastState = {
			uv0,
			uv0,
			uv0
		}

		return slot0._lastState, slot1
	end

	if not slot0._lastState then
		slot0._lastState = {
			uv1,
			uv1,
			uv1
		}

		if uv2._001 == slot0:getState(uv2._000) or uv2._011 == slot2 or uv2._101 == slot2 or uv2._111 == slot2 then
			slot0._lastState[1] = true
		end

		if uv2._010 == slot2 or uv2._011 == slot2 or uv2._110 == slot2 or uv2._111 == slot2 then
			slot0._lastState[2] = true
		end

		if uv2._100 == slot2 or uv2._101 == slot2 or uv2._110 == slot2 or uv2._111 == slot2 then
			slot0._lastState[3] = true
		end
	end

	return slot0._lastState, slot1
end

function slot1._setPosToDefault(slot0, slot1, slot2)
	slot4 = slot0._startDefaultPosList[slot1]

	if slot2 then
		slot0:tweenAnchorPos(slot0._startTransList[slot1], slot4.x, slot4.y)
	else
		recthelper.setAnchor(slot3, slot4.x, slot4.y)
	end
end

function slot1.setData(slot0)
	uv0.setData(slot0)

	slot1, slot2 = slot0:_getLastState()

	slot0:setActive_before(not slot2)
	slot0:setActive_after(slot2)
	slot0:_setDragEnabled(not slot2)

	if not slot2 then
		for slot7, slot8 in ipairs(slot1) do
			gohelper.setActive(slot0._startGoList[slot7], true)
			gohelper.setActive(slot0._endGoList[slot7], not slot8)

			if slot8 then
				slot3 = 0 + 1

				slot0:setPosToEnd(slot0._endTransList[slot7], slot0._startTransList[slot7])
			else
				slot0:_setPosToDefault(slot7)
			end
		end

		if slot3 > 0 and slot3 == #slot1 then
			slot0:_setActive_anim(true)

			slot8 = 1

			slot0:playAnimRaw_before_idle(0, slot8)
			slot0:_setNeedWait(3)

			for slot8, slot9 in ipairs(slot1) do
				slot0:_onPutState(slot8, slot0._onPut_doneCb, slot0)
			end

			slot0:_setDragEnabled(false)
		end
	end
end

return slot1
