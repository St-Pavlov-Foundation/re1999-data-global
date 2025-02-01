module("modules.logic.room.view.RoomProductLineLevelUpView", package.seeall)

slot0 = class("RoomProductLineLevelUpView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageleftbg = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_leftbg")
	slot0._simagerightbg = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_rightbg")
	slot0._simageproductlineIcon = gohelper.findChildSingleImage(slot0.viewGO, "root/info/#simage_productIcon")
	slot0._txtnamecn = gohelper.findChildText(slot0.viewGO, "root/info/#txt_namecn")
	slot0._txtnamen = gohelper.findChildText(slot0.viewGO, "root/info/#txt_namecn/#txt_nameen")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "root/info/#txt_namecn/#image_icon")
	slot0._golevelupInfoItem = gohelper.findChild(slot0.viewGO, "root/levelupInfo/#go_levelupInfoItem")
	slot0._gocostitem = gohelper.findChild(slot0.viewGO, "root/costs/content/#go_costitem")
	slot0._btnlevelup = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_levelup")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "root/#btn_levelup/#go_reddot")
	slot0._golacktip = gohelper.findChild(slot0.viewGO, "root/#btn_levelup/#go_lacktip")
	slot0._txtroomLvTips = gohelper.findChildTextMesh(slot0.viewGO, "root/#btn_levelup/#txt_roomLvTips")
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
	if not slot0._costEnough then
		GameFacade.showToast(ToastEnum.RoomProductNotCost)

		return
	end

	if slot0._isMaxLevel == false then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomProductLineLevelUpConfirm, MsgBoxEnum.BoxType.Yes_No, function ()
			RoomRpc.instance:sendProductionLineLvUpRequest(uv0._productionLineMO.id, uv0._tarLevel)
		end)
	else
		GameFacade.showToast(ToastEnum.RoomProductIsMaxLev)
	end
end

function slot0._editableInitView(slot0)
	slot0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	slot0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))

	slot0._scene = GameSceneMgr.instance:getCurScene()

	gohelper.setActive(slot0._golevelupInfoItem, false)

	slot0._levelUpInfoItemList = {}

	gohelper.setActive(slot0._gocostitem, false)

	slot0._costItemList = {}

	gohelper.removeUIClickAudio(slot0._btnclose.gameObject)
end

function slot0.onUpdateParam(slot0)
	slot0._productionLineMO = slot0.viewParam.lineMO
	slot0._selectPartId = slot0.viewParam.selectPartId or 0

	slot0:_refreshUI()
end

function slot0.onOpen(slot0)
	slot0._selectPartId = slot0.viewParam.selectPartId or 0
	slot0._productionLineMO = slot0.viewParam.lineMO

	slot0:addEventCb(RoomController.instance, RoomEvent.ProduceLineLevelUp, slot0._onLevelUp, slot0)
	slot0:_refreshUI()
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_yield_open)
end

function slot0.onClose(slot0)
	slot0:removeEventCb(RoomController.instance, RoomEvent.ProduceLineLevelUp, slot0._onLevelUp, slot0)

	if slot0.viewContainer:isManualClose() then
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_close)
	end
end

function slot0._onLevelUp(slot0)
	ViewMgr.instance:openView(ViewName.RoomLevelUpTipsView, {
		productLineMO = slot0._productionLineMO
	})
	ViewMgr.instance:closeView(ViewName.RoomProductLineLevelUpView, nil, false)
end

function slot0._refreshUI(slot0)
	slot0._tarLevel = math.min(slot0._productionLineMO.maxConfigLevel, slot0._productionLineMO.level + 1)
	slot0._isMaxLevel = slot0._productionLineMO.level == slot0._productionLineMO.maxLevel
	slot0._isMaxConfigLevel = slot0._productionLineMO.level == slot0._productionLineMO.maxConfigLevel
	slot0._costEnough = true

	slot0:_refreshLevelUpInfo()
	slot0:_refreshTitleInfo()
	slot0:_refreshCost()
	slot0:_refreshLevel()

	slot0._productionLineMO = slot0.viewParam.lineMO
	slot0._selectPartId = slot0.viewParam.selectPartId or 0

	RedDotController.instance:addRedDot(slot0._goreddot, RedDotEnum.DotNode.RoomProductionLevel, slot0._productionLineMO.id)
end

function slot0._refreshTitleInfo(slot0)
	slot2 = string.nilorempty(slot0._productionLineMO.config.name) and "" or "·" .. slot0._productionLineMO.config.name

	if RoomProductionHelper.getPartType(RoomConfig.instance:getProductionPartConfig(slot0._selectPartId).id) == RoomProductLineEnum.ProductType.Change then
		slot2 = ""
	end

	slot0._txtnamecn.text = string.format("%s%s", slot1.name, slot2)
	slot0._txtnamen.text = slot1.nameEn

	UISpriteSetMgr.instance:setRoomSprite(slot0._imageicon, "bg_part" .. slot0._selectPartId)
	slot0._simageproductlineIcon:LoadImage(ResUrl.getRoomProductline("icon_part" .. slot0._selectPartId))
end

function slot0._refreshLevel(slot0)
	slot1 = slot0._productionLineMO.level

	ZProj.UGUIHelper.SetGrayscale(slot0._btnlevelup.gameObject, slot0._isMaxLevel or not slot0._costEnough)
	gohelper.setActive(slot0._golacktip, false)
	gohelper.setActive(slot0._golevelupbeffect, not slot0._isMaxLevel and slot0._costEnough)

	if RoomConfig.instance:getProductionLineLevelConfig(slot0._productionLineMO.config.levelGroup, slot0._tarLevel) and RoomModel.instance:getRoomLevel() < slot2.needRoomLevel and slot0._costEnough then
		slot0._txtroomLvTips.text = formatLuaLang("roomproductlinelevelup_roomtips", slot2.needRoomLevel)
	else
		slot0._txtroomLvTips.text = ""
	end
end

function slot0._refreshLevelUpInfo(slot0)
	slot1 = {}

	if slot0._isMaxConfigLevel == false then
		slot1 = RoomProductionHelper.getProductLineLevelUpParams(slot0._productionLineMO.id, slot0._productionLineMO.level, slot0._tarLevel, false)
	end

	for slot5, slot6 in ipairs(slot1) do
		if not slot0._levelUpInfoItemList[slot5] then
			slot7 = slot0:getUserDataTb_()
			slot7.go = gohelper.cloneInPlace(slot0._golevelupInfoItem, "item" .. slot5)
			slot7.bg = gohelper.findChild(slot7.go, "go_bg")
			slot7.curNum = gohelper.findChildText(slot7.go, "#txt_levelupInfo/#txt_curNum")
			slot7.nextNum = gohelper.findChildText(slot7.go, "#txt_levelupInfo/#txt_nextNum")
			slot7.txtdesc = gohelper.findChildText(slot7.go, "#txt_levelupInfo")

			table.insert(slot0._levelUpInfoItemList, slot7)
		end

		slot7.txtdesc.text = slot6.desc
		slot7.curNum.text = slot6.currentDesc
		slot7.nextNum.text = slot6.nextDesc

		gohelper.setActive(slot7.bg, slot5 % 2 ~= 0)
		gohelper.setActive(slot7.go, true)
	end

	for slot5 = #slot1 + 1, #slot0._levelUpInfoItemList do
		gohelper.setActive(slot0._levelUpInfoItemList[slot5].go, false)
	end
end

function slot0._refreshCost(slot0)
	slot1 = {}

	if slot0._isMaxConfigLevel == false then
		slot1 = GameUtil.splitString2(RoomConfig.instance:getProductionLineLevelConfig(slot0._productionLineMO.config.levelGroup, slot0._tarLevel).cost, true)
	end

	for slot5, slot6 in ipairs(slot1) do
		if not slot0._costItemList[slot5] then
			slot7 = slot0:getUserDataTb_()
			slot7.index = slot5
			slot7.go = gohelper.cloneInPlace(slot0._gocostitem, "item" .. slot5)
			slot7.parent = gohelper.findChild(slot7.go, "go_itempos")
			slot7.itemIcon = IconMgr.instance:getCommonItemIcon(slot7.parent)

			table.insert(slot0._costItemList, slot7)
		end

		slot7.param = slot6
		slot8 = true

		slot7.itemIcon:setMOValue(slot9, slot10, slot11)
		slot7.itemIcon:setCountFontSize(43)
		slot7.itemIcon:setOnBeforeClickCallback(JumpController.commonIconBeforeClickSetRecordItem, slot0)

		if slot6[3] <= ItemModel.instance:getItemQuantity(slot6[1], slot6[2]) then
			slot7.itemIcon:getCount().text = string.format("%s/%s", GameUtil.numberDisplay(slot12), GameUtil.numberDisplay(slot11))
		else
			slot13.text = string.format("<color=#d97373>%s</color>/%s", GameUtil.numberDisplay(slot12), GameUtil.numberDisplay(slot11))
		end

		slot14 = slot6.item
		slot0._costEnough = slot0._costEnough and slot8

		gohelper.setActive(slot7.go, true)
	end

	for slot5 = #slot1 + 1, #slot0._costItemList do
		gohelper.setActive(slot0._costItemList[slot5].go, false)
	end
end

function slot0._btnclickOnClick(slot0, slot1)
	slot3 = slot0._costItemList[slot1].param

	MaterialTipController.instance:showMaterialInfo(slot3[1], slot3[2], nil, , , {
		type = slot3[1],
		id = slot3[2],
		quantity = slot3[3],
		sceneType = GameSceneMgr.instance:getCurSceneType(),
		openedViewNameList = JumpController.instance:getCurrentOpenedView()
	})
end

function slot0.onDestroyView(slot0)
	slot0._simageleftbg:UnLoadImage()
	slot0._simagerightbg:UnLoadImage()
	slot0._simageproductlineIcon:UnLoadImage()
end

return slot0
