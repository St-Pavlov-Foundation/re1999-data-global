module("modules.logic.room.view.building.RoomCommonStrengthView", package.seeall)

local var_0_0 = class("RoomCommonStrengthView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goline1 = gohelper.findChild(arg_1_0.viewGO, "lines/#go_line1")
	arg_1_0._goline2 = gohelper.findChild(arg_1_0.viewGO, "lines/#go_line2")
	arg_1_0._goproductItem = gohelper.findChild(arg_1_0.viewGO, "strengthen/productContent/#go_productItem")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "strengthen/productContent/#go_tips")
	arg_1_0._txtresourceRequireDetail = gohelper.findChildText(arg_1_0.viewGO, "strengthen/productContent/#go_tips/#txt_resourceRequireDetail")
	arg_1_0._godetail = gohelper.findChild(arg_1_0.viewGO, "#go_detail")
	arg_1_0._gonextslotitem = gohelper.findChild(arg_1_0.viewGO, "#go_detail/scroll_nextproductslot/viewport/content/#go_nextslotitem")
	arg_1_0._txtnext = gohelper.findChildText(arg_1_0.viewGO, "#go_detail/#txt_next")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "strengthen/productContent/btn/#btn_close")
	arg_1_0._btnclosedetail = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_detail/#btn_closedetail")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnclosedetail:AddClickListener(arg_2_0._btnclosedetailOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnclosedetail:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:_applyLevelChange()
	arg_4_0:closeThis()
end

function var_0_0._btndetailOnClick(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._levelGroupItemList[arg_5_1]
	local var_5_1 = arg_5_0._levels[arg_5_1] or 0

	arg_5_0:_refreshSlot(arg_5_0._nextSlotItemList, arg_5_0._gonextslotitem, var_5_0.levelGroup, var_5_1 + 1)

	if var_5_1 >= RoomConfig.instance:getProductionLineLevelGroupMaxLevel(var_5_0.levelGroup) then
		arg_5_0._txtnext.text = luaLang("room_building_maxlevel")
	else
		arg_5_0._txtnext.text = luaLang("room_building_nextlevel")
	end

	local var_5_2, var_5_3, var_5_4 = transformhelper.getPos(var_5_0.godetail.transform)

	transformhelper.setPos(arg_5_0._godetail.transform, var_5_2, var_5_3, var_5_4)
	gohelper.setActive(arg_5_0._godetail.gameObject, true)
end

function var_0_0._btnaddOnClick(arg_6_0, arg_6_1)
	arg_6_0:_levelChange(arg_6_1, 1)
end

function var_0_0._btnclosedetailOnClick(arg_7_0)
	gohelper.setActive(arg_7_0._godetail.gameObject, false)
end

function var_0_0._levelChange(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = tabletool.copy(arg_8_0._levels)

	var_8_0[arg_8_1] = math.max(0, (arg_8_0._levels[arg_8_1] or 0) + arg_8_2)

	local var_8_1, var_8_2 = arg_8_0:canLevelUp(var_8_0, arg_8_2 > 0)

	if not var_8_1 then
		if var_8_2 == -1 then
			GameFacade.showToast(ToastEnum.RoomErrorCantLevup)

			return
		elseif var_8_2 == -3 then
			GameFacade.showToast(ToastEnum.RoomErrorCantLevup2)

			return
		end
	end

	if arg_8_2 > 0 then
		local var_8_3 = {
			arg_8_0._productionLineMO.config.levelGroup
		}
		local var_8_4 = arg_8_0:getLevelUpCost(var_8_3[arg_8_1], var_8_0[arg_8_1])
		local var_8_5 = ItemModel.instance:getItemConfig(var_8_4.type, var_8_4.id)

		GameFacade.showMessageBox(MessageBoxIdDefine.RoomChangeLevelUp, MsgBoxEnum.BoxType.Yes_No, function()
			arg_8_0._levels = var_8_0

			arg_8_0:_refreshStrength()
		end, nil, nil, nil, nil, nil, var_8_4.quantity, var_8_5.name)
	elseif arg_8_2 < 0 then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomChangeLevelDown, MsgBoxEnum.BoxType.Yes_No, function()
			arg_8_0._levels = var_8_0

			arg_8_0:_refreshStrength()
		end)
	end
end

function var_0_0._applyLevelChange(arg_11_0)
	if not arg_11_0._productionLineId then
		return
	end

	if arg_11_0._productionLineMO.level ~= arg_11_0._levels[1] then
		RoomRpc.instance:sendProductionLineLvUpRequest(arg_11_0._productionLineId, arg_11_0._levels[1])
	end
end

function var_0_0._editableInitView(arg_12_0)
	gohelper.setActive(arg_12_0._gotips, false)
	gohelper.setActive(arg_12_0._godetail, false)
	gohelper.setActive(arg_12_0._goproductItem, false)
	gohelper.setActive(arg_12_0._gonextslotitem, false)

	arg_12_0._levelGroupItemList = {}
	arg_12_0._nextSlotItemList = {}
end

function var_0_0._refreshUI(arg_13_0)
	arg_13_0:_refreshStrength()
end

function var_0_0._refreshStrength(arg_14_0)
	local var_14_0 = {
		arg_14_0._productionLineMO.config.levelGroup
	}

	gohelper.setActive(arg_14_0._goline1, #var_14_0 == 2)
	gohelper.setActive(arg_14_0._goline2, #var_14_0 == 3)

	for iter_14_0, iter_14_1 in ipairs(var_14_0) do
		local var_14_1 = arg_14_0._levelGroupItemList[iter_14_0]

		if not var_14_1 then
			var_14_1 = arg_14_0:getUserDataTb_()
			var_14_1.index = iter_14_0
			var_14_1.go = gohelper.cloneInPlace(arg_14_0._goproductItem, "item" .. iter_14_0)
			var_14_1.gored1 = gohelper.findChild(var_14_1.go, "iconbg/go_red1")
			var_14_1.gored2 = gohelper.findChild(var_14_1.go, "iconbg/go_red2")
			var_14_1.simageproducticon = gohelper.findChildSingleImage(var_14_1.go, "simage_producticon")
			var_14_1.txtname = gohelper.findChildText(var_14_1.go, "name/txt_name")
			var_14_1.txtlv = gohelper.findChildText(var_14_1.go, "txt_lv")
			var_14_1.godetail = gohelper.findChild(var_14_1.go, "go_detail")
			var_14_1.btndetail = gohelper.findChildButtonWithAudio(var_14_1.go, "name/txt_name/btn_detail")
			var_14_1.btnadd = gohelper.findChildButtonWithAudio(var_14_1.go, "btn_add")
			var_14_1.goslotitem = gohelper.findChild(var_14_1.go, "scroll_productslot/viewport/content/go_slotitem")
			var_14_1.gostrengthitem = gohelper.findChild(var_14_1.go, "coinList/coinItem")
			var_14_1.slotItemList = {}
			var_14_1.strengthItemList = {}

			gohelper.setActive(var_14_1.gored1, iter_14_0 % 2 == 0)
			gohelper.setActive(var_14_1.gored2, iter_14_0 % 2 == 1)
			gohelper.addUIClickAudio(var_14_1.btndetail.gameObject, AudioEnum.UI.Play_UI_Taskinterface)
			gohelper.addUIClickAudio(var_14_1.btnadd.gameObject, AudioEnum.UI.UI_Common_Click)
			var_14_1.btndetail:AddClickListener(arg_14_0._btndetailOnClick, arg_14_0, var_14_1.index)
			var_14_1.btnadd:AddClickListener(arg_14_0._btnaddOnClick, arg_14_0, var_14_1.index)
			gohelper.setActive(var_14_1.goslotitem, false)
			gohelper.setActive(var_14_1.gostrengthitem, false)
			table.insert(arg_14_0._levelGroupItemList, var_14_1)
		end

		var_14_1.levelGroup = iter_14_1

		local var_14_2 = arg_14_0._levels[iter_14_0] or 0
		local var_14_3 = RoomConfig.instance:getProductionLineLevelGroupMaxLevel(iter_14_1)
		local var_14_4 = RoomConfig.instance:getProductionLineLevelConfig(iter_14_1, var_14_2)

		var_14_1.simageproducticon:LoadImage(ResUrl.getRoomImage("modulepart/" .. var_14_4.icon))

		var_14_1.txtname.text = arg_14_0._productionLineMO.config.name
		var_14_1.txtlv.text = string.format("Lv.%s", var_14_2)
		var_14_1.btnadd.button.enabled = var_14_2 < var_14_3

		ZProj.UGUIHelper.SetGrayscale(var_14_1.btnadd.gameObject, var_14_3 <= var_14_2)
		arg_14_0:_refreshSlot(var_14_1.slotItemList, var_14_1.goslotitem, iter_14_1, var_14_2)
		arg_14_0:_refreshStrengthItem(var_14_1, iter_14_1, var_14_2)
		gohelper.setActive(var_14_1.go, true)
	end

	for iter_14_2 = #var_14_0 + 1, #arg_14_0._levelGroupItemList do
		local var_14_5 = arg_14_0._levelGroupItemList[iter_14_2]

		gohelper.setActive(var_14_5.go, false)
	end

	gohelper.setAsLastSibling(arg_14_0._gotips)
end

function var_0_0._refreshSlot(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	local var_15_0 = {}

	if arg_15_4 == 0 then
		local var_15_1 = RoomConfig.instance:getProductionLineLevelConfig(arg_15_3, arg_15_4)

		if not string.nilorempty(var_15_1.desc) then
			table.insert(var_15_0, {
				desc = string.format("<color=#57503B>%s</color>", var_15_1.desc)
			})
		end
	else
		local var_15_2 = RoomConfig.instance:getProductionLineLevelConfig(arg_15_3, arg_15_4)

		if var_15_2 then
			table.insert(var_15_0, {
				desc = string.format("<color=#608C54>%s</color>", var_15_2.desc)
			})
		end
	end

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		local var_15_3 = arg_15_1[iter_15_0]

		if not var_15_3 then
			var_15_3 = arg_15_0:getUserDataTb_()
			var_15_3.go = gohelper.cloneInPlace(arg_15_2, "item" .. iter_15_0)
			var_15_3.gopoint1 = gohelper.findChild(var_15_3.go, "go_point1")
			var_15_3.gopoint2 = gohelper.findChild(var_15_3.go, "go_point2")
			var_15_3.txtslotdesc = gohelper.findChildText(var_15_3.go, "")

			gohelper.setActive(var_15_3.gopoint1, iter_15_0 % 2 == 1)
			gohelper.setActive(var_15_3.gopoint2, iter_15_0 % 2 == 0)
			table.insert(arg_15_1, var_15_3)
		end

		var_15_3.txtslotdesc.text = iter_15_1.desc

		gohelper.setActive(var_15_3.go, true)
	end

	for iter_15_2 = #var_15_0 + 1, #arg_15_1 do
		local var_15_4 = arg_15_1[iter_15_2]

		gohelper.setActive(var_15_4.go, false)
	end
end

function var_0_0._refreshStrengthItem(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = 1

	for iter_16_0 = 1, var_16_0 do
		local var_16_1 = arg_16_1.strengthItemList[iter_16_0]

		if not var_16_1 then
			var_16_1 = arg_16_0:getUserDataTb_()
			var_16_1.go = gohelper.cloneInPlace(arg_16_1.gostrengthitem, "item" .. iter_16_0)
			var_16_1.simageicon = gohelper.findChildSingleImage(var_16_1.go, "coin")

			table.insert(arg_16_1.strengthItemList, var_16_1)
		end

		gohelper.setActive(var_16_1.simageicon.gameObject, arg_16_3 > 1)

		if arg_16_3 > 1 then
			local var_16_2 = RoomConfig.instance:getProductionLineLevelConfig(arg_16_2, arg_16_3).cost
			local var_16_3 = string.splitToNumber(var_16_2, "#")
			local var_16_4 = ItemModel.instance:getItemSmallIcon(var_16_3[2])

			var_16_1.simageicon:LoadImage(var_16_4)
		end

		gohelper.setActive(var_16_1.go, true)
	end

	for iter_16_1 = var_16_0 + 1, #arg_16_1.strengthItemList do
		local var_16_5 = arg_16_1.strengthItemList[iter_16_1]

		gohelper.setActive(var_16_5.go, false)
	end
end

function var_0_0._updateBuildingLevels(arg_17_0, arg_17_1)
	arg_17_0._levels = {
		arg_17_0._productionLineMO.level
	}

	arg_17_0:_refreshStrength()
end

function var_0_0._onEscape(arg_18_0)
	if arg_18_0._gotips.activeInHierarchy then
		gohelper.setActive(arg_18_0._gotips, false)

		return
	end

	if arg_18_0._godetail.activeInHierarchy then
		gohelper.setActive(arg_18_0._godetail, false)

		return
	end

	arg_18_0:_applyLevelChange()
	arg_18_0:closeThis()
end

function var_0_0.onOpen(arg_19_0)
	arg_19_0._productionLineId = arg_19_0.viewParam.lineMO.id
	arg_19_0._productionLineMO = arg_19_0.viewParam.lineMO
	arg_19_0._levels = {
		arg_19_0._productionLineMO.level
	}

	gohelper.addUIClickAudio(arg_19_0._btnclose.gameObject, AudioEnum.UI.Play_UI_Rolesback)
	arg_19_0:_refreshUI()
	arg_19_0:addEventCb(RoomController.instance, RoomEvent.ProduceLineLevelUp, arg_19_0._updateBuildingLevels, arg_19_0)
	NavigateMgr.instance:addEscape(ViewName.RoomCommonStrengthView, arg_19_0._onEscape, arg_19_0)
end

function var_0_0.onUpdateParam(arg_20_0)
	arg_20_0._productionLineId = arg_20_0.viewParam.lineMO.id
	arg_20_0._productionLineMO = arg_20_0.viewParam.lineMO
	arg_20_0._levels = {
		arg_20_0._productionLineMO.level
	}

	arg_20_0:_refreshUI()
end

function var_0_0.onClose(arg_21_0)
	return
end

function var_0_0.onDestroyView(arg_22_0)
	for iter_22_0, iter_22_1 in ipairs(arg_22_0._levelGroupItemList) do
		iter_22_1.simageproducticon:UnLoadImage()
		iter_22_1.btndetail:RemoveClickListener()
		iter_22_1.btnadd:RemoveClickListener()

		for iter_22_2, iter_22_3 in ipairs(iter_22_1.strengthItemList) do
			iter_22_3.simageicon:UnLoadImage()
		end
	end
end

function var_0_0.canLevelUp(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0:getLevelUpCostItems(arg_23_1)
	local var_23_1, var_23_2 = ItemModel.instance:hasEnoughItems(var_23_0)

	if not var_23_2 then
		local var_23_3 = {}

		for iter_23_0, iter_23_1 in ipairs(var_23_0) do
			if iter_23_1.type == MaterialEnum.MaterialType.Item and iter_23_1.id == RoomBuildingEnum.SpecialStrengthItemId then
				table.insert(var_23_3, tabletool.copy(iter_23_1))
			end
		end

		local var_23_4, var_23_5 = ItemModel.instance:hasEnoughItems(var_23_3)

		if not var_23_5 then
			return false, -3
		else
			return false, -1
		end
	end

	return true
end

function var_0_0.getLevelUpCostItems(arg_24_0, arg_24_1)
	local var_24_0 = {
		arg_24_0._productionLineMO.config.levelGroup
	}
	local var_24_1 = {
		arg_24_0._productionLineMO.level
	}
	local var_24_2 = {}

	for iter_24_0, iter_24_1 in ipairs(arg_24_1) do
		local var_24_3 = var_24_1[iter_24_0] or 1
		local var_24_4 = math.min(var_24_3, iter_24_1)
		local var_24_5 = math.max(var_24_3, iter_24_1)
		local var_24_6 = var_24_3 < iter_24_1 and 1 or -1

		for iter_24_2 = var_24_4 + 1, var_24_5 do
			local var_24_7 = arg_24_0:getLevelUpCost(var_24_0[iter_24_0], iter_24_2)

			var_24_7.quantity = var_24_6 * var_24_7.quantity

			table.insert(var_24_2, var_24_7)
		end
	end

	return var_24_2
end

function var_0_0.getLevelUpCost(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = RoomConfig.instance:getProductionLineLevelConfig(arg_25_1, arg_25_2).cost
	local var_25_1 = string.splitToNumber(var_25_0, "#")

	return {
		type = var_25_1[1],
		id = var_25_1[2],
		quantity = var_25_1[3]
	}
end

return var_0_0
