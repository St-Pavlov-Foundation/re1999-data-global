module("modules.logic.room.view.manufacture.RoomOneKeyView", package.seeall)

slot0 = class("RoomOneKeyView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnfill = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_fill")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_close")
	slot0._goAddPop = gohelper.findChild(slot0.viewGO, "right/#go_addPop")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnfill:AddClickListener(slot0._btnfillOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.OneKeySelectCustomManufactureItem, slot0.refreshCustomizeItem, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnfill:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	slot0:removeEventCb(ManufactureController.instance, ManufactureEvent.OneKeySelectCustomManufactureItem, slot0.refreshCustomizeItem, slot0)
end

function slot0._btnfillOnClick(slot0)
	ManufactureController.instance:oneKeyManufactureItem(slot0.curOneKeyType)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnclickOnClick(slot0, slot1)
	if slot0.curOneKeyType and slot0.curOneKeyType == slot1 then
		return
	end

	slot2 = nil

	if slot0.curOneKeyType and slot1 == RoomManufactureEnum.OneKeyType.Customize then
		slot2 = "left"
	elseif slot0.curOneKeyType == RoomManufactureEnum.OneKeyType.Customize then
		slot2 = "back"
	end

	if slot0._viewAnimator and not string.nilorempty(slot2) then
		slot0._viewAnimator.enabled = true

		slot0._viewAnimator:Play(slot2, 0, 0)
	end

	slot0:setAddPopActive(slot3)

	slot0.curOneKeyType = slot1

	if slot0.optionItemDict then
		for slot7, slot8 in pairs(slot0.optionItemDict) do
			gohelper.setActive(slot8.goselected, slot7 == slot1)
		end
	end
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot4 = UnityEngine.Animator
	slot0._viewAnimator = slot0.viewGO:GetComponent(typeof(slot4))

	slot0:clearOptionItem()

	for slot4, slot5 in pairs(RoomManufactureEnum.OneKeyType) do
		slot0.optionItemDict[slot5] = slot0:createOptionItem(gohelper.findChild(slot0.viewGO, "root/#scroll_option/Viewport/Content/#go_type" .. slot5), slot5)
	end

	slot0:_btnclickOnClick(ManufactureModel.instance:getRecordOneKeyType())
end

function slot0.createOptionItem(slot0, slot1, slot2)
	slot3 = slot0:getUserDataTb_()
	slot3.oneKeyType = slot2
	slot3.txtdesc = gohelper.findChildText(slot1, "#txt_desc")
	slot3.godesc = slot3.txtdesc.gameObject
	slot3.goselected = gohelper.findChild(slot1, "selectdBg/#go_selected")
	slot3.btnclick = gohelper.findChildClickWithAudio(slot1, "#btn_click")

	slot3.btnclick:AddClickListener(slot0._btnclickOnClick, slot0, slot2)

	slot3.gohasItem = gohelper.findChild(slot1, "#go_hasItem")

	if not gohelper.isNil(slot3.gohasItem) then
		slot3.rarebg = gohelper.findChildImage(slot1, "#go_hasItem/#image_quality")
		slot3.itemicon = gohelper.findChildSingleImage(slot1, "#go_hasItem/#image_quality/#simage_productionIcon")
		slot3.txtitemname = gohelper.findChildText(slot1, "#go_hasItem/#image_quality/#txt_name")
		slot3.txtitemnum = gohelper.findChildText(slot1, "#go_hasItem/#txt_num")
	end

	return slot3
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	if not RoomTradeModel.instance:isGetOrderInfo() then
		RoomRpc.instance:sendGetOrderInfoRequest()
	end

	slot0:refreshCustomizeItem()
end

function slot0.refreshCustomizeItem(slot0)
	if not slot0.optionItemDict[RoomManufactureEnum.OneKeyType.Customize] or gohelper.isNil(slot1.gohasItem) then
		return
	end

	slot2, slot3 = OneKeyAddPopListModel.instance:getSelectedManufactureItem()

	if slot2 then
		slot5, slot6 = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, ManufactureConfig.instance:getItemId(slot2))

		UISpriteSetMgr.instance:setCritterSprite(slot1.rarebg, RoomManufactureEnum.RareImageMap[slot5.rare])
		slot1.itemicon:LoadImage(ManufactureConfig.instance:getBatchIconPath(slot2) or slot6)

		slot1.txtitemname.text = string.split(ManufactureConfig.instance:getManufactureItemName(slot2), "*")[1]
		slot1.txtitemnum.text = luaLang("multiple") .. slot3
	end

	gohelper.setActive(slot1.gohasItem, slot2)
	gohelper.setActive(slot1.godesc, not slot2)
end

function slot0.setAddPopActive(slot0, slot1)
	if slot0.isShowAddPop == slot1 then
		return
	end

	slot2 = slot0.isShowAddPop
	slot0.isShowAddPop = slot1
	slot3 = slot0.isShowAddPop and "#B97B45" or "#ACACAC"

	if slot0.optionItemDict[RoomManufactureEnum.OneKeyType.Customize] then
		UIColorHelper.set(slot4.txtdesc, slot3)
		UIColorHelper.set(slot4.txtitemname, slot3)
	end

	gohelper.setActive(slot0._goAddPop, slot0.isShowAddPop)

	if slot2 and not OneKeyAddPopListModel.instance:getSelectedManufactureItem() then
		slot0:_btnclickOnClick(RoomManufactureEnum.OneKeyType.ShortTime)
	end
end

function slot0.clearOptionItem(slot0)
	if slot0.optionItemDict then
		for slot4, slot5 in pairs(slot0.optionItemDict) do
			if slot5.itemicon then
				slot5.itemicon:UnLoadImage()

				slot5.itemicon = nil
			end

			if slot5.btnclick then
				slot5.btnclick:RemoveClickListener()
			end
		end
	end

	slot0.optionItemDict = {}
end

function slot0.onClose(slot0)
	OneKeyAddPopListModel.instance:resetSelectManufactureItemFromCache()
end

function slot0.onDestroyView(slot0)
	slot0:clearOptionItem()
end

return slot0
