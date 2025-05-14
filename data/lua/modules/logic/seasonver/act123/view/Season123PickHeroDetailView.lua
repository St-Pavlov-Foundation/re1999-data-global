module("modules.logic.seasonver.act123.view.Season123PickHeroDetailView", package.seeall)

local var_0_0 = class("Season123PickHeroDetailView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gononecharacter = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_nonecharacter")
	arg_1_0._gocharacterinfo = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo")
	arg_1_0._imagedmgtype = gohelper.findChildImage(arg_1_0.viewGO, "characterinfo/#go_characterinfo/#image_dmgtype")
	arg_1_0._imagecareericon = gohelper.findChildImage(arg_1_0.viewGO, "characterinfo/#go_characterinfo/career/#image_careericon")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "characterinfo/#go_characterinfo/name/#txt_name")
	arg_1_0._txtnameen = gohelper.findChildText(arg_1_0.viewGO, "characterinfo/#go_characterinfo/name/#txt_nameen")
	arg_1_0._gospecialitem = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/special/#go_specialitem")
	arg_1_0._txtlevel = gohelper.findChildText(arg_1_0.viewGO, "characterinfo/#go_characterinfo/level/#txt_level")
	arg_1_0._txtlevelmax = gohelper.findChildText(arg_1_0.viewGO, "characterinfo/#go_characterinfo/level/#txt_level/#txt_levelmax")
	arg_1_0._btncharacter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "characterinfo/#go_characterinfo/level/#btn_character")
	arg_1_0._btnattribute = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "characterinfo/#go_characterinfo/attribute/#btn_attribute")
	arg_1_0._goattribute = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/attribute/#go_attribute")
	arg_1_0._goskill = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/#go_skill")
	arg_1_0._btnpassiveskill = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "characterinfo/#go_characterinfo/passiveskill/#btn_passiveskill")
	arg_1_0._txtpassivename = gohelper.findChildText(arg_1_0.viewGO, "characterinfo/#go_characterinfo/passiveskill/bg/#txt_passivename")
	arg_1_0._gopassiveskills = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/passiveskill/#go_passiveskills")
	arg_1_0._gorolesort = gohelper.findChild(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort")
	arg_1_0._btnlvrank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_lvrank")
	arg_1_0._btnrarerank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_rarerank")
	arg_1_0._btnexskillrank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_exskillrank")
	arg_1_0._btnclassify = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_classify")
	arg_1_0._goexarrow = gohelper.findChild(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_exskillrank/#go_exarrow")
	arg_1_0._gosearchfilter = gohelper.findChild(arg_1_0.viewGO, "#go_searchfilter")
	arg_1_0._btnclosefilterview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_searchfilter/#btn_closefilterview")
	arg_1_0._godmgitem = gohelper.findChild(arg_1_0.viewGO, "#go_searchfilter/container/dmgContainer/#go_dmgitem")
	arg_1_0._goattritem = gohelper.findChild(arg_1_0.viewGO, "#go_searchfilter/container/attrContainer/#go_attritem")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_searchfilter/container/#btn_reset")
	arg_1_0._btnok = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_searchfilter/container/#btn_ok")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnpassiveskill:AddClickListener(arg_2_0._btnpassiveskillOnClick, arg_2_0)
	arg_2_0._btncharacter:AddClickListener(arg_2_0._btncharacterOnClick, arg_2_0)
	arg_2_0._btnattribute:AddClickListener(arg_2_0._btnattributeOnClick, arg_2_0)
	arg_2_0._btnlvrank:AddClickListener(arg_2_0._btnlvrankOnClick, arg_2_0)
	arg_2_0._btnrarerank:AddClickListener(arg_2_0._btnrarerankOnClick, arg_2_0)
	arg_2_0._btnexskillrank:AddClickListener(arg_2_0._btnexskillrankOnClick, arg_2_0)
	arg_2_0._btnclassify:AddClickListener(arg_2_0._btnclassifyOnClick, arg_2_0)
	arg_2_0._btnclosefilterview:AddClickListener(arg_2_0._btncloseFilterViewOnClick, arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
	arg_2_0._btnok:AddClickListener(arg_2_0._btnokOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnpassiveskill:RemoveClickListener()
	arg_3_0._btncharacter:RemoveClickListener()
	arg_3_0._btnattribute:RemoveClickListener()
	arg_3_0._btnlvrank:RemoveClickListener()
	arg_3_0._btnrarerank:RemoveClickListener()
	arg_3_0._btnexskillrank:RemoveClickListener()
	arg_3_0._btnclassify:RemoveClickListener()
	arg_3_0._btnclosefilterview:RemoveClickListener()
	arg_3_0._btnreset:RemoveClickListener()
	arg_3_0._btnok:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._careerGOs = {}
	arg_4_0._lvBtns = arg_4_0:getUserDataTb_()
	arg_4_0._lvArrow = arg_4_0:getUserDataTb_()
	arg_4_0._rareBtns = arg_4_0:getUserDataTb_()
	arg_4_0._rareArrow = arg_4_0:getUserDataTb_()
	arg_4_0._classifyBtns = arg_4_0:getUserDataTb_()
	arg_4_0._selectDmgs = {}
	arg_4_0._dmgSelects = arg_4_0:getUserDataTb_()
	arg_4_0._dmgUnselects = arg_4_0:getUserDataTb_()
	arg_4_0._dmgBtnClicks = arg_4_0:getUserDataTb_()
	arg_4_0._selectAttrs = {}
	arg_4_0._attrSelects = arg_4_0:getUserDataTb_()
	arg_4_0._attrUnselects = arg_4_0:getUserDataTb_()
	arg_4_0._attrBtnClicks = arg_4_0:getUserDataTb_()
	arg_4_0._selectLocations = {}
	arg_4_0._locationSelects = arg_4_0:getUserDataTb_()
	arg_4_0._locationUnselects = arg_4_0:getUserDataTb_()
	arg_4_0._locationBtnClicks = arg_4_0:getUserDataTb_()
	arg_4_0._curDmgs = {}
	arg_4_0._curAttrs = {}
	arg_4_0._curLocations = {}

	for iter_4_0 = 1, 2 do
		arg_4_0._lvBtns[iter_4_0] = gohelper.findChild(arg_4_0._btnlvrank.gameObject, "btn" .. tostring(iter_4_0))
		arg_4_0._lvArrow[iter_4_0] = gohelper.findChild(arg_4_0._lvBtns[iter_4_0], "txt/arrow").transform
		arg_4_0._rareBtns[iter_4_0] = gohelper.findChild(arg_4_0._btnrarerank.gameObject, "btn" .. tostring(iter_4_0))
		arg_4_0._rareArrow[iter_4_0] = gohelper.findChild(arg_4_0._rareBtns[iter_4_0], "txt/arrow").transform
		arg_4_0._classifyBtns[iter_4_0] = gohelper.findChild(arg_4_0._btnclassify.gameObject, "btn" .. tostring(iter_4_0))
		arg_4_0._dmgUnselects[iter_4_0] = gohelper.findChild(arg_4_0._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. iter_4_0 .. "/unselected")
		arg_4_0._dmgSelects[iter_4_0] = gohelper.findChild(arg_4_0._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. iter_4_0 .. "/selected")
		arg_4_0._dmgBtnClicks[iter_4_0] = gohelper.findChildButtonWithAudio(arg_4_0._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. iter_4_0 .. "/click")

		arg_4_0._dmgBtnClicks[iter_4_0]:AddClickListener(arg_4_0._dmgBtnOnClick, arg_4_0, iter_4_0)
	end

	for iter_4_1 = 1, 6 do
		arg_4_0._attrUnselects[iter_4_1] = gohelper.findChild(arg_4_0._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. iter_4_1 .. "/unselected")
		arg_4_0._attrSelects[iter_4_1] = gohelper.findChild(arg_4_0._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. iter_4_1 .. "/selected")
		arg_4_0._attrBtnClicks[iter_4_1] = gohelper.findChildButtonWithAudio(arg_4_0._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. iter_4_1 .. "/click")

		arg_4_0._attrBtnClicks[iter_4_1]:AddClickListener(arg_4_0._attrBtnOnClick, arg_4_0, iter_4_1)
	end

	for iter_4_2 = 1, 6 do
		arg_4_0._locationUnselects[iter_4_2] = gohelper.findChild(arg_4_0._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. iter_4_2 .. "/unselected")
		arg_4_0._locationSelects[iter_4_2] = gohelper.findChild(arg_4_0._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. iter_4_2 .. "/selected")
		arg_4_0._locationBtnClicks[iter_4_2] = gohelper.findChildButtonWithAudio(arg_4_0._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. iter_4_2 .. "/click")

		arg_4_0._locationBtnClicks[iter_4_2]:AddClickListener(arg_4_0._locationBtnOnClick, arg_4_0, iter_4_2)
	end

	arg_4_0._attributevalues = {}

	for iter_4_3 = 1, 5 do
		local var_4_0 = arg_4_0:getUserDataTb_()

		var_4_0.value = gohelper.findChildText(arg_4_0._goattribute, "attribute" .. tostring(iter_4_3) .. "/txt_attribute")
		var_4_0.name = gohelper.findChildText(arg_4_0._goattribute, "attribute" .. tostring(iter_4_3) .. "/name")
		var_4_0.icon = gohelper.findChildImage(arg_4_0._goattribute, "attribute" .. tostring(iter_4_3) .. "/icon")
		arg_4_0._attributevalues[iter_4_3] = var_4_0
	end

	arg_4_0._passiveskillitems = {}

	for iter_4_4 = 1, 3 do
		local var_4_1 = arg_4_0:getUserDataTb_()

		var_4_1.go = gohelper.findChild(arg_4_0._gopassiveskills, "passiveskill" .. tostring(iter_4_4))
		var_4_1.on = gohelper.findChild(var_4_1.go, "on")
		var_4_1.off = gohelper.findChild(var_4_1.go, "off")
		arg_4_0._passiveskillitems[iter_4_4] = var_4_1
	end

	arg_4_0._skillContainer = MonoHelper.addNoUpdateLuaComOnceToGo(arg_4_0._goskill, CharacterSkillContainer)

	gohelper.setActive(arg_4_0._gononecharacter, false)
	gohelper.setActive(arg_4_0._gocharacterinfo, false)
end

function var_0_0.onDestroyView(arg_5_0)
	if arg_5_0._skillContainer then
		arg_5_0._skillContainer:onDestroy()

		arg_5_0._skillContainer = nil
	end

	for iter_5_0 = 1, 2 do
		arg_5_0._dmgBtnClicks[iter_5_0]:RemoveClickListener()
	end

	for iter_5_1 = 1, 6 do
		arg_5_0._attrBtnClicks[iter_5_1]:RemoveClickListener()
	end

	for iter_5_2 = 1, 6 do
		arg_5_0._locationBtnClicks[iter_5_2]:RemoveClickListener()
	end
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:addEventCb(Season123Controller.instance, Season123Event.PickViewRefresh, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_6_0.refreshHeroListByFilter, arg_6_0)
	arg_6_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_6_0.refreshHeroListByFilter, arg_6_0)
	arg_6_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_6_0.refreshHeroListByFilter, arg_6_0)
	arg_6_0:addEventCb(CharacterController.instance, CharacterEvent.successDressUpSkin, arg_6_0.refreshHeroListByFilter, arg_6_0)
	arg_6_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_6_0.refreshUI, arg_6_0)
	arg_6_0:addEventCb(CharacterController.instance, CharacterEvent.levelUpAttribute, arg_6_0._onAttributeChanged, arg_6_0)
	arg_6_0:addEventCb(CharacterController.instance, CharacterEvent.showCharacterRankUpView, arg_6_0._showCharacterRankUpView, arg_6_0)
	arg_6_0:initStatus()
	arg_6_0:refreshUI()
end

function var_0_0.onClose(arg_7_0)
	return
end

function var_0_0.initStatus(arg_8_0)
	for iter_8_0 = 1, 6 do
		arg_8_0._selectAttrs[iter_8_0] = false
	end

	for iter_8_1 = 1, 2 do
		arg_8_0._selectDmgs[iter_8_1] = false
	end

	for iter_8_2 = 1, 6 do
		arg_8_0._selectLocations[iter_8_2] = false
	end
end

function var_0_0.refreshUI(arg_9_0)
	arg_9_0._heroMO = Season123PickHeroModel.instance:getSelectedHeroMO()

	if arg_9_0._heroMO then
		gohelper.setActive(arg_9_0._gononecharacter, false)
		gohelper.setActive(arg_9_0._gocharacterinfo, true)
		arg_9_0:_refreshSkill()
		arg_9_0:_refreshMainInfo()
		arg_9_0:_refreshAttribute()
		arg_9_0:_refreshPassiveSkill()
	else
		gohelper.setActive(arg_9_0._gononecharacter, true)
		gohelper.setActive(arg_9_0._gocharacterinfo, false)
	end

	arg_9_0:_refreshBtnIcon()
end

function var_0_0._refreshMainInfo(arg_10_0)
	if arg_10_0._heroMO then
		UISpriteSetMgr.instance:setCommonSprite(arg_10_0._imagecareericon, "sx_biandui_" .. tostring(arg_10_0._heroMO.config.career))
		UISpriteSetMgr.instance:setCommonSprite(arg_10_0._imagedmgtype, "dmgtype" .. tostring(arg_10_0._heroMO.config.dmgType))

		arg_10_0._txtname.text = arg_10_0._heroMO.config.name
		arg_10_0._txtnameen.text = arg_10_0._heroMO.config.nameEng

		local var_10_0 = CharacterModel.instance:getrankEffects(arg_10_0._heroMO.heroId, arg_10_0._heroMO.rank)[1]
		local var_10_1 = HeroConfig.instance:getShowLevel(arg_10_0._heroMO.level)
		local var_10_2 = HeroConfig.instance:getShowLevel(var_10_0)

		arg_10_0._txtlevel.text = tostring(var_10_1)
		arg_10_0._txtlevelmax.text = string.format("/%d", var_10_2)

		local var_10_3 = {}

		if not string.nilorempty(arg_10_0._heroMO.config.battleTag) then
			var_10_3 = string.split(arg_10_0._heroMO.config.battleTag, "#")
		end

		for iter_10_0 = 1, #var_10_3 do
			local var_10_4 = arg_10_0._careerGOs[iter_10_0]

			if not var_10_4 then
				var_10_4 = arg_10_0:getUserDataTb_()
				var_10_4.go = gohelper.cloneInPlace(arg_10_0._gospecialitem, "item" .. iter_10_0)
				var_10_4.textfour = gohelper.findChildText(var_10_4.go, "#go_fourword/name")
				var_10_4.textthree = gohelper.findChildText(var_10_4.go, "#go_threeword/name")
				var_10_4.texttwo = gohelper.findChildText(var_10_4.go, "#go_twoword/name")
				var_10_4.containerfour = gohelper.findChild(var_10_4.go, "#go_fourword")
				var_10_4.containerthree = gohelper.findChild(var_10_4.go, "#go_threeword")
				var_10_4.containertwo = gohelper.findChild(var_10_4.go, "#go_twoword")

				table.insert(arg_10_0._careerGOs, var_10_4)
			end

			local var_10_5 = HeroConfig.instance:getBattleTagConfigCO(var_10_3[iter_10_0]).tagName
			local var_10_6 = GameUtil.utf8len(var_10_5)

			gohelper.setActive(var_10_4.containertwo, var_10_6 <= 2)
			gohelper.setActive(var_10_4.containerthree, var_10_6 == 3)
			gohelper.setActive(var_10_4.containerfour, var_10_6 >= 4)

			if var_10_6 <= 2 then
				var_10_4.texttwo.text = var_10_5
			elseif var_10_6 == 3 then
				var_10_4.textthree.text = var_10_5
			else
				var_10_4.textfour.text = var_10_5
			end

			gohelper.setActive(var_10_4.go, true)
		end

		for iter_10_1 = #var_10_3 + 1, #arg_10_0._careerGOs do
			gohelper.setActive(arg_10_0._careerGOs[iter_10_1].go, false)
		end
	end
end

function var_0_0._refreshAttribute(arg_11_0)
	if arg_11_0._heroMO then
		local var_11_0 = arg_11_0._heroMO:getTotalBaseAttrDict(arg_11_0._equips)

		for iter_11_0, iter_11_1 in ipairs(CharacterEnum.BaseAttrIdList) do
			local var_11_1 = HeroConfig.instance:getHeroAttributeCO(iter_11_1)

			arg_11_0._attributevalues[iter_11_0].name.text = var_11_1.name
			arg_11_0._attributevalues[iter_11_0].value.text = var_11_0[iter_11_1]

			CharacterController.instance:SetAttriIcon(arg_11_0._attributevalues[iter_11_0].icon, iter_11_1)
		end
	end
end

function var_0_0._refreshPassiveSkill(arg_12_0)
	if not arg_12_0._heroMO then
		return
	end

	local var_12_0 = SkillConfig.instance:getpassiveskillsCO(arg_12_0._heroMO.heroId)
	local var_12_1 = var_12_0[1].skillPassive
	local var_12_2 = lua_skill.configDict[var_12_1]

	if not var_12_2 then
		logError("找不到角色被动技能, skillId: " .. tostring(var_12_1))
	else
		arg_12_0._txtpassivename.text = var_12_2.name
	end

	for iter_12_0 = 1, #var_12_0 do
		local var_12_3 = CharacterModel.instance:isPassiveUnlockByHeroMo(arg_12_0._heroMO, iter_12_0)

		gohelper.setActive(arg_12_0._passiveskillitems[iter_12_0].on, var_12_3)
		gohelper.setActive(arg_12_0._passiveskillitems[iter_12_0].off, not var_12_3)
		gohelper.setActive(arg_12_0._passiveskillitems[iter_12_0].go, true)
	end

	for iter_12_1 = #var_12_0 + 1, #arg_12_0._passiveskillitems do
		gohelper.setActive(arg_12_0._passiveskillitems[iter_12_1].go, false)
	end
end

function var_0_0._refreshSkill(arg_13_0)
	arg_13_0._skillContainer:onUpdateMO(arg_13_0._heroMO and arg_13_0._heroMO.heroId, false, arg_13_0._heroMO)
end

function var_0_0._refreshBtnIcon(arg_14_0)
	local var_14_0 = CharacterModel.instance:getRankState()
	local var_14_1 = CharacterModel.instance:getBtnTag(CharacterEnum.FilterType.HeroGroup)

	gohelper.setActive(arg_14_0._lvBtns[1], var_14_1 ~= 1)
	gohelper.setActive(arg_14_0._lvBtns[2], var_14_1 == 1)
	gohelper.setActive(arg_14_0._rareBtns[1], var_14_1 ~= 2)
	gohelper.setActive(arg_14_0._rareBtns[2], var_14_1 == 2)

	local var_14_2 = false

	for iter_14_0, iter_14_1 in pairs(arg_14_0._selectDmgs) do
		if iter_14_1 then
			var_14_2 = true
		end
	end

	for iter_14_2, iter_14_3 in pairs(arg_14_0._selectAttrs) do
		if iter_14_3 then
			var_14_2 = true
		end
	end

	gohelper.setActive(arg_14_0._classifyBtns[1], not var_14_2)
	gohelper.setActive(arg_14_0._classifyBtns[2], var_14_2)
	transformhelper.setLocalScale(arg_14_0._lvArrow[1], 1, var_14_0[1], 1)
	transformhelper.setLocalScale(arg_14_0._lvArrow[2], 1, var_14_0[1], 1)
	transformhelper.setLocalScale(arg_14_0._rareArrow[1], 1, var_14_0[2], 1)
	transformhelper.setLocalScale(arg_14_0._rareArrow[2], 1, var_14_0[2], 1)
end

function var_0_0._btnattributeOnClick(arg_15_0)
	if arg_15_0._heroMO then
		local var_15_0 = {}

		var_15_0.tag = "attribute"
		var_15_0.heroid = arg_15_0._heroMO.heroId
		var_15_0.equips = arg_15_0._equips
		var_15_0.showExtraAttr = true
		var_15_0.fromHeroGroupEditView = true

		CharacterController.instance:openCharacterTipView(var_15_0)
	end
end

function var_0_0._btncharacterOnClick(arg_16_0)
	if arg_16_0._heroMO then
		local var_16_0 = {}

		if arg_16_0._isShowQuickEdit then
			var_16_0 = Season123HeroGroupQuickEditModel.instance:getList()
		else
			var_16_0 = Season123HeroGroupEditModel.instance:getList()
		end

		if arg_16_0._heroMO:isOtherPlayerHero() then
			local var_16_1 = Season123HeroGroupEditModel.instance:getEquipMOByHeroUid(arg_16_0._heroMO.uid)

			if var_16_1 then
				arg_16_0._heroMO:setOtherPlayerEquipMo(var_16_1)
			end
		end

		CharacterController.instance:openCharacterView(arg_16_0._heroMO, var_16_0)
	end
end

function var_0_0._btnpassiveskillOnClick(arg_17_0)
	if not arg_17_0._heroMO then
		return
	end

	local var_17_0 = {}

	var_17_0.tag = "passiveskill"
	var_17_0.heroid = arg_17_0._heroMO.heroId
	var_17_0.tipPos = Vector2.New(851, -59)
	var_17_0.buffTipsX = 1603
	var_17_0.anchorParams = {
		Vector2.New(0, 0.5),
		Vector2.New(0, 0.5)
	}

	CharacterController.instance:openCharacterTipView(var_17_0)
end

function var_0_0._refreshFilterView(arg_18_0)
	for iter_18_0 = 1, 2 do
		gohelper.setActive(arg_18_0._dmgUnselects[iter_18_0], not arg_18_0._selectDmgs[iter_18_0])
		gohelper.setActive(arg_18_0._dmgSelects[iter_18_0], arg_18_0._selectDmgs[iter_18_0])
	end

	for iter_18_1 = 1, 6 do
		gohelper.setActive(arg_18_0._attrUnselects[iter_18_1], not arg_18_0._selectAttrs[iter_18_1])
		gohelper.setActive(arg_18_0._attrSelects[iter_18_1], arg_18_0._selectAttrs[iter_18_1])
	end

	for iter_18_2 = 1, 6 do
		gohelper.setActive(arg_18_0._locationUnselects[iter_18_2], not arg_18_0._selectLocations[iter_18_2])
		gohelper.setActive(arg_18_0._locationSelects[iter_18_2], arg_18_0._selectLocations[iter_18_2])
	end
end

function var_0_0.refreshHeroListByFilter(arg_19_0)
	local var_19_0 = {}

	for iter_19_0 = 1, 2 do
		if arg_19_0._selectDmgs[iter_19_0] then
			table.insert(var_19_0, iter_19_0)
		end
	end

	local var_19_1 = {}

	for iter_19_1 = 1, 6 do
		if arg_19_0._selectAttrs[iter_19_1] then
			table.insert(var_19_1, iter_19_1)
		end
	end

	local var_19_2 = {}

	for iter_19_2 = 1, 6 do
		if arg_19_0._selectLocations[iter_19_2] then
			table.insert(var_19_2, iter_19_2)
		end
	end

	if #var_19_0 == 0 then
		var_19_0 = {
			1,
			2
		}
	end

	if #var_19_1 == 0 then
		var_19_1 = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	if #var_19_2 == 0 then
		var_19_2 = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	local var_19_3 = {
		dmgs = var_19_0,
		careers = var_19_1,
		locations = var_19_2
	}

	CharacterModel.instance:filterCardListByDmgAndCareer(var_19_3, false, CharacterEnum.FilterType.HeroGroup)
	arg_19_0:_refreshBtnIcon()
	Season123PickHeroController.instance:updateFilter()
end

function var_0_0._onAttributeChanged(arg_20_0, arg_20_1, arg_20_2)
	CharacterModel.instance:setFakeLevel(arg_20_2, arg_20_1)
end

function var_0_0._showCharacterRankUpView(arg_21_0, arg_21_1)
	arg_21_1()
end

function var_0_0._attrBtnOnClick(arg_22_0, arg_22_1)
	arg_22_0._selectAttrs[arg_22_1] = not arg_22_0._selectAttrs[arg_22_1]

	arg_22_0:_refreshFilterView()
end

function var_0_0._dmgBtnOnClick(arg_23_0, arg_23_1)
	if not arg_23_0._selectDmgs[arg_23_1] then
		arg_23_0._selectDmgs[3 - arg_23_1] = arg_23_0._selectDmgs[arg_23_1]
	end

	arg_23_0._selectDmgs[arg_23_1] = not arg_23_0._selectDmgs[arg_23_1]

	arg_23_0:_refreshFilterView()
end

function var_0_0._locationBtnOnClick(arg_24_0, arg_24_1)
	arg_24_0._selectLocations[arg_24_1] = not arg_24_0._selectLocations[arg_24_1]

	arg_24_0:_refreshFilterView()
end

function var_0_0._btncloseFilterViewOnClick(arg_25_0)
	arg_25_0._selectDmgs = LuaUtil.deepCopy(arg_25_0._curDmgs)
	arg_25_0._selectAttrs = LuaUtil.deepCopy(arg_25_0._curAttrs)
	arg_25_0._selectLocations = LuaUtil.deepCopy(arg_25_0._curLocations)

	arg_25_0:_refreshBtnIcon()
	gohelper.setActive(arg_25_0._gosearchfilter, false)
end

function var_0_0._btnclassifyOnClick(arg_26_0)
	gohelper.setActive(arg_26_0._gosearchfilter, true)
	arg_26_0:_refreshFilterView()
end

function var_0_0._btnresetOnClick(arg_27_0)
	for iter_27_0 = 1, 6 do
		arg_27_0._selectAttrs[iter_27_0] = false
	end

	for iter_27_1 = 1, 2 do
		arg_27_0._selectDmgs[iter_27_1] = false
	end

	for iter_27_2 = 1, 6 do
		arg_27_0._selectLocations[iter_27_2] = false
	end

	arg_27_0:_refreshBtnIcon()
	arg_27_0:_refreshFilterView()
end

function var_0_0._btnokOnClick(arg_28_0)
	gohelper.setActive(arg_28_0._gosearchfilter, false)
	arg_28_0:refreshHeroListByFilter()

	arg_28_0._curDmgs = LuaUtil.deepCopy(arg_28_0._selectDmgs)
	arg_28_0._curAttrs = LuaUtil.deepCopy(arg_28_0._selectAttrs)
	arg_28_0._curLocations = LuaUtil.deepCopy(arg_28_0._selectLocations)

	ViewMgr.instance:closeView(ViewName.CharacterLevelUpView)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
end

function var_0_0._btnexskillrankOnClick(arg_29_0)
	CharacterModel.instance:setCardListByExSkill(false, CharacterEnum.FilterType.HeroGroup)
	Season123PickHeroController.instance:updateFilter()
	arg_29_0:_refreshBtnIcon()
end

function var_0_0._btnlvrankOnClick(arg_30_0)
	CharacterModel.instance:setCardListByLevel(false, CharacterEnum.FilterType.HeroGroup)
	Season123PickHeroController.instance:updateFilter()
	arg_30_0:_refreshBtnIcon()
end

function var_0_0._btnrarerankOnClick(arg_31_0)
	CharacterModel.instance:setCardListByRare(false, CharacterEnum.FilterType.HeroGroup)
	Season123PickHeroController.instance:updateFilter()
	arg_31_0:_refreshBtnIcon()
end

return var_0_0
