module("modules.logic.room.view.building.RoomCommonStrengthView", package.seeall)

slot0 = class("RoomCommonStrengthView", BaseView)

function slot0.onInitView(slot0)
	slot0._goline1 = gohelper.findChild(slot0.viewGO, "lines/#go_line1")
	slot0._goline2 = gohelper.findChild(slot0.viewGO, "lines/#go_line2")
	slot0._goproductItem = gohelper.findChild(slot0.viewGO, "strengthen/productContent/#go_productItem")
	slot0._gotips = gohelper.findChild(slot0.viewGO, "strengthen/productContent/#go_tips")
	slot0._txtresourceRequireDetail = gohelper.findChildText(slot0.viewGO, "strengthen/productContent/#go_tips/#txt_resourceRequireDetail")
	slot0._godetail = gohelper.findChild(slot0.viewGO, "#go_detail")
	slot0._gonextslotitem = gohelper.findChild(slot0.viewGO, "#go_detail/scroll_nextproductslot/viewport/content/#go_nextslotitem")
	slot0._txtnext = gohelper.findChildText(slot0.viewGO, "#go_detail/#txt_next")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "strengthen/productContent/btn/#btn_close")
	slot0._btnclosedetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_detail/#btn_closedetail")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnclosedetail:AddClickListener(slot0._btnclosedetailOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnclosedetail:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:_applyLevelChange()
	slot0:closeThis()
end

function slot0._btndetailOnClick(slot0, slot1)
	slot2 = slot0._levelGroupItemList[slot1]
	slot3 = slot0._levels[slot1] or 0

	slot0:_refreshSlot(slot0._nextSlotItemList, slot0._gonextslotitem, slot2.levelGroup, slot3 + 1)

	if RoomConfig.instance:getProductionLineLevelGroupMaxLevel(slot2.levelGroup) <= slot3 then
		slot0._txtnext.text = luaLang("room_building_maxlevel")
	else
		slot0._txtnext.text = luaLang("room_building_nextlevel")
	end

	slot5, slot6, slot7 = transformhelper.getPos(slot2.godetail.transform)

	transformhelper.setPos(slot0._godetail.transform, slot5, slot6, slot7)
	gohelper.setActive(slot0._godetail.gameObject, true)
end

function slot0._btnaddOnClick(slot0, slot1)
	slot0:_levelChange(slot1, 1)
end

function slot0._btnclosedetailOnClick(slot0)
	gohelper.setActive(slot0._godetail.gameObject, false)
end

function slot0._levelChange(slot0, slot1, slot2)
	slot3 = tabletool.copy(slot0._levels)
	slot3[slot1] = math.max(0, (slot0._levels[slot1] or 0) + slot2)
	slot4, slot5 = slot0:canLevelUp(slot3, slot2 > 0)

	if not slot4 then
		if slot5 == -1 then
			GameFacade.showToast(ToastEnum.RoomErrorCantLevup)

			return
		elseif slot5 == -3 then
			GameFacade.showToast(ToastEnum.RoomErrorCantLevup2)

			return
		end
	end

	if slot2 > 0 then
		slot7 = slot0:getLevelUpCost(({
			slot0._productionLineMO.config.levelGroup
		})[slot1], slot3[slot1])

		GameFacade.showMessageBox(MessageBoxIdDefine.RoomChangeLevelUp, MsgBoxEnum.BoxType.Yes_No, function ()
			uv0._levels = uv1

			uv0:_refreshStrength()
		end, nil, , , , , slot7.quantity, ItemModel.instance:getItemConfig(slot7.type, slot7.id).name)
	elseif slot2 < 0 then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomChangeLevelDown, MsgBoxEnum.BoxType.Yes_No, function ()
			uv0._levels = uv1

			uv0:_refreshStrength()
		end)
	end
end

function slot0._applyLevelChange(slot0)
	if not slot0._productionLineId then
		return
	end

	if slot0._productionLineMO.level ~= slot0._levels[1] then
		RoomRpc.instance:sendProductionLineLvUpRequest(slot0._productionLineId, slot0._levels[1])
	end
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gotips, false)
	gohelper.setActive(slot0._godetail, false)
	gohelper.setActive(slot0._goproductItem, false)
	gohelper.setActive(slot0._gonextslotitem, false)

	slot0._levelGroupItemList = {}
	slot0._nextSlotItemList = {}
end

function slot0._refreshUI(slot0)
	slot0:_refreshStrength()
end

function slot0._refreshStrength(slot0)
	gohelper.setActive(slot0._goline1, #{
		slot0._productionLineMO.config.levelGroup
	} == 2)
	gohelper.setActive(slot0._goline2, #slot1 == 3)

	for slot5, slot6 in ipairs(slot1) do
		if not slot0._levelGroupItemList[slot5] then
			slot7 = slot0:getUserDataTb_()
			slot7.index = slot5
			slot7.go = gohelper.cloneInPlace(slot0._goproductItem, "item" .. slot5)
			slot7.gored1 = gohelper.findChild(slot7.go, "iconbg/go_red1")
			slot7.gored2 = gohelper.findChild(slot7.go, "iconbg/go_red2")
			slot7.simageproducticon = gohelper.findChildSingleImage(slot7.go, "simage_producticon")
			slot7.txtname = gohelper.findChildText(slot7.go, "name/txt_name")
			slot7.txtlv = gohelper.findChildText(slot7.go, "txt_lv")
			slot7.godetail = gohelper.findChild(slot7.go, "go_detail")
			slot7.btndetail = gohelper.findChildButtonWithAudio(slot7.go, "name/txt_name/btn_detail")
			slot7.btnadd = gohelper.findChildButtonWithAudio(slot7.go, "btn_add")
			slot7.goslotitem = gohelper.findChild(slot7.go, "scroll_productslot/viewport/content/go_slotitem")
			slot7.gostrengthitem = gohelper.findChild(slot7.go, "coinList/coinItem")
			slot7.slotItemList = {}
			slot7.strengthItemList = {}

			gohelper.setActive(slot7.gored1, slot5 % 2 == 0)
			gohelper.setActive(slot7.gored2, slot5 % 2 == 1)
			gohelper.addUIClickAudio(slot7.btndetail.gameObject, AudioEnum.UI.Play_UI_Taskinterface)
			gohelper.addUIClickAudio(slot7.btnadd.gameObject, AudioEnum.UI.UI_Common_Click)
			slot7.btndetail:AddClickListener(slot0._btndetailOnClick, slot0, slot7.index)
			slot7.btnadd:AddClickListener(slot0._btnaddOnClick, slot0, slot7.index)
			gohelper.setActive(slot7.goslotitem, false)
			gohelper.setActive(slot7.gostrengthitem, false)
			table.insert(slot0._levelGroupItemList, slot7)
		end

		slot7.levelGroup = slot6
		slot8 = slot0._levels[slot5] or 0

		slot7.simageproducticon:LoadImage(ResUrl.getRoomImage("modulepart/" .. RoomConfig.instance:getProductionLineLevelConfig(slot6, slot8).icon))

		slot7.txtname.text = slot0._productionLineMO.config.name
		slot7.txtlv.text = string.format("Lv.%s", slot8)
		slot7.btnadd.button.enabled = slot8 < RoomConfig.instance:getProductionLineLevelGroupMaxLevel(slot6)

		ZProj.UGUIHelper.SetGrayscale(slot7.btnadd.gameObject, slot9 <= slot8)
		slot0:_refreshSlot(slot7.slotItemList, slot7.goslotitem, slot6, slot8)
		slot0:_refreshStrengthItem(slot7, slot6, slot8)
		gohelper.setActive(slot7.go, true)
	end

	for slot5 = #slot1 + 1, #slot0._levelGroupItemList do
		gohelper.setActive(slot0._levelGroupItemList[slot5].go, false)
	end

	gohelper.setAsLastSibling(slot0._gotips)
end

function slot0._refreshSlot(slot0, slot1, slot2, slot3, slot4)
	if slot4 == 0 then
		if not string.nilorempty(RoomConfig.instance:getProductionLineLevelConfig(slot3, slot4).desc) then
			table.insert({}, {
				desc = string.format("<color=#57503B>%s</color>", slot6.desc)
			})
		end
	elseif RoomConfig.instance:getProductionLineLevelConfig(slot3, slot4) then
		table.insert(slot5, {
			desc = string.format("<color=#608C54>%s</color>", slot6.desc)
		})
	end

	for slot9, slot10 in ipairs(slot5) do
		if not slot1[slot9] then
			slot11 = slot0:getUserDataTb_()
			slot11.go = gohelper.cloneInPlace(slot2, "item" .. slot9)
			slot11.gopoint1 = gohelper.findChild(slot11.go, "go_point1")
			slot11.gopoint2 = gohelper.findChild(slot11.go, "go_point2")
			slot11.txtslotdesc = gohelper.findChildText(slot11.go, "")

			gohelper.setActive(slot11.gopoint1, slot9 % 2 == 1)
			gohelper.setActive(slot11.gopoint2, slot9 % 2 == 0)
			table.insert(slot1, slot11)
		end

		slot11.txtslotdesc.text = slot10.desc

		gohelper.setActive(slot11.go, true)
	end

	for slot9 = #slot5 + 1, #slot1 do
		gohelper.setActive(slot1[slot9].go, false)
	end
end

function slot0._refreshStrengthItem(slot0, slot1, slot2, slot3)
	for slot8 = 1, 1 do
		if not slot1.strengthItemList[slot8] then
			slot9 = slot0:getUserDataTb_()
			slot9.go = gohelper.cloneInPlace(slot1.gostrengthitem, "item" .. slot8)
			slot9.simageicon = gohelper.findChildSingleImage(slot9.go, "coin")

			table.insert(slot1.strengthItemList, slot9)
		end

		gohelper.setActive(slot9.simageicon.gameObject, slot3 > 1)

		if slot3 > 1 then
			slot9.simageicon:LoadImage(ItemModel.instance:getItemSmallIcon(string.splitToNumber(RoomConfig.instance:getProductionLineLevelConfig(slot2, slot3).cost, "#")[2]))
		end

		gohelper.setActive(slot9.go, true)
	end

	for slot8 = slot4 + 1, #slot1.strengthItemList do
		gohelper.setActive(slot1.strengthItemList[slot8].go, false)
	end
end

function slot0._updateBuildingLevels(slot0, slot1)
	slot0._levels = {
		slot0._productionLineMO.level
	}

	slot0:_refreshStrength()
end

function slot0._onEscape(slot0)
	if slot0._gotips.activeInHierarchy then
		gohelper.setActive(slot0._gotips, false)

		return
	end

	if slot0._godetail.activeInHierarchy then
		gohelper.setActive(slot0._godetail, false)

		return
	end

	slot0:_applyLevelChange()
	slot0:closeThis()
end

function slot0.onOpen(slot0)
	slot0._productionLineId = slot0.viewParam.lineMO.id
	slot0._productionLineMO = slot0.viewParam.lineMO
	slot0._levels = {
		slot0._productionLineMO.level
	}

	gohelper.addUIClickAudio(slot0._btnclose.gameObject, AudioEnum.UI.Play_UI_Rolesback)
	slot0:_refreshUI()
	slot0:addEventCb(RoomController.instance, RoomEvent.ProduceLineLevelUp, slot0._updateBuildingLevels, slot0)
	NavigateMgr.instance:addEscape(ViewName.RoomCommonStrengthView, slot0._onEscape, slot0)
end

function slot0.onUpdateParam(slot0)
	slot0._productionLineId = slot0.viewParam.lineMO.id
	slot0._productionLineMO = slot0.viewParam.lineMO
	slot0._levels = {
		slot0._productionLineMO.level
	}

	slot0:_refreshUI()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0._levelGroupItemList) do
		slot5.simageproducticon:UnLoadImage()
		slot5.btndetail:RemoveClickListener()
		slot5.btnadd:RemoveClickListener()

		for slot9, slot10 in ipairs(slot5.strengthItemList) do
			slot10.simageicon:UnLoadImage()
		end
	end
end

function slot0.canLevelUp(slot0, slot1, slot2)
	slot4, slot5 = ItemModel.instance:hasEnoughItems(slot0:getLevelUpCostItems(slot1))

	if not slot5 then
		slot6 = {}

		for slot10, slot11 in ipairs(slot3) do
			if slot11.type == MaterialEnum.MaterialType.Item and slot11.id == RoomBuildingEnum.SpecialStrengthItemId then
				table.insert(slot6, tabletool.copy(slot11))
			end
		end

		slot7, slot8 = ItemModel.instance:hasEnoughItems(slot6)

		if not slot8 then
			return false, -3
		else
			return false, -1
		end
	end

	return true
end

function slot0.getLevelUpCostItems(slot0, slot1)
	slot2 = {
		slot0._productionLineMO.config.levelGroup
	}
	slot4 = {}

	for slot8, slot9 in ipairs(slot1) do
		slot10 = ({
			slot0._productionLineMO.level
		})[slot8] or 1

		for slot17 = math.min(slot10, slot9) + 1, math.max(slot10, slot9) do
			slot18 = slot0:getLevelUpCost(slot2[slot8], slot17)
			slot18.quantity = (slot10 < slot9 and 1 or -1) * slot18.quantity

			table.insert(slot4, slot18)
		end
	end

	return slot4
end

function slot0.getLevelUpCost(slot0, slot1, slot2)
	slot5 = string.splitToNumber(RoomConfig.instance:getProductionLineLevelConfig(slot1, slot2).cost, "#")

	return {
		type = slot5[1],
		id = slot5[2],
		quantity = slot5[3]
	}
end

return slot0
