module("modules.logic.seasonver.act123.view2_0.Season123_2_0PickHeroDetailView", package.seeall)

slot0 = class("Season123_2_0PickHeroDetailView", BaseView)

function slot0.onInitView(slot0)
	slot0._gononecharacter = gohelper.findChild(slot0.viewGO, "characterinfo/#go_nonecharacter")
	slot0._gocharacterinfo = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo")
	slot0._imagedmgtype = gohelper.findChildImage(slot0.viewGO, "characterinfo/#go_characterinfo/#image_dmgtype")
	slot0._imagecareericon = gohelper.findChildImage(slot0.viewGO, "characterinfo/#go_characterinfo/career/#image_careericon")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "characterinfo/#go_characterinfo/name/#txt_name")
	slot0._txtnameen = gohelper.findChildText(slot0.viewGO, "characterinfo/#go_characterinfo/name/#txt_nameen")
	slot0._gospecialitem = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/special/#go_specialitem")
	slot0._golevel = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/level")
	slot0._txtlevel = gohelper.findChildText(slot0.viewGO, "characterinfo/#go_characterinfo/level/#txt_level")
	slot0._txtlevelmax = gohelper.findChildText(slot0.viewGO, "characterinfo/#go_characterinfo/level/#txt_level/#txt_levelmax")
	slot0._btncharacter = gohelper.findChildButtonWithAudio(slot0.viewGO, "characterinfo/#go_characterinfo/level/#btn_character")
	slot0._btnattribute = gohelper.findChildButtonWithAudio(slot0.viewGO, "characterinfo/#go_characterinfo/attribute/#btn_attribute")
	slot0._goattribute = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/attribute/#go_attribute")
	slot0._goskill = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/#go_skill")
	slot0._btnpassiveskill = gohelper.findChildButtonWithAudio(slot0.viewGO, "characterinfo/#go_characterinfo/passiveskill/#btn_passiveskill")
	slot0._txtpassivename = gohelper.findChildText(slot0.viewGO, "characterinfo/#go_characterinfo/passiveskill/bg/#txt_passivename")
	slot0._gopassiveskills = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/passiveskill/#go_passiveskills")
	slot0._gorolesort = gohelper.findChild(slot0.viewGO, "#go_rolecontainer/#go_rolesort")
	slot0._btnlvrank = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_lvrank")
	slot0._btnrarerank = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_rarerank")
	slot0._btnexskillrank = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_exskillrank")
	slot0._btnclassify = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_classify")
	slot0._goexarrow = gohelper.findChild(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_exskillrank/#go_exarrow")
	slot0._gosearchfilter = gohelper.findChild(slot0.viewGO, "#go_searchfilter")
	slot0._btnclosefilterview = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_searchfilter/#btn_closefilterview")
	slot0._godmgitem = gohelper.findChild(slot0.viewGO, "#go_searchfilter/container/dmgContainer/#go_dmgitem")
	slot0._goattritem = gohelper.findChild(slot0.viewGO, "#go_searchfilter/container/attrContainer/#go_attritem")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_searchfilter/container/#btn_reset")
	slot0._btnok = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_searchfilter/container/#btn_ok")
	slot0._txtrecommendAttrDesc = gohelper.findChildText(slot0.viewGO, "#go_recommendAttr/bg/#txt_desc")
	slot0._goattrlist = gohelper.findChild(slot0.viewGO, "#go_recommendAttr/bg/#go_attrlist")
	slot0._goattritem = gohelper.findChild(slot0.viewGO, "#go_recommendAttr/bg/#go_attrlist/#go_attritem")
	slot0._golevelWithTalent = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent")
	slot0._txtlevelWithTalent = gohelper.findChildText(slot0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_level")
	slot0._txtlevelmaxWithTalent = gohelper.findChildText(slot0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_level/#txt_levelmax")
	slot0._btncharacterWithTalent = gohelper.findChildButtonWithAudio(slot0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#btn_character")
	slot0._goheroLvTxtWithTalent = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/Text")
	slot0._txttalent = gohelper.findChildText(slot0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_talent")
	slot0._txttalentType = gohelper.findChildText(slot0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_talentType")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnpassiveskill:AddClickListener(slot0._btnpassiveskillOnClick, slot0)
	slot0._btncharacter:AddClickListener(slot0._btncharacterOnClick, slot0)
	slot0._btncharacterWithTalent:AddClickListener(slot0._btncharacterOnClick, slot0)
	slot0._btnattribute:AddClickListener(slot0._btnattributeOnClick, slot0)
	slot0._btnlvrank:AddClickListener(slot0._btnlvrankOnClick, slot0)
	slot0._btnrarerank:AddClickListener(slot0._btnrarerankOnClick, slot0)
	slot0._btnexskillrank:AddClickListener(slot0._btnexskillrankOnClick, slot0)
	slot0._btnclassify:AddClickListener(slot0._btnclassifyOnClick, slot0)
	slot0._btnclosefilterview:AddClickListener(slot0._btncloseFilterViewOnClick, slot0)
	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
	slot0._btnok:AddClickListener(slot0._btnokOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnpassiveskill:RemoveClickListener()
	slot0._btncharacter:RemoveClickListener()
	slot0._btncharacterWithTalent:RemoveClickListener()
	slot0._btnattribute:RemoveClickListener()
	slot0._btnlvrank:RemoveClickListener()
	slot0._btnrarerank:RemoveClickListener()
	slot0._btnexskillrank:RemoveClickListener()
	slot0._btnclassify:RemoveClickListener()
	slot0._btnclosefilterview:RemoveClickListener()
	slot0._btnreset:RemoveClickListener()
	slot0._btnok:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._careerGOs = {}
	slot0._lvBtns = slot0:getUserDataTb_()
	slot0._lvArrow = slot0:getUserDataTb_()
	slot0._rareBtns = slot0:getUserDataTb_()
	slot0._rareArrow = slot0:getUserDataTb_()
	slot0._classifyBtns = slot0:getUserDataTb_()
	slot0._selectDmgs = {}
	slot0._dmgSelects = slot0:getUserDataTb_()
	slot0._dmgUnselects = slot0:getUserDataTb_()
	slot0._dmgBtnClicks = slot0:getUserDataTb_()
	slot0._selectAttrs = {}
	slot0._attrSelects = slot0:getUserDataTb_()
	slot0._attrUnselects = slot0:getUserDataTb_()
	slot0._attrBtnClicks = slot0:getUserDataTb_()
	slot0._selectLocations = {}
	slot0._locationSelects = slot0:getUserDataTb_()
	slot0._locationUnselects = slot0:getUserDataTb_()
	slot0._locationBtnClicks = slot0:getUserDataTb_()
	slot0._curDmgs = {}
	slot0._curAttrs = {}
	slot0._curLocations = {}

	for slot4 = 1, 2 do
		slot0._lvBtns[slot4] = gohelper.findChild(slot0._btnlvrank.gameObject, "btn" .. tostring(slot4))
		slot0._lvArrow[slot4] = gohelper.findChild(slot0._lvBtns[slot4], "txt/arrow").transform
		slot0._rareBtns[slot4] = gohelper.findChild(slot0._btnrarerank.gameObject, "btn" .. tostring(slot4))
		slot0._rareArrow[slot4] = gohelper.findChild(slot0._rareBtns[slot4], "txt/arrow").transform
		slot0._classifyBtns[slot4] = gohelper.findChild(slot0._btnclassify.gameObject, "btn" .. tostring(slot4))
		slot0._dmgUnselects[slot4] = gohelper.findChild(slot0._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. slot4 .. "/unselected")
		slot0._dmgSelects[slot4] = gohelper.findChild(slot0._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. slot4 .. "/selected")
		slot0._dmgBtnClicks[slot4] = gohelper.findChildButtonWithAudio(slot0._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. slot4 .. "/click")

		slot0._dmgBtnClicks[slot4]:AddClickListener(slot0._dmgBtnOnClick, slot0, slot4)
	end

	for slot4 = 1, 6 do
		slot0._attrUnselects[slot4] = gohelper.findChild(slot0._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. slot4 .. "/unselected")
		slot0._attrSelects[slot4] = gohelper.findChild(slot0._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. slot4 .. "/selected")
		slot0._attrBtnClicks[slot4] = gohelper.findChildButtonWithAudio(slot0._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. slot4 .. "/click")

		slot0._attrBtnClicks[slot4]:AddClickListener(slot0._attrBtnOnClick, slot0, slot4)
	end

	for slot4 = 1, 6 do
		slot0._locationUnselects[slot4] = gohelper.findChild(slot0._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. slot4 .. "/unselected")
		slot0._locationSelects[slot4] = gohelper.findChild(slot0._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. slot4 .. "/selected")
		slot0._locationBtnClicks[slot4] = gohelper.findChildButtonWithAudio(slot0._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. slot4 .. "/click")

		slot0._locationBtnClicks[slot4]:AddClickListener(slot0._locationBtnOnClick, slot0, slot4)
	end

	slot0._attributevalues = {}

	for slot4 = 1, 5 do
		slot5 = slot0:getUserDataTb_()
		slot5.value = gohelper.findChildText(slot0._goattribute, "attribute" .. tostring(slot4) .. "/txt_attribute")
		slot5.name = gohelper.findChildText(slot0._goattribute, "attribute" .. tostring(slot4) .. "/name")
		slot5.icon = gohelper.findChildImage(slot0._goattribute, "attribute" .. tostring(slot4) .. "/icon")
		slot0._attributevalues[slot4] = slot5
	end

	slot0._passiveskillitems = {}

	for slot4 = 1, 3 do
		slot5 = slot0:getUserDataTb_()
		slot5.go = gohelper.findChild(slot0._gopassiveskills, "passiveskill" .. tostring(slot4))
		slot5.on = gohelper.findChild(slot5.go, "on")
		slot5.off = gohelper.findChild(slot5.go, "off")
		slot0._passiveskillitems[slot4] = slot5
	end

	slot0._skillContainer = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._goskill, CharacterSkillContainer)

	gohelper.setActive(slot0._gononecharacter, false)
	gohelper.setActive(slot0._gocharacterinfo, false)
end

function slot0.onDestroyView(slot0)
	if slot0._skillContainer then
		slot0._skillContainer:onDestroy()

		slot0._skillContainer = nil
	end

	for slot4 = 1, 2 do
		slot0._dmgBtnClicks[slot4]:RemoveClickListener()
	end

	for slot4 = 1, 6 do
		slot0._attrBtnClicks[slot4]:RemoveClickListener()
	end

	for slot4 = 1, 6 do
		slot0._locationBtnClicks[slot4]:RemoveClickListener()
	end
end

function slot0.onOpen(slot0)
	slot0:addEventCb(Season123Controller.instance, Season123Event.PickViewRefresh, slot0.refreshUI, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, slot0.refreshHeroListByFilter, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, slot0.refreshHeroListByFilter, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, slot0.refreshHeroListByFilter, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successDressUpSkin, slot0.refreshHeroListByFilter, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, slot0.refreshUI, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, slot0.refreshUI, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, slot0.refreshUI, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, slot0.refreshUI, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, slot0.refreshUI, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.levelUpAttribute, slot0._onAttributeChanged, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.showCharacterRankUpView, slot0._showCharacterRankUpView, slot0)
	slot0:initStatus()
	slot0:refreshUI()
	slot0:_showRecommendCareer()
end

function slot0.onClose(slot0)
end

function slot0.initStatus(slot0)
	for slot4 = 1, 6 do
		slot0._selectAttrs[slot4] = false
	end

	for slot4 = 1, 2 do
		slot0._selectDmgs[slot4] = false
	end

	for slot4 = 1, 6 do
		slot0._selectLocations[slot4] = false
	end
end

function slot0.refreshUI(slot0)
	slot0._heroMO = Season123PickHeroModel.instance:getSelectedHeroMO()

	if slot0._heroMO then
		gohelper.setActive(slot0._gononecharacter, false)
		gohelper.setActive(slot0._gocharacterinfo, true)
		slot0:_refreshSkill()
		slot0:_refreshMainInfo()
		slot0:_refreshAttribute()
		slot0:_refreshPassiveSkill()
	else
		gohelper.setActive(slot0._gononecharacter, true)
		gohelper.setActive(slot0._gocharacterinfo, false)
	end

	slot0:_refreshBtnIcon()
end

function slot0._refreshMainInfo(slot0)
	if slot0._heroMO then
		UISpriteSetMgr.instance:setCommonSprite(slot0._imagecareericon, "sx_biandui_" .. tostring(slot0._heroMO.config.career))
		UISpriteSetMgr.instance:setCommonSprite(slot0._imagedmgtype, "dmgtype" .. tostring(slot0._heroMO.config.dmgType))

		slot0._txtname.text = slot0._heroMO.config.name
		slot0._txtnameen.text = slot0._heroMO.config.nameEng
		slot2 = HeroConfig.instance:getShowLevel(slot0._heroMO.level)
		slot3 = HeroConfig.instance:getShowLevel(CharacterModel.instance:getrankEffects(slot0._heroMO.heroId, slot0._heroMO.rank)[1])
		slot4 = CharacterEnum.TalentRank <= slot0._heroMO.rank and slot0._heroMO.talent > 0

		if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) then
			slot4 = false
		end

		if slot4 then
			gohelper.setActive(slot0._golevel, false)
			gohelper.setActive(slot0._golevelWithTalent, true)
			gohelper.setActive(slot0._goheroLvTxtWithTalent, true)

			slot0._txtlevelWithTalent.text = tostring(slot2)
			slot0._txtlevelmaxWithTalent.text = string.format("/%d", slot3)
			slot0._txttalent.text = "Lv.<size=40>" .. tostring(slot0._heroMO.talent)
			slot0._txttalentType.text = luaLang("talent_character_talentcn" .. CharacterEnum.TalentTxtByHeroType[slot0._heroMO.config.heroType])
		else
			gohelper.setActive(slot0._golevel, true)
			gohelper.setActive(slot0._golevelWithTalent, false)

			slot0._txtlevel.text = tostring(slot2)
			slot0._txtlevelmax.text = string.format("/%d", slot3)
		end

		slot5 = {}

		if not string.nilorempty(slot0._heroMO.config.battleTag) then
			slot5 = string.split(slot0._heroMO.config.battleTag, "#")
		end

		for slot9 = 1, #slot5 do
			if not slot0._careerGOs[slot9] then
				slot10 = slot0:getUserDataTb_()
				slot10.go = gohelper.cloneInPlace(slot0._gospecialitem, "item" .. slot9)
				slot10.textfour = gohelper.findChildText(slot10.go, "#go_fourword/name")
				slot10.textthree = gohelper.findChildText(slot10.go, "#go_threeword/name")
				slot10.texttwo = gohelper.findChildText(slot10.go, "#go_twoword/name")
				slot10.containerfour = gohelper.findChild(slot10.go, "#go_fourword")
				slot10.containerthree = gohelper.findChild(slot10.go, "#go_threeword")
				slot10.containertwo = gohelper.findChild(slot10.go, "#go_twoword")

				table.insert(slot0._careerGOs, slot10)
			end

			gohelper.setActive(slot10.containertwo, GameUtil.utf8len(HeroConfig.instance:getBattleTagConfigCO(slot5[slot9]).tagName) <= 2)
			gohelper.setActive(slot10.containerthree, slot12 == 3)
			gohelper.setActive(slot10.containerfour, slot12 >= 4)

			if slot12 <= 2 then
				slot10.texttwo.text = slot11
			elseif slot12 == 3 then
				slot10.textthree.text = slot11
			else
				slot10.textfour.text = slot11
			end

			gohelper.setActive(slot10.go, true)
		end

		for slot9 = #slot5 + 1, #slot0._careerGOs do
			gohelper.setActive(slot0._careerGOs[slot9].go, false)
		end
	end
end

function slot0._refreshAttribute(slot0)
	if slot0._heroMO then
		for slot5, slot6 in ipairs(CharacterEnum.BaseAttrIdList) do
			slot0._attributevalues[slot5].name.text = HeroConfig.instance:getHeroAttributeCO(slot6).name
			slot0._attributevalues[slot5].value.text = slot0._heroMO:getTotalBaseAttrDict(slot0._equips)[slot6]

			CharacterController.instance:SetAttriIcon(slot0._attributevalues[slot5].icon, slot6)
		end
	end
end

function slot0._refreshPassiveSkill(slot0)
	if not slot0._heroMO then
		return
	end

	if not lua_skill.configDict[SkillConfig.instance:getpassiveskillsCO(slot0._heroMO.heroId)[1].skillPassive] then
		logError("找不到角色被动技能, skillId: " .. tostring(slot3))
	else
		slot0._txtpassivename.text = slot4.name
	end

	for slot8 = 1, #slot1 do
		slot9 = CharacterModel.instance:isPassiveUnlockByHeroMo(slot0._heroMO, slot8)

		gohelper.setActive(slot0._passiveskillitems[slot8].on, slot9)
		gohelper.setActive(slot0._passiveskillitems[slot8].off, not slot9)
		gohelper.setActive(slot0._passiveskillitems[slot8].go, true)
	end

	for slot8 = #slot1 + 1, #slot0._passiveskillitems do
		gohelper.setActive(slot0._passiveskillitems[slot8].go, false)
	end
end

function slot0._refreshSkill(slot0)
	slot0._skillContainer:onUpdateMO(slot0._heroMO and slot0._heroMO.heroId, false, slot0._heroMO)
end

function slot0._refreshBtnIcon(slot0)
	slot1 = CharacterModel.instance:getRankState()

	gohelper.setActive(slot0._lvBtns[1], CharacterModel.instance:getBtnTag(CharacterEnum.FilterType.HeroGroup) ~= 1)
	gohelper.setActive(slot0._lvBtns[2], slot2 == 1)
	gohelper.setActive(slot0._rareBtns[1], slot2 ~= 2)
	gohelper.setActive(slot0._rareBtns[2], slot2 == 2)

	slot3 = false

	for slot7, slot8 in pairs(slot0._selectDmgs) do
		if slot8 then
			slot3 = true
		end
	end

	for slot7, slot8 in pairs(slot0._selectAttrs) do
		if slot8 then
			slot3 = true
		end
	end

	gohelper.setActive(slot0._classifyBtns[1], not slot3)
	gohelper.setActive(slot0._classifyBtns[2], slot3)
	transformhelper.setLocalScale(slot0._lvArrow[1], 1, slot1[1], 1)
	transformhelper.setLocalScale(slot0._lvArrow[2], 1, slot1[1], 1)
	transformhelper.setLocalScale(slot0._rareArrow[1], 1, slot1[2], 1)
	transformhelper.setLocalScale(slot0._rareArrow[2], 1, slot1[2], 1)
end

function slot0._btnattributeOnClick(slot0)
	if slot0._heroMO then
		CharacterController.instance:openCharacterTipView({
			tag = "attribute",
			heroid = slot0._heroMO.heroId,
			equips = slot0._equips,
			showExtraAttr = true,
			fromHeroGroupEditView = true
		})
	end
end

function slot0._btncharacterOnClick(slot0)
	if slot0._heroMO then
		slot1 = Season123PickHeroModel.instance.heroMOList or {}

		if slot0._heroMO:isOtherPlayerHero() and Season123HeroGroupEditModel.instance:getEquipMOByHeroUid(slot0._heroMO.uid) then
			slot0._heroMO:setOtherPlayerEquipMo(slot2)
		end

		CharacterController.instance:openCharacterView(slot0._heroMO, slot1)
	end
end

function slot0._btnpassiveskillOnClick(slot0)
	if not slot0._heroMO then
		return
	end

	CharacterController.instance:openCharacterTipView({
		tag = "passiveskill",
		heroid = slot0._heroMO.heroId,
		tipPos = Vector2.New(851, -59),
		buffTipsX = 1603,
		anchorParams = {
			Vector2.New(0, 0.5),
			Vector2.New(0, 0.5)
		}
	})
end

function slot0._refreshFilterView(slot0)
	for slot4 = 1, 2 do
		gohelper.setActive(slot0._dmgUnselects[slot4], not slot0._selectDmgs[slot4])
		gohelper.setActive(slot0._dmgSelects[slot4], slot0._selectDmgs[slot4])
	end

	for slot4 = 1, 6 do
		gohelper.setActive(slot0._attrUnselects[slot4], not slot0._selectAttrs[slot4])
		gohelper.setActive(slot0._attrSelects[slot4], slot0._selectAttrs[slot4])
	end

	for slot4 = 1, 6 do
		gohelper.setActive(slot0._locationUnselects[slot4], not slot0._selectLocations[slot4])
		gohelper.setActive(slot0._locationSelects[slot4], slot0._selectLocations[slot4])
	end
end

function slot0.refreshHeroListByFilter(slot0)
	for slot5 = 1, 2 do
		if slot0._selectDmgs[slot5] then
			table.insert({}, slot5)
		end
	end

	for slot6 = 1, 6 do
		if slot0._selectAttrs[slot6] then
			table.insert({}, slot6)
		end
	end

	for slot7 = 1, 6 do
		if slot0._selectLocations[slot7] then
			table.insert({}, slot7)
		end
	end

	if #slot1 == 0 then
		slot1 = {
			1,
			2
		}
	end

	if #slot2 == 0 then
		slot2 = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	if #slot3 == 0 then
		slot3 = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	CharacterModel.instance:filterCardListByDmgAndCareer({
		dmgs = slot1,
		careers = slot2,
		locations = slot3
	}, false, CharacterEnum.FilterType.HeroGroup)
	slot0:_refreshBtnIcon()
	Season123PickHeroController.instance:updateFilter()
end

function slot0._onAttributeChanged(slot0, slot1, slot2)
	CharacterModel.instance:setFakeLevel(slot2, slot1)
end

function slot0._showCharacterRankUpView(slot0, slot1)
	slot1()
end

function slot0._attrBtnOnClick(slot0, slot1)
	slot0._selectAttrs[slot1] = not slot0._selectAttrs[slot1]

	slot0:_refreshFilterView()
end

function slot0._dmgBtnOnClick(slot0, slot1)
	if not slot0._selectDmgs[slot1] then
		slot0._selectDmgs[3 - slot1] = slot0._selectDmgs[slot1]
	end

	slot0._selectDmgs[slot1] = not slot0._selectDmgs[slot1]

	slot0:_refreshFilterView()
end

function slot0._locationBtnOnClick(slot0, slot1)
	slot0._selectLocations[slot1] = not slot0._selectLocations[slot1]

	slot0:_refreshFilterView()
end

function slot0._showRecommendCareer(slot0)
	if Season123Config.instance:getRecommendCareers(Season123PickHeroEntryModel.instance.activityId, Season123PickHeroEntryModel.instance.stage) then
		gohelper.CreateObjList(slot0, slot0._onRecommendCareerItemShow, slot1, slot0._goattrlist, slot0._goattritem)
	end

	slot0._txtrecommendAttrDesc.text = slot1 and luaLang("herogroupeditview_recommend") or luaLang("herogroupeditview_notrecommend")

	gohelper.setActive(slot0._goattrlist, slot1)
end

function slot0._onRecommendCareerItemShow(slot0, slot1, slot2, slot3)
	UISpriteSetMgr.instance:setHeroGroupSprite(gohelper.findChildImage(slot1, "icon"), "career_" .. slot2)
end

function slot0._btncloseFilterViewOnClick(slot0)
	slot0._selectDmgs = LuaUtil.deepCopy(slot0._curDmgs)
	slot0._selectAttrs = LuaUtil.deepCopy(slot0._curAttrs)
	slot0._selectLocations = LuaUtil.deepCopy(slot0._curLocations)

	slot0:_refreshBtnIcon()
	gohelper.setActive(slot0._gosearchfilter, false)
end

function slot0._btnclassifyOnClick(slot0)
	gohelper.setActive(slot0._gosearchfilter, true)
	slot0:_refreshFilterView()
end

function slot0._btnresetOnClick(slot0)
	for slot4 = 1, 6 do
		slot0._selectAttrs[slot4] = false
	end

	for slot4 = 1, 2 do
		slot0._selectDmgs[slot4] = false
	end

	for slot4 = 1, 6 do
		slot0._selectLocations[slot4] = false
	end

	slot0:_refreshBtnIcon()
	slot0:_refreshFilterView()
end

function slot0._btnokOnClick(slot0)
	gohelper.setActive(slot0._gosearchfilter, false)
	slot0:refreshHeroListByFilter()

	slot0._curDmgs = LuaUtil.deepCopy(slot0._selectDmgs)
	slot0._curAttrs = LuaUtil.deepCopy(slot0._selectAttrs)
	slot0._curLocations = LuaUtil.deepCopy(slot0._selectLocations)

	ViewMgr.instance:closeView(ViewName.CharacterLevelUpView)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
end

function slot0._btnexskillrankOnClick(slot0)
	CharacterModel.instance:setCardListByExSkill(false, CharacterEnum.FilterType.HeroGroup)
	Season123PickHeroController.instance:updateFilter()
	slot0:_refreshBtnIcon()
end

function slot0._btnlvrankOnClick(slot0)
	CharacterModel.instance:setCardListByLevel(false, CharacterEnum.FilterType.HeroGroup)
	Season123PickHeroController.instance:updateFilter()
	slot0:_refreshBtnIcon()
end

function slot0._btnrarerankOnClick(slot0)
	CharacterModel.instance:setCardListByRare(false, CharacterEnum.FilterType.HeroGroup)
	Season123PickHeroController.instance:updateFilter()
	slot0:_refreshBtnIcon()
end

return slot0
