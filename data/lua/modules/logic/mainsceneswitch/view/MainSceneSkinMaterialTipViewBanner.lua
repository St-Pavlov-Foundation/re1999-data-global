module("modules.logic.mainsceneswitch.view.MainSceneSkinMaterialTipViewBanner", package.seeall)

slot0 = class("MainSceneSkinMaterialTipViewBanner", BaseView)

function slot0.onInitView(slot0)
	slot0._gobannerContent = gohelper.findChild(slot0.viewGO, "left/banner/#go_bannerContent")
	slot0._goroominfoItem = gohelper.findChild(slot0.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem")
	slot0._goslider = gohelper.findChild(slot0.viewGO, "left/banner/#go_slider")
	slot0._gobannerscroll = gohelper.findChild(slot0.viewGO, "left/banner/#go_bannerscroll")
	slot0._gobannerSelectItem = gohelper.findChild(slot0.viewGO, "left/banner/#go_slider/go_bannerSelectItem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._bannerscroll:AddDragBeginListener(slot0._onScrollDragBegin, slot0)
	slot0._bannerscroll:AddDragEndListener(slot0._onScrollDragEnd, slot0)
end

function slot0.removeEvents(slot0)
	slot0._bannerscroll:RemoveDragBeginListener()
	slot0._bannerscroll:RemoveDragEndListener()
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gojumpItem, false)

	slot0._bannerscroll = SLFramework.UGUI.UIDragListener.Get(slot0._gobannerscroll)
	slot0._infoItemTbList = slot0:getUserDataTb_()
	slot0._infoItemDataList = slot0:getUserDataTb_()
	slot0._pageItemTbList = slot0:getUserDataTb_()

	slot0:_createInfoItemUserDataTb_(slot0._goroominfoItem)
	slot0:_createPageItemUserDataTb_(slot0._gobannerSelectItem)
	transformhelper.setLocalPosXY(slot0._gobannerContent.transform, -1, 0)
end

function slot0._getMaxPage(slot0)
	return slot0._infoItemDataList and #slot0._infoItemDataList or 0
end

function slot0._checkCurPage(slot0)
	if not slot0._curPage or slot0:_getMaxPage() < slot0._curPage then
		slot0._curPage = 1
	end

	if slot0._curPage < 1 then
		slot0._curPage = slot1
	end

	return slot0._curPage
end

function slot0._isFirstPage(slot0)
	return slot0:_checkCurPage() <= 1
end

function slot0._isLastPage(slot0)
	return slot0:_getMaxPage() <= slot0:_checkCurPage()
end

function slot0._getItemDataList(slot0)
	slot1 = {}

	table.insert(slot1, {
		itemId = slot0.viewParam.id,
		itemType = slot0.viewParam.type
	})

	return slot1
end

function slot0._onScrollDragBegin(slot0, slot1, slot2)
	slot0._scrollStartPosX = GamepadController.instance:getMousePosition().x
end

function slot0._onScrollDragEnd(slot0, slot1, slot2)
	if GamepadController.instance:getMousePosition().x - slot0._scrollStartPosX > 80 then
		slot0:_runSwithPage(true)
	elseif slot4 < -80 then
		slot0:_runSwithPage(false)
	end
end

function slot0._startAutoSwitch(slot0)
	TaskDispatcher.cancelTask(slot0._onSwitch, slot0)

	if slot0:_getMaxPage() > 1 then
		TaskDispatcher.runRepeat(slot0._onSwitch, slot0, 3)
	end
end

function slot0._onSwitch(slot0)
	if slot0:_getMaxPage() <= 1 then
		TaskDispatcher.cancelTask(slot0._onSwitch, slot0)

		return
	end

	if not slot0._nextRunSwitchTime or slot0._nextRunSwitchTime <= Time.time then
		slot0:_runSwithPage(false)
	end
end

function slot0._runSwithPage(slot0, slot1)
	slot0._nextRunSwitchTime = Time.time + 2
	slot3 = false

	if slot1 then
		slot3 = slot0:_isFirstPage()
		slot0._curPage = slot0:_checkCurPage() - 1
	else
		slot3 = slot0:_isLastPage()
		slot0._curPage = slot2 + 1
	end

	if slot3 and slot0:_getMaxPage() > 2 then
		recthelper.setAnchorX(slot0._gobannerContent.transform, -slot0:_getPosXByPage(slot1 and slot0:_getMaxPage() - 1 or 2))
	end

	if slot2 == slot0:_checkCurPage() then
		return
	end

	slot0:_refreshUI()
end

function slot0._refreshUI(slot0)
	slot0:_refreshPageUI()
	slot0:_refreshInfoUI()
end

function slot0._refreshPageUI(slot0)
	gohelper.setActive(slot0._goslider, slot0:_getMaxPage() > 1)

	for slot6 = 1, slot1 do
		slot7 = slot0._pageItemTbList[slot6] or slot0:_createPageItemUserDataTb_(gohelper.clone(slot0._gobannerSelectItem, slot0._goslider, "go_bannerSelectItem" .. slot6))

		slot0:_updatePageItemUI(slot7, slot6 == slot0:_checkCurPage())
		gohelper.setActive(slot7._go, true)
	end

	for slot6 = slot1 + 1, #slot0._pageItemTbList do
		gohelper.setActive(slot0._pageItemTbList[slot6]._go, false)
	end
end

function slot0._refreshInfoUI(slot0)
	slot2 = slot0:_checkCurPage()

	for slot7 = #slot0._infoItemTbList + 1, math.min(3, slot0:_getMaxPage()) do
		slot0:_createInfoItemUserDataTb_(gohelper.clone(slot0._goroominfoItem, slot0._gobannerContent, "go_bannerSelectItem" .. slot7))
	end

	slot4 = 0

	for slot8 = 1, #slot0._infoItemTbList do
		slot0:_refreshInfoItem(slot8, ((slot1 < #slot0._infoItemTbList or slot0:_isFirstPage()) and 0 or slot0:_isLastPage() and slot1 - 3 or slot2 - 2) + slot8)
	end

	if slot1 > 0 then
		ZProj.TweenHelper.DOAnchorPosX(slot0._gobannerContent.transform, -slot0:_getPosXByPage(slot2), 0.75)
	end
end

function slot0._refreshInfoItem(slot0, slot1, slot2)
	slot4 = slot0._infoItemTbList[slot1]

	if slot0._infoItemDataList[slot2] then
		slot0:_updateInfoItemUI(slot4, slot3.itemId, slot3.itemType)
		transformhelper.setLocalPosXY(slot4._go.transform, slot0:_getPosXByPage(slot2), 0)
	end

	if slot4 then
		gohelper.setActive(slot4._go, slot3 and true or false)
	end
end

function slot0._getPosXByPage(slot0, slot1)
	return (slot1 - 1) * 1030
end

function slot0._createPageItemUserDataTb_(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2._go = slot1
	slot2._gonomalstar = gohelper.findChild(slot1, "go_nomalstar")
	slot2._golightstar = gohelper.findChild(slot1, "go_lightstar")

	table.insert(slot0._pageItemTbList, slot2)

	return slot2
end

function slot0._updatePageItemUI(slot0, slot1, slot2)
	slot3 = slot1

	gohelper.setActive(slot3._gonomalstar, not slot2)
	gohelper.setActive(slot3._golightstar, slot2)
end

function slot0._createInfoItemUserDataTb_(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2._go = slot1
	slot2._gotag = gohelper.findChild(slot1, "#go_tag")
	slot2._txtdesc = gohelper.findChildText(slot1, "txt_desc")
	slot2._txtname = gohelper.findChildText(slot1, "txt_desc/txt_name")
	slot2._simageinfobg = gohelper.findChildSingleImage(slot1, "#simage_pic")
	slot2._btn = gohelper.findChildButtonWithAudio(slot1, "txt_desc/txt_name/#btn_Info")

	slot2._btn:AddClickListener(function ()
		if not uv0._sceneSkinId then
			return
		end

		ViewMgr.instance:openView(ViewName.MainSceneSwitchInfoView, {
			isPreview = true,
			noInfoEffect = true,
			sceneSkinId = uv0._sceneSkinId
		})
	end, slot2)

	slot0._infoItemTbList = slot0._infoItemTbList or {}

	table.insert(slot0._infoItemTbList, slot2)

	return slot2
end

function slot0._updateInfoItemUI(slot0, slot1, slot2, slot3)
	slot4 = slot1
	slot5 = ItemModel.instance:getItemConfig(slot3, slot2)
	slot4._txtdesc.text = slot5.desc
	slot4._txtname.text = slot5.name

	gohelper.setActive(slot4._gotag, true)

	slot6 = MainSceneSwitchConfig.instance:getConfigByItemId(slot2)
	slot4._sceneSkinId = slot6.id

	slot4._simageinfobg:LoadImage(ResUrl.getMainSceneSwitchIcon(slot6.previewIcon))
end

function slot0.onUpdateParam(slot0)
	slot0._infoItemDataList = {}

	tabletool.addValues(slot0._infoItemDataList, slot0:_getItemDataList())
	slot0:_refreshUI()
	slot0:_startAutoSwitch()
end

function slot0.onOpen(slot0)
	slot0._infoItemDataList = {}

	tabletool.addValues(slot0._infoItemDataList, slot0:_getItemDataList())
	slot0:_refreshUI()
	slot0:_startAutoSwitch()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._onSwitch, slot0)

	for slot4, slot5 in ipairs(slot0._infoItemTbList) do
		slot5._simageinfobg:UnLoadImage()
		slot5._btn:RemoveClickListener()
	end
end

return slot0
