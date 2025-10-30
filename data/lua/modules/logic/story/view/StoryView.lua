module("modules.logic.story.view.StoryView", package.seeall)

local var_0_0 = class("StoryView", BaseView)

function var_0_0._clearAllTimers(arg_1_0)
	TaskDispatcher.cancelTask(arg_1_0._conShowIn, arg_1_0)
	TaskDispatcher.cancelTask(arg_1_0._onEnableClick, arg_1_0)
	TaskDispatcher.cancelTask(arg_1_0._enterNextStep, arg_1_0)
	TaskDispatcher.cancelTask(arg_1_0._onFullTextFinished, arg_1_0)
	TaskDispatcher.cancelTask(arg_1_0._startShowText, arg_1_0)
	TaskDispatcher.cancelTask(arg_1_0._onCheckNext, arg_1_0)
	TaskDispatcher.cancelTask(arg_1_0._guaranteeEnterNextStep, arg_1_0)
	TaskDispatcher.cancelTask(arg_1_0._playShowHero, arg_1_0)
	TaskDispatcher.cancelTask(arg_1_0._startShake, arg_1_0)
	TaskDispatcher.cancelTask(arg_1_0._shakeStop, arg_1_0)
	TaskDispatcher.cancelTask(arg_1_0._viewFadeIn, arg_1_0)
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._imagefullbottom = gohelper.findChildImage(arg_2_0.viewGO, "#image_fullbottom")
	arg_2_0._gomiddle = gohelper.findChild(arg_2_0.viewGO, "#go_middle")
	arg_2_0._goimg2 = gohelper.findChild(arg_2_0.viewGO, "#go_middle/#go_img2")
	arg_2_0._govideo2 = gohelper.findChild(arg_2_0.viewGO, "#go_middle/#go_video2")
	arg_2_0._goeff2 = gohelper.findChild(arg_2_0.viewGO, "#go_middle/#go_eff2")
	arg_2_0._gocontentroot = gohelper.findChild(arg_2_0.viewGO, "#go_contentroot")
	arg_2_0._gonexticon = gohelper.findChild(arg_2_0.viewGO, "#go_contentroot/nexticon")
	arg_2_0._goconversation = gohelper.findChild(arg_2_0.viewGO, "#go_contentroot/#go_conversation")
	arg_2_0._goblackbottom = gohelper.findChild(arg_2_0.viewGO, "#go_contentroot/#go_conversation/content/blackBottom")
	arg_2_0._gohead = gohelper.findChild(arg_2_0.viewGO, "#go_contentroot/#go_conversation/#go_contents/content/#go_head")
	arg_2_0._goheadgrey = gohelper.findChild(arg_2_0.viewGO, "#go_contentroot/#go_conversation/#go_contents/content/#go_head/#go_headgrey")
	arg_2_0._simagehead = gohelper.findChildSingleImage(arg_2_0.viewGO, "#go_contentroot/#go_conversation/#go_contents/content/#go_head/#simage_head")
	arg_2_0._gospine = gohelper.findChild(arg_2_0.viewGO, "#go_contentroot/#go_conversation/#go_contents/content/#go_spine")
	arg_2_0._gospineobj = gohelper.findChild(arg_2_0.viewGO, "#go_contentroot/#go_conversation/#go_contents/content/#go_spine/mask/#go_spineobj")
	arg_2_0._goname = gohelper.findChild(arg_2_0.viewGO, "#go_contentroot/#go_conversation/#go_contents/content/#go_name")
	arg_2_0._gonamebg = gohelper.findChild(arg_2_0.viewGO, "#go_contentroot/#go_conversation/#go_contents/content/#go_name/#go_namebg")
	arg_2_0._txtnamecn1 = gohelper.findChildText(arg_2_0.viewGO, "#go_contentroot/#go_conversation/#go_contents/content/#go_name/namelayout/#txt_namecn1")
	arg_2_0._txtnamecn2 = gohelper.findChildText(arg_2_0.viewGO, "#go_contentroot/#go_conversation/#go_contents/content/#go_name/namelayout/#txt_namecn2")
	arg_2_0._txtnameen = gohelper.findChildText(arg_2_0.viewGO, "#go_contentroot/#go_conversation/#go_contents/content/#go_name/namelayout/#txt_nameen")
	arg_2_0._gocontents = gohelper.findChild(arg_2_0.viewGO, "#go_contentroot/#go_conversation/#go_contents")
	arg_2_0._gonoconversation = gohelper.findChild(arg_2_0.viewGO, "#go_contentroot/#go_noconversation")
	arg_2_0._gotop = gohelper.findChild(arg_2_0.viewGO, "#go_top")
	arg_2_0._goimg3 = gohelper.findChild(arg_2_0.viewGO, "#go_top/#go_img3")
	arg_2_0._govideo3 = gohelper.findChild(arg_2_0.viewGO, "#go_top/#go_video3")
	arg_2_0._goeff3 = gohelper.findChild(arg_2_0.viewGO, "#go_top/#go_eff3")

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	return
end

function var_0_0.removeEvents(arg_4_0)
	return
end

function var_0_0._btnnextOnClick(arg_5_0)
	if StoryModel.instance:isViewHide() then
		StoryModel.instance:setViewHide(false)
		gohelper.setActive(arg_5_0._gocontentroot, StoryModel.instance:isNormalStep())
		StoryController.instance:dispatchEvent(StoryEvent.LeadRoleViewShow, StoryModel.instance:isNormalStep())

		return
	end

	if StoryModel.instance:isStoryAuto() then
		return
	end

	if not arg_5_0._stepCo then
		return
	end

	if arg_5_0:_isUnInteractType() then
		return
	end

	if StoryModel.instance:isNormalStep() then
		if StoryModel.instance:isTextShowing() then
			arg_5_0._dialogItem:conFinished()
			arg_5_0:_conFinished()
		else
			arg_5_0:_enterNextStep()
		end
	end
end

function var_0_0._isUnInteractType(arg_6_0)
	if not arg_6_0._stepCo then
		return true
	end

	if arg_6_0._stepCo.conversation.type == StoryEnum.ConversationType.None then
		return true
	end

	if arg_6_0._stepCo.conversation.type == StoryEnum.ConversationType.NoInteract then
		return true
	end

	if arg_6_0._stepCo.conversation.type == StoryEnum.ConversationType.ScreenDialog then
		return true
	end

	if arg_6_0._stepCo.conversation.type == StoryEnum.ConversationType.IrregularShake then
		return true
	end

	return false
end

function var_0_0._btnhideOnClick(arg_7_0)
	StoryController.instance:dispatchEvent(StoryEvent.LeadRoleViewShow, false)
	gohelper.setActive(arg_7_0._gocontentroot, false)
end

function var_0_0._btnlogOnClick(arg_8_0)
	StoryController.instance:openStoryLogView()
end

function var_0_0._btnautoOnClick(arg_9_0)
	if not arg_9_0._stepCo then
		return
	end

	if not arg_9_0:_isUnInteractType() then
		arg_9_0._dialogItem:startAutoEnterNext()
	end
end

function var_0_0._btnskipOnClick(arg_10_0, arg_10_1)
	if not arg_10_1 and not StoryModel.instance:isNormalStep() then
		return
	end

	StoryTool.enablePostProcess(true)

	if arg_10_0._curStoryId == SDKMediaEventEnum.FirstStoryId then
		local var_10_0 = string.format(PlayerPrefsKey.SDKDataTrackMgr_MediaEvent_first_story_skip, PlayerModel.instance:getMyUserId())

		if PlayerPrefsHelper.getNumber(var_10_0, 0) == 0 then
			SDKDataTrackMgr.instance:trackMediaEvent(SDKDataTrackMgr.MediaEvent.first_story_skip)
			PlayerPrefsHelper.setNumber(var_10_0, 1)
		end
	end

	arg_10_0:_skipStep(arg_10_1)
end

function var_0_0._editableInitView(arg_11_0)
	arg_11_0:_initData()
	arg_11_0:_initView()
end

function var_0_0.addEvent(arg_12_0)
	arg_12_0:addEventCb(StoryController.instance, StoryEvent.RefreshStep, arg_12_0._onUpdateUI, arg_12_0)
	arg_12_0:addEventCb(StoryController.instance, StoryEvent.AllStepFinished, arg_12_0._storyFinished, arg_12_0)
	arg_12_0:addEventCb(StoryController.instance, StoryEvent.RefreshView, arg_12_0._refreshView, arg_12_0)
	arg_12_0:addEventCb(StoryController.instance, StoryEvent.RefreshConversation, arg_12_0._updateConversation, arg_12_0)
	arg_12_0:addEventCb(StoryController.instance, StoryEvent.Log, arg_12_0._btnlogOnClick, arg_12_0)
	arg_12_0:addEventCb(StoryController.instance, StoryEvent.Hide, arg_12_0._btnhideOnClick, arg_12_0)
	arg_12_0:addEventCb(StoryController.instance, StoryEvent.Auto, arg_12_0._btnautoOnClick, arg_12_0)
	arg_12_0:addEventCb(StoryController.instance, StoryEvent.Skip, arg_12_0._btnskipOnClick, arg_12_0)
	arg_12_0:addEventCb(StoryController.instance, StoryEvent.PvPause, arg_12_0._btnPvPauseOnClick, arg_12_0)
	arg_12_0:addEventCb(StoryController.instance, StoryEvent.PvPlay, arg_12_0._btnPvPlayOnClick, arg_12_0)
	arg_12_0:addEventCb(StoryController.instance, StoryEvent.EnterNextStep, arg_12_0._btnnextOnClick, arg_12_0)
	arg_12_0:addEventCb(StoryController.instance, StoryEvent.Finish, arg_12_0._clearItems, arg_12_0)
	arg_12_0:addEventCb(StoryController.instance, StoryEvent.FullTextLineShowFinished, arg_12_0._onFullTextShowFinished, arg_12_0)
	arg_12_0:addEventCb(StoryController.instance, StoryEvent.HideDialog, arg_12_0._hideDialog, arg_12_0)
	arg_12_0:addEventCb(StoryController.instance, StoryEvent.DialogConFinished, arg_12_0._dialogConFinished, arg_12_0)
end

function var_0_0.removeEvent(arg_13_0)
	arg_13_0:removeEventCb(StoryController.instance, StoryEvent.RefreshStep, arg_13_0._onUpdateUI, arg_13_0)
	arg_13_0:removeEventCb(StoryController.instance, StoryEvent.AllStepFinished, arg_13_0._storyFinished, arg_13_0)
	arg_13_0:removeEventCb(StoryController.instance, StoryEvent.RefreshView, arg_13_0._refreshView, arg_13_0)
	arg_13_0:removeEventCb(StoryController.instance, StoryEvent.RefreshConversation, arg_13_0._updateConversation, arg_13_0)
	arg_13_0:removeEventCb(StoryController.instance, StoryEvent.Log, arg_13_0._btnlogOnClick, arg_13_0)
	arg_13_0:removeEventCb(StoryController.instance, StoryEvent.Hide, arg_13_0._btnhideOnClick, arg_13_0)
	arg_13_0:removeEventCb(StoryController.instance, StoryEvent.Auto, arg_13_0._btnautoOnClick, arg_13_0)
	arg_13_0:removeEventCb(StoryController.instance, StoryEvent.Skip, arg_13_0._btnskipOnClick, arg_13_0)
	arg_13_0:removeEventCb(StoryController.instance, StoryEvent.PvPause, arg_13_0._btnPvPauseOnClick, arg_13_0)
	arg_13_0:removeEventCb(StoryController.instance, StoryEvent.PvPlay, arg_13_0._btnPvPlayOnClick, arg_13_0)
	arg_13_0:removeEventCb(StoryController.instance, StoryEvent.EnterNextStep, arg_13_0._btnnextOnClick, arg_13_0)
	arg_13_0:removeEventCb(StoryController.instance, StoryEvent.Finish, arg_13_0._clearItems, arg_13_0)
	arg_13_0:removeEventCb(StoryController.instance, StoryEvent.FullTextLineShowFinished, arg_13_0._onFullTextShowFinished, arg_13_0)
	arg_13_0:removeEventCb(StoryController.instance, StoryEvent.HideDialog, arg_13_0._hideDialog, arg_13_0)
	arg_13_0:removeEventCb(StoryController.instance, StoryEvent.DialogConFinished, arg_13_0._dialogConFinished, arg_13_0)
end

function var_0_0._btnPvPauseOnClick(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0._videos) do
		iter_14_1:pause(true)
	end
end

function var_0_0._btnPvPlayOnClick(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0._videos) do
		iter_15_1:pause(false)
	end
end

function var_0_0._initData(arg_16_0)
	arg_16_0._stepId = 0
	arg_16_0._audios = {}
	arg_16_0._pictures = {}
	arg_16_0._effects = {}
	arg_16_0._videos = {}
	arg_16_0._initFullBottomAlpha = arg_16_0._imagefullbottom.color.a

	StoryModel.instance:resetStoryState()
end

function var_0_0._initView(arg_17_0)
	arg_17_0._conCanvasGroup = arg_17_0._gocontentroot:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_17_0._contentAnimator = arg_17_0._goconversation:GetComponent(typeof(UnityEngine.Animator))

	local var_17_0 = ViewMgr.instance:getContainer(ViewName.StoryBackgroundView).viewGO

	arg_17_0._gobottom = gohelper.findChild(var_17_0, "#go_bottomitem")
	arg_17_0._goimg1 = gohelper.findChild(var_17_0, "#go_bottomitem/#go_img1")
	arg_17_0._govideo1 = gohelper.findChild(var_17_0, "#go_bottomitem/#go_video1")
	arg_17_0._goeff1 = gohelper.findChild(var_17_0, "#go_bottomitem/#go_eff1")

	gohelper.setActive(arg_17_0._gocontentroot, false)
	arg_17_0:_initItems()
end

function var_0_0.onOpen(arg_18_0)
	arg_18_0:addEvent()
	ViewMgr.instance:openView(ViewName.StoryFrontView, nil, true)
	gohelper.setActive(arg_18_0.viewGO, true)
	SpineFpsMgr.instance:set(SpineFpsMgr.Story)

	if UnityEngine.Shader.IsKeywordEnabled("_MAININTERFACELIGHT") then
		arg_18_0._keywordEnable = true

		UnityEngine.Shader.DisableKeyword("_MAININTERFACELIGHT")
	end

	arg_18_0:_clearItems()
end

function var_0_0._initItems(arg_19_0)
	if not arg_19_0._dialogItem then
		arg_19_0._dialogItem = StoryDialogItem.New()

		arg_19_0._dialogItem:init(arg_19_0._gocontentroot)
		arg_19_0._dialogItem:hideDialog()
	end
end

function var_0_0._hideDialog(arg_20_0)
	if arg_20_0._dialogItem then
		if StoryModel.instance:isTextShowing() then
			arg_20_0._dialogItem:conFinished()
			arg_20_0:_conFinished()
		end

		gohelper.setActive(arg_20_0._gocontentroot, false)
	end
end

function var_0_0._dialogConFinished(arg_21_0)
	if arg_21_0._dialogItem and StoryModel.instance:isTextShowing() then
		arg_21_0._dialogItem:conFinished()
		arg_21_0:_conFinished()
	end
end

function var_0_0._storyFinished(arg_22_0, arg_22_1)
	arg_22_0:_clearAllTimers()

	arg_22_0._stepId = 0
	arg_22_0._finished = true
	arg_22_0._stepCo = nil

	TaskDispatcher.cancelTask(arg_22_0._onCheckNext, arg_22_0)
	arg_22_0._dialogItem:storyFinished()
	StoryModel.instance:enableClick(false)

	if arg_22_0._dialogItem then
		arg_22_0._dialogItem:stopConAudio()
	end

	if StoryController.instance._hideStartAndEndDark then
		arg_22_0:stopAllAudio(1.5)
		gohelper.setActive(arg_22_0._gospine, false)

		if arg_22_0._confadeId then
			ZProj.TweenHelper.KillById(arg_22_0._confadeId)
		end

		arg_22_0._confadeId = ZProj.TweenHelper.DOFadeCanvasGroup(arg_22_0._gocontentroot, 1, 0, 0.35, nil, nil, nil, EaseType.Linear)

		return
	end

	if StoryModel.instance:isTypeSkip(StoryEnum.SkipType.OutDarkFade, StoryController.instance._curStoryId) then
		return
	end

	arg_22_0:stopAllAudio(1.5)
end

function var_0_0.onClose(arg_23_0)
	arg_23_0:_clearAllTimers()

	if not arg_23_0._finished then
		arg_23_0:stopAllAudio(0)
	end

	if arg_23_0._keywordEnable then
		UnityEngine.Shader.EnableKeyword("_MAININTERFACELIGHT")
	end

	arg_23_0:removeEvent()
	TaskDispatcher.cancelTask(arg_23_0._viewFadeIn, arg_23_0)
	arg_23_0:_clearItems()
	SpineFpsMgr.instance:remove(SpineFpsMgr.Story)
end

function var_0_0.onUpdateParam(arg_24_0)
	return
end

function var_0_0._enterNextStep(arg_25_0)
	StoryController.instance:dispatchEvent(StoryEvent.PlayFullTextOut)

	if arg_25_0._diaLineTxt and arg_25_0._diaLineTxt[2] then
		local var_25_0, var_25_1, var_25_2 = transformhelper.getLocalPos(arg_25_0._diaLineTxt[2].transform)

		transformhelper.setLocalPos(arg_25_0._diaLineTxt[2].transform, var_25_0, var_25_1, 1)
	end

	TaskDispatcher.cancelTask(arg_25_0._enterNextStep, arg_25_0)
	TaskDispatcher.cancelTask(arg_25_0._guaranteeEnterNextStep, arg_25_0)
	StoryController.instance:enterNext()
end

function var_0_0._guaranteeEnterNextStep(arg_26_0)
	arg_26_0:_enterNextStep()
end

function var_0_0._skipStep(arg_27_0, arg_27_1)
	StoryModel.instance:enableClick(false)
	TaskDispatcher.cancelTask(arg_27_0._enterNextStep, arg_27_0)
	TaskDispatcher.cancelTask(arg_27_0._playShowHero, arg_27_0)

	if arg_27_1 then
		StoryController.instance:skipAllStory()
	else
		StoryController.instance:skipStory()
	end
end

function var_0_0._onCheckNext(arg_28_0)
	arg_28_0:_onConFinished(arg_28_0._stepCo.conversation.isAuto)
end

function var_0_0._onUpdateUI(arg_29_0, arg_29_1)
	arg_29_0._finished = false

	StoryModel.instance:setStepNormal(arg_29_1.stepType == StoryEnum.StepType.Normal)

	if arg_29_0._gocontentroot.activeSelf ~= StoryModel.instance:isNormalStep() then
		gohelper.setActive(arg_29_0._gocontentroot, not StoryModel.instance:isNormalStep())
		StoryController.instance:dispatchEvent(StoryEvent.LeadRoleViewShow, not StoryModel.instance:isNormalStep())
	end

	if arg_29_0._curStoryId ~= arg_29_1.storyId and #arg_29_1.branches < 1 then
		arg_29_0:_clearItems()

		arg_29_0._curStoryId = arg_29_1.storyId
	end

	arg_29_0:_updateStep(arg_29_1.stepId)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshHero, arg_29_1)

	if #arg_29_1.branches > 0 then
		StoryController.instance:openStoryBranchView(arg_29_1.branches)
		arg_29_0:_showBranchLeadHero()
	else
		gohelper.setActive(arg_29_0._gonoconversation, false)
	end

	StoryModel.instance:clearStepLine()
end

function var_0_0._showBranchLeadHero(arg_30_0)
	arg_30_0._dialogItem:hideDialog()
	arg_30_0._dialogItem:stopConAudio()

	if arg_30_0._confadeId then
		ZProj.TweenHelper.KillById(arg_30_0._confadeId)
	end

	TaskDispatcher.cancelTask(arg_30_0._conShowIn, arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0._startShowText, arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0._startShake, arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0._shakeStop, arg_30_0)
	TaskDispatcher.cancelTask(arg_30_0._enterNextStep, arg_30_0)

	arg_30_0._conCanvasGroup.alpha = 1

	gohelper.setActive(arg_30_0._goname, true)
	gohelper.setActive(arg_30_0._txtnameen.gameObject, true)
	gohelper.setActive(arg_30_0._gocontentroot, true)
	gohelper.setActive(arg_30_0._gonoconversation, true)

	local var_30_0

	for iter_30_0, iter_30_1 in pairs(arg_30_0._stepCo.optList) do
		if iter_30_1.condition and iter_30_1.conditionType == StoryEnum.OptionConditionType.NormalLead then
			arg_30_0:_showNormalLeadHero(iter_30_1)

			return
		elseif iter_30_1.condition and iter_30_1.conditionType == StoryEnum.OptionConditionType.MainSpine then
			arg_30_0:_showSpineLeadHero(iter_30_1)

			return
		end
	end

	arg_30_0:_showSpineLeadHero()
end

function var_0_0._showNormalLeadHero(arg_31_0, arg_31_1)
	gohelper.setActive(arg_31_0._gohead, true)
	gohelper.setActive(arg_31_0._gospine, false)

	local var_31_0 = arg_31_1.conditionValue2[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]
	local var_31_1 = arg_31_1.conditionValue2[LanguageEnum.LanguageStoryType.EN]

	arg_31_0:_showHeadContentTxt(var_31_0, var_31_1)
	arg_31_0:_showHeadContentIcon(arg_31_1.conditionValue)
end

function var_0_0._showSpineLeadHero(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_1 and string.split(arg_32_1.conditionValue, ".")[1] or nil

	StoryController.instance:dispatchEvent(StoryEvent.LeadRoleViewShow, true, var_32_0)
	gohelper.setActive(arg_32_0._gohead, false)
	gohelper.setActive(arg_32_0._gospine, true)

	arg_32_0._txtnamecn1.text = luaLang("mainrolename")
	arg_32_0._txtnamecn2.text = luaLang("mainrolename")
	arg_32_0._txtnameen.text = "<voffset=4>/ </voffset>Vertin"

	if arg_32_1 then
		return
	end

	local var_32_1 = 1

	if arg_32_0._stepCo and arg_32_0._stepCo.optList[1] and arg_32_0._stepCo.optList[1].feedbackType == StoryEnum.OptionFeedbackType.HeroLead then
		var_32_1 = arg_32_0._stepCo.optList[1].feedbackValue ~= "" and tonumber(arg_32_0._stepCo.optList[1].feedbackValue) or 1
	end

	StoryController.instance:dispatchEvent(StoryEvent.ShowLeadRole, arg_32_0._stepCo, true, false, false, var_32_1)
	gohelper.setActive(arg_32_0._txtnamecn1.gameObject, true)
	gohelper.setActive(arg_32_0._txtnamecn2.gameObject, false)

	if GameLanguageMgr.instance:getLanguageTypeStoryIndex() ~= LanguageEnum.LanguageStoryType.EN then
		arg_32_0._txtnameen.text = "<voffset=4>/ </voffset>Vertin"

		gohelper.setActive(arg_32_0._txtnameen.gameObject, true)
	else
		arg_32_0._txtnameen.text = ""

		gohelper.setActive(arg_32_0._txtnameen.gameObject, false)
	end
end

function var_0_0._updateStep(arg_33_0, arg_33_1)
	if not StoryModel.instance:isNormalStep() then
		return
	end

	arg_33_0._stepCo = StoryStepModel.instance:getStepListById(arg_33_1)

	if arg_33_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.SoftLight then
		gohelper.setActive(arg_33_0._goline, false)
		gohelper.setActive(arg_33_0._gonexticon, false)
		gohelper.setActive(arg_33_0._goblackbottom, false)
	else
		gohelper.setActive(arg_33_0._goline, true)
		gohelper.setActive(arg_33_0._gonexticon, true)
		gohelper.setActive(arg_33_0._goblackbottom, true)
	end

	if arg_33_0._stepCo.bg.transType ~= StoryEnum.BgTransType.DarkFade and arg_33_0._stepCo.bg.transType ~= StoryEnum.BgTransType.WhiteFade then
		arg_33_0:_refreshView()
	else
		arg_33_0:_updateEffectList(arg_33_0._stepCo.effList)
		arg_33_0:_updateAudioList(arg_33_0._stepCo.audioList)
	end
end

function var_0_0._refreshView(arg_34_0)
	arg_34_0:_updateEffectList(arg_34_0._stepCo.effList)
	arg_34_0:_updateAudioList(arg_34_0._stepCo.audioList)
	arg_34_0:_updatePictureList(arg_34_0._stepCo.picList)
	arg_34_0:_updateVideoList(arg_34_0._stepCo.videoList)
	arg_34_0:_updateNavigateList(arg_34_0._stepCo.navigateList)
	arg_34_0:_updateOptionList(arg_34_0._stepCo.optList)
end

function var_0_0._updateConversation(arg_35_0)
	if not arg_35_0._stepCo then
		return
	end

	if not arg_35_0._stepId then
		arg_35_0._stepId = 0

		return
	end

	if arg_35_0._storyId and arg_35_0._storyId == arg_35_0._curStoryId and arg_35_0._stepId == arg_35_0._stepCo.id then
		arg_35_0._stepId = 0

		return
	end

	StoryModel.instance:enableClick(false)

	arg_35_0._stepId = arg_35_0._stepCo.id
	arg_35_0._storyId = arg_35_0._curStoryId

	if arg_35_0._confadeId then
		ZProj.TweenHelper.KillById(arg_35_0._confadeId)
	end

	TaskDispatcher.cancelTask(arg_35_0._conShowIn, arg_35_0)
	TaskDispatcher.cancelTask(arg_35_0._onEnableClick, arg_35_0)
	TaskDispatcher.cancelTask(arg_35_0._enterNextStep, arg_35_0)
	TaskDispatcher.cancelTask(arg_35_0._onFullTextKeepFinished, arg_35_0)
	TaskDispatcher.cancelTask(arg_35_0._startShowText, arg_35_0)
	TaskDispatcher.cancelTask(arg_35_0._onCheckNext, arg_35_0)

	if arg_35_0._stepCo.conversation.type ~= StoryEnum.ConversationType.None then
		StoryModel.instance:setTextShowing(true)
	end

	if StoryModel.instance:isNeedFadeOut() then
		if arg_35_0._gospine.activeSelf then
			StoryController.instance:dispatchEvent(StoryEvent.ShowLeadRole, arg_35_0._stepCo, true, false, true)
		end

		arg_35_0._confadeId = ZProj.TweenHelper.DOFadeCanvasGroup(arg_35_0._gocontentroot, 1, 0, 0.35, nil, nil, nil, EaseType.Linear)

		if not StoryModel.instance:isPlayFinished() then
			TaskDispatcher.runDelay(arg_35_0._conShowIn, arg_35_0, 0.35)
		end
	else
		arg_35_0:_conShowIn()
	end
end

function var_0_0._conShowIn(arg_36_0)
	if not arg_36_0._stepCo then
		return
	end

	arg_36_0._diatxt = StoryTool.getFilterDia(arg_36_0._stepCo.conversation.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()])

	arg_36_0._dialogItem:hideDialog()
	TaskDispatcher.cancelTask(arg_36_0._enterNextStep, arg_36_0)
	TaskDispatcher.cancelTask(arg_36_0._onFullTextKeepFinished, arg_36_0)
	TaskDispatcher.cancelTask(arg_36_0._guaranteeEnterNextStep, arg_36_0)
	TaskDispatcher.cancelTask(arg_36_0._onFullTextFinished, arg_36_0)
	TaskDispatcher.cancelTask(arg_36_0._startShowText, arg_36_0)

	if arg_36_0._stepCo.conversation.type == StoryEnum.ConversationType.None then
		arg_36_0:_showConversationItem(false)
		TaskDispatcher.runDelay(arg_36_0._guaranteeEnterNextStep, arg_36_0, arg_36_0._stepCo.conversation.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] + 0.2)
		TaskDispatcher.runDelay(arg_36_0._enterNextStep, arg_36_0, arg_36_0._stepCo.conversation.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	else
		StoryController.instance:dispatchEvent(StoryEvent.SetFullText, "")

		if arg_36_0._stepCo.conversation.type == StoryEnum.ConversationType.NoInteract then
			StoryModel.instance:enableClick(false)
			TaskDispatcher.runDelay(arg_36_0._guaranteeEnterNextStep, arg_36_0, arg_36_0._stepCo.conversation.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] + 0.2)
			TaskDispatcher.runDelay(arg_36_0._enterNextStep, arg_36_0, arg_36_0._stepCo.conversation.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
		end

		arg_36_0:_showConversationItem(true)
	end

	if StoryModel.instance:isNeedFadeIn() then
		if arg_36_0._gospine.activeSelf then
			StoryController.instance:dispatchEvent(StoryEvent.ShowLeadRole, arg_36_0._stepCo, true, true, false)
		end

		arg_36_0._confadeId = ZProj.TweenHelper.DOFadeCanvasGroup(arg_36_0._gocontentroot, 0, 1, 0.5, nil, nil, nil, EaseType.Linear)

		TaskDispatcher.runDelay(arg_36_0._startShowText, arg_36_0, 0.5)
	else
		arg_36_0:_startShowText()
	end
end

function var_0_0._startShowText(arg_37_0)
	if not arg_37_0._stepCo then
		return
	end

	arg_37_0._conCanvasGroup.alpha = 1

	if arg_37_0._stepCo.conversation.effType ~= StoryEnum.ConversationEffectType.Shake then
		StoryController.instance:dispatchEvent(StoryEvent.ConversationShake, arg_37_0._stepCo, 0, true)
		TaskDispatcher.cancelTask(arg_37_0._startShake, arg_37_0)
		TaskDispatcher.cancelTask(arg_37_0._shakeStop, arg_37_0)
		arg_37_0._contentAnimator:Play(UIAnimationName.Idle)
	end

	arg_37_0:_showText()
end

function var_0_0._showConversationItem(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_0._stepCo.conversation.type ~= StoryEnum.ConversationType.ScreenDialog and arg_38_0._stepCo.conversation.type ~= StoryEnum.ConversationType.IrregularShake
	local var_38_1 = arg_38_0._stepCo.conversation.type == StoryEnum.ConversationType.SlideDialog

	if not arg_38_1 then
		gohelper.setActive(arg_38_0._gocontentroot, false)
		arg_38_0._simagehead:UnLoadImage()
		StoryController.instance:dispatchEvent(StoryEvent.LeadRoleViewShow, false)

		return
	end

	StoryController.instance:dispatchEvent(StoryEvent.SetFullText, arg_38_0._diatxt)
	gohelper.setActive(arg_38_0._gobtns, var_38_0)
	gohelper.setActive(arg_38_0._gocontentroot, var_38_0)
	gohelper.setActive(arg_38_0._goconversation, not var_38_1)
	StoryController.instance:dispatchEvent(StoryEvent.LeadRoleViewShow, var_38_0)

	local var_38_2 = arg_38_0._stepCo.conversation.heroNames[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]
	local var_38_3 = arg_38_0._stepCo.conversation.heroNames[LanguageEnum.LanguageStoryType.EN]

	arg_38_0:_showHeadContentTxt(var_38_2, var_38_3)
	gohelper.setActive(arg_38_0._goname, arg_38_0._stepCo.conversation.nameShow)

	local var_38_4 = tonumber(arg_38_0._stepCo.conversation.heroNames[LanguageEnum.LanguageStoryType.CN])
	local var_38_5 = arg_38_0._stepCo.conversation.nameEnShow

	if var_38_4 and GameLanguageMgr.instance:getLanguageTypeStoryIndex() == LanguageEnum.LanguageStoryType.EN then
		var_38_5 = false
	end

	gohelper.setActive(arg_38_0._txtnameen.gameObject, var_38_5)

	if not arg_38_0._stepCo.conversation.iconShow then
		gohelper.setActive(arg_38_0._gohead, false)
		gohelper.setActive(arg_38_0._gospine, false)
		gohelper.setActive(arg_38_0._gonamebg, false)
		arg_38_0._simagehead:UnLoadImage()
		StoryController.instance:dispatchEvent(StoryEvent.ShowLeadRole, arg_38_0._stepCo, false, false, false)

		return
	end

	arg_38_0:_showHeadContentIcon(arg_38_0._stepCo.conversation.heroIcon)
end

function var_0_0._showHeadContentTxt(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = string.match(arg_39_1, "[^?]") == nil

	gohelper.setActive(arg_39_0._txtnamecn1.gameObject, not var_39_0)
	gohelper.setActive(arg_39_0._txtnamecn2.gameObject, var_39_0)

	if var_39_0 then
		arg_39_0._txtnamecn2.text = string.split(arg_39_1, "_")[1]
	else
		arg_39_0._txtnamecn1.text = string.split(arg_39_1, "_")[1]
	end

	local var_39_1 = tonumber(arg_39_0._stepCo.conversation.heroNames[LanguageEnum.LanguageStoryType.CN])

	if (var_39_1 and StoryTool.FilterStrByPatterns(arg_39_1, {
		"%a",
		"%s",
		"%p"
	}) or StoryTool.FilterStrByPatterns(arg_39_1, {
		"%w",
		"%s",
		"%p"
	})) ~= "" and GameLanguageMgr.instance:getLanguageTypeStoryIndex() ~= LanguageEnum.LanguageStoryType.EN then
		if LangSettings.instance:isJp() and arg_39_2 == "Aleph" then
			arg_39_2 = ""
		end

		arg_39_0._txtnameen.text = arg_39_2 ~= "" and "<voffset=4>/ </voffset>" .. arg_39_2 or ""

		gohelper.setActive(arg_39_0._txtnameen.gameObject, true)
	else
		arg_39_0._txtnameen.text = ""

		if var_39_1 and GameLanguageMgr.instance:getLanguageTypeStoryIndex() == LanguageEnum.LanguageStoryType.EN then
			arg_39_0._txtnamecn1.text = arg_39_0._stepCo.conversation.heroNames[LanguageEnum.LanguageStoryType.CN]
		end

		gohelper.setActive(arg_39_0._txtnameen.gameObject, false)
	end
end

function var_0_0._showHeadContentIcon(arg_40_0, arg_40_1)
	if arg_40_0._goeffectIcon then
		gohelper.destroy(arg_40_0._goeffectIcon)

		arg_40_0._goeffectIcon = nil
	end

	if arg_40_0:_isHeroLead() then
		gohelper.setActive(arg_40_0._gohead, false)
		gohelper.setActive(arg_40_0._gospine, true)
		gohelper.setActive(arg_40_0._gonamebg, true)
		arg_40_0._simagehead:UnLoadImage()
		StoryController.instance:dispatchEvent(StoryEvent.ShowLeadRole, arg_40_0._stepCo, true, false, false)
	else
		gohelper.setActive(arg_40_0._gospine, false)
		gohelper.setActive(arg_40_0._gonamebg, false)
		gohelper.setActive(arg_40_0._gohead, true)

		local var_40_0 = StoryModel.instance:isHeroIconCuts(string.split(arg_40_1, ".")[1])

		gohelper.setActive(arg_40_0._goheadblack, not var_40_0)
		gohelper.setActive(arg_40_0._goheadgrey, false)
		StoryController.instance:dispatchEvent(StoryEvent.ShowLeadRole, arg_40_0._stepCo, false, false, false)

		local var_40_1 = arg_40_0:_getEffectHeadIconCo()

		if var_40_1 then
			arg_40_0._headEffectResPath = ResUrl.getStoryPrefabRes(var_40_1.path)

			local var_40_2 = {}

			table.insert(var_40_2, arg_40_0._headEffectResPath)
			arg_40_0:loadRes(var_40_2, arg_40_0._headEffectResLoaded, arg_40_0)
			gohelper.setActive(arg_40_0._goheadgrey, true)
		else
			local var_40_3 = string.format("singlebg/headicon_small/%s", arg_40_1)

			if arg_40_0._simagehead.curImageUrl == var_40_3 then
				gohelper.setActive(arg_40_0._goheadgrey, true)
			else
				arg_40_0._simagehead:LoadImage(var_40_3, function()
					gohelper.setActive(arg_40_0._goheadgrey, true)
				end)
			end
		end
	end
end

function var_0_0._headEffectResLoaded(arg_42_0)
	if arg_42_0._headEffectResPath then
		local var_42_0 = arg_42_0._loader:getAssetItem(arg_42_0._headEffectResPath)

		arg_42_0._goeffectIcon = gohelper.clone(var_42_0:GetResource(), arg_42_0._gohead)
	end
end

function var_0_0.loadRes(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
	if arg_43_0._loader then
		arg_43_0._loader:dispose()

		arg_43_0._loader = nil
	end

	if arg_43_1 and #arg_43_1 > 0 then
		arg_43_0._loader = MultiAbLoader.New()

		arg_43_0._loader:setPathList(arg_43_1)
		arg_43_0._loader:startLoad(arg_43_2, arg_43_3)
	elseif arg_43_2 then
		arg_43_2(arg_43_3)
	end
end

function var_0_0._getEffectHeadIconCo(arg_44_0)
	local var_44_0 = string.split(arg_44_0._stepCo.conversation.heroIcon, ".")[1]
	local var_44_1 = StoryConfig.instance:getStoryLeadHeroSpine()

	for iter_44_0, iter_44_1 in ipairs(var_44_1) do
		if iter_44_1.resType == StoryEnum.IconResType.IconEff and iter_44_1.icon == var_44_0 then
			return iter_44_1
		end
	end

	return nil
end

function var_0_0._isHeroLead(arg_45_0)
	local var_45_0 = string.split(arg_45_0._stepCo.conversation.heroIcon, ".")[1]
	local var_45_1 = StoryConfig.instance:getStoryLeadHeroSpine()

	for iter_45_0, iter_45_1 in ipairs(var_45_1) do
		if iter_45_1.resType == StoryEnum.IconResType.Spine and iter_45_1.icon == var_45_0 then
			return true
		end
	end

	return false
end

function var_0_0._showText(arg_46_0)
	if arg_46_0._stepCo.conversation.type == StoryEnum.ConversationType.None then
		arg_46_0._dialogItem:stopConAudio()

		return
	end

	StoryModel.instance:setTextShowing(true)

	if arg_46_0._stepCo.conversation.type == StoryEnum.ConversationType.ScreenDialog then
		StoryModel.instance:enableClick(false)
		arg_46_0:_playDialog()
		StoryController.instance:dispatchEvent(StoryEvent.PlayFullText, arg_46_0._stepCo)
	elseif arg_46_0._stepCo.conversation.type == StoryEnum.ConversationType.IrregularShake then
		StoryModel.instance:enableClick(false)
		arg_46_0:_playDialog()
		StoryController.instance:dispatchEvent(StoryEvent.PlayIrregularShakeText, arg_46_0._stepCo)
	else
		StoryModel.instance:enableClick(true)
		arg_46_0:_playDialog()
	end

	if arg_46_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Shake then
		arg_46_0:_shakeDialog()
	elseif arg_46_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Fade then
		arg_46_0:_fadeIn()
	elseif arg_46_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.WordByWord then
		-- block empty
	elseif arg_46_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.LineByLine then
		arg_46_0:_lineShow(1)
	elseif arg_46_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.TwoLineShow then
		arg_46_0:_lineShow(2)
	end
end

function var_0_0._playDialog(arg_47_0)
	arg_47_0._finishTime = nil

	arg_47_0._dialogItem:hideDialog()

	local var_47_0 = arg_47_0._stepCo.conversation.audios[1] or 0
	local var_47_1 = StoryModel.instance:getStoryTxtByVoiceType(arg_47_0._diatxt, var_47_0)

	arg_47_0._dialogItem:playDialog(var_47_1, arg_47_0._stepCo, arg_47_0._conFinished, arg_47_0)
end

function var_0_0._conFinished(arg_48_0)
	StoryModel.instance:setTextShowing(false)

	if arg_48_0._conTweenId then
		ZProj.TweenHelper.KillById(arg_48_0._conTweenId)

		arg_48_0._conTweenId = nil
	end

	local var_48_0 = false
	local var_48_1 = arg_48_0._stepCo and arg_48_0._stepCo.conversation.keepTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] or 1.5

	if StoryModel.instance:isStoryAuto() then
		if not arg_48_0._finishTime then
			arg_48_0._finishTime = ServerTime.now()
		end

		var_48_0 = var_48_1 < ServerTime.now() - arg_48_0._finishTime
	end

	arg_48_0._finishTime = ServerTime.now()

	if var_48_0 then
		arg_48_0:_onCheckNext()
	else
		TaskDispatcher.runDelay(arg_48_0._onCheckNext, arg_48_0, var_48_1)
	end
end

function var_0_0._shakeDialog(arg_49_0)
	TaskDispatcher.cancelTask(arg_49_0._startShake, arg_49_0)
	TaskDispatcher.cancelTask(arg_49_0._shakeStop, arg_49_0)

	if arg_49_0._stepCo.conversation.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		return
	end

	if arg_49_0._stepCo.conversation.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		arg_49_0:_startShake()
	else
		TaskDispatcher.runDelay(arg_49_0._startShake, arg_49_0, arg_49_0._stepCo.conversation.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	end
end

function var_0_0._startShake(arg_50_0)
	TaskDispatcher.cancelTask(arg_50_0._shakeStop, arg_50_0)

	local var_50_0 = {
		"low",
		"middle",
		"high"
	}

	arg_50_0._contentAnimator:Play(var_50_0[arg_50_0._stepCo.conversation.effLv + 1])

	arg_50_0._contentAnimator.speed = arg_50_0._stepCo.conversation.effRate

	TaskDispatcher.runDelay(arg_50_0._shakeStop, arg_50_0, arg_50_0._stepCo.conversation.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	StoryController.instance:dispatchEvent(StoryEvent.ConversationShake, arg_50_0._stepCo, true, arg_50_0._stepCo.conversation.effLv + 1)
end

function var_0_0._shakeStop(arg_51_0)
	if not arg_51_0._stepCo then
		return
	end

	StoryController.instance:dispatchEvent(StoryEvent.ConversationShake, arg_51_0._stepCo, false, arg_51_0._stepCo.conversation.effLv + 1)

	arg_51_0._contentAnimator.speed = arg_51_0._stepCo.conversation.effRate

	arg_51_0._contentAnimator:SetBool("stoploop", true)
end

function var_0_0._fadeIn(arg_52_0)
	StoryModel.instance:setTextShowing(true)
	arg_52_0._dialogItem:playNorDialogFadeIn(arg_52_0._fadeInFinished, arg_52_0)
end

function var_0_0._fadeInFinished(arg_53_0)
	if not arg_53_0._stepCo then
		return
	end

	StoryModel.instance:setTextShowing(false)
	TaskDispatcher.cancelTask(arg_53_0._onCheckNext, arg_53_0)

	if not arg_53_0._stepCo then
		return
	end

	TaskDispatcher.runDelay(arg_53_0._onCheckNext, arg_53_0, arg_53_0._stepCo.conversation.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function var_0_0._wordByWord(arg_54_0)
	StoryModel.instance:setTextShowing(true)
	arg_54_0._dialogItem:playWordByWord(arg_54_0._wordByWordFinished, arg_54_0)
end

function var_0_0._wordByWordFinished(arg_55_0)
	StoryModel.instance:setTextShowing(false)
	TaskDispatcher.cancelTask(arg_55_0._onCheckNext, arg_55_0)

	if not arg_55_0._stepCo then
		return
	end

	TaskDispatcher.runDelay(arg_55_0._onCheckNext, arg_55_0, 1)
end

function var_0_0._lineShow(arg_56_0, arg_56_1)
	if not arg_56_0._stepCo then
		return
	end

	StoryModel.instance:enableClick(false)
	StoryModel.instance:setTextShowing(true)
	StoryController.instance:dispatchEvent(StoryEvent.PlayFullTextLineShow, arg_56_1, arg_56_0._stepCo)
end

function var_0_0._onFullTextShowFinished(arg_57_0)
	if not arg_57_0._stepCo then
		return
	end

	StoryModel.instance:setTextShowing(false)
	TaskDispatcher.cancelTask(arg_57_0._onFullTextKeepFinished, arg_57_0)
	TaskDispatcher.runDelay(arg_57_0._onFullTextKeepFinished, arg_57_0, arg_57_0._stepCo.conversation.keepTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function var_0_0._onFullTextKeepFinished(arg_58_0)
	StoryController.instance:dispatchEvent(StoryEvent.PlayFullTextOut, arg_58_0._onFullTextFadeOutFinished, arg_58_0)
end

function var_0_0._onFullTextFadeOutFinished(arg_59_0)
	StoryModel.instance:enableClick(true)
	TaskDispatcher.cancelTask(arg_59_0._onFullTextKeepFinished, arg_59_0)
	arg_59_0:_onConFinished(true)
end

function var_0_0._onConFinished(arg_60_0, arg_60_1)
	if arg_60_1 then
		arg_60_0:_onAutoDialogFinished()

		return
	end

	if StoryModel.instance:isStoryAuto() then
		if arg_60_0:_isUnInteractType() then
			return
		end

		if arg_60_0._dialogItem then
			if arg_60_0._dialogItem:isAudioPlaying() then
				arg_60_0._dialogItem:checkAutoEnterNext(arg_60_0._onAutoDialogFinished, arg_60_0)
			else
				arg_60_0:_onAutoDialogFinished()
			end
		end
	end
end

function var_0_0._onAutoDialogFinished(arg_61_0)
	StoryController.instance:enterNext()
end

function var_0_0._onEnableClick(arg_62_0)
	if StoryModel.instance:isTextShowing() then
		return
	end

	StoryModel.instance:enableClick(true)
end

function var_0_0._updateAudioList(arg_63_0, arg_63_1)
	local var_63_0 = {}
	local var_63_1 = StoryModel.instance:getStepLine()
	local var_63_2 = 0

	for iter_63_0, iter_63_1 in pairs(var_63_1) do
		var_63_2 = var_63_2 + 1
	end

	if var_63_2 > 1 then
		arg_63_0:stopAllAudio(0)
	end

	local var_63_3 = false

	if var_63_1[arg_63_0._curStoryId] then
		for iter_63_2, iter_63_3 in ipairs(var_63_1[arg_63_0._curStoryId]) do
			if iter_63_3.skip then
				var_63_3 = true

				break
			end
		end
	end

	if var_63_3 then
		arg_63_0:stopAllAudio(0)
	end

	if arg_63_0._curStoryId and arg_63_0._curStoryId == StoryController.instance._curStoryId and arg_63_0._stepId and arg_63_0._stepId == StoryController.instance._curStepId and arg_63_0._audios then
		for iter_63_4, iter_63_5 in pairs(arg_63_1) do
			if not arg_63_0._audios[iter_63_5.audio] then
				return
			end
		end
	end

	arg_63_0._audioCo = arg_63_1

	for iter_63_6, iter_63_7 in pairs(arg_63_0._audioCo) do
		if not arg_63_0._audios then
			arg_63_0._audios = {}
		end

		if not arg_63_0._audios[iter_63_7.audio] then
			arg_63_0._audios[iter_63_7.audio] = StoryAudioItem.New()

			arg_63_0._audios[iter_63_7.audio]:init(iter_63_7.audio)
		end

		arg_63_0._audios[iter_63_7.audio]:setAudio(iter_63_7)
	end
end

function var_0_0.stopAllAudio(arg_64_0, arg_64_1)
	if arg_64_0._audios then
		for iter_64_0, iter_64_1 in pairs(arg_64_0._audios) do
			iter_64_1:stop(arg_64_1)
		end

		arg_64_0._audios = nil
	end
end

function var_0_0._updateEffectList(arg_65_0, arg_65_1)
	local var_65_0 = {}
	local var_65_1 = StoryModel.instance:getStepLine()
	local var_65_2 = 0

	for iter_65_0, iter_65_1 in pairs(var_65_1) do
		var_65_2 = var_65_2 + 1
	end

	if var_65_2 > 1 then
		for iter_65_2, iter_65_3 in pairs(arg_65_0._effects) do
			iter_65_3:onDestroy()
		end
	end

	if var_65_1[arg_65_0._curStoryId] then
		for iter_65_4, iter_65_5 in ipairs(var_65_1[arg_65_0._curStoryId]) do
			if iter_65_5.skip and iter_65_5.skip then
				local var_65_3 = StoryStepModel.instance:getStepListById(iter_65_5.stepId).effList

				for iter_65_6 = 1, #var_65_3 do
					table.insert(var_65_0, var_65_3[iter_65_6])

					if var_65_3[iter_65_6].orderType == StoryEnum.EffectOrderType.Destroy then
						for iter_65_7 = #var_65_0, 1, -1 do
							if var_65_0[iter_65_7].orderType ~= StoryEnum.EffectOrderType.Destroy and var_65_0[iter_65_7].effect == var_65_3[iter_65_6].effect then
								table.remove(var_65_0, #var_65_0)
								table.remove(var_65_0, iter_65_7)
							end
						end
					end
				end
			end
		end
	end

	if #arg_65_1 < 1 and #var_65_0 == 0 then
		return
	end

	arg_65_0._effCo = #var_65_0 == 0 and arg_65_1 or var_65_0

	local var_65_4 = false

	for iter_65_8, iter_65_9 in pairs(arg_65_0._effCo) do
		if iter_65_9.orderType ~= StoryEnum.EffectOrderType.Destroy and iter_65_9.layer > 0 then
			arg_65_0:_buildEffect(iter_65_9.effect, iter_65_9)
		else
			arg_65_0:_destroyEffect(iter_65_9.effect, iter_65_9)
		end

		if iter_65_9.layer < 4 then
			var_65_4 = true
		end
	end

	StoryTool.enablePostProcess(false)

	for iter_65_10, iter_65_11 in pairs(arg_65_0._effects) do
		StoryTool.enablePostProcess(true)
	end

	StoryModel.instance:setHasBottomEffect(var_65_4)
end

function var_0_0._buildEffect(arg_66_0, arg_66_1, arg_66_2)
	local var_66_0 = 0
	local var_66_1

	if arg_66_2.layer < 4 then
		var_66_1 = arg_66_0._goeff1
		var_66_0 = 4
	elseif arg_66_2.layer < 7 then
		var_66_1 = arg_66_0._goeff2
		var_66_0 = 1000
	elseif arg_66_2.layer < 10 then
		var_66_1 = arg_66_0._goeff3
		var_66_0 = 2000
	else
		if not arg_66_0._goeff4 then
			local var_66_2 = ViewMgr.instance:getContainer(ViewName.StoryFrontView).viewGO

			arg_66_0._goeff4 = gohelper.findChild(var_66_2, "#go_frontitem/#go_eff4")
		end

		var_66_1 = arg_66_0._goeff4
	end

	if not arg_66_0._effects[arg_66_1] then
		arg_66_0._effects[arg_66_1] = StoryEffectItem.New()

		arg_66_0._effects[arg_66_1]:init(var_66_1, arg_66_1, arg_66_2, var_66_0)
	else
		arg_66_0._effects[arg_66_1]:reset(var_66_1, arg_66_2, var_66_0)
	end
end

function var_0_0._destroyEffect(arg_67_0, arg_67_1, arg_67_2)
	if not arg_67_0._effects[arg_67_1] then
		return
	end

	local var_67_0 = {
		callback = arg_67_0._effectRealDestroy,
		callbackObj = arg_67_0
	}

	arg_67_0._effects[arg_67_1]:destroyEffect(arg_67_2, var_67_0)
end

function var_0_0._effectRealDestroy(arg_68_0, arg_68_1)
	arg_68_0._effects[arg_68_1] = nil
end

function var_0_0._updatePictureList(arg_69_0, arg_69_1)
	local var_69_0 = {}
	local var_69_1 = StoryModel.instance:getStepLine()
	local var_69_2 = 0

	for iter_69_0, iter_69_1 in pairs(var_69_1) do
		var_69_2 = var_69_2 + 1
	end

	if var_69_2 > 1 then
		for iter_69_2, iter_69_3 in pairs(arg_69_0._pictures) do
			iter_69_3:onDestroy()
		end
	end

	local var_69_3 = false

	if var_69_1[arg_69_0._curStoryId] then
		for iter_69_4, iter_69_5 in ipairs(var_69_1[arg_69_0._curStoryId]) do
			local var_69_4 = StoryStepModel.instance:getStepListById(iter_69_5.stepId).picList

			if iter_69_5.skip then
				var_69_3 = true

				for iter_69_6 = 1, #var_69_4 do
					table.insert(var_69_0, var_69_4[iter_69_6])

					if var_69_4[iter_69_6].orderType == StoryEnum.PictureOrderType.Destroy then
						for iter_69_7 = #var_69_0, 1, -1 do
							if var_69_0[iter_69_7].orderType == StoryEnum.PictureOrderType.Produce and var_69_0[iter_69_7].picture == var_69_4[iter_69_6].picture then
								table.remove(var_69_0, #var_69_0)
								table.remove(var_69_0, iter_69_7)
							end
						end
					end
				end
			end
		end
	end

	arg_69_0:_resetStepPictures()

	if #arg_69_1 < 1 and #var_69_0 == 0 then
		return
	end

	arg_69_0._picCo = #var_69_0 > 0 and var_69_0 or arg_69_1

	for iter_69_8, iter_69_9 in pairs(arg_69_0._picCo) do
		local var_69_5 = iter_69_9.picType == StoryEnum.PictureType.FullScreen and "fullfocusitem" or iter_69_9.picture

		if iter_69_9.orderType == StoryEnum.PictureOrderType.Produce and iter_69_9.layer > 0 then
			arg_69_0:_buildPicture(var_69_5, iter_69_9, var_69_3)
		else
			arg_69_0:_destroyPicture(var_69_5, iter_69_9, var_69_3)
		end
	end

	arg_69_0:_checkFloatBgShow()
end

function var_0_0._resetStepPictures(arg_70_0)
	for iter_70_0, iter_70_1 in pairs(arg_70_0._pictures) do
		iter_70_1:resetStep()
	end
end

function var_0_0._checkFloatBgShow(arg_71_0)
	ZProj.TweenHelper.KillByObj(arg_71_0._imagefullbottom)

	for iter_71_0, iter_71_1 in pairs(arg_71_0._pictures) do
		if iter_71_1:isFloatType() then
			gohelper.setActive(arg_71_0._imagefullbottom.gameObject, true)

			local var_71_0 = arg_71_0._imagefullbottom.color.a

			ZProj.TweenHelper.DoFade(arg_71_0._imagefullbottom, var_71_0, arg_71_0._initFullBottomAlpha, 0.1, nil, nil, nil, EaseType.Linear)

			return
		end
	end

	local var_71_1 = 0

	for iter_71_2, iter_71_3 in pairs(arg_71_0._picCo) do
		var_71_1 = iter_71_3.orderType == StoryEnum.PictureOrderType.Destroy and iter_71_3.layer > 0 and iter_71_3.picType == StoryEnum.PictureType.Float and var_71_1 < iter_71_3.outTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] and iter_71_3.outTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] or var_71_1
	end

	for iter_71_4, iter_71_5 in pairs(arg_71_0._picCo) do
		if iter_71_5.orderType == StoryEnum.PictureOrderType.Produce and iter_71_5.layer > 0 and iter_71_5.picType == StoryEnum.PictureType.Float then
			var_71_1 = 0
		end
	end

	if var_71_1 < 0.01 then
		gohelper.setActive(arg_71_0._imagefullbottom.gameObject, false)
	else
		gohelper.setActive(arg_71_0._imagefullbottom.gameObject, true)
		ZProj.TweenHelper.DoFade(arg_71_0._imagefullbottom, arg_71_0._initFullBottomAlpha, 0, var_71_1, function()
			gohelper.setActive(arg_71_0._imagefullbottom.gameObject, false)
		end, nil, nil, EaseType.Linear)
	end
end

function var_0_0._buildPicture(arg_73_0, arg_73_1, arg_73_2, arg_73_3)
	local var_73_0

	if arg_73_2.layer < 4 then
		var_73_0 = arg_73_0._goimg1
	elseif arg_73_2.layer < 7 then
		var_73_0 = arg_73_0._goimg2
	elseif arg_73_2.layer < 10 then
		var_73_0 = arg_73_0._goimg3
	else
		if not arg_73_0._goimg4 then
			local var_73_1 = ViewMgr.instance:getContainer(ViewName.StoryFrontView).viewGO

			arg_73_0._goimg4 = gohelper.findChild(var_73_1, "#go_frontitem/#go_img4")
		end

		var_73_0 = arg_73_0._goimg4
	end

	if not arg_73_0._pictures[arg_73_1] then
		arg_73_0._pictures[arg_73_1] = StoryPictureItem.New()

		arg_73_0._pictures[arg_73_1]:init(var_73_0, arg_73_1, arg_73_2)
	elseif not arg_73_3 then
		arg_73_0._pictures[arg_73_1]:reset(var_73_0, arg_73_2)
	end
end

function var_0_0._destroyPicture(arg_74_0, arg_74_1, arg_74_2, arg_74_3)
	if not arg_74_0._pictures[arg_74_1] then
		if arg_74_3 then
			if arg_74_2.orderType == StoryEnum.PictureOrderType.Produce then
				arg_74_0:_buildPicture(arg_74_1, arg_74_2, arg_74_3)
			end

			TaskDispatcher.runDelay(function()
				arg_74_0:_startDestroyPic(arg_74_2, arg_74_3, arg_74_1)
			end, nil, 0.2)
		end

		return
	end

	arg_74_0:_startDestroyPic(arg_74_2, arg_74_3, arg_74_1)
end

function var_0_0._startDestroyPic(arg_76_0, arg_76_1, arg_76_2, arg_76_3)
	if not arg_76_0._pictures[arg_76_3] then
		return
	end

	local var_76_0 = 0
	local var_76_1 = arg_76_0._stepCo.videoList

	for iter_76_0, iter_76_1 in pairs(var_76_1) do
		if iter_76_1.orderType == StoryEnum.VideoOrderType.Produce then
			var_76_0 = 0.5
		end
	end

	arg_76_0._pictures[arg_76_3]:destroyPicture(arg_76_1, arg_76_2, var_76_0)

	arg_76_0._pictures[arg_76_3] = nil
end

function var_0_0._updateNavigateList(arg_77_0, arg_77_1)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshNavigate, arg_77_1)
end

function var_0_0._updateVideoList(arg_78_0, arg_78_1)
	arg_78_0._videoCo = arg_78_1

	local var_78_0 = false

	arg_78_0:_checkCreatePlayList()

	for iter_78_0, iter_78_1 in pairs(arg_78_0._videoCo) do
		if iter_78_1.orderType == StoryEnum.VideoOrderType.Produce then
			arg_78_0:_buildVideo(iter_78_1.video, iter_78_1)
		elseif iter_78_1.orderType == StoryEnum.VideoOrderType.Destroy then
			arg_78_0:_destroyVideo(iter_78_1.video, iter_78_1)
		elseif iter_78_1.orderType == StoryEnum.VideoOrderType.Pause then
			arg_78_0._videos[iter_78_1.video]:pause(true)
		else
			arg_78_0._videos[iter_78_1.video]:pause(false)
		end
	end

	for iter_78_2, iter_78_3 in pairs(arg_78_0._videoCo) do
		if iter_78_3.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 and (iter_78_3.orderType == StoryEnum.VideoOrderType.Produce or iter_78_3.orderType == StoryEnum.VideoOrderType.Pause or iter_78_3.orderType == StoryEnum.VideoOrderType.Restart) then
			var_78_0 = true
		end
	end

	if not var_78_0 then
		StoryController.instance:dispatchEvent(StoryEvent.ShowBackground)
	end
end

function var_0_0._videoStarted(arg_79_0, arg_79_1)
	for iter_79_0, iter_79_1 in pairs(arg_79_0._videos) do
		if iter_79_1 ~= arg_79_1 then
			iter_79_1:pause(true)
		end
	end
end

function var_0_0._buildVideo(arg_80_0, arg_80_1, arg_80_2)
	arg_80_0:_checkCreatePlayList()

	local var_80_0

	if arg_80_2.layer < 4 then
		var_80_0 = arg_80_0._govideo1
	elseif arg_80_2.layer < 7 then
		var_80_0 = arg_80_0._govideo2
	else
		var_80_0 = arg_80_0._govideo3
	end

	if not arg_80_0._videos[arg_80_1] then
		arg_80_0._videos[arg_80_1] = StoryVideoItem.New()

		arg_80_0._videos[arg_80_1]:init(var_80_0, arg_80_1, arg_80_2, arg_80_0._videoStarted, arg_80_0, arg_80_0._videoPlayList)
	else
		arg_80_0._videos[arg_80_1]:reset(var_80_0, arg_80_2)
	end
end

function var_0_0._destroyVideo(arg_81_0, arg_81_1, arg_81_2)
	if not arg_81_0._videos[arg_81_1] then
		return
	end

	arg_81_0._videos[arg_81_1]:destroyVideo(arg_81_2)

	arg_81_0._videos[arg_81_1] = nil
end

function var_0_0._checkCreatePlayList(arg_82_0)
	if not arg_82_0._videoPlayList then
		local var_82_0 = AvProMgr.instance:getStoryUrl()
		local var_82_1 = arg_82_0:getResInst(var_82_0, arg_82_0.viewGO, "play_list")

		arg_82_0._videoPlayList = StoryVideoPlayList.New()

		arg_82_0._videoPlayList:init(var_82_1, arg_82_0.viewGO)
	end
end

function var_0_0._checkDisposePlayList(arg_83_0)
	if arg_83_0._videoPlayList then
		arg_83_0._videoPlayList:dispose()

		arg_83_0._videoPlayList = nil
	end
end

function var_0_0._updateOptionList(arg_84_0, arg_84_1)
	arg_84_0._optCo = arg_84_1
end

function var_0_0._clearItems(arg_85_0, arg_85_1)
	arg_85_0:_clearAllTimers()
	TaskDispatcher.cancelTask(arg_85_0._viewFadeIn, arg_85_0)
	TaskDispatcher.cancelTask(arg_85_0._enterNextStep, arg_85_0)
	TaskDispatcher.cancelTask(arg_85_0._startShowText, arg_85_0)
	TaskDispatcher.cancelTask(arg_85_0._startShake, arg_85_0)
	TaskDispatcher.cancelTask(arg_85_0._shakeStop, arg_85_0)

	for iter_85_0, iter_85_1 in pairs(arg_85_0._pictures) do
		iter_85_1:onDestroy()
	end

	arg_85_0._pictures = {}

	for iter_85_2, iter_85_3 in pairs(arg_85_0._effects) do
		iter_85_3:onDestroy()
	end

	arg_85_0._effects = {}

	for iter_85_4, iter_85_5 in pairs(arg_85_0._videos) do
		iter_85_5:onDestroy()
	end

	arg_85_0._videos = {}

	arg_85_0:_checkDisposePlayList()
end

function var_0_0.onDestroyView(arg_86_0)
	if ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
		ViewMgr.instance:closeView(ViewName.MessageBoxView, true)
	end

	if arg_86_0._confadeId then
		ZProj.TweenHelper.KillById(arg_86_0._confadeId)

		arg_86_0._confadeId = nil
	end

	ZProj.TweenHelper.KillByObj(arg_86_0._imagefullbottom)
	arg_86_0:_checkDisposePlayList()
	TaskDispatcher.cancelTask(arg_86_0._conShowIn, arg_86_0)
	TaskDispatcher.cancelTask(arg_86_0._startShowText, arg_86_0)
	TaskDispatcher.cancelTask(arg_86_0._enterNextStep, arg_86_0)
	TaskDispatcher.cancelTask(arg_86_0._onFullTextKeepFinished, arg_86_0)
	TaskDispatcher.cancelTask(arg_86_0._startShake, arg_86_0)
	TaskDispatcher.cancelTask(arg_86_0._guaranteeEnterNextStep, arg_86_0)
	TaskDispatcher.cancelTask(arg_86_0._shakeStop, arg_86_0)
	StoryTool.enablePostProcess(false)
	ViewMgr.instance:closeView(ViewName.StoryFrontView, nil, true)
	arg_86_0._simagehead:UnLoadImage()
	StoryController.instance:stopPlotMusic()

	arg_86_0._bgAudio = nil

	arg_86_0:stopAllAudio(0)

	if arg_86_0._dialogItem then
		arg_86_0._dialogItem:destroy()

		arg_86_0._dialogItem = nil
	end
end

return var_0_0
