module("modules.logic.seasonver.act166.view.Season166TalentInfoView", package.seeall)

slot0 = class("Season166TalentInfoView", BaseView)

function slot0.onInitView(slot0)
	slot0._btncloseView = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_closeView")
	slot0._gotalent1 = gohelper.findChild(slot0.viewGO, "talentIcon/#go_talentIcon1")
	slot0._gotalent2 = gohelper.findChild(slot0.viewGO, "talentIcon/#go_talentIcon2")
	slot0._gotalent3 = gohelper.findChild(slot0.viewGO, "talentIcon/#go_talentIcon3")
	slot0._goEquipSlot = gohelper.findChild(slot0.viewGO, "#go_equipslot")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "info/#txt_title")
	slot0._txttitleen = gohelper.findChildText(slot0.viewGO, "info/#txt_titleen")
	slot0._txtbasicSkill = gohelper.findChildText(slot0.viewGO, "info/#txt_basicSkill")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncloseView:AddClickListener(slot0._btncloseViewOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncloseView:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseViewOnClick(slot0)
	slot0:closeThis()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	SkillHelper.addHyperLinkClick(slot0._txtbasicSkill, slot0.clcikHyperLink, slot0)
	slot0:initEquipSlot()
end

function slot0.initEquipSlot(slot0)
	slot0.talentSlotTab = slot0:getUserDataTb_()

	for slot4 = 1, 3 do
		slot5 = {
			item = gohelper.findChild(slot0._goEquipSlot, slot4)
		}
		slot5.light = gohelper.findChild(slot5.item, "light")
		slot5.imageLight = gohelper.findChildImage(slot5.item, "light")
		slot5.lineLight = gohelper.findChild(slot5.item, "line_light")
		slot5.lineDark = gohelper.findChild(slot5.item, "line_dark")
		slot5.effect1 = gohelper.findChild(slot5.item, "light/qi1")
		slot5.effect2 = gohelper.findChild(slot5.item, "light/qi2")
		slot5.effect3 = gohelper.findChild(slot5.item, "light/qi3")
		slot0.talentSlotTab[slot4] = slot5
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.Season166.play_ui_hero_sign)
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0.actId = Season166Model.instance:getCurSeasonId()

	if not slot0.actId or slot0.actId == 0 then
		slot0.actId = Season166Model.instance:getBattleContext() and slot1.actId or 0
	end

	slot0.talentParam = Season166Model.instance:getFightTalentParam()
	slot0.talentId = slot0.talentParam.talentId
	slot0.talentLevel = slot0.talentParam.talentLevel
	slot0.talentConfig = lua_activity166_talent.configDict[slot0.actId][slot0.talentId]
	slot0.styleCfgDic = lua_activity166_talent_style.configDict[slot0.talentId]
	slot0.maxSlot = lua_activity166_talent_style.configDict[slot0.talentId][slot0.talentLevel].slot

	slot0:refreshEquip()
	slot0:refreshTitle()
	slot0:initBasicSkill()
	slot0:refreshSkill()
end

function slot0.refreshEquip(slot0)
	for slot5 = 1, 3 do
		gohelper.setActive(slot0["_gotalent" .. slot5], slot5 == lua_activity166_talent.configDict[slot0.actId][slot0.talentId].sortIndex)
	end

	slot3 = #slot0.talentParam.talentSkillIds

	for slot7, slot8 in ipairs(slot0.talentSlotTab) do
		gohelper.setActive(slot8.item, slot7 <= slot0.maxSlot)
		gohelper.setActive(slot8.light, slot7 <= slot3)
		gohelper.setActive(slot8.lineLight, slot7 > 1 and slot7 <= slot3)
		gohelper.setActive(slot8.lineDark, slot7 > 1 and slot3 < slot7)
		UISpriteSetMgr.instance:setSeason166Sprite(slot8.imageLight, "season166_talentree_pointl" .. tostring(slot1.sortIndex))

		for slot12 = 1, 3 do
			gohelper.setActive(slot8["effect" .. slot12], slot1.sortIndex == slot12)
		end
	end
end

function slot0.refreshTitle(slot0)
	slot0._txttitle.text = slot0.talentConfig.name
	slot0._txttitleen.text = slot0.talentConfig.nameEn

	if string.nilorempty(slot0.talentConfig.baseSkillIds) then
		slot1 = slot0.talentConfig.baseSkillIds2
	end

	slot0._txtbasicSkill.text = SkillHelper.buildDesc(FightConfig.instance:getSkillEffectDesc("", lua_skill_effect.configDict[string.splitToNumber(slot1, "#")[1]]))
end

function slot0.initBasicSkill(slot0)
	slot0.selectSkillList = {}

	for slot4 = 1, 3 do
		slot5 = slot0:getUserDataTb_()
		slot5.go = gohelper.findChild(slot0.viewGO, "info/basicSkill/" .. slot4)
		slot5.goUnequip = gohelper.findChild(slot5.go, "unequip")
		slot5.goWhiteBg = gohelper.findChild(slot5.go, "unequip/bg2")
		slot5.goEquiped = gohelper.findChild(slot5.go, "equiped")
		slot5.animEquip = slot5.goEquiped:GetComponent(gohelper.Type_Animation)
		slot5.txtDesc = gohelper.findChildText(slot5.go, "equiped/txt_desc")

		SkillHelper.addHyperLinkClick(slot5.txtDesc, slot0.clcikHyperLink, slot0)
		UISpriteSetMgr.instance:setSeason166Sprite(gohelper.findChildImage(slot5.go, "equiped/txt_desc/slot"), "season166_talentree_pointl" .. tostring(slot0.talentConfig.sortIndex))
		gohelper.setActive(gohelper.findChild(slot5.go, "equiped/txt_desc/slot/" .. slot0.talentConfig.sortIndex), true)

		slot5.goLock = gohelper.findChild(slot5.go, "locked")
		gohelper.findChildText(slot5.go, "locked/txt_desc").text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("season166_talent_selectlock"), slot0.styleCfgDic[slot4].needStar, Season166Config.instance:getBaseSpotByTalentId(slot0.actId, slot0.talentId).name)
		slot5.anim = slot5.go:GetComponent(gohelper.Type_Animator)
		slot0.selectSkillList[slot4] = slot5
	end
end

function slot0.refreshSkill(slot0)
	slot2 = #slot0.talentParam.talentSkillIds + 1

	for slot6, slot7 in ipairs(slot0.selectSkillList) do
		if slot6 == slot2 and slot2 <= slot0.maxSlot then
			gohelper.setActive(slot7.goWhiteBg, true)
		else
			gohelper.setActive(slot7.goWhiteBg, false)
		end

		if slot0.maxSlot < slot6 then
			gohelper.setActive(slot7.goUnequip, false)
			gohelper.setActive(slot7.goEquiped, false)
			gohelper.setActive(slot7.goLock, true)
		elseif slot6 > #slot1 then
			gohelper.setActive(slot7.goUnequip, true)
			gohelper.setActive(slot7.goEquiped, false)
			gohelper.setActive(slot7.goLock, false)
		else
			slot7.txtDesc.text = SkillHelper.buildDesc(FightConfig.instance:getSkillEffectDesc("", lua_skill_effect.configDict[slot1[slot6]]))

			gohelper.setActive(slot7.goUnequip, false)
			gohelper.setActive(slot7.goEquiped, true)
			gohelper.setActive(slot7.goLock, false)
		end
	end
end

function slot0.clcikHyperLink(slot0, slot1, slot2)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPos(slot1, Vector2(-742, 178))
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
