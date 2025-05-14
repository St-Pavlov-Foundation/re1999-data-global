module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.view.VersionActivity1_2DungeonView", package.seeall)

local var_0_0 = class("VersionActivity1_2DungeonView", BaseViewExtended)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._imagehardModeIconTxtGo = gohelper.findChild(arg_1_0.viewGO, "#go_tasklist/#go_versionActivity/#go_hardmode/#image_hardModeIcon/txt")
	arg_1_0._topLeftGo = gohelper.findChild(arg_1_0.viewGO, "top_left")
	arg_1_0._topRight = gohelper.findChild(arg_1_0.viewGO, "topRight")
	arg_1_0._topRightGo = gohelper.findChild(arg_1_0.viewGO, "#go_topright")
	arg_1_0._topLeftElementGo = gohelper.findChild(arg_1_0.viewGO, "top_left_element")
	arg_1_0._gotasklist = gohelper.findChild(arg_1_0.viewGO, "#go_tasklist")
	arg_1_0._goversionactivity = gohelper.findChild(arg_1_0.viewGO, "#go_tasklist/#go_versionActivity")
	arg_1_0._gomain = gohelper.findChild(arg_1_0.viewGO, "#go_main")
	arg_1_0._gores = gohelper.findChild(arg_1_0.viewGO, "#go_res")
	arg_1_0._gointeractiveroot = gohelper.findChild(arg_1_0.viewGO, "#go_interactive_root")
	arg_1_0._txtstorenum = gohelper.findChildText(arg_1_0.viewGO, "#go_topright/#btn_activitystore/#txt_num")
	arg_1_0._btn3 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_3")
	arg_1_0._gohardmodelock = gohelper.findChild(arg_1_0.viewGO, "#go_tasklist/#go_versionActivity/#go_hardmode/#go_hardModeLock")
	arg_1_0._txtunlocktime = gohelper.findChildText(arg_1_0.viewGO, "#go_tasklist/#go_versionActivity/#go_hardmode/#go_hardModeLock/#txt_unlockTime")
	arg_1_0._hardBtnAni = gohelper.onceAddComponent(arg_1_0._gohardmodelock, typeof(UnityEngine.Animator))
	arg_1_0._btnAni1 = gohelper.findChildComponent(arg_1_0.viewGO, "#go_tasklist/#go_versionActivity", typeof(UnityEngine.Animator))
	arg_1_0._btnAni2 = gohelper.findChildComponent(arg_1_0.viewGO, "#go_tasklist/#go_taskitem", typeof(UnityEngine.Animator))
	arg_1_0._btnAni3 = gohelper.findChildComponent(arg_1_0.viewGO, "#btn_3", typeof(UnityEngine.Animator))
	arg_1_0._btnAni4 = gohelper.findChildComponent(arg_1_0.viewGO, "#btn_4", typeof(UnityEngine.Animator))
	arg_1_0._rightBtnAni = gohelper.findChildComponent(arg_1_0.viewGO, "#go_topright", typeof(UnityEngine.Animator))
	arg_1_0._currencyNum = gohelper.findChildText(arg_1_0.viewGO, "#btn_4/icon/cost/num")
	arg_1_0._currencyNumLvHuEMen = gohelper.findChildText(arg_1_0.viewGO, "#go_topright/GameObject/#btn_1/node/num")
	arg_1_0._focusBtnStateOff = gohelper.findChild(arg_1_0.viewGO, "#btn_4/icon/#go_off")
	arg_1_0._focusBtnStateOn = gohelper.findChild(arg_1_0.viewGO, "#btn_4/icon/#go_on")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_versionActivityBg/#simage_bg")
	arg_1_0._simagebgeffect = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_versionActivityBg/#simage_bgeffect")
	arg_1_0._simagehardbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_versionActivityBg/#simage_hardbg")
	arg_1_0._btncloseview = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closeview")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_2_0._onOpenView, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0._onCloseView, arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0.refreshActivityCurrency, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateDungeonInfo, arg_2_0._onUpdateDungeonInfo, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnSetEpisodeListVisible, arg_2_0._onSetEpisodeListVisible, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.showNoteUnlock, arg_2_0._showNoteUnlock, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_2DungeonController.instance, VersionActivity1_2DungeonEvent.onReceiveAct121UpdatePush, arg_2_0._onReceiveAct121UpdatePush, arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0._onCurrencyChange, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, arg_2_0._OnRemoveElement, arg_2_0)
	arg_2_0._btn3:AddClickListener(arg_2_0._onClickBtn3, arg_2_0)
	arg_2_0._storeBtn:AddClickListener(arg_2_0._onClickStoreBtn, arg_2_0)
	arg_2_0._taskBtn:AddClickListener(arg_2_0._onClickTaskBtn, arg_2_0)
	arg_2_0._btncloseview:AddClickListener(arg_2_0._btncloseviewOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btn3:RemoveClickListener()
	arg_3_0._storeBtn:RemoveClickListener()
	arg_3_0._taskBtn:RemoveClickListener()
	arg_3_0._btncloseview:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	gohelper.setActive(arg_4_0._gotasklist, true)
	gohelper.setActive(arg_4_0._goversionactivity, true)
	gohelper.setActive(arg_4_0._gomain, false)
	gohelper.setActive(arg_4_0._gores, false)

	arg_4_0._storeBtn = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "#go_topright/GameObject/#btn_1")
	arg_4_0._taskBtn = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "#go_topright/GameObject/#btn_2", AudioEnum.UI.play_ui_mission_open)

	local var_4_0 = gohelper.findChild(arg_4_0._taskBtn.gameObject, "reddot")

	RedDotController.instance:addRedDot(var_4_0, RedDotEnum.DotNode.LvHuEMenTask)
	arg_4_0._simagebg:LoadImage(ResUrl.getVersionActivityDungeon_1_2("bj_zasehuahen"))
	arg_4_0._simagebgeffect:LoadImage(ResUrl.getVersionActivityDungeon_1_2("bj_zasehuahen"))
	arg_4_0._simagehardbg:LoadImage(ResUrl.getVersionActivityDungeon_1_2("lvjing_kunnan"))
	gohelper.removeUIClickAudio(arg_4_0._btncloseview.gameObject)

	arg_4_0._scrollcontent = gohelper.findChildScrollRect(arg_4_0.viewGO, "#scroll_content")
	arg_4_0._rectmask2D = arg_4_0._scrollcontent:GetComponent(typeof(UnityEngine.UI.RectMask2D))

	gohelper.setActive(arg_4_0._storeBtn, false)
	gohelper.setActive(arg_4_0._taskBtn, false)
end

function var_0_0._btncloseviewOnClick(arg_5_0)
	ViewMgr.instance:closeView(ViewName.VersionActivity1_2DungeonMapLevelView)
end

function var_0_0._onUpdateDungeonInfo(arg_6_0)
	arg_6_0:_detectHardModel()
end

function var_0_0._onClickStoreBtn(arg_7_0)
	ReactivityController.instance:openReactivityStoreView(VersionActivity1_2Enum.ActivityId.Dungeon)
end

function var_0_0._onClickTaskBtn(arg_8_0)
	ReactivityController.instance:openReactivityTaskView(VersionActivity1_2Enum.ActivityId.Dungeon)
end

function var_0_0._onClickBtn3(arg_9_0)
	ViewMgr.instance:openView(ViewName.VersionActivity_1_2_StoryCollectView)
end

function var_0_0.onUpdateParam(arg_10_0)
	arg_10_0:refreshUI()
end

function var_0_0._onEscBtnClick(arg_11_0)
	if arg_11_0._interActiveItem then
		local var_11_0 = arg_11_0._interActiveItem:getChildViews()

		if var_11_0 and #var_11_0 > 0 then
			VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.closeChildElementView)

			return
		end
	end

	arg_11_0:closeThis()
end

function var_0_0._dimBgm(arg_12_0, arg_12_1)
	if arg_12_1 then
		AudioMgr.instance:trigger(AudioEnum.UI.set_state_bgm_decrease)
	else
		AudioMgr.instance:trigger(AudioEnum.UI.set_state_bgm_redecrease)
	end
end

function var_0_0.onOpen(arg_13_0)
	arg_13_0:refreshUI()
	NavigateMgr.instance:addEscape(ViewName.VersionActivity1_2DungeonView, arg_13_0._onEscBtnClick, arg_13_0)
	arg_13_0:_detectHardModel()
	gohelper.setActive(arg_13_0._btn3.gameObject, DungeonMapModel.instance:elementIsFinished(12101103))
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_13_0.dailyRefresh, arg_13_0)
	arg_13_0:_dimBgm(true)
	arg_13_0:_showNoteRedPoint()
	arg_13_0:_showClueTips()
	arg_13_0:_showCurrencyNum()

	if DungeonMapModel.instance:getElementById(12101091) then
		DungeonRpc.instance:sendMapElementRequest(12101091)
	end
end

function var_0_0._onCurrencyChange(arg_14_0)
	arg_14_0:_showCurrencyNum()
end

function var_0_0._showCurrencyNum(arg_15_0)
	local var_15_0 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.DryForest)
	local var_15_1 = var_15_0 and var_15_0.quantity or 0

	arg_15_0._currencyNum.text = GameUtil.numberDisplay(var_15_1)

	local var_15_2 = ReactivityModel.instance:getActivityCurrencyId(VersionActivity1_2Enum.ActivityId.Dungeon)
	local var_15_3 = CurrencyModel.instance:getCurrency(var_15_2)
	local var_15_4 = var_15_3 and var_15_3.quantity or 0

	arg_15_0._currencyNumLvHuEMen.text = GameUtil.numberDisplay(var_15_4)
end

function var_0_0.dailyRefresh(arg_16_0)
	arg_16_0:_detectHardModel()
end

function var_0_0._detectHardModel(arg_17_0)
	local var_17_0 = VersionActivity1_2DungeonMapEpisodeView.hardModelIsOpen(arg_17_0)

	gohelper.setActive(arg_17_0._imagehardModeIconTxtGo, var_17_0)
	gohelper.setActive(arg_17_0._gohardmodelock, not var_17_0)

	if not var_17_0 then
		local var_17_1 = VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonHard

		arg_17_0._hardBtnAni:Play("idle", 0, 0)

		local var_17_2 = VersionActivityConfig.instance:getAct113DungeonChapterOpenTimeStamp(var_17_1)
		local var_17_3 = ServerTime.now()

		if var_17_3 < var_17_2 then
			local var_17_4 = var_17_2 - var_17_3
			local var_17_5 = Mathf.Floor(var_17_4 / TimeUtil.OneDaySecond)
			local var_17_6 = var_17_4 % TimeUtil.OneDaySecond
			local var_17_7 = Mathf.Floor(var_17_6 / TimeUtil.OneHourSecond)
			local var_17_8 = ActivityModel.instance:getActivityInfo()[VersionActivity1_2Enum.ActivityId.Dungeon]

			if var_17_5 > 0 then
				local var_17_9 = var_17_8:getRemainTimeStr2(var_17_4)

				if var_17_7 > 0 then
					var_17_9 = var_17_9 .. var_17_7 .. luaLang("time_hour2")
				end

				arg_17_0._txtunlocktime.text = string.format(luaLang("seasonmainview_timeopencondition"), var_17_9)
			else
				arg_17_0._txtunlocktime.text = string.format(luaLang("seasonmainview_timeopencondition"), var_17_8:getRemainTimeStr2(var_17_4))
			end

			return
		end

		local var_17_10, var_17_11 = DungeonModel.instance:chapterIsUnLock(VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonHard)
		local var_17_12 = DungeonConfig.instance:getChapterCO(var_17_1)

		arg_17_0._txtunlocktime.text = string.format(luaLang("dungeon_unlock_episode_mode"), var_17_12.chapterIndex .. "-" .. VersionActivity1_2DungeonConfig.instance:getEpisodeIndex(var_17_11))
	elseif var_0_0.getHardModelUnlockAniFinish() == 0 then
		gohelper.setActive(arg_17_0._gohardmodelock, true)

		arg_17_0._txtunlocktime.text = ""

		gohelper.setActive(gohelper.findChild(arg_17_0._gohardmodelock, "icon"), false)
		var_0_0.setHardModelUnlockAniFinish()
		arg_17_0._hardBtnAni:Play("unlock")
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_unlock)
	end
end

function var_0_0.getHardModelUnlockAniFinish()
	return PlayerPrefsHelper.getNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Fight1_2HardModelUnlockAniFinish, 0)
end

function var_0_0.setHardModelUnlockAniFinish()
	return PlayerPrefsHelper.setNumber(PlayerModel.instance:getMyUserId() .. PlayerPrefsKey.Fight1_2HardModelUnlockAniFinish, 1)
end

function var_0_0._onReceiveGet116InfosReply(arg_20_0)
	return
end

function var_0_0.refreshUI(arg_21_0)
	local var_21_0 = arg_21_0.viewParam

	if var_21_0 and var_21_0.jumpParam then
		if var_21_0.jumpParam == JumpEnum.Activity1_2DungeonJump.Shop then
			ReactivityController.instance:openReactivityStoreView(VersionActivity1_2Enum.ActivityId.Dungeon)
		elseif var_21_0.jumpParam == JumpEnum.Activity1_2DungeonJump.Task then
			ReactivityController.instance:openReactivityTaskView(VersionActivity1_2Enum.ActivityId.Dungeon)
		end

		var_21_0.jumpParam = nil
	end
end

function var_0_0.refreshActivityCurrency(arg_22_0)
	return
end

function var_0_0._onReceiveAct121UpdatePush(arg_23_0)
	arg_23_0:_showClueTips()
end

function var_0_0.openMapInteractiveItem(arg_24_0)
	arg_24_0._interActiveItem = arg_24_0._interActiveItem or arg_24_0:openSubView(DungeonMapInteractive1_2Item, arg_24_0._gointeractiveroot)

	DungeonController.instance:dispatchEvent(DungeonEvent.OnSetEpisodeListVisible, false)

	return arg_24_0._interActiveItem
end

function var_0_0._onSetEpisodeListVisible(arg_25_0, arg_25_1)
	arg_25_0:_setViewVisible(arg_25_1)
end

function var_0_0._setViewVisible(arg_26_0, arg_26_1)
	if arg_26_1 then
		arg_26_0._btnAni1:Play("open")
		arg_26_0._btnAni2:Play("taskitem_in")
		arg_26_0._btnAni3:Play("open")
		arg_26_0._btnAni4:Play("open")
		arg_26_0._rightBtnAni:Play("open")

		arg_26_0._rectmask2D.padding = Vector4(0, 0, 0, 0)
	else
		arg_26_0._btnAni1:Play("close")
		arg_26_0._btnAni2:Play("taskitem_out")
		arg_26_0._btnAni3:Play("close")
		arg_26_0._btnAni4:Play("close")
		arg_26_0._rightBtnAni:Play("close")

		arg_26_0._rectmask2D.padding = Vector4(0, 0, 600, 0)
	end

	gohelper.setActive(arg_26_0._topLeftGo, arg_26_1)
	gohelper.setActive(arg_26_0._topRight, arg_26_1)
	gohelper.setActive(arg_26_0._btncloseview, not arg_26_1)
end

function var_0_0._onOpenView(arg_27_0, arg_27_1)
	if arg_27_1 == ViewName.VersionActivity1_2DungeonMapLevelView then
		arg_27_0:_setViewVisible()
	end
end

function var_0_0._onCloseView(arg_28_0, arg_28_1)
	if arg_28_1 == ViewName.VersionActivity1_2DungeonMapLevelView then
		arg_28_0:_setViewVisible(true)
	elseif arg_28_1 == ViewName.VersionActivity_1_2_StoryCollectView then
		arg_28_0:_showNoteRedPoint()
	elseif arg_28_1 == ViewName.CommonPropView and arg_28_0._needShowNoteUnlock then
		arg_28_0._needShowNoteUnlock = false

		gohelper.setActive(arg_28_0._btn3.gameObject, true)
		gohelper.onceAddComponent(arg_28_0._btn3.gameObject, typeof(UnityEngine.Animator)):Play("unlock")
	end
end

function var_0_0._showNoteUnlock(arg_29_0)
	arg_29_0._needShowNoteUnlock = true
end

function var_0_0._showNoteRedPoint(arg_30_0)
	local var_30_0 = gohelper.findChild(arg_30_0._btn3.gameObject, "redPoint")

	gohelper.setActive(var_30_0, VersionActivity_1_2_StoryCollectView.getRedPoint())
end

function var_0_0._showClueTips(arg_31_0)
	arg_31_0._clueTips = FlowSequence.New()

	arg_31_0._clueTips:addWork(FightWork1_2ClueTips.New())
	arg_31_0._clueTips:start()
end

function var_0_0._OnRemoveElement(arg_32_0, arg_32_1)
	if arg_32_1 == 12101091 then
		VersionActivity1_2DungeonController.instance:dispatchEvent(VersionActivity1_2DungeonEvent.afterCollectLastShow)
	end
end

function var_0_0.onClose(arg_33_0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, arg_33_0.dailyRefresh, arg_33_0)
	UIBlockMgr.instance:endBlock(arg_33_0.viewName)
	arg_33_0:_dimBgm(false)

	if arg_33_0._clueTips then
		arg_33_0._clueTips:stop()

		arg_33_0._clueTips = nil
	end
end

function var_0_0.onDestroyView(arg_34_0)
	arg_34_0._simagebg:UnLoadImage()
	arg_34_0._simagebgeffect:UnLoadImage()
	arg_34_0._simagehardbg:UnLoadImage()
end

return var_0_0
