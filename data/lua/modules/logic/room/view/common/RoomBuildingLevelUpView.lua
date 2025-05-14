module("modules.logic.room.view.common.RoomBuildingLevelUpView", package.seeall)

local var_0_0 = class("RoomBuildingLevelUpView", BaseView)
local var_0_1 = 43

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageproductIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/info/#simage_productIcon")
	arg_1_0._txtnamecn = gohelper.findChildText(arg_1_0.viewGO, "root/info/#txt_namecn")
	arg_1_0._txtnameen = gohelper.findChildText(arg_1_0.viewGO, "root/info/#txt_namecn/#txt_nameen")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "root/info/#txt_namecn/#image_icon")
	arg_1_0._golevelupInfoItem = gohelper.findChild(arg_1_0.viewGO, "root/levelupInfo/#go_levelupInfoItem")
	arg_1_0._txtlevelupInfo = gohelper.findChildText(arg_1_0.viewGO, "root/levelupInfo/#go_levelupInfoItem/#txt_levelupInfo")
	arg_1_0._txtcurNum = gohelper.findChildText(arg_1_0.viewGO, "root/levelupInfo/#go_levelupInfoItem/#txt_curNum")
	arg_1_0._txtnextNum = gohelper.findChildText(arg_1_0.viewGO, "root/levelupInfo/#go_levelupInfoItem/#txt_nextNum")
	arg_1_0._gocost = gohelper.findChild(arg_1_0.viewGO, "root/costs")
	arg_1_0._gocostitem = gohelper.findChild(arg_1_0.viewGO, "root/costs/content/#go_costitem")
	arg_1_0._btnlevelup = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_levelup")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "root/#btn_levelup/#go_reddot")
	arg_1_0._golevelupbeffect = gohelper.findChild(arg_1_0.viewGO, "root/#btn_levelup/#go_reddot/#go_levelupbeffect")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close")
	arg_1_0._txtNeed = gohelper.findChildText(arg_1_0.viewGO, "root/#txt_need")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnlevelup:AddClickListener(arg_2_0._btnlevelupOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_2_0._onItemChanged, arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0._onItemChanged, arg_2_0)
	arg_2_0:addEventCb(RoomMapController.instance, RoomEvent.BuildingLevelUpPush, arg_2_0._onBuildingLevelUp, arg_2_0)
	arg_2_0:addEventCb(ManufactureController.instance, ManufactureEvent.TradeLevelChange, arg_2_0._onTradeLevelChange, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnlevelup:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_3_0._onItemChanged, arg_3_0)
	arg_3_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0._onItemChanged, arg_3_0)
	arg_3_0:removeEventCb(RoomMapController.instance, RoomEvent.BuildingLevelUpPush, arg_3_0._onBuildingLevelUp, arg_3_0)
	arg_3_0:removeEventCb(ManufactureController.instance, ManufactureEvent.TradeLevelChange, arg_3_0._onTradeLevelChange, arg_3_0)
end

function var_0_0._btnlevelupOnClick(arg_4_0)
	if not arg_4_0._isCanUpgrade then
		if not arg_4_0._costEnough then
			GameFacade.showToast(ToastEnum.RoomUpgradeFailByNotEnough)
		elseif arg_4_0._extraCheckFailToast then
			GameFacade.showToast(arg_4_0._extraCheckFailToast)
		end

		return
	end

	if arg_4_0._costInfoList and #arg_4_0._costInfoList > 0 then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomUpgradeManufactureBuilding, MsgBoxEnum.BoxType.Yes_No, arg_4_0._confirmLevelUp, nil, nil, arg_4_0)
	else
		arg_4_0:_confirmLevelUp()
	end
end

function var_0_0._confirmLevelUp(arg_5_0)
	ManufactureController.instance:upgradeManufactureBuilding(arg_5_0._buildingUid)
end

function var_0_0._btncloseOnClick(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._onItemChanged(arg_7_0)
	arg_7_0:refreshCost()
	arg_7_0:refreshCanUpgrade()
end

function var_0_0._onBuildingLevelUp(arg_8_0, arg_8_1)
	if not arg_8_1 or not arg_8_1[arg_8_0._buildingUid] then
		return
	end

	ViewMgr.instance:closeView(ViewName.RoomBuildingLevelUpView, true, false)
	ViewMgr.instance:openView(ViewName.RoomManufactureBuildingLevelUpTipsView, {
		buildingUid = arg_8_0._buildingUid
	})
end

function var_0_0._onTradeLevelChange(arg_9_0)
	arg_9_0:refreshCanUpgrade()
end

function var_0_0._editableInitView(arg_10_0)
	gohelper.setActive(arg_10_0._golevelupInfoItem, false)
	gohelper.setActive(arg_10_0._gocostitem, false)

	arg_10_0._levelUpInfoItemList = {}
	arg_10_0._costItemList = {}
end

function var_0_0.onUpdateParam(arg_11_0)
	arg_11_0._buildingUid = arg_11_0.viewParam.buildingUid
	arg_11_0._levelUpInfoList = arg_11_0.viewParam.levelUpInfoList
	arg_11_0._costInfoList = arg_11_0.viewParam.costInfoList or {}
	arg_11_0._extraCheckFunc = arg_11_0.viewParam.extraCheckFunc
	arg_11_0._extraCheckFuncObj = arg_11_0.viewParam.extraCheckFuncObj

	arg_11_0:refreshUI()
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0:onUpdateParam()
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_yield_open)
end

function var_0_0.refreshUI(arg_13_0)
	arg_13_0:refreshTitleInfo()
	arg_13_0:refreshLevelUpInfo()
	arg_13_0:refreshCost()
	arg_13_0:refreshCanUpgrade()
end

function var_0_0.refreshTitleInfo(arg_14_0)
	local var_14_0 = RoomMapBuildingModel.instance:getBuildingMOById(arg_14_0._buildingUid)

	arg_14_0._txtnamecn.text = var_14_0.config.name
	arg_14_0._txtnameen.text = var_14_0.config.nameEn

	local var_14_1 = ManufactureConfig.instance:getManufactureBuildingIcon(var_14_0.buildingId)

	UISpriteSetMgr.instance:setRoomSprite(arg_14_0._imageicon, var_14_1)

	local var_14_2 = var_14_0:getLevelUpIcon()

	if not string.nilorempty(var_14_2) then
		arg_14_0._simageproductIcon:LoadImage(ResUrl.getRoomImage("critter/" .. var_14_2))
	else
		local var_14_3 = var_14_0:getIcon()

		arg_14_0._simageproductIcon:LoadImage(ResUrl.getRoomImage("building/" .. var_14_3))
	end
end

function var_0_0.refreshLevelUpInfo(arg_15_0)
	if not arg_15_0._levelUpInfoList then
		return
	end

	for iter_15_0, iter_15_1 in ipairs(arg_15_0._levelUpInfoList) do
		local var_15_0 = arg_15_0._levelUpInfoItemList[iter_15_0]

		if not var_15_0 then
			var_15_0 = arg_15_0:getUserDataTb_()
			var_15_0.go = gohelper.cloneInPlace(arg_15_0._golevelupInfoItem, "item" .. iter_15_0)
			var_15_0.trans = var_15_0.go.transform
			var_15_0.bg = gohelper.findChild(var_15_0.go, "go_bg")
			var_15_0.txtdesc = gohelper.findChildText(var_15_0.go, "#txt_levelupInfo")
			var_15_0.goDesc = gohelper.findChild(var_15_0.go, "#go_desc")
			var_15_0.curNum = gohelper.findChildText(var_15_0.go, "#go_desc/#txt_curNum")
			var_15_0.nextNum = gohelper.findChildText(var_15_0.go, "#go_desc/#txt_nextNum")
			var_15_0.goNewItemLayout = gohelper.findChild(var_15_0.go, "#go_newItemLayout")
			var_15_0.goNewItem = gohelper.findChild(var_15_0.go, "#go_newItemLayout/#go_newItem")

			table.insert(arg_15_0._levelUpInfoItemList, var_15_0)
		end

		var_15_0.txtdesc.text = iter_15_1.desc

		local var_15_1 = recthelper.getHeight(var_15_0.trans)
		local var_15_2 = iter_15_1.newItemInfoList and true or false

		if var_15_2 then
			gohelper.CreateObjList(arg_15_0, arg_15_0._onSetNewItem, iter_15_1.newItemInfoList, var_15_0.goNewItemLayout, var_15_0.goNewItem)

			var_15_1 = recthelper.getHeight(var_15_0.goNewItemLayout.transform)
		else
			var_15_0.curNum.text = iter_15_1.currentDesc
			var_15_0.nextNum.text = iter_15_1.nextDesc
		end

		recthelper.setHeight(var_15_0.trans, var_15_1)
		gohelper.setActive(var_15_0.goDesc, not var_15_2)
		gohelper.setActive(var_15_0.goNewItemLayout, var_15_2)
		gohelper.setActive(var_15_0.bg, iter_15_0 % 2 ~= 0)
		gohelper.setActive(var_15_0.go, true)
	end

	for iter_15_2 = #arg_15_0._levelUpInfoList + 1, #arg_15_0._levelUpInfoItemList do
		local var_15_3 = arg_15_0._levelUpInfoItemList[iter_15_2]

		gohelper.setActive(var_15_3.go, false)
	end
end

function var_0_0._onSetNewItem(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_2.type
	local var_16_1 = arg_16_2.id
	local var_16_2 = arg_16_2.quantity or 0
	local var_16_3 = IconMgr.instance:getCommonItemIcon(arg_16_1)

	var_16_3:setCountFontSize(var_0_1)
	var_16_3:setMOValue(var_16_0, var_16_1, var_16_2)
	var_16_3:isShowCount(var_16_2 ~= 0)
end

function var_0_0.refreshCost(arg_17_0)
	arg_17_0._costEnough = true

	local var_17_0 = arg_17_0._costInfoList and #arg_17_0._costInfoList > 0

	gohelper.setActive(arg_17_0._gocost, var_17_0)

	if not var_17_0 then
		return
	end

	for iter_17_0, iter_17_1 in ipairs(arg_17_0._costInfoList) do
		local var_17_1 = iter_17_1.type
		local var_17_2 = iter_17_1.id
		local var_17_3 = iter_17_1.quantity
		local var_17_4 = ItemModel.instance:getItemQuantity(var_17_1, var_17_2)
		local var_17_5 = var_17_3 <= var_17_4
		local var_17_6 = arg_17_0._costItemList[iter_17_0]

		if not var_17_6 then
			var_17_6 = arg_17_0:getUserDataTb_()
			var_17_6.index = iter_17_0
			var_17_6.go = gohelper.cloneInPlace(arg_17_0._gocostitem, "item" .. iter_17_0)
			var_17_6.parent = gohelper.findChild(var_17_6.go, "go_itempos")
			var_17_6.itemIcon = IconMgr.instance:getCommonItemIcon(var_17_6.parent)

			table.insert(arg_17_0._costItemList, var_17_6)
		end

		var_17_6.itemIcon:setMOValue(var_17_1, var_17_2, var_17_3)
		var_17_6.itemIcon:setCountFontSize(var_0_1)
		var_17_6.itemIcon:setOnBeforeClickCallback(JumpController.commonIconBeforeClickSetRecordItem, arg_17_0)

		local var_17_7 = var_17_1 == MaterialEnum.MaterialType.Currency
		local var_17_8 = ""

		if var_17_5 then
			if var_17_7 then
				var_17_8 = GameUtil.numberDisplay(var_17_3)
			else
				var_17_8 = string.format("%s/%s", GameUtil.numberDisplay(var_17_4), GameUtil.numberDisplay(var_17_3))
			end
		elseif var_17_7 then
			var_17_8 = string.format("<color=#d97373>%s</color>", GameUtil.numberDisplay(var_17_3))
		else
			var_17_8 = string.format("<color=#d97373>%s</color>/%s", GameUtil.numberDisplay(var_17_4), GameUtil.numberDisplay(var_17_3))
		end

		var_17_6.itemIcon:getCount().text = var_17_8
		arg_17_0._costEnough = arg_17_0._costEnough and var_17_5

		gohelper.setActive(var_17_6.go, true)
	end

	for iter_17_2 = #arg_17_0._costInfoList + 1, #arg_17_0._costItemList do
		local var_17_9 = arg_17_0._costItemList[iter_17_2]

		gohelper.setActive(var_17_9.go, false)
	end
end

function var_0_0.refreshCanUpgrade(arg_18_0)
	local var_18_0 = true
	local var_18_1
	local var_18_2

	if arg_18_0._extraCheckFunc then
		var_18_0, var_18_1, var_18_2 = arg_18_0._extraCheckFunc(arg_18_0._extraCheckFuncObj, arg_18_0._buildingUid)
		arg_18_0._txtNeed.text = var_18_2 or ""
	end

	gohelper.setActive(arg_18_0._txtNeed, var_18_2)

	arg_18_0._isCanUpgrade = var_18_0 and arg_18_0._costEnough
	arg_18_0._extraCheckFailToast = var_18_1

	ZProj.UGUIHelper.SetGrayscale(arg_18_0._btnlevelup.gameObject, not arg_18_0._isCanUpgrade)
	gohelper.setActive(arg_18_0._golevelupbeffect, arg_18_0._isCanUpgrade)
end

function var_0_0.onClose(arg_19_0)
	return
end

function var_0_0.onDestroyView(arg_20_0)
	arg_20_0._simageproductIcon:UnLoadImage()
end

return var_0_0
