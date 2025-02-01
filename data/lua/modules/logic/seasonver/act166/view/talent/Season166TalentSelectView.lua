module("modules.logic.seasonver.act166.view.talent.Season166TalentSelectView", package.seeall)

slot0 = class("Season166TalentSelectView", BaseView)

function slot0.onInitView(slot0)
	slot0._txttitleen = gohelper.findChildText(slot0.viewGO, "root/left/#txt_titleen")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "root/left/#txt_title")
	slot0._txtbasicSkill = gohelper.findChildText(slot0.viewGO, "root/left/#txt_basicSkill")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(Season166Controller.instance, Season166Event.SetTalentSkill, slot0.OnSetTalentSkill, slot0)
end

function slot0.removeEvents(slot0)
end

slot1 = {
	Lock = 4,
	Full = 2,
	Select = 3,
	Normal = 1
}

function slot0._editableInitView(slot0)
	SkillHelper.addHyperLinkClick(slot0._txtbasicSkill, slot0.clcikHyperLink, slot0)

	slot0.unlockStateTab = slot0:getUserDataTb_()
	slot0.localUnlockStateTab = slot0:getUserDataTb_()
end

function slot0.onOpen(slot0)
	if slot0.viewParam and slot0.viewParam.talentId then
		slot0.actId = Season166Model.instance:getCurSeasonId()
		slot0.talentId = slot0.viewParam.talentId
		slot0.talentConfig = lua_activity166_talent.configDict[slot0.actId][slot0.talentId]
		slot0._txttitle.text = slot0.talentConfig.name
		slot0._txttitleen.text = slot0.talentConfig.nameEn
		slot0._txtbasicSkill.text = SkillHelper.buildDesc(FightConfig.instance:getSkillEffectDesc("", lua_skill_effect.configDict[string.splitToNumber(slot0.talentConfig.baseSkillIds, "#")[1]]))
		slot0.styleCfgDic = lua_activity166_talent_style.configDict[slot0.talentId]
		slot0.talentInfo = Season166Model.instance:getTalentInfo(slot0.actId, slot0.talentId)
		slot0.baseConfig = Season166Config.instance:getBaseSpotByTalentId(slot0.actId, slot0.talentId)

		slot0:refreshTalentParam(slot0.talentInfo)
		slot0:_initSkillItem()
		slot0:_initLeftArea()
		slot0:_initMiddleArea()
		slot0:playUnlockEffect()
	else
		logError("please open view with talentId")
	end
end

function slot0.onClose(slot0)
	slot0:saveUnlockState()
end

function slot0.refreshTalentParam(slot0, slot1)
	slot0.talentLvl = slot1.level
	slot0.maxSlot = slot1.config.slot
end

function slot0._initLeftArea(slot0)
	slot0.selectSkillList = {}

	for slot4 = 1, 3 do
		slot5 = slot0:getUserDataTb_()
		slot5.go = gohelper.findChild(slot0.viewGO, "root/left/basicSkill/" .. slot4)
		slot5.goUnequip = gohelper.findChild(slot5.go, "unequip")
		slot5.goWhiteBg = gohelper.findChild(slot5.go, "unequip/bg2")
		slot5.goEquiped = gohelper.findChild(slot5.go, "equiped")
		slot5.animEquip = slot5.goEquiped:GetComponent(gohelper.Type_Animation)
		slot5.txtDesc = gohelper.findChildText(slot5.go, "equiped/txt_desc")

		SkillHelper.addHyperLinkClick(slot5.txtDesc, slot0.clcikHyperLink, slot0)
		UISpriteSetMgr.instance:setSeason166Sprite(gohelper.findChildImage(slot5.go, "equiped/txt_desc/slot"), "season166_talentree_pointl" .. tostring(slot0.talentConfig.sortIndex))
		gohelper.setActive(gohelper.findChild(slot5.go, "equiped/txt_desc/slot/" .. slot0.talentConfig.sortIndex), true)

		slot5.goLock = gohelper.findChild(slot5.go, "locked")
		gohelper.findChildText(slot5.go, "locked/txt_desc").text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("season166_talent_selectlock"), slot0.styleCfgDic[slot4].needStar, slot0.baseConfig.name)
		slot5.anim = slot5.go:GetComponent(gohelper.Type_Animator)
		slot0.selectSkillList[slot4] = slot5
	end

	slot0:_refreshSelectSkill()
end

function slot0._initMiddleArea(slot0)
	slot2 = gohelper.findChild(slot0.viewGO, "root/middle/talent" .. slot0.talentConfig.sortIndex)
	slot0.equipSlotList = slot0:getUserDataTb_()
	slot0.equipSlotLightList = slot0:getUserDataTb_()

	for slot6 = 1, 3 do
		slot0.equipSlotList[slot6] = gohelper.findChild(slot2, "equipslot/" .. slot6)

		gohelper.setActive(slot0.equipSlotList[slot6], slot6 <= slot0.maxSlot)

		slot0.equipSlotLightList[slot6] = gohelper.findChild(slot2, "equipslot/" .. slot6 .. "/light")
	end

	gohelper.setActive(slot2, true)
	slot0:_refreshMiddlSlot()
end

function slot0._initSkillItem(slot0)
	slot0.skillUnlockLvlDic = {}
	slot0.skillIds = {}

	for slot4, slot5 in ipairs(slot0.styleCfgDic) do
		slot6 = string.splitToNumber(slot5.skillId, "#")

		tabletool.addValues(slot0.skillIds, slot6)

		slot0.skillUnlockLvlDic[slot5.level] = slot6
	end

	slot0.skillItemDic = {}

	for slot4 = 1, 6 do
		slot5 = gohelper.findChild(slot0.viewGO, "root/right/#scroll_skill/Viewport/Content/skillItem" .. slot4)

		if slot0.skillIds[slot4] then
			slot7 = slot0:getUserDataTb_()
			slot7.effctConfig = lua_skill_effect.configDict[slot6]
			slot7.canvasGroup = gohelper.findChild(slot5, "content"):GetComponent(gohelper.Type_CanvasGroup)
			slot7.goslot = gohelper.findChild(slot5, "content/slot/go_slotLight")
			slot7.txtdesc = gohelper.findChildText(slot5, "content/txt_desc")
			slot7.txtdesc.text = FightConfig.instance:getSkillEffectDesc("", slot7.effctConfig)

			UISpriteSetMgr.instance:setSeason166Sprite(gohelper.findChildImage(slot5, "content/slot/go_slotLight"), "season166_talentree_pointl" .. tostring(slot0.talentConfig.sortIndex))

			slot7.select = gohelper.findChild(slot5, "select")
			slot7.normal = gohelper.findChild(slot5, "normal")
			slot7.full = gohelper.findChild(slot5, "full")
			slot7.lock = gohelper.findChild(slot5, "lock")
			gohelper.findChildText(slot5, "lock/txt_locktips").text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("season166_talent_selectlock"), slot0.styleCfgDic[slot0:getSkillUnlockLvl(slot6)].needStar, slot0.baseConfig.name)
			slot7.anim = slot5:GetComponent(gohelper.Type_Animator)

			slot0:addClickCb(gohelper.findChildButtonWithAudio(slot5, "click"), slot0._clickItem, slot0, slot6)

			slot0.skillItemDic[slot6] = slot7
		else
			gohelper.setActive(slot5, false)
		end
	end

	slot0:_refreshSkillItemStatus()
end

function slot0._refreshSelectSkill(slot0, slot1)
	slot3 = #slot0.talentInfo.skillIds + 1

	for slot7, slot8 in ipairs(slot0.selectSkillList) do
		if slot7 == slot3 and slot3 <= slot0.maxSlot then
			gohelper.setActive(slot8.goWhiteBg, true)
		else
			gohelper.setActive(slot8.goWhiteBg, false)
		end

		if slot0.maxSlot < slot7 then
			gohelper.setActive(slot8.goUnequip, false)
			gohelper.setActive(slot8.goEquiped, false)
			gohelper.setActive(slot8.goLock, true)
		elseif slot7 > #slot2 then
			gohelper.setActive(slot8.goUnequip, true)
			gohelper.setActive(slot8.goEquiped, false)
			gohelper.setActive(slot8.goLock, false)
		else
			slot8.txtDesc.text = SkillHelper.buildDesc(FightConfig.instance:getSkillEffectDesc("", lua_skill_effect.configDict[slot2[slot7]]))

			gohelper.setActive(slot8.goUnequip, false)
			gohelper.setActive(slot8.goEquiped, true)
			gohelper.setActive(slot8.goLock, false)

			if slot1 and slot7 == #slot2 then
				slot8.animEquip:Play("equiped_open")
				AudioMgr.instance:trigger(AudioEnum.Season166.play_ui_checkpoint_light)
			end
		end
	end
end

function slot0._refreshMiddlSlot(slot0)
	for slot5 = 1, slot0.maxSlot do
		gohelper.setActive(slot0.equipSlotLightList[slot5], slot5 <= #slot0.talentInfo.skillIds)
	end
end

function slot0._refreshSkillItemStatus(slot0)
	for slot4, slot5 in pairs(slot0.skillItemDic) do
		slot6 = slot0:getSkillUnlockLvl(slot4)
		slot8 = slot0.styleCfgDic[slot6]

		if slot0:InferSkillStatus(slot4, slot6) == uv0.Full or slot7 == uv0.Lock then
			slot5.canvasGroup.alpha = 0.5
		else
			slot5.canvasGroup.alpha = 1
		end

		gohelper.setActive(slot5.select, slot7 == uv0.Select)
		gohelper.setActive(slot5.goslot, slot7 == uv0.Select)
		gohelper.setActive(slot5.normal, slot7 == uv0.Normal)
		gohelper.setActive(slot5.full, slot7 == uv0.Full)
		gohelper.setActive(slot5.lock, slot7 == uv0.Lock)

		slot9 = slot7 ~= uv0.Lock and slot8.needStar > 0
		slot0.unlockStateTab[slot4] = slot9 and Season166Enum.UnlockState or Season166Enum.LockState
		slot5.isUnlock = slot9
	end
end

function slot0._clickItem(slot0, slot1)
	if slot0:InferSkillStatus(slot1, slot0:getSkillUnlockLvl(slot1)) == uv0.Normal then
		slot4 = tabletool.copy(slot0.talentInfo.skillIds)
		slot4[#slot4 + 1] = slot1

		Activity166Rpc.instance:SendAct166SetTalentSkillRequest(slot0.actId, slot0.talentId, slot4)
	elseif slot3 == uv0.Select then
		slot4 = tabletool.copy(slot0.talentInfo.skillIds)

		tabletool.removeValue(slot4, slot1)
		Activity166Rpc.instance:SendAct166SetTalentSkillRequest(slot0.actId, slot0.talentId, slot4)
	end
end

function slot0.OnSetTalentSkill(slot0, slot1, slot2)
	if slot0.talentId == slot1 then
		slot0:_refreshSkillItemStatus()
		slot0:_refreshSelectSkill(slot2)
		slot0:_refreshMiddlSlot()
		slot0:saveUnlockState()
	end
end

function slot0.InferSkillStatus(slot0, slot1, slot2)
	if slot0.talentLvl < slot2 then
		return uv0.Lock
	end

	if tabletool.indexOf(slot0.talentInfo.skillIds, slot1) then
		return uv0.Select
	end

	if slot0.maxSlot <= #slot0.talentInfo.skillIds then
		return uv0.Full
	end

	return uv0.Normal
end

function slot0.getSkillUnlockLvl(slot0, slot1)
	for slot5, slot6 in pairs(slot0.skillUnlockLvlDic) do
		if tabletool.indexOf(slot6, slot1) then
			return slot5
		end
	end

	return 0
end

function slot0.playUnlockEffect(slot0)
	if Season166Controller.instance:getPlayerPrefs(Season166Enum.TalentLvlLocalSaveKey .. slot0.talentId, 0) < slot0.talentInfo.level then
		for slot6 = 1, slot2 do
			if slot6 == slot2 then
				slot0.selectSkillList[slot6].anim:Play("unlock")
				AudioMgr.instance:trigger(AudioEnum.Season166.play_ui_checkpoint_unlock)
			end

			for slot11 = 1, 2 do
				if slot6 == slot2 then
					slot0.skillItemDic[slot0.skillIds[(slot6 - 1) * 2 + slot11]].anim:Play("unlock")
				end
			end
		end

		Season166Controller.instance:savePlayerPrefs(Season166Enum.TalentLvlLocalSaveKey .. slot0.talentId, slot2)
	end
end

function slot0.isTalentSelect(slot0, slot1)
	return tabletool.indexOf(slot0.talentInfo.skillIds, slot1)
end

function slot0.saveUnlockState(slot0)
	slot1 = {}
	slot2 = Season166Model.instance:getTalentLocalSaveKey(slot0.talentId)

	for slot6, slot7 in pairs(slot0.unlockStateTab) do
		table.insert(slot1, string.format("%s|%s", slot6, slot7))
	end

	Season166Controller.instance:savePlayerPrefs(slot2, cjson.encode(slot1))
end

function slot0.clcikHyperLink(slot0, slot1, slot2)
	CommonBuffTipController.instance:openCommonTipViewWithCustomPos(slot1, Vector2(-305, 30))
end

return slot0
