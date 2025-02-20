module("modules.logic.tips.view.SkillTipView", package.seeall)

slot0 = class("SkillTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._gonewskilltip = gohelper.findChild(slot0.viewGO, "#go_newskilltip")
	slot0._gospecialitem = gohelper.findChild(slot0.viewGO, "#go_newskilltip/skilltipScrollview/Viewport/Content/name/special/#go_specialitem")
	slot0._goline = gohelper.findChild(slot0.viewGO, "#go_newskilltip/skilltipScrollview/Viewport/Content/#go_line")
	slot0._goskillspecialitem = gohelper.findChild(slot0.viewGO, "#go_newskilltip/skilltipScrollview/Viewport/Content/skillspecial/#go_skillspecialitem")
	slot0._goskilltipScrollviewContent = gohelper.findChild(slot0.viewGO, "#go_newskilltip/skilltipScrollview/Viewport/Content")
	slot0._scrollskilltipScrollview = gohelper.findChildScrollRect(slot0.viewGO, "#go_newskilltip/skilltipScrollview")
	slot0._goarrow = gohelper.findChild(slot0.viewGO, "#go_newskilltip/bottombg/#go_arrow")
	slot0._gostoryDesc = gohelper.findChild(slot0.viewGO, "#go_newskilltip/skilltipScrollview/Viewport/Content/#go_storyDesc")
	slot0._txtstory = gohelper.findChildText(slot0.viewGO, "#go_newskilltip/skilltipScrollview/Viewport/Content/#go_storyDesc/#txt_story")
	slot0._goBuffContainer = gohelper.findChild(slot0.viewGO, "#go_buffContainer")
	slot0._btnclosebuff = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_buffContainer/buff_bg")
	slot0._goBuffItem = gohelper.findChild(slot0.viewGO, "#go_buffContainer/#go_buffitem")
	slot0._txtBuffName = gohelper.findChildText(slot0.viewGO, "#go_buffContainer/#go_buffitem/title/txt_name")
	slot0._goBuffTag = gohelper.findChild(slot0.viewGO, "#go_buffContainer/#go_buffitem/title/txt_name/go_tag")
	slot0._txtBuffTagName = gohelper.findChildText(slot0.viewGO, "#go_buffContainer/#go_buffitem/title/txt_name/go_tag/bg/txt_tagname")
	slot0._txtBuffDesc = gohelper.findChildText(slot0.viewGO, "#go_buffContainer/#go_buffitem/txt_desc")
	slot0._btnupgradeShow = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_newskilltip/#btn_upgradeShow")
	slot0._goBtnNormal = gohelper.findChild(slot0._btnupgradeShow.gameObject, "#go_normal")
	slot0._goBtnUpgraded = gohelper.findChild(slot0._btnupgradeShow.gameObject, "#go_upgraded")
	slot0._goshowSelect = gohelper.findChild(slot0.viewGO, "#go_newskilltip/#go_showSelect")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclosebuff:AddClickListener(slot0._btnclosebuffOnClick, slot0)
	slot0._btnupgradeShow:AddClickListener(slot0._btnUpgradeShowOnClock, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclosebuff:RemoveClickListener()
	slot0._btnupgradeShow:RemoveClickListener()
end

slot0.skillTypeColor = {
	"#405874",
	"#8c4e31",
	"#9b7039"
}

function slot0._btnclosebuffOnClick(slot0)
	gohelper.setActive(slot0._goBuffContainer, false)
end

function slot0._refreshArrow(slot0)
	if recthelper.getHeight(slot0._scrollskilltipScrollview.transform) < recthelper.getHeight(slot0._goskilltipScrollviewContent.transform) and slot0._scrollskilltipScrollview.verticalNormalizedPosition > 0.01 then
		gohelper.setActive(slot0._goarrow, true)
	else
		gohelper.setActive(slot0._goarrow, false)
	end
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goBuffContainer, false)

	slot4 = slot0._refreshArrow

	slot0._scrollskilltipScrollview:AddOnValueChanged(slot4, slot0)

	slot0._newskillitems = {}

	for slot4 = 1, 3 do
		slot5 = gohelper.findChild(slot0._gonewskilltip, "normal/skillicon" .. tostring(slot4))
		slot6 = slot0:getUserDataTb_()
		slot6.go = slot5
		slot6.icon = gohelper.findChildSingleImage(slot5, "imgIcon")
		slot6.btn = gohelper.findChildButtonWithAudio(slot5, "bg")
		slot6.selectframe = gohelper.findChild(slot5, "selectframe")
		slot6.selectarrow = gohelper.findChild(slot5, "selectarrow")
		slot6.aggrandizement = gohelper.findChild(slot5, "aggrandizement")
		slot6.index = slot4

		slot6.btn:AddClickListener(slot0._skillItemClick, slot0, slot6.index)

		slot6.tag = gohelper.findChildSingleImage(slot5, "tag/tagIcon")
		slot0._newskillitems[slot4] = slot6
	end

	slot0._newsuperskill = slot0:getUserDataTb_()
	slot1 = gohelper.findChild(slot0._gonewskilltip, "super")
	slot0._newsuperskill.icon = gohelper.findChildSingleImage(slot1, "imgIcon")
	slot0._newsuperskill.tag = gohelper.findChildSingleImage(slot1, "tag/tagIcon")
	slot0._newsuperskill.aggrandizement = gohelper.findChild(slot1, "aggrandizement")
	slot0._newskilltips = slot0:getUserDataTb_()
	slot0._newskilltips[1] = gohelper.findChild(slot0._gonewskilltip, "normal")
	slot0._newskilltips[2] = gohelper.findChild(slot0._gonewskilltip, "super")
	slot0._newskillname = gohelper.findChildText(slot0._goskilltipScrollviewContent, "name")
	slot0._newskilldesc = gohelper.findChildText(slot0._goskilltipScrollviewContent, "desc")
	slot0._fixTmpBreakLine = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._newskilldesc.gameObject, FixTmpBreakLine)

	SkillHelper.addHyperLinkClick(slot0._newskilldesc, slot0._onHyperLinkClick, slot0)

	slot0._skillTagGOs = slot0:getUserDataTb_()
	slot0._skillEffectGOs = slot0:getUserDataTb_()

	gohelper.setActive(slot0._gospecialitem, false)
	gohelper.setActive(slot0._goskillspecialitem, false)

	slot0._goarrow1 = gohelper.findChild(slot0._gonewskilltip, "normal/arrow1")
	slot0._goarrow2 = gohelper.findChild(slot0._gonewskilltip, "normal/arrow2")
	slot0._viewInitialized = true
	slot0._upgradeSelectShow = false
	slot0._canShowUpgradeBtn = true
end

function slot0._skillItemClick(slot0, slot1)
	if slot1 == slot0._curSkillLevel then
		return
	end

	slot0:_refreshSkill(slot1)
end

function slot0._setNewSkills(slot0, slot1, slot2, slot3)
	slot0._curSkillLevel = slot0._curSkillLevel or nil
	slot0._skillIdList = slot0:_checkDestinyEffect(slot1)
	slot0._super = slot2

	gohelper.setActive(slot0._newskilltips[1], not slot2)
	gohelper.setActive(slot0._newskilltips[2], slot2)

	if not slot2 then
		for slot8 = 1, #slot1 do
			if lua_skill.configDict[slot1[slot8]] then
				slot0._newskillitems[slot8].icon:LoadImage(ResUrl.getSkillIcon(slot9.icon))
				slot0._newskillitems[slot8].tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. slot9.showTag))
			else
				logError("找不到技能: " .. slot1[slot8])
			end

			gohelper.setActive(slot0._newskillitems[slot8].selectframe, false)
			gohelper.setActive(slot0._newskillitems[slot8].selectarrow, false)
			gohelper.setActive(slot0._newskillitems[slot8].go, true)
			gohelper.setActive(slot0._newskillitems[slot8].aggrandizement, slot0._upgradeSelectShow)
		end

		for slot8 = slot4 + 1, 3 do
			gohelper.setActive(slot0._newskillitems[slot8].go, false)
		end

		gohelper.setActive(slot0._goarrow1, slot4 > 1)
		gohelper.setActive(slot0._goarrow2, slot4 > 2)
		slot0:_refreshSkill(slot0._curSkillLevel or 1)
	elseif lua_skill.configDict[slot1[1]] then
		slot0._newsuperskill.icon:LoadImage(ResUrl.getSkillIcon(slot4.icon))
		slot0._newsuperskill.tag:LoadImage(ResUrl.getAttributeIcon("attribute_" .. slot4.showTag))

		slot0._newskillname.text = slot4.name
		slot0._newskilldesc.text = SkillHelper.getSkillDesc(slot0.monsterName, slot4)

		slot0._fixTmpBreakLine:refreshTmpContent(slot0._newskilldesc)
		gohelper.setActive(slot0._newsuperskill.aggrandizement, slot0._upgradeSelectShow)
		gohelper.setActive(slot0._gostoryDesc, not string.nilorempty(slot4.desc_art))

		slot0._txtstory.text = slot4.desc_art

		slot0._txtstory:GetPreferredValues()

		slot0._scrollskilltipScrollview.verticalNormalizedPosition = 1

		slot0:_refreshSkillSpecial(slot4)
	else
		logError("找不到技能: " .. tostring(slot1))
	end

	if slot0.viewName == ViewName.FightFocusView then
		if ViewMgr.instance:isOpen(ViewName.FightFocusView) then
			if slot3 then
				transformhelper.setLocalPosXY(slot0._gonewskilltip.transform, 460.9, -24.3)
				recthelper.setAnchorX(slot0._goBuffItem.transform, -38)
			else
				transformhelper.setLocalPosXY(slot0._gonewskilltip.transform, 270, -24.3)
				recthelper.setAnchorX(slot4, -38)
			end
		else
			transformhelper.setLocalPosXY(slot0._gonewskilltip.transform, 185.12, 49.85)
			recthelper.setAnchorX(slot4, -120)
		end
	else
		transformhelper.setLocalPosXY(slot0._gonewskilltip.transform, 0.69, -0.54)
		recthelper.setAnchorX(slot4, -304)
	end
end

function slot0._checkDestinyEffect(slot0, slot1)
	if slot1 and slot0.viewParam and slot0.viewParam.heroMo and slot2.destinyStoneMo then
		slot1 = slot2.destinyStoneMo:_replaceSkill(slot1)
	end

	return slot1
end

function slot0._refreshSkill(slot0, slot1)
	if not slot0._skillIdList[slot1] then
		slot1 = 1
	end

	slot0._curSkillLevel = slot1

	for slot5 = 1, 3 do
		gohelper.setActive(slot0._newskillitems[slot5].selectframe, slot5 == slot1)
		gohelper.setActive(slot0._newskillitems[slot5].selectarrow, slot5 == slot1)
	end

	if lua_skill.configDict[tonumber(slot0._skillIdList[slot1])] then
		slot0._newskillname.text = slot2.name
		slot0._newskilldesc.text = SkillHelper.getSkillDesc(slot0.monsterName, slot2)

		slot0._fixTmpBreakLine:refreshTmpContent(slot0._newskilldesc)
		gohelper.setActive(slot0._gostoryDesc, not string.nilorempty(slot2.desc_art))

		slot0._txtstory.text = slot2.desc_art

		slot0._txtstory:GetPreferredValues()

		slot0._scrollskilltipScrollview.verticalNormalizedPosition = 1

		slot0:_refreshSkillSpecial(slot2)
	else
		logError("找不到技能: " .. slot0._skillIdList[slot1])
	end
end

function slot0._refreshSkillSpecial(slot0, slot1)
	slot2 = {}

	if slot1.battleTag and slot1.battleTag ~= "" then
		slot6 = "#"

		for slot6 = 1, #string.split(slot1.battleTag, slot6) do
			if not slot0._skillTagGOs[slot6] then
				table.insert(slot0._skillTagGOs, gohelper.cloneInPlace(slot0._gospecialitem, "item" .. slot6))
			end

			if HeroConfig.instance:getBattleTagConfigCO(slot2[slot6]) then
				gohelper.findChildText(slot7, "name").text = slot9.tagName
			else
				logError("找不到技能BattleTag: " .. tostring(slot2[slot6]))
			end

			gohelper.setActive(slot7, true)
		end
	end

	for slot6 = #slot2 + 1, #slot0._skillTagGOs do
		gohelper.setActive(slot0._skillTagGOs[slot6], false)
	end

	gohelper.setActive(slot0._goline, false)

	for slot8 = #HeroSkillModel.instance:getEffectTagIDsFromDescRecursion(FightConfig.instance:getSkillEffectDesc(slot0.monsterName, slot1)), 1, -1 do
		if SkillConfig.instance:getSkillEffectDescCo(tonumber(slot4[slot8])) then
			if not SkillHelper.canShowTag(slot10) then
				table.remove(slot4, slot8)
			end
		else
			logError("找不到技能eff_desc: " .. tostring(slot9))
		end
	end

	slot5 = 1

	for slot9 = 1, #slot4 do
		if SkillConfig.instance:getSkillEffectDescCo(tonumber(slot4[slot9])).isSpecialCharacter == 1 then
			gohelper.setActive(slot0._goline, true)

			if not slot0._skillEffectGOs[slot5] then
				table.insert(slot0._skillEffectGOs, gohelper.cloneInPlace(slot0._goskillspecialitem, "item" .. slot5))
			end

			slot15 = gohelper.findChildText(slot12, "desc")

			SkillHelper.addHyperLinkClick(slot15, slot0._onHyperLinkClick, slot0)

			if slot11 then
				SLFramework.UGUI.GuiHelper.SetColor(gohelper.findChildImage(slot12, "titlebg/bg"):GetComponent("Image"), uv0.skillTypeColor[slot11.color])

				gohelper.findChildText(slot12, "titlebg/bg/name").text = SkillHelper.removeRichTag(slot11.name)
				slot15.text = SkillHelper.getSkillDesc(slot0.monsterName, slot11)

				MonoHelper.addNoUpdateLuaComOnceToGo(slot15.gameObject, FixTmpBreakLine):refreshTmpContent(slot15)
			else
				logError("找不到技能eff_desc: " .. tostring(slot10))
			end

			gohelper.setActive(slot12, true)

			slot5 = slot5 + 1
		end
	end

	for slot9 = slot5, #slot0._skillEffectGOs do
		gohelper.setActive(slot0._skillEffectGOs[slot9], false)
	end

	slot0:_refreshArrow()
end

function slot0._onHyperLinkClick(slot0, slot1, slot2)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPos(tonumber(slot1), CommonBuffTipEnum.Anchor[slot0.viewName], CommonBuffTipEnum.Pivot.Right)
end

function slot0.AutoEffectDescItem()
end

function slot0.onUpdateParam(slot0)
	if slot0.viewName ~= ViewName.FightFocusView then
		slot0:initView()
	end
end

function slot0.onOpen(slot0)
	if slot0.viewName ~= ViewName.FightFocusView then
		slot0:initView()
	else
		slot0:hideInfo()
	end
end

function slot0.initView(slot0)
	slot1 = slot0.viewParam
	slot0.srcSkillIdList = slot1.skillIdList
	slot0.isSuper = slot1.super
	slot0.isCharacter = true

	slot0:updateMonsterName()
	slot0:refreshUpgradeBtn(slot0.isCharacter)
	slot0:_setNewSkills(slot0.srcSkillIdList, slot0.isSuper, slot0.isCharacter)

	if slot1 and slot1.anchorX then
		recthelper.setAnchorX(slot0.viewGO.transform, slot2)
	end
end

function slot0.updateMonsterName(slot0)
	slot0.monsterName = slot0.viewParam.monsterName

	if string.nilorempty(slot0.monsterName) then
		logError("SkillTipView 缺少 monsterName 参数")

		slot0.monsterName = ""
	end
end

function slot0.showInfo(slot0, slot1, slot2, slot3)
	if not slot0._viewInitialized then
		return
	end

	slot0.entityMo = FightDataHelper.entityMgr:getById(slot3)
	slot0.monsterName = FightConfig.instance:getEntityName(slot3)
	slot0.entitySkillIndex = slot1.skillIndex

	if string.nilorempty(slot0.monsterName) then
		logError("SkillTipView monsterName 为 nil, entityId : " .. tostring(slot3))

		slot0.monsterName = ""
	end

	slot0.srcSkillIdList = slot1.skillIdList
	slot0.isSuper = slot1.super
	slot0.isCharacter = slot2

	gohelper.setActive(slot0._gonewskilltip, true)

	slot0._upgradeSelectShow = false

	slot0:refreshUpgradeBtn(slot0.isCharacter)
	slot0:_setNewSkills(slot0.srcSkillIdList, slot0.isSuper, slot0.isCharacter)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Tipsopen)
end

function slot0.hideInfo(slot0)
	if not slot0._viewInitialized then
		return
	end

	gohelper.setActive(slot0._gonewskilltip, false)
end

function slot0.refreshUpgradeBtn(slot0, slot1)
	if not slot0._canShowUpgradeBtn then
		gohelper.setActive(slot0._btnupgradeShow.gameObject, false)

		return
	end

	if slot0.viewName ~= ViewName.FightFocusView then
		slot0:refreshHeroUpgrade()
	else
		slot0:refreshEntityUpgrade(slot1)
	end
end

function slot0.refreshHeroUpgrade(slot0)
	slot0.hasBreakLevelSkill, slot0.upgradeSkillIdList = SkillConfig.instance:getHeroUpgradeSkill(slot0.viewParam.heroId, slot0.viewParam.heroMo and slot1.exSkillLevel or 0, slot0.viewParam.skillIndex)

	slot0:refreshUpgradeUI()
end

function slot0.refreshEntityUpgrade(slot0, slot1)
	if not slot1 then
		slot0:refreshUpgradeUI()

		return
	end

	slot2 = slot0.entityMo and slot0.entityMo:getCO()

	if not (slot2 and slot2.id) then
		gohelper.setActive(slot0._btnupgradeShow.gameObject, false)

		return
	end

	slot0.hasBreakLevelSkill, slot0.upgradeSkillIdList = SkillConfig.instance:getHeroUpgradeSkill(slot3, slot0.entityMo.exSkillLevel, slot0.entitySkillIndex)

	if slot0.upgradeSkillIdList and slot0.srcSkillIdList[1] == slot0.upgradeSkillIdList[1] then
		slot0.upgraded = true
	else
		slot0.upgraded = false
	end

	slot0:refreshUpgradeUI()
end

function slot0._btnUpgradeShowOnClock(slot0)
	slot0._upgradeSelectShow = not slot0._upgradeSelectShow

	slot0:refreshUpgradeUI()
	slot0:_setNewSkills(slot0._upgradeSelectShow and slot0.upgradeSkillIdList or slot0.srcSkillIdList, slot0.isSuper, slot0.isCharacter)
end

function slot0.refreshUpgradeUI(slot0)
	gohelper.setActive(slot0._btnupgradeShow, not slot0.upgraded and slot0.hasBreakLevelSkill)
	gohelper.setActive(slot0._goshowSelect, slot0.upgraded or slot0._upgradeSelectShow)
	gohelper.setActive(slot0._goBtnUpgraded, slot0._upgradeSelectShow)
	gohelper.setActive(slot0._goBtnNormal, not slot0._upgradeSelectShow)
end

function slot0.setUpgradebtnShowState(slot0, slot1)
	slot0._canShowUpgradeBtn = slot1
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._scrollskilltipScrollview:RemoveOnValueChanged()

	if slot0._newskillitems then
		for slot4, slot5 in pairs(slot0._newskillitems) do
			slot5.icon:UnLoadImage()
			slot5.btn:RemoveClickListener()
		end
	end
end

return slot0
