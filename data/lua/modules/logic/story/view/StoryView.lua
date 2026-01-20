-- chunkname: @modules/logic/story/view/StoryView.lua

module("modules.logic.story.view.StoryView", package.seeall)

local StoryView = class("StoryView", BaseView)

function StoryView:_clearAllTimers()
	TaskDispatcher.cancelTask(self._conShowIn, self)
	TaskDispatcher.cancelTask(self._onEnableClick, self)
	TaskDispatcher.cancelTask(self._enterNextStep, self)
	TaskDispatcher.cancelTask(self._onFullTextFinished, self)
	TaskDispatcher.cancelTask(self._startShowText, self)
	TaskDispatcher.cancelTask(self._onCheckNext, self)
	TaskDispatcher.cancelTask(self._guaranteeEnterNextStep, self)
	TaskDispatcher.cancelTask(self._playShowHero, self)
	TaskDispatcher.cancelTask(self._startShake, self)
	TaskDispatcher.cancelTask(self._shakeStop, self)
	TaskDispatcher.cancelTask(self._viewFadeIn, self)
end

function StoryView:onInitView()
	self._imagefullbottom = gohelper.findChildImage(self.viewGO, "#image_fullbottom")
	self._gomiddle = gohelper.findChild(self.viewGO, "#go_middle")
	self._goimg2 = gohelper.findChild(self.viewGO, "#go_middle/#go_img2")
	self._govideo2 = gohelper.findChild(self.viewGO, "#go_middle/#go_video2")
	self._goeff2 = gohelper.findChild(self.viewGO, "#go_middle/#go_eff2")
	self._gocontentroot = gohelper.findChild(self.viewGO, "#go_contentroot")
	self._gonexticon = gohelper.findChild(self.viewGO, "#go_contentroot/nexticon")
	self._goconversation = gohelper.findChild(self.viewGO, "#go_contentroot/#go_conversation")
	self._goblackbottom = gohelper.findChild(self.viewGO, "#go_contentroot/#go_conversation/content/blackBottom")
	self._gohead = gohelper.findChild(self.viewGO, "#go_contentroot/#go_conversation/#go_contents/content/#go_head")
	self._goheadgrey = gohelper.findChild(self.viewGO, "#go_contentroot/#go_conversation/#go_contents/content/#go_head/#go_headgrey")
	self._simagehead = gohelper.findChildSingleImage(self.viewGO, "#go_contentroot/#go_conversation/#go_contents/content/#go_head/#simage_head")
	self._gospine = gohelper.findChild(self.viewGO, "#go_contentroot/#go_conversation/#go_contents/content/#go_spine")
	self._gospineobj = gohelper.findChild(self.viewGO, "#go_contentroot/#go_conversation/#go_contents/content/#go_spine/mask/#go_spineobj")
	self._goname = gohelper.findChild(self.viewGO, "#go_contentroot/#go_conversation/#go_contents/content/#go_name")
	self._gonamebg = gohelper.findChild(self.viewGO, "#go_contentroot/#go_conversation/#go_contents/content/#go_name/#go_namebg")
	self._txtnamecn1 = gohelper.findChildText(self.viewGO, "#go_contentroot/#go_conversation/#go_contents/content/#go_name/namelayout/#txt_namecn1")
	self._txtnamecn2 = gohelper.findChildText(self.viewGO, "#go_contentroot/#go_conversation/#go_contents/content/#go_name/namelayout/#txt_namecn2")
	self._txtnameen = gohelper.findChildText(self.viewGO, "#go_contentroot/#go_conversation/#go_contents/content/#go_name/namelayout/#txt_nameen")
	self._gocontents = gohelper.findChild(self.viewGO, "#go_contentroot/#go_conversation/#go_contents")
	self._gonoconversation = gohelper.findChild(self.viewGO, "#go_contentroot/#go_noconversation")
	self._gotop = gohelper.findChild(self.viewGO, "#go_top")
	self._goimg3 = gohelper.findChild(self.viewGO, "#go_top/#go_img3")
	self._govideo3 = gohelper.findChild(self.viewGO, "#go_top/#go_video3")
	self._goeff3 = gohelper.findChild(self.viewGO, "#go_top/#go_eff3")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoryView:addEvents()
	return
end

function StoryView:removeEvents()
	return
end

function StoryView:_btnnextOnClick()
	if StoryModel.instance:isViewHide() then
		StoryModel.instance:setViewHide(false)
		gohelper.setActive(self._gocontentroot, StoryModel.instance:isNormalStep())
		StoryController.instance:dispatchEvent(StoryEvent.LeadRoleViewShow, StoryModel.instance:isNormalStep())

		return
	end

	if StoryModel.instance:isStoryAuto() then
		return
	end

	if not self._stepCo then
		return
	end

	if self:_isUnInteractType() then
		return
	end

	if StoryModel.instance:isNormalStep() then
		if StoryModel.instance:isTextShowing() then
			self._dialogItem:conFinished()
			self:_conFinished()
		else
			self:_enterNextStep()
		end
	end
end

function StoryView:_isUnInteractType()
	if not self._stepCo then
		return true
	end

	if self._stepCo.conversation.type == StoryEnum.ConversationType.None then
		return true
	end

	if self._stepCo.conversation.type == StoryEnum.ConversationType.NoInteract then
		return true
	end

	if self._stepCo.conversation.type == StoryEnum.ConversationType.ScreenDialog then
		return true
	end

	if self._stepCo.conversation.type == StoryEnum.ConversationType.IrregularShake then
		return true
	end

	local isLimitNoInteractLock = StoryModel.instance:isLimitNoInteractLock(self._stepCo)

	if isLimitNoInteractLock then
		return true
	end

	return false
end

function StoryView:_btnhideOnClick()
	StoryController.instance:dispatchEvent(StoryEvent.LeadRoleViewShow, false)
	gohelper.setActive(self._gocontentroot, false)
end

function StoryView:_btnlogOnClick()
	StoryController.instance:openStoryLogView()
end

function StoryView:_btnautoOnClick()
	if not self._stepCo then
		return
	end

	if not self:_isUnInteractType() then
		self._dialogItem:startAutoEnterNext()
	end
end

function StoryView:_btnskipOnClick(isSkipAll)
	if not isSkipAll and not StoryModel.instance:isNormalStep() then
		return
	end

	StoryTool.enablePostProcess(true)

	if self._curStoryId == SDKMediaEventEnum.FirstStoryId then
		local playerPrefsKey = string.format(PlayerPrefsKey.SDKDataTrackMgr_MediaEvent_first_story_skip, PlayerModel.instance:getMyUserId())

		if PlayerPrefsHelper.getNumber(playerPrefsKey, 0) == 0 then
			SDKDataTrackMgr.instance:trackMediaEvent(SDKDataTrackMgr.MediaEvent.first_story_skip)
			PlayerPrefsHelper.setNumber(playerPrefsKey, 1)
		end
	end

	self:_skipStep(isSkipAll)
end

function StoryView:_editableInitView()
	self:_initData()
	self:_initView()
end

function StoryView:addEvent()
	self:addEventCb(StoryController.instance, StoryEvent.RefreshStep, self._onUpdateUI, self)
	self:addEventCb(StoryController.instance, StoryEvent.AllStepFinished, self._storyFinished, self)
	self:addEventCb(StoryController.instance, StoryEvent.RefreshView, self._refreshView, self)
	self:addEventCb(StoryController.instance, StoryEvent.RefreshConversation, self._updateConversation, self)
	self:addEventCb(StoryController.instance, StoryEvent.Log, self._btnlogOnClick, self)
	self:addEventCb(StoryController.instance, StoryEvent.Hide, self._btnhideOnClick, self)
	self:addEventCb(StoryController.instance, StoryEvent.Auto, self._btnautoOnClick, self)
	self:addEventCb(StoryController.instance, StoryEvent.Skip, self._btnskipOnClick, self)
	self:addEventCb(StoryController.instance, StoryEvent.PvPause, self._btnPvPauseOnClick, self)
	self:addEventCb(StoryController.instance, StoryEvent.PvPlay, self._btnPvPlayOnClick, self)
	self:addEventCb(StoryController.instance, StoryEvent.EnterNextStep, self._btnnextOnClick, self)
	self:addEventCb(StoryController.instance, StoryEvent.Finish, self._clearItems, self)
	self:addEventCb(StoryController.instance, StoryEvent.FullTextLineShowFinished, self._onFullTextShowFinished, self)
	self:addEventCb(StoryController.instance, StoryEvent.HideDialog, self._hideDialog, self)
	self:addEventCb(StoryController.instance, StoryEvent.DialogConFinished, self._dialogConFinished, self)
	self:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function StoryView:removeEvent()
	self:removeEventCb(StoryController.instance, StoryEvent.RefreshStep, self._onUpdateUI, self)
	self:removeEventCb(StoryController.instance, StoryEvent.AllStepFinished, self._storyFinished, self)
	self:removeEventCb(StoryController.instance, StoryEvent.RefreshView, self._refreshView, self)
	self:removeEventCb(StoryController.instance, StoryEvent.RefreshConversation, self._updateConversation, self)
	self:removeEventCb(StoryController.instance, StoryEvent.Log, self._btnlogOnClick, self)
	self:removeEventCb(StoryController.instance, StoryEvent.Hide, self._btnhideOnClick, self)
	self:removeEventCb(StoryController.instance, StoryEvent.Auto, self._btnautoOnClick, self)
	self:removeEventCb(StoryController.instance, StoryEvent.Skip, self._btnskipOnClick, self)
	self:removeEventCb(StoryController.instance, StoryEvent.PvPause, self._btnPvPauseOnClick, self)
	self:removeEventCb(StoryController.instance, StoryEvent.PvPlay, self._btnPvPlayOnClick, self)
	self:removeEventCb(StoryController.instance, StoryEvent.EnterNextStep, self._btnnextOnClick, self)
	self:removeEventCb(StoryController.instance, StoryEvent.Finish, self._clearItems, self)
	self:removeEventCb(StoryController.instance, StoryEvent.FullTextLineShowFinished, self._onFullTextShowFinished, self)
	self:removeEventCb(StoryController.instance, StoryEvent.HideDialog, self._hideDialog, self)
	self:removeEventCb(StoryController.instance, StoryEvent.DialogConFinished, self._dialogConFinished, self)
	self:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, self._onCloseViewFinish, self)
end

function StoryView:_onCloseViewFinish(viewName)
	if self._effects then
		for _, v in pairs(self._effects) do
			StoryTool.enablePostProcess(true)

			return
		end
	end
end

function StoryView:_btnPvPauseOnClick()
	for _, videoItem in pairs(self._videos) do
		videoItem:pause(true)
	end
end

function StoryView:_btnPvPlayOnClick()
	for _, videoItem in pairs(self._videos) do
		videoItem:pause(false)
	end
end

function StoryView:_initData()
	self._stepId = 0
	self._audios = {}
	self._pictures = {}
	self._effects = {}
	self._videos = {}
	self._initFullBottomAlpha = self._imagefullbottom.color.a

	StoryModel.instance:resetStoryState()
end

function StoryView:_initView()
	self._conCanvasGroup = self._gocontentroot:GetComponent(typeof(UnityEngine.CanvasGroup))
	self._contentAnimator = self._goconversation:GetComponent(typeof(UnityEngine.Animator))

	local bgGo = ViewMgr.instance:getContainer(ViewName.StoryBackgroundView).viewGO

	self._gobottom = gohelper.findChild(bgGo, "#go_bottomitem")
	self._goimg1 = gohelper.findChild(bgGo, "#go_bottomitem/#go_img1")
	self._govideo1 = gohelper.findChild(bgGo, "#go_bottomitem/#go_video1")
	self._goeff1 = gohelper.findChild(bgGo, "#go_bottomitem/#go_eff1")

	gohelper.setActive(self._gocontentroot, false)
	self:_initItems()
end

function StoryView:onOpen()
	self:addEvent()
	ViewMgr.instance:openView(ViewName.StoryFrontView, nil, true)
	gohelper.setActive(self.viewGO, true)
	SpineFpsMgr.instance:set(SpineFpsMgr.Story)

	if UnityEngine.Shader.IsKeywordEnabled("_MAININTERFACELIGHT") then
		self._keywordEnable = true

		UnityEngine.Shader.DisableKeyword("_MAININTERFACELIGHT")
	end

	self:_clearItems()
end

function StoryView:_initItems()
	if not self._dialogItem then
		self._dialogItem = StoryDialogItem.New()

		self._dialogItem:init(self._gocontentroot)
		self._dialogItem:hideDialog()
	end
end

function StoryView:_hideDialog()
	if self._dialogItem then
		if StoryModel.instance:isTextShowing() then
			self._dialogItem:conFinished()
			self:_conFinished()
		end

		gohelper.setActive(self._gocontentroot, false)
	end
end

function StoryView:_dialogConFinished()
	if self._dialogItem and StoryModel.instance:isTextShowing() then
		self._dialogItem:conFinished()
		self:_conFinished()
	end
end

function StoryView:_storyFinished(isSkip)
	self:_clearAllTimers()

	self._stepId = 0
	self._finished = true
	self._stepCo = nil

	TaskDispatcher.cancelTask(self._onCheckNext, self)
	self._dialogItem:storyFinished()
	StoryModel.instance:enableClick(false)

	if self._dialogItem then
		self._dialogItem:stopConAudio()
	end

	if StoryController.instance._hideStartAndEndDark then
		self:stopAllAudio(1.5)
		gohelper.setActive(self._gospine, false)

		if self._confadeId then
			ZProj.TweenHelper.KillById(self._confadeId)
		end

		self._confadeId = ZProj.TweenHelper.DOFadeCanvasGroup(self._gocontentroot, 1, 0, 0.35, nil, nil, nil, EaseType.Linear)

		return
	end

	local skip = StoryModel.instance:isTypeSkip(StoryEnum.SkipType.OutDarkFade, StoryModel.instance:getCurStoryId())

	if skip then
		return
	end

	self:stopAllAudio(1.5)
end

function StoryView:onClose()
	self:_clearAllTimers()

	if not self._finished then
		self:stopAllAudio(0)
	end

	if self._keywordEnable then
		UnityEngine.Shader.EnableKeyword("_MAININTERFACELIGHT")
	end

	self:removeEvent()
	TaskDispatcher.cancelTask(self._viewFadeIn, self)
	self:_clearItems()
	SpineFpsMgr.instance:remove(SpineFpsMgr.Story)
end

function StoryView:onUpdateParam()
	return
end

function StoryView:_enterNextStep()
	StoryController.instance:dispatchEvent(StoryEvent.PlayFullTextOut)

	if self._diaLineTxt and self._diaLineTxt[2] then
		local x1, y1, z1 = transformhelper.getLocalPos(self._diaLineTxt[2].transform)

		transformhelper.setLocalPos(self._diaLineTxt[2].transform, x1, y1, 1)
	end

	TaskDispatcher.cancelTask(self._enterNextStep, self)
	TaskDispatcher.cancelTask(self._guaranteeEnterNextStep, self)
	StoryController.instance:enterNext()
end

function StoryView:_guaranteeEnterNextStep()
	self:_enterNextStep()
end

function StoryView:_skipStep(isSkipAll)
	StoryModel.instance:enableClick(false)
	TaskDispatcher.cancelTask(self._enterNextStep, self)
	TaskDispatcher.cancelTask(self._playShowHero, self)

	if isSkipAll then
		StoryController.instance:skipAllStory()
	else
		StoryController.instance:skipStory()
	end
end

function StoryView:_onCheckNext()
	self:_onConFinished(self._stepCo.conversation.isAuto)
end

function StoryView:_onUpdateUI(param)
	self._finished = false

	StoryModel.instance:setStepNormal(param.stepType == StoryEnum.StepType.Normal)

	if self._gocontentroot.activeSelf ~= StoryModel.instance:isNormalStep() then
		gohelper.setActive(self._gocontentroot, not StoryModel.instance:isNormalStep())
		StoryController.instance:dispatchEvent(StoryEvent.LeadRoleViewShow, not StoryModel.instance:isNormalStep())
	end

	if self._curStoryId ~= param.storyId and #param.branches < 1 then
		self:_clearItems()

		self._curStoryId = param.storyId
	end

	self:_updateStep(param.stepId)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshHero, param)

	if #param.branches > 0 then
		StoryController.instance:openStoryBranchView(param.branches)
		self:_showBranchLeadHero()
	else
		gohelper.setActive(self._gonoconversation, false)
	end

	StoryModel.instance:clearStepLine()
end

function StoryView:_showBranchLeadHero()
	self._dialogItem:hideDialog()
	self._dialogItem:stopConAudio()

	if self._confadeId then
		ZProj.TweenHelper.KillById(self._confadeId)
	end

	TaskDispatcher.cancelTask(self._conShowIn, self)
	TaskDispatcher.cancelTask(self._startShowText, self)
	TaskDispatcher.cancelTask(self._startShake, self)
	TaskDispatcher.cancelTask(self._shakeStop, self)
	TaskDispatcher.cancelTask(self._enterNextStep, self)

	self._conCanvasGroup.alpha = 1

	gohelper.setActive(self._goname, true)
	gohelper.setActive(self._txtnameen.gameObject, true)
	gohelper.setActive(self._gocontentroot, true)
	gohelper.setActive(self._gonoconversation, true)

	local normalOptionParam

	for _, v in pairs(self._stepCo.optList) do
		if v.condition and v.conditionType == StoryEnum.OptionConditionType.NormalLead then
			self:_showNormalLeadHero(v)

			return
		elseif v.condition and v.conditionType == StoryEnum.OptionConditionType.MainSpine then
			self:_showSpineLeadHero(v)

			return
		end
	end

	self:_showSpineLeadHero()
end

function StoryView:_showNormalLeadHero(param)
	gohelper.setActive(self._gohead, true)
	gohelper.setActive(self._gospine, false)

	local name = param.conditionValue2[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]
	local nameEn = param.conditionValue2[LanguageEnum.LanguageStoryType.EN]

	self:_showHeadContentTxt(name, nameEn)
	self:_showHeadContentIcon(param.conditionValue)
end

function StoryView:_showSpineLeadHero(param)
	local heroIcon = param and string.split(param.conditionValue, ".")[1] or nil

	StoryController.instance:dispatchEvent(StoryEvent.LeadRoleViewShow, true, heroIcon)
	gohelper.setActive(self._gohead, false)
	gohelper.setActive(self._gospine, true)

	self._txtnamecn1.text = luaLang("mainrolename")
	self._txtnamecn2.text = luaLang("mainrolename")
	self._txtnameen.text = "<voffset=4>/ </voffset>Vertin"

	if param then
		return
	end

	local spineType = 1

	if self._stepCo and self._stepCo.optList[1] and self._stepCo.optList[1].feedbackType == StoryEnum.OptionFeedbackType.HeroLead then
		spineType = self._stepCo.optList[1].feedbackValue ~= "" and tonumber(self._stepCo.optList[1].feedbackValue) or 1
	end

	StoryController.instance:dispatchEvent(StoryEvent.ShowLeadRole, self._stepCo, true, false, false, spineType)
	gohelper.setActive(self._txtnamecn1.gameObject, true)
	gohelper.setActive(self._txtnamecn2.gameObject, false)

	if GameLanguageMgr.instance:getLanguageTypeStoryIndex() ~= LanguageEnum.LanguageStoryType.EN then
		self._txtnameen.text = "<voffset=4>/ </voffset>Vertin"

		gohelper.setActive(self._txtnameen.gameObject, true)
	else
		self._txtnameen.text = ""

		gohelper.setActive(self._txtnameen.gameObject, false)
	end
end

function StoryView:_updateStep(stepId)
	if not StoryModel.instance:isNormalStep() then
		return
	end

	self._stepCo = StoryStepModel.instance:getStepListById(stepId)

	if self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.SoftLight then
		gohelper.setActive(self._goline, false)
		gohelper.setActive(self._gonexticon, false)
		gohelper.setActive(self._goblackbottom, false)
	else
		gohelper.setActive(self._goline, true)
		gohelper.setActive(self._gonexticon, true)
		gohelper.setActive(self._goblackbottom, true)
	end

	if self._stepCo.bg.transType ~= StoryEnum.BgTransType.DarkFade and self._stepCo.bg.transType ~= StoryEnum.BgTransType.WhiteFade then
		self:_refreshView()
	else
		self:_updateEffectList(self._stepCo.effList)
		self:_updateAudioList(self._stepCo.audioList)
	end
end

function StoryView:_refreshView()
	self:_updateEffectList(self._stepCo.effList)
	self:_updateAudioList(self._stepCo.audioList)
	self:_updatePictureList(self._stepCo.picList)
	self:_updateVideoList(self._stepCo.videoList)
	self:_updateNavigateList(self._stepCo.navigateList)
	self:_updateOptionList(self._stepCo.optList)
end

function StoryView:_updateConversation()
	if not self._stepCo then
		return
	end

	if not self._stepId then
		self._stepId = 0

		return
	end

	if self._storyId and self._storyId == self._curStoryId and self._stepId == self._stepCo.id then
		self._stepId = 0

		return
	end

	StoryModel.instance:enableClick(false)

	self._stepId = self._stepCo.id
	self._storyId = self._curStoryId

	if self._confadeId then
		ZProj.TweenHelper.KillById(self._confadeId)
	end

	TaskDispatcher.cancelTask(self._conShowIn, self)
	TaskDispatcher.cancelTask(self._onEnableClick, self)
	TaskDispatcher.cancelTask(self._enterNextStep, self)
	TaskDispatcher.cancelTask(self._onFullTextKeepFinished, self)
	TaskDispatcher.cancelTask(self._startShowText, self)
	TaskDispatcher.cancelTask(self._onCheckNext, self)

	if self._stepCo.conversation.type ~= StoryEnum.ConversationType.None then
		StoryModel.instance:setTextShowing(true)
	end

	if StoryModel.instance:isNeedFadeOut() then
		if self._gospine.activeSelf then
			StoryController.instance:dispatchEvent(StoryEvent.ShowLeadRole, self._stepCo, true, false, true)
		end

		self._confadeId = ZProj.TweenHelper.DOFadeCanvasGroup(self._gocontentroot, 1, 0, 0.35, nil, nil, nil, EaseType.Linear)

		if not StoryModel.instance:isPlayFinished() then
			TaskDispatcher.runDelay(self._conShowIn, self, 0.35)
		end
	else
		self:_conShowIn()
	end
end

function StoryView:_conShowIn()
	if not self._stepCo then
		return
	end

	self._diatxt = StoryTool.getFilterDia(self._stepCo.conversation.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()])

	self._dialogItem:hideDialog()
	TaskDispatcher.cancelTask(self._enterNextStep, self)
	TaskDispatcher.cancelTask(self._onFullTextKeepFinished, self)
	TaskDispatcher.cancelTask(self._guaranteeEnterNextStep, self)
	TaskDispatcher.cancelTask(self._onFullTextFinished, self)
	TaskDispatcher.cancelTask(self._startShowText, self)

	if self._stepCo.conversation.type == StoryEnum.ConversationType.None then
		self:_showConversationItem(false)
		TaskDispatcher.runDelay(self._guaranteeEnterNextStep, self, self._stepCo.conversation.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] + 0.2)
		TaskDispatcher.runDelay(self._enterNextStep, self, self._stepCo.conversation.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	else
		StoryController.instance:dispatchEvent(StoryEvent.SetFullText, "")
		StoryModel.instance:setLimitNoInteractLock(false)

		if self._stepCo.conversation.type == StoryEnum.ConversationType.NoInteract then
			StoryModel.instance:enableClick(false)
			TaskDispatcher.runDelay(self._guaranteeEnterNextStep, self, self._stepCo.conversation.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] + 0.2)
			TaskDispatcher.runDelay(self._enterNextStep, self, self._stepCo.conversation.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
		elseif self._stepCo.conversation.type == StoryEnum.ConversationType.LimitNoInteract then
			StoryModel.instance:setLimitNoInteractLock(true)
			StoryModel.instance:enableClick(false)
			TaskDispatcher.runDelay(self._onLimitNoInteractFinished, self, self._stepCo.conversation.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
		end

		self:_showConversationItem(true)
	end

	if StoryModel.instance:isNeedFadeIn() then
		if self._gospine.activeSelf then
			StoryController.instance:dispatchEvent(StoryEvent.ShowLeadRole, self._stepCo, true, true, false)
		end

		self._confadeId = ZProj.TweenHelper.DOFadeCanvasGroup(self._gocontentroot, 0, 1, 0.5, nil, nil, nil, EaseType.Linear)

		TaskDispatcher.runDelay(self._startShowText, self, 0.5)
	else
		self:_startShowText()
	end
end

function StoryView:_onLimitNoInteractFinished()
	StoryModel.instance:setLimitNoInteractLock(false)
	StoryModel.instance:enableClick(true)

	local isAuto = StoryModel.instance:isStoryAuto()
	local isTextShowing = StoryModel.instance:isTextShowing()

	if isAuto and not isTextShowing then
		self:_enterNextStep()
	end
end

function StoryView:_startShowText()
	if not self._stepCo then
		return
	end

	self._conCanvasGroup.alpha = 1

	if self._stepCo.conversation.effType ~= StoryEnum.ConversationEffectType.Shake then
		StoryController.instance:dispatchEvent(StoryEvent.ConversationShake, self._stepCo, 0, true)
		TaskDispatcher.cancelTask(self._startShake, self)
		TaskDispatcher.cancelTask(self._shakeStop, self)
		self._contentAnimator:Play(UIAnimationName.Idle)
	end

	self:_showText()
end

function StoryView:_showConversationItem(show)
	local isShowContentText = self._stepCo.conversation.type ~= StoryEnum.ConversationType.ScreenDialog and self._stepCo.conversation.type ~= StoryEnum.ConversationType.IrregularShake
	local isSlideDialog = self._stepCo.conversation.type == StoryEnum.ConversationType.SlideDialog

	if not show then
		gohelper.setActive(self._gocontentroot, false)
		self._simagehead:UnLoadImage()
		StoryController.instance:dispatchEvent(StoryEvent.LeadRoleViewShow, false)

		return
	end

	StoryController.instance:dispatchEvent(StoryEvent.SetFullText, self._diatxt)
	gohelper.setActive(self._gobtns, isShowContentText)
	gohelper.setActive(self._gocontentroot, isShowContentText)
	gohelper.setActive(self._goconversation, not isSlideDialog)
	StoryController.instance:dispatchEvent(StoryEvent.LeadRoleViewShow, isShowContentText)

	local name = self._stepCo.conversation.heroNames[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]
	local nameEn = self._stepCo.conversation.heroNames[LanguageEnum.LanguageStoryType.EN]

	self:_showHeadContentTxt(name, nameEn)
	gohelper.setActive(self._goname, self._stepCo.conversation.nameShow)

	local isNumberName = tonumber(self._stepCo.conversation.heroNames[LanguageEnum.LanguageStoryType.CN])
	local enShow = self._stepCo.conversation.nameEnShow

	if isNumberName and GameLanguageMgr.instance:getLanguageTypeStoryIndex() == LanguageEnum.LanguageStoryType.EN then
		enShow = false
	end

	gohelper.setActive(self._txtnameen.gameObject, enShow)

	if not self._stepCo.conversation.iconShow then
		gohelper.setActive(self._gohead, false)
		gohelper.setActive(self._gospine, false)
		gohelper.setActive(self._gonamebg, false)
		self._simagehead:UnLoadImage()
		StoryController.instance:dispatchEvent(StoryEvent.ShowLeadRole, self._stepCo, false, false, false)

		return
	end

	self:_showHeadContentIcon(self._stepCo.conversation.heroIcon)
end

function StoryView:_showHeadContentTxt(name, nameEn)
	local hasQuestion = string.match(name, "[^?]") == nil

	gohelper.setActive(self._txtnamecn1.gameObject, not hasQuestion)
	gohelper.setActive(self._txtnamecn2.gameObject, hasQuestion)

	if hasQuestion then
		self._txtnamecn2.text = string.split(name, "_")[1]
	else
		self._txtnamecn1.text = string.split(name, "_")[1]
	end

	local isNumberName = tonumber(self._stepCo.conversation.heroNames[LanguageEnum.LanguageStoryType.CN])
	local filterStr = isNumberName and StoryTool.FilterStrByPatterns(name, {
		"%a",
		"%s",
		"%p"
	}) or StoryTool.FilterStrByPatterns(name, {
		"%w",
		"%s",
		"%p"
	})

	if filterStr ~= "" and GameLanguageMgr.instance:getLanguageTypeStoryIndex() ~= LanguageEnum.LanguageStoryType.EN then
		if LangSettings.instance:isJp() and nameEn == "Aleph" then
			nameEn = ""
		end

		self._txtnameen.text = nameEn ~= "" and "<voffset=4>/ </voffset>" .. nameEn or ""

		gohelper.setActive(self._txtnameen.gameObject, true)
	else
		self._txtnameen.text = ""

		if isNumberName and GameLanguageMgr.instance:getLanguageTypeStoryIndex() == LanguageEnum.LanguageStoryType.EN then
			self._txtnamecn1.text = self._stepCo.conversation.heroNames[LanguageEnum.LanguageStoryType.CN]
		end

		gohelper.setActive(self._txtnameen.gameObject, false)
	end
end

function StoryView:_showHeadContentIcon(icon)
	if self._goeffectIcon then
		gohelper.destroy(self._goeffectIcon)

		self._goeffectIcon = nil
	end

	if self:_isHeroLead() then
		gohelper.setActive(self._gohead, false)
		gohelper.setActive(self._gospine, true)
		gohelper.setActive(self._gonamebg, true)
		self._simagehead:UnLoadImage()
		StoryController.instance:dispatchEvent(StoryEvent.ShowLeadRole, self._stepCo, true, false, false)
	else
		gohelper.setActive(self._gospine, false)
		gohelper.setActive(self._gonamebg, false)
		gohelper.setActive(self._gohead, true)

		local isCut = StoryModel.instance:isHeroIconCuts(string.split(icon, ".")[1])

		gohelper.setActive(self._goheadblack, not isCut)
		gohelper.setActive(self._goheadgrey, false)
		StoryController.instance:dispatchEvent(StoryEvent.ShowLeadRole, self._stepCo, false, false, false)

		local effHeadCo = self:_getEffectHeadIconCo()

		if effHeadCo then
			self._headEffectResPath = ResUrl.getStoryPrefabRes(effHeadCo.path)

			local resList = {}

			table.insert(resList, self._headEffectResPath)
			self:loadRes(resList, self._headEffectResLoaded, self)
			gohelper.setActive(self._goheadgrey, true)
		else
			local path = string.format("singlebg/headicon_small/%s", icon)

			if self._simagehead.curImageUrl == path then
				gohelper.setActive(self._goheadgrey, true)
			else
				self._simagehead:LoadImage(path, function()
					gohelper.setActive(self._goheadgrey, true)
				end)
			end
		end
	end
end

function StoryView:_headEffectResLoaded()
	if self._headEffectResPath then
		local prefAssetItem = self._loader:getAssetItem(self._headEffectResPath)

		self._goeffectIcon = gohelper.clone(prefAssetItem:GetResource(), self._gohead)
	end
end

function StoryView:loadRes(resList, callback, callbackObj)
	if self._loader then
		self._loader:dispose()

		self._loader = nil
	end

	if resList and #resList > 0 then
		self._loader = MultiAbLoader.New()

		self._loader:setPathList(resList)
		self._loader:startLoad(callback, callbackObj)
	elseif callback then
		callback(callbackObj)
	end
end

function StoryView:_getEffectHeadIconCo()
	local heroIcon = string.split(self._stepCo.conversation.heroIcon, ".")[1]
	local leadHeroSpineCos = StoryConfig.instance:getStoryLeadHeroSpine()

	for _, v in ipairs(leadHeroSpineCos) do
		if v.resType == StoryEnum.IconResType.IconEff and v.icon == heroIcon then
			return v
		end
	end

	return nil
end

function StoryView:_isHeroLead()
	local heroIcon = string.split(self._stepCo.conversation.heroIcon, ".")[1]
	local leadHeroSpineCos = StoryConfig.instance:getStoryLeadHeroSpine()

	for _, v in ipairs(leadHeroSpineCos) do
		if v.resType == StoryEnum.IconResType.Spine and v.icon == heroIcon then
			return true
		end
	end

	return false
end

function StoryView:_showText()
	if self._stepCo.conversation.type == StoryEnum.ConversationType.None then
		self._dialogItem:stopConAudio()

		return
	end

	StoryModel.instance:setTextShowing(true)

	if self._stepCo.conversation.type == StoryEnum.ConversationType.ScreenDialog then
		StoryModel.instance:enableClick(false)
		self:_playDialog()
		StoryController.instance:dispatchEvent(StoryEvent.PlayFullText, self._stepCo)
	elseif self._stepCo.conversation.type == StoryEnum.ConversationType.IrregularShake then
		StoryModel.instance:enableClick(false)
		self:_playDialog()
		StoryController.instance:dispatchEvent(StoryEvent.PlayIrregularShakeText, self._stepCo)
	else
		StoryModel.instance:enableClick(true)
		self:_playDialog()
	end

	if self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Shake then
		self:_shakeDialog()
	elseif self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.Fade then
		self:_fadeIn()
	elseif self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.WordByWord then
		-- block empty
	elseif self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.LineByLine then
		self:_lineShow(1)
	elseif self._stepCo.conversation.effType == StoryEnum.ConversationEffectType.TwoLineShow then
		self:_lineShow(2)
	end
end

function StoryView:_playDialog()
	self._finishTime = nil

	self._dialogItem:hideDialog()

	local audioId = self._stepCo.conversation.audios[1] or 0
	local diatxt = StoryModel.instance:getStoryTxtByVoiceType(self._diatxt, audioId)

	self._dialogItem:playDialog(diatxt, self._stepCo, self._conFinished, self)
end

function StoryView:_conFinished()
	StoryModel.instance:setTextShowing(false)

	if self._conTweenId then
		ZProj.TweenHelper.KillById(self._conTweenId)

		self._conTweenId = nil
	end

	local immediate = false
	local keepTime = self._stepCo and self._stepCo.conversation.keepTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] or 1.5

	if StoryModel.instance:isStoryAuto() then
		if not self._finishTime then
			self._finishTime = ServerTime.now()
		end

		immediate = keepTime < ServerTime.now() - self._finishTime
	end

	self._finishTime = ServerTime.now()

	if immediate then
		self:_onCheckNext()
	else
		TaskDispatcher.runDelay(self._onCheckNext, self, keepTime)
	end
end

function StoryView:_shakeDialog()
	TaskDispatcher.cancelTask(self._startShake, self)
	TaskDispatcher.cancelTask(self._shakeStop, self)

	if self._stepCo.conversation.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		return
	end

	if self._stepCo.conversation.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		self:_startShake()
	else
		TaskDispatcher.runDelay(self._startShake, self, self._stepCo.conversation.effDelayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	end
end

function StoryView:_startShake()
	TaskDispatcher.cancelTask(self._shakeStop, self)

	local aniName = {
		"low",
		"middle",
		"high"
	}

	self._contentAnimator:Play(aniName[self._stepCo.conversation.effLv + 1])

	self._contentAnimator.speed = self._stepCo.conversation.effRate

	TaskDispatcher.runDelay(self._shakeStop, self, self._stepCo.conversation.effTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
	StoryController.instance:dispatchEvent(StoryEvent.ConversationShake, self._stepCo, true, self._stepCo.conversation.effLv + 1)
end

function StoryView:_shakeStop()
	if not self._stepCo then
		return
	end

	StoryController.instance:dispatchEvent(StoryEvent.ConversationShake, self._stepCo, false, self._stepCo.conversation.effLv + 1)

	self._contentAnimator.speed = self._stepCo.conversation.effRate

	self._contentAnimator:SetBool("stoploop", true)
end

function StoryView:_fadeIn()
	StoryModel.instance:setTextShowing(true)
	self._dialogItem:playNorDialogFadeIn(self._fadeInFinished, self)
end

function StoryView:_fadeInFinished()
	if not self._stepCo then
		return
	end

	StoryModel.instance:setTextShowing(false)
	TaskDispatcher.cancelTask(self._onCheckNext, self)

	if not self._stepCo then
		return
	end

	TaskDispatcher.runDelay(self._onCheckNext, self, self._stepCo.conversation.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function StoryView:_wordByWord()
	StoryModel.instance:setTextShowing(true)
	self._dialogItem:playWordByWord(self._wordByWordFinished, self)
end

function StoryView:_wordByWordFinished()
	StoryModel.instance:setTextShowing(false)
	TaskDispatcher.cancelTask(self._onCheckNext, self)

	if not self._stepCo then
		return
	end

	TaskDispatcher.runDelay(self._onCheckNext, self, 1)
end

function StoryView:_lineShow(lineCount)
	if not self._stepCo then
		return
	end

	StoryModel.instance:enableClick(false)
	StoryModel.instance:setTextShowing(true)
	StoryController.instance:dispatchEvent(StoryEvent.PlayFullTextLineShow, lineCount, self._stepCo)
end

function StoryView:_onFullTextShowFinished()
	if not self._stepCo then
		return
	end

	StoryModel.instance:setTextShowing(false)
	TaskDispatcher.cancelTask(self._onFullTextKeepFinished, self)
	TaskDispatcher.runDelay(self._onFullTextKeepFinished, self, self._stepCo.conversation.keepTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function StoryView:_onFullTextKeepFinished()
	StoryController.instance:dispatchEvent(StoryEvent.PlayFullTextOut, self._onFullTextFadeOutFinished, self)
end

function StoryView:_onFullTextFadeOutFinished()
	StoryModel.instance:enableClick(true)
	TaskDispatcher.cancelTask(self._onFullTextKeepFinished, self)
	self:_onConFinished(true)
end

function StoryView:_onConFinished(auto)
	if auto then
		self:_onAutoDialogFinished()

		return
	end

	if StoryModel.instance:isStoryAuto() then
		if self:_isUnInteractType() then
			return
		end

		if self._dialogItem then
			if self._dialogItem:isAudioPlaying() then
				self._dialogItem:checkAutoEnterNext(self._onAutoDialogFinished, self)
			else
				self:_onAutoDialogFinished()
			end
		end
	end
end

function StoryView:_onAutoDialogFinished()
	StoryController.instance:enterNext()
end

function StoryView:_onEnableClick()
	if StoryModel.instance:isTextShowing() then
		return
	end

	StoryModel.instance:enableClick(true)
end

function StoryView:_updateAudioList(param)
	local audioParams = {}
	local stepLines = StoryModel.instance:getStepLine()
	local storyCount = 0

	for _, v in pairs(stepLines) do
		storyCount = storyCount + 1
	end

	if storyCount > 1 then
		self:stopAllAudio(0)
	end

	local isSkip = false

	if stepLines[self._curStoryId] then
		for _, v in ipairs(stepLines[self._curStoryId]) do
			if v.skip then
				isSkip = true

				break
			end
		end
	end

	if isSkip then
		self:stopAllAudio(0)
	end

	if self._curStoryId and self._curStoryId == StoryModel.instance:getCurStoryId() and self._stepId and self._stepId == StoryModel.instance:getCurStepId() and self._audios then
		for _, v in pairs(param) do
			if not self._audios[v.audio] then
				return
			end
		end
	end

	self._audioCo = param

	for _, v in pairs(self._audioCo) do
		if not self._audios then
			self._audios = {}
		end

		if not self._audios[v.audio] then
			self._audios[v.audio] = StoryAudioItem.New()

			self._audios[v.audio]:init(v.audio)
		end

		self._audios[v.audio]:setAudio(v)
	end
end

function StoryView:stopAllAudio(outTime)
	if self._audios then
		for _, v in pairs(self._audios) do
			v:stop(outTime)
		end

		self._audios = nil
	end
end

function StoryView:_updateEffectList(param)
	local effParams = {}
	local stepLines = StoryModel.instance:getStepLine()
	local storyCount = 0

	for _, _ in pairs(stepLines) do
		storyCount = storyCount + 1
	end

	if storyCount > 1 then
		for _, v in pairs(self._effects) do
			v:onDestroy()
		end
	end

	if stepLines[self._curStoryId] then
		for _, v in ipairs(stepLines[self._curStoryId]) do
			if v.skip and v.skip then
				local effCos = StoryStepModel.instance:getStepListById(v.stepId).effList

				for i = 1, #effCos do
					table.insert(effParams, effCos[i])

					if effCos[i].orderType == StoryEnum.EffectOrderType.Destroy then
						for j = #effParams, 1, -1 do
							if effParams[j].orderType ~= StoryEnum.EffectOrderType.Destroy and effParams[j].effect == effCos[i].effect then
								table.remove(effParams, #effParams)
								table.remove(effParams, j)
							end
						end
					end
				end
			end
		end
	end

	if #param < 1 and #effParams == 0 then
		return
	end

	self._effCo = #effParams == 0 and param or effParams

	local hasboteff = false

	for _, v in pairs(self._effCo) do
		if v.orderType ~= StoryEnum.EffectOrderType.Destroy and v.layer > 0 then
			self:_buildEffect(v.effect, v)
		else
			self:_destroyEffect(v.effect, v)
		end

		if v.layer < 4 then
			hasboteff = true
		end
	end

	StoryTool.enablePostProcess(false)

	for _, v in pairs(self._effects) do
		StoryTool.enablePostProcess(true)
	end

	StoryModel.instance:setHasBottomEffect(hasboteff)
end

function StoryView:_buildEffect(name, eff)
	local order = 0
	local effGo

	if eff.layer < 4 then
		effGo = self._goeff1
		order = 4
	elseif eff.layer < 7 then
		effGo = self._goeff2
		order = 1000
	elseif eff.layer < 10 then
		effGo = self._goeff3
		order = 2000
	else
		if not self._goeff4 then
			local frontGo = ViewMgr.instance:getContainer(ViewName.StoryFrontView).viewGO

			self._goeff4 = gohelper.findChild(frontGo, "#go_frontitem/#go_eff4")
		end

		effGo = self._goeff4
	end

	if not self._effects[name] then
		self._effects[name] = StoryEffectItem.New()

		self._effects[name]:init(effGo, name, eff, order)
	else
		self._effects[name]:reset(effGo, eff, order)
	end
end

function StoryView:_destroyEffect(name, v)
	if not self._effects[name] then
		return
	end

	local data = {}

	data.callback = self._effectRealDestroy
	data.callbackObj = self

	self._effects[name]:destroyEffect(v, data)
end

function StoryView:_effectRealDestroy(name)
	self._effects[name] = nil
end

function StoryView:_updatePictureList(param)
	local picParams = {}
	local stepLines = StoryModel.instance:getStepLine()
	local storyCount = 0

	for _, v in pairs(stepLines) do
		storyCount = storyCount + 1
	end

	if storyCount > 1 then
		for _, v in pairs(self._pictures) do
			v:onDestroy()
		end
	end

	local isSkip = false

	if stepLines[self._curStoryId] then
		for _, v in ipairs(stepLines[self._curStoryId]) do
			local picCos = StoryStepModel.instance:getStepListById(v.stepId).picList

			if v.skip then
				isSkip = true

				for i = 1, #picCos do
					table.insert(picParams, picCos[i])

					if picCos[i].orderType == StoryEnum.PictureOrderType.Destroy then
						for j = #picParams, 1, -1 do
							if picParams[j].orderType == StoryEnum.PictureOrderType.Produce and picParams[j].picture == picCos[i].picture then
								table.remove(picParams, #picParams)
								table.remove(picParams, j)
							end
						end
					end
				end
			end
		end
	end

	self:_resetStepPictures()

	if #param < 1 and #picParams == 0 then
		return
	end

	self._picCo = #picParams > 0 and picParams or param

	for _, v in pairs(self._picCo) do
		local name = v.picType == StoryEnum.PictureType.FullScreen and "fullfocusitem" or v.picture

		if v.orderType == StoryEnum.PictureOrderType.Produce and v.layer > 0 then
			self:_buildPicture(name, v, isSkip)
		else
			self:_destroyPicture(name, v, isSkip)
		end
	end

	self:_checkFloatBgShow()
end

function StoryView:_resetStepPictures()
	for _, v in pairs(self._pictures) do
		v:resetStep()
	end
end

function StoryView:_checkFloatBgShow()
	ZProj.TweenHelper.KillByObj(self._imagefullbottom)

	for _, v in pairs(self._pictures) do
		if v:isFloatType() then
			gohelper.setActive(self._imagefullbottom.gameObject, true)

			local alpha = self._imagefullbottom.color.a

			ZProj.TweenHelper.DoFade(self._imagefullbottom, alpha, self._initFullBottomAlpha, 0.1, nil, nil, nil, EaseType.Linear)

			return
		end
	end

	local destroyKeepTime = 0

	for _, v in pairs(self._picCo) do
		destroyKeepTime = v.orderType == StoryEnum.PictureOrderType.Destroy and v.layer > 0 and v.picType == StoryEnum.PictureType.Float and destroyKeepTime < v.outTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] and v.outTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] or destroyKeepTime
	end

	for _, v in pairs(self._picCo) do
		if v.orderType == StoryEnum.PictureOrderType.Produce and v.layer > 0 and v.picType == StoryEnum.PictureType.Float then
			destroyKeepTime = 0
		end
	end

	if destroyKeepTime < 0.01 then
		gohelper.setActive(self._imagefullbottom.gameObject, false)
	else
		gohelper.setActive(self._imagefullbottom.gameObject, true)
		ZProj.TweenHelper.DoFade(self._imagefullbottom, self._initFullBottomAlpha, 0, destroyKeepTime, function()
			gohelper.setActive(self._imagefullbottom.gameObject, false)
		end, nil, nil, EaseType.Linear)
	end
end

function StoryView:_buildPicture(name, pic, isSkip)
	local imgGo

	if pic.layer < 4 then
		imgGo = self._goimg1
	elseif pic.layer < 7 then
		imgGo = self._goimg2
	elseif pic.layer < 10 then
		imgGo = self._goimg3
	else
		if not self._goimg4 then
			local frontGo = ViewMgr.instance:getContainer(ViewName.StoryFrontView).viewGO

			self._goimg4 = gohelper.findChild(frontGo, "#go_frontitem/#go_img4")
		end

		imgGo = self._goimg4
	end

	if not self._pictures[name] then
		self._pictures[name] = StoryPictureItem.New()

		self._pictures[name]:init(imgGo, name, pic)
	elseif not isSkip then
		self._pictures[name]:reset(imgGo, pic)
	end
end

function StoryView:_destroyPicture(name, v, isSkip)
	if not self._pictures[name] then
		if isSkip then
			if v.orderType == StoryEnum.PictureOrderType.Produce then
				self:_buildPicture(name, v, isSkip)
			end

			TaskDispatcher.runDelay(function()
				self:_startDestroyPic(v, isSkip, name)
			end, nil, 0.2)
		end

		return
	end

	self:_startDestroyPic(v, isSkip, name)
end

function StoryView:_startDestroyPic(v, isSkip, name)
	if not self._pictures[name] then
		return
	end

	local keepTime = 0
	local videoList = self._stepCo.videoList

	for _, video in pairs(videoList) do
		if video.orderType == StoryEnum.VideoOrderType.Produce then
			keepTime = 0.5
		end
	end

	self._pictures[name]:destroyPicture(v, isSkip, keepTime)

	self._pictures[name] = nil
end

function StoryView:_updateNavigateList(navs)
	StoryController.instance:dispatchEvent(StoryEvent.RefreshNavigate, navs)
end

function StoryView:_updateVideoList(param)
	self._videoCo = param

	local hasVideo = false

	for _, v in pairs(self._videoCo) do
		if v.orderType == StoryEnum.VideoOrderType.Produce then
			self:_buildVideo(v.video, v)
		elseif v.orderType == StoryEnum.VideoOrderType.Destroy then
			self:_destroyVideo(v.video, v)
		elseif v.orderType == StoryEnum.VideoOrderType.Pause then
			self._videos[v.video]:pause(true)
		else
			self._videos[v.video]:pause(false)
		end
	end

	for _, v in pairs(self._videoCo) do
		if v.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 and (v.orderType == StoryEnum.VideoOrderType.Produce or v.orderType == StoryEnum.VideoOrderType.Pause or v.orderType == StoryEnum.VideoOrderType.Restart) then
			hasVideo = true
		end
	end

	if not hasVideo then
		StoryController.instance:dispatchEvent(StoryEvent.ShowBackground)
	end
end

function StoryView:_videoStarted(storyVideoItem)
	return
end

function StoryView:_buildVideo(name, co)
	local videoGo

	if co.layer < 4 then
		videoGo = self._govideo1
	elseif co.layer < 7 then
		videoGo = self._govideo2
	else
		videoGo = self._govideo3
	end

	if not self._videos[name] then
		self._videos[name] = StoryVideoItem.New()

		self._videos[name]:init(videoGo, name, co, self._videoStarted, self)
	else
		self._videos[name]:reset(videoGo, co)
	end
end

function StoryView:_destroyVideo(name, co)
	if not self._videos[name] then
		return
	end

	self._videos[name]:destroyVideo(co)

	self._videos[name] = nil
end

function StoryView:_updateOptionList(param)
	self._optCo = param
end

function StoryView:_clearItems(noCancel)
	self:_clearAllTimers()
	TaskDispatcher.cancelTask(self._viewFadeIn, self)
	TaskDispatcher.cancelTask(self._enterNextStep, self)
	TaskDispatcher.cancelTask(self._startShowText, self)
	TaskDispatcher.cancelTask(self._startShake, self)
	TaskDispatcher.cancelTask(self._shakeStop, self)

	for _, v in pairs(self._pictures) do
		v:onDestroy()
	end

	self._pictures = {}

	for _, v in pairs(self._effects) do
		v:onDestroy()
	end

	self._effects = {}

	for _, v in pairs(self._videos) do
		v:onDestroy()
	end

	self._videos = {}
end

function StoryView:onDestroyView()
	if ViewMgr.instance:isOpen(ViewName.MessageBoxView) then
		ViewMgr.instance:closeView(ViewName.MessageBoxView, true)
	end

	if self._confadeId then
		ZProj.TweenHelper.KillById(self._confadeId)

		self._confadeId = nil
	end

	ZProj.TweenHelper.KillByObj(self._imagefullbottom)
	TaskDispatcher.cancelTask(self._conShowIn, self)
	TaskDispatcher.cancelTask(self._startShowText, self)
	TaskDispatcher.cancelTask(self._enterNextStep, self)
	TaskDispatcher.cancelTask(self._onFullTextKeepFinished, self)
	TaskDispatcher.cancelTask(self._startShake, self)
	TaskDispatcher.cancelTask(self._guaranteeEnterNextStep, self)
	TaskDispatcher.cancelTask(self._shakeStop, self)
	StoryTool.enablePostProcess(false)
	ViewMgr.instance:closeView(ViewName.StoryFrontView, nil, true)
	self._simagehead:UnLoadImage()
	StoryController.instance:stopPlotMusic()

	self._bgAudio = nil

	self:stopAllAudio(0)

	if self._dialogItem then
		self._dialogItem:destroy()

		self._dialogItem = nil
	end
end

return StoryView
