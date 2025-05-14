module("modules.logic.season.view1_2.Season1_2HeroGroupFightView", package.seeall)

local var_0_0 = class("Season1_2HeroGroupFightView", BaseView)
local var_0_1 = 1

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocontainer = gohelper.findChild(arg_1_0.viewGO, "#go_container")
	arg_1_0._goreplayready = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_replayready")
	arg_1_0._gotopbtns = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_btns/#go_topbtns")
	arg_1_0._btnrecommend = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/#go_btns/#go_topbtns/btn_recommend")
	arg_1_0._btnrestrain = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/#go_btns/#go_topbtns/#btn_RestraintInfo")
	arg_1_0._gobtncontain = gohelper.findChild(arg_1_0.viewGO, "#go_container/btnContain")
	arg_1_0._btncloth = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/btnContain/btnCloth")
	arg_1_0._txtclothname = gohelper.findChildText(arg_1_0.viewGO, "#go_container/btnContain/btnCloth/#txt_clothName")
	arg_1_0._txtclothnameen = gohelper.findChildText(arg_1_0.viewGO, "#go_container/btnContain/btnCloth/#txt_clothName/#txt_clothNameEn")
	arg_1_0._btnstartseason = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#btn_startseason")
	arg_1_0._btnseasonreplay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#btn_seasonreplay")
	arg_1_0._imagereplaybg = gohelper.findChildImage(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#btn_seasonreplay/replayAnimRoot/#image_seasonreplaybg")
	arg_1_0._imagereplayicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#btn_seasonreplay/replayAnimRoot/#image_seasonreplayicon")
	arg_1_0._txtreplaycount = gohelper.findChildText(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#btn_seasonreplay/replayAnimRoot/#txt_seasonreplaycount")
	arg_1_0._dropseasonherogroup = gohelper.findChildDropdown(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#drop_seasonherogroup")
	arg_1_0._goherogroupcontain = gohelper.findChild(arg_1_0.viewGO, "herogroupcontain")
	arg_1_0._gosupercard = gohelper.findChild(arg_1_0.viewGO, "herogroupcontain/#go_supercard")
	arg_1_0._simagerole = gohelper.findChildSingleImage(arg_1_0._gosupercard, "#simage_role")
	arg_1_0._gosupercardlight = gohelper.findChild(arg_1_0.viewGO, "herogroupcontain/#go_supercard/light")
	arg_1_0._gosupercardempty = gohelper.findChild(arg_1_0.viewGO, "herogroupcontain/#go_supercard/#go_supercardempty")
	arg_1_0._gosupercardpos = gohelper.findChild(arg_1_0.viewGO, "herogroupcontain/#go_supercard/#go_supercardpos")
	arg_1_0._btnsupercardclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "herogroupcontain/#go_supercard/#btn_supercardclick")
	arg_1_0._gocontainer2 = gohelper.findChild(arg_1_0.viewGO, "#go_container2")
	arg_1_0._gomask = gohelper.findChild(arg_1_0.viewGO, "#go_container2/#go_mask")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncloth:AddClickListener(arg_2_0._btnclothOnClock, arg_2_0)
	arg_2_0._btnrecommend:AddClickListener(arg_2_0._btnrecommendOnClick, arg_2_0)
	arg_2_0._btnrestrain:AddClickListener(arg_2_0._btnrestrainOnClick, arg_2_0)
	arg_2_0._btnstartseason:AddClickListener(arg_2_0._btnstartseasonOnClick, arg_2_0)
	arg_2_0._btnseasonreplay:AddClickListener(arg_2_0._btnseasonreplayOnClick, arg_2_0)
	arg_2_0._btnsupercardclick:AddClickListener(arg_2_0._btnseasonsupercardOnClick, arg_2_0)
	arg_2_0._dropseasonherogroup:AddOnValueChanged(arg_2_0._groupDropValueChanged, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncloth:RemoveClickListener()
	arg_3_0._btnrecommend:RemoveClickListener()
	arg_3_0._btnrestrain:RemoveClickListener()
	arg_3_0._btnstartseason:RemoveClickListener()
	arg_3_0._btnseasonreplay:RemoveClickListener()
	arg_3_0._btnsupercardclick:RemoveClickListener()
	arg_3_0._dropseasonherogroup:RemoveOnValueChanged()
end

function var_0_0._btnrecommendOnClick(arg_4_0)
	FightFailRecommendController.instance:onClickRecommend()
	arg_4_0:_udpateRecommendEffect()
	DungeonRpc.instance:sendGetEpisodeHeroRecommendRequest(arg_4_0._episodeId, arg_4_0._receiveRecommend, arg_4_0)
end

function var_0_0._btnclothOnClock(arg_5_0)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill) or PlayerClothModel.instance:getSpEpisodeClothID() then
		ViewMgr.instance:openView(ViewName.PlayerClothView)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.LeadRoleSkill))
	end
end

function var_0_0._btnrestrainOnClick(arg_6_0)
	ViewMgr.instance:openView(ViewName.HeroGroupCareerTipView)
end

function var_0_0._btnstartseasonOnClick(arg_7_0)
	if not arg_7_0._blockStart then
		arg_7_0:_onClickStart()

		arg_7_0._blockStart = true

		TaskDispatcher.runDelay(arg_7_0._onEnableStart, arg_7_0, 1)
	end
end

function var_0_0._onEnableStart(arg_8_0)
	arg_8_0._blockStart = false
end

function var_0_0._btnseasonreplayOnClick(arg_9_0)
	arg_9_0:_onClickReplay()
end

function var_0_0._btnseasonsupercardOnClick(arg_10_0)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	local var_10_0 = {}

	var_10_0.pos = 4
	var_10_0.actId = Activity104Model.instance:getCurSeasonId()
	var_10_0.slot = 1
	var_10_0.group = Activity104Model.instance:getSeasonCurSnapshotSubId()

	if not Activity104Model.instance:isSeasonPosUnlock(var_10_0.actId, var_10_0.group, var_10_0.slot, var_10_0.pos) then
		return
	end

	Activity104Controller.instance:openSeasonEquipHeroView(var_10_0)
end

function var_0_0._groupDropValueChanged(arg_11_0, arg_11_1)
	GameFacade.showToast(ToastEnum.SeasonGroupChanged)

	local var_11_0 = Activity104Model.instance:getCurSeasonId()
	local var_11_1 = arg_11_1 + 1

	Activity104Model.instance:setSeasonCurSnapshotSubId(var_11_0, var_11_1)

	local var_11_2 = Activity104Model.instance:getSnapshotHeroGroupBySubId(var_11_1)
	local var_11_3 = {
		groupIndex = var_11_1,
		heroGroup = var_11_2
	}

	HeroGroupModel.instance:setHeroGroupSnapshot(ModuleEnum.HeroGroupType.Season, DungeonModel.instance.curSendEpisodeId, true, var_11_3)
	Activity104Rpc.instance:sendChangeFightGroupRequest(var_11_0, var_11_1)
end

function var_0_0._editableInitView(arg_12_0)
	arg_12_0._simagerole:LoadImage(ResUrl.getSeasonIcon("img_vertin.png"))
	arg_12_0:_initComponent()
	arg_12_0:_initData()
	arg_12_0:_addEvents()
end

function var_0_0.onOpen(arg_13_0)
	arg_13_0:_checkFirstPosHasEquip()
	arg_13_0:_checkEquipClothSkill()
	arg_13_0:_refreshUI()
	arg_13_0:_checkReplay()
	arg_13_0:_refreshReplay()
	arg_13_0:_udpateRecommendEffect()
end

function var_0_0._initComponent(arg_14_0)
	arg_14_0._anim = arg_14_0._gocontainer:GetComponent(typeof(UnityEngine.Animator))
	arg_14_0._heroContainAnim = arg_14_0._goherogroupcontain:GetComponent(typeof(UnityEngine.Animator))
	arg_14_0._btnContainAnim = arg_14_0._gobtncontain:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0._initData(arg_15_0)
	gohelper.addUIClickAudio(arg_15_0._btnstartseason.gameObject, AudioEnum.HeroGroupUI.Play_UI_Formation_Action)
	gohelper.addUIClickAudio(arg_15_0._btnseasonreplay.gameObject, AudioEnum.UI.Play_UI_Player_Interface_Close)
	gohelper.addUIClickAudio(arg_15_0._btnrestrain.gameObject, AudioEnum.UI.Play_UI_Tipsopen)
	gohelper.addUIClickAudio(arg_15_0._dropseasonherogroup.gameObject, AudioEnum.UI.UI_transverse_tabs_click)
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Action_Cardsopen)
	NavigateMgr.instance:addEscape(ViewName.Season1_2HeroGroupFightView, arg_15_0._onEscapeBtnClick, arg_15_0)
	FightHelper.detectAttributeCounter()

	arg_15_0._iconGO = arg_15_0:getResInst(arg_15_0.viewContainer:getSetting().otherRes[1], arg_15_0._btncloth.gameObject)

	recthelper.setAnchor(arg_15_0._iconGO.transform, -100, 1)

	arg_15_0._tweeningId = 0
	arg_15_0._replayMode = false
	arg_15_0._multiplication = 1

	gohelper.setActive(arg_15_0._gomask, false)

	local var_15_0 = {
		luaLang("season_herogroup_one"),
		luaLang("season_herogroup_two"),
		luaLang("season_herogroup_three"),
		luaLang("season_herogroup_four")
	}

	arg_15_0._dropseasonherogroup:ClearOptions()
	arg_15_0._dropseasonherogroup:AddOptions(var_15_0)

	local var_15_1 = Activity104Model.instance:getSeasonCurSnapshotSubId()

	arg_15_0._dropseasonherogroup:SetValue(var_15_1 - 1)
	gohelper.setActive(arg_15_0._goseasoncontain, true)
end

function var_0_0._addEvents(arg_16_0)
	arg_16_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullView, arg_16_0._onOpenFullView, arg_16_0)
	arg_16_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_16_0._onCloseView, arg_16_0)
	arg_16_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_16_0._onModifyHeroGroup, arg_16_0)
	arg_16_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_16_0._onModifySnapshot, arg_16_0)
	arg_16_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroGroupItem, arg_16_0._onClickHeroGroupItem, arg_16_0)
	arg_16_0:addEventCb(FightController.instance, FightEvent.RespBeginFight, arg_16_0._respBeginFight, arg_16_0)
	arg_16_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.PlayHeroGroupExitEffect, arg_16_0._playHeroGroupExitEffect, arg_16_0)
	arg_16_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.PlayCloseHeroGroupAnimation, arg_16_0._playCloseHeroGroupAnimation, arg_16_0)
	arg_16_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnUseRecommendGroup, arg_16_0._onUseRecommendGroup, arg_16_0)
	arg_16_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_16_0._onCurrencyChange, arg_16_0)
	arg_16_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.ShowGuideDragEffect, arg_16_0._showGuideDragEffect, arg_16_0)
	arg_16_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.HeroMoveForward, arg_16_0._heroMoveForward, arg_16_0)
	arg_16_0:addEventCb(Activity104Controller.instance, Activity104Event.SwitchSnapshotSubId, arg_16_0._switchSnapshotSubId, arg_16_0)
end

function var_0_0._checkReplay(arg_17_0)
	local var_17_0 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay)
	local var_17_1 = DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId)
	local var_17_2 = var_17_1 and var_17_1.star == DungeonEnum.StarType.Advanced and var_17_1.hasRecord
	local var_17_3 = Activity104Model.instance:isEpisodeAdvance(HeroGroupModel.instance.episodeId)
	local var_17_4 = PlayerPrefsHelper.getString(FightModel.getPrefsKeyFightPassModel(), "")

	if var_17_0 and var_17_2 and not string.nilorempty(var_17_4) and not var_17_3 and cjson.decode(var_17_4)[tostring(arg_17_0._episodeId)] and not arg_17_0._replayMode then
		arg_17_0._replayMode = true
		arg_17_0._multiplication = PlayerPrefsHelper.getNumber(arg_17_0:_getMultiplicationKey(), 1)

		arg_17_0:_refreshBtns()

		arg_17_0._replayFightGroupMO = HeroGroupModel.instance:getReplayParam()

		if not arg_17_0._replayFightGroupMO then
			arg_17_0:addEventCb(FightController.instance, FightEvent.RespGetFightRecordGroupReply, arg_17_0._onGetFightRecordGroupReply, arg_17_0)
			FightRpc.instance:sendGetFightRecordGroupRequest(HeroGroupModel.instance.episodeId)
		else
			arg_17_0:_switchReplayGroup()
		end
	end
end

function var_0_0._receiveRecommend(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if arg_18_2 ~= 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.HeroGroupRecommendView, arg_18_3)
end

function var_0_0._switchSnapshotSubId(arg_19_0)
	arg_19_0:_refreshMainCard()
end

function var_0_0._refreshMainCard(arg_20_0)
	local var_20_0 = HeroGroupModel.instance:getCurGroupMO()
	local var_20_1 = "-100000"
	local var_20_2 = Activity104EquipItemListModel.MainCharPos
	local var_20_3 = 1
	local var_20_4 = 0

	if var_20_0 then
		if var_20_0.isReplay and var_20_0.replay_activity104Equip_data then
			var_20_4 = var_20_0.replay_activity104Equip_data[var_20_1][var_20_3].equipId
		end

		if not var_20_0.isReplay and var_20_0.activity104Equips and var_20_0.activity104Equips[var_20_2] then
			var_20_4 = Activity104Model.instance:getItemIdByUid(var_20_0:getAct104PosEquips(var_20_2):getEquipUID(var_20_3))
		end
	end

	gohelper.setActive(arg_20_0._gosupercardlight, false)

	if var_20_4 ~= 0 then
		if not arg_20_0._superCardItem then
			arg_20_0._superCardItem = Season1_2CelebrityCardItem.New()

			arg_20_0._superCardItem:init(arg_20_0._gosupercardpos, var_20_4)
		else
			gohelper.setActive(arg_20_0._superCardItem.go, true)
			arg_20_0._superCardItem:reset(var_20_4)
		end

		gohelper.setActive(arg_20_0._gosupercardlight, true)
	elseif arg_20_0._superCardItem then
		gohelper.setActive(arg_20_0._superCardItem.go, false)
	end

	local var_20_5 = Activity104Model.instance:getAct104CurLayer()

	if var_20_0.isReplay and DungeonModel.instance.curSendEpisodeId and DungeonConfig.instance:getEpisodeCO(DungeonModel.instance.curSendEpisodeId).type == DungeonEnum.EpisodeType.Season then
		var_20_5 = Activity104Model.instance:getBattleFinishLayer()
	end

	local var_20_6 = Activity104Model.instance:getSeasonCurSnapshotSubId()
	local var_20_7 = Activity104Model.instance:isSeasonLayerPosUnlock(nil, var_20_6, var_20_5, var_20_3, var_20_2)

	gohelper.setActive(arg_20_0._gosupercardlock, not var_20_7)
	gohelper.setActive(arg_20_0._gosupercardempty, var_20_7)
end

function var_0_0._onClickReplay(arg_21_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay) then
		local var_21_0, var_21_1 = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.FightReplay)

		GameFacade.showToast(var_21_0, var_21_1)

		return
	end

	if not HeroGroupModel.instance.episodeId then
		return
	end

	local var_21_2 = DungeonConfig.instance:getEpisodeCO(HeroGroupModel.instance.episodeId)
	local var_21_3 = DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId)
	local var_21_4 = var_21_3 and var_21_3.hasRecord
	local var_21_5 = var_21_2 and var_21_2.firstBattleId > 0

	if not var_21_4 and var_21_5 then
		GameFacade.showToast(ToastEnum.CantRecordReplay)

		return
	end

	if Activity104Model.instance:isEpisodeAdvance(HeroGroupModel.instance.episodeId) and var_21_3.hasRecord then
		GameFacade.showToast(ToastEnum.SeasonAdvanceLevelNoReplay)

		return
	end

	if not var_21_4 then
		GameFacade.showToast(ToastEnum.SeasonHeroGroupStarNoAdvanced)

		return
	end

	if arg_21_0._replayMode then
		arg_21_0._replayMode = false
		arg_21_0._multiplication = 1

		arg_21_0._btnContainAnim:Play(UIAnimationName.Switch, 0, 0)
		gohelper.setActive(arg_21_0._gomultispeed, false)
	else
		arg_21_0._btnContainAnim:Play(UIAnimationName.Switch, 0, 0)

		arg_21_0._replayMode = true
		arg_21_0._multiplication = 1
	end

	PlayerPrefsHelper.setNumber(arg_21_0:_getMultiplicationKey(), arg_21_0._multiplication)
	arg_21_0:_refreshBtns()

	if arg_21_0._replayMode and not arg_21_0._replayFightGroupMO then
		arg_21_0:addEventCb(FightController.instance, FightEvent.RespGetFightRecordGroupReply, arg_21_0._onGetFightRecordGroupReply, arg_21_0)
		FightRpc.instance:sendGetFightRecordGroupRequest(HeroGroupModel.instance.episodeId)

		return
	end

	arg_21_0:_switchReplayGroup(arg_21_0._replayMode)
end

function var_0_0._switchReplayGroup(arg_22_0, arg_22_1)
	arg_22_0:_refreshTips()
	gohelper.setActive(arg_22_0._goreplayready, arg_22_0._replayMode)
	UISpriteSetMgr.instance:setHeroGroupSprite(arg_22_0._imagereplayicon, arg_22_0._replayMode and "btn_replay_pause" or "btn_replay_play")

	if arg_22_1 ~= arg_22_0._replayMode then
		TaskDispatcher.cancelTask(arg_22_0._switchReplayMul, arg_22_0)
		TaskDispatcher.runDelay(arg_22_0._switchReplayMul, arg_22_0, 0.1)
	else
		arg_22_0:_switchReplayMul()
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.PlayHeroGroupHeroEffect, arg_22_0._replayMode and "swicth" or "open")

	if arg_22_0._replayMode then
		arg_22_0:_updateReplayHeroGroupList()
	else
		HeroGroupModel.instance:setParam(HeroGroupModel.instance.battleId, HeroGroupModel.instance.episodeId, HeroGroupModel.instance.adventure)

		local var_22_0 = HeroGroupModel.instance:getCurGroupMO().id

		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, var_22_0)
		arg_22_0:_refreshCloth()
		arg_22_0:_refreshMainCard()
		gohelper.setActive(arg_22_0._goherogroupcontain, false)
		gohelper.setActive(arg_22_0._goherogroupcontain, true)
	end
end

function var_0_0._refreshTips(arg_23_0)
	return
end

function var_0_0._updateReplayHeroGroupList(arg_24_0)
	HeroGroupModel.instance:setReplayParam(arg_24_0._replayFightGroupMO)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, arg_24_0._replayFightGroupMO.id)
	arg_24_0:_refreshCloth()
	arg_24_0:_refreshMainCard()
	gohelper.setActive(arg_24_0._goherogroupcontain, false)
	gohelper.setActive(arg_24_0._goherogroupcontain, true)
end

function var_0_0._switchReplayMul(arg_25_0)
	arg_25_0._txtreplaycount.text = arg_25_0._replayMode and luaLang("multiple") .. arg_25_0._multiplication or ""
end

function var_0_0._heroMoveForward(arg_26_0, arg_26_1)
	HeroGroupEditListModel.instance:setMoveHeroId(tonumber(arg_26_1))
end

function var_0_0.isReplayMode(arg_27_0)
	return arg_27_0._replayMode
end

function var_0_0._onCurrencyChange(arg_28_0, arg_28_1)
	if not arg_28_1[CurrencyEnum.CurrencyType.Power] then
		return
	end

	arg_28_0:_refreshBtns()
end

function var_0_0._respBeginFight(arg_29_0)
	gohelper.setActive(arg_29_0._gomask, true)
end

function var_0_0._onOpenFullView(arg_30_0, arg_30_1)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
end

function var_0_0._onCloseView(arg_31_0, arg_31_1)
	if arg_31_1 == ViewName.EquipInfoTeamShowView then
		arg_31_0:_checkFirstPosHasEquip()
	end
end

function var_0_0._getMultiplicationKey(arg_32_0)
	return string.format("%s#%d", PlayerPrefsKey.Multiplication .. PlayerModel.instance:getMyUserId(), arg_32_0._episodeId)
end

function var_0_0._udpateRecommendEffect(arg_33_0)
	gohelper.setActive(arg_33_0._goRecommendEffect, FightFailRecommendController.instance:needShowRecommend(arg_33_0._episodeId))
end

function var_0_0._onEscapeBtnClick(arg_34_0)
	if not arg_34_0._gomask.gameObject.activeInHierarchy then
		arg_34_0.viewContainer:_closeCallback()
	end
end

function var_0_0._refreshUI(arg_35_0)
	local var_35_0 = HeroGroupModel.instance:getCurGroupId()

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, var_35_0)

	arg_35_0._episodeId = HeroGroupModel.instance.episodeId
	arg_35_0.episodeConfig = DungeonConfig.instance:getEpisodeCO(arg_35_0._episodeId)

	arg_35_0:_refreshBtns()
	arg_35_0:_refreshCloth()
	arg_35_0:_refreshMainCard()
	arg_35_0.viewContainer:setNavigateOverrideClose(arg_35_0.openSeason1_2MainView, arg_35_0)
end

function var_0_0.onClose(arg_36_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)

	local var_36_0 = {
		groupIndex = Activity104Model.instance:getSeasonCurSnapshotSubId()
	}

	var_36_0.heroGroup = Activity104Model.instance:getSnapshotHeroGroupBySubId(var_36_0.groupIndex)

	HeroGroupModel.instance:setHeroGroupSnapshot(ModuleEnum.HeroGroupType.Season, DungeonModel.instance.curSendEpisodeId, true, var_36_0)
	arg_36_0:_removeEvents()
	ZProj.TweenHelper.KillById(arg_36_0._tweeningId)
	TaskDispatcher.cancelTask(arg_36_0.openHeroGroupEditView, arg_36_0)
	TaskDispatcher.cancelTask(arg_36_0._closeHeroContainAnim, arg_36_0)
	TaskDispatcher.cancelTask(arg_36_0._onEnableStart, arg_36_0)

	if arg_36_0._dragEffectLoader then
		arg_36_0._dragEffectLoader:dispose()

		arg_36_0._dragEffectLoader = nil
	end
end

function var_0_0._removeEvents(arg_37_0)
	arg_37_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_37_0._onModifySnapshot, arg_37_0)
	arg_37_0:removeEventCb(FightController.instance, FightEvent.RespGetFightRecordGroupReply, arg_37_0._onGetFightRecordGroupReply, arg_37_0)
end

function var_0_0._refreshReplay(arg_38_0)
	local var_38_0 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightReplay)
	local var_38_1 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay)

	gohelper.setActive(arg_38_0._btnseasonreplay.gameObject, arg_38_0.episodeConfig and arg_38_0.episodeConfig.canUseRecord == 1)

	local var_38_2 = DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId)
	local var_38_3 = var_38_2 and var_38_2.hasRecord

	ZProj.UGUIHelper.SetColorAlpha(arg_38_0._imagereplaybg, var_38_1 and var_38_3 and 1 or 0.75)

	arg_38_0._txtreplaycount.text = arg_38_0._replayMode and luaLang("multiple") .. arg_38_0._multiplication or ""

	UISpriteSetMgr.instance:setHeroGroupSprite(arg_38_0._imagereplayicon, var_38_1 and var_38_3 and "btn_replay_play" or "btn_replay_lack")
end

function var_0_0._refreshCloth(arg_39_0)
	local var_39_0 = HeroGroupModel.instance:getCurGroupMO()
	local var_39_1 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.LeadRoleSkill)
	local var_39_2 = var_39_0.clothId
	local var_39_3 = PlayerClothModel.instance:getById(var_39_2)

	gohelper.setActive(arg_39_0._txtclothname.gameObject, var_39_3)

	if var_39_3 then
		local var_39_4 = lua_cloth.configDict[var_39_3.clothId]

		if not var_39_3.level then
			local var_39_5 = 0
		end

		arg_39_0._txtclothname.text = var_39_4.name
		arg_39_0._txtclothnameen.text = var_39_4.enname
	end

	for iter_39_0, iter_39_1 in ipairs(lua_cloth.configList) do
		local var_39_6 = gohelper.findChild(arg_39_0._iconGO, tostring(iter_39_1.id))

		if not gohelper.isNil(var_39_6) then
			gohelper.setActive(var_39_6, iter_39_1.id == var_39_2)
		end
	end

	gohelper.setActive(arg_39_0._btncloth.gameObject, var_0_0.showCloth())
end

function var_0_0._checkEquipClothSkill(arg_40_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill) then
		return
	end

	local var_40_0 = HeroGroupModel.instance:getCurGroupMO()

	if PlayerClothModel.instance:getById(var_40_0.clothId) then
		return
	end

	local var_40_1 = PlayerClothModel.instance:getList()

	for iter_40_0, iter_40_1 in ipairs(var_40_1) do
		if PlayerClothModel.instance:hasCloth(iter_40_1.id) then
			local var_40_2 = Activity104Model.instance:getCurSeasonId()
			local var_40_3 = Activity104Model.instance:getSeasonCurSnapshotSubId(var_40_2)
			local var_40_4 = Activity104Model.instance:getSnapshotHeroGroupBySubId(var_40_3)
			local var_40_5 = {
				groupIndex = var_40_3,
				heroGroup = var_40_4
			}

			HeroGroupModel.instance:setHeroGroupSnapshot(ModuleEnum.HeroGroupType.Season, DungeonModel.instance.curSendEpisodeId, true, var_40_5)

			break
		end
	end
end

function var_0_0._getEpisodeConfigAndBattleConfig()
	local var_41_0 = DungeonConfig.instance:getEpisodeCO(HeroGroupModel.instance.episodeId)
	local var_41_1 = var_41_0 and lua_battle.configDict[var_41_0.battleId]

	return var_41_0, var_41_1
end

function var_0_0.showCloth()
	if PlayerClothModel.instance:getSpEpisodeClothID() then
		return true
	end

	if not OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.LeadRoleSkill) then
		return false
	end

	local var_42_0, var_42_1 = var_0_0._getEpisodeConfigAndBattleConfig()

	if var_42_1 and var_42_1.noClothSkill == 1 then
		return false
	end

	local var_42_2 = HeroGroupModel.instance:getCurGroupMO()
	local var_42_3 = PlayerClothModel.instance:getById(var_42_2.clothId)
	local var_42_4 = PlayerClothModel.instance:getList()
	local var_42_5 = false

	for iter_42_0, iter_42_1 in ipairs(var_42_4) do
		var_42_5 = true

		break
	end

	return var_42_5
end

function var_0_0._onModifyHeroGroup(arg_43_0)
	arg_43_0:_refreshCloth()
	arg_43_0:_refreshMainCard()
end

function var_0_0._onModifySnapshot(arg_44_0)
	arg_44_0:_refreshCloth()
	arg_44_0:_refreshMainCard()
end

function var_0_0._onClickHeroGroupItem(arg_45_0, arg_45_1)
	TaskDispatcher.cancelTask(arg_45_0.openHeroGroupEditView, arg_45_0)

	local var_45_0 = HeroGroupModel.instance:getCurGroupMO()

	HeroSingleGroupModel.instance:setSingleGroup(var_45_0)

	local var_45_1 = var_45_0:getPosEquips(arg_45_1 - 1).equipUid

	arg_45_0._param = {}
	arg_45_0._param.singleGroupMOId = arg_45_1
	arg_45_0._param.originalHeroUid = HeroSingleGroupModel.instance:getHeroUid(arg_45_1)
	arg_45_0._param.equips = var_45_1

	arg_45_0:openHeroGroupEditView()
end

function var_0_0.openHeroGroupEditView(arg_46_0)
	ViewMgr.instance:openView(ViewName.HeroGroupEditView, arg_46_0._param)
end

function var_0_0._checkFirstPosHasEquip(arg_47_0)
	local var_47_0 = HeroGroupModel.instance:getCurGroupMO()

	if not var_47_0 then
		return
	end

	local var_47_1 = var_47_0:getPosEquips(0).equipUid
	local var_47_2 = var_47_1 and var_47_1[1]

	if var_47_2 and EquipModel.instance:getEquip(var_47_2) then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnFirstPosHasEquip)
	end
end

function var_0_0._showGuideDragEffect(arg_48_0, arg_48_1)
	if arg_48_0._dragEffectLoader then
		arg_48_0._dragEffectLoader:dispose()

		arg_48_0._dragEffectLoader = nil
	end

	if tonumber(arg_48_1) == 1 then
		arg_48_0._dragEffectLoader = PrefabInstantiate.Create(arg_48_0.viewGO)

		arg_48_0._dragEffectLoader:startLoad("ui/viewres/guide/guide_herogroup.prefab")
	end
end

function var_0_0._onClickStart(arg_49_0)
	local var_49_0 = string.split(arg_49_0.episodeConfig.cost, "|")
	local var_49_1 = string.split(var_49_0[1], "#")
	local var_49_2 = tonumber(var_49_1[3] or 0)
	local var_49_3 = 10104

	if HeroGroupModel.instance.episodeId == var_49_3 and not DungeonModel.instance:hasPassLevel(var_49_3) then
		local var_49_4 = HeroSingleGroupModel.instance:getList()
		local var_49_5 = 0

		for iter_49_0, iter_49_1 in ipairs(var_49_4) do
			if not iter_49_1:isEmpty() then
				var_49_5 = var_49_5 + 1
			end
		end

		if var_49_5 < 2 then
			GameFacade.showToast(ToastEnum.HeroSingleGroupCount)

			return
		end
	end

	arg_49_0:_enterFight()
end

function var_0_0._enterFight(arg_50_0)
	if HeroGroupModel.instance.episodeId then
		arg_50_0._closeWithEnteringFight = true

		if FightController.instance:setFightHeroGroup() then
			local var_50_0 = FightModel.instance:getFightParam()

			if arg_50_0._replayMode then
				var_50_0.isReplay = true
				var_50_0.multiplication = arg_50_0._multiplication

				DungeonFightController.instance:sendStartDungeonRequest(var_50_0.chapterId, var_50_0.episodeId, var_50_0, arg_50_0._multiplication, nil, true)
			else
				var_50_0.isReplay = false
				var_50_0.multiplication = 1

				DungeonFightController.instance:sendStartDungeonRequest(var_50_0.chapterId, var_50_0.episodeId, var_50_0, 1)
			end

			AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
		end
	else
		logError("没选中关卡，无法开始战斗")
	end
end

function var_0_0._onUseRecommendGroup(arg_51_0)
	if arg_51_0._replayMode then
		arg_51_0._replayMode = false
		arg_51_0._multiplication = 1

		arg_51_0:_refreshBtns()
		arg_51_0:_switchReplayGroup()
	end
end

function var_0_0._refreshBtns(arg_52_0)
	gohelper.setActive(arg_52_0._dropseasonherogroup.gameObject, not arg_52_0._replayMode)
end

function var_0_0._onGetFightRecordGroupReply(arg_53_0, arg_53_1)
	arg_53_0:removeEventCb(FightController.instance, FightEvent.RespGetFightRecordGroupReply, arg_53_0._onGetFightRecordGroupReply, arg_53_0)

	arg_53_0._replayFightGroupMO = arg_53_1

	if not arg_53_0._replayMode then
		return
	end

	arg_53_0:_switchReplayGroup()
	arg_53_0:_updateReplayHeroGroup()
end

function var_0_0._updateReplayHeroGroup(arg_54_0)
	HeroGroupModel.instance:setReplayParam(arg_54_0._replayFightGroupMO)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, arg_54_0._replayFightGroupMO.id)
	arg_54_0:_refreshCloth()
	arg_54_0:_refreshMainCard()
	gohelper.setActive(arg_54_0._goherogroupcontain, false)
	gohelper.setActive(arg_54_0._goherogroupcontain, true)
end

function var_0_0._playHeroGroupExitEffect(arg_55_0)
	arg_55_0._anim:Play("close", 0, 0)
	arg_55_0._btnContainAnim:Play("close", 0, 0)
end

function var_0_0._playCloseHeroGroupAnimation(arg_56_0)
	arg_56_0._anim:Play("close", 0, 0)
	arg_56_0._btnContainAnim:Play("close", 0, 0)

	arg_56_0._heroContainAnim.enabled = true

	arg_56_0._heroContainAnim:Play("herogroupcontain_out", 0, 0)
	TaskDispatcher.runDelay(arg_56_0._closeHeroContainAnim, arg_56_0, 0.133)
end

function var_0_0._closeHeroContainAnim(arg_57_0)
	if arg_57_0._heroContainAnim then
		arg_57_0._heroContainAnim.enabled = false
	end
end

function var_0_0.onDestroyView(arg_58_0)
	arg_58_0._simagerole:UnLoadImage()

	if arg_58_0._superCardItem then
		arg_58_0._superCardItem:destroy()

		arg_58_0._superCardItem = nil
	end
end

return var_0_0
