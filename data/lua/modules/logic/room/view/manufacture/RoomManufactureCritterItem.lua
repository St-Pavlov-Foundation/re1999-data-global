module("modules.logic.room.view.manufacture.RoomManufactureCritterItem", package.seeall)

slot0 = class("RoomManufactureCritterItem", ListScrollCellExtend)
slot1 = 0.5
slot2 = 99999

function slot0.onInitView(slot0)
	slot0._goicon = gohelper.findChild(slot0.viewGO, "#go_icon")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#go_info/#txt_name")
	slot0._imageskill = gohelper.findChildImage(slot0.viewGO, "#go_info/#go_skill/#image_skill")
	slot0._gosimageskill = slot0._imageskill.gameObject
	slot0._txtefficiency = gohelper.findChildText(slot0.viewGO, "#go_info/#go_layoutAttr/#go_efficiency/#txt_efficiency")
	slot0._txtmoodcostspeed = gohelper.findChildText(slot0.viewGO, "#go_info/#go_layoutAttr/#go_moodCostSpeed/#txt_moodCostSpeed")
	slot0._txtcrirate = gohelper.findChildText(slot0.viewGO, "#go_info/#go_layoutAttr/#go_criRate/#txt_criRate")
	slot0._goselected = gohelper.findChild(slot0.viewGO, "#go_selected")
	slot0._gohighQuality = gohelper.findChild(slot0.viewGO, "#go_highQuality")
	slot0._btnclick = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "#btn_click")
	slot0._goskillTabLayout = gohelper.findChild(slot0.viewGO, "#go_info/#go_skillTabLayout")
	slot0._goskillTabItem = gohelper.findChild(slot0.viewGO, "#go_info/#go_skillTabLayout/#go_skillTabItem")
	slot0._btnlongPrees = SLFramework.UGUI.UILongPressListener.Get(slot0._btnclick.gameObject)

	slot0._btnlongPrees:SetLongPressTime({
		uv0,
		uv1
	})

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0._btnlongPrees:AddLongPressListener(slot0._onLongPress, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.CritterWorkInfoChange, slot0._onCritterWorkInfoChange, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.TransportCritterChanged, slot0._onCritterWorkInfoChange, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterUpdateAttrPreview, slot0._onAttrPreviewUpdate, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterRenameReply, slot0._onCritterRenameReply, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
	slot0._btnlongPrees:RemoveLongPressListener()
	slot0:removeEventCb(ManufactureController.instance, ManufactureEvent.CritterWorkInfoChange, slot0._onCritterWorkInfoChange, slot0)
	slot0:removeEventCb(RoomMapController.instance, RoomEvent.TransportCritterChanged, slot0._onCritterWorkInfoChange, slot0)
	slot0:removeEventCb(CritterController.instance, CritterEvent.CritterUpdateAttrPreview, slot0._onAttrPreviewUpdate, slot0)
	slot0:removeEventCb(CritterController.instance, CritterEvent.CritterRenameReply, slot0._onCritterRenameReply, slot0)
end

function slot0._btnclickOnClick(slot0)
	if slot0:getPathId() then
		ManufactureController.instance:clickTransportCritterItem(slot0:getCritterId())
	else
		ManufactureController.instance:clickCritterItem(slot1)
	end
end

function slot0._onLongPress(slot0)
	CritterController.instance:openRoomCritterDetailView(not slot0._mo:isMaturity(), slot0._mo)
end

function slot0._onCritterWorkInfoChange(slot0)
	slot0:refreshSelected()
end

function slot0._onAttrPreviewUpdate(slot0, slot1)
	if slot0:getCritterId() and not slot1[slot2] then
		return
	end

	slot0:refreshPreviewAttr()
	slot0:refreshPreviewSkill()
end

function slot0._onCritterRenameReply(slot0, slot1)
	if slot0:getCritterId() == slot1 then
		slot0:setCritter()
	end
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goskillTabItem, false)
end

function slot0.getViewBuilding(slot0)
	slot1, slot2, slot3 = slot0._view.viewContainer:getContainerViewBuilding()

	return slot1, slot2, slot3
end

function slot0.getPathId(slot0)
	return slot0._view.viewContainer:getContainerPathId()
end

function slot0.getCritterId(slot0)
	slot1, slot2 = nil

	if slot0._mo then
		slot1 = slot0._mo:getId()
		slot2 = slot0._mo:getDefineId()
	end

	return slot1, slot2
end

function slot0.getPreviewAttrInfo(slot0)
	slot1 = slot0:getCritterId()
	slot2 = true
	slot3 = nil

	if not slot0:getPathId() then
		slot4, slot5, slot3 = slot0:getViewBuilding()

		if slot5 and slot5:isCritterInSeatSlot(slot1) then
			slot2 = false
		end
	end

	return ManufactureCritterListModel.instance:getPreviewAttrInfo(slot1, slot3, slot2)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:setCritter()
	slot0:refresh()

	slot2, slot3, slot4 = slot0:getViewBuilding()

	CritterController.instance:getNextCritterPreviewAttr(slot4, slot0._index)
end

function slot0.setCritter(slot0)
	slot1, slot2 = slot0:getCritterId()

	if not slot0.critterIcon then
		slot0.critterIcon = IconMgr.instance:getCommonCritterIcon(slot0._goicon)
	end

	slot0.critterIcon:setMOValue(slot1, slot2)
	slot0.critterIcon:showMood()

	slot0._txtname.text = slot0._mo and slot0._mo:getName() or CritterConfig.instance:getCritterName(slot2)

	if slot0._mo and slot0._mo:getSkillInfo() then
		for slot7, slot8 in pairs(slot3) do
			if CritterConfig.instance:getCritterTagCfg(slot8) and slot9.type == CritterEnum.TagType.Race then
				UISpriteSetMgr.instance:setCritterSprite(slot0._imageskill, slot9.skillIcon)

				break
			end
		end
	end

	gohelper.setActive(slot0._gohighQuality, slot0._mo:getIsHighQuality())
end

function slot0.refresh(slot0)
	slot0:refreshSelected()
	slot0:refreshPreviewAttr()
	slot0:refreshPreviewSkill()
end

function slot0.refreshSelected(slot0)
	if not slot0.critterIcon then
		return
	end

	slot1 = false
	slot4 = RoomMapTransportPathModel.instance:getTransportPathMOByCritterUid(slot0:getCritterId()) and slot3.id
	slot5 = ManufactureModel.instance:getCritterWorkingBuilding(slot2)
	slot1 = slot0:getPathId() and slot4 == slot6 or slot0:getViewBuilding() == slot5

	slot0.critterIcon:setIsShowBuildingIcon((slot4 or slot5) and not slot1)
	gohelper.setActive(slot0._goselected, slot1)
end

function slot0.refreshPreviewAttr(slot0)
	slot1 = slot0:getPreviewAttrInfo()

	ZProj.UGUIHelper.SetGrayscale(slot0._gosimageskill, not slot1.isSpSkillEffect)

	slot0._txtefficiency.text = slot1.efficiency or 0
	slot0._txtmoodcostspeed.text = GameUtil.getSubPlaceholderLuaLang(luaLang("critter_mood_cost_speed"), {
		slot1.moodCostSpeed or 0
	})
	slot0._txtcrirate.text = string.format("%s%%", slot1.criRate or 0)
end

function slot0.refreshPreviewSkill(slot0)
	slot0._skillTbList = slot0._skillTbList or {}
	slot2 = 0

	if slot0._mo and slot0._mo:getSkillInfo() then
		slot3 = slot0:getPreviewAttrInfo()

		for slot7, slot8 in pairs(slot1) do
			if CritterConfig.instance:getCritterTagCfg(slot8) and slot9.type == CritterEnum.SkilTagType.Common then
				if not slot0._skillTbList[slot2 + 1] then
					slot11 = gohelper.cloneInPlace(slot0._goskillTabItem)
					slot10 = slot0:getUserDataTb_()
					slot10.go = slot11
					slot10.skillIcon = gohelper.findChildImage(slot11, "image_skillIcon")
					slot10.goskillIcon = slot10.skillIcon.gameObject
					slot0._skillTbList[slot2] = slot10
				end

				UISpriteSetMgr.instance:setCritterSprite(slot10.skillIcon, slot9.skillIcon)

				slot11 = true

				if slot3 and slot3.skillTags and tabletool.indexOf(slot3.skillTags, slot9.id) then
					slot11 = false
				end

				ZProj.UGUIHelper.SetGrayscale(slot10.goskillIcon, slot11)
			end
		end
	end

	for slot6 = 1, #slot0._skillTbList do
		gohelper.setActive(slot0._skillTbList[slot6].go, slot6 <= slot2)
	end
end

function slot0.onDestroyView(slot0)
end

return slot0
