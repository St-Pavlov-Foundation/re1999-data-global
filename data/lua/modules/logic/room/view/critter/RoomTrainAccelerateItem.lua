module("modules.logic.room.view.critter.RoomTrainAccelerateItem", package.seeall)

slot0 = class("RoomTrainAccelerateItem", ListScrollCellExtend)
slot1 = 1

function slot0.onInitView(slot0)
	slot0._goitem = gohelper.findChild(slot0.viewGO, "#go_item")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#txt_name")
	slot0._gouse = gohelper.findChild(slot0.viewGO, "#go_use")
	slot0._btnmin = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_use/#btn_min")
	slot0._btnsub = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_use/#btn_sub")
	slot0._inputvalue = gohelper.findChildTextMeshInputField(slot0.viewGO, "#go_use/valuebg/#input_value")
	slot0._btnadd = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_use/#btn_add")
	slot0._btnmax = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_use/#btn_max")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_use/hasCount/#simage_icon")
	slot0._txthas = gohelper.findChildText(slot0.viewGO, "#go_use/hasCount/#txt_has")
	slot0._btnuse = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_use/#btn_use")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnmin:AddClickListener(slot0._btnminOnClick, slot0)
	slot0._btnsub:AddClickListener(slot0._btnsubOnClick, slot0)
	slot0._btnadd:AddClickListener(slot0._btnaddOnClick, slot0)
	slot0._btnmax:AddClickListener(slot0._btnmaxOnClick, slot0)
	slot0._btnuse:AddClickListener(slot0._btnuseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnmin:RemoveClickListener()
	slot0._btnsub:RemoveClickListener()
	slot0._btnadd:RemoveClickListener()
	slot0._btnmax:RemoveClickListener()
	slot0._btnuse:RemoveClickListener()
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
	slot0:changeCount(slot0:getMaxCount())
end

function slot0._btnuseOnClick(slot0)
	if slot0:checkCount() then
		if slot0._critterMO.trainInfo:getCurCdTime() < slot0._count * slot0._accelerateTime then
			GameFacade.showMessageBox(MessageBoxIdDefine.RoomCritterTrainFastForwardExceed, MsgBoxEnum.BoxType.Yes_No, slot0._yesToSendFasetForward, nil, , slot0, nil, )

			return
		end

		RoomCritterController.instance:sendFastForwardTrain(slot0._critterUid, slot0._itemId, slot0._count)
	else
		GameFacade.showToast(ToastEnum.RoomManufactureAccelerateCount)
	end
end

function slot0._yesToSendFasetForward(slot0)
	if slot0:checkCount() then
		RoomCritterController.instance:sendFastForwardTrain(slot0._critterUid, slot0._itemId, slot0._count)
	end
end

function slot0._editableInitView(slot0)
end

function slot0._editableAddEvents(slot0)
	if slot0._view and slot0._view.viewContainer then
		slot0._view.viewContainer:registerCallback(CritterEvent.UITrainCdTime, slot0._opTranCdTimeUpdate, slot0)
		slot0._view.viewContainer:registerCallback(CritterEvent.FastForwardTrainReply, slot0._opFastForwardTrainReply, slot0)
	end
end

function slot0._editableRemoveEvents(slot0)
	if slot0._view and slot0._view.viewContainer then
		slot0._view.viewContainer:unregisterCallback(CritterEvent.UITrainCdTime, slot0._opTranCdTimeUpdate, slot0)
		slot0._view.viewContainer:unregisterCallback(CritterEvent.FastForwardTrainReply, slot0._opFastForwardTrainReply, slot0)
	end
end

function slot0.onUpdateMO(slot0, slot1)
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
end

function slot0._opTranCdTimeUpdate(slot0)
	if slot0:getUseMaxCount() < slot0._count then
		-- Nothing
	end
end

function slot0._opFastForwardTrainReply(slot0)
	slot0:changeCount(uv0)
	slot0:refreshCount()
end

function slot0.setData(slot0, slot1, slot2)
	slot0._critterUid = slot1
	slot0._itemId = slot2
	slot0._itemCfg = ItemConfig.instance:getItemCo(slot2)
	slot0._accelerateTime = 0

	if slot0._itemCfg then
		slot0._accelerateTime = tonumber(slot0._itemCfg.effect)
	end

	slot0._critterMO = CritterModel.instance:getCritterMOByUid(slot0._critterUid)

	slot0:setItem()
	slot0:changeCount(uv0)
end

function slot0.setItem(slot0)
	if not slot0._itemId then
		return
	end

	if not slot0._itemIcon then
		slot0._itemIcon = IconMgr.instance:getCommonItemIcon(slot0._goitem)
	end

	slot1, slot2 = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, slot0._itemId, true)

	slot0._simageicon:LoadImage(slot2)
	slot0._itemIcon:setMOValue(MaterialEnum.MaterialType.Item, slot0._itemId)

	slot0._txtname.text = ItemConfig.instance:getItemNameById(slot0._itemId)
end

function slot0.changeCount(slot0, slot1, slot2)
	slot3 = slot0:getMaxCount()

	if slot0:getUseMaxCount() < slot1 then
		slot1 = slot4
	end

	if slot1 < uv0 then
		slot1 = uv0
	end

	if slot3 < slot1 then
		slot1 = slot3
	end

	slot0._count = slot1

	if slot2 then
		slot0._inputvalue:SetText(slot1)
	else
		slot0._inputvalue:SetTextWithoutNotify(tostring(slot1))
	end

	slot0:refreshCount()

	if slot0._view then
		slot0._view:setPreviewForwardTime(slot0._count * slot0._accelerateTime)
	end
end

function slot0.refreshCount(slot0)
	slot0._txthas.text = string.format("%s/%s", slot0._count, slot0:getMaxCount())

	ZProj.UGUIHelper.SetGrayscale(slot0._btnuse.gameObject, not slot0:checkCount())
end

function slot0.getUseMaxCount(slot0)
	if not slot0._accelerateTime or slot0._accelerateTime <= 0 then
		return 0
	end

	if slot0._critterMO then
		return math.ceil(slot0._critterMO.trainInfo:getCurCdTime() / slot0._accelerateTime)
	end

	return 0
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

return slot0
