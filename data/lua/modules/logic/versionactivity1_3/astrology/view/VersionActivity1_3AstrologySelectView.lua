module("modules.logic.versionactivity1_3.astrology.view.VersionActivity1_3AstrologySelectView", package.seeall)

slot0 = class("VersionActivity1_3AstrologySelectView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageDec1 = gohelper.findChildSingleImage(slot0.viewGO, "SelectStar/#simage_Dec1")
	slot0._simageDec2 = gohelper.findChildSingleImage(slot0.viewGO, "SelectStar/#simage_Dec2")
	slot0._scrollPlanetList = gohelper.findChildScrollRect(slot0.viewGO, "SelectStar/#scroll_PlanetList")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "SelectStar/#scroll_PlanetList/Viewport/#go_content")
	slot0._txtStarName = gohelper.findChildText(slot0.viewGO, "SelectStar/#txt_StarName")
	slot0._txtAdjustTimes = gohelper.findChildText(slot0.viewGO, "SelectStar/AdjustTimes/image_AdjustTimesBG/#txt_AdjustTimes")
	slot0._txtCurrentAngle = gohelper.findChildText(slot0.viewGO, "CurrentAngle/image_CurrentAngleBG/#txt_CurrentAngle")
	slot0._goBtns = gohelper.findChild(slot0.viewGO, "#go_Btns")
	slot0._goToGet = gohelper.findChild(slot0.viewGO, "#go_Btns/#go_ToGet")
	slot0._btnToGet = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_Btns/#go_ToGet/#btn_ToGet")
	slot0._txtToGetTips = gohelper.findChildText(slot0.viewGO, "#go_Btns/#go_ToGet/#txt_ToGetTips")
	slot0._goConfirm = gohelper.findChild(slot0.viewGO, "#go_Btns/#go_Confirm")
	slot0._btnConfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_Btns/#go_Confirm/#btn_Confirm")
	slot0._txtConfirmTips = gohelper.findChildText(slot0.viewGO, "#go_Btns/#go_Confirm/#txt_ConfirmTips")
	slot0._goTips = gohelper.findChild(slot0.viewGO, "#go_Btns/#go_Tips")
	slot0._txtTips = gohelper.findChildText(slot0.viewGO, "#go_Btns/#go_Tips/#txt_Tips")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnToGet:AddClickListener(slot0._btnToGetOnClick, slot0)
	slot0._btnConfirm:AddClickListener(slot0._btnConfirmOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnToGet:RemoveClickListener()
	slot0._btnConfirm:RemoveClickListener()
end

function slot0._btnToGetOnClick(slot0)
	JumpController.instance:jump(VersionActivity1_3DungeonEnum.JumpDaily)
end

function slot0._btnConfirmOnClick(slot0)
	slot0.viewContainer:sendUpdateProgressRequest()
end

function slot0._editableInitView(slot0)
	slot0._viewPortTrans = slot0._gocontent.transform.parent

	slot0:_addItems()
	slot0:addEventCb(VersionActivity1_3AstrologyController.instance, VersionActivity1_3AstrologyEvent.adjustPreviewAngle, slot0._adjustPreviewAngle, slot0)
	slot0:addEventCb(Activity126Controller.instance, Activity126Event.onUpdateProgressReply, slot0._onUpdateProgressReply, slot0)
	slot0:addEventCb(Activity126Controller.instance, Activity126Event.onGetHoroscopeReply, slot0._onGetHoroscopeReply, slot0)

	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._viewPortTrans.gameObject)

	slot0._drag:AddDragBeginListener(slot0._onDragBeginHandler, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEndHandler, slot0)
	slot0._drag:AddDragListener(slot0._onDrag, slot0)
end

function slot0._onDragBeginHandler(slot0, slot1, slot2)
	slot0._startDragPos = recthelper.screenPosToAnchorPos(slot2.position, slot0._viewPortTrans)
	slot0._selectedIndex = tabletool.indexOf(slot0._planetMoList, slot0._selectedItem:getPlanetMo())
end

function slot0._onDragEndHandler(slot0, slot1, slot2)
end

function slot0._onDrag(slot0, slot1, slot2)
	if not slot0._startDragPos then
		return
	end

	slot4 = recthelper.screenPosToAnchorPos(slot2.position, slot0._viewPortTrans) - slot0._startDragPos
	slot5 = math.floor(math.abs(slot4.x) / 120)

	if slot0._planetMoList[slot0._selectedIndex + (slot4.x > 0 and -slot5 or slot5)] then
		slot0:setSelected(slot0._itemList[slot7.id])
	end
end

function slot0._onGetHoroscopeReply(slot0)
end

function slot0._onUpdateProgressReply(slot0, slot1)
	if slot1 and slot1.fromReset then
		slot0:_sortAndSelectFirst()
		slot0:_refresh()
	else
		if not VersionActivity1_3AstrologyModel.instance:getStarReward() then
			slot0:_refresh()

			return
		end

		TaskDispatcher.cancelTask(slot0._refresh, slot0)
		TaskDispatcher.runDelay(slot0._refresh, slot0, 2.5)
	end
end

function slot0._refresh(slot0)
	slot0:updateItemNum()
	slot0:_updatePlanetItemInfo()
end

function slot0._adjustPreviewAngle(slot0)
	slot0:_updatePlanetItemInfo()
end

function slot0.onOpen(slot0)
end

function slot0._sortItems(slot0)
	table.sort(slot0._planetMoList, uv0._sort)

	for slot4, slot5 in ipairs(slot0._planetMoList) do
		gohelper.setAsLastSibling(slot0._itemList[slot5.id].viewGO)
	end
end

function slot0._sort(slot0, slot1)
	if slot0.num > 0 and slot1.num > 0 then
		return slot0.id < slot1.id
	elseif slot2 then
		return true
	elseif slot3 then
		return false
	end

	return slot0.id < slot1.id
end

function slot0._addItems(slot0)
	slot0._itemList = slot0:getUserDataTb_()
	slot0._planetMoList = {}

	for slot5 = VersionActivity1_3AstrologyEnum.Planet.shuixing, VersionActivity1_3AstrologyEnum.Planet.tuxing do
		slot7 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._gocontent), VersionActivity1_3AstrologyPlanetItem, {
			slot5,
			slot0
		})
		slot0._itemList[slot5] = slot7

		table.insert(slot0._planetMoList, slot7:getPlanetMo())
	end

	slot0:_sortAndSelectFirst()
end

function slot0._sortAndSelectFirst(slot0)
	slot0:_sortItems()
	slot0:setSelected(slot0._itemList[slot0._planetMoList[1].id])
end

function slot0.setSelected(slot0, slot1)
	if slot0._selectedItem == slot1 then
		return
	end

	slot0._selectedItem = slot1
	slot0._planetMo = slot0._selectedItem:getPlanetMo()
	slot0._txtStarName.text = slot0._planetMo:getItemName()

	for slot5, slot6 in pairs(slot0._itemList) do
		slot6:setSelected(slot6 == slot1)
	end

	ZProj.UGUIHelper.RebuildLayout(slot0._gocontent.transform)
	TaskDispatcher.cancelTask(slot0._focusItem, slot0)
	TaskDispatcher.runDelay(slot0._focusItem, slot0, 0)
	VersionActivity1_3AstrologyController.instance:dispatchEvent(VersionActivity1_3AstrologyEvent.selectPlanetItem, slot1)
	slot0:_updatePlanetItemInfo()
end

function slot0._focusItem(slot0)
	slot0:_clearTween()

	slot0._contentTweenId = ZProj.TweenHelper.DOAnchorPosX(slot0._gocontent.transform, -(recthelper.getAnchorX(slot0._selectedItem.viewGO.transform) - 470) - 42, 0.2)
end

function slot0._clearTween(slot0)
	if slot0._contentTweenId then
		ZProj.TweenHelper.KillById(slot0._contentTweenId)

		slot0._contentTweenId = nil
	end
end

function slot0.updateItemNum(slot0)
	for slot4, slot5 in pairs(slot0._itemList) do
		slot5:updateNum()
	end
end

function slot0._updatePlanetItemInfo(slot0)
	slot0:_updateNum(slot0._planetMo.num, slot0._planetMo:getRemainNum())
	slot0:_updateAngle(slot0._planetMo.previewAngle)

	slot6 = slot1 <= 0

	gohelper.setActive(slot0._goConfirm, false)
	gohelper.setActive(slot0._goTips, false)
	gohelper.setActive(slot0._goToGet, false)

	if Activity126Model.instance:getStarNum() >= 10 then
		if VersionActivity1_3AstrologyModel.instance:hasAdjust() then
			gohelper.setActive(slot0._goConfirm, true)

			slot0._txtConfirmTips.text = luaLang("astrology_tip6")

			return
		end

		if slot6 then
			gohelper.setActive(slot0._goToGet, true)

			slot0._txtToGetTips.text = luaLang("astrology_tip4")

			return
		end

		gohelper.setActive(slot0._goTips, true)

		slot0._txtTips.text = luaLang("astrology_tip5")
	else
		if slot5 then
			gohelper.setActive(slot0._goConfirm, true)

			slot0._txtConfirmTips.text = luaLang("astrology_tip3")

			return
		end

		if slot6 then
			gohelper.setActive(slot0._goToGet, true)

			slot0._txtToGetTips.text = luaLang("astrology_tip1")

			return
		end

		gohelper.setActive(slot0._goTips, true)

		slot0._txtTips.text = luaLang("astrology_tip2")
	end
end

function slot0._updateNum(slot0, slot1, slot2)
	if slot1 > 0 then
		if slot1 ~= slot2 then
			slot0._txtAdjustTimes.text = string.format("%s%s<color=#b73850>-%s</color>", luaLang("adjustNum"), slot1, slot1 - slot2)
		else
			slot0._txtAdjustTimes.text = string.format("%s%s", luaLang("adjustNum"), slot1)
		end
	else
		slot0._txtAdjustTimes.text = string.format("%s<color=#b73850>%s</color>", luaLang("adjustNum"), 0)
	end
end

function slot0._updateAngle(slot0, slot1)
	slot0._txtCurrentAngle.text = string.format("%s°", slot1 % 360)
end

function slot0.getSelectedPlanetId(slot0)
	for slot4, slot5 in pairs(slot0._itemList) do
		if slot5:isSelected() then
			return slot4
		end
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._focusItem, slot0)
	slot0:_clearTween()
	slot0._drag:RemoveDragBeginListener()
	slot0._drag:RemoveDragListener()
	slot0._drag:RemoveDragEndListener()
	TaskDispatcher.cancelTask(slot0._refresh, slot0)
end

return slot0
