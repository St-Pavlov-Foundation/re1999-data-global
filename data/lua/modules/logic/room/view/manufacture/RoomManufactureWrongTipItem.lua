module("modules.logic.room.view.manufacture.RoomManufactureWrongTipItem", package.seeall)

slot0 = class("RoomManufactureWrongTipItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._gowaitbg = gohelper.findChild(slot0.go, "waitbg")
	slot0._gopausebg = gohelper.findChild(slot0.go, "pausebg")
	slot0._imagequality = gohelper.findChildImage(slot0.go, "info/item/#image_quality")
	slot0._simageproductionIcon = gohelper.findChildSingleImage(slot0.go, "info/item/#simage_productionIcon")
	slot0._txtproductionName = gohelper.findChildText(slot0.go, "info/item/#txt_productionName")
	slot0._golayoutstatus = gohelper.findChild(slot0.go, "info/layoutStatus")
	slot0._goStatusItem = gohelper.findChild(slot0.go, "info/layoutStatus/#simage_status")
	slot0._godec = gohelper.findChild(slot0.go, "info/#go_dec")
	slot0._gowrongs = gohelper.findChild(slot0.go, "#go_wrongs")
	slot0._gowrongItem = gohelper.findChild(slot0.go, "#go_wrongs/#go_wrongItem")

	slot0:setData()
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.onWrongItemJumpClick(slot0, slot1)
	if not slot0.wrongItemList[slot1] then
		return
	end

	ManufactureController.instance:clickWrongJump(slot2.data.wrongType, slot2.data.manufactureItemId, slot2.data.buildingType, {
		isOverView = slot0.isOverView,
		pathToType = slot0.buildingType
	})
end

function slot0.setData(slot0, slot1, slot2, slot3, slot4)
	slot0.buildingUid = slot1
	slot0.manufactureItemId = slot2
	slot0.wrongSlotIdList = slot3
	slot0.isOverView = slot4
	slot0.buildingType = ManufactureConfig.instance:getManufactureItemBelongBuildingType(slot2)

	slot0:refresh()
end

function slot0.refresh(slot0)
	if not slot0.buildingUid or not slot0.manufactureItemId or not slot0.wrongSlotIdList then
		return
	end

	slot0:setItemInfo()

	slot1, slot2 = ManufactureModel.instance:getAllWrongManufactureItemList(slot0.buildingUid, slot0.manufactureItemId, #slot0.wrongSlotIdList)

	slot0:setStatusItems(slot2)
	slot0:setWrongItems(slot1)
end

function slot0.setItemInfo(slot0)
	slot2, slot3 = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, ManufactureConfig.instance:getItemId(slot0.manufactureItemId))

	UISpriteSetMgr.instance:setCritterSprite(slot0._imagequality, RoomManufactureEnum.RareImageMap[slot2.rare])
	slot0._simageproductionIcon:LoadImage(ManufactureConfig.instance:getBatchIconPath(slot0.manufactureItemId) or slot3)

	slot0._txtproductionName.text = ManufactureConfig.instance:getManufactureItemName(slot0.manufactureItemId)
end

function slot0.setStatusItems(slot0, slot1)
	slot0.statusItemList = {}
	slot2 = false

	for slot6, slot7 in ipairs(slot1) do
		if slot7 ~= RoomManufactureEnum.ManufactureWrongType.WaitPreMat then
			break
		end
	end

	gohelper.setActive(slot0._gowaitbg, not slot2)
	gohelper.setActive(slot0._gopausebg, slot2)
	gohelper.CreateObjList(slot0, slot0._onSetStatusItem, slot1, slot0._golayoutstatus, slot0._goStatusItem)
end

function slot0._onSetStatusItem(slot0, slot1, slot2, slot3)
	slot4 = slot0:getUserDataTb_()
	slot4.go = slot1
	slot4.wrongType = slot2
	slot4.simagestatus = slot1:GetComponent(gohelper.Type_Image)
	slot4.txtstatus = gohelper.findChildText(slot1, "#txt_status")
	slot5 = nil
	slot6 = ""

	if RoomManufactureEnum.ManufactureWrongDisplay[slot2] then
		slot5 = slot7.icon
		slot6 = luaLang(slot7.desc)
	end

	if not string.nilorempty(slot5) then
		UISpriteSetMgr.instance:setRoomSprite(slot4.simagestatus, slot5)
	end

	slot4.txtstatus.text = slot6
	slot0.statusItemList[slot3] = slot4
end

function slot0.setWrongItems(slot0, slot1)
	slot0:clearWrongItemList()
	gohelper.setActive(slot0._godec, slot1 and #slot1 > 0)
	gohelper.CreateObjList(slot0, slot0._onSetWrongItem, slot1, slot0._gowrongs, slot0._gowrongItem)
end

function slot0.clearWrongItemList(slot0)
	if slot0.wrongItemList then
		for slot4, slot5 in ipairs(slot0.wrongItemList) do
			slot5.needitemIcon:UnLoadImage()
			slot5.btnjump:RemoveClickListener()
		end
	end

	slot0.wrongItemList = {}
end

function slot0._onSetWrongItem(slot0, slot1, slot2, slot3)
	slot4 = slot0:getUserDataTb_()
	slot4.go = slot1
	slot4.data = slot2
	slot4.goneedItem = gohelper.findChild(slot1, "#go_needItem")
	slot4.needitemquality = gohelper.findChildImage(slot1, "#go_needItem/item/#image_quality")
	slot4.needitemIcon = gohelper.findChildSingleImage(slot1, "#go_needItem/item/#simage_productionIcon")
	slot4.needitemName = gohelper.findChildText(slot1, "#go_needItem/#txt_tipItemName")
	slot4.txtneed = gohelper.findChildText(slot1, "#go_needItem/#txt_need")
	slot4.goneedLink = gohelper.findChild(slot1, "#go_needLink")
	slot4.simagestart = gohelper.findChildImage(slot1, "#go_needLink/#simage_start")
	slot4.simageend = gohelper.findChildImage(slot1, "#go_needLink/#simage_end")
	slot4.btnjump = gohelper.findChildClickWithDefaultAudio(slot1, "#btn_jump")
	slot4.txtjump = gohelper.findChildText(slot1, "#btn_jump/#txt_jump")

	slot4.btnjump:AddClickListener(slot0.onWrongItemJumpClick, slot0, slot3)

	slot6 = slot4.data.wrongType == RoomManufactureEnum.ManufactureWrongType.NoLinkPath

	gohelper.setActive(slot4.goneedItem, not slot6)
	gohelper.setActive(slot4.goneedLink, slot6)

	if slot6 then
		UISpriteSetMgr.instance:setRoomSprite(slot4.simagestart, RoomConfig.instance:getBuildingTypeIcon(slot4.data.buildingType))
		UISpriteSetMgr.instance:setRoomSprite(slot4.simageend, RoomConfig.instance:getBuildingTypeIcon(slot0.buildingType))
	else
		slot7 = slot4.data.manufactureItemId
		slot9, slot10 = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, ManufactureConfig.instance:getItemId(slot7))

		UISpriteSetMgr.instance:setCritterSprite(slot4.needitemquality, RoomManufactureEnum.RareImageMap[slot9.rare])
		slot4.needitemIcon:LoadImage(ManufactureConfig.instance:getBatchIconPath(slot7) or slot10)

		slot4.needitemName.text = ManufactureConfig.instance:getManufactureItemName(slot7)
		slot4.txtneed.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("room_manufacture_wrong_need_count"), string.format("<color=#D26D69>%s</color>", ManufactureModel.instance:getManufactureItemCount(slot7)), slot4.data.needQuantity)
	end

	slot4.txtjump.text = luaLang(RoomManufactureEnum.ManufactureWrongDisplay[slot5].jumpDesc)
	slot0.wrongItemList[slot3] = slot4
end

function slot0.onDestroy(slot0)
	slot0._simageproductionIcon:UnLoadImage()
	slot0:clearWrongItemList()
end

return slot0
