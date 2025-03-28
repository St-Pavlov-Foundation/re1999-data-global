module("modules.logic.season.view.SeasonHeroGroupFightView", package.seeall)

slot0 = class("SeasonHeroGroupFightView", BaseView)
slot1 = 1

function slot0.onInitView(slot0)
	slot0._gocontainer = gohelper.findChild(slot0.viewGO, "#go_container")
	slot0._goreplayready = gohelper.findChild(slot0.viewGO, "#go_container/#go_replayready")
	slot0._gotopbtns = gohelper.findChild(slot0.viewGO, "#go_container/#go_btns/#go_topbtns")
	slot0._btnrecommend = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/#go_btns/#go_topbtns/btn_recommend")
	slot0._btnrestrain = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/#go_btns/#go_topbtns/#btn_RestraintInfo")
	slot0._gobtncontain = gohelper.findChild(slot0.viewGO, "#go_container/btnContain")
	slot0._btncloth = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/btnContain/btnCloth")
	slot0._txtclothname = gohelper.findChildText(slot0.viewGO, "#go_container/btnContain/btnCloth/#txt_clothName")
	slot0._txtclothnameen = gohelper.findChildText(slot0.viewGO, "#go_container/btnContain/btnCloth/#txt_clothName/#txt_clothNameEn")
	slot0._btnstartseason = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/btnContain/horizontal/#btn_startseason")
	slot0._btnseasonreplay = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/btnContain/horizontal/#btn_seasonreplay")
	slot0._imagereplaybg = gohelper.findChildImage(slot0.viewGO, "#go_container/btnContain/horizontal/#btn_seasonreplay/replayAnimRoot/#image_seasonreplaybg")
	slot0._imagereplayicon = gohelper.findChildImage(slot0.viewGO, "#go_container/btnContain/horizontal/#btn_seasonreplay/replayAnimRoot/#image_seasonreplayicon")
	slot0._txtreplaycount = gohelper.findChildText(slot0.viewGO, "#go_container/btnContain/horizontal/#btn_seasonreplay/replayAnimRoot/#txt_seasonreplaycount")
	slot0._dropseasonherogroup = gohelper.findChildDropdown(slot0.viewGO, "#go_container/btnContain/horizontal/#drop_seasonherogroup")
	slot0._goherogroupcontain = gohelper.findChild(slot0.viewGO, "herogroupcontain")
	slot0._gosupercard = gohelper.findChild(slot0.viewGO, "herogroupcontain/#go_supercard")
	slot0._simagerole = gohelper.findChildSingleImage(slot0._gosupercard, "#simage_role")
	slot0._gosupercardlight = gohelper.findChild(slot0.viewGO, "herogroupcontain/#go_supercard/light")
	slot0._gosupercardempty = gohelper.findChild(slot0.viewGO, "herogroupcontain/#go_supercard/#go_supercardempty")
	slot0._gosupercardpos = gohelper.findChild(slot0.viewGO, "herogroupcontain/#go_supercard/#go_supercardpos")
	slot0._btnsupercardclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "herogroupcontain/#go_supercard/#btn_supercardclick")
	slot0._gocontainer2 = gohelper.findChild(slot0.viewGO, "#go_container2")
	slot0._gomask = gohelper.findChild(slot0.viewGO, "#go_container2/#go_mask")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncloth:AddClickListener(slot0._btnclothOnClock, slot0)
	slot0._btnrecommend:AddClickListener(slot0._btnrecommendOnClick, slot0)
	slot0._btnrestrain:AddClickListener(slot0._btnrestrainOnClick, slot0)
	slot0._btnstartseason:AddClickListener(slot0._btnstartseasonOnClick, slot0)
	slot0._btnseasonreplay:AddClickListener(slot0._btnseasonreplayOnClick, slot0)
	slot0._btnsupercardclick:AddClickListener(slot0._btnseasonsupercardOnClick, slot0)
	slot0._dropseasonherogroup:AddOnValueChanged(slot0._groupDropValueChanged, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncloth:RemoveClickListener()
	slot0._btnrecommend:RemoveClickListener()
	slot0._btnrestrain:RemoveClickListener()
	slot0._btnstartseason:RemoveClickListener()
	slot0._btnseasonreplay:RemoveClickListener()
	slot0._btnsupercardclick:RemoveClickListener()
	slot0._dropseasonherogroup:RemoveOnValueChanged()
end

function slot0._btnrecommendOnClick(slot0)
	FightFailRecommendController.instance:onClickRecommend()
	slot0:_udpateRecommendEffect()
	DungeonRpc.instance:sendGetEpisodeHeroRecommendRequest(slot0._episodeId, slot0._receiveRecommend, slot0)
end

function slot0._btnclothOnClock(slot0)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill) or PlayerClothModel.instance:getSpEpisodeClothID() then
		ViewMgr.instance:openView(ViewName.PlayerClothView)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.LeadRoleSkill))
	end
end

function slot0._btnrestrainOnClick(slot0)
	ViewMgr.instance:openView(ViewName.HeroGroupCareerTipView)
end

function slot0._btnstartseasonOnClick(slot0)
	if not slot0._blockStart then
		slot0:_onClickStart()

		slot0._blockStart = true

		TaskDispatcher.runDelay(slot0._onEnableStart, slot0, 1)
	end
end

function slot0._onEnableStart(slot0)
	slot0._blockStart = false
end

function slot0._btnseasonreplayOnClick(slot0)
	slot0:_onClickReplay()
end

function slot0._btnseasonsupercardOnClick(slot0)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	slot1 = {
		pos = 4,
		actId = ActivityEnum.Activity.Season,
		slot = 1,
		group = Activity104Model.instance:getSeasonCurSnapshotSubId()
	}

	if not Activity104Model.instance:isSeasonPosUnlock(slot1.actId, slot1.group, slot1.slot, slot1.pos) then
		return
	end

	Activity104Controller.instance:openSeasonEquipHeroView(slot1)
end

function slot0._groupDropValueChanged(slot0, slot1)
	GameFacade.showToast(ToastEnum.SeasonGroupChanged)

	slot2 = ActivityEnum.Activity.Season
	slot3 = slot1 + 1

	Activity104Model.instance:setSeasonCurSnapshotSubId(slot2, slot3)
	HeroGroupModel.instance:setHeroGroupSnapshot(ModuleEnum.HeroGroupType.Season, DungeonModel.instance.curSendEpisodeId, true, {
		groupIndex = slot3,
		heroGroup = Activity104Model.instance:getSnapshotHeroGroupBySubId(slot3)
	})
	Activity104Rpc.instance:sendChangeFightGroupRequest(slot2, slot3)
end

function slot0._editableInitView(slot0)
	slot0._simageaidtag = gohelper.findChildSingleImage(slot0.viewGO, "herogroupcontain/hero/heroitem/heroitemani/aidtag")

	slot0._simageaidtag:LoadImage("singlebg_lang/txt_tag/bg_biaoqian1.png")
	slot0._simagerole:LoadImage(ResUrl.getSeasonIcon("img_vertin.png"))
	slot0:_initComponent()
	slot0:_initData()
	slot0:_addEvents()
end

function slot0.onOpen(slot0)
	slot0:_checkFirstPosHasEquip()
	slot0:_checkEquipClothSkill()
	slot0:_refreshUI()
	slot0:_checkReplay()
	slot0:_refreshReplay()
	slot0:_udpateRecommendEffect()
end

function slot0._initComponent(slot0)
	slot0._anim = slot0._gocontainer:GetComponent(typeof(UnityEngine.Animator))
	slot0._heroContainAnim = slot0._goherogroupcontain:GetComponent(typeof(UnityEngine.Animator))
	slot0._btnContainAnim = slot0._gobtncontain:GetComponent(typeof(UnityEngine.Animator))
end

function slot0._initData(slot0)
	gohelper.addUIClickAudio(slot0._btnstartseason.gameObject, AudioEnum.HeroGroupUI.Play_UI_Formation_Action)
	gohelper.addUIClickAudio(slot0._btnseasonreplay.gameObject, AudioEnum.UI.Play_UI_Player_Interface_Close)
	gohelper.addUIClickAudio(slot0._btnrestrain.gameObject, AudioEnum.UI.Play_UI_Tipsopen)
	gohelper.addUIClickAudio(slot0._dropseasonherogroup.gameObject, AudioEnum.UI.UI_transverse_tabs_click)
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Action_Cardsopen)
	NavigateMgr.instance:addEscape(ViewName.SeasonHeroGroupFightView, slot0._onEscapeBtnClick, slot0)
	FightHelper.detectAttributeCounter()

	slot0._iconGO = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._btncloth.gameObject)

	recthelper.setAnchor(slot0._iconGO.transform, -100, 1)

	slot0._tweeningId = 0
	slot0._replayMode = false
	slot0._multiplication = 1

	gohelper.setActive(slot0._gomask, false)
	slot0._dropseasonherogroup:ClearOptions()
	slot0._dropseasonherogroup:AddOptions({
		luaLang("season_herogroup_one"),
		luaLang("season_herogroup_two"),
		luaLang("season_herogroup_three"),
		luaLang("season_herogroup_four")
	})
	slot0._dropseasonherogroup:SetValue(Activity104Model.instance:getSeasonCurSnapshotSubId() - 1)
	gohelper.setActive(slot0._goseasoncontain, true)
end

function slot0._addEvents(slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullView, slot0._onOpenFullView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, slot0._onModifyHeroGroup, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, slot0._onModifySnapshot, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroGroupItem, slot0._onClickHeroGroupItem, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.RespBeginFight, slot0._respBeginFight, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.PlayHeroGroupExitEffect, slot0._playHeroGroupExitEffect, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.PlayCloseHeroGroupAnimation, slot0._playCloseHeroGroupAnimation, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnUseRecommendGroup, slot0._onUseRecommendGroup, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onCurrencyChange, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.ShowGuideDragEffect, slot0._showGuideDragEffect, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.HeroMoveForward, slot0._heroMoveForward, slot0)
	slot0:addEventCb(Activity104Controller.instance, Activity104Event.SwitchSnapshotSubId, slot0._switchSnapshotSubId, slot0)
end

function slot0._checkReplay(slot0)
	slot5 = PlayerPrefsHelper.getString(FightModel.getPrefsKeyFightPassModel(), "")

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay) and (DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId) and slot2.star == DungeonEnum.StarType.Advanced and slot2.hasRecord) and not string.nilorempty(slot5) and not Activity104Model.instance:isEpisodeAdvance(HeroGroupModel.instance.episodeId) and cjson.decode(slot5)[tostring(slot0._episodeId)] and not slot0._replayMode then
		slot0._replayMode = true
		slot0._multiplication = PlayerPrefsHelper.getNumber(slot0:_getMultiplicationKey(), 1)

		slot0:_refreshBtns()

		slot0._replayFightGroupMO = HeroGroupModel.instance:getReplayParam()

		if not slot0._replayFightGroupMO then
			slot0:addEventCb(FightController.instance, FightEvent.RespGetFightRecordGroupReply, slot0._onGetFightRecordGroupReply, slot0)
			FightRpc.instance:sendGetFightRecordGroupRequest(HeroGroupModel.instance.episodeId)
		else
			slot0:_switchReplayGroup()
		end
	end
end

function slot0._receiveRecommend(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.HeroGroupRecommendView, slot3)
end

function slot0._switchSnapshotSubId(slot0)
	slot0:_refreshMainCard()
end

function slot0._refreshMainCard(slot0)
	slot3 = 0

	if HeroGroupModel.instance:getCurGroupMO() then
		if slot1.isReplay and slot1.replay_activity104Equip_data then
			slot3 = slot1.replay_activity104Equip_data["-100000"][1].equipId
		end

		if not slot1.isReplay and slot1.activity104Equips and slot1.activity104Equips[4] then
			slot3 = Activity104Model.instance:getItemIdByUid(slot1.activity104Equips[4].equipUid[1])
		end
	end

	gohelper.setActive(slot0._gosupercardlight, false)

	if slot3 ~= 0 then
		if not slot0._superCardItem then
			slot0._superCardItem = SeasonCelebrityCardItem.New()

			slot0._superCardItem:init(slot0._gosupercardpos, slot3)
		else
			gohelper.setActive(slot0._superCardItem.go, true)
			slot0._superCardItem:reset(slot3)
		end

		gohelper.setActive(slot0._gosupercardlight, true)
	elseif slot0._superCardItem then
		gohelper.setActive(slot0._superCardItem.go, false)
	end

	slot4 = Activity104Model.instance:getAct104CurLayer()

	if slot1.isReplay and DungeonModel.instance.curSendEpisodeId and DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId).type == DungeonEnum.EpisodeType.Season then
		slot4 = Activity104Model.instance:getBattleFinishLayer()
	end

	slot6 = Activity104Model.instance:isSeasonLayerPosUnlock(nil, Activity104Model.instance:getSeasonCurSnapshotSubId(), slot4, 1, 4)

	gohelper.setActive(slot0._gosupercardlock, not slot6)
	gohelper.setActive(slot0._gosupercardempty, slot6)
end

function slot0._onClickReplay(slot0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay) then
		slot1, slot2 = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.FightReplay)

		GameFacade.showToast(slot1, slot2)

		return
	end

	if not HeroGroupModel.instance.episodeId then
		return
	end

	slot1 = DungeonConfig.instance:getEpisodeCO(HeroGroupModel.instance.episodeId)

	if not (DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId) and slot2.hasRecord) and (slot1 and slot1.firstBattleId > 0) then
		GameFacade.showToast(ToastEnum.CantRecordReplay)

		return
	end

	if Activity104Model.instance:isEpisodeAdvance(HeroGroupModel.instance.episodeId) and slot2.hasRecord then
		GameFacade.showToast(ToastEnum.SeasonAdvanceLevelNoReplay)

		return
	end

	if not slot3 then
		GameFacade.showToast(ToastEnum.SeasonHeroGroupStarNoAdvanced)

		return
	end

	if slot0._replayMode then
		slot0._replayMode = false
		slot0._multiplication = 1

		slot0._btnContainAnim:Play(UIAnimationName.Switch, 0, 0)
		gohelper.setActive(slot0._gomultispeed, false)
	else
		slot0._btnContainAnim:Play(UIAnimationName.Switch, 0, 0)

		slot0._replayMode = true
		slot0._multiplication = 1
	end

	PlayerPrefsHelper.setNumber(slot0:_getMultiplicationKey(), slot0._multiplication)
	slot0:_refreshBtns()

	if slot0._replayMode and not slot0._replayFightGroupMO then
		slot0:addEventCb(FightController.instance, FightEvent.RespGetFightRecordGroupReply, slot0._onGetFightRecordGroupReply, slot0)
		FightRpc.instance:sendGetFightRecordGroupRequest(HeroGroupModel.instance.episodeId)

		return
	end

	slot0:_switchReplayGroup(slot0._replayMode)
end

function slot0._switchReplayGroup(slot0, slot1)
	slot0:_refreshTips()
	gohelper.setActive(slot0._goreplayready, slot0._replayMode)
	UISpriteSetMgr.instance:setHeroGroupSprite(slot0._imagereplayicon, slot0._replayMode and "btn_replay_pause" or "btn_replay_play")

	if slot1 ~= slot0._replayMode then
		TaskDispatcher.cancelTask(slot0._switchReplayMul, slot0)
		TaskDispatcher.runDelay(slot0._switchReplayMul, slot0, 0.1)
	else
		slot0:_switchReplayMul()
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.PlayHeroGroupHeroEffect, slot0._replayMode and "swicth" or "open")

	if slot0._replayMode then
		slot0:_updateReplayHeroGroupList()
	else
		HeroGroupModel.instance:setParam(HeroGroupModel.instance.battleId, HeroGroupModel.instance.episodeId, HeroGroupModel.instance.adventure)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, HeroGroupModel.instance:getCurGroupMO().id)
		slot0:_refreshCloth()
		slot0:_refreshMainCard()
		gohelper.setActive(slot0._goherogroupcontain, false)
		gohelper.setActive(slot0._goherogroupcontain, true)
	end
end

function slot0._refreshTips(slot0)
end

function slot0._updateReplayHeroGroupList(slot0)
	HeroGroupModel.instance:setReplayParam(slot0._replayFightGroupMO)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, slot0._replayFightGroupMO.id)
	slot0:_refreshCloth()
	slot0:_refreshMainCard()
	gohelper.setActive(slot0._goherogroupcontain, false)
	gohelper.setActive(slot0._goherogroupcontain, true)
end

function slot0._switchReplayMul(slot0)
	slot0._txtreplaycount.text = slot0._replayMode and luaLang("multiple") .. slot0._multiplication or ""
end

function slot0._heroMoveForward(slot0, slot1)
	HeroGroupEditListModel.instance:setMoveHeroId(tonumber(slot1))
end

function slot0.isReplayMode(slot0)
	return slot0._replayMode
end

function slot0._onCurrencyChange(slot0, slot1)
	if not slot1[CurrencyEnum.CurrencyType.Power] then
		return
	end

	slot0:_refreshBtns()
end

function slot0._respBeginFight(slot0)
	gohelper.setActive(slot0._gomask, true)
end

function slot0._onOpenFullView(slot0, slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.EquipInfoTeamShowView then
		slot0:_checkFirstPosHasEquip()
	end
end

function slot0._getMultiplicationKey(slot0)
	return string.format("%s#%d", PlayerPrefsKey.Multiplication .. PlayerModel.instance:getMyUserId(), slot0._episodeId)
end

function slot0._udpateRecommendEffect(slot0)
	gohelper.setActive(slot0._goRecommendEffect, FightFailRecommendController.instance:needShowRecommend(slot0._episodeId))
end

function slot0._onEscapeBtnClick(slot0)
	if not slot0._gomask.gameObject.activeInHierarchy then
		slot0.viewContainer:_closeCallback()
	end
end

function slot0._refreshUI(slot0)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, HeroGroupModel.instance:getCurGroupId())

	slot0._episodeId = HeroGroupModel.instance.episodeId
	slot0.episodeConfig = DungeonConfig.instance:getEpisodeCO(slot0._episodeId)
	slot0._chapterConfig = DungeonConfig.instance:getChapterCO(slot0.episodeConfig.chapterId)

	slot0:_refreshBtns()
	slot0:_refreshCloth()
	slot0:_refreshMainCard()
	slot0.viewContainer:setNavigateOverrideClose(slot0.openSeasonMainView, slot0)
end

function slot0.onClose(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)

	slot1 = {
		groupIndex = Activity104Model.instance:getSeasonCurSnapshotSubId()
	}
	slot1.heroGroup = Activity104Model.instance:getSnapshotHeroGroupBySubId(slot1.groupIndex)

	HeroGroupModel.instance:setHeroGroupSnapshot(ModuleEnum.HeroGroupType.Season, DungeonModel.instance.curSendEpisodeId, true, slot1)
	slot0:_removeEvents()
	ZProj.TweenHelper.KillById(slot0._tweeningId)
	TaskDispatcher.cancelTask(slot0.openHeroGroupEditView, slot0)
	TaskDispatcher.cancelTask(slot0._closeHeroContainAnim, slot0)
	TaskDispatcher.cancelTask(slot0._onEnableStart, slot0)

	if slot0._dragEffectLoader then
		slot0._dragEffectLoader:dispose()

		slot0._dragEffectLoader = nil
	end
end

function slot0._removeEvents(slot0)
	slot0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, slot0._onModifySnapshot, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.RespGetFightRecordGroupReply, slot0._onGetFightRecordGroupReply, slot0)
end

function slot0._refreshReplay(slot0)
	slot1 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightReplay)
	slot2 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay)

	gohelper.setActive(slot0._btnseasonreplay.gameObject, slot0.episodeConfig and slot0.episodeConfig.canUseRecord == 1)

	slot4 = DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId) and slot3.hasRecord

	ZProj.UGUIHelper.SetColorAlpha(slot0._imagereplaybg, slot2 and slot4 and 1 or 0.75)

	slot0._txtreplaycount.text = slot0._replayMode and luaLang("multiple") .. slot0._multiplication or ""

	UISpriteSetMgr.instance:setHeroGroupSprite(slot0._imagereplayicon, slot2 and slot4 and "btn_replay_play" or "btn_replay_lack")
end

function slot0._refreshCloth(slot0)
	slot2 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.LeadRoleSkill)
	slot4 = PlayerClothModel.instance:getById(HeroGroupModel.instance:getCurGroupMO().clothId)

	gohelper.setActive(slot0._txtclothname.gameObject, slot4)

	if slot4 then
		slot5 = lua_cloth.configDict[slot4.clothId]
		slot6 = slot4.level or 0
		slot0._txtclothname.text = slot5.name
		slot0._txtclothnameen.text = slot5.enname
	end

	for slot8, slot9 in ipairs(lua_cloth.configList) do
		if not gohelper.isNil(gohelper.findChild(slot0._iconGO, tostring(slot9.id))) then
			gohelper.setActive(slot10, slot9.id == slot3)
		end
	end

	gohelper.setActive(slot0._btncloth.gameObject, uv0.showCloth())
end

function slot0._checkEquipClothSkill(slot0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill) then
		return
	end

	if PlayerClothModel.instance:getById(HeroGroupModel.instance:getCurGroupMO().clothId) then
		return
	end

	for slot6, slot7 in ipairs(PlayerClothModel.instance:getList()) do
		if PlayerClothModel.instance:hasCloth(slot7.id) then
			slot9 = Activity104Model.instance:getSeasonCurSnapshotSubId(ActivityEnum.Activity.Season)

			HeroGroupModel.instance:setHeroGroupSnapshot(ModuleEnum.HeroGroupType.Season, DungeonModel.instance.curSendEpisodeId, true, {
				groupIndex = slot9,
				heroGroup = Activity104Model.instance:getSnapshotHeroGroupBySubId(slot9)
			})

			break
		end
	end
end

function slot0._getEpisodeConfigAndBattleConfig()
	return slot0, DungeonConfig.instance:getEpisodeCO(HeroGroupModel.instance.episodeId) and lua_battle.configDict[slot0.battleId]
end

function slot0.showCloth()
	if PlayerClothModel.instance:getSpEpisodeClothID() then
		return true
	end

	if not OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.LeadRoleSkill) then
		return false
	end

	slot1, slot2 = uv0._getEpisodeConfigAndBattleConfig()

	if slot2 and slot2.noClothSkill == 1 then
		return false
	end

	slot4 = PlayerClothModel.instance:getById(HeroGroupModel.instance:getCurGroupMO().clothId)
	slot6 = false

	for slot10, slot11 in ipairs(PlayerClothModel.instance:getList()) do
		slot6 = true

		break
	end

	return slot6
end

function slot0._onModifyHeroGroup(slot0)
	slot0:_refreshCloth()
	slot0:_refreshMainCard()
end

function slot0._onModifySnapshot(slot0)
	slot0:_refreshCloth()
	slot0:_refreshMainCard()
end

function slot0._onClickHeroGroupItem(slot0, slot1)
	TaskDispatcher.cancelTask(slot0.openHeroGroupEditView, slot0)

	slot2 = HeroGroupModel.instance:getCurGroupMO()

	HeroSingleGroupModel.instance:setSingleGroup(slot2)

	slot0._param = {
		singleGroupMOId = slot1,
		originalHeroUid = HeroSingleGroupModel.instance:getHeroUid(slot1),
		equips = slot2:getPosEquips(slot1 - 1).equipUid
	}

	slot0:openHeroGroupEditView()
end

function slot0.openHeroGroupEditView(slot0)
	ViewMgr.instance:openView(ViewName.HeroGroupEditView, slot0._param)
end

function slot0._checkFirstPosHasEquip(slot0)
	if not HeroGroupModel.instance:getCurGroupMO() then
		return
	end

	slot3 = slot1:getPosEquips(0).equipUid and slot2[1]

	if slot3 and EquipModel.instance:getEquip(slot3) then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnFirstPosHasEquip)
	end
end

function slot0._showGuideDragEffect(slot0, slot1)
	if slot0._dragEffectLoader then
		slot0._dragEffectLoader:dispose()

		slot0._dragEffectLoader = nil
	end

	if tonumber(slot1) == 1 then
		slot0._dragEffectLoader = PrefabInstantiate.Create(slot0.viewGO)

		slot0._dragEffectLoader:startLoad("ui/viewres/guide/guide_herogroup.prefab")
	end
end

function slot0._onClickStart(slot0)
	slot3 = tonumber(string.split(string.split(slot0.episodeConfig.cost, "|")[1], "#")[3] or 0)

	if HeroGroupModel.instance.episodeId == 10104 and not DungeonModel.instance:hasPassLevel(slot4) then
		for slot10, slot11 in ipairs(HeroSingleGroupModel.instance:getList()) do
			if not slot11:isEmpty() then
				slot6 = 0 + 1
			end
		end

		if slot6 < 2 then
			GameFacade.showToast(ToastEnum.HeroSingleGroupCount)

			return
		end
	end

	slot0:_enterFight()
end

function slot0._enterFight(slot0)
	if HeroGroupModel.instance.episodeId then
		slot0._closeWithEnteringFight = true

		if FightController.instance:setFightHeroGroup() then
			slot2 = FightModel.instance:getFightParam()

			if slot0._replayMode then
				slot2.isReplay = true
				slot2.multiplication = slot0._multiplication

				DungeonFightController.instance:sendStartDungeonRequest(slot2.chapterId, slot2.episodeId, slot2, slot0._multiplication, nil, true)
			else
				slot2.isReplay = false
				slot2.multiplication = 1

				DungeonFightController.instance:sendStartDungeonRequest(slot2.chapterId, slot2.episodeId, slot2, 1)
			end

			AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
		end
	else
		logError("没选中关卡，无法开始战斗")
	end
end

function slot0._onUseRecommendGroup(slot0)
	if slot0._replayMode then
		slot0._replayMode = false
		slot0._multiplication = 1

		slot0:_refreshBtns()
		slot0:_switchReplayGroup()
	end
end

function slot0._refreshBtns(slot0)
	gohelper.setActive(slot0._dropseasonherogroup.gameObject, not slot0._replayMode)
end

function slot0._onGetFightRecordGroupReply(slot0, slot1)
	slot0:removeEventCb(FightController.instance, FightEvent.RespGetFightRecordGroupReply, slot0._onGetFightRecordGroupReply, slot0)

	slot0._replayFightGroupMO = slot1

	if not slot0._replayMode then
		return
	end

	slot0:_switchReplayGroup()
	slot0:_updateReplayHeroGroup()
end

function slot0._updateReplayHeroGroup(slot0)
	HeroGroupModel.instance:setReplayParam(slot0._replayFightGroupMO)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, slot0._replayFightGroupMO.id)
	slot0:_refreshCloth()
	slot0:_refreshMainCard()
	gohelper.setActive(slot0._goherogroupcontain, false)
	gohelper.setActive(slot0._goherogroupcontain, true)
end

function slot0._playHeroGroupExitEffect(slot0)
	slot0._anim:Play("close", 0, 0)
	slot0._btnContainAnim:Play("close", 0, 0)
end

function slot0._playCloseHeroGroupAnimation(slot0)
	slot0._anim:Play("close", 0, 0)
	slot0._btnContainAnim:Play("close", 0, 0)

	slot0._heroContainAnim.enabled = true

	slot0._heroContainAnim:Play("herogroupcontain_out", 0, 0)
	TaskDispatcher.runDelay(slot0._closeHeroContainAnim, slot0, 0.133)
end

function slot0._closeHeroContainAnim(slot0)
	if slot0._heroContainAnim then
		slot0._heroContainAnim.enabled = false
	end
end

function slot0.onDestroyView(slot0)
	slot0._simagerole:UnLoadImage()
	slot0._simageaidtag:UnLoadImage()

	if slot0._superCardItem then
		slot0._superCardItem:destroy()

		slot0._superCardItem = nil
	end
end

return slot0
