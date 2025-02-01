module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity1_2DungeonView", package.seeall)

slot0 = class("VersionActivity1_2DungeonView", BaseViewExtended)

function slot0.onInitView(slot0)
	slot0._imagehardModeIconTxtGo = gohelper.findChild(slot0.viewGO, "#go_tasklist/#go_versionActivity/#go_hardmode/#image_hardModeIcon/txt")
	slot0._topLeftGo = gohelper.findChild(slot0.viewGO, "top_left")
	slot0._topRight = gohelper.findChild(slot0.viewGO, "topRight")
	slot0._topRightGo = gohelper.findChild(slot0.viewGO, "#go_topright")
	slot0._topLeftElementGo = gohelper.findChild(slot0.viewGO, "top_left_element")
	slot0._gotasklist = gohelper.findChild(slot0.viewGO, "#go_tasklist")
	slot0._goversionactivity = gohelper.findChild(slot0.viewGO, "#go_tasklist/#go_versionActivity")
	slot0._gomain = gohelper.findChild(slot0.viewGO, "#go_main")
	slot0._gores = gohelper.findChild(slot0.viewGO, "#go_res")
	slot0._gointeractiveroot = gohelper.findChild(slot0.viewGO, "#go_interactive_root")
	slot0._txtstorenum = gohelper.findChildText(slot0.viewGO, "#go_topright/#btn_activitystore/#txt_num")
	slot0._btn3 = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_3")
	slot0._gohardmodelock = gohelper.findChild(slot0.viewGO, "#go_tasklist/#go_versionActivity/#go_hardmode/#go_hardModeLock")
	slot0._txtunlocktime = gohelper.findChildText(slot0.viewGO, "#go_tasklist/#go_versionActivity/#go_hardmode/#go_hardModeLock/#txt_unlockTime")
	slot0._hardBtnAni = gohelper.onceAddComponent(slot0._gohardmodelock, typeof(UnityEngine.Animator))
	slot0._btnAni1 = gohelper.findChildComponent(slot0.viewGO, "#go_tasklist/#go_versionActivity", typeof(UnityEngine.Animator))
	slot0._btnAni2 = gohelper.findChildComponent(slot0.viewGO, "#go_tasklist/#go_taskitem", typeof(UnityEngine.Animator))
	slot0._btnAni3 = gohelper.findChildComponent(slot0.viewGO, "#btn_3", typeof(UnityEngine.Animator))
	slot0._btnAni4 = gohelper.findChildComponent(slot0.viewGO, "#btn_4", typeof(UnityEngine.Animator))
	slot0._rightBtnAni = gohelper.findChildComponent(slot0.viewGO, "#go_topright", typeof(UnityEngine.Animator))
	slot0._currencyNum = gohelper.findChildText(slot0.viewGO, "#btn_4/icon/cost/num")
	slot0._currencyNumLvHuEMen = gohelper.findChildText(slot0.viewGO, "#go_topright/GameObject/#btn_1/node/num")
	slot0._focusBtnStateOff = gohelper.findChild(slot0.viewGO, "#btn_4/icon/#go_off")
	slot0._focusBtnStateOn = gohelper.findChild(slot0.viewGO, "#btn_4/icon/#go_on")
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#go_versionActivityBg/#simage_bg")
	slot0._simagebgeffect = gohelper.findChildSingleImage(slot0.viewGO, "#go_versionActivityBg/#simage_bgeffect")
	slot0._simagehardbg = gohelper.findChildSingleImage(slot0.viewGO, "#go_versionActivityBg/#simage_hardbg")
	slot0._btncloseview = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_closeview")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseView, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.refreshActivityCurrency, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, slot0._onUpdateDungeonInfo, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, slot0._onSetEpisodeListVisible, slot0)
	slot0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.showNoteUnlock, slot0._showNoteUnlock, slot0)
	slot0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.onReceiveAct121UpdatePush, slot0._onReceiveAct121UpdatePush, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0._onCurrencyChange, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, slot0._OnRemoveElement, slot0)
	slot0._btn3:AddClickListener(slot0._onClickBtn3, slot0)
	slot0._storeBtn:AddClickListener(slot0._onClickStoreBtn, slot0)
	slot0._taskBtn:AddClickListener(slot0._onClickTaskBtn, slot0)
	slot0._btncloseview:AddClickListener(slot0._btncloseviewOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btn3:RemoveClickListener()
	slot0._storeBtn:RemoveClickListener()
	slot0._taskBtn:RemoveClickListener()
	slot0._btncloseview:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gotasklist, true)
	gohelper.setActive(slot0._goversionactivity, true)
	gohelper.setActive(slot0._gomain, false)
	gohelper.setActive(slot0._gores, false)

	slot0._storeBtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_topright/GameObject/#btn_1")
	slot0._taskBtn = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_topright/GameObject/#btn_2", AudioEnum.UI.play_ui_mission_open)

	RedDotController.instance:addRedDot(gohelper.findChild(slot0._taskBtn.gameObject, "reddot"), RedDotEnum.DotNode.LvHuEMenTask)
	slot0._simagebg:LoadImage(ResUrl.getVersionActivityDungeon_1_2("bj_zasehuahen"))
	slot0._simagebgeffect:LoadImage(ResUrl.getVersionActivityDungeon_1_2("bj_zasehuahen"))
	slot0._simagehardbg:LoadImage(ResUrl.getVersionActivityDungeon_1_2("lvjing_kunnan"))
	gohelper.removeUIClickAudio(slot0._btncloseview.gameObject)

	slot0._scrollcontent = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_content")
	slot0._rectmask2D = slot0._scrollcontent:GetComponent(typeof(UnityEngine.UI.RectMask2D))

	gohelper.setActive(slot0._storeBtn, false)
	gohelper.setActive(slot0._taskBtn, false)
end

function slot0._btncloseviewOnClick(slot0)
	ViewMgr.instance:closeView(ViewName.VersionActivity1_2DungeonMapLevelView)
end

function slot0._onUpdateDungeonInfo(slot0)
	slot0:_detectHardModel()
end

function slot0._onClickStoreBtn(slot0)
	ReactivityController.instance:openReactivityStoreView(VersionActivity1_2Enum.ActivityId.Dungeon)
end

function slot0._onClickTaskBtn(slot0)
	ReactivityController.instance:openReactivityTaskView(VersionActivity1_2Enum.ActivityId.Dungeon)
end

function slot0._onClickBtn3(slot0)
	ViewMgr.instance:openView(ViewName.VersionActivity_1_2_StoryCollectView)
end

function slot0.onUpdateParam(slot0)
	slot0:refreshUI()
end

function slot0._onEscBtnClick(slot0)
	if slot0._interActiveItem and slot0._interActiveItem:getChildViews() and #slot1 > 0 then
		VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.closeChildElementView)

		return
	end

	slot0:closeThis()
end

function slot0._dimBgm(slot0, slot1)
	if slot1 then
		AudioMgr.instance:trigger(AudioEnum.UI.set_state_bgm_decrease)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.set_state_bgm_redecrease)
	end
end

function slot0.onOpen(slot0)
	slot0:refreshUI()
	NavigateMgr.instance:addEscape(ViewName.VersionActivity1_2DungeonView, slot0._onEscBtnClick, slot0)
	slot0:_detectHardModel()
	gohelper.setActive(slot0._btn3.gameObject, DungeonMapModel.instance:elementIsFinished(12101103))
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0.dailyRefresh, slot0)
	slot0:_dimBgm(true)
	slot0:_showNoteRedPoint()
	slot0:_showClueTips()
	slot0:_showCurrencyNum()

	if DungeonMapModel.instance:getElementById(12101091) then
		DungeonRpc.instance:sendMapElementRequest(12101091)
	end
end

function slot0._onCurrencyChange(slot0)
	slot0:_showCurrencyNum()
end

function slot0._showCurrencyNum(slot0)
	slot0._currencyNum.text = GameUtil.numberDisplay(CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.DryForest) and slot1.quantity or 0)
	slot0._currencyNumLvHuEMen.text = GameUtil.numberDisplay(CurrencyModel.instance:getCurrency(ReactivityModel.instance:getActivityCurrencyId(VersionActivity1_2Enum.ActivityId.Dungeon)) and slot1.quantity or 0)
end

function slot0.dailyRefresh(slot0)
	slot0:_detectHardModel()
end

function slot0._detectHardModel(slot0)
	slot1 = VersionActivity1_2DungeonMapEpisodeView.hardModelIsOpen(slot0)

	gohelper.setActive(slot0._imagehardModeIconTxtGo, slot1)
	gohelper.setActive(slot0._gohardmodelock, not slot1)

	if not slot1 then
		slot0._hardBtnAni:Play("idle", 0, 0)

		if ServerTime.now() < VersionActivityConfig.instance:getAct113DungeonChapterOpenTimeStamp(VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonHard) then
			slot5 = slot3 - slot4
			slot8 = Mathf.Floor(slot5 % TimeUtil.OneDaySecond / TimeUtil.OneHourSecond)

			if Mathf.Floor(slot5 / TimeUtil.OneDaySecond) > 0 then
				if slot8 > 0 then
					slot10 = ActivityModel.instance:getActivityInfo()[VersionActivity1_2Enum.ActivityId.Dungeon]:getRemainTimeStr2(slot5) .. slot8 .. luaLang("time_hour2")
				end

				slot0._txtunlocktime.text = string.format(luaLang("seasonmainview_timeopencondition"), slot10)
			else
				slot0._txtunlocktime.text = string.format(luaLang("seasonmainview_timeopencondition"), slot9:getRemainTimeStr2(slot5))
			end

			return
		end

		slot5, slot6 = DungeonModel.instance:chapterIsUnLock(VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonHard)
		slot0._txtunlocktime.text = string.format(luaLang("dungeon_unlock_episode_mode"), DungeonConfig.instance:getChapterCO(slot2).chapterIndex .. "-" .. VersionActivity1_2DungeonConfig.instance:getEpisodeIndex(slot6))
	elseif uv0.getHardModelUnlockAniFinish() == 0 then
		gohelper.setActive(slot0._gohardmodelock, true)

		slot0._txtunlocktime.text = ""

		gohelper.setActive(gohelper.findChild(slot0._gohardmodelock, "icon"), false)
		uv0.setHardModelUnlockAniFinish()
		slot0._hardBtnAni:Play("unlock")
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_unlock)
	end
end

function slot0.getHardModelUnlockAniFinish()
	return PlayerPrefsHelper.getNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Fight1_2HardModelUnlockAniFinish, 0)
end

function slot0.setHardModelUnlockAniFinish()
	return PlayerPrefsHelper.setNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Fight1_2HardModelUnlockAniFinish, 1)
end

function slot0._onReceiveGet116InfosReply(slot0)
end

function slot0.refreshUI(slot0)
	if slot0.viewParam and slot1.jumpParam then
		if slot1.jumpParam == JumpEnum.Activity1_2DungeonJump.Shop then
			ReactivityController.instance:openReactivityStoreView(VersionActivity1_2Enum.ActivityId.Dungeon)
		elseif slot1.jumpParam == JumpEnum.Activity1_2DungeonJump.Task then
			ReactivityController.instance:openReactivityTaskView(VersionActivity1_2Enum.ActivityId.Dungeon)
		end

		slot1.jumpParam = nil
	end
end

function slot0.refreshActivityCurrency(slot0)
end

function slot0._onReceiveAct121UpdatePush(slot0)
	slot0:_showClueTips()
end

function slot0.openMapInteractiveItem(slot0)
	slot0._interActiveItem = slot0._interActiveItem or slot0:openSubView(DungeonMapInteractive1_2Item, slot0._gointeractiveroot)

	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, false)

	return slot0._interActiveItem
end

function slot0._onSetEpisodeListVisible(slot0, slot1)
	slot0:_setViewVisible(slot1)
end

function slot0._setViewVisible(slot0, slot1)
	if slot1 then
		slot0._btnAni1:Play("open")
		slot0._btnAni2:Play("taskitem_in")
		slot0._btnAni3:Play("open")
		slot0._btnAni4:Play("open")
		slot0._rightBtnAni:Play("open")

		slot0._rectmask2D.padding = Vector4(0, 0, 0, 0)
	else
		slot0._btnAni1:Play("close")
		slot0._btnAni2:Play("taskitem_out")
		slot0._btnAni3:Play("close")
		slot0._btnAni4:Play("close")
		slot0._rightBtnAni:Play("close")

		slot0._rectmask2D.padding = Vector4(0, 0, 600, 0)
	end

	gohelper.setActive(slot0._topLeftGo, slot1)
	gohelper.setActive(slot0._topRight, slot1)
	gohelper.setActive(slot0._btncloseview, not slot1)
end

function slot0._onOpenView(slot0, slot1)
	if slot1 == ViewName.VersionActivity1_2DungeonMapLevelView then
		slot0:_setViewVisible()
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.VersionActivity1_2DungeonMapLevelView then
		slot0:_setViewVisible(true)
	elseif slot1 == ViewName.VersionActivity_1_2_StoryCollectView then
		slot0:_showNoteRedPoint()
	elseif slot1 == ViewName.CommonPropView and slot0._needShowNoteUnlock then
		slot0._needShowNoteUnlock = false

		gohelper.setActive(slot0._btn3.gameObject, true)
		gohelper.onceAddComponent(slot0._btn3.gameObject, typeof(UnityEngine.Animator)):Play("unlock")
	end
end

function slot0._showNoteUnlock(slot0)
	slot0._needShowNoteUnlock = true
end

function slot0._showNoteRedPoint(slot0)
	gohelper.setActive(gohelper.findChild(slot0._btn3.gameObject, "redPoint"), VersionActivity_1_2_StoryCollectView.getRedPoint())
end

function slot0._showClueTips(slot0)
	slot0._clueTips = FlowSequence.New()

	slot0._clueTips:addWork(FightWork1_2ClueTips.New())
	slot0._clueTips:start()
end

function slot0._OnRemoveElement(slot0, slot1)
	if slot1 == 12101091 then
		VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.afterCollectLastShow)
	end
end

function slot0.onClose(slot0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, slot0.dailyRefresh, slot0)
	UIBlockMgr.instance:endBlock(slot0.viewName)
	slot0:_dimBgm(false)

	if slot0._clueTips then
		slot0._clueTips:stop()

		slot0._clueTips = nil
	end
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagebgeffect:UnLoadImage()
	slot0._simagehardbg:UnLoadImage()
end

return slot0
