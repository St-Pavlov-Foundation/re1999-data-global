module("modules.logic.seasonver.act123.view1_8.Season123_1_8HeroGroupFightView", package.seeall)

local var_0_0 = class("Season123_1_8HeroGroupFightView", BaseView)
local var_0_1 = "UIBlock_SeasonFight"

function var_0_0._setBlock_overseas(arg_1_0, arg_1_1)
	if arg_1_1 then
		UIBlockMgr.instance:startBlock(var_0_1)
	else
		UIBlockMgr.instance:endBlock(var_0_1)
	end
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._gocontainer = gohelper.findChild(arg_2_0.viewGO, "#go_container")
	arg_2_0._goreplayready = gohelper.findChild(arg_2_0.viewGO, "#go_container/#go_replayready")
	arg_2_0._gotopbtns = gohelper.findChild(arg_2_0.viewGO, "#go_container/#go_btns/#go_topbtns")
	arg_2_0._btnrecommend = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "#go_container/#go_btns/#go_topbtns/btn_recommend")
	arg_2_0._btnrestrain = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "#go_container/#go_btns/#go_topbtns/#btn_RestraintInfo")
	arg_2_0._gobtncontain = gohelper.findChild(arg_2_0.viewGO, "#go_container/btnContain")
	arg_2_0._btncloth = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "#go_container/btnContain/btnCloth")
	arg_2_0._txtclothname = gohelper.findChildText(arg_2_0.viewGO, "#go_container/btnContain/btnCloth/#txt_clothName")
	arg_2_0._txtclothnameen = gohelper.findChildText(arg_2_0.viewGO, "#go_container/btnContain/btnCloth/#txt_clothName/#txt_clothNameEn")
	arg_2_0._btnstartseason = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "#go_container/btnContain/horizontal/#btn_startseason")
	arg_2_0._btnstartseasonreplay = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "#go_container/btnContain/horizontal/#btn_startseasonreplay")
	arg_2_0._btnseasonreplay = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "#go_container/btnContain/horizontal/#btn_seasonreplay")
	arg_2_0._imagereplaybg = gohelper.findChildImage(arg_2_0.viewGO, "#go_container/btnContain/horizontal/#btn_seasonreplay/replayAnimRoot/#image_seasonreplaybg")
	arg_2_0._imagereplayicon = gohelper.findChildImage(arg_2_0.viewGO, "#go_container/btnContain/horizontal/#btn_seasonreplay/replayAnimRoot/#image_seasonreplayicon")
	arg_2_0._txtreplaycount = gohelper.findChildText(arg_2_0.viewGO, "#go_container/btnContain/horizontal/#btn_seasonreplay/replayAnimRoot/#txt_seasonreplaycount")
	arg_2_0._dropseasonherogroup = gohelper.findChildDropdown(arg_2_0.viewGO, "#go_container/btnContain/horizontal/#drop_seasonherogroup")
	arg_2_0._goherogroupcontain = gohelper.findChild(arg_2_0.viewGO, "herogroupcontain")
	arg_2_0._gocontainer2 = gohelper.findChild(arg_2_0.viewGO, "#go_container2")
	arg_2_0._gomask = gohelper.findChild(arg_2_0.viewGO, "#go_container2/#go_mask")
	arg_2_0._goreplaybtn = gohelper.findChild(arg_2_0.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn")
	arg_2_0._gocost = gohelper.findChild(arg_2_0.viewGO, "#go_container/btnContain/horizontal/#btn_startseason/#go_cost")
	arg_2_0._btnseasonreplaygroup = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn/replayAnimRoot/btnReplay")
	arg_2_0._gomemorytimes = gohelper.findChild(arg_2_0.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn/replayAnimRoot/#go_memorytimes")
	arg_2_0._txtmemorytimes = gohelper.findChildText(arg_2_0.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn/replayAnimRoot/#go_memorytimes/bg/#txt_memorytimes")

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0._btncloth:AddClickListener(arg_3_0._btnclothOnClock, arg_3_0)
	arg_3_0._btnrecommend:AddClickListener(arg_3_0._btnrecommendOnClick, arg_3_0)
	arg_3_0._btnrestrain:AddClickListener(arg_3_0._btnrestrainOnClick, arg_3_0)
	arg_3_0._btnstartseason:AddClickListener(arg_3_0._btnstartseasonOnClick, arg_3_0)
	arg_3_0._btnstartseasonreplay:AddClickListener(arg_3_0._btnstartseasonOnClick, arg_3_0)
	arg_3_0._btnseasonreplay:AddClickListener(arg_3_0._btnseasonreplayOnClick, arg_3_0)
	arg_3_0._btnseasonreplaygroup:AddClickListener(arg_3_0._btnseasonreplayOnClick, arg_3_0)
	arg_3_0._dropseasonherogroup:AddOnValueChanged(arg_3_0._groupDropValueChanged, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0._btncloth:RemoveClickListener()
	arg_4_0._btnrecommend:RemoveClickListener()
	arg_4_0._btnrestrain:RemoveClickListener()
	arg_4_0._btnstartseason:RemoveClickListener()
	arg_4_0._btnseasonreplay:RemoveClickListener()
	arg_4_0._btnseasonreplaygroup:RemoveClickListener()
	arg_4_0._btnstartseasonreplay:RemoveClickListener()
	arg_4_0._dropseasonherogroup:RemoveOnValueChanged()
end

function var_0_0._btnrecommendOnClick(arg_5_0)
	FightFailRecommendController.instance:onClickRecommend()
	arg_5_0:_updateRecommendEffect()
	DungeonRpc.instance:sendGetEpisodeHeroRecommendRequest(arg_5_0._episodeId, arg_5_0._receiveRecommend, arg_5_0)
end

function var_0_0._btnclothOnClock(arg_6_0)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill) or PlayerClothModel.instance:getSpEpisodeClothID() then
		ViewMgr.instance:openView(ViewName.PlayerClothView)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.LeadRoleSkill))
	end
end

function var_0_0._btnrestrainOnClick(arg_7_0)
	ViewMgr.instance:openView(ViewName.HeroGroupCareerTipView)
end

var_0_0.UIBlock_SeasonFight = "UIBlock_SeasonFight"

function var_0_0._btnstartseasonOnClick(arg_8_0)
	arg_8_0:_onClickStart()
end

function var_0_0._btnseasonreplayOnClick(arg_9_0)
	arg_9_0:_onClickReplay()
end

function var_0_0._groupDropValueChanged(arg_10_0, arg_10_1)
	if arg_10_0._isDropInited then
		GameFacade.showToast(ToastEnum.SeasonGroupChanged)
	end

	if Season123HeroGroupModel.instance:isEpisodeSeason123() then
		local var_10_0 = arg_10_0.viewParam.actId
		local var_10_1 = arg_10_1 + 1

		if var_10_1 ~= Season123Model.instance:getActInfo(var_10_0).heroGroupSnapshotSubId then
			Season123HeroGroupController.instance:switchHeroGroup(var_10_1)
		end
	end
end

function var_0_0._editableInitView(arg_11_0)
	arg_11_0:_initComponent()
	arg_11_0:_initData()
	arg_11_0:_addEvents()
end

function var_0_0.onDestroyView(arg_12_0)
	if arg_12_0._superCardItem then
		arg_12_0._superCardItem:destroy()

		arg_12_0._superCardItem = nil
	end

	Season123HeroGroupController.instance:onCloseView()
	arg_12_0:_setBlock_overseas(false)
end

function var_0_0.onOpen(arg_13_0)
	local var_13_0 = arg_13_0.viewParam.actId
	local var_13_1 = arg_13_0.viewParam.layer
	local var_13_2 = arg_13_0.viewParam.episodeId
	local var_13_3 = arg_13_0.viewParam.stage

	Season123HeroGroupController.instance:onOpenView(var_13_0, var_13_1, var_13_2, var_13_3)
	arg_13_0:initSeason123FightGroupDrop()
	arg_13_0:_checkFirstPosHasEquip()
	arg_13_0:_refreshUI()
	arg_13_0:_checkReplay()
	arg_13_0:_refreshReplay()
	arg_13_0:_updateRecommendEffect()
	arg_13_0:_initDataOnOpen()

	if Season123HeroGroupModel.instance:isEpisodeSeason123() then
		Season123Controller.instance:dispatchEvent(Season123Event.EnterMainEpiosdeHeroGroupView)
	end
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
	NavigateMgr.instance:addEscape(Season123Controller.instance:getHeroGroupFightViewName(), arg_15_0._onEscapeBtnClick, arg_15_0)

	arg_15_0._iconGO = arg_15_0:getResInst(arg_15_0.viewContainer:getSetting().otherRes[1], arg_15_0._btncloth.gameObject)

	recthelper.setAnchor(arg_15_0._iconGO.transform, -100, 1)

	arg_15_0._tweeningId = 0
	arg_15_0._replayMode = false

	gohelper.setActive(arg_15_0._gomask, false)
end

function var_0_0._initDataOnOpen(arg_16_0)
	if Season123HeroGroupModel.instance:isEpisodeSeason123() then
		local var_16_0 = Season123Model.instance:getActInfo(arg_16_0.viewParam.actId).heroGroupSnapshotSubId

		arg_16_0._dropseasonherogroup:SetValue(var_16_0 - 1)
	else
		arg_16_0._dropseasonherogroup:SetValue(1)
	end

	gohelper.setActive(arg_16_0._goseasoncontain, true)

	arg_16_0._isDropInited = true
end

function var_0_0._addEvents(arg_17_0)
	arg_17_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullView, arg_17_0._onOpenFullView, arg_17_0)
	arg_17_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_17_0._onCloseView, arg_17_0)
	arg_17_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_17_0._onModifyHeroGroup, arg_17_0)
	arg_17_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_17_0._onModifySnapshot, arg_17_0)
	arg_17_0:addEventCb(Season123Controller.instance, Season123Event.HeroGroupIndexChanged, arg_17_0._onModifySnapshot, arg_17_0)
	arg_17_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroGroupItem, arg_17_0._onClickHeroGroupItem, arg_17_0)
	arg_17_0:addEventCb(FightController.instance, FightEvent.RespBeginFight, arg_17_0._respBeginFight, arg_17_0)
	arg_17_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.PlayHeroGroupExitEffect, arg_17_0._playHeroGroupExitEffect, arg_17_0)
	arg_17_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.PlayCloseHeroGroupAnimation, arg_17_0._playCloseHeroGroupAnimation, arg_17_0)
	arg_17_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnUseRecommendGroup, arg_17_0._onUseRecommendGroup, arg_17_0)
	arg_17_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_17_0._onCurrencyChange, arg_17_0)
	arg_17_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.ShowGuideDragEffect, arg_17_0._showGuideDragEffect, arg_17_0)
	arg_17_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.HeroMoveForward, arg_17_0._heroMoveForward, arg_17_0)
	arg_17_0:addEventCb(Season123Controller.instance, Season123Event.StartFightFailed, arg_17_0.handleStartFightFailed, arg_17_0)
end

function var_0_0._checkReplay(arg_18_0)
	local var_18_0 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay)
	local var_18_1 = DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId)
	local var_18_2 = var_18_1 and var_18_1.star == DungeonEnum.StarType.Advanced and var_18_1.hasRecord
	local var_18_3 = PlayerPrefsHelper.getString(FightModel.getPrefsKeyFightPassModel(), "")

	if var_18_0 and var_18_2 and not string.nilorempty(var_18_3) and cjson.decode(var_18_3)[tostring(arg_18_0._episodeId)] and not arg_18_0._replayMode then
		arg_18_0._replayMode = true

		arg_18_0:_refreshBtns()

		arg_18_0._replayFightGroupMO = HeroGroupModel.instance:getReplayParam()

		if not arg_18_0._replayFightGroupMO then
			arg_18_0:addEventCb(FightController.instance, FightEvent.RespGetFightRecordGroupReply, arg_18_0._onGetFightRecordGroupReply, arg_18_0)
			FightRpc.instance:sendGetFightRecordGroupRequest(HeroGroupModel.instance.episodeId)
		else
			arg_18_0:_switchReplayGroup()
		end
	end
end

function var_0_0.initSeason123FightGroupDrop(arg_19_0)
	local var_19_0 = {}

	if Season123HeroGroupModel.instance:isEpisodeSeason123() then
		var_19_0 = {
			luaLang("season_herogroup_one"),
			luaLang("season_herogroup_two"),
			luaLang("season_herogroup_three"),
			luaLang("season_herogroup_four")
		}
	else
		var_19_0 = {
			luaLang("season_herogroup_one")
		}
	end

	arg_19_0._dropseasonherogroup:ClearOptions()
	arg_19_0._dropseasonherogroup:AddOptions(var_19_0)
end

function var_0_0._receiveRecommend(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	if arg_20_2 ~= 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.HeroGroupRecommendView, arg_20_3)
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

	if Season123Model.instance:isEpisodeAdvance(HeroGroupModel.instance.episodeId) and var_21_3.hasRecord then
		GameFacade.showToast(ToastEnum.SeasonAdvanceLevelNoReplay)

		return
	end

	if not var_21_4 then
		GameFacade.showToast(ToastEnum.SeasonHeroGroupStarNoAdvanced)

		return
	end

	if arg_21_0._replayMode then
		arg_21_0._replayMode = false

		arg_21_0._btnContainAnim:Play(UIAnimationName.Switch, 0, 0)
	else
		arg_21_0._btnContainAnim:Play(UIAnimationName.Switch, 0, 0)

		arg_21_0._replayMode = true
	end

	Season123HeroGroupModel.instance:saveMultiplication()
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
	gohelper.setActive(arg_22_0._gomemorytimes, arg_22_0._replayMode)
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

		arg_22_0._txtmemorytimes.text = arg_22_0._replayFightGroupMO.recordRound
	else
		Season123HeroGroupController.instance:changeReplayMode2Manual()
		arg_22_0:_refreshCloth()
		gohelper.setActive(arg_22_0._goherogroupcontain, false)
		gohelper.setActive(arg_22_0._goherogroupcontain, true)
	end

	Season123Controller.instance:dispatchEvent(Season123Event.RecordRspMainCardRefresh)
end

function var_0_0._refreshTips(arg_23_0)
	return
end

function var_0_0._updateReplayHeroGroupList(arg_24_0)
	HeroGroupModel.instance:setReplayParam(arg_24_0._replayFightGroupMO)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, arg_24_0._replayFightGroupMO.id)
	arg_24_0:_refreshCloth()
	gohelper.setActive(arg_24_0._goherogroupcontain, false)
	gohelper.setActive(arg_24_0._goherogroupcontain, true)
end

function var_0_0._switchReplayMul(arg_25_0)
	arg_25_0._txtreplaycount.text = arg_25_0._replayMode and luaLang("multiple") .. Season123HeroGroupModel.instance.multiplication or ""
end

function var_0_0._heroMoveForward(arg_26_0, arg_26_1)
	HeroGroupEditListModel.instance:setMoveHeroId(tonumber(arg_26_1))
end

function var_0_0.handleStartFightFailed(arg_27_0)
	arg_27_0:_setBlock_overseas(false)
end

function var_0_0.isReplayMode(arg_28_0)
	return arg_28_0._replayMode
end

function var_0_0._onCurrencyChange(arg_29_0, arg_29_1)
	if not arg_29_1[CurrencyEnum.CurrencyType.Power] then
		return
	end

	arg_29_0:_refreshBtns()
end

function var_0_0._respBeginFight(arg_30_0)
	gohelper.setActive(arg_30_0._gomask, true)
end

function var_0_0._onOpenFullView(arg_31_0, arg_31_1)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
end

function var_0_0._onCloseView(arg_32_0, arg_32_1)
	if arg_32_1 == ViewName.EquipInfoTeamShowView then
		arg_32_0:_checkFirstPosHasEquip()
	end
end

function var_0_0._getMultiplicationKey(arg_33_0)
	return string.format("%s#%d", PlayerPrefsKey.Multiplication .. PlayerModel.instance:getMyUserId(), arg_33_0._episodeId)
end

function var_0_0._updateRecommendEffect(arg_34_0)
	gohelper.setActive(arg_34_0._goRecommendEffect, FightFailRecommendController.instance:needShowRecommend(arg_34_0._episodeId))
end

function var_0_0._onEscapeBtnClick(arg_35_0)
	if not arg_35_0._gomask.gameObject.activeInHierarchy then
		arg_35_0.viewContainer:_closeCallback()
	end
end

function var_0_0._refreshUI(arg_36_0)
	local var_36_0 = HeroGroupModel.instance:getCurGroupId()

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, var_36_0)

	arg_36_0._episodeId = HeroGroupModel.instance.episodeId
	arg_36_0.episodeConfig = DungeonConfig.instance:getEpisodeCO(arg_36_0._episodeId)
	arg_36_0._chapterConfig = DungeonConfig.instance:getChapterCO(arg_36_0.episodeConfig.chapterId)

	if Season123HeroGroupModel.instance:isEpisodeSeason123() then
		gohelper.setActive(arg_36_0._btnrecommend, false)
	else
		gohelper.setActive(arg_36_0._btnrecommend, true)
	end

	arg_36_0:_refreshBtns()
	arg_36_0:_refreshCloth()
end

function var_0_0.onClose(arg_37_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
	arg_37_0:_removeEvents()
	ZProj.TweenHelper.KillById(arg_37_0._tweeningId)
	TaskDispatcher.cancelTask(arg_37_0._closeHeroContainAnim, arg_37_0)

	if arg_37_0._dragEffectLoader then
		arg_37_0._dragEffectLoader:dispose()

		arg_37_0._dragEffectLoader = nil
	end
end

function var_0_0._removeEvents(arg_38_0)
	arg_38_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_38_0._onModifySnapshot, arg_38_0)
	arg_38_0:removeEventCb(FightController.instance, FightEvent.RespGetFightRecordGroupReply, arg_38_0._onGetFightRecordGroupReply, arg_38_0)
end

function var_0_0._refreshReplay(arg_39_0)
	local var_39_0 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightReplay)
	local var_39_1 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay)

	gohelper.setActive(arg_39_0._btnseasonreplay.gameObject, arg_39_0.episodeConfig and arg_39_0.episodeConfig.canUseRecord == 1 and not arg_39_0._replayMode)

	local var_39_2 = DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId)
	local var_39_3 = var_39_2 and var_39_2.hasRecord

	ZProj.UGUIHelper.SetColorAlpha(arg_39_0._imagereplaybg, var_39_1 and var_39_3 and 1 or 0.75)

	arg_39_0._txtreplaycount.text = arg_39_0._replayMode and luaLang("multiple") .. Season123HeroGroupModel.instance.multiplication or ""

	UISpriteSetMgr.instance:setHeroGroupSprite(arg_39_0._imagereplayicon, var_39_1 and var_39_3 and "btn_replay_play" or "btn_replay_lack")
	gohelper.setActive(arg_39_0._gomemorytimes, arg_39_0._replayMode)
end

function var_0_0._refreshCloth(arg_40_0)
	local var_40_0 = HeroGroupModel.instance:getCurGroupMO()
	local var_40_1 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.LeadRoleSkill)
	local var_40_2 = var_40_0.clothId
	local var_40_3 = PlayerClothModel.instance:getById(var_40_2)

	gohelper.setActive(arg_40_0._txtclothname.gameObject, var_40_3)

	if var_40_3 then
		local var_40_4 = lua_cloth.configDict[var_40_3.clothId]

		if not var_40_3.level then
			local var_40_5 = 0
		end

		arg_40_0._txtclothname.text = var_40_4.name
		arg_40_0._txtclothnameen.text = var_40_4.enname
	end

	for iter_40_0, iter_40_1 in ipairs(lua_cloth.configList) do
		local var_40_6 = gohelper.findChild(arg_40_0._iconGO, tostring(iter_40_1.id))

		if not gohelper.isNil(var_40_6) then
			gohelper.setActive(var_40_6, iter_40_1.id == var_40_2)
		end
	end

	gohelper.setActive(arg_40_0._btncloth.gameObject, var_0_0.showCloth())
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
end

function var_0_0._onModifySnapshot(arg_44_0)
	arg_44_0:_refreshCloth()
end

function var_0_0._onClickHeroGroupItem(arg_45_0, arg_45_1)
	local var_45_0 = HeroGroupModel.instance:getCurGroupMO()
	local var_45_1 = var_45_0:getPosEquips(arg_45_1 - 1).equipUid

	if var_45_0 then
		HeroSingleGroupModel.instance:setSingleGroup(var_45_0, true)
	end

	if Season123HeroGroupModel.instance:isEpisodeSeason123() or Season123HeroGroupModel.instance:isEpisodeSeason123Retail() then
		arg_45_0._param = tabletool.copy(arg_45_0.viewParam)
		arg_45_0._param.singleGroupMOId = arg_45_1
		arg_45_0._param.originalHeroUid = HeroSingleGroupModel.instance:getHeroUid(arg_45_1)
		arg_45_0._param.equips = var_45_1

		ViewMgr.instance:openView(Season123Controller.instance:getHeroGroupEditViewName(), arg_45_0._param)
	else
		arg_45_0._param = {}
		arg_45_0._param.singleGroupMOId = arg_45_1
		arg_45_0._param.originalHeroUid = HeroSingleGroupModel.instance:getHeroUid(arg_45_1)
		arg_45_0._param.adventure = HeroGroupModel.instance:isAdventureOrWeekWalk()
		arg_45_0._param.equips = var_45_1

		ViewMgr.instance:openView(ViewName.HeroGroupEditView, arg_45_0._param)
	end
end

function var_0_0._checkFirstPosHasEquip(arg_46_0)
	local var_46_0 = HeroGroupModel.instance:getCurGroupMO()

	if not var_46_0 then
		return
	end

	local var_46_1 = var_46_0:getPosEquips(0).equipUid
	local var_46_2 = var_46_1 and var_46_1[1]

	if var_46_2 and EquipModel.instance:getEquip(var_46_2) then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnFirstPosHasEquip)
	end
end

function var_0_0._showGuideDragEffect(arg_47_0, arg_47_1)
	if arg_47_0._dragEffectLoader then
		arg_47_0._dragEffectLoader:dispose()

		arg_47_0._dragEffectLoader = nil
	end

	if tonumber(arg_47_1) == 1 then
		arg_47_0._dragEffectLoader = PrefabInstantiate.Create(arg_47_0.viewGO)

		arg_47_0._dragEffectLoader:startLoad("ui/viewres/guide/guide_herogroup.prefab")
	end
end

function var_0_0._onClickStart(arg_48_0)
	local var_48_0 = string.split(arg_48_0.episodeConfig.cost, "|")
	local var_48_1 = string.split(var_48_0[1], "#")
	local var_48_2 = tonumber(var_48_1[3] or 0)
	local var_48_3 = 10104

	if HeroGroupModel.instance.episodeId == var_48_3 and not DungeonModel.instance:hasPassLevel(var_48_3) then
		local var_48_4 = HeroSingleGroupModel.instance:getList()
		local var_48_5 = 0

		for iter_48_0, iter_48_1 in ipairs(var_48_4) do
			if not iter_48_1:isEmpty() then
				var_48_5 = var_48_5 + 1
			end
		end

		if var_48_5 < 2 then
			GameFacade.showToast(ToastEnum.HeroSingleGroupCount)

			return
		end
	end

	arg_48_0:_enterFight()
end

function var_0_0._enterFight(arg_49_0)
	if HeroGroupModel.instance.episodeId then
		arg_49_0._closeWithEnteringFight = true

		if FightController.instance:setFightHeroGroup() then
			arg_49_0:_setBlock_overseas(true)

			local var_49_0 = FightModel.instance:getFightParam()

			if arg_49_0._replayMode then
				var_49_0.isReplay = true
				var_49_0.multiplication = Season123HeroGroupModel.instance.multiplication

				Season123HeroGroupController.instance:sendStartAct123Battle(var_49_0.chapterId, var_49_0.episodeId, var_49_0, Season123HeroGroupModel.instance.multiplication, nil, true)
			else
				var_49_0.isReplay = false
				var_49_0.multiplication = 1

				Season123HeroGroupController.instance:sendStartAct123Battle(var_49_0.chapterId, var_49_0.episodeId, var_49_0, 1)
			end

			AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
		end
	else
		logError("没选中关卡，无法开始战斗")
	end
end

function var_0_0._onUseRecommendGroup(arg_50_0)
	if arg_50_0._replayMode then
		arg_50_0._replayMode = false

		arg_50_0:_refreshBtns()
		arg_50_0:_switchReplayGroup()
	end
end

function var_0_0._refreshBtns(arg_51_0)
	gohelper.setActive(arg_51_0._goreplaybtn, arg_51_0._replayMode)
	gohelper.setActive(arg_51_0._dropseasonherogroup.gameObject, not arg_51_0._replayMode)
	gohelper.setActive(arg_51_0._gocost, arg_51_0._replayMode)
	gohelper.setActive(arg_51_0._btnseasonreplay, not arg_51_0._replayMode)
	gohelper.setActive(arg_51_0._btnstartseason, not arg_51_0._replayMode)
	gohelper.setActive(arg_51_0._btnstartseasonreplay, arg_51_0._replayMode)
end

function var_0_0._onGetFightRecordGroupReply(arg_52_0, arg_52_1)
	arg_52_0:removeEventCb(FightController.instance, FightEvent.RespGetFightRecordGroupReply, arg_52_0._onGetFightRecordGroupReply, arg_52_0)
	Season123HeroGroupController.processReplayGroupMO(arg_52_1)

	arg_52_0._replayFightGroupMO = arg_52_1

	if not arg_52_0._replayMode then
		return
	end

	arg_52_0:_switchReplayGroup()
	arg_52_0:_updateReplayHeroGroup()
end

function var_0_0._updateReplayHeroGroup(arg_53_0)
	HeroGroupModel.instance:setReplayParam(arg_53_0._replayFightGroupMO)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, arg_53_0._replayFightGroupMO.id)
	arg_53_0:_refreshCloth()
	gohelper.setActive(arg_53_0._goherogroupcontain, false)
	gohelper.setActive(arg_53_0._goherogroupcontain, true)
	Season123Controller.instance:dispatchEvent(Season123Event.RecordRspMainCardRefresh)
end

function var_0_0._playHeroGroupExitEffect(arg_54_0)
	arg_54_0._anim:Play("close", 0, 0)
	arg_54_0._btnContainAnim:Play("close", 0, 0)
end

function var_0_0._playCloseHeroGroupAnimation(arg_55_0)
	arg_55_0._anim:Play("close", 0, 0)
	arg_55_0._btnContainAnim:Play("close", 0, 0)

	arg_55_0._heroContainAnim.enabled = true

	arg_55_0._heroContainAnim:Play("herogroupcontain_out", 0, 0)
	TaskDispatcher.runDelay(arg_55_0._closeHeroContainAnim, arg_55_0, 0.133)
end

function var_0_0._closeHeroContainAnim(arg_56_0)
	if arg_56_0._heroContainAnim then
		arg_56_0._heroContainAnim.enabled = false
	end
end

return var_0_0
