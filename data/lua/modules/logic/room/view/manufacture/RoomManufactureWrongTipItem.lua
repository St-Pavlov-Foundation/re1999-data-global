module("modules.logic.room.view.manufacture.RoomManufactureWrongTipItem", package.seeall)

local var_0_0 = class("RoomManufactureWrongTipItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._gowaitbg = gohelper.findChild(arg_1_0.go, "waitbg")
	arg_1_0._gopausebg = gohelper.findChild(arg_1_0.go, "pausebg")
	arg_1_0._imagequality = gohelper.findChildImage(arg_1_0.go, "info/item/#image_quality")
	arg_1_0._simageproductionIcon = gohelper.findChildSingleImage(arg_1_0.go, "info/item/#simage_productionIcon")
	arg_1_0._txtproductionName = gohelper.findChildText(arg_1_0.go, "info/item/#txt_productionName")
	arg_1_0._golayoutstatus = gohelper.findChild(arg_1_0.go, "info/layoutStatus")
	arg_1_0._goStatusItem = gohelper.findChild(arg_1_0.go, "info/layoutStatus/#simage_status")
	arg_1_0._godec = gohelper.findChild(arg_1_0.go, "info/#go_dec")
	arg_1_0._gowrongs = gohelper.findChild(arg_1_0.go, "#go_wrongs")
	arg_1_0._gowrongItem = gohelper.findChild(arg_1_0.go, "#go_wrongs/#go_wrongItem")

	arg_1_0:setData()
end

function var_0_0.addEventListeners(arg_2_0)
	return
end

function var_0_0.removeEventListeners(arg_3_0)
	return
end

function var_0_0.onWrongItemJumpClick(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.wrongItemList[arg_4_1]

	if not var_4_0 then
		return
	end

	local var_4_1 = {
		isOverView = arg_4_0.isOverView,
		pathToType = arg_4_0.buildingType
	}

	ManufactureController.instance:clickWrongJump(var_4_0.data.wrongType, var_4_0.data.manufactureItemId, var_4_0.data.buildingType, var_4_1)
end

function var_0_0.setData(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	arg_5_0.buildingUid = arg_5_1
	arg_5_0.manufactureItemId = arg_5_2
	arg_5_0.wrongSlotIdList = arg_5_3
	arg_5_0.isOverView = arg_5_4
	arg_5_0.buildingType = ManufactureConfig.instance:getManufactureItemBelongBuildingType(arg_5_2)

	arg_5_0:refresh()
end

function var_0_0.refresh(arg_6_0)
	if not arg_6_0.buildingUid or not arg_6_0.manufactureItemId or not arg_6_0.wrongSlotIdList then
		return
	end

	arg_6_0:setItemInfo()

	local var_6_0, var_6_1 = ManufactureModel.instance:getAllWrongManufactureItemList(arg_6_0.buildingUid, arg_6_0.manufactureItemId, #arg_6_0.wrongSlotIdList)

	arg_6_0:setStatusItems(var_6_1)
	arg_6_0:setWrongItems(var_6_0)
end

function var_0_0.setItemInfo(arg_7_0)
	local var_7_0 = ManufactureConfig.instance:getItemId(arg_7_0.manufactureItemId)
	local var_7_1, var_7_2 = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, var_7_0)
	local var_7_3 = RoomManufactureEnum.RareImageMap[var_7_1.rare]

	UISpriteSetMgr.instance:setCritterSprite(arg_7_0._imagequality, var_7_3)

	var_7_2 = ManufactureConfig.instance:getBatchIconPath(arg_7_0.manufactureItemId) or var_7_2

	arg_7_0._simageproductionIcon:LoadImage(var_7_2)

	local var_7_4 = ManufactureConfig.instance:getManufactureItemName(arg_7_0.manufactureItemId)

	arg_7_0._txtproductionName.text = var_7_4
end

function var_0_0.setStatusItems(arg_8_0, arg_8_1)
	arg_8_0.statusItemList = {}

	local var_8_0 = false

	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		var_8_0 = iter_8_1 ~= RoomManufactureEnum.ManufactureWrongType.WaitPreMat

		if var_8_0 then
			break
		end
	end

	gohelper.setActive(arg_8_0._gowaitbg, not var_8_0)
	gohelper.setActive(arg_8_0._gopausebg, var_8_0)
	gohelper.CreateObjList(arg_8_0, arg_8_0._onSetStatusItem, arg_8_1, arg_8_0._golayoutstatus, arg_8_0._goStatusItem)
end

function var_0_0._onSetStatusItem(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = arg_9_0:getUserDataTb_()

	var_9_0.go = arg_9_1
	var_9_0.wrongType = arg_9_2
	var_9_0.simagestatus = arg_9_1:GetComponent(gohelper.Type_Image)
	var_9_0.txtstatus = gohelper.findChildText(arg_9_1, "#txt_status")

	local var_9_1
	local var_9_2 = ""
	local var_9_3 = RoomManufactureEnum.ManufactureWrongDisplay[arg_9_2]

	if var_9_3 then
		var_9_1 = var_9_3.icon
		var_9_2 = luaLang(var_9_3.desc)
	end

	if not string.nilorempty(var_9_1) then
		UISpriteSetMgr.instance:setRoomSprite(var_9_0.simagestatus, var_9_1)
	end

	var_9_0.txtstatus.text = var_9_2
	arg_9_0.statusItemList[arg_9_3] = var_9_0
end

function var_0_0.setWrongItems(arg_10_0, arg_10_1)
	arg_10_0:clearWrongItemList()
	gohelper.setActive(arg_10_0._godec, arg_10_1 and #arg_10_1 > 0)
	gohelper.CreateObjList(arg_10_0, arg_10_0._onSetWrongItem, arg_10_1, arg_10_0._gowrongs, arg_10_0._gowrongItem)
end

function var_0_0.clearWrongItemList(arg_11_0)
	if arg_11_0.wrongItemList then
		for iter_11_0, iter_11_1 in ipairs(arg_11_0.wrongItemList) do
			iter_11_1.needitemIcon:UnLoadImage()
			iter_11_1.btnjump:RemoveClickListener()
		end
	end

	arg_11_0.wrongItemList = {}
end

function var_0_0._onSetWrongItem(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = arg_12_0:getUserDataTb_()

	var_12_0.go = arg_12_1
	var_12_0.data = arg_12_2
	var_12_0.goneedItem = gohelper.findChild(arg_12_1, "#go_needItem")
	var_12_0.needitemquality = gohelper.findChildImage(arg_12_1, "#go_needItem/item/#image_quality")
	var_12_0.needitemIcon = gohelper.findChildSingleImage(arg_12_1, "#go_needItem/item/#simage_productionIcon")
	var_12_0.needitemName = gohelper.findChildText(arg_12_1, "#go_needItem/#txt_tipItemName")
	var_12_0.txtneed = gohelper.findChildText(arg_12_1, "#go_needItem/#txt_need")
	var_12_0.goneedLink = gohelper.findChild(arg_12_1, "#go_needLink")
	var_12_0.simagestart = gohelper.findChildImage(arg_12_1, "#go_needLink/#simage_start")
	var_12_0.simageend = gohelper.findChildImage(arg_12_1, "#go_needLink/#simage_end")
	var_12_0.btnjump = gohelper.findChildClickWithDefaultAudio(arg_12_1, "#btn_jump")
	var_12_0.txtjump = gohelper.findChildText(arg_12_1, "#btn_jump/#txt_jump")

	var_12_0.btnjump:AddClickListener(arg_12_0.onWrongItemJumpClick, arg_12_0, arg_12_3)

	local var_12_1 = var_12_0.data.wrongType
	local var_12_2 = var_12_1 == RoomManufactureEnum.ManufactureWrongType.NoLinkPath

	gohelper.setActive(var_12_0.goneedItem, not var_12_2)
	gohelper.setActive(var_12_0.goneedLink, var_12_2)

	if var_12_2 then
		local var_12_3 = RoomConfig.instance:getBuildingTypeIcon(var_12_0.data.buildingType)
		local var_12_4 = RoomConfig.instance:getBuildingTypeIcon(arg_12_0.buildingType)

		UISpriteSetMgr.instance:setRoomSprite(var_12_0.simagestart, var_12_3)
		UISpriteSetMgr.instance:setRoomSprite(var_12_0.simageend, var_12_4)
	else
		local var_12_5 = var_12_0.data.manufactureItemId
		local var_12_6 = ManufactureConfig.instance:getItemId(var_12_5)
		local var_12_7, var_12_8 = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, var_12_6)
		local var_12_9 = RoomManufactureEnum.RareImageMap[var_12_7.rare]

		UISpriteSetMgr.instance:setCritterSprite(var_12_0.needitemquality, var_12_9)

		var_12_8 = ManufactureConfig.instance:getBatchIconPath(var_12_5) or var_12_8

		var_12_0.needitemIcon:LoadImage(var_12_8)

		local var_12_10 = ManufactureConfig.instance:getManufactureItemName(var_12_5)

		var_12_0.needitemName.text = var_12_10

		local var_12_11 = ManufactureModel.instance:getManufactureItemCount(var_12_5)
		local var_12_12 = string.format("<color=#D26D69>%s</color>", var_12_11)

		var_12_0.txtneed.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("room_manufacture_wrong_need_count"), var_12_12, var_12_0.data.needQuantity)
	end

	local var_12_13 = RoomManufactureEnum.ManufactureWrongDisplay[var_12_1]

	var_12_0.txtjump.text = luaLang(var_12_13.jumpDesc)
	arg_12_0.wrongItemList[arg_12_3] = var_12_0
end

function var_0_0.onDestroy(arg_13_0)
	arg_13_0._simageproductionIcon:UnLoadImage()
	arg_13_0:clearWrongItemList()
end

return var_0_0
