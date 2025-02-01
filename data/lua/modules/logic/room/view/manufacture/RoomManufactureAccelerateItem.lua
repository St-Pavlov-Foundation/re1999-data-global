module("modules.logic.room.view.manufacture.RoomManufactureAccelerateItem", package.seeall)

slot0 = class("RoomManufactureAccelerateItem", LuaCompBase)
slot1 = 1

function slot0.init(slot0, slot1)
	slot0.go = slot1

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0._editableInitView(slot0)
	slot0._imgquality = gohelper.findChildImage(slot0.go, "#image_quality")
	slot0._goitem = gohelper.findChild(slot0.go, "#go_item")
	slot0._txtname = gohelper.findChildText(slot0.go, "#txt_name")
	slot0._gouse = gohelper.findChild(slot0.go, "#go_use")
	slot0._inputvalue = gohelper.findChildTextMeshInputField(slot0.go, "#go_use/valuebg/#input_value")
	slot0._btnmin = gohelper.findChildButtonWithAudio(slot0.go, "#go_use/#btn_min")
	slot0._btnsub = gohelper.findChildButtonWithAudio(slot0.go, "#go_use/#btn_sub")
	slot0._btnadd = gohelper.findChildButtonWithAudio(slot0.go, "#go_use/#btn_add")
	slot0._btnmax = gohelper.findChildButtonWithAudio(slot0.go, "#go_use/#btn_max")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.go, "#go_use/hasCount/#simage_icon")
	slot0._txthas = gohelper.findChildText(slot0.go, "#go_use/hasCount/#txt_has")
	slot0._btnuse = gohelper.findChildButtonWithAudio(slot0.go, "#go_use/#btn_use")
end

function slot0.addEventListeners(slot0)
	slot0._btnmin:AddClickListener(slot0._btnminOnClick, slot0)
	slot0._btnsub:AddClickListener(slot0._btnsubOnClick, slot0)
	slot0._inputvalue:AddOnValueChanged(slot0._onInputValueChange, slot0)
	slot0._btnadd:AddClickListener(slot0._btnaddOnClick, slot0)
	slot0._btnmax:AddClickListener(slot0._btnmaxOnClick, slot0)
	slot0._btnuse:AddClickListener(slot0._btnuseOnClick, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._onItemChange, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnmin:RemoveClickListener()
	slot0._btnsub:RemoveClickListener()
	slot0._inputvalue:RemoveOnValueChanged()
	slot0._btnadd:RemoveClickListener()
	slot0._btnmax:RemoveClickListener()
	slot0._btnuse:RemoveClickListener()
	slot0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._onItemChange, slot0)
end

function slot0._btnminOnClick(slot0)
	slot0:changeCount(uv0)
end

function slot0._btnsubOnClick(slot0)
	slot0:changeCount(slot0._count - 1)
end

function slot0._onInputValueChange(slot0, slot1)
	slot0:changeCount(tonumber(slot1) or uv0)
end

function slot0._btnaddOnClick(slot0)
	slot0:changeCount(slot0._count + 1)
end

function slot0._btnmaxOnClick(slot0)
	if not RoomMapBuildingModel.instance:getBuildingMOById(slot0._buildingUid) then
		return
	end

	slot2 = slot0:getMaxCount()

	if slot1:getSlotRemainSecTime(slot1:getSlotIdInProgress()) > 0 and slot1:getAccelerateEff(slot3, slot0._itemId) ~= 0 then
		slot2 = math.ceil(slot4 / slot5)
	end

	slot0:changeCount(slot2)
end

function slot0._btnuseOnClick(slot0)
	if slot0:checkCount() then
		if not RoomMapBuildingModel.instance:getBuildingMOById(slot0._buildingUid) then
			return
		end

		slot3 = slot2:getSlotIdInProgress()

		if slot2:getSlotRemainSecTime(slot3) < slot2:getAccelerateEff(slot3, slot0._itemId) * slot0._count then
			GameFacade.showMessageBox(MessageBoxIdDefine.RoomManufactureAccelerateOver, MsgBoxEnum.BoxType.Yes_No, slot0._sendUseItem, nil, , slot0)
		else
			slot0:_sendUseItem()
		end
	else
		GameFacade.showToast(ToastEnum.RoomManufactureAccelerateCount)
	end
end

function slot0._sendUseItem(slot0)
	ManufactureController.instance:useAccelerateItem(slot0._buildingUid, slot0._itemId, slot0._count, RoomMapBuildingModel.instance:getBuildingMOById(slot0._buildingUid) and slot1:getSlotIdInProgress())
end

function slot0._onItemChange(slot0)
	slot0:changeCount(uv0)
end

function slot0.setData(slot0, slot1, slot2)
	slot0._buildingUid = slot1
	slot0._itemId = slot2.id

	slot0:setItem()
	slot0:changeCount(uv0)
end

function slot0.setItem(slot0)
	if not slot0._itemId then
		return
	end

	if not slot0._itemIcon then
		slot0._itemIcon = IconMgr.instance:getCommonItemIcon(slot0._goitem)

		slot0._itemIcon:isShowQuality(false)
	end

	slot0._itemIcon:setMOValue(MaterialEnum.MaterialType.Item, slot0._itemId)
	UISpriteSetMgr.instance:setCritterSprite(slot0._imgquality, RoomManufactureEnum.RareImageMap[slot0._itemIcon:getRare()])

	slot3, slot4 = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, slot0._itemId, true)

	slot0._simageicon:LoadImage(slot4)

	slot0._txtname.text = ItemConfig.instance:getItemNameById(slot0._itemId)
end

function slot0.changeCount(slot0, slot1, slot2)
	if slot0:getMaxCount() < uv0 then
		slot3 = uv0
	end

	slot0._count = Mathf.Clamp(slot1, uv0, slot3)

	if slot2 then
		slot0._inputvalue:SetText(slot1)
	else
		slot0._inputvalue:SetTextWithoutNotify(tostring(slot1))
	end

	slot0:refreshCount()
end

function slot0.refreshCount(slot0)
	slot0._txthas.text = string.format("%s/%s", slot0._count, slot0:getMaxCount())

	ZProj.UGUIHelper.SetGrayscale(slot0._btnuse.gameObject, not slot0:checkCount())
end

function slot0.getMaxCount(slot0)
	return ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Item, slot0._itemId)
end

function slot0.checkCount(slot0)
	slot1 = false

	if slot0._count and uv0 <= slot0._count and slot0._count <= slot0:getMaxCount() then
		slot1 = true
	end

	return slot1
end

function slot0.onDestroy(slot0)
	slot0._simageicon:UnLoadImage()
end

return slot0
