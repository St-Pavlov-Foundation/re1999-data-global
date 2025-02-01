module("modules.logic.story.view.StoryView", package.seeall)

slot0 = class("StoryView", BaseView)

function slot0._clearAllTimers(slot0)
	TaskDispatcher.cancelTask(slot0._conShowIn, slot0)
	TaskDispatcher.cancelTask(slot0._onEnableClick, slot0)
	TaskDispatcher.cancelTask(slot0._enterNextStep, slot0)
	TaskDispatcher.cancelTask(slot0._onFullTextFinished, slot0)
	TaskDispatcher.cancelTask(slot0._startShowText, slot0)
	TaskDispatcher.cancelTask(slot0._onCheckNext, slot0)
	TaskDispatcher.cancelTask(slot0._guaranteeEnterNextStep, slot0)
	TaskDispatcher.cancelTask(slot0._playShowHero, slot0)
	TaskDispatcher.cancelTask(slot0._startShake, slot0)
	TaskDispatcher.cancelTask(slot0._shakeStop, slot0)
	TaskDispatcher.cancelTask(slot0._viewFadeIn, slot0)
end

function slot0.onInitView(slot0)
	slot0._imagefullbottom = gohelper.findChildImage(slot0.viewGO, "#image_fullbottom")
	slot0._gomiddle = gohelper.findChild(slot0.viewGO, "#go_middle")
	slot0._goimg2 = gohelper.findChild(slot0.viewGO, "#go_middle/#go_img2")
	slot0._govideo2 = gohelper.findChild(slot0.viewGO, "#go_middle/#go_video2")
	slot0._goeff2 = gohelper.findChild(slot0.viewGO, "#go_middle/#go_eff2")
	slot0._gocontentroot = gohelper.findChild(slot0.viewGO, "#go_contentroot")
	slot0._gonexticon = gohelper.findChild(slot0.viewGO, "#go_contentroot/nexticon")
	slot0._goconversation = gohelper.findChild(slot0.viewGO, "#go_contentroot/#go_conversation")
	slot0._goblackbottom = gohelper.findChild(slot0.viewGO, "#go_contentroot/#go_conversation/content/blackBottom")
	slot0._gohead = gohelper.findChild(slot0.viewGO, "#go_contentroot/#go_conversation/#go_contents/content/#go_head")
	slot0._goheadgrey = gohelper.findChild(slot0.viewGO, "#go_contentroot/#go_conversation/#go_contents/content/#go_head/#go_headgrey")
	slot0._simagehead = gohelper.findChildSingleImage(slot0.viewGO, "#go_contentroot/#go_conversation/#go_contents/content/#go_head/#simage_head")
	slot0._gospine = gohelper.findChild(slot0.viewGO, "#go_contentroot/#go_conversation/#go_contents/content/#go_spine")
	slot0._gospineobj = gohelper.findChild(slot0.viewGO, "#go_contentroot/#go_conversation/#go_contents/content/#go_spine/mask/#go_spineobj")
	slot0._goname = gohelper.findChild(slot0.viewGO, "#go_contentroot/#go_conversation/#go_contents/content/#go_name")
	slot0._gonamebg = gohelper.findChild(slot0.viewGO, "#go_contentroot/#go_conversation/#go_contents/content/#go_name/#go_namebg")
	slot0._txtnamecn1 = gohelper.findChildText(slot0.viewGO, "#go_contentroot/#go_conversation/#go_contents/content/#go_name/namelayout/#txt_namecn1")
	slot0._txtnamecn2 = gohelper.findChildText(slot0.viewGO, "#go_contentroot/#go_conversation/#go_contents/content/#go_name/namelayout/#txt_namecn2")
	slot0._txtnameen = gohelper.findChildText(slot0.viewGO, "#go_contentroot/#go_conversation/#go_contents/content/#go_name/namelayout/#txt_nameen")
	slot0._gocontents = gohelper.findChild(slot0.viewGO, "#go_contentroot/#go_conversation/#go_contents")
	slot0._gonoconversation = gohelper.findChild(slot0.viewGO, "#go_contentroot/#go_noconversation")
	slot0._gotop = gohelper.findChild(slot0.viewGO, "#go_top")
	slot0._goimg3 = gohelper.findChild(slot0.viewGO, "#go_top/#go_img3")
	slot0._govideo3 = gohelper.findChild(slot0.viewGO, "#go_top/#go_video3")
	slot0._goeff3 = gohelper.findChild(slot0.viewGO, "#go_top/#go_eff3")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._btnnextOnClick(slot0)
	if StoryModel.instance:isViewHide() then
		StoryModel.instance:setViewHide(false)
		gohelper.setActive(slot0._gocontentroot, StoryModel.instance:isNormalStep())
		StoryController.instance:dispatchEvent(StoryEvent.LeadRoleViewShow, StoryModel.instance:isNormalStep())

		return
	end

	if StoryModel.instance:isStoryAuto() then
		return
	end

	if not slot0._stepCo or slot0._stepCo.conversation.type == StoryEnum.ConversationType.None or slot0._stepCo.conversation.type == StoryEnum.ConversationType.NoInteract then
		return
	end

	if StoryModel.instance:isNormalStep() then
		if StoryModel.instance:isTextShowing() then
			slot0._dialogItem:conFinished()
			slot0:_conFinished()
		else
			slot0:_enterNextStep()
		end
	end
end

function slot0._btnhideOnClick(slot0)
	StoryController.instance:dispatchEvent(StoryEvent.LeadRoleViewShow, false)
	gohelper.setActive(slot0._gocontentroot, false)
end

function slot0._btnlogOnClick(slot0)
	StoryController.instance:openStoryLogView()
end

function slot0._btnautoOnClick(slot0)
	if slot0._stepCo.conversation.type ~= StoryEnum.ConversationType.None and slot0._stepCo.conversation.type ~= StoryEnum.ConversationType.NoInteract and slot0._stepCo.conversation.type ~= StoryEnum.ConversationType.ScreenDialog and slot0._stepCo.conversation.type ~= StoryEnum.ConversationType.IrregularShake then
		slot0._dialogItem:startAutoEnterNext()
	end
end

function slot0._btnskipOnClick(slot0, slot1)
	if not slot1 and not StoryModel.instance:isNormalStep() then
		return
	end

	StoryTool.enablePostProcess(true)

	if slot0._curStoryId == SDKMediaEventEnum.FirstStoryId and PlayerPrefsHelper.getNumber(string.format(PlayerPrefsKey.SDKDataTrackMgr_MediaEvent_first_story_skip, PlayerModel.instance:getMyUserId()), 0) == 0 then
		SDKDataTrackMgr.instance:trackMediaEvent(SDKDataTrackMgr.MediaEvent.first_story_skip)
		PlayerPrefsHelper.setNumber(slot2, 1)
	end

	slot0:_skipStep(slot1)
end

function slot0._editableInitView(slot0)
	slot0:_initData()
	slot0:_initView()
end

function slot0.addEvent(slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.RefreshStep, slot0._onUpdateUI, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.AllStepFinished, slot0._storyFinished, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.RefreshView, slot0._refreshView, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.RefreshConversation, slot0._updateConversation, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.Log, slot0._btnlogOnClick, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.Hide, slot0._btnhideOnClick, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.Auto, slot0._btnautoOnClick, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.Skip, slot0._btnskipOnClick, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.EnterNextStep, slot0._btnnextOnClick, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.Finish, slot0._clearItems, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.FullTextLineShowFinished, slot0._onFullTextShowFinished, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.HideDialog, slot0._hideDialog, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.DialogConFinished, slot0._dialogConFinished, slot0)
end

function slot0.removeEvent(slot0)
	slot0:removeEventCb(StoryController.instance, StoryEvent.RefreshStep, slot0._onUpdateUI, slot0)
	slot0:removeEventCb(StoryController.instance, StoryEvent.AllStepFinished, slot0._storyFinished, slot0)
	slot0:removeEventCb(StoryController.instance, StoryEvent.RefreshView, slot0._refreshView, slot0)
	slot0:removeEventCb(StoryController.instance, StoryEvent.RefreshConversation, slot0._updateConversation, slot0)
	slot0:removeEventCb(StoryController.instance, StoryEvent.Log, slot0._btnlogOnClick, slot0)
	slot0:removeEventCb(StoryController.instance, StoryEvent.Hide, slot0._btnhideOnClick, slot0)
	slot0:removeEventCb(StoryController.instance, StoryEvent.Auto, slot0._btnautoOnClick, slot0)
	slot0:removeEventCb(StoryController.instance, StoryEvent.Skip, slot0._btnskipOnClick, slot0)
	slot0:removeEventCb(StoryController.instance, StoryEvent.EnterNextStep, slot0._btnnextOnClick, slot0)
	slot0:removeEventCb(StoryController.instance, StoryEvent.Finish, slot0._clearItems, slot0)
	slot0:removeEventCb(StoryController.instance, StoryEvent.FullTextLineShowFinished, slot0._onFullTextShowFinished, slot0)
	slot0:removeEventCb(StoryController.instance, StoryEvent.HideDialog, slot0._hideDialog, slot0)
	slot0:removeEventCb(StoryController.instance, StoryEvent.DialogConFinished, slot0._dialogConFinished, slot0)
end

function slot0._initData(slot0)
	slot0._stepId = 0
	slot0._audios = {}
	slot0._pictures = {}
	slot0._effects = {}
	slot0._videos = {}
	slot0._initFullBottomAlpha = slot0._imagefullbottom.color.a

	StoryModel.instance:resetStoryState()
end

function slot0._initView(slot0)
	slot0._conCanvasGroup = slot0._gocontentroot:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._contentAnimator = slot0._goconversation:GetComponent(typeof(UnityEngine.Animator))
	slot1 = ViewMgr.instance:getContainer(ViewName.StoryBackgroundView).viewGO
	slot0._gobottom = gohelper.findChild(slot1, "#go_bottomitem")
	slot0._goimg1 = gohelper.findChild(slot1, "#go_bottomitem/#go_img1")
	slot0._govideo1 = gohelper.findChild(slot1, "#go_bottomitem/#go_video1")
	slot0._goeff1 = gohelper.findChild(slot1, "#go_bottomitem/#go_eff1")

	gohelper.setActive(slot0._gocontentroot, false)
	slot0:_initItems()
end

function slot0.onOpen(slot0)
	slot0:addEvent()
	ViewMgr.instance:openView(ViewName.StoryFrontView, nil, true)
	gohelper.setActive(slot0.viewGO, true)
	SpineFpsMgr.instance:set(SpineFpsMgr.Story)

	if UnityEngine.Shader.IsKeywordEnabled("_MAININTERFACELIGHT") then
		slot0._keywordEnable = true

		UnityEngine.Shader.DisableKeyword("_MAININTERFACELIGHT")
	end

	slot0:_clearItems()
end

function slot0._initItems(slot0)
	if not slot0._dialogItem then
		slot0._dialogItem = StoryDialogItem.New()

		slot0._dialogItem:init(slot0._gocontentroot)
		slot0._dialogItem:hideDialog()
	end
end

function slot0._hideDialog(slot0)
	if slot0._dialogItem then
		if StoryModel.instance:isTextShowing() then
			slot0._dialogItem:conFinished()
			slot0:_conFinished()
		end

		gohelper.setActive(slot0._gocontentroot, false)
	end
end

function slot0._dialogConFinished(slot0)
	if slot0._dialogItem and StoryModel.instance:isTextShowing() then
		slot0._dialogItem:conFinished()
		slot0:_conFinished()
	end
end

function slot0._storyFinished(slot0, slot1)
	slot0:_clearAllTimers()

	slot0._stepId = 0
	slot0._finished = true
	slot0._stepCo = nil

	TaskDispatcher.cancelTask(slot0._onCheckNext, slot0)
	slot0._dialogItem:storyFinished()
	StoryModel.instance:enableClick(false)

	if slot0._dialogItem then
		slot0._dialogItem:stopConAudio()
	end

	if StoryController.instance._hideStartAndEndDark then
		slot0:stopAllAudio(1.5)
		gohelper.setActive(slot0._gospine, false)

		if slot0._confadeId then
			ZProj.TweenHelper.KillById(slot0._confadeId)
		end

		slot0._confadeId = ZProj.TweenHelper.DOFadeCanvasGroup(slot0._gocontentroot, 1, 0, 0.35, nil, , , EaseType.Linear)

		return
	end

	if StoryModel.instance:isTypeSkip(StoryEnum.SkipType.OutDarkFade, StoryController.instance._curStoryId) then
		return
	end

	slot0:stopAllAudio(1.5)
end

function slot0.onClose(slot0)
	slot0:_clearAllTimers()

	if not slot0._finished then
		slot0:stopAllAudio(0)
	end

	if slot0._keywordEnable then
		UnityEngine.Shader.EnableKeyword("_MAININTERFACELIGHT")
	end

	slot0:removeEvent()
	TaskDispatcher.cancelTask(slot0._viewFadeIn, slot0)
	slot0:_clearItems()
	SpineFpsMgr.instance:remove(SpineFpsMgr.Story)
end

function slot0.onUpdateParam(slot0)
end

function slot0._enterNextStep(slot0)
	StoryController.instance:dispatchEvent(StoryEvent.PlayFullTextOut)

	if slot0._diaLineTxt and slot0._diaLineTxt[2] then
		slot1, slot2, slot3 = transformhelper.getLocalPos(slot0._diaLineTxt[2].transform)

		transformhelper.setLocalPos(slot0._diaLineTxt[2].transform, slot1, slot2, 1)
	end

	TaskDispatcher.cancelTask(slot0._enterNextStep, slot0)
	TaskDispatcher.cancelTask(slot0._guaranteeEnterNextStep, slot0)
	StoryController.instance:enterNext()
end

function slot0._guaranteeEnterNextStep(slot0)
	slot0:_enterNextStep()
end

function slot0._skipStep(slot0, slot1)
	StoryModel.instance:enableClick(false)
	TaskDispatcher.cancelTask(slot0._enterNextStep, slot0)
	TaskDispatcher.cancelTask(slot0._playShowHero, slot0)

	if slot1 then
		StoryController.instance:skipAllStory()
	else
		StoryController.instance:skipStory()
	end
end

function slot0._onCheckNext(slot0)
	slot0:_onConFinished(slot0._stepCo.conversation.isAuto)
end

function slot0._onUpdateUI(slot0, slot1)
	slot0._finished = false

	StoryModel.instance:setStepNormal(slot1.stepType == StoryEnum.StepType.Normal)

	if slot0._gocontentroot.activeSelf ~= StoryModel.instance:isNormalStep() then
		gohelper.setActive(slot0._gocontentroot, not StoryModel.instance:isNormalStep())
		StoryController.instance:dispatchEvent(StoryEvent.LeadRoleViewShow, not StoryModel.instance:isNormalStep())
	end

	if slot0._curStoryId ~= slot1.storyId and #slot1.branches < 1 then
		slot0:_clearItems()

		slot0._curStoryId = slot1.storyId
	end

	slot0:_updateStep(slot1.stepId)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshHero, slot1)

	if #slot1.branches > 0 then
		StoryController.instance:openStoryBranchView(slot1.branches)
		slot0:_showBranchLeadHero()
	else
		gohelper.setActive(slot0._gonoconversation, false)
	end

	StoryModel.instance:clearStepLine()
end

function slot0._showBranchLeadHero(slot0)
	slot0._dialogItem:hideDialog()
	slot0._dialogItem:stopConAudio()

	if slot0._confadeId then
		ZProj.TweenHelper.KillById(slot0._confadeId)
	end

	TaskDispatcher.cancelTask(slot0._conShowIn, slot0)
	TaskDispatcher.cancelTask(slot0._startShowText, slot0)
	TaskDispatcher.cancelTask(slot0._startShake, slot0)
	TaskDispatcher.cancelTask(slot0._shakeStop, slot0)
	TaskDispatcher.cancelTask(slot0._enterNextStep, slot0)

	slot0._conCanvasGroup.alpha = 1

	gohelper.setActive(slot0._goname, true)
	gohelper.setActive(slot0._txtnameen.gameObject, true)
	gohelper.setActive(slot0._gocontentroot, true)
	gohelper.setActive(slot0._gonoconversation, true)

	slot1 = nil

	for slot5, slot6 in pairs(slot0._stepCo.optList) do
		if slot6.condition and slot6.conditionType == StoryEnum.OptionConditionType.HeroLead then
			slot1 = slot6
		end
	end

	if slot1 then
		slot0:_showNormalLeadHero(slot1)
	else
		slot0:_showSpineLeadHero()
	end
end

function slot0._showNormalLeadHero(slot0, slot1)
	gohelper.setActive(slot0._gohead, true)
	gohelper.setActive(slot0._gospine, false)
	slot0:_showHeadContentTxt(slot1.conditionValue2[GameLanguageMgr.instance:getLanguageTypeStoryIndex()], slot1.conditionValue2[LanguageEnum.LanguageStoryType.EN])
	slot0:_showHeadContentIcon(slot1.conditionValue)
end

function slot0._showSpineLeadHero(slot0)
	StoryController.instance:dispatchEvent(StoryEvent.LeadRoleViewShow, true)
	gohelper.setActive(slot0._gohead, false)
	gohelper.setActive(slot0._gospine, true)

	slot1 = 1

	if slot0._stepCo and slot0._stepCo.optList[1] and slot0._stepCo.optList[1].feedbackType == StoryEnum.OptionFeedbackType.HeroLead then
		slot1 = slot0._stepCo.optList[1].feedbackValue ~= "" and tonumber(slot0._stepCo.optList[1].feedbackValue) or 1
	end

	StoryController.instance:dispatchEvent(StoryEvent.ShowLeadRole, slot0._stepCo, true, false, false, slot1)

	slot0._txtnamecn1.text = luaLang("mainrolename")
	slot0._txtnamecn2.text = luaLang("mainrolename")

	gohelper.setActive(slot0._txtnamecn1.gameObject, true)
	gohelper.setActive(slot0._txtnamecn2.gameObject, false)

	if GameLanguageMgr.instance:getLanguageTypeStoryIndex() ~= LanguageEnum.LanguageStoryType.EN then
		slot0._txtnameen.text = "<voffset=4>/ </voffset>Vertin"

		gohelper.setActive(slot0._txtnameen.gameObject, true)
	else
		slot0._txtnameen.text = ""

		gohelper.setActive(slot0._txtnameen.gameObject, false)
	end
end

function slot0._updateStep(slot0, slot1)
	if not StoryModel.instance:isNormalStep() then
		return
	end

	slot0._stepCo = StoryStepModel.instance:getStepListById(slot1)

	if slot0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.SoftLight then
		gohelper.setActive(slot0._goline, false)
		gohelper.setActive(slot0._gonexticon, false)
		gohelper.setActive(slot0._goblackbottom, false)
	else
		gohelper.setActive(slot0._goline, true)
		gohelper.setActive(slot0._gonexticon, true)
		gohelper.setActive(slot0._goblackbottom, true)
	end

	if slot0._stepCo.bg.transType ~= StoryEnum.BgTransType.DarkFade and slot0._stepCo.bg.transType ~= StoryEnum.BgTransType.WhiteFade then
		slot0:_refreshView()
	else
		slot0:_updateEffectList(slot0._stepCo.effList)
		slot0:_updateAudioList(slot0._stepCo.audioList)
	end
end

function slot0._refreshView(slot0)
	slot0:_updateEffectList(slot0._stepCo.effList)
	slot0:_updateAudioList(slot0._stepCo.audioList)
	slot0:_updatePictureList(slot0._stepCo.picList)
	slot0:_updateVideoList(slot0._stepCo.videoList)
	slot0:_updateNavigateList(slot0._stepCo.navigateList)
	slot0:_updateOptionList(slot0._stepCo.optList)
end

function slot0._updateConversation(slot0)
	if not slot0._stepCo then
		return
	end

	if not slot0._stepId or slot0._stepId == slot0._stepCo.id then
		slot0._stepId = 0

		return
	end

	StoryModel.instance:enableClick(false)

	slot0._stepId = slot0._stepCo.id

	if slot0._confadeId then
		ZProj.TweenHelper.KillById(slot0._confadeId)
	end

	TaskDispatcher.cancelTask(slot0._conShowIn, slot0)
	TaskDispatcher.cancelTask(slot0._onEnableClick, slot0)
	TaskDispatcher.cancelTask(slot0._enterNextStep, slot0)
	TaskDispatcher.cancelTask(slot0._onFullTextFinished, slot0)
	TaskDispatcher.cancelTask(slot0._startShowText, slot0)
	TaskDispatcher.cancelTask(slot0._onCheckNext, slot0)

	if slot0._stepCo.conversation.type ~= StoryEnum.ConversationType.None then
		StoryModel.instance:setTextShowing(true)
	end

	if StoryModel.instance:isNeedFadeOut() then
		if slot0._gospine.activeSelf then
			StoryController.instance:dispatchEvent(StoryEvent.ShowLeadRole, slot0._stepCo, true, false, true)
		end

		slot0._confadeId = ZProj.TweenHelper.DOFadeCanvasGroup(slot0._gocontentroot, 1, 0, 0.35, nil, , , EaseType.Linear)

		if not StoryModel.instance:isPlayFinished() then
			TaskDispatcher.runDelay(slot0._conShowIn, slot0, 0.35)
		end
	else
		slot0:_conShowIn()
	end
end

function slot0._conShowIn(slot0)
	slot0._diatxt = StoryTool.getFilterDia(slot0._stepCo.conversation.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()])

	slot0._dialogItem:hideDialog()
	TaskDispatcher.cancelTask(slot0._enterNextStep, slot0)
	TaskDispatcher.cancelTask(slot0._guaranteeEnterNextStep, slot0)
	TaskDispatcher.cancelTask(slot0._onFullTextFinished, slot0)
	TaskDispatcher.cancelTask(slot0._startShowText, slot0)

	if slot0._stepCo.conversation.type == StoryEnum.ConversationType.None then
		slot0:_showConversationItem(false)
		TaskDispatcher.runDelay(slot0._guaranteeEnterNextStep, slot0, slot0._stepCo.conversation.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] + 0.2)
		TaskDispatcher.runDelay(slot0._enterNextStep, slot0, slot0._stepCo.conversation.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	else
		StoryController.instance:dispatchEvent(StoryEvent.SetFullText, "")

		if slot0._stepCo.conversation.type == StoryEnum.ConversationType.NoInteract then
			StoryModel.instance:enableClick(false)
			TaskDispatcher.runDelay(slot0._guaranteeEnterNextStep, slot0, slot0._stepCo.conversation.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] + 0.2)
			TaskDispatcher.runDelay(slot0._enterNextStep, slot0, slot0._stepCo.conversation.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
		end

		slot0:_showConversationItem(true)
	end

	if StoryModel.instance:isNeedFadeIn() then
		if slot0._gospine.activeSelf then
			StoryController.instance:dispatchEvent(StoryEvent.ShowLeadRole, slot0._stepCo, true, true, false)
		end

		slot0._confadeId = ZProj.TweenHelper.DOFadeCanvasGroup(slot0._gocontentroot, 0, 1, 0.5, nil, , , EaseType.Linear)

		TaskDispatcher.runDelay(slot0._startShowText, slot0, 0.5)
	else
		slot0:_startShowText()
	end
end

function slot0._startShowText(slot0)
	slot0._conCanvasGroup.alpha = 1

	if slot0._stepCo.conversation.effType ~= StoryEnum.ConversationEffectType.Shake then
		StoryController.instance:dispatchEvent(StoryEvent.ConversationShake, slot0._stepCo, 0, true)
		TaskDispatcher.cancelTask(slot0._startShake, slot0)
		TaskDispatcher.cancelTask(slot0._shakeStop, slot0)
		slot0._contentAnimator:Play(UIAnimationName.Idle)
	end

	slot0:_showText()
end

function slot0._showConversationItem(slot0, slot1)
	slot2 = slot0._stepCo.conversation.type ~= StoryEnum.ConversationType.ScreenDialog and slot0._stepCo.conversation.type ~= StoryEnum.ConversationType.IrregularShake
	slot3 = slot0._stepCo.conversation.type == StoryEnum.ConversationType.SlideDialog

	if not slot1 then
		gohelper.setActive(slot0._gocontentroot, false)
		slot0._simagehead:UnLoadImage()
		StoryController.instance:dispatchEvent(StoryEvent.LeadRoleViewShow, false)

		return
	end

	StoryController.instance:dispatchEvent(StoryEvent.SetFullText, slot0._diatxt)
	gohelper.setActive(slot0._gobtns, slot2)
	gohelper.setActive(slot0._gocontentroot, slot2)
	gohelper.setActive(slot0._goconversation, not slot3)
	StoryController.instance:dispatchEvent(StoryEvent.LeadRoleViewShow, slot2)
	slot0:_showHeadContentTxt(slot0._stepCo.conversation.heroNames[GameLanguageMgr.instance:getLanguageTypeStoryIndex()], slot0._stepCo.conversation.heroNames[LanguageEnum.LanguageStoryType.EN])
	gohelper.setActive(slot0._goname, slot0._stepCo.conversation.nameShow)

	slot7 = slot0._stepCo.conversation.nameEnShow

	if tonumber(slot0._stepCo.conversation.heroNames[LanguageEnum.LanguageStoryType.CN]) and GameLanguageMgr.instance:getLanguageTypeStoryIndex() == LanguageEnum.LanguageStoryType.EN then
		slot7 = false
	end

	gohelper.setActive(slot0._txtnameen.gameObject, slot7)

	if not slot0._stepCo.conversation.iconShow then
		gohelper.setActive(slot0._gohead, false)
		gohelper.setActive(slot0._gospine, false)
		gohelper.setActive(slot0._gonamebg, false)
		slot0._simagehead:UnLoadImage()
		StoryController.instance:dispatchEvent(StoryEvent.ShowLeadRole, slot0._stepCo, false, false, false)

		return
	end

	slot0:_showHeadContentIcon(slot0._stepCo.conversation.heroIcon)
end

function slot0._showHeadContentTxt(slot0, slot1, slot2)
	slot3 = string.match(slot1, "[^?]") == nil

	gohelper.setActive(slot0._txtnamecn1.gameObject, not slot3)
	gohelper.setActive(slot0._txtnamecn2.gameObject, slot3)

	if slot3 then
		slot0._txtnamecn2.text = string.split(slot1, "_")[1]
	else
		slot0._txtnamecn1.text = string.split(slot1, "_")[1]
	end

	if (tonumber(slot0._stepCo.conversation.heroNames[LanguageEnum.LanguageStoryType.CN]) and StoryTool.FilterStrByPatterns(slot1, {
		"%a",
		"%s",
		"%p"
	}) or StoryTool.FilterStrByPatterns(slot1, {
		"%w",
		"%s",
		"%p"
	})) ~= "" and GameLanguageMgr.instance:getLanguageTypeStoryIndex() ~= LanguageEnum.LanguageStoryType.EN then
		slot0._txtnameen.text = slot2 ~= "" and "<voffset=4>/ </voffset>" .. slot2 or ""

		gohelper.setActive(slot0._txtnameen.gameObject, true)
	else
		slot0._txtnameen.text = ""

		if slot4 and GameLanguageMgr.instance:getLanguageTypeStoryIndex() == LanguageEnum.LanguageStoryType.EN then
			slot0._txtnamecn1.text = slot0._stepCo.conversation.heroNames[LanguageEnum.LanguageStoryType.CN]
		end

		gohelper.setActive(slot0._txtnameen.gameObject, false)
	end
end

function slot0._showHeadContentIcon(slot0, slot1)
	if slot0:_isHeroLead() then
		gohelper.setActive(slot0._gohead, false)
		gohelper.setActive(slot0._gospine, true)
		gohelper.setActive(slot0._gonamebg, true)
		slot0._simagehead:UnLoadImage()
		StoryController.instance:dispatchEvent(StoryEvent.ShowLeadRole, slot0._stepCo, true, false, false)
	else
		gohelper.setActive(slot0._gospine, false)
		gohelper.setActive(slot0._gonamebg, false)
		gohelper.setActive(slot0._gohead, true)
		gohelper.setActive(slot0._goheadblack, not StoryModel.instance:isHeroIconCuts(string.split(slot1, ".")[1]))
		gohelper.setActive(slot0._goheadgrey, false)
		StoryController.instance:dispatchEvent(StoryEvent.ShowLeadRole, slot0._stepCo, false, false, false)

		if slot0._simagehead.curImageUrl == string.format("singlebg/headicon_small/%s", slot1) then
			gohelper.setActive(slot0._goheadgrey, true)
		else
			slot0._simagehead:LoadImage(slot3, function ()
				gohelper.setActive(uv0._goheadgrey, true)
			end)
		end
	end
end

function slot0._isHeroLead(slot0, slot1)
	for slot7, slot8 in ipairs(StoryConfig.instance:getStoryLeadHeroSpine()) do
		if slot8.icon == string.split(slot0._stepCo.conversation.heroIcon, ".")[1] then
			return true
		end
	end

	return false
end

function slot0._showText(slot0)
	if slot0._stepCo.conversation.type == StoryEnum.ConversationType.None then
		slot0._dialogItem:stopConAudio()

		return
	end

	StoryModel.instance:setTextShowing(true)

	if slot0._stepCo.conversation.type == StoryEnum.ConversationType.ScreenDialog then
		StoryModel.instance:enableClick(false)
		slot0:_playDialog()
		StoryController.instance:dispatchEvent(StoryEvent.PlayFullText, slot0._stepCo)
	elseif slot0._stepCo.conversation.type == StoryEnum.ConversationType.IrregularShake then
		StoryModel.instance:enableClick(false)
		slot0:_playDialog()
		StoryController.instance:dispatchEvent(StoryEvent.PlayIrregularShakeText, slot0._stepCo)
	else
		StoryModel.instance:enableClick(true)
		slot0:_playDialog()
	end

	if slot0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Shake then
		slot0:_shakeDialog()
	elseif slot0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Fade then
		slot0:_fadeIn()
	elseif slot0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.WordByWord then
		-- Nothing
	elseif slot0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.LineByLine then
		slot0:_lineShow(1)
	elseif slot0._stepCo.conversation.effType == StoryEnum.ConversationEffectType.TwoLineShow then
		slot0:_lineShow(2)
	end
end

function slot0._playDialog(slot0)
	slot0._finishTime = nil

	slot0._dialogItem:hideDialog()
	slot0._dialogItem:playDialog(StoryModel.instance:getStoryTxtByVoiceType(slot0._diatxt, slot0._stepCo.conversation.audios[1] or 0), slot0._stepCo, slot0._conFinished, slot0)
end

function slot0._conFinished(slot0)
	StoryModel.instance:setTextShowing(false)

	if slot0._conTweenId then
		ZProj.TweenHelper.KillById(slot0._conTweenId)

		slot0._conTweenId = nil
	end

	slot1 = false
	slot2 = slot0._stepCo and slot0._stepCo.conversation.keepTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] or 1.5

	if StoryModel.instance:isStoryAuto() then
		if not slot0._finishTime then
			slot0._finishTime = ServerTime.now()
		end

		slot1 = slot2 < ServerTime.now() - slot0._finishTime
	end

	slot0._finishTime = ServerTime.now()

	if slot1 then
		slot0:_onCheckNext()
	else
		TaskDispatcher.runDelay(slot0._onCheckNext, slot0, slot2)
	end
end

function slot0._shakeDialog(slot0)
	TaskDispatcher.cancelTask(slot0._startShake, slot0)
	TaskDispatcher.cancelTask(slot0._shakeStop, slot0)

	if slot0._stepCo.conversation.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		return
	end

	if slot0._stepCo.conversation.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		slot0:_startShake()
	else
		TaskDispatcher.runDelay(slot0._startShake, slot0, slot0._stepCo.conversation.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	end
end

function slot0._startShake(slot0)
	TaskDispatcher.cancelTask(slot0._shakeStop, slot0)
	slot0._contentAnimator:Play(({
		"low",
		"middle",
		"high"
	})[slot0._stepCo.conversation.effLv + 1])

	slot0._contentAnimator.speed = slot0._stepCo.conversation.effRate

	TaskDispatcher.runDelay(slot0._shakeStop, slot0, slot0._stepCo.conversation.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	StoryController.instance:dispatchEvent(StoryEvent.ConversationShake, slot0._stepCo, true, slot0._stepCo.conversation.effLv + 1)
end

function slot0._shakeStop(slot0)
	StoryController.instance:dispatchEvent(StoryEvent.ConversationShake, slot0._stepCo, false, slot0._stepCo.conversation.effLv + 1)

	slot0._contentAnimator.speed = slot0._stepCo.conversation.effRate

	slot0._contentAnimator:SetBool("stoploop", true)
end

function slot0._fadeIn(slot0)
	StoryModel.instance:setTextShowing(true)
	slot0._dialogItem:playNorDialogFadeIn(slot0._fadeInFinished, slot0)
end

function slot0._fadeInFinished(slot0)
	StoryModel.instance:setTextShowing(false)
	TaskDispatcher.cancelTask(slot0._onCheckNext, slot0)

	if not slot0._stepCo then
		return
	end

	TaskDispatcher.runDelay(slot0._onCheckNext, slot0, slot0._stepCo.conversation.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function slot0._wordByWord(slot0)
	StoryModel.instance:setTextShowing(true)
	slot0._dialogItem:playWordByWord(slot0._wordByWordFinished, slot0)
end

function slot0._wordByWordFinished(slot0)
	StoryModel.instance:setTextShowing(false)
	TaskDispatcher.cancelTask(slot0._onCheckNext, slot0)

	if not slot0._stepCo then
		return
	end

	TaskDispatcher.runDelay(slot0._onCheckNext, slot0, 1)
end

function slot0._lineShow(slot0, slot1)
	StoryModel.instance:enableClick(false)
	StoryModel.instance:setTextShowing(true)
	StoryController.instance:dispatchEvent(StoryEvent.PlayFullTextLineShow, slot1, slot0._stepCo)
end

function slot0._onFullTextShowFinished(slot0)
	StoryModel.instance:setTextShowing(false)
	TaskDispatcher.cancelTask(slot0._onFullTextFinished, slot0)
	TaskDispatcher.runDelay(slot0._onFullTextFinished, slot0, slot0._stepCo.conversation.keepTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function slot0._onFullTextFinished(slot0)
	StoryModel.instance:enableClick(true)
	TaskDispatcher.cancelTask(slot0._onFullTextFinished, slot0)
	StoryController.instance:dispatchEvent(StoryEvent.PlayFullTextOut)
	slot0:_onConFinished(true)
end

function slot0._onConFinished(slot0, slot1)
	if slot1 then
		slot0:_onAutoDialogFinished()

		return
	end

	if StoryModel.instance:isStoryAuto() then
		if slot0._stepCo.conversation.type == StoryEnum.ConversationType.None or slot0._stepCo.conversation.type == StoryEnum.ConversationType.NoInteract or slot0._stepCo.conversation.type == StoryEnum.ConversationType.ScreenDialog or slot0._stepCo.conversation.type == StoryEnum.ConversationType.IrregularShake then
			return
		end

		if slot0._dialogItem then
			if slot0._dialogItem:isAudioPlaying() then
				slot0._dialogItem:checkAutoEnterNext(slot0._onAutoDialogFinished, slot0)
			else
				slot0:_onAutoDialogFinished()
			end
		end
	end
end

function slot0._onAutoDialogFinished(slot0)
	StoryController.instance:enterNext()
end

function slot0._onEnableClick(slot0)
	if StoryModel.instance:isTextShowing() then
		return
	end

	StoryModel.instance:enableClick(true)
end

function slot0._updateAudioList(slot0, slot1)
	slot2 = {}

	for slot8, slot9 in pairs(StoryModel.instance:getStepLine()) do
		slot4 = 0 + 1
	end

	if slot4 > 1 then
		slot0:stopAllAudio(0)
	end

	slot5 = false

	if slot3[slot0._curStoryId] then
		for slot9, slot10 in ipairs(slot3[slot0._curStoryId]) do
			if slot10.skip then
				slot5 = true

				break
			end
		end
	end

	if slot5 then
		slot0:stopAllAudio(0)
	end

	if slot0._curStoryId and slot0._curStoryId == StoryController.instance._curStoryId and slot0._stepId and slot0._stepId == StoryController.instance._curStepId then
		return
	end

	slot0._audioCo = slot1

	for slot9, slot10 in pairs(slot0._audioCo) do
		if not slot0._audios then
			slot0._audios = {}
		end

		if not slot0._audios[slot10.audio] then
			slot0._audios[slot10.audio] = StoryAudioItem.New()

			slot0._audios[slot10.audio]:init(slot10.audio)
		end

		slot0._audios[slot10.audio]:setAudio(slot10)
	end
end

function slot0.stopAllAudio(slot0, slot1)
	if slot0._audios then
		for slot5, slot6 in pairs(slot0._audios) do
			slot6:stop(slot1)
		end

		slot0._audios = nil
	end
end

function slot0._updateEffectList(slot0, slot1)
	slot2 = {}

	for slot8, slot9 in pairs(StoryModel.instance:getStepLine()) do
		slot4 = 0 + 1
	end

	if slot4 > 1 then
		for slot8, slot9 in pairs(slot0._effects) do
			slot9:onDestroy()
		end
	end

	if slot3[slot0._curStoryId] then
		for slot8, slot9 in ipairs(slot3[slot0._curStoryId]) do
			if slot9.skip and slot9.skip then
				for slot14 = 1, #StoryStepModel.instance:getStepListById(slot9.stepId).effList do
					table.insert(slot2, slot10[slot14])

					if slot10[slot14].orderType == StoryEnum.EffectOrderType.Destroy then
						for slot18 = #slot2, 1, -1 do
							if slot2[slot18].orderType ~= StoryEnum.EffectOrderType.Destroy and slot2[slot18].effect == slot10[slot14].effect then
								table.remove(slot2, #slot2)
								table.remove(slot2, slot18)
							end
						end
					end
				end
			end
		end
	end

	if #slot1 < 1 and #slot2 == 0 then
		return
	end

	slot0._effCo = #slot2 == 0 and slot1 or slot2
	slot5 = false

	for slot9, slot10 in pairs(slot0._effCo) do
		if slot10.orderType ~= StoryEnum.EffectOrderType.Destroy and slot10.layer > 0 then
			slot0:_buildEffect(slot10.effect, slot10)
		else
			slot0:_destroyEffect(slot10.effect, slot10)
		end

		if slot10.layer < 4 then
			slot5 = true
		end
	end

	StoryTool.enablePostProcess(false)

	for slot9, slot10 in pairs(slot0._effects) do
		StoryTool.enablePostProcess(true)
	end

	StoryModel.instance:setHasBottomEffect(slot5)
end

function slot0._buildEffect(slot0, slot1, slot2)
	slot3 = 0
	slot4 = nil

	if slot2.layer < 4 then
		slot4 = slot0._goeff1
		slot3 = 4
	elseif slot2.layer < 7 then
		slot4 = slot0._goeff2
		slot3 = 1000
	elseif slot2.layer < 10 then
		slot4 = slot0._goeff3
		slot3 = 2000
	else
		if not slot0._goeff4 then
			slot0._goeff4 = gohelper.findChild(ViewMgr.instance:getContainer(ViewName.StoryFrontView).viewGO, "#go_frontitem/#go_eff4")
		end

		slot4 = slot0._goeff4
	end

	if not slot0._effects[slot1] then
		slot0._effects[slot1] = StoryEffectItem.New()

		slot0._effects[slot1]:init(slot4, slot1, slot2, slot3)
	else
		slot0._effects[slot1]:reset(slot4, slot2, slot3)
	end
end

function slot0._destroyEffect(slot0, slot1, slot2)
	if not slot0._effects[slot1] then
		return
	end

	slot0._effects[slot1]:destroyEffect(slot2, {
		callback = slot0._effectRealDestroy,
		callbackObj = slot0
	})
end

function slot0._effectRealDestroy(slot0, slot1)
	slot0._effects[slot1] = nil
end

function slot0._updatePictureList(slot0, slot1)
	slot2 = {}

	for slot8, slot9 in pairs(StoryModel.instance:getStepLine()) do
		slot4 = 0 + 1
	end

	if slot4 > 1 then
		for slot8, slot9 in pairs(slot0._pictures) do
			slot9:onDestroy()
		end
	end

	slot5 = false

	if slot3[slot0._curStoryId] then
		for slot9, slot10 in ipairs(slot3[slot0._curStoryId]) do
			slot11 = StoryStepModel.instance:getStepListById(slot10.stepId).picList

			if slot10.skip then
				slot5 = true

				for slot15 = 1, #slot11 do
					table.insert(slot2, slot11[slot15])

					if slot11[slot15].orderType == StoryEnum.PictureOrderType.Destroy then
						for slot19 = #slot2, 1, -1 do
							if slot2[slot19].orderType == StoryEnum.PictureOrderType.Produce and slot2[slot19].picture == slot11[slot15].picture then
								table.remove(slot2, #slot2)
								table.remove(slot2, slot19)
							end
						end
					end
				end
			end
		end
	end

	slot0:_resetStepPictures()

	if #slot1 < 1 and #slot2 == 0 then
		return
	end

	slot0._picCo = #slot2 > 0 and slot2 or slot1

	for slot9, slot10 in pairs(slot0._picCo) do
		if slot10.orderType == StoryEnum.PictureOrderType.Produce and slot10.layer > 0 then
			slot0:_buildPicture(slot10.picType == StoryEnum.PictureType.FullScreen and "fullfocusitem" or slot10.picture, slot10, slot5)
		else
			slot0:_destroyPicture(slot11, slot10, slot5)
		end
	end

	slot0:_checkFloatBgShow()
end

function slot0._resetStepPictures(slot0)
	for slot4, slot5 in pairs(slot0._pictures) do
		slot5:resetStep()
	end
end

function slot0._checkFloatBgShow(slot0)
	ZProj.TweenHelper.KillByObj(slot0._imagefullbottom)

	for slot4, slot5 in pairs(slot0._pictures) do
		if slot5:isFloatType() then
			gohelper.setActive(slot0._imagefullbottom.gameObject, true)
			ZProj.TweenHelper.DoFade(slot0._imagefullbottom, slot0._imagefullbottom.color.a, slot0._initFullBottomAlpha, 0.1, nil, , , EaseType.Linear)

			return
		end
	end

	slot1 = 0

	for slot5, slot6 in pairs(slot0._picCo) do
		if slot6.orderType == StoryEnum.PictureOrderType.Destroy and slot6.layer > 0 and slot6.picType == StoryEnum.PictureType.Float and slot1 < slot6.outTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] then
			slot1 = slot6.outTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] or slot1
		end
	end

	for slot5, slot6 in pairs(slot0._picCo) do
		if slot6.orderType == StoryEnum.PictureOrderType.Produce and slot6.layer > 0 and slot6.picType == StoryEnum.PictureType.Float then
			slot1 = 0
		end
	end

	if slot1 < 0.01 then
		gohelper.setActive(slot0._imagefullbottom.gameObject, false)
	else
		gohelper.setActive(slot0._imagefullbottom.gameObject, true)
		ZProj.TweenHelper.DoFade(slot0._imagefullbottom, slot0._initFullBottomAlpha, 0, slot1, function ()
			gohelper.setActive(uv0._imagefullbottom.gameObject, false)
		end, nil, , EaseType.Linear)
	end
end

function slot0._buildPicture(slot0, slot1, slot2, slot3)
	slot4 = nil

	if slot2.layer < 4 then
		slot4 = slot0._goimg1
	elseif slot2.layer < 7 then
		slot4 = slot0._goimg2
	elseif slot2.layer < 10 then
		slot4 = slot0._goimg3
	else
		if not slot0._goimg4 then
			slot0._goimg4 = gohelper.findChild(ViewMgr.instance:getContainer(ViewName.StoryFrontView).viewGO, "#go_frontitem/#go_img4")
		end

		slot4 = slot0._goimg4
	end

	if not slot0._pictures[slot1] then
		slot0._pictures[slot1] = StoryPictureItem.New()

		slot0._pictures[slot1]:init(slot4, slot1, slot2)
	elseif not slot3 then
		slot0._pictures[slot1]:reset(slot4, slot2)
	end
end

function slot0._destroyPicture(slot0, slot1, slot2, slot3)
	if not slot0._pictures[slot1] then
		if slot3 then
			slot0:_buildPicture(slot1, slot2, slot3)
			TaskDispatcher.runDelay(function ()
				slot0 = 0

				for slot5, slot6 in pairs(uv0._stepCo.videoList) do
					if slot6.orderType == StoryEnum.VideoOrderType.Produce then
						slot0 = 0.5
					end
				end

				uv0._pictures[uv1]:destroyPicture(uv2, uv3, slot0)

				uv0._pictures[uv1] = nil
			end, nil, 0.2)
		end

		return
	end

	slot4 = 0

	for slot9, slot10 in pairs(slot0._stepCo.videoList) do
		if slot10.orderType == StoryEnum.VideoOrderType.Produce then
			slot4 = 0.5
		end
	end

	slot0._pictures[slot1]:destroyPicture(slot2, slot3, slot4)

	slot0._pictures[slot1] = nil
end

function slot0._updateNavigateList(slot0, slot1)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshNavigate, slot1)
end

function slot0._updateVideoList(slot0, slot1)
	slot0._videoCo = slot1
	slot2 = false

	slot0:_checkCreatePlayList()

	for slot6, slot7 in pairs(slot0._videoCo) do
		if slot7.orderType == StoryEnum.VideoOrderType.Produce then
			slot0:_buildVideo(slot7.video, slot7)
		elseif slot7.orderType == StoryEnum.VideoOrderType.Destroy then
			slot0:_destroyVideo(slot7.video, slot7)
		elseif slot7.orderType == StoryEnum.VideoOrderType.Pause then
			slot0._videos[slot7.video]:pause(true)
		else
			slot0._videos[slot7.video]:pause(false)
		end
	end

	for slot6, slot7 in pairs(slot0._videoCo) do
		if slot7.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 and (slot7.orderType == StoryEnum.VideoOrderType.Produce or slot7.orderType == StoryEnum.VideoOrderType.Pause or slot7.orderType == StoryEnum.VideoOrderType.Restart) then
			slot2 = true
		end
	end

	if not slot2 then
		StoryController.instance:dispatchEvent(StoryEvent.ShowBackground)
	end
end

function slot0._videoStarted(slot0, slot1)
	for slot5, slot6 in pairs(slot0._videos) do
		if slot6 ~= slot1 then
			slot6:pause(true)
		end
	end
end

function slot0._buildVideo(slot0, slot1, slot2)
	slot0:_checkCreatePlayList()

	slot3 = nil

	if not slot0._videos[slot1] then
		slot0._videos[slot1] = StoryVideoItem.New()

		slot0._videos[slot1]:init((slot2.layer >= 4 or slot0._govideo1) and (slot2.layer >= 7 or slot0._govideo2) and slot0._govideo3, slot1, slot2, slot0._videoStarted, slot0, slot0._videoPlayList)
	else
		slot0._videos[slot1]:reset(slot3, slot2)
	end
end

function slot0._destroyVideo(slot0, slot1, slot2)
	if not slot0._videos[slot1] then
		return
	end

	slot0._videos[slot1]:destroyVideo(slot2)

	slot0._videos[slot1] = nil
end

function slot0._checkCreatePlayList(slot0)
	if not slot0._videoPlayList then
		slot0._videoPlayList = StoryVideoPlayList.New()

		slot0._videoPlayList:init(slot0:getResInst(AvProMgr.instance:getStoryUrl(), slot0.viewGO, "play_list"), slot0.viewGO)
	end
end

function slot0._checkDisposePlayList(slot0)
	if slot0._videoPlayList then
		slot0._videoPlayList:dispose()

		slot0._videoPlayList = nil
	end
end

function slot0._updateOptionList(slot0, slot1)
	slot0._optCo = slot1
end

function slot0._clearItems(slot0, slot1)
	slot0:_clearAllTimers()
	TaskDispatcher.cancelTask(slot0._viewFadeIn, slot0)
	TaskDispatcher.cancelTask(slot0._enterNextStep, slot0)

	for slot5, slot6 in pairs(slot0._pictures) do
		slot6:onDestroy()
	end

	slot0._pictures = {}

	for slot5, slot6 in pairs(slot0._effects) do
		slot6:onDestroy()
	end

	slot0._effects = {}

	for slot5, slot6 in pairs(slot0._videos) do
		slot6:onDestroy()
	end

	slot0._videos = {}

	slot0:_checkDisposePlayList()
end

function slot0.onDestroyView(slot0)
	if ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
		ViewMgr.instance:closeView(ViewName.MessageBoxView, true)
	end

	if slot0._confadeId then
		ZProj.TweenHelper.KillById(slot0._confadeId)

		slot0._confadeId = nil
	end

	ZProj.TweenHelper.KillByObj(slot0._imagefullbottom)
	slot0:_checkDisposePlayList()
	TaskDispatcher.cancelTask(slot0._conShowIn, slot0)
	TaskDispatcher.cancelTask(slot0._startShowText, slot0)
	TaskDispatcher.cancelTask(slot0._enterNextStep, slot0)
	TaskDispatcher.cancelTask(slot0._onFullTextFinished, slot0)
	TaskDispatcher.cancelTask(slot0._startShake, slot0)
	TaskDispatcher.cancelTask(slot0._guaranteeEnterNextStep, slot0)
	TaskDispatcher.cancelTask(slot0._shakeStop, slot0)
	StoryTool.enablePostProcess(false)
	ViewMgr.instance:closeView(ViewName.StoryFrontView, nil, true)
	slot0._simagehead:UnLoadImage()
	StoryController.instance:stopPlotMusic()

	slot0._bgAudio = nil

	slot0:stopAllAudio(0)

	if slot0._dialogItem then
		slot0._dialogItem:destroy()

		slot0._dialogItem = nil
	end
end

return slot0
