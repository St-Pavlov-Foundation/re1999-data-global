module("modules.logic.room.view.manufacture.RoomManufactureFormulaItem", package.seeall)

local var_0_0 = class("RoomManufactureFormulaItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnneedMatClick:AddClickListener(arg_2_0.onClick, arg_2_0)
	arg_2_0._btnnoMatClick:AddClickListener(arg_2_0.onClick, arg_2_0)
	arg_2_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_2_0._onItemChanged, arg_2_0)
	arg_2_0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, arg_2_0._onItemChanged, arg_2_0)
	arg_2_0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, arg_2_0._onItemChanged, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnneedMatClick:RemoveClickListener()
	arg_3_0._btnnoMatClick:RemoveClickListener()
	arg_3_0:removeEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_3_0._onItemChanged, arg_3_0)
	arg_3_0:removeEventCb(ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, arg_3_0._onItemChanged, arg_3_0)
	arg_3_0:removeEventCb(ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, arg_3_0._onItemChanged, arg_3_0)
end

function var_0_0.onClick(arg_4_0)
	ManufactureController.instance:clickFormulaItem(arg_4_0.id)
end

function var_0_0.onMatClick(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.type
	local var_5_1 = arg_5_1.id

	MaterialTipController.instance:showMaterialInfo(var_5_0, var_5_1)
end

function var_0_0._onItemChanged(arg_6_0)
	arg_6_0:refreshItem()
	arg_6_0:refreshMats()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._goneedMat = gohelper.findChild(arg_7_0.viewGO, "#go_needMat")
	arg_7_0._btnneedMatClick = gohelper.findChildClickWithDefaultAudio(arg_7_0.viewGO, "#go_needMat/#btn_productClick")
	arg_7_0._imgneedMatRareBg = gohelper.findChildImage(arg_7_0.viewGO, "#go_needMat/content/head/#image_quality")
	arg_7_0._goneedMatItem = gohelper.findChild(arg_7_0.viewGO, "#go_needMat/content/head/#go_item")
	arg_7_0._txtneedMatproductionName = gohelper.findChildText(arg_7_0.viewGO, "#go_needMat/content/#txt_productionName")
	arg_7_0._golayoutmat = gohelper.findChild(arg_7_0.viewGO, "#go_needMat/content/layout_mat")
	arg_7_0._gomatItem = gohelper.findChild(arg_7_0.viewGO, "#go_needMat/content/layout_mat/#go_matItem")
	arg_7_0._txtneedMattime = gohelper.findChildText(arg_7_0.viewGO, "#go_needMat/content/time/#txt_time")
	arg_7_0._txtneedMatnum = gohelper.findChildText(arg_7_0.viewGO, "#go_needMat/num/#txt_num")
	arg_7_0._goneedtraced = gohelper.findChild(arg_7_0.viewGO, "#go_needMat/#go_traced")
	arg_7_0._txtneed = gohelper.findChildText(arg_7_0.viewGO, "#go_needMat/#txt_need")
	arg_7_0._gonoMat = gohelper.findChild(arg_7_0.viewGO, "#go_noMat")
	arg_7_0._btnnoMatClick = gohelper.findChildClickWithDefaultAudio(arg_7_0.viewGO, "#go_noMat/#btn_productClick")
	arg_7_0._imgnoMatRareBg = gohelper.findChildImage(arg_7_0.viewGO, "#go_noMat/content/head/#image_quality")
	arg_7_0._gonoMatitem = gohelper.findChild(arg_7_0.viewGO, "#go_noMat/content/head/#go_item")
	arg_7_0._txtnoMatproductionName = gohelper.findChildText(arg_7_0.viewGO, "#go_noMat/content/#txt_productionName")
	arg_7_0._txtnoMattime = gohelper.findChildText(arg_7_0.viewGO, "#go_noMat/content/time/#txt_time")
	arg_7_0._txtnoMatnum = gohelper.findChildText(arg_7_0.viewGO, "#go_noMat/num/#txt_num")
	arg_7_0._gonomattraced = gohelper.findChild(arg_7_0.viewGO, "#go_noMat/#go_traced")
	arg_7_0._txtnomatneed = gohelper.findChildText(arg_7_0.viewGO, "#go_noMat/#txt_need")
	arg_7_0.matItemList = {}

	gohelper.setActive(arg_7_0._gomatItem, false)
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0.id = arg_8_1.id
	arg_8_0.buildingUid = arg_8_1.buildingUid

	arg_8_0:refreshItem()
	arg_8_0:refreshMats()
	arg_8_0:refreshTime()
end

function var_0_0.refreshItem(arg_9_0)
	local var_9_0 = ManufactureConfig.instance:getItemId(arg_9_0.id)

	if not var_9_0 then
		return
	end

	if not arg_9_0._itemIcon then
		arg_9_0._itemIcon = IconMgr.instance:getCommonItemIcon(arg_9_0._goneedMatItem)

		arg_9_0._itemIcon:isShowQuality(false)
	end

	local var_9_1 = ManufactureConfig.instance:getBatchIconPath(arg_9_0.id)

	arg_9_0._itemIcon:setMOValue(MaterialEnum.MaterialType.Item, var_9_0, nil, nil, nil, {
		specificIcon = var_9_1
	})

	local var_9_2 = arg_9_0._itemIcon:getRare()
	local var_9_3 = RoomManufactureEnum.RareImageMap[var_9_2]

	UISpriteSetMgr.instance:setCritterSprite(arg_9_0._imgneedMatRareBg, var_9_3)
	UISpriteSetMgr.instance:setCritterSprite(arg_9_0._imgnoMatRareBg, var_9_3)
	arg_9_0:refreshItemName()
	arg_9_0:refreshItemNum()

	local var_9_4, var_9_5 = ManufactureModel.instance:getLackMatCount(arg_9_0.id)
	local var_9_6 = var_9_4 and var_9_4 ~= 0

	if var_9_6 then
		local var_9_7 = var_9_5 and luaLang("room_manufacture_traced_count") or luaLang("room_manufacture_formula_need_count")
		local var_9_8 = GameUtil.getSubPlaceholderLuaLangOneParam(var_9_7, var_9_4)

		if arg_9_0._txtneed then
			arg_9_0._txtneed.text = var_9_8
		end

		if arg_9_0._txtnomatneed then
			arg_9_0._txtnomatneed.text = var_9_8
		end
	end

	gohelper.setActive(arg_9_0._txtneed, var_9_6)
	gohelper.setActive(arg_9_0._txtnomatneed, var_9_6)

	local var_9_9 = RoomTradeModel.instance:isTracedGoods(arg_9_0.id)

	gohelper.setActive(arg_9_0._goneedtraced, var_9_9)
	gohelper.setActive(arg_9_0._gonomattraced, var_9_9)
end

function var_0_0.refreshItemName(arg_10_0)
	local var_10_0 = ManufactureConfig.instance:getManufactureItemName(arg_10_0.id)

	arg_10_0._txtneedMatproductionName.text = var_10_0
	arg_10_0._txtnoMatproductionName.text = var_10_0
end

function var_0_0.refreshItemNum(arg_11_0)
	local var_11_0 = ManufactureModel.instance:getManufactureItemCount(arg_11_0.id)
	local var_11_1 = formatLuaLang("materialtipview_itemquantity", var_11_0)

	arg_11_0._txtneedMatnum.text = var_11_1
	arg_11_0._txtnoMatnum.text = var_11_1
end

function var_0_0.refreshMats(arg_12_0)
	local var_12_0 = ManufactureConfig.instance:getNeedMatItemList(arg_12_0.id)
	local var_12_1 = var_12_0 and #var_12_0 or 0
	local var_12_2 = var_12_1 > 0
	local var_12_3 = RoomMapBuildingModel.instance:getBuildingMOById(arg_12_0.buildingUid)
	local var_12_4 = var_12_3 and var_12_3.config.buildingType

	if var_12_2 then
		for iter_12_0, iter_12_1 in ipairs(var_12_0) do
			local var_12_5 = iter_12_1.id
			local var_12_6 = iter_12_1.quantity
			local var_12_7 = arg_12_0:getMatItem(iter_12_0)
			local var_12_8 = ManufactureConfig.instance:getItemId(var_12_5)
			local var_12_9, var_12_10 = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, var_12_8)

			if not string.nilorempty(var_12_10) then
				var_12_7.icon:LoadImage(var_12_10)
			end

			var_12_7.txtunitNum.text = var_12_6

			local var_12_11 = false
			local var_12_12 = false
			local var_12_13, var_12_14 = ManufactureModel.instance:getManufactureItemCount(var_12_5, true, true)

			if ManufactureModel.instance:hasPathLinkedToThisBuildingType(var_12_5, var_12_4) then
				var_12_11 = var_12_14 and var_12_14 > 0
				var_12_12 = var_12_6 <= var_12_13 + ManufactureModel.instance:getManufactureItemCountInSlotQueue(var_12_5, true, true)
			else
				var_12_12 = var_12_6 <= var_12_13
			end

			local var_12_15 = ""

			if var_12_11 then
				local var_12_16 = var_12_12 and luaLang("room_manufacture_item_mat_count") or luaLang("room_manufacture_item_mat_count_not_enough")

				var_12_15 = GameUtil.getSubPlaceholderLuaLangTwoParam(var_12_16, var_12_13, var_12_14)
			else
				var_12_15 = var_12_12 and var_12_13 or string.format("<color=#BE4343>%s</color>", var_12_13)
			end

			var_12_7.txthasNum.text = var_12_15

			var_12_7.btnClick:RemoveClickListener()
			var_12_7.btnClick:AddClickListener(arg_12_0.onMatClick, arg_12_0, {
				type = MaterialEnum.MaterialType.Item,
				id = var_12_8
			})
			gohelper.setActive(var_12_7.go, true)
		end

		for iter_12_2 = var_12_1 + 1, #arg_12_0.matItemList do
			gohelper.setActive(arg_12_0.matItemList[iter_12_2].go, false)
		end
	end

	gohelper.setActive(arg_12_0._goneedMat, var_12_2)
	gohelper.setActive(arg_12_0._gonoMat, not var_12_2)

	if arg_12_0._itemIcon then
		arg_12_0._itemIcon.tr:SetParent(var_12_2 and arg_12_0._goneedMatItem.transform or arg_12_0._gonoMatitem.transform)
		recthelper.setAnchor(arg_12_0._itemIcon.tr, 0, 0)
	end
end

function var_0_0.getMatItem(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0.matItemList[arg_13_1]

	if not var_13_0 then
		var_13_0 = arg_13_0:getUserDataTb_()
		var_13_0.go = gohelper.clone(arg_13_0._gomatItem, arg_13_0._golayoutmat, arg_13_1)
		var_13_0.icon = gohelper.findChildSingleImage(var_13_0.go, "#simage_productionIcon")
		var_13_0.txtunitNum = gohelper.findChildText(var_13_0.go, "#simage_productionIcon/#txt_unitNum")
		var_13_0.txthasNum = gohelper.findChildText(var_13_0.go, "#txt_hasNum")
		var_13_0.goline = gohelper.findChild(var_13_0.go, "#go_line")
		var_13_0.btnClick = gohelper.findChildClickWithAudio(var_13_0.go, "#btn_click", AudioEnum.UI.Store_Good_Click)

		table.insert(arg_13_0.matItemList, var_13_0)
	end

	return var_13_0
end

function var_0_0.refreshTime(arg_14_0)
	local var_14_0 = ManufactureConfig.instance:getNeedTime(arg_14_0.id)
	local var_14_1 = ManufactureController.instance:getFormatTime(var_14_0)

	arg_14_0._txtneedMattime.text = var_14_1
	arg_14_0._txtnoMattime.text = var_14_1
end

function var_0_0.onDestroyView(arg_15_0)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0.matItemList) do
		if iter_15_1.icon then
			iter_15_1.icon:UnLoadImage()

			iter_15_1.icon = nil
		end

		if iter_15_1.btnClick then
			iter_15_1.btnClick:RemoveClickListener()
		end
	end
end

return var_0_0
