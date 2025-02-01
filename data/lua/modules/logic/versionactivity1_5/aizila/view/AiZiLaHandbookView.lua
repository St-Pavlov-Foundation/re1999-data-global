module("modules.logic.versionactivity1_5.aizila.view.AiZiLaHandbookView", package.seeall)

slot0 = class("AiZiLaHandbookView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagePanelBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_PanelBG")
	slot0._txtItemNum = gohelper.findChildText(slot0.viewGO, "Left/ItemNum/#txt_ItemNum")
	slot0._imageItemIcon = gohelper.findChildImage(slot0.viewGO, "Left/#image_ItemIcon")
	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "Left/#txt_Title")
	slot0._txtDescr = gohelper.findChildText(slot0.viewGO, "Left/#scrollview/view/#txt_Descr")
	slot0._goUnCollect = gohelper.findChild(slot0.viewGO, "Left/#go_UnCollect")
	slot0._scrollItems = gohelper.findChildScrollRect(slot0.viewGO, "Right/#scroll_Items")
	slot0._goBackBtns = gohelper.findChild(slot0.viewGO, "#go_BackBtns")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._goLeft = gohelper.findChild(slot0.viewGO, "Left")
	slot0._animatorLeft = slot0._goLeft:GetComponent(AiZiLaEnum.ComponentType.Animator)
	slot0._animator = slot0.viewGO:GetComponent(AiZiLaEnum.ComponentType.Animator)
	slot0._singleItemIcon = gohelper.findChildSingleImage(slot0.viewGO, "Left/#image_ItemIcon")
	slot0._unCollectHideList = slot0:getUserDataTb_()
	slot0._grayGoList = slot0:getUserDataTb_()

	for slot5, slot6 in ipairs({
		"ItemNum",
		"image_TitleLIne",
		"#scrollview/view/#txt_Descr"
	}) do
		table.insert(slot0._unCollectHideList, gohelper.findChild(slot0._goLeft, slot6))
	end

	slot4 = {}

	RoomHelper.cArrayToLuaTable(gohelper.findChild(slot0.viewGO, "Left/ItemBG"):GetComponentsInChildren(gohelper.Type_Image, true), slot4)

	for slot8, slot9 in ipairs(slot4) do
		table.insert(slot0._grayGoList, slot9.gameObject)
	end

	table.insert(slot0._grayGoList, slot0._imageItemIcon.gameObject)
end

function slot0.onUpdateParam(slot0)
end

function slot0.playViewAnimator(slot0, slot1)
	if slot0._animator then
		slot0._animator:Play(slot1, 0, 0)
	end
end

function slot0.onOpen(slot0)
	if slot0.viewContainer then
		NavigateMgr.instance:addEscape(slot0.viewContainer.viewName, slot0.closeThis, slot0)
	end

	slot1 = AiZiLaHandbookListModel.instance

	slot1:init()

	if slot1:getByIndex(1) then
		slot1:setSelect(slot2.id)
	end

	slot0:addEventCb(AiZiLaController.instance, AiZiLaEvent.SelectItem, slot0._onSelectItem, slot0)
	slot0:refreshUI()
	AiZiLaModel.instance:finishItemRed()
	AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.play_ui_wulu_aizila_forward_paper3)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._onDelayRefreshUI, slot0)
	slot0._singleItemIcon:UnLoadImage()
end

function slot0._onSelectItem(slot0)
	if slot0._animatorLeft then
		if not slot0._isPlayLeftAnimIng then
			slot0._isPlayLeftAnimIng = true

			slot0._animatorLeft:Play(UIAnimationName.Switch, 0, 0)
			TaskDispatcher.runDelay(slot0._onDelayRefreshUI, slot0, 0.4)
		end
	else
		slot0:refreshUI()
	end
end

function slot0._onDelayRefreshUI(slot0)
	slot0._isPlayLeftAnimIng = false

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot1 = AiZiLaHandbookListModel.instance:getSelectMO()

	gohelper.setActive(slot0._goLeft, slot1)

	if slot1 then
		if slot0._lastQuantity ~= slot1:getQuantity() then
			slot0._lastQuantity = slot2
			slot0._txtItemNum.text = formatLuaLang("materialtipview_itemquantity", slot2)
		end

		if slot0._lastItemId ~= slot1.itemId then
			slot0._lastItemId = slot1.itemId

			slot0._singleItemIcon:LoadImage(ResUrl.getV1a5AiZiLaItemIcon(slot1:getConfig().icon))

			slot0._txtTitle.text = string.format(AiZiLaModel.instance:isCollectItemId(slot0._lastItemId) and "%s" or "<color=#524D46>%s</color>", slot4.name)
			slot0._txtDescr.text = slot4.desc

			slot0:_refreshGray(not slot3)
		end
	end
end

function slot0._refreshGray(slot0, slot1)
	if slot0._lastGray ~= (slot1 and true or false) then
		for slot6, slot7 in ipairs(slot0._grayGoList) do
			slot0:_setGrayMode(slot7, slot1)
		end

		for slot6, slot7 in ipairs(slot0._unCollectHideList) do
			gohelper.setActive(slot7, not slot1)
		end

		gohelper.setActive(slot0._goUnCollect, slot1)
	end
end

function slot0._setGrayMode(slot0, slot1, slot2)
	if slot2 then
		ZProj.UGUIHelper.SetGrayFactor(slot1, 0.8)
	else
		ZProj.UGUIHelper.SetGrayscale(slot1, false)
	end
end

return slot0
