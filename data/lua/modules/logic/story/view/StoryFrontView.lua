module("modules.logic.story.view.StoryFrontView", package.seeall)

local var_0_0 = class("StoryFrontView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._gobtnleft = gohelper.findChild(arg_1_0.viewGO, "#go_btns/#go_btnleft")
	arg_1_0._btnlog = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_btns/#go_btnleft/#btn_log")
	arg_1_0._btnhide = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_btns/#go_btnleft/#btn_hide")
	arg_1_0._gobtnright = gohelper.findChild(arg_1_0.viewGO, "#go_btns/#go_btnright")
	arg_1_0._btnauto = gohelper.findChildButtonWithAudio(arg_1_0._gobtnright, "#btn_auto")
	arg_1_0._txtauto = gohelper.findChildTextMesh(arg_1_0._gobtnright, "#btn_auto/txt_Auto")
	arg_1_0._imageautooff = gohelper.findChildImage(arg_1_0._gobtnright, "#btn_auto/#image_autooff")
	arg_1_0._imageautoon = gohelper.findChildImage(arg_1_0._gobtnright, "#btn_auto/#image_autoon")
	arg_1_0._imageautotxt = gohelper.findChildImage(arg_1_0._gobtnright, "#btn_auto/#image_autotxt")
	arg_1_0._btnskip = gohelper.findChildButtonWithAudio(arg_1_0._gobtnright, "#btn_skip")
	arg_1_0._objskip = arg_1_0._btnskip.gameObject
	arg_1_0._txtskip = gohelper.findChildTextMesh(arg_1_0._gobtnright, "#btn_skip/txt_skip")
	arg_1_0._imageskip = gohelper.findChildImage(arg_1_0._gobtnright, "#btn_skip/#image_skip")
	arg_1_0._imageskiptxt = gohelper.findChildImage(arg_1_0._gobtnright, "#btn_skip/#image_skiptxt")
	arg_1_0._gopvpause = gohelper.findChild(arg_1_0.viewGO, "#go_pvpause")
	arg_1_0._pvpauseAnim = arg_1_0._gopvpause:GetComponent(gohelper.Type_Animator)
	arg_1_0._btnpause = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_pvpause/#btn_Pause")
	arg_1_0._btnplay = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_pvpause/#btn_Play")
	arg_1_0._goexit = gohelper.findChild(arg_1_0.viewGO, "#btn_exit")
	arg_1_0._txtexit = gohelper.findChildTextMesh(arg_1_0.viewGO, "#btn_exit/txt_exit")
	arg_1_0._imageexit = gohelper.findChildImage(arg_1_0.viewGO, "#btn_exit/#image_exit")
	arg_1_0._imageexittxt = gohelper.findChildImage(arg_1_0.viewGO, "#btn_exit/#image_exittxt")
	arg_1_0._goshadow = gohelper.findChild(arg_1_0.viewGO, "#go_shadow")
	arg_1_0._gofront = gohelper.findChild(arg_1_0.viewGO, "#go_front")
	arg_1_0._goblock = gohelper.findChild(arg_1_0.viewGO, "#go_front/#go_block")
	arg_1_0._gonavigate = gohelper.findChild(arg_1_0.viewGO, "#go_navigate")
	arg_1_0._goepisode = gohelper.findChild(arg_1_0.viewGO, "#go_navigate/#go_episode")
	arg_1_0._gochapteropen = gohelper.findChild(arg_1_0.viewGO, "#go_navigate/#go_chapter/#go_open")
	arg_1_0._gochapterclose = gohelper.findChild(arg_1_0.viewGO, "#go_navigate/#go_chapter/#go_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnlog:AddClickListener(arg_2_0._btnlogOnClick, arg_2_0)
	arg_2_0._btnhide:AddClickListener(arg_2_0._btnhideOnClick, arg_2_0)
	arg_2_0._btnauto:AddClickListener(arg_2_0._btnautoOnClick, arg_2_0)
	arg_2_0._btnskip:AddClickListener(arg_2_0._btnskipOnClick, arg_2_0)
	arg_2_0._btnpause:AddClickListener(arg_2_0._btnpauseOnClick, arg_2_0)
	arg_2_0._btnplay:AddClickListener(arg_2_0._btnplayOnClick, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogAuto, arg_2_0._btnautoOnClick, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogSkip, arg_2_0._btnskipOnClick, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogExit, arg_2_0._onKeyExit, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnlog:RemoveClickListener()
	arg_3_0._btnhide:RemoveClickListener()
	arg_3_0._btnauto:RemoveClickListener()
	arg_3_0._btnskip:RemoveClickListener()
	arg_3_0._btnpause:RemoveClickListener()
	arg_3_0._btnplay:RemoveClickListener()
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogAuto, arg_3_0._btnautoOnClick, arg_3_0)
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogSkip, arg_3_0._btnskipOnClick, arg_3_0)
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogExit, arg_3_0._onKeyExit, arg_3_0)
end

function var_0_0._btnpauseOnClick(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._playFinished, arg_4_0)
	UIBlockMgr.instance:endBlock("PlayPv")
	StoryModel.instance:setStoryPvPause(true)
	gohelper.setActive(arg_4_0._gopvpause, true)
	gohelper.setActive(arg_4_0._objskip, true)
	arg_4_0._pvpauseAnim:Play("pause", 0, 0)
	UIBlockMgr.instance:startBlock("waitPause")
	TaskDispatcher.runDelay(arg_4_0._realPause, arg_4_0, 0.5)
end

function var_0_0._realPause(arg_5_0)
	UIBlockMgr.instance:endBlock("waitPause")
	AudioMgr.instance:trigger(AudioEnum.Story.pause_cg_bus)
	StoryController.instance:dispatchEvent(StoryEvent.PvPause)
	GameTimeMgr.instance:setTimeScale(GameTimeMgr.TimeScaleType.StoryPv, 0)
end

function var_0_0._btnplayOnClick(arg_6_0)
	UIBlockMgr.instance:endBlock("waitPause")
	TaskDispatcher.cancelTask(arg_6_0._realPause, arg_6_0)
	StoryModel.instance:setStoryPvPause(false)
	gohelper.setActive(arg_6_0._gopvpause, true)
	AudioMgr.instance:trigger(AudioEnum.Story.resume_cg_bus)
	StoryController.instance:dispatchEvent(StoryEvent.PvPlay)
	GameTimeMgr.instance:setTimeScale(GameTimeMgr.TimeScaleType.StoryPv, 1)
	UIBlockMgr.instance:startBlock("PlayPv")
	arg_6_0._pvpauseAnim:Play("play", 0, 0)
	TaskDispatcher.runDelay(arg_6_0._playFinished, arg_6_0, 0.5)
end

function var_0_0._playFinished(arg_7_0)
	UIBlockMgr.instance:endBlock("PlayPv")
	gohelper.setActive(arg_7_0._gopvpause, false)
end

function var_0_0._checkPvPlayRestart(arg_8_0)
	if StoryModel.instance:isStoryPvPause() then
		StoryModel.instance:setStoryPvPause(false)
		AudioMgr.instance:trigger(AudioEnum.Story.resume_cg_bus)
		StoryController.instance:dispatchEvent(StoryEvent.PvPlay)
		GameTimeMgr.instance:setTimeScale(GameTimeMgr.TimeScaleType.StoryPv, 1)
	end
end

function var_0_0._btnnextOnMidClick(arg_9_0)
	if not StoryModel.instance:isEnableClick() then
		return
	end

	if arg_9_0._btnlog.gameObject.activeInHierarchy == false then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.StoryLogView) then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.StoryPrologueSkipView) then
		return
	end

	arg_9_0:_btnlogOnClick()
end

function var_0_0._btnlogOnClick(arg_10_0)
	if ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_plot_common)
	StoryModel.instance:setStoryAuto(false)
	StoryController.instance:dispatchEvent(StoryEvent.Log)
end

function var_0_0._onKeyExit(arg_11_0)
	if ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
		return
	end

	if arg_11_0._exitBtn and arg_11_0._goexit.activeInHierarchy then
		arg_11_0._exitBtn:onClickExitBtn()
	end
end

function var_0_0._btnhideOnClick(arg_12_0)
	if ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_plot_common)

	if StoryModel.instance:isStoryAuto() then
		return
	end

	StoryModel.instance:setViewHide(true)
	arg_12_0:setBtnVisible(false)
	StoryController.instance:dispatchEvent(StoryEvent.Hide)

	if arg_12_0._exitBtn then
		arg_12_0._exitBtn:setActive(false)
	end
end

function var_0_0._btnautoOnClick(arg_13_0)
	if ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
		return
	end

	if not arg_13_0._stepCo then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_plot_common)

	local var_13_0 = StoryModel.instance:isLimitNoInteractLock(arg_13_0._stepCo)

	if arg_13_0._stepCo.conversation.type ~= StoryEnum.ConversationType.None and arg_13_0._stepCo.conversation.type ~= StoryEnum.ConversationType.NoInteract and arg_13_0._stepCo.conversation.type ~= StoryEnum.ConversationType.ScreenDialog and arg_13_0._stepCo.conversation.type ~= StoryEnum.ConversationType.IrregularShake and not var_13_0 then
		StoryModel.instance:enableClick(true)
	end

	if not StoryModel.instance:isNormalStep() then
		return
	end

	local var_13_1 = not StoryModel.instance:isStoryAuto()

	StoryModel.instance:setStoryAuto(var_13_1)
	StoryController.instance:dispatchEvent(StoryEvent.Auto)
end

function var_0_0._onEscapeBtnClick(arg_14_0)
	if arg_14_0._objskip.activeInHierarchy and not arg_14_0._goblock.gameObject.activeInHierarchy then
		arg_14_0:_btnskipOnClick()
	end
end

function var_0_0._btnskipOnClick(arg_15_0)
	arg_15_0:_checkPvPlayRestart()

	if ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_plot_common)
	StoryModel.instance:setStoryAuto(false)

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.StorySkip) and not isDebugBuild and not StoryModel.instance:isReplay() then
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.StorySkip))

		return
	end

	if not StoryModel.instance:isReplay() then
		local var_15_0 = StoryModel.instance:getCurStoryId()
		local var_15_1 = StoryModel.instance:getCurStepId()
		local var_15_2, var_15_3 = StoryModel.instance:isPrologueSkipAndGetTxt(var_15_0, var_15_1)

		if var_15_2 then
			GameFacade.showMessageBox(MessageBoxIdDefine.StorySkipConfirm, MsgBoxEnum.BoxType.Yes_No, function()
				gohelper.setActive(arg_15_0._gobtns, false)

				local var_16_0 = {
					content = var_15_3
				}

				StoryController.instance:openStoryPrologueSkipView(var_16_0)
			end, nil)

			return
		end
	end

	local var_15_4 = StoryController.instance:getSkipMessageId()

	GameFacade.showMessageBox(var_15_4, MsgBoxEnum.BoxType.Yes_No, function()
		arg_15_0:_onSkipConfirm()
	end, nil)
end

function var_0_0._onPrologueSkip(arg_18_0)
	gohelper.setActive(arg_18_0._gobtns, true)

	local var_18_0 = StoryModel.instance:getCurStoryId()

	StoryModel.instance:setPrologueSkipId(var_18_0)
	arg_18_0:_onSkipConfirm()
end

function var_0_0._onSkipConfirm(arg_19_0)
	gohelper.setActive(arg_19_0._goepisode, false)
	gohelper.setActive(arg_19_0._gochapteropen, false)
	StoryController.instance:dispatchEvent(StoryEvent.Skip)
end

function var_0_0._btnnextOnClick(arg_20_0)
	if StoryModel.instance:isPlayFinished() then
		if StoryModel.instance:isVersionActivityPV() then
			GameTimeMgr.instance:setTimeScale(GameTimeMgr.TimeScaleType.StoryPv, 1)
		end

		return
	end

	StoryModel.instance:addStepClickTime()
	arg_20_0:closeHideSkipTask()

	if arg_20_0._exitBtn then
		arg_20_0._exitBtn:onClickNext()
	end

	gohelper.setActive(arg_20_0._gopvpause, false)

	if StoryModel.instance:isVersionActivityPV() then
		if arg_20_0._frontItem then
			arg_20_0._frontItem:enableFrontRayCast(false)
		end

		if not StoryModel.instance:isStoryPvPause() then
			arg_20_0:_btnpauseOnClick()
		else
			arg_20_0:_btnplayOnClick()
		end

		arg_20_0:startHideSkipTask()

		if not arg_20_0._objskip.activeInHierarchy then
			gohelper.setActive(arg_20_0._objskip, true)
		end

		return
	end

	local var_20_0 = false

	if StoryModel.instance:isStoryAuto() then
		var_20_0 = true

		StoryModel.instance:setStoryAuto(false)
		StoryModel.instance:setTextShowing(false)

		return
	end

	if not StoryModel.instance:isEnableClick() then
		return
	end

	if StoryModel.instance:isViewHide() then
		arg_20_0:setBtnVisible(true)
	end

	if not var_20_0 then
		StoryController.instance:dispatchEvent(StoryEvent.EnterNextStep)
	end
end

function var_0_0._editableInitView(arg_21_0)
	arg_21_0._btnnext = gohelper.findChildButton(arg_21_0.viewGO, "btn_next")
	arg_21_0._btnnextMidClick = SLFramework.UGUI.UIMiddleClickListener.Get(arg_21_0._btnnext.gameObject)
	arg_21_0._touchEventMgr = TouchEventMgrHepler.getTouchEventMgr(arg_21_0._btnnext.gameObject)

	arg_21_0._touchEventMgr:SetIgnoreUI(true)
	arg_21_0._touchEventMgr:SetOnlyTouch(true)
	arg_21_0._touchEventMgr:SetScrollWheelCb(arg_21_0._btnnextOnMidClick, arg_21_0)

	arg_21_0._imagehide = gohelper.findChildImage(arg_21_0.viewGO, "#go_btns/#go_btnleft/#btn_hide/icon")

	gohelper.setActive(arg_21_0._imageautooff.gameObject, true)
	gohelper.setActive(arg_21_0._imageautoon.gameObject, false)

	if not arg_21_0._frontItem then
		arg_21_0._frontItem = StoryFrontItem.New()

		arg_21_0._frontItem:init(arg_21_0._gofront)
	end

	if not arg_21_0._exitBtn then
		arg_21_0._exitBtn = StoryExitBtn.New(arg_21_0._goexit, arg_21_0.resetRightBtnPos, arg_21_0)
	end

	local var_21_0 = GMController.instance:getGMNode("storyview", arg_21_0.viewGO)

	if var_21_0 and not arg_21_0._gmView then
		arg_21_0._gmView = StoryGMView.New(var_21_0)
	end
end

function var_0_0.onUpdateParam(arg_22_0)
	return
end

function var_0_0.onOpen(arg_23_0)
	arg_23_0._btnnext:AddClickListener(arg_23_0._btnnextOnClick, arg_23_0)
	arg_23_0._btnnextMidClick:AddClickListener(arg_23_0._btnnextOnMidClick, arg_23_0)
	arg_23_0:addEventCb(StoryController.instance, StoryEvent.Skip, arg_23_0._onSkip, arg_23_0)
	arg_23_0:addEventCb(StoryController.instance, StoryEvent.AutoChange, arg_23_0._onAutoChange, arg_23_0)
	arg_23_0:addEventCb(StoryController.instance, StoryEvent.ReOpenStoryView, arg_23_0._reOpenStory, arg_23_0)
	arg_23_0:addEventCb(StoryController.instance, StoryEvent.AllStepFinished, arg_23_0._screenFadeOut, arg_23_0)
	arg_23_0:addEventCb(StoryController.instance, StoryEvent.RefreshStep, arg_23_0._onUpdateUI, arg_23_0)
	arg_23_0:addEventCb(StoryController.instance, StoryEvent.SetFullText, arg_23_0._onSetFullText, arg_23_0)
	arg_23_0:addEventCb(StoryController.instance, StoryEvent.PlayFullText, arg_23_0._onPlayFullText, arg_23_0)
	arg_23_0:addEventCb(StoryController.instance, StoryEvent.PlayIrregularShakeText, arg_23_0._onPlayIrregularShakeText, arg_23_0)
	arg_23_0:addEventCb(StoryController.instance, StoryEvent.PlayFullTextOut, arg_23_0._onPlayFullTextOut, arg_23_0)
	arg_23_0:addEventCb(StoryController.instance, StoryEvent.PlayFullBlurIn, arg_23_0._onPlayFullBlurIn, arg_23_0)
	arg_23_0:addEventCb(StoryController.instance, StoryEvent.PlayFullBlurOut, arg_23_0._onPlayFullBlurOut, arg_23_0)
	arg_23_0:addEventCb(StoryController.instance, StoryEvent.PlayFullTextLineShow, arg_23_0._onPlayLineShow, arg_23_0)
	arg_23_0:addEventCb(StoryController.instance, StoryEvent.RefreshNavigate, arg_23_0._refreshNavigate, arg_23_0)
	arg_23_0:addEventCb(StoryController.instance, StoryEvent.OnSkipClick, arg_23_0._onPrologueSkip, arg_23_0)
	arg_23_0:addEventCb(StoryController.instance, StoryEvent.HideTopBtns, arg_23_0._onHideBtns, arg_23_0)
	arg_23_0:addEventCb(StoryController.instance, StoryEvent.OnSkipClick, arg_23_0._onPrologueSkip, arg_23_0)
	arg_23_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_23_0._setBtnsVisible, arg_23_0)
	arg_23_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_23_0._setBtnsVisible, arg_23_0)

	if StoryModel.instance:getHideBtns() then
		arg_23_0:setBtnVisible(false)
	end

	arg_23_0:_enterStory()

	if StoryModel.instance:isVersionActivityPV() then
		gohelper.setActive(arg_23_0._gobtnleft, false)
		gohelper.setActive(arg_23_0._objskip, false)
		gohelper.setActive(arg_23_0._btnauto, false)
	else
		gohelper.setActive(arg_23_0._gobtnleft, true)
		gohelper.setActive(arg_23_0._btnauto, true)

		local var_23_0 = OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.StorySkip) or StoryModel.instance:isReplay()
		local var_23_1 = StoryModel.instance:isDirectSkipStory(StoryModel.instance:getCurStoryId())

		var_23_0 = var_23_0 or isDebugBuild or var_23_1

		gohelper.setActive(arg_23_0._objskip, var_23_0)
	end

	arg_23_0:refreshExitBtn()
	NavigateMgr.instance:addSpace(ViewName.StoryFrontView, arg_23_0._btnnextOnClick, arg_23_0)
	NavigateMgr.instance:addEscape(ViewName.StoryFrontView, arg_23_0._onEscapeBtnClick, arg_23_0)
end

function var_0_0.onClose(arg_24_0)
	arg_24_0._btnnext:RemoveClickListener()
	arg_24_0:removeEventCb(StoryController.instance, StoryEvent.Skip, arg_24_0._onSkip, arg_24_0)
	arg_24_0:removeEventCb(StoryController.instance, StoryEvent.AutoChange, arg_24_0._onAutoChange, arg_24_0)
	arg_24_0._btnnextMidClick:RemoveClickListener()

	if not gohelper.isNil(arg_24_0._touchEventMgr) then
		arg_24_0._touchEventMgr:ClearAllCallback()
	end

	arg_24_0:removeEventCb(StoryController.instance, StoryEvent.ReOpenStoryView, arg_24_0._reOpenStory, arg_24_0)
	arg_24_0:removeEventCb(StoryController.instance, StoryEvent.AllStepFinished, arg_24_0._screenFadeOut, arg_24_0)
	arg_24_0:removeEventCb(StoryController.instance, StoryEvent.RefreshStep, arg_24_0._onUpdateUI, arg_24_0)
	arg_24_0:removeEventCb(StoryController.instance, StoryEvent.SetFullText, arg_24_0._onSetFullText, arg_24_0)
	arg_24_0:removeEventCb(StoryController.instance, StoryEvent.PlayFullText, arg_24_0._onPlayFullText, arg_24_0)
	arg_24_0:removeEventCb(StoryController.instance, StoryEvent.PlayIrregularShakeText, arg_24_0._onPlayIrregularShakeText, arg_24_0)
	arg_24_0:removeEventCb(StoryController.instance, StoryEvent.PlayFullTextOut, arg_24_0._onPlayFullTextOut, arg_24_0)
	arg_24_0:removeEventCb(StoryController.instance, StoryEvent.PlayFullBlurIn, arg_24_0._onPlayFullBlurIn, arg_24_0)
	arg_24_0:removeEventCb(StoryController.instance, StoryEvent.PlayFullBlurOut, arg_24_0._onPlayFullBlurOut, arg_24_0)
	arg_24_0:removeEventCb(StoryController.instance, StoryEvent.PlayFullTextLineShow, arg_24_0._onPlayLineShow, arg_24_0)
	arg_24_0:removeEventCb(StoryController.instance, StoryEvent.RefreshNavigate, arg_24_0._refreshNavigate, arg_24_0)
	arg_24_0:removeEventCb(StoryController.instance, StoryEvent.OnSkipClick, arg_24_0._onPrologueSkip, arg_24_0)
	arg_24_0:removeEventCb(StoryController.instance, StoryEvent.HideTopBtns, arg_24_0._onHideBtns, arg_24_0)
	arg_24_0:removeEventCb(StoryController.instance, StoryEvent.OnSkipClick, arg_24_0._onPrologueSkip, arg_24_0)
	arg_24_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_24_0._setBtnsVisible, arg_24_0)
	arg_24_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_24_0._setBtnsVisible, arg_24_0)
end

function var_0_0._onSkip(arg_25_0)
	gohelper.setActive(arg_25_0._goepisode, false)
	gohelper.setActive(arg_25_0._gochapteropen, false)
end

function var_0_0._onAutoChange(arg_26_0)
	local var_26_0 = StoryModel.instance:isStoryAuto()

	gohelper.setActive(arg_26_0._imageautooff.gameObject, not var_26_0)
	gohelper.setActive(arg_26_0._imageautoon.gameObject, var_26_0)

	local var_26_1 = var_26_0 and "#333333" or "#FFFFFF"

	SLFramework.UGUI.GuiHelper.SetColor(arg_26_0._imagehide, var_26_1)
end

function var_0_0._reOpenStory(arg_27_0)
	arg_27_0._reOpen = true

	arg_27_0:_enterStory()
end

function var_0_0._onSetFullText(arg_28_0, arg_28_1)
	arg_28_0._frontItem:showFullScreenText(false, arg_28_1)
end

function var_0_0._onPlayFullText(arg_29_0, arg_29_1)
	arg_29_0._stepCo = arg_29_1

	if arg_29_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Fade then
		arg_29_0._frontItem:playTextFadeIn(arg_29_0._stepCo, arg_29_0._onFullTextShowFinished, arg_29_0)
	elseif arg_29_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.WordByWord then
		arg_29_0._frontItem:wordByWord(arg_29_0._stepCo, arg_29_0._onFullTextShowFinished, arg_29_0)
	elseif arg_29_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Glitch then
		arg_29_0._frontItem:playTextFadeIn(arg_29_0._stepCo, arg_29_0._onFullTextShowFinished, arg_29_0)
		arg_29_0._frontItem:playGlitch()
	end
end

function var_0_0._onPlayIrregularShakeText(arg_30_0, arg_30_1)
	arg_30_0._stepCo = arg_30_1

	arg_30_0._frontItem:playIrregularShakeText(arg_30_0._stepCo, arg_30_0._onFullTextShowFinished, arg_30_0)
end

function var_0_0._onPlayFullTextOut(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = 0.5

	if arg_31_0._stepCo and arg_31_0._stepCo.conversation.type == StoryEnum.ConversationType.ScreenDialog and (arg_31_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Fade or arg_31_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.WordByWord or arg_31_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.LineByLine or arg_31_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.TwoLineShow) then
		var_31_0 = arg_31_0._stepCo.conversation.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]
	end

	arg_31_0._frontItem:playFullTextFadeOut(var_31_0, arg_31_1, arg_31_2)
end

function var_0_0._onPlayFullBlurIn(arg_32_0, arg_32_1, arg_32_2)
	if arg_32_1 < 1 then
		return
	end

	local var_32_0 = {
		0.3,
		0.6,
		1
	}

	PostProcessingMgr.instance:setUIBlurActive(3)
	PostProcessingMgr.instance:setFreezeVisble(true)
	PostProcessingMgr.instance:setDesamplingRate(1)
	arg_32_0:_killBlurId()

	arg_32_0._blurTweenId = ZProj.TweenHelper.DOTweenFloat(0, var_32_0[arg_32_1], arg_32_2, arg_32_0._fadeUpdate, nil, arg_32_0, nil, EaseType.Linear)
end

function var_0_0._killBlurId(arg_33_0)
	if arg_33_0._blurTweenId then
		ZProj.TweenHelper.KillById(arg_33_0._blurTweenId)

		arg_33_0._blurTweenId = nil
	end
end

function var_0_0._onPlayFullBlurOut(arg_34_0, arg_34_1)
	arg_34_0:_killBlurId()

	local var_34_0 = PostProcessingMgr.instance:getCaptureView()

	if not var_34_0 or not var_34_0.activeSelf then
		return
	end

	local var_34_1 = var_34_0:GetComponent(typeof(UrpCustom.UIGaussianEffect))
	local var_34_2 = var_34_1 and var_34_1.blurWeight or 0

	if var_34_2 <= 0 then
		return
	end

	if arg_34_1 < 0.1 then
		arg_34_0:_fadeBlurOutFinished()

		return
	end

	arg_34_0._blurTweenId = ZProj.TweenHelper.DOTweenFloat(var_34_2, 0, arg_34_1, arg_34_0._fadeUpdate, arg_34_0._fadeBlurOutFinished, arg_34_0, nil, EaseType.Linear)
end

function var_0_0._fadeUpdate(arg_35_0, arg_35_1)
	PostProcessingMgr.instance:setBlurWeight(arg_35_1)
end

function var_0_0._fadeBlurOutFinished(arg_36_0)
	PostProcessingMgr.instance:setUIBlurActive(0)
	PostProcessingMgr.instance:setFreezeVisble(false)
	arg_36_0:_killBlurId()
	arg_36_0:_fadeUpdate(0)
end

function var_0_0._onPlayLineShow(arg_37_0, arg_37_1, arg_37_2)
	arg_37_0._stepCo = arg_37_2

	arg_37_0._frontItem:lineShow(arg_37_1, arg_37_0._stepCo, arg_37_0._onFullTextShowFinished, arg_37_0)
end

function var_0_0._onFullTextShowFinished(arg_38_0)
	StoryController.instance:dispatchEvent(StoryEvent.FullTextLineShowFinished)
end

function var_0_0._onUpdateUI(arg_39_0, arg_39_1)
	arg_39_0:_killBlurId()

	local var_39_0 = arg_39_1.stepType == StoryEnum.StepType.Normal
	local var_39_1 = var_39_0 and "#FFFFFF" or "#292218"
	local var_39_2 = var_39_0 and "#FFFFFF" or "#333333"

	SLFramework.UGUI.GuiHelper.SetColor(arg_39_0._txtskip, var_39_1)
	SLFramework.UGUI.GuiHelper.SetColor(arg_39_0._imageskip, var_39_2)
	SLFramework.UGUI.GuiHelper.SetColor(arg_39_0._txtauto, var_39_1)
	SLFramework.UGUI.GuiHelper.SetColor(arg_39_0._imageautooff, var_39_2)
	SLFramework.UGUI.GuiHelper.SetColor(arg_39_0._imageautoon, var_39_2)
	SLFramework.UGUI.GuiHelper.SetColor(arg_39_0._imageskiptxt, var_39_1)
	SLFramework.UGUI.GuiHelper.SetColor(arg_39_0._imageautotxt, var_39_1)
	SLFramework.UGUI.GuiHelper.SetColor(arg_39_0._txtexit, var_39_1)
	SLFramework.UGUI.GuiHelper.SetColor(arg_39_0._imageexittxt, var_39_1)
	SLFramework.UGUI.GuiHelper.SetColor(arg_39_0._imageexit, var_39_2)

	arg_39_0._stepCo = StoryStepModel.instance:getStepListById(arg_39_1.stepId)

	if arg_39_0:_isCgStep() or StoryModel.instance:getHideBtns() then
		arg_39_0:setBtnVisible(false)
	else
		arg_39_0:setBtnVisible(true)
	end

	if not (arg_39_0._stepCo.conversation.type == StoryEnum.ConversationType.ScreenDialog) then
		arg_39_0._frontItem:showFullScreenText(false, "")
	end

	arg_39_0:refreshExitBtn()
end

function var_0_0._isCgStep(arg_40_0)
	if StoryModel.instance:getCurStoryId() ~= 100001 then
		return false
	end

	if isDebugBuild then
		return false
	end

	if StoryModel.instance:isReplay() then
		return false
	end

	if arg_40_0._stepCo then
		for iter_40_0, iter_40_1 in pairs(arg_40_0._stepCo.videoList) do
			if iter_40_1.orderType ~= StoryEnum.VideoOrderType.Destroy then
				return true
			end
		end
	end

	return false
end

function var_0_0._enterStory(arg_41_0)
	TaskDispatcher.cancelTask(arg_41_0._startStory, arg_41_0)
	TaskDispatcher.cancelTask(arg_41_0._viewFadeIn, arg_41_0)
	arg_41_0._frontItem:cancelViewFadeOut()
	gohelper.setActive(arg_41_0._goblock, false)
	arg_41_0:_screenFadeIn()
end

function var_0_0._screenFadeIn(arg_42_0)
	if GuideModel.instance:isDoingFirstGuide() and not GuideController.instance:isForbidGuides() and GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		StoryController.instance:startStory()

		return
	end

	local var_42_0 = StoryModel.instance:isTypeSkip(StoryEnum.SkipType.InDarkFade, StoryModel.instance:getCurStoryId())

	StoryModel.instance.skipFade = var_42_0

	arg_42_0._frontItem:setFullTopShow()
	gohelper.setActive(arg_42_0.viewGO, true)

	if arg_42_0._reOpen and var_42_0 then
		arg_42_0:_startStory()
	else
		TaskDispatcher.runDelay(arg_42_0._startStory, arg_42_0, 0.5)
	end
end

function var_0_0._startStory(arg_43_0)
	StoryController.instance:startStory()
	TaskDispatcher.runDelay(arg_43_0._viewFadeIn, arg_43_0, 0.05)
end

function var_0_0._viewFadeIn(arg_44_0)
	if StoryController.instance._showBlur then
		arg_44_0._dofFactor = PostProcessingMgr.instance:getUnitPPValue("DofFactor")
		arg_44_0._unitCameraActive = CameraMgr.instance:getUnitCamera().gameObject.activeSelf

		gohelper.setActive(PostProcessingMgr.instance._unitPPVolume.gameObject, true)
		gohelper.setActive(CameraMgr.instance:getUnitCamera(), true)
		arg_44_0:_killBlurId()

		arg_44_0._blurTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1.5, arg_44_0._blurUpdate, arg_44_0._blurInFinished, arg_44_0, EaseType.Linear)

		return
	end

	arg_44_0._frontItem:playStoryViewIn()
end

function var_0_0._blurUpdate(arg_45_0, arg_45_1)
	PostProcessingMgr.instance:setUnitPPValue("dofFactor", arg_45_1)
	PostProcessingMgr.instance:setUnitPPValue("DofFactor", arg_45_1)
end

function var_0_0._blurInFinished(arg_46_0)
	arg_46_0:_blurUpdate(1)
	arg_46_0:_killBlurId()
end

function var_0_0._screenFadeOut(arg_47_0, arg_47_1)
	StoryModel.instance:enableClick(false)
	gohelper.setActive(arg_47_0._goblock, true)
	gohelper.setActive(arg_47_0._goepisode, false)
	gohelper.setActive(arg_47_0._gochapteropen, false)
	arg_47_0:setBtnVisible(false)

	if arg_47_0._exitBtn then
		arg_47_0._exitBtn:setActive(false)
	end

	if StoryController.instance._showBlur then
		arg_47_0:_killBlurId()

		arg_47_0._blurTweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, 1.5, arg_47_0._blurUpdate, arg_47_0._blurOutFinished, arg_47_0, EaseType.Linear)

		return
	end

	arg_47_0._frontItem:playStoryViewOut(arg_47_0._onScreenFadeOut, arg_47_0, arg_47_1)
end

function var_0_0._blurOutFinished(arg_48_0)
	arg_48_0:_blurUpdate(0)
	PostProcessingMgr.instance:setUnitPPValue("dofFactor", arg_48_0._dofFactor or 0)
	PostProcessingMgr.instance:setUnitPPValue("DofFactor", arg_48_0._dofFactor or 0)
	gohelper.setActive(CameraMgr.instance:getUnitCamera().gameObject, arg_48_0._unitCameraActive)
	StoryController.instance:finished()
	arg_48_0._frontItem:enterStoryFinish()
	arg_48_0:_onScreenFadeOut()
end

function var_0_0._onScreenFadeOut(arg_49_0)
	if arg_49_0._navigateItem then
		arg_49_0._navigateItem:clear()
	end
end

function var_0_0._refreshNavigate(arg_50_0, arg_50_1)
	local var_50_0 = false
	local var_50_1 = {}

	for iter_50_0, iter_50_1 in pairs(arg_50_1) do
		if iter_50_1.navigateType == StoryEnum.NavigateType.HideBtns then
			var_50_0 = true
		else
			table.insert(var_50_1, iter_50_1)
		end
	end

	arg_50_0:setBtnVisible(not var_50_0)
	arg_50_0:refreshExitBtn()
	StoryModel.instance:setHideBtns(var_50_0)

	if #var_50_1 > 0 then
		if not arg_50_0._navigateItem then
			arg_50_0._navigateItem = StoryNavigateItem.New()

			arg_50_0._navigateItem:init(arg_50_0._gonavigate)
			arg_50_0._navigateItem:show(var_50_1)
		else
			arg_50_0._navigateItem:show(var_50_1)
		end
	elseif arg_50_0._navigateItem then
		arg_50_0._navigateItem:clear()
	end
end

function var_0_0.setBtnVisible(arg_51_0, arg_51_1)
	if StoryModel.instance:getHideBtns() then
		gohelper.setActive(arg_51_0._gobtns, false)

		return
	end

	if arg_51_0.btnVisible == arg_51_1 then
		return
	end

	arg_51_0.btnVisible = arg_51_1

	gohelper.setActive(arg_51_0._gobtns, arg_51_1)
end

function var_0_0._setBtnsVisible(arg_52_0, arg_52_1)
	if StoryController.instance._showBlur then
		StoryModel.instance:setUIActive(true)
	else
		local var_52_0 = StoryModel.instance:getUIActive()

		StoryModel.instance:setUIActive(var_52_0)
	end

	if arg_52_1 == ViewName.StoryLogView then
		local var_52_1 = arg_52_0._gobtnleft.activeInHierarchy

		gohelper.setActive(arg_52_0._gobtnleft, not var_52_1)
	end
end

function var_0_0._onHideBtns(arg_53_0, arg_53_1)
	StoryModel.instance:setHideBtns(arg_53_1)
	arg_53_0:setBtnVisible(not arg_53_1)

	if arg_53_1 and arg_53_0._exitBtn then
		arg_53_0._exitBtn:setActive(false)
	end
end

function var_0_0.startHideSkipTask(arg_54_0)
	arg_54_0:closeHideSkipTask()
	TaskDispatcher.runDelay(arg_54_0._hideSkipBtn, arg_54_0, 3)
end

function var_0_0._hideSkipBtn(arg_55_0)
	gohelper.setActive(arg_55_0._objskip, false)
end

function var_0_0.closeHideSkipTask(arg_56_0)
	TaskDispatcher.cancelTask(arg_56_0._hideSkipBtn, arg_56_0)
end

function var_0_0.refreshExitBtn(arg_57_0)
	if arg_57_0._exitBtn then
		arg_57_0._exitBtn:refresh(arg_57_0.btnVisible)
	end
end

function var_0_0.resetRightBtnPos(arg_58_0)
	if arg_58_0._exitBtn and arg_58_0._exitBtn.isActive then
		recthelper.setAnchorX(arg_58_0._gobtnright.transform, -260)
		gohelper.setActive(arg_58_0._goshadow, arg_58_0._exitBtn.isInVideo and true or false)
	else
		recthelper.setAnchorX(arg_58_0._gobtnright.transform, -62)
		gohelper.setActive(arg_58_0._goshadow, false)
	end
end

function var_0_0.onDestroyView(arg_59_0)
	StoryModel.instance:setStoryPvPause(false)
	TaskDispatcher.cancelTask(arg_59_0._realPause, arg_59_0)
	TaskDispatcher.cancelTask(arg_59_0._playFinished, arg_59_0)
	UIBlockMgr.instance:endBlock("waitPause")
	UIBlockMgr.instance:endBlock("PlayPv")

	if StoryController.instance._showBlur then
		PostProcessingMgr.instance:setUnitPPValue("dofFactor", arg_59_0._dofFactor or 0)
		PostProcessingMgr.instance:setUnitPPValue("DofFactor", arg_59_0._dofFactor or 0)

		StoryController.instance._showBlur = false
	end

	StoryController.instance:dispatchEvent(StoryEvent.StoryFrontViewDestroy)
	TaskDispatcher.cancelTask(arg_59_0._startStory, arg_59_0)
	TaskDispatcher.cancelTask(arg_59_0._viewFadeIn, arg_59_0)
	arg_59_0:_killBlurId()
	arg_59_0:closeHideSkipTask()

	if arg_59_0._frontItem then
		arg_59_0._frontItem:destroy()

		arg_59_0._frontItem = nil
	end

	if arg_59_0._navigateItem then
		arg_59_0._navigateItem:destroy()

		arg_59_0._navigateItem = nil
	end

	if arg_59_0._exitBtn then
		arg_59_0._exitBtn:destroy()

		arg_59_0._exitBtn = nil
	end

	if arg_59_0._gmView then
		arg_59_0._gmView:destroy()

		arg_59_0._gmView = nil
	end
end

return var_0_0
