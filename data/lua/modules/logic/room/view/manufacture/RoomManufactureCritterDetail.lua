module("modules.logic.room.view.manufacture.RoomManufactureCritterDetail", package.seeall)

slot0 = class("RoomManufactureCritterDetail", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gocritter = gohelper.findChild(slot0.viewGO, "go_critterLayer/#go_critter")
	slot0._txtcritterName = gohelper.findChildText(slot0.viewGO, "go_critterLayer/#txt_critterName")
	slot0._gomood = gohelper.findChild(slot0.viewGO, "go_critterLayer/#go_mood")
	slot0._gohasMood = gohelper.findChild(slot0.viewGO, "go_critterLayer/#go_mood/#go_hasMood")
	slot0._simagemood = gohelper.findChildSingleImage(slot0.viewGO, "go_critterLayer/#go_mood/#go_hasMood/#simage_mood")
	slot0._simageprogress = gohelper.findChildSingleImage(slot0.viewGO, "go_critterLayer/#go_mood/#go_hasMood/#simage_progress")
	slot0._txtmood = gohelper.findChildText(slot0.viewGO, "go_critterLayer/#go_mood/#go_hasMood/#txt_mood")
	slot0._gonoMood = gohelper.findChild(slot0.viewGO, "go_critterLayer/#go_mood/#go_noMood")
	slot0._goskillItem = gohelper.findChild(slot0.viewGO, "#go_skillItem")
	slot0._txtskillname = gohelper.findChildText(slot0.viewGO, "#go_skillItem/title/#txt_skillname")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "#go_skillItem/title/#txt_skillname/#image_icon")
	slot0._txtskilldec = gohelper.findChildText(slot0.viewGO, "#go_skillItem/#txt_skilldec")
	slot0._gobaseitem = gohelper.findChild(slot0.viewGO, "#go_baseitem")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#go_baseitem/#txt_name")
	slot0._txtratio = gohelper.findChildText(slot0.viewGO, "#go_baseitem/#txt_ratio")
	slot0._gobaseLayer = gohelper.findChild(slot0.viewGO, "#go_baseLayer")
	slot0._goskill = gohelper.findChild(slot0.viewGO, "#go_skill")
	slot0._goskillActive = gohelper.findChild(slot0.viewGO, "#go_skillActive")
	slot0._btnyulan = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_skillActive/#btn_yulan")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnyulan:AddClickListener(slot0._btnyulanOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnyulan:RemoveClickListener()
end

function slot0._btnyulanOnClick(slot0)
	slot0:_setShowInvalidSkill(slot0._isShowInvalidSkill == false)
end

function slot0._editableInitView(slot0)
	slot0._godark = gohelper.findChild(slot0.viewGO, "#go_skillActive/#btn_yulan/dark")
	slot0._golight = gohelper.findChild(slot0.viewGO, "#go_skillActive/#btn_yulan/light")
	slot0._imageprogress = gohelper.findChildImage(slot0.viewGO, "go_critterLayer/#go_mood/#go_hasMood/#simage_progress")
	slot0._Type_Canvas_Group = typeof(UnityEngine.CanvasGroup)
	slot0._skillTBList = {}
	slot0._skillTBInvalidList = {}

	gohelper.setActive(slot0._gobaseitem, false)
	gohelper.setActive(slot0._goskillItem, false)

	slot0._maxMood = tonumber(ManufactureConfig.instance:getManufactureConst(RoomManufactureEnum.ConstId.CritterMaxMood)) or 0
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._critterMO = slot1
	slot0._tagsCfgList = {}
	slot0._tagsCfgInvalidList = {}
	slot0._preViewAttrInfo = {}
	slot0._buildingId = slot0:getBuildingId()
	slot0._previewAttrInfo = nil

	if slot0._critterMO and slot0._critterMO.skillInfo then
		slot2 = ManufactureCritterListModel.instance:getPreviewAttrInfo(slot0._critterMO:getId(), slot0._buildingId, false)
		slot3 = slot0._critterMO.skillInfo.tags or {}

		for slot7 = 1, #slot3 do
			if CritterConfig.instance:getCritterTagCfg(slot3[slot7]) then
				if slot2 and slot2.skillTags and tabletool.indexOf(slot2.skillTags, slot8.id) then
					table.insert(slot0._tagsCfgList, slot8)
				else
					table.insert(slot0._tagsCfgInvalidList, slot8)
				end
			end
		end
	end

	slot0:_refreshCritterUI()
	slot0:_refreshAttr()
	slot0:_refreshTagTB(slot0._tagsCfgList, slot0._skillTBList, slot0._goskill)
	slot0:_refreshTagTB(slot0._tagsCfgInvalidList, slot0._skillTBInvalidList, slot0._goskillActive, 0.5)
	slot0:_setShowInvalidSkill(false)
	gohelper.setActive(slot0._btnyulan, #slot0._tagsCfgInvalidList > 0)
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
	for slot4 = 1, #slot0._attrItems do
		slot0._attrItems[slot4]:onDestroy()
	end
end

function slot0.getBuildingId(slot0)
	slot1 = nil

	if slot0._critterMO then
		slot2, slot3 = slot0._critterMO:getWorkBuildingInfo()

		if RoomMapBuildingModel.instance:getBuildingMOById(slot2) then
			slot1 = slot4.buildingId
		end
	end

	return slot1
end

function slot0._createTagTB(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.go = slot1
	slot2._txtskillname = gohelper.findChildText(slot1, "title/#txt_skillname")
	slot2._imageicon = gohelper.findChildImage(slot1, "title/#txt_skillname/#image_icon")
	slot2._txtskilldec = gohelper.findChildText(slot1, "#txt_skilldec")

	return slot2
end

function slot0._refreshTagTB(slot0, slot1, slot2, slot3, slot4)
	slot5 = 0

	if not slot2 then
		return
	end

	if slot1 and #slot1 > 0 then
		for slot10, slot11 in ipairs(slot1) do
			slot5 = slot5 + 1

			if not slot6[slot10] then
				table.insert(slot6, slot0:_createTagTB(gohelper.clone(slot0._goskillItem, slot3)))

				if slot4 then
					slot13:GetComponent(slot0._Type_Canvas_Group).alpha = slot4
				end
			end

			slot12._txtskillname.text = slot11.name
			slot12._txtskilldec.text = slot11.desc

			UISpriteSetMgr.instance:setCritterSprite(slot12._imageicon, slot11.skillIcon)
		end
	end

	for slot10 = 1, #slot6 do
		gohelper.setActive(slot6[slot10].go, slot10 <= slot5)
	end
end

function slot0._setTagTBActive(slot0, slot1, slot2)
	for slot6 = 1, #slot1 do
		gohelper.setActive(slot1[slot6].go, slot6 <= slot2)
	end
end

function slot0._setShowInvalidSkill(slot0, slot1)
	slot2 = slot1 and true or false
	slot0._isShowInvalidSkill = slot2

	gohelper.setActive(slot0._godark, slot2)
	gohelper.setActive(slot0._golight, not slot2)
	slot0:_setTagTBActive(slot0._skillTBInvalidList, slot2 and #slot0._skillTBInvalidList or 0)
end

function slot0._refreshAttr(slot0)
	if not slot0._critterMO then
		return
	end

	slot1 = slot0._critterMO:getAttributeInfos()

	if not slot0._attrItems then
		slot0._attrItems = slot0:getUserDataTb_()
	end

	slot2 = 1

	if slot1 then
		slot3 = slot0._critterMO.id

		for slot7, slot8 in pairs(slot1) do
			if not slot0._attrItems[slot2] then
				table.insert(slot0._attrItems, MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.clone(slot0._gobaseitem, slot0._gobaseLayer), RoomCritterDetailAttrItem))
			end

			slot11 = CritterHelper.formatAttrValue(slot8.attributeId, CritterHelper.getPreViewAttrValue(slot8.attributeId, slot3, slot0._buildingId, false))

			slot9:onRefreshMo(slot8, slot2, slot11, slot11, slot8:getName())

			slot2 = slot2 + 1
		end
	end

	for slot6 = 1, #slot0._attrItems do
		gohelper.setActive(slot0._attrItems[slot6].viewGO, slot6 < slot2)
	end
end

function slot0._refreshCritterUI(slot0)
	if not slot0._critterMO then
		return
	end

	if not slot0.critterIcon then
		slot0.critterIcon = IconMgr.instance:getCommonCritterIcon(slot0._gocritter)
	end

	slot0.critterIcon:setMOValue(slot0._critterMO:getId(), slot0._critterMO:getDefineId())

	slot0._txtcritterName.text = slot0._critterMO:getName()
	slot1 = slot0._critterMO:isNoMood()

	gohelper.setActive(slot0._gonoMood, slot1)
	gohelper.setActive(slot0._gohasMood, not slot1)

	if not slot1 then
		slot0._txtmood.text = slot0._critterMO:getMoodValue()
		slot3 = 1

		if slot0._maxMood ~= 0 then
			slot3 = slot2 / slot0._maxMood
		end

		slot0._imageprogress.fillAmount = slot3
	end
end

slot0.prefabPath = "ui/viewres/room/manufacture/roommanufacturecritterdetail.prefab"

return slot0
