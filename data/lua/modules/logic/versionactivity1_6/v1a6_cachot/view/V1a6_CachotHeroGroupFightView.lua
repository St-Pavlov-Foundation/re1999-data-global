module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotHeroGroupFightView", package.seeall)

slot0 = class("V1a6_CachotHeroGroupFightView", BaseView)
slot1 = 4

function slot0.onInitView(slot0)
	slot0._btnstart = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/btnContain/horizontal/btnStart")
	slot0._btnBalanceStart = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/btnContain/horizontal/btnBalance")
	slot0._btnUnPowerBalanceStart = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/btnContain/horizontal/btnUnPowerBalance")
	slot0._btnstarthard = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/btnContain/horizontal/btnStartHard")
	slot0._btnstartreplay = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/btnContain/horizontal/btnStartReplay")
	slot0._goreplaybtnframe = gohelper.findChild(slot0.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn/replayAnimRoot/#go_replaybtnframe")
	slot0._goReplayBtn = gohelper.findChild(slot0.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn")
	slot0._btnReplay = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn/replayAnimRoot/btnReplay")
	slot0._imagereplayicon = gohelper.findChildImage(slot0.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn/replayAnimRoot/btnReplay/#image_replayicon")
	slot0._imgbtnReplayBg = gohelper.findChildImage(slot0.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn/replayAnimRoot/btnReplay/#image_replaybg")
	slot0._goreplayready = gohelper.findChild(slot0.viewGO, "#go_container/#go_replayready")
	slot0._btnmultispeed = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn/replayAnimRoot/#btn_multispeed")
	slot0._txtmultispeed = gohelper.findChildTextMesh(slot0.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn/replayAnimRoot/#btn_multispeed/Label")
	slot0._btnclosemult = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_closemult")
	slot0._gomultPos = gohelper.findChild(slot0.viewGO, "#go_container/btnContain/horizontal/#go_replayBtn/replayAnimRoot/#btn_multispeed/#go_multpos")
	slot0._gomultispeed = gohelper.findChild(slot0.viewGO, "#go_multispeed")
	slot0._gomultContent = gohelper.findChild(slot0.viewGO, "#go_multispeed/Viewport/Content")
	slot0._gomultitem = gohelper.findChild(slot0.viewGO, "#go_multispeed/Viewport/Content/#go_multitem")
	slot0._simagereplayframe = gohelper.findChildSingleImage(slot0.viewGO, "#go_container/#go_replayready/#simage_replayframe")
	slot0._btncloth = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/btnContain/btnCloth")
	slot0._txtclothname = gohelper.findChildText(slot0.viewGO, "#go_container/btnContain/btnCloth/#txt_clothName")
	slot0._txtclothnameen = gohelper.findChildText(slot0.viewGO, "#go_container/btnContain/btnCloth/#txt_clothName/#txt_clothNameEn")
	slot0._btncareerrestrain = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/#go_topbtns/#btn_RestraintInfo")
	slot0._btnrecommend = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/#go_topbtns/btn_recommend")
	slot0._goRecommendEffect = gohelper.findChild(slot0.viewGO, "#go_container/btnContain/#go_topbtns/btn_recommend/recommend")
	slot0._gocost = gohelper.findChild(slot0.viewGO, "#go_container/btnContain/#go_cost")
	slot0._gopower = gohelper.findChild(slot0.viewGO, "#go_container/btnContain/#go_cost/#go_power")
	slot0._simagepower = gohelper.findChildSingleImage(slot0.viewGO, "#go_container/btnContain/#go_cost/#go_power/#simage_power")
	slot0._txtusepower = gohelper.findChildText(slot0.viewGO, "#go_container/btnContain/#go_cost/#go_power/#txt_usepower")
	slot0._gocount = gohelper.findChild(slot0.viewGO, "#go_container/btnContain/#go_cost/#go_count")
	slot0._txtcostcount = gohelper.findChildText(slot0.viewGO, "#go_container/btnContain/#go_cost/#go_count/animroot/#txt_costCount")
	slot0._gopowercontent = gohelper.findChild(slot0.viewGO, "#go_righttop/#go_power")
	slot0._gofightCount = gohelper.findChild(slot0.viewGO, "#go_righttop/fightcount")
	slot0._txtfightCount = gohelper.findChildTextMesh(slot0.viewGO, "#go_righttop/fightcount/#txt_fightcount")
	slot0._gomask = gohelper.findChild(slot0.viewGO, "#go_container2/#go_mask")
	slot0._gocontainer = gohelper.findChild(slot0.viewGO, "#go_container")
	slot0._gocontainer2 = gohelper.findChild(slot0.viewGO, "#go_container2")
	slot0._golevelchange = gohelper.findChild(slot0.viewGO, "#go_container/btnContain/#go_levelchange")
	slot0._txtreplaycn = gohelper.findChildText(slot0.viewGO, "#go_container/btnContain/horizontal/btnStartReplay/#txt_replaycn")
	slot0._gotopbtns = gohelper.findChild(slot0.viewGO, "#go_container/#go_topbtns")
	slot0._btnunpowerstart = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/btnContain/horizontal/btnUnPowerStart")
	slot0._btnunpowerreplay = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/btnContain/horizontal/btnUnPowerReplay")
	slot0._btnhardreplay = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/btnContain/horizontal/btnHardReplay")
	slot0._txtreplayhardcn = gohelper.findChildText(slot0.viewGO, "#go_container/btnContain/horizontal/btnHardReplay/#txt_replayhardcn")
	slot0._txtreplayunpowercn = gohelper.findChildText(slot0.viewGO, "#go_container/btnContain/horizontal/btnUnPowerReplay/#txt_replayunpowercn")
	slot0._gonormallackpower = gohelper.findChild(slot0.viewGO, "#go_container/btnContain/#go_normallackpower")
	slot0._goreplaylackpower = gohelper.findChild(slot0.viewGO, "#go_container/btnContain/#go_replaylackpower")
	slot0._goTrialTips = gohelper.findChild(slot0.viewGO, "#go_container/trialContainer/#go_trialTips")
	slot0._goTrialTipsBg = gohelper.findChild(slot0.viewGO, "#go_container/trialContainer/#go_trialTips/#go_tipsbg")
	slot0._goTrialTipsItem = gohelper.findChild(slot0.viewGO, "#go_container/trialContainer/#go_trialTips/#go_tipsbg/#go_tipsitem")
	slot0._btnTrialTips = gohelper.findChildButton(slot0.viewGO, "#go_container/trialContainer/#go_trialTips/#btn_tips")
	slot0._btnSwitchBalance = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/btnContain/horizontal/#btn_switchBalance")
	slot0._goBalanceEnter = gohelper.findChild(slot0.viewGO, "#go_container/btnContain/horizontal/#btn_switchBalance/#btn_enter")
	slot0._goBalanceExit = gohelper.findChild(slot0.viewGO, "#go_container/btnContain/horizontal/#btn_switchBalance/#btn_exit")
	slot0._dropherogroup = gohelper.findChildDropdown(slot0.viewGO, "#go_container/btnContain/horizontal/#drop_herogroup")
	slot0._btnmodifyname = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/btnContain/horizontal/#drop_herogroup/#btn_changename")
	slot0._dropherogrouparrow = gohelper.findChild(slot0.viewGO, "#go_container/btnContain/horizontal/#drop_herogroup/arrow").transform
	slot0._btncoststart = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/btnContain/horizontal/btnCostStart")
	slot0._txtCostNum = gohelper.findChildText(slot0.viewGO, "#go_container/btnContain/horizontal/btnCostStart/#txt_num")
	slot0._btncostreplay = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_container/btnContain/horizontal/btnCostReplay")
	slot0._txtreplaycostcn = gohelper.findChildText(slot0.viewGO, "#go_container/btnContain/horizontal/btnCostReplay/#txt_replaycostcn")
	slot0._txtReplayCostNum = gohelper.findChildText(slot0.viewGO, "#go_container/btnContain/horizontal/btnCostReplay/#txt_num")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnTrialTips:AddClickListener(slot0._switchTrialTips, slot0)
	slot0._btnSwitchBalance:AddClickListener(slot0._btnSwitchBalanceOnClick, slot0)
	slot0._btnstart:AddClickListener(slot0._onClickStart, slot0)
	slot0._btnstarthard:AddClickListener(slot0._onClickStart, slot0)
	slot0._btnstartreplay:AddClickListener(slot0._onClickStart, slot0)
	slot0._btnReplay:AddClickListener(slot0._onClickReplay, slot0)
	slot0._btncloth:AddClickListener(slot0._btnclothOnClock, slot0)
	slot0._btncareerrestrain:AddClickListener(slot0._btncareerrestrainOnClick, slot0)
	slot0._btnrecommend:AddClickListener(slot0._btnrecommendOnClick, slot0)
	slot0._btnunpowerstart:AddClickListener(slot0._onClickStart, slot0)
	slot0._btncoststart:AddClickListener(slot0._onClickStart, slot0)
	slot0._btnBalanceStart:AddClickListener(slot0._onClickStart, slot0)
	slot0._btnUnPowerBalanceStart:AddClickListener(slot0._onClickStart, slot0)
	slot0._btnunpowerreplay:AddClickListener(slot0._onClickStart, slot0)
	slot0._btncostreplay:AddClickListener(slot0._onClickStart, slot0)
	slot0._btnhardreplay:AddClickListener(slot0._onClickStart, slot0)
	slot0._btnmultispeed:AddClickListener(slot0._openmultcontent, slot0)
	slot0._btnclosemult:AddClickListener(slot0._closemultcontent, slot0)
	slot0._btnmodifyname:AddClickListener(slot0._modifyName, slot0)
	slot0:addEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreen, slot0._onTouch, slot0)
	slot0._dropherogroup:AddOnValueChanged(slot0._groupDropValueChanged, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(GameStateMgr.instance, GameStateEvent.OnTouchScreen, slot0._onTouch, slot0)
	slot0._btnTrialTips:RemoveClickListener()
	slot0._btnSwitchBalance:RemoveClickListener()
	slot0._btnstart:RemoveClickListener()
	slot0._btnBalanceStart:RemoveClickListener()
	slot0._btnUnPowerBalanceStart:RemoveClickListener()
	slot0._btnstarthard:RemoveClickListener()
	slot0._btnstartreplay:RemoveClickListener()
	slot0._btnReplay:RemoveClickListener()
	slot0._btncloth:RemoveClickListener()
	slot0._btncareerrestrain:RemoveClickListener()
	slot0._btnrecommend:RemoveClickListener()
	slot0._btnunpowerstart:RemoveClickListener()
	slot0._btnunpowerreplay:RemoveClickListener()
	slot0._btncoststart:RemoveClickListener()
	slot0._btncostreplay:RemoveClickListener()
	slot0._btnhardreplay:RemoveClickListener()
	slot0._btnmultispeed:RemoveClickListener()
	slot0._btnclosemult:RemoveClickListener()
	slot0._btnmodifyname:RemoveClickListener()
	slot0._dropherogroup:RemoveOnValueChanged()
	slot0:removeEventCb(FightController.instance, FightEvent.RespGetFightRecordGroupReply, slot0._onGetFightRecordGroupReply, slot0)
end

function slot0._openmultcontent(slot0)
	gohelper.setActive(slot0._gomultispeed, not slot0._gomultispeed.activeSelf)

	slot0._gomultispeed.transform.position = slot0._gomultPos.transform.position
end

function slot0._closemultcontent(slot0)
	gohelper.setActive(slot0._gomultispeed, false)
end

function slot0._btnSwitchBalanceOnClick(slot0)
	HeroGroupBalanceHelper.switchBalanceMode()
	HeroGroupModel.instance:setParam(HeroGroupModel.instance.battleId, HeroGroupModel.instance.episodeId, HeroGroupModel.instance.adventure)
	slot0.viewContainer:dispatchEvent(HeroGroupEvent.SwitchBalance)
	gohelper.setActive(slot0._goBalanceEnter, not HeroGroupBalanceHelper.getIsBalanceMode())
	gohelper.setActive(slot0._goBalanceExit, HeroGroupBalanceHelper.getIsBalanceMode())

	if slot0._replayMode then
		slot0:_closemultcontent()

		slot0._replayMode = false
		slot0._multiplication = 1

		slot0:_refreshCost(true)
		slot0:_switchReplayGroup()
	else
		gohelper.setActive(slot0._goherogroupcontain, false)
		gohelper.setActive(slot0._goherogroupcontain, true)
		slot0:_refreshUI()
	end

	slot0.viewContainer:refreshHelpBtnIcon()
	slot0:isShowHelpBtnIcon()
	slot0:_initFightGroupDrop()

	if HeroGroupBalanceHelper.getIsBalanceMode() then
		ViewMgr.instance:openView(ViewName.HeroGroupBalanceTipView)
	end
end

function slot0._btnclothOnClock(slot0)
	if V1a6_CachotHeroGroupModel.instance:getCurGroupMO().isReplay then
		return
	end

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill) or PlayerClothModel.instance:getSpEpisodeClothID() then
		slot2 = V1a6_CachotHeroGroupModel.instance

		ViewMgr.instance:openView(ViewName.PlayerClothView, {
			groupModel = slot2,
			useCallback = slot2.cachotSaveCurGroup,
			useCallbackObj = slot2
		})
	else
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.LeadRoleSkill))
	end
end

function slot0._btncareerrestrainOnClick(slot0)
	ViewMgr.instance:openView(ViewName.HeroGroupCareerTipView)
end

function slot0._btnrecommendOnClick(slot0)
	FightFailRecommendController.instance:onClickRecommend()
	slot0:_udpateRecommendEffect()

	if slot0._chapterConfig.type == DungeonEnum.ChapterType.WeekWalk then
		WeekwalkRpc.instance:sendWeekwalkHeroRecommendRequest(WeekWalkModel.instance:getBattleElementId(), slot0._receiveRecommend, slot0)

		return
	end

	DungeonRpc.instance:sendGetEpisodeHeroRecommendRequest(slot0._episodeId, slot0._receiveRecommend, slot0)
end

function slot0._receiveRecommend(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		return
	end

	ViewMgr.instance:openView(ViewName.HeroGroupRecommendView, slot3)
end

function slot0._editableInitView(slot0)
	uv0 = CommonConfig.instance:getConstNum(ConstEnum.MaxMultiplication) or uv0
	slot0._multiplication = 1
	slot0._goherogroupcontain = gohelper.findChild(slot0.viewGO, "herogroupcontain")
	slot0._goBtnContain = gohelper.findChild(slot0.viewGO, "#go_container/btnContain")
	slot0._btnContainAnim = slot0._goBtnContain:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(slot0._gomask, false)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenFullView, slot0._onOpenFullView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, slot0._onModifyHeroGroup, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyGroupName, slot0._initFightGroupDrop, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, slot0._onModifySnapshot, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnClickHeroGroupItem, slot0._onClickHeroGroupItem, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.RespBeginFight, slot0._respBeginFight, slot0)
	slot0:addEventCb(HelpController.instance, HelpEvent.RefreshHelp, slot0.isShowHelpBtnIcon, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnUseRecommendGroup, slot0._onUseRecommendGroup, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onCurrencyChange, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.ShowGuideDragEffect, slot0._showGuideDragEffect, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnUpdateRecommendLevel, slot0._refreshTips, slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.HeroMoveForward, slot0._heroMoveForward, slot0)

	if BossRushController.instance:isInBossRushFight() then
		gohelper.addUIClickAudio(slot0._btnstart.gameObject, AudioEnum.ui_formation.play_ui_formation_action)
		gohelper.addUIClickAudio(slot0._btnstarthard.gameObject, AudioEnum.ui_formation.play_ui_formation_action)
		gohelper.addUIClickAudio(slot0._btnstartreplay.gameObject, AudioEnum.ui_formation.play_ui_formation_action)
	else
		gohelper.addUIClickAudio(slot0._btnstart.gameObject, AudioEnum.HeroGroupUI.Play_UI_Formation_Action)
		gohelper.addUIClickAudio(slot0._btnstarthard.gameObject, AudioEnum.HeroGroupUI.Play_UI_Formation_Action)
		gohelper.addUIClickAudio(slot0._btnstartreplay.gameObject, AudioEnum.HeroGroupUI.Play_UI_Formation_Action)
	end

	gohelper.addUIClickAudio(slot0._btnReplay.gameObject, AudioEnum.UI.Play_UI_Player_Interface_Close)

	slot0._iconGO = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._btncloth.gameObject)

	recthelper.setAnchor(slot0._iconGO.transform, -100, 1)

	slot0._tweeningId = 0
	slot0._replayMode = false
	slot0._multSpeedItems = {}

	gohelper.CreateObjList(slot0, slot0._setMultSpeedItem, {
		4,
		3,
		2,
		1
	}, slot0._gomultContent, slot0._gomultitem)
	gohelper.setActive(slot0._gomultispeed, false)
	slot0._simagereplayframe:LoadImage(ResUrl.getHeroGroupBg("fuxian_zhegai"))
end

function slot0._setMultSpeedItem(slot0, slot1, slot2, slot3)
	slot0:addClickCb(gohelper.getClick(slot1), slot0.setMultSpeed, slot0, slot2)

	gohelper.findChildTextMesh(slot1, "num").text = luaLang("multiple") .. slot2

	gohelper.setActive(gohelper.findChild(slot1, "line"), slot2 ~= uv0)

	slot0._multSpeedItems[slot2] = slot0:getUserDataTb_()
	slot0._multSpeedItems[slot2].num = slot5
	slot0._multSpeedItems[slot2].selecticon = gohelper.findChild(slot1, "selecticon")
end

slot2 = GameUtil.parseColor("#efb785")
slot3 = GameUtil.parseColor("#C3BEB6")

function slot0.setMultSpeed(slot0, slot1)
	for slot5 = 1, uv0 do
		slot0._multSpeedItems[slot5].num.color = slot1 == slot5 and uv1 or uv2

		gohelper.setActive(slot0._multSpeedItems[slot5].selecticon, slot1 == slot5)
	end

	slot0._txtmultispeed.text = luaLang("multiple") .. slot1
	slot0._multiplication = slot1

	PlayerPrefsHelper.setNumber(slot0:_getMultiplicationKey(), slot0._multiplication)
	slot0:_refreshUI()
	slot0:_refreshTips()

	slot2 = formatLuaLang("herogroupview_replaycn", GameUtil.getNum2Chinese(slot0._multiplication))
	slot0._txtreplaycn.text = slot2
	slot0._txtreplayhardcn.text = slot2
	slot0._txtreplayunpowercn.text = slot2
	slot0._txtreplaycostcn.text = slot2

	slot0:_refreshPowerShow()
	slot0:_closemultcontent()
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

	slot0:_refreshCostPower()
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

function slot0.onOpen(slot0)
	if HeroGroupBalanceHelper.getIsBalanceMode() then
		ViewMgr.instance:openView(ViewName.HeroGroupBalanceTipView)
	end

	HeroGroupTrialModel.instance:setTrialByBattleId(HeroGroupModel.instance.battleId)
	slot0:_checkFirstPosHasEquip()
	slot0:_checkEquipClothSkill()
	gohelper.setActive(slot0._btnSwitchBalance, HeroGroupBalanceHelper.canShowBalanceSwitchBtn())
	gohelper.setActive(slot0._goBalanceEnter, not HeroGroupBalanceHelper.getIsBalanceMode())
	gohelper.setActive(slot0._goBalanceExit, HeroGroupBalanceHelper.getIsBalanceMode())
	slot0:_refreshUI()
	gohelper.addUIClickAudio(slot0._btncareerrestrain.gameObject, AudioEnum.UI.Play_UI_Tipsopen)
	NavigateMgr.instance:addEscape(ViewName.V1a6_CachotHeroGroupFightView, slot0._onEscapeBtnClick, slot0)
	slot0:isShowHelpBtnIcon()
	AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Action_Cardsopen)

	slot4 = PlayerPrefsHelper.getString(FightModel.getPrefsKeyFightPassModel(), "")

	if OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay) and (DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId) and slot2.star == DungeonEnum.StarType.Advanced and slot2.hasRecord) and not string.nilorempty(slot4) and cjson.decode(slot4)[tostring(slot0._episodeId)] and not slot0._replayMode then
		slot0._replayMode = true
		slot0._multiplication = PlayerPrefsHelper.getNumber(slot0:_getMultiplicationKey(), 1)

		slot0:_refreshCost(true)

		slot0._replayFightGroupMO = HeroGroupModel.instance:getReplayParam()

		if not slot0._replayFightGroupMO then
			slot0:addEventCb(FightController.instance, FightEvent.RespGetFightRecordGroupReply, slot0._onGetFightRecordGroupReply, slot0)
			FightRpc.instance:sendGetFightRecordGroupRequest(HeroGroupModel.instance.episodeId)
		else
			slot0:_switchReplayGroup()
		end
	end

	slot0:setMultSpeed(slot0._multiplication)
	gohelper.setActive(slot0._goreplaybtnframe, slot0._replayMode)

	slot5 = false

	if DungeonConfig.instance:getChapterCO(DungeonConfig.instance:getEpisodeCO(HeroGroupModel.instance.episodeId).chapterId) and slot8.enterAfterFreeLimit > 0 and DungeonModel.instance:getChapterRemainingNum(slot8.type) > 0 then
		slot5 = true
		slot0._txtfightCount.text = slot9
	end

	gohelper.setActive(slot0._gofightCount, slot5)

	slot0._dropgroupchildcount = slot0._dropherogroup.transform.childCount

	slot0:_refreshReplay()
	slot0:_refreshTips()
	slot0:_refreshPowerShow()
	slot0:_udpateRecommendEffect()
	FightHelper.detectAttributeCounter()
	slot0:_initFightGroupDrop()

	if slot0._goTrialTips.activeSelf then
		gohelper.setActive(slot0._goTrialTipsBg, true)
	end
end

function slot0.onOpenFinish(slot0)
	slot0:_dispatchGuideEventOnOpenFinish()
end

function slot0._setTrialNumTips(slot0)
	slot1, slot2 = uv0._getEpisodeConfigAndBattleConfig()
	slot3 = {
		luaLang("herogroup_trial_tip")
	}

	if slot2 and slot2.trialLimit > 0 then
		if slot2.trialLimit >= 4 then
			-- Nothing
		else
			slot3[1] = formatLuaLang("herogroup_trial_limit_tip", slot2.trialLimit)
		end
	end

	if slot2 and not string.nilorempty(slot2.trialEquips) then
		table.insert(slot3, luaLang("herogroup_trial_equip_tip"))
	end

	gohelper.setActive(slot0._goTrialTips, #slot3 > 0)

	if #slot3 > 0 then
		gohelper.CreateObjList(slot0, slot0._setTrialTipsTxt, slot3, slot0._goTrialTipsBg, slot0._goTrialTipsItem)
	end
end

function slot0._onTouch(slot0)
	if slot0._goTrialTips.activeSelf and slot0._clickTrialFrame ~= UnityEngine.Time.frameCount and not ViewMgr.instance:isOpen(ViewName.HeroGroupBalanceTipView) then
		gohelper.setActive(slot0._goTrialTipsBg, false)
	end
end

function slot0._setTrialTipsTxt(slot0, slot1, slot2, slot3)
	gohelper.findChildTextMesh(slot1, "desc").text = slot2
end

function slot0._switchTrialTips(slot0)
	gohelper.setActive(slot0._goTrialTipsBg, not slot0._goTrialTipsBg.activeSelf)

	slot0._clickTrialFrame = UnityEngine.Time.frameCount
end

function slot0._refreshPowerShow(slot0)
	slot1 = true

	if DungeonConfig.instance:getChapterCO(DungeonConfig.instance:getEpisodeCO(HeroGroupModel.instance.episodeId).chapterId) and slot4.enterAfterFreeLimit > 0 and slot0._multiplication <= DungeonModel.instance:getChapterRemainingNum(slot4.type) then
		slot1 = false
	end

	gohelper.setActive(slot0._gopowercontent, slot1)
	gohelper.setActive(slot0._gofightCount, not slot1)
end

function slot0._getMultiplicationKey(slot0)
	return string.format("%s#%d", PlayerPrefsKey.Multiplication .. PlayerModel.instance:getMyUserId(), slot0._episodeId)
end

function slot0._udpateRecommendEffect(slot0)
	gohelper.setActive(slot0._goRecommendEffect, FightFailRecommendController.instance:needShowRecommend(slot0._episodeId))
end

function slot0.isShowHelpBtnIcon(slot0)
	recthelper.setAnchorX(slot0._gotopbtns.transform, slot0.viewContainer:getHelpId() and 568.56 or 419.88)
end

function slot0._onEscapeBtnClick(slot0)
	if not slot0._gomask.gameObject.activeInHierarchy then
		slot0.viewContainer:_closeCallback()
	end
end

function slot0._getfreeCount(slot0)
	if not slot0._chapterConfig or slot0._chapterConfig.enterAfterFreeLimit <= 0 then
		return 0
	end

	return DungeonModel.instance:getChapterRemainingNum(slot0._chapterConfig.type)
end

function slot0._groupDropValueChanged(slot0, slot1)
	slot2 = nil

	gohelper.setActive(slot0._btnmodifyname, false)

	if V1a6_CachotHeroGroupModel.instance:setHeroGroupSelectIndex(V1a6_CachotHeroGroupModel.instance:getGroupTypeName() and slot1 or slot1 + 1) then
		slot0:_checkEquipClothSkill()
		GameFacade.showToast(ToastEnum.SeasonGroupChanged)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
		gohelper.setActive(slot0._goherogroupcontain, false)
		gohelper.setActive(slot0._goherogroupcontain, true)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyGroupSelectIndex)
	end
end

function slot0._initFightGroupDrop(slot0)
	if not slot0:_noAidHero() then
		return
	end

	slot1 = {
		[slot5] = V1a6_CachotHeroGroupModel.instance:getCommonGroupName(slot5)
	}

	for slot5 = 1, 4 do
	end

	slot2 = V1a6_CachotHeroGroupModel.instance.curGroupSelectIndex

	gohelper.setActive(slot0._btnmodifyname, false)

	if V1a6_CachotHeroGroupModel.instance:getGroupTypeName() then
		table.insert(slot1, 1, slot3)
	else
		slot2 = slot2 - 1
	end

	slot0._dropherogroup:ClearOptions()
	slot0._dropherogroup:AddOptions(slot1)
	slot0._dropherogroup:SetValue(slot2)
end

function slot0._modifyName(slot0)
	ViewMgr.instance:openView(ViewName.HeroGroupModifyNameView)
end

function slot0._refreshUI(slot0)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, V1a6_CachotHeroGroupModel.instance:getCurGroupId())

	slot0._episodeId = HeroGroupModel.instance.episodeId
	slot0.episodeConfig = DungeonConfig.instance:getEpisodeCO(slot0._episodeId)
	slot0._chapterConfig = DungeonConfig.instance:getChapterCO(slot0.episodeConfig.chapterId)
	slot0._enterAfterFreeLimit = slot0:_getfreeCount() - slot0._multiplication >= 0 and slot2 - slot0._multiplication or false

	gohelper.setActive(slot0._btnrecommend.gameObject, slot0._chapterConfig.isHeroRecommend == 1)
	slot0:_refreshCost(true)
	slot0:_refreshCloth()
	slot0:_setTrialNumTips()
	slot0.viewContainer:setNavigateOverrideClose()
	gohelper.setActive(slot0._goReplayBtn, not HeroGroupBalanceHelper.getIsBalanceMode() and slot0.episodeConfig and slot0.episodeConfig.canUseRecord == 1 and slot0._chapterConfig.type ~= DungeonEnum.ChapterType.WeekWalk)
end

function slot0._refreshCost(slot0, slot1)
	gohelper.setActive(slot0._gocost, slot1)
	gohelper.setActive(slot0._gopower, not slot0._enterAfterFreeLimit)
	gohelper.setActive(slot0._gocount, not slot0._enterAfterFreeLimit and slot0:_getfreeCount() > 0)
	gohelper.setActive(slot0._gonormallackpower, false)
	gohelper.setActive(slot0._goreplaylackpower, false)

	if slot0._enterAfterFreeLimit or slot2 > 0 then
		slot3 = tostring(-1 * math.min(slot0._multiplication, slot2))
		slot0._txtCostNum.text = slot3
		slot0._txtReplayCostNum.text = slot3

		if slot0._multiplication <= slot2 then
			slot0:_refreshBtns(false)

			return
		end
	end

	slot0._simagepower:LoadImage(ResUrl.getCurrencyItemIcon(CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power).icon .. "_btn"))
	slot0:_refreshCostPower()
end

function slot0._refreshTips(slot0)
	recthelper.setAnchor(slot0._golevelchange.transform, slot0._enterAfterFreeLimit and -271.5 or -280, slot0._enterAfterFreeLimit and 163 or 165.5)
	recthelper.setAnchorY(slot0._gocount.transform, slot0._golevelchange.activeInHierarchy and not slot0._replayMode and 0 or -41.11)
	recthelper.setAnchorX(slot0._gocount.transform, -72)
	gohelper.setActive(slot0._btnmultispeed.gameObject, slot0._replayMode)

	slot0._gomultispeed.transform.position = slot0._gomultPos.transform.position
end

function slot0._refreshCostPower(slot0)
	slot4 = tonumber(string.split(string.split(slot0.episodeConfig.cost, "|")[1], "#")[3] or 0) > 0

	if slot0._enterAfterFreeLimit then
		slot4 = false
	end

	gohelper.setActive(slot0._gopower, slot4)
	slot0:_refreshBtns(slot4)

	if not slot4 then
		return
	end

	slot0._txtusepower.text = string.format("-%s", slot3 * ((slot0._multiplication or 1) - slot0:_getfreeCount()))

	if slot5 <= CurrencyModel.instance:getPower() then
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtusepower, slot0._replayMode and "#070706" or (slot0._chapterConfig.type == DungeonEnum.ChapterType.Hard and "#FFFFFF" or "#070706"))
	else
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtusepower, slot0._replayMode and "#800015" or (slot6 and "#C44945" or "#800015"))
		gohelper.setActive(slot0._gonormallackpower, not slot0._replayMode)
		gohelper.setActive(slot0._goreplaylackpower, slot0._replayMode)
	end
end

function slot0._dispatchGuideEvent(slot0)
	if slot0._replayMode then
		return
	end

	if not slot0:_isSpType(slot0._chapterConfig.type) then
		if not GuideInvalidCondition.checkAllGroupSetEquip() then
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnEnteryEquipType)
		end

		slot0:_dispatchRecordEvent()
		slot0:_dispatchNoEquipEvent()
	end
end

function slot0._dispatchGuideEventOnOpenFinish(slot0)
	if slot0._episodeId then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OpenHeroGroupFinishWithEpisodeId, slot0._episodeId)
	end
end

function slot0._dispatchNoEquipEvent(slot0)
	for slot5 = 1, 4 do
		if EquipModel.instance:getEquip(V1a6_CachotHeroGroupModel.instance:getCurGroupMO():getPosEquips(slot5 - 1).equipUid[1]) then
			return
		end
	end

	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnEnteryNormalType)
end

function slot0._isSpType(slot0, slot1)
	return slot1 == DungeonEnum.ChapterType.Sp or slot1 == DungeonEnum.ChapterType.TeachNote
end

function slot0._dispatchRecordEvent(slot0)
	if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightReplay) and (DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId) and slot2.hasRecord) then
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnHasRecord)
	end
end

function slot0.onClose(slot0)
	slot0:removeEventCb(HeroGroupController.instance, HeroGroupEvent.OnSnapshotSaveSucc, slot0._onModifySnapshot, slot0)
	slot0:removeEventCb(HelpController.instance, HelpEvent.RefreshHelp, slot0.isShowHelpBtnIcon, slot0)
	TaskDispatcher.cancelTask(slot0._checkDropArrow, slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
	ZProj.TweenHelper.KillById(slot0._tweeningId)
	HeroGroupBalanceHelper.clearBalanceStatus()

	if slot0._dragEffectLoader then
		slot0._dragEffectLoader:dispose()

		slot0._dragEffectLoader = nil
	end

	slot0:removeEventCb(HelpController.instance, HelpEvent.RefreshHelp, slot0.isShowHelpBtnIcon, slot0)
end

function slot0._refreshReplay(slot0)
	if slot0._chapterConfig.type == DungeonEnum.ChapterType.WeekWalk then
		gohelper.setActive(slot0._goReplayBtn, false)
	else
		slot2 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay)
		slot4 = DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId) and slot3.hasRecord

		ZProj.UGUIHelper.SetColorAlpha(slot0._imgbtnReplayBg, slot2 and slot4 and 1 or 0.75)
		UISpriteSetMgr.instance:setHeroGroupSprite(slot0._imagereplayicon, slot2 and slot4 and (slot0._replayMode and "btn_replay_pause" or "btn_replay_play") or "btn_replay_lack")
		recthelper.setWidth(slot0._goReplayBtn.transform, slot0._replayMode and 249.538 or 83)

		if OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightReplay) and slot4 and not slot0._replayMode then
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnHasRecord)
		end
	end
end

function slot0._refreshCloth(slot0)
	slot1 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.LeadRoleSkill)
	slot4 = PlayerClothModel.instance:getById(PlayerClothModel.instance:getSpEpisodeClothID() or V1a6_CachotHeroGroupModel.instance:getCurGroupMO().clothId)

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

	if PlayerClothModel.instance:getById(V1a6_CachotHeroGroupModel.instance:getCurGroupMO().clothId) then
		return
	end

	for slot6, slot7 in ipairs(PlayerClothModel.instance:getList()) do
		if PlayerClothModel.instance:hasCloth(slot7.id) then
			V1a6_CachotHeroGroupModel.instance:replaceCloth(slot7.id)
			HeroGroupController.instance:dispatchEvent(HeroGroupEvent.OnModifyHeroGroup)
			V1a6_CachotHeroGroupModel.instance:cachotSaveCurGroup()

			break
		end
	end
end

function slot0._getEpisodeConfigAndBattleConfig()
	slot1 = nil

	return DungeonConfig.instance:getEpisodeCO(HeroGroupModel.instance.episodeId), (not HeroGroupModel.instance.battleId or HeroGroupModel.instance.battleId <= 0 or lua_battle.configDict[HeroGroupModel.instance.battleId]) and DungeonConfig.instance:getBattleCo(HeroGroupModel.instance.episodeId)
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

	slot4 = PlayerClothModel.instance:getById(V1a6_CachotHeroGroupModel.instance:getCurGroupMO().clothId)
	slot6 = false

	for slot10, slot11 in ipairs(PlayerClothModel.instance:getList()) do
		slot6 = true

		break
	end

	return slot6
end

function slot0._onModifyHeroGroup(slot0)
	slot0:_refreshCloth()
end

function slot0._onModifySnapshot(slot0)
	slot0:_refreshCloth()
end

function slot0._onClickHeroGroupItem(slot0, slot1)
	slot0._param = {
		singleGroupMOId = slot1,
		originalHeroUid = V1a6_CachotHeroSingleGroupModel.instance:getHeroUid(slot1),
		adventure = V1a6_CachotHeroGroupModel.instance:isAdventureOrWeekWalk(),
		equips = V1a6_CachotHeroGroupModel.instance:getCurGroupMO():getPosEquips(slot1 - 1).equipUid,
		heroGroupEditType = V1a6_CachotEnum.HeroGroupEditType.Fight,
		seatLevel = V1a6_CachotTeamModel.instance:getSeatLevel(slot1)
	}

	ViewMgr.instance:openView(ViewName.V1a6_CachotHeroGroupEditView, slot0._param)
end

function slot0._checkFirstPosHasEquip(slot0)
	slot3 = V1a6_CachotHeroGroupModel.instance:getCurGroupMO():getPosEquips(0).equipUid and slot2[1]

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
	if CurrencyModel.instance:getPower() < tonumber(string.split(string.split(slot0.episodeConfig.cost, "|")[1], "#")[3] or 0) * ((slot0._multiplication or 1) - slot0:_getfreeCount()) then
		CurrencyController.instance:openPowerView()

		return
	end

	if HeroGroupModel.instance.episodeId == 10104 and not DungeonModel.instance:hasPassLevel(slot6) then
		for slot12, slot13 in ipairs(HeroSingleGroupModel.instance:getList()) do
			if not slot13:isEmpty() then
				slot8 = 0 + 1
			end
		end

		if slot8 < 2 then
			GameFacade.showToast(ToastEnum.HeroSingleGroupCount)

			return
		end
	end

	slot0:_closemultcontent()
	slot0:_enterFight()
end

function slot0._enterFight(slot0)
	if HeroGroupModel.instance.episodeId then
		slot0._closeWithEnteringFight = true

		if V1a6_CachotController.instance:setFightHeroGroup() then
			slot0.viewContainer:beforeEnterFight()

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
		slot0:_closemultcontent()

		slot0._replayMode = false
		slot0._multiplication = 1

		slot0:_refreshCost(true)
		slot0:_switchReplayGroup()
	end
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

	if not (DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId) and slot2.hasRecord) and (slot2 and slot2.star == DungeonEnum.StarType.Advanced) and (slot1 and slot1.firstBattleId > 0) then
		GameFacade.showToast(ToastEnum.CantRecordReplay)

		return
	end

	if slot2 and slot2.star == DungeonEnum.StarType.Advanced and not slot2.hasRecord then
		GameFacade.showToast(ToastEnum.HeroGroupStarAdvanced)

		return
	end

	if not slot2 or slot2 and slot2.star ~= DungeonEnum.StarType.Advanced then
		GameFacade.showToast(ToastEnum.HeroGroupStarNoAdvanced)

		return
	end

	slot6 = slot0._replayMode

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
	slot0:_refreshCost(true)

	if slot0._replayMode and not slot0._replayFightGroupMO then
		slot0:addEventCb(FightController.instance, FightEvent.RespGetFightRecordGroupReply, slot0._onGetFightRecordGroupReply, slot0)
		FightRpc.instance:sendGetFightRecordGroupRequest(HeroGroupModel.instance.episodeId)

		return
	end

	slot0:_switchReplayGroup(slot6)
end

function slot0._switchReplayGroup(slot0, slot1)
	slot0:_switchReplayMul()
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.PlayHeroGroupHeroEffect, slot0._replayMode and "swicth" or UIAnimationName.Open)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SwitchReplay, slot0._replayMode)

	if slot0._replayMode then
		slot0._goLevelChangePosX = slot0._goLevelChangePosX or recthelper.getAnchorX(slot0._golevelchange.transform)

		recthelper.setAnchorX(slot0._golevelchange.transform, 10000)
		slot0:_updateReplayHeroGorupList()

		slot2 = formatLuaLang("herogroupview_replaycn", GameUtil.getNum2Chinese(slot0._multiplication))
		slot0._txtreplaycn.text = slot2
		slot0._txtreplayhardcn.text = slot2
		slot0._txtreplayunpowercn.text = slot2
	else
		if slot0._goLevelChangePosX then
			recthelper.setAnchorX(slot0._golevelchange.transform, slot0._goLevelChangePosX)
		end

		V1a6_CachotHeroGroupModel.instance:setParam(V1a6_CachotHeroGroupModel.instance.battleId, V1a6_CachotHeroGroupModel.instance.episodeId, V1a6_CachotHeroGroupModel.instance.adventure)
		HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, V1a6_CachotHeroGroupModel.instance:getCurGroupMO().id)
		slot0:_refreshCloth()
		gohelper.setActive(slot0._goherogroupcontain, false)
		gohelper.setActive(slot0._goherogroupcontain, true)
	end
end

function slot0._switchReplayMul(slot0)
	if slot0._replayMode then
		slot0:setMultSpeed(slot0._multiplication)
	else
		slot0:_refreshUI()
		slot0:_refreshTips()
	end

	slot0:_refreshCost(true)
	slot0:_refreshPowerShow()
	gohelper.setActive(slot0._goreplayready, slot0._replayMode)
	UISpriteSetMgr.instance:setHeroGroupSprite(slot0._imagereplayicon, not slot0:_haveRecord() and "btn_replay_lack" or slot0._replayMode and "btn_replay_pause" or "btn_replay_play")
	recthelper.setWidth(slot0._goReplayBtn.transform, slot0._replayMode and 249.538 or 83)
	ZProj.UGUIHelper.RebuildLayout(slot0._goReplayBtn.transform.parent)
	gohelper.setActive(slot0._goreplaybtnframe, slot0._replayMode)
end

function slot0._haveRecord(slot0)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.FightReplay) then
		return false
	end

	if DungeonModel.instance:getEpisodeInfo(HeroGroupModel.instance.episodeId) and slot1.star == DungeonEnum.StarType.Advanced and not slot1.hasRecord then
		return false
	end

	if not slot1 or slot1 and slot1.star ~= DungeonEnum.StarType.Advanced then
		return false
	end

	return true
end

function slot0._refreshBtns(slot0, slot1)
	gohelper.setActive(slot0._btnBalanceStart, HeroGroupBalanceHelper.getIsBalanceMode() and not slot0._replayMode and slot0._chapterConfig.type ~= DungeonEnum.ChapterType.Hard)
	gohelper.setActive(slot0._btnUnPowerBalanceStart, slot2 and not slot0._replayMode and slot0._chapterConfig.type == DungeonEnum.ChapterType.Hard)

	slot3 = slot0._enterAfterFreeLimit or slot0:_getfreeCount() > 0

	gohelper.setActive(slot0._btnstartreplay.gameObject, slot1 and slot0._replayMode and slot0._chapterConfig.type ~= DungeonEnum.ChapterType.Hard)
	gohelper.setActive(slot0._btnunpowerreplay.gameObject, not slot1 and not slot3 and slot0._replayMode)
	gohelper.setActive(slot0._btnunpowerstart.gameObject, not slot2 and not slot1 and not slot3 and not slot0._replayMode)
	gohelper.setActive(slot0._btncostreplay.gameObject, not slot1 and slot3 and slot0._replayMode)
	gohelper.setActive(slot0._btncoststart.gameObject, not slot2 and not slot1 and slot3 and not slot0._replayMode)
	gohelper.setActive(slot0._btnhardreplay.gameObject, slot1 and slot0._replayMode and slot0._chapterConfig.type == DungeonEnum.ChapterType.Hard)
	gohelper.setActive(slot0._btnstart.gameObject, not slot2 and slot1 and not slot0._replayMode and slot0._chapterConfig.type ~= DungeonEnum.ChapterType.Hard)
	gohelper.setActive(slot0._btnstarthard.gameObject, not slot2 and slot1 and not slot0._replayMode and slot0._chapterConfig.type == DungeonEnum.ChapterType.Hard)

	slot4 = not slot0._replayMode and slot0:_noAidHero()

	gohelper.setActive(slot0._dropherogroup, slot4)

	if slot4 then
		TaskDispatcher.runRepeat(slot0._checkDropArrow, slot0, 0)
	else
		TaskDispatcher.cancelTask(slot0._checkDropArrow, slot0)
	end
end

function slot0._checkDropArrow(slot0)
	if not slot0._dropherogrouparrow then
		TaskDispatcher.cancelTask(slot0._checkDropArrow, slot0)

		return
	end

	if slot0._dropherogroup.transform.childCount ~= slot0._dropDownChildCount then
		slot0._dropDownChildCount = slot1

		transformhelper.setLocalScale(slot0._dropherogrouparrow, 1, slot0._dropgroupchildcount ~= slot1 and -1 or 1, 1)
	end
end

function slot0._noAidHero(slot0)
	if not lua_battle.configDict[HeroGroupModel.instance.battleId] then
		return
	end

	return slot2.trialLimit <= 0 and string.nilorempty(slot2.aid) and string.nilorempty(slot2.trialHeros) and string.nilorempty(slot2.trialEquips)
end

function slot0._onGetFightRecordGroupReply(slot0, slot1)
	slot0:removeEventCb(FightController.instance, FightEvent.RespGetFightRecordGroupReply, slot0._onGetFightRecordGroupReply, slot0)

	slot0._replayFightGroupMO = slot1

	if not slot0._replayMode then
		return
	end

	slot0:_switchReplayGroup()
	slot0:_updateReplayHeroGorupList()
end

function slot0._updateReplayHeroGorupList(slot0)
	V1a6_CachotHeroGroupModel.instance:setReplayParam(slot0._replayFightGroupMO)
	HeroGroupController.instance:dispatchEvent(HeroGroupEvent.SelectHeroGroup, slot0._replayFightGroupMO.id)
	slot0:_refreshCloth()
	gohelper.setActive(slot0._goherogroupcontain, false)
	gohelper.setActive(slot0._goherogroupcontain, true)
end

return slot0
