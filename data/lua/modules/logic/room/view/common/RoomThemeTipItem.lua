module("modules.logic.room.view.common.RoomThemeTipItem", package.seeall)

slot0 = class("RoomThemeTipItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._hideSourcesShowTypeMap = {
		[RoomEnum.SourcesShowType.Cobrand] = true
	}

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._gobuildingicon = gohelper.findChild(slot0.viewGO, "go_buildingicon")
	slot0._goplaneicon = gohelper.findChild(slot0.viewGO, "go_planeicon")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "txt_name")
	slot0._txtstate = gohelper.findChildText(slot0.viewGO, "txt_state")
	slot0._gosource = gohelper.findChild(slot0.viewGO, "go_source")
	slot0._gosourceItem = gohelper.findChild(slot0.viewGO, "go_source/go_sourceItem")
	slot0._sourceTab = slot0:getUserDataTb_()

	gohelper.setActive(slot0._gosourceItem, false)
end

function slot0._refreshUI(slot0)
	slot2 = slot0._themeItemMO.itemNum <= slot0._themeItemMO:getItemQuantity()

	gohelper.setActive(slot0._gobuildingicon, slot0._themeItemMO.materialType == MaterialEnum.MaterialType.Building)
	gohelper.setActive(slot0._goplaneicon, slot0._themeItemMO.materialType == MaterialEnum.MaterialType.BlockPackage)

	slot3 = slot0._themeItemMO:getItemConfig()

	for slot7, slot8 in pairs(slot0._sourceTab) do
		gohelper.setActive(slot8.go, false)
	end

	slot0._txtname.text = slot3 and slot3.name or ""
	slot0._txtstate.text = slot0:_getStateStr(slot0._themeItemMO.itemNum, slot1)

	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtstate, slot2 and "#65B96F" or "#D97373")

	if not string.nilorempty(slot3.sourcesType) then
		slot4 = string.splitToNumber(slot3.sourcesType, "#")
		slot8 = slot4

		slot0:_sortSource(slot8)

		for slot8, slot9 in pairs(slot4) do
			if RoomConfig.instance:getSourcesTypeConfig(slot9) and (not slot10.showType or not slot0._hideSourcesShowTypeMap[slot10.showType]) then
				slot11 = slot0:_getSourceItem(slot9)

				gohelper.setActive(slot11.go, true)

				slot11.txt.text = string.format("<color=%s>%s</color>", slot10.nameColor, slot10.name)

				UISpriteSetMgr.instance:setRoomSprite(slot11.bg, slot10.bgIcon)
				SLFramework.UGUI.GuiHelper.SetColor(slot11.bg, string.nilorempty(slot10.bgColor) and "#FFFFFF" or slot10.bgColor)
			elseif slot10 == nil then
				logError(string.format("小屋主题\"export_获得类型\"缺少配置。id:%s", slot9))
			end
		end
	end
end

function slot0._getSourceItem(slot0, slot1)
	if not slot0._sourceTab[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.go = gohelper.clone(slot0._gosourceItem, slot0._gosource, "source" .. slot1)
		slot2.txt = gohelper.findChildText(slot2.go, "txt")
		slot2.bg = gohelper.findChildImage(slot2.go, "bg")

		gohelper.setActive(slot2.go, false)

		slot0._sourceTab[slot1] = slot2
	end

	return slot2
end

function slot0._sortSource(slot0, slot1)
	table.sort(slot1, uv0._sortFunc)
end

function slot0._sortFunc(slot0, slot1)
	if RoomConfig.instance:getSourcesTypeConfig(slot0).order ~= RoomConfig.instance:getSourcesTypeConfig(slot1).order then
		return slot2 < slot3
	end
end

function slot0._getStateStr(slot0, slot1, slot2)
	slot3 = slot1 <= slot2

	return string.format("%s/%s", slot2, slot1)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._themeItemMO = slot1

	slot0:_refreshUI()
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
end

return slot0
