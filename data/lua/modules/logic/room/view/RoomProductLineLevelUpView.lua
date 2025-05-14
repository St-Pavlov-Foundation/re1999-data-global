module("modules.logic.room.view.RoomProductLineLevelUpView", package.seeall)

local var_0_0 = class("RoomProductLineLevelUpView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageleftbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_leftbg")
	arg_1_0._simagerightbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_rightbg")
	arg_1_0._simageproductlineIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/info/#simage_productIcon")
	arg_1_0._txtnamecn = gohelper.findChildText(arg_1_0.viewGO, "root/info/#txt_namecn")
	arg_1_0._txtnamen = gohelper.findChildText(arg_1_0.viewGO, "root/info/#txt_namecn/#txt_nameen")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "root/info/#txt_namecn/#image_icon")
	arg_1_0._golevelupInfoItem = gohelper.findChild(arg_1_0.viewGO, "root/levelupInfo/#go_levelupInfoItem")
	arg_1_0._gocostitem = gohelper.findChild(arg_1_0.viewGO, "root/costs/content/#go_costitem")
	arg_1_0._btnlevelup = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_levelup")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "root/#btn_levelup/#go_reddot")
	arg_1_0._golacktip = gohelper.findChild(arg_1_0.viewGO, "root/#btn_levelup/#go_lacktip")
	arg_1_0._txtroomLvTips = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/#btn_levelup/#txt_roomLvTips")
	arg_1_0._golevelupbeffect = gohelper.findChild(arg_1_0.viewGO, "root/#btn_levelup/#go_reddot/#go_levelupbeffect")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnlevelup:AddClickListener(arg_2_0._btnlevelupOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnlevelup:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnlevelupOnClick(arg_5_0)
	if not arg_5_0._costEnough then
		GameFacade.showToast(ToastEnum.RoomProductNotCost)

		return
	end

	if arg_5_0._isMaxLevel == false then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomProductLineLevelUpConfirm, MsgBoxEnum.BoxType.Yes_No, function()
			RoomRpc.instance:sendProductionLineLvUpRequest(arg_5_0._productionLineMO.id, arg_5_0._tarLevel)
		end)
	else
		GameFacade.showToast(ToastEnum.RoomProductIsMaxLev)
	end
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	arg_7_0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))

	arg_7_0._scene = GameSceneMgr.instance:getCurScene()

	gohelper.setActive(arg_7_0._golevelupInfoItem, false)

	arg_7_0._levelUpInfoItemList = {}

	gohelper.setActive(arg_7_0._gocostitem, false)

	arg_7_0._costItemList = {}

	gohelper.removeUIClickAudio(arg_7_0._btnclose.gameObject)
end

function var_0_0.onUpdateParam(arg_8_0)
	arg_8_0._productionLineMO = arg_8_0.viewParam.lineMO
	arg_8_0._selectPartId = arg_8_0.viewParam.selectPartId or 0

	arg_8_0:_refreshUI()
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0._selectPartId = arg_9_0.viewParam.selectPartId or 0
	arg_9_0._productionLineMO = arg_9_0.viewParam.lineMO

	arg_9_0:addEventCb(RoomController.instance, RoomEvent.ProduceLineLevelUp, arg_9_0._onLevelUp, arg_9_0)
	arg_9_0:_refreshUI()
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_yield_open)
end

function var_0_0.onClose(arg_10_0)
	arg_10_0:removeEventCb(RoomController.instance, RoomEvent.ProduceLineLevelUp, arg_10_0._onLevelUp, arg_10_0)

	if arg_10_0.viewContainer:isManualClose() then
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_close)
	end
end

function var_0_0._onLevelUp(arg_11_0)
	ViewMgr.instance:openView(ViewName.RoomLevelUpTipsView, {
		productLineMO = arg_11_0._productionLineMO
	})
	ViewMgr.instance:closeView(ViewName.RoomProductLineLevelUpView, nil, false)
end

function var_0_0._refreshUI(arg_12_0)
	local var_12_0 = arg_12_0._productionLineMO.maxConfigLevel
	local var_12_1 = arg_12_0._productionLineMO.level

	arg_12_0._tarLevel = math.min(var_12_0, var_12_1 + 1)
	arg_12_0._isMaxLevel = arg_12_0._productionLineMO.level == arg_12_0._productionLineMO.maxLevel
	arg_12_0._isMaxConfigLevel = arg_12_0._productionLineMO.level == arg_12_0._productionLineMO.maxConfigLevel
	arg_12_0._costEnough = true

	arg_12_0:_refreshLevelUpInfo()
	arg_12_0:_refreshTitleInfo()
	arg_12_0:_refreshCost()
	arg_12_0:_refreshLevel()

	arg_12_0._productionLineMO = arg_12_0.viewParam.lineMO
	arg_12_0._selectPartId = arg_12_0.viewParam.selectPartId or 0

	RedDotController.instance:addRedDot(arg_12_0._goreddot, RedDotEnum.DotNode.RoomProductionLevel, arg_12_0._productionLineMO.id)
end

function var_0_0._refreshTitleInfo(arg_13_0)
	local var_13_0 = RoomConfig.instance:getProductionPartConfig(arg_13_0._selectPartId)
	local var_13_1 = string.nilorempty(arg_13_0._productionLineMO.config.name) and "" or "·" .. arg_13_0._productionLineMO.config.name

	if RoomProductionHelper.getPartType(var_13_0.id) == RoomProductLineEnum.ProductType.Change then
		var_13_1 = ""
	end

	arg_13_0._txtnamecn.text = string.format("%s%s", var_13_0.name, var_13_1)
	arg_13_0._txtnamen.text = var_13_0.nameEn

	UISpriteSetMgr.instance:setRoomSprite(arg_13_0._imageicon, "bg_part" .. arg_13_0._selectPartId)
	arg_13_0._simageproductlineIcon:LoadImage(ResUrl.getRoomProductline("icon_part" .. arg_13_0._selectPartId))
end

function var_0_0._refreshLevel(arg_14_0)
	local var_14_0 = arg_14_0._productionLineMO.level

	ZProj.UGUIHelper.SetGrayscale(arg_14_0._btnlevelup.gameObject, arg_14_0._isMaxLevel or not arg_14_0._costEnough)
	gohelper.setActive(arg_14_0._golacktip, false)
	gohelper.setActive(arg_14_0._golevelupbeffect, not arg_14_0._isMaxLevel and arg_14_0._costEnough)

	local var_14_1 = RoomConfig.instance:getProductionLineLevelConfig(arg_14_0._productionLineMO.config.levelGroup, arg_14_0._tarLevel)

	if var_14_1 and var_14_1.needRoomLevel > RoomModel.instance:getRoomLevel() and arg_14_0._costEnough then
		arg_14_0._txtroomLvTips.text = formatLuaLang("roomproductlinelevelup_roomtips", var_14_1.needRoomLevel)
	else
		arg_14_0._txtroomLvTips.text = ""
	end
end

function var_0_0._refreshLevelUpInfo(arg_15_0)
	local var_15_0 = {}

	if arg_15_0._isMaxConfigLevel == false then
		var_15_0 = RoomProductionHelper.getProductLineLevelUpParams(arg_15_0._productionLineMO.id, arg_15_0._productionLineMO.level, arg_15_0._tarLevel, false)
	end

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		local var_15_1 = arg_15_0._levelUpInfoItemList[iter_15_0]

		if not var_15_1 then
			var_15_1 = arg_15_0:getUserDataTb_()
			var_15_1.go = gohelper.cloneInPlace(arg_15_0._golevelupInfoItem, "item" .. iter_15_0)
			var_15_1.bg = gohelper.findChild(var_15_1.go, "go_bg")
			var_15_1.curNum = gohelper.findChildText(var_15_1.go, "#txt_levelupInfo/#txt_curNum")
			var_15_1.nextNum = gohelper.findChildText(var_15_1.go, "#txt_levelupInfo/#txt_nextNum")
			var_15_1.txtdesc = gohelper.findChildText(var_15_1.go, "#txt_levelupInfo")

			table.insert(arg_15_0._levelUpInfoItemList, var_15_1)
		end

		var_15_1.txtdesc.text = iter_15_1.desc
		var_15_1.curNum.text = iter_15_1.currentDesc
		var_15_1.nextNum.text = iter_15_1.nextDesc

		gohelper.setActive(var_15_1.bg, iter_15_0 % 2 ~= 0)
		gohelper.setActive(var_15_1.go, true)
	end

	for iter_15_2 = #var_15_0 + 1, #arg_15_0._levelUpInfoItemList do
		local var_15_2 = arg_15_0._levelUpInfoItemList[iter_15_2]

		gohelper.setActive(var_15_2.go, false)
	end
end

function var_0_0._refreshCost(arg_16_0)
	local var_16_0 = {}

	if arg_16_0._isMaxConfigLevel == false then
		local var_16_1 = RoomConfig.instance:getProductionLineLevelConfig(arg_16_0._productionLineMO.config.levelGroup, arg_16_0._tarLevel).cost

		var_16_0 = GameUtil.splitString2(var_16_1, true)
	end

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		local var_16_2 = arg_16_0._costItemList[iter_16_0]

		if not var_16_2 then
			var_16_2 = arg_16_0:getUserDataTb_()
			var_16_2.index = iter_16_0
			var_16_2.go = gohelper.cloneInPlace(arg_16_0._gocostitem, "item" .. iter_16_0)
			var_16_2.parent = gohelper.findChild(var_16_2.go, "go_itempos")
			var_16_2.itemIcon = IconMgr.instance:getCommonItemIcon(var_16_2.parent)

			table.insert(arg_16_0._costItemList, var_16_2)
		end

		var_16_2.param = iter_16_1

		local var_16_3 = true
		local var_16_4 = iter_16_1[1]
		local var_16_5 = iter_16_1[2]
		local var_16_6 = iter_16_1[3]
		local var_16_7 = ItemModel.instance:getItemQuantity(var_16_4, var_16_5)
		local var_16_8 = var_16_6 <= var_16_7

		var_16_2.itemIcon:setMOValue(var_16_4, var_16_5, var_16_6)
		var_16_2.itemIcon:setCountFontSize(43)
		var_16_2.itemIcon:setOnBeforeClickCallback(JumpController.commonIconBeforeClickSetRecordItem, arg_16_0)

		local var_16_9 = var_16_2.itemIcon:getCount()

		if var_16_8 then
			var_16_9.text = string.format("%s/%s", GameUtil.numberDisplay(var_16_7), GameUtil.numberDisplay(var_16_6))
		else
			var_16_9.text = string.format("<color=#d97373>%s</color>/%s", GameUtil.numberDisplay(var_16_7), GameUtil.numberDisplay(var_16_6))
		end

		local var_16_10 = iter_16_1.item

		arg_16_0._costEnough = arg_16_0._costEnough and var_16_8

		gohelper.setActive(var_16_2.go, true)
	end

	for iter_16_2 = #var_16_0 + 1, #arg_16_0._costItemList do
		local var_16_11 = arg_16_0._costItemList[iter_16_2]

		gohelper.setActive(var_16_11.go, false)
	end
end

function var_0_0._btnclickOnClick(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0._costItemList[arg_17_1].param

	MaterialTipController.instance:showMaterialInfo(var_17_0[1], var_17_0[2], nil, nil, nil, {
		type = var_17_0[1],
		id = var_17_0[2],
		quantity = var_17_0[3],
		sceneType = GameSceneMgr.instance:getCurSceneType(),
		openedViewNameList = JumpController.instance:getCurrentOpenedView()
	})
end

function var_0_0.onDestroyView(arg_18_0)
	arg_18_0._simageleftbg:UnLoadImage()
	arg_18_0._simagerightbg:UnLoadImage()
	arg_18_0._simageproductlineIcon:UnLoadImage()
end

return var_0_0
