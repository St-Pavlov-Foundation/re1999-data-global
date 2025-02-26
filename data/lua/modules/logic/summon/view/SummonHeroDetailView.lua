module("modules.logic.summon.view.SummonHeroDetailView", package.seeall)

slot0 = class("SummonHeroDetailView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_bg")
	slot0._simageredlight = gohelper.findChildSingleImage(slot0.viewGO, "bg/lightcontainer/#simage_redlight")
	slot0._gocharacterinfo = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo")
	slot0._imagedmgtype = gohelper.findChildImage(slot0.viewGO, "characterinfo/#go_characterinfo/#image_dmgtype")
	slot0._imagecareericon = gohelper.findChildImage(slot0.viewGO, "characterinfo/#go_characterinfo/career/#image_careericon")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "characterinfo/#go_characterinfo/name/#txt_name")
	slot0._txtnameen = gohelper.findChildText(slot0.viewGO, "characterinfo/#go_characterinfo/name/#txt_nameen")
	slot0._gospecialitem = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/special/#go_specialitem")
	slot0._gofourword = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/special/#go_specialitem/#go_fourword")
	slot0._gothreeword = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/special/#go_specialitem/#go_threeword")
	slot0._gotwoword = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/special/#go_specialitem/#go_twoword")
	slot0._txtlevel = gohelper.findChildText(slot0.viewGO, "characterinfo/#go_characterinfo/level/#txt_level")
	slot0._goskill = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/#go_skill")
	slot0._btnexskill = gohelper.findChildButtonWithAudio(slot0.viewGO, "characterinfo/#go_characterinfo/exskill/#btn_exskill")
	slot0._txtpassivename = gohelper.findChildText(slot0.viewGO, "characterinfo/#go_characterinfo/passiveskill/bg/#txt_passivename")
	slot0._gopassiveskills = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/passiveskill/#go_passiveskills")
	slot0._btnpassiveskill = gohelper.findChildButtonWithAudio(slot0.viewGO, "characterinfo/#go_characterinfo/passiveskill/#btn_passiveskill")
	slot0._btnattribute = gohelper.findChildButtonWithAudio(slot0.viewGO, "characterinfo/#go_characterinfo/attribute/#btn_attribute")
	slot0._goattribute = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/attribute/#go_attribute")
	slot0._simagecharacter = gohelper.findChildSingleImage(slot0.viewGO, "charactercontainer/#simage_character")
	slot0._gostarList = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/#go_starList")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnpassiveskill:AddClickListener(slot0._btnpassiveskillOnClick, slot0)
	slot0._btnattribute:AddClickListener(slot0._btnattributeOnClick, slot0)
	slot0._btnexskill:AddClickListener(slot0._btnexskillOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnpassiveskill:RemoveClickListener()
	slot0._btnattribute:RemoveClickListener()
	slot0._btnexskill:RemoveClickListener()
end

slot0.HpAttrId = 101
slot0.AttackAttrId = 102
slot0.DefenseAttrId = 103
slot0.MdefenseAttrId = 104
slot0.TechnicAttrId = 105

function slot0._btnpassiveskillOnClick(slot0)
	CharacterController.instance:openCharacterTipView({
		tag = "passiveskill",
		heroid = slot0._heroId,
		tipPos = Vector2.New(909, -13.8),
		anchorParams = {
			Vector2.New(0, 0.5),
			Vector2.New(0, 0.5)
		},
		buffTipsX = 1666,
		showAttributeOption = CharacterEnum.showAttributeOption.ShowMin
	})
end

function slot0._btnattributeOnClick(slot0)
	CharacterController.instance:openCharacterTipView({
		tag = "attribute",
		heroid = slot0._heroId,
		showAttributeOption = CharacterEnum.showAttributeOption.ShowMin
	})
end

function slot0._btnexskillOnClick(slot0)
	CharacterController.instance:openCharacterExSkillView({
		fromHeroDetailView = true,
		heroId = slot0._heroId,
		showAttributeOption = CharacterEnum.showAttributeOption.ShowMin
	})
end

function slot0._editableInitView(slot0)
	slot0._simagebg:LoadImage(ResUrl.getCommonViewBg("full/biandui_di"))

	slot0._imagecharacter = gohelper.findChildImage(slot0.viewGO, "charactercontainer/#simage_character")
	slot0._careerGOs = {}

	gohelper.setActive(slot0._gospecialitem, false)

	slot4 = "guang_027"

	slot0._simageredlight:LoadImage(ResUrl.getHeroGroupBg(slot4))

	for slot4 = 1, 6 do
		slot0["_gostar" .. slot4] = gohelper.findChild(slot0._gostarList, "star" .. slot4)
	end

	slot0._skillContainer = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._goskill, CharacterSkillContainer)
	slot0._attributevalues = {}

	for slot4 = 1, 5 do
		slot5 = slot0:getUserDataTb_()
		slot5.value = gohelper.findChildText(slot0._goattribute, "attribute" .. tostring(slot4) .. "/txt_attribute")
		slot5.name = gohelper.findChildText(slot0._goattribute, "attribute" .. tostring(slot4) .. "/name")
		slot5.icon = gohelper.findChildImage(slot0._goattribute, "attribute" .. tostring(slot4) .. "/icon")
		slot5.rate = gohelper.findChildImage(slot0._goattribute, "attribute" .. tostring(slot4) .. "/rate")

		gohelper.setActive(slot5.rate.gameObject, false)

		slot0._attributevalues[slot4] = slot5
	end

	slot0._passiveskillGOs = {}

	for slot4 = 1, 3 do
		table.insert(slot0._passiveskillGOs, gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/passiveskill/#go_passiveskills/passiveskill" .. slot4))
	end
end

function slot0._refreshUI(slot0)
	slot0:_refreshHero(slot0._heroId)
	slot0:_refreshSkin(slot0._skinId)
end

function slot0._getSkinId(slot0)
	for slot5 = CharacterModel.instance:getMaxRank(slot0._heroId), 1, -1 do
		slot10 = "#"

		for slot10, slot11 in pairs(GameUtil.splitString2(SkillConfig.instance:getherorankCO(slot0._heroId, slot5).effect, true, "|", slot10)) do
			if tonumber(slot11[1]) == 3 then
				return tonumber(slot11[2])
			end
		end
	end

	return nil
end

function slot0._refreshHero(slot0, slot1)
	slot2 = HeroConfig.instance:getHeroCO(slot1)

	for slot6 = 1, 6 do
		gohelper.setActive(slot0["_gostar" .. slot6], slot6 <= CharacterEnum.Star[slot2.rare])
	end

	slot0._txtname.text = slot2.name
	slot0._txtnameen.text = slot2.nameEng

	UISpriteSetMgr.instance:setCharactergetSprite(slot0._imagecareericon, "charactercareer" .. tostring(slot2.career))
	UISpriteSetMgr.instance:setCommonSprite(slot0._imagedmgtype, "dmgtype" .. tostring(slot2.dmgType))

	slot5 = HeroConfig.instance:getShowLevel(CharacterModel.instance:getrankEffects(slot1, CharacterModel.instance:getMaxRank(slot1))[1])
	slot0._txtlevel.text = string.format("%d/%d", slot5, slot5)

	slot0:_refreshSpecial(slot1, slot2)
	slot0:_refreshSkill(slot1)
	slot0:_refreshPassiveSkill(slot1, slot2)
	slot0:_refreshAttribute(slot1, slot2)
end

function slot0._refreshSpecial(slot0, slot1, slot2)
	slot3 = {}

	if not string.nilorempty(slot2.battleTag) then
		slot3 = string.split(slot2.battleTag, "#")
	end

	for slot7 = 1, #slot3 do
		if not slot0._careerGOs[slot7] then
			slot8 = slot0:getUserDataTb_()
			slot8.go = gohelper.cloneInPlace(slot0._gospecialitem, "item" .. slot7)
			slot8.textfour = gohelper.findChildText(slot8.go, "#go_fourword/name")
			slot8.textthree = gohelper.findChildText(slot8.go, "#go_threeword/name")
			slot8.texttwo = gohelper.findChildText(slot8.go, "#go_twoword/name")
			slot8.containerfour = gohelper.findChild(slot8.go, "#go_fourword")
			slot8.containerthree = gohelper.findChild(slot8.go, "#go_threeword")
			slot8.containertwo = gohelper.findChild(slot8.go, "#go_twoword")

			table.insert(slot0._careerGOs, slot8)
		end

		gohelper.setActive(slot8.containertwo, GameUtil.utf8len(HeroConfig.instance:getBattleTagConfigCO(slot3[slot7]).tagName) <= 2)
		gohelper.setActive(slot8.containerthree, slot10 == 3)
		gohelper.setActive(slot8.containerfour, slot10 >= 4)

		if slot10 <= 2 then
			slot8.texttwo.text = slot9
		elseif slot10 == 3 then
			slot8.textthree.text = slot9
		else
			slot8.textfour.text = slot9
		end

		gohelper.setActive(slot8.go, true)
	end

	for slot7 = #slot3 + 1, #slot0._careerGOs do
		gohelper.setActive(slot0._careerGOs[slot7].go, false)
	end
end

function slot0._refreshSkill(slot0, slot1)
	slot0._skillContainer:onUpdateMO(slot1, CharacterEnum.showAttributeOption.ShowMin)
end

function slot0._refreshPassiveSkill(slot0, slot1, slot2)
	if not lua_skill.configDict[SkillConfig.instance:getpassiveskillsCO(slot1)[1].skillPassive] then
		logError("找不到角色被动技能, skillId: " .. tostring(slot5))
	end

	slot0._txtpassivename.text = slot6.name

	for slot10 = 1, #slot0._passiveskillGOs do
		gohelper.setActive(slot0._passiveskillGOs[slot10], slot10 <= #slot3)
	end
end

function slot0._refreshAttribute(slot0, slot1, slot2)
	slot3 = {
		uv0.HpAttrId,
		uv0.DefenseAttrId,
		uv0.TechnicAttrId,
		uv0.MdefenseAttrId,
		uv0.AttackAttrId
	}

	for slot7 = 1, 5 do
		slot0._attributevalues[slot7].name.text = HeroConfig.instance:getHeroAttributeCO(slot3[slot7]).name

		CharacterController.instance:SetAttriIcon(slot0._attributevalues[slot7].icon, slot3[slot7], GameUtil.parseColor("#9b795e"))
	end

	slot4 = SkillConfig.instance:getherolevelCO(slot1, 1)
	slot0._attributevalues[1].value.text = slot4.hp
	slot0._attributevalues[2].value.text = slot4.def
	slot0._attributevalues[3].value.text = slot4.technic
	slot0._attributevalues[4].value.text = slot4.mdef
	slot0._attributevalues[5].value.text = slot4.atk
end

function slot0._getLevel1Atrributes(slot0)
	slot2 = SkillConfig.instance:getherolevelCO(slot0._heroId, 1)

	return {
		[uv0.HpAttrId] = slot2.hp,
		[uv0.AttackAttrId] = slot2.atk,
		[uv0.DefenseAttrId] = slot2.def,
		[uv0.MdefenseAttrId] = slot2.mdef,
		[uv0.TechnicAttrId] = slot2.technic
	}
end

function slot0._getAttributeRates(slot0, slot1)
	slot2 = SkillConfig.instance:getGrowCo()
	slot3 = {
		[uv0.HpAttrId] = {},
		[uv0.AttackAttrId] = {},
		[uv0.DefenseAttrId] = {},
		[uv0.MdefenseAttrId] = {},
		[uv0.TechnicAttrId] = {}
	}

	for slot7 = 1, 8 do
		table.insert(slot3[uv0.AttackAttrId], slot2[slot7].atk)
		table.insert(slot3[uv0.HpAttrId], slot2[slot7].hp)
		table.insert(slot3[uv0.DefenseAttrId], slot2[slot7].def)
		table.insert(slot3[uv0.MdefenseAttrId], slot2[slot7].mdef)
		table.insert(slot3[uv0.TechnicAttrId], slot2[slot7].technic)
	end

	return {
		[uv0.HpAttrId] = slot0:_countRate(slot1[uv0.HpAttrId], slot3[uv0.HpAttrId], 8),
		[uv0.AttackAttrId] = slot0:_countRate(slot1[uv0.AttackAttrId], slot3[uv0.AttackAttrId], 8),
		[uv0.DefenseAttrId] = slot0:_countRate(slot1[uv0.DefenseAttrId], slot3[uv0.DefenseAttrId], 8),
		[uv0.MdefenseAttrId] = slot0:_countRate(slot1[uv0.MdefenseAttrId], slot3[uv0.MdefenseAttrId], 8),
		[uv0.TechnicAttrId] = slot0:_countRate(slot1[uv0.TechnicAttrId], slot3[uv0.TechnicAttrId], 8)
	}
end

function slot0._countRate(slot0, slot1, slot2, slot3)
	for slot7 = 1, slot3 - 1 do
		if slot1 < slot2[slot7 + 1] then
			return slot7
		end
	end

	return slot3
end

function slot0._refreshSkin(slot0, slot1)
	if not SkinConfig.instance:getSkinCo(slot1) then
		logError("没有找到配置, skinId: " .. tostring(slot1))

		return
	end

	slot3 = SkinConfig.instance:getSkinOffset(slot2.haloOffset)
	slot6 = tonumber(slot3[3])

	recthelper.setAnchor(slot0._simageredlight.transform, tonumber(slot3[1]), tonumber(slot3[2]))
	transformhelper.setLocalScale(slot0._simageredlight.transform, slot6, slot6, slot6)

	slot0._skinConfig = slot2

	slot0._simagecharacter:LoadImage(ResUrl.getHeadIconImg(slot2.drawing), slot0._onImageLoaded, slot0)

	if slot0._skinColorStr then
		SLFramework.UGUI.GuiHelper.SetColor(slot0._imagecharacter, slot0._skinColorStr)
	end
end

function slot0._onImageLoaded(slot0)
	ZProj.UGUIHelper.SetImageSize(slot0._simagecharacter.gameObject)

	slot1 = SkinConfig.instance:getSkinOffset(slot0._skinConfig.summonHeroViewOffset)

	recthelper.setAnchor(slot0._simagecharacter.transform.parent, slot1[1], slot1[2])
	transformhelper.setLocalScale(slot0._simagecharacter.transform.parent, slot1[3], slot1[3], slot1[3])
end

function slot0._initViewParam(slot0)
	slot0._characterDetailId = slot0.viewParam.id
	slot0._heroId = slot0.viewParam.heroId
	slot0._skinId = slot0.viewParam.skinId
	slot0._skinColorStr = slot0.viewParam.skinColorStr or "#FFFFFF"

	if slot0._skinId == nil then
		if slot0._heroId then
			slot0._skinId = slot0:_getSkinId() or HeroConfig.instance:getHeroCO(slot0._heroId).skinId
		end

		if slot0._characterDetailId then
			slot0._heroId = SummonConfig.instance:getCharacterDetailConfig(slot0._characterDetailId).heroId
			slot0._skinId = slot0:_getSkinId() or slot1.skinId
		end
	end
end

function slot0.onUpdateParam(slot0)
	slot0:_initViewParam()
	slot0:_refreshUI()
end

function slot0.onOpen(slot0)
	slot0:_initViewParam()
	slot0:_refreshUI()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageredlight:UnLoadImage()
	slot0._simagebg:UnLoadImage()
end

return slot0
