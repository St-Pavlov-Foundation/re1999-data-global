module("modules.logic.rouge.view.RougeHeroGroupEditView", package.seeall)

slot0 = class("RougeHeroGroupEditView", BaseView)

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
	slot0._gorank = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/level/#txt_level/#go_rank")
	slot0._txtlevelmax = gohelper.findChildText(slot0.viewGO, "characterinfo/#go_characterinfo/level/#txt_level/#txt_levelmax")
	slot0._btncharacter = gohelper.findChildButtonWithAudio(slot0.viewGO, "characterinfo/#go_characterinfo/level/#btn_character")
	slot0._btntrial = gohelper.findChildButtonWithAudio(slot0.viewGO, "characterinfo/#go_characterinfo/level/#btn_trial")
	slot0._goBalance = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/level/#go_balance")
	slot0._goheroLvTxt = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/level/Text")
	slot0._golevelWithTalent = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent")
	slot0._txtlevelWithTalent = gohelper.findChildText(slot0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_level")
	slot0._gowithtalentrank = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_level/#go_rank")
	slot0._txtlevelmaxWithTalent = gohelper.findChildText(slot0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_level/#txt_levelmax")
	slot0._btncharacterWithTalent = gohelper.findChildButtonWithAudio(slot0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#btn_character")
	slot0._btntrialWithTalent = gohelper.findChildButtonWithAudio(slot0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#btn_trial")
	slot0._goBalanceWithTalent = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#go_balance")
	slot0._goheroLvTxtWithTalent = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/Text")
	slot0._txttalent = gohelper.findChildText(slot0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_talent")
	slot0._txttalenticon = gohelper.findChildImage(slot0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_talent/icon")
	slot0._txttalentType = gohelper.findChildText(slot0.viewGO, "characterinfo/#go_characterinfo/levelwithtalent/#txt_talentType")
	slot0._btnattribute = gohelper.findChildButtonWithAudio(slot0.viewGO, "characterinfo/#go_characterinfo/attribute/#btn_attribute")
	slot0._goattribute = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/attribute/#go_attribute")
	slot0._goskill = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/#go_skill")
	slot0._btnpassiveskill = gohelper.findChildButtonWithAudio(slot0.viewGO, "characterinfo/#go_characterinfo/passiveskill/#btn_passiveskill")
	slot0._txtpassivename = gohelper.findChildText(slot0.viewGO, "characterinfo/#go_characterinfo/passiveskill/bg/#txt_passivename")
	slot0._gopassiveskills = gohelper.findChild(slot0.viewGO, "characterinfo/#go_characterinfo/passiveskill/#go_passiveskills")
	slot0._gorolecontainer = gohelper.findChild(slot0.viewGO, "#go_rolecontainer")
	slot0._scrollcard = gohelper.findChildScrollRect(slot0.viewGO, "#go_rolecontainer/#scroll_card")
	slot0._goScrollContent = gohelper.findChild(slot0.viewGO, "#go_rolecontainer/#scroll_card/scrollcontent")
	slot0._scrollquickedit = gohelper.findChildScrollRect(slot0.viewGO, "#go_rolecontainer/#scroll_quickedit")
	slot0._gorolesort = gohelper.findChild(slot0.viewGO, "#go_rolecontainer/#go_rolesort")
	slot0._btnlvrank = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_lvrank")
	slot0._btnrarerank = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_rarerank")
	slot0._btnexskillrank = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_exskillrank")
	slot0._btnclassify = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_classify")
	slot0._btnquickedit = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_quickedit")
	slot0._goexarrow = gohelper.findChild(slot0.viewGO, "#go_rolecontainer/#go_rolesort/#btn_exskillrank/#go_exarrow")
	slot0._gosearchfilter = gohelper.findChild(slot0.viewGO, "#go_searchfilter")
	slot0._btnclosefilterview = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_searchfilter/#btn_closefilterview")
	slot0._godmgitem = gohelper.findChild(slot0.viewGO, "#go_searchfilter/container/dmgContainer/#go_dmgitem")
	slot0._goattritem = gohelper.findChild(slot0.viewGO, "#go_searchfilter/container/attrContainer/#go_attritem")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_searchfilter/container/#btn_reset")
	slot0._btnok = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_searchfilter/container/#btn_ok")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._btnconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ops/#btn_confirm")
	slot0._btncancel = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_ops/#btn_cancel")
	slot0._gorecommendAttrDesc = gohelper.findChild(slot0.viewGO, "#go_recommendAttr")
	slot0._txtrecommendAttrDesc = gohelper.findChildText(slot0.viewGO, "#go_recommendAttr/bg/#txt_desc")
	slot0._goattrlist = gohelper.findChild(slot0.viewGO, "#go_recommendAttr/bg/#go_attrlist")
	slot0._goattritem = gohelper.findChild(slot0.viewGO, "#go_recommendAttr/bg/#go_attrlist/#go_attritem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnlvrank:AddClickListener(slot0._btnlvrankOnClick, slot0)
	slot0._btnrarerank:AddClickListener(slot0._btnrarerankOnClick, slot0)
	slot0._btnexskillrank:AddClickListener(slot0._btnexskillrankOnClick, slot0)
	slot0._btnclassify:AddClickListener(slot0._btnclassifyOnClick, slot0)
	slot0._btncharacter:AddClickListener(slot0._btncharacterOnClick, slot0)
	slot0._btntrial:AddClickListener(slot0._btntrialOnClick, slot0)
	slot0._btncharacterWithTalent:AddClickListener(slot0._btncharacterOnClick, slot0)
	slot0._btntrialWithTalent:AddClickListener(slot0._btntrialOnClick, slot0)
	slot0._btnattribute:AddClickListener(slot0._btnattributeOnClick, slot0)
	slot0._btnconfirm:AddClickListener(slot0._btnconfirmOnClick, slot0)
	slot0._btncancel:AddClickListener(slot0._btncancelOnClick, slot0)
	slot0._btnpassiveskill:AddClickListener(slot0._btnpassiveskillOnClick, slot0)
	slot0._btnquickedit:AddClickListener(slot0._btnquickeditOnClick, slot0)
	slot0._btnclosefilterview:AddClickListener(slot0._btncloseFilterViewOnClick, slot0)
	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
	slot0._btnok:AddClickListener(slot0._btnokOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnlvrank:RemoveClickListener()
	slot0._btnrarerank:RemoveClickListener()
	slot0._btnexskillrank:RemoveClickListener()
	slot0._btnclassify:RemoveClickListener()
	slot0._btncharacter:RemoveClickListener()
	slot0._btntrial:RemoveClickListener()
	slot0._btncharacterWithTalent:RemoveClickListener()
	slot0._btntrialWithTalent:RemoveClickListener()
	slot0._btnattribute:RemoveClickListener()
	slot0._btnconfirm:RemoveClickListener()
	slot0._btncancel:RemoveClickListener()
	slot0._btnpassiveskill:RemoveClickListener()
	slot0._btnquickedit:RemoveClickListener()
	slot0._btnclosefilterview:RemoveClickListener()
	slot0._btnreset:RemoveClickListener()
	slot0._btnok:RemoveClickListener()
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
	for slot4 = 1, 2 do
		slot0._selectDmgs[slot4] = false
	end

	for slot4 = 1, 6 do
		slot0._selectAttrs[slot4] = false
	end

	for slot4 = 1, 6 do
		slot0._selectLocations[slot4] = false
	end

	slot0:_refreshBtnIcon()
	slot0:_refreshFilterView()
end

function slot0._btnokOnClick(slot0)
	gohelper.setActive(slot0._gosearchfilter, false)

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

	slot4, slot5 = transformhelper.getLocalPos(slot0._goScrollContent.transform)

	transformhelper.setLocalPosXY(slot0._goScrollContent.transform, slot4, slot0._initScrollContentPosY)
	CharacterModel.instance:filterCardListByDmgAndCareer({
		dmgs = slot1,
		careers = slot2,
		locations = slot3
	}, false, CharacterEnum.FilterType.HeroGroup)
	HeroGroupTrialModel.instance:setFilter(slot1, slot2)

	slot0._curDmgs = LuaUtil.deepCopy(slot0._selectDmgs)
	slot0._curAttrs = LuaUtil.deepCopy(slot0._selectAttrs)
	slot0._curLocations = LuaUtil.deepCopy(slot0._selectLocations)

	slot0:_refreshBtnIcon()
	slot0:_refreshCurScrollBySort()
	ViewMgr.instance:closeView(ViewName.CharacterLevelUpView)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_hero_card_property)
end

function slot0._btnpassiveskillOnClick(slot0)
	if not slot0._heroMO then
		return
	end

	CharacterController.instance:openCharacterTipView({
		tag = "passiveskill",
		heroid = slot0._heroMO.heroId,
		heroMo = slot0._heroMO,
		tipPos = Vector2.New(851, -59),
		buffTipsX = 1603,
		anchorParams = {
			Vector2.New(0, 0.5),
			Vector2.New(0, 0.5)
		},
		isBalance = RougeHeroGroupBalanceHelper.getIsBalanceMode() and not slot0._heroMO:isTrial(),
		balanceHelper = RougeHeroGroupBalanceHelper
	})
end

function slot0._btnconfirmOnClick(slot0)
	if slot0._adventure then
		if slot0._heroGroupQuickEditListModel:getHeroUids() and #slot1 > 0 then
			for slot5, slot6 in pairs(slot1) do
				if HeroModel.instance:getById(slot6) and WeekWalkModel.instance:getCurMapHeroCd(slot7.heroId) > 0 then
					GameFacade.showToast(ToastEnum.HeroGroupEdit)

					return
				end
			end
		elseif slot0._heroMO and WeekWalkModel.instance:getCurMapHeroCd(slot0._heroMO.heroId) > 0 then
			GameFacade.showToast(ToastEnum.HeroGroupEdit)

			return
		end
	end

	if slot0._isShowQuickEdit then
		if slot0.viewParam.heroGroupEditType == RougeEnum.HeroGroupEditType.SelectHero and #slot0.viewContainer:getQuickSelectHeroList() <= 0 then
			GameFacade.showMessageBox(MessageBoxIdDefine.RougeTeamSelectedHeroConfirm, MsgBoxEnum.BoxType.Yes_No, function ()
				uv0:_saveQuickGroupInfo(true)
				uv0:closeThis()
			end, nil, , slot0)

			return
		end

		slot0:_saveQuickGroupInfo(true)
		slot0:closeThis()

		return
	end

	if not slot0:_normalEditHasChange() then
		slot0:closeThis()

		return
	end

	if slot0._heroSingleGroupModel:getById(slot0._singleGroupMOId).trialPos then
		GameFacade.showToast(ToastEnum.TrialCantTakeOff)

		return
	end

	if slot0._heroMO then
		if slot0._heroMO.isPosLock then
			GameFacade.showToast(ToastEnum.TrialCantTakeOff)

			return
		end

		if slot0._heroMO:isTrial() and not slot0._heroSingleGroupModel:isInGroup(slot0._heroMO.uid) and (slot1:isEmpty() or not slot1.trial) and slot0._heroGroupEditListModel:isTrialLimit() then
			GameFacade.showToast(ToastEnum.TrialJoinLimit, HeroGroupTrialModel.instance:getLimitNum())

			return
		end

		if slot0:_isFightEditType() and (RougeModel.instance:getTeamInfo():getHeroHp(slot0._heroMO.heroId) and slot3.life or 0) <= 0 then
			GameFacade.showToast(ToastEnum.V1a6CachotToast04)

			return
		end

		slot2, slot3 = slot0._heroSingleGroupModel:hasHeroUids(slot0._heroMO.uid, slot0._singleGroupMOId)

		if slot2 then
			slot0._heroSingleGroupModel:removeFrom(slot3)
			slot0._heroSingleGroupModel:addTo(slot0._heroMO.uid, slot0._singleGroupMOId)

			if slot0._heroMO:isTrial() then
				slot1:setTrial(slot0._heroMO.trialCo.id, slot0._heroMO.trialCo.trialTemplate)
			else
				slot1:setTrial()
			end

			FightAudioMgr.instance:playHeroVoiceRandom(slot0._heroMO.heroId, CharacterEnum.VoiceType.HeroGroup)
			slot0:_saveCurGroupInfo()
			slot0:closeThis()

			return
		end

		if slot0._heroSingleGroupModel:isAidConflict(slot0._heroMO.heroId) then
			GameFacade.showToast(ToastEnum.HeroIsAidConflict)

			return
		end

		slot0._heroSingleGroupModel:addTo(slot0._heroMO.uid, slot0._singleGroupMOId)

		if slot0._heroMO:isTrial() then
			slot1:setTrial(slot0._heroMO.trialCo.id, slot0._heroMO.trialCo.trialTemplate)
		else
			slot1:setTrial()
		end

		FightAudioMgr.instance:playHeroVoiceRandom(slot0._heroMO.heroId, CharacterEnum.VoiceType.HeroGroup)
		slot0:_saveCurGroupInfo()
		slot0:closeThis()
	else
		slot0._heroSingleGroupModel:removeFrom(slot0._singleGroupMOId)
		slot0:_saveCurGroupInfo()
		slot0:closeThis()
	end
end

function slot0.checkTrialNum(slot0)
	return false
end

function slot0._btncancelOnClick(slot0)
	if slot0.viewParam.heroGroupEditType == RougeEnum.HeroGroupEditType.SelectHero then
		slot0.viewContainer:_overrideClose()

		return
	end

	slot0:closeThis()
end

function slot0._btncharacterOnClick(slot0)
	if slot0._heroMO then
		slot1 = nil
		slot2 = {}

		for slot6, slot7 in ipairs((not slot0._isShowQuickEdit or slot0._heroGroupQuickEditListModel:getList()) and slot0._heroGroupEditListModel:getList()) do
			if not slot7:isTrial() then
				table.insert(slot2, slot7)
			end
		end

		CharacterController.instance:openCharacterView(slot0._heroMO, slot2)
	end
end

function slot0._btntrialOnClick(slot0)
	if slot0._heroMO then
		slot1 = nil
		slot2 = {}

		for slot6, slot7 in ipairs((not slot0._isShowQuickEdit or slot0._heroGroupQuickEditListModel:getList()) and slot0._heroGroupEditListModel:getList()) do
			if slot7:isTrial() then
				table.insert(slot2, slot7)
			end
		end

		CharacterController.instance:openCharacterView(slot0._heroMO, slot2)
	end
end

function slot0._btnattributeOnClick(slot0)
	if slot0._heroMO then
		slot2 = nil

		if HeroGroupTrialModel.instance:getById(slot0._originalHeroUid) then
			slot2 = slot1.trialEquipMo
		end

		CharacterController.instance:openCharacterTipView({
			tag = "attribute",
			heroid = slot0._heroMO.heroId,
			equips = slot0._equips,
			showExtraAttr = true,
			fromHeroGroupEditView = true,
			heroMo = slot0._heroMO,
			trialEquipMo = slot2,
			isBalance = RougeHeroGroupBalanceHelper.getIsBalanceMode() and not slot0._heroMO:isTrial(),
			balanceHelper = RougeHeroGroupBalanceHelper
		})
	end
end

function slot0._btnexskillrankOnClick(slot0)
	slot1, slot2 = transformhelper.getLocalPos(slot0._goScrollContent.transform)

	transformhelper.setLocalPosXY(slot0._goScrollContent.transform, slot1, slot0._initScrollContentPosY)
	CharacterModel.instance:setCardListByExSkill(false, CharacterEnum.FilterType.HeroGroup)
	slot0:_refreshCurScrollBySort()
	slot0:_refreshBtnIcon()
end

function slot0._btnlvrankOnClick(slot0)
	slot1, slot2 = transformhelper.getLocalPos(slot0._goScrollContent.transform)

	transformhelper.setLocalPosXY(slot0._goScrollContent.transform, slot1, slot0._initScrollContentPosY)
	CharacterModel.instance:setCardListByLevel(false, CharacterEnum.FilterType.HeroGroup)
	slot0:_refreshCurScrollBySort()
	slot0:_refreshBtnIcon()
end

function slot0._btnrarerankOnClick(slot0)
	slot1, slot2 = transformhelper.getLocalPos(slot0._goScrollContent.transform)

	transformhelper.setLocalPosXY(slot0._goScrollContent.transform, slot1, slot0._initScrollContentPosY)
	CharacterModel.instance:setCardListByRare(false, CharacterEnum.FilterType.HeroGroup)
	slot0:_refreshCurScrollBySort()
	slot0:_refreshBtnIcon()
end

function slot0._btnquickeditOnClick(slot0)
	slot0._isShowQuickEdit = not slot0._isShowQuickEdit

	slot0:_refreshBtnIcon()
	slot0:_refreshEditMode()

	if slot0._isShowQuickEdit then
		slot0:_onHeroItemClick(nil)
		slot0._heroGroupQuickEditListModel:cancelAllSelected()
		slot0._heroGroupQuickEditListModel:copyQuickEditCardList()

		if slot0._heroGroupQuickEditListModel:getById(slot0._originalHeroUid) then
			slot0._heroGroupQuickEditListModel:selectCell(slot0._heroGroupQuickEditListModel:getIndex(slot1), true)
		end
	else
		slot0:_saveQuickGroupInfo()
		slot0:_onHeroItemClick(nil)
		slot0._heroGroupEditListModel:cancelAllSelected()

		if slot0._heroSingleGroupModel:getHeroUid(slot0._singleGroupMOId) ~= "0" then
			slot0._heroGroupEditListModel:selectCell(slot0._heroGroupEditListModel:getIndex(slot0._heroGroupEditListModel:getById(slot1)), true)
		end

		slot0._heroGroupEditListModel:copyCharacterCardList()
	end

	slot0:_updateTotalCapacity()
	RougeController.instance:dispatchEvent(RougeEvent.OnSwitchHeroGroupEditMode)
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

function slot0._onClickHeroEditItem(slot0, slot1)
	slot0:_onHeroItemClick(slot1)
	slot0:_updateTotalCapacity()
end

function slot0._onHeroItemClick(slot0, slot1)
	slot0._heroMO = slot1

	slot0:_refreshCharacterInfo()
end

function slot0._refreshCharacterInfo(slot0)
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
end

function slot0._refreshMainInfo(slot0)
	if slot0._heroMO then
		gohelper.setActive(slot0._btntrial.gameObject, slot0._heroMO:isTrial())
		gohelper.setActive(slot0._btntrialWithTalent.gameObject, slot0._heroMO:isTrial())
		UISpriteSetMgr.instance:setCommonSprite(slot0._imagecareericon, "lssx_" .. tostring(slot0._heroMO.config.career))
		UISpriteSetMgr.instance:setCommonSprite(slot0._imagedmgtype, "dmgtype" .. tostring(slot0._heroMO.config.dmgType))

		slot0._txtname.text = slot0._heroMO.config.name
		slot0._txtnameen.text = slot0._heroMO.config.nameEng
		slot1 = CharacterEnum.TalentRank <= slot0._heroMO.rank and slot0._heroMO.talent > 0

		if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) then
			slot1 = false
		end

		slot2 = 0
		slot3 = 0
		slot4 = 0
		slot5 = false

		if not slot0._heroMO:isTrial() then
			slot2, slot7, slot4 = RougeHeroGroupBalanceHelper.getHeroBalanceInfo(slot0._heroMO.heroId)

			if slot7 and CharacterEnum.TalentRank <= slot3 and slot4 > 0 then
				slot5 = true
			end
		end

		slot7 = slot5 and (not slot1 or slot0._heroMO.talent < slot4)

		if slot1 or slot5 then
			gohelper.setActive(slot0._golevel, false)
			gohelper.setActive(slot0._golevelWithTalent, true)
			gohelper.setActive(slot0._goBalanceWithTalent, false)
			gohelper.setActive(slot0._goheroLvTxtWithTalent, true)

			if slot2 and slot0._heroMO.level < slot2 then
				slot8, slot9 = HeroConfig.instance:getShowLevel(slot2)
				slot0._txtlevelWithTalent.text = "<color=#8fb1cc>" .. tostring(slot8)
				slot0._txtlevelmaxWithTalent.text = string.format("/%d", HeroConfig.instance:getShowLevel(CharacterModel.instance:getrankEffects(slot0._heroMO.heroId, slot9)[1]))

				slot0:refreshWithTalentRankIcon(slot9, true)
			else
				slot0._txtlevelWithTalent.text = tostring(HeroConfig.instance:getShowLevel(slot0._heroMO.level))
				slot0._txtlevelmaxWithTalent.text = string.format("/%d", HeroConfig.instance:getShowLevel(CharacterModel.instance:getrankEffects(slot0._heroMO.heroId, slot0._heroMO.rank)[1]))

				slot0:refreshWithTalentRankIcon(slot0._heroMO.rank)
			end

			if slot7 then
				slot0._txttalent.text = "<color=#8fb1cc>Lv.<size=40>" .. tostring(slot4)
				slot0._txttalenticon.color = GameUtil.parseColor("#89dafd")
			else
				slot0._txttalent.text = "Lv.<size=40>" .. tostring(slot0._heroMO.talent)
				slot0._txttalenticon.color = GameUtil.parseColor("#D3CCBF")
			end

			slot0._txttalentType.text = luaLang("talent_character_talentcn" .. CharacterEnum.TalentTxtByHeroType[slot0._heroMO.config.heroType])
		else
			gohelper.setActive(slot0._golevel, true)
			gohelper.setActive(slot0._golevelWithTalent, false)
			gohelper.setActive(slot0._goBalance, false)
			gohelper.setActive(slot0._goheroLvTxt, not slot6)

			if slot6 then
				slot8, slot9 = HeroConfig.instance:getShowLevel(slot2)
				slot0._txtlevel.text = "<color=#8fb1cc>" .. tostring(slot8)
				slot0._txtlevelmax.text = string.format("/%d", HeroConfig.instance:getShowLevel(CharacterModel.instance:getrankEffects(slot0._heroMO.heroId, slot9)[1]))

				slot0:refreshRankIcon(slot9, true)
			else
				slot0._txtlevel.text = tostring(HeroConfig.instance:getShowLevel(slot0._heroMO.level))
				slot0._txtlevelmax.text = string.format("/%d", HeroConfig.instance:getShowLevel(CharacterModel.instance:getrankEffects(slot0._heroMO.heroId, slot0._heroMO.rank)[1]))

				slot0:refreshRankIcon(slot0._heroMO.rank)
			end
		end

		slot8 = {}

		if not string.nilorempty(slot0._heroMO.config.battleTag) then
			slot8 = string.split(slot0._heroMO.config.battleTag, "#")
		end

		for slot12 = 1, #slot8 do
			if not slot0._careerGOs[slot12] then
				slot13 = slot0:getUserDataTb_()
				slot13.go = gohelper.cloneInPlace(slot0._gospecialitem, "item" .. slot12)
				slot13.textfour = gohelper.findChildText(slot13.go, "#go_fourword/name")
				slot13.textthree = gohelper.findChildText(slot13.go, "#go_threeword/name")
				slot13.texttwo = gohelper.findChildText(slot13.go, "#go_twoword/name")
				slot13.containerfour = gohelper.findChild(slot13.go, "#go_fourword")
				slot13.containerthree = gohelper.findChild(slot13.go, "#go_threeword")
				slot13.containertwo = gohelper.findChild(slot13.go, "#go_twoword")

				table.insert(slot0._careerGOs, slot13)
			end

			gohelper.setActive(slot13.containertwo, GameUtil.utf8len(HeroConfig.instance:getBattleTagConfigCO(slot8[slot12]).tagName) <= 2)
			gohelper.setActive(slot13.containerthree, slot15 == 3)
			gohelper.setActive(slot13.containerfour, slot15 >= 4)

			if slot15 <= 2 then
				slot13.texttwo.text = slot14
			elseif slot15 == 3 then
				slot13.textthree.text = slot14
			else
				slot13.textfour.text = slot14
			end

			gohelper.setActive(slot13.go, true)
		end

		for slot12 = #slot8 + 1, #slot0._careerGOs do
			gohelper.setActive(slot0._careerGOs[slot12].go, false)
		end
	end
end

function slot0.refreshRankIcon(slot0, slot1, slot2)
	slot0:initRankGoList()

	for slot6, slot7 in ipairs(slot0.rankGoList) do
		gohelper.setActive(slot7, slot6 == slot1 - 1)
		SLFramework.UGUI.GuiHelper.SetColor(slot7:GetComponent(gohelper.Type_Image), slot2 and "#89dafd" or "#D3CCBF")
	end
end

function slot0.initRankGoList(slot0)
	if not slot0.rankGoList then
		slot0.rankGoList = slot0:getUserDataTb_()

		for slot4 = 1, 3 do
			table.insert(slot0.rankGoList, gohelper.findChild(slot0._gorank, "rank" .. slot4))
		end
	end

	return slot0.rankGoList
end

function slot0.refreshWithTalentRankIcon(slot0, slot1, slot2)
	slot0:initRankGoWithTalentList()

	for slot6, slot7 in ipairs(slot0.rankGoWithTalentList) do
		gohelper.setActive(slot7, slot6 == slot1 - 1)
		SLFramework.UGUI.GuiHelper.SetColor(slot7:GetComponent(gohelper.Type_Image), slot2 and "#89dafd" or "#D3CCBF")
	end
end

function slot0.initRankGoWithTalentList(slot0)
	if not slot0.rankGoWithTalentList then
		slot0.rankGoWithTalentList = slot0:getUserDataTb_()

		for slot4 = 1, 3 do
			table.insert(slot0.rankGoWithTalentList, gohelper.findChild(slot0._gowithtalentrank, "rank" .. slot4))
		end
	end

	return slot0.rankGoList
end

function slot0._refreshAttribute(slot0)
	if slot0._heroMO then
		slot2 = nil

		if HeroGroupTrialModel.instance:getById(slot0._originalHeroUid) then
			slot2 = slot1.trialEquipMo
		end

		for slot7, slot8 in ipairs(CharacterEnum.BaseAttrIdList) do
			slot0._attributevalues[slot7].name.text = HeroConfig.instance:getHeroAttributeCO(slot8).name
			slot0._attributevalues[slot7].value.text = slot0._heroMO:getTotalBaseAttrDict(slot0._equips, nil, , RougeHeroGroupBalanceHelper.getIsBalanceMode() and not slot0._heroMO:isTrial(), slot2, RougeHeroGroupBalanceHelper.getHeroBalanceInfo)[slot8]

			CharacterController.instance:SetAttriIcon(slot0._attributevalues[slot7].icon, slot8)
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

	slot5 = 0

	if not slot0._heroMO:isTrial() then
		slot5 = RougeHeroGroupBalanceHelper.getHeroBalanceLv(slot0._heroMO.heroId)
	end

	slot6 = slot0._heroMO.level < slot5
	slot7, slot8 = SkillConfig.instance:getHeroExSkillLevelByLevel(slot0._heroMO.heroId, math.max(slot0._heroMO.level, slot5))

	for slot12 = 1, #slot1 do
		slot13 = slot12 <= slot7

		gohelper.setActive(slot0._passiveskillitems[slot12].on, slot13 and not slot6)
		gohelper.setActive(slot0._passiveskillitems[slot12].off, not slot13)
		gohelper.setActive(slot0._passiveskillitems[slot12].balance, slot13 and slot6)
		gohelper.setActive(slot0._passiveskillitems[slot12].go, true)
	end

	for slot12 = #slot1 + 1, #slot0._passiveskillitems do
		gohelper.setActive(slot0._passiveskillitems[slot12].go, false)
	end
end

function slot0._refreshSkill(slot0)
	slot0._skillContainer:onUpdateMO(slot0._heroMO and slot0._heroMO.heroId, nil, slot0._heroMO, RougeHeroGroupBalanceHelper.getIsBalanceMode() and not slot0._heroMO:isTrial())
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

	for slot7, slot8 in pairs(slot0._selectLocations) do
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

function slot0._updateHeroList(slot0)
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

	if slot0._isShowQuickEdit then
		slot0._heroGroupQuickEditListModel:copyQuickEditCardList()
	else
		slot0._heroGroupEditListModel:copyCharacterCardList()
	end
end

function slot0.replaceSelectHeroDefaultEquip(slot0)
	if slot0._heroMO and slot0._heroMO:hasDefaultEquip() and slot0._singleGroupMOId <= RougeEnum.FightTeamNormalHeroNum then
		for slot6, slot7 in pairs(slot0._heroGroupModel:getCurGroupMO().equips) do
			if slot7.equipUid[1] == slot0._heroMO.defaultEquipUid then
				slot7.equipUid[1] = "0"

				break
			end
		end

		slot2[slot0._singleGroupMOId - 1].equipUid[1] = slot0._heroMO.defaultEquipUid
	end
end

function slot0.replaceQuickGroupHeroDefaultEquip(slot0, slot1)
	if slot0._isInitType then
		return
	end

	slot3 = slot0._heroGroupModel:getCurGroupMO().equips
	slot4 = nil

	for slot8, slot9 in ipairs(slot1) do
		if HeroModel.instance:getById(slot9) and slot4:hasDefaultEquip() then
			for slot13, slot14 in pairs(slot3) do
				if slot14.equipUid[1] == slot4.defaultEquipUid then
					slot14.equipUid[1] = "0"

					break
				end
			end

			slot3[slot8 - 1].equipUid[1] = slot4.defaultEquipUid
		end
	end
end

function slot0._saveCurGroupInfo(slot0)
	if not slot0:_isFightEditType() then
		if slot0._isInitType then
			slot0._heroSingleGroupModel:getCurGroupMO():replaceHeroList(slot0._heroSingleGroupModel.instance:getList())
		end

		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)

		return
	end

	slot1 = slot0._heroSingleGroupModel:getHeroUids()
	slot2 = slot0._heroGroupModel:getCurGroupMO()

	slot0:replaceSelectHeroDefaultEquip()
	slot0._heroGroupModel:replaceSingleGroup()
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
	slot0._heroGroupModel:saveCurGroupData()
	slot0._heroGroupModel:rougeSaveCurGroup()
end

function slot0._saveQuickGroupInfo(slot0, slot1)
	if slot0.viewParam.heroGroupEditType == RougeEnum.HeroGroupEditType.SelectHero then
		if slot1 then
			slot0.viewContainer:checkSelectHeroResult()
		end

		return
	end

	slot2 = nil
	slot2 = (not slot0._isInitType or RougeEnum.InitTeamHeroNum) and slot0._heroGroupModel:getBattleRoleNum()

	if slot0._heroGroupQuickEditListModel:getIsDirty() then
		slot0:replaceQuickGroupHeroDefaultEquip(slot0._heroGroupQuickEditListModel:getHeroUids())

		for slot7 = 1, slot2 do
			if slot3[slot7] ~= nil then
				slot9, slot10 = slot0._heroSingleGroupModel:hasHeroUids(slot8, slot0._singleGroupMOId)

				if slot9 then
					slot0._heroSingleGroupModel:removeFrom(slot10)
				end

				slot0._heroSingleGroupModel:addTo(slot8, slot7)

				if tonumber(slot8) < 0 then
					if HeroGroupTrialModel.instance:getById(slot8) then
						slot0._heroSingleGroupModel:getByIndex(slot7):setTrial(slot12.trialCo.id, slot12.trialCo.trialTemplate)
					else
						slot11:setTrial()
					end
				else
					slot11:setTrial()
				end
			end
		end

		slot0._heroGroupModel:replaceSingleGroup()
		slot0._heroGroupModel:replaceSingleGroupEquips()
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)

		if slot0._isInitType then
			return
		end

		slot0._heroGroupModel:saveCurGroupData()
		slot0._heroGroupModel:rougeSaveCurGroup()
	end
end

function slot0._onAttributeChanged(slot0, slot1, slot2)
	CharacterModel.instance:setFakeLevel(slot2, slot1)
end

function slot0._normalEditHasChange(slot0)
	if Activity104Model.instance:isSeasonChapter() then
		return true
	end

	if slot0._heroSingleGroupModel:getHeroUid(slot0._singleGroupMOId) ~= slot0._originalHeroUid then
		return true
	end

	if slot0._originalHeroUid and slot0._heroMO and slot0._originalHeroUid == slot0._heroMO.uid then
		return false
	elseif (not slot0._originalHeroUid or slot0._originalHeroUid == "0") and not slot0._heroMO then
		return false
	else
		return true
	end
end

function slot0._refreshEditMode(slot0)
	gohelper.setActive(slot0._scrollquickedit.gameObject, slot0._isShowQuickEdit)
	gohelper.setActive(slot0._scrollcard.gameObject, not slot0._isShowQuickEdit)
	gohelper.setActive(slot0._goBtnEditQuickMode.gameObject, slot0._isShowQuickEdit)
	gohelper.setActive(slot0._goBtnEditNormalMode.gameObject, not slot0._isShowQuickEdit)
end

function slot0._refreshCurScrollBySort(slot0)
	if slot0._isShowQuickEdit then
		if slot0._heroGroupQuickEditListModel:getIsDirty() then
			slot0:_saveQuickGroupInfo()
		end

		slot0._heroGroupQuickEditListModel:copyQuickEditCardList()

		if slot0._heroMO ~= slot0._heroMO then
			slot0._heroGroupQuickEditListModel:cancelAllSelected()
		end
	else
		slot0._heroGroupEditListModel:copyCharacterCardList()
	end
end

function slot0._onGroupModify(slot0)
	if slot0._isShowQuickEdit then
		slot0._heroGroupQuickEditListModel:copyQuickEditCardList()
	else
		if slot0._originalHeroUid ~= slot0._heroSingleGroupModel:getHeroUid(slot0._singleGroupMOId) then
			slot0._originalHeroUid = slot1

			slot0._heroGroupEditListModel:setParam(slot1, slot0._adventure)
			slot0:_onHeroItemClick(nil)
			slot0._heroGroupEditListModel:cancelAllSelected()
			slot0._heroGroupEditListModel:selectCell(slot0._heroGroupEditListModel:getIndex(slot0._heroGroupEditListModel:getById(slot1)), true)
		end

		slot0._heroGroupEditListModel:copyCharacterCardList()
	end
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gospecialitem, false)

	slot0._careerGOs = {}
	slot0._imgBg = gohelper.findChildSingleImage(slot0.viewGO, "bg/bgimg")
	slot0._simageredlight = gohelper.findChildSingleImage(slot0.viewGO, "bg/#simage_redlight")

	slot0._imgBg:LoadImage(ResUrl.getCommonViewBg("full/biandui_di"))

	slot4 = "guang_027"

	slot0._simageredlight:LoadImage(ResUrl.getHeroGroupBg(slot4))

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

	slot0._goBtnEditQuickMode = gohelper.findChild(slot0._btnquickedit.gameObject, "btn2")
	slot0._goBtnEditNormalMode = gohelper.findChild(slot0._btnquickedit.gameObject, "btn1")
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
		slot5.balance = gohelper.findChild(slot5.go, "balance")
		slot0._passiveskillitems[slot4] = slot5
	end

	slot0._skillContainer = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._goskill, CharacterSkillContainer)

	gohelper.setActive(slot0._gononecharacter, false)
	gohelper.setActive(slot0._gocharacterinfo, false)

	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(slot0._gorecommendAttrDesc, false)

	slot0._fightTip = gohelper.findChild(slot0.viewGO, "#go_chooserole/fight")
	slot0._fightAssitTip = gohelper.findChild(slot0.viewGO, "#go_chooserole/assit")
end

function slot0._isFightEditType(slot0)
	return slot0.viewParam.heroGroupEditType == RougeEnum.HeroGroupEditType.Fight or slot0.viewParam.heroGroupEditType == RougeEnum.HeroGroupEditType.FightAssit
end

function slot0._initFightTip(slot0)
	gohelper.setActive(slot0._fightTip, slot0.viewParam.heroGroupEditType == RougeEnum.HeroGroupEditType.Fight)
	gohelper.setActive(slot0._fightAssitTip, slot1 == RougeEnum.HeroGroupEditType.FightAssit)
end

function slot0._initCapacity(slot0)
	slot0._selectHeroCapacity = slot0.viewParam.selectHeroCapacity
	slot0._curCapacity = slot0.viewParam.curCapacity
	slot0._totalCapacity = slot0.viewParam.totalCapacity
	slot0._assistCapacity = slot0.viewParam.assistCapacity
	slot0._assistPos = slot0.viewParam.assistPos
	slot0._assistHeroId = slot0.viewParam.assistHeroId

	RougeHeroGroupEditListModel.instance:setCapacityInfo(slot0._selectHeroCapacity, slot0._curCapacity, slot0._totalCapacity, slot0._assistCapacity, slot0._assistPos, slot0._assistHeroId)

	if not slot0._capacityComp then
		slot1 = gohelper.findChild(slot0.viewGO, "characterinfo/volumebg/volume")

		if slot0.viewParam.heroGroupEditType == RougeEnum.HeroGroupEditType.SelectHero then
			gohelper.findChildText(slot0.viewGO, "characterinfo/volumebg/txt_titletips").text = luaLang("p_rougeinitteamview_txt_titletips")
		else
			slot2.text = luaLang("p_rougeinitteamview_txt_titletips2")
		end

		slot3 = nil

		if slot0:_isFightEditType() then
			slot3 = RougeCapacityComp.SpriteType2
		end

		slot0._capacityComp = RougeCapacityComp.Add(slot1, slot0._curCapacity, slot0._totalCapacity, true, slot3)

		slot0._capacityComp:showChangeEffect(true)
	else
		slot0._capacityComp:updateCurAndMaxNum(slot0._curCapacity, slot0._totalCapacity)
	end
end

function slot0._updateTotalCapacity(slot0)
	if slot0._isShowQuickEdit then
		slot0._capacityComp:updateCurAndMaxNum(RougeHeroGroupQuickEditListModel.instance:calcTotalCapacity(), slot0._totalCapacity)

		return
	end

	slot0._capacityComp:updateCurAndMaxNum(RougeHeroGroupEditListModel.instance:calcTotalCapacity(slot0._singleGroupMOId, slot0._heroMO), slot0._totalCapacity)
end

function slot0.onUpdateParam(slot0)
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Team_Open)
end

function slot0._initFakeLevelList(slot0, slot1)
	if not RougeHeroGroupBalanceHelper.getIsBalanceMode() then
		return
	end

	for slot6, slot7 in ipairs(slot1) do
		if slot7.level < RougeHeroGroupBalanceHelper.getHeroBalanceLv(slot7.heroId) then
			-- Nothing
		end
	end

	CharacterModel.instance:setFakeList({
		[slot7.heroId] = slot8
	})
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Team_Open)

	slot0._isShowQuickEdit = false
	slot0._scrollcard.verticalNormalizedPosition = 1
	slot0._scrollquickedit.verticalNormalizedPosition = 1
	slot0._originalHeroUid = slot0.viewParam.originalHeroUid
	slot0._singleGroupMOId = slot0.viewParam.singleGroupMOId
	slot0._adventure = slot0.viewParam.adventure
	slot0._equips = slot0.viewParam.equips

	for slot4 = 1, 2 do
		slot0._selectDmgs[slot4] = false
	end

	for slot4 = 1, 6 do
		slot0._selectAttrs[slot4] = false
	end

	for slot4 = 1, 6 do
		slot0._selectLocations[slot4] = false
	end

	slot0._heroGroupEditListModel = RougeHeroGroupEditListModel.instance
	slot0._heroGroupQuickEditListModel = RougeHeroGroupQuickEditListModel.instance
	slot0._heroSingleGroupModel = RougeHeroSingleGroupModel.instance
	slot0._heroGroupModel = RougeHeroGroupModel.instance
	slot1 = nil
	slot1 = (not slot0:_isFightEditType() or RougeHeroGroupEditListModel.instance:getTeamNoSortedList()) and HeroModel.instance:getList()

	CharacterModel.instance:setHeroList(slot1)
	slot0:_initFakeLevelList(slot1)
	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.HeroGroup)
	slot0._heroGroupEditListModel:setParam(slot0._originalHeroUid, slot0._adventure, slot0._heroHps)
	slot0._heroGroupQuickEditListModel:setParam(slot0._adventure, slot0._heroHps)
	slot0._heroGroupEditListModel:setHeroGroupEditType(slot0.viewParam.heroGroupEditType)

	slot0._isInitType = slot0.viewParam.heroGroupEditType == RougeEnum.HeroGroupEditType.Init

	slot0.viewContainer:_setHomeBtnVisible(slot0:_isFightEditType())
	slot0:_initCapacity()
	slot0:_initFightTip()

	slot0._heroMO = slot0._heroGroupEditListModel:copyCharacterCardList(true)

	slot0:_refreshEditMode()
	slot0:_refreshBtnIcon()
	slot0:_refreshCharacterInfo()
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, slot0._updateHeroList, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, slot0._updateHeroList, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, slot0._updateHeroList, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroEditItem, slot0._onClickHeroEditItem, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, slot0._refreshCharacterInfo, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, slot0._refreshCharacterInfo, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, slot0._refreshCharacterInfo, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, slot0._refreshCharacterInfo, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, slot0._refreshCharacterInfo, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.levelUpAttribute, slot0._onAttributeChanged, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.showCharacterRankUpView, slot0._showCharacterRankUpView, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, slot0._onGroupModify, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, slot0._onGroupModify, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:addEventCb(CharacterController.instance, CharacterEvent.HeroUpdatePush, slot0._refreshCharacterInfo, slot0)
	gohelper.addUIClickAudio(slot0._btnlvrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(slot0._btnrarerank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(slot0._btnexskillrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(slot0._btnattribute.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(slot0._btnpassiveskill.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(slot0._btncharacter.gameObject, AudioEnum.UI.UI_Common_Click)

	_, slot0._initScrollContentPosY = transformhelper.getLocalPos(slot0._goScrollContent.transform)

	gohelper.setActive(slot0._btnquickedit, slot0.viewParam.heroGroupEditType == RougeEnum.HeroGroupEditType.Fight or slot0._isInitType)

	if slot0.viewParam.heroGroupEditType == RougeEnum.HeroGroupEditType.SelectHero then
		slot0:_btnquickeditOnClick()
	end

	slot0:_updateTotalCapacity()
end

function slot0.onClose(slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, slot0._updateHeroList, slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, slot0._updateHeroList, slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, slot0._updateHeroList, slot0)
	slot0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroEditItem, slot0._onClickHeroEditItem, slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, slot0._refreshCharacterInfo, slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, slot0._refreshCharacterInfo, slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, slot0._refreshCharacterInfo, slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, slot0._refreshCharacterInfo, slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, slot0._refreshCharacterInfo, slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.levelUpAttribute, slot0._onAttributeChanged, slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.showCharacterRankUpView, slot0._showCharacterRankUpView, slot0)
	slot0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, slot0._onGroupModify, slot0)
	slot0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, slot0._onGroupModify, slot0)
	slot0:removeEventCb(CharacterController.instance, CharacterEvent.HeroUpdatePush, slot0._refreshCharacterInfo, slot0)
	CharacterModel.instance:clearFakeList()
	CharacterModel.instance:setFakeLevel()
	slot0._heroGroupEditListModel:cancelAllSelected()
	slot0._heroGroupEditListModel:clear()
	slot0._heroGroupQuickEditListModel:cancelAllSelected()
	slot0._heroGroupQuickEditListModel:clear()
	HeroGroupTrialModel.instance:setFilter()
	CommonHeroHelper.instance:resetGrayState()

	slot0._selectDmgs = {}
	slot0._selectAttrs = {}
	slot0._selectLocations = {}

	if slot0._isStopBgm then
		TaskDispatcher.cancelTask(slot0._delyStopBgm, slot0)
		slot0:_delyStopBgm()
	end
end

function slot0._onOpenView(slot0, slot1)
	if slot1 == ViewName.CharacterView and slot0._isStopBgm then
		TaskDispatcher.cancelTask(slot0._delyStopBgm, slot0)
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Unsatisfied_Music)

		return
	end
end

function slot0._showRecommendCareer(slot0)
	slot1, slot2 = FightHelper.detectAttributeCounter()

	gohelper.CreateObjList(slot0, slot0._onRecommendCareerItemShow, slot1, slot0._goattrlist, slot0._goattritem)

	slot0._txtrecommendAttrDesc.text = #slot1 == 0 and luaLang("herogroupeditview_notrecommend") or luaLang("herogroupeditview_recommend")

	gohelper.setActive(slot0._goattrlist, #slot1 ~= 0)
end

function slot0._onRecommendCareerItemShow(slot0, slot1, slot2, slot3)
	UISpriteSetMgr.instance:setHeroGroupSprite(gohelper.findChildImage(slot1, "icon"), "career_" .. slot2)
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.CharacterView then
		AudioMgr.instance:trigger(AudioEnum.UI.Stop_UIMusic)

		slot0._isStopBgm = true

		TaskDispatcher.cancelTask(slot0._delyStopBgm, slot0)
		TaskDispatcher.runDelay(slot0._delyStopBgm, slot0, 1)
	end
end

function slot0._delyStopBgm(slot0)
	slot0._isStopBgm = false

	AudioMgr.instance:trigger(AudioEnum.Bgm.Pause_FightingMusic)
end

function slot0._showCharacterRankUpView(slot0, slot1)
	slot1()
end

function slot0.onDestroyView(slot0)
	CharacterModel.instance:clearFakeList()
	CharacterModel.instance:setHeroList(nil)

	if slot0:_isFightEditType() then
		CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.HeroGroup)
	end

	slot0._imgBg:UnLoadImage()
	slot0._simageredlight:UnLoadImage()

	slot0._imgBg = nil
	slot0._simageredlight = nil

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

return slot0
