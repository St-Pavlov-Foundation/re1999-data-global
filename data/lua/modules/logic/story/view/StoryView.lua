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

	if not arg_5_0._stepCo or arg_5_0._stepCo.conversation.type == StoryEnum.ConversationType.None or arg_5_0._stepCo.conversation.type == StoryEnum.ConversationType.NoInteract or arg_5_0._stepCo.conversation.type == StoryEnum.ConversationType.ScreenDialog or arg_5_0._stepCo.conversation.type == StoryEnum.ConversationType.IrregularShake then
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

function var_0_0._btnhideOnClick(arg_6_0)
	StoryController.instance:dispatchEvent(StoryEvent.LeadRoleViewShow, false)
	gohelper.setActive(arg_6_0._gocontentroot, false)
end

function var_0_0._btnlogOnClick(arg_7_0)
	StoryController.instance:openStoryLogView()
end

function var_0_0._btnautoOnClick(arg_8_0)
	if arg_8_0._stepCo.conversation.type ~= StoryEnum.ConversationType.None and arg_8_0._stepCo.conversation.type ~= StoryEnum.ConversationType.NoInteract and arg_8_0._stepCo.conversation.type ~= StoryEnum.ConversationType.ScreenDialog and arg_8_0._stepCo.conversation.type ~= StoryEnum.ConversationType.IrregularShake then
		arg_8_0._dialogItem:startAutoEnterNext()
	end
end

function var_0_0._btnskipOnClick(arg_9_0, arg_9_1)
	if not arg_9_1 and not StoryModel.instance:isNormalStep() then
		return
	end

	StoryTool.enablePostProcess(true)

	if arg_9_0._curStoryId == SDKMediaEventEnum.FirstStoryId then
		local var_9_0 = string.format(PlayerPrefsKey.SDKDataTrackMgr_MediaEvent_first_story_skip, PlayerModel.instance:getMyUserId())

		if PlayerPrefsHelper.getNumber(var_9_0, 0) == 0 then
			SDKDataTrackMgr.instance:trackMediaEvent(SDKDataTrackMgr.MediaEvent.first_story_skip)
			PlayerPrefsHelper.setNumber(var_9_0, 1)
		end
	end

	arg_9_0:_skipStep(arg_9_1)
end

function var_0_0._editableInitView(arg_10_0)
	arg_10_0:_initData()
	arg_10_0:_initView()
end

function var_0_0.addEvent(arg_11_0)
	arg_11_0:addEventCb(StoryController.instance, StoryEvent.RefreshStep, arg_11_0._onUpdateUI, arg_11_0)
	arg_11_0:addEventCb(StoryController.instance, StoryEvent.AllStepFinished, arg_11_0._storyFinished, arg_11_0)
	arg_11_0:addEventCb(StoryController.instance, StoryEvent.RefreshView, arg_11_0._refreshView, arg_11_0)
	arg_11_0:addEventCb(StoryController.instance, StoryEvent.RefreshConversation, arg_11_0._updateConversation, arg_11_0)
	arg_11_0:addEventCb(StoryController.instance, StoryEvent.Log, arg_11_0._btnlogOnClick, arg_11_0)
	arg_11_0:addEventCb(StoryController.instance, StoryEvent.Hide, arg_11_0._btnhideOnClick, arg_11_0)
	arg_11_0:addEventCb(StoryController.instance, StoryEvent.Auto, arg_11_0._btnautoOnClick, arg_11_0)
	arg_11_0:addEventCb(StoryController.instance, StoryEvent.Skip, arg_11_0._btnskipOnClick, arg_11_0)
	arg_11_0:addEventCb(StoryController.instance, StoryEvent.EnterNextStep, arg_11_0._btnnextOnClick, arg_11_0)
	arg_11_0:addEventCb(StoryController.instance, StoryEvent.Finish, arg_11_0._clearItems, arg_11_0)
	arg_11_0:addEventCb(StoryController.instance, StoryEvent.FullTextLineShowFinished, arg_11_0._onFullTextShowFinished, arg_11_0)
	arg_11_0:addEventCb(StoryController.instance, StoryEvent.HideDialog, arg_11_0._hideDialog, arg_11_0)
	arg_11_0:addEventCb(StoryController.instance, StoryEvent.DialogConFinished, arg_11_0._dialogConFinished, arg_11_0)
end

function var_0_0.removeEvent(arg_12_0)
	arg_12_0:removeEventCb(StoryController.instance, StoryEvent.RefreshStep, arg_12_0._onUpdateUI, arg_12_0)
	arg_12_0:removeEventCb(StoryController.instance, StoryEvent.AllStepFinished, arg_12_0._storyFinished, arg_12_0)
	arg_12_0:removeEventCb(StoryController.instance, StoryEvent.RefreshView, arg_12_0._refreshView, arg_12_0)
	arg_12_0:removeEventCb(StoryController.instance, StoryEvent.RefreshConversation, arg_12_0._updateConversation, arg_12_0)
	arg_12_0:removeEventCb(StoryController.instance, StoryEvent.Log, arg_12_0._btnlogOnClick, arg_12_0)
	arg_12_0:removeEventCb(StoryController.instance, StoryEvent.Hide, arg_12_0._btnhideOnClick, arg_12_0)
	arg_12_0:removeEventCb(StoryController.instance, StoryEvent.Auto, arg_12_0._btnautoOnClick, arg_12_0)
	arg_12_0:removeEventCb(StoryController.instance, StoryEvent.Skip, arg_12_0._btnskipOnClick, arg_12_0)
	arg_12_0:removeEventCb(StoryController.instance, StoryEvent.EnterNextStep, arg_12_0._btnnextOnClick, arg_12_0)
	arg_12_0:removeEventCb(StoryController.instance, StoryEvent.Finish, arg_12_0._clearItems, arg_12_0)
	arg_12_0:removeEventCb(StoryController.instance, StoryEvent.FullTextLineShowFinished, arg_12_0._onFullTextShowFinished, arg_12_0)
	arg_12_0:removeEventCb(StoryController.instance, StoryEvent.HideDialog, arg_12_0._hideDialog, arg_12_0)
	arg_12_0:removeEventCb(StoryController.instance, StoryEvent.DialogConFinished, arg_12_0._dialogConFinished, arg_12_0)
end

function var_0_0._initData(arg_13_0)
	arg_13_0._stepId = 0
	arg_13_0._audios = {}
	arg_13_0._pictures = {}
	arg_13_0._effects = {}
	arg_13_0._videos = {}
	arg_13_0._initFullBottomAlpha = arg_13_0._imagefullbottom.color.a

	StoryModel.instance:resetStoryState()
end

function var_0_0._initView(arg_14_0)
	arg_14_0._conCanvasGroup = arg_14_0._gocontentroot:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_14_0._contentAnimator = arg_14_0._goconversation:GetComponent(typeof(UnityEngine.Animator))

	local var_14_0 = ViewMgr.instance:getContainer(ViewName.StoryBackgroundView).viewGO

	arg_14_0._gobottom = gohelper.findChild(var_14_0, "#go_bottomitem")
	arg_14_0._goimg1 = gohelper.findChild(var_14_0, "#go_bottomitem/#go_img1")
	arg_14_0._govideo1 = gohelper.findChild(var_14_0, "#go_bottomitem/#go_video1")
	arg_14_0._goeff1 = gohelper.findChild(var_14_0, "#go_bottomitem/#go_eff1")

	gohelper.setActive(arg_14_0._gocontentroot, false)
	arg_14_0:_initItems()
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0:addEvent()
	ViewMgr.instance:openView(ViewName.StoryFrontView, nil, true)
	gohelper.setActive(arg_15_0.viewGO, true)
	SpineFpsMgr.instance:set(SpineFpsMgr.Story)

	if UnityEngine.Shader.IsKeywordEnabled("_MAININTERFACELIGHT") then
		arg_15_0._keywordEnable = true

		UnityEngine.Shader.DisableKeyword("_MAININTERFACELIGHT")
	end

	arg_15_0:_clearItems()
end

function var_0_0._initItems(arg_16_0)
	if not arg_16_0._dialogItem then
		arg_16_0._dialogItem = StoryDialogItem.New()

		arg_16_0._dialogItem:init(arg_16_0._gocontentroot)
		arg_16_0._dialogItem:hideDialog()
	end
end

function var_0_0._hideDialog(arg_17_0)
	if arg_17_0._dialogItem then
		if StoryModel.instance:isTextShowing() then
			arg_17_0._dialogItem:conFinished()
			arg_17_0:_conFinished()
		end

		gohelper.setActive(arg_17_0._gocontentroot, false)
	end
end

function var_0_0._dialogConFinished(arg_18_0)
	if arg_18_0._dialogItem and StoryModel.instance:isTextShowing() then
		arg_18_0._dialogItem:conFinished()
		arg_18_0:_conFinished()
	end
end

function var_0_0._storyFinished(arg_19_0, arg_19_1)
	arg_19_0:_clearAllTimers()

	arg_19_0._stepId = 0
	arg_19_0._finished = true
	arg_19_0._stepCo = nil

	TaskDispatcher.cancelTask(arg_19_0._onCheckNext, arg_19_0)
	arg_19_0._dialogItem:storyFinished()
	StoryModel.instance:enableClick(false)

	if arg_19_0._dialogItem then
		arg_19_0._dialogItem:stopConAudio()
	end

	if StoryController.instance._hideStartAndEndDark then
		arg_19_0:stopAllAudio(1.5)
		gohelper.setActive(arg_19_0._gospine, false)

		if arg_19_0._confadeId then
			ZProj.TweenHelper.KillById(arg_19_0._confadeId)
		end

		arg_19_0._confadeId = ZProj.TweenHelper.DOFadeCanvasGroup(arg_19_0._gocontentroot, 1, 0, 0.35, nil, nil, nil, EaseType.Linear)

		return
	end

	if StoryModel.instance:isTypeSkip(StoryEnum.SkipType.OutDarkFade, StoryController.instance._curStoryId) then
		return
	end

	arg_19_0:stopAllAudio(1.5)
end

function var_0_0.onClose(arg_20_0)
	arg_20_0:_clearAllTimers()

	if not arg_20_0._finished then
		arg_20_0:stopAllAudio(0)
	end

	if arg_20_0._keywordEnable then
		UnityEngine.Shader.EnableKeyword("_MAININTERFACELIGHT")
	end

	arg_20_0:removeEvent()
	TaskDispatcher.cancelTask(arg_20_0._viewFadeIn, arg_20_0)
	arg_20_0:_clearItems()
	SpineFpsMgr.instance:remove(SpineFpsMgr.Story)
end

function var_0_0.onUpdateParam(arg_21_0)
	return
end

function var_0_0._enterNextStep(arg_22_0)
	StoryController.instance:dispatchEvent(StoryEvent.PlayFullTextOut)

	if arg_22_0._diaLineTxt and arg_22_0._diaLineTxt[2] then
		local var_22_0, var_22_1, var_22_2 = transformhelper.getLocalPos(arg_22_0._diaLineTxt[2].transform)

		transformhelper.setLocalPos(arg_22_0._diaLineTxt[2].transform, var_22_0, var_22_1, 1)
	end

	TaskDispatcher.cancelTask(arg_22_0._enterNextStep, arg_22_0)
	TaskDispatcher.cancelTask(arg_22_0._guaranteeEnterNextStep, arg_22_0)
	StoryController.instance:enterNext()
end

function var_0_0._guaranteeEnterNextStep(arg_23_0)
	arg_23_0:_enterNextStep()
end

function var_0_0._skipStep(arg_24_0, arg_24_1)
	StoryModel.instance:enableClick(false)
	TaskDispatcher.cancelTask(arg_24_0._enterNextStep, arg_24_0)
	TaskDispatcher.cancelTask(arg_24_0._playShowHero, arg_24_0)

	if arg_24_1 then
		StoryController.instance:skipAllStory()
	else
		StoryController.instance:skipStory()
	end
end

function var_0_0._onCheckNext(arg_25_0)
	arg_25_0:_onConFinished(arg_25_0._stepCo.conversation.isAuto)
end

function var_0_0._onUpdateUI(arg_26_0, arg_26_1)
	arg_26_0._finished = false

	StoryModel.instance:setStepNormal(arg_26_1.stepType == StoryEnum.StepType.Normal)

	if arg_26_0._gocontentroot.activeSelf ~= StoryModel.instance:isNormalStep() then
		gohelper.setActive(arg_26_0._gocontentroot, not StoryModel.instance:isNormalStep())
		StoryController.instance:dispatchEvent(StoryEvent.LeadRoleViewShow, not StoryModel.instance:isNormalStep())
	end

	if arg_26_0._curStoryId ~= arg_26_1.storyId and #arg_26_1.branches < 1 then
		arg_26_0:_clearItems()

		arg_26_0._curStoryId = arg_26_1.storyId
	end

	arg_26_0:_updateStep(arg_26_1.stepId)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshHero, arg_26_1)

	if #arg_26_1.branches > 0 then
		StoryController.instance:openStoryBranchView(arg_26_1.branches)
		arg_26_0:_showBranchLeadHero()
	else
		gohelper.setActive(arg_26_0._gonoconversation, false)
	end

	StoryModel.instance:clearStepLine()
end

function var_0_0._showBranchLeadHero(arg_27_0)
	arg_27_0._dialogItem:hideDialog()
	arg_27_0._dialogItem:stopConAudio()

	if arg_27_0._confadeId then
		ZProj.TweenHelper.KillById(arg_27_0._confadeId)
	end

	TaskDispatcher.cancelTask(arg_27_0._conShowIn, arg_27_0)
	TaskDispatcher.cancelTask(arg_27_0._startShowText, arg_27_0)
	TaskDispatcher.cancelTask(arg_27_0._startShake, arg_27_0)
	TaskDispatcher.cancelTask(arg_27_0._shakeStop, arg_27_0)
	TaskDispatcher.cancelTask(arg_27_0._enterNextStep, arg_27_0)

	arg_27_0._conCanvasGroup.alpha = 1

	gohelper.setActive(arg_27_0._goname, true)
	gohelper.setActive(arg_27_0._txtnameen.gameObject, true)
	gohelper.setActive(arg_27_0._gocontentroot, true)
	gohelper.setActive(arg_27_0._gonoconversation, true)

	local var_27_0

	for iter_27_0, iter_27_1 in pairs(arg_27_0._stepCo.optList) do
		if iter_27_1.condition and iter_27_1.conditionType == StoryEnum.OptionConditionType.NormalLead then
			arg_27_0:_showNormalLeadHero(iter_27_1)

			return
		elseif iter_27_1.condition and iter_27_1.conditionType == StoryEnum.OptionConditionType.MainSpine then
			arg_27_0:_showSpineLeadHero(iter_27_1)

			return
		end
	end

	arg_27_0:_showSpineLeadHero()
end

function var_0_0._showNormalLeadHero(arg_28_0, arg_28_1)
	gohelper.setActive(arg_28_0._gohead, true)
	gohelper.setActive(arg_28_0._gospine, false)

	local var_28_0 = arg_28_1.conditionValue2[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]
	local var_28_1 = arg_28_1.conditionValue2[LanguageEnum.LanguageStoryType.EN]

	arg_28_0:_showHeadContentTxt(var_28_0, var_28_1)
	arg_28_0:_showHeadContentIcon(arg_28_1.conditionValue)
end

function var_0_0._showSpineLeadHero(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_1 and string.split(arg_29_1.conditionValue, ".")[1] or nil

	StoryController.instance:dispatchEvent(StoryEvent.LeadRoleViewShow, true, var_29_0)
	gohelper.setActive(arg_29_0._gohead, false)
	gohelper.setActive(arg_29_0._gospine, true)

	arg_29_0._txtnamecn1.text = luaLang("mainrolename")
	arg_29_0._txtnamecn2.text = luaLang("mainrolename")
	arg_29_0._txtnameen.text = "<voffset=4>/ </voffset>Vertin"

	if arg_29_1 then
		return
	end

	local var_29_1 = 1

	if arg_29_0._stepCo and arg_29_0._stepCo.optList[1] and arg_29_0._stepCo.optList[1].feedbackType == StoryEnum.OptionFeedbackType.HeroLead then
		var_29_1 = arg_29_0._stepCo.optList[1].feedbackValue ~= "" and tonumber(arg_29_0._stepCo.optList[1].feedbackValue) or 1
	end

	StoryController.instance:dispatchEvent(StoryEvent.ShowLeadRole, arg_29_0._stepCo, true, false, false, var_29_1)
	gohelper.setActive(arg_29_0._txtnamecn1.gameObject, true)
	gohelper.setActive(arg_29_0._txtnamecn2.gameObject, false)

	if GameLanguageMgr.instance:getLanguageTypeStoryIndex() ~= LanguageEnum.LanguageStoryType.EN then
		arg_29_0._txtnameen.text = "<voffset=4>/ </voffset>Vertin"

		gohelper.setActive(arg_29_0._txtnameen.gameObject, true)
	else
		arg_29_0._txtnameen.text = ""

		gohelper.setActive(arg_29_0._txtnameen.gameObject, false)
	end
end

function var_0_0._updateStep(arg_30_0, arg_30_1)
	if not StoryModel.instance:isNormalStep() then
		return
	end

	arg_30_0._stepCo = StoryStepModel.instance:getStepListById(arg_30_1)

	if arg_30_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.SoftLight then
		gohelper.setActive(arg_30_0._goline, false)
		gohelper.setActive(arg_30_0._gonexticon, false)
		gohelper.setActive(arg_30_0._goblackbottom, false)
	else
		gohelper.setActive(arg_30_0._goline, true)
		gohelper.setActive(arg_30_0._gonexticon, true)
		gohelper.setActive(arg_30_0._goblackbottom, true)
	end

	if arg_30_0._stepCo.bg.transType ~= StoryEnum.BgTransType.DarkFade and arg_30_0._stepCo.bg.transType ~= StoryEnum.BgTransType.WhiteFade then
		arg_30_0:_refreshView()
	else
		arg_30_0:_updateEffectList(arg_30_0._stepCo.effList)
		arg_30_0:_updateAudioList(arg_30_0._stepCo.audioList)
	end
end

function var_0_0._refreshView(arg_31_0)
	arg_31_0:_updateEffectList(arg_31_0._stepCo.effList)
	arg_31_0:_updateAudioList(arg_31_0._stepCo.audioList)
	arg_31_0:_updatePictureList(arg_31_0._stepCo.picList)
	arg_31_0:_updateVideoList(arg_31_0._stepCo.videoList)
	arg_31_0:_updateNavigateList(arg_31_0._stepCo.navigateList)
	arg_31_0:_updateOptionList(arg_31_0._stepCo.optList)
end

function var_0_0._updateConversation(arg_32_0)
	if not arg_32_0._stepCo then
		return
	end

	if not arg_32_0._stepId then
		arg_32_0._stepId = 0

		return
	end

	if arg_32_0._storyId and arg_32_0._storyId == arg_32_0._curStoryId and arg_32_0._stepId == arg_32_0._stepCo.id then
		arg_32_0._stepId = 0

		return
	end

	StoryModel.instance:enableClick(false)

	arg_32_0._stepId = arg_32_0._stepCo.id
	arg_32_0._storyId = arg_32_0._curStoryId

	if arg_32_0._confadeId then
		ZProj.TweenHelper.KillById(arg_32_0._confadeId)
	end

	TaskDispatcher.cancelTask(arg_32_0._conShowIn, arg_32_0)
	TaskDispatcher.cancelTask(arg_32_0._onEnableClick, arg_32_0)
	TaskDispatcher.cancelTask(arg_32_0._enterNextStep, arg_32_0)
	TaskDispatcher.cancelTask(arg_32_0._onFullTextFinished, arg_32_0)
	TaskDispatcher.cancelTask(arg_32_0._startShowText, arg_32_0)
	TaskDispatcher.cancelTask(arg_32_0._onCheckNext, arg_32_0)

	if arg_32_0._stepCo.conversation.type ~= StoryEnum.ConversationType.None then
		StoryModel.instance:setTextShowing(true)
	end

	if StoryModel.instance:isNeedFadeOut() then
		if arg_32_0._gospine.activeSelf then
			StoryController.instance:dispatchEvent(StoryEvent.ShowLeadRole, arg_32_0._stepCo, true, false, true)
		end

		arg_32_0._confadeId = ZProj.TweenHelper.DOFadeCanvasGroup(arg_32_0._gocontentroot, 1, 0, 0.35, nil, nil, nil, EaseType.Linear)

		if not StoryModel.instance:isPlayFinished() then
			TaskDispatcher.runDelay(arg_32_0._conShowIn, arg_32_0, 0.35)
		end
	else
		arg_32_0:_conShowIn()
	end
end

function var_0_0._conShowIn(arg_33_0)
	if not arg_33_0._stepCo then
		return
	end

	arg_33_0._diatxt = StoryTool.getFilterDia(arg_33_0._stepCo.conversation.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()])

	arg_33_0._dialogItem:hideDialog()
	TaskDispatcher.cancelTask(arg_33_0._enterNextStep, arg_33_0)
	TaskDispatcher.cancelTask(arg_33_0._guaranteeEnterNextStep, arg_33_0)
	TaskDispatcher.cancelTask(arg_33_0._onFullTextFinished, arg_33_0)
	TaskDispatcher.cancelTask(arg_33_0._startShowText, arg_33_0)

	if arg_33_0._stepCo.conversation.type == StoryEnum.ConversationType.None then
		arg_33_0:_showConversationItem(false)
		TaskDispatcher.runDelay(arg_33_0._guaranteeEnterNextStep, arg_33_0, arg_33_0._stepCo.conversation.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] + 0.2)
		TaskDispatcher.runDelay(arg_33_0._enterNextStep, arg_33_0, arg_33_0._stepCo.conversation.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	else
		StoryController.instance:dispatchEvent(StoryEvent.SetFullText, "")

		if arg_33_0._stepCo.conversation.type == StoryEnum.ConversationType.NoInteract then
			StoryModel.instance:enableClick(false)
			TaskDispatcher.runDelay(arg_33_0._guaranteeEnterNextStep, arg_33_0, arg_33_0._stepCo.conversation.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] + 0.2)
			TaskDispatcher.runDelay(arg_33_0._enterNextStep, arg_33_0, arg_33_0._stepCo.conversation.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
		end

		arg_33_0:_showConversationItem(true)
	end

	if StoryModel.instance:isNeedFadeIn() then
		if arg_33_0._gospine.activeSelf then
			StoryController.instance:dispatchEvent(StoryEvent.ShowLeadRole, arg_33_0._stepCo, true, true, false)
		end

		arg_33_0._confadeId = ZProj.TweenHelper.DOFadeCanvasGroup(arg_33_0._gocontentroot, 0, 1, 0.5, nil, nil, nil, EaseType.Linear)

		TaskDispatcher.runDelay(arg_33_0._startShowText, arg_33_0, 0.5)
	else
		arg_33_0:_startShowText()
	end
end

function var_0_0._startShowText(arg_34_0)
	if not arg_34_0._stepCo then
		return
	end

	arg_34_0._conCanvasGroup.alpha = 1

	if arg_34_0._stepCo.conversation.effType ~= StoryEnum.ConversationEffectType.Shake then
		StoryController.instance:dispatchEvent(StoryEvent.ConversationShake, arg_34_0._stepCo, 0, true)
		TaskDispatcher.cancelTask(arg_34_0._startShake, arg_34_0)
		TaskDispatcher.cancelTask(arg_34_0._shakeStop, arg_34_0)
		arg_34_0._contentAnimator:Play(UIAnimationName.Idle)
	end

	arg_34_0:_showText()
end

function var_0_0._showConversationItem(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0._stepCo.conversation.type ~= StoryEnum.ConversationType.ScreenDialog and arg_35_0._stepCo.conversation.type ~= StoryEnum.ConversationType.IrregularShake
	local var_35_1 = arg_35_0._stepCo.conversation.type == StoryEnum.ConversationType.SlideDialog

	if not arg_35_1 then
		gohelper.setActive(arg_35_0._gocontentroot, false)
		arg_35_0._simagehead:UnLoadImage()
		StoryController.instance:dispatchEvent(StoryEvent.LeadRoleViewShow, false)

		return
	end

	StoryController.instance:dispatchEvent(StoryEvent.SetFullText, arg_35_0._diatxt)
	gohelper.setActive(arg_35_0._gobtns, var_35_0)
	gohelper.setActive(arg_35_0._gocontentroot, var_35_0)
	gohelper.setActive(arg_35_0._goconversation, not var_35_1)
	StoryController.instance:dispatchEvent(StoryEvent.LeadRoleViewShow, var_35_0)

	local var_35_2 = arg_35_0._stepCo.conversation.heroNames[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]
	local var_35_3 = arg_35_0._stepCo.conversation.heroNames[LanguageEnum.LanguageStoryType.EN]

	arg_35_0:_showHeadContentTxt(var_35_2, var_35_3)
	gohelper.setActive(arg_35_0._goname, arg_35_0._stepCo.conversation.nameShow)

	local var_35_4 = tonumber(arg_35_0._stepCo.conversation.heroNames[LanguageEnum.LanguageStoryType.CN])
	local var_35_5 = arg_35_0._stepCo.conversation.nameEnShow

	if var_35_4 and GameLanguageMgr.instance:getLanguageTypeStoryIndex() == LanguageEnum.LanguageStoryType.EN then
		var_35_5 = false
	end

	gohelper.setActive(arg_35_0._txtnameen.gameObject, var_35_5)

	if not arg_35_0._stepCo.conversation.iconShow then
		gohelper.setActive(arg_35_0._gohead, false)
		gohelper.setActive(arg_35_0._gospine, false)
		gohelper.setActive(arg_35_0._gonamebg, false)
		arg_35_0._simagehead:UnLoadImage()
		StoryController.instance:dispatchEvent(StoryEvent.ShowLeadRole, arg_35_0._stepCo, false, false, false)

		return
	end

	arg_35_0:_showHeadContentIcon(arg_35_0._stepCo.conversation.heroIcon)
end

function var_0_0._showHeadContentTxt(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = string.match(arg_36_1, "[^?]") == nil

	gohelper.setActive(arg_36_0._txtnamecn1.gameObject, not var_36_0)
	gohelper.setActive(arg_36_0._txtnamecn2.gameObject, var_36_0)

	if var_36_0 then
		arg_36_0._txtnamecn2.text = string.split(arg_36_1, "_")[1]
	else
		arg_36_0._txtnamecn1.text = string.split(arg_36_1, "_")[1]
	end

	local var_36_1 = tonumber(arg_36_0._stepCo.conversation.heroNames[LanguageEnum.LanguageStoryType.CN])

	if (var_36_1 and StoryTool.FilterStrByPatterns(arg_36_1, {
		"%a",
		"%s",
		"%p"
	}) or StoryTool.FilterStrByPatterns(arg_36_1, {
		"%w",
		"%s",
		"%p"
	})) ~= "" and GameLanguageMgr.instance:getLanguageTypeStoryIndex() ~= LanguageEnum.LanguageStoryType.EN then
		if LangSettings.instance:isJp() and arg_36_2 == "Aleph" then
			arg_36_2 = ""
		end

		arg_36_0._txtnameen.text = arg_36_2 ~= "" and "<voffset=4>/ </voffset>" .. arg_36_2 or ""

		gohelper.setActive(arg_36_0._txtnameen.gameObject, true)
	else
		arg_36_0._txtnameen.text = ""

		if var_36_1 and GameLanguageMgr.instance:getLanguageTypeStoryIndex() == LanguageEnum.LanguageStoryType.EN then
			arg_36_0._txtnamecn1.text = arg_36_0._stepCo.conversation.heroNames[LanguageEnum.LanguageStoryType.CN]
		end

		gohelper.setActive(arg_36_0._txtnameen.gameObject, false)
	end
end

function var_0_0._showHeadContentIcon(arg_37_0, arg_37_1)
	if arg_37_0._goeffectIcon then
		gohelper.destroy(arg_37_0._goeffectIcon)

		arg_37_0._goeffectIcon = nil
	end

	if arg_37_0:_isHeroLead() then
		gohelper.setActive(arg_37_0._gohead, false)
		gohelper.setActive(arg_37_0._gospine, true)
		gohelper.setActive(arg_37_0._gonamebg, true)
		arg_37_0._simagehead:UnLoadImage()
		StoryController.instance:dispatchEvent(StoryEvent.ShowLeadRole, arg_37_0._stepCo, true, false, false)
	else
		gohelper.setActive(arg_37_0._gospine, false)
		gohelper.setActive(arg_37_0._gonamebg, false)
		gohelper.setActive(arg_37_0._gohead, true)

		local var_37_0 = StoryModel.instance:isHeroIconCuts(string.split(arg_37_1, ".")[1])

		gohelper.setActive(arg_37_0._goheadblack, not var_37_0)
		gohelper.setActive(arg_37_0._goheadgrey, false)
		StoryController.instance:dispatchEvent(StoryEvent.ShowLeadRole, arg_37_0._stepCo, false, false, false)

		local var_37_1 = arg_37_0:_getEffectHeadIconCo()

		if var_37_1 then
			arg_37_0._headEffectResPath = ResUrl.getStoryPrefabRes(var_37_1.path)

			local var_37_2 = {}

			table.insert(var_37_2, arg_37_0._headEffectResPath)
			arg_37_0:loadRes(var_37_2, arg_37_0._headEffectResLoaded, arg_37_0)
			gohelper.setActive(arg_37_0._goheadgrey, true)
		else
			local var_37_3 = string.format("singlebg/headicon_small/%s", arg_37_1)

			if arg_37_0._simagehead.curImageUrl == var_37_3 then
				gohelper.setActive(arg_37_0._goheadgrey, true)
			else
				arg_37_0._simagehead:LoadImage(var_37_3, function()
					gohelper.setActive(arg_37_0._goheadgrey, true)
				end)
			end
		end
	end
end

function var_0_0._headEffectResLoaded(arg_39_0)
	if arg_39_0._headEffectResPath then
		local var_39_0 = arg_39_0._loader:getAssetItem(arg_39_0._headEffectResPath)

		arg_39_0._goeffectIcon = gohelper.clone(var_39_0:GetResource(), arg_39_0._gohead)
	end
end

function var_0_0.loadRes(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	if arg_40_0._loader then
		arg_40_0._loader:dispose()

		arg_40_0._loader = nil
	end

	if arg_40_1 and #arg_40_1 > 0 then
		arg_40_0._loader = MultiAbLoader.New()

		arg_40_0._loader:setPathList(arg_40_1)
		arg_40_0._loader:startLoad(arg_40_2, arg_40_3)
	elseif arg_40_2 then
		arg_40_2(arg_40_3)
	end
end

function var_0_0._getEffectHeadIconCo(arg_41_0)
	local var_41_0 = string.split(arg_41_0._stepCo.conversation.heroIcon, ".")[1]
	local var_41_1 = StoryConfig.instance:getStoryLeadHeroSpine()

	for iter_41_0, iter_41_1 in ipairs(var_41_1) do
		if iter_41_1.resType == StoryEnum.IconResType.IconEff and iter_41_1.icon == var_41_0 then
			return iter_41_1
		end
	end

	return nil
end

function var_0_0._isHeroLead(arg_42_0)
	local var_42_0 = string.split(arg_42_0._stepCo.conversation.heroIcon, ".")[1]
	local var_42_1 = StoryConfig.instance:getStoryLeadHeroSpine()

	for iter_42_0, iter_42_1 in ipairs(var_42_1) do
		if iter_42_1.resType == StoryEnum.IconResType.Spine and iter_42_1.icon == var_42_0 then
			return true
		end
	end

	return false
end

function var_0_0._showText(arg_43_0)
	if arg_43_0._stepCo.conversation.type == StoryEnum.ConversationType.None then
		arg_43_0._dialogItem:stopConAudio()

		return
	end

	StoryModel.instance:setTextShowing(true)

	if arg_43_0._stepCo.conversation.type == StoryEnum.ConversationType.ScreenDialog then
		StoryModel.instance:enableClick(false)
		arg_43_0:_playDialog()
		StoryController.instance:dispatchEvent(StoryEvent.PlayFullText, arg_43_0._stepCo)
	elseif arg_43_0._stepCo.conversation.type == StoryEnum.ConversationType.IrregularShake then
		StoryModel.instance:enableClick(false)
		arg_43_0:_playDialog()
		StoryController.instance:dispatchEvent(StoryEvent.PlayIrregularShakeText, arg_43_0._stepCo)
	else
		StoryModel.instance:enableClick(true)
		arg_43_0:_playDialog()
	end

	if arg_43_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Shake then
		arg_43_0:_shakeDialog()
	elseif arg_43_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Fade then
		arg_43_0:_fadeIn()
	elseif arg_43_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.WordByWord then
		-- block empty
	elseif arg_43_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.LineByLine then
		arg_43_0:_lineShow(1)
	elseif arg_43_0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.TwoLineShow then
		arg_43_0:_lineShow(2)
	end
end

function var_0_0._playDialog(arg_44_0)
	arg_44_0._finishTime = nil

	arg_44_0._dialogItem:hideDialog()

	local var_44_0 = arg_44_0._stepCo.conversation.audios[1] or 0
	local var_44_1 = StoryModel.instance:getStoryTxtByVoiceType(arg_44_0._diatxt, var_44_0)

	arg_44_0._dialogItem:playDialog(var_44_1, arg_44_0._stepCo, arg_44_0._conFinished, arg_44_0)
end

function var_0_0._conFinished(arg_45_0)
	StoryModel.instance:setTextShowing(false)

	if arg_45_0._conTweenId then
		ZProj.TweenHelper.KillById(arg_45_0._conTweenId)

		arg_45_0._conTweenId = nil
	end

	local var_45_0 = false
	local var_45_1 = arg_45_0._stepCo and arg_45_0._stepCo.conversation.keepTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] or 1.5

	if StoryModel.instance:isStoryAuto() then
		if not arg_45_0._finishTime then
			arg_45_0._finishTime = ServerTime.now()
		end

		var_45_0 = var_45_1 < ServerTime.now() - arg_45_0._finishTime
	end

	arg_45_0._finishTime = ServerTime.now()

	if var_45_0 then
		arg_45_0:_onCheckNext()
	else
		TaskDispatcher.runDelay(arg_45_0._onCheckNext, arg_45_0, var_45_1)
	end
end

function var_0_0._shakeDialog(arg_46_0)
	TaskDispatcher.cancelTask(arg_46_0._startShake, arg_46_0)
	TaskDispatcher.cancelTask(arg_46_0._shakeStop, arg_46_0)

	if arg_46_0._stepCo.conversation.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		return
	end

	if arg_46_0._stepCo.conversation.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		arg_46_0:_startShake()
	else
		TaskDispatcher.runDelay(arg_46_0._startShake, arg_46_0, arg_46_0._stepCo.conversation.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	end
end

function var_0_0._startShake(arg_47_0)
	TaskDispatcher.cancelTask(arg_47_0._shakeStop, arg_47_0)

	local var_47_0 = {
		"low",
		"middle",
		"high"
	}

	arg_47_0._contentAnimator:Play(var_47_0[arg_47_0._stepCo.conversation.effLv + 1])

	arg_47_0._contentAnimator.speed = arg_47_0._stepCo.conversation.effRate

	TaskDispatcher.runDelay(arg_47_0._shakeStop, arg_47_0, arg_47_0._stepCo.conversation.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	StoryController.instance:dispatchEvent(StoryEvent.ConversationShake, arg_47_0._stepCo, true, arg_47_0._stepCo.conversation.effLv + 1)
end

function var_0_0._shakeStop(arg_48_0)
	if not arg_48_0._stepCo then
		return
	end

	StoryController.instance:dispatchEvent(StoryEvent.ConversationShake, arg_48_0._stepCo, false, arg_48_0._stepCo.conversation.effLv + 1)

	arg_48_0._contentAnimator.speed = arg_48_0._stepCo.conversation.effRate

	arg_48_0._contentAnimator:SetBool("stoploop", true)
end

function var_0_0._fadeIn(arg_49_0)
	StoryModel.instance:setTextShowing(true)
	arg_49_0._dialogItem:playNorDialogFadeIn(arg_49_0._fadeInFinished, arg_49_0)
end

function var_0_0._fadeInFinished(arg_50_0)
	if not arg_50_0._stepCo then
		return
	end

	StoryModel.instance:setTextShowing(false)
	TaskDispatcher.cancelTask(arg_50_0._onCheckNext, arg_50_0)

	if not arg_50_0._stepCo then
		return
	end

	TaskDispatcher.runDelay(arg_50_0._onCheckNext, arg_50_0, arg_50_0._stepCo.conversation.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function var_0_0._wordByWord(arg_51_0)
	StoryModel.instance:setTextShowing(true)
	arg_51_0._dialogItem:playWordByWord(arg_51_0._wordByWordFinished, arg_51_0)
end

function var_0_0._wordByWordFinished(arg_52_0)
	StoryModel.instance:setTextShowing(false)
	TaskDispatcher.cancelTask(arg_52_0._onCheckNext, arg_52_0)

	if not arg_52_0._stepCo then
		return
	end

	TaskDispatcher.runDelay(arg_52_0._onCheckNext, arg_52_0, 1)
end

function var_0_0._lineShow(arg_53_0, arg_53_1)
	if not arg_53_0._stepCo then
		return
	end

	StoryModel.instance:enableClick(false)
	StoryModel.instance:setTextShowing(true)
	StoryController.instance:dispatchEvent(StoryEvent.PlayFullTextLineShow, arg_53_1, arg_53_0._stepCo)
end

function var_0_0._onFullTextShowFinished(arg_54_0)
	if not arg_54_0._stepCo then
		return
	end

	StoryModel.instance:setTextShowing(false)
	TaskDispatcher.cancelTask(arg_54_0._onFullTextFinished, arg_54_0)
	TaskDispatcher.runDelay(arg_54_0._onFullTextFinished, arg_54_0, arg_54_0._stepCo.conversation.keepTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function var_0_0._onFullTextFinished(arg_55_0)
	StoryModel.instance:enableClick(true)
	TaskDispatcher.cancelTask(arg_55_0._onFullTextFinished, arg_55_0)
	StoryController.instance:dispatchEvent(StoryEvent.PlayFullTextOut)
	arg_55_0:_onConFinished(true)
end

function var_0_0._onConFinished(arg_56_0, arg_56_1)
	if arg_56_1 then
		arg_56_0:_onAutoDialogFinished()

		return
	end

	if StoryModel.instance:isStoryAuto() then
		if arg_56_0._stepCo.conversation.type == StoryEnum.ConversationType.None or arg_56_0._stepCo.conversation.type == StoryEnum.ConversationType.NoInteract or arg_56_0._stepCo.conversation.type == StoryEnum.ConversationType.ScreenDialog or arg_56_0._stepCo.conversation.type == StoryEnum.ConversationType.IrregularShake then
			return
		end

		if arg_56_0._dialogItem then
			if arg_56_0._dialogItem:isAudioPlaying() then
				arg_56_0._dialogItem:checkAutoEnterNext(arg_56_0._onAutoDialogFinished, arg_56_0)
			else
				arg_56_0:_onAutoDialogFinished()
			end
		end
	end
end

function var_0_0._onAutoDialogFinished(arg_57_0)
	StoryController.instance:enterNext()
end

function var_0_0._onEnableClick(arg_58_0)
	if StoryModel.instance:isTextShowing() then
		return
	end

	StoryModel.instance:enableClick(true)
end

function var_0_0._updateAudioList(arg_59_0, arg_59_1)
	local var_59_0 = {}
	local var_59_1 = StoryModel.instance:getStepLine()
	local var_59_2 = 0

	for iter_59_0, iter_59_1 in pairs(var_59_1) do
		var_59_2 = var_59_2 + 1
	end

	if var_59_2 > 1 then
		arg_59_0:stopAllAudio(0)
	end

	local var_59_3 = false

	if var_59_1[arg_59_0._curStoryId] then
		for iter_59_2, iter_59_3 in ipairs(var_59_1[arg_59_0._curStoryId]) do
			if iter_59_3.skip then
				var_59_3 = true

				break
			end
		end
	end

	if var_59_3 then
		arg_59_0:stopAllAudio(0)
	end

	if arg_59_0._curStoryId and arg_59_0._curStoryId == StoryController.instance._curStoryId and arg_59_0._stepId and arg_59_0._stepId == StoryController.instance._curStepId and arg_59_0._audios then
		for iter_59_4, iter_59_5 in pairs(arg_59_1) do
			if not arg_59_0._audios[iter_59_5.audio] then
				return
			end
		end
	end

	arg_59_0._audioCo = arg_59_1

	for iter_59_6, iter_59_7 in pairs(arg_59_0._audioCo) do
		if not arg_59_0._audios then
			arg_59_0._audios = {}
		end

		if not arg_59_0._audios[iter_59_7.audio] then
			arg_59_0._audios[iter_59_7.audio] = StoryAudioItem.New()

			arg_59_0._audios[iter_59_7.audio]:init(iter_59_7.audio)
		end

		arg_59_0._audios[iter_59_7.audio]:setAudio(iter_59_7)
	end
end

function var_0_0.stopAllAudio(arg_60_0, arg_60_1)
	if arg_60_0._audios then
		for iter_60_0, iter_60_1 in pairs(arg_60_0._audios) do
			iter_60_1:stop(arg_60_1)
		end

		arg_60_0._audios = nil
	end
end

function var_0_0._updateEffectList(arg_61_0, arg_61_1)
	local var_61_0 = {}
	local var_61_1 = StoryModel.instance:getStepLine()
	local var_61_2 = 0

	for iter_61_0, iter_61_1 in pairs(var_61_1) do
		var_61_2 = var_61_2 + 1
	end

	if var_61_2 > 1 then
		for iter_61_2, iter_61_3 in pairs(arg_61_0._effects) do
			iter_61_3:onDestroy()
		end
	end

	if var_61_1[arg_61_0._curStoryId] then
		for iter_61_4, iter_61_5 in ipairs(var_61_1[arg_61_0._curStoryId]) do
			if iter_61_5.skip and iter_61_5.skip then
				local var_61_3 = StoryStepModel.instance:getStepListById(iter_61_5.stepId).effList

				for iter_61_6 = 1, #var_61_3 do
					table.insert(var_61_0, var_61_3[iter_61_6])

					if var_61_3[iter_61_6].orderType == StoryEnum.EffectOrderType.Destroy then
						for iter_61_7 = #var_61_0, 1, -1 do
							if var_61_0[iter_61_7].orderType ~= StoryEnum.EffectOrderType.Destroy and var_61_0[iter_61_7].effect == var_61_3[iter_61_6].effect then
								table.remove(var_61_0, #var_61_0)
								table.remove(var_61_0, iter_61_7)
							end
						end
					end
				end
			end
		end
	end

	if #arg_61_1 < 1 and #var_61_0 == 0 then
		return
	end

	arg_61_0._effCo = #var_61_0 == 0 and arg_61_1 or var_61_0

	local var_61_4 = false

	for iter_61_8, iter_61_9 in pairs(arg_61_0._effCo) do
		if iter_61_9.orderType ~= StoryEnum.EffectOrderType.Destroy and iter_61_9.layer > 0 then
			arg_61_0:_buildEffect(iter_61_9.effect, iter_61_9)
		else
			arg_61_0:_destroyEffect(iter_61_9.effect, iter_61_9)
		end

		if iter_61_9.layer < 4 then
			var_61_4 = true
		end
	end

	StoryTool.enablePostProcess(false)

	for iter_61_10, iter_61_11 in pairs(arg_61_0._effects) do
		StoryTool.enablePostProcess(true)
	end

	StoryModel.instance:setHasBottomEffect(var_61_4)
end

function var_0_0._buildEffect(arg_62_0, arg_62_1, arg_62_2)
	local var_62_0 = 0
	local var_62_1

	if arg_62_2.layer < 4 then
		var_62_1 = arg_62_0._goeff1
		var_62_0 = 4
	elseif arg_62_2.layer < 7 then
		var_62_1 = arg_62_0._goeff2
		var_62_0 = 1000
	elseif arg_62_2.layer < 10 then
		var_62_1 = arg_62_0._goeff3
		var_62_0 = 2000
	else
		if not arg_62_0._goeff4 then
			local var_62_2 = ViewMgr.instance:getContainer(ViewName.StoryFrontView).viewGO

			arg_62_0._goeff4 = gohelper.findChild(var_62_2, "#go_frontitem/#go_eff4")
		end

		var_62_1 = arg_62_0._goeff4
	end

	if not arg_62_0._effects[arg_62_1] then
		arg_62_0._effects[arg_62_1] = StoryEffectItem.New()

		arg_62_0._effects[arg_62_1]:init(var_62_1, arg_62_1, arg_62_2, var_62_0)
	else
		arg_62_0._effects[arg_62_1]:reset(var_62_1, arg_62_2, var_62_0)
	end
end

function var_0_0._destroyEffect(arg_63_0, arg_63_1, arg_63_2)
	if not arg_63_0._effects[arg_63_1] then
		return
	end

	local var_63_0 = {
		callback = arg_63_0._effectRealDestroy,
		callbackObj = arg_63_0
	}

	arg_63_0._effects[arg_63_1]:destroyEffect(arg_63_2, var_63_0)
end

function var_0_0._effectRealDestroy(arg_64_0, arg_64_1)
	arg_64_0._effects[arg_64_1] = nil
end

function var_0_0._updatePictureList(arg_65_0, arg_65_1)
	local var_65_0 = {}
	local var_65_1 = StoryModel.instance:getStepLine()
	local var_65_2 = 0

	for iter_65_0, iter_65_1 in pairs(var_65_1) do
		var_65_2 = var_65_2 + 1
	end

	if var_65_2 > 1 then
		for iter_65_2, iter_65_3 in pairs(arg_65_0._pictures) do
			iter_65_3:onDestroy()
		end
	end

	local var_65_3 = false

	if var_65_1[arg_65_0._curStoryId] then
		for iter_65_4, iter_65_5 in ipairs(var_65_1[arg_65_0._curStoryId]) do
			local var_65_4 = StoryStepModel.instance:getStepListById(iter_65_5.stepId).picList

			if iter_65_5.skip then
				var_65_3 = true

				for iter_65_6 = 1, #var_65_4 do
					table.insert(var_65_0, var_65_4[iter_65_6])

					if var_65_4[iter_65_6].orderType == StoryEnum.PictureOrderType.Destroy then
						for iter_65_7 = #var_65_0, 1, -1 do
							if var_65_0[iter_65_7].orderType == StoryEnum.PictureOrderType.Produce and var_65_0[iter_65_7].picture == var_65_4[iter_65_6].picture then
								table.remove(var_65_0, #var_65_0)
								table.remove(var_65_0, iter_65_7)
							end
						end
					end
				end
			end
		end
	end

	arg_65_0:_resetStepPictures()

	if #arg_65_1 < 1 and #var_65_0 == 0 then
		return
	end

	arg_65_0._picCo = #var_65_0 > 0 and var_65_0 or arg_65_1

	for iter_65_8, iter_65_9 in pairs(arg_65_0._picCo) do
		local var_65_5 = iter_65_9.picType == StoryEnum.PictureType.FullScreen and "fullfocusitem" or iter_65_9.picture

		if iter_65_9.orderType == StoryEnum.PictureOrderType.Produce and iter_65_9.layer > 0 then
			arg_65_0:_buildPicture(var_65_5, iter_65_9, var_65_3)
		else
			arg_65_0:_destroyPicture(var_65_5, iter_65_9, var_65_3)
		end
	end

	arg_65_0:_checkFloatBgShow()
end

function var_0_0._resetStepPictures(arg_66_0)
	for iter_66_0, iter_66_1 in pairs(arg_66_0._pictures) do
		iter_66_1:resetStep()
	end
end

function var_0_0._checkFloatBgShow(arg_67_0)
	ZProj.TweenHelper.KillByObj(arg_67_0._imagefullbottom)

	for iter_67_0, iter_67_1 in pairs(arg_67_0._pictures) do
		if iter_67_1:isFloatType() then
			gohelper.setActive(arg_67_0._imagefullbottom.gameObject, true)

			local var_67_0 = arg_67_0._imagefullbottom.color.a

			ZProj.TweenHelper.DoFade(arg_67_0._imagefullbottom, var_67_0, arg_67_0._initFullBottomAlpha, 0.1, nil, nil, nil, EaseType.Linear)

			return
		end
	end

	local var_67_1 = 0

	for iter_67_2, iter_67_3 in pairs(arg_67_0._picCo) do
		var_67_1 = iter_67_3.orderType == StoryEnum.PictureOrderType.Destroy and iter_67_3.layer > 0 and iter_67_3.picType == StoryEnum.PictureType.Float and var_67_1 < iter_67_3.outTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] and iter_67_3.outTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] or var_67_1
	end

	for iter_67_4, iter_67_5 in pairs(arg_67_0._picCo) do
		if iter_67_5.orderType == StoryEnum.PictureOrderType.Produce and iter_67_5.layer > 0 and iter_67_5.picType == StoryEnum.PictureType.Float then
			var_67_1 = 0
		end
	end

	if var_67_1 < 0.01 then
		gohelper.setActive(arg_67_0._imagefullbottom.gameObject, false)
	else
		gohelper.setActive(arg_67_0._imagefullbottom.gameObject, true)
		ZProj.TweenHelper.DoFade(arg_67_0._imagefullbottom, arg_67_0._initFullBottomAlpha, 0, var_67_1, function()
			gohelper.setActive(arg_67_0._imagefullbottom.gameObject, false)
		end, nil, nil, EaseType.Linear)
	end
end

function var_0_0._buildPicture(arg_69_0, arg_69_1, arg_69_2, arg_69_3)
	local var_69_0

	if arg_69_2.layer < 4 then
		var_69_0 = arg_69_0._goimg1
	elseif arg_69_2.layer < 7 then
		var_69_0 = arg_69_0._goimg2
	elseif arg_69_2.layer < 10 then
		var_69_0 = arg_69_0._goimg3
	else
		if not arg_69_0._goimg4 then
			local var_69_1 = ViewMgr.instance:getContainer(ViewName.StoryFrontView).viewGO

			arg_69_0._goimg4 = gohelper.findChild(var_69_1, "#go_frontitem/#go_img4")
		end

		var_69_0 = arg_69_0._goimg4
	end

	if not arg_69_0._pictures[arg_69_1] then
		arg_69_0._pictures[arg_69_1] = StoryPictureItem.New()

		arg_69_0._pictures[arg_69_1]:init(var_69_0, arg_69_1, arg_69_2)
	elseif not arg_69_3 then
		arg_69_0._pictures[arg_69_1]:reset(var_69_0, arg_69_2)
	end
end

function var_0_0._destroyPicture(arg_70_0, arg_70_1, arg_70_2, arg_70_3)
	if not arg_70_0._pictures[arg_70_1] then
		if arg_70_3 then
			if arg_70_2.orderType == StoryEnum.PictureOrderType.Produce then
				arg_70_0:_buildPicture(arg_70_1, arg_70_2, arg_70_3)
			end

			TaskDispatcher.runDelay(function()
				arg_70_0:_startDestroyPic(arg_70_2, arg_70_3, arg_70_1)
			end, nil, 0.2)
		end

		return
	end

	arg_70_0:_startDestroyPic(arg_70_2, arg_70_3, arg_70_1)
end

function var_0_0._startDestroyPic(arg_72_0, arg_72_1, arg_72_2, arg_72_3)
	if not arg_72_0._pictures[arg_72_3] then
		return
	end

	local var_72_0 = 0
	local var_72_1 = arg_72_0._stepCo.videoList

	for iter_72_0, iter_72_1 in pairs(var_72_1) do
		if iter_72_1.orderType == StoryEnum.VideoOrderType.Produce then
			var_72_0 = 0.5
		end
	end

	arg_72_0._pictures[arg_72_3]:destroyPicture(arg_72_1, arg_72_2, var_72_0)

	arg_72_0._pictures[arg_72_3] = nil
end

function var_0_0._updateNavigateList(arg_73_0, arg_73_1)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshNavigate, arg_73_1)
end

function var_0_0._updateVideoList(arg_74_0, arg_74_1)
	arg_74_0._videoCo = arg_74_1

	local var_74_0 = false

	arg_74_0:_checkCreatePlayList()

	for iter_74_0, iter_74_1 in pairs(arg_74_0._videoCo) do
		if iter_74_1.orderType == StoryEnum.VideoOrderType.Produce then
			arg_74_0:_buildVideo(iter_74_1.video, iter_74_1)
		elseif iter_74_1.orderType == StoryEnum.VideoOrderType.Destroy then
			arg_74_0:_destroyVideo(iter_74_1.video, iter_74_1)
		elseif iter_74_1.orderType == StoryEnum.VideoOrderType.Pause then
			arg_74_0._videos[iter_74_1.video]:pause(true)
		else
			arg_74_0._videos[iter_74_1.video]:pause(false)
		end
	end

	for iter_74_2, iter_74_3 in pairs(arg_74_0._videoCo) do
		if iter_74_3.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 and (iter_74_3.orderType == StoryEnum.VideoOrderType.Produce or iter_74_3.orderType == StoryEnum.VideoOrderType.Pause or iter_74_3.orderType == StoryEnum.VideoOrderType.Restart) then
			var_74_0 = true
		end
	end

	if not var_74_0 then
		StoryController.instance:dispatchEvent(StoryEvent.ShowBackground)
	end
end

function var_0_0._videoStarted(arg_75_0, arg_75_1)
	for iter_75_0, iter_75_1 in pairs(arg_75_0._videos) do
		if iter_75_1 ~= arg_75_1 then
			iter_75_1:pause(true)
		end
	end
end

function var_0_0._buildVideo(arg_76_0, arg_76_1, arg_76_2)
	arg_76_0:_checkCreatePlayList()

	local var_76_0

	if arg_76_2.layer < 4 then
		var_76_0 = arg_76_0._govideo1
	elseif arg_76_2.layer < 7 then
		var_76_0 = arg_76_0._govideo2
	else
		var_76_0 = arg_76_0._govideo3
	end

	if not arg_76_0._videos[arg_76_1] then
		arg_76_0._videos[arg_76_1] = StoryVideoItem.New()

		arg_76_0._videos[arg_76_1]:init(var_76_0, arg_76_1, arg_76_2, arg_76_0._videoStarted, arg_76_0, arg_76_0._videoPlayList)
	else
		arg_76_0._videos[arg_76_1]:reset(var_76_0, arg_76_2)
	end
end

function var_0_0._destroyVideo(arg_77_0, arg_77_1, arg_77_2)
	if not arg_77_0._videos[arg_77_1] then
		return
	end

	arg_77_0._videos[arg_77_1]:destroyVideo(arg_77_2)

	arg_77_0._videos[arg_77_1] = nil
end

function var_0_0._checkCreatePlayList(arg_78_0)
	if not arg_78_0._videoPlayList then
		local var_78_0 = AvProMgr.instance:getStoryUrl()
		local var_78_1 = arg_78_0:getResInst(var_78_0, arg_78_0.viewGO, "play_list")

		arg_78_0._videoPlayList = StoryVideoPlayList.New()

		arg_78_0._videoPlayList:init(var_78_1, arg_78_0.viewGO)
	end
end

function var_0_0._checkDisposePlayList(arg_79_0)
	if arg_79_0._videoPlayList then
		arg_79_0._videoPlayList:dispose()

		arg_79_0._videoPlayList = nil
	end
end

function var_0_0._updateOptionList(arg_80_0, arg_80_1)
	arg_80_0._optCo = arg_80_1
end

function var_0_0._clearItems(arg_81_0, arg_81_1)
	arg_81_0:_clearAllTimers()
	TaskDispatcher.cancelTask(arg_81_0._viewFadeIn, arg_81_0)
	TaskDispatcher.cancelTask(arg_81_0._enterNextStep, arg_81_0)
	TaskDispatcher.cancelTask(arg_81_0._startShowText, arg_81_0)
	TaskDispatcher.cancelTask(arg_81_0._startShake, arg_81_0)
	TaskDispatcher.cancelTask(arg_81_0._shakeStop, arg_81_0)

	for iter_81_0, iter_81_1 in pairs(arg_81_0._pictures) do
		iter_81_1:onDestroy()
	end

	arg_81_0._pictures = {}

	for iter_81_2, iter_81_3 in pairs(arg_81_0._effects) do
		iter_81_3:onDestroy()
	end

	arg_81_0._effects = {}

	for iter_81_4, iter_81_5 in pairs(arg_81_0._videos) do
		iter_81_5:onDestroy()
	end

	arg_81_0._videos = {}

	arg_81_0:_checkDisposePlayList()
end

function var_0_0.onDestroyView(arg_82_0)
	if ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
		ViewMgr.instance:closeView(ViewName.MessageBoxView, true)
	end

	if arg_82_0._confadeId then
		ZProj.TweenHelper.KillById(arg_82_0._confadeId)

		arg_82_0._confadeId = nil
	end

	ZProj.TweenHelper.KillByObj(arg_82_0._imagefullbottom)
	arg_82_0:_checkDisposePlayList()
	TaskDispatcher.cancelTask(arg_82_0._conShowIn, arg_82_0)
	TaskDispatcher.cancelTask(arg_82_0._startShowText, arg_82_0)
	TaskDispatcher.cancelTask(arg_82_0._enterNextStep, arg_82_0)
	TaskDispatcher.cancelTask(arg_82_0._onFullTextFinished, arg_82_0)
	TaskDispatcher.cancelTask(arg_82_0._startShake, arg_82_0)
	TaskDispatcher.cancelTask(arg_82_0._guaranteeEnterNextStep, arg_82_0)
	TaskDispatcher.cancelTask(arg_82_0._shakeStop, arg_82_0)
	StoryTool.enablePostProcess(false)
	ViewMgr.instance:closeView(ViewName.StoryFrontView, nil, true)
	arg_82_0._simagehead:UnLoadImage()
	StoryController.instance:stopPlotMusic()

	arg_82_0._bgAudio = nil

	arg_82_0:stopAllAudio(0)

	if arg_82_0._dialogItem then
		arg_82_0._dialogItem:destroy()

		arg_82_0._dialogItem = nil
	end
end

return var_0_0
