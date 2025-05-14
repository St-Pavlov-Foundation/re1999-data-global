module("modules.logic.seasonver.act123.view.Season123HeroGroupEditView", package.seeall)

local var_0_0 = class("Season123HeroGroupEditView", BaseView)

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
	arg_1_0._gobtncharacter = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/level/#btn_character")
	arg_1_0._btnassistcharacter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "characterinfo/#go_characterinfo/level/#btn_assistcharacter")
	arg_1_0._gobtnassistcharacter = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/level/#btn_assistcharacter")
	arg_1_0._btnattribute = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "characterinfo/#go_characterinfo/attribute/#btn_attribute")
	arg_1_0._goattribute = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/attribute/#go_attribute")
	arg_1_0._goskill = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/#go_skill")
	arg_1_0._btnpassiveskill = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "characterinfo/#go_characterinfo/passiveskill/#btn_passiveskill")
	arg_1_0._txtpassivename = gohelper.findChildText(arg_1_0.viewGO, "characterinfo/#go_characterinfo/passiveskill/bg/#txt_passivename")
	arg_1_0._gopassiveskills = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/passiveskill/#go_passiveskills")
	arg_1_0._gorolecontainer = gohelper.findChild(arg_1_0.viewGO, "#go_rolecontainer")
	arg_1_0._scrollcard = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_rolecontainer/#scroll_card")
	arg_1_0._goScrollContent = gohelper.findChild(arg_1_0.viewGO, "#go_rolecontainer/#scroll_card/scrollcontent")
	arg_1_0._scrollquickedit = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_rolecontainer/#scroll_quickedit")
	arg_1_0._gorolesort = gohelper.findChild(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort")
	arg_1_0._btnlvrank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_lvrank")
	arg_1_0._btnrarerank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_rarerank")
	arg_1_0._btnexskillrank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_exskillrank")
	arg_1_0._btnclassify = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_classify")
	arg_1_0._btnquickedit = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_quickedit")
	arg_1_0._goexarrow = gohelper.findChild(arg_1_0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_exskillrank/#go_exarrow")
	arg_1_0._gosearchfilter = gohelper.findChild(arg_1_0.viewGO, "#go_searchfilter")
	arg_1_0._btnclosefilterview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_searchfilter/#btn_closefilterview")
	arg_1_0._godmgitem = gohelper.findChild(arg_1_0.viewGO, "#go_searchfilter/container/dmgContainer/#go_dmgitem")
	arg_1_0._goattritem = gohelper.findChild(arg_1_0.viewGO, "#go_searchfilter/container/attrContainer/#go_attritem")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_searchfilter/container/#btn_reset")
	arg_1_0._btnok = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_searchfilter/container/#btn_ok")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ops/#btn_confirm")
	arg_1_0._btncancel = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_ops/#btn_cancel")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnlvrank:AddClickListener(arg_2_0._btnlvrankOnClick, arg_2_0)
	arg_2_0._btnrarerank:AddClickListener(arg_2_0._btnrarerankOnClick, arg_2_0)
	arg_2_0._btnexskillrank:AddClickListener(arg_2_0._btnexskillrankOnClick, arg_2_0)
	arg_2_0._btnclassify:AddClickListener(arg_2_0._btnclassifyOnClick, arg_2_0)
	arg_2_0._btncharacter:AddClickListener(arg_2_0._btncharacterOnClick, arg_2_0)
	arg_2_0._btnassistcharacter:AddClickListener(arg_2_0._btncharacterOnClick, arg_2_0)
	arg_2_0._btnattribute:AddClickListener(arg_2_0._btnattributeOnClick, arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
	arg_2_0._btncancel:AddClickListener(arg_2_0._btncancelOnClick, arg_2_0)
	arg_2_0._btnpassiveskill:AddClickListener(arg_2_0._btnpassiveskillOnClick, arg_2_0)
	arg_2_0._btnquickedit:AddClickListener(arg_2_0._btnquickeditOnClick, arg_2_0)
	arg_2_0._btnclosefilterview:AddClickListener(arg_2_0._btncloseFilterViewOnClick, arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
	arg_2_0._btnok:AddClickListener(arg_2_0._btnokOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnlvrank:RemoveClickListener()
	arg_3_0._btnrarerank:RemoveClickListener()
	arg_3_0._btnexskillrank:RemoveClickListener()
	arg_3_0._btnclassify:RemoveClickListener()
	arg_3_0._btncharacter:RemoveClickListener()
	arg_3_0._btnassistcharacter:RemoveClickListener()
	arg_3_0._btnattribute:RemoveClickListener()
	arg_3_0._btnconfirm:RemoveClickListener()
	arg_3_0._btncancel:RemoveClickListener()
	arg_3_0._btnpassiveskill:RemoveClickListener()
	arg_3_0._btnquickedit:RemoveClickListener()
	arg_3_0._btnclosefilterview:RemoveClickListener()
	arg_3_0._btnreset:RemoveClickListener()
	arg_3_0._btnok:RemoveClickListener()
end

function var_0_0._btncloseFilterViewOnClick(arg_4_0)
	arg_4_0._selectDmgs = LuaUtil.deepCopy(arg_4_0._curDmgs)
	arg_4_0._selectAttrs = LuaUtil.deepCopy(arg_4_0._curAttrs)
	arg_4_0._selectLocations = LuaUtil.deepCopy(arg_4_0._curLocations)

	arg_4_0:_refreshBtnIcon()
	gohelper.setActive(arg_4_0._gosearchfilter, false)
end

function var_0_0._btnclassifyOnClick(arg_5_0)
	gohelper.setActive(arg_5_0._gosearchfilter, true)
	arg_5_0:_refreshFilterView()
end

function var_0_0._btnresetOnClick(arg_6_0)
	for iter_6_0 = 1, 6 do
		arg_6_0._selectAttrs[iter_6_0] = false
	end

	for iter_6_1 = 1, 2 do
		arg_6_0._selectDmgs[iter_6_1] = false
	end

	for iter_6_2 = 1, 6 do
		arg_6_0._selectLocations[iter_6_2] = false
	end

	arg_6_0:_refreshBtnIcon()
	arg_6_0:_refreshFilterView()
end

function var_0_0._btnokOnClick(arg_7_0)
	gohelper.setActive(arg_7_0._gosearchfilter, false)

	local var_7_0 = {}

	for iter_7_0 = 1, 2 do
		if arg_7_0._selectDmgs[iter_7_0] then
			table.insert(var_7_0, iter_7_0)
		end
	end

	local var_7_1 = {}

	for iter_7_1 = 1, 6 do
		if arg_7_0._selectAttrs[iter_7_1] then
			table.insert(var_7_1, iter_7_1)
		end
	end

	local var_7_2 = {}

	for iter_7_2 = 1, 6 do
		if arg_7_0._selectLocations[iter_7_2] then
			table.insert(var_7_2, iter_7_2)
		end
	end

	if #var_7_0 == 0 then
		var_7_0 = {
			1,
			2
		}
	end

	if #var_7_1 == 0 then
		var_7_1 = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	if #var_7_2 == 0 then
		var_7_2 = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	local var_7_3, var_7_4 = transformhelper.getLocalPos(arg_7_0._goScrollContent.transform)

	transformhelper.setLocalPosXY(arg_7_0._goScrollContent.transform, var_7_3, arg_7_0._initScrollContentPosY)

	local var_7_5 = {
		dmgs = var_7_0,
		careers = var_7_1,
		locations = var_7_2
	}

	CharacterModel.instance:filterCardListByDmgAndCareer(var_7_5, false, CharacterEnum.FilterType.HeroGroup)
	HeroGroupTrialModel.instance:setFilter(var_7_0, var_7_1)

	arg_7_0._curDmgs = LuaUtil.deepCopy(arg_7_0._selectDmgs)
	arg_7_0._curAttrs = LuaUtil.deepCopy(arg_7_0._selectAttrs)
	arg_7_0._curLocations = LuaUtil.deepCopy(arg_7_0._selectLocations)

	arg_7_0:_refreshBtnIcon()
	arg_7_0:_refreshCurScrollBySort()
	ViewMgr.instance:closeView(ViewName.CharacterLevelUpView)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
end

function var_0_0._btnpassiveskillOnClick(arg_8_0)
	if not arg_8_0._heroMO then
		return
	end

	local var_8_0 = {}

	var_8_0.tag = "passiveskill"
	var_8_0.heroid = arg_8_0._heroMO.heroId
	var_8_0.heroMo = arg_8_0._heroMO
	var_8_0.tipPos = Vector2.New(851, -59)
	var_8_0.buffTipsX = 1603
	var_8_0.anchorParams = {
		Vector2.New(0, 0.5),
		Vector2.New(0, 0.5)
	}

	CharacterController.instance:openCharacterTipView(var_8_0)
end

function var_0_0._btnconfirmOnClick(arg_9_0)
	if arg_9_0._isShowQuickEdit then
		arg_9_0:_saveQuickGroupInfo()
		arg_9_0:closeThis()

		return
	end

	if not arg_9_0:_normalEditHasChange() then
		arg_9_0:closeThis()

		return
	end

	local var_9_0 = HeroSingleGroupModel.instance:getById(arg_9_0._singleGroupMOId)

	if var_9_0.trialPos then
		GameFacade.showToast(ToastEnum.TrialCantTakeOff)

		return
	end

	if arg_9_0._heroMO then
		if arg_9_0._heroMO.isPosLock then
			GameFacade.showToast(ToastEnum.TrialCantTakeOff)

			return
		end

		if arg_9_0._heroMO:isTrial() and not HeroSingleGroupModel.instance:isInGroup(arg_9_0._heroMO.uid) and (var_9_0:isEmpty() or not var_9_0.trial) and HeroGroupEditListModel.instance:isTrialLimit() then
			GameFacade.showToast(ToastEnum.TrialJoinLimit, HeroGroupTrialModel.instance:getLimitNum())

			return
		end

		local var_9_1, var_9_2 = HeroSingleGroupModel.instance:hasHeroUids(arg_9_0._heroMO.uid, arg_9_0._singleGroupMOId)

		if var_9_1 then
			HeroSingleGroupModel.instance:removeFrom(var_9_2)
			HeroSingleGroupModel.instance:addTo(arg_9_0._heroMO.uid, arg_9_0._singleGroupMOId)

			if arg_9_0._heroMO:isTrial() then
				var_9_0:setTrial(arg_9_0._heroMO.trialCo.id, arg_9_0._heroMO.trialCo.trialTemplate)
			else
				var_9_0:setTrial()
			end

			FightAudioMgr.instance:playHeroVoiceRandom(arg_9_0._heroMO.heroId, CharacterEnum.VoiceType.HeroGroup)
			arg_9_0:_saveCurGroupInfo()
			arg_9_0:closeThis()

			return
		end

		if HeroSingleGroupModel.instance:isAidConflict(arg_9_0._heroMO.heroId) then
			GameFacade.showToast(ToastEnum.HeroIsAidConflict)

			return
		end

		HeroSingleGroupModel.instance:addTo(arg_9_0._heroMO.uid, arg_9_0._singleGroupMOId)

		if arg_9_0._heroMO:isTrial() then
			var_9_0:setTrial(arg_9_0._heroMO.trialCo.id, arg_9_0._heroMO.trialCo.trialTemplate)
		else
			var_9_0:setTrial()
		end

		FightAudioMgr.instance:playHeroVoiceRandom(arg_9_0._heroMO.heroId, CharacterEnum.VoiceType.HeroGroup)
		arg_9_0:_saveCurGroupInfo()
		arg_9_0:closeThis()
	else
		HeroSingleGroupModel.instance:removeFrom(arg_9_0._singleGroupMOId)
		arg_9_0:_saveCurGroupInfo()
		arg_9_0:closeThis()
	end
end

function var_0_0._btncancelOnClick(arg_10_0)
	arg_10_0:closeThis()
end

function var_0_0._btncharacterOnClick(arg_11_0)
	if arg_11_0._heroMO then
		local var_11_0 = {}

		if arg_11_0._isShowQuickEdit then
			var_11_0 = Season123HeroGroupQuickEditModel.instance:getList()
		else
			var_11_0 = Season123HeroGroupEditModel.instance:getList()
		end

		if arg_11_0._heroMO:isOtherPlayerHero() then
			local var_11_1 = Season123HeroGroupEditModel.instance:getEquipMOByHeroUid(arg_11_0._heroMO.uid)

			if var_11_1 then
				arg_11_0._heroMO:setOtherPlayerEquipMo(var_11_1)
			end
		end

		CharacterController.instance:openCharacterView(arg_11_0._heroMO, var_11_0)
	end
end

function var_0_0._btnattributeOnClick(arg_12_0)
	if arg_12_0._heroMO then
		local var_12_0 = HeroGroupTrialModel.instance:getById(arg_12_0._originalHeroUid)
		local var_12_1

		if var_12_0 then
			var_12_1 = var_12_0.trialEquipMo
		end

		local var_12_2 = {}

		var_12_2.tag = "attribute"
		var_12_2.heroid = arg_12_0._heroMO.heroId
		var_12_2.equips = arg_12_0._equips
		var_12_2.showExtraAttr = true
		var_12_2.fromHeroGroupEditView = true
		var_12_2.heroMo = arg_12_0._heroMO
		var_12_2.trialEquipMo = var_12_1
		var_12_2.isBalance = HeroGroupBalanceHelper.getIsBalanceMode() and not arg_12_0._heroMO:isTrial()

		CharacterController.instance:openCharacterTipView(var_12_2)
	end
end

function var_0_0._btnexskillrankOnClick(arg_13_0)
	local var_13_0, var_13_1 = transformhelper.getLocalPos(arg_13_0._goScrollContent.transform)

	transformhelper.setLocalPosXY(arg_13_0._goScrollContent.transform, var_13_0, arg_13_0._initScrollContentPosY)
	CharacterModel.instance:setCardListByExSkill(false, CharacterEnum.FilterType.HeroGroup)
	arg_13_0:_refreshCurScrollBySort()
	arg_13_0:_refreshBtnIcon()
end

function var_0_0._btnlvrankOnClick(arg_14_0)
	local var_14_0, var_14_1 = transformhelper.getLocalPos(arg_14_0._goScrollContent.transform)

	transformhelper.setLocalPosXY(arg_14_0._goScrollContent.transform, var_14_0, arg_14_0._initScrollContentPosY)
	CharacterModel.instance:setCardListByLevel(false, CharacterEnum.FilterType.HeroGroup)
	arg_14_0:_refreshCurScrollBySort()
	arg_14_0:_refreshBtnIcon()
end

function var_0_0._btnrarerankOnClick(arg_15_0)
	local var_15_0, var_15_1 = transformhelper.getLocalPos(arg_15_0._goScrollContent.transform)

	transformhelper.setLocalPosXY(arg_15_0._goScrollContent.transform, var_15_0, arg_15_0._initScrollContentPosY)
	CharacterModel.instance:setCardListByRare(false, CharacterEnum.FilterType.HeroGroup)
	arg_15_0:_refreshCurScrollBySort()
	arg_15_0:_refreshBtnIcon()
end

function var_0_0._btnquickeditOnClick(arg_16_0)
	arg_16_0._isShowQuickEdit = not arg_16_0._isShowQuickEdit

	arg_16_0:_refreshBtnIcon()
	arg_16_0:_refreshEditMode()

	if arg_16_0._isShowQuickEdit then
		arg_16_0:_onHeroItemClick(nil)
		Season123HeroGroupQuickEditModel.instance:cancelAllSelected()
		Season123HeroGroupQuickEditModel.instance:copyQuickEditCardList()

		local var_16_0 = Season123HeroGroupQuickEditModel.instance:getById(arg_16_0._originalHeroUid)

		if var_16_0 then
			local var_16_1 = Season123HeroGroupQuickEditModel.instance:getIndex(var_16_0)

			Season123HeroGroupQuickEditModel.instance:selectCell(var_16_1, true)
		end
	else
		arg_16_0:_saveQuickGroupInfo()
		arg_16_0:_onHeroItemClick(nil)
		Season123HeroGroupEditModel.instance:cancelAllSelected()

		local var_16_2 = HeroSingleGroupModel.instance:getHeroUid(arg_16_0._singleGroupMOId)

		if var_16_2 ~= "0" then
			local var_16_3 = Season123HeroGroupEditModel.instance:getById(var_16_2)
			local var_16_4 = Season123HeroGroupEditModel.instance:getIndex(var_16_3)

			Season123HeroGroupEditModel.instance:selectCell(var_16_4, true)
		end

		Season123HeroGroupEditModel.instance:copyCharacterCardList()
	end
end

function var_0_0._attrBtnOnClick(arg_17_0, arg_17_1)
	arg_17_0._selectAttrs[arg_17_1] = not arg_17_0._selectAttrs[arg_17_1]

	arg_17_0:_refreshFilterView()
end

function var_0_0._dmgBtnOnClick(arg_18_0, arg_18_1)
	if not arg_18_0._selectDmgs[arg_18_1] then
		arg_18_0._selectDmgs[3 - arg_18_1] = arg_18_0._selectDmgs[arg_18_1]
	end

	arg_18_0._selectDmgs[arg_18_1] = not arg_18_0._selectDmgs[arg_18_1]

	arg_18_0:_refreshFilterView()
end

function var_0_0._locationBtnOnClick(arg_19_0, arg_19_1)
	arg_19_0._selectLocations[arg_19_1] = not arg_19_0._selectLocations[arg_19_1]

	arg_19_0:_refreshFilterView()
end

function var_0_0._onHeroItemClick(arg_20_0, arg_20_1)
	arg_20_0._heroMO = arg_20_1

	arg_20_0:_refreshCharacterInfo()
end

function var_0_0._refreshCharacterInfo(arg_21_0)
	if arg_21_0._heroMO then
		gohelper.setActive(arg_21_0._gononecharacter, false)
		gohelper.setActive(arg_21_0._gocharacterinfo, true)
		arg_21_0:_refreshSkill()
		arg_21_0:_refreshMainInfo()
		arg_21_0:_refreshAttribute()
		arg_21_0:_refreshPassiveSkill()
	else
		gohelper.setActive(arg_21_0._gononecharacter, true)
		gohelper.setActive(arg_21_0._gocharacterinfo, false)
	end
end

function var_0_0._refreshMainInfo(arg_22_0)
	if arg_22_0._heroMO then
		UISpriteSetMgr.instance:setCommonSprite(arg_22_0._imagecareericon, "sx_biandui_" .. tostring(arg_22_0._heroMO.config.career))
		UISpriteSetMgr.instance:setCommonSprite(arg_22_0._imagedmgtype, "dmgtype" .. tostring(arg_22_0._heroMO.config.dmgType))

		arg_22_0._txtname.text = arg_22_0._heroMO.config.name
		arg_22_0._txtnameen.text = arg_22_0._heroMO.config.nameEng

		local var_22_0 = CharacterModel.instance:getrankEffects(arg_22_0._heroMO.heroId, arg_22_0._heroMO.rank)[1]
		local var_22_1 = HeroConfig.instance:getShowLevel(arg_22_0._heroMO.level)
		local var_22_2 = HeroConfig.instance:getShowLevel(var_22_0)

		arg_22_0._txtlevel.text = tostring(var_22_1)
		arg_22_0._txtlevelmax.text = string.format("/%d", var_22_2)

		local var_22_3 = {}

		if not string.nilorempty(arg_22_0._heroMO.config.battleTag) then
			var_22_3 = string.split(arg_22_0._heroMO.config.battleTag, "#")
		end

		for iter_22_0 = 1, #var_22_3 do
			local var_22_4 = arg_22_0._careerGOs[iter_22_0]

			if not var_22_4 then
				var_22_4 = arg_22_0:getUserDataTb_()
				var_22_4.go = gohelper.cloneInPlace(arg_22_0._gospecialitem, "item" .. iter_22_0)
				var_22_4.textfour = gohelper.findChildText(var_22_4.go, "#go_fourword/name")
				var_22_4.textthree = gohelper.findChildText(var_22_4.go, "#go_threeword/name")
				var_22_4.texttwo = gohelper.findChildText(var_22_4.go, "#go_twoword/name")
				var_22_4.containerfour = gohelper.findChild(var_22_4.go, "#go_fourword")
				var_22_4.containerthree = gohelper.findChild(var_22_4.go, "#go_threeword")
				var_22_4.containertwo = gohelper.findChild(var_22_4.go, "#go_twoword")

				table.insert(arg_22_0._careerGOs, var_22_4)
			end

			local var_22_5 = HeroConfig.instance:getBattleTagConfigCO(var_22_3[iter_22_0]).tagName
			local var_22_6 = GameUtil.utf8len(var_22_5)

			gohelper.setActive(var_22_4.containertwo, var_22_6 <= 2)
			gohelper.setActive(var_22_4.containerthree, var_22_6 == 3)
			gohelper.setActive(var_22_4.containerfour, var_22_6 >= 4)

			if var_22_6 <= 2 then
				var_22_4.texttwo.text = var_22_5
			elseif var_22_6 == 3 then
				var_22_4.textthree.text = var_22_5
			else
				var_22_4.textfour.text = var_22_5
			end

			gohelper.setActive(var_22_4.go, true)
		end

		for iter_22_1 = #var_22_3 + 1, #arg_22_0._careerGOs do
			gohelper.setActive(arg_22_0._careerGOs[iter_22_1].go, false)
		end

		local var_22_7 = arg_22_0._heroMO:isOwnHero()

		gohelper.setActive(arg_22_0._gobtncharacter, var_22_7)
		gohelper.setActive(arg_22_0._gobtnassistcharacter, not var_22_7)
	end
end

function var_0_0._refreshAttribute(arg_23_0)
	if arg_23_0._heroMO then
		local var_23_0 = arg_23_0._heroMO:getTotalBaseAttrDict(arg_23_0._equips)

		for iter_23_0, iter_23_1 in ipairs(CharacterEnum.BaseAttrIdList) do
			local var_23_1 = HeroConfig.instance:getHeroAttributeCO(iter_23_1)

			arg_23_0._attributevalues[iter_23_0].name.text = var_23_1.name
			arg_23_0._attributevalues[iter_23_0].value.text = var_23_0[iter_23_1]

			CharacterController.instance:SetAttriIcon(arg_23_0._attributevalues[iter_23_0].icon, iter_23_1)
		end
	end
end

function var_0_0._refreshPassiveSkill(arg_24_0)
	if not arg_24_0._heroMO then
		return
	end

	local var_24_0 = SkillConfig.instance:getpassiveskillsCO(arg_24_0._heroMO.heroId)
	local var_24_1 = var_24_0[1].skillPassive
	local var_24_2 = lua_skill.configDict[var_24_1]

	if not var_24_2 then
		logError("找不到角色被动技能, skillId: " .. tostring(var_24_1))
	else
		arg_24_0._txtpassivename.text = var_24_2.name
	end

	for iter_24_0 = 1, #var_24_0 do
		local var_24_3 = CharacterModel.instance:isPassiveUnlockByHeroMo(arg_24_0._heroMO, iter_24_0)

		gohelper.setActive(arg_24_0._passiveskillitems[iter_24_0].on, var_24_3)
		gohelper.setActive(arg_24_0._passiveskillitems[iter_24_0].off, not var_24_3)
		gohelper.setActive(arg_24_0._passiveskillitems[iter_24_0].go, true)
	end

	for iter_24_1 = #var_24_0 + 1, #arg_24_0._passiveskillitems do
		gohelper.setActive(arg_24_0._passiveskillitems[iter_24_1].go, false)
	end
end

function var_0_0._refreshSkill(arg_25_0)
	arg_25_0._skillContainer:onUpdateMO(arg_25_0._heroMO and arg_25_0._heroMO.heroId, false, arg_25_0._heroMO)
end

function var_0_0._refreshBtnIcon(arg_26_0)
	local var_26_0 = CharacterModel.instance:getRankState()
	local var_26_1 = CharacterModel.instance:getBtnTag(CharacterEnum.FilterType.HeroGroup)

	gohelper.setActive(arg_26_0._lvBtns[1], var_26_1 ~= 1)
	gohelper.setActive(arg_26_0._lvBtns[2], var_26_1 == 1)
	gohelper.setActive(arg_26_0._rareBtns[1], var_26_1 ~= 2)
	gohelper.setActive(arg_26_0._rareBtns[2], var_26_1 == 2)

	local var_26_2 = false

	for iter_26_0, iter_26_1 in pairs(arg_26_0._selectDmgs) do
		if iter_26_1 then
			var_26_2 = true
		end
	end

	for iter_26_2, iter_26_3 in pairs(arg_26_0._selectAttrs) do
		if iter_26_3 then
			var_26_2 = true
		end
	end

	gohelper.setActive(arg_26_0._classifyBtns[1], not var_26_2)
	gohelper.setActive(arg_26_0._classifyBtns[2], var_26_2)
	transformhelper.setLocalScale(arg_26_0._lvArrow[1], 1, var_26_0[1], 1)
	transformhelper.setLocalScale(arg_26_0._lvArrow[2], 1, var_26_0[1], 1)
	transformhelper.setLocalScale(arg_26_0._rareArrow[1], 1, var_26_0[2], 1)
	transformhelper.setLocalScale(arg_26_0._rareArrow[2], 1, var_26_0[2], 1)
end

function var_0_0._refreshFilterView(arg_27_0)
	for iter_27_0 = 1, 2 do
		gohelper.setActive(arg_27_0._dmgUnselects[iter_27_0], not arg_27_0._selectDmgs[iter_27_0])
		gohelper.setActive(arg_27_0._dmgSelects[iter_27_0], arg_27_0._selectDmgs[iter_27_0])
	end

	for iter_27_1 = 1, 6 do
		gohelper.setActive(arg_27_0._attrUnselects[iter_27_1], not arg_27_0._selectAttrs[iter_27_1])
		gohelper.setActive(arg_27_0._attrSelects[iter_27_1], arg_27_0._selectAttrs[iter_27_1])
	end

	for iter_27_2 = 1, 6 do
		gohelper.setActive(arg_27_0._locationUnselects[iter_27_2], not arg_27_0._selectLocations[iter_27_2])
		gohelper.setActive(arg_27_0._locationSelects[iter_27_2], arg_27_0._selectLocations[iter_27_2])
	end
end

function var_0_0._updateHeroList(arg_28_0)
	local var_28_0 = {}

	for iter_28_0 = 1, 2 do
		if arg_28_0._selectDmgs[iter_28_0] then
			table.insert(var_28_0, iter_28_0)
		end
	end

	local var_28_1 = {}

	for iter_28_1 = 1, 6 do
		if arg_28_0._selectAttrs[iter_28_1] then
			table.insert(var_28_1, iter_28_1)
		end
	end

	local var_28_2 = {}

	for iter_28_2 = 1, 6 do
		if arg_28_0._selectLocations[iter_28_2] then
			table.insert(var_28_2, iter_28_2)
		end
	end

	if #var_28_0 == 0 then
		var_28_0 = {
			1,
			2
		}
	end

	if #var_28_1 == 0 then
		var_28_1 = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	if #var_28_2 == 0 then
		var_28_2 = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	local var_28_3 = {
		dmgs = var_28_0,
		careers = var_28_1,
		locations = var_28_2
	}

	CharacterModel.instance:filterCardListByDmgAndCareer(var_28_3, false, CharacterEnum.FilterType.HeroGroup)
	arg_28_0:_refreshBtnIcon()

	if arg_28_0._isShowQuickEdit then
		Season123HeroGroupQuickEditModel.instance:copyQuickEditCardList()
	else
		Season123HeroGroupEditModel.instance:copyCharacterCardList()
	end
end

function var_0_0.replaceSelectHeroDefaultEquip(arg_29_0)
	if arg_29_0._heroMO and arg_29_0._heroMO:hasDefaultEquip() then
		local var_29_0 = HeroGroupModel.instance:getCurGroupMO().equips

		for iter_29_0, iter_29_1 in pairs(var_29_0) do
			if iter_29_1.equipUid[1] == arg_29_0._heroMO.defaultEquipUid then
				iter_29_1.equipUid[1] = "0"

				break
			end
		end

		var_29_0[arg_29_0._singleGroupMOId - 1].equipUid[1] = arg_29_0._heroMO.defaultEquipUid
	end
end

function var_0_0._saveCurGroupInfo(arg_30_0)
	local var_30_0 = HeroSingleGroupModel.instance:getHeroUids()
	local var_30_1 = HeroGroupModel.instance:getCurGroupMO()

	arg_30_0:replaceSelectHeroDefaultEquip()

	local var_30_2 = Season123Model.instance:getActInfo(arg_30_0.viewParam.actId)

	if not var_30_2 then
		return
	end

	Season123HeroGroupController.instance:replaceHeroesDefaultEquip(var_30_0)

	var_30_1.heroList = var_30_0

	local var_30_3 = {
		groupIndex = var_30_2.heroGroupSnapshotSubId,
		heroGroup = var_30_1
	}

	HeroGroupModel.instance:setHeroGroupSnapshot(HeroGroupModel.instance.heroGroupType, DungeonModel.instance.curSendEpisodeId, true, var_30_3)
end

function var_0_0._saveQuickGroupInfo(arg_31_0)
	if Season123HeroGroupQuickEditModel.instance:getIsDirty() then
		local var_31_0 = Season123HeroGroupQuickEditModel.instance:getHeroUids()
		local var_31_1 = HeroGroupModel.instance:getCurGroupMO()

		Season123HeroGroupController.instance:replaceHeroesDefaultEquip(var_31_0)

		if HeroSingleGroupModel.instance:isTemp() then
			for iter_31_0 = 1, HeroGroupModel.instance:getBattleRoleNum() do
				local var_31_2 = var_31_0[iter_31_0]

				if var_31_2 ~= nil then
					HeroSingleGroupModel.instance:addTo(var_31_2, iter_31_0)
				end
			end

			HeroGroupModel.instance:replaceSingleGroup()
			HeroGroupModel.instance:replaceSingleGroupEquips()
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)

			return
		end

		var_31_1.heroList = var_31_0

		local var_31_3 = arg_31_0.viewParam.actId
		local var_31_4 = Season123Model.instance:getActInfo(var_31_3)

		if not var_31_4 then
			return
		end

		local var_31_5 = var_31_4.heroGroupSnapshotSubId
		local var_31_6 = {
			groupIndex = var_31_5,
			heroGroup = var_31_1
		}

		HeroGroupModel.instance:setHeroGroupSnapshot(HeroGroupModel.instance.heroGroupType, DungeonModel.instance.curSendEpisodeId, true, var_31_6)
	end
end

function var_0_0._onAttributeChanged(arg_32_0, arg_32_1, arg_32_2)
	CharacterModel.instance:setFakeLevel(arg_32_2, arg_32_1)
end

function var_0_0._normalEditHasChange(arg_33_0)
	return true
end

function var_0_0._refreshEditMode(arg_34_0)
	gohelper.setActive(arg_34_0._scrollquickedit.gameObject, arg_34_0._isShowQuickEdit)
	gohelper.setActive(arg_34_0._scrollcard.gameObject, not arg_34_0._isShowQuickEdit)
	gohelper.setActive(arg_34_0._goBtnEditQuickMode.gameObject, arg_34_0._isShowQuickEdit)
	gohelper.setActive(arg_34_0._goBtnEditNormalMode.gameObject, not arg_34_0._isShowQuickEdit)
end

function var_0_0._refreshCurScrollBySort(arg_35_0)
	if arg_35_0._isShowQuickEdit then
		if Season123HeroGroupQuickEditModel.instance:getIsDirty() then
			arg_35_0:_saveQuickGroupInfo()
		end

		local var_35_0 = arg_35_0._heroMO

		Season123HeroGroupQuickEditModel.instance:copyQuickEditCardList()

		if var_35_0 ~= arg_35_0._heroMO then
			Season123HeroGroupQuickEditModel.instance:cancelAllSelected()
		end
	else
		Season123HeroGroupEditModel.instance:copyCharacterCardList()
	end
end

function var_0_0._onGroupModify(arg_36_0)
	if arg_36_0._isShowQuickEdit then
		Season123HeroGroupQuickEditModel.instance:copyQuickEditCardList()
	else
		local var_36_0 = HeroSingleGroupModel.instance:getHeroUid(arg_36_0._singleGroupMOId)

		if arg_36_0._originalHeroUid ~= var_36_0 then
			arg_36_0._originalHeroUid = var_36_0

			Season123HeroGroupEditModel.instance:setParam(var_36_0, arg_36_0._adventure)
			arg_36_0:_onHeroItemClick(nil)
			Season123HeroGroupEditModel.instance:cancelAllSelected()

			local var_36_1 = Season123HeroGroupEditModel.instance:getById(var_36_0)
			local var_36_2 = Season123HeroGroupEditModel.instance:getIndex(var_36_1)

			Season123HeroGroupEditModel.instance:selectCell(var_36_2, true)
		end

		Season123HeroGroupEditModel.instance:copyCharacterCardList()
	end
end

function var_0_0._editableInitView(arg_37_0)
	gohelper.setActive(arg_37_0._gospecialitem, false)

	arg_37_0._careerGOs = {}
	arg_37_0._imgBg = gohelper.findChildSingleImage(arg_37_0.viewGO, "bg/bgimg")
	arg_37_0._simageredlight = gohelper.findChildSingleImage(arg_37_0.viewGO, "bg/#simage_redlight")

	arg_37_0._imgBg:LoadImage(ResUrl.getCommonViewBg("full/biandui_di"))
	arg_37_0._simageredlight:LoadImage(ResUrl.getHeroGroupBg("guang_027"))

	arg_37_0._lvBtns = arg_37_0:getUserDataTb_()
	arg_37_0._lvArrow = arg_37_0:getUserDataTb_()
	arg_37_0._rareBtns = arg_37_0:getUserDataTb_()
	arg_37_0._rareArrow = arg_37_0:getUserDataTb_()
	arg_37_0._classifyBtns = arg_37_0:getUserDataTb_()
	arg_37_0._selectDmgs = {}
	arg_37_0._dmgSelects = arg_37_0:getUserDataTb_()
	arg_37_0._dmgUnselects = arg_37_0:getUserDataTb_()
	arg_37_0._dmgBtnClicks = arg_37_0:getUserDataTb_()
	arg_37_0._selectAttrs = {}
	arg_37_0._attrSelects = arg_37_0:getUserDataTb_()
	arg_37_0._attrUnselects = arg_37_0:getUserDataTb_()
	arg_37_0._attrBtnClicks = arg_37_0:getUserDataTb_()
	arg_37_0._selectLocations = {}
	arg_37_0._locationSelects = arg_37_0:getUserDataTb_()
	arg_37_0._locationUnselects = arg_37_0:getUserDataTb_()
	arg_37_0._locationBtnClicks = arg_37_0:getUserDataTb_()
	arg_37_0._curDmgs = {}
	arg_37_0._curAttrs = {}
	arg_37_0._curLocations = {}

	for iter_37_0 = 1, 2 do
		arg_37_0._lvBtns[iter_37_0] = gohelper.findChild(arg_37_0._btnlvrank.gameObject, "btn" .. tostring(iter_37_0))
		arg_37_0._lvArrow[iter_37_0] = gohelper.findChild(arg_37_0._lvBtns[iter_37_0], "txt/arrow").transform
		arg_37_0._rareBtns[iter_37_0] = gohelper.findChild(arg_37_0._btnrarerank.gameObject, "btn" .. tostring(iter_37_0))
		arg_37_0._rareArrow[iter_37_0] = gohelper.findChild(arg_37_0._rareBtns[iter_37_0], "txt/arrow").transform
		arg_37_0._classifyBtns[iter_37_0] = gohelper.findChild(arg_37_0._btnclassify.gameObject, "btn" .. tostring(iter_37_0))
		arg_37_0._dmgUnselects[iter_37_0] = gohelper.findChild(arg_37_0._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. iter_37_0 .. "/unselected")
		arg_37_0._dmgSelects[iter_37_0] = gohelper.findChild(arg_37_0._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. iter_37_0 .. "/selected")
		arg_37_0._dmgBtnClicks[iter_37_0] = gohelper.findChildButtonWithAudio(arg_37_0._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. iter_37_0 .. "/click")

		arg_37_0._dmgBtnClicks[iter_37_0]:AddClickListener(arg_37_0._dmgBtnOnClick, arg_37_0, iter_37_0)
	end

	for iter_37_1 = 1, 6 do
		arg_37_0._attrUnselects[iter_37_1] = gohelper.findChild(arg_37_0._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. iter_37_1 .. "/unselected")
		arg_37_0._attrSelects[iter_37_1] = gohelper.findChild(arg_37_0._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. iter_37_1 .. "/selected")
		arg_37_0._attrBtnClicks[iter_37_1] = gohelper.findChildButtonWithAudio(arg_37_0._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. iter_37_1 .. "/click")

		arg_37_0._attrBtnClicks[iter_37_1]:AddClickListener(arg_37_0._attrBtnOnClick, arg_37_0, iter_37_1)
	end

	for iter_37_2 = 1, 6 do
		arg_37_0._locationUnselects[iter_37_2] = gohelper.findChild(arg_37_0._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. iter_37_2 .. "/unselected")
		arg_37_0._locationSelects[iter_37_2] = gohelper.findChild(arg_37_0._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. iter_37_2 .. "/selected")
		arg_37_0._locationBtnClicks[iter_37_2] = gohelper.findChildButtonWithAudio(arg_37_0._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. iter_37_2 .. "/click")

		arg_37_0._locationBtnClicks[iter_37_2]:AddClickListener(arg_37_0._locationBtnOnClick, arg_37_0, iter_37_2)
	end

	arg_37_0._goBtnEditQuickMode = gohelper.findChild(arg_37_0._btnquickedit.gameObject, "btn2")
	arg_37_0._goBtnEditNormalMode = gohelper.findChild(arg_37_0._btnquickedit.gameObject, "btn1")
	arg_37_0._attributevalues = {}

	for iter_37_3 = 1, 5 do
		local var_37_0 = arg_37_0:getUserDataTb_()

		var_37_0.value = gohelper.findChildText(arg_37_0._goattribute, "attribute" .. tostring(iter_37_3) .. "/txt_attribute")
		var_37_0.name = gohelper.findChildText(arg_37_0._goattribute, "attribute" .. tostring(iter_37_3) .. "/name")
		var_37_0.icon = gohelper.findChildImage(arg_37_0._goattribute, "attribute" .. tostring(iter_37_3) .. "/icon")
		arg_37_0._attributevalues[iter_37_3] = var_37_0
	end

	arg_37_0._passiveskillitems = {}

	for iter_37_4 = 1, 3 do
		local var_37_1 = arg_37_0:getUserDataTb_()

		var_37_1.go = gohelper.findChild(arg_37_0._gopassiveskills, "passiveskill" .. tostring(iter_37_4))
		var_37_1.on = gohelper.findChild(var_37_1.go, "on")
		var_37_1.off = gohelper.findChild(var_37_1.go, "off")
		arg_37_0._passiveskillitems[iter_37_4] = var_37_1
	end

	arg_37_0._skillContainer = MonoHelper.addNoUpdateLuaComOnceToGo(arg_37_0._goskill, CharacterSkillContainer)

	gohelper.setActive(arg_37_0._gononecharacter, false)
	gohelper.setActive(arg_37_0._gocharacterinfo, false)

	arg_37_0._animator = arg_37_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.onOpen(arg_38_0)
	arg_38_0._isShowQuickEdit = false
	arg_38_0._scrollcard.verticalNormalizedPosition = 1
	arg_38_0._scrollquickedit.verticalNormalizedPosition = 1
	arg_38_0._originalHeroUid = arg_38_0.viewParam.originalHeroUid
	arg_38_0._singleGroupMOId = arg_38_0.viewParam.singleGroupMOId
	arg_38_0._adventure = arg_38_0.viewParam.adventure
	arg_38_0._equips = arg_38_0.viewParam.equips

	for iter_38_0 = 1, 6 do
		arg_38_0._selectAttrs[iter_38_0] = false
	end

	for iter_38_1 = 1, 2 do
		arg_38_0._selectDmgs[iter_38_1] = false
	end

	if Season123HeroGroupModel.instance:isEpisodeSeason123() then
		CharacterModel.instance:setAppendHeroMOs(Season123HeroGroupEditModel.instance:getAssistHeroList())
	end

	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.HeroGroup)
	Season123HeroGroupEditModel.instance:setParam(arg_38_0._originalHeroUid, arg_38_0._adventure, arg_38_0._heroHps)
	Season123HeroGroupQuickEditModel.instance:setParam(arg_38_0._adventure, arg_38_0._heroHps)

	arg_38_0._heroMO = Season123HeroGroupEditModel.instance:copyCharacterCardList(true)

	arg_38_0:_refreshEditMode()
	arg_38_0:_refreshBtnIcon()
	arg_38_0:_refreshCharacterInfo()
	arg_38_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_38_0._updateHeroList, arg_38_0)
	arg_38_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_38_0._updateHeroList, arg_38_0)
	arg_38_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_38_0._updateHeroList, arg_38_0)
	arg_38_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroEditItem, arg_38_0._onHeroItemClick, arg_38_0)
	arg_38_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_38_0._refreshCharacterInfo, arg_38_0)
	arg_38_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_38_0._refreshCharacterInfo, arg_38_0)
	arg_38_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_38_0._refreshCharacterInfo, arg_38_0)
	arg_38_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, arg_38_0._refreshCharacterInfo, arg_38_0)
	arg_38_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_38_0._refreshCharacterInfo, arg_38_0)
	arg_38_0:addEventCb(CharacterController.instance, CharacterEvent.levelUpAttribute, arg_38_0._onAttributeChanged, arg_38_0)
	arg_38_0:addEventCb(CharacterController.instance, CharacterEvent.showCharacterRankUpView, arg_38_0._showCharacterRankUpView, arg_38_0)
	arg_38_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_38_0._onGroupModify, arg_38_0)
	arg_38_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_38_0._onGroupModify, arg_38_0)
	arg_38_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_38_0._onOpenView, arg_38_0)
	arg_38_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_38_0._onCloseView, arg_38_0)
	gohelper.addUIClickAudio(arg_38_0._btnlvrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_38_0._btnrarerank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_38_0._btnexskillrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_38_0._btnattribute.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_38_0._btnpassiveskill.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_38_0._btncharacter.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_38_0._btnassistcharacter.gameObject, AudioEnum.UI.UI_Common_Click)

	_, arg_38_0._initScrollContentPosY = transformhelper.getLocalPos(arg_38_0._goScrollContent.transform)
end

function var_0_0.onClose(arg_39_0)
	arg_39_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_39_0._updateHeroList, arg_39_0)
	arg_39_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_39_0._updateHeroList, arg_39_0)
	arg_39_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_39_0._updateHeroList, arg_39_0)
	arg_39_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroEditItem, arg_39_0._onHeroItemClick, arg_39_0)
	arg_39_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_39_0._refreshCharacterInfo, arg_39_0)
	arg_39_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_39_0._refreshCharacterInfo, arg_39_0)
	arg_39_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_39_0._refreshCharacterInfo, arg_39_0)
	arg_39_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, arg_39_0._refreshCharacterInfo, arg_39_0)
	arg_39_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_39_0._refreshCharacterInfo, arg_39_0)
	arg_39_0:removeEventCb(CharacterController.instance, CharacterEvent.levelUpAttribute, arg_39_0._onAttributeChanged, arg_39_0)
	arg_39_0:removeEventCb(CharacterController.instance, CharacterEvent.showCharacterRankUpView, arg_39_0._showCharacterRankUpView, arg_39_0)
	arg_39_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_39_0._onGroupModify, arg_39_0)
	arg_39_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_39_0._onGroupModify, arg_39_0)
	CharacterModel.instance:setFakeLevel()
	Season123HeroGroupEditModel.instance:cancelAllSelected()
	Season123HeroGroupEditModel.instance:clear()
	Season123HeroGroupQuickEditModel.instance:cancelAllSelected()
	Season123HeroGroupQuickEditModel.instance:clear()
	CommonHeroHelper.instance:resetGrayState()
	CharacterModel.instance:setAppendHeroMOs(nil)
	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.HeroGroup)

	arg_39_0._selectDmgs = {}
	arg_39_0._selectAttrs = {}

	if arg_39_0._isStopBgm then
		TaskDispatcher.cancelTask(arg_39_0._delyStopBgm, arg_39_0)
		arg_39_0:_delyStopBgm()
	end
end

function var_0_0._onOpenView(arg_40_0, arg_40_1)
	if arg_40_1 == ViewName.CharacterView and arg_40_0._isStopBgm then
		TaskDispatcher.cancelTask(arg_40_0._delyStopBgm, arg_40_0)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Unsatisfied_Music)

		return
	end
end

function var_0_0._onCloseView(arg_41_0, arg_41_1)
	if arg_41_1 == ViewName.CharacterView then
		AudioMgr.instance:trigger(AudioEnum.UI.Stop_UIMusic)

		arg_41_0._isStopBgm = true

		TaskDispatcher.cancelTask(arg_41_0._delyStopBgm, arg_41_0)
		TaskDispatcher.runDelay(arg_41_0._delyStopBgm, arg_41_0, 1)
	end
end

function var_0_0._delyStopBgm(arg_42_0)
	arg_42_0._isStopBgm = false

	AudioMgr.instance:trigger(AudioEnum.Bgm.Pause_FightingMusic)
end

function var_0_0._showCharacterRankUpView(arg_43_0, arg_43_1)
	arg_43_1()
end

function var_0_0.onDestroyView(arg_44_0)
	arg_44_0._imgBg:UnLoadImage()
	arg_44_0._simageredlight:UnLoadImage()

	arg_44_0._imgBg = nil
	arg_44_0._simageredlight = nil

	for iter_44_0 = 1, 2 do
		arg_44_0._dmgBtnClicks[iter_44_0]:RemoveClickListener()
	end

	for iter_44_1 = 1, 6 do
		arg_44_0._attrBtnClicks[iter_44_1]:RemoveClickListener()
	end

	for iter_44_2 = 1, 6 do
		arg_44_0._locationBtnClicks[iter_44_2]:RemoveClickListener()
	end

	CharacterModel.instance:setAppendHeroMOs(nil)
end

return var_0_0
