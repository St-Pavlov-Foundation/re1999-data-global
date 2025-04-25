module("modules.logic.room.view.critter.RoomCritterTrainReportView", package.seeall)

slot0 = class("RoomCritterTrainReportView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._simagepage = gohelper.findChildSingleImage(slot0.viewGO, "page1/#simage_page")
	slot0._simagetitle = gohelper.findChildSingleImage(slot0.viewGO, "page1/top/#simage_title")
	slot0._goqualityhigh = gohelper.findChild(slot0.viewGO, "page1/top/#go_qualityhigh")
	slot0._goqualitylow = gohelper.findChild(slot0.viewGO, "page1/top/#go_qualitylow")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "page1/top/#txt_name")
	slot0._btnnameedit = gohelper.findChildButtonWithAudio(slot0.viewGO, "page1/top/#txt_name/#btn_nameedit")
	slot0._gocrittericon = gohelper.findChild(slot0.viewGO, "page1/top/critter/#go_crittericon")
	slot0._gostarList = gohelper.findChild(slot0.viewGO, "page1/top/#go_starList")
	slot0._scrolldes = gohelper.findChildScrollRect(slot0.viewGO, "page1/top/#scroll_des")
	slot0._txtDesc = gohelper.findChildText(slot0.viewGO, "page1/top/#scroll_des/viewport/content/#txt_Desc")
	slot0._txttag1 = gohelper.findChildText(slot0.viewGO, "page1/top/tag/#txt_tag1")
	slot0._txttag2 = gohelper.findChildText(slot0.viewGO, "page1/top/tag/#txt_tag2")
	slot0._txtwork = gohelper.findChildText(slot0.viewGO, "page1/middle/work/#txt_work")
	slot0._imagelvwork = gohelper.findChildImage(slot0.viewGO, "page1/middle/work/#image_lv_work")
	slot0._txtheart = gohelper.findChildText(slot0.viewGO, "page1/middle/heart/#txt_heart")
	slot0._imagelvheart = gohelper.findChildImage(slot0.viewGO, "page1/middle/heart/#image_lv_heart")
	slot0._txtlucky = gohelper.findChildText(slot0.viewGO, "page1/middle/lucky/#txt_lucky")
	slot0._imagelvlucky = gohelper.findChildImage(slot0.viewGO, "page1/middle/lucky/#image_lv_lucky")
	slot0._scrollskill = gohelper.findChildScrollRect(slot0.viewGO, "page1/bottom/1/#scroll_skill")
	slot0._goskillItem = gohelper.findChild(slot0.viewGO, "page1/bottom/1/#scroll_skill/viewport/content/#go_skillItem")
	slot0._txtskillname = gohelper.findChildText(slot0.viewGO, "page1/bottom/1/#scroll_skill/viewport/content/#go_skillItem/title/#txt_skillname")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "page1/bottom/1/#scroll_skill/viewport/content/#go_skillItem/title/#txt_skillname/#image_icon")
	slot0._txtskilldec = gohelper.findChildText(slot0.viewGO, "page1/bottom/1/#scroll_skill/viewport/content/#go_skillItem/#txt_skilldec")
	slot0._btnsubtag1 = gohelper.findChildButtonWithAudio(slot0.viewGO, "page1/bottom/#btn_subtag1")
	slot0._btnsubtag2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "page1/bottom/#btn_subtag2")
	slot0._btnsubtag3 = gohelper.findChildButtonWithAudio(slot0.viewGO, "page1/bottom/#btn_subtag3")
	slot0._goempty = gohelper.findChild(slot0.viewGO, "page1/bottom/#go_empty")
	slot0._simagesmallpage = gohelper.findChildSingleImage(slot0.viewGO, "page2/#simage_smallpage")
	slot0._imagequality = gohelper.findChildImage(slot0.viewGO, "page2/heroinfo/#image_quality")
	slot0._simageheroicon = gohelper.findChildSingleImage(slot0.viewGO, "page2/heroinfo/#image_quality/#simage_heroicon")
	slot0._txtheroname = gohelper.findChildText(slot0.viewGO, "page2/heroinfo/#txt_heroname")
	slot0._txtherolevel = gohelper.findChildText(slot0.viewGO, "page2/heroinfo/#txt_herolevel")
	slot0._scrollcomments = gohelper.findChildScrollRect(slot0.viewGO, "page2/#scroll_comments")
	slot0._txtdec = gohelper.findChildText(slot0.viewGO, "page2/#scroll_comments/viewport/content/#txt_dec")
	slot0._simagesignature = gohelper.findChildSingleImage(slot0.viewGO, "page2/#simage_signature")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnnameedit:AddClickListener(slot0._btnnameeditOnClick, slot0)
	slot0._btnsubtag1:AddClickListener(slot0._btnsubtag1OnClick, slot0)
	slot0._btnsubtag2:AddClickListener(slot0._btnsubtag2OnClick, slot0)
	slot0._btnsubtag3:AddClickListener(slot0._btnsubtag3OnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnnameedit:RemoveClickListener()
	slot0._btnsubtag1:RemoveClickListener()
	slot0._btnsubtag2:RemoveClickListener()
	slot0._btnsubtag3:RemoveClickListener()
end

function slot0._btnnameeditOnClick(slot0)
	RoomCritterController.instance:openRenameView(slot0._critterUid)
end

function slot0._btnsubtag1OnClick(slot0)
	slot0:_selectSubTag(CritterEnum.SkilTagType.Common)
end

function slot0._btnsubtag2OnClick(slot0)
	slot0:_selectSubTag(CritterEnum.SkilTagType.Base)
end

function slot0._btnsubtag3OnClick(slot0)
	slot0:_selectSubTag(CritterEnum.SkilTagType.Race)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._starTbList = slot0:getUserDataTb_()

	for slot4 = 1, 6 do
		table.insert(slot0._starTbList, gohelper.findChild(slot0._gostarList, "star" .. slot4))
	end

	slot0._tagsTbListDict = {}
	slot0._tagType2IdxDict = {}
	slot0._goskillItemDict = slot0:getUserDataTb_()
	slot0._goSubTagList = slot0:getUserDataTb_()
	slot0._tagTypeList = {
		CritterEnum.SkilTagType.Common,
		CritterEnum.SkilTagType.Base,
		CritterEnum.SkilTagType.Race
	}
	slot0._tagsCfgMap = {}

	for slot4 = 1, #slot0._tagTypeList do
		slot5 = gohelper.findChild(slot0.viewGO, "page1/bottom/" .. slot4)
		slot0._goSubTagList[slot4] = slot5
		slot6 = gohelper.findChild(slot5, "#scroll_skill/viewport/content/#go_skillItem")
		slot7 = slot0._tagTypeList[slot4]
		slot0._tagType2IdxDict[slot7] = slot4
		slot0._goskillItemDict[slot7] = slot6
		slot0._tagsTbListDict[slot7] = {}

		table.insert(slot0._tagsTbListDict[slot7], slot0:_createTagTB(slot6))
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterRenameReply, slot0._onCritterRenameReply, slot0)

	slot0._critterUid = slot0.viewParam and slot0.viewParam.critterUid
	slot0._heroId = slot0.viewParam and slot0.viewParam.heroId
	slot0._trainNum = slot0.viewParam and slot0.viewParam.tranNum or 1
	slot0._critterMO = CritterModel.instance:getCritterMOByUid(slot0._critterUid)
	slot0._heroMO = HeroModel.instance:getByHeroId(slot0._heroId)
	slot0._tagsCfgMap = {}

	if slot0._critterMO and slot0._critterMO.skillInfo then
		slot1 = slot0._critterMO.skillInfo.tags or {}

		for slot5 = 1, #slot1 do
			if CritterConfig.instance:getCritterTagCfg(slot1[slot5]) then
				slot0._tagsCfgMap[slot6.type] = slot0._tagsCfgMap[slot6.type] or {}

				table.insert(slot0._tagsCfgMap[slot6.type], slot6)
			end
		end
	end

	slot0:refreshUI()

	slot1 = nil

	for slot5, slot6 in ipairs(slot0._tagTypeList) do
		if slot0._tagsCfgMap[slot6] and #slot7 > 0 then
			slot1 = slot6

			break
		end
	end

	slot0:_selectSubTag(slot1 or CritterEnum.SkilTagType.Base)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_mj_dabiao)
end

function slot0.onClose(slot0)
	slot0._simageheroicon:UnLoadImage()
end

function slot0.onDestroyView(slot0)
end

function slot0._onCritterRenameReply(slot0, slot1)
	if slot0._critterMO and slot0._critterUid == slot1 then
		slot0._txtname.text = slot0._critterMO:getName()
	end
end

function slot0._createTagTB(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.go = slot1
	slot2._txtskillname = gohelper.findChildText(slot1, "title/#txt_skillname")
	slot2._imageicon = gohelper.findChildImage(slot1, "title/#txt_skillname/#image_icon")
	slot2._txtskilldec = gohelper.findChildText(slot1, "#txt_skilldec")

	return slot2
end

function slot0._selectSubTag(slot0, slot1)
	for slot6, slot7 in ipairs(slot0._goSubTagList) do
		gohelper.setActive(slot7, slot6 == (slot0._tagType2IdxDict and slot0._tagType2IdxDict[slot1] or 1))
	end

	gohelper.setActive(slot0._goempty, not slot0._tagsCfgMap[slot1] or #slot3 < 1)
end

function slot0.refreshUI(slot0)
	slot0:_refreshCritterTagUI()
	slot0:_refreshHeroUI()
	slot0:_refreshCritterUI()
end

function slot0._refreshCritterTagUI(slot0)
	for slot4, slot5 in ipairs(slot0._tagTypeList) do
		slot0:_refreshTagTBByTyp(slot5, slot0._tagsCfgMap[slot5])
	end
end

function slot0._refreshTagTBByTyp(slot0, slot1, slot2)
	slot3 = 0

	if not slot0._tagsTbListDict[slot1] then
		return
	end

	if slot2 and #slot2 > 0 then
		for slot8, slot9 in ipairs(slot2) do
			slot3 = slot3 + 1

			if not slot4[slot8] then
				table.insert(slot4, slot0:_createTagTB(gohelper.cloneInPlace(slot0._goskillItemDict[slot1])))
			end

			slot10._txtskillname.text = slot9.name
			slot10._txtskilldec.text = slot9.desc

			UISpriteSetMgr.instance:setCritterSprite(slot10._imageicon, slot9.skillIcon)
		end
	end

	for slot8 = 1, #slot4 do
		gohelper.setActive(slot4[slot8].go, slot8 <= slot3)
	end
end

function slot0._refreshCritterUI(slot0)
	if not slot0._critterMO then
		return
	end

	slot2 = slot0._critterMO.isHighQuality
	slot3 = slot0._critterMO.efficiency
	slot4 = slot0._critterMO.patience
	slot5 = slot0._critterMO.lucky
	slot0._txtwork.text = slot3
	slot0._txtheart.text = slot4
	slot0._txtlucky.text = slot5

	UISpriteSetMgr.instance:setCritterSprite(slot0._imagelvwork, slot0:_getLevelIconName(slot3))
	UISpriteSetMgr.instance:setCritterSprite(slot0._imagelvheart, slot0:_getLevelIconName(slot4))
	UISpriteSetMgr.instance:setCritterSprite(slot0._imagelvlucky, slot0:_getLevelIconName(slot5))

	slot0._txtname.text = slot0._critterMO:getName()
	slot0._txtDesc.text = slot0._critterMO:getDefineCfg() and slot1.desc or ""

	gohelper.setActive(slot0._txttag2, slot0._critterMO.specialSkin)
	gohelper.setActive(slot0._goqualityhigh, slot2)
	gohelper.setActive(slot0._goqualitylow, not slot2)

	if not slot0.critterIcon then
		slot0.critterIcon = IconMgr.instance:getCommonCritterIcon(slot0._gocrittericon)
	end

	slot0.critterIcon:setMOValue(slot0._critterMO:getId(), slot0._critterMO:getDefineId())

	for slot10 = 1, #slot0._starTbList do
		gohelper.setActive(slot0._starTbList[slot10], slot10 <= (slot1 and slot1.rare or 3) + 1)
	end

	slot0._txttag1.text = luaLang(slot0._critterMO:isMaturity() and "room_critter_adult" or "room_critter_child")
	slot0._txtdec.text = GameUtil.getSubPlaceholderLuaLangThreeParam(luaLang("critter_report_comment_txt"), slot0._trainNum, slot0:_getMaxAttrName(), slot0._tagsCfgMap[CritterEnum.SkilTagType.Common] and #slot8 or 0)
end

function slot0._getLevelIconName(slot0, slot1)
	return CritterConfig.instance:getCritterAttributeLevelCfgByValue(slot1) and slot2.icon or ""
end

function slot0._refreshHeroUI(slot0)
	if slot0._heroMO then
		slot1 = slot0._heroMO.config

		slot0._simageheroicon:LoadImage(ResUrl.getRoomHeadIcon(SkinConfig.instance:getSkinCo(slot0._heroMO.skin).headIcon))

		slot0._txtheroname.text = slot1.name

		slot0._simagesignature:LoadImage(ResUrl.getSignature(slot1.signature))
		UISpriteSetMgr.instance:setCritterSprite(slot0._imagequality, CritterEnum.QualityImageNameMap[slot1.rare])

		slot0._txtherolevel.text = luaLang(CritterEnum.LangKey.HeroTrainLevel)
	end
end

function slot0._getMaxAttrName(slot0)
	if not slot0._critterMO then
		return ""
	end

	slot2 = nil

	for slot6, slot7 in pairs(slot0._critterMO:getAttributeInfos()) do
		if slot2 == nil or slot2.value < slot7.value then
			slot2 = slot7
		end
	end

	slot3 = slot2 and CritterConfig.instance:getCritterAttributeCfg(slot2.attributeId)

	return slot3 and slot3.name or ""
end

return slot0
