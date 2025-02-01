module("modules.logic.character.view.CharacterRankUpResultView", package.seeall)

slot0 = class("CharacterRankUpResultView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebgimg = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bgimg")
	slot0._simagecenterbg = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_centerbg")
	slot0._gospine = gohelper.findChild(slot0.viewGO, "spineContainer/#go_spine")
	slot0._gorighttop = gohelper.findChild(slot0.viewGO, "#go_righttop")
	slot0._goranknormal = gohelper.findChild(slot0.viewGO, "rank/#go_ranknormal")
	slot0._goeffect = gohelper.findChild(slot0.viewGO, "#scroll_info/viewport/#go_effect")
	slot0._golevel = gohelper.findChild(slot0._goeffect, "#go_level")
	slot0._goskill = gohelper.findChild(slot0._goeffect, "#go_skill")
	slot0._txttalentlevel = gohelper.findChildText(slot0._goeffect, "#go_talentlevel")
	slot0._txtskillRankUp = gohelper.findChildText(slot0._goeffect, "#go_skill/#txt_skillRankUp")
	slot0._txtskillDetail = gohelper.findChildText(slot0._goeffect, "#go_skill/skilldetail/#txt_skillDetail")
	slot0._goattribute = gohelper.findChild(slot0._goeffect, "#go_attribute")
	slot0._goattributedetail = gohelper.findChild(slot0._goeffect, "#go_attribute/#go_attributedetail")
	slot0._btnheroDetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_heroDetail")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnheroDetail:AddClickListener(slot0._btnheroDetailOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnheroDetail:RemoveClickListener()
end

slot0.characterTalentLevel = {
	[2.0] = 10,
	[3.0] = 15
}

function slot0._btnheroDetailOnClick(slot0)
	CharacterController.instance:openCharacterSkinFullScreenView(SkinConfig.instance:getSkinCo(slot0._skinId), true)
end

function slot0._editableInitView(slot0)
	slot4 = "guang_005"

	slot0._simagecenterbg:LoadImage(ResUrl.getCharacterIcon(slot4))

	slot0._txtlevel = gohelper.findChildText(slot0._goeffect, "#go_level")
	slot0._uiSpine = GuiModelAgent.Create(slot0._gospine, true)

	slot0._uiSpine:useRT()

	slot0._rareGos = slot0:getUserDataTb_()
	slot0._norrank = {
		insights = {}
	}

	for slot4 = 1, 3 do
		slot5 = slot0:getUserDataTb_()
		slot9 = tostring(slot4)
		slot5.go = gohelper.findChild(slot0._goranknormal, "insightlight" .. slot9)
		slot5.lights = {}

		for slot9 = 1, slot4 do
			table.insert(slot5.lights, gohelper.findChild(slot5.go, "star" .. slot9))
		end

		slot0._norrank.insights[slot4] = slot5
		slot0._rareGos[slot4] = gohelper.findChild(slot0._txtskillDetail.gameObject, "rare" .. slot4)
	end

	slot0._norrank.eyes = slot0:getUserDataTb_()

	for slot4 = 1, 2 do
		table.insert(slot0._norrank.eyes, gohelper.findChild(slot0._goranknormal, "eyes/eye" .. tostring(slot4)))
	end

	slot0._attributeItems = slot0:getUserDataTb_()

	for slot4 = 1, 5 do
		slot5 = {
			go = gohelper.findChild(slot0._goattributedetail, "attributeItem" .. slot4)
		}
		slot5.icon = gohelper.findChildImage(slot5.go, "image_icon")
		slot5.preNumTxt = gohelper.findChildText(slot5.go, "txt_prevnum")
		slot5.curNumTxt = gohelper.findChildText(slot5.go, "txt_nextnum")

		table.insert(slot0._attributeItems, slot5)
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.heroMo = HeroModel.instance:getByHeroId(slot0.viewParam)

	slot0:_refreshView()
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0, LuaEventSystem.Low)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, slot0._onOpenViewFinish, slot0, LuaEventSystem.Low)
end

function slot0._onOpenViewFinish(slot0, slot1)
	if slot1 == ViewName.CharacterSkinFullScreenView and slot0._uiSpine then
		slot0._uiSpine:hideModelEffect()
	end
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.CharacterSkinFullScreenView and slot0._uiSpine then
		slot0._uiSpine:showModelEffect()
	end
end

function slot0._refreshView(slot0)
	slot0:_refreshSpine()
	slot0:_refreshRank()
	slot0:_refreshEffect()
	slot0:_refreshAttribute()
end

function slot0._refreshSpine(slot0)
	slot1 = SkinConfig.instance:getSkinCo(slot0.heroMo.skin)

	slot0._uiSpine:setResPath(slot1, slot0._onSpineLoaded, slot0)

	slot3 = nil

	if string.nilorempty(slot1.characterRankUpViewOffset) then
		slot3 = SkinConfig.instance:getSkinOffset(slot1.characterViewOffset)
		slot5 = SkinConfig.instance:getSkinOffset(CommonConfig.instance:getConstStr(ConstEnum.CharacterTitleViewOffset))
		slot3[1] = slot3[1] + slot5[1]
		slot3[2] = slot3[2] + slot5[2]
		slot3[3] = slot3[3] + slot5[3]
	else
		slot3 = SkinConfig.instance:getSkinOffset(slot2)
	end

	recthelper.setAnchor(slot0._gospine.transform, tonumber(slot3[1]), tonumber(slot3[2]))
	transformhelper.setLocalScale(slot0._gospine.transform, tonumber(slot3[3]), tonumber(slot3[3]), tonumber(slot3[3]))
end

function slot0._refreshRank(slot0)
	slot1 = slot0.heroMo.rank
	slot2 = HeroConfig.instance:getMaxRank(slot0.heroMo.config.rare)

	for slot6 = 1, 3 do
		gohelper.setActive(slot0._norrank.insights[slot6].go, slot2 == slot6)

		for slot10 = 1, slot6 do
			if slot10 <= slot1 - 1 then
				SLFramework.UGUI.GuiHelper.SetColor(slot0._norrank.insights[slot6].lights[slot10]:GetComponent("Image"), "#f59d3d")
			else
				SLFramework.UGUI.GuiHelper.SetColor(slot0._norrank.insights[slot6].lights[slot10]:GetComponent("Image"), "#646161")
			end
		end
	end

	gohelper.setActive(slot0._norrank.eyes[1], slot2 ~= slot1 - 1)
	gohelper.setActive(slot0._norrank.eyes[2], slot2 == slot1 - 1)
end

function slot0._refreshEffect(slot0)
	if not SkillConfig.instance:getherorankCO(slot0.heroMo.heroId, slot0.heroMo.rank) or slot1.effects == "" then
		gohelper.setActive(slot0._goeffect, false)

		return
	end

	gohelper.setActive(slot0._goeffect, true)
	gohelper.setActive(slot0._txttalentlevel.gameObject, false)
	gohelper.setActive(slot0._golevel, false)
	gohelper.setActive(slot0._goskill, false)
	gohelper.setActive(slot0._btnheroDetail.gameObject, false)

	for slot6 = 1, #string.split(slot1.effect, "|") do
		if string.splitToNumber(slot2[slot6], "#")[1] == 1 then
			gohelper.setActive(slot0._golevel, true)

			slot0._txtlevel.text = GameUtil.getSubPlaceholderLuaLang(luaLang("character_rankupresult_levellimit"), {
				slot0.heroMo.config.name,
				tostring(HeroConfig.instance:getShowLevel(tonumber(slot7[2])))
			})
		elseif slot7[1] == 2 then
			gohelper.setActive(slot0._goskill, true)

			slot8 = CharacterModel.instance:getMaxUnlockPassiveLevel(slot0.heroMo.heroId)
			slot9 = SkillConfig.instance:getPassiveSKillsCoByExSkillLevel(slot0.heroMo.heroId, slot0.heroMo.exSkillLevel)

			for slot13, slot14 in pairs(slot0._rareGos) do
				gohelper.setActive(slot14, false)
			end

			gohelper.setActive(slot0._rareGos[slot8], true)

			slot0._txtskillRankUp.text = string.format(luaLang("character_rankupresult_skill"), tostring(lua_skill.configDict[slot9[1].skillPassive].name))
			slot0._txtskillDetail.text = HeroSkillModel.instance:skillDesToSpot(FightConfig.instance:getSkillEffectDesc(slot0.heroMo:getHeroName(), lua_skill.configDict[slot9[slot8].skillPassive]), "#CE9358", "#CE9358")
		elseif slot7[1] == 3 then
			gohelper.setActive(slot0._btnheroDetail.gameObject, true)

			slot0._skinId = slot7[2]
		end
	end

	gohelper.setActive(slot0._txttalentlevel.gameObject, slot0.heroMo.rank - 1 > 1)

	if slot3 > 1 then
		slot0._txttalentlevel.text = string.format(luaLang("talent_characterrankup_talentlevellimit" .. CharacterEnum.TalentTxtByHeroType[slot0.heroMo.config.heroType]), uv0.characterTalentLevel[slot3])
	end
end

function slot0._refreshAttribute(slot0)
	for slot6, slot7 in ipairs(slot0._attributeItems) do
		UISpriteSetMgr.instance:setCommonSprite(slot7.icon, "icon_att_" .. CharacterEnum.BaseAttrIdList[slot6])

		slot7.preNumTxt.text = slot0:getHeroPreAttribute()[slot6]
		slot7.curNumTxt.text = slot0:getCurrentHeroAttribute()[slot6]
	end
end

function slot0.getHeroPreAttribute(slot0)
	return slot0:_getHeroAttribute(slot0.heroMo.level - 1, slot0.heroMo.rank - 1)
end

function slot0.getCurrentHeroAttribute(slot0)
	return slot0:_getHeroAttribute()
end

function slot0._getHeroAttribute(slot0, slot1, slot2)
	slot1 = slot1 or slot0.heroMo.level
	slot2 = slot2 or slot0.heroMo.rank
	slot3 = nil

	if slot0.heroMo:hasDefaultEquip() then
		slot3 = {
			slot0.heroMo.defaultEquipUid
		}
	end

	return slot0.heroMo:getTotalBaseAttrList(slot3, slot1, slot2)
end

function slot0.onClose(slot0)
	slot0._simagecenterbg:UnLoadImage()
	slot0._uiSpine:setModelVisible(false)
end

function slot0.onDestroyView(slot0)
	if slot0._uiSpine then
		slot0._uiSpine:onDestroy()

		slot0._uiSpine = nil
	end
end

return slot0
