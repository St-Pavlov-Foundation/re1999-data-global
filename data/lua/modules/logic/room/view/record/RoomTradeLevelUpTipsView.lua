module("modules.logic.room.view.record.RoomTradeLevelUpTipsView", package.seeall)

slot0 = class("RoomTradeLevelUpTipsView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._simagecaidai = gohelper.findChildSingleImage(slot0.viewGO, "#simage_caidai")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "title/#txt_name")
	slot0._txttype = gohelper.findChildText(slot0.viewGO, "title/#txt_type")
	slot0._scrolllevelup = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_levelup")
	slot0._goinfo = gohelper.findChild(slot0.viewGO, "#scroll_levelup/Viewport/Content/levelupInfo/#go_info")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goinfo, false)
end

function slot0.onOpen(slot0)
	slot0.tradeLevel = slot0.viewParam.level

	if slot0.tradeLevel then
		slot0:_updateLevelInfo(slot0.tradeLevel)
	end

	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_firmup_upgrade)
end

function slot0.onUpdateParam(slot0)
	slot0.tradeLevel = slot0.viewParam.level
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0.onDestroyView(slot0)
end

function slot0._updateLevelInfo(slot0, slot1)
	slot2 = ManufactureConfig.instance:getTradeLevelCfg(slot1)
	slot0._txtname.text = slot2.dimension
	slot0._txttype.text = slot2.job
	slot4 = {}

	if RoomTradeTaskModel.instance:getLevelUnlock(slot1) then
		for slot8, slot9 in ipairs(slot3) do
			if not slot4[slot9.type] then
				slot4[slot10] = {}
			end

			table.insert(slot11, slot9)
		end
	end

	for slot8, slot9 in pairs(slot4) do
		if RoomTradeConfig.instance:getLevelUnlockCo(slot8).itemType == 1 then
			if slot8 == RoomTradeEnum.LevelUnlock.BuildingMaxLevel then
				for slot14, slot15 in ipairs(slot9) do
					slot0:_setBuildingMaxLevelItem(slot15, slot8)
				end
			else
				slot0:_setNewBuildingItem(slot9, slot8)
			end
		elseif slot10.itemType == 2 then
			slot0:_setGetBonusItem(slot9, slot8)
		else
			slot0:setNormalItem(slot9, slot8)
		end
	end

	slot5 = slot0:getUserDataTb_()

	if slot0._unlockInfoItems then
		for slot9, slot10 in pairs(slot0._unlockInfoItems) do
			table.insert(slot5, slot10)
		end

		table.sort(slot5, slot0._sortInfoItem)
		slot0:_sortItem(slot5)
	end
end

function slot0._sortInfoItem(slot0, slot1)
	slot3 = slot1.co

	if slot0.co and slot3 then
		return slot2.sort < slot3.sort
	end
end

function slot0._sortItem(slot0, slot1)
	if slot1 then
		for slot5, slot6 in ipairs(slot1) do
			slot6.go.transform:SetSiblingIndex(slot5)
			gohelper.setActive(slot6.bgGo, slot5 % 2 == 0)
		end
	end
end

function slot0._setGetBonusItem(slot0, slot1, slot2)
	if not LuaUtil.tableNotEmpty(slot1) then
		return
	end

	slot3 = slot0:_getInfoItem(slot2)
	slot3.co = RoomTradeConfig.instance:getLevelUnlockCo(slot2)
	slot3.descTxt.text = slot3.co.levelupDes
	slot3.type = slot2

	for slot7, slot8 in ipairs(slot1) do
		slot10 = string.split(slot8.bouns, "#")
		slot11 = slot10[1]
		slot12 = slot10[2]
		slot13 = slot10[3]

		if not slot3.itemList then
			slot3.itemList = slot0:getUserDataTb_()
		end

		if not slot3.itemList[slot7] then
			slot15 = gohelper.cloneInPlace(slot3.goicon, "item_" .. slot7)
			slot14 = slot0:getUserDataTb_()
			slot14.go = slot15
			slot14.icon = IconMgr.instance:getCommonPropItemIcon(slot15)

			slot14.icon:setMOValue(slot11, slot12, slot13, nil, true)
			slot14.icon:setCountFontSize(40)
			slot14.icon:showStackableNum2()
			slot14.icon:isShowEffect(true)

			slot3.itemList[slot7] = slot14
		else
			slot14.icon:setMOValue(slot11, slot12, slot13, nil, true)
		end

		gohelper.setActive(slot14.go, true)
	end

	gohelper.setActive(slot3.itemGo, true)
	gohelper.setActive(slot3.go, true)
end

function slot0._setNewBuildingItem(slot0, slot1, slot2)
	if not LuaUtil.tableNotEmpty(slot1) then
		return
	end

	slot3 = slot0:_getInfoItem(slot2)
	slot3.co = RoomTradeConfig.instance:getLevelUnlockCo(slot2)
	slot3.descTxt.text = slot3.co.levelupDes
	slot3.type = slot2

	for slot7, slot8 in ipairs(slot1) do
		if not slot3.itemList then
			slot3.itemList = slot0:getUserDataTb_()
		end

		if not slot3.itemList[slot7] then
			slot10 = gohelper.cloneInPlace(slot3.goicon, "item_" .. slot7)
			slot9 = slot0:getUserDataTb_()
			slot9.go = slot10
			slot9.icon = IconMgr.instance:getCommonPropItemIcon(slot10)

			slot9.icon:setMOValue(MaterialEnum.MaterialType.Building, slot8.buildingId, 1, nil, true)
			slot9.icon:setCountFontSize(40)
			slot9.icon:showStackableNum2()
			slot9.icon:isShowEffect(true)
			slot9.icon:isShowCount(false)

			slot3.itemList[slot7] = slot9
		else
			slot9.icon:setMOValue(MaterialEnum.MaterialType.Building, slot8.buildingId, 1, nil, true)
		end

		gohelper.setActive(slot9.go, true)
	end

	gohelper.setActive(slot3.itemGo, true)
	gohelper.setActive(slot3.go, true)
end

function slot0._setBuildingMaxLevelItem(slot0, slot1, slot2)
	if not LuaUtil.tableNotEmpty(slot1) then
		return
	end

	slot3 = slot0:_getInfoItem(slot2)
	slot3.co = RoomTradeConfig.instance:getLevelUnlockCo(slot2)
	slot3.descTxt.text = GameUtil.getSubPlaceholderLuaLangOneParam(slot3.co.levelupDes, slot1.num.cur - slot1.num.last)
	slot3.type = slot2

	if not slot3.itemList then
		slot3.itemList = slot0:getUserDataTb_()
	end

	if not slot3.itemList[1] then
		slot5 = gohelper.cloneInPlace(slot3.goicon, "item_" .. 1)
		slot4 = slot0:getUserDataTb_()
		slot4.go = slot5
		slot4.icon = IconMgr.instance:getCommonPropItemIcon(slot5, "item_" .. 1)

		slot4.icon:setMOValue(MaterialEnum.MaterialType.Building, slot1.buildingId, 1, nil, true)
		slot4.icon:setCountFontSize(40)
		slot4.icon:showStackableNum2()
		slot4.icon:isShowEffect(true)
		slot4.icon:isShowCount(false)

		slot3.itemList[1] = slot4
	else
		slot4.icon:setMOValue(MaterialEnum.MaterialType.Building, slot1.buildingId, 1, nil, true)
	end

	gohelper.setActive(slot4.go, true)
	gohelper.setActive(slot3.itemGo, true)
	gohelper.setActive(slot3.go, true)
end

function slot0.setNormalItem(slot0, slot1, slot2)
	if not LuaUtil.tableNotEmpty(slot1) then
		return
	end

	slot3 = slot0:_getInfoItem(slot2)
	slot3.type = slot2
	slot3.co = RoomTradeConfig.instance:getLevelUnlockCo(slot2)
	slot3.type = slot2

	for slot7, slot8 in ipairs(slot1) do
		if LuaUtil.tableNotEmpty(slot8.num) then
			slot3.descTxt.text = GameUtil.getSubPlaceholderLuaLangOneParam(RoomTradeConfig.instance:getLevelUnlockCo(slot2).levelupDes, slot9.cur - slot9.last)
		else
			slot3.descTxt.text = slot10.levelupDes
		end
	end

	gohelper.setActive(slot3.go, true)
end

function slot0._getInfoItem(slot0, slot1)
	if not slot0._unlockInfoItems then
		slot0._unlockInfoItems = slot0:getUserDataTb_()
	end

	if not slot0._unlockInfoItems[slot1] then
		slot2 = {
			go = slot3,
			descTxt = gohelper.findChildText(slot3, "desc"),
			itemGo = gohelper.findChild(slot3, "item"),
			bgGo = gohelper.findChild(slot3, "bg"),
			goicon = gohelper.findChild(slot3, "item/go_icon")
		}
		slot3 = gohelper.cloneInPlace(slot0._goinfo, "item_" .. slot1)

		gohelper.setActive(slot2.goicon, false)

		slot0._unlockInfoItems[slot1] = slot2
	end

	return slot2
end

return slot0
