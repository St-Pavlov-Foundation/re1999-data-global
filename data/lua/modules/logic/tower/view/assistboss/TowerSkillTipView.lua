module("modules.logic.tower.view.assistboss.TowerSkillTipView", package.seeall)

slot0 = class("TowerSkillTipView", SkillTipView)

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
	slot0._gotag = gohelper.findChild(slot0.viewGO, "#go_newskilltip/super/tagIcon")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goBuffContainer, false)
	slot0._scrollskilltipScrollview:AddOnValueChanged(slot0._refreshArrow, slot0)

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

	slot0._viewInitialized = true
	slot0._upgradeSelectShow = false
	slot0._canShowUpgradeBtn = true
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

		slot0._scrollskilltipScrollview.verticalNormalizedPosition = 1

		slot0:_refreshSkillSpecial(slot4)
	else
		logError("找不到技能: " .. tostring(slot1))
	end

	if slot0.viewName == ViewName.FightFocusView then
		if ViewMgr.instance:isOpen(ViewName.FightFocusView) then
			transformhelper.setLocalPosXY(slot0._gonewskilltip.transform, 270, -24.3)
		else
			transformhelper.setLocalPosXY(slot0._gonewskilltip.transform, 185.12, 49.85)
		end
	else
		transformhelper.setLocalPosXY(slot0._gonewskilltip.transform, 0.69, -0.54)
	end

	gohelper.setActive(slot0._gotag, false)
end

return slot0
