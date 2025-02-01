module("modules.logic.weekwalk.view.WeekWalkLayerPage", package.seeall)

slot0 = class("WeekWalkLayerPage", BaseChildView)

function slot0.onInitView(slot0)
	slot0._simagebgimg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bgimg")
	slot0._simageline = gohelper.findChildSingleImage(slot0.viewGO, "#simage_line")
	slot0._scrollview = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_view")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#scroll_view/Viewport/#go_content")
	slot0._gopos5 = gohelper.findChild(slot0.viewGO, "#scroll_view/Viewport/#go_content/#go_pos5")
	slot0._gopos3 = gohelper.findChild(slot0.viewGO, "#scroll_view/Viewport/#go_content/#go_pos3")
	slot0._gotopblock = gohelper.findChild(slot0.viewGO, "#go_topblock")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._scrollview:AddOnValueChanged(slot0._setEdgFadeStrengthen, slot0)
end

function slot0.removeEvents(slot0)
	slot0._scrollview:RemoveOnValueChanged()
end

function slot0._editableInitView(slot0)
	slot0._simageline:LoadImage(ResUrl.getWeekWalkBg("hw2.png"))

	slot0._animatorPlayer = SLFramework.AnimatorPlayer.Get(slot0.viewGO)
	slot0._bgAnimation = slot0._simagebgimg.gameObject:GetComponent(typeof(UnityEngine.Animation))
end

function slot0.removeScrollDragListener(slot0, slot1)
	slot1:RemoveDragBeginListener()
	slot1:RemoveDragEndListener()
	slot1:RemoveDragListener()
end

function slot0.initScrollDragListener(slot0, slot1, slot2)
	slot1:AddDragBeginListener(slot0._onDragBegin, slot0, slot2)
	slot1:AddDragListener(slot0._onDrag, slot0, slot2)
	slot1:AddDragEndListener(slot0._onDragEnd, slot0, slot2)
end

function slot0._onScrollValueChanged(slot0, slot1, slot2)
	if not slot0._curScroll then
		return
	end

	slot3 = slot0._curScroll.horizontalNormalizedPosition

	if slot0._curNormalizedPos and slot3 >= 0 and slot3 <= 1 and slot0._cellCenterPos <= math.abs(slot3 - slot0._curNormalizedPos) then
		if slot4 > 0 then
			slot0._curNormalizedPos = slot0._curNormalizedPos + slot0._cellCenterPos
		else
			slot0._curNormalizedPos = slot0._curNormalizedPos - slot0._cellCenterPos
		end

		slot0._curNormalizedPos = slot3

		if slot4 <= -slot0._cellCenterPos and slot3 <= 0 then
			return
		end

		AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_slip)
	end
end

function slot0._onDragBegin(slot0, slot1, slot2)
	slot0._beginDragScrollNormalizePos = slot1.horizontalNormalizedPosition
	slot0._beginDrag = true

	slot0:initNormalizePos(slot1)
	AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_slipmap)
end

function slot0.initNormalizePos(slot0, slot1)
	slot2 = recthelper.getWidth(slot1.content)
	slot3 = recthelper.getWidth(slot1.transform)

	if slot1.content.childCount == 0 then
		return
	end

	if slot2 - slot3 > 0 then
		slot0._cellCenterPos = 1 / (slot8 / recthelper.getWidth(slot4:GetChild(slot5 - 1))) / 3
		slot0._curNormalizedPos = slot1.horizontalNormalizedPosition

		if slot0._curScroll then
			slot0._curScroll = nil
		end

		slot0._curScroll = slot1
	else
		slot0._curNormalizedPos = nil
	end
end

function slot0._onDrag(slot0, slot1, slot2)
	if slot0._beginDrag then
		slot0._beginDrag = false

		return
	end

	slot3 = slot2.delta.x
	slot4 = slot1.horizontalNormalizedPosition

	if slot0._beginDragScrollNormalizePos then
		slot0._beginDragScrollNormalizePos = nil
	end
end

function slot0._onDragEnd(slot0, slot1, slot2)
	slot0._beginDrag = false
	slot0._beginDragScrollNormalizePos = nil
end

function slot0.playAnim(slot0, slot1)
	if not slot0._animatorPlayer then
		return
	end

	slot0._animName = slot1

	slot0._animatorPlayer:Play(slot1, slot0._animDone, slot0)
	gohelper.setActive(slot0._gotopblock, true)
	TaskDispatcher.cancelTask(slot0._hideBlock, slot0)
	TaskDispatcher.runDelay(slot0._hideBlock, slot0, 0.5)
end

function slot0._hideBlock(slot0)
	gohelper.setActive(slot0._gotopblock, false)
end

function slot0.playBgAnim(slot0, slot1)
	slot0._bgAnimation:Play(slot1)
end

function slot0._animDone(slot0)
	if slot0._animName == "weekwalklayerpage_in" then
		slot0:_changeRightBtnVisible()
	end

	if slot0._visible then
		for slot4, slot5 in ipairs(slot0._itemList) do
			slot5:updateUnlockStatus()
		end
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.setVisible(slot0, slot1)
	slot0._visible = slot1
end

function slot0.getVisible(slot0)
	return slot0._visible
end

function slot0.resetPos(slot0, slot1)
	if slot1 then
		for slot5, slot6 in ipairs(slot0._layerList) do
			if slot6.id == slot1 then
				slot0:focusPos(slot5)

				return
			end
		end
	end

	for slot5, slot6 in ipairs(slot0._layerList) do
		if WeekWalkModel.instance:getMapInfo(slot6.id) and slot7.isFinish <= 0 then
			slot0:focusPos(slot5)

			return
		end

		if not slot7 and slot5 == 1 then
			slot0._scrollview.horizontalNormalizedPosition = 0

			return
		end
	end

	for slot5, slot6 in ipairs(slot0._layerList) do
		if WeekWalkModel.instance:getMapInfo(slot6.id) then
			slot8, slot9 = slot7:getStarInfo()

			if slot8 ~= slot9 then
				slot0:focusPos(slot5)

				return
			end
		end
	end

	slot0._scrollview.horizontalNormalizedPosition = 1
end

function slot0.focusPos(slot0, slot1)
	if not slot0._itemList[slot1] then
		return
	end

	recthelper.setAnchorX(slot0._gocontent.transform, -slot2._relativeAnchorPos.x + 300)
end

function slot0.onOpen(slot0)
	slot0._layerView = slot0.viewParam[1]
	slot0._pageIndex = slot0.viewParam[2]
	slot0._layerList = slot0.viewParam[3]
	slot0._itemList = slot0:getUserDataTb_()

	slot0:_addItems()

	if WeekWalkLayerView.isShallowPage(slot0._pageIndex) then
		if slot0._pageIndex <= 1 then
			slot0._simagebgimg:LoadImage(ResUrl.getWeekWalkLayerIcon("full/bg_choose_shallow_1"))
		else
			slot0._simagebgimg:LoadImage(ResUrl.getWeekWalkLayerIcon("full/bg_choose_shallow_2"))
		end
	else
		slot0._simagebgimg:LoadImage(ResUrl.getWeekWalkLayerIcon("full/bg_choose_deep"))
	end

	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._scrollview.gameObject)

	slot0:initScrollDragListener(slot0._drag, slot0._scrollview)
	gohelper.setActive(slot0._goshallowicon, WeekWalkLayerView.isShallowPage(slot0._pageIndex))
	gohelper.setActive(slot0._godeepicon, not WeekWalkLayerView.isShallowPage(slot0._pageIndex))
	slot0:_setEdgFadeStrengthen()
end

function slot0._addItems(slot0)
	gohelper.setActive(slot0._gopos3, false)
	gohelper.setActive(slot0._gopos5, false)

	slot2 = #slot0._layerList == 6 and slot0._gopos3 or slot0._gopos5

	gohelper.setActive(slot2, true)

	for slot7, slot8 in ipairs(slot0._layerList) do
		slot0:_addItem(slot2.transform:GetChild(slot7 - 1).gameObject, slot8)
	end

	if slot1 then
		recthelper.setWidth(slot0._gocontent.transform, 3400)
	end
end

function slot0._addItem(slot0, slot1, slot2)
	slot4 = slot0._layerView.viewContainer:getResInst(slot0._layerView.viewContainer:getSetting().otherRes[2], slot1)
	slot4.name = "weekwalklayerpageitem" .. slot2.layer
	slot5 = MonoHelper.addLuaComOnceToGo(slot4, WeekWalkLayerPageItem, {
		slot2,
		slot0._pageIndex,
		slot0
	})
	slot5._relativeAnchorPos = recthelper.rectToRelativeAnchorPos(slot4.transform.position, slot0._gocontent.transform)

	table.insert(slot0._itemList, slot5)
end

function slot0._setEdgFadeStrengthen(slot0, slot1, slot2)
	if slot0._scrollview.horizontalNormalizedPosition < 0.01 then
		slot0._scrollview.horizontalNormalizedPosition = 0
	end

	WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnScrollPage, Mathf.Clamp(Mathf.Abs(slot0._scrollview.horizontalNormalizedPosition * 8), 0, 1), slot0._pageIndex)
	slot0:_changeRightBtnVisible()
	slot0:_onScrollValueChanged(slot1, slot2)
end

function slot0._changeRightBtnVisible(slot0)
	if not WeekWalkLayerView.isShallowPage(slot0._pageIndex) or not slot0._visible or not slot0._scrollview then
		return
	end

	if slot0._scrollview.horizontalNormalizedPosition >= 0.95 then
		slot0._showRightBtn = true

		WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnChangeRightBtnVisible, slot0._showRightBtn)
	elseif slot1 <= 0.5 and slot0._showRightBtn then
		slot0._showRightBtn = false

		WeekWalkController.instance:dispatchEvent(WeekWalkEvent.OnChangeRightBtnVisible, slot0._showRightBtn)
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._hideBlock, slot0)
	slot0._animatorPlayer:Stop()

	if slot0._drag then
		slot0:removeScrollDragListener(slot0._drag)
	end

	for slot4, slot5 in ipairs(slot0._itemList) do
		slot5:onDestroy()
	end
end

function slot0.onDestroyView(slot0)
	slot0._simagebgimg:UnLoadImage()
	slot0._simageline:UnLoadImage()
end

return slot0
