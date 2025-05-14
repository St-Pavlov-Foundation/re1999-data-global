module("modules.logic.room.view.RoomLevelUpView", package.seeall)

local var_0_0 = class("RoomLevelUpView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_leftbg")
	arg_1_0._simagebg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "bg/#simage_rightbg")
	arg_1_0._simageproductlineIcon = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/info/#simage_productIcon")
	arg_1_0._txtnamecn = gohelper.findChildText(arg_1_0.viewGO, "root/info/#txt_namecn")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "root/info/#txt_namecn/#image_icon")
	arg_1_0._btnlevelup = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_levelup")
	arg_1_0._txttip = gohelper.findChildText(arg_1_0.viewGO, "#txt_tip")
	arg_1_0._golevelupInfoItem = gohelper.findChild(arg_1_0.viewGO, "root/scrollview/viewport/content/#go_levelupInfoItem")
	arg_1_0._gocostitem = gohelper.findChild(arg_1_0.viewGO, "root/costs/content/#go_costitem")
	arg_1_0._goblockitem = gohelper.findChild(arg_1_0.viewGO, "root/costs/content/#go_blockitem")
	arg_1_0._goreddot = gohelper.findChild(arg_1_0.viewGO, "root/#btn_levelup/#go_reddot")
	arg_1_0._golacktip = gohelper.findChild(arg_1_0.viewGO, "root/#btn_levelup/#go_lacktip")
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
	local var_5_0 = RoomMapModel.instance:getRoomLevel()
	local var_5_1, var_5_2 = RoomInitBuildingHelper.canLevelUp()

	if var_5_1 then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomLevelUpConfirm, MsgBoxEnum.BoxType.Yes_No, function()
			RoomRpc.instance:sendRoomLevelUpRequest()
		end)
	elseif var_5_2 == RoomInitBuildingEnum.CanLevelUpErrorCode.MaxLevel then
		-- block empty
	elseif var_5_2 == RoomInitBuildingEnum.CanLevelUpErrorCode.NotEnoughItem then
		GameFacade.showToast(ToastEnum.RoomLevelUpNotItem)
	elseif var_5_2 == RoomInitBuildingEnum.CanLevelUpErrorCode.NotEnoughBlock then
		GameFacade.showToast(ToastEnum.RoomLevelUpNotBlock)
	end
end

function var_0_0._btnclickOnClick(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._costItemList[arg_7_1].param

	if var_7_0.type == "item" then
		local var_7_1 = var_7_0.item

		MaterialTipController.instance:showMaterialInfo(var_7_1.type, var_7_1.id, nil, nil, nil, {
			type = var_7_1.type,
			id = var_7_1.id,
			quantity = var_7_1.quantity,
			sceneType = GameSceneMgr.instance:getCurSceneType(),
			openedViewNameList = JumpController.instance:getCurrentOpenedView()
		})
	elseif var_7_0.type == "block" and RoomMapBlockModel.instance:getConfirmBlockCount() < var_7_0.count then
		GameFacade.showToast(ToastEnum.RoomLevelUpNotBlock)
	end
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._simagebg1:LoadImage(ResUrl.getCommonIcon("bg_1"))
	arg_8_0._simagebg2:LoadImage(ResUrl.getCommonIcon("bg_2"))
	arg_8_0._simageproductlineIcon:LoadImage(ResUrl.getRoomProductline("icon_part0"))

	arg_8_0._scene = GameSceneMgr.instance:getCurScene()

	gohelper.setActive(arg_8_0._golevelupInfoItem, false)

	arg_8_0._levelUpInfoItemList = {}

	gohelper.setActive(arg_8_0._gocostitem, false)

	arg_8_0._costItemList = {}

	gohelper.setActive(arg_8_0._txttip.gameObject, false)
	RedDotController.instance:addRedDot(arg_8_0._goreddot, RedDotEnum.DotNode.RoomInitBuildingLevel)
end

function var_0_0._refreshUI(arg_9_0)
	arg_9_0:_refreshTitleInfo()
	arg_9_0:_refreshLevelUpInfo()
	arg_9_0:_refreshCost()
	arg_9_0:_refreshLevel()
end

function var_0_0._refreshTitleInfo(arg_10_0)
	arg_10_0._txtnamecn.text = luaLang("room_initbuilding_title")

	UISpriteSetMgr.instance:setRoomSprite(arg_10_0._imageicon, "bg_init_ovr")
	arg_10_0._simageproductlineIcon:LoadImage(ResUrl.getRoomProductline("icon_part0"))
end

function var_0_0._refreshLevel(arg_11_0)
	local var_11_0 = RoomInitBuildingHelper.canLevelUp()

	gohelper.setActive(arg_11_0._golevelupbeffect, var_11_0)
end

function var_0_0._refreshLevelUpInfo(arg_12_0)
	local var_12_0 = RoomMapModel.instance:getRoomLevel()
	local var_12_1 = RoomProductionHelper.getRoomLevelUpParams(var_12_0, var_12_0 + 1, false)

	for iter_12_0, iter_12_1 in ipairs(var_12_1) do
		local var_12_2 = arg_12_0._levelUpInfoItemList[iter_12_0]

		if not var_12_2 then
			var_12_2 = arg_12_0:getUserDataTb_()
			var_12_2.go = gohelper.cloneInPlace(arg_12_0._golevelupInfoItem, "item" .. iter_12_0)
			var_12_2.bg = gohelper.findChild(var_12_2.go, "#txt_levelupInfo/go_bg")
			var_12_2.curNum = gohelper.findChildText(var_12_2.go, "#txt_levelupInfo/#txt_curNum")
			var_12_2.nextNum = gohelper.findChildText(var_12_2.go, "#txt_levelupInfo/#txt_nextNum")
			var_12_2.txtdesc = gohelper.findChildText(var_12_2.go, "#txt_levelupInfo")

			table.insert(arg_12_0._levelUpInfoItemList, var_12_2)
		end

		var_12_2.txtdesc.text = iter_12_1.desc
		var_12_2.curNum.text = iter_12_1.currentDesc
		var_12_2.nextNum.text = iter_12_1.nextDesc

		gohelper.setActive(var_12_2.bg, iter_12_0 % 2 ~= 0)
		gohelper.setActive(var_12_2.go, true)
	end

	for iter_12_2 = #var_12_1 + 1, #arg_12_0._levelUpInfoItemList do
		local var_12_3 = arg_12_0._levelUpInfoItemList[iter_12_2]

		gohelper.setActive(var_12_3.go, false)
	end
end

function var_0_0._refreshCost(arg_13_0)
	local var_13_0 = {}
	local var_13_1 = RoomMapModel.instance:getRoomLevel() + 1
	local var_13_2 = RoomConfig.instance:getRoomLevelConfig(var_13_1)
	local var_13_3 = RoomProductionHelper.getFormulaItemParamList(var_13_2.cost)

	for iter_13_0, iter_13_1 in ipairs(var_13_3) do
		table.insert(var_13_0, {
			type = "item",
			item = iter_13_1
		})
	end

	table.insert(var_13_0, {
		type = "block",
		count = var_13_2.needBlockCount
	})

	arg_13_0._isCostLack = false

	for iter_13_2, iter_13_3 in ipairs(var_13_0) do
		local var_13_4 = arg_13_0._costItemList[iter_13_2]

		if not var_13_4 then
			var_13_4 = arg_13_0:getUserDataTb_()
			var_13_4.index = iter_13_2

			if iter_13_3.type == "item" then
				var_13_4.go = gohelper.cloneInPlace(arg_13_0._gocostitem, "item" .. iter_13_2)
				var_13_4.parent = gohelper.findChild(var_13_4.go, "go_itempos")
				var_13_4.itemIcon = IconMgr.instance:getCommonItemIcon(var_13_4.parent)

				var_13_4.itemIcon:setOnBeforeClickCallback(JumpController.commonIconBeforeClickSetRecordItem, arg_13_0)
			elseif iter_13_3.type == "block" then
				var_13_4.go = gohelper.cloneInPlace(arg_13_0._goblockitem, "item" .. iter_13_2)
				var_13_4.txtcostcount = gohelper.findChildText(var_13_4.go, "txt_costcount")
				var_13_4.btnclick = gohelper.findChildButtonWithAudio(var_13_4.go, "btnclick")

				var_13_4.btnclick:AddClickListener(arg_13_0._btnclickOnClick, arg_13_0, var_13_4.index)
			end

			table.insert(arg_13_0._costItemList, var_13_4)
		end

		var_13_4.param = iter_13_3

		local var_13_5 = true

		if iter_13_3.type == "block" then
			local var_13_6 = iter_13_3.count
			local var_13_7 = RoomMapBlockModel.instance:getConfirmBlockCount()

			if var_13_6 <= var_13_7 then
				var_13_4.txtcostcount.text = string.format("%d/%d", var_13_7, var_13_6)
			else
				arg_13_0._isCostLack = true
				var_13_4.txtcostcount.text = string.format("<color=#d97373>%d</color>/%d", var_13_7, var_13_6)
			end
		elseif iter_13_3.type == "item" then
			local var_13_8 = iter_13_3.item

			var_13_4.itemIcon:setMOValue(var_13_8.type, var_13_8.id, var_13_8.quantity)
			var_13_4.itemIcon:setCountFontSize(43)

			local var_13_9 = var_13_4.itemIcon:getCount()
			local var_13_10 = ItemModel.instance:getItemQuantity(var_13_8.type, var_13_8.id)

			if var_13_10 >= var_13_8.quantity then
				var_13_9.text = string.format("%s/%s", GameUtil.numberDisplay(var_13_10), GameUtil.numberDisplay(var_13_8.quantity))
			else
				var_13_9.text = string.format("<color=#d97373>%s</color>/%s", GameUtil.numberDisplay(var_13_10), GameUtil.numberDisplay(var_13_8.quantity))
				arg_13_0._isCostLack = true
			end
		end

		gohelper.setActive(var_13_4.go, true)
	end

	for iter_13_4 = #var_13_0 + 1, #arg_13_0._costItemList do
		local var_13_11 = arg_13_0._costItemList[iter_13_4]

		gohelper.setActive(var_13_11.go, false)
	end

	gohelper.setActive(arg_13_0._golacktip, false)
	ZProj.UGUIHelper.SetGrayscale(arg_13_0._btnlevelup.gameObject, arg_13_0._isCostLack)
	gohelper.setActive(arg_13_0._golevelupbeffect, not arg_13_0._isCostLack)
end

function var_0_0._updateRoomLevel(arg_14_0)
	local var_14_0 = RoomMapModel.instance:getRoomLevel()
	local var_14_1 = RoomConfig.instance:getMaxRoomLevel()

	ViewMgr.instance:openView(ViewName.RoomLevelUpTipsView, {
		level = var_14_0
	})
	ViewMgr.instance:closeView(ViewName.RoomLevelUpView, nil, false)
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0:_refreshUI()
	arg_15_0:addEventCb(RoomMapController.instance, RoomEvent.UpdateRoomLevel, arg_15_0._updateRoomLevel, arg_15_0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_yield_open)
end

function var_0_0.onClose(arg_16_0)
	if arg_16_0.viewContainer:isManualClose() then
		AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_close)
	end
end

function var_0_0.onDestroyView(arg_17_0)
	arg_17_0._simagebg1:UnLoadImage()
	arg_17_0._simagebg2:UnLoadImage()
	arg_17_0._simageproductlineIcon:UnLoadImage()

	for iter_17_0, iter_17_1 in ipairs(arg_17_0._costItemList) do
		if iter_17_1.param.type == "block" then
			iter_17_1.btnclick:RemoveClickListener()
		end
	end
end

return var_0_0
