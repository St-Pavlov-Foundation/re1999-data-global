module("modules.logic.room.view.manufacture.RoomManufactureFormulaItem", package.seeall)

slot0 = class("RoomManufactureFormulaItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnneedMatClick:AddClickListener(slot0.onClick, slot0)
	slot0._btnnoMatClick:AddClickListener(slot0.onClick, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._onItemChanged, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, slot0._onItemChanged, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, slot0._onItemChanged, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnneedMatClick:RemoveClickListener()
	slot0._btnnoMatClick:RemoveClickListener()
	slot0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._onItemChanged, slot0)
	slot0:removeEventCb(ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, slot0._onItemChanged, slot0)
	slot0:removeEventCb(ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, slot0._onItemChanged, slot0)
end

function slot0.onClick(slot0)
	ManufactureController.instance:clickFormulaItem(slot0.id)
end

function slot0.onMatClick(slot0, slot1)
	MaterialTipController.instance:showMaterialInfo(slot1.type, slot1.id)
end

function slot0._onItemChanged(slot0)
	slot0:refreshItem()
	slot0:refreshMats()
end

function slot0._editableInitView(slot0)
	slot0._goneedMat = gohelper.findChild(slot0.viewGO, "#go_needMat")
	slot0._btnneedMatClick = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "#go_needMat/#btn_productClick")
	slot0._imgneedMatRareBg = gohelper.findChildImage(slot0.viewGO, "#go_needMat/content/head/#image_quality")
	slot0._goneedMatItem = gohelper.findChild(slot0.viewGO, "#go_needMat/content/head/#go_item")
	slot0._txtneedMatproductionName = gohelper.findChildText(slot0.viewGO, "#go_needMat/content/#txt_productionName")
	slot0._golayoutmat = gohelper.findChild(slot0.viewGO, "#go_needMat/content/layout_mat")
	slot0._gomatItem = gohelper.findChild(slot0.viewGO, "#go_needMat/content/layout_mat/#go_matItem")
	slot0._txtneedMattime = gohelper.findChildText(slot0.viewGO, "#go_needMat/content/time/#txt_time")
	slot0._txtneedMatnum = gohelper.findChildText(slot0.viewGO, "#go_needMat/num/#txt_num")
	slot0._goneedtraced = gohelper.findChild(slot0.viewGO, "#go_needMat/#go_traced")
	slot0._txtneed = gohelper.findChildText(slot0.viewGO, "#go_needMat/#txt_need")
	slot0._gonoMat = gohelper.findChild(slot0.viewGO, "#go_noMat")
	slot0._btnnoMatClick = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "#go_noMat/#btn_productClick")
	slot0._imgnoMatRareBg = gohelper.findChildImage(slot0.viewGO, "#go_noMat/content/head/#image_quality")
	slot0._gonoMatitem = gohelper.findChild(slot0.viewGO, "#go_noMat/content/head/#go_item")
	slot0._txtnoMatproductionName = gohelper.findChildText(slot0.viewGO, "#go_noMat/content/#txt_productionName")
	slot0._txtnoMattime = gohelper.findChildText(slot0.viewGO, "#go_noMat/content/time/#txt_time")
	slot0._txtnoMatnum = gohelper.findChildText(slot0.viewGO, "#go_noMat/num/#txt_num")
	slot0._gonomattraced = gohelper.findChild(slot0.viewGO, "#go_noMat/#go_traced")
	slot0._txtnomatneed = gohelper.findChildText(slot0.viewGO, "#go_noMat/#txt_need")
	slot0.matItemList = {}

	gohelper.setActive(slot0._gomatItem, false)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0.id = slot1.id
	slot0.buildingUid = slot1.buildingUid

	slot0:refreshItem()
	slot0:refreshMats()
	slot0:refreshTime()
end

function slot0.refreshItem(slot0)
	if not ManufactureConfig.instance:getItemId(slot0.id) then
		return
	end

	if not slot0._itemIcon then
		slot0._itemIcon = IconMgr.instance:getCommonItemIcon(slot0._goneedMatItem)

		slot0._itemIcon:isShowQuality(false)
	end

	slot0._itemIcon:setMOValue(MaterialEnum.MaterialType.Item, slot1, nil, , , {
		specificIcon = ManufactureConfig.instance:getBatchIconPath(slot0.id)
	})

	slot4 = RoomManufactureEnum.RareImageMap[slot0._itemIcon:getRare()]

	UISpriteSetMgr.instance:setCritterSprite(slot0._imgneedMatRareBg, slot4)
	UISpriteSetMgr.instance:setCritterSprite(slot0._imgnoMatRareBg, slot4)
	slot0:refreshItemName()
	slot0:refreshItemNum()

	slot5, slot6 = ManufactureModel.instance:getLackMatCount(slot0.id)

	if slot5 and slot5 ~= 0 then
		if slot0._txtneed then
			slot0._txtneed.text = GameUtil.getSubPlaceholderLuaLangOneParam(slot6 and luaLang("room_manufacture_traced_count") or luaLang("room_manufacture_formula_need_count"), slot5)
		end

		if slot0._txtnomatneed then
			slot0._txtnomatneed.text = slot9
		end
	end

	gohelper.setActive(slot0._txtneed, slot7)
	gohelper.setActive(slot0._txtnomatneed, slot7)

	slot8 = RoomTradeModel.instance:isTracedGoods(slot0.id)

	gohelper.setActive(slot0._goneedtraced, slot8)
	gohelper.setActive(slot0._gonomattraced, slot8)
end

function slot0.refreshItemName(slot0)
	slot1 = ManufactureConfig.instance:getManufactureItemName(slot0.id)
	slot0._txtneedMatproductionName.text = slot1
	slot0._txtnoMatproductionName.text = slot1
end

function slot0.refreshItemNum(slot0)
	slot2 = formatLuaLang("materialtipview_itemquantity", ManufactureModel.instance:getManufactureItemCount(slot0.id))
	slot0._txtneedMatnum.text = slot2
	slot0._txtnoMatnum.text = slot2
end

function slot0.refreshMats(slot0)
	slot5 = RoomMapBuildingModel.instance:getBuildingMOById(slot0.buildingUid) and slot4.config.buildingType

	if (ManufactureConfig.instance:getNeedMatItemList(slot0.id) and #slot1 or 0) > 0 then
		for slot9, slot10 in ipairs(slot1) do
			slot12 = slot10.quantity
			slot13 = slot0:getMatItem(slot9)
			slot15, slot16 = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, ManufactureConfig.instance:getItemId(slot10.id))

			if not string.nilorempty(slot16) then
				slot13.icon:LoadImage(slot16)
			end

			slot13.txtunitNum.text = slot12
			slot17 = false
			slot18 = false
			slot19, slot20 = ManufactureModel.instance:getManufactureItemCount(slot11, true, true)

			if ManufactureModel.instance:hasPathLinkedToThisBuildingType(slot11, slot5) then
				slot17 = slot20 and slot20 > 0
				slot18 = slot12 <= slot19 + ManufactureModel.instance:getManufactureItemCountInSlotQueue(slot11, true, true)
			else
				slot18 = slot12 <= slot19
			end

			slot22 = ""
			slot13.txthasNum.text = (not slot17 or GameUtil.getSubPlaceholderLuaLangTwoParam(slot18 and luaLang("room_manufacture_item_mat_count") or luaLang("room_manufacture_item_mat_count_not_enough"), slot19, slot20)) and (slot18 and slot19 or string.format("<color=#BE4343>%s</color>", slot19))

			slot13.btnClick:RemoveClickListener()
			slot13.btnClick:AddClickListener(slot0.onMatClick, slot0, {
				type = MaterialEnum.MaterialType.Item,
				id = slot14
			})
			gohelper.setActive(slot13.go, true)
		end

		for slot9 = slot2 + 1, #slot0.matItemList do
			gohelper.setActive(slot0.matItemList[slot9].go, false)
		end
	end

	gohelper.setActive(slot0._goneedMat, slot3)
	gohelper.setActive(slot0._gonoMat, not slot3)

	if slot0._itemIcon then
		slot0._itemIcon.tr:SetParent(slot3 and slot0._goneedMatItem.transform or slot0._gonoMatitem.transform)
		recthelper.setAnchor(slot0._itemIcon.tr, 0, 0)
	end
end

function slot0.getMatItem(slot0, slot1)
	if not slot0.matItemList[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.go = gohelper.clone(slot0._gomatItem, slot0._golayoutmat, slot1)
		slot2.icon = gohelper.findChildSingleImage(slot2.go, "#simage_productionIcon")
		slot2.txtunitNum = gohelper.findChildText(slot2.go, "#simage_productionIcon/#txt_unitNum")
		slot2.txthasNum = gohelper.findChildText(slot2.go, "#txt_hasNum")
		slot2.goline = gohelper.findChild(slot2.go, "#go_line")
		slot2.btnClick = gohelper.findChildClickWithAudio(slot2.go, "#btn_click", AudioEnum.UI.Store_Good_Click)

		table.insert(slot0.matItemList, slot2)
	end

	return slot2
end

function slot0.refreshTime(slot0)
	slot2 = ManufactureController.instance:getFormatTime(ManufactureConfig.instance:getNeedTime(slot0.id))
	slot0._txtneedMattime.text = slot2
	slot0._txtnoMattime.text = slot2
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0.matItemList) do
		if slot5.icon then
			slot5.icon:UnLoadImage()

			slot5.icon = nil
		end

		if slot5.btnClick then
			slot5.btnClick:RemoveClickListener()
		end
	end
end

return slot0
