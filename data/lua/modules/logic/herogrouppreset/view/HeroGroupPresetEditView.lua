module("modules.logic.herogrouppreset.view.HeroGroupPresetEditView", package.seeall)

local var_0_0 = class("HeroGroupPresetEditView", BaseView)

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
	var_8_0.isBalance = HeroGroupBalanceHelper.getIsBalanceMode() and not arg_8_0._heroMO:isTrial()

	CharacterController.instance:openCharacterTipView(var_8_0)
end

function var_0_0._btnconfirmOnClick(arg_9_0)
	if arg_9_0._isShowQuickEdit then
		local var_9_0 = arg_9_0._heroGroupQuickEditListModel:getHeroUids()

		if var_9_0 and #var_9_0 > 0 then
			if arg_9_0._adventure then
				for iter_9_0, iter_9_1 in pairs(var_9_0) do
					local var_9_1 = HeroModel.instance:getById(iter_9_1)

					if var_9_1 and WeekWalkModel.instance:getCurMapHeroCd(var_9_1.heroId) > 0 then
						GameFacade.showToast(ToastEnum.HeroGroupEdit)

						return
					end
				end
			elseif arg_9_0._isWeekWalk_2 then
				for iter_9_2, iter_9_3 in pairs(var_9_0) do
					local var_9_2 = HeroModel.instance:getById(iter_9_3)

					if var_9_2 and WeekWalk_2Model.instance:getCurMapHeroCd(var_9_2.heroId) > 0 then
						GameFacade.showToast(ToastEnum.HeroGroupEdit)

						return
					end
				end
			elseif arg_9_0._isTowerBattle then
				for iter_9_4, iter_9_5 in pairs(var_9_0) do
					local var_9_3 = HeroModel.instance:getById(iter_9_5)

					if var_9_3 and TowerModel.instance:isHeroBan(var_9_3.heroId) then
						GameFacade.showToast(ToastEnum.TowerHeroGroupEdit)

						return
					end
				end
			end
		end

		arg_9_0:_saveQuickGroupInfo()
		arg_9_0:closeThis()

		return
	end

	if not arg_9_0:_normalEditHasChange() then
		arg_9_0:closeThis()

		return
	end

	local var_9_4 = arg_9_0._heroSingleGroupModel:getById(arg_9_0._singleGroupMOId)

	if var_9_4.trialPos then
		GameFacade.showToast(ToastEnum.TrialCantTakeOff)

		return
	end

	if arg_9_0._heroMO then
		if arg_9_0._adventure then
			if WeekWalkModel.instance:getCurMapHeroCd(arg_9_0._heroMO.heroId) > 0 then
				GameFacade.showToast(ToastEnum.HeroGroupEdit)

				return
			end
		elseif arg_9_0._isWeekWalk_2 then
			if WeekWalk_2Model.instance:getCurMapHeroCd(arg_9_0._heroMO.heroId) > 0 then
				GameFacade.showToast(ToastEnum.HeroGroupEdit)

				return
			end
		elseif arg_9_0._isTowerBattle and TowerModel.instance:isHeroBan(arg_9_0._heroMO.heroId) then
			GameFacade.showToast(ToastEnum.TowerHeroGroupEdit)

			return
		end

		if arg_9_0._heroMO.isPosLock then
			GameFacade.showToast(ToastEnum.TrialCantTakeOff)

			return
		end

		if arg_9_0._heroMO:isTrial() and not arg_9_0._heroSingleGroupModel:isInGroup(arg_9_0._heroMO.uid) and (var_9_4:isEmpty() or not var_9_4.trial) and arg_9_0._heroGroupEditListModel:isTrialLimit() then
			GameFacade.showToast(ToastEnum.TrialJoinLimit, HeroGroupTrialModel.instance:getLimitNum())

			return
		end

		local var_9_5, var_9_6 = arg_9_0._heroSingleGroupModel:hasHeroUids(arg_9_0._heroMO.uid, arg_9_0._singleGroupMOId)

		if var_9_5 then
			arg_9_0._heroSingleGroupModel:removeFrom(var_9_6)
			arg_9_0._heroSingleGroupModel:addTo(arg_9_0._heroMO.uid, arg_9_0._singleGroupMOId)

			if arg_9_0._heroMO:isTrial() then
				var_9_4:setTrial(arg_9_0._heroMO.trialCo.id, arg_9_0._heroMO.trialCo.trialTemplate)
			else
				var_9_4:setTrial()
			end

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
			var_9_4:setTrial(arg_9_0._heroMO.trialCo.id, arg_9_0._heroMO.trialCo.trialTemplate)
		else
			var_9_4:setTrial()
		end

		arg_9_0:_saveCurGroupInfo()
		arg_9_0:closeThis()
	else
		arg_9_0._heroSingleGroupModel:removeFrom(arg_9_0._singleGroupMOId)
		arg_9_0:_saveCurGroupInfo()
		arg_9_0:closeThis()
	end
end

function var_0_0.checkTrialNum(arg_10_0)
	return false
end

function var_0_0._btncancelOnClick(arg_11_0)
	arg_11_0:closeThis()
end

function var_0_0._btncharacterOnClick(arg_12_0)
	if arg_12_0._heroMO then
		local var_12_0

		if arg_12_0._isShowQuickEdit then
			var_12_0 = arg_12_0._heroGroupQuickEditListModel:getList()
		else
			var_12_0 = arg_12_0._heroGroupEditListModel:getList()
		end

		local var_12_1 = {}

		for iter_12_0, iter_12_1 in ipairs(var_12_0) do
			if not iter_12_1:isTrial() then
				table.insert(var_12_1, iter_12_1)
			end
		end

		CharacterController.instance:openCharacterView(arg_12_0._heroMO, var_12_1)
	end
end

function var_0_0._btntrialOnClick(arg_13_0)
	if arg_13_0._heroMO then
		local var_13_0

		if arg_13_0._isShowQuickEdit then
			var_13_0 = arg_13_0._heroGroupQuickEditListModel:getList()
		else
			var_13_0 = arg_13_0._heroGroupEditListModel:getList()
		end

		local var_13_1 = {}

		for iter_13_0, iter_13_1 in ipairs(var_13_0) do
			if iter_13_1:isTrial() then
				table.insert(var_13_1, iter_13_1)
			end
		end

		CharacterController.instance:openCharacterView(arg_13_0._heroMO, var_13_1)
	end
end

function var_0_0._btnattributeOnClick(arg_14_0)
	if arg_14_0._heroMO then
		local var_14_0 = HeroGroupTrialModel.instance:getById(arg_14_0._originalHeroUid)
		local var_14_1

		if var_14_0 then
			var_14_1 = var_14_0.trialEquipMo
		end

		local var_14_2 = {}

		var_14_2.tag = "attribute"
		var_14_2.heroid = arg_14_0._heroMO.heroId
		var_14_2.equips = arg_14_0._equips
		var_14_2.showExtraAttr = true
		var_14_2.fromHeroGroupEditView = true
		var_14_2.heroMo = arg_14_0._heroMO
		var_14_2.trialEquipMo = var_14_1
		var_14_2.isBalance = HeroGroupBalanceHelper.getIsBalanceMode() and not arg_14_0._heroMO:isTrial()

		CharacterController.instance:openCharacterTipView(var_14_2)
	end
end

function var_0_0._btnexskillrankOnClick(arg_15_0)
	local var_15_0, var_15_1 = transformhelper.getLocalPos(arg_15_0._goScrollContent.transform)

	transformhelper.setLocalPosXY(arg_15_0._goScrollContent.transform, var_15_0, arg_15_0._initScrollContentPosY)
	CharacterModel.instance:setCardListByExSkill(false, CharacterEnum.FilterType.HeroGroup)
	arg_15_0:_refreshBtnIcon()
	arg_15_0:_refreshCurScrollBySort()
end

function var_0_0._btnlvrankOnClick(arg_16_0)
	local var_16_0, var_16_1 = transformhelper.getLocalPos(arg_16_0._goScrollContent.transform)

	transformhelper.setLocalPosXY(arg_16_0._goScrollContent.transform, var_16_0, arg_16_0._initScrollContentPosY)
	CharacterModel.instance:setCardListByLevel(false, CharacterEnum.FilterType.HeroGroup)
	arg_16_0:_refreshBtnIcon()
	arg_16_0:_refreshCurScrollBySort()
end

function var_0_0._btnrarerankOnClick(arg_17_0)
	local var_17_0, var_17_1 = transformhelper.getLocalPos(arg_17_0._goScrollContent.transform)

	transformhelper.setLocalPosXY(arg_17_0._goScrollContent.transform, var_17_0, arg_17_0._initScrollContentPosY)
	CharacterModel.instance:setCardListByRare(false, CharacterEnum.FilterType.HeroGroup)
	arg_17_0:_refreshBtnIcon()
	arg_17_0:_refreshCurScrollBySort()
end

function var_0_0._btnquickeditOnClick(arg_18_0)
	arg_18_0._isShowQuickEdit = not arg_18_0._isShowQuickEdit

	arg_18_0:_refreshBtnIcon()
	arg_18_0:_refreshEditMode()

	if arg_18_0._isShowQuickEdit then
		arg_18_0:_onHeroItemClick(nil)
		arg_18_0._heroGroupQuickEditListModel:cancelAllSelected()
		arg_18_0._heroGroupQuickEditListModel:copyQuickEditCardList()

		local var_18_0 = arg_18_0._heroGroupQuickEditListModel:getById(arg_18_0._originalHeroUid)

		if var_18_0 then
			local var_18_1 = arg_18_0._heroGroupQuickEditListModel:getIndex(var_18_0)

			arg_18_0._heroGroupQuickEditListModel:selectCell(var_18_1, true)
		end
	else
		arg_18_0._heroGroupQuickEditListModel:cancelAllErrorSelected()
		arg_18_0:_saveQuickGroupInfo()
		arg_18_0:_onHeroItemClick(nil)
		arg_18_0._heroGroupEditListModel:cancelAllSelected()

		local var_18_2 = arg_18_0._heroSingleGroupModel:getHeroUid(arg_18_0._singleGroupMOId)

		if var_18_2 ~= "0" then
			local var_18_3 = arg_18_0._heroGroupEditListModel:getById(var_18_2)
			local var_18_4 = arg_18_0._heroGroupEditListModel:getIndex(var_18_3)

			arg_18_0._heroGroupEditListModel:selectCell(var_18_4, true)
		end

		arg_18_0._heroGroupEditListModel:copyCharacterCardList()
	end
end

function var_0_0._attrBtnOnClick(arg_19_0, arg_19_1)
	arg_19_0._selectAttrs[arg_19_1] = not arg_19_0._selectAttrs[arg_19_1]

	arg_19_0:_refreshFilterView()
end

function var_0_0._dmgBtnOnClick(arg_20_0, arg_20_1)
	if not arg_20_0._selectDmgs[arg_20_1] then
		arg_20_0._selectDmgs[3 - arg_20_1] = arg_20_0._selectDmgs[arg_20_1]
	end

	arg_20_0._selectDmgs[arg_20_1] = not arg_20_0._selectDmgs[arg_20_1]

	arg_20_0:_refreshFilterView()
end

function var_0_0._locationBtnOnClick(arg_21_0, arg_21_1)
	arg_21_0._selectLocations[arg_21_1] = not arg_21_0._selectLocations[arg_21_1]

	arg_21_0:_refreshFilterView()
end

function var_0_0._onHeroItemClick(arg_22_0, arg_22_1)
	arg_22_0._heroMO = arg_22_1

	arg_22_0:_refreshCharacterInfo()
end

function var_0_0._refreshCharacterInfo(arg_23_0)
	if arg_23_0._heroMO then
		gohelper.setActive(arg_23_0._gononecharacter, false)
		gohelper.setActive(arg_23_0._gocharacterinfo, true)
		arg_23_0:_refreshSkill()
		arg_23_0:_refreshMainInfo()
		arg_23_0:_refreshAttribute()
		arg_23_0:_refreshPassiveSkill()
	else
		gohelper.setActive(arg_23_0._gononecharacter, true)
		gohelper.setActive(arg_23_0._gocharacterinfo, false)
	end
end

function var_0_0._refreshMainInfo(arg_24_0)
	if arg_24_0._heroMO then
		gohelper.setActive(arg_24_0._btntrial.gameObject, arg_24_0._heroMO:isTrial())
		gohelper.setActive(arg_24_0._btntrialWithTalent.gameObject, arg_24_0._heroMO:isTrial())
		UISpriteSetMgr.instance:setCommonSprite(arg_24_0._imagecareericon, "sx_biandui_" .. tostring(arg_24_0._heroMO.config.career))
		UISpriteSetMgr.instance:setCommonSprite(arg_24_0._imagedmgtype, "dmgtype" .. tostring(arg_24_0._heroMO.config.dmgType))

		arg_24_0._txtname.text = arg_24_0._heroMO:getHeroName()
		arg_24_0._txtnameen.text = arg_24_0._heroMO.config.nameEng

		local var_24_0 = arg_24_0._heroMO.rank >= CharacterEnum.TalentRank and arg_24_0._heroMO.talent > 0

		if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) then
			var_24_0 = false
		end

		local var_24_1 = 0
		local var_24_2 = 0
		local var_24_3 = 0
		local var_24_4 = false

		if not arg_24_0._heroMO:isTrial() then
			local var_24_5

			var_24_1, var_24_5, var_24_3 = HeroGroupBalanceHelper.getHeroBalanceInfo(arg_24_0._heroMO.heroId)

			if var_24_5 and var_24_5 >= CharacterEnum.TalentRank and var_24_3 > 0 then
				var_24_4 = true
			end
		end

		local var_24_6 = var_24_1 and var_24_1 > arg_24_0._heroMO.level
		local var_24_7 = var_24_4 and (not var_24_0 or var_24_3 > arg_24_0._heroMO.talent)

		if var_24_0 or var_24_4 then
			gohelper.setActive(arg_24_0._golevel, false)
			gohelper.setActive(arg_24_0._golevelWithTalent, true)
			gohelper.setActive(arg_24_0._goBalanceWithTalent, var_24_6 or var_24_7)
			gohelper.setActive(arg_24_0._goheroLvTxtWithTalent, true)

			if var_24_6 then
				local var_24_8, var_24_9 = HeroConfig.instance:getShowLevel(var_24_1)
				local var_24_10 = CharacterModel.instance:getrankEffects(arg_24_0._heroMO.heroId, var_24_9)[1]
				local var_24_11 = HeroConfig.instance:getShowLevel(var_24_10)

				arg_24_0._txtlevelWithTalent.text = "<color=#8fb1cc>" .. tostring(var_24_8)
				arg_24_0._txtlevelmaxWithTalent.text = string.format("/%d", var_24_11)
			else
				local var_24_12 = CharacterModel.instance:getrankEffects(arg_24_0._heroMO.heroId, arg_24_0._heroMO.rank)[1]
				local var_24_13 = HeroConfig.instance:getShowLevel(arg_24_0._heroMO.level)
				local var_24_14 = HeroConfig.instance:getShowLevel(var_24_12)

				arg_24_0._txtlevelWithTalent.text = tostring(var_24_13)
				arg_24_0._txtlevelmaxWithTalent.text = string.format("/%d", var_24_14)
			end

			if var_24_7 then
				arg_24_0._txttalent.text = "<color=#8fb1cc>Lv.<size=40>" .. tostring(var_24_3)
			else
				arg_24_0._txttalent.text = "Lv.<size=40>" .. tostring(arg_24_0._heroMO.talent)
			end

			arg_24_0._txttalentType.text = luaLang("talent_character_talentcn" .. arg_24_0._heroMO:getTalentTxtByHeroType())
		else
			gohelper.setActive(arg_24_0._golevel, true)
			gohelper.setActive(arg_24_0._golevelWithTalent, false)
			gohelper.setActive(arg_24_0._goBalance, var_24_6)
			gohelper.setActive(arg_24_0._goheroLvTxt, not var_24_6)

			if var_24_6 then
				local var_24_15, var_24_16 = HeroConfig.instance:getShowLevel(var_24_1)
				local var_24_17 = CharacterModel.instance:getrankEffects(arg_24_0._heroMO.heroId, var_24_16)[1]
				local var_24_18 = HeroConfig.instance:getShowLevel(var_24_17)

				arg_24_0._txtlevel.text = "<color=#8fb1cc>" .. tostring(var_24_15)
				arg_24_0._txtlevelmax.text = string.format("/%d", var_24_18)
			else
				local var_24_19 = CharacterModel.instance:getrankEffects(arg_24_0._heroMO.heroId, arg_24_0._heroMO.rank)[1]
				local var_24_20 = HeroConfig.instance:getShowLevel(arg_24_0._heroMO.level)
				local var_24_21 = HeroConfig.instance:getShowLevel(var_24_19)

				arg_24_0._txtlevel.text = tostring(var_24_20)
				arg_24_0._txtlevelmax.text = string.format("/%d", var_24_21)
			end
		end

		local var_24_22 = {}

		if not string.nilorempty(arg_24_0._heroMO.config.battleTag) then
			var_24_22 = string.split(arg_24_0._heroMO.config.battleTag, "#")
		end

		for iter_24_0 = 1, #var_24_22 do
			local var_24_23 = arg_24_0._careerGOs[iter_24_0]

			if not var_24_23 then
				var_24_23 = arg_24_0:getUserDataTb_()
				var_24_23.go = gohelper.cloneInPlace(arg_24_0._gospecialitem, "item" .. iter_24_0)
				var_24_23.textfour = gohelper.findChildText(var_24_23.go, "#go_fourword/name")
				var_24_23.textthree = gohelper.findChildText(var_24_23.go, "#go_threeword/name")
				var_24_23.texttwo = gohelper.findChildText(var_24_23.go, "#go_twoword/name")
				var_24_23.containerfour = gohelper.findChild(var_24_23.go, "#go_fourword")
				var_24_23.containerthree = gohelper.findChild(var_24_23.go, "#go_threeword")
				var_24_23.containertwo = gohelper.findChild(var_24_23.go, "#go_twoword")

				table.insert(arg_24_0._careerGOs, var_24_23)
			end

			local var_24_24 = HeroConfig.instance:getBattleTagConfigCO(var_24_22[iter_24_0]).tagName
			local var_24_25 = GameUtil.utf8len(var_24_24)

			gohelper.setActive(var_24_23.containertwo, var_24_25 <= 2)
			gohelper.setActive(var_24_23.containerthree, var_24_25 == 3)
			gohelper.setActive(var_24_23.containerfour, var_24_25 >= 4)

			if var_24_25 <= 2 then
				var_24_23.texttwo.text = var_24_24
			elseif var_24_25 == 3 then
				var_24_23.textthree.text = var_24_24
			else
				var_24_23.textfour.text = var_24_24
			end

			gohelper.setActive(var_24_23.go, true)
		end

		for iter_24_1 = #var_24_22 + 1, #arg_24_0._careerGOs do
			gohelper.setActive(arg_24_0._careerGOs[iter_24_1].go, false)
		end
	end
end

function var_0_0._refreshAttribute(arg_25_0)
	if arg_25_0._heroMO then
		local var_25_0 = HeroGroupTrialModel.instance:getById(arg_25_0._originalHeroUid)
		local var_25_1

		if var_25_0 then
			var_25_1 = var_25_0.trialEquipMo
		end

		local var_25_2 = arg_25_0._heroMO:getTotalBaseAttrDict(arg_25_0._equips, nil, nil, HeroGroupBalanceHelper.getIsBalanceMode() and not arg_25_0._heroMO:isTrial(), var_25_1)

		for iter_25_0, iter_25_1 in ipairs(CharacterEnum.BaseAttrIdList) do
			local var_25_3 = HeroConfig.instance:getHeroAttributeCO(iter_25_1)

			arg_25_0._attributevalues[iter_25_0].name.text = var_25_3.name
			arg_25_0._attributevalues[iter_25_0].value.text = var_25_2[iter_25_1]

			CharacterController.instance:SetAttriIcon(arg_25_0._attributevalues[iter_25_0].icon, iter_25_1)
		end
	end
end

function var_0_0._refreshPassiveSkill(arg_26_0)
	if not arg_26_0._heroMO then
		return
	end

	local var_26_0 = arg_26_0._heroMO:getpassiveskillsCO()
	local var_26_1 = var_26_0[1].skillPassive
	local var_26_2 = lua_skill.configDict[var_26_1]

	if not var_26_2 then
		logError("找不到角色被动技能, skillId: " .. tostring(var_26_1))
	else
		arg_26_0._txtpassivename.text = var_26_2.name
	end

	local var_26_3 = 0

	if not arg_26_0._heroMO:isTrial() then
		var_26_3 = HeroGroupBalanceHelper.getHeroBalanceLv(arg_26_0._heroMO.heroId)
	end

	local var_26_4 = var_26_3 > arg_26_0._heroMO.level
	local var_26_5, var_26_6 = SkillConfig.instance:getHeroExSkillLevelByLevel(arg_26_0._heroMO.heroId, math.max(arg_26_0._heroMO.level, var_26_3))

	for iter_26_0 = 1, #var_26_0 do
		local var_26_7 = iter_26_0 <= var_26_5

		gohelper.setActive(arg_26_0._passiveskillitems[iter_26_0].on, var_26_7 and not var_26_4)
		gohelper.setActive(arg_26_0._passiveskillitems[iter_26_0].off, not var_26_7)
		gohelper.setActive(arg_26_0._passiveskillitems[iter_26_0].balance, var_26_7 and var_26_4)
		gohelper.setActive(arg_26_0._passiveskillitems[iter_26_0].go, true)
	end

	for iter_26_1 = #var_26_0 + 1, #arg_26_0._passiveskillitems do
		gohelper.setActive(arg_26_0._passiveskillitems[iter_26_1].go, false)
	end

	if var_26_0[0] then
		gohelper.setActive(arg_26_0._passiveskillitems[0].on, true)
		gohelper.setActive(arg_26_0._passiveskillitems[0].off, false)
		gohelper.setActive(arg_26_0._passiveskillitems[0].balance, var_26_4)
		gohelper.setActive(arg_26_0._passiveskillitems[0].go, true)
	else
		gohelper.setActive(arg_26_0._passiveskillitems[0].go, false)
	end
end

function var_0_0._refreshSkill(arg_27_0)
	arg_27_0._skillContainer:onUpdateMO(arg_27_0._heroMO and arg_27_0._heroMO.heroId, nil, arg_27_0._heroMO, HeroGroupBalanceHelper.getIsBalanceMode() and not arg_27_0._heroMO:isTrial())
end

function var_0_0._refreshBtnIcon(arg_28_0)
	local var_28_0 = CharacterModel.instance:getRankState()
	local var_28_1 = CharacterModel.instance:getBtnTag(CharacterEnum.FilterType.HeroGroup)

	gohelper.setActive(arg_28_0._lvBtns[1], var_28_1 ~= 1)
	gohelper.setActive(arg_28_0._lvBtns[2], var_28_1 == 1)
	gohelper.setActive(arg_28_0._rareBtns[1], var_28_1 ~= 2)
	gohelper.setActive(arg_28_0._rareBtns[2], var_28_1 == 2)

	local var_28_2 = false

	for iter_28_0, iter_28_1 in pairs(arg_28_0._selectDmgs) do
		if iter_28_1 then
			var_28_2 = true
		end
	end

	for iter_28_2, iter_28_3 in pairs(arg_28_0._selectAttrs) do
		if iter_28_3 then
			var_28_2 = true
		end
	end

	for iter_28_4, iter_28_5 in pairs(arg_28_0._selectLocations) do
		if iter_28_5 then
			var_28_2 = true
		end
	end

	gohelper.setActive(arg_28_0._classifyBtns[1], not var_28_2)
	gohelper.setActive(arg_28_0._classifyBtns[2], var_28_2)
	HeroGroupTrialModel.instance:sortByLevelAndRare(var_28_1 == 1, var_28_0[var_28_1] == 1)
	transformhelper.setLocalScale(arg_28_0._lvArrow[1], 1, var_28_0[1], 1)
	transformhelper.setLocalScale(arg_28_0._lvArrow[2], 1, var_28_0[1], 1)
	transformhelper.setLocalScale(arg_28_0._rareArrow[1], 1, var_28_0[2], 1)
	transformhelper.setLocalScale(arg_28_0._rareArrow[2], 1, var_28_0[2], 1)
end

function var_0_0._refreshFilterView(arg_29_0)
	for iter_29_0 = 1, 2 do
		gohelper.setActive(arg_29_0._dmgUnselects[iter_29_0], not arg_29_0._selectDmgs[iter_29_0])
		gohelper.setActive(arg_29_0._dmgSelects[iter_29_0], arg_29_0._selectDmgs[iter_29_0])
	end

	for iter_29_1 = 1, 6 do
		gohelper.setActive(arg_29_0._attrUnselects[iter_29_1], not arg_29_0._selectAttrs[iter_29_1])
		gohelper.setActive(arg_29_0._attrSelects[iter_29_1], arg_29_0._selectAttrs[iter_29_1])
	end

	for iter_29_2 = 1, 6 do
		gohelper.setActive(arg_29_0._locationUnselects[iter_29_2], not arg_29_0._selectLocations[iter_29_2])
		gohelper.setActive(arg_29_0._locationSelects[iter_29_2], arg_29_0._selectLocations[iter_29_2])
	end
end

function var_0_0._updateHeroList(arg_30_0)
	local var_30_0 = {}

	for iter_30_0 = 1, 2 do
		if arg_30_0._selectDmgs[iter_30_0] then
			table.insert(var_30_0, iter_30_0)
		end
	end

	local var_30_1 = {}

	for iter_30_1 = 1, 6 do
		if arg_30_0._selectAttrs[iter_30_1] then
			table.insert(var_30_1, iter_30_1)
		end
	end

	local var_30_2 = {}

	for iter_30_2 = 1, 6 do
		if arg_30_0._selectLocations[iter_30_2] then
			table.insert(var_30_2, iter_30_2)
		end
	end

	if #var_30_0 == 0 then
		var_30_0 = {
			1,
			2
		}
	end

	if #var_30_1 == 0 then
		var_30_1 = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	if #var_30_2 == 0 then
		var_30_2 = {
			1,
			2,
			3,
			4,
			5,
			6
		}
	end

	local var_30_3 = {
		dmgs = var_30_0,
		careers = var_30_1,
		locations = var_30_2
	}

	CharacterModel.instance:filterCardListByDmgAndCareer(var_30_3, false, CharacterEnum.FilterType.HeroGroup)
	arg_30_0:_refreshBtnIcon()

	if arg_30_0._isShowQuickEdit then
		arg_30_0._heroGroupQuickEditListModel:copyQuickEditCardList()
	else
		arg_30_0._heroGroupEditListModel:copyCharacterCardList()
	end
end

function var_0_0.replaceSelectHeroDefaultEquip(arg_31_0)
	if arg_31_0._heroMO and arg_31_0._heroMO:hasDefaultEquip() then
		local var_31_0 = arg_31_0._heroGroupModel:getCurGroupMO().equips

		for iter_31_0, iter_31_1 in pairs(var_31_0) do
			if iter_31_1.equipUid[1] == arg_31_0._heroMO.defaultEquipUid then
				iter_31_1.equipUid[1] = "0"

				break
			end
		end

		var_31_0[arg_31_0._singleGroupMOId - 1].equipUid[1] = arg_31_0._heroMO.defaultEquipUid
	end
end

function var_0_0.replaceQuickGroupHeroDefaultEquip(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0._heroGroupModel:getCurGroupMO().equips
	local var_32_1

	for iter_32_0, iter_32_1 in ipairs(arg_32_1) do
		local var_32_2 = HeroModel.instance:getById(iter_32_1)

		if var_32_2 and var_32_2:hasDefaultEquip() then
			for iter_32_2, iter_32_3 in pairs(var_32_0) do
				if iter_32_3.equipUid[1] == var_32_2.defaultEquipUid then
					iter_32_3.equipUid[1] = "0"

					break
				end
			end

			var_32_0[iter_32_0 - 1].equipUid[1] = var_32_2.defaultEquipUid
		end
	end
end

function var_0_0._saveCurGroupInfo(arg_33_0)
	local var_33_0 = arg_33_0._heroSingleGroupModel:getHeroUids()
	local var_33_1 = arg_33_0._heroGroupModel:getCurGroupMO()

	arg_33_0:replaceSelectHeroDefaultEquip()
	arg_33_0._heroGroupModel:replaceSingleGroup()
	HeroGroupPresetController.instance:updateFightHeroGroup()
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	arg_33_0._heroGroupModel:saveCurGroupData()
end

function var_0_0._saveQuickGroupInfo(arg_34_0)
	if arg_34_0._heroGroupQuickEditListModel:getIsDirty() then
		local var_34_0 = arg_34_0._heroGroupQuickEditListModel:getHeroUids()
		local var_34_1 = arg_34_0._heroGroupModel:getCurGroupMO()

		arg_34_0:replaceQuickGroupHeroDefaultEquip(var_34_0)

		for iter_34_0 = 1, arg_34_0._heroGroupModel:getBattleRoleNum() do
			local var_34_2 = var_34_0[iter_34_0]

			if var_34_2 ~= nil then
				arg_34_0._heroSingleGroupModel:addTo(var_34_2, iter_34_0)

				local var_34_3 = arg_34_0._heroSingleGroupModel:getByIndex(iter_34_0)

				if tonumber(var_34_2) < 0 then
					local var_34_4 = HeroGroupTrialModel.instance:getById(var_34_2)

					if var_34_4 then
						var_34_3:setTrial(var_34_4.trialCo.id, var_34_4.trialCo.trialTemplate)
					else
						var_34_3:setTrial()
					end
				else
					var_34_3:setTrial()
				end
			end
		end

		arg_34_0._heroGroupModel:replaceSingleGroup()
		arg_34_0._heroGroupModel:replaceSingleGroupEquips()
		HeroGroupPresetController.instance:updateFightHeroGroup()
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
		arg_34_0._heroGroupModel:saveCurGroupData()
	end
end

function var_0_0._onAttributeChanged(arg_35_0, arg_35_1, arg_35_2)
	CharacterModel.instance:setFakeLevel(arg_35_2, arg_35_1)
end

function var_0_0._normalEditHasChange(arg_36_0)
	if Activity104Model.instance:isSeasonChapter() then
		return true
	end

	if arg_36_0._heroSingleGroupModel:getHeroUid(arg_36_0._singleGroupMOId) ~= arg_36_0._originalHeroUid then
		return true
	end

	if arg_36_0._originalHeroUid and arg_36_0._heroMO and arg_36_0._originalHeroUid == arg_36_0._heroMO.uid then
		return false
	elseif (not arg_36_0._originalHeroUid or arg_36_0._originalHeroUid == "0") and not arg_36_0._heroMO then
		return false
	else
		return true
	end
end

function var_0_0._refreshEditMode(arg_37_0)
	gohelper.setActive(arg_37_0._scrollquickedit.gameObject, arg_37_0._isShowQuickEdit)
	gohelper.setActive(arg_37_0._scrollcard.gameObject, not arg_37_0._isShowQuickEdit)
	gohelper.setActive(arg_37_0._goBtnEditQuickMode.gameObject, arg_37_0._isShowQuickEdit)
	gohelper.setActive(arg_37_0._goBtnEditNormalMode.gameObject, not arg_37_0._isShowQuickEdit)
end

function var_0_0._refreshCurScrollBySort(arg_38_0)
	if arg_38_0._isShowQuickEdit then
		if arg_38_0._heroGroupQuickEditListModel:getIsDirty() then
			arg_38_0:_saveQuickGroupInfo()
		end

		local var_38_0 = arg_38_0._heroMO

		arg_38_0._heroGroupQuickEditListModel:copyQuickEditCardList()

		if var_38_0 ~= arg_38_0._heroMO then
			arg_38_0._heroGroupQuickEditListModel:cancelAllSelected()
		end
	else
		arg_38_0._heroGroupEditListModel:copyCharacterCardList()
	end
end

function var_0_0._onGroupModify(arg_39_0)
	if arg_39_0._isShowQuickEdit then
		arg_39_0._heroGroupQuickEditListModel:copyQuickEditCardList()
	else
		local var_39_0 = arg_39_0._heroSingleGroupModel:getHeroUid(arg_39_0._singleGroupMOId)

		if arg_39_0._originalHeroUid ~= var_39_0 then
			arg_39_0._originalHeroUid = var_39_0

			arg_39_0._heroGroupEditListModel:setParam(var_39_0, arg_39_0._adventure)
			arg_39_0:_onHeroItemClick(nil)
			arg_39_0._heroGroupEditListModel:cancelAllSelected()

			local var_39_1 = arg_39_0._heroGroupEditListModel:getById(var_39_0)
			local var_39_2 = arg_39_0._heroGroupEditListModel:getIndex(var_39_1)

			arg_39_0._heroGroupEditListModel:selectCell(var_39_2, true)
		end

		arg_39_0._heroGroupEditListModel:copyCharacterCardList()
	end
end

function var_0_0._editableInitView(arg_40_0)
	gohelper.setActive(arg_40_0._gospecialitem, false)

	arg_40_0._careerGOs = {}
	arg_40_0._imgBg = gohelper.findChildSingleImage(arg_40_0.viewGO, "bg/bgimg")
	arg_40_0._simageredlight = gohelper.findChildSingleImage(arg_40_0.viewGO, "bg/#simage_redlight")

	arg_40_0._imgBg:LoadImage(ResUrl.getCommonViewBg("full/biandui_di"))
	arg_40_0._simageredlight:LoadImage(ResUrl.getHeroGroupBg("guang_027"))

	arg_40_0._lvBtns = arg_40_0:getUserDataTb_()
	arg_40_0._lvArrow = arg_40_0:getUserDataTb_()
	arg_40_0._rareBtns = arg_40_0:getUserDataTb_()
	arg_40_0._rareArrow = arg_40_0:getUserDataTb_()
	arg_40_0._classifyBtns = arg_40_0:getUserDataTb_()
	arg_40_0._selectDmgs = {}
	arg_40_0._dmgSelects = arg_40_0:getUserDataTb_()
	arg_40_0._dmgUnselects = arg_40_0:getUserDataTb_()
	arg_40_0._dmgBtnClicks = arg_40_0:getUserDataTb_()
	arg_40_0._selectAttrs = {}
	arg_40_0._attrSelects = arg_40_0:getUserDataTb_()
	arg_40_0._attrUnselects = arg_40_0:getUserDataTb_()
	arg_40_0._attrBtnClicks = arg_40_0:getUserDataTb_()
	arg_40_0._selectLocations = {}
	arg_40_0._locationSelects = arg_40_0:getUserDataTb_()
	arg_40_0._locationUnselects = arg_40_0:getUserDataTb_()
	arg_40_0._locationBtnClicks = arg_40_0:getUserDataTb_()
	arg_40_0._curDmgs = {}
	arg_40_0._curAttrs = {}
	arg_40_0._curLocations = {}

	for iter_40_0 = 1, 2 do
		arg_40_0._lvBtns[iter_40_0] = gohelper.findChild(arg_40_0._btnlvrank.gameObject, "btn" .. tostring(iter_40_0))
		arg_40_0._lvArrow[iter_40_0] = gohelper.findChild(arg_40_0._lvBtns[iter_40_0], "txt/arrow").transform
		arg_40_0._rareBtns[iter_40_0] = gohelper.findChild(arg_40_0._btnrarerank.gameObject, "btn" .. tostring(iter_40_0))
		arg_40_0._rareArrow[iter_40_0] = gohelper.findChild(arg_40_0._rareBtns[iter_40_0], "txt/arrow").transform
		arg_40_0._classifyBtns[iter_40_0] = gohelper.findChild(arg_40_0._btnclassify.gameObject, "btn" .. tostring(iter_40_0))
		arg_40_0._dmgUnselects[iter_40_0] = gohelper.findChild(arg_40_0._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. iter_40_0 .. "/unselected")
		arg_40_0._dmgSelects[iter_40_0] = gohelper.findChild(arg_40_0._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. iter_40_0 .. "/selected")
		arg_40_0._dmgBtnClicks[iter_40_0] = gohelper.findChildButtonWithAudio(arg_40_0._gosearchfilter, "container/Scroll View/Viewport/Content/dmgContainer/#go_dmg" .. iter_40_0 .. "/click")

		arg_40_0._dmgBtnClicks[iter_40_0]:AddClickListener(arg_40_0._dmgBtnOnClick, arg_40_0, iter_40_0)
	end

	for iter_40_1 = 1, 6 do
		arg_40_0._attrUnselects[iter_40_1] = gohelper.findChild(arg_40_0._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. iter_40_1 .. "/unselected")
		arg_40_0._attrSelects[iter_40_1] = gohelper.findChild(arg_40_0._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. iter_40_1 .. "/selected")
		arg_40_0._attrBtnClicks[iter_40_1] = gohelper.findChildButtonWithAudio(arg_40_0._gosearchfilter, "container/Scroll View/Viewport/Content/attrContainer/#go_attr" .. iter_40_1 .. "/click")

		arg_40_0._attrBtnClicks[iter_40_1]:AddClickListener(arg_40_0._attrBtnOnClick, arg_40_0, iter_40_1)
	end

	for iter_40_2 = 1, 6 do
		arg_40_0._locationUnselects[iter_40_2] = gohelper.findChild(arg_40_0._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. iter_40_2 .. "/unselected")
		arg_40_0._locationSelects[iter_40_2] = gohelper.findChild(arg_40_0._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. iter_40_2 .. "/selected")
		arg_40_0._locationBtnClicks[iter_40_2] = gohelper.findChildButtonWithAudio(arg_40_0._gosearchfilter, "container/Scroll View/Viewport/Content/locationContainer/#go_location" .. iter_40_2 .. "/click")

		arg_40_0._locationBtnClicks[iter_40_2]:AddClickListener(arg_40_0._locationBtnOnClick, arg_40_0, iter_40_2)
	end

	arg_40_0._goBtnEditQuickMode = gohelper.findChild(arg_40_0._btnquickedit.gameObject, "btn2")
	arg_40_0._goBtnEditNormalMode = gohelper.findChild(arg_40_0._btnquickedit.gameObject, "btn1")
	arg_40_0._attributevalues = {}

	for iter_40_3 = 1, 5 do
		local var_40_0 = arg_40_0:getUserDataTb_()

		var_40_0.value = gohelper.findChildText(arg_40_0._goattribute, "attribute" .. tostring(iter_40_3) .. "/txt_attribute")
		var_40_0.name = gohelper.findChildText(arg_40_0._goattribute, "attribute" .. tostring(iter_40_3) .. "/name")
		var_40_0.icon = gohelper.findChildImage(arg_40_0._goattribute, "attribute" .. tostring(iter_40_3) .. "/icon")
		arg_40_0._attributevalues[iter_40_3] = var_40_0
	end

	arg_40_0._passiveskillitems = {}

	for iter_40_4 = 1, 3 do
		arg_40_0._passiveskillitems[iter_40_4] = arg_40_0:_findPassiveskillitems(iter_40_4)
	end

	arg_40_0._passiveskillitems[0] = arg_40_0:_findPassiveskillitems(4)
	arg_40_0._skillContainer = MonoHelper.addNoUpdateLuaComOnceToGo(arg_40_0._goskill, CharacterSkillContainer)

	gohelper.setActive(arg_40_0._gononecharacter, false)
	gohelper.setActive(arg_40_0._gocharacterinfo, false)

	arg_40_0._animator = arg_40_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0._findPassiveskillitems(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0:getUserDataTb_()

	var_41_0.go = gohelper.findChild(arg_41_0._gopassiveskills, "passiveskill" .. arg_41_1)
	var_41_0.on = gohelper.findChild(var_41_0.go, "on")
	var_41_0.off = gohelper.findChild(var_41_0.go, "off")
	var_41_0.balance = gohelper.findChild(var_41_0.go, "balance")

	return var_41_0
end

function var_0_0._getGroupType(arg_42_0)
	local var_42_0 = arg_42_0._heroGroupModel.episodeId
	local var_42_1 = var_42_0 and lua_episode.configDict[var_42_0]

	if (var_42_1 and var_42_1.type) == DungeonEnum.EpisodeType.WeekWalk_2 then
		return HeroGroupEnum.GroupType.WeekWalk_2
	end
end

function var_0_0.onOpen(arg_43_0)
	arg_43_0._heroGroupEditListModel = HeroGroupPresetEditListModel.instance
	arg_43_0._heroGroupQuickEditListModel = HeroGroupPresetQuickEditListModel.instance
	arg_43_0._heroSingleGroupModel = HeroGroupPresetSingleGroupModel.instance
	arg_43_0._heroGroupModel = HeroGroupPresetModel.instance
	arg_43_0._isShowQuickEdit = false
	arg_43_0._scrollcard.verticalNormalizedPosition = 1
	arg_43_0._scrollquickedit.verticalNormalizedPosition = 1
	arg_43_0._originalHeroUid = arg_43_0.viewParam.originalHeroUid
	arg_43_0._singleGroupMOId = arg_43_0.viewParam.singleGroupMOId
	arg_43_0._adventure = arg_43_0.viewParam.adventure
	arg_43_0._equips = arg_43_0.viewParam.equips
	arg_43_0._isTowerBattle = TowerModel.instance:isInTowerBattle()
	arg_43_0._groupType = arg_43_0:_getGroupType()
	arg_43_0._isWeekWalk_2 = arg_43_0._groupType == HeroGroupEnum.GroupType.WeekWalk_2

	for iter_43_0 = 1, 2 do
		arg_43_0._selectDmgs[iter_43_0] = false
	end

	for iter_43_1 = 1, 6 do
		arg_43_0._selectAttrs[iter_43_1] = false
	end

	for iter_43_2 = 1, 6 do
		arg_43_0._selectLocations[iter_43_2] = false
	end

	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.HeroGroup)
	arg_43_0._heroGroupEditListModel:setParam(arg_43_0._originalHeroUid, arg_43_0._adventure, arg_43_0._isTowerBattle, arg_43_0._groupType)
	arg_43_0._heroGroupQuickEditListModel:setParam(arg_43_0._adventure, arg_43_0._isTowerBattle, arg_43_0._groupType)

	arg_43_0._heroMO = arg_43_0._heroGroupEditListModel:copyCharacterCardList(true)

	arg_43_0:_refreshEditMode()
	arg_43_0:_refreshBtnIcon()
	arg_43_0:_refreshCharacterInfo()

	arg_43_0._txtrecommendAttrDesc.text = arg_43_0.viewParam.heroGroupName

	arg_43_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_43_0._updateHeroList, arg_43_0)
	arg_43_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_43_0._updateHeroList, arg_43_0)
	arg_43_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_43_0._updateHeroList, arg_43_0)
	arg_43_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroEditItem, arg_43_0._onHeroItemClick, arg_43_0)
	arg_43_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_43_0._refreshCharacterInfo, arg_43_0)
	arg_43_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_43_0._refreshCharacterInfo, arg_43_0)
	arg_43_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_43_0._refreshCharacterInfo, arg_43_0)
	arg_43_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, arg_43_0._refreshCharacterInfo, arg_43_0)
	arg_43_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_43_0._refreshCharacterInfo, arg_43_0)
	arg_43_0:addEventCb(CharacterController.instance, CharacterEvent.levelUpAttribute, arg_43_0._onAttributeChanged, arg_43_0)
	arg_43_0:addEventCb(CharacterController.instance, CharacterEvent.showCharacterRankUpView, arg_43_0._showCharacterRankUpView, arg_43_0)
	arg_43_0:addEventCb(CharacterController.instance, CharacterEvent.OnMarkFavorSuccess, arg_43_0._markFavorSuccess, arg_43_0)
	arg_43_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_43_0._onGroupModify, arg_43_0)
	arg_43_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_43_0._onGroupModify, arg_43_0)
	arg_43_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_43_0._onOpenView, arg_43_0)
	arg_43_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_43_0._onCloseView, arg_43_0)
	arg_43_0:addEventCb(CharacterController.instance, CharacterEvent.HeroUpdatePush, arg_43_0._refreshCharacterInfo, arg_43_0)
	arg_43_0:addEventCb(AudioMgr.instance, AudioMgr.Evt_Trigger, arg_43_0._onAudioTrigger, arg_43_0)
	gohelper.addUIClickAudio(arg_43_0._btnlvrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_43_0._btnrarerank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_43_0._btnexskillrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_43_0._btnattribute.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_43_0._btnpassiveskill.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_43_0._btncharacter.gameObject, AudioEnum.UI.UI_Common_Click)

	_, arg_43_0._initScrollContentPosY = transformhelper.getLocalPos(arg_43_0._goScrollContent.transform)

	if arg_43_0.viewParam.onlyQuickEdit then
		arg_43_0:_btnquickeditOnClick()

		arg_43_0._btnquickedit.button.interactable = false
	end
end

function var_0_0.onClose(arg_44_0)
	arg_44_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_44_0._updateHeroList, arg_44_0)
	arg_44_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_44_0._updateHeroList, arg_44_0)
	arg_44_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_44_0._updateHeroList, arg_44_0)
	arg_44_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroEditItem, arg_44_0._onHeroItemClick, arg_44_0)
	arg_44_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_44_0._refreshCharacterInfo, arg_44_0)
	arg_44_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_44_0._refreshCharacterInfo, arg_44_0)
	arg_44_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_44_0._refreshCharacterInfo, arg_44_0)
	arg_44_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, arg_44_0._refreshCharacterInfo, arg_44_0)
	arg_44_0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_44_0._refreshCharacterInfo, arg_44_0)
	arg_44_0:removeEventCb(CharacterController.instance, CharacterEvent.levelUpAttribute, arg_44_0._onAttributeChanged, arg_44_0)
	arg_44_0:removeEventCb(CharacterController.instance, CharacterEvent.showCharacterRankUpView, arg_44_0._showCharacterRankUpView, arg_44_0)
	arg_44_0:removeEventCb(CharacterController.instance, CharacterEvent.OnMarkFavorSuccess, arg_44_0._markFavorSuccess, arg_44_0)
	arg_44_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_44_0._onGroupModify, arg_44_0)
	arg_44_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_44_0._onGroupModify, arg_44_0)
	arg_44_0:removeEventCb(CharacterController.instance, CharacterEvent.HeroUpdatePush, arg_44_0._refreshCharacterInfo, arg_44_0)
	arg_44_0:removeEventCb(AudioMgr.instance, AudioMgr.Evt_Trigger, arg_44_0._onAudioTrigger, arg_44_0)
	CharacterModel.instance:setFakeLevel()
	arg_44_0._heroGroupEditListModel:cancelAllSelected()
	arg_44_0._heroGroupEditListModel:clear()
	arg_44_0._heroGroupQuickEditListModel:cancelAllSelected()
	arg_44_0._heroGroupQuickEditListModel:clear()
	HeroGroupTrialModel.instance:setFilter()
	CommonHeroHelper.instance:resetGrayState()

	arg_44_0._selectDmgs = {}
	arg_44_0._selectAttrs = {}
	arg_44_0._selectLocations = {}
end

function var_0_0._onAudioTrigger(arg_45_0, arg_45_1)
	return
end

function var_0_0._onOpenView(arg_46_0, arg_46_1)
	return
end

function var_0_0._markFavorSuccess(arg_47_0)
	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.HeroGroup)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
end

function var_0_0._showRecommendCareer(arg_48_0)
	local var_48_0, var_48_1 = FightHelper.detectAttributeCounter()

	gohelper.CreateObjList(arg_48_0, arg_48_0._onRecommendCareerItemShow, var_48_0, arg_48_0._goattrlist, arg_48_0._goattritem)

	arg_48_0._txtrecommendAttrDesc.text = #var_48_0 == 0 and luaLang("herogroupeditview_notrecommend") or luaLang("herogroupeditview_recommend")

	gohelper.setActive(arg_48_0._goattrlist, #var_48_0 ~= 0)
end

function var_0_0._onRecommendCareerItemShow(arg_49_0, arg_49_1, arg_49_2, arg_49_3)
	local var_49_0 = gohelper.findChildImage(arg_49_1, "icon")

	UISpriteSetMgr.instance:setHeroGroupSprite(var_49_0, "career_" .. arg_49_2)
end

function var_0_0._onCloseView(arg_50_0, arg_50_1)
	return
end

function var_0_0._showCharacterRankUpView(arg_51_0, arg_51_1)
	arg_51_1()
end

function var_0_0.onDestroyView(arg_52_0)
	arg_52_0._imgBg:UnLoadImage()
	arg_52_0._simageredlight:UnLoadImage()

	arg_52_0._imgBg = nil
	arg_52_0._simageredlight = nil

	for iter_52_0 = 1, 2 do
		arg_52_0._dmgBtnClicks[iter_52_0]:RemoveClickListener()
	end

	for iter_52_1 = 1, 6 do
		arg_52_0._attrBtnClicks[iter_52_1]:RemoveClickListener()
	end

	for iter_52_2 = 1, 6 do
		arg_52_0._locationBtnClicks[iter_52_2]:RemoveClickListener()
	end
end

return var_0_0
