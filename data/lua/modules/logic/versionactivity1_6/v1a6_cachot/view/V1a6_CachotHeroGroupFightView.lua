module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotHeroGroupFightView", package.seeall)

local var_0_0 = class("V1a6_CachotHeroGroupFightView", BaseView)
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
	arg_1_0._txtclothname = gohelper.findChildText(arg_1_0.viewGO, "#go_container/btnContain/btnCloth/#txt_clothName")
	arg_1_0._txtclothnameen = gohelper.findChildText(arg_1_0.viewGO, "#go_container/btnContain/btnCloth/#txt_clothName/#txt_clothNameEn")
	arg_1_0._btncareerrestrain = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/#go_topbtns/#btn_RestraintInfo")
	arg_1_0._btnrecommend = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/#go_topbtns/btn_recommend")
	arg_1_0._goRecommendEffect = gohelper.findChild(arg_1_0.viewGO, "#go_container/btnContain/#go_topbtns/btn_recommend/recommend")
	arg_1_0._gocost = gohelper.findChild(arg_1_0.viewGO, "#go_container/btnContain/#go_cost")
	arg_1_0._gopower = gohelper.findChild(arg_1_0.viewGO, "#go_container/btnContain/#go_cost/#go_power")
	arg_1_0._simagepower = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_container/btnContain/#go_cost/#go_power/#simage_power")
	arg_1_0._txtusepower = gohelper.findChildText(arg_1_0.viewGO, "#go_container/btnContain/#go_cost/#go_power/#txt_usepower")
	arg_1_0._gocount = gohelper.findChild(arg_1_0.viewGO, "#go_container/btnContain/#go_cost/#go_count")
	arg_1_0._txtcostcount = gohelper.findChildText(arg_1_0.viewGO, "#go_container/btnContain/#go_cost/#go_count/animroot/#txt_costCount")
	arg_1_0._gopowercontent = gohelper.findChild(arg_1_0.viewGO, "#go_righttop/#go_power")
	arg_1_0._gofightCount = gohelper.findChild(arg_1_0.viewGO, "#go_righttop/fightcount")
	arg_1_0._txtfightCount = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_righttop/fightcount/#txt_fightcount")
	arg_1_0._gomask = gohelper.findChild(arg_1_0.viewGO, "#go_container2/#go_mask")
	arg_1_0._gocontainer = gohelper.findChild(arg_1_0.viewGO, "#go_container")
	arg_1_0._gocontainer2 = gohelper.findChild(arg_1_0.viewGO, "#go_container2")
	arg_1_0._golevelchange = gohelper.findChild(arg_1_0.viewGO, "#go_container/btnContain/#go_levelchange")
	arg_1_0._txtreplaycn = gohelper.findChildText(arg_1_0.viewGO, "#go_container/btnContain/horizontal/btnStartReplay/#txt_replaycn")
	arg_1_0._gotopbtns = gohelper.findChild(arg_1_0.viewGO, "#go_container/#go_topbtns")
	arg_1_0._btnunpowerstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/btnContain/horizontal/btnUnPowerStart")
	arg_1_0._btnunpowerreplay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/btnContain/horizontal/btnUnPowerReplay")
	arg_1_0._btnhardreplay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_container/btnContain/horizontal/btnHardReplay")
	arg_1_0._txtreplayhardcn = gohelper.findChildText(arg_1_0.viewGO, "#go_container/btnContain/horizontal/btnHardReplay/#txt_replayhardcn")
	arg_1_0._txtreplayunpowercn = gohelper.findChildText(arg_1_0.viewGO, "#go_container/btnContain/horizontal/btnUnPowerReplay/#txt_replayunpowercn")
	arg_1_0._gonormallackpower = gohelper.findChild(arg_1_0.viewGO, "#go_container/btnContain/#go_normallackpower")
	arg_1_0._goreplaylackpower = gohelper.findChild(arg_1_0.viewGO, "#go_container/btnContain/#go_replaylackpower")
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
	if V1a6_CachotHeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill) or PlayerClothModel.instance:getSpEpisodeClothID() then
		local var_7_0 = V1a6_CachotHeroGroupModel.instance

		ViewMgr.instance:openView(ViewName.PlayerClothView, {
			groupModel = var_7_0,
			useCallback = var_7_0.cachotSaveCurGroup,
			useCallbackObj = var_7_0
		})
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

	DungeonRpc.instance:sendGetEpisodeHeroRecommendRequest(arg_9_0._episodeId, arg_9_0._receiveRecommend, arg_9_0)
end

function var_0_0._receiveRecommend(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_2 ~= 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.HeroGroupRecommendView, arg_10_3)
end

function var_0_0._editableInitView(arg_11_0)
	var_0_1 = CommonConfig.instance:getConstNum(ConstEnum.MaxMultiplication) or var_0_1
	arg_11_0._multiplication = 1
	arg_11_0._goherogroupcontain = gohelper.findChild(arg_11_0.viewGO, "herogroupcontain")
	arg_11_0._goBtnContain = gohelper.findChild(arg_11_0.viewGO, "#go_container/btnContain")
	arg_11_0._btnContainAnim = arg_11_0._goBtnContain:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(arg_11_0._gomask, false)
	arg_11_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullView, arg_11_0._onOpenFullView, arg_11_0)
	arg_11_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_11_0._onCloseView, arg_11_0)
	arg_11_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_11_0._onModifyHeroGroup, arg_11_0)
	arg_11_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyGroupName, arg_11_0._initFightGroupDrop, arg_11_0)
	arg_11_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_11_0._onModifySnapshot, arg_11_0)
	arg_11_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroGroupItem, arg_11_0._onClickHeroGroupItem, arg_11_0)
	arg_11_0:addEventCb(FightController.instance, FightEvent.RespBeginFight, arg_11_0._respBeginFight, arg_11_0)
	arg_11_0:addEventCb(HelpController.instance, HelpEvent.RefreshHelp, arg_11_0.isShowHelpBtnIcon, arg_11_0)
	arg_11_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnUseRecommendGroup, arg_11_0._onUseRecommendGroup, arg_11_0)
	arg_11_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_11_0._onCurrencyChange, arg_11_0)
	arg_11_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.ShowGuideDragEffect, arg_11_0._showGuideDragEffect, arg_11_0)
	arg_11_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnUpdateRecommendLevel, arg_11_0._refreshTips, arg_11_0)
	arg_11_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.HeroMoveForward, arg_11_0._heroMoveForward, arg_11_0)

	if BossRushController.instance:isInBossRushFight() then
		gohelper.addUIClickAudio(arg_11_0._btnstart.gameObject, AudioEnum.ui_formation.play_ui_formation_action)
		gohelper.addUIClickAudio(arg_11_0._btnstarthard.gameObject, AudioEnum.ui_formation.play_ui_formation_action)
		gohelper.addUIClickAudio(arg_11_0._btnstartreplay.gameObject, AudioEnum.ui_formation.play_ui_formation_action)
	else
		gohelper.addUIClickAudio(arg_11_0._btnstart.gameObject, AudioEnum.HeroGroupUI.Play_UI_Formation_Action)
		gohelper.addUIClickAudio(arg_11_0._btnstarthard.gameObject, AudioEnum.HeroGroupUI.Play_UI_Formation_Action)
		gohelper.addUIClickAudio(arg_11_0._btnstartreplay.gameObject, AudioEnum.HeroGroupUI.Play_UI_Formation_Action)
	end

	gohelper.addUIClickAudio(arg_11_0._btnReplay.gameObject, AudioEnum.UI.Play_UI_Player_Interface_Close)

	arg_11_0._iconGO = arg_11_0:getResInst(arg_11_0.viewContainer:getSetting().otherRes[1], arg_11_0._btncloth.gameObject)

	recthelper.setAnchor(arg_11_0._iconGO.transform, -100, 1)

	arg_11_0._tweeningId = 0
	arg_11_0._replayMode = false
	arg_11_0._multSpeedItems = {}

	gohelper.CreateObjList(arg_11_0, arg_11_0._setMultSpeedItem, {
		4,
		3,
		2,
		1
	}, arg_11_0._gomultContent, arg_11_0._gomultitem)
	gohelper.setActive(arg_11_0._gomultispeed, false)
	arg_11_0._simagereplayframe:LoadImage(ResUrl.getHeroGroupBg("fuxian_zhegai"))
end

function var_0_0._setMultSpeedItem(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = gohelper.findChild(arg_12_1, "line")
	local var_12_1 = gohelper.findChildTextMesh(arg_12_1, "num")
	local var_12_2 = gohelper.findChild(arg_12_1, "selecticon")

	arg_12_0:addClickCb(gohelper.getClick(arg_12_1), arg_12_0.setMultSpeed, arg_12_0, arg_12_2)

	var_12_1.text = luaLang("multiple") .. arg_12_2

	gohelper.setActive(var_12_0, arg_12_2 ~= var_0_1)

	arg_12_0._multSpeedItems[arg_12_2] = arg_12_0:getUserDataTb_()
	arg_12_0._multSpeedItems[arg_12_2].num = var_12_1
	arg_12_0._multSpeedItems[arg_12_2].selecticon = var_12_2
end

local var_0_2 = GameUtil.parseColor("#efb785")
local var_0_3 = GameUtil.parseColor("#C3BEB6")

function var_0_0.setMultSpeed(arg_13_0, arg_13_1)
	for iter_13_0 = 1, var_0_1 do
		arg_13_0._multSpeedItems[iter_13_0].num.color = arg_13_1 == iter_13_0 and var_0_2 or var_0_3

		gohelper.setActive(arg_13_0._multSpeedItems[iter_13_0].selecticon, arg_13_1 == iter_13_0)
	end

	arg_13_0._txtmultispeed.text = luaLang("multiple") .. arg_13_1
	arg_13_0._multiplication = arg_13_1

	PlayerPrefsHelper.setNumber(arg_13_0:_getMultiplicationKey(), arg_13_0._multiplication)
	arg_13_0:_refreshUI()
	arg_13_0:_refreshTips()

	local var_13_0 = formatLuaLang("herogroupview_replaycn", GameUtil.getNum2Chinese(arg_13_0._multiplication))

	arg_13_0._txtreplaycn.text = var_13_0
	arg_13_0._txtreplayhardcn.text = var_13_0
	arg_13_0._txtreplayunpowercn.text = var_13_0
	arg_13_0._txtreplaycostcn.text = var_13_0

	arg_13_0:_refreshPowerShow()
	arg_13_0:_closemultcontent()
end

function var_0_0._heroMoveForward(arg_14_0, arg_14_1)
	HeroGroupEditListModel.instance:setMoveHeroId(tonumber(arg_14_1))
end

function var_0_0.isReplayMode(arg_15_0)
	return arg_15_0._replayMode
end

function var_0_0._onCurrencyChange(arg_16_0, arg_16_1)
	if not arg_16_1[CurrencyEnum.CurrencyType.Power] then
		return
	end

	arg_16_0:_refreshCostPower()
end

function var_0_0._respBeginFight(arg_17_0)
	gohelper.setActive(arg_17_0._gomask, true)
end

function var_0_0._onOpenFullView(arg_18_0, arg_18_1)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
end

function var_0_0._onCloseView(arg_19_0, arg_19_1)
	if arg_19_1 == ViewName.EquipInfoTeamShowView then
		arg_19_0:_checkFirstPosHasEquip()
	end
end

function var_0_0.onOpen(arg_20_0)
	if HeroGroupBalanceHelper.getIsBalanceMode() then
		ViewMgr.instance:openView(ViewName.HeroGroupBalanceTipView)
	end

	HeroGroupTrialModel.instance:setTrialByBattleId(HeroGroupModel.instance.battleId)
	arg_20_0:_checkFirstPosHasEquip()
	arg_20_0:_checkEquipClothSkill()
	gohelper.setActive(arg_20_0._btnSwitchBalance, HeroGroupBalanceHelper.canShowBalanceSwitchBtn())
	gohelper.setActive(arg_20_0._goBalanceEnter, not HeroGroupBalanceHelper.getIsBalanceMode())
	gohelper.setActive(arg_20_0._goBalanceExit, HeroGroupBalanceHelper.getIsBalanceMode())
	arg_20_0:_refreshUI()
	gohelper.addUIClickAudio(arg_20_0._btncareerrestrain.gameObject, AudioEnum.UI.Play_UI_Tipsopen)
	NavigateMgr.instance:addEscape(ViewName.V1a6_CachotHeroGroupFightView, arg_20_0._onEscapeBtnClick, arg_20_0)
	arg_20_0:isShowHelpBtnIcon()
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Action_Cardsopen)

	local var_20_0 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay)
	local var_20_1 = DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId)
	local var_20_2 = var_20_1 and var_20_1.star == DungeonEnum.StarType.Advanced and var_20_1.hasRecord
	local var_20_3 = PlayerPrefsHelper.getString(FightModel.getPrefsKeyFightPassModel(), "")

	if var_20_0 and var_20_2 and not string.nilorempty(var_20_3) and cjson.decode(var_20_3)[tostring(arg_20_0._episodeId)] and not arg_20_0._replayMode then
		arg_20_0._replayMode = true
		arg_20_0._multiplication = PlayerPrefsHelper.getNumber(arg_20_0:_getMultiplicationKey(), 1)

		arg_20_0:_refreshCost(true)

		arg_20_0._replayFightGroupMO = HeroGroupModel.instance:getReplayParam()

		if not arg_20_0._replayFightGroupMO then
			arg_20_0:addEventCb(FightController.instance, FightEvent.RespGetFightRecordGroupReply, arg_20_0._onGetFightRecordGroupReply, arg_20_0)
			FightRpc.instance:sendGetFightRecordGroupRequest(HeroGroupModel.instance.episodeId)
		else
			arg_20_0:_switchReplayGroup()
		end
	end

	arg_20_0:setMultSpeed(arg_20_0._multiplication)
	gohelper.setActive(arg_20_0._goreplaybtnframe, arg_20_0._replayMode)

	local var_20_4 = false
	local var_20_5 = HeroGroupModel.instance.episodeId
	local var_20_6 = DungeonConfig.instance:getEpisodeCO(var_20_5)
	local var_20_7 = DungeonConfig.instance:getChapterCO(var_20_6.chapterId)

	if var_20_7 and var_20_7.enterAfterFreeLimit > 0 then
		local var_20_8 = DungeonModel.instance:getChapterRemainingNum(var_20_7.type)

		if var_20_8 > 0 then
			var_20_4 = true
			arg_20_0._txtfightCount.text = var_20_8
		end
	end

	gohelper.setActive(arg_20_0._gofightCount, var_20_4)

	arg_20_0._dropgroupchildcount = arg_20_0._dropherogroup.transform.childCount

	arg_20_0:_refreshReplay()
	arg_20_0:_refreshTips()
	arg_20_0:_refreshPowerShow()
	arg_20_0:_udpateRecommendEffect()
	FightHelper.detectAttributeCounter()
	arg_20_0:_initFightGroupDrop()

	if arg_20_0._goTrialTips.activeSelf then
		gohelper.setActive(arg_20_0._goTrialTipsBg, true)
	end
end

function var_0_0.onOpenFinish(arg_21_0)
	arg_21_0:_dispatchGuideEventOnOpenFinish()
end

function var_0_0._setTrialNumTips(arg_22_0)
	local var_22_0, var_22_1 = var_0_0._getEpisodeConfigAndBattleConfig()
	local var_22_2 = {}

	if var_22_1 and var_22_1.trialLimit > 0 then
		if var_22_1.trialLimit >= 4 then
			var_22_2[1] = luaLang("herogroup_trial_tip")
		else
			var_22_2[1] = formatLuaLang("herogroup_trial_limit_tip", var_22_1.trialLimit)
		end
	end

	if var_22_1 and not string.nilorempty(var_22_1.trialEquips) then
		table.insert(var_22_2, luaLang("herogroup_trial_equip_tip"))
	end

	gohelper.setActive(arg_22_0._goTrialTips, #var_22_2 > 0)

	if #var_22_2 > 0 then
		gohelper.CreateObjList(arg_22_0, arg_22_0._setTrialTipsTxt, var_22_2, arg_22_0._goTrialTipsBg, arg_22_0._goTrialTipsItem)
	end
end

function var_0_0._onTouch(arg_23_0)
	if arg_23_0._goTrialTips.activeSelf and arg_23_0._clickTrialFrame ~= UnityEngine.Time.frameCount and not ViewMgr.instance:isOpen(ViewName.HeroGroupBalanceTipView) then
		gohelper.setActive(arg_23_0._goTrialTipsBg, false)
	end
end

function var_0_0._setTrialTipsTxt(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	gohelper.findChildTextMesh(arg_24_1, "desc").text = arg_24_2
end

function var_0_0._switchTrialTips(arg_25_0)
	gohelper.setActive(arg_25_0._goTrialTipsBg, not arg_25_0._goTrialTipsBg.activeSelf)

	arg_25_0._clickTrialFrame = UnityEngine.Time.frameCount
end

function var_0_0._refreshPowerShow(arg_26_0)
	local var_26_0 = true
	local var_26_1 = HeroGroupModel.instance.episodeId
	local var_26_2 = DungeonConfig.instance:getEpisodeCO(var_26_1)
	local var_26_3 = DungeonConfig.instance:getChapterCO(var_26_2.chapterId)

	if var_26_3 and var_26_3.enterAfterFreeLimit > 0 and DungeonModel.instance:getChapterRemainingNum(var_26_3.type) >= arg_26_0._multiplication then
		var_26_0 = false
	end

	gohelper.setActive(arg_26_0._gopowercontent, var_26_0)
	gohelper.setActive(arg_26_0._gofightCount, not var_26_0)
end

function var_0_0._getMultiplicationKey(arg_27_0)
	return string.format("%s#%d", PlayerPrefsKey.Multiplication .. PlayerModel.instance:getMyUserId(), arg_27_0._episodeId)
end

function var_0_0._udpateRecommendEffect(arg_28_0)
	gohelper.setActive(arg_28_0._goRecommendEffect, FightFailRecommendController.instance:needShowRecommend(arg_28_0._episodeId))
end

function var_0_0.isShowHelpBtnIcon(arg_29_0)
	local var_29_0 = arg_29_0.viewContainer:getHelpId()

	recthelper.setAnchorX(arg_29_0._gotopbtns.transform, var_29_0 and 568.56 or 419.88)
end

function var_0_0._onEscapeBtnClick(arg_30_0)
	if not arg_30_0._gomask.gameObject.activeInHierarchy then
		arg_30_0.viewContainer:_closeCallback()
	end
end

function var_0_0._getfreeCount(arg_31_0)
	if not arg_31_0._chapterConfig or arg_31_0._chapterConfig.enterAfterFreeLimit <= 0 then
		return 0
	end

	return (DungeonModel.instance:getChapterRemainingNum(arg_31_0._chapterConfig.type))
end

function var_0_0._groupDropValueChanged(arg_32_0, arg_32_1)
	local var_32_0

	if V1a6_CachotHeroGroupModel.instance:getGroupTypeName() then
		var_32_0 = arg_32_1
	else
		var_32_0 = arg_32_1 + 1
	end

	gohelper.setActive(arg_32_0._btnmodifyname, false)

	if V1a6_CachotHeroGroupModel.instance:setHeroGroupSelectIndex(var_32_0) then
		arg_32_0:_checkEquipClothSkill()
		GameFacade.showToast(ToastEnum.SeasonGroupChanged)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
		gohelper.setActive(arg_32_0._goherogroupcontain, false)
		gohelper.setActive(arg_32_0._goherogroupcontain, true)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyGroupSelectIndex)
	end
end

function var_0_0._initFightGroupDrop(arg_33_0)
	if not arg_33_0:_noAidHero() then
		return
	end

	local var_33_0 = {}

	for iter_33_0 = 1, 4 do
		var_33_0[iter_33_0] = V1a6_CachotHeroGroupModel.instance:getCommonGroupName(iter_33_0)
	end

	local var_33_1 = V1a6_CachotHeroGroupModel.instance.curGroupSelectIndex

	gohelper.setActive(arg_33_0._btnmodifyname, false)

	local var_33_2 = V1a6_CachotHeroGroupModel.instance:getGroupTypeName()

	if var_33_2 then
		table.insert(var_33_0, 1, var_33_2)
	else
		var_33_1 = var_33_1 - 1
	end

	arg_33_0._dropherogroup:ClearOptions()
	arg_33_0._dropherogroup:AddOptions(var_33_0)
	arg_33_0._dropherogroup:SetValue(var_33_1)
end

function var_0_0._modifyName(arg_34_0)
	ViewMgr.instance:openView(ViewName.HeroGroupModifyNameView)
end

function var_0_0._refreshUI(arg_35_0)
	local var_35_0 = V1a6_CachotHeroGroupModel.instance:getCurGroupId()

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, var_35_0)

	arg_35_0._episodeId = HeroGroupModel.instance.episodeId
	arg_35_0.episodeConfig = DungeonConfig.instance:getEpisodeCO(arg_35_0._episodeId)
	arg_35_0._chapterConfig = DungeonConfig.instance:getChapterCO(arg_35_0.episodeConfig.chapterId)

	local var_35_1 = arg_35_0:_getfreeCount()

	arg_35_0._enterAfterFreeLimit = var_35_1 - arg_35_0._multiplication >= 0 and var_35_1 - arg_35_0._multiplication or false

	gohelper.setActive(arg_35_0._btnrecommend.gameObject, arg_35_0._chapterConfig.isHeroRecommend == 1)
	arg_35_0:_refreshCost(true)
	arg_35_0:_refreshCloth()
	arg_35_0:_setTrialNumTips()
	arg_35_0.viewContainer:setNavigateOverrideClose()
	gohelper.setActive(arg_35_0._goReplayBtn, not HeroGroupBalanceHelper.getIsBalanceMode() and arg_35_0.episodeConfig and arg_35_0.episodeConfig.canUseRecord == 1 and arg_35_0._chapterConfig.type ~= DungeonEnum.ChapterType.WeekWalk)
end

function var_0_0._refreshCost(arg_36_0, arg_36_1)
	gohelper.setActive(arg_36_0._gocost, arg_36_1)

	local var_36_0 = arg_36_0:_getfreeCount()

	gohelper.setActive(arg_36_0._gopower, not arg_36_0._enterAfterFreeLimit)
	gohelper.setActive(arg_36_0._gocount, not arg_36_0._enterAfterFreeLimit and var_36_0 > 0)
	gohelper.setActive(arg_36_0._gonormallackpower, false)
	gohelper.setActive(arg_36_0._goreplaylackpower, false)

	if arg_36_0._enterAfterFreeLimit or var_36_0 > 0 then
		local var_36_1 = tostring(-1 * math.min(arg_36_0._multiplication, var_36_0))

		arg_36_0._txtCostNum.text = var_36_1
		arg_36_0._txtReplayCostNum.text = var_36_1

		if var_36_0 >= arg_36_0._multiplication then
			arg_36_0:_refreshBtns(false)

			return
		end
	end

	local var_36_2 = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power)
	local var_36_3 = ResUrl.getCurrencyItemIcon(var_36_2.icon .. "_btn")

	arg_36_0._simagepower:LoadImage(var_36_3)
	arg_36_0:_refreshCostPower()
end

function var_0_0._refreshTips(arg_37_0)
	local var_37_0 = arg_37_0._enterAfterFreeLimit and -271.5 or -280
	local var_37_1 = arg_37_0._enterAfterFreeLimit and 163 or 165.5

	recthelper.setAnchor(arg_37_0._golevelchange.transform, var_37_0, var_37_1)

	local var_37_2 = arg_37_0._golevelchange.activeInHierarchy and not arg_37_0._replayMode

	recthelper.setAnchorY(arg_37_0._gocount.transform, var_37_2 and 0 or -41.11)
	recthelper.setAnchorX(arg_37_0._gocount.transform, -72)
	gohelper.setActive(arg_37_0._btnmultispeed.gameObject, arg_37_0._replayMode)

	arg_37_0._gomultispeed.transform.position = arg_37_0._gomultPos.transform.position
end

function var_0_0._refreshCostPower(arg_38_0)
	local var_38_0 = string.split(arg_38_0.episodeConfig.cost, "|")
	local var_38_1 = string.split(var_38_0[1], "#")
	local var_38_2 = tonumber(var_38_1[3] or 0)
	local var_38_3 = var_38_2 > 0

	if arg_38_0._enterAfterFreeLimit then
		var_38_3 = false
	end

	gohelper.setActive(arg_38_0._gopower, var_38_3)
	arg_38_0:_refreshBtns(var_38_3)

	if not var_38_3 then
		return
	end

	local var_38_4 = var_38_2 * ((arg_38_0._multiplication or 1) - arg_38_0:_getfreeCount())

	arg_38_0._txtusepower.text = string.format("-%s", var_38_4)

	local var_38_5 = arg_38_0._chapterConfig.type == DungeonEnum.ChapterType.Hard

	if var_38_4 <= CurrencyModel.instance:getPower() then
		local var_38_6 = var_38_5 and "#FFFFFF" or "#070706"

		SLFramework.UGUI.GuiHelper.SetColor(arg_38_0._txtusepower, arg_38_0._replayMode and "#070706" or var_38_6)
	else
		local var_38_7 = var_38_5 and "#C44945" or "#800015"

		SLFramework.UGUI.GuiHelper.SetColor(arg_38_0._txtusepower, arg_38_0._replayMode and "#800015" or var_38_7)
		gohelper.setActive(arg_38_0._gonormallackpower, not arg_38_0._replayMode)
		gohelper.setActive(arg_38_0._goreplaylackpower, arg_38_0._replayMode)
	end
end

function var_0_0._dispatchGuideEvent(arg_39_0)
	if arg_39_0._replayMode then
		return
	end

	if not arg_39_0:_isSpType(arg_39_0._chapterConfig.type) then
		if not GuideInvalidCondition.checkAllGroupSetEquip() then
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnEnteryEquipType)
		end

		arg_39_0:_dispatchRecordEvent()
		arg_39_0:_dispatchNoEquipEvent()
	end
end

function var_0_0._dispatchGuideEventOnOpenFinish(arg_40_0)
	if arg_40_0._episodeId then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OpenHeroGroupFinishWithEpisodeId, arg_40_0._episodeId)
	end
end

function var_0_0._dispatchNoEquipEvent(arg_41_0)
	local var_41_0 = V1a6_CachotHeroGroupModel.instance:getCurGroupMO()

	for iter_41_0 = 1, 4 do
		local var_41_1 = var_41_0:getPosEquips(iter_41_0 - 1).equipUid[1]

		if EquipModel.instance:getEquip(var_41_1) then
			return
		end
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnEnteryNormalType)
end

function var_0_0._isSpType(arg_42_0, arg_42_1)
	return arg_42_1 == DungeonEnum.ChapterType.Sp or arg_42_1 == DungeonEnum.ChapterType.TeachNote
end

function var_0_0._dispatchRecordEvent(arg_43_0)
	local var_43_0 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightReplay)
	local var_43_1 = DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId)
	local var_43_2 = var_43_1 and var_43_1.hasRecord

	if var_43_0 and var_43_2 then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnHasRecord)
	end
end

function var_0_0.onClose(arg_44_0)
	arg_44_0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, arg_44_0._onModifySnapshot, arg_44_0)
	arg_44_0:removeEventCb(HelpController.instance, HelpEvent.RefreshHelp, arg_44_0.isShowHelpBtnIcon, arg_44_0)
	TaskDispatcher.cancelTask(arg_44_0._checkDropArrow, arg_44_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
	ZProj.TweenHelper.KillById(arg_44_0._tweeningId)
	HeroGroupBalanceHelper.clearBalanceStatus()

	if arg_44_0._dragEffectLoader then
		arg_44_0._dragEffectLoader:dispose()

		arg_44_0._dragEffectLoader = nil
	end

	arg_44_0:removeEventCb(HelpController.instance, HelpEvent.RefreshHelp, arg_44_0.isShowHelpBtnIcon, arg_44_0)
end

function var_0_0._refreshReplay(arg_45_0)
	if arg_45_0._chapterConfig.type == DungeonEnum.ChapterType.WeekWalk then
		gohelper.setActive(arg_45_0._goReplayBtn, false)
	else
		local var_45_0 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightReplay)
		local var_45_1 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay)
		local var_45_2 = DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId)
		local var_45_3 = var_45_2 and var_45_2.hasRecord

		ZProj.UGUIHelper.SetColorAlpha(arg_45_0._imgbtnReplayBg, var_45_1 and var_45_3 and 1 or 0.75)

		local var_45_4 = arg_45_0._replayMode and "btn_replay_pause" or "btn_replay_play"

		UISpriteSetMgr.instance:setHeroGroupSprite(arg_45_0._imagereplayicon, var_45_1 and var_45_3 and var_45_4 or "btn_replay_lack")
		recthelper.setWidth(arg_45_0._goReplayBtn.transform, arg_45_0._replayMode and 249.538 or 83)

		if var_45_0 and var_45_3 and not arg_45_0._replayMode then
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnHasRecord)
		end
	end
end

function var_0_0._refreshCloth(arg_46_0)
	local var_46_0 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.LeadRoleSkill)
	local var_46_1 = V1a6_CachotHeroGroupModel.instance:getCurGroupMO().clothId

	var_46_1 = PlayerClothModel.instance:getSpEpisodeClothID() or var_46_1

	local var_46_2 = PlayerClothModel.instance:getById(var_46_1)

	gohelper.setActive(arg_46_0._txtclothname.gameObject, var_46_2)

	if var_46_2 then
		local var_46_3 = lua_cloth.configDict[var_46_2.clothId]

		if not var_46_2.level then
			local var_46_4 = 0
		end

		arg_46_0._txtclothname.text = var_46_3.name
		arg_46_0._txtclothnameen.text = var_46_3.enname
	end

	for iter_46_0, iter_46_1 in ipairs(lua_cloth.configList) do
		local var_46_5 = gohelper.findChild(arg_46_0._iconGO, tostring(iter_46_1.id))

		if not gohelper.isNil(var_46_5) then
			gohelper.setActive(var_46_5, iter_46_1.id == var_46_1)
		end
	end

	gohelper.setActive(arg_46_0._btncloth.gameObject, var_0_0.showCloth())
end

function var_0_0._checkEquipClothSkill(arg_47_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill) then
		return
	end

	local var_47_0 = V1a6_CachotHeroGroupModel.instance:getCurGroupMO()

	if PlayerClothModel.instance:getById(var_47_0.clothId) then
		return
	end

	local var_47_1 = PlayerClothModel.instance:getList()

	for iter_47_0, iter_47_1 in ipairs(var_47_1) do
		if PlayerClothModel.instance:hasCloth(iter_47_1.id) then
			V1a6_CachotHeroGroupModel.instance:replaceCloth(iter_47_1.id)
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
			V1a6_CachotHeroGroupModel.instance:cachotSaveCurGroup()

			break
		end
	end
end

function var_0_0._getEpisodeConfigAndBattleConfig()
	local var_48_0 = DungeonConfig.instance:getEpisodeCO(HeroGroupModel.instance.episodeId)
	local var_48_1

	if HeroGroupModel.instance.battleId and HeroGroupModel.instance.battleId > 0 then
		var_48_1 = lua_battle.configDict[HeroGroupModel.instance.battleId]
	else
		var_48_1 = DungeonConfig.instance:getBattleCo(HeroGroupModel.instance.episodeId)
	end

	return var_48_0, var_48_1
end

function var_0_0.showCloth()
	if PlayerClothModel.instance:getSpEpisodeClothID() then
		return true
	end

	if not OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.LeadRoleSkill) then
		return false
	end

	local var_49_0, var_49_1 = var_0_0._getEpisodeConfigAndBattleConfig()

	if var_49_1 and var_49_1.noClothSkill == 1 then
		return false
	end

	local var_49_2 = V1a6_CachotHeroGroupModel.instance:getCurGroupMO()
	local var_49_3 = PlayerClothModel.instance:getById(var_49_2.clothId)
	local var_49_4 = PlayerClothModel.instance:getList()
	local var_49_5 = false

	for iter_49_0, iter_49_1 in ipairs(var_49_4) do
		var_49_5 = true

		break
	end

	return var_49_5
end

function var_0_0._onModifyHeroGroup(arg_50_0)
	arg_50_0:_refreshCloth()
end

function var_0_0._onModifySnapshot(arg_51_0)
	arg_51_0:_refreshCloth()
end

function var_0_0._onClickHeroGroupItem(arg_52_0, arg_52_1)
	local var_52_0 = V1a6_CachotHeroGroupModel.instance:getCurGroupMO():getPosEquips(arg_52_1 - 1).equipUid

	arg_52_0._param = {}
	arg_52_0._param.singleGroupMOId = arg_52_1
	arg_52_0._param.originalHeroUid = V1a6_CachotHeroSingleGroupModel.instance:getHeroUid(arg_52_1)
	arg_52_0._param.adventure = V1a6_CachotHeroGroupModel.instance:isAdventureOrWeekWalk()
	arg_52_0._param.equips = var_52_0
	arg_52_0._param.heroGroupEditType = V1a6_CachotEnum.HeroGroupEditType.Fight
	arg_52_0._param.seatLevel = V1a6_CachotTeamModel.instance:getSeatLevel(arg_52_1)

	ViewMgr.instance:openView(ViewName.V1a6_CachotHeroGroupEditView, arg_52_0._param)
end

function var_0_0._checkFirstPosHasEquip(arg_53_0)
	local var_53_0 = V1a6_CachotHeroGroupModel.instance:getCurGroupMO():getPosEquips(0).equipUid
	local var_53_1 = var_53_0 and var_53_0[1]

	if var_53_1 and EquipModel.instance:getEquip(var_53_1) then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnFirstPosHasEquip)
	end
end

function var_0_0._showGuideDragEffect(arg_54_0, arg_54_1)
	if arg_54_0._dragEffectLoader then
		arg_54_0._dragEffectLoader:dispose()

		arg_54_0._dragEffectLoader = nil
	end

	if tonumber(arg_54_1) == 1 then
		arg_54_0._dragEffectLoader = PrefabInstantiate.Create(arg_54_0.viewGO)

		arg_54_0._dragEffectLoader:startLoad("ui/viewres/guide/guide_herogroup.prefab")
	end
end

function var_0_0._onClickStart(arg_55_0)
	local var_55_0 = string.split(arg_55_0.episodeConfig.cost, "|")
	local var_55_1 = string.split(var_55_0[1], "#")
	local var_55_2 = tonumber(var_55_1[3] or 0)
	local var_55_3 = arg_55_0:_getfreeCount()

	if var_55_2 * ((arg_55_0._multiplication or 1) - var_55_3) > CurrencyModel.instance:getPower() then
		CurrencyController.instance:openPowerView()

		return
	end

	local var_55_4 = 10104

	if HeroGroupModel.instance.episodeId == var_55_4 and not DungeonModel.instance:hasPassLevel(var_55_4) then
		local var_55_5 = HeroSingleGroupModel.instance:getList()
		local var_55_6 = 0

		for iter_55_0, iter_55_1 in ipairs(var_55_5) do
			if not iter_55_1:isEmpty() then
				var_55_6 = var_55_6 + 1
			end
		end

		if var_55_6 < 2 then
			GameFacade.showToast(ToastEnum.HeroSingleGroupCount)

			return
		end
	end

	arg_55_0:_closemultcontent()
	arg_55_0:_enterFight()
end

function var_0_0._enterFight(arg_56_0)
	if HeroGroupModel.instance.episodeId then
		arg_56_0._closeWithEnteringFight = true

		if V1a6_CachotController.instance:setFightHeroGroup() then
			arg_56_0.viewContainer:beforeEnterFight()

			local var_56_0 = FightModel.instance:getFightParam()

			if arg_56_0._replayMode then
				var_56_0.isReplay = true
				var_56_0.multiplication = arg_56_0._multiplication

				DungeonFightController.instance:sendStartDungeonRequest(var_56_0.chapterId, var_56_0.episodeId, var_56_0, arg_56_0._multiplication, nil, true)
			else
				var_56_0.isReplay = false
				var_56_0.multiplication = 1

				DungeonFightController.instance:sendStartDungeonRequest(var_56_0.chapterId, var_56_0.episodeId, var_56_0, 1)
			end

			AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
		end
	else
		logError("没选中关卡，无法开始战斗")
	end
end

function var_0_0._onUseRecommendGroup(arg_57_0)
	if arg_57_0._replayMode then
		arg_57_0:_closemultcontent()

		arg_57_0._replayMode = false
		arg_57_0._multiplication = 1

		arg_57_0:_refreshCost(true)
		arg_57_0:_switchReplayGroup()
	end
end

function var_0_0._onClickReplay(arg_58_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay) then
		local var_58_0, var_58_1 = OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.FightReplay)

		GameFacade.showToast(var_58_0, var_58_1)

		return
	end

	if not HeroGroupModel.instance.episodeId then
		return
	end

	local var_58_2 = DungeonConfig.instance:getEpisodeCO(HeroGroupModel.instance.episodeId)
	local var_58_3 = DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId)
	local var_58_4 = var_58_3 and var_58_3.hasRecord
	local var_58_5 = var_58_3 and var_58_3.star == DungeonEnum.StarType.Advanced
	local var_58_6 = var_58_2 and var_58_2.firstBattleId > 0

	if not var_58_4 and var_58_5 and var_58_6 then
		GameFacade.showToast(ToastEnum.CantRecordReplay)

		return
	end

	if var_58_3 and var_58_3.star == DungeonEnum.StarType.Advanced and not var_58_3.hasRecord then
		GameFacade.showToast(ToastEnum.HeroGroupStarAdvanced)

		return
	end

	if not var_58_3 or var_58_3 and var_58_3.star ~= DungeonEnum.StarType.Advanced then
		GameFacade.showToast(ToastEnum.HeroGroupStarNoAdvanced)

		return
	end

	local var_58_7 = arg_58_0._replayMode

	if arg_58_0._replayMode then
		arg_58_0._replayMode = false
		arg_58_0._multiplication = 1

		arg_58_0._btnContainAnim:Play(UIAnimationName.Switch, 0, 0)
		gohelper.setActive(arg_58_0._gomultispeed, false)
	else
		arg_58_0._btnContainAnim:Play(UIAnimationName.Switch, 0, 0)

		arg_58_0._replayMode = true
		arg_58_0._multiplication = 1
	end

	PlayerPrefsHelper.setNumber(arg_58_0:_getMultiplicationKey(), arg_58_0._multiplication)
	arg_58_0:_refreshCost(true)

	if arg_58_0._replayMode and not arg_58_0._replayFightGroupMO then
		arg_58_0:addEventCb(FightController.instance, FightEvent.RespGetFightRecordGroupReply, arg_58_0._onGetFightRecordGroupReply, arg_58_0)
		FightRpc.instance:sendGetFightRecordGroupRequest(HeroGroupModel.instance.episodeId)

		return
	end

	arg_58_0:_switchReplayGroup(var_58_7)
end

function var_0_0._switchReplayGroup(arg_59_0, arg_59_1)
	arg_59_0:_switchReplayMul()
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.PlayHeroGroupHeroEffect, arg_59_0._replayMode and "swicth" or UIAnimationName.Open)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SwitchReplay, arg_59_0._replayMode)

	if arg_59_0._replayMode then
		arg_59_0._goLevelChangePosX = arg_59_0._goLevelChangePosX or recthelper.getAnchorX(arg_59_0._golevelchange.transform)

		recthelper.setAnchorX(arg_59_0._golevelchange.transform, 10000)
		arg_59_0:_updateReplayHeroGorupList()

		local var_59_0 = formatLuaLang("herogroupview_replaycn", GameUtil.getNum2Chinese(arg_59_0._multiplication))

		arg_59_0._txtreplaycn.text = var_59_0
		arg_59_0._txtreplayhardcn.text = var_59_0
		arg_59_0._txtreplayunpowercn.text = var_59_0
	else
		if arg_59_0._goLevelChangePosX then
			recthelper.setAnchorX(arg_59_0._golevelchange.transform, arg_59_0._goLevelChangePosX)
		end

		V1a6_CachotHeroGroupModel.instance:setParam(V1a6_CachotHeroGroupModel.instance.battleId, V1a6_CachotHeroGroupModel.instance.episodeId, V1a6_CachotHeroGroupModel.instance.adventure)

		local var_59_1 = V1a6_CachotHeroGroupModel.instance:getCurGroupMO().id

		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, var_59_1)
		arg_59_0:_refreshCloth()
		gohelper.setActive(arg_59_0._goherogroupcontain, false)
		gohelper.setActive(arg_59_0._goherogroupcontain, true)
	end
end

function var_0_0._switchReplayMul(arg_60_0)
	if arg_60_0._replayMode then
		arg_60_0:setMultSpeed(arg_60_0._multiplication)
	else
		arg_60_0:_refreshUI()
		arg_60_0:_refreshTips()
	end

	arg_60_0:_refreshCost(true)
	arg_60_0:_refreshPowerShow()
	gohelper.setActive(arg_60_0._goreplayready, arg_60_0._replayMode)

	local var_60_0 = arg_60_0:_haveRecord()

	UISpriteSetMgr.instance:setHeroGroupSprite(arg_60_0._imagereplayicon, not var_60_0 and "btn_replay_lack" or arg_60_0._replayMode and "btn_replay_pause" or "btn_replay_play")
	recthelper.setWidth(arg_60_0._goReplayBtn.transform, arg_60_0._replayMode and 249.538 or 83)
	ZProj.UGUIHelper.RebuildLayout(arg_60_0._goReplayBtn.transform.parent)
	gohelper.setActive(arg_60_0._goreplaybtnframe, arg_60_0._replayMode)
end

function var_0_0._haveRecord(arg_61_0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay) then
		return false
	end

	local var_61_0 = DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId)

	if var_61_0 and var_61_0.star == DungeonEnum.StarType.Advanced and not var_61_0.hasRecord then
		return false
	end

	if not var_61_0 or var_61_0 and var_61_0.star ~= DungeonEnum.StarType.Advanced then
		return false
	end

	return true
end

function var_0_0._refreshBtns(arg_62_0, arg_62_1)
	local var_62_0 = HeroGroupBalanceHelper.getIsBalanceMode()

	gohelper.setActive(arg_62_0._btnBalanceStart, var_62_0 and not arg_62_0._replayMode and arg_62_0._chapterConfig.type ~= DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_62_0._btnUnPowerBalanceStart, var_62_0 and not arg_62_0._replayMode and arg_62_0._chapterConfig.type == DungeonEnum.ChapterType.Hard)

	local var_62_1 = arg_62_0._enterAfterFreeLimit or arg_62_0:_getfreeCount() > 0

	gohelper.setActive(arg_62_0._btnstartreplay.gameObject, arg_62_1 and arg_62_0._replayMode and arg_62_0._chapterConfig.type ~= DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_62_0._btnunpowerreplay.gameObject, not arg_62_1 and not var_62_1 and arg_62_0._replayMode)
	gohelper.setActive(arg_62_0._btnunpowerstart.gameObject, not var_62_0 and not arg_62_1 and not var_62_1 and not arg_62_0._replayMode)
	gohelper.setActive(arg_62_0._btncostreplay.gameObject, not arg_62_1 and var_62_1 and arg_62_0._replayMode)
	gohelper.setActive(arg_62_0._btncoststart.gameObject, not var_62_0 and not arg_62_1 and var_62_1 and not arg_62_0._replayMode)
	gohelper.setActive(arg_62_0._btnhardreplay.gameObject, arg_62_1 and arg_62_0._replayMode and arg_62_0._chapterConfig.type == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_62_0._btnstart.gameObject, not var_62_0 and arg_62_1 and not arg_62_0._replayMode and arg_62_0._chapterConfig.type ~= DungeonEnum.ChapterType.Hard)
	gohelper.setActive(arg_62_0._btnstarthard.gameObject, not var_62_0 and arg_62_1 and not arg_62_0._replayMode and arg_62_0._chapterConfig.type == DungeonEnum.ChapterType.Hard)

	local var_62_2 = not arg_62_0._replayMode and arg_62_0:_noAidHero()

	gohelper.setActive(arg_62_0._dropherogroup, var_62_2)

	if var_62_2 then
		TaskDispatcher.runRepeat(arg_62_0._checkDropArrow, arg_62_0, 0)
	else
		TaskDispatcher.cancelTask(arg_62_0._checkDropArrow, arg_62_0)
	end
end

function var_0_0._checkDropArrow(arg_63_0)
	if not arg_63_0._dropherogrouparrow then
		TaskDispatcher.cancelTask(arg_63_0._checkDropArrow, arg_63_0)

		return
	end

	local var_63_0 = arg_63_0._dropherogroup.transform.childCount

	if var_63_0 ~= arg_63_0._dropDownChildCount then
		arg_63_0._dropDownChildCount = var_63_0

		local var_63_1 = arg_63_0._dropgroupchildcount ~= var_63_0

		transformhelper.setLocalScale(arg_63_0._dropherogrouparrow, 1, var_63_1 and -1 or 1, 1)
	end
end

function var_0_0._noAidHero(arg_64_0)
	local var_64_0 = HeroGroupModel.instance.battleId
	local var_64_1 = lua_battle.configDict[var_64_0]

	if not var_64_1 then
		return
	end

	return var_64_1.trialLimit <= 0 and string.nilorempty(var_64_1.aid) and string.nilorempty(var_64_1.trialHeros) and string.nilorempty(var_64_1.trialEquips)
end

function var_0_0._onGetFightRecordGroupReply(arg_65_0, arg_65_1)
	arg_65_0:removeEventCb(FightController.instance, FightEvent.RespGetFightRecordGroupReply, arg_65_0._onGetFightRecordGroupReply, arg_65_0)

	arg_65_0._replayFightGroupMO = arg_65_1

	if not arg_65_0._replayMode then
		return
	end

	arg_65_0:_switchReplayGroup()
	arg_65_0:_updateReplayHeroGorupList()
end

function var_0_0._updateReplayHeroGorupList(arg_66_0)
	V1a6_CachotHeroGroupModel.instance:setReplayParam(arg_66_0._replayFightGroupMO)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, arg_66_0._replayFightGroupMO.id)
	arg_66_0:_refreshCloth()
	gohelper.setActive(arg_66_0._goherogroupcontain, false)
	gohelper.setActive(arg_66_0._goherogroupcontain, true)
end

return var_0_0
