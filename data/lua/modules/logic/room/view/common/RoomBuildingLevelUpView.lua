module("modules.logic.room.view.common.RoomBuildingLevelUpView", package.seeall)

slot0 = class("RoomBuildingLevelUpView", BaseView)
slot1 = 43

function slot0.onInitView(slot0)
	slot0._simageproductIcon = gohelper.findChildSingleImage(slot0.viewGO, "root/info/#simage_productIcon")
	slot0._txtnamecn = gohelper.findChildText(slot0.viewGO, "root/info/#txt_namecn")
	slot0._txtnameen = gohelper.findChildText(slot0.viewGO, "root/info/#txt_namecn/#txt_nameen")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "root/info/#txt_namecn/#image_icon")
	slot0._golevelupInfoItem = gohelper.findChild(slot0.viewGO, "root/levelupInfo/#go_levelupInfoItem")
	slot0._txtlevelupInfo = gohelper.findChildText(slot0.viewGO, "root/levelupInfo/#go_levelupInfoItem/#txt_levelupInfo")
	slot0._txtcurNum = gohelper.findChildText(slot0.viewGO, "root/levelupInfo/#go_levelupInfoItem/#txt_curNum")
	slot0._txtnextNum = gohelper.findChildText(slot0.viewGO, "root/levelupInfo/#go_levelupInfoItem/#txt_nextNum")
	slot0._gocost = gohelper.findChild(slot0.viewGO, "root/costs")
	slot0._gocostitem = gohelper.findChild(slot0.viewGO, "root/costs/content/#go_costitem")
	slot0._btnlevelup = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_levelup")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "root/#btn_levelup/#go_reddot")
	slot0._golevelupbeffect = gohelper.findChild(slot0.viewGO, "root/#btn_levelup/#go_reddot/#go_levelupbeffect")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_close")
	slot0._txtNeed = gohelper.findChildText(slot0.viewGO, "root/#txt_need")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnlevelup:AddClickListener(slot0._btnlevelupOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._onItemChanged, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onItemChanged, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.BuildingLevelUpPush, slot0._onBuildingLevelUp, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.TradeLevelChange, slot0._onTradeLevelChange, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnlevelup:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	slot0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._onItemChanged, slot0)
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onItemChanged, slot0)
	slot0:removeEventCb(RoomMapController.instance, RoomEvent.BuildingLevelUpPush, slot0._onBuildingLevelUp, slot0)
	slot0:removeEventCb(ManufactureController.instance, ManufactureEvent.TradeLevelChange, slot0._onTradeLevelChange, slot0)
end

function slot0._btnlevelupOnClick(slot0)
	if not slot0._isCanUpgrade then
		if not slot0._costEnough then
			GameFacade.showToast(ToastEnum.RoomUpgradeFailByNotEnough)
		elseif slot0._extraCheckFailToast then
			GameFacade.showToast(slot0._extraCheckFailToast)
		end

		return
	end

	if slot0._costInfoList and #slot0._costInfoList > 0 then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomUpgradeManufactureBuilding, MsgBoxEnum.BoxType.Yes_No, slot0._confirmLevelUp, nil, , slot0)
	else
		slot0:_confirmLevelUp()
	end
end

function slot0._confirmLevelUp(slot0)
	ManufactureController.instance:upgradeManufactureBuilding(slot0._buildingUid)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._onItemChanged(slot0)
	slot0:refreshCost()
	slot0:refreshCanUpgrade()
end

function slot0._onBuildingLevelUp(slot0, slot1)
	if not slot1 or not slot1[slot0._buildingUid] then
		return
	end

	ViewMgr.instance:closeView(ViewName.RoomBuildingLevelUpView, true, false)
	ViewMgr.instance:openView(ViewName.RoomManufactureBuildingLevelUpTipsView, {
		buildingUid = slot0._buildingUid
	})
end

function slot0._onTradeLevelChange(slot0)
	slot0:refreshCanUpgrade()
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._golevelupInfoItem, false)
	gohelper.setActive(slot0._gocostitem, false)

	slot0._levelUpInfoItemList = {}
	slot0._costItemList = {}
end

function slot0.onUpdateParam(slot0)
	slot0._buildingUid = slot0.viewParam.buildingUid
	slot0._levelUpInfoList = slot0.viewParam.levelUpInfoList
	slot0._costInfoList = slot0.viewParam.costInfoList or {}
	slot0._extraCheckFunc = slot0.viewParam.extraCheckFunc
	slot0._extraCheckFuncObj = slot0.viewParam.extraCheckFuncObj

	slot0:refreshUI()
end

function slot0.onOpen(slot0)
	slot0:onUpdateParam()
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_yield_open)
end

function slot0.refreshUI(slot0)
	slot0:refreshTitleInfo()
	slot0:refreshLevelUpInfo()
	slot0:refreshCost()
	slot0:refreshCanUpgrade()
end

function slot0.refreshTitleInfo(slot0)
	slot1 = RoomMapBuildingModel.instance:getBuildingMOById(slot0._buildingUid)
	slot0._txtnamecn.text = slot1.config.name
	slot0._txtnameen.text = slot1.config.nameEn

	UISpriteSetMgr.instance:setRoomSprite(slot0._imageicon, ManufactureConfig.instance:getManufactureBuildingIcon(slot1.buildingId))

	if not string.nilorempty(slot1:getLevelUpIcon()) then
		slot0._simageproductIcon:LoadImage(ResUrl.getRoomImage("critter/" .. slot3))
	else
		slot0._simageproductIcon:LoadImage(ResUrl.getRoomImage("building/" .. slot1:getIcon()))
	end
end

function slot0.refreshLevelUpInfo(slot0)
	if not slot0._levelUpInfoList then
		return
	end

	for slot4, slot5 in ipairs(slot0._levelUpInfoList) do
		if not slot0._levelUpInfoItemList[slot4] then
			slot6 = slot0:getUserDataTb_()
			slot6.go = gohelper.cloneInPlace(slot0._golevelupInfoItem, "item" .. slot4)
			slot6.trans = slot6.go.transform
			slot6.bg = gohelper.findChild(slot6.go, "go_bg")
			slot6.txtdesc = gohelper.findChildText(slot6.go, "#txt_levelupInfo")
			slot6.goDesc = gohelper.findChild(slot6.go, "#go_desc")
			slot6.curNum = gohelper.findChildText(slot6.go, "#go_desc/#txt_curNum")
			slot6.nextNum = gohelper.findChildText(slot6.go, "#go_desc/#txt_nextNum")
			slot6.goNewItemLayout = gohelper.findChild(slot6.go, "#go_newItemLayout")
			slot6.goNewItem = gohelper.findChild(slot6.go, "#go_newItemLayout/#go_newItem")

			table.insert(slot0._levelUpInfoItemList, slot6)
		end

		slot6.txtdesc.text = slot5.desc
		slot7 = recthelper.getHeight(slot6.trans)

		if slot5.newItemInfoList and true or false then
			gohelper.CreateObjList(slot0, slot0._onSetNewItem, slot5.newItemInfoList, slot6.goNewItemLayout, slot6.goNewItem)

			slot7 = recthelper.getHeight(slot6.goNewItemLayout.transform)
		else
			slot6.curNum.text = slot5.currentDesc
			slot6.nextNum.text = slot5.nextDesc
		end

		recthelper.setHeight(slot6.trans, slot7)
		gohelper.setActive(slot6.goDesc, not slot8)
		gohelper.setActive(slot6.goNewItemLayout, slot8)
		gohelper.setActive(slot6.bg, slot4 % 2 ~= 0)
		gohelper.setActive(slot6.go, true)
	end

	for slot4 = #slot0._levelUpInfoList + 1, #slot0._levelUpInfoItemList do
		gohelper.setActive(slot0._levelUpInfoItemList[slot4].go, false)
	end
end

function slot0._onSetNewItem(slot0, slot1, slot2, slot3)
	slot6 = slot2.quantity or 0
	slot7 = IconMgr.instance:getCommonItemIcon(slot1)

	slot7:setCountFontSize(uv0)
	slot7:setMOValue(slot2.type, slot2.id, slot6)
	slot7:isShowCount(slot6 ~= 0)
end

function slot0.refreshCost(slot0)
	slot0._costEnough = true
	slot1 = slot0._costInfoList and #slot0._costInfoList > 0

	gohelper.setActive(slot0._gocost, slot1)

	if not slot1 then
		return
	end

	for slot5, slot6 in ipairs(slot0._costInfoList) do
		slot11 = slot6.quantity <= ItemModel.instance:getItemQuantity(slot6.type, slot6.id)

		if not slot0._costItemList[slot5] then
			slot12 = slot0:getUserDataTb_()
			slot12.index = slot5
			slot12.go = gohelper.cloneInPlace(slot0._gocostitem, "item" .. slot5)
			slot12.parent = gohelper.findChild(slot12.go, "go_itempos")
			slot12.itemIcon = IconMgr.instance:getCommonItemIcon(slot12.parent)

			table.insert(slot0._costItemList, slot12)
		end

		slot12.itemIcon:setMOValue(slot7, slot8, slot9)
		slot12.itemIcon:setCountFontSize(uv0)
		slot12.itemIcon:setOnBeforeClickCallback(JumpController.commonIconBeforeClickSetRecordItem, slot0)

		slot13 = slot7 == MaterialEnum.MaterialType.Currency
		slot14 = ""
		slot12.itemIcon:getCount().text = (not slot11 or (not slot13 or GameUtil.numberDisplay(slot9)) and string.format("%s/%s", GameUtil.numberDisplay(slot10), GameUtil.numberDisplay(slot9))) and (not slot13 or string.format("<color=#d97373>%s</color>", GameUtil.numberDisplay(slot9))) and string.format("<color=#d97373>%s</color>/%s", GameUtil.numberDisplay(slot10), GameUtil.numberDisplay(slot9))
		slot0._costEnough = slot0._costEnough and slot11

		gohelper.setActive(slot12.go, true)
	end

	for slot5 = #slot0._costInfoList + 1, #slot0._costItemList do
		gohelper.setActive(slot0._costItemList[slot5].go, false)
	end
end

function slot0.refreshCanUpgrade(slot0)
	slot1 = true
	slot2, slot3 = nil

	if slot0._extraCheckFunc then
		slot1, slot2, slot6 = slot0._extraCheckFunc(slot0._extraCheckFuncObj, slot0._buildingUid)
		slot0._txtNeed.text = slot6 or ""
	end

	gohelper.setActive(slot0._txtNeed, slot3)

	slot0._isCanUpgrade = slot1 and slot0._costEnough
	slot0._extraCheckFailToast = slot2

	ZProj.UGUIHelper.SetGrayscale(slot0._btnlevelup.gameObject, not slot0._isCanUpgrade)
	gohelper.setActive(slot0._golevelupbeffect, slot0._isCanUpgrade)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageproductIcon:UnLoadImage()
end

return slot0
