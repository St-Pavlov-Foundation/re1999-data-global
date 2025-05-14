module("modules.logic.seasonver.act166.view.Season166HeroGroupEditView", package.seeall)

local var_0_0 = class("Season166HeroGroupEditView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gononecharacter = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_nonecharacter")
	arg_1_0._gocharacterinfo = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo")
	arg_1_0._imagedmgtype = gohelper.findChildImage(arg_1_0.viewGO, "characterinfo/#go_characterinfo/#image_dmgtype")
	arg_1_0._imagecareericon = gohelper.findChildImage(arg_1_0.viewGO, "characterinfo/#go_characterinfo/career/#image_careericon")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "characterinfo/#go_characterinfo/name/#txt_name")
	arg_1_0._txtnameen = gohelper.findChildText(arg_1_0.viewGO, "characterinfo/#go_characterinfo/name/#txt_nameen")
	arg_1_0._gospecialitem = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/special/#go_specialitem")
	arg_1_0._golevel = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/level")
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
	arg_1_0._txtrecommendAttrDesc = gohelper.findChildText(arg_1_0.viewGO, "#go_recommendAttr/bg/#txt_desc")
	arg_1_0._goattrlist = gohelper.findChild(arg_1_0.viewGO, "#go_recommendAttr/bg/#go_attrlist")
	arg_1_0._goattritem = gohelper.findChild(arg_1_0.viewGO, "#go_recommendAttr/bg/#go_attrlist/#go_attritem")
	arg_1_0._golevelWithTalent = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent")
	arg_1_0._txtlevelWithTalent = gohelper.findChildText(arg_1_0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_level")
	arg_1_0._txtlevelmaxWithTalent = gohelper.findChildText(arg_1_0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_level/#txt_levelmax")
	arg_1_0._btncharacterWithTalent = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#btn_character")
	arg_1_0._btnassistWithTalent = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#btn_assistwithtalent")
	arg_1_0._goheroLvTxtWithTalent = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/Text")
	arg_1_0._txttalent = gohelper.findChildText(arg_1_0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_talent")
	arg_1_0._txttalentType = gohelper.findChildText(arg_1_0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_talentType")

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
	arg_2_0._btnassistWithTalent:AddClickListener(arg_2_0._btncharacterOnClick, arg_2_0)
	arg_2_0._btncharacterWithTalent:AddClickListener(arg_2_0._btncharacterOnClick, arg_2_0)
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
	arg_3_0._btnassistWithTalent:RemoveClickListener()
	arg_3_0._btncharacterWithTalent:RemoveClickListener()
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

		if not Season166HeroSingleGroupModel.instance:isAssistHeroInTeam() then
			Season166HeroGroupModel.instance:cleanAssistData()
		end

		arg_9_0:closeThis()

		return
	end

	if not arg_9_0:_normalEditHasChange() then
		arg_9_0:closeThis()

		return
	end

	local var_9_0 = Season166HeroSingleGroupModel.instance:getById(arg_9_0._singleGroupMOId)

	if arg_9_0._heroMO then
		if arg_9_0._heroMO.isPosLock then
			GameFacade.showToast(ToastEnum.TrialCantTakeOff)

			return
		end

		local var_9_1, var_9_2 = Season166HeroSingleGroupModel.instance:hasHeroUids(arg_9_0._heroMO.uid, arg_9_0._singleGroupMOId)

		if var_9_1 then
			Season166HeroSingleGroupModel.instance:removeFrom(var_9_2)
			Season166HeroSingleGroupModel.instance:addTo(arg_9_0._heroMO.uid, arg_9_0._singleGroupMOId)

			if arg_9_0._heroMO:isTrial() then
				var_9_0:setTrial(arg_9_0._heroMO.trialCo.id, arg_9_0._heroMO.trialCo.trialTemplate)
			else
				var_9_0:setTrial()
			end

			if not Season166HeroSingleGroupModel.instance:isAssistHeroInTeam() then
				Season166HeroGroupModel.instance:cleanAssistData()
			end

			FightAudioMgr.instance:playHeroVoiceRandom(arg_9_0._heroMO.heroId, CharacterEnum.VoiceType.HeroGroup)
			arg_9_0:_saveCurGroupInfo()
			arg_9_0:closeThis()

			return
		end

		if Season166HeroSingleGroupModel.instance:isAidConflict(arg_9_0._heroMO.heroId) then
			GameFacade.showToast(ToastEnum.HeroIsAidConflict)

			return
		end

		Season166HeroSingleGroupModel.instance:addTo(arg_9_0._heroMO.uid, arg_9_0._singleGroupMOId)

		if arg_9_0._heroMO:isTrial() then
			var_9_0:setTrial(arg_9_0._heroMO.trialCo.id, arg_9_0._heroMO.trialCo.trialTemplate)
		else
			var_9_0:setTrial()
		end

		if not Season166HeroSingleGroupModel.instance:isAssistHeroInTeam() then
			Season166HeroGroupModel.instance:cleanAssistData()
		end

		FightAudioMgr.instance:playHeroVoiceRandom(arg_9_0._heroMO.heroId, CharacterEnum.VoiceType.HeroGroup)
		arg_9_0:_saveCurGroupInfo()
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
		arg_9_0:closeThis()
	else
		local var_9_3 = Season166HeroSingleGroupModel.instance.assistMO

		if var_9_3 and var_9_0.heroUid == var_9_3.heroUid then
			Season166HeroGroupModel.instance:cleanAssistData()
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
		end

		Season166HeroSingleGroupModel.instance:removeFrom(arg_9_0._singleGroupMOId)
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
			var_11_0 = Season166HeroGroupQuickEditModel.instance:getList()
		else
			var_11_0 = Season166HeroGroupEditModel.instance:getList()
		end

		if arg_11_0._heroMO:isOtherPlayerHero() then
			local var_11_1 = Season166HeroGroupEditModel.instance:getEquipMOByHeroUid(arg_11_0._heroMO.uid)

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
		var_12_2.isBalance = false

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
		Season166HeroGroupQuickEditModel.instance:cancelAllSelected()
		Season166HeroGroupQuickEditModel.instance:copyQuickEditCardList()

		local var_16_0 = Season166HeroGroupQuickEditModel.instance:getById(arg_16_0._originalHeroUid)

		if var_16_0 then
			local var_16_1 = Season166HeroGroupQuickEditModel.instance:getIndex(var_16_0)

			Season166HeroGroupQuickEditModel.instance:selectCell(var_16_1, true)
		end
	else
		arg_16_0:_saveQuickGroupInfo()
		arg_16_0:_onHeroItemClick(nil)
		Season166HeroGroupEditModel.instance:cancelAllSelected()

		local var_16_2 = Season166HeroSingleGroupModel.instance:getHeroUid(arg_16_0._singleGroupMOId)

		if var_16_2 ~= "0" then
			local var_16_3 = Season166HeroGroupEditModel.instance:getById(var_16_2)
			local var_16_4 = Season166HeroGroupEditModel.instance:getIndex(var_16_3)

			Season166HeroGroupEditModel.instance:selectCell(var_16_4, true)
		end

		Season166HeroGroupEditModel.instance:copyCharacterCardList()
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
		local var_22_3 = arg_22_0._heroMO.rank >= CharacterEnum.TalentRank and arg_22_0._heroMO.talent > 0

		if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) then
			var_22_3 = false
		end

		if var_22_3 then
			gohelper.setActive(arg_22_0._golevel, false)
			gohelper.setActive(arg_22_0._golevelWithTalent, true)
			gohelper.setActive(arg_22_0._goheroLvTxtWithTalent, true)

			arg_22_0._txtlevelWithTalent.text = tostring(var_22_1)
			arg_22_0._txtlevelmaxWithTalent.text = string.format("/%d", var_22_2)
			arg_22_0._txttalent.text = "Lv.<size=40>" .. tostring(arg_22_0._heroMO.talent)
			arg_22_0._txttalentType.text = luaLang("talent_character_talentcn" .. CharacterEnum.TalentTxtByHeroType[arg_22_0._heroMO.config.heroType])
		else
			gohelper.setActive(arg_22_0._golevel, true)
			gohelper.setActive(arg_22_0._golevelWithTalent, false)

			arg_22_0._txtlevel.text = tostring(var_22_1)
			arg_22_0._txtlevelmax.text = string.format("/%d", var_22_2)
		end

		local var_22_4 = {}

		if not string.nilorempty(arg_22_0._heroMO.config.battleTag) then
			var_22_4 = string.split(arg_22_0._heroMO.config.battleTag, "#")
		end

		for iter_22_0 = 1, #var_22_4 do
			local var_22_5 = arg_22_0._careerGOs[iter_22_0]

			if not var_22_5 then
				var_22_5 = arg_22_0:getUserDataTb_()
				var_22_5.go = gohelper.cloneInPlace(arg_22_0._gospecialitem, "item" .. iter_22_0)
				var_22_5.textfour = gohelper.findChildText(var_22_5.go, "#go_fourword/name")
				var_22_5.textthree = gohelper.findChildText(var_22_5.go, "#go_threeword/name")
				var_22_5.texttwo = gohelper.findChildText(var_22_5.go, "#go_twoword/name")
				var_22_5.containerfour = gohelper.findChild(var_22_5.go, "#go_fourword")
				var_22_5.containerthree = gohelper.findChild(var_22_5.go, "#go_threeword")
				var_22_5.containertwo = gohelper.findChild(var_22_5.go, "#go_twoword")

				table.insert(arg_22_0._careerGOs, var_22_5)
			end

			local var_22_6 = HeroConfig.instance:getBattleTagConfigCO(var_22_4[iter_22_0]).tagName
			local var_22_7 = GameUtil.utf8len(var_22_6)

			gohelper.setActive(var_22_5.containertwo, var_22_7 <= 2)
			gohelper.setActive(var_22_5.containerthree, var_22_7 == 3)
			gohelper.setActive(var_22_5.containerfour, var_22_7 >= 4)

			if var_22_7 <= 2 then
				var_22_5.texttwo.text = var_22_6
			elseif var_22_7 == 3 then
				var_22_5.textthree.text = var_22_6
			else
				var_22_5.textfour.text = var_22_6
			end

			gohelper.setActive(var_22_5.go, true)
		end

		for iter_22_1 = #var_22_4 + 1, #arg_22_0._careerGOs do
			gohelper.setActive(arg_22_0._careerGOs[iter_22_1].go, false)
		end

		local var_22_8 = arg_22_0._heroMO:isOwnHero()

		gohelper.setActive(arg_22_0._gobtncharacter, var_22_8)
		gohelper.setActive(arg_22_0._gobtnassistcharacter, not var_22_8)
		gohelper.setActive(arg_22_0._btnassistWithTalent.gameObject, not var_22_8)
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
		Season166HeroGroupQuickEditModel.instance:copyQuickEditCardList()
	else
		Season166HeroGroupEditModel.instance:copyCharacterCardList()
	end
end

function var_0_0.replaceSelectHeroDefaultEquip(arg_29_0)
	if arg_29_0._heroMO and arg_29_0._heroMO:hasDefaultEquip() then
		local var_29_0 = Season166HeroGroupModel.instance:getCurGroupMO().equips

		for iter_29_0, iter_29_1 in pairs(var_29_0) do
			if iter_29_1.equipUid[1] == arg_29_0._heroMO.defaultEquipUid then
				iter_29_1.equipUid[1] = "0"

				break
			end
		end

		var_29_0[arg_29_0._singleGroupMOId - 1].equipUid[1] = arg_29_0._heroMO.defaultEquipUid
	end
end

function var_0_0.replaceHeroesDefaultEquip(arg_30_0, arg_30_1)
	local var_30_0 = Season166HeroGroupModel.instance:getCurGroupMO().equips
	local var_30_1

	for iter_30_0, iter_30_1 in ipairs(arg_30_1) do
		local var_30_2 = HeroModel.instance:getById(iter_30_1)

		if var_30_2 and var_30_2:hasDefaultEquip() then
			for iter_30_2, iter_30_3 in pairs(var_30_0) do
				if iter_30_3.equipUid[1] == var_30_2.defaultEquipUid then
					iter_30_3.equipUid[1] = "0"

					break
				end
			end

			var_30_0[iter_30_0 - 1].equipUid[1] = var_30_2.defaultEquipUid
		end
	end
end

function var_0_0._saveCurGroupInfo(arg_31_0)
	arg_31_0:replaceSelectHeroDefaultEquip()
	Season166HeroGroupModel.instance:replaceSingleGroup()
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	Season166HeroGroupModel.instance:saveCurGroupData()
end

function var_0_0._saveQuickGroupInfo(arg_32_0)
	if Season166HeroGroupQuickEditModel.instance:getIsDirty() then
		local var_32_0 = Season166HeroGroupQuickEditModel.instance:getHeroUids()
		local var_32_1 = Season166HeroGroupModel.instance:getCurGroupMO()

		arg_32_0:replaceHeroesDefaultEquip(var_32_0)

		for iter_32_0 = 1, Season166HeroGroupModel.instance:getBattleRoleNum() do
			local var_32_2 = var_32_0[iter_32_0]

			if var_32_2 ~= nil then
				Season166HeroSingleGroupModel.instance:addTo(var_32_2, iter_32_0)

				local var_32_3 = Season166HeroSingleGroupModel.instance:getByIndex(iter_32_0)

				if tonumber(var_32_2) < 0 then
					local var_32_4 = HeroGroupTrialModel.instance:getById(var_32_2)

					if var_32_4 then
						var_32_3:setTrial(var_32_4.trialCo.id, var_32_4.trialCo.trialTemplate)
					else
						var_32_3:setTrial()
					end
				else
					var_32_3:setTrial()
				end
			end
		end

		Season166HeroGroupModel.instance:replaceSingleGroup()
		Season166HeroGroupModel.instance:replaceSingleGroupEquips()
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
		Season166HeroGroupModel.instance:saveCurGroupData()
	end
end

function var_0_0._onAttributeChanged(arg_33_0, arg_33_1, arg_33_2)
	CharacterModel.instance:setFakeLevel(arg_33_2, arg_33_1)
end

function var_0_0._normalEditHasChange(arg_34_0)
	return true
end

function var_0_0._refreshEditMode(arg_35_0)
	gohelper.setActive(arg_35_0._scrollquickedit.gameObject, arg_35_0._isShowQuickEdit)
	gohelper.setActive(arg_35_0._scrollcard.gameObject, not arg_35_0._isShowQuickEdit)
	gohelper.setActive(arg_35_0._goBtnEditQuickMode.gameObject, arg_35_0._isShowQuickEdit)
	gohelper.setActive(arg_35_0._goBtnEditNormalMode.gameObject, not arg_35_0._isShowQuickEdit)
end

function var_0_0._refreshCurScrollBySort(arg_36_0)
	if arg_36_0._isShowQuickEdit then
		if Season166HeroGroupQuickEditModel.instance:getIsDirty() then
			arg_36_0:_saveQuickGroupInfo()
		end

		local var_36_0 = arg_36_0._heroMO

		Season166HeroGroupQuickEditModel.instance:copyQuickEditCardList()

		if var_36_0 ~= arg_36_0._heroMO then
			Season166HeroGroupQuickEditModel.instance:cancelAllSelected()
		end
	else
		Season166HeroGroupEditModel.instance:copyCharacterCardList()
	end
end

function var_0_0._onGroupModify(arg_37_0)
	if arg_37_0._isShowQuickEdit then
		Season166HeroGroupQuickEditModel.instance:copyQuickEditCardList()
	else
		local var_37_0 = Season166HeroSingleGroupModel.instance:getHeroUid(arg_37_0._singleGroupMOId)

		if arg_37_0._originalHeroUid ~= var_37_0 then
			arg_37_0._originalHeroUid = var_37_0

			Season166HeroGroupEditModel.instance:setParam(var_37_0)
			arg_37_0:_onHeroItemClick(nil)
			Season166HeroGroupEditModel.instance:cancelAllSelected()

			local var_37_1 = Season166HeroGroupEditModel.instance:getById(var_37_0)
			local var_37_2 = Season166HeroGroupEditModel.instance:getIndex(var_37_1)

			Season166HeroGroupEditModel.instance:selectCell(var_37_2, true)
		end

		Season166HeroGroupEditModel.instance:copyCharacterCardList()
	end
end

function var_0_0._editableInitView(arg_38_0)
	gohelper.setActive(arg_38_0._gospecialitem, false)

	arg_38_0._careerGOs = {}
	arg_38_0._imgBg = gohelper.findChildSingleImage(arg_38_0.viewGO, "bg/bgimg")
	arg_38_0._simageredlight = gohelper.findChildSingleImage(arg_38_0.viewGO, "bg/#simage_redlight")

	arg_38_0._imgBg:LoadImage(ResUrl.getCommonViewBg("full/biandui_di"))
	arg_38_0._simageredlight:LoadImage(ResUrl.getHeroGroupBg("guang_027"))

	arg_38_0._lvBtns = arg_38_0:getUserDataTb_()
	arg_38_0._lvArrow = arg_38_0:getUserDataTb_()
	arg_38_0._rareBtns = arg_38_0:getUserDataTb_()
	arg_38_0._rareArrow = arg_38_0:getUserDataTb_()
	arg_38_0._classifyBtns = arg_38_0:getUserDataTb_()
	arg_38_0._selectDmgs = {}
	arg_38_0._dmgSelects = arg_38_0:getUserDataTb_()
	arg_38_0._dmgUnselects = arg_38_0:getUserDataTb_()
	arg_38_0._dmgBtnClicks = arg_38_0:getUserDataTb_()
	arg_38_0._selectAttrs = {}
	arg_38_0._attrSelects = arg_38_0:getUserDataTb_()
	arg_38_0._attrUnselects = arg_38_0:getUserDataTb_()
	arg_38_0._attrBtnClicks = arg_38_0:getUserDataTb_()
	arg_38_0._selectLocations = {}
	arg_38_0._locationSelects = arg_38_0:getUserDataTb_()
	arg_38_0._locationUnselects = arg_38_0:getUserDataTb_()
	arg_38_0._locationBtnClicks = arg_38_0:getUserDataTb_()
	arg_38_0._curDmgs = {}
	arg_38_0._curAttrs = {}
	arg_38_0._curLocations = {}

	for iter_38_0 = 1, 2 do
		arg_38_0._lvBtns[iter_38_0] = gohelper.findChild(arg_38_0._btnlvrank.gameObject, "btn" .. tostring(iter_38_0))
		arg_38_0._lvArrow[iter_38_0] = gohelper.findChild(arg_38_0._lvBtns[iter_38_0], "txt/arrow").transform
		arg_38_0._rareBtns[iter_38_0] = gohelper.findChild(arg_38_0._btnrarerank.gameObject, "btn" .. tostring(iter_38_0))
		arg_38_0._rareArrow[iter_38_0] = gohelper.findChild(arg_38_0._rareBtns[iter_38_0], "txt/arrow").transform
		arg_38_0._classifyBtns[iter_38_0] = gohelper.findChild(arg_38_0._btnclassify.gameObject, "btn" .. tostring(iter_38_0))
		arg_38_0._dmgUnselects[iter_38_0] = gohelper.findChild(arg_38_0._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. iter_38_0 .. "/unselected")
		arg_38_0._dmgSelects[iter_38_0] = gohelper.findChild(arg_38_0._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. iter_38_0 .. "/selected")
		arg_38_0._dmgBtnClicks[iter_38_0] = gohelper.findChildButtonWithAudio(arg_38_0._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. iter_38_0 .. "/click")

		arg_38_0._dmgBtnClicks[iter_38_0]:AddClickListener(arg_38_0._dmgBtnOnClick, arg_38_0, iter_38_0)
	end

	for iter_38_1 = 1, 6 do
		arg_38_0._attrUnselects[iter_38_1] = gohelper.findChild(arg_38_0._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. iter_38_1 .. "/unselected")
		arg_38_0._attrSelects[iter_38_1] = gohelper.findChild(arg_38_0._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. iter_38_1 .. "/selected")
		arg_38_0._attrBtnClicks[iter_38_1] = gohelper.findChildButtonWithAudio(arg_38_0._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. iter_38_1 .. "/click")

		arg_38_0._attrBtnClicks[iter_38_1]:AddClickListener(arg_38_0._attrBtnOnClick, arg_38_0, iter_38_1)
	end

	for iter_38_2 = 1, 6 do
		arg_38_0._locationUnselects[iter_38_2] = gohelper.findChild(arg_38_0._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. iter_38_2 .. "/unselected")
		arg_38_0._locationSelects[iter_38_2] = gohelper.findChild(arg_38_0._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. iter_38_2 .. "/selected")
		arg_38_0._locationBtnClicks[iter_38_2] = gohelper.findChildButtonWithAudio(arg_38_0._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. iter_38_2 .. "/click")

		arg_38_0._locationBtnClicks[iter_38_2]:AddClickListener(arg_38_0._locationBtnOnClick, arg_38_0, iter_38_2)
	end

	arg_38_0._goBtnEditQuickMode = gohelper.findChild(arg_38_0._btnquickedit.gameObject, "btn2")
	arg_38_0._goBtnEditNormalMode = gohelper.findChild(arg_38_0._btnquickedit.gameObject, "btn1")
	arg_38_0._attributevalues = {}

	for iter_38_3 = 1, 5 do
		local var_38_0 = arg_38_0:getUserDataTb_()

		var_38_0.value = gohelper.findChildText(arg_38_0._goattribute, "attribute" .. tostring(iter_38_3) .. "/txt_attribute")
		var_38_0.name = gohelper.findChildText(arg_38_0._goattribute, "attribute" .. tostring(iter_38_3) .. "/name")
		var_38_0.icon = gohelper.findChildImage(arg_38_0._goattribute, "attribute" .. tostring(iter_38_3) .. "/icon")
		arg_38_0._attributevalues[iter_38_3] = var_38_0
	end

	arg_38_0._passiveskillitems = {}

	for iter_38_4 = 1, 3 do
		local var_38_1 = arg_38_0:getUserDataTb_()

		var_38_1.go = gohelper.findChild(arg_38_0._gopassiveskills, "passiveskill" .. tostring(iter_38_4))
		var_38_1.on = gohelper.findChild(var_38_1.go, "on")
		var_38_1.off = gohelper.findChild(var_38_1.go, "off")
		arg_38_0._passiveskillitems[iter_38_4] = var_38_1
	end

	arg_38_0._skillContainer = MonoHelper.addNoUpdateLuaComOnceToGo(arg_38_0._goskill, CharacterSkillContainer)

	gohelper.setActive(arg_38_0._gononecharacter, false)
	gohelper.setActive(arg_38_0._gocharacterinfo, false)

	arg_38_0._animator = arg_38_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.onOpen(arg_39_0)
	arg_39_0._isShowQuickEdit = false
	arg_39_0._scrollcard.verticalNormalizedPosition = 1
	arg_39_0._scrollquickedit.verticalNormalizedPosition = 1
	arg_39_0._originalHeroUid = arg_39_0.viewParam.originalHeroUid
	arg_39_0._singleGroupMOId = arg_39_0.viewParam.singleGroupMOId
	arg_39_0._adventure = arg_39_0.viewParam.adventure
	arg_39_0._equips = arg_39_0.viewParam.equips

	for iter_39_0 = 1, 6 do
		arg_39_0._selectAttrs[iter_39_0] = false
	end

	for iter_39_1 = 1, 2 do
		arg_39_0._selectDmgs[iter_39_1] = false
	end

	if Season166HeroGroupModel.instance:isSeason166Episode() then
		CharacterModel.instance:setAppendHeroMOs(Season166HeroGroupEditModel.instance:getAssistHeroList())
	end

	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.HeroGroup)
	Season166HeroGroupEditModel.instance:setParam(arg_39_0._originalHeroUid)

	arg_39_0._heroMO = Season166HeroGroupEditModel.instance:copyCharacterCardList(true)

	arg_39_0:_refreshEditMode()
	arg_39_0:_refreshBtnIcon()
	arg_39_0:_refreshCharacterInfo()
	arg_39_0:_showRecommendCareer()
	arg_39_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_39_0._updateHeroList, arg_39_0)
	arg_39_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_39_0._updateHeroList, arg_39_0)
	arg_39_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_39_0._updateHeroList, arg_39_0)
	arg_39_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroEditItem, arg_39_0._onHeroItemClick, arg_39_0)
	arg_39_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_39_0._refreshCharacterInfo, arg_39_0)
	arg_39_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_39_0._refreshCharacterInfo, arg_39_0)
	arg_39_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_39_0._refreshCharacterInfo, arg_39_0)
	arg_39_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, arg_39_0._refreshCharacterInfo, arg_39_0)
	arg_39_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_39_0._refreshCharacterInfo, arg_39_0)
	arg_39_0:addEventCb(CharacterController.instance, CharacterEvent.levelUpAttribute, arg_39_0._onAttributeChanged, arg_39_0)
	arg_39_0:addEventCb(CharacterController.instance, CharacterEvent.showCharacterRankUpView, arg_39_0._showCharacterRankUpView, arg_39_0)
	arg_39_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_39_0._onGroupModify, arg_39_0)
	arg_39_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_39_0._onGroupModify, arg_39_0)
	arg_39_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_39_0._onOpenView, arg_39_0)
	arg_39_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_39_0._onCloseView, arg_39_0)
	gohelper.addUIClickAudio(arg_39_0._btnlvrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_39_0._btnrarerank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_39_0._btnexskillrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_39_0._btnattribute.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_39_0._btnpassiveskill.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_39_0._btncharacter.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_39_0._btnassistcharacter.gameObject, AudioEnum.UI.UI_Common_Click)

	_, arg_39_0._initScrollContentPosY = transformhelper.getLocalPos(arg_39_0._goScrollContent.transform)
end

function var_0_0.onClose(arg_40_0)
	arg_40_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_40_0._updateHeroList, arg_40_0)
	arg_40_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_40_0._updateHeroList, arg_40_0)
	arg_40_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_40_0._updateHeroList, arg_40_0)
	arg_40_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroEditItem, arg_40_0._onHeroItemClick, arg_40_0)
	arg_40_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_40_0._refreshCharacterInfo, arg_40_0)
	arg_40_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_40_0._refreshCharacterInfo, arg_40_0)
	arg_40_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_40_0._refreshCharacterInfo, arg_40_0)
	arg_40_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, arg_40_0._refreshCharacterInfo, arg_40_0)
	arg_40_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_40_0._refreshCharacterInfo, arg_40_0)
	arg_40_0:removeEventCb(CharacterController.instance, CharacterEvent.levelUpAttribute, arg_40_0._onAttributeChanged, arg_40_0)
	arg_40_0:removeEventCb(CharacterController.instance, CharacterEvent.showCharacterRankUpView, arg_40_0._showCharacterRankUpView, arg_40_0)
	arg_40_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_40_0._onGroupModify, arg_40_0)
	arg_40_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_40_0._onGroupModify, arg_40_0)
	CharacterModel.instance:setFakeLevel()
	Season166HeroGroupEditModel.instance:cancelAllSelected()
	Season166HeroGroupEditModel.instance:clear()
	Season166HeroGroupQuickEditModel.instance:cancelAllSelected()
	Season166HeroGroupQuickEditModel.instance:clear()
	CommonHeroHelper.instance:resetGrayState()
	CharacterModel.instance:setAppendHeroMOs(nil)
	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.HeroGroup)

	arg_40_0._selectDmgs = {}
	arg_40_0._selectAttrs = {}

	if arg_40_0._isStopBgm then
		TaskDispatcher.cancelTask(arg_40_0._delyStopBgm, arg_40_0)
		arg_40_0:_delyStopBgm()
	end
end

function var_0_0._onOpenView(arg_41_0, arg_41_1)
	if arg_41_1 == ViewName.CharacterView and arg_41_0._isStopBgm then
		TaskDispatcher.cancelTask(arg_41_0._delyStopBgm, arg_41_0)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Unsatisfied_Music)

		return
	end
end

function var_0_0._onCloseView(arg_42_0, arg_42_1)
	if arg_42_1 == ViewName.CharacterView then
		AudioMgr.instance:trigger(AudioEnum.UI.Stop_UIMusic)

		arg_42_0._isStopBgm = true

		TaskDispatcher.cancelTask(arg_42_0._delyStopBgm, arg_42_0)
		TaskDispatcher.runDelay(arg_42_0._delyStopBgm, arg_42_0, 1)
	end
end

function var_0_0._delyStopBgm(arg_43_0)
	arg_43_0._isStopBgm = false

	AudioMgr.instance:trigger(AudioEnum.Bgm.Pause_FightingMusic)
end

function var_0_0._showCharacterRankUpView(arg_44_0, arg_44_1)
	arg_44_1()
end

function var_0_0.onDestroyView(arg_45_0)
	arg_45_0._imgBg:UnLoadImage()
	arg_45_0._simageredlight:UnLoadImage()

	arg_45_0._imgBg = nil
	arg_45_0._simageredlight = nil

	for iter_45_0 = 1, 2 do
		arg_45_0._dmgBtnClicks[iter_45_0]:RemoveClickListener()
	end

	for iter_45_1 = 1, 6 do
		arg_45_0._attrBtnClicks[iter_45_1]:RemoveClickListener()
	end

	for iter_45_2 = 1, 6 do
		arg_45_0._locationBtnClicks[iter_45_2]:RemoveClickListener()
	end

	CharacterModel.instance:setAppendHeroMOs(nil)
end

function var_0_0._showRecommendCareer(arg_46_0)
	local var_46_0, var_46_1 = FightHelper.detectAttributeCounter()

	gohelper.CreateObjList(arg_46_0, arg_46_0._onRecommendCareerItemShow, var_46_0, arg_46_0._goattrlist, arg_46_0._goattritem)

	arg_46_0._txtrecommendAttrDesc.text = #var_46_0 == 0 and luaLang("herogroupeditview_notrecommend") or luaLang("herogroupeditview_recommend")

	gohelper.setActive(arg_46_0._goattrlist, #var_46_0 ~= 0)
end

function var_0_0._onRecommendCareerItemShow(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	local var_47_0 = gohelper.findChildImage(arg_47_1, "icon")

	UISpriteSetMgr.instance:setHeroGroupSprite(var_47_0, "career_" .. arg_47_2)
end

return var_0_0
