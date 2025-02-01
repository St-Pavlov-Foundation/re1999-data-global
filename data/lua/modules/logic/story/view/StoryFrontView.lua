module("modules.logic.story.view.StoryFrontView", package.seeall)

slot0 = class("StoryFrontView", BaseView)

function slot0.onInitView(slot0)
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._gobtnleft = gohelper.findChild(slot0.viewGO, "#go_btns/#go_btnleft")
	slot0._btnlog = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_btns/#go_btnleft/#btn_log")
	slot0._btnhide = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_btns/#go_btnleft/#btn_hide")
	slot0._gobtnright = gohelper.findChild(slot0.viewGO, "#go_btns/#go_btnright")
	slot0._btnauto = gohelper.findChildButtonWithAudio(slot0._gobtnright, "#btn_auto")
	slot0._txtauto = gohelper.findChildTextMesh(slot0._gobtnright, "#btn_auto/txt_Auto")
	slot0._imageautooff = gohelper.findChildImage(slot0._gobtnright, "#btn_auto/#image_autooff")
	slot0._imageautoon = gohelper.findChildImage(slot0._gobtnright, "#btn_auto/#image_autoon")
	slot0._imageautotxt = gohelper.findChildImage(slot0._gobtnright, "#btn_auto/#image_autotxt")
	slot0._btnskip = gohelper.findChildButtonWithAudio(slot0._gobtnright, "#btn_skip")
	slot0._objskip = slot0._btnskip.gameObject
	slot0._txtskip = gohelper.findChildTextMesh(slot0._gobtnright, "#btn_skip/txt_skip")
	slot0._imageskip = gohelper.findChildImage(slot0._gobtnright, "#btn_skip/#image_skip")
	slot0._imageskiptxt = gohelper.findChildImage(slot0._gobtnright, "#btn_skip/#image_skiptxt")
	slot0._goexit = gohelper.findChild(slot0.viewGO, "#btn_exit")
	slot0._txtexit = gohelper.findChildTextMesh(slot0.viewGO, "#btn_exit/txt_exit")
	slot0._imageexit = gohelper.findChildImage(slot0.viewGO, "#btn_exit/#image_exit")
	slot0._imageexittxt = gohelper.findChildImage(slot0.viewGO, "#btn_exit/#image_exittxt")
	slot0._goshadow = gohelper.findChild(slot0.viewGO, "#go_shadow")
	slot0._gofront = gohelper.findChild(slot0.viewGO, "#go_front")
	slot0._goblock = gohelper.findChild(slot0.viewGO, "#go_front/#go_block")
	slot0._gonavigate = gohelper.findChild(slot0.viewGO, "#go_navigate")
	slot0._goepisode = gohelper.findChild(slot0.viewGO, "#go_navigate/#go_episode")
	slot0._gochapteropen = gohelper.findChild(slot0.viewGO, "#go_navigate/#go_chapter/#go_open")
	slot0._gochapterclose = gohelper.findChild(slot0.viewGO, "#go_navigate/#go_chapter/#go_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnlog:AddClickListener(slot0._btnlogOnClick, slot0)
	slot0._btnhide:AddClickListener(slot0._btnhideOnClick, slot0)
	slot0._btnauto:AddClickListener(slot0._btnautoOnClick, slot0)
	slot0._btnskip:AddClickListener(slot0._btnskipOnClick, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogAuto, slot0._btnautoOnClick, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogSkip, slot0._btnskipOnClick, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogExit, slot0._onKeyExit, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnlog:RemoveClickListener()
	slot0._btnhide:RemoveClickListener()
	slot0._btnauto:RemoveClickListener()
	slot0._btnskip:RemoveClickListener()
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogAuto, slot0._btnautoOnClick, slot0)
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogSkip, slot0._btnskipOnClick, slot0)
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogExit, slot0._onKeyExit, slot0)
end

function slot0._btnnextOnMidClick(slot0)
	if not StoryModel.instance:isEnableClick() then
		return
	end

	if slot0._btnlog.gameObject.activeInHierarchy == false then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.StoryLogView) then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.StoryPrologueSkipView) then
		return
	end

	slot0:_btnlogOnClick()
end

function slot0._btnlogOnClick(slot0)
	if ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_plot_common)
	StoryModel.instance:setStoryAuto(false)
	StoryController.instance:dispatchEvent(StoryEvent.Log)
end

function slot0._onKeyExit(slot0)
	if ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
		return
	end

	if slot0._exitBtn and slot0._goexit.activeInHierarchy then
		slot0._exitBtn:onClickExitBtn()
	end
end

function slot0._btnhideOnClick(slot0)
	if ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_plot_common)

	if StoryModel.instance:isStoryAuto() then
		return
	end

	StoryModel.instance:setViewHide(true)
	slot0:setBtnVisible(false)
	StoryController.instance:dispatchEvent(StoryEvent.Hide)

	if slot0._exitBtn then
		slot0._exitBtn:setActive(false)
	end
end

function slot0._btnautoOnClick(slot0)
	if ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
		return
	end

	if not slot0._stepCo then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_plot_common)

	if slot0._stepCo.conversation.type ~= StoryEnum.ConversationType.None and slot0._stepCo.conversation.type ~= StoryEnum.ConversationType.NoInteract and slot0._stepCo.conversation.type ~= StoryEnum.ConversationType.ScreenDialog and slot0._stepCo.conversation.type ~= StoryEnum.ConversationType.IrregularShake then
		StoryModel.instance:enableClick(true)
	end

	if not StoryModel.instance:isNormalStep() then
		return
	end

	StoryModel.instance:setStoryAuto(not StoryModel.instance:isStoryAuto())
	StoryController.instance:dispatchEvent(StoryEvent.Auto)
end

function slot0._onEscapeBtnClick(slot0)
	if slot0._objskip.activeInHierarchy and not slot0._goblock.gameObject.activeInHierarchy then
		slot0:_btnskipOnClick()
	end
end

function slot0._btnskipOnClick(slot0)
	if ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_plot_common)
	StoryModel.instance:setStoryAuto(false)

	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.StorySkip) and not isDebugBuild and not StoryController.instance:isReplay() then
		GameFacade.showToast(OpenModel.instance:getFuncUnlockDesc(OpenEnum.UnlockFunc.StorySkip))

		return
	end

	if not StoryController.instance:isReplay() then
		slot3, slot4 = StoryModel.instance:isPrologueSkipAndGetTxt(StoryController.instance._curStoryId, StoryController.instance._curStepId)

		if slot3 then
			GameFacade.showMessageBox(MessageBoxIdDefine.StorySkipConfirm, MsgBoxEnum.BoxType.Yes_No, function ()
				gohelper.setActive(uv0._gobtns, false)
				StoryController.instance:openStoryPrologueSkipView({
					content = uv1
				})
			end, nil)

			return
		end
	end

	GameFacade.showMessageBox(StoryController.instance:getSkipMessageId(), MsgBoxEnum.BoxType.Yes_No, function ()
		uv0:_onSkipConfirm()
	end, nil)
end

function slot0._onPrologueSkip(slot0)
	gohelper.setActive(slot0._gobtns, true)
	StoryModel.instance:setPrologueSkipId(StoryController.instance._curStoryId)
	slot0:_onSkipConfirm()
end

function slot0._onSkipConfirm(slot0)
	gohelper.setActive(slot0._goepisode, false)
	gohelper.setActive(slot0._gochapteropen, false)
	StoryController.instance:dispatchEvent(StoryEvent.Skip)
end

function slot0._btnnextOnClick(slot0)
	if StoryModel.instance:isPlayFinished() then
		return
	end

	StoryModel.instance:addStepClickTime()
	slot0:closeHideSkipTask()

	if slot0._exitBtn then
		slot0._exitBtn:onClickNext()
	end

	if StoryController.instance:isVersionActivityPV() then
		slot0:startHideSkipTask()

		if not slot0._objskip.activeInHierarchy then
			gohelper.setActive(slot0._objskip, true)
		end

		return
	end

	slot1 = false

	if StoryModel.instance:isStoryAuto() then
		slot1 = true

		StoryModel.instance:setStoryAuto(false)
		StoryModel.instance:setTextShowing(false)

		return
	end

	if not StoryModel.instance:isEnableClick() then
		return
	end

	if StoryModel.instance:isViewHide() then
		slot0:setBtnVisible(true)
	end

	if not slot1 then
		StoryController.instance:dispatchEvent(StoryEvent.EnterNextStep)
	end
end

function slot0._editableInitView(slot0)
	slot0._btnnext = gohelper.findChildButton(slot0.viewGO, "btn_next")
	slot0._btnnextMidClick = SLFramework.UGUI.UIMiddleClickListener.Get(slot0._btnnext.gameObject)
	slot0._touchEventMgr = TouchEventMgrHepler.getTouchEventMgr(slot0._btnnext.gameObject)

	slot0._touchEventMgr:SetIgnoreUI(true)
	slot0._touchEventMgr:SetOnlyTouch(true)
	slot0._touchEventMgr:SetScrollWheelCb(slot0._btnnextOnMidClick, slot0)

	slot0._imagehide = gohelper.findChildImage(slot0.viewGO, "#go_btns/#go_btnleft/#btn_hide/icon")

	gohelper.setActive(slot0._imageautooff.gameObject, true)
	gohelper.setActive(slot0._imageautoon.gameObject, false)

	if not slot0._frontItem then
		slot0._frontItem = StoryFrontItem.New()

		slot0._frontItem:init(slot0._gofront)
	end

	if not slot0._exitBtn then
		slot0._exitBtn = StoryExitBtn.New(slot0._goexit, slot0.resetRightBtnPos, slot0)
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._btnnext:AddClickListener(slot0._btnnextOnClick, slot0)
	slot0._btnnextMidClick:AddClickListener(slot0._btnnextOnMidClick, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.Skip, slot0._onSkip, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.AutoChange, slot0._onAutoChange, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.ReOpenStoryView, slot0._reOpenStory, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.AllStepFinished, slot0._screenFadeOut, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.RefreshStep, slot0._onUpdateUI, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.SetFullText, slot0._onSetFullText, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.PlayFullText, slot0._onPlayFullText, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.PlayIrregularShakeText, slot0._onPlayIrregularShakeText, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.PlayFullTextOut, slot0._onPlayFullTextOut, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.PlayFullBlurIn, slot0._onPlayFullBlurIn, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.PlayFullTextLineShow, slot0._onPlayLineShow, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.RefreshNavigate, slot0._refreshNavigate, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.OnSkipClick, slot0._onPrologueSkip, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.HideTopBtns, slot0._onHideBtns, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.OnSkipClick, slot0._onPrologueSkip, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, slot0._setBtnsVisible, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._setBtnsVisible, slot0)

	if StoryModel.instance:getHideBtns() then
		slot0:setBtnVisible(false)
	end

	slot0:_enterStory()

	if StoryController.instance:isVersionActivityPV() then
		gohelper.setActive(slot0._gobtnleft, false)
		gohelper.setActive(slot0._objskip, false)
		gohelper.setActive(slot0._btnauto, false)
	else
		gohelper.setActive(slot0._gobtnleft, true)
		gohelper.setActive(slot0._btnauto, true)
		gohelper.setActive(slot0._objskip, OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.StorySkip) or StoryController.instance:isReplay() or isDebugBuild)
	end

	slot0:refreshExitBtn()
	NavigateMgr.instance:addSpace(ViewName.StoryFrontView, slot0._btnnextOnClick, slot0)
	NavigateMgr.instance:addEscape(ViewName.StoryFrontView, slot0._onEscapeBtnClick, slot0)
end

function slot0.onClose(slot0)
	slot0._btnnext:RemoveClickListener()
	slot0:removeEventCb(StoryController.instance, StoryEvent.Skip, slot0._onSkip, slot0)
	slot0:removeEventCb(StoryController.instance, StoryEvent.AutoChange, slot0._onAutoChange, slot0)
	slot0._btnnextMidClick:RemoveClickListener()

	if not gohelper.isNil(slot0._touchEventMgr) then
		slot0._touchEventMgr:ClearAllCallback()
	end

	slot0:removeEventCb(StoryController.instance, StoryEvent.ReOpenStoryView, slot0._reOpenStory, slot0)
	slot0:removeEventCb(StoryController.instance, StoryEvent.AllStepFinished, slot0._screenFadeOut, slot0)
	slot0:removeEventCb(StoryController.instance, StoryEvent.RefreshStep, slot0._onUpdateUI, slot0)
	slot0:removeEventCb(StoryController.instance, StoryEvent.SetFullText, slot0._onSetFullText, slot0)
	slot0:removeEventCb(StoryController.instance, StoryEvent.PlayFullText, slot0._onPlayFullText, slot0)
	slot0:removeEventCb(StoryController.instance, StoryEvent.PlayIrregularShakeText, slot0._onPlayIrregularShakeText, slot0)
	slot0:removeEventCb(StoryController.instance, StoryEvent.PlayFullTextOut, slot0._onPlayFullTextOut, slot0)
	slot0:removeEventCb(StoryController.instance, StoryEvent.PlayFullBlurIn, slot0._onPlayFullBlurIn, slot0)
	slot0:removeEventCb(StoryController.instance, StoryEvent.PlayFullTextLineShow, slot0._onPlayLineShow, slot0)
	slot0:removeEventCb(StoryController.instance, StoryEvent.RefreshNavigate, slot0._refreshNavigate, slot0)
	slot0:removeEventCb(StoryController.instance, StoryEvent.OnSkipClick, slot0._onPrologueSkip, slot0)
	slot0:removeEventCb(StoryController.instance, StoryEvent.HideTopBtns, slot0._onHideBtns, slot0)
	slot0:removeEventCb(StoryController.instance, StoryEvent.OnSkipClick, slot0._onPrologueSkip, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, slot0._setBtnsVisible, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._setBtnsVisible, slot0)
end

function slot0._onSkip(slot0)
	gohelper.setActive(slot0._goepisode, false)
	gohelper.setActive(slot0._gochapteropen, false)
end

function slot0._onAutoChange(slot0)
	slot1 = StoryModel.instance:isStoryAuto()

	gohelper.setActive(slot0._imageautooff.gameObject, not slot1)
	gohelper.setActive(slot0._imageautoon.gameObject, slot1)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._imagehide, slot1 and "#333333" or "#FFFFFF")
end

function slot0._reOpenStory(slot0)
	slot0._reOpen = true

	slot0:_enterStory()
end

function slot0._onSetFullText(slot0, slot1)
	slot0._frontItem:showFullScreenText(false, slot1)
end

function slot0._onPlayFullText(slot0, slot1)
	slot0._stepCo = slot1

	if slot0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Fade then
		slot0._frontItem:playTextFadeIn(slot0._stepCo, slot0._onFullTextShowFinished, slot0)
	elseif slot0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.WordByWord then
		slot0._frontItem:wordByWord(slot0._stepCo, slot0._onFullTextShowFinished, slot0)
	end
end

function slot0._onPlayIrregularShakeText(slot0, slot1)
	slot0._stepCo = slot1

	slot0._frontItem:playIrregularShakeText(slot0._stepCo, slot0._onFullTextShowFinished, slot0)
end

function slot0._onPlayFullTextOut(slot0)
	slot0._frontItem:playFullTextFadeOut()
end

function slot0._onPlayFullBlurIn(slot0, slot1, slot2)
	if slot1 < 1 then
		return
	end

	PostProcessingMgr.instance:setDesamplingRate(1)

	slot0._blurTweenId = ZProj.TweenHelper.DOTweenFloat(0, ({
		0.3,
		0.6,
		1
	})[slot1], slot2, slot0._fadeUpdate, nil, slot0, nil, EaseType.Linear)
end

function slot0._fadeUpdate(slot0, slot1)
	PostProcessingMgr.instance:setBlurWeight(slot1)
end

function slot0._onPlayLineShow(slot0, slot1, slot2)
	slot0._stepCo = slot2

	slot0._frontItem:lineShow(slot1, slot0._stepCo, slot0._onFullTextShowFinished, slot0)
end

function slot0._onFullTextShowFinished(slot0)
	StoryController.instance:dispatchEvent(StoryEvent.FullTextLineShowFinished)
end

function slot0._onUpdateUI(slot0, slot1)
	if slot0._blurTweenId then
		ZProj.TweenHelper.KillById(slot0._blurTweenId)

		slot0._blurTweenId = nil
	end

	slot2 = slot1.stepType == StoryEnum.StepType.Normal
	slot3 = slot2 and "#FFFFFF" or "#292218"
	slot4 = slot2 and "#FFFFFF" or "#333333"

	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtskip, slot3)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._imageskip, slot4)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtauto, slot3)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._imageautooff, slot4)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._imageautoon, slot4)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._imageskiptxt, slot3)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._imageautotxt, slot3)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._txtexit, slot3)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._imageexittxt, slot3)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._imageexit, slot4)

	slot0._stepCo = StoryStepModel.instance:getStepListById(slot1.stepId)

	if slot0:_isCgStep() or StoryModel.instance:getHideBtns() then
		slot0:setBtnVisible(false)
	else
		slot0:setBtnVisible(true)
	end

	if not (slot0._stepCo.conversation.type == StoryEnum.ConversationType.ScreenDialog) then
		slot0._frontItem:showFullScreenText(false, "")
	end

	slot0:refreshExitBtn()
end

function slot0._isCgStep(slot0)
	if StoryController.instance._curStoryId ~= 100001 then
		return false
	end

	if isDebugBuild then
		return false
	end

	if StoryController.instance:isReplay() then
		return false
	end

	if slot0._stepCo then
		for slot4, slot5 in pairs(slot0._stepCo.videoList) do
			if slot5.orderType ~= StoryEnum.VideoOrderType.Destroy then
				return true
			end
		end
	end

	return false
end

function slot0._enterStory(slot0)
	TaskDispatcher.cancelTask(slot0._startStory, slot0)
	TaskDispatcher.cancelTask(slot0._viewFadeIn, slot0)
	slot0._frontItem:cancelViewFadeOut()
	gohelper.setActive(slot0._goblock, false)
	slot0:_screenFadeIn()
end

function slot0._screenFadeIn(slot0)
	if GuideModel.instance:isDoingFirstGuide() and not GuideController.instance:isForbidGuides() and GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		StoryController.instance:startStory()

		return
	end

	StoryModel.instance.skipFade = StoryModel.instance:isTypeSkip(StoryEnum.SkipType.InDarkFade, StoryController.instance._curStoryId)

	slot0._frontItem:setFullTopShow()
	gohelper.setActive(slot0.viewGO, true)

	if slot0._reOpen and slot1 then
		slot0:_startStory()
	else
		TaskDispatcher.runDelay(slot0._startStory, slot0, 0.5)
	end
end

function slot0._startStory(slot0)
	StoryController.instance:startStory()
	TaskDispatcher.runDelay(slot0._viewFadeIn, slot0, 0.05)
end

function slot0._viewFadeIn(slot0)
	if StoryController.instance._showBlur then
		slot0._dofFactor = PostProcessingMgr.instance:getUnitPPValue("DofFactor")
		slot0._unitCameraActive = CameraMgr.instance:getUnitCamera().gameObject.activeSelf

		gohelper.setActive(PostProcessingMgr.instance._unitPPVolume.gameObject, true)
		gohelper.setActive(CameraMgr.instance:getUnitCamera(), true)

		slot0._blurTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 1.5, slot0._blurUpdate, slot0._blurInFinished, slot0, EaseType.Linear)

		return
	end

	slot0._frontItem:playStoryViewIn()
end

function slot0._blurUpdate(slot0, slot1)
	PostProcessingMgr.instance:setUnitPPValue("dofFactor", slot1)
	PostProcessingMgr.instance:setUnitPPValue("DofFactor", slot1)
end

function slot0._blurInFinished(slot0)
	slot0:_blurUpdate(1)

	slot0._blurTweenId = nil
end

function slot0._screenFadeOut(slot0, slot1)
	StoryModel.instance:enableClick(false)
	gohelper.setActive(slot0._goblock, true)
	gohelper.setActive(slot0._goepisode, false)
	gohelper.setActive(slot0._gochapteropen, false)
	slot0:setBtnVisible(false)

	if slot0._exitBtn then
		slot0._exitBtn:setActive(false)
	end

	if StoryController.instance._showBlur then
		slot0._blurTweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, 1.5, slot0._blurUpdate, slot0._blurOutFinished, slot0, EaseType.Linear)

		return
	end

	slot0._frontItem:playStoryViewOut(slot0._onScreenFadeOut, slot0, slot1)
end

function slot0._blurOutFinished(slot0)
	slot0:_blurUpdate(0)
	PostProcessingMgr.instance:setUnitPPValue("dofFactor", slot0._dofFactor or 0)
	PostProcessingMgr.instance:setUnitPPValue("DofFactor", slot0._dofFactor or 0)
	gohelper.setActive(CameraMgr.instance:getUnitCamera().gameObject, slot0._unitCameraActive)
	StoryController.instance:finished()
	slot0._frontItem:enterStoryFinish()
	slot0:_onScreenFadeOut()
end

function slot0._onScreenFadeOut(slot0)
	if slot0._navigateItem then
		slot0._navigateItem:clear()
	end
end

function slot0._refreshNavigate(slot0, slot1)
	slot2 = false
	slot3 = {}

	for slot7, slot8 in pairs(slot1) do
		if slot8.navigateType == StoryEnum.NavigateType.HideBtns then
			slot2 = true
		else
			table.insert(slot3, slot8)
		end
	end

	slot0:setBtnVisible(not slot2)
	slot0:refreshExitBtn()
	StoryModel.instance:setHideBtns(slot2)

	if #slot3 > 0 then
		if not slot0._navigateItem then
			slot0._navigateItem = StoryNavigateItem.New()

			slot0._navigateItem:init(slot0._gonavigate)
			slot0._navigateItem:show(slot3)
		else
			slot0._navigateItem:show(slot3)
		end
	elseif slot0._navigateItem then
		slot0._navigateItem:clear()
	end
end

function slot0.setBtnVisible(slot0, slot1)
	if StoryModel.instance:getHideBtns() then
		gohelper.setActive(slot0._gobtns, false)

		return
	end

	if slot0.btnVisible == slot1 then
		return
	end

	slot0.btnVisible = slot1

	gohelper.setActive(slot0._gobtns, slot1)
end

function slot0._setBtnsVisible(slot0, slot1)
	if StoryController.instance._showBlur then
		StoryModel.instance:setUIActive(true)
	else
		StoryModel.instance:setUIActive(StoryModel.instance:getUIActive())
	end

	if slot1 == ViewName.StoryLogView then
		gohelper.setActive(slot0._gobtnleft, not slot0._gobtnleft.activeInHierarchy)
	end
end

function slot0._onHideBtns(slot0, slot1)
	StoryModel.instance:setHideBtns(slot1)
	slot0:setBtnVisible(not slot1)

	if slot1 and slot0._exitBtn then
		slot0._exitBtn:setActive(false)
	end
end

function slot0.startHideSkipTask(slot0)
	slot0:closeHideSkipTask()
	TaskDispatcher.runDelay(slot0._hideSkipBtn, slot0, 3)
end

function slot0._hideSkipBtn(slot0)
	gohelper.setActive(slot0._objskip, false)
end

function slot0.closeHideSkipTask(slot0)
	TaskDispatcher.cancelTask(slot0._hideSkipBtn, slot0)
end

function slot0.refreshExitBtn(slot0)
	if slot0._exitBtn then
		slot0._exitBtn:refresh(slot0.btnVisible)
	end
end

function slot0.resetRightBtnPos(slot0)
	if slot0._exitBtn and slot0._exitBtn.isActive then
		recthelper.setAnchorX(slot0._gobtnright.transform, -260)
		gohelper.setActive(slot0._goshadow, slot0._exitBtn.isInVideo and true or false)
	else
		recthelper.setAnchorX(slot0._gobtnright.transform, -62)
		gohelper.setActive(slot0._goshadow, false)
	end
end

function slot0.onDestroyView(slot0)
	if StoryController.instance._showBlur then
		PostProcessingMgr.instance:setUnitPPValue("dofFactor", slot0._dofFactor or 0)
		PostProcessingMgr.instance:setUnitPPValue("DofFactor", slot0._dofFactor or 0)

		StoryController.instance._showBlur = false
	end

	StoryController.instance:dispatchEvent(StoryEvent.StoryFrontViewDestroy)
	TaskDispatcher.cancelTask(slot0._startStory, slot0)
	TaskDispatcher.cancelTask(slot0._viewFadeIn, slot0)

	if slot0._blurTweenId then
		ZProj.TweenHelper.KillById(slot0._blurTweenId)

		slot0._blurTweenId = nil
	end

	slot0:closeHideSkipTask()

	if slot0._frontItem then
		slot0._frontItem:destroy()

		slot0._frontItem = nil
	end

	if slot0._navigateItem then
		slot0._navigateItem:destroy()

		slot0._navigateItem = nil
	end

	if slot0._exitBtn then
		slot0._exitBtn:destroy()

		slot0._exitBtn = nil
	end
end

return slot0
