module("modules.logic.room.view.manufacture.RoomCritterRestTipsView", package.seeall)

local var_0_0 = class("RoomCritterRestTipsView", BaseView)
local var_0_1 = 43

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagerestarea = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/info/#simage_restarea")
	arg_1_0._txtnamecn = gohelper.findChildText(arg_1_0.viewGO, "root/info/#txt_namecn")
	arg_1_0._txtnameen = gohelper.findChildText(arg_1_0.viewGO, "root/info/#txt_namecn/#txt_nameen")
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_0.viewGO, "root/info/#txt_namecn/#image_icon")
	arg_1_0._gocostitem = gohelper.findChild(arg_1_0.viewGO, "root/costs/content/#go_costitem")
	arg_1_0._btnbuild = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_build")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnbuild:AddClickListener(arg_2_0._btnbuildOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_2_0._onItemChanged, arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0._onItemChanged, arg_2_0)
	arg_2_0:addEventCb(CritterController.instance, CritterEvent.CritterUnlockSeatSlot, arg_2_0.closeThis, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnbuild:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_3_0._onItemChanged, arg_3_0)
	arg_3_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0._onItemChanged, arg_3_0)
	arg_3_0:removeEventCb(CritterController.instance, CritterEvent.CritterUnlockSeatSlot, arg_3_0.closeThis, arg_3_0)
end

function var_0_0._btnbuildOnClick(arg_4_0)
	if not arg_4_0._isCanUpgrade then
		GameFacade.showToast(ToastEnum.RoomNotEnoughMatBuySeatSlot)

		return
	end

	CritterController.instance:buySeatSlot(arg_4_0.buildingUid, arg_4_0.seatSlotId)
end

function var_0_0._btncloseOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._onItemChanged(arg_6_0)
	arg_6_0:refreshCost()
end

function var_0_0._editableInitView(arg_7_0)
	local var_7_0 = ResUrl.getRoomCritterIcon("room_rest_area_1")

	arg_7_0._simagerestarea:LoadImage(var_7_0)

	arg_7_0._costItemList = {}
end

function var_0_0.onUpdateParam(arg_8_0)
	arg_8_0.buildingUid = arg_8_0.viewParam.buildingUid
	arg_8_0.seatSlotId = arg_8_0.viewParam.seatSlotId
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:onUpdateParam()
	arg_9_0:refreshBuildingInfo()
	arg_9_0:refreshCost()
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_yield_open)
end

function var_0_0.refreshBuildingInfo(arg_10_0)
	local var_10_0 = ""
	local var_10_1 = ""
	local var_10_2 = RoomMapBuildingModel.instance:getBuildingMOById(arg_10_0.buildingUid)
	local var_10_3 = var_10_2 and var_10_2.config

	if var_10_3 then
		var_10_0 = var_10_3.name
		var_10_1 = var_10_3.nameEn
	end

	arg_10_0._txtnamecn.text = var_10_0
	arg_10_0._txtnameen.text = var_10_1

	local var_10_4 = ManufactureConfig.instance:getManufactureBuildingIcon(var_10_2.buildingId)

	UISpriteSetMgr.instance:setRoomSprite(arg_10_0._imageicon, var_10_4)
end

function var_0_0.refreshCost(arg_11_0)
	local var_11_0 = RoomMapBuildingModel.instance:getBuildingMOById(arg_11_0.buildingUid)
	local var_11_1 = ManufactureConfig.instance:getRestBuildingSeatSlotCost(var_11_0 and var_11_0.buildingId)
	local var_11_2 = true

	for iter_11_0, iter_11_1 in ipairs(var_11_1) do
		local var_11_3 = iter_11_1.type
		local var_11_4 = iter_11_1.id
		local var_11_5 = iter_11_1.quantity
		local var_11_6 = ItemModel.instance:getItemQuantity(var_11_3, var_11_4)
		local var_11_7 = var_11_5 <= var_11_6
		local var_11_8 = arg_11_0._costItemList[iter_11_0]

		if not var_11_8 then
			var_11_8 = arg_11_0:getUserDataTb_()
			var_11_8.index = iter_11_0
			var_11_8.go = gohelper.cloneInPlace(arg_11_0._gocostitem, "item" .. iter_11_0)
			var_11_8.parent = gohelper.findChild(var_11_8.go, "go_itempos")
			var_11_8.itemIcon = IconMgr.instance:getCommonItemIcon(var_11_8.parent)

			table.insert(arg_11_0._costItemList, var_11_8)
		end

		var_11_8.itemIcon:setMOValue(var_11_3, var_11_4, var_11_5)
		var_11_8.itemIcon:setCountFontSize(var_0_1)
		var_11_8.itemIcon:setOnBeforeClickCallback(JumpController.commonIconBeforeClickSetRecordItem, arg_11_0)

		local var_11_9 = var_11_3 == MaterialEnum.MaterialType.Currency
		local var_11_10 = ""

		if var_11_7 then
			if var_11_9 then
				var_11_10 = GameUtil.numberDisplay(var_11_5)
			else
				var_11_10 = string.format("%s/%s", GameUtil.numberDisplay(var_11_6), GameUtil.numberDisplay(var_11_5))
			end
		elseif var_11_9 then
			var_11_10 = string.format("<color=#d97373>%s</color>", GameUtil.numberDisplay(var_11_5))
		else
			var_11_10 = string.format("<color=#d97373>%s</color>/%s", GameUtil.numberDisplay(var_11_6), GameUtil.numberDisplay(var_11_5))
		end

		var_11_8.itemIcon:getCount().text = var_11_10
		var_11_2 = var_11_2 and var_11_7

		gohelper.setActive(var_11_8.go, true)
	end

	arg_11_0._isCanUpgrade = var_11_2

	for iter_11_2 = #var_11_1 + 1, #arg_11_0._costItemList do
		local var_11_11 = arg_11_0._costItemList[iter_11_2]

		gohelper.setActive(var_11_11.go, false)
	end

	ZProj.UGUIHelper.SetGrayscale(arg_11_0._btnbuild.gameObject, not arg_11_0._isCanUpgrade)
end

function var_0_0.onClose(arg_12_0)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
