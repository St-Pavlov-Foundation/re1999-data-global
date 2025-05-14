module("modules.logic.seasonver.act123.view2_0.Season123_2_0HeroGroupFightView", package.seeall)

local var_0_0 = class("Season123_2_0HeroGroupFightView", BaseView)

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
	arg_1_0._btnstartseasonreplay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#btn_startseasonreplay")
	arg_1_0._btnseasonreplay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#btn_seasonreplay")
	arg_1_0._imagereplaybg = gohelper.findChildImage(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#btn_seasonreplay/replayAnimRoot/#image_seasonreplaybg")
	arg_1_0._imagereplayicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#btn_seasonreplay/replayAnimRoot/#image_seasonreplayicon")
	arg_1_0._txtreplaycount = gohelper.findChildText(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#btn_seasonreplay/replayAnimRoot/#txt_seasonreplaycount")
	arg_1_0._dropseasonherogroup = gohelper.findChildDropdown(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#drop_seasonherogroup")
	arg_1_0._goherogroupcontain = gohelper.findChild(arg_1_0.viewGO, "herogroupcontain")
	arg_1_0._gocontainer2 = gohelper.findChild(arg_1_0.viewGO, "#go_container2")
	arg_1_0._gomask = gohelper.findChild(arg_1_0.viewGO, "#go_container2/#go_mask")
	arg_1_0._goreplaybtn = gohelper.findChild(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn")
	arg_1_0._gocost = gohelper.findChild(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#btn_startseason/#go_cost")
	arg_1_0._btnseasonreplaygroup = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn/replayAnimRoot/btnReplay")
	arg_1_0._gomemorytimes = gohelper.findChild(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn/replayAnimRoot/#go_memorytimes")
	arg_1_0._txtmemorytimes = gohelper.findChildText(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn/replayAnimRoot/#go_memorytimes/bg/#txt_memorytimes")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncloth:AddClickListener(arg_2_0._btnclothOnClock, arg_2_0)
	arg_2_0._btnrecommend:AddClickListener(arg_2_0._btnrecommendOnClick, arg_2_0)
	arg_2_0._btnrestrain:AddClickListener(arg_2_0._btnrestrainOnClick, arg_2_0)
	arg_2_0._btnstartseason:AddClickListener(arg_2_0._btnstartseasonOnClick, arg_2_0)
	arg_2_0._btnstartseasonreplay:AddClickListener(arg_2_0._btnstartseasonOnClick, arg_2_0)
	arg_2_0._btnseasonreplay:AddClickListener(arg_2_0._btnseasonreplayOnClick, arg_2_0)
	arg_2_0._btnseasonreplaygroup:AddClickListener(arg_2_0._btnseasonreplayOnClick, arg_2_0)
	arg_2_0._dropseasonherogroup:AddOnValueChanged(arg_2_0._groupDropValueChanged, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncloth:RemoveClickListener()
	arg_3_0._btnrecommend:RemoveClickListener()
	arg_3_0._btnrestrain:RemoveClickListener()
	arg_3_0._btnstartseason:RemoveClickListener()
	arg_3_0._btnseasonreplay:RemoveClickListener()
	arg_3_0._btnseasonreplaygroup:RemoveClickListener()
	arg_3_0._btnstartseasonreplay:RemoveClickListener()
	arg_3_0._dropseasonherogroup:RemoveOnValueChanged()
end

function var_0_0._btnrecommendOnClick(arg_4_0)
	FightFailRecommendController.instance:onClickRecommend()
	arg_4_0:_updateRecommendEffect()
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

var_0_0.UIBlock_SeasonFight = "UIBlock_SeasonFight"

function var_0_0._btnstartseasonOnClick(arg_7_0)
	if not arg_7_0._blockStart then
		if not arg_7_0:_onClickStart() then
			return
		end

		arg_7_0._blockStart = true

		UIBlockMgr.instance:startBlock(var_0_0.UIBlock_SeasonFight)
	end
end

function var_0_0._btnseasonreplayOnClick(arg_8_0)
	arg_8_0:_onClickReplay()
end

function var_0_0._groupDropValueChanged(arg_9_0, arg_9_1)
	if arg_9_0._isDropInited then
		GameFacade.showToast(ToastEnum.SeasonGroupChanged)
	end

	if Season123HeroGroupModel.instance:isEpisodeSeason123() then
		local var_9_0 = arg_9_0.viewParam.actId
		local var_9_1 = arg_9_1 + 1

		if var_9_1 ~= Season123Model.instance:getActInfo(var_9_0).heroGroupSnapshotSubId then
			Season123HeroGroupController.instance:switchHeroGroup(var_9_1)
		end
	end
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0:_initComponent()
	arg_10_0:_initData()
	arg_10_0:_addEvents()
end

function var_0_0.onDestroyView(arg_11_0)
	if arg_11_0._superCardItem then
		arg_11_0._superCardItem:destroy()

		arg_11_0._superCardItem = nil
	end

	Season123HeroGroupController.instance:onCloseView()
	UIBlockMgr.instance:endBlock(var_0_0.UIBlock_SeasonFight)
end

function var_0_0.onOpen(arg_12_0)
	local var_12_0 = arg_12_0.viewParam.actId
	local var_12_1 = arg_12_0.viewParam.layer
	local var_12_2 = arg_12_0.viewParam.episodeId
	local var_12_3 = arg_12_0.viewParam.stage

	Season123HeroGroupController.instance:onOpenView(var_12_0, var_12_1, var_12_2, var_12_3)
	arg_12_0:initSeason123FightGroupDrop()
	arg_12_0:_checkFirstPosHasEquip()
	arg_12_0:_refreshUI()
	arg_12_0:_checkReplay()
	arg_12_0:_refreshReplay()
	arg_12_0:_updateRecommendEffect()
	arg_12_0:_initDataOnOpen()

	if Season123HeroGroupModel.instance:isEpisodeSeason123() then
		Season123Controller.instance:dispatchEvent(Season123Event.EnterMainEpiosdeHeroGroupView)
	end
end

function var_0_0._initComponent(arg_13_0)
	arg_13_0._anim = arg_13_0._gocontainer:GetComponent(typeof(UnityEngine.Animator))
	arg_13_0._heroContainAnim = arg_13_0._goherogroupcontain:GetComponent(typeof(UnityEngine.Animator))
	arg_13_0._btnContainAnim = arg_13_0._gobtncontain:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0._initData(arg_14_0)
	gohelper.addUIClickAudio(arg_14_0._btnstartseason.gameObject, AudioEnum.HeroGroupUI.Play_UI_Formation_Action)
	gohelper.addUIClickAudio(arg_14_0._btnseasonreplay.gameObject, AudioEnum.UI.Play_UI_Player_Interface_Close)
	gohelper.addUIClickAudio(arg_14_0._btnrestrain.gameObject, AudioEnum.UI.Play_UI_Tipsopen)
	gohelper.addUIClickAudio(arg_14_0._dropseasonherogroup.gameObject, AudioEnum.UI.UI_transverse_tabs_click)
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Action_Cardsopen)
	NavigateMgr.instance:addEscape(Season123Controller.instance:getHeroGroupFightViewName(), arg_14_0._onEscapeBtnClick, arg_14_0)

	arg_14_0._iconGO = arg_14_0:getResInst(arg_14_0.viewContainer:getSetting().otherRes[1], arg_14_0._btncloth.gameObject)

	recthelper.setAnchor(arg_14_0._iconGO.transform, -100, 1)

	arg_14_0._tweeningId = 0
	arg_14_0._replayMode = false

	gohelper.setActive(arg_14_0._gomask, false)
end

function var_0_0._initDataOnOpen(arg_15_0)
	if Season123HeroGroupModel.instance:isEpisodeSeason123() then
		local var_15_0 = Season123Model.instance:getActInfo(arg_15_0.viewParam.actId).heroGroupSnapshotSubId

		arg_15_0._dropseasonherogroup:SetValue(var_15_0 - 1)
	else
		arg_15_0._dropseasonherogroup:SetValue(1)
	end

	gohelper.setActive(arg_15_0._goseasoncontain, true)

	arg_15_0._isDropInited = true
end

function var_0_0._addEvents(arg_16_0)
	arg_16_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullView, arg_16_0._onOpenFullView, arg_16_0)
	arg_16_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_16_0._onCloseView, arg_16_0)
	arg_16_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_16_0._onModifyHeroGroup, arg_16_0)
	arg_16_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_16_0._onModifySnapshot, arg_16_0)
	arg_16_0:addEventCb(Season123Controller.instance, Season123Event.HeroGroupIndexChanged, arg_16_0._onModifySnapshot, arg_16_0)
	arg_16_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroGroupItem, arg_16_0._onClickHeroGroupItem, arg_16_0)
	arg_16_0:addEventCb(FightController.instance, FightEvent.RespBeginFight, arg_16_0._respBeginFight, arg_16_0)
	arg_16_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.PlayHeroGroupExitEffect, arg_16_0._playHeroGroupExitEffect, arg_16_0)
	arg_16_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.PlayCloseHeroGroupAnimation, arg_16_0._playCloseHeroGroupAnimation, arg_16_0)
	arg_16_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnUseRecommendGroup, arg_16_0._onUseRecommendGroup, arg_16_0)
	arg_16_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_16_0._onCurrencyChange, arg_16_0)
	arg_16_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.ShowGuideDragEffect, arg_16_0._showGuideDragEffect, arg_16_0)
	arg_16_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.HeroMoveForward, arg_16_0._heroMoveForward, arg_16_0)
	arg_16_0:addEventCb(Season123Controller.instance, Season123Event.StartFightFailed, arg_16_0.handleStartFightFailed, arg_16_0)
end

function var_0_0._checkReplay(arg_17_0)
	local var_17_0 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay)
	local var_17_1 = DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId)
	local var_17_2 = var_17_1 and var_17_1.star == DungeonEnum.StarType.Advanced and var_17_1.hasRecord
	local var_17_3 = PlayerPrefsHelper.getString(FightModel.getPrefsKeyFightPassModel(), "")

	if var_17_0 and var_17_2 and not string.nilorempty(var_17_3) and cjson.decode(var_17_3)[tostring(arg_17_0._episodeId)] and not arg_17_0._replayMode then
		arg_17_0._replayMode = true

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

function var_0_0.initSeason123FightGroupDrop(arg_18_0)
	local var_18_0 = {}

	if Season123HeroGroupModel.instance:isEpisodeSeason123() then
		var_18_0 = {
			luaLang("season_herogroup_one"),
			luaLang("season_herogroup_two"),
			luaLang("season_herogroup_three"),
			luaLang("season_herogroup_four")
		}
	else
		var_18_0 = {
			luaLang("season_herogroup_one")
		}
	end

	arg_18_0._dropseasonherogroup:ClearOptions()
	arg_18_0._dropseasonherogroup:AddOptions(var_18_0)
end

function var_0_0._receiveRecommend(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	if arg_19_2 ~= 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.HeroGroupRecommendView, arg_19_3)
end

function var_0_0._onClickReplay(arg_20_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay) then
		local var_20_0, var_20_1 = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.FightReplay)

		GameFacade.showToast(var_20_0, var_20_1)

		return
	end

	if not HeroGroupModel.instance.episodeId then
		return
	end

	local var_20_2 = DungeonConfig.instance:getEpisodeCO(HeroGroupModel.instance.episodeId)
	local var_20_3 = DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId)
	local var_20_4 = var_20_3 and var_20_3.hasRecord
	local var_20_5 = var_20_2 and var_20_2.firstBattleId > 0

	if not var_20_4 and var_20_5 then
		GameFacade.showToast(ToastEnum.CantRecordReplay)

		return
	end

	if Season123Model.instance:isEpisodeAdvance(HeroGroupModel.instance.episodeId) and var_20_3.hasRecord then
		GameFacade.showToast(ToastEnum.SeasonAdvanceLevelNoReplay)

		return
	end

	if not var_20_4 then
		GameFacade.showToast(ToastEnum.SeasonHeroGroupStarNoAdvanced)

		return
	end

	if arg_20_0._replayMode then
		arg_20_0._replayMode = false

		arg_20_0._btnContainAnim:Play(UIAnimationName.Switch, 0, 0)
	else
		arg_20_0._btnContainAnim:Play(UIAnimationName.Switch, 0, 0)

		arg_20_0._replayMode = true
	end

	Season123HeroGroupModel.instance:saveMultiplication()
	arg_20_0:_refreshBtns()

	if arg_20_0._replayMode and not arg_20_0._replayFightGroupMO then
		arg_20_0:addEventCb(FightController.instance, FightEvent.RespGetFightRecordGroupReply, arg_20_0._onGetFightRecordGroupReply, arg_20_0)
		FightRpc.instance:sendGetFightRecordGroupRequest(HeroGroupModel.instance.episodeId)

		return
	end

	arg_20_0:_switchReplayGroup(arg_20_0._replayMode)
end

function var_0_0._switchReplayGroup(arg_21_0, arg_21_1)
	arg_21_0:_refreshTips()
	gohelper.setActive(arg_21_0._goreplayready, arg_21_0._replayMode)
	gohelper.setActive(arg_21_0._gomemorytimes, arg_21_0._replayMode)
	UISpriteSetMgr.instance:setHeroGroupSprite(arg_21_0._imagereplayicon, arg_21_0._replayMode and "btn_replay_pause" or "btn_replay_play")

	if arg_21_1 ~= arg_21_0._replayMode then
		TaskDispatcher.cancelTask(arg_21_0._switchReplayMul, arg_21_0)
		TaskDispatcher.runDelay(arg_21_0._switchReplayMul, arg_21_0, 0.1)
	else
		arg_21_0:_switchReplayMul()
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.PlayHeroGroupHeroEffect, arg_21_0._replayMode and "swicth" or "open")

	if arg_21_0._replayMode then
		arg_21_0:_updateReplayHeroGroupList()

		arg_21_0._txtmemorytimes.text = arg_21_0._replayFightGroupMO.recordRound
	else
		Season123HeroGroupController.instance:changeReplayMode2Manual()
		arg_21_0:_refreshCloth()
		gohelper.setActive(arg_21_0._goherogroupcontain, false)
		gohelper.setActive(arg_21_0._goherogroupcontain, true)
	end

	Season123Controller.instance:dispatchEvent(Season123Event.RecordRspMainCardRefresh)
end

function var_0_0._refreshTips(arg_22_0)
	return
end

function var_0_0._updateReplayHeroGroupList(arg_23_0)
	HeroGroupModel.instance:setReplayParam(arg_23_0._replayFightGroupMO)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, arg_23_0._replayFightGroupMO.id)
	arg_23_0:_refreshCloth()
	gohelper.setActive(arg_23_0._goherogroupcontain, false)
	gohelper.setActive(arg_23_0._goherogroupcontain, true)
end

function var_0_0._switchReplayMul(arg_24_0)
	arg_24_0._txtreplaycount.text = arg_24_0._replayMode and luaLang("multiple") .. Season123HeroGroupModel.instance.multiplication or ""
end

function var_0_0._heroMoveForward(arg_25_0, arg_25_1)
	HeroGroupEditListModel.instance:setMoveHeroId(tonumber(arg_25_1))
end

function var_0_0.handleStartFightFailed(arg_26_0)
	arg_26_0._blockStart = false

	UIBlockMgr.instance:endBlock(var_0_0.UIBlock_SeasonFight)
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

function var_0_0._updateRecommendEffect(arg_33_0)
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
	arg_35_0._chapterConfig = DungeonConfig.instance:getChapterCO(arg_35_0.episodeConfig.chapterId)

	if Season123HeroGroupModel.instance:isEpisodeSeason123() then
		gohelper.setActive(arg_35_0._btnrecommend, false)
	else
		gohelper.setActive(arg_35_0._btnrecommend, true)
	end

	arg_35_0:_refreshBtns()
	arg_35_0:_refreshCloth()
end

function var_0_0.onClose(arg_36_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
	arg_36_0:_removeEvents()
	ZProj.TweenHelper.KillById(arg_36_0._tweeningId)
	TaskDispatcher.cancelTask(arg_36_0._closeHeroContainAnim, arg_36_0)

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

	gohelper.setActive(arg_38_0._btnseasonreplay.gameObject, arg_38_0.episodeConfig and arg_38_0.episodeConfig.canUseRecord == 1 and not arg_38_0._replayMode)

	local var_38_2 = DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId)
	local var_38_3 = var_38_2 and var_38_2.hasRecord

	ZProj.UGUIHelper.SetColorAlpha(arg_38_0._imagereplaybg, var_38_1 and var_38_3 and 1 or 0.75)

	arg_38_0._txtreplaycount.text = arg_38_0._replayMode and luaLang("multiple") .. Season123HeroGroupModel.instance.multiplication or ""

	UISpriteSetMgr.instance:setHeroGroupSprite(arg_38_0._imagereplayicon, var_38_1 and var_38_3 and "btn_replay_play" or "btn_replay_lack")
	gohelper.setActive(arg_38_0._gomemorytimes, arg_38_0._replayMode)
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

function var_0_0._getEpisodeConfigAndBattleConfig()
	local var_40_0 = DungeonConfig.instance:getEpisodeCO(HeroGroupModel.instance.episodeId)
	local var_40_1 = var_40_0 and lua_battle.configDict[var_40_0.battleId]

	return var_40_0, var_40_1
end

function var_0_0.showCloth()
	if PlayerClothModel.instance:getSpEpisodeClothID() then
		return true
	end

	if not OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.LeadRoleSkill) then
		return false
	end

	local var_41_0, var_41_1 = var_0_0._getEpisodeConfigAndBattleConfig()

	if var_41_1 and var_41_1.noClothSkill == 1 then
		return false
	end

	local var_41_2 = HeroGroupModel.instance:getCurGroupMO()
	local var_41_3 = PlayerClothModel.instance:getById(var_41_2.clothId)
	local var_41_4 = PlayerClothModel.instance:getList()
	local var_41_5 = false

	for iter_41_0, iter_41_1 in ipairs(var_41_4) do
		var_41_5 = true

		break
	end

	return var_41_5
end

function var_0_0._onModifyHeroGroup(arg_42_0)
	arg_42_0:_refreshCloth()
end

function var_0_0._onModifySnapshot(arg_43_0)
	arg_43_0:_refreshCloth()
end

function var_0_0._onClickHeroGroupItem(arg_44_0, arg_44_1)
	local var_44_0 = HeroGroupModel.instance:getCurGroupMO()
	local var_44_1 = var_44_0:getPosEquips(arg_44_1 - 1).equipUid

	if var_44_0 then
		HeroSingleGroupModel.instance:setSingleGroup(var_44_0, true)
	end

	if Season123HeroGroupModel.instance:isEpisodeSeason123() or Season123HeroGroupModel.instance:isEpisodeSeason123Retail() then
		arg_44_0._param = tabletool.copy(arg_44_0.viewParam)
		arg_44_0._param.singleGroupMOId = arg_44_1
		arg_44_0._param.originalHeroUid = HeroSingleGroupModel.instance:getHeroUid(arg_44_1)
		arg_44_0._param.equips = var_44_1

		ViewMgr.instance:openView(Season123Controller.instance:getHeroGroupEditViewName(), arg_44_0._param)
	else
		arg_44_0._param = {}
		arg_44_0._param.singleGroupMOId = arg_44_1
		arg_44_0._param.originalHeroUid = HeroSingleGroupModel.instance:getHeroUid(arg_44_1)
		arg_44_0._param.adventure = HeroGroupModel.instance:isAdventureOrWeekWalk()
		arg_44_0._param.equips = var_44_1

		ViewMgr.instance:openView(ViewName.HeroGroupEditView, arg_44_0._param)
	end
end

function var_0_0._checkFirstPosHasEquip(arg_45_0)
	local var_45_0 = HeroGroupModel.instance:getCurGroupMO()

	if not var_45_0 then
		return
	end

	local var_45_1 = var_45_0:getPosEquips(0).equipUid
	local var_45_2 = var_45_1 and var_45_1[1]

	if var_45_2 and EquipModel.instance:getEquip(var_45_2) then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnFirstPosHasEquip)
	end
end

function var_0_0._showGuideDragEffect(arg_46_0, arg_46_1)
	if arg_46_0._dragEffectLoader then
		arg_46_0._dragEffectLoader:dispose()

		arg_46_0._dragEffectLoader = nil
	end

	if tonumber(arg_46_1) == 1 then
		arg_46_0._dragEffectLoader = PrefabInstantiate.Create(arg_46_0.viewGO)

		arg_46_0._dragEffectLoader:startLoad("ui/viewres/guide/guide_herogroup.prefab")
	end
end

function var_0_0._onClickStart(arg_47_0)
	local var_47_0 = string.split(arg_47_0.episodeConfig.cost, "|")
	local var_47_1 = string.split(var_47_0[1], "#")
	local var_47_2 = tonumber(var_47_1[3] or 0)
	local var_47_3 = 10104

	if HeroGroupModel.instance.episodeId == var_47_3 and not DungeonModel.instance:hasPassLevel(var_47_3) then
		local var_47_4 = HeroSingleGroupModel.instance:getList()
		local var_47_5 = 0

		for iter_47_0, iter_47_1 in ipairs(var_47_4) do
			if not iter_47_1:isEmpty() then
				var_47_5 = var_47_5 + 1
			end
		end

		if var_47_5 < 2 then
			GameFacade.showToast(ToastEnum.HeroSingleGroupCount)

			return
		end
	end

	return arg_47_0:_enterFight()
end

function var_0_0._enterFight(arg_48_0)
	local var_48_0 = false

	if HeroGroupModel.instance.episodeId then
		arg_48_0._closeWithEnteringFight = true
		var_48_0 = FightController.instance:setFightHeroGroup()

		if var_48_0 then
			local var_48_1 = FightModel.instance:getFightParam()

			if arg_48_0._replayMode then
				var_48_1.isReplay = true
				var_48_1.multiplication = Season123HeroGroupModel.instance.multiplication

				Season123HeroGroupController.instance:sendStartAct123Battle(var_48_1.chapterId, var_48_1.episodeId, var_48_1, Season123HeroGroupModel.instance.multiplication, nil, true)
			else
				var_48_1.isReplay = false
				var_48_1.multiplication = 1

				Season123HeroGroupController.instance:sendStartAct123Battle(var_48_1.chapterId, var_48_1.episodeId, var_48_1, 1)
			end

			AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
		end
	else
		logError("没选中关卡，无法开始战斗")
	end

	return var_48_0
end

function var_0_0._onUseRecommendGroup(arg_49_0)
	if arg_49_0._replayMode then
		arg_49_0._replayMode = false

		arg_49_0:_refreshBtns()
		arg_49_0:_switchReplayGroup()
	end
end

function var_0_0._refreshBtns(arg_50_0)
	gohelper.setActive(arg_50_0._goreplaybtn, arg_50_0._replayMode)
	gohelper.setActive(arg_50_0._dropseasonherogroup.gameObject, not arg_50_0._replayMode)
	gohelper.setActive(arg_50_0._gocost, arg_50_0._replayMode)
	gohelper.setActive(arg_50_0._btnseasonreplay, not arg_50_0._replayMode)
	gohelper.setActive(arg_50_0._btnstartseason, not arg_50_0._replayMode)
	gohelper.setActive(arg_50_0._btnstartseasonreplay, arg_50_0._replayMode)
end

function var_0_0._onGetFightRecordGroupReply(arg_51_0, arg_51_1)
	arg_51_0:removeEventCb(FightController.instance, FightEvent.RespGetFightRecordGroupReply, arg_51_0._onGetFightRecordGroupReply, arg_51_0)
	Season123HeroGroupController.processReplayGroupMO(arg_51_1)

	arg_51_0._replayFightGroupMO = arg_51_1

	if not arg_51_0._replayMode then
		return
	end

	arg_51_0:_switchReplayGroup()
	arg_51_0:_updateReplayHeroGroup()
end

function var_0_0._updateReplayHeroGroup(arg_52_0)
	HeroGroupModel.instance:setReplayParam(arg_52_0._replayFightGroupMO)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, arg_52_0._replayFightGroupMO.id)
	arg_52_0:_refreshCloth()
	gohelper.setActive(arg_52_0._goherogroupcontain, false)
	gohelper.setActive(arg_52_0._goherogroupcontain, true)
	Season123Controller.instance:dispatchEvent(Season123Event.RecordRspMainCardRefresh)
end

function var_0_0._playHeroGroupExitEffect(arg_53_0)
	arg_53_0._anim:Play("close", 0, 0)
	arg_53_0._btnContainAnim:Play("close", 0, 0)
end

function var_0_0._playCloseHeroGroupAnimation(arg_54_0)
	arg_54_0._anim:Play("close", 0, 0)
	arg_54_0._btnContainAnim:Play("close", 0, 0)

	arg_54_0._heroContainAnim.enabled = true

	arg_54_0._heroContainAnim:Play("herogroupcontain_out", 0, 0)
	TaskDispatcher.runDelay(arg_54_0._closeHeroContainAnim, arg_54_0, 0.133)
end

function var_0_0._closeHeroContainAnim(arg_55_0)
	if arg_55_0._heroContainAnim then
		arg_55_0._heroContainAnim.enabled = false
	end
end

return var_0_0
