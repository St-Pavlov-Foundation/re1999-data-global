module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotHeroGroupEditView", package.seeall)

local var_0_0 = class("V1a6_CachotHeroGroupEditView", BaseView)

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
	arg_1_0._btntrial = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "characterinfo/#go_characterinfo/level/#btn_trial")
	arg_1_0._goBalance = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/level/#go_balance")
	arg_1_0._goheroLvTxt = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/level/Text")
	arg_1_0._golevelWithTalent = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent")
	arg_1_0._txtlevelWithTalent = gohelper.findChildText(arg_1_0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_level")
	arg_1_0._txtlevelmaxWithTalent = gohelper.findChildText(arg_1_0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_level/#txt_levelmax")
	arg_1_0._btncharacterWithTalent = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#btn_character")
	arg_1_0._btntrialWithTalent = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#btn_trial")
	arg_1_0._goBalanceWithTalent = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#go_balance")
	arg_1_0._goheroLvTxtWithTalent = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/Text")
	arg_1_0._txttalent = gohelper.findChildText(arg_1_0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_talent")
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
	arg_1_0._goseatlevel = gohelper.findChild(arg_1_0.viewGO, "#go_rolecontainer/#go_level")
	arg_1_0._seatIcon = gohelper.findChildImage(arg_1_0.viewGO, "#go_rolecontainer/#go_level/bg/#txt_title/icon")
	arg_1_0._seatEffect = gohelper.findChild(arg_1_0.viewGO, "#go_rolecontainer/#go_level/bg/#txt_title/quality_effect")
	arg_1_0._btntips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rolecontainer/#go_level/bg/#txt_title/#btn_tips")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "#go_rolecontainer/#go_empty")
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
	arg_2_0._btntrial:AddClickListener(arg_2_0._btntrialOnClick, arg_2_0)
	arg_2_0._btncharacterWithTalent:AddClickListener(arg_2_0._btncharacterOnClick, arg_2_0)
	arg_2_0._btntrialWithTalent:AddClickListener(arg_2_0._btntrialOnClick, arg_2_0)
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
	arg_3_0._btntrial:RemoveClickListener()
	arg_3_0._btncharacterWithTalent:RemoveClickListener()
	arg_3_0._btntrialWithTalent:RemoveClickListener()
	arg_3_0._btnattribute:RemoveClickListener()
	arg_3_0._btnconfirm:RemoveClickListener()
	arg_3_0._btncancel:RemoveClickListener()
	arg_3_0._btnpassiveskill:RemoveClickListener()
	arg_3_0._btnquickedit:RemoveClickListener()
	arg_3_0._btnclosefilterview:RemoveClickListener()
	arg_3_0._btnreset:RemoveClickListener()
	arg_3_0._btnok:RemoveClickListener()
	arg_3_0._btntips:RemoveClickListener()
end

function var_0_0._btntipsOnClick(arg_4_0)
	HelpController.instance:showHelp(HelpEnum.HelpId.Cachot1_6HeroGroupHelp)
end

function var_0_0._btncloseFilterViewOnClick(arg_5_0)
	arg_5_0._selectDmgs = LuaUtil.deepCopy(arg_5_0._curDmgs)
	arg_5_0._selectAttrs = LuaUtil.deepCopy(arg_5_0._curAttrs)
	arg_5_0._selectLocations = LuaUtil.deepCopy(arg_5_0._curLocations)

	arg_5_0:_refreshBtnIcon()
	gohelper.setActive(arg_5_0._gosearchfilter, false)
end

function var_0_0._btnclassifyOnClick(arg_6_0)
	gohelper.setActive(arg_6_0._gosearchfilter, true)
	arg_6_0:_refreshFilterView()
end

function var_0_0._btnresetOnClick(arg_7_0)
	for iter_7_0 = 1, 2 do
		arg_7_0._selectDmgs[iter_7_0] = false
	end

	for iter_7_1 = 1, 6 do
		arg_7_0._selectAttrs[iter_7_1] = false
	end

	for iter_7_2 = 1, 6 do
		arg_7_0._selectLocations[iter_7_2] = false
	end

	arg_7_0:_refreshBtnIcon()
	arg_7_0:_refreshFilterView()
end

function var_0_0._btnokOnClick(arg_8_0)
	gohelper.setActive(arg_8_0._gosearchfilter, false)

	local var_8_0 = {}

	for iter_8_0 = 1, 2 do
		if arg_8_0._selectDmgs[iter_8_0] then
			table.insert(var_8_0, iter_8_0)
		end
	end

	local var_8_1 = {}

	for iter_8_1 = 1, 6 do
		if arg_8_0._selectAttrs[iter_8_1] then
			table.insert(var_8_1, iter_8_1)
		end
	end

	local var_8_2 = {}

	for iter_8_2 = 1, 6 do
		if arg_8_0._selectLocations[iter_8_2] then
			table.insert(var_8_2, iter_8_2)
		end
	end

	if #var_8_0 == 0 then
		var_8_0 = {
			1,
			2
		}
	end

	if #var_8_1 == 0 then
		var_8_1 = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	if #var_8_2 == 0 then
		var_8_2 = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	local var_8_3, var_8_4 = transformhelper.getLocalPos(arg_8_0._goScrollContent.transform)

	transformhelper.setLocalPosXY(arg_8_0._goScrollContent.transform, var_8_3, arg_8_0._initScrollContentPosY)

	local var_8_5 = {
		dmgs = var_8_0,
		careers = var_8_1,
		locations = var_8_2
	}

	CharacterModel.instance:filterCardListByDmgAndCareer(var_8_5, false, CharacterEnum.FilterType.HeroGroup)
	HeroGroupTrialModel.instance:setFilter(var_8_0, var_8_1)

	arg_8_0._curDmgs = LuaUtil.deepCopy(arg_8_0._selectDmgs)
	arg_8_0._curAttrs = LuaUtil.deepCopy(arg_8_0._selectAttrs)
	arg_8_0._curLocations = LuaUtil.deepCopy(arg_8_0._selectLocations)

	arg_8_0:_refreshBtnIcon()
	arg_8_0:_refreshCurScrollBySort()
	ViewMgr.instance:closeView(ViewName.CharacterLevelUpView)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
end

function var_0_0._btnpassiveskillOnClick(arg_9_0)
	if not arg_9_0._heroMO then
		return
	end

	local var_9_0 = {}

	var_9_0.tag = "passiveskill"
	var_9_0.heroid = arg_9_0._heroMO.heroId
	var_9_0.heroMo = arg_9_0._heroMO
	var_9_0.tipPos = Vector2.New(851, -59)
	var_9_0.buffTipsX = 1603
	var_9_0.anchorParams = {
		Vector2.New(0, 0.5),
		Vector2.New(0, 0.5)
	}
	var_9_0.isBalance = HeroGroupBalanceHelper.getIsBalanceMode() and not arg_9_0._heroMO:isTrial()

	arg_9_0:_addCachotProp(var_9_0)
	CharacterController.instance:openCharacterTipView(var_9_0)
end

function var_0_0._addCachotProp(arg_10_0, arg_10_1)
	local var_10_0, var_10_1 = V1a6_CachotTeamModel.instance:getHeroMaxLevel(arg_10_0._heroMO, arg_10_0._seatLevel)
	local var_10_2, var_10_3 = HeroConfig.instance:getShowLevel(var_10_0)

	arg_10_1.level = var_10_0
	arg_10_1.rank = var_10_3
	arg_10_1.passiveSkillLevel = {}
	arg_10_1.seatLevel = arg_10_0._seatLevel

	for iter_10_0 = 1, var_10_3 - 1 do
		table.insert(arg_10_1.passiveSkillLevel, iter_10_0)
	end

	local var_10_4 = V1a6_CachotHeroGroupController.instance

	arg_10_1.setEquipInfo = {
		var_10_4.getCharacterTipEquipInfo,
		var_10_4,
		{
			isCachot = true,
			seatLevel = arg_10_0._seatLevel
		}
	}
	arg_10_1.talentCubeInfos = arg_10_0._talentCubeInfos
end

function var_0_0._btnconfirmOnClick(arg_11_0)
	if arg_11_0._adventure then
		local var_11_0 = arg_11_0._heroGroupQuickEditListModel:getHeroUids()

		if var_11_0 and #var_11_0 > 0 then
			for iter_11_0, iter_11_1 in pairs(var_11_0) do
				local var_11_1 = HeroModel.instance:getById(iter_11_1)

				if var_11_1 and WeekWalkModel.instance:getCurMapHeroCd(var_11_1.heroId) > 0 then
					GameFacade.showToast(ToastEnum.HeroGroupEdit)

					return
				end
			end
		elseif arg_11_0._heroMO and WeekWalkModel.instance:getCurMapHeroCd(arg_11_0._heroMO.heroId) > 0 then
			GameFacade.showToast(ToastEnum.HeroGroupEdit)

			return
		end
	end

	if arg_11_0._isShowQuickEdit then
		arg_11_0:_saveQuickGroupInfo()
		arg_11_0:closeThis()

		return
	end

	if not arg_11_0:_normalEditHasChange() then
		arg_11_0:closeThis()

		return
	end

	local var_11_2 = arg_11_0._heroSingleGroupModel:getById(arg_11_0._singleGroupMOId)

	if var_11_2.trialPos then
		GameFacade.showToast(ToastEnum.TrialCantTakeOff)

		return
	end

	if arg_11_0._heroMO then
		if arg_11_0._heroMO.isPosLock then
			GameFacade.showToast(ToastEnum.TrialCantTakeOff)

			return
		end

		if arg_11_0._heroMO:isTrial() and not arg_11_0._heroSingleGroupModel:isInGroup(arg_11_0._heroMO.uid) and (var_11_2:isEmpty() or not var_11_2.trial) and arg_11_0._heroGroupEditListModel:isTrialLimit() then
			GameFacade.showToast(ToastEnum.TrialJoinLimit, HeroGroupTrialModel.instance:getLimitNum())

			return
		end

		if arg_11_0.viewParam.heroGroupEditType == V1a6_CachotEnum.HeroGroupEditType.Fight then
			local var_11_3 = V1a6_CachotModel.instance:getTeamInfo():getHeroHp(arg_11_0._heroMO.heroId)

			if (var_11_3 and var_11_3.life or 0) <= 0 then
				GameFacade.showToast(ToastEnum.V1a6CachotToast04)

				return
			end
		end

		local var_11_4, var_11_5 = arg_11_0._heroSingleGroupModel:hasHeroUids(arg_11_0._heroMO.uid, arg_11_0._singleGroupMOId)

		if var_11_4 then
			if arg_11_0.viewParam.heroGroupEditType == V1a6_CachotEnum.HeroGroupEditType.Event then
				GameFacade.showToast(ToastEnum.V1a6CachotToast03)

				return
			end

			arg_11_0._heroSingleGroupModel:removeFrom(var_11_5)
			arg_11_0._heroSingleGroupModel:addTo(arg_11_0._heroMO.uid, arg_11_0._singleGroupMOId)

			if arg_11_0._heroMO:isTrial() then
				var_11_2:setTrial(arg_11_0._heroMO.trialCo.id, arg_11_0._heroMO.trialCo.trialTemplate)
			else
				var_11_2:setTrial()
			end

			FightAudioMgr.instance:playHeroVoiceRandom(arg_11_0._heroMO.heroId, CharacterEnum.VoiceType.HeroGroup)
			arg_11_0:_saveCurGroupInfo()
			arg_11_0:closeThis()

			return
		end

		if arg_11_0._heroSingleGroupModel:isAidConflict(arg_11_0._heroMO.heroId) then
			GameFacade.showToast(ToastEnum.HeroIsAidConflict)

			return
		end

		arg_11_0._heroSingleGroupModel:addTo(arg_11_0._heroMO.uid, arg_11_0._singleGroupMOId)

		if arg_11_0._heroMO:isTrial() then
			var_11_2:setTrial(arg_11_0._heroMO.trialCo.id, arg_11_0._heroMO.trialCo.trialTemplate)
		else
			var_11_2:setTrial()
		end

		FightAudioMgr.instance:playHeroVoiceRandom(arg_11_0._heroMO.heroId, CharacterEnum.VoiceType.HeroGroup)
		arg_11_0:_saveCurGroupInfo()
		arg_11_0:closeThis()
	else
		if arg_11_0.viewParam.heroGroupEditType == V1a6_CachotEnum.HeroGroupEditType.Event then
			arg_11_0.viewContainer:_overrideClose()

			return
		end

		arg_11_0._heroSingleGroupModel:removeFrom(arg_11_0._singleGroupMOId)
		arg_11_0:_saveCurGroupInfo()
		arg_11_0:closeThis()
	end
end

function var_0_0.checkTrialNum(arg_12_0)
	return false
end

function var_0_0._btncancelOnClick(arg_13_0)
	if arg_13_0.viewParam.heroGroupEditType == V1a6_CachotEnum.HeroGroupEditType.Event then
		arg_13_0.viewContainer:_overrideClose()

		return
	end

	arg_13_0:closeThis()
end

function var_0_0._btncharacterOnClick(arg_14_0)
	if arg_14_0._heroMO then
		local var_14_0

		if arg_14_0._isShowQuickEdit then
			var_14_0 = arg_14_0._heroGroupQuickEditListModel:getList()
		else
			var_14_0 = arg_14_0._heroGroupEditListModel:getList()
		end

		local var_14_1 = {}

		for iter_14_0, iter_14_1 in ipairs(var_14_0) do
			if not iter_14_1:isTrial() then
				table.insert(var_14_1, iter_14_1)
			end
		end

		CharacterController.instance:openCharacterView(arg_14_0._heroMO, var_14_1)
	end
end

function var_0_0._btntrialOnClick(arg_15_0)
	if arg_15_0._heroMO then
		local var_15_0

		if arg_15_0._isShowQuickEdit then
			var_15_0 = arg_15_0._heroGroupQuickEditListModel:getList()
		else
			var_15_0 = arg_15_0._heroGroupEditListModel:getList()
		end

		local var_15_1 = {}

		for iter_15_0, iter_15_1 in ipairs(var_15_0) do
			if iter_15_1:isTrial() then
				table.insert(var_15_1, iter_15_1)
			end
		end

		CharacterController.instance:openCharacterView(arg_15_0._heroMO, var_15_1)
	end
end

function var_0_0._btnattributeOnClick(arg_16_0)
	if arg_16_0._heroMO then
		local var_16_0 = {}

		var_16_0.tag = "attribute"
		var_16_0.heroid = arg_16_0._heroMO.heroId
		var_16_0.equips = arg_16_0._equips
		var_16_0.showExtraAttr = true
		var_16_0.fromHeroGroupEditView = true
		var_16_0.heroMo = arg_16_0._heroMO
		var_16_0.isBalance = HeroGroupBalanceHelper.getIsBalanceMode() and not arg_16_0._heroMO:isTrial()

		arg_16_0:_addCachotProp(var_16_0)
		CharacterController.instance:openCharacterTipView(var_16_0)
	end
end

function var_0_0._btnexskillrankOnClick(arg_17_0)
	local var_17_0, var_17_1 = transformhelper.getLocalPos(arg_17_0._goScrollContent.transform)

	transformhelper.setLocalPosXY(arg_17_0._goScrollContent.transform, var_17_0, arg_17_0._initScrollContentPosY)
	CharacterModel.instance:setCardListByExSkill(false, CharacterEnum.FilterType.HeroGroup)
	arg_17_0:_refreshCurScrollBySort()
	arg_17_0:_refreshBtnIcon()
end

function var_0_0._btnlvrankOnClick(arg_18_0)
	local var_18_0, var_18_1 = transformhelper.getLocalPos(arg_18_0._goScrollContent.transform)

	transformhelper.setLocalPosXY(arg_18_0._goScrollContent.transform, var_18_0, arg_18_0._initScrollContentPosY)
	CharacterModel.instance:setCardListByLevel(false, CharacterEnum.FilterType.HeroGroup)
	arg_18_0:_refreshCurScrollBySort()
	arg_18_0:_refreshBtnIcon()
end

function var_0_0._btnrarerankOnClick(arg_19_0)
	local var_19_0, var_19_1 = transformhelper.getLocalPos(arg_19_0._goScrollContent.transform)

	transformhelper.setLocalPosXY(arg_19_0._goScrollContent.transform, var_19_0, arg_19_0._initScrollContentPosY)
	CharacterModel.instance:setCardListByRare(false, CharacterEnum.FilterType.HeroGroup)
	arg_19_0:_refreshCurScrollBySort()
	arg_19_0:_refreshBtnIcon()
end

function var_0_0._btnquickeditOnClick(arg_20_0)
	arg_20_0._isShowQuickEdit = not arg_20_0._isShowQuickEdit

	arg_20_0:_refreshBtnIcon()
	arg_20_0:_refreshEditMode()

	if arg_20_0._isShowQuickEdit then
		arg_20_0:_onHeroItemClick(nil)
		arg_20_0._heroGroupQuickEditListModel:cancelAllSelected()
		arg_20_0._heroGroupQuickEditListModel:copyQuickEditCardList()

		local var_20_0 = arg_20_0._heroGroupQuickEditListModel:getById(arg_20_0._originalHeroUid)

		if var_20_0 then
			local var_20_1 = arg_20_0._heroGroupQuickEditListModel:getIndex(var_20_0)

			arg_20_0._heroGroupQuickEditListModel:selectCell(var_20_1, true)
		end
	else
		arg_20_0:_saveQuickGroupInfo()
		arg_20_0:_onHeroItemClick(nil)
		arg_20_0._heroGroupEditListModel:cancelAllSelected()

		local var_20_2 = arg_20_0._heroSingleGroupModel:getHeroUid(arg_20_0._singleGroupMOId)

		if var_20_2 ~= "0" then
			local var_20_3 = arg_20_0._heroGroupEditListModel:getById(var_20_2)
			local var_20_4 = arg_20_0._heroGroupEditListModel:getIndex(var_20_3)

			arg_20_0._heroGroupEditListModel:selectCell(var_20_4, true)
		end

		arg_20_0._heroGroupEditListModel:copyCharacterCardList()
	end
end

function var_0_0._attrBtnOnClick(arg_21_0, arg_21_1)
	arg_21_0._selectAttrs[arg_21_1] = not arg_21_0._selectAttrs[arg_21_1]

	arg_21_0:_refreshFilterView()
end

function var_0_0._dmgBtnOnClick(arg_22_0, arg_22_1)
	if not arg_22_0._selectDmgs[arg_22_1] then
		arg_22_0._selectDmgs[3 - arg_22_1] = arg_22_0._selectDmgs[arg_22_1]
	end

	arg_22_0._selectDmgs[arg_22_1] = not arg_22_0._selectDmgs[arg_22_1]

	arg_22_0:_refreshFilterView()
end

function var_0_0._locationBtnOnClick(arg_23_0, arg_23_1)
	arg_23_0._selectLocations[arg_23_1] = not arg_23_0._selectLocations[arg_23_1]

	arg_23_0:_refreshFilterView()
end

function var_0_0._onHeroItemClick(arg_24_0, arg_24_1)
	arg_24_0._heroMO = arg_24_1

	arg_24_0:_refreshCharacterInfo()
end

function var_0_0._refreshCharacterInfo(arg_25_0)
	if arg_25_0._heroMO then
		gohelper.setActive(arg_25_0._gononecharacter, false)
		gohelper.setActive(arg_25_0._gocharacterinfo, true)
		arg_25_0:_refreshSkill()
		arg_25_0:_refreshMainInfo()
		arg_25_0:_refreshAttribute()
		arg_25_0:_refreshPassiveSkill()
	else
		gohelper.setActive(arg_25_0._gononecharacter, true)
		gohelper.setActive(arg_25_0._gocharacterinfo, false)
	end
end

function var_0_0._refreshMainInfo(arg_26_0)
	if arg_26_0._heroMO then
		gohelper.setActive(arg_26_0._btntrial.gameObject, arg_26_0._heroMO:isTrial())
		gohelper.setActive(arg_26_0._btntrialWithTalent.gameObject, arg_26_0._heroMO:isTrial())
		UISpriteSetMgr.instance:setCommonSprite(arg_26_0._imagecareericon, "sx_biandui_" .. tostring(arg_26_0._heroMO.config.career))
		UISpriteSetMgr.instance:setCommonSprite(arg_26_0._imagedmgtype, "dmgtype" .. tostring(arg_26_0._heroMO.config.dmgType))

		arg_26_0._txtname.text = arg_26_0._heroMO.config.name
		arg_26_0._txtnameen.text = arg_26_0._heroMO.config.nameEng

		local var_26_0, var_26_1 = V1a6_CachotTeamModel.instance:getHeroMaxLevel(arg_26_0._heroMO, arg_26_0._seatLevel)
		local var_26_2, var_26_3 = HeroConfig.instance:getShowLevel(var_26_0)
		local var_26_4 = var_26_3 >= CharacterEnum.TalentRank

		if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) then
			var_26_4 = false
		end

		local var_26_5 = 0
		local var_26_6 = 0
		local var_26_7 = 0
		local var_26_8 = false

		if not arg_26_0._heroMO:isTrial() then
			local var_26_9

			var_26_5, var_26_9, var_26_7 = HeroGroupBalanceHelper.getHeroBalanceInfo(arg_26_0._heroMO.heroId)

			if var_26_9 and var_26_9 >= CharacterEnum.TalentRank and var_26_7 > 0 then
				var_26_8 = true
			end
		end

		local var_26_10 = var_26_5 and var_26_5 > arg_26_0._heroMO.level
		local var_26_11 = var_26_8 and (not var_26_4 or var_26_7 > arg_26_0._heroMO.talent)

		if var_26_4 or var_26_8 then
			gohelper.setActive(arg_26_0._golevel, false)
			gohelper.setActive(arg_26_0._golevelWithTalent, true)
			gohelper.setActive(arg_26_0._goBalanceWithTalent, var_26_10 or var_26_11)
			gohelper.setActive(arg_26_0._goheroLvTxtWithTalent, true)

			if var_26_10 then
				local var_26_12, var_26_13 = HeroConfig.instance:getShowLevel(var_26_5)
				local var_26_14 = CharacterModel.instance:getrankEffects(arg_26_0._heroMO.heroId, var_26_13)[1]
				local var_26_15 = HeroConfig.instance:getShowLevel(var_26_14)

				arg_26_0._txtlevelWithTalent.text = "<color=#8fb1cc>" .. tostring(var_26_12)
				arg_26_0._txtlevelmaxWithTalent.text = string.format("/%d", var_26_15)
			else
				local var_26_16, var_26_17 = V1a6_CachotTeamModel.instance:getHeroMaxLevel(arg_26_0._heroMO, arg_26_0._seatLevel)
				local var_26_18, var_26_19 = HeroConfig.instance:getShowLevel(var_26_16)
				local var_26_20 = CharacterModel.instance:getrankEffects(arg_26_0._heroMO.heroId, var_26_19)[1]
				local var_26_21 = HeroConfig.instance:getShowLevel(var_26_20)

				arg_26_0._txtlevelWithTalent.text = tostring(var_26_18)
				arg_26_0._txtlevelmaxWithTalent.text = string.format("/%d", var_26_21)
			end

			if var_26_11 then
				arg_26_0._txttalent.text = "<color=#8fb1cc>Lv.<size=40>" .. tostring(var_26_7)
			else
				local var_26_22, var_26_23 = V1a6_CachotTeamModel.instance:getHeroMaxLevel(arg_26_0._heroMO, arg_26_0._seatLevel)

				arg_26_0._txttalent.text = "Lv.<size=40>" .. tostring(var_26_23)
			end
		else
			gohelper.setActive(arg_26_0._golevel, true)
			gohelper.setActive(arg_26_0._golevelWithTalent, false)
			gohelper.setActive(arg_26_0._goBalance, var_26_10)
			gohelper.setActive(arg_26_0._goheroLvTxt, not var_26_10)

			if var_26_10 then
				local var_26_24, var_26_25 = HeroConfig.instance:getShowLevel(var_26_5)
				local var_26_26 = CharacterModel.instance:getrankEffects(arg_26_0._heroMO.heroId, var_26_25)[1]
				local var_26_27 = HeroConfig.instance:getShowLevel(var_26_26)

				arg_26_0._txtlevel.text = "<color=#8fb1cc>" .. tostring(var_26_24)
				arg_26_0._txtlevelmax.text = string.format("/%d", var_26_27)
			else
				local var_26_28, var_26_29 = V1a6_CachotTeamModel.instance:getHeroMaxLevel(arg_26_0._heroMO, arg_26_0._seatLevel)
				local var_26_30, var_26_31 = HeroConfig.instance:getShowLevel(var_26_28)
				local var_26_32 = CharacterModel.instance:getrankEffects(arg_26_0._heroMO.heroId, var_26_31)[1]
				local var_26_33 = HeroConfig.instance:getShowLevel(var_26_32)

				arg_26_0._txtlevel.text = tostring(var_26_30)
				arg_26_0._txtlevelmax.text = string.format("/%d", var_26_33)
			end
		end

		local var_26_34 = {}

		if not string.nilorempty(arg_26_0._heroMO.config.battleTag) then
			var_26_34 = string.split(arg_26_0._heroMO.config.battleTag, "#")
		end

		for iter_26_0 = 1, #var_26_34 do
			local var_26_35 = arg_26_0._careerGOs[iter_26_0]

			if not var_26_35 then
				var_26_35 = arg_26_0:getUserDataTb_()
				var_26_35.go = gohelper.cloneInPlace(arg_26_0._gospecialitem, "item" .. iter_26_0)
				var_26_35.textfour = gohelper.findChildText(var_26_35.go, "#go_fourword/name")
				var_26_35.textthree = gohelper.findChildText(var_26_35.go, "#go_threeword/name")
				var_26_35.texttwo = gohelper.findChildText(var_26_35.go, "#go_twoword/name")
				var_26_35.containerfour = gohelper.findChild(var_26_35.go, "#go_fourword")
				var_26_35.containerthree = gohelper.findChild(var_26_35.go, "#go_threeword")
				var_26_35.containertwo = gohelper.findChild(var_26_35.go, "#go_twoword")

				table.insert(arg_26_0._careerGOs, var_26_35)
			end

			local var_26_36 = HeroConfig.instance:getBattleTagConfigCO(var_26_34[iter_26_0]).tagName
			local var_26_37 = GameUtil.utf8len(var_26_36)

			gohelper.setActive(var_26_35.containertwo, var_26_37 <= 2)
			gohelper.setActive(var_26_35.containerthree, var_26_37 == 3)
			gohelper.setActive(var_26_35.containerfour, var_26_37 >= 4)

			if var_26_37 <= 2 then
				var_26_35.texttwo.text = var_26_36
			elseif var_26_37 == 3 then
				var_26_35.textthree.text = var_26_36
			else
				var_26_35.textfour.text = var_26_36
			end

			gohelper.setActive(var_26_35.go, true)
		end

		for iter_26_1 = #var_26_34 + 1, #arg_26_0._careerGOs do
			gohelper.setActive(arg_26_0._careerGOs[iter_26_1].go, false)
		end
	end
end

function var_0_0._modifyEquipMo(arg_27_0, arg_27_1)
	local var_27_0 = V1a6_CachotTeamModel.instance:getEquipMaxLevel(arg_27_1, arg_27_0._seatLevel)

	if var_27_0 == arg_27_1.level then
		return arg_27_1
	end

	local var_27_1 = EquipMO.New()

	var_27_1:initByConfig(nil, arg_27_1.equipId, var_27_0, arg_27_1.refineLv)

	return var_27_1
end

function var_0_0._refreshAttribute(arg_28_0)
	arg_28_0._talentCubeInfos = nil

	if arg_28_0._heroMO then
		local var_28_0, var_28_1 = V1a6_CachotTeamModel.instance:getHeroMaxLevel(arg_28_0._heroMO, arg_28_0._seatLevel)
		local var_28_2, var_28_3 = HeroConfig.instance:getShowLevel(var_28_0)
		local var_28_4

		if var_28_1 ~= arg_28_0._heroMO.talent and OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) then
			var_28_4 = var_28_3 >= CharacterEnum.TalentRank and HeroMo.getTalentCubeInfos(arg_28_0._heroMO.heroId, var_28_1) or nil
			arg_28_0._talentCubeInfos = var_28_4
		end

		local var_28_5 = arg_28_0._heroMO:getCachotTotalBaseAttrDict(arg_28_0._equips, var_28_0, var_28_3, nil, var_28_4, arg_28_0._modifyEquipMo, arg_28_0)

		for iter_28_0, iter_28_1 in ipairs(CharacterEnum.BaseAttrIdList) do
			local var_28_6 = HeroConfig.instance:getHeroAttributeCO(iter_28_1)

			arg_28_0._attributevalues[iter_28_0].name.text = var_28_6.name
			arg_28_0._attributevalues[iter_28_0].value.text = var_28_5[iter_28_1]

			CharacterController.instance:SetAttriIcon(arg_28_0._attributevalues[iter_28_0].icon, iter_28_1)
		end
	end
end

function var_0_0._refreshPassiveSkill(arg_29_0)
	if not arg_29_0._heroMO then
		return
	end

	local var_29_0 = SkillConfig.instance:getpassiveskillsCO(arg_29_0._heroMO.heroId)
	local var_29_1 = var_29_0[1].skillPassive
	local var_29_2 = lua_skill.configDict[var_29_1]

	if not var_29_2 then
		logError("找不到角色被动技能, skillId: " .. tostring(var_29_1))
	else
		arg_29_0._txtpassivename.text = var_29_2.name
	end

	local var_29_3 = 0

	if not arg_29_0._heroMO:isTrial() then
		var_29_3 = HeroGroupBalanceHelper.getHeroBalanceLv(arg_29_0._heroMO.heroId)
	end

	local var_29_4, var_29_5 = V1a6_CachotTeamModel.instance:getHeroMaxLevel(arg_29_0._heroMO, arg_29_0._seatLevel)
	local var_29_6 = var_29_4 < var_29_3
	local var_29_7, var_29_8 = SkillConfig.instance:getHeroExSkillLevelByLevel(arg_29_0._heroMO.heroId, math.max(var_29_4, var_29_3))

	for iter_29_0 = 1, #var_29_0 do
		local var_29_9 = iter_29_0 <= var_29_7

		gohelper.setActive(arg_29_0._passiveskillitems[iter_29_0].on, var_29_9 and not var_29_6)
		gohelper.setActive(arg_29_0._passiveskillitems[iter_29_0].off, not var_29_9)
		gohelper.setActive(arg_29_0._passiveskillitems[iter_29_0].balance, var_29_9 and var_29_6)
		gohelper.setActive(arg_29_0._passiveskillitems[iter_29_0].go, true)
	end

	for iter_29_1 = #var_29_0 + 1, #arg_29_0._passiveskillitems do
		gohelper.setActive(arg_29_0._passiveskillitems[iter_29_1].go, false)
	end
end

function var_0_0._refreshSkill(arg_30_0)
	arg_30_0._skillContainer:onUpdateMO(arg_30_0._heroMO and arg_30_0._heroMO.heroId, nil, arg_30_0._heroMO, HeroGroupBalanceHelper.getIsBalanceMode() and not arg_30_0._heroMO:isTrial())
end

function var_0_0._refreshBtnIcon(arg_31_0)
	local var_31_0 = CharacterModel.instance:getRankState()
	local var_31_1 = CharacterModel.instance:getBtnTag(CharacterEnum.FilterType.HeroGroup)

	gohelper.setActive(arg_31_0._lvBtns[1], var_31_1 ~= 1)
	gohelper.setActive(arg_31_0._lvBtns[2], var_31_1 == 1)
	gohelper.setActive(arg_31_0._rareBtns[1], var_31_1 ~= 2)
	gohelper.setActive(arg_31_0._rareBtns[2], var_31_1 == 2)

	local var_31_2 = false

	for iter_31_0, iter_31_1 in pairs(arg_31_0._selectDmgs) do
		if iter_31_1 then
			var_31_2 = true
		end
	end

	for iter_31_2, iter_31_3 in pairs(arg_31_0._selectAttrs) do
		if iter_31_3 then
			var_31_2 = true
		end
	end

	for iter_31_4, iter_31_5 in pairs(arg_31_0._selectLocations) do
		if iter_31_5 then
			var_31_2 = true
		end
	end

	gohelper.setActive(arg_31_0._classifyBtns[1], not var_31_2)
	gohelper.setActive(arg_31_0._classifyBtns[2], var_31_2)
	transformhelper.setLocalScale(arg_31_0._lvArrow[1], 1, var_31_0[1], 1)
	transformhelper.setLocalScale(arg_31_0._lvArrow[2], 1, var_31_0[1], 1)
	transformhelper.setLocalScale(arg_31_0._rareArrow[1], 1, var_31_0[2], 1)
	transformhelper.setLocalScale(arg_31_0._rareArrow[2], 1, var_31_0[2], 1)
end

function var_0_0._refreshFilterView(arg_32_0)
	for iter_32_0 = 1, 2 do
		gohelper.setActive(arg_32_0._dmgUnselects[iter_32_0], not arg_32_0._selectDmgs[iter_32_0])
		gohelper.setActive(arg_32_0._dmgSelects[iter_32_0], arg_32_0._selectDmgs[iter_32_0])
	end

	for iter_32_1 = 1, 6 do
		gohelper.setActive(arg_32_0._attrUnselects[iter_32_1], not arg_32_0._selectAttrs[iter_32_1])
		gohelper.setActive(arg_32_0._attrSelects[iter_32_1], arg_32_0._selectAttrs[iter_32_1])
	end

	for iter_32_2 = 1, 6 do
		gohelper.setActive(arg_32_0._locationUnselects[iter_32_2], not arg_32_0._selectLocations[iter_32_2])
		gohelper.setActive(arg_32_0._locationSelects[iter_32_2], arg_32_0._selectLocations[iter_32_2])
	end
end

function var_0_0._updateHeroList(arg_33_0)
	local var_33_0 = {}

	for iter_33_0 = 1, 2 do
		if arg_33_0._selectDmgs[iter_33_0] then
			table.insert(var_33_0, iter_33_0)
		end
	end

	local var_33_1 = {}

	for iter_33_1 = 1, 6 do
		if arg_33_0._selectAttrs[iter_33_1] then
			table.insert(var_33_1, iter_33_1)
		end
	end

	local var_33_2 = {}

	for iter_33_2 = 1, 6 do
		if arg_33_0._selectLocations[iter_33_2] then
			table.insert(var_33_2, iter_33_2)
		end
	end

	if #var_33_0 == 0 then
		var_33_0 = {
			1,
			2
		}
	end

	if #var_33_1 == 0 then
		var_33_1 = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	if #var_33_2 == 0 then
		var_33_2 = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	local var_33_3 = {
		dmgs = var_33_0,
		careers = var_33_1,
		locations = var_33_2
	}

	CharacterModel.instance:filterCardListByDmgAndCareer(var_33_3, false, CharacterEnum.FilterType.HeroGroup)
	arg_33_0:_refreshBtnIcon()

	if arg_33_0._isShowQuickEdit then
		arg_33_0._heroGroupQuickEditListModel:copyQuickEditCardList()
	else
		arg_33_0._heroGroupEditListModel:copyCharacterCardList()
	end
end

function var_0_0.replaceSelectHeroDefaultEquip(arg_34_0)
	if arg_34_0._heroMO and arg_34_0._heroMO:hasDefaultEquip() then
		local var_34_0 = arg_34_0._heroSingleGroupModel:getCurGroupMO().equips

		for iter_34_0, iter_34_1 in pairs(var_34_0) do
			if iter_34_1.equipUid[1] == arg_34_0._heroMO.defaultEquipUid then
				iter_34_1.equipUid[1] = "0"
			end
		end

		var_34_0[arg_34_0._singleGroupMOId - 1].equipUid[1] = arg_34_0._heroMO.defaultEquipUid
	end
end

function var_0_0.replaceFightSelectHeroDefaultEquip(arg_35_0)
	local var_35_0 = V1a6_CachotModel.instance:getTeamInfo()

	if arg_35_0._heroMO and arg_35_0._heroMO:hasDefaultEquip() and var_35_0:hasEquip(arg_35_0._heroMO.defaultEquipUid) then
		local var_35_1 = arg_35_0._heroSingleGroupModel:getCurGroupMO().equips

		for iter_35_0, iter_35_1 in pairs(var_35_1) do
			if iter_35_1.equipUid[1] == arg_35_0._heroMO.defaultEquipUid then
				iter_35_1.equipUid[1] = "0"
			end
		end

		var_35_1[arg_35_0._singleGroupMOId - 1].equipUid[1] = arg_35_0._heroMO.defaultEquipUid
	end
end

function var_0_0.replaceQuickGroupHeroDefaultEquip(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0._heroSingleGroupModel:getCurGroupMO().equips
	local var_36_1

	for iter_36_0, iter_36_1 in ipairs(arg_36_1) do
		local var_36_2 = HeroModel.instance:getById(iter_36_1)

		if var_36_2 and var_36_2:hasDefaultEquip() then
			for iter_36_2, iter_36_3 in pairs(var_36_0) do
				if iter_36_3.equipUid[1] == var_36_2.defaultEquipUid then
					iter_36_3.equipUid[1] = "0"

					break
				end
			end

			var_36_0[iter_36_0 - 1].equipUid[1] = var_36_2.defaultEquipUid
		end
	end
end

function var_0_0._saveCurGroupInfo(arg_37_0)
	if arg_37_0.viewParam.heroGroupEditType ~= V1a6_CachotEnum.HeroGroupEditType.Fight then
		if arg_37_0.viewParam.heroGroupEditType == V1a6_CachotEnum.HeroGroupEditType.Init then
			arg_37_0:replaceSelectHeroDefaultEquip()

			local var_37_0 = arg_37_0._heroSingleGroupModel:getCurGroupMO()
			local var_37_1 = V1a6_CachotHeroSingleGroupModel.instance:getList()

			var_37_0:replaceHeroList(var_37_1)
		end

		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)

		return
	end

	local var_37_2 = arg_37_0._heroSingleGroupModel:getHeroUids()
	local var_37_3 = arg_37_0._heroSingleGroupModel:getCurGroupMO()

	arg_37_0:replaceFightSelectHeroDefaultEquip()
	arg_37_0._heroGroupModel:replaceSingleGroup()
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	arg_37_0._heroGroupModel:saveCurGroupData()
	arg_37_0._heroGroupModel:cachotSaveCurGroup()
end

function var_0_0._saveQuickGroupInfo(arg_38_0)
	if arg_38_0._heroGroupQuickEditListModel:getIsDirty() then
		local var_38_0 = arg_38_0._heroGroupQuickEditListModel:getHeroUids()
		local var_38_1 = arg_38_0._heroSingleGroupModel:getCurGroupMO()

		arg_38_0:replaceQuickGroupHeroDefaultEquip(var_38_0)

		for iter_38_0 = 1, arg_38_0._heroGroupModel:getBattleRoleNum() do
			local var_38_2 = var_38_0[iter_38_0]

			if var_38_2 ~= nil then
				arg_38_0._heroSingleGroupModel:addTo(var_38_2, iter_38_0)

				local var_38_3 = arg_38_0._heroSingleGroupModel:getByIndex(iter_38_0)

				if tonumber(var_38_2) < 0 then
					local var_38_4 = HeroGroupTrialModel.instance:getById(var_38_2)

					if var_38_4 then
						var_38_3:setTrial(var_38_4.trialCo.id, var_38_4.trialCo.trialTemplate)
					else
						var_38_3:setTrial()
					end
				else
					var_38_3:setTrial()
				end
			end
		end

		arg_38_0._heroGroupModel:replaceSingleGroup()
		arg_38_0._heroGroupModel:replaceSingleGroupEquips()
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
		arg_38_0._heroGroupModel:saveCurGroupData()
	end
end

function var_0_0._onAttributeChanged(arg_39_0, arg_39_1, arg_39_2)
	CharacterModel.instance:setFakeLevel(arg_39_2, arg_39_1)
end

function var_0_0._normalEditHasChange(arg_40_0)
	if Activity104Model.instance:isSeasonChapter() then
		return true
	end

	if arg_40_0._heroSingleGroupModel:getHeroUid(arg_40_0._singleGroupMOId) ~= arg_40_0._originalHeroUid then
		return true
	end

	if arg_40_0._originalHeroUid and arg_40_0._heroMO and arg_40_0._originalHeroUid == arg_40_0._heroMO.uid then
		return false
	elseif (not arg_40_0._originalHeroUid or arg_40_0._originalHeroUid == "0") and not arg_40_0._heroMO then
		return false
	else
		return true
	end
end

function var_0_0._refreshEditMode(arg_41_0)
	gohelper.setActive(arg_41_0._scrollquickedit.gameObject, arg_41_0._isShowQuickEdit)
	gohelper.setActive(arg_41_0._scrollcard.gameObject, not arg_41_0._isShowQuickEdit)
	gohelper.setActive(arg_41_0._goBtnEditQuickMode.gameObject, arg_41_0._isShowQuickEdit)
	gohelper.setActive(arg_41_0._goBtnEditNormalMode.gameObject, not arg_41_0._isShowQuickEdit)
end

function var_0_0._refreshCurScrollBySort(arg_42_0)
	if arg_42_0._isShowQuickEdit then
		if arg_42_0._heroGroupQuickEditListModel:getIsDirty() then
			arg_42_0:_saveQuickGroupInfo()
		end

		local var_42_0 = arg_42_0._heroMO

		arg_42_0._heroGroupQuickEditListModel:copyQuickEditCardList()

		if var_42_0 ~= arg_42_0._heroMO then
			arg_42_0._heroGroupQuickEditListModel:cancelAllSelected()
		end
	else
		arg_42_0._heroGroupEditListModel:copyCharacterCardList()
	end
end

function var_0_0._onGroupModify(arg_43_0)
	if arg_43_0._isShowQuickEdit then
		arg_43_0._heroGroupQuickEditListModel:copyQuickEditCardList()
	else
		local var_43_0 = arg_43_0._heroSingleGroupModel:getHeroUid(arg_43_0._singleGroupMOId)

		if arg_43_0._originalHeroUid ~= var_43_0 then
			arg_43_0._originalHeroUid = var_43_0

			arg_43_0._heroGroupEditListModel:setParam(var_43_0, arg_43_0._adventure)
			arg_43_0:_onHeroItemClick(nil)
			arg_43_0._heroGroupEditListModel:cancelAllSelected()

			local var_43_1 = arg_43_0._heroGroupEditListModel:getById(var_43_0)
			local var_43_2 = arg_43_0._heroGroupEditListModel:getIndex(var_43_1)

			arg_43_0._heroGroupEditListModel:selectCell(var_43_2, true)
		end

		arg_43_0._heroGroupEditListModel:copyCharacterCardList()
	end
end

function var_0_0._editableInitView(arg_44_0)
	gohelper.setActive(arg_44_0._gospecialitem, false)

	arg_44_0._careerGOs = {}
	arg_44_0._imgBg = gohelper.findChildSingleImage(arg_44_0.viewGO, "bg/bgimg")
	arg_44_0._simageredlight = gohelper.findChildSingleImage(arg_44_0.viewGO, "bg/#simage_redlight")

	arg_44_0._imgBg:LoadImage(ResUrl.getCommonViewBg("full/biandui_di"))
	arg_44_0._simageredlight:LoadImage(ResUrl.getHeroGroupBg("guang_027"))

	arg_44_0._lvBtns = arg_44_0:getUserDataTb_()
	arg_44_0._lvArrow = arg_44_0:getUserDataTb_()
	arg_44_0._rareBtns = arg_44_0:getUserDataTb_()
	arg_44_0._rareArrow = arg_44_0:getUserDataTb_()
	arg_44_0._classifyBtns = arg_44_0:getUserDataTb_()
	arg_44_0._selectDmgs = {}
	arg_44_0._dmgSelects = arg_44_0:getUserDataTb_()
	arg_44_0._dmgUnselects = arg_44_0:getUserDataTb_()
	arg_44_0._dmgBtnClicks = arg_44_0:getUserDataTb_()
	arg_44_0._selectAttrs = {}
	arg_44_0._attrSelects = arg_44_0:getUserDataTb_()
	arg_44_0._attrUnselects = arg_44_0:getUserDataTb_()
	arg_44_0._attrBtnClicks = arg_44_0:getUserDataTb_()
	arg_44_0._selectLocations = {}
	arg_44_0._locationSelects = arg_44_0:getUserDataTb_()
	arg_44_0._locationUnselects = arg_44_0:getUserDataTb_()
	arg_44_0._locationBtnClicks = arg_44_0:getUserDataTb_()
	arg_44_0._curDmgs = {}
	arg_44_0._curAttrs = {}
	arg_44_0._curLocations = {}

	for iter_44_0 = 1, 2 do
		arg_44_0._lvBtns[iter_44_0] = gohelper.findChild(arg_44_0._btnlvrank.gameObject, "btn" .. tostring(iter_44_0))
		arg_44_0._lvArrow[iter_44_0] = gohelper.findChild(arg_44_0._lvBtns[iter_44_0], "txt/arrow").transform
		arg_44_0._rareBtns[iter_44_0] = gohelper.findChild(arg_44_0._btnrarerank.gameObject, "btn" .. tostring(iter_44_0))
		arg_44_0._rareArrow[iter_44_0] = gohelper.findChild(arg_44_0._rareBtns[iter_44_0], "txt/arrow").transform
		arg_44_0._classifyBtns[iter_44_0] = gohelper.findChild(arg_44_0._btnclassify.gameObject, "btn" .. tostring(iter_44_0))
		arg_44_0._dmgUnselects[iter_44_0] = gohelper.findChild(arg_44_0._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. iter_44_0 .. "/unselected")
		arg_44_0._dmgSelects[iter_44_0] = gohelper.findChild(arg_44_0._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. iter_44_0 .. "/selected")
		arg_44_0._dmgBtnClicks[iter_44_0] = gohelper.findChildButtonWithAudio(arg_44_0._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. iter_44_0 .. "/click")

		arg_44_0._dmgBtnClicks[iter_44_0]:AddClickListener(arg_44_0._dmgBtnOnClick, arg_44_0, iter_44_0)
	end

	for iter_44_1 = 1, 6 do
		arg_44_0._attrUnselects[iter_44_1] = gohelper.findChild(arg_44_0._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. iter_44_1 .. "/unselected")
		arg_44_0._attrSelects[iter_44_1] = gohelper.findChild(arg_44_0._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. iter_44_1 .. "/selected")
		arg_44_0._attrBtnClicks[iter_44_1] = gohelper.findChildButtonWithAudio(arg_44_0._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. iter_44_1 .. "/click")

		arg_44_0._attrBtnClicks[iter_44_1]:AddClickListener(arg_44_0._attrBtnOnClick, arg_44_0, iter_44_1)
	end

	for iter_44_2 = 1, 6 do
		arg_44_0._locationUnselects[iter_44_2] = gohelper.findChild(arg_44_0._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. iter_44_2 .. "/unselected")
		arg_44_0._locationSelects[iter_44_2] = gohelper.findChild(arg_44_0._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. iter_44_2 .. "/selected")
		arg_44_0._locationBtnClicks[iter_44_2] = gohelper.findChildButtonWithAudio(arg_44_0._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. iter_44_2 .. "/click")

		arg_44_0._locationBtnClicks[iter_44_2]:AddClickListener(arg_44_0._locationBtnOnClick, arg_44_0, iter_44_2)
	end

	arg_44_0._goBtnEditQuickMode = gohelper.findChild(arg_44_0._btnquickedit.gameObject, "btn2")
	arg_44_0._goBtnEditNormalMode = gohelper.findChild(arg_44_0._btnquickedit.gameObject, "btn1")
	arg_44_0._attributevalues = {}

	for iter_44_3 = 1, 5 do
		local var_44_0 = arg_44_0:getUserDataTb_()

		var_44_0.value = gohelper.findChildText(arg_44_0._goattribute, "attribute" .. tostring(iter_44_3) .. "/txt_attribute")
		var_44_0.name = gohelper.findChildText(arg_44_0._goattribute, "attribute" .. tostring(iter_44_3) .. "/name")
		var_44_0.icon = gohelper.findChildImage(arg_44_0._goattribute, "attribute" .. tostring(iter_44_3) .. "/icon")
		arg_44_0._attributevalues[iter_44_3] = var_44_0
	end

	arg_44_0._passiveskillitems = {}

	for iter_44_4 = 1, 3 do
		local var_44_1 = arg_44_0:getUserDataTb_()

		var_44_1.go = gohelper.findChild(arg_44_0._gopassiveskills, "passiveskill" .. tostring(iter_44_4))
		var_44_1.on = gohelper.findChild(var_44_1.go, "on")
		var_44_1.off = gohelper.findChild(var_44_1.go, "off")
		var_44_1.balance = gohelper.findChild(var_44_1.go, "balance")
		arg_44_0._passiveskillitems[iter_44_4] = var_44_1
	end

	arg_44_0._skillContainer = MonoHelper.addNoUpdateLuaComOnceToGo(arg_44_0._goskill, CharacterSkillContainer)

	gohelper.setActive(arg_44_0._gononecharacter, false)
	gohelper.setActive(arg_44_0._gocharacterinfo, false)

	arg_44_0._animator = arg_44_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if GuideModel.instance:isGuideFinish(V1a6_CachotEnum.HelpUnlockGuideId) then
		arg_44_0._btntips:AddClickListener(arg_44_0._btntipsOnClick, arg_44_0)
	end
end

function var_0_0._initFakeLevelList(arg_45_0)
	if not arg_45_0.viewParam.seatLevel then
		return
	end

	local var_45_0 = {}
	local var_45_1 = HeroModel.instance:getList()

	for iter_45_0, iter_45_1 in ipairs(var_45_1) do
		local var_45_2 = V1a6_CachotTeamModel.instance:getHeroMaxLevel(iter_45_1, arg_45_0.viewParam.seatLevel)

		var_45_0[iter_45_1.heroId] = var_45_2
	end

	CharacterModel.instance:setFakeList(var_45_0)
end

function var_0_0.onOpen(arg_46_0)
	arg_46_0._isShowQuickEdit = false
	arg_46_0._scrollcard.verticalNormalizedPosition = 1
	arg_46_0._scrollquickedit.verticalNormalizedPosition = 1
	arg_46_0._originalHeroUid = arg_46_0.viewParam.originalHeroUid
	arg_46_0._singleGroupMOId = arg_46_0.viewParam.singleGroupMOId
	arg_46_0._adventure = arg_46_0.viewParam.adventure
	arg_46_0._equips = arg_46_0.viewParam.equips

	for iter_46_0 = 1, 2 do
		arg_46_0._selectDmgs[iter_46_0] = false
	end

	for iter_46_1 = 1, 6 do
		arg_46_0._selectAttrs[iter_46_1] = false
	end

	for iter_46_2 = 1, 6 do
		arg_46_0._selectLocations[iter_46_2] = false
	end

	arg_46_0._heroGroupEditListModel = V1a6_CachotHeroGroupEditListModel.instance
	arg_46_0._heroGroupQuickEditListModel = HeroGroupQuickEditListModel.instance
	arg_46_0._heroSingleGroupModel = V1a6_CachotHeroSingleGroupModel.instance
	arg_46_0._heroGroupModel = V1a6_CachotHeroGroupModel.instance

	arg_46_0:_initFakeLevelList()
	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.HeroGroup)
	CharacterModel.instance:setCardListByRareAndSort(false, CharacterEnum.FilterType.HeroGroup, false)
	arg_46_0._heroGroupEditListModel:setParam(arg_46_0._originalHeroUid, arg_46_0._adventure, arg_46_0._heroHps)
	arg_46_0._heroGroupQuickEditListModel:setParam(arg_46_0._adventure, arg_46_0._heroHps)
	arg_46_0._heroGroupEditListModel:setHeroGroupEditType(arg_46_0.viewParam.heroGroupEditType)
	arg_46_0.viewContainer:_setHomeBtnVisible(arg_46_0.viewParam.heroGroupEditType == V1a6_CachotEnum.HeroGroupEditType.Fight)

	local var_46_0 = arg_46_0.viewParam.seatLevel

	arg_46_0._seatLevel = var_46_0

	arg_46_0._heroGroupEditListModel:setSeatLevel(var_46_0)
	gohelper.setActive(arg_46_0._goseatlevel, var_46_0)

	if var_46_0 then
		UISpriteSetMgr.instance:setV1a6CachotSprite(arg_46_0._seatIcon, "v1a6_cachot_quality_0" .. var_46_0)

		if not arg_46_0._qualityEffectList then
			arg_46_0._qualityEffectList = arg_46_0:getUserDataTb_()

			local var_46_1 = arg_46_0._seatEffect.transform
			local var_46_2 = var_46_1.childCount

			for iter_46_3 = 1, var_46_2 do
				local var_46_3 = var_46_1:GetChild(iter_46_3 - 1)

				arg_46_0._qualityEffectList[var_46_3.name] = var_46_3
			end
		end

		local var_46_4 = "effect_0" .. var_46_0

		for iter_46_4, iter_46_5 in pairs(arg_46_0._qualityEffectList) do
			gohelper.setActive(iter_46_5, iter_46_4 == var_46_4)
		end
	end

	arg_46_0._heroMO = arg_46_0._heroGroupEditListModel:copyCharacterCardList(true)

	arg_46_0:_refreshEditMode()
	arg_46_0:_refreshBtnIcon()
	arg_46_0:_refreshCharacterInfo()
	gohelper.setActive(arg_46_0._btnquickedit, false)
	gohelper.setActive(arg_46_0._btncancel, not arg_46_0.viewParam.hideCancel)
	gohelper.setActive(arg_46_0._btncharacter, false)
	gohelper.setActive(arg_46_0._btncharacterWithTalent, false)

	if arg_46_0.viewParam.heroGroupEditType == V1a6_CachotEnum.HeroGroupEditType.Event then
		local var_46_5 = arg_46_0._heroGroupEditListModel:getList()

		gohelper.setActive(arg_46_0._goempty, #var_46_5 <= 0)

		if #V1a6_CachotModel.instance:getRogueInfo().teamInfo:getAllHeroUids() >= #var_46_5 then
			gohelper.setActive(arg_46_0._btncancel, true)
			gohelper.setActive(arg_46_0._btnconfirm, false)
			recthelper.setAnchorX(arg_46_0._btncancel.transform, -192)
		end
	end

	arg_46_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_46_0._updateHeroList, arg_46_0)
	arg_46_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_46_0._updateHeroList, arg_46_0)
	arg_46_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_46_0._updateHeroList, arg_46_0)
	arg_46_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroEditItem, arg_46_0._onHeroItemClick, arg_46_0)
	arg_46_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_46_0._refreshCharacterInfo, arg_46_0)
	arg_46_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_46_0._refreshCharacterInfo, arg_46_0)
	arg_46_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_46_0._refreshCharacterInfo, arg_46_0)
	arg_46_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, arg_46_0._refreshCharacterInfo, arg_46_0)
	arg_46_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_46_0._refreshCharacterInfo, arg_46_0)
	arg_46_0:addEventCb(CharacterController.instance, CharacterEvent.levelUpAttribute, arg_46_0._onAttributeChanged, arg_46_0)
	arg_46_0:addEventCb(CharacterController.instance, CharacterEvent.showCharacterRankUpView, arg_46_0._showCharacterRankUpView, arg_46_0)
	arg_46_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_46_0._onGroupModify, arg_46_0)
	arg_46_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_46_0._onGroupModify, arg_46_0)
	arg_46_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_46_0._onOpenView, arg_46_0)
	arg_46_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_46_0._onCloseView, arg_46_0)
	gohelper.addUIClickAudio(arg_46_0._btnlvrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_46_0._btnrarerank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_46_0._btnexskillrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_46_0._btnattribute.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_46_0._btnpassiveskill.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_46_0._btncharacter.gameObject, AudioEnum.UI.UI_Common_Click)

	_, arg_46_0._initScrollContentPosY = transformhelper.getLocalPos(arg_46_0._goScrollContent.transform)
end

function var_0_0.onClose(arg_47_0)
	arg_47_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_47_0._updateHeroList, arg_47_0)
	arg_47_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_47_0._updateHeroList, arg_47_0)
	arg_47_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_47_0._updateHeroList, arg_47_0)
	arg_47_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroEditItem, arg_47_0._onHeroItemClick, arg_47_0)
	arg_47_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_47_0._refreshCharacterInfo, arg_47_0)
	arg_47_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_47_0._refreshCharacterInfo, arg_47_0)
	arg_47_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_47_0._refreshCharacterInfo, arg_47_0)
	arg_47_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, arg_47_0._refreshCharacterInfo, arg_47_0)
	arg_47_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_47_0._refreshCharacterInfo, arg_47_0)
	arg_47_0:removeEventCb(CharacterController.instance, CharacterEvent.levelUpAttribute, arg_47_0._onAttributeChanged, arg_47_0)
	arg_47_0:removeEventCb(CharacterController.instance, CharacterEvent.showCharacterRankUpView, arg_47_0._showCharacterRankUpView, arg_47_0)
	arg_47_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_47_0._onGroupModify, arg_47_0)
	arg_47_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_47_0._onGroupModify, arg_47_0)
	CharacterModel.instance:clearFakeList()
	CharacterModel.instance:setFakeLevel()
	arg_47_0._heroGroupEditListModel:cancelAllSelected()
	arg_47_0._heroGroupEditListModel:clear()
	arg_47_0._heroGroupQuickEditListModel:cancelAllSelected()
	arg_47_0._heroGroupQuickEditListModel:clear()
	HeroGroupTrialModel.instance:setFilter()
	CommonHeroHelper.instance:resetGrayState()

	arg_47_0._selectDmgs = {}
	arg_47_0._selectAttrs = {}
	arg_47_0._selectLocations = {}

	if arg_47_0._isStopBgm then
		TaskDispatcher.cancelTask(arg_47_0._delyStopBgm, arg_47_0)
		arg_47_0:_delyStopBgm()
	end
end

function var_0_0._onOpenView(arg_48_0, arg_48_1)
	if arg_48_1 == ViewName.CharacterView and arg_48_0._isStopBgm then
		TaskDispatcher.cancelTask(arg_48_0._delyStopBgm, arg_48_0)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Unsatisfied_Music)

		return
	end
end

function var_0_0._showRecommendCareer(arg_49_0)
	local var_49_0, var_49_1 = FightHelper.detectAttributeCounter()

	gohelper.CreateObjList(arg_49_0, arg_49_0._onRecommendCareerItemShow, var_49_0, arg_49_0._goattrlist, arg_49_0._goattritem)

	arg_49_0._txtrecommendAttrDesc.text = #var_49_0 == 0 and luaLang("herogroupeditview_notrecommend") or luaLang("herogroupeditview_recommend")

	gohelper.setActive(arg_49_0._goattrlist, #var_49_0 ~= 0)
end

function var_0_0._onRecommendCareerItemShow(arg_50_0, arg_50_1, arg_50_2, arg_50_3)
	local var_50_0 = gohelper.findChildImage(arg_50_1, "icon")

	UISpriteSetMgr.instance:setHeroGroupSprite(var_50_0, "career_" .. arg_50_2)
end

function var_0_0._onCloseView(arg_51_0, arg_51_1)
	if arg_51_1 == ViewName.CharacterView then
		AudioMgr.instance:trigger(AudioEnum.UI.Stop_UIMusic)

		arg_51_0._isStopBgm = true

		TaskDispatcher.cancelTask(arg_51_0._delyStopBgm, arg_51_0)
		TaskDispatcher.runDelay(arg_51_0._delyStopBgm, arg_51_0, 1)
	end
end

function var_0_0._delyStopBgm(arg_52_0)
	arg_52_0._isStopBgm = false

	AudioMgr.instance:trigger(AudioEnum.Bgm.Pause_FightingMusic)
end

function var_0_0._showCharacterRankUpView(arg_53_0, arg_53_1)
	arg_53_1()
end

function var_0_0.onDestroyView(arg_54_0)
	arg_54_0._imgBg:UnLoadImage()
	arg_54_0._simageredlight:UnLoadImage()

	arg_54_0._imgBg = nil
	arg_54_0._simageredlight = nil

	for iter_54_0 = 1, 2 do
		arg_54_0._dmgBtnClicks[iter_54_0]:RemoveClickListener()
	end

	for iter_54_1 = 1, 6 do
		arg_54_0._attrBtnClicks[iter_54_1]:RemoveClickListener()
	end

	for iter_54_2 = 1, 6 do
		arg_54_0._locationBtnClicks[iter_54_2]:RemoveClickListener()
	end
end

return var_0_0
