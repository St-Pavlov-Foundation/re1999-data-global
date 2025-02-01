module("modules.logic.room.view.RoomLevelUpView", package.seeall)

slot0 = class("RoomLevelUpView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_leftbg")
	slot0._simagebg2 = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_rightbg")
	slot0._simageproductlineIcon = gohelper.findChildSingleImage(slot0.viewGO, "root/info/#simage_productIcon")
	slot0._txtnamecn = gohelper.findChildText(slot0.viewGO, "root/info/#txt_namecn")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "root/info/#txt_namecn/#image_icon")
	slot0._btnlevelup = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_levelup")
	slot0._txttip = gohelper.findChildText(slot0.viewGO, "#txt_tip")
	slot0._golevelupInfoItem = gohelper.findChild(slot0.viewGO, "root/scrollview/viewport/content/#go_levelupInfoItem")
	slot0._gocostitem = gohelper.findChild(slot0.viewGO, "root/costs/content/#go_costitem")
	slot0._goblockitem = gohelper.findChild(slot0.viewGO, "root/costs/content/#go_blockitem")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "root/#btn_levelup/#go_reddot")
	slot0._golacktip = gohelper.findChild(slot0.viewGO, "root/#btn_levelup/#go_lacktip")
	slot0._golevelupbeffect = gohelper.findChild(slot0.viewGO, "root/#btn_levelup/#go_reddot/#go_levelupbeffect")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnlevelup:AddClickListener(slot0._btnlevelupOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnlevelup:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnlevelupOnClick(slot0)
	slot1 = RoomMapModel.instance:getRoomLevel()
	slot2, slot3 = RoomInitBuildingHelper.canLevelUp()

	if slot2 then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomLevelUpConfirm, MsgBoxEnum.BoxType.Yes_No, function ()
			RoomRpc.instance:sendRoomLevelUpRequest()
		end)
	elseif slot3 == RoomInitBuildingEnum.CanLevelUpErrorCode.MaxLevel then
		-- Nothing
	elseif slot3 == RoomInitBuildingEnum.CanLevelUpErrorCode.NotEnoughItem then
		GameFacade.showToast(ToastEnum.RoomLevelUpNotItem)
	elseif slot3 == RoomInitBuildingEnum.CanLevelUpErrorCode.NotEnoughBlock then
		GameFacade.showToast(ToastEnum.RoomLevelUpNotBlock)
	end
end

function slot0._btnclickOnClick(slot0, slot1)
	if slot0._costItemList[slot1].param.type == "item" then
		slot4 = slot3.item

		MaterialTipController.instance:showMaterialInfo(slot4.type, slot4.id, nil, , , {
			type = slot4.type,
			id = slot4.id,
			quantity = slot4.quantity,
			sceneType = GameSceneMgr.instance:getCurSceneType(),
			openedViewNameList = JumpController.instance:getCurrentOpenedView()
		})
	elseif slot3.type == "block" and RoomMapBlockModel.instance:getConfirmBlockCount() < slot3.count then
		GameFacade.showToast(ToastEnum.RoomLevelUpNotBlock)
	end
end

function slot0._editableInitView(slot0)
	slot0._simagebg1:LoadImage(ResUrl.getCommonIcon("bg_1"))
	slot0._simagebg2:LoadImage(ResUrl.getCommonIcon("bg_2"))
	slot0._simageproductlineIcon:LoadImage(ResUrl.getRoomProductline("icon_part0"))

	slot0._scene = GameSceneMgr.instance:getCurScene()

	gohelper.setActive(slot0._golevelupInfoItem, false)

	slot0._levelUpInfoItemList = {}

	gohelper.setActive(slot0._gocostitem, false)

	slot0._costItemList = {}

	gohelper.setActive(slot0._txttip.gameObject, false)
	RedDotController.instance:addRedDot(slot0._goreddot, RedDotEnum.DotNode.RoomInitBuildingLevel)
end

function slot0._refreshUI(slot0)
	slot0:_refreshTitleInfo()
	slot0:_refreshLevelUpInfo()
	slot0:_refreshCost()
	slot0:_refreshLevel()
end

function slot0._refreshTitleInfo(slot0)
	slot0._txtnamecn.text = luaLang("room_initbuilding_title")

	UISpriteSetMgr.instance:setRoomSprite(slot0._imageicon, "bg_init_ovr")
	slot0._simageproductlineIcon:LoadImage(ResUrl.getRoomProductline("icon_part0"))
end

function slot0._refreshLevel(slot0)
	gohelper.setActive(slot0._golevelupbeffect, RoomInitBuildingHelper.canLevelUp())
end

function slot0._refreshLevelUpInfo(slot0)
	slot1 = RoomMapModel.instance:getRoomLevel()

	for slot6, slot7 in ipairs(RoomProductionHelper.getRoomLevelUpParams(slot1, slot1 + 1, false)) do
		if not slot0._levelUpInfoItemList[slot6] then
			slot8 = slot0:getUserDataTb_()
			slot8.go = gohelper.cloneInPlace(slot0._golevelupInfoItem, "item" .. slot6)
			slot8.bg = gohelper.findChild(slot8.go, "#txt_levelupInfo/go_bg")
			slot8.curNum = gohelper.findChildText(slot8.go, "#txt_levelupInfo/#txt_curNum")
			slot8.nextNum = gohelper.findChildText(slot8.go, "#txt_levelupInfo/#txt_nextNum")
			slot8.txtdesc = gohelper.findChildText(slot8.go, "#txt_levelupInfo")

			table.insert(slot0._levelUpInfoItemList, slot8)
		end

		slot8.txtdesc.text = slot7.desc
		slot8.curNum.text = slot7.currentDesc
		slot8.nextNum.text = slot7.nextDesc

		gohelper.setActive(slot8.bg, slot6 % 2 ~= 0)
		gohelper.setActive(slot8.go, true)
	end

	for slot6 = #slot2 + 1, #slot0._levelUpInfoItemList do
		gohelper.setActive(slot0._levelUpInfoItemList[slot6].go, false)
	end
end

function slot0._refreshCost(slot0)
	slot1 = {}

	for slot9, slot10 in ipairs(RoomProductionHelper.getFormulaItemParamList(RoomConfig.instance:getRoomLevelConfig(RoomMapModel.instance:getRoomLevel() + 1).cost)) do
		table.insert(slot1, {
			type = "item",
			item = slot10
		})
	end

	slot9 = slot4.needBlockCount

	table.insert(slot1, {
		type = "block",
		count = slot9
	})

	slot0._isCostLack = false

	for slot9, slot10 in ipairs(slot1) do
		if not slot0._costItemList[slot9] then
			slot0:getUserDataTb_().index = slot9

			if slot10.type == "item" then
				slot11.go = gohelper.cloneInPlace(slot0._gocostitem, "item" .. slot9)
				slot11.parent = gohelper.findChild(slot11.go, "go_itempos")
				slot11.itemIcon = IconMgr.instance:getCommonItemIcon(slot11.parent)

				slot11.itemIcon:setOnBeforeClickCallback(JumpController.commonIconBeforeClickSetRecordItem, slot0)
			elseif slot10.type == "block" then
				slot11.go = gohelper.cloneInPlace(slot0._goblockitem, "item" .. slot9)
				slot11.txtcostcount = gohelper.findChildText(slot11.go, "txt_costcount")
				slot11.btnclick = gohelper.findChildButtonWithAudio(slot11.go, "btnclick")

				slot11.btnclick:AddClickListener(slot0._btnclickOnClick, slot0, slot11.index)
			end

			table.insert(slot0._costItemList, slot11)
		end

		slot11.param = slot10
		slot12 = true

		if slot10.type == "block" then
			if slot10.count <= RoomMapBlockModel.instance:getConfirmBlockCount() then
				slot11.txtcostcount.text = string.format("%d/%d", slot14, slot13)
			else
				slot0._isCostLack = true
				slot11.txtcostcount.text = string.format("<color=#d97373>%d</color>/%d", slot14, slot13)
			end
		elseif slot10.type == "item" then
			slot13 = slot10.item

			slot11.itemIcon:setMOValue(slot13.type, slot13.id, slot13.quantity)
			slot11.itemIcon:setCountFontSize(43)

			if slot13.quantity <= ItemModel.instance:getItemQuantity(slot13.type, slot13.id) then
				slot11.itemIcon:getCount().text = string.format("%s/%s", GameUtil.numberDisplay(slot15), GameUtil.numberDisplay(slot13.quantity))
			else
				slot14.text = string.format("<color=#d97373>%s</color>/%s", GameUtil.numberDisplay(slot15), GameUtil.numberDisplay(slot13.quantity))
				slot0._isCostLack = true
			end
		end

		gohelper.setActive(slot11.go, true)
	end

	for slot9 = #slot1 + 1, #slot0._costItemList do
		gohelper.setActive(slot0._costItemList[slot9].go, false)
	end

	gohelper.setActive(slot0._golacktip, false)
	ZProj.UGUIHelper.SetGrayscale(slot0._btnlevelup.gameObject, slot0._isCostLack)
	gohelper.setActive(slot0._golevelupbeffect, not slot0._isCostLack)
end

function slot0._updateRoomLevel(slot0)
	slot2 = RoomConfig.instance:getMaxRoomLevel()

	ViewMgr.instance:openView(ViewName.RoomLevelUpTipsView, {
		level = RoomMapModel.instance:getRoomLevel()
	})
	ViewMgr.instance:closeView(ViewName.RoomLevelUpView, nil, false)
end

function slot0.onOpen(slot0)
	slot0:_refreshUI()
	slot0:addEventCb(RoomMapController.instance, RoomEvent.UpdateRoomLevel, slot0._updateRoomLevel, slot0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_yield_open)
end

function slot0.onClose(slot0)
	if slot0.viewContainer:isManualClose() then
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_close)
	end
end

function slot0.onDestroyView(slot0)
	slot0._simagebg1:UnLoadImage()
	slot0._simagebg2:UnLoadImage()
	slot0._simageproductlineIcon:UnLoadImage()

	for slot4, slot5 in ipairs(slot0._costItemList) do
		if slot5.param.type == "block" then
			slot5.btnclick:RemoveClickListener()
		end
	end
end

return slot0
