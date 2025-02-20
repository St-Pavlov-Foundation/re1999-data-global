module("modules.logic.room.view.manufacture.RoomCritterRestTipsView", package.seeall)

slot0 = class("RoomCritterRestTipsView", BaseView)
slot1 = 43

function slot0.onInitView(slot0)
	slot0._simagerestarea = gohelper.findChildSingleImage(slot0.viewGO, "root/info/#simage_restarea")
	slot0._txtnamecn = gohelper.findChildText(slot0.viewGO, "root/info/#txt_namecn")
	slot0._txtnameen = gohelper.findChildText(slot0.viewGO, "root/info/#txt_namecn/#txt_nameen")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "root/info/#txt_namecn/#image_icon")
	slot0._gocostitem = gohelper.findChild(slot0.viewGO, "root/costs/content/#go_costitem")
	slot0._btnbuild = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_build")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnbuild:AddClickListener(slot0._btnbuildOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._onItemChanged, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onItemChanged, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterUnlockSeatSlot, slot0.closeThis, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnbuild:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	slot0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._onItemChanged, slot0)
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onItemChanged, slot0)
	slot0:removeEventCb(CritterController.instance, CritterEvent.CritterUnlockSeatSlot, slot0.closeThis, slot0)
end

function slot0._btnbuildOnClick(slot0)
	if not slot0._isCanUpgrade then
		GameFacade.showToast(ToastEnum.RoomNotEnoughMatBuySeatSlot)

		return
	end

	CritterController.instance:buySeatSlot(slot0.buildingUid, slot0.seatSlotId)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._onItemChanged(slot0)
	slot0:refreshCost()
end

function slot0._editableInitView(slot0)
	slot0._simagerestarea:LoadImage(ResUrl.getRoomCritterIcon("room_rest_area_1"))

	slot0._costItemList = {}
end

function slot0.onUpdateParam(slot0)
	slot0.buildingUid = slot0.viewParam.buildingUid
	slot0.seatSlotId = slot0.viewParam.seatSlotId
end

function slot0.onOpen(slot0)
	slot0:onUpdateParam()
	slot0:refreshBuildingInfo()
	slot0:refreshCost()
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_yield_open)
end

function slot0.refreshBuildingInfo(slot0)
	slot1 = ""
	slot2 = ""

	if RoomMapBuildingModel.instance:getBuildingMOById(slot0.buildingUid) and slot3.config then
		slot1 = slot4.name
		slot2 = slot4.nameEn
	end

	slot0._txtnamecn.text = slot1
	slot0._txtnameen.text = slot2

	UISpriteSetMgr.instance:setRoomSprite(slot0._imageicon, ManufactureConfig.instance:getManufactureBuildingIcon(slot3.buildingId))
end

function slot0.refreshCost(slot0)
	slot2 = ManufactureConfig.instance
	slot2 = slot2.getRestBuildingSeatSlotCost
	slot3 = true

	for slot7, slot8 in ipairs(slot2(slot2, RoomMapBuildingModel.instance:getBuildingMOById(slot0.buildingUid) and slot1.buildingId)) do
		slot13 = slot8.quantity <= ItemModel.instance:getItemQuantity(slot8.type, slot8.id)

		if not slot0._costItemList[slot7] then
			slot14 = slot0:getUserDataTb_()
			slot14.index = slot7
			slot14.go = gohelper.cloneInPlace(slot0._gocostitem, "item" .. slot7)
			slot14.parent = gohelper.findChild(slot14.go, "go_itempos")
			slot14.itemIcon = IconMgr.instance:getCommonItemIcon(slot14.parent)

			table.insert(slot0._costItemList, slot14)
		end

		slot14.itemIcon:setMOValue(slot9, slot10, slot11)
		slot14.itemIcon:setCountFontSize(uv0)
		slot14.itemIcon:setOnBeforeClickCallback(JumpController.commonIconBeforeClickSetRecordItem, slot0)

		slot15 = slot9 == MaterialEnum.MaterialType.Currency
		slot16 = ""
		slot14.itemIcon:getCount().text = (not slot13 or (not slot15 or GameUtil.numberDisplay(slot11)) and string.format("%s/%s", GameUtil.numberDisplay(slot12), GameUtil.numberDisplay(slot11))) and (not slot15 or string.format("<color=#d97373>%s</color>", GameUtil.numberDisplay(slot11))) and string.format("<color=#d97373>%s</color>/%s", GameUtil.numberDisplay(slot12), GameUtil.numberDisplay(slot11))
		slot3 = slot3 and slot13

		gohelper.setActive(slot14.go, true)
	end

	slot0._isCanUpgrade = slot3

	for slot7 = #slot2 + 1, #slot0._costItemList do
		gohelper.setActive(slot0._costItemList[slot7].go, false)
	end

	ZProj.UGUIHelper.SetGrayscale(slot0._btnbuild.gameObject, not slot0._isCanUpgrade)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
