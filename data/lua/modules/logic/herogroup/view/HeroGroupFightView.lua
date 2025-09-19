module("modules.logic.herogroup.view.HeroGroupFightView", package.seeall)

local var_0_0 = class("HeroGroupFightView", BaseView)
local var_0_1 = 4

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/btnContain/horizontal/btnStart")
	arg_1_0._btnBalanceStart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/btnContain/horizontal/btnBalance")
	arg_1_0._btnUnPowerBalanceStart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/btnContain/horizontal/btnUnPowerBalance")
	arg_1_0._btnstarthard = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/btnContain/horizontal/btnStartHard")
	arg_1_0._btnstartreplay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/btnContain/horizontal/btnStartReplay")
	arg_1_0._goreplaybtnframe = gohelper.findChild(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn/replayAnimRoot/#go_replaybtnframe")
	arg_1_0._goReplayBtn = gohelper.findChild(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn")
	arg_1_0._btnReplay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn/replayAnimRoot/btnReplay")
	arg_1_0._imagereplayicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn/replayAnimRoot/btnReplay/#image_replayicon")
	arg_1_0._imgbtnReplayBg = gohelper.findChildImage(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn/replayAnimRoot/btnReplay/#image_replaybg")
	arg_1_0._goreplayready = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_replayready")
	arg_1_0._btnmultispeed = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn/replayAnimRoot/#btn_multispeed")
	arg_1_0._txtmultispeed = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn/replayAnimRoot/#btn_multispeed/Label")
	arg_1_0._btnclosemult = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closemult")
	arg_1_0._gomultPos = gohelper.findChild(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn/replayAnimRoot/#btn_multispeed/#go_multpos")
	arg_1_0._gomultispeed = gohelper.findChild(arg_1_0.viewGO, "#go_multispeed")
	arg_1_0._gomultContent = gohelper.findChild(arg_1_0.viewGO, "#go_multispeed/Viewport/Content")
	arg_1_0._gomultitem = gohelper.findChild(arg_1_0.viewGO, "#go_multispeed/Viewport/Content/#go_multitem")
	arg_1_0._simagereplayframe = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_container/#go_replayready/#simage_replayframe")
	arg_1_0._btncloth = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/btnContain/btnCloth")
	arg_1_0._goclothbg = gohelper.findChild(arg_1_0.viewGO, "#go_container/btnContain/btnCloth/bg")
	arg_1_0._txtclothname = gohelper.findChildText(arg_1_0.viewGO, "#go_container/btnContain/btnCloth/bg/#txt_clothName")
	arg_1_0._txtclothnameen = gohelper.findChildText(arg_1_0.viewGO, "#go_container/btnContain/btnCloth/bg/#txt_clothName/#txt_clothNameEn")
	arg_1_0._btncareerrestrain = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/#go_topbtns/#btn_RestraintInfo")
	arg_1_0._btnrecommend = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/#go_topbtns/btn_recommend")
	arg_1_0._btnTry = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/#go_topbtns/btn_Try")
	arg_1_0._goRecommendEffect = gohelper.findChild(arg_1_0.viewGO, "#go_container/btnContain/#go_topbtns/btn_recommend/recommend")
	arg_1_0._gocost = gohelper.findChild(arg_1_0.viewGO, "#go_container/btnContain/#go_cost")
	arg_1_0._gopower = gohelper.findChild(arg_1_0.viewGO, "#go_container/btnContain/#go_cost/#go_power")
	arg_1_0._simagepower = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_container/btnContain/#go_cost/#go_power/#simage_power")
	arg_1_0._txtusepower = gohelper.findChildText(arg_1_0.viewGO, "#go_container/btnContain/#go_cost/#go_power/#txt_usepower")
	arg_1_0._gopowercontent = gohelper.findChild(arg_1_0.viewGO, "#go_righttop/#go_power")
	arg_1_0._gofightCount = gohelper.findChild(arg_1_0.viewGO, "#go_righttop/fightcount")
	arg_1_0._txtfightCount = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_righttop/fightcount/#txt_fightcount")
	arg_1_0._gomask = gohelper.findChild(arg_1_0.viewGO, "#go_container2/#go_mask")
	arg_1_0._gocontainer = gohelper.findChild(arg_1_0.viewGO, "#go_container")
	arg_1_0._gocontainer2 = gohelper.findChild(arg_1_0.viewGO, "#go_container2")
	arg_1_0._txtreplaycn = gohelper.findChildText(arg_1_0.viewGO, "#go_container/btnContain/horizontal/btnStartReplay/#txt_replaycn")
	arg_1_0._gotopbtns = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_topbtns")
	arg_1_0._btnunpowerstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/btnContain/horizontal/btnUnPowerStart")
	arg_1_0._btnunpowerreplay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/btnContain/horizontal/btnUnPowerReplay")
	arg_1_0._btnhardreplay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/btnContain/horizontal/btnHardReplay")
	arg_1_0._txtreplayhardcn = gohelper.findChildText(arg_1_0.viewGO, "#go_container/btnContain/horizontal/btnHardReplay/#txt_replayhardcn")
	arg_1_0._txtreplayunpowercn = gohelper.findChildText(arg_1_0.viewGO, "#go_container/btnContain/horizontal/btnUnPowerReplay/#txt_replayunpowercn")
	arg_1_0._gonormallackpower = gohelper.findChild(arg_1_0.viewGO, "#go_container/btnContain/#go_normallackpower")
	arg_1_0._goreplaylackpower = gohelper.findChild(arg_1_0.viewGO, "#go_container/btnContain/#go_replaylackpower")
	arg_1_0._gospace = gohelper.findChild(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#go_space")
	arg_1_0._goTrialTips = gohelper.findChild(arg_1_0.viewGO, "#go_container/trialContainer/#go_trialTips")
	arg_1_0._goTrialTipsBg = gohelper.findChild(arg_1_0.viewGO, "#go_container/trialContainer/#go_trialTips/#go_tipsbg")
	arg_1_0._goTrialTipsItem = gohelper.findChild(arg_1_0.viewGO, "#go_container/trialContainer/#go_trialTips/#go_tipsbg/#go_tipsitem")
	arg_1_0._btnTrialTips = gohelper.findChildButton(arg_1_0.viewGO, "#go_container/trialContainer/#go_trialTips/#btn_tips")
	arg_1_0._btnSwitchBalance = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#btn_switchBalance")
	arg_1_0._goBalanceEnter = gohelper.findChild(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#btn_switchBalance/#btn_enter")
	arg_1_0._goBalanceExit = gohelper.findChild(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#btn_switchBalance/#btn_exit")
	arg_1_0._dropherogroup = gohelper.findChildDropdown(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#drop_herogroup")
	arg_1_0._btnmodifyname = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#drop_herogroup/#btn_changename")
	arg_1_0._dropherogrouparrow = gohelper.findChild(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#drop_herogroup/arrow").transform
	arg_1_0._btncoststart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/btnContain/horizontal/btnCostStart")
	arg_1_0._txtCostNum = gohelper.findChildText(arg_1_0.viewGO, "#go_container/btnContain/horizontal/btnCostStart/#txt_num")
	arg_1_0._btncostreplay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/btnContain/horizontal/btnCostReplay")
	arg_1_0._txtreplaycostcn = gohelper.findChildText(arg_1_0.viewGO, "#go_container/btnContain/horizontal/btnCostReplay/#txt_replaycostcn")
	arg_1_0._txtReplayCostNum = gohelper.findChildText(arg_1_0.viewGO, "#go_container/btnContain/horizontal/btnCostReplay/#txt_num")
	arg_1_0._godoubledroptimes = gohelper.findChild(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#go_doubletimes")
	arg_1_0._txtdoubledroptimes = gohelper.findChildText(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#go_doubletimes/#txt_doubletimes")
	arg_1_0._gomemorytimes = gohelper.findChild(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn/replayAnimRoot/#go_memorytimes")
	arg_1_0._txtmemorytimes = gohelper.findChildText(arg_1_0.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn/replayAnimRoot/#go_memorytimes/bg/#txt_memorytimes")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnTrialTips:AddClickListener(arg_2_0._switchTrialTips, arg_2_0)
	arg_2_0._btnSwitchBalance:AddClickListener(arg_2_0._btnSwitchBalanceOnClick, arg_2_0)
	arg_2_0._btnstart:AddClickListener(arg_2_0._onClickStart, arg_2_0)
	arg_2_0._btnstarthard:AddClickListener(arg_2_0._onClickStart, arg_2_0)
	arg_2_0._btnstartreplay:AddClickListener(arg_2_0._onClickStart, arg_2_0)
	arg_2_0._btnReplay:AddClickListener(arg_2_0._onClickReplay, arg_2_0)
	arg_2_0._btncloth:AddClickListener(arg_2_0._btnclothOnClock, arg_2_0)
	arg_2_0._btncareerrestrain:AddClickListener(arg_2_0._btncareerrestrainOnClick, arg_2_0)
	arg_2_0._btnrecommend:AddClickListener(arg_2_0._btnrecommendOnClick, arg_2_0)

	if arg_2_0._btnTry then
		arg_2_0._btnTry:AddClickListener(arg_2_0._btnTryOnClick, arg_2_0)
	end

	arg_2_0._btnunpowerstart:AddClickListener(arg_2_0._onClickStart, arg_2_0)
	arg_2_0._btncoststart:AddClickListener(arg_2_0._onClickStart, arg_2_0)
	arg_2_0._btnBalanceStart:AddClickListener(arg_2_0._onClickStart, arg_2_0)
	arg_2_0._btnUnPowerBalanceStart:AddClickListener(arg_2_0._onClickStart, arg_2_0)
	arg_2_0._btnunpowerreplay:AddClickListener(arg_2_0._onClickStart, arg_2_0)
	arg_2_0._btncostreplay:AddClickListener(arg_2_0._onClickStart, arg_2_0)
	arg_2_0._btnhardreplay:AddClickListener(arg_2_0._onClickStart, arg_2_0)
	arg_2_0._btnmultispeed:AddClickListener(arg_2_0._openmultcontent, arg_2_0)
	arg_2_0._btnclosemult:AddClickListener(arg_2_0._closemultcontent, arg_2_0)
	arg_2_0._btnmodifyname:AddClickListener(arg_2_0._modifyName, arg_2_0)
	arg_2_0:addEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreen, arg_2_0._onTouch, arg_2_0)
	arg_2_0._dropherogroup:AddOnValueChanged(arg_2_0._groupDropValueChanged, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreen, arg_3_0._onTouch, arg_3_0)
	arg_3_0._btnTrialTips:RemoveClickListener()
	arg_3_0._btnSwitchBalance:RemoveClickListener()
	arg_3_0._btnstart:RemoveClickListener()
	arg_3_0._btnBalanceStart:RemoveClickListener()
	arg_3_0._btnUnPowerBalanceStart:RemoveClickListener()
	arg_3_0._btnstarthard:RemoveClickListener()
	arg_3_0._btnstartreplay:RemoveClickListener()
	arg_3_0._btnReplay:RemoveClickListener()
	arg_3_0._btncloth:RemoveClickListener()
	arg_3_0._btncareerrestrain:RemoveClickListener()
	arg_3_0._btnrecommend:RemoveClickListener()

	if arg_3_0._btnTry then
		arg_3_0._btnTry:RemoveClickListener()
	end

	arg_3_0._btnunpowerstart:RemoveClickListener()
	arg_3_0._btnunpowerreplay:RemoveClickListener()
	arg_3_0._btncoststart:RemoveClickListener()
	arg_3_0._btncostreplay:RemoveClickListener()
	arg_3_0._btnhardreplay:RemoveClickListener()
	arg_3_0._btnmultispeed:RemoveClickListener()
	arg_3_0._btnclosemult:RemoveClickListener()
	arg_3_0._btnmodifyname:RemoveClickListener()
	arg_3_0._dropherogroup:RemoveOnValueChanged()
	arg_3_0:removeEventCb(FightController.instance, FightEvent.RespGetFightRecordGroupReply, arg_3_0._onGetFightRecordGroupReply, arg_3_0)
end

function var_0_0._openmultcontent(arg_4_0)
	gohelper.setActive(arg_4_0._gomultispeed, not arg_4_0._gomultispeed.activeSelf)

	arg_4_0._gomultispeed.transform.position = arg_4_0._gomultPos.transform.position
end

function var_0_0._closemultcontent(arg_5_0)
	gohelper.setActive(arg_5_0._gomultispeed, false)
end

function var_0_0._btnSwitchBalanceOnClick(arg_6_0)
	HeroGroupBalanceHelper.switchBalanceMode()
	HeroGroupModel.instance:setParam(HeroGroupModel.instance.battleId, HeroGroupModel.instance.episodeId, HeroGroupModel.instance.adventure)
	arg_6_0.viewContainer:dispatchEvent(HeroGroupEvent.SwitchBalance)
	gohelper.setActive(arg_6_0._goBalanceEnter, not HeroGroupBalanceHelper.getIsBalanceMode())
	gohelper.setActive(arg_6_0._goBalanceExit, HeroGroupBalanceHelper.getIsBalanceMode())

	if arg_6_0._replayMode then
		arg_6_0:_closemultcontent()

		arg_6_0._replayMode = false
		arg_6_0._multiplication = 1

		arg_6_0:_refreshCost(true)
		arg_6_0:_switchReplayGroup()
	else
		gohelper.setActive(arg_6_0._goherogroupcontain, false)
		gohelper.setActive(arg_6_0._goherogroupcontain, true)
		arg_6_0:_refreshUI()
	end

	arg_6_0.viewContainer:refreshHelpBtnIcon()
	arg_6_0:isShowHelpBtnIcon()
	arg_6_0:_initFightGroupDrop()

	if HeroGroupBalanceHelper.getIsBalanceMode() then
		ViewMgr.instance:openView(ViewName.HeroGroupBalanceTipView)
	end
end

function var_0_0._btnclothOnClock(arg_7_0)
	if HeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill) or PlayerClothModel.instance:getSpEpisodeClothID() then
		ViewMgr.instance:openView(ViewName.PlayerClothView)
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.LeadRoleSkill))
	end
end

function var_0_0._btncareerrestrainOnClick(arg_8_0)
	ViewMgr.instance:openView(ViewName.HeroGroupCareerTipView)
end

function var_0_0._btnrecommendOnClick(arg_9_0)
	FightFailRecommendController.instance:onClickRecommend()
	arg_9_0:_udpateRecommendEffect()

	if arg_9_0._chapterConfig.type == DungeonEnum.ChapterType.WeekWalk then
		local var_9_0 = WeekWalkModel.instance:getBattleElementId()

		WeekwalkRpc.instance:sendWeekwalkHeroRecommendRequest(var_9_0, arg_9_0._receiveRecommend, arg_9_0)

		return
	end

	if arg_9_0._chapterConfig.type == DungeonEnum.ChapterType.WeekWalk_2 then
		local var_9_1 = WeekWalk_2Model.instance:getBattleElementId()

		Weekwalk_2Rpc.instance:sendWeekwalkVer2HeroRecommendRequest(var_9_1, WeekWalk_2Model.instance:getCurMapId(), arg_9_0._receiveRecommend, arg_9_0)

		return
	end

	DungeonRpc.instance:sendGetEpisodeHeroRecommendRequest(arg_9_0._episodeId, arg_9_0._receiveRecommend, arg_9_0)
end

function var_0_0._btnTryOnClick(arg_10_0)
	local var_10_0 = arg_10_0:_getTryoutCharacter()

	if not var_10_0 then
		return
	end

	ViewMgr.instance:openView(ViewName.CommonTrialHeroDetailView, {
		heroId = var_10_0
	})
end

function var_0_0._getTryoutCharacter(arg_11_0)
	if arg_11_0._chapterConfig.actId <= 0 then
		return
	end

	local var_11_0 = ActivityConfig.instance:getActivityCo(arg_11_0._chapterConfig.actId)

	if not var_11_0 or var_11_0.tryoutcharacter <= 0 then
		return
	end

	return var_11_0.tryoutcharacter
end

function var_0_0._receiveRecommend(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_2 ~= 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.HeroGroupRecommendView, arg_12_3)
end

function var_0_0._editableInitView(arg_13_0)
	var_0_1 = CommonConfig.instance:getConstNum(ConstEnum.MaxMultiplication) or var_0_1
	arg_13_0._multiplication = 1
	arg_13_0._goherogroupcontain = gohelper.findChild(arg_13_0.viewGO, "herogroupcontain")
	arg_13_0._goBtnContain = gohelper.findChild(arg_13_0.viewGO, "#go_container/btnContain")
	arg_13_0._btnContainAnim = arg_13_0._goBtnContain:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(arg_13_0._gomask, false)
	arg_13_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullView, arg_13_0._onOpenFullView, arg_13_0)
	arg_13_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_13_0._onCloseView, arg_13_0)
	arg_13_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_13_0._onModifyHeroGroup, arg_13_0)
	arg_13_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyGroupName, arg_13_0._initFightGroupDrop, arg_13_0)
	arg_13_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_13_0._onModifySnapshot, arg_13_0)
	arg_13_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroGroupItem, arg_13_0._onClickHeroGroupItem, arg_13_0)
	arg_13_0:addEventCb(FightController.instance, FightEvent.RespBeginFight, arg_13_0._respBeginFight, arg_13_0)
	arg_13_0:addEventCb(HelpController.instance, HelpEvent.RefreshHelp, arg_13_0.isShowHelpBtnIcon, arg_13_0)
	arg_13_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnUseRecommendGroup, arg_13_0._onUseRecommendGroup, arg_13_0)
	arg_13_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_13_0._onCurrencyChange, arg_13_0)
	arg_13_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.ShowGuideDragEffect, arg_13_0._showGuideDragEffect, arg_13_0)
	arg_13_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnUpdateRecommendLevel, arg_13_0._refreshTips, arg_13_0)
	arg_13_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.HeroMoveForward, arg_13_0._heroMoveForward, arg_13_0)
	arg_13_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshDoubleDropInfo, arg_13_0.refreshDoubleDropTips, arg_13_0)

	if BossRushController.instance:isInBossRushFight() then
		gohelper.addUIClickAudio(arg_13_0._btnstart.gameObject, AudioEnum.ui_formation.play_ui_formation_action)
		gohelper.addUIClickAudio(arg_13_0._btnstarthard.gameObject, AudioEnum.ui_formation.play_ui_formation_action)
		gohelper.addUIClickAudio(arg_13_0._btnstartreplay.gameObject, AudioEnum.ui_formation.play_ui_formation_action)
	else
		gohelper.addUIClickAudio(arg_13_0._btnstart.gameObject, AudioEnum.HeroGroupUI.Play_UI_Formation_Action)
		gohelper.addUIClickAudio(arg_13_0._btnstarthard.gameObject, AudioEnum.HeroGroupUI.Play_UI_Formation_Action)
		gohelper.addUIClickAudio(arg_13_0._btnstartreplay.gameObject, AudioEnum.HeroGroupUI.Play_UI_Formation_Action)
	end

	gohelper.addUIClickAudio(arg_13_0._btnReplay.gameObject, AudioEnum.UI.Play_UI_Player_Interface_Close)

	arg_13_0._goclothbg = gohelper.findChild(arg_13_0.viewGO, "#go_container/btnContain/btnCloth/bg")

	if arg_13_0._goclothbg then
		arg_13_0._iconGO = arg_13_0:getResInst(arg_13_0.viewContainer:getSetting().otherRes[1], arg_13_0._goclothbg.gameObject)
		gohelper.onceAddComponent(arg_13_0._iconGO, typeof(UnityEngine.UI.LayoutElement)).ignoreLayout = true
		arg_13_0._iconGO.transform.anchorMin = Vector2.up
		arg_13_0._iconGO.transform.anchorMax = Vector2.up
		arg_13_0._iconGO.transform.pivot = Vector2.up

		recthelper.setAnchor(arg_13_0._iconGO.transform, -90, 70)
	end

	arg_13_0._tweeningId = 0
	arg_13_0._replayMode = false
	arg_13_0._multSpeedItems = {}

	local var_13_0 = arg_13_0._gomultContent.transform

	for iter_13_0 = 1, var_0_1 do
		local var_13_1 = var_13_0:GetChild(iter_13_0 - 1)

		arg_13_0:_setMultSpeedItem(var_13_1.gameObject, var_0_1 - iter_13_0 + 1)
	end

	gohelper.setActive(arg_13_0._gomultispeed, false)
	arg_13_0._simagereplayframe:LoadImage(ResUrl.getHeroGroupBg("fuxian_zhegai"))
end

function var_0_0._setMultSpeedItem(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = gohelper.findChild(arg_14_1, "line")
	local var_14_1 = gohelper.findChildTextMesh(arg_14_1, "num")
	local var_14_2 = gohelper.findChild(arg_14_1, "selecticon")

	arg_14_0:addClickCb(gohelper.getClick(arg_14_1), arg_14_0.setMultSpeed, arg_14_0, arg_14_2)

	var_14_1.text = luaLang("multiple") .. arg_14_2

	gohelper.setActive(var_14_0, arg_14_2 ~= var_0_1)

	arg_14_0._multSpeedItems[arg_14_2] = arg_14_0:getUserDataTb_()
	arg_14_0._multSpeedItems[arg_14_2].num = var_14_1
	arg_14_0._multSpeedItems[arg_14_2].selecticon = var_14_2
end

local var_0_2 = GameUtil.parseColor("#efb785")
local var_0_3 = GameUtil.parseColor("#C3BEB6")

function var_0_0.setMultSpeed(arg_15_0, arg_15_1)
	for iter_15_0 = 1, var_0_1 do
		arg_15_0._multSpeedItems[iter_15_0].num.color = arg_15_1 == iter_15_0 and var_0_2 or var_0_3

		gohelper.setActive(arg_15_0._multSpeedItems[iter_15_0].selecticon, arg_15_1 == iter_15_0)
	end

	arg_15_0._txtmultispeed.text = luaLang("multiple") .. arg_15_1
	arg_15_0._multiplication = arg_15_1

	PlayerPrefsHelper.setNumber(arg_15_0:_getMultiplicationKey(), arg_15_0._multiplication)
	arg_15_0:_refreshUI()
	arg_15_0:_refreshTips()

	local var_15_0 = formatLuaLang("herogroupview_replaycn", GameUtil.getNum2Chinese(arg_15_0._multiplication))

	arg_15_0._txtreplaycn.text = var_15_0
	arg_15_0._txtreplayhardcn.text = var_15_0
	arg_15_0._txtreplayunpowercn.text = var_15_0
	arg_15_0._txtreplaycostcn.text = var_15_0

	arg_15_0:_refreshPowerShow()
	arg_15_0:_closemultcontent()
end

function var_0_0._heroMoveForward(arg_16_0, arg_16_1)
	HeroGroupEditListModel.instance:setMoveHeroId(tonumber(arg_16_1))
end

function var_0_0.isReplayMode(arg_17_0)
	return arg_17_0._replayMode
end

function var_0_0._onCurrencyChange(arg_18_0, arg_18_1)
	if not arg_18_1[CurrencyEnum.CurrencyType.Power] then
		return
	end

	arg_18_0:_refreshCostPower()
end

function var_0_0._respBeginFight(arg_19_0)
	gohelper.setActive(arg_19_0._gomask, true)
end

function var_0_0._onOpenFullView(arg_20_0, arg_20_1)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
end

function var_0_0._onCloseView(arg_21_0, arg_21_1)
	if arg_21_1 == ViewName.EquipInfoTeamShowView then
		arg_21_0:_checkFirstPosHasEquip()
	end
end

function var_0_0.onOpen(arg_22_0)
	if HeroGroupBalanceHelper.getIsBalanceMode() then
		ViewMgr.instance:openView(ViewName.HeroGroupBalanceTipView)
	end

	HeroGroupTrialModel.instance:setTrialByBattleId(HeroGroupModel.instance.battleId)
	arg_22_0:_checkFirstPosHasEquip()
	arg_22_0:_checkEquipClothSkill()
	gohelper.setActive(arg_22_0._btnSwitchBalance, HeroGroupBalanceHelper.canShowBalanceSwitchBtn())
	gohelper.setActive(arg_22_0._goBalanceEnter, not HeroGroupBalanceHelper.getIsBalanceMode())
	gohelper.setActive(arg_22_0._goBalanceExit, HeroGroupBalanceHelper.getIsBalanceMode())
	arg_22_0:_refreshUI()
	gohelper.addUIClickAudio(arg_22_0._btncareerrestrain.gameObject, AudioEnum.UI.Play_UI_Tipsopen)
	NavigateMgr.instance:addEscape(arg_22_0.viewName, arg_22_0._onEscapeBtnClick, arg_22_0)
	arg_22_0:isShowHelpBtnIcon()
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Action_Cardsopen)

	local var_22_0 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay)
	local var_22_1 = DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId)
	local var_22_2 = var_22_1 and var_22_1.star == DungeonEnum.StarType.Advanced and var_22_1.hasRecord
	local var_22_3 = PlayerPrefsHelper.getString(FightModel.getPrefsKeyFightPassModel(), "")

	if var_22_0 and var_22_2 and not string.nilorempty(var_22_3) and arg_22_0.episodeConfig and arg_22_0.episodeConfig.canUseRecord == 1 and cjson.decode(var_22_3)[tostring(arg_22_0._episodeId)] and not arg_22_0._replayMode then
		arg_22_0._replayMode = true
		arg_22_0._multiplication = PlayerPrefsHelper.getNumber(arg_22_0:_getMultiplicationKey(), 1)

		arg_22_0:_refreshCost(true)

		arg_22_0._replayFightGroupMO = HeroGroupModel.instance:getReplayParam()

		if not arg_22_0._replayFightGroupMO then
			arg_22_0:addEventCb(FightController.instance, FightEvent.RespGetFightRecordGroupReply, arg_22_0._onGetFightRecordGroupReply, arg_22_0)
			FightRpc.instance:sendGetFightRecordGroupRequest(HeroGroupModel.instance.episodeId)
		else
			arg_22_0:_switchReplayGroup()
		end
	end

	arg_22_0:setMultSpeed(arg_22_0._multiplication)
	gohelper.setActive(arg_22_0._goreplaybtnframe, arg_22_0._replayMode)
	arg_22_0:_dispatchGuideEvent()

	arg_22_0._dropgroupchildcount = arg_22_0._dropherogroup.transform.childCount

	arg_22_0:_refreshReplay()
	arg_22_0:_refreshTips()
	arg_22_0:_refreshPowerShow()
	arg_22_0:_udpateRecommendEffect()
	FightHelper.detectAttributeCounter()
	arg_22_0:_initFightGroupDrop()

	if arg_22_0._goTrialTips.activeSelf and not BossRushModel.instance:isSpecialLayerCurBattle() then
		gohelper.setActive(arg_22_0._goTrialTipsBg, true)
	end

	if arg_22_0._chapterConfig.type == DungeonEnum.ChapterType.TrialHero then
		local var_22_4 = arg_22_0:_getTryoutCharacter()

		if not var_22_4 then
			return
		end

		if GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.HeroGroupFightView_TrialHeroAlert .. var_22_4, "0") == "0" then
			GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.HeroGroupFightView_TrialHeroAlert .. var_22_4, "1")
			TaskDispatcher.runDelay(arg_22_0._btnTryOnClick, arg_22_0, 0.5)
		end
	end
end

function var_0_0.refreshFightCount(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0:_getfreeCount()

	if var_23_0 > 0 then
		local var_23_1 = math.min(var_23_0, arg_23_0._multiplication)

		arg_23_0._txtfightCount.text = string.format("%s<color=#E45A57> -%s</color>", var_23_0, var_23_1)
	end

	gohelper.setActive(arg_23_0._gofightCount, var_23_0 > 0)

	if arg_23_1 then
		recthelper.setAnchorX(arg_23_0._gofightCount.transform, -410)
	else
		recthelper.setAnchorX(arg_23_0._gofightCount.transform, -196)
	end
end

function var_0_0.onOpenFinish(arg_24_0)
	arg_24_0:_dispatchGuideEventOnOpenFinish()
end

function var_0_0._setTrialNumTips(arg_25_0)
	local var_25_0, var_25_1 = var_0_0._getEpisodeConfigAndBattleConfig()
	local var_25_2 = {}
	local var_25_3 = HeroGroupTrialModel.instance:getLimitNum() or 0

	if var_25_3 > 0 then
		if var_25_3 >= 4 then
			var_25_2[1] = luaLang("herogroup_trial_tip")
		else
			var_25_2[1] = formatLuaLang("herogroup_trial_limit_tip", var_25_3)
		end
	end

	if var_25_1 and not string.nilorempty(var_25_1.trialEquips) then
		table.insert(var_25_2, luaLang("herogroup_trial_equip_tip"))
	end

	gohelper.setActive(arg_25_0._goTrialTips, #var_25_2 > 0)

	if #var_25_2 > 0 then
		gohelper.CreateObjList(arg_25_0, arg_25_0._setTrialTipsTxt, var_25_2, arg_25_0._goTrialTipsBg, arg_25_0._goTrialTipsItem)
	end
end

function var_0_0._onTouch(arg_26_0)
	if arg_26_0._goTrialTips.activeSelf and arg_26_0._clickTrialFrame ~= UnityEngine.Time.frameCount and not ViewMgr.instance:isOpen(ViewName.HeroGroupBalanceTipView) then
		gohelper.setActive(arg_26_0._goTrialTipsBg, false)
	end
end

function var_0_0._setTrialTipsTxt(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	gohelper.findChildTextMesh(arg_27_1, "desc").text = arg_27_2
end

function var_0_0._switchTrialTips(arg_28_0)
	gohelper.setActive(arg_28_0._goTrialTipsBg, not arg_28_0._goTrialTipsBg.activeSelf)

	arg_28_0._clickTrialFrame = UnityEngine.Time.frameCount
end

function var_0_0._refreshPowerShow(arg_29_0)
	local var_29_0 = true
	local var_29_1 = HeroGroupModel.instance.episodeId
	local var_29_2 = DungeonConfig.instance:getEpisodeCO(var_29_1)
	local var_29_3 = DungeonConfig.instance:getChapterCO(var_29_2.chapterId)

	if var_29_3 and var_29_3.enterAfterFreeLimit > 0 and DungeonModel.instance:getChapterRemainingNum(var_29_3.type) >= arg_29_0._multiplication then
		var_29_0 = false
	end

	gohelper.setActive(arg_29_0._gopowercontent, var_29_0)
	arg_29_0:refreshFightCount(var_29_0)
end

function var_0_0._getMultiplicationKey(arg_30_0)
	return string.format("%s#%d", PlayerPrefsKey.Multiplication .. PlayerModel.instance:getMyUserId(), arg_30_0._episodeId)
end

function var_0_0._udpateRecommendEffect(arg_31_0)
	gohelper.setActive(arg_31_0._goRecommendEffect, FightFailRecommendController.instance:needShowRecommend(arg_31_0._episodeId))
end

function var_0_0.isShowHelpBtnIcon(arg_32_0)
	local var_32_0 = arg_32_0.viewContainer:getHelpId()

	recthelper.setAnchorX(arg_32_0._gotopbtns.transform, var_32_0 and 568.56 or 419.88)
end

function var_0_0._onEscapeBtnClick(arg_33_0)
	if not arg_33_0._gomask.gameObject.activeInHierarchy then
		arg_33_0.viewContainer:_closeCallback()
	end
end

function var_0_0._getfreeCount(arg_34_0)
	if not arg_34_0._chapterConfig or arg_34_0._chapterConfig.enterAfterFreeLimit <= 0 then
		return 0
	end

	return (DungeonModel.instance:getChapterRemainingNum(arg_34_0._chapterConfig.type))
end

function var_0_0.setGroupChangeToast(arg_35_0, arg_35_1)
	arg_35_0._changeToastId = arg_35_1
end

function var_0_0._groupDropValueChanged(arg_36_0, arg_36_1)
	local var_36_0

	if HeroGroupModel.instance:getGroupTypeName() then
		var_36_0 = arg_36_1
	else
		var_36_0 = arg_36_1 + 1
	end

	gohelper.setActive(arg_36_0._btnmodifyname, var_36_0 ~= 0)

	if HeroGroupModel.instance:setHeroGroupSelectIndex(var_36_0) then
		HeroGroupModel.instance:_setSingleGroup()
		arg_36_0:_checkEquipClothSkill()
		GameFacade.showToast(arg_36_0._changeToastId or ToastEnum.SeasonGroupChanged)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
		gohelper.setActive(arg_36_0._goherogroupcontain, false)
		gohelper.setActive(arg_36_0._goherogroupcontain, true)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyGroupSelectIndex)
	end
end

function var_0_0._initFightGroupDrop(arg_37_0)
	if not arg_37_0:_noAidHero() then
		return
	end

	local var_37_0 = {}

	for iter_37_0 = 1, 4 do
		var_37_0[iter_37_0] = HeroGroupModel.instance:getCommonGroupName(iter_37_0)
	end

	local var_37_1 = HeroGroupModel.instance.curGroupSelectIndex

	gohelper.setActive(arg_37_0._btnmodifyname, var_37_1 ~= 0)

	local var_37_2 = HeroGroupModel.instance:getGroupTypeName()

	if var_37_2 then
		table.insert(var_37_0, 1, var_37_2)
	else
		var_37_1 = var_37_1 - 1
	end

	arg_37_0._dropherogroup:ClearOptions()
	arg_37_0._dropherogroup:AddOptions(var_37_0)
	arg_37_0._dropherogroup:SetValue(var_37_1)
end

function var_0_0._modifyName(arg_38_0)
	ViewMgr.instance:openView(ViewName.HeroGroupModifyNameView)
end

function var_0_0._refreshUI(arg_39_0)
	local var_39_0 = HeroGroupModel.instance:getCurGroupId()

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, var_39_0)

	arg_39_0._episodeId = HeroGroupModel.instance.episodeId
	arg_39_0.episodeConfig = DungeonConfig.instance:getEpisodeCO(arg_39_0._episodeId)
	arg_39_0._chapterConfig = DungeonConfig.instance:getChapterCO(arg_39_0.episodeConfig.chapterId)

	local var_39_1 = arg_39_0:_getfreeCount()

	arg_39_0._enterAfterFreeLimit = var_39_1 - arg_39_0._multiplication >= 0 and var_39_1 - arg_39_0._multiplication or false

	if arg_39_0._btnTry then
		gohelper.setActive(arg_39_0._btnTry, arg_39_0._chapterConfig.type == DungeonEnum.ChapterType.TrialHero)
	end

	gohelper.setActive(arg_39_0._btnrecommend.gameObject, arg_39_0._chapterConfig.isHeroRecommend == 1)
	arg_39_0:_refreshCost(true)
	arg_39_0:_refreshCloth()
	arg_39_0:_setTrialNumTips()
	arg_39_0:refreshDoubleDropTips()
	arg_39_0.viewContainer:setNavigateOverrideClose()
	gohelper.setActive(arg_39_0._goReplayBtn, not HeroGroupBalanceHelper.getIsBalanceMode() and arg_39_0.episodeConfig and arg_39_0.episodeConfig.canUseRecord == 1 and arg_39_0._chapterConfig.type ~= DungeonEnum.ChapterType.WeekWalk)
end

function var_0_0._refreshCost(arg_40_0, arg_40_1)
	gohelper.setActive(arg_40_0._gocost, arg_40_1)

	local var_40_0 = arg_40_0:_getfreeCount()

	gohelper.setActive(arg_40_0._gopower, not arg_40_0._enterAfterFreeLimit)
	gohelper.setActive(arg_40_0._gonormallackpower, false)
	gohelper.setActive(arg_40_0._goreplaylackpower, false)

	if arg_40_0._enterAfterFreeLimit or var_40_0 > 0 then
		local var_40_1 = tostring(-1 * math.min(arg_40_0._multiplication, var_40_0))

		arg_40_0._txtCostNum.text = var_40_1
		arg_40_0._txtReplayCostNum.text = var_40_1

		if var_40_0 >= arg_40_0._multiplication then
			arg_40_0:_refreshBtns(false)

			return
		end
	end

	local var_40_2 = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power)
	local var_40_3 = ResUrl.getCurrencyItemIcon(var_40_2.icon .. "_btn")

	arg_40_0._simagepower:LoadImage(var_40_3)
	arg_40_0:_refreshCostPower()
end

function var_0_0._refreshTips(arg_41_0)
	gohelper.setActive(arg_41_0._btnmultispeed.gameObject, arg_41_0._replayMode)

	arg_41_0._gomultispeed.transform.position = arg_41_0._gomultPos.transform.position
end

function var_0_0._refreshCostPower(arg_42_0)
	local var_42_0 = string.split(arg_42_0.episodeConfig.cost, "|")
	local var_42_1 = string.split(var_42_0[1], "#")
	local var_42_2 = tonumber(var_42_1[3] or 0)
	local var_42_3 = var_42_2 > 0

	if arg_42_0._enterAfterFreeLimit then
		var_42_3 = false
	end

	gohelper.setActive(arg_42_0._gopower, var_42_3)
	arg_42_0:_refreshBtns(var_42_3)

	if not var_42_3 then
		return
	end

	local var_42_4 = var_42_2 * ((arg_42_0._multiplication or 1) - arg_42_0:_getfreeCount())

	arg_42_0._txtusepower.text = string.format("-%s", var_42_4)

	local var_42_5 = arg_42_0._chapterConfig.type == DungeonEnum.ChapterType.Hard

	if var_42_4 <= CurrencyModel.instance:getPower() then
		gohelper.setActive(arg_42_0._gonormallackpower, false)
		gohelper.setActive(arg_42_0._goreplaylackpower, false)

		local var_42_6 = var_42_5 and "#FFFFFF" or "#070706"

		SLFramework.UGUI.GuiHelper.SetColor(arg_42_0._txtusepower, arg_42_0._replayMode and "#070706" or var_42_6)
	else
		local var_42_7 = var_42_5 and "#C44945" or "#800015"

		SLFramework.UGUI.GuiHelper.SetColor(arg_42_0._txtusepower, arg_42_0._replayMode and "#800015" or var_42_7)
		gohelper.setActive(arg_42_0._gonormallackpower, not arg_42_0._replayMode)
		gohelper.setActive(arg_42_0._goreplaylackpower, arg_42_0._replayMode)
	end
end

function var_0_0._dispatchGuideEvent(arg_43_0)
	if arg_43_0._replayMode then
		return
	end

	if not arg_43_0:_isSpType(arg_43_0._chapterConfig.type) then
		if not GuideInvalidCondition.checkAllGroupSetEquip() then
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnEnteryEquipType)
		end

		arg_43_0:_dispatchRecordEvent()
		arg_43_0:_dispatchNoEquipEvent()
	end
end

function var_0_0._dispatchGuideEventOnOpenFinish(arg_44_0)
	if arg_44_0._episodeId then
		local var_44_0 = arg_44_0.episodeConfig.chapterId
		local var_44_1 = arg_44_0.episodeConfig.type

		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OpenHeroGroupFinishWithEpisodeId, arg_44_0._episodeId)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OpenHeroGroupFinishWithChapterId, var_44_0)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OpenHeroGroupFinishWithEpisodeType, var_44_1)
	end
end

function var_0_0._dispatchNoEquipEvent(arg_45_0)
	local var_45_0 = HeroGroupModel.instance:getCurGroupMO()

	for iter_45_0 = 1, 4 do
		local var_45_1 = var_45_0:getPosEquips(iter_45_0 - 1).equipUid[1]

		if EquipModel.instance:getEquip(var_45_1) then
			return
		end
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnEnteryNormalType)
end

function var_0_0._isSpType(arg_46_0, arg_46_1)
	return arg_46_1 == DungeonEnum.ChapterType.Sp or arg_46_1 == DungeonEnum.ChapterType.TeachNote
end

function var_0_0._dispatchRecordEvent(arg_47_0)
	local var_47_0 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightReplay)
	local var_47_1 = DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId)
	local var_47_2 = var_47_1 and var_47_1.hasRecord

	if var_47_0 and var_47_2 then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnHasRecord)
	end
end

function var_0_0.onClose(arg_48_0)
	ViewMgr.instance:closeView(ViewName.CommonTrialHeroDetailView)
	TaskDispatcher.cancelTask(arg_48_0._btnTryOnClick, arg_48_0)
	arg_48_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_48_0._onModifySnapshot, arg_48_0)
	arg_48_0:removeEventCb(HelpController.instance, HelpEvent.RefreshHelp, arg_48_0.isShowHelpBtnIcon, arg_48_0)
	TaskDispatcher.cancelTask(arg_48_0._checkDropArrow, arg_48_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
	ZProj.TweenHelper.KillById(arg_48_0._tweeningId)
	HeroGroupBalanceHelper.clearBalanceStatus()

	if arg_48_0._dragEffectLoader then
		arg_48_0._dragEffectLoader:dispose()

		arg_48_0._dragEffectLoader = nil
	end

	arg_48_0:removeEventCb(HelpController.instance, HelpEvent.RefreshHelp, arg_48_0.isShowHelpBtnIcon, arg_48_0)
end

function var_0_0._refreshReplay(arg_49_0)
	if arg_49_0._chapterConfig.type == DungeonEnum.ChapterType.WeekWalk then
		gohelper.setActive(arg_49_0._goReplayBtn, false)
		gohelper.setActive(arg_49_0._gomemorytimes, false)
	else
		gohelper.setActive(arg_49_0._gomemorytimes, arg_49_0._replayMode)

		local var_49_0 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightReplay)
		local var_49_1 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay)
		local var_49_2 = DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId)
		local var_49_3 = var_49_2 and var_49_2.hasRecord

		ZProj.UGUIHelper.SetColorAlpha(arg_49_0._imgbtnReplayBg, var_49_1 and var_49_3 and 1 or 0.75)

		local var_49_4 = arg_49_0._replayMode and "btn_replay_pause" or "btn_replay_play"

		UISpriteSetMgr.instance:setHeroGroupSprite(arg_49_0._imagereplayicon, var_49_1 and var_49_3 and var_49_4 or "btn_replay_lack")
		recthelper.setWidth(arg_49_0._goReplayBtn.transform, arg_49_0._replayMode and 500 or 83)

		if var_49_0 and var_49_3 and not arg_49_0._replayMode then
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnHasRecord)
		end
	end
end

function var_0_0._refreshCloth(arg_50_0)
	local var_50_0 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.LeadRoleSkill)
	local var_50_1 = HeroGroupModel.instance:getCurGroupMO().clothId

	var_50_1 = PlayerClothModel.instance:getSpEpisodeClothID() or var_50_1

	local var_50_2 = PlayerClothModel.instance:getById(var_50_1)

	gohelper.setActive(arg_50_0._txtclothname.gameObject, var_50_2)

	if var_50_2 then
		local var_50_3 = lua_cloth.configDict[var_50_2.clothId]

		if not var_50_2.level then
			local var_50_4 = 0
		end

		arg_50_0._txtclothname.text = var_50_3.name
		arg_50_0._txtclothnameen.text = var_50_3.enname
	end

	for iter_50_0, iter_50_1 in ipairs(lua_cloth.configList) do
		local var_50_5 = gohelper.findChild(arg_50_0._iconGO, tostring(iter_50_1.id))

		if not gohelper.isNil(var_50_5) then
			gohelper.setActive(var_50_5, iter_50_1.id == var_50_1)
		end
	end

	gohelper.setActive(arg_50_0._btncloth.gameObject, var_0_0.showCloth())
end

function var_0_0._checkEquipClothSkill(arg_51_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill) then
		return
	end

	local var_51_0 = HeroGroupModel.instance:getCurGroupMO()

	if PlayerClothModel.instance:getById(var_51_0.clothId) then
		return
	end

	local var_51_1 = PlayerClothModel.instance:getList()

	for iter_51_0, iter_51_1 in ipairs(var_51_1) do
		if PlayerClothModel.instance:hasCloth(iter_51_1.id) then
			HeroGroupModel.instance:replaceCloth(iter_51_1.id)
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
			HeroGroupModel.instance:saveCurGroupData()

			break
		end
	end
end

function var_0_0._getEpisodeConfigAndBattleConfig()
	local var_52_0 = DungeonConfig.instance:getEpisodeCO(HeroGroupModel.instance.episodeId)
	local var_52_1

	if HeroGroupModel.instance.battleId and HeroGroupModel.instance.battleId > 0 then
		var_52_1 = lua_battle.configDict[HeroGroupModel.instance.battleId]
	else
		var_52_1 = DungeonConfig.instance:getBattleCo(HeroGroupModel.instance.episodeId)
	end

	return var_52_0, var_52_1
end

function var_0_0.showCloth()
	if PlayerClothModel.instance:getSpEpisodeClothID() then
		return true
	end

	if not OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.LeadRoleSkill) then
		return false
	end

	local var_53_0, var_53_1 = var_0_0._getEpisodeConfigAndBattleConfig()

	if var_53_1 and var_53_1.noClothSkill == 1 then
		return false
	end

	local var_53_2 = HeroGroupModel.instance:getCurGroupMO()
	local var_53_3 = PlayerClothModel.instance:getById(var_53_2.clothId)
	local var_53_4 = PlayerClothModel.instance:getList()
	local var_53_5 = false

	for iter_53_0, iter_53_1 in ipairs(var_53_4) do
		var_53_5 = true

		break
	end

	return var_53_5
end

function var_0_0._onModifyHeroGroup(arg_54_0)
	arg_54_0:_refreshCloth()
end

function var_0_0._onModifySnapshot(arg_55_0)
	arg_55_0:_refreshCloth()
end

function var_0_0._onClickHeroGroupItem(arg_56_0, arg_56_1)
	local var_56_0 = HeroGroupModel.instance:getCurGroupMO():getPosEquips(arg_56_1 - 1).equipUid

	arg_56_0._param = {}
	arg_56_0._param.singleGroupMOId = arg_56_1
	arg_56_0._param.originalHeroUid = HeroSingleGroupModel.instance:getHeroUid(arg_56_1)
	arg_56_0._param.adventure = HeroGroupModel.instance:isAdventureOrWeekWalk()
	arg_56_0._param.equips = var_56_0

	arg_56_0:openHeroGroupEditView()
end

function var_0_0.openHeroGroupEditView(arg_57_0)
	ViewMgr.instance:openView(ViewName.HeroGroupEditView, arg_57_0._param)
end

function var_0_0._checkFirstPosHasEquip(arg_58_0)
	local var_58_0 = HeroGroupModel.instance:getCurGroupMO():getPosEquips(0).equipUid
	local var_58_1 = var_58_0 and var_58_0[1]

	if var_58_1 and EquipModel.instance:getEquip(var_58_1) then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnFirstPosHasEquip)
	end
end

function var_0_0._showGuideDragEffect(arg_59_0, arg_59_1)
	if arg_59_0._dragEffectLoader then
		arg_59_0._dragEffectLoader:dispose()

		arg_59_0._dragEffectLoader = nil
	end

	if tonumber(arg_59_1) == 1 then
		arg_59_0._dragEffectLoader = PrefabInstantiate.Create(arg_59_0.viewGO)

		arg_59_0._dragEffectLoader:startLoad("ui/viewres/guide/guide_herogroup.prefab")
	end
end

function var_0_0._onClickStart(arg_60_0)
	local var_60_0 = string.split(arg_60_0.episodeConfig.cost, "|")
	local var_60_1 = string.split(var_60_0[1], "#")
	local var_60_2 = tonumber(var_60_1[3] or 0)
	local var_60_3 = arg_60_0:_getfreeCount()

	if var_60_2 * ((arg_60_0._multiplication or 1) - var_60_3) > CurrencyModel.instance:getPower() then
		CurrencyController.instance:openPowerView()

		return
	end

	local var_60_4 = 10104

	if HeroGroupModel.instance.episodeId == var_60_4 and not DungeonModel.instance:hasPassLevel(var_60_4) then
		local var_60_5 = HeroSingleGroupModel.instance:getList()
		local var_60_6 = 0

		for iter_60_0, iter_60_1 in ipairs(var_60_5) do
			if not iter_60_1:isEmpty() then
				var_60_6 = var_60_6 + 1
			end
		end

		if var_60_6 < 2 then
			GameFacade.showToast(ToastEnum.HeroSingleGroupCount)

			return
		end
	end

	arg_60_0:_closemultcontent()
	arg_60_0:_enterFight()
end

function var_0_0._enterFight(arg_61_0)
	if HeroGroupModel.instance.episodeId then
		arg_61_0._closeWithEnteringFight = true

		if FightController.instance:setFightHeroSingleGroup() then
			arg_61_0.viewContainer:dispatchEvent(HeroGroupEvent.BeforeEnterFight)

			local var_61_0 = FightModel.instance:getFightParam()

			if arg_61_0._replayMode then
				var_61_0.isReplay = true
				var_61_0.multiplication = arg_61_0._multiplication

				DungeonFightController.instance:sendStartDungeonRequest(var_61_0.chapterId, var_61_0.episodeId, var_61_0, arg_61_0._multiplication, nil, true)
			else
				var_61_0.isReplay = false
				var_61_0.multiplication = 1

				DungeonFightController.instance:sendStartDungeonRequest(var_61_0.chapterId, var_61_0.episodeId, var_61_0, 1)
			end

			AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
		end
	else
		logError("没选中关卡，无法开始战斗")
	end
end

function var_0_0._onUseRecommendGroup(arg_62_0)
	if arg_62_0._replayMode then
		arg_62_0:_closemultcontent()

		arg_62_0._replayMode = false
		arg_62_0._multiplication = 1

		arg_62_0:_refreshCost(true)
		arg_62_0:_switchReplayGroup()
	end
end

function var_0_0._onClickReplay(arg_63_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay) then
		local var_63_0, var_63_1 = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.FightReplay)

		GameFacade.showToast(var_63_0, var_63_1)

		return
	end

	if not HeroGroupModel.instance.episodeId then
		return
	end

	local var_63_2 = DungeonConfig.instance:getEpisodeCO(HeroGroupModel.instance.episodeId)
	local var_63_3 = DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId)
	local var_63_4 = var_63_3 and var_63_3.hasRecord
	local var_63_5 = var_63_3 and var_63_3.star == DungeonEnum.StarType.Advanced
	local var_63_6 = var_63_2 and var_63_2.firstBattleId > 0

	if not var_63_4 and var_63_5 and var_63_6 then
		GameFacade.showToast(ToastEnum.CantRecordReplay)

		return
	end

	if var_63_3 and var_63_3.star == DungeonEnum.StarType.Advanced and not var_63_3.hasRecord then
		GameFacade.showToast(ToastEnum.HeroGroupStarAdvanced)

		return
	end

	if not var_63_3 or var_63_3 and var_63_3.star ~= DungeonEnum.StarType.Advanced then
		GameFacade.showToast(ToastEnum.HeroGroupStarNoAdvanced)

		return
	end

	local var_63_7 = arg_63_0._replayMode

	if arg_63_0._replayMode then
		arg_63_0._replayMode = false
		arg_63_0._multiplication = 1

		arg_63_0._btnContainAnim:Play(UIAnimationName.Switch, 0, 0)
		gohelper.setActive(arg_63_0._gomultispeed, false)
	else
		arg_63_0._btnContainAnim:Play(UIAnimationName.Switch, 0, 0)

		arg_63_0._replayMode = true
		arg_63_0._multiplication = 1
	end

	PlayerPrefsHelper.setNumber(arg_63_0:_getMultiplicationKey(), arg_63_0._multiplication)
	arg_63_0:_refreshCost(true)

	if arg_63_0._replayMode and not arg_63_0._replayFightGroupMO then
		arg_63_0:addEventCb(FightController.instance, FightEvent.RespGetFightRecordGroupReply, arg_63_0._onGetFightRecordGroupReply, arg_63_0)
		FightRpc.instance:sendGetFightRecordGroupRequest(HeroGroupModel.instance.episodeId)

		return
	end

	arg_63_0:_switchReplayGroup(var_63_7)
end

function var_0_0._switchReplayGroup(arg_64_0, arg_64_1)
	arg_64_0:_switchReplayMul()
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.PlayHeroGroupHeroEffect, arg_64_0._replayMode and "swicth" or UIAnimationName.Open)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SwitchReplay, arg_64_0._replayMode)
	gohelper.setActive(arg_64_0._gomemorytimes, arg_64_0._replayMode)

	if arg_64_0._replayMode then
		arg_64_0:_updateReplayHeroGorupList()

		local var_64_0 = formatLuaLang("herogroupview_replaycn", GameUtil.getNum2Chinese(arg_64_0._multiplication))

		arg_64_0._txtreplaycn.text = var_64_0
		arg_64_0._txtreplayhardcn.text = var_64_0
		arg_64_0._txtreplayunpowercn.text = var_64_0
		arg_64_0._txtmemorytimes.text = arg_64_0._replayFightGroupMO.recordRound
	else
		HeroGroupModel.instance:setParam(HeroGroupModel.instance.battleId, HeroGroupModel.instance.episodeId, HeroGroupModel.instance.adventure)

		local var_64_1 = HeroGroupModel.instance:getCurGroupMO().id

		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, var_64_1)
		arg_64_0:_refreshCloth()
		gohelper.setActive(arg_64_0._goherogroupcontain, false)
		gohelper.setActive(arg_64_0._goherogroupcontain, true)
	end
end

function var_0_0._switchReplayMul(arg_65_0)
	if arg_65_0._replayMode then
		arg_65_0:setMultSpeed(arg_65_0._multiplication)
	else
		arg_65_0:_refreshUI()
		arg_65_0:_refreshTips()
	end

	arg_65_0:_refreshCost(true)
	arg_65_0:_refreshPowerShow()
	gohelper.setActive(arg_65_0._goreplayready, arg_65_0._replayMode)

	local var_65_0 = arg_65_0:_haveRecord()

	UISpriteSetMgr.instance:setHeroGroupSprite(arg_65_0._imagereplayicon, not var_65_0 and "btn_replay_lack" or arg_65_0._replayMode and "btn_replay_pause" or "btn_replay_play")
	recthelper.setWidth(arg_65_0._goReplayBtn.transform, arg_65_0._replayMode and 500 or 83)
	ZProj.UGUIHelper.RebuildLayout(arg_65_0._goReplayBtn.transform.parent)
	gohelper.setActive(arg_65_0._goreplaybtnframe, arg_65_0._replayMode)

	gohelper.findChildTextMesh(arg_65_0._goreplayready, "tip").color = GameConfig:GetCurLangType() == LangSettings.zh and Color.white or SLFramework.UGUI.GuiHelper.ParseColor("#D6B5B5")
end

function var_0_0._haveRecord(arg_66_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay) then
		return false
	end

	local var_66_0 = DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId)

	if var_66_0 and var_66_0.star == DungeonEnum.StarType.Advanced and not var_66_0.hasRecord then
		return false
	end

	if not var_66_0 or var_66_0 and var_66_0.star ~= DungeonEnum.StarType.Advanced then
		return false
	end

	return true
end

function var_0_0._refreshBtns(arg_67_0, arg_67_1)
	local var_67_0 = HeroGroupBalanceHelper.getIsBalanceMode()

	gohelper.setActive(arg_67_0._btnBalanceStart, var_67_0 and not arg_67_0._replayMode and arg_67_1)
	gohelper.setActive(arg_67_0._btnUnPowerBalanceStart, var_67_0 and not arg_67_0._replayMode and not arg_67_1)

	local var_67_1 = arg_67_0._enterAfterFreeLimit or arg_67_0:_getfreeCount() > 0

	gohelper.setActive(arg_67_0._btnstartreplay.gameObject, arg_67_1 and arg_67_0._replayMode and arg_67_0._chapterConfig.type ~= DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_67_0._btnunpowerreplay.gameObject, not arg_67_1 and not var_67_1 and arg_67_0._replayMode)
	gohelper.setActive(arg_67_0._btnunpowerstart.gameObject, not var_67_0 and not arg_67_1 and not var_67_1 and not arg_67_0._replayMode)
	gohelper.setActive(arg_67_0._btncostreplay.gameObject, not arg_67_1 and var_67_1 and arg_67_0._replayMode)
	gohelper.setActive(arg_67_0._btncoststart.gameObject, not var_67_0 and not arg_67_1 and var_67_1 and not arg_67_0._replayMode)
	gohelper.setActive(arg_67_0._gospace, not arg_67_0._replayMode and arg_67_1)
	gohelper.setActive(arg_67_0._btnhardreplay.gameObject, arg_67_1 and arg_67_0._replayMode and arg_67_0._chapterConfig.type == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_67_0._btnstart.gameObject, not var_67_0 and arg_67_1 and not arg_67_0._replayMode and arg_67_0._chapterConfig.type ~= DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_67_0._btnstarthard.gameObject, not var_67_0 and arg_67_1 and not arg_67_0._replayMode and arg_67_0._chapterConfig.type == DungeonEnum.ChapterType.Hard)

	local var_67_2 = not arg_67_0._replayMode and arg_67_0:_noAidHero()

	gohelper.setActive(arg_67_0._dropherogroup, var_67_2)

	if var_67_2 then
		TaskDispatcher.runRepeat(arg_67_0._checkDropArrow, arg_67_0, 0)
	else
		TaskDispatcher.cancelTask(arg_67_0._checkDropArrow, arg_67_0)
	end
end

function var_0_0._checkDropArrow(arg_68_0)
	if not arg_68_0._dropherogrouparrow then
		TaskDispatcher.cancelTask(arg_68_0._checkDropArrow, arg_68_0)

		return
	end

	local var_68_0 = arg_68_0._dropherogroup.transform.childCount

	if var_68_0 ~= arg_68_0._dropDownChildCount then
		arg_68_0._dropDownChildCount = var_68_0

		local var_68_1 = arg_68_0._dropgroupchildcount ~= var_68_0

		transformhelper.setLocalScale(arg_68_0._dropherogrouparrow, 1, var_68_1 and -1 or 1, 1)
	end
end

function var_0_0._noAidHero(arg_69_0)
	local var_69_0 = HeroGroupModel.instance.battleId
	local var_69_1 = lua_battle.configDict[var_69_0]

	if not var_69_1 then
		return
	end

	if ToughBattleModel.instance:getEpisodeId() then
		return
	end

	return var_69_1.trialLimit <= 0 and string.nilorempty(var_69_1.aid) and string.nilorempty(var_69_1.trialHeros) and string.nilorempty(var_69_1.trialEquips)
end

function var_0_0._onGetFightRecordGroupReply(arg_70_0, arg_70_1)
	arg_70_0:removeEventCb(FightController.instance, FightEvent.RespGetFightRecordGroupReply, arg_70_0._onGetFightRecordGroupReply, arg_70_0)

	arg_70_0._replayFightGroupMO = arg_70_1

	if not arg_70_0._replayMode then
		return
	end

	arg_70_0:_switchReplayGroup()
	arg_70_0:_updateReplayHeroGorupList()
end

function var_0_0._updateReplayHeroGorupList(arg_71_0)
	HeroGroupModel.instance:setReplayParam(arg_71_0._replayFightGroupMO)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, arg_71_0._replayFightGroupMO.id)
	arg_71_0:_refreshCloth()
	gohelper.setActive(arg_71_0._goherogroupcontain, false)
	gohelper.setActive(arg_71_0._goherogroupcontain, true)
end

function var_0_0.refreshDoubleDropTips(arg_72_0)
	local var_72_0, var_72_1, var_72_2 = DoubleDropModel.instance:isShowDoubleByEpisode(arg_72_0._episodeId, true)

	gohelper.setActive(arg_72_0._godoubledroptimes, var_72_0)

	if var_72_0 then
		local var_72_3 = {
			var_72_1,
			var_72_2
		}

		arg_72_0._txtdoubledroptimes.text = GameUtil.getSubPlaceholderLuaLang(luaLang("double_drop_remain_times"), var_72_3)
	end
end

return var_0_0
