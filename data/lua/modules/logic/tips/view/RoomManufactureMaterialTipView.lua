module("modules.logic.tips.view.RoomManufactureMaterialTipView", package.seeall)

slot0 = class("RoomManufactureMaterialTipView", BaseView)

function slot0.onInitView(slot0)
	if GMController.instance:getGMNode("materialtipview", slot0.viewGO) then
		slot0._gogm = gohelper.findChild(slot1, "#go_gm")
		slot0._txtmattip = gohelper.findChildText(slot1, "#go_gm/bg/#txt_mattip")
		slot0._btnone = gohelper.findChildButtonWithAudio(slot1, "#go_gm/#btn_one")
		slot0._btnten = gohelper.findChildButtonWithAudio(slot1, "#go_gm/#btn_ten")
		slot0._btnhundred = gohelper.findChildButtonWithAudio(slot1, "#go_gm/#btn_hundred")
		slot0._btnthousand = gohelper.findChildButtonWithAudio(slot1, "#go_gm/#btn_thousand")
		slot0._btntenthousand = gohelper.findChildButtonWithAudio(slot1, "#go_gm/#btn_tenthousand")
		slot0._btntenmillion = gohelper.findChildButtonWithAudio(slot1, "#go_gm/#btn_tenmillion")
		slot0._btninput = gohelper.findChildButtonWithAudio(slot1, "#go_gm/#btn_input")
	end

	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._imagequality = gohelper.findChildImage(slot0.viewGO, "iconbg/#image_quality")
	slot0._simagepropicon = gohelper.findChildSingleImage(slot0.viewGO, "iconbg/#simage_propicon")
	slot0._gohadnumber = gohelper.findChild(slot0.viewGO, "iconbg/#go_hadnumber")
	slot0._txthadnumber = gohelper.findChildText(slot0.viewGO, "iconbg/#go_hadnumber/#txt_hadnumber")
	slot0._txtpropname = gohelper.findChildText(slot0.viewGO, "#txt_propname")
	slot0._scrolldesc = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_desc")
	slot0._txtdec1 = gohelper.findChildText(slot0.viewGO, "#scroll_desc/viewport/content/#txt_dec1")
	slot0._txtdec2 = gohelper.findChildText(slot0.viewGO, "#scroll_desc/viewport/content/#txt_dec2")
	slot0._txtWrongTip = gohelper.findChildText(slot0.viewGO, "#txt_wrongJump")
	slot0._btnWrongJump = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "#txt_wrongJump/#btn_wrongJump")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	if slot0._gogm then
		slot0._btnone:AddClickListener(slot0._btnGMClick, slot0, 1)
		slot0._btnten:AddClickListener(slot0._btnGMClick, slot0, 10)
		slot0._btnhundred:AddClickListener(slot0._btnGMClick, slot0, 100)
		slot0._btnthousand:AddClickListener(slot0._btnGMClick, slot0, 1000)
		slot0._btntenthousand:AddClickListener(slot0._btnGMClick, slot0, 10000)
		slot0._btntenmillion:AddClickListener(slot0._btnGMClick, slot0, 10000000)
		slot0._btninput:AddClickListener(slot0._btninputOnClick, slot0)
	end

	slot0._btnWrongJump:AddClickListener(slot0._btnwrongjumpOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._onItemChange, slot0)
end

function slot0.removeEvents(slot0)
	if slot0._gogm then
		slot0._btnone:RemoveClickListener()
		slot0._btnten:RemoveClickListener()
		slot0._btnhundred:RemoveClickListener()
		slot0._btnthousand:RemoveClickListener()
		slot0._btntenthousand:RemoveClickListener()
		slot0._btntenmillion:RemoveClickListener()
		slot0._btninput:RemoveClickListener()
	end

	slot0._btnWrongJump:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	slot0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._onItemChange, slot0)
end

function slot0._btnGMClick(slot0, slot1)
	slot0:sendGMRequest(slot1)
end

function slot0._btninputOnClick(slot0)
	slot1 = CommonInputMO.New()
	slot1.title = "请输入增加道具数量！"
	slot1.defaultInput = "Enter Item Num"

	function slot1.sureCallback(slot0)
		GameFacade.closeInputBox()

		if tonumber(slot0) and slot1 > 0 then
			uv0:sendGMRequest(slot1)
		end
	end

	GameFacade.openInputBox(slot1)
end

function slot0.sendGMRequest(slot0, slot1)
	GameFacade.showToast(ToastEnum.GMTool5, slot0.viewParam.id)

	if slot0.viewParam.type == MaterialEnum.MaterialType.Item and slot0.viewParam.id == 510001 then
		GMRpc.instance:sendGMRequest(string.format("add heroStoryTicket %d", slot1))
	else
		GMRpc.instance:sendGMRequest(string.format("add material %d#%d#%d", slot0.viewParam.type, slot0.viewParam.id, slot1))
	end
end

function slot0._btnwrongjumpOnClick(slot0)
	if not slot0.isWrong then
		return
	end

	if slot0.wrongBuildingUid then
		ManufactureController.instance:jumpToManufactureBuildingLevelUpView(slot0.wrongBuildingUid)
	else
		ManufactureController.instance:jump2PlaceManufactureBuildingView()
	end
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._onItemChange(slot0)
	slot0:refreshItemQuantity()
end

function slot0._editableInitView(slot0)
	if slot0._gogm then
		gohelper.setActive(slot0._gogm, GMController.instance:isOpenGM())
	end
end

function slot0.onUpdateParam(slot0)
	slot0.type = nil
	slot0.id = nil

	if slot0.viewParam then
		slot0.type = slot0.viewParam.type
		slot0.id = slot0.viewParam.id
	end

	slot0:setItem()
end

function slot0.onOpen(slot0)
	slot0:onUpdateParam()
end

function slot0.setItem(slot0)
	slot1, slot2 = ItemModel.instance:getItemConfigAndIcon(slot0.type, slot0.id)
	slot0._txtpropname.text = slot1.name
	slot0._txtdec1.text = slot1.useDesc
	slot0._txtdec2.text = slot1.desc

	slot0._simagepropicon:LoadImage(slot2)
	UISpriteSetMgr.instance:setCritterSprite(slot0._imagequality, "critter_manufacture_itemquality" .. slot1.rare)

	if slot0._txtmattip then
		slot0._txtmattip.text = tostring(slot0.type) .. "#" .. tostring(slot0.id)
	end

	slot0:refreshItemQuantity()
	slot0:checkWrong()
end

function slot0.checkWrong(slot0)
	slot0.isWrong = false
	slot0.wrongBuildingUid = nil

	if ManufactureConfig.instance:getManufactureItemListByItemId(slot0.id)[1] then
		if ManufactureController.instance:checkPlaceProduceBuilding(slot2) then
			slot4, slot5, slot6 = ManufactureController.instance:checkProduceBuildingLevel(slot2)

			if slot4 then
				slot7 = ""

				if RoomMapBuildingModel.instance:getBuildingMOById(slot5) then
					slot7 = slot8.config.useDesc
				end

				slot0._txtWrongTip.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("room_upgrade_building_unlock"), slot7, slot6)
				slot0.wrongBuildingUid = slot5
				slot0.isWrong = true
			end
		else
			slot4 = ""

			if RoomConfig.instance:getBuildingConfig(ManufactureConfig.instance:getManufactureItemBelongBuildingList(slot2)[1]) then
				slot4 = slot6.useDesc
			end

			slot0._txtWrongTip.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("room_place_building_to_unlock"), slot4)
			slot0.isWrong = true
		end
	end

	gohelper.setActive(slot0._txtWrongTip, slot0.isWrong)
end

function slot0.refreshItemQuantity(slot0)
	slot0._txthadnumber.text = formatLuaLang("materialtipview_itemquantity", tostring(GameUtil.numberDisplay(ItemModel.instance:getItemQuantity(slot0.type, slot0.id) or 0)))
end

function slot0.onClose(slot0)
	slot0._simagepropicon:UnLoadImage()
end

function slot0.onDestroyView(slot0)
end

return slot0
