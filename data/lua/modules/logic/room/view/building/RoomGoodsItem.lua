module("modules.logic.room.view.building.RoomGoodsItem", package.seeall)

slot0 = class("RoomGoodsItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._imagerare = gohelper.findChildImage(slot0.viewGO, "#image_rare")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "#simage_icon")
	slot0._gorarecircle = gohelper.findChild(slot0.viewGO, "#go_rarecircle")
	slot0._gocountbg = gohelper.findChild(slot0.viewGO, "countbg")
	slot0._txtcount = gohelper.findChildText(slot0.viewGO, "countbg/#txt_count")
	slot0._click = gohelper.getClick(slot0.viewGO)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEventListeners(slot0)
	slot0._click:AddClickListener(slot0._onClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._click:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._isEnableClick = true
	slot0._rareCircleTabs = slot0:getUserDataTb_()

	for slot4 = 5, 4, -1 do
		table.insert(slot0._rareCircleTabs, {
			id = slot4,
			go = gohelper.findChild(slot0._gorarecircle, "#go_rare" .. slot4)
		})
	end
end

function slot0.onUpdateMO(slot0, slot1)
	slot0:setMOValue(slot1.materilType, slot1.materilId, slot1.quantity)
end

function slot0.setMOValue(slot0, slot1, slot2, slot3, slot4)
	slot0._itemType = tonumber(slot1)
	slot0._itemId = slot2
	slot0._itemQuantity = tonumber(slot3)
	slot5, slot6 = ItemModel.instance:getItemConfigAndIcon(slot0._itemType, slot0._itemId)
	slot0._config = slot5

	slot0._simageicon:LoadImage(slot6)

	slot7 = slot5.rare and slot5.rare or 5

	UISpriteSetMgr.instance:setRoomSprite(slot0._imagerare, "bg_wupindi_" .. tostring(ItemEnum.Color[slot7]))

	if slot7 >= 4 then
		for slot11, slot12 in ipairs(slot0._rareCircleTabs) do
			gohelper.setActive(slot12.go, slot12.id == slot7)
		end
	end

	slot0._colorStr = slot4

	if string.nilorempty(slot0._colorStr) then
		slot0._txtcount.text = GameUtil.numberDisplay(slot0._itemQuantity)
	else
		slot0._txtcount.text = string.format("<color=%s>%s</color>", slot0._colorStr, GameUtil.numberDisplay(slot0._itemQuantity))
	end
end

function slot0.isEnableClick(slot0, slot1)
	slot0._isEnableClick = slot1
end

function slot0.setRecordFarmItem(slot0, slot1)
	slot0.needSetRecordFarm = slot1
end

function slot0.setConsume(slot0, slot1)
	slot0._isConsume = slot1
end

function slot0._onClick(slot0, slot1)
	if not slot0._isEnableClick and not slot1 then
		return
	end

	if slot0._customCallback then
		return slot0._customCallback(slot0.params)
	end

	if slot0.needSetRecordFarm then
		MaterialTipController.instance:showMaterialInfo(slot0._itemType, slot0._itemId, slot0._inPack, nil, , {
			type = slot0._itemType,
			id = slot0._itemId,
			quantity = slot0._itemQuantity,
			sceneType = GameSceneMgr.instance:getCurSceneType(),
			openedViewNameList = JumpController.instance:getCurrentOpenedView()
		}, nil, slot0._itemQuantity, slot0._isConsume, slot0.jumpFinishCallback, slot0.jumpFinishCallbackObj, slot0.jumpFinishCallbackParam)
	else
		MaterialTipController.instance:showMaterialInfo(slot0._itemType, slot0._itemId, slot0._inPack, nil, )
	end
end

function slot0.customOnClickCallback(slot0, slot1, slot2)
	slot0._customCallback = slot1
	slot0.params = slot2
end

function slot0.setCountText(slot0, slot1)
	slot0._txtcount.text = slot1
end

function slot0.canShowRareCircle(slot0, slot1)
	gohelper.setActive(slot0._gorarecircle, slot1)
end

function slot0.setIconPos(slot0, slot1, slot2)
	recthelper.setAnchor(slot0._simageicon.transform, slot1, slot2)
end

function slot0.setIconScale(slot0, slot1)
	transformhelper.setLocalScale(slot0._simageicon.transform, slot1, slot1, slot1)
end

function slot0.setCountPos(slot0, slot1, slot2)
	recthelper.setAnchor(slot0._gocountbg.transform, slot1, slot2)
end

function slot0.setCountScale(slot0, slot1)
	transformhelper.setLocalScale(slot0._gocountbg.transform, slot1, slot1, slot1)
end

function slot0.isShowCount(slot0, slot1)
	gohelper.setActive(slot0._gocountbg, slot1)
end

function slot0.setGrayscale(slot0, slot1)
	ZProj.UGUIHelper.SetGrayscale(slot0._simageicon.gameObject, slot1)
	ZProj.UGUIHelper.SetGrayscale(slot0._imagerare.gameObject, slot1)
end

function slot0.setJumpFinishCallback(slot0, slot1, slot2, slot3)
	slot0.jumpFinishCallback = slot1
	slot0.jumpFinishCallbackObj = slot2
	slot0.jumpFinishCallbackParam = slot3
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
	if slot0._simageicon then
		slot0._simageicon:UnLoadImage()
	end
end

return slot0
