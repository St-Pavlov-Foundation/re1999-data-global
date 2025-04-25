module("modules.logic.room.view.critter.detail.RoomCritterDetailMaturityView", package.seeall)

slot0 = class("RoomCritterDetailMaturityView", RoomCritterDetailView)

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg")
	slot0._gomaturity = gohelper.findChild(slot0.viewGO, "#go_maturity")
	slot0._txtbuilding = gohelper.findChildText(slot0.viewGO, "#go_maturity/Left/building/bg/#txt_building")
	slot0._imagebuildingicon = gohelper.findChildImage(slot0.viewGO, "#go_maturity/Left/building/#image_buildingicon")
	slot0._godetail = gohelper.findChild(slot0.viewGO, "#go_maturity/Left/#go_detail")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#go_maturity/Left/#go_detail/#txt_name")
	slot0._imagelock = gohelper.findChildImage(slot0.viewGO, "#go_maturity/Left/#go_detail/#txt_name/#image_lock")
	slot0._btnnameedit = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_maturity/Left/#go_detail/#txt_name/#btn_nameedit")
	slot0._txttag1 = gohelper.findChildText(slot0.viewGO, "#go_maturity/Left/#go_detail/tag/#txt_tag1")
	slot0._txttag2 = gohelper.findChildText(slot0.viewGO, "#go_maturity/Left/#go_detail/tag/#txt_tag2")
	slot0._imagesort = gohelper.findChildImage(slot0.viewGO, "#go_maturity/Left/#go_detail/#image_sort")
	slot0._txtsort = gohelper.findChildText(slot0.viewGO, "#go_maturity/Left/#go_detail/#image_sort/#txt_sort")
	slot0._scrolldes = gohelper.findChildScrollRect(slot0.viewGO, "#go_maturity/Left/#go_detail/#scroll_des")
	slot0._txtDesc = gohelper.findChildText(slot0.viewGO, "#go_maturity/Left/#go_detail/#scroll_des/viewport/content/#txt_Desc")
	slot0._btnreport = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_maturity/Left/#btn_report")
	slot0._gocritterlive2d = gohelper.findChild(slot0.viewGO, "#go_maturity/Middle/#go_critterlive2d")
	slot0._scrollbase = gohelper.findChildScrollRect(slot0.viewGO, "#go_maturity/Right/base/#scroll_base")
	slot0._gobaseitem = gohelper.findChild(slot0.viewGO, "#go_maturity/Right/base/#scroll_base/viewport/content/#go_baseitem")
	slot0._scrolltipbase = gohelper.findChildScrollRect(slot0.viewGO, "#go_maturity/Right/base/basetips/#scroll_base")
	slot0._gobasetipsitem = gohelper.findChild(slot0.viewGO, "#go_maturity/Right/base/basetips/#scroll_base/viewport/content/#go_basetipsitem")
	slot0._scrollskill = gohelper.findChildScrollRect(slot0.viewGO, "#go_maturity/Right/skill/#scroll_skill")
	slot0._goskillItem = gohelper.findChild(slot0.viewGO, "#go_maturity/Right/skill/#scroll_skill/viewport/content/#go_skillItem")
	slot0._scrollnormalskill = gohelper.findChildScrollRect(slot0.viewGO, "#go_maturity/Right/normalskill/#scroll_normalskill")
	slot0._gonormalskillitem = gohelper.findChild(slot0.viewGO, "#go_maturity/Right/normalskill/#scroll_normalskill/viewport/content/#go_normalskillitem")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")
	slot0._gostar = gohelper.findChild(slot0.viewGO, "#go_maturity/Left/#go_detail/starList")
	slot0._gotipbase = gohelper.findChild(slot0.viewGO, "#go_maturity/Right/base/basetips")
	slot0._gobuilding = gohelper.findChild(slot0.viewGO, "#go_maturity/Left/building")
	slot0._goLock = gohelper.findChild(slot0.viewGO, "#go_maturity/Left/#go_detail/#txt_name/#image_lock")
	slot0._gonormalskill = gohelper.findChild(slot0.viewGO, "#go_maturity/Right/normalskill")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	uv0.super.addEvents(slot0)
	slot0._btnreport:AddClickListener(slot0._btnreportOnClick, slot0)
	slot0._btnnameedit:AddClickListener(slot0._btnnameeditOnClick, slot0)
end

function slot0.removeEvents(slot0)
	uv0.super.removeEvents(slot0)
	slot0._btnreport:RemoveClickListener()
	slot0._btnnameedit:RemoveClickListener()
end

function slot0._btnreportOnClick(slot0)
	RoomCritterController.instance:openTrainReporView(slot0._critterMo:getId(), slot0._critterMo.trainHeroId, slot0._critterMo.totalFinishCount)
end

function slot0._btnnameeditOnClick(slot0)
	if slot0._critterMo then
		RoomCritterController.instance:openRenameView(slot0._critterMo:getId())
	end
end

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterRenameReply, slot0._onCritterRenameReply, slot0)
	uv0.super.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_mj_open)
end

function slot0._onCritterRenameReply(slot0, slot1)
	if slot0._critterMo and slot0._critterMo.id == slot1 then
		slot0:showInfo()
	end
end

function slot0.onRefresh(slot0)
	slot0._critterMo = slot0.viewParam.critterMo

	uv0.super.onRefresh(slot0)
	slot0:refreshWordInfo()
	slot0:refreshTrainInfo()
end

function slot0.getAttrRatio(slot0, slot1, slot2)
	return slot2:getValueNum()
end

function slot0.refreshWordInfo(slot0)
	if not slot0._critterMo then
		return
	end

	slot1 = nil
	slot3 = false
	slot5 = nil

	if ManufactureModel.instance:getCritterWorkingBuilding(slot0._critterMo:getId()) or ManufactureModel.instance:getCritterRestingBuilding(slot2) then
		if RoomMapBuildingModel.instance:getBuildingMOById(slot4) then
			slot5 = ManufactureConfig.instance:getManufactureBuildingIcon(slot6.buildingId)
			slot1 = slot6.config.useDesc
			slot3 = true
		end
	elseif RoomMapTransportPathModel.instance:getTransportPathMOByCritterUid(slot2) then
		slot5 = RoomTransportHelper.getVehicleCfgByBuildingId(slot6.buildingId, slot6.buildingSkinId) and slot9.buildIcon
		slot1 = luaLang(RoomBuildingEnum.BuildingTypeSiteLangKey[RoomTransportHelper.fromTo2SiteType(slot6.fromType, slot6.toType)])
		slot3 = true
	end

	if slot3 then
		slot0._txtbuilding.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("room_critter_working_in"), slot1)

		UISpriteSetMgr.instance:setRoomSprite(slot0._imagebuildingicon, slot5)
	end

	gohelper.setActive(slot0._gobuilding, slot3)
end

function slot0.showSkill(slot0)
	uv0.super.showSkill(slot0)

	if not slot0._critterMo then
		return
	end

	if slot0._critterMo:getSkillInfo() then
		gohelper.setActive(slot0._gonormalskill.gameObject, true)

		slot2 = 1

		for slot6, slot7 in pairs(slot1) do
			if CritterConfig.instance:getCritterTagCfg(slot7) and slot8.type ~= RoomCritterDetailView._exclusiveSkill then
				slot0:getNormalSkillItem(slot2):onRefreshMo(slot8)

				slot2 = slot2 + 1
			end
		end

		if slot0._normalSkillItems then
			for slot6 = 1, #slot0._normalSkillItems do
				gohelper.setActive(slot0._normalSkillItems[slot6].viewGO, slot6 < slot2)
			end
		end
	else
		gohelper.setActive(slot0._gonormalskill.gameObject, false)
	end
end

function slot0.refreshTrainInfo(slot0)
	gohelper.setActive(slot0._btnreport.gameObject, slot0:_isShowReport())
end

function slot0._isShowReport(slot0)
	if slot0._critterMo and slot0._critterMo:isMaturity() and slot0._critterMo.trainHeroId and tonumber(slot0._critterMo.trainHeroId) ~= 0 then
		return true
	end

	return false
end

function slot0.getNormalSkillItem(slot0, slot1)
	if not slot0._normalSkillItems then
		slot0._normalSkillItems = slot0:getUserDataTb_()
	end

	if not slot0._normalSkillItems[slot1] then
		slot0._normalSkillItems[slot1] = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.cloneInPlace(slot0._gonormalskillitem), RoomCritterDetailSkillItem)
	end

	return slot2
end

return slot0
