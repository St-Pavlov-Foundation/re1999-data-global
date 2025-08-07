module("modules.logic.sp01.odyssey.view.OdysseyHeroGroupEditView", package.seeall)

local var_0_0 = class("OdysseyHeroGroupEditView", HeroGroupEditView)

function var_0_0.onOpen(arg_1_0)
	arg_1_0._isShowQuickEdit = false
	arg_1_0._scrollcard.verticalNormalizedPosition = 1
	arg_1_0._scrollquickedit.verticalNormalizedPosition = 1
	arg_1_0._originalHeroUid = arg_1_0.viewParam.originalHeroUid
	arg_1_0._singleGroupMOId = arg_1_0.viewParam.singleGroupMOId
	arg_1_0._adventure = arg_1_0.viewParam.adventure
	arg_1_0._equips = arg_1_0.viewParam.equips
	arg_1_0._isTowerBattle = TowerModel.instance:isInTowerBattle()
	arg_1_0._groupType = arg_1_0:_getGroupType()
	arg_1_0._isWeekWalk_2 = arg_1_0._groupType == HeroGroupEnum.GroupType.WeekWalk_2

	for iter_1_0 = 1, 2 do
		arg_1_0._selectDmgs[iter_1_0] = false
	end

	for iter_1_1 = 1, 6 do
		arg_1_0._selectAttrs[iter_1_1] = false
	end

	for iter_1_2 = 1, 6 do
		arg_1_0._selectLocations[iter_1_2] = false
	end

	CharacterModel.instance:setCharacterList(false, CharacterEnum.FilterType.HeroGroup)

	local var_1_0 = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.TrialHeroId)
	local var_1_1 = tonumber(var_1_0.value)

	HeroGroupTrialModel.instance:setTrailByTrialIdList({
		var_1_1
	}, 1)
	HeroGroupEditListModel.instance:setParam(arg_1_0._originalHeroUid, arg_1_0._adventure, arg_1_0._isTowerBattle, arg_1_0._groupType)
	HeroGroupQuickEditListModel.instance:setParam(arg_1_0._adventure, arg_1_0._isTowerBattle, arg_1_0._groupType)

	arg_1_0._heroMO = HeroGroupEditListModel.instance:copyCharacterCardList(true)

	arg_1_0:_refreshEditMode()
	arg_1_0:_refreshBtnIcon()
	arg_1_0:_refreshCharacterInfo()
	arg_1_0:_showRecommendCareer()
	arg_1_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_1_0._updateHeroList, arg_1_0)
	arg_1_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_1_0._updateHeroList, arg_1_0)
	arg_1_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_1_0._updateHeroList, arg_1_0)
	arg_1_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroEditItem, arg_1_0._onHeroItemClick, arg_1_0)
	arg_1_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroRankUp, arg_1_0._refreshCharacterInfo, arg_1_0)
	arg_1_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroLevelUp, arg_1_0._refreshCharacterInfo, arg_1_0)
	arg_1_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_1_0._refreshCharacterInfo, arg_1_0)
	arg_1_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroTalentUp, arg_1_0._refreshCharacterInfo, arg_1_0)
	arg_1_0:addEventCb(CharacterController.instance, CharacterEvent.successHeroExSkillUp, arg_1_0._refreshCharacterInfo, arg_1_0)
	arg_1_0:addEventCb(CharacterController.instance, CharacterEvent.levelUpAttribute, arg_1_0._onAttributeChanged, arg_1_0)
	arg_1_0:addEventCb(CharacterController.instance, CharacterEvent.showCharacterRankUpView, arg_1_0._showCharacterRankUpView, arg_1_0)
	arg_1_0:addEventCb(CharacterController.instance, CharacterEvent.OnMarkFavorSuccess, arg_1_0._markFavorSuccess, arg_1_0)
	arg_1_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_1_0._onGroupModify, arg_1_0)
	arg_1_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_1_0._onGroupModify, arg_1_0)
	arg_1_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_1_0._onOpenView, arg_1_0)
	arg_1_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_1_0._onCloseView, arg_1_0)
	arg_1_0:addEventCb(CharacterController.instance, CharacterEvent.HeroUpdatePush, arg_1_0._refreshCharacterInfo, arg_1_0)
	arg_1_0:addEventCb(AudioMgr.instance, AudioMgr.Evt_Trigger, arg_1_0._onAudioTrigger, arg_1_0)
	gohelper.addUIClickAudio(arg_1_0._btnlvrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_1_0._btnrarerank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_1_0._btnexskillrank.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_1_0._btnattribute.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_1_0._btnpassiveskill.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(arg_1_0._btncharacter.gameObject, AudioEnum.UI.UI_Common_Click)

	_, arg_1_0._initScrollContentPosY = transformhelper.getLocalPos(arg_1_0._goScrollContent.transform)
end

function var_0_0._showRecommendCareer(arg_2_0)
	OdysseyTalentModel.instance:setTrialCassandraTreeInfo()

	if FightModel.instance:getFightParam() == nil then
		return
	end

	local var_2_0, var_2_1 = FightHelper.detectAttributeCounter()

	gohelper.CreateObjList(arg_2_0, arg_2_0._onRecommendCareerItemShow, var_2_0, arg_2_0._goattrlist, arg_2_0._goattritem)

	arg_2_0._txtrecommendAttrDesc.text = #var_2_0 == 0 and luaLang("herogroupeditview_notrecommend") or luaLang("herogroupeditview_recommend")

	gohelper.setActive(arg_2_0._goattrlist, #var_2_0 ~= 0)
end

function var_0_0._btnconfirmOnClick(arg_3_0)
	if arg_3_0._isShowQuickEdit then
		local var_3_0 = HeroGroupQuickEditListModel.instance:getHeroUids()

		if var_3_0 and #var_3_0 > 0 then
			if arg_3_0._adventure then
				for iter_3_0, iter_3_1 in pairs(var_3_0) do
					local var_3_1 = HeroModel.instance:getById(iter_3_1)

					if var_3_1 and WeekWalkModel.instance:getCurMapHeroCd(var_3_1.heroId) > 0 then
						GameFacade.showToast(ToastEnum.HeroGroupEdit)

						return
					end
				end
			elseif arg_3_0._isWeekWalk_2 then
				for iter_3_2, iter_3_3 in pairs(var_3_0) do
					local var_3_2 = HeroModel.instance:getById(iter_3_3)

					if var_3_2 and WeekWalk_2Model.instance:getCurMapHeroCd(var_3_2.heroId) > 0 then
						GameFacade.showToast(ToastEnum.HeroGroupEdit)

						return
					end
				end
			elseif arg_3_0._isTowerBattle then
				for iter_3_4, iter_3_5 in pairs(var_3_0) do
					local var_3_3 = HeroModel.instance:getById(iter_3_5)

					if var_3_3 and TowerModel.instance:isHeroBan(var_3_3.heroId) then
						GameFacade.showToast(ToastEnum.TowerHeroGroupEdit)

						return
					end
				end
			end
		end

		arg_3_0:_saveQuickGroupInfo()
		arg_3_0:closeThis()

		return
	end

	if not arg_3_0:_normalEditHasChange() then
		arg_3_0:closeThis()

		return
	end

	local var_3_4 = HeroSingleGroupModel.instance:getById(arg_3_0._singleGroupMOId)

	if var_3_4.trialPos then
		GameFacade.showToast(ToastEnum.TrialCantTakeOff)

		return
	end

	if arg_3_0._heroMO then
		if arg_3_0._adventure then
			if WeekWalkModel.instance:getCurMapHeroCd(arg_3_0._heroMO.heroId) > 0 then
				GameFacade.showToast(ToastEnum.HeroGroupEdit)

				return
			end
		elseif arg_3_0._isWeekWalk_2 then
			if WeekWalk_2Model.instance:getCurMapHeroCd(arg_3_0._heroMO.heroId) > 0 then
				GameFacade.showToast(ToastEnum.HeroGroupEdit)

				return
			end
		elseif arg_3_0._isTowerBattle and TowerModel.instance:isHeroBan(arg_3_0._heroMO.heroId) then
			GameFacade.showToast(ToastEnum.TowerHeroGroupEdit)

			return
		end

		if arg_3_0._heroMO.isPosLock then
			GameFacade.showToast(ToastEnum.TrialCantTakeOff)

			return
		end

		if arg_3_0._heroMO:isTrial() and not HeroSingleGroupModel.instance:isInGroup(arg_3_0._heroMO.uid) and (var_3_4:isEmpty() or not var_3_4.trial) and HeroGroupEditListModel.instance:isTrialLimit() then
			GameFacade.showToast(ToastEnum.TrialJoinLimit, HeroGroupTrialModel.instance:getLimitNum())

			return
		end

		local var_3_5, var_3_6 = HeroSingleGroupModel.instance:hasHeroUids(arg_3_0._heroMO.uid, arg_3_0._singleGroupMOId)

		if var_3_5 then
			HeroSingleGroupModel.instance:removeFrom(var_3_6)
			OdysseyHeroGroupModel.instance:getCurHeroGroup():swapOdysseyEquips(var_3_6 - 1, arg_3_0._singleGroupMOId - 1)
			HeroSingleGroupModel.instance:addTo(arg_3_0._heroMO.uid, arg_3_0._singleGroupMOId)

			if arg_3_0._heroMO:isTrial() then
				var_3_4:setTrial(arg_3_0._heroMO.trialCo.id, arg_3_0._heroMO.trialCo.trialTemplate)
			else
				var_3_4:setTrial()
			end

			FightAudioMgr.instance:playHeroVoiceRandom(arg_3_0._heroMO.heroId, CharacterEnum.VoiceType.HeroGroup)
			arg_3_0:_saveCurGroupInfo()
			arg_3_0:closeThis()

			return
		end

		if HeroSingleGroupModel.instance:isAidConflict(arg_3_0._heroMO.heroId) then
			GameFacade.showToast(ToastEnum.HeroIsAidConflict)

			return
		end

		HeroSingleGroupModel.instance:addTo(arg_3_0._heroMO.uid, arg_3_0._singleGroupMOId)

		if arg_3_0._heroMO:isTrial() then
			var_3_4:setTrial(arg_3_0._heroMO.trialCo.id, arg_3_0._heroMO.trialCo.trialTemplate)
		else
			var_3_4:setTrial()
		end

		FightAudioMgr.instance:playHeroVoiceRandom(arg_3_0._heroMO.heroId, CharacterEnum.VoiceType.HeroGroup)
		arg_3_0:_saveCurGroupInfo()
		arg_3_0:closeThis()
	else
		HeroSingleGroupModel.instance:removeFrom(arg_3_0._singleGroupMOId)
		arg_3_0:_saveCurGroupInfo()
		arg_3_0:closeThis()
	end
end

return var_0_0
