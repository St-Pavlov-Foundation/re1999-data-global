module("modules.logic.rouge.view.RougeHeroGroupEditView", package.seeall)

local var_0_0 = class("RougeHeroGroupEditView", BaseView)

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
	arg_1_0._gorank = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/level/#txt_level/#go_rank")
	arg_1_0._txtlevelmax = gohelper.findChildText(arg_1_0.viewGO, "characterinfo/#go_characterinfo/level/#txt_level/#txt_levelmax")
	arg_1_0._btncharacter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "characterinfo/#go_characterinfo/level/#btn_character")
	arg_1_0._btntrial = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "characterinfo/#go_characterinfo/level/#btn_trial")
	arg_1_0._goBalance = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/level/#go_balance")
	arg_1_0._goheroLvTxt = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/level/Text")
	arg_1_0._golevelWithTalent = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent")
	arg_1_0._txtlevelWithTalent = gohelper.findChildText(arg_1_0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_level")
	arg_1_0._gowithtalentrank = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_level/#go_rank")
	arg_1_0._txtlevelmaxWithTalent = gohelper.findChildText(arg_1_0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_level/#txt_levelmax")
	arg_1_0._btncharacterWithTalent = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#btn_character")
	arg_1_0._btntrialWithTalent = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#btn_trial")
	arg_1_0._goBalanceWithTalent = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#go_balance")
	arg_1_0._goheroLvTxtWithTalent = gohelper.findChild(arg_1_0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/Text")
	arg_1_0._txttalent = gohelper.findChildText(arg_1_0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_talent")
	arg_1_0._txttalenticon = gohelper.findChildImage(arg_1_0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_talent/icon")
	arg_1_0._txttalentType = gohelper.findChildText(arg_1_0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_talentType")
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
	arg_1_0._gorecommendAttrDesc = gohelper.findChild(arg_1_0.viewGO, "#go_recommendAttr")
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
	for iter_6_0 = 1, 2 do
		arg_6_0._selectDmgs[iter_6_0] = false
	end

	for iter_6_1 = 1, 6 do
		arg_6_0._selectAttrs[iter_6_1] = false
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
	var_8_0.isBalance = RougeHeroGroupBalanceHelper.getIsBalanceMode() and not arg_8_0._heroMO:isTrial()
	var_8_0.balanceHelper = RougeHeroGroupBalanceHelper

	CharacterController.instance:openCharacterTipView(var_8_0)
end

function var_0_0._btnconfirmOnClick(arg_9_0)
	if arg_9_0._adventure then
		local var_9_0 = arg_9_0._heroGroupQuickEditListModel:getHeroUids()

		if var_9_0 and #var_9_0 > 0 then
			for iter_9_0, iter_9_1 in pairs(var_9_0) do
				local var_9_1 = HeroModel.instance:getById(iter_9_1)

				if var_9_1 and WeekWalkModel.instance:getCurMapHeroCd(var_9_1.heroId) > 0 then
					GameFacade.showToast(ToastEnum.HeroGroupEdit)

					return
				end
			end
		elseif arg_9_0._heroMO and WeekWalkModel.instance:getCurMapHeroCd(arg_9_0._heroMO.heroId) > 0 then
			GameFacade.showToast(ToastEnum.HeroGroupEdit)

			return
		end
	end

	if arg_9_0._isShowQuickEdit then
		if arg_9_0.viewParam.heroGroupEditType == RougeEnum.HeroGroupEditType.SelectHero and #arg_9_0.viewContainer:getQuickSelectHeroList() <= 0 then
			GameFacade.showMessageBox(MessageBoxIdDefine.RougeTeamSelectedHeroConfirm, MsgBoxEnum.BoxType.Yes_No, function()
				arg_9_0:_saveQuickGroupInfo(true)
				arg_9_0:closeThis()
			end, nil, nil, arg_9_0)

			return
		end

		arg_9_0:_saveQuickGroupInfo(true)
		arg_9_0:closeThis()

		return
	end

	if not arg_9_0:_normalEditHasChange() then
		arg_9_0:closeThis()

		return
	end

	local var_9_2 = arg_9_0._heroSingleGroupModel:getById(arg_9_0._singleGroupMOId)

	if var_9_2.trialPos then
		GameFacade.showToast(ToastEnum.TrialCantTakeOff)

		return
	end

	if arg_9_0._heroMO then
		if arg_9_0._heroMO.isPosLock then
			GameFacade.showToast(ToastEnum.TrialCantTakeOff)

			return
		end

		if arg_9_0._heroMO:isTrial() and not arg_9_0._heroSingleGroupModel:isInGroup(arg_9_0._heroMO.uid) and (var_9_2:isEmpty() or not var_9_2.trial) and arg_9_0._heroGroupEditListModel:isTrialLimit() then
			GameFacade.showToast(ToastEnum.TrialJoinLimit, HeroGroupTrialModel.instance:getLimitNum())

			return
		end

		if arg_9_0:_isFightEditType() then
			local var_9_3 = RougeModel.instance:getTeamInfo():getHeroHp(arg_9_0._heroMO.heroId)

			if (var_9_3 and var_9_3.life or 0) <= 0 then
				GameFacade.showToast(ToastEnum.V1a6CachotToast04)

				return
			end
		end

		local var_9_4, var_9_5 = arg_9_0._heroSingleGroupModel:hasHeroUids(arg_9_0._heroMO.uid, arg_9_0._singleGroupMOId)

		if var_9_4 then
			arg_9_0._heroSingleGroupModel:removeFrom(var_9_5)
			arg_9_0._heroSingleGroupModel:addTo(arg_9_0._heroMO.uid, arg_9_0._singleGroupMOId)

			if arg_9_0._heroMO:isTrial() then
				var_9_2:setTrial(arg_9_0._heroMO.trialCo.id, arg_9_0._heroMO.trialCo.trialTemplate)
			else
				var_9_2:setTrial()
			end

			FightAudioMgr.instance:playHeroVoiceRandom(arg_9_0._heroMO.heroId, CharacterEnum.VoiceType.HeroGroup)
			arg_9_0:_saveCurGroupInfo()
			arg_9_0:closeThis()

			return
		end

		if arg_9_0._heroSingleGroupModel:isAidConflict(arg_9_0._heroMO.heroId) then
			GameFacade.showToast(ToastEnum.HeroIsAidConflict)

			return
		end

		arg_9_0._heroSingleGroupModel:addTo(arg_9_0._heroMO.uid, arg_9_0._singleGroupMOId)

		if arg_9_0._heroMO:isTrial() then
			var_9_2:setTrial(arg_9_0._heroMO.trialCo.id, arg_9_0._heroMO.trialCo.trialTemplate)
		else
			var_9_2:setTrial()
		end

		FightAudioMgr.instance:playHeroVoiceRandom(arg_9_0._heroMO.heroId, CharacterEnum.VoiceType.HeroGroup)
		arg_9_0:_saveCurGroupInfo()
		arg_9_0:closeThis()
	else
		arg_9_0._heroSingleGroupModel:removeFrom(arg_9_0._singleGroupMOId)
		arg_9_0:_saveCurGroupInfo()
		arg_9_0:closeThis()
	end
end

function var_0_0.checkTrialNum(arg_11_0)
	return false
end

function var_0_0._btncancelOnClick(arg_12_0)
	if arg_12_0.viewParam.heroGroupEditType == RougeEnum.HeroGroupEditType.SelectHero then
		arg_12_0.viewContainer:_overrideClose()

		return
	end

	arg_12_0:closeThis()
end

function var_0_0._btncharacterOnClick(arg_13_0)
	if arg_13_0._heroMO then
		local var_13_0

		if arg_13_0._isShowQuickEdit then
			var_13_0 = arg_13_0._heroGroupQuickEditListModel:getList()
		else
			var_13_0 = arg_13_0._heroGroupEditListModel:getList()
		end

		local var_13_1 = {}

		for iter_13_0, iter_13_1 in ipairs(var_13_0) do
			if not iter_13_1:isTrial() then
				table.insert(var_13_1, iter_13_1)
			end
		end

		CharacterController.instance:openCharacterView(arg_13_0._heroMO, var_13_1)
	end
end

function var_0_0._btntrialOnClick(arg_14_0)
	if arg_14_0._heroMO then
		local var_14_0

		if arg_14_0._isShowQuickEdit then
			var_14_0 = arg_14_0._heroGroupQuickEditListModel:getList()
		else
			var_14_0 = arg_14_0._heroGroupEditListModel:getList()
		end

		local var_14_1 = {}

		for iter_14_0, iter_14_1 in ipairs(var_14_0) do
			if iter_14_1:isTrial() then
				table.insert(var_14_1, iter_14_1)
			end
		end

		CharacterController.instance:openCharacterView(arg_14_0._heroMO, var_14_1)
	end
end

function var_0_0._btnattributeOnClick(arg_15_0)
	if arg_15_0._heroMO then
		local var_15_0 = HeroGroupTrialModel.instance:getById(arg_15_0._originalHeroUid)
		local var_15_1

		if var_15_0 then
			var_15_1 = var_15_0.trialEquipMo
		end

		local var_15_2 = {}

		var_15_2.tag = "attribute"
		var_15_2.heroid = arg_15_0._heroMO.heroId
		var_15_2.equips = arg_15_0._equips
		var_15_2.showExtraAttr = true
		var_15_2.fromHeroGroupEditView = true
		var_15_2.heroMo = arg_15_0._heroMO
		var_15_2.trialEquipMo = var_15_1
		var_15_2.isBalance = RougeHeroGroupBalanceHelper.getIsBalanceMode() and not arg_15_0._heroMO:isTrial()
		var_15_2.balanceHelper = RougeHeroGroupBalanceHelper

		CharacterController.instance:openCharacterTipView(var_15_2)
	end
end

function var_0_0._btnexskillrankOnClick(arg_16_0)
	local var_16_0, var_16_1 = transformhelper.getLocalPos(arg_16_0._goScrollContent.transform)

	transformhelper.setLocalPosXY(arg_16_0._goScrollContent.transform, var_16_0, arg_16_0._initScrollContentPosY)
	CharacterModel.instance:setCardListByExSkill(false, CharacterEnum.FilterType.HeroGroup)
	arg_16_0:_refreshCurScrollBySort()
	arg_16_0:_refreshBtnIcon()
end

function var_0_0._btnlvrankOnClick(arg_17_0)
	local var_17_0, var_17_1 = transformhelper.getLocalPos(arg_17_0._goScrollContent.transform)

	transformhelper.setLocalPosXY(arg_17_0._goScrollContent.transform, var_17_0, arg_17_0._initScrollContentPosY)
	CharacterModel.instance:setCardListByLevel(false, CharacterEnum.FilterType.HeroGroup)
	arg_17_0:_refreshCurScrollBySort()
	arg_17_0:_refreshBtnIcon()
end

function var_0_0._btnrarerankOnClick(arg_18_0)
	local var_18_0, var_18_1 = transformhelper.getLocalPos(arg_18_0._goScrollContent.transform)

	transformhelper.setLocalPosXY(arg_18_0._goScrollContent.transform, var_18_0, arg_18_0._initScrollContentPosY)
	CharacterModel.instance:setCardListByRare(false, CharacterEnum.FilterType.HeroGroup)
	arg_18_0:_refreshCurScrollBySort()
	arg_18_0:_refreshBtnIcon()
end

function var_0_0._btnquickeditOnClick(arg_19_0)
	arg_19_0._isShowQuickEdit = not arg_19_0._isShowQuickEdit

	arg_19_0:_refreshBtnIcon()
	arg_19_0:_refreshEditMode()

	if arg_19_0._isShowQuickEdit then
		arg_19_0:_onHeroItemClick(nil)
		arg_19_0._heroGroupQuickEditListModel:cancelAllSelected()
		arg_19_0._heroGroupQuickEditListModel:copyQuickEditCardList()

		local var_19_0 = arg_19_0._heroGroupQuickEditListModel:getById(arg_19_0._originalHeroUid)

		if var_19_0 then
			local var_19_1 = arg_19_0._heroGroupQuickEditListModel:getIndex(var_19_0)

			arg_19_0._heroGroupQuickEditListModel:selectCell(var_19_1, true)
		end
	else
		arg_19_0:_saveQuickGroupInfo()
		arg_19_0:_onHeroItemClick(nil)
		arg_19_0._heroGroupEditListModel:cancelAllSelected()

		local var_19_2 = arg_19_0._heroSingleGroupModel:getHeroUid(arg_19_0._singleGroupMOId)

		if var_19_2 ~= "0" then
			local var_19_3 = arg_19_0._heroGroupEditListModel:getById(var_19_2)
			local var_19_4 = arg_19_0._heroGroupEditListModel:getIndex(var_19_3)

			arg_19_0._heroGroupEditListModel:selectCell(var_19_4, true)
		end

		arg_19_0._heroGroupEditListModel:copyCharacterCardList()
	end

	arg_19_0:_updateTotalCapacity()
	RougeController.instance:dispatchEvent(RougeEvent.OnSwitchHeroGroupEditMode)
end

function var_0_0._attrBtnOnClick(arg_20_0, arg_20_1)
	arg_20_0._selectAttrs[arg_20_1] = not arg_20_0._selectAttrs[arg_20_1]

	arg_20_0:_refreshFilterView()
end

function var_0_0._dmgBtnOnClick(arg_21_0, arg_21_1)
	if not arg_21_0._selectDmgs[arg_21_1] then
		arg_21_0._selectDmgs[3 - arg_21_1] = arg_21_0._selectDmgs[arg_21_1]
	end

	arg_21_0._selectDmgs[arg_21_1] = not arg_21_0._selectDmgs[arg_21_1]

	arg_21_0:_refreshFilterView()
end

function var_0_0._locationBtnOnClick(arg_22_0, arg_22_1)
	arg_22_0._selectLocations[arg_22_1] = not arg_22_0._selectLocations[arg_22_1]

	arg_22_0:_refreshFilterView()
end

function var_0_0._onClickHeroEditItem(arg_23_0, arg_23_1)
	arg_23_0:_onHeroItemClick(arg_23_1)
	arg_23_0:_updateTotalCapacity()
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
		UISpriteSetMgr.instance:setCommonSprite(arg_26_0._imagecareericon, "lssx_" .. tostring(arg_26_0._heroMO.config.career))
		UISpriteSetMgr.instance:setCommonSprite(arg_26_0._imagedmgtype, "dmgtype" .. tostring(arg_26_0._heroMO.config.dmgType))

		arg_26_0._txtname.text = arg_26_0._heroMO.config.name
		arg_26_0._txtnameen.text = arg_26_0._heroMO.config.nameEng

		local var_26_0 = arg_26_0._heroMO.rank >= CharacterEnum.TalentRank and arg_26_0._heroMO.talent > 0

		if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) then
			var_26_0 = false
		end

		local var_26_1 = 0
		local var_26_2 = 0
		local var_26_3 = 0
		local var_26_4 = false

		if not arg_26_0._heroMO:isTrial() then
			local var_26_5

			var_26_1, var_26_5, var_26_3 = RougeHeroGroupBalanceHelper.getHeroBalanceInfo(arg_26_0._heroMO.heroId)

			if var_26_5 and var_26_5 >= CharacterEnum.TalentRank and var_26_3 > 0 then
				var_26_4 = true
			end
		end

		local var_26_6 = var_26_1 and var_26_1 > arg_26_0._heroMO.level
		local var_26_7 = var_26_4 and (not var_26_0 or var_26_3 > arg_26_0._heroMO.talent)

		if var_26_0 or var_26_4 then
			gohelper.setActive(arg_26_0._golevel, false)
			gohelper.setActive(arg_26_0._golevelWithTalent, true)
			gohelper.setActive(arg_26_0._goBalanceWithTalent, false)
			gohelper.setActive(arg_26_0._goheroLvTxtWithTalent, true)

			if var_26_6 then
				local var_26_8, var_26_9 = HeroConfig.instance:getShowLevel(var_26_1)
				local var_26_10 = CharacterModel.instance:getrankEffects(arg_26_0._heroMO.heroId, var_26_9)[1]
				local var_26_11 = HeroConfig.instance:getShowLevel(var_26_10)

				arg_26_0._txtlevelWithTalent.text = "<color=#8fb1cc>" .. tostring(var_26_8)
				arg_26_0._txtlevelmaxWithTalent.text = string.format("/%d", var_26_11)

				arg_26_0:refreshWithTalentRankIcon(var_26_9, true)
			else
				local var_26_12 = CharacterModel.instance:getrankEffects(arg_26_0._heroMO.heroId, arg_26_0._heroMO.rank)[1]
				local var_26_13 = HeroConfig.instance:getShowLevel(arg_26_0._heroMO.level)
				local var_26_14 = HeroConfig.instance:getShowLevel(var_26_12)

				arg_26_0._txtlevelWithTalent.text = tostring(var_26_13)
				arg_26_0._txtlevelmaxWithTalent.text = string.format("/%d", var_26_14)

				arg_26_0:refreshWithTalentRankIcon(arg_26_0._heroMO.rank)
			end

			if var_26_7 then
				arg_26_0._txttalent.text = "<color=#8fb1cc>Lv.<size=40>" .. tostring(var_26_3)
				arg_26_0._txttalenticon.color = GameUtil.parseColor("#89dafd")
			else
				arg_26_0._txttalent.text = "Lv.<size=40>" .. tostring(arg_26_0._heroMO.talent)
				arg_26_0._txttalenticon.color = GameUtil.parseColor("#D3CCBF")
			end

			arg_26_0._txttalentType.text = luaLang("talent_character_talentcn" .. arg_26_0._heroMO:getTalentTxtByHeroType())
		else
			gohelper.setActive(arg_26_0._golevel, true)
			gohelper.setActive(arg_26_0._golevelWithTalent, false)
			gohelper.setActive(arg_26_0._goBalance, false)
			gohelper.setActive(arg_26_0._goheroLvTxt, not var_26_6)

			if var_26_6 then
				local var_26_15, var_26_16 = HeroConfig.instance:getShowLevel(var_26_1)
				local var_26_17 = CharacterModel.instance:getrankEffects(arg_26_0._heroMO.heroId, var_26_16)[1]
				local var_26_18 = HeroConfig.instance:getShowLevel(var_26_17)

				arg_26_0._txtlevel.text = "<color=#8fb1cc>" .. tostring(var_26_15)
				arg_26_0._txtlevelmax.text = string.format("/%d", var_26_18)

				arg_26_0:refreshRankIcon(var_26_16, true)
			else
				local var_26_19 = CharacterModel.instance:getrankEffects(arg_26_0._heroMO.heroId, arg_26_0._heroMO.rank)[1]
				local var_26_20 = HeroConfig.instance:getShowLevel(arg_26_0._heroMO.level)
				local var_26_21 = HeroConfig.instance:getShowLevel(var_26_19)

				arg_26_0._txtlevel.text = tostring(var_26_20)
				arg_26_0._txtlevelmax.text = string.format("/%d", var_26_21)

				arg_26_0:refreshRankIcon(arg_26_0._heroMO.rank)
			end
		end

		local var_26_22 = {}

		if not string.nilorempty(arg_26_0._heroMO.config.battleTag) then
			var_26_22 = string.split(arg_26_0._heroMO.config.battleTag, "#")
		end

		for iter_26_0 = 1, #var_26_22 do
			local var_26_23 = arg_26_0._careerGOs[iter_26_0]

			if not var_26_23 then
				var_26_23 = arg_26_0:getUserDataTb_()
				var_26_23.go = gohelper.cloneInPlace(arg_26_0._gospecialitem, "item" .. iter_26_0)
				var_26_23.textfour = gohelper.findChildText(var_26_23.go, "#go_fourword/name")
				var_26_23.textthree = gohelper.findChildText(var_26_23.go, "#go_threeword/name")
				var_26_23.texttwo = gohelper.findChildText(var_26_23.go, "#go_twoword/name")
				var_26_23.containerfour = gohelper.findChild(var_26_23.go, "#go_fourword")
				var_26_23.containerthree = gohelper.findChild(var_26_23.go, "#go_threeword")
				var_26_23.containertwo = gohelper.findChild(var_26_23.go, "#go_twoword")

				table.insert(arg_26_0._careerGOs, var_26_23)
			end

			local var_26_24 = HeroConfig.instance:getBattleTagConfigCO(var_26_22[iter_26_0]).tagName
			local var_26_25 = GameUtil.utf8len(var_26_24)

			gohelper.setActive(var_26_23.containertwo, var_26_25 <= 2)
			gohelper.setActive(var_26_23.containerthree, var_26_25 == 3)
			gohelper.setActive(var_26_23.containerfour, var_26_25 >= 4)

			if var_26_25 <= 2 then
				var_26_23.texttwo.text = var_26_24
			elseif var_26_25 == 3 then
				var_26_23.textthree.text = var_26_24
			else
				var_26_23.textfour.text = var_26_24
			end

			gohelper.setActive(var_26_23.go, true)
		end

		for iter_26_1 = #var_26_22 + 1, #arg_26_0._careerGOs do
			gohelper.setActive(arg_26_0._careerGOs[iter_26_1].go, false)
		end
	end
end

function var_0_0.refreshRankIcon(arg_27_0, arg_27_1, arg_27_2)
	arg_27_0:initRankGoList()

	for iter_27_0, iter_27_1 in ipairs(arg_27_0.rankGoList) do
		gohelper.setActive(iter_27_1, iter_27_0 == arg_27_1 - 1)
		SLFramework.UGUI.GuiHelper.SetColor(iter_27_1:GetComponent(gohelper.Type_Image), arg_27_2 and "#89dafd" or "#D3CCBF")
	end
end

function var_0_0.initRankGoList(arg_28_0)
	if not arg_28_0.rankGoList then
		arg_28_0.rankGoList = arg_28_0:getUserDataTb_()

		for iter_28_0 = 1, 3 do
			table.insert(arg_28_0.rankGoList, gohelper.findChild(arg_28_0._gorank, "rank" .. iter_28_0))
		end
	end

	return arg_28_0.rankGoList
end

function var_0_0.refreshWithTalentRankIcon(arg_29_0, arg_29_1, arg_29_2)
	arg_29_0:initRankGoWithTalentList()

	for iter_29_0, iter_29_1 in ipairs(arg_29_0.rankGoWithTalentList) do
		gohelper.setActive(iter_29_1, iter_29_0 == arg_29_1 - 1)
		SLFramework.UGUI.GuiHelper.SetColor(iter_29_1:GetComponent(gohelper.Type_Image), arg_29_2 and "#89dafd" or "#D3CCBF")
	end
end

function var_0_0.initRankGoWithTalentList(arg_30_0)
	if not arg_30_0.rankGoWithTalentList then
		arg_30_0.rankGoWithTalentList = arg_30_0:getUserDataTb_()

		for iter_30_0 = 1, 3 do
			table.insert(arg_30_0.rankGoWithTalentList, gohelper.findChild(arg_30_0._gowithtalentrank, "rank" .. iter_30_0))
		end
	end

	return arg_30_0.rankGoList
end

function var_0_0._refreshAttribute(arg_31_0)
	if arg_31_0._heroMO then
		local var_31_0 = HeroGroupTrialModel.instance:getById(arg_31_0._originalHeroUid)
		local var_31_1

		if var_31_0 then
			var_31_1 = var_31_0.trialEquipMo
		end

		local var_31_2 = arg_31_0._heroMO:getTotalBaseAttrDict(arg_31_0._equips, nil, nil, RougeHeroGroupBalanceHelper.getIsBalanceMode() and not arg_31_0._heroMO:isTrial(), var_31_1, RougeHeroGroupBalanceHelper.getHeroBalanceInfo)

		for iter_31_0, iter_31_1 in ipairs(CharacterEnum.BaseAttrIdList) do
			local var_31_3 = HeroConfig.instance:getHeroAttributeCO(iter_31_1)

			arg_31_0._attributevalues[iter_31_0].name.text = var_31_3.name
			arg_31_0._attributevalues[iter_31_0].value.text = var_31_2[iter_31_1]

			CharacterController.instance:SetAttriIcon(arg_31_0._attributevalues[iter_31_0].icon, iter_31_1)
		end
	end
end

function var_0_0._refreshPassiveSkill(arg_32_0)
	if not arg_32_0._heroMO then
		return
	end

	local var_32_0 = SkillConfig.instance:getpassiveskillsCO(arg_32_0._heroMO.heroId)
	local var_32_1 = var_32_0[1].skillPassive
	local var_32_2 = lua_skill.configDict[var_32_1]

	if not var_32_2 then
		logError("找不到角色被动技能, skillId: " .. tostring(var_32_1))
	else
		arg_32_0._txtpassivename.text = var_32_2.name
	end

	local var_32_3 = 0

	if not arg_32_0._heroMO:isTrial() then
		var_32_3 = RougeHeroGroupBalanceHelper.getHeroBalanceLv(arg_32_0._heroMO.heroId)
	end

	local var_32_4 = var_32_3 > arg_32_0._heroMO.level
	local var_32_5, var_32_6 = SkillConfig.instance:getHeroExSkillLevelByLevel(arg_32_0._heroMO.heroId, math.max(arg_32_0._heroMO.level, var_32_3))

	for iter_32_0 = 1, #var_32_0 do
		local var_32_7 = iter_32_0 <= var_32_5

		gohelper.setActive(arg_32_0._passiveskillitems[iter_32_0].on, var_32_7 and not var_32_4)
		gohelper.setActive(arg_32_0._passiveskillitems[iter_32_0].off, not var_32_7)
		gohelper.setActive(arg_32_0._passiveskillitems[iter_32_0].balance, var_32_7 and var_32_4)
		gohelper.setActive(arg_32_0._passiveskillitems[iter_32_0].go, true)
	end

	for iter_32_1 = #var_32_0 + 1, #arg_32_0._passiveskillitems do
		gohelper.setActive(arg_32_0._passiveskillitems[iter_32_1].go, false)
	end

	if var_32_0[0] then
		gohelper.setActive(arg_32_0._passiveskillitems[0].on, true)
		gohelper.setActive(arg_32_0._passiveskillitems[0].off, false)
		gohelper.setActive(arg_32_0._passiveskillitems[0].balance, var_32_4)
		gohelper.setActive(arg_32_0._passiveskillitems[0].go, true)
	else
		gohelper.setActive(arg_32_0._passiveskillitems[0].go, false)
	end
end

function var_0_0._refreshSkill(arg_33_0)
	arg_33_0._skillContainer:onUpdateMO(arg_33_0._heroMO and arg_33_0._heroMO.heroId, nil, arg_33_0._heroMO, RougeHeroGroupBalanceHelper.getIsBalanceMode() and not arg_33_0._heroMO:isTrial())
end

function var_0_0._refreshBtnIcon(arg_34_0)
	local var_34_0 = CharacterModel.instance:getRankState()
	local var_34_1 = CharacterModel.instance:getBtnTag(CharacterEnum.FilterType.HeroGroup)

	gohelper.setActive(arg_34_0._lvBtns[1], var_34_1 ~= 1)
	gohelper.setActive(arg_34_0._lvBtns[2], var_34_1 == 1)
	gohelper.setActive(arg_34_0._rareBtns[1], var_34_1 ~= 2)
	gohelper.setActive(arg_34_0._rareBtns[2], var_34_1 == 2)

	local var_34_2 = false

	for iter_34_0, iter_34_1 in pairs(arg_34_0._selectDmgs) do
		if iter_34_1 then
			var_34_2 = true
		end
	end

	for iter_34_2, iter_34_3 in pairs(arg_34_0._selectAttrs) do
		if iter_34_3 then
			var_34_2 = true
		end
	end

	for iter_34_4, iter_34_5 in pairs(arg_34_0._selectLocations) do
		if iter_34_5 then
			var_34_2 = true
		end
	end

	gohelper.setActive(arg_34_0._classifyBtns[1], not var_34_2)
	gohelper.setActive(arg_34_0._classifyBtns[2], var_34_2)
	transformhelper.setLocalScale(arg_34_0._lvArrow[1], 1, var_34_0[1], 1)
	transformhelper.setLocalScale(arg_34_0._lvArrow[2], 1, var_34_0[1], 1)
	transformhelper.setLocalScale(arg_34_0._rareArrow[1], 1, var_34_0[2], 1)
	transformhelper.setLocalScale(arg_34_0._rareArrow[2], 1, var_34_0[2], 1)
end

function var_0_0._refreshFilterView(arg_35_0)
	for iter_35_0 = 1, 2 do
		gohelper.setActive(arg_35_0._dmgUnselects[iter_35_0], not arg_35_0._selectDmgs[iter_35_0])
		gohelper.setActive(arg_35_0._dmgSelects[iter_35_0], arg_35_0._selectDmgs[iter_35_0])
	end

	for iter_35_1 = 1, 6 do
		gohelper.setActive(arg_35_0._attrUnselects[iter_35_1], not arg_35_0._selectAttrs[iter_35_1])
		gohelper.setActive(arg_35_0._attrSelects[iter_35_1], arg_35_0._selectAttrs[iter_35_1])
	end

	for iter_35_2 = 1, 6 do
		gohelper.setActive(arg_35_0._locationUnselects[iter_35_2], not arg_35_0._selectLocations[iter_35_2])
		gohelper.setActive(arg_35_0._locationSelects[iter_35_2], arg_35_0._selectLocations[iter_35_2])
	end
end

function var_0_0._updateHeroList(arg_36_0)
	local var_36_0 = {}

	for iter_36_0 = 1, 2 do
		if arg_36_0._selectDmgs[iter_36_0] then
			table.insert(var_36_0, iter_36_0)
		end
	end

	local var_36_1 = {}

	for iter_36_1 = 1, 6 do
		if arg_36_0._selectAttrs[iter_36_1] then
			table.insert(var_36_1, iter_36_1)
		end
	end

	local var_36_2 = {}

	for iter_36_2 = 1, 6 do
		if arg_36_0._selectLocations[iter_36_2] then
			table.insert(var_36_2, iter_36_2)
		end
	end

	if #var_36_0 == 0 then
		var_36_0 = {
			1,
			2
		}
	end

	if #var_36_1 == 0 then
		var_36_1 = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	if #var_36_2 == 0 then
		var_36_2 = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	local var_36_3 = {
		dmgs = var_36_0,
		careers = var_36_1,
		locations = var_36_2
	}

	CharacterModel.instance:filterCardListByDmgAndCareer(var_36_3, false, CharacterEnum.FilterType.HeroGroup)
	arg_36_0:_refreshBtnIcon()

	if arg_36_0._isShowQuickEdit then
		arg_36_0._heroGroupQuickEditListModel:copyQuickEditCardList()
	else
		arg_36_0._heroGroupEditListModel:copyCharacterCardList()
	end
end

function var_0_0.replaceSelectHeroDefaultEquip(arg_37_0)
	if arg_37_0._heroMO and arg_37_0._heroMO:hasDefaultEquip() and arg_37_0._singleGroupMOId <= RougeEnum.FightTeamNormalHeroNum then
		local var_37_0 = arg_37_0._heroGroupModel:getCurGroupMO().equips

		for iter_37_0, iter_37_1 in pairs(var_37_0) do
			if iter_37_1.equipUid[1] == arg_37_0._heroMO.defaultEquipUid then
				iter_37_1.equipUid[1] = "0"

				break
			end
		end

		var_37_0[arg_37_0._singleGroupMOId - 1].equipUid[1] = arg_37_0._heroMO.defaultEquipUid
	end
end

function var_0_0.replaceQuickGroupHeroDefaultEquip(arg_38_0, arg_38_1)
	if arg_38_0._isInitType then
		return
	end

	local var_38_0 = arg_38_0._heroGroupModel:getCurGroupMO().equips
	local var_38_1

	for iter_38_0, iter_38_1 in ipairs(arg_38_1) do
		local var_38_2 = HeroModel.instance:getById(iter_38_1)

		if var_38_2 and var_38_2:hasDefaultEquip() then
			for iter_38_2, iter_38_3 in pairs(var_38_0) do
				if iter_38_3.equipUid[1] == var_38_2.defaultEquipUid then
					iter_38_3.equipUid[1] = "0"

					break
				end
			end

			var_38_0[iter_38_0 - 1].equipUid[1] = var_38_2.defaultEquipUid
		end
	end
end

function var_0_0._saveCurGroupInfo(arg_39_0)
	if not arg_39_0:_isFightEditType() then
		if arg_39_0._isInitType then
			local var_39_0 = arg_39_0._heroSingleGroupModel:getCurGroupMO()
			local var_39_1 = arg_39_0._heroSingleGroupModel.instance:getList()

			var_39_0:replaceHeroList(var_39_1)
		end

		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)

		return
	end

	local var_39_2 = arg_39_0._heroSingleGroupModel:getHeroUids()
	local var_39_3 = arg_39_0._heroGroupModel:getCurGroupMO()

	arg_39_0:replaceSelectHeroDefaultEquip()
	arg_39_0._heroGroupModel:replaceSingleGroup()
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	arg_39_0._heroGroupModel:saveCurGroupData()
	arg_39_0._heroGroupModel:rougeSaveCurGroup()
end

function var_0_0._saveQuickGroupInfo(arg_40_0, arg_40_1)
	if arg_40_0.viewParam.heroGroupEditType == RougeEnum.HeroGroupEditType.SelectHero then
		if arg_40_1 then
			arg_40_0.viewContainer:checkSelectHeroResult()
		end

		return
	end

	local var_40_0

	if arg_40_0._isInitType then
		var_40_0 = RougeEnum.InitTeamHeroNum
	else
		var_40_0 = arg_40_0._heroGroupModel:getBattleRoleNum()
	end

	if arg_40_0._heroGroupQuickEditListModel:getIsDirty() then
		local var_40_1 = arg_40_0._heroGroupQuickEditListModel:getHeroUids()

		arg_40_0:replaceQuickGroupHeroDefaultEquip(var_40_1)

		for iter_40_0 = 1, var_40_0 do
			local var_40_2 = var_40_1[iter_40_0]

			if var_40_2 ~= nil then
				local var_40_3, var_40_4 = arg_40_0._heroSingleGroupModel:hasHeroUids(var_40_2, arg_40_0._singleGroupMOId)

				if var_40_3 then
					arg_40_0._heroSingleGroupModel:removeFrom(var_40_4)
				end

				arg_40_0._heroSingleGroupModel:addTo(var_40_2, iter_40_0)

				local var_40_5 = arg_40_0._heroSingleGroupModel:getByIndex(iter_40_0)

				if tonumber(var_40_2) < 0 then
					local var_40_6 = HeroGroupTrialModel.instance:getById(var_40_2)

					if var_40_6 then
						var_40_5:setTrial(var_40_6.trialCo.id, var_40_6.trialCo.trialTemplate)
					else
						var_40_5:setTrial()
					end
				else
					var_40_5:setTrial()
				end
			end
		end

		arg_40_0._heroGroupModel:replaceSingleGroup()
		arg_40_0._heroGroupModel:replaceSingleGroupEquips()
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)

		if arg_40_0._isInitType then
			return
		end

		arg_40_0._heroGroupModel:saveCurGroupData()
		arg_40_0._heroGroupModel:rougeSaveCurGroup()
	end
end

function var_0_0._onAttributeChanged(arg_41_0, arg_41_1, arg_41_2)
	CharacterModel.instance:setFakeLevel(arg_41_2, arg_41_1)
end

function var_0_0._normalEditHasChange(arg_42_0)
	if Activity104Model.instance:isSeasonChapter() then
		return true
	end

	if arg_42_0._heroSingleGroupModel:getHeroUid(arg_42_0._singleGroupMOId) ~= arg_42_0._originalHeroUid then
		return true
	end

	if arg_42_0._originalHeroUid and arg_42_0._heroMO and arg_42_0._originalHeroUid == arg_42_0._heroMO.uid then
		return false
	elseif (not arg_42_0._originalHeroUid or arg_42_0._originalHeroUid == "0") and not arg_42_0._heroMO then
		return false
	else
		return true
	end
end

function var_0_0._refreshEditMode(arg_43_0)
	gohelper.setActive(arg_43_0._scrollquickedit.gameObject, arg_43_0._isShowQuickEdit)
	gohelper.setActive(arg_43_0._scrollcard.gameObject, not arg_43_0._isShowQuickEdit)
	gohelper.setActive(arg_43_0._goBtnEditQuickMode.gameObject, arg_43_0._isShowQuickEdit)
	gohelper.setActive(arg_43_0._goBtnEditNormalMode.gameObject, not arg_43_0._isShowQuickEdit)
end

function var_0_0._refreshCurScrollBySort(arg_44_0)
	if arg_44_0._isShowQuickEdit then
		if arg_44_0._heroGroupQuickEditListModel:getIsDirty() then
			arg_44_0:_saveQuickGroupInfo()
		end

		local var_44_0 = arg_44_0._heroMO

		arg_44_0._heroGroupQuickEditListModel:copyQuickEditCardList()

		if var_44_0 ~= arg_44_0._heroMO then
			arg_44_0._heroGroupQuickEditListModel:cancelAllSelected()
		end
	else
		arg_44_0._heroGroupEditListModel:copyCharacterCardList()
	end
end

function var_0_0._onGroupModify(arg_45_0)
	if arg_45_0._isShowQuickEdit then
		arg_45_0._heroGroupQuickEditListModel:copyQuickEditCardList()
	else
		local var_45_0 = arg_45_0._heroSingleGroupModel:getHeroUid(arg_45_0._singleGroupMOId)

		if arg_45_0._originalHeroUid ~= var_45_0 then
			arg_45_0._originalHeroUid = var_45_0

			arg_45_0._heroGroupEditListModel:setParam(var_45_0, arg_45_0._adventure)
			arg_45_0:_onHeroItemClick(nil)
			arg_45_0._heroGroupEditListModel:cancelAllSelected()

			local var_45_1 = arg_45_0._heroGroupEditListModel:getById(var_45_0)
			local var_45_2 = arg_45_0._heroGroupEditListModel:getIndex(var_45_1)

			arg_45_0._heroGroupEditListModel:selectCell(var_45_2, true)
		end

		arg_45_0._heroGroupEditListModel:copyCharacterCardList()
	end
end

function var_0_0._editableInitView(arg_46_0)
	gohelper.setActive(arg_46_0._gospecialitem, false)

	arg_46_0._careerGOs = {}
	arg_46_0._imgBg = gohelper.findChildSingleImage(arg_46_0.viewGO, "bg/bgimg")
	arg_46_0._simageredlight = gohelper.findChildSingleImage(arg_46_0.viewGO, "bg/#simage_redlight")

	arg_46_0._imgBg:LoadImage(ResUrl.getCommonViewBg("full/biandui_di"))
	arg_46_0._simageredlight:LoadImage(ResUrl.getHeroGroupBg("guang_027"))

	arg_46_0._lvBtns = arg_46_0:getUserDataTb_()
	arg_46_0._lvArrow = arg_46_0:getUserDataTb_()
	arg_46_0._rareBtns = arg_46_0:getUserDataTb_()
	arg_46_0._rareArrow = arg_46_0:getUserDataTb_()
	arg_46_0._classifyBtns = arg_46_0:getUserDataTb_()
	arg_46_0._selectDmgs = {}
	arg_46_0._dmgSelects = arg_46_0:getUserDataTb_()
	arg_46_0._dmgUnselects = arg_46_0:getUserDataTb_()
	arg_46_0._dmgBtnClicks = arg_46_0:getUserDataTb_()
	arg_46_0._selectAttrs = {}
	arg_46_0._attrSelects = arg_46_0:getUserDataTb_()
	arg_46_0._attrUnselects = arg_46_0:getUserDataTb_()
	arg_46_0._attrBtnClicks = arg_46_0:getUserDataTb_()
	arg_46_0._selectLocations = {}
	arg_46_0._locationSelects = arg_46_0:getUserDataTb_()
	arg_46_0._locationUnselects = arg_46_0:getUserDataTb_()
	arg_46_0._locationBtnClicks = arg_46_0:getUserDataTb_()
	arg_46_0._curDmgs = {}
	arg_46_0._curAttrs = {}
	arg_46_0._curLocations = {}

	for iter_46_0 = 1, 2 do
		arg_46_0._lvBtns[iter_46_0] = gohelper.findChild(arg_46_0._btnlvrank.gameObject, "btn" .. tostring(iter_46_0))
		arg_46_0._lvArrow[iter_46_0] = gohelper.findChild(arg_46_0._lvBtns[iter_46_0], "txt/arrow").transform
		arg_46_0._rareBtns[iter_46_0] = gohelper.findChild(arg_46_0._btnrarerank.gameObject, "btn" .. tostring(iter_46_0))
		arg_46_0._rareArrow[iter_46_0] = gohelper.findChild(arg_46_0._rareBtns[iter_46_0], "txt/arrow").transform
		arg_46_0._classifyBtns[iter_46_0] = gohelper.findChild(arg_46_0._btnclassify.gameObject, "btn" .. tostring(iter_46_0))
		arg_46_0._dmgUnselects[iter_46_0] = gohelper.findChild(arg_46_0._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. iter_46_0 .. "/unselected")
		arg_46_0._dmgSelects[iter_46_0] = gohelper.findChild(arg_46_0._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. iter_46_0 .. "/selected")
		arg_46_0._dmgBtnClicks[iter_46_0] = gohelper.findChildButtonWithAudio(arg_46_0._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. iter_46_0 .. "/click")

		arg_46_0._dmgBtnClicks[iter_46_0]:AddClickListener(arg_46_0._dmgBtnOnClick, arg_46_0, iter_46_0)
	end

	for iter_46_1 = 1, 6 do
		arg_46_0._attrUnselects[iter_46_1] = gohelper.findChild(arg_46_0._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. iter_46_1 .. "/unselected")
		arg_46_0._attrSelects[iter_46_1] = gohelper.findChild(arg_46_0._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. iter_46_1 .. "/selected")
		arg_46_0._attrBtnClicks[iter_46_1] = gohelper.findChildButtonWithAudio(arg_46_0._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. iter_46_1 .. "/click")

		arg_46_0._attrBtnClicks[iter_46_1]:AddClickListener(arg_46_0._attrBtnOnClick, arg_46_0, iter_46_1)
	end

	for iter_46_2 = 1, 6 do
		arg_46_0._locationUnselects[iter_46_2] = gohelper.findChild(arg_46_0._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. iter_46_2 .. "/unselected")
		arg_46_0._locationSelects[iter_46_2] = gohelper.findChild(arg_46_0._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. iter_46_2 .. "/selected")
		arg_46_0._locationBtnClicks[iter_46_2] = gohelper.findChildButtonWithAudio(arg_46_0._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. iter_46_2 .. "/click")

		arg_46_0._locationBtnClicks[iter_46_2]:AddClickListener(arg_46_0._locationBtnOnClick, arg_46_0, iter_46_2)
	end

	arg_46_0._goBtnEditQuickMode = gohelper.findChild(arg_46_0._btnquickedit.gameObject, "btn2")
	arg_46_0._goBtnEditNormalMode = gohelper.findChild(arg_46_0._btnquickedit.gameObject, "btn1")
	arg_46_0._attributevalues = {}

	for iter_46_3 = 1, 5 do
		local var_46_0 = arg_46_0:getUserDataTb_()

		var_46_0.value = gohelper.findChildText(arg_46_0._goattribute, "attribute" .. tostring(iter_46_3) .. "/txt_attribute")
		var_46_0.name = gohelper.findChildText(arg_46_0._goattribute, "attribute" .. tostring(iter_46_3) .. "/name")
		var_46_0.icon = gohelper.findChildImage(arg_46_0._goattribute, "attribute" .. tostring(iter_46_3) .. "/icon")
		arg_46_0._attributevalues[iter_46_3] = var_46_0
	end

	arg_46_0._passiveskillitems = {}

	for iter_46_4 = 1, 3 do
		arg_46_0._passiveskillitems[iter_46_4] = arg_46_0:_findPassiveskillitems(iter_46_4)
	end

	arg_46_0._passiveskillitems[0] = arg_46_0:_findPassiveskillitems(4)
	arg_46_0._skillContainer = MonoHelper.addNoUpdateLuaComOnceToGo(arg_46_0._goskill, CharacterSkillContainer)

	gohelper.setActive(arg_46_0._gononecharacter, false)
	gohelper.setActive(arg_46_0._gocharacterinfo, false)

	arg_46_0._animator = arg_46_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(arg_46_0._gorecommendAttrDesc, false)

	arg_46_0._fightTip = gohelper.findChild(arg_46_0.viewGO, "#go_chooserole/fight")
	arg_46_0._fightAssitTip = gohelper.findChild(arg_46_0.viewGO, "#go_chooserole/assit")
end

function var_0_0._findPassiveskillitems(arg_47_0, arg_47_1)
	local var_47_0 = arg_47_0:getUserDataTb_()

	var_47_0.go = gohelper.findChild(arg_47_0._gopassiveskills, "passiveskill" .. arg_47_1)
	var_47_0.on = gohelper.findChild(var_47_0.go, "on")
	var_47_0.off = gohelper.findChild(var_47_0.go, "off")
	var_47_0.balance = gohelper.findChild(var_47_0.go, "balance")

	return var_47_0
end

function var_0_0._isFightEditType(arg_48_0)
	return arg_48_0.viewParam.heroGroupEditType == RougeEnum.HeroGroupEditType.Fight or arg_48_0.viewParam.heroGroupEditType == RougeEnum.HeroGroupEditType.FightAssit
end

function var_0_0._initFightTip(arg_49_0)
	local var_49_0 = arg_49_0.viewParam.heroGroupEditType

	gohelper.setActive(arg_49_0._fightTip, var_49_0 == RougeEnum.HeroGroupEditType.Fight)
	gohelper.setActive(arg_49_0._fightAssitTip, var_49_0 == RougeEnum.HeroGroupEditType.FightAssit)
end

function var_0_0._initCapacity(arg_50_0)
	arg_50_0._selectHeroCapacity = arg_50_0.viewParam.selectHeroCapacity
	arg_50_0._curCapacity = arg_50_0.viewParam.curCapacity
	arg_50_0._totalCapacity = arg_50_0.viewParam.totalCapacity
	arg_50_0._assistCapacity = arg_50_0.viewParam.assistCapacity
	arg_50_0._assistPos = arg_50_0.viewParam.assistPos
	arg_50_0._assistHeroId = arg_50_0.viewParam.assistHeroId

	RougeHeroGroupEditListModel.instance:setCapacityInfo(arg_50_0._selectHeroCapacity, arg_50_0._curCapacity, arg_50_0._totalCapacity, arg_50_0._assistCapacity, arg_50_0._assistPos, arg_50_0._assistHeroId)

	if not arg_50_0._capacityComp then
		local var_50_0 = gohelper.findChild(arg_50_0.viewGO, "characterinfo/volumebg/volume")
		local var_50_1 = gohelper.findChildText(arg_50_0.viewGO, "characterinfo/volumebg/txt_titletips")

		if arg_50_0.viewParam.heroGroupEditType == RougeEnum.HeroGroupEditType.SelectHero then
			var_50_1.text = luaLang("p_rougeinitteamview_txt_titletips")
		else
			var_50_1.text = luaLang("p_rougeinitteamview_txt_titletips2")
		end

		local var_50_2

		if arg_50_0:_isFightEditType() then
			var_50_2 = RougeCapacityComp.SpriteType2
		end

		arg_50_0._capacityComp = RougeCapacityComp.Add(var_50_0, arg_50_0._curCapacity, arg_50_0._totalCapacity, true, var_50_2)

		arg_50_0._capacityComp:showChangeEffect(true)
	else
		arg_50_0._capacityComp:updateCurAndMaxNum(arg_50_0._curCapacity, arg_50_0._totalCapacity)
	end
end

function var_0_0._updateTotalCapacity(arg_51_0)
	if arg_51_0._isShowQuickEdit then
		local var_51_0 = RougeHeroGroupQuickEditListModel.instance:calcTotalCapacity()

		arg_51_0._capacityComp:updateCurAndMaxNum(var_51_0, arg_51_0._totalCapacity)

		return
	end

	local var_51_1 = RougeHeroGroupEditListModel.instance:calcTotalCapacity(arg_51_0._singleGroupMOId, arg_51_0._heroMO)

	arg_51_0._capacityComp:updateCurAndMaxNum(var_51_1, arg_51_0._totalCapacity)
end

function var_0_0.onUpdateParam(arg_52_0)
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Team_Open)
end

function var_0_0._initFakeLevelList(arg_53_0, arg_53_1)
	if not RougeHeroGroupBalanceHelper.getIsBalanceMode() then
		return
	end

	local var_53_0 = {}

	for iter_53_0, iter_53_1 in ipairs(arg_53_1) do
		local var_53_1 = RougeHeroGroupBalanceHelper.getHeroBalanceLv(iter_53_1.heroId)

		if var_53_1 > iter_53_1.level then
			var_53_0[iter_53_1.heroId] = var_53_1
		end
	end

	CharacterModel.instance:setFakeList(var_53_0)
end

function var_0_0.onOpen(arg_54_0)
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Team_Open)

	arg_54_0._isShowQuickEdit = false
	arg_54_0._scrollcard.verticalNormalizedPosition = 1
	arg_54_0._scrollquickedit.verticalNormalizedPosition = 1
	arg_54_0._originalHeroUid = arg_54_0.viewParam.originalHeroUid
	arg_54_0._singleGroupMOId = arg_54_0.viewParam.singleGroupMOId
	arg_54_0._adventure = arg_54_0.viewParam.adventure
	arg_54_0._equips = arg_54_0.viewParam.equips

	for iter_54_0 = 1, 2 do
		arg_54_0._selectDmgs[iter_54_0] = false
	end

	for iter_54_1 = 1, 6 do
		arg_54_0._selectAttrs[iter_54_1] = false
	end

	for iter_54_2 = 1, 6 do
		arg_54_0._selectLocations[iter_54_2] = false
	end

	arg_54_0._heroGroupEditListModel = RougeHeroGroupEditListModel.instance
	arg_54_0._heroGroupQuickEditListModel = RougeHeroGroupQuickEditListModel.instance
	arg_54_0._heroSingleGroupModel = RougeHeroSingleGroupModel.instance
	arg_54_0._heroGroupModel = RougeHeroGroupModel.instance

	local var_54_0

	if arg_54_0:_isFightEditType() then
		var_54_0 = RougeHeroGroupEditListModel.instance:getTeamNoSortedList()
	else
		var_54_0 = HeroModel.instance:getList()
	end

	CharacterModel.instance:setHeroList(var_54_0)
	arg_54_0:_initFakeLevelList(var_54_0)
	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.HeroGroup)
	arg_54_0._heroGroupEditListModel:setParam(arg_54_0._originalHeroUid, arg_54_0._adventure, arg_54_0._heroHps)
	arg_54_0._heroGroupQuickEditListModel:setParam(arg_54_0._adventure, arg_54_0._heroHps)
	arg_54_0._heroGroupEditListModel:setHeroGroupEditType(arg_54_0.viewParam.heroGroupEditType)

	arg_54_0._isInitType = arg_54_0.viewParam.heroGroupEditType == RougeEnum.HeroGroupEditType.Init

	arg_54_0.viewContainer:_setHomeBtnVisible(arg_54_0:_isFightEditType())
	arg_54_0:_initCapacity()
	arg_54_0:_initFightTip()

	arg_54_0._heroMO = arg_54_0._heroGroupEditListModel:copyCharacterCardList(true)

	arg_54_0:_refreshEditMode()
	arg_54_0:_refreshBtnIcon()
	arg_54_0:_refreshCharacterInfo()
	arg_54_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_54_0._updateHeroList, arg_54_0)
	arg_54_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_54_0._updateHeroList, arg_54_0)
	arg_54_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_54_0._updateHeroList, arg_54_0)
	arg_54_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroEditItem, arg_54_0._onClickHeroEditItem, arg_54_0)
	arg_54_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_54_0._refreshCharacterInfo, arg_54_0)
	arg_54_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_54_0._refreshCharacterInfo, arg_54_0)
	arg_54_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_54_0._refreshCharacterInfo, arg_54_0)
	arg_54_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, arg_54_0._refreshCharacterInfo, arg_54_0)
	arg_54_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_54_0._refreshCharacterInfo, arg_54_0)
	arg_54_0:addEventCb(CharacterController.instance, CharacterEvent.levelUpAttribute, arg_54_0._onAttributeChanged, arg_54_0)
	arg_54_0:addEventCb(CharacterController.instance, CharacterEvent.showCharacterRankUpView, arg_54_0._showCharacterRankUpView, arg_54_0)
	arg_54_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_54_0._onGroupModify, arg_54_0)
	arg_54_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_54_0._onGroupModify, arg_54_0)
	arg_54_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_54_0._onOpenView, arg_54_0)
	arg_54_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_54_0._onCloseView, arg_54_0)
	arg_54_0:addEventCb(CharacterController.instance, CharacterEvent.HeroUpdatePush, arg_54_0._refreshCharacterInfo, arg_54_0)
	gohelper.addUIClickAudio(arg_54_0._btnlvrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_54_0._btnrarerank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_54_0._btnexskillrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_54_0._btnattribute.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_54_0._btnpassiveskill.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_54_0._btncharacter.gameObject, AudioEnum.UI.UI_Common_Click)

	_, arg_54_0._initScrollContentPosY = transformhelper.getLocalPos(arg_54_0._goScrollContent.transform)

	gohelper.setActive(arg_54_0._btnquickedit, arg_54_0.viewParam.heroGroupEditType == RougeEnum.HeroGroupEditType.Fight or arg_54_0._isInitType)

	if arg_54_0.viewParam.heroGroupEditType == RougeEnum.HeroGroupEditType.SelectHero then
		arg_54_0:_btnquickeditOnClick()
	end

	arg_54_0:_updateTotalCapacity()
end

function var_0_0.onClose(arg_55_0)
	arg_55_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_55_0._updateHeroList, arg_55_0)
	arg_55_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_55_0._updateHeroList, arg_55_0)
	arg_55_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_55_0._updateHeroList, arg_55_0)
	arg_55_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroEditItem, arg_55_0._onClickHeroEditItem, arg_55_0)
	arg_55_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_55_0._refreshCharacterInfo, arg_55_0)
	arg_55_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_55_0._refreshCharacterInfo, arg_55_0)
	arg_55_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_55_0._refreshCharacterInfo, arg_55_0)
	arg_55_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, arg_55_0._refreshCharacterInfo, arg_55_0)
	arg_55_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_55_0._refreshCharacterInfo, arg_55_0)
	arg_55_0:removeEventCb(CharacterController.instance, CharacterEvent.levelUpAttribute, arg_55_0._onAttributeChanged, arg_55_0)
	arg_55_0:removeEventCb(CharacterController.instance, CharacterEvent.showCharacterRankUpView, arg_55_0._showCharacterRankUpView, arg_55_0)
	arg_55_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_55_0._onGroupModify, arg_55_0)
	arg_55_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_55_0._onGroupModify, arg_55_0)
	arg_55_0:removeEventCb(CharacterController.instance, CharacterEvent.HeroUpdatePush, arg_55_0._refreshCharacterInfo, arg_55_0)
	CharacterModel.instance:clearFakeList()
	CharacterModel.instance:setFakeLevel()
	arg_55_0._heroGroupEditListModel:cancelAllSelected()
	arg_55_0._heroGroupEditListModel:clear()
	arg_55_0._heroGroupQuickEditListModel:cancelAllSelected()
	arg_55_0._heroGroupQuickEditListModel:clear()
	HeroGroupTrialModel.instance:setFilter()
	CommonHeroHelper.instance:resetGrayState()

	arg_55_0._selectDmgs = {}
	arg_55_0._selectAttrs = {}
	arg_55_0._selectLocations = {}

	if arg_55_0._isStopBgm then
		TaskDispatcher.cancelTask(arg_55_0._delyStopBgm, arg_55_0)
		arg_55_0:_delyStopBgm()
	end
end

function var_0_0._onOpenView(arg_56_0, arg_56_1)
	if arg_56_1 == ViewName.CharacterView and arg_56_0._isStopBgm then
		TaskDispatcher.cancelTask(arg_56_0._delyStopBgm, arg_56_0)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Unsatisfied_Music)

		return
	end
end

function var_0_0._showRecommendCareer(arg_57_0)
	local var_57_0, var_57_1 = FightHelper.detectAttributeCounter()

	gohelper.CreateObjList(arg_57_0, arg_57_0._onRecommendCareerItemShow, var_57_0, arg_57_0._goattrlist, arg_57_0._goattritem)

	arg_57_0._txtrecommendAttrDesc.text = #var_57_0 == 0 and luaLang("herogroupeditview_notrecommend") or luaLang("herogroupeditview_recommend")

	gohelper.setActive(arg_57_0._goattrlist, #var_57_0 ~= 0)
end

function var_0_0._onRecommendCareerItemShow(arg_58_0, arg_58_1, arg_58_2, arg_58_3)
	local var_58_0 = gohelper.findChildImage(arg_58_1, "icon")

	UISpriteSetMgr.instance:setHeroGroupSprite(var_58_0, "career_" .. arg_58_2)
end

function var_0_0._onCloseView(arg_59_0, arg_59_1)
	if arg_59_1 == ViewName.CharacterView then
		AudioMgr.instance:trigger(AudioEnum.UI.Stop_UIMusic)

		arg_59_0._isStopBgm = true

		TaskDispatcher.cancelTask(arg_59_0._delyStopBgm, arg_59_0)
		TaskDispatcher.runDelay(arg_59_0._delyStopBgm, arg_59_0, 1)
	end
end

function var_0_0._delyStopBgm(arg_60_0)
	arg_60_0._isStopBgm = false

	AudioMgr.instance:trigger(AudioEnum.Bgm.Pause_FightingMusic)
end

function var_0_0._showCharacterRankUpView(arg_61_0, arg_61_1)
	arg_61_1()
end

function var_0_0.onDestroyView(arg_62_0)
	CharacterModel.instance:clearFakeList()
	CharacterModel.instance:setHeroList(nil)

	if arg_62_0:_isFightEditType() then
		CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.HeroGroup)
	end

	arg_62_0._imgBg:UnLoadImage()
	arg_62_0._simageredlight:UnLoadImage()

	arg_62_0._imgBg = nil
	arg_62_0._simageredlight = nil

	for iter_62_0 = 1, 2 do
		arg_62_0._dmgBtnClicks[iter_62_0]:RemoveClickListener()
	end

	for iter_62_1 = 1, 6 do
		arg_62_0._attrBtnClicks[iter_62_1]:RemoveClickListener()
	end

	for iter_62_2 = 1, 6 do
		arg_62_0._locationBtnClicks[iter_62_2]:RemoveClickListener()
	end
end

return var_0_0
