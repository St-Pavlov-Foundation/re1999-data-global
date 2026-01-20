-- chunkname: @modules/logic/story/controller/StoryController.lua

module("modules.logic.story.controller.StoryController", package.seeall)

local StoryController = class("StoryController", BaseController)

function StoryController:onInit()
	self._curStoryId = 0
	self._curStepId = 0
end

function StoryController:reInit()
	self:_checkAudioEnd()
end

function StoryController:playStories(storyIds, storyParams, callback, callbackObj, callbackParam)
	local nextParam = {}

	nextParam.storyIds = tabletool.copy(storyIds)

	if storyParams then
		for k, v in pairs(storyParams) do
			nextParam[k] = v
		end
	end

	nextParam.callback = callback
	nextParam.target = callbackObj
	nextParam.param = callbackParam

	self:_playNextStory(nextParam)
end

function StoryController:_playNextStory(nextParam, isSkip)
	local storyId

	if #nextParam.storyIds > 0 then
		storyId = nextParam.storyIds[1]
	end

	table.remove(nextParam.storyIds, 1)

	if storyId and not isSkip then
		self:playStory(storyId, nextParam, self._playNextStory, self, nextParam)
	elseif nextParam.callback then
		nextParam.callback(nextParam.target, nextParam.param)
	end
end

function StoryController:playStoryByStartStep(storyId, stepId)
	self._mark = false
	self._curStoryId = storyId

	StoryModel.instance:setCurStoryId(storyId)
	self:initStoryData(storyId, function()
		StoryModel.instance:setStoryFirstStep(stepId)
		self:dispatchEvent(StoryEvent.Start, storyId)
		ViewMgr.instance:openView(ViewName.StoryBackgroundView, nil, true)
	end)
end

function StoryController:playStory(storyId, storyParams, callback, target, param)
	PostProcessingMgr.instance:setUIActive(true, true)

	local levelId = storyParams and storyParams.levelIdDict and storyParams.levelIdDict[storyId]

	if levelId and levelId ~= 0 then
		ViewMgr.instance:openView(ViewName.StorySceneView, {
			levelId = levelId
		}, true)
	end

	self:_checkAudioStart()

	if not ViewMgr.instance:isOpen(ViewName.StoryView) then
		ViewMgr.instance:closeAllModalViews()
	end

	self._curStoryId = storyId

	StoryModel.instance:setCurStoryId(storyId)

	self._finishCallback = callback
	self._callbackTarget = target
	self._param = param

	self:resetStoryParam(storyParams)
	self:initStoryData(storyId, function()
		StoryModel.instance:setStoryFirstStep(0)
		self:dispatchEvent(StoryEvent.Start, storyId)

		if StoryModel.instance:hasConfigNotExist() then
			self:skipAllStory()
			self:closeStoryView()
			self:playFinishCallback()

			return
		end

		StoryModel.instance:enableClick(true)

		if ViewMgr.instance:isOpen(ViewName.StoryBackgroundView) then
			self:dispatchEvent(StoryEvent.ReOpenStoryView)
		else
			if ViewMgr.instance:isOpen(ViewName.StoryView) then
				ViewMgr.instance:closeView(ViewName.StoryView, true)
				ViewMgr.instance:closeView(ViewName.StoryLeadRoleSpineView, true)
				ViewMgr.instance:closeView(ViewName.StoryHeroView, true)
				ViewMgr.instance:closeView(ViewName.StoryFrontView, true)
				ViewMgr.instance:closeView(ViewName.StoryLogView, true)
			end

			ViewMgr.instance:openView(ViewName.StoryBackgroundView, nil, true)
		end
	end)
end

function StoryController:resetStoryParam(param)
	StoryModel.instance:setHideBtns(param and param.hideBtn)

	if param and param.mark == false then
		self._mark = false
	else
		self._mark = true
	end

	self._episodeId = param and param.episodeId
	self._isReplay = param and param.isReplay

	local isVersionActivityPV = param and param.isVersionActivityPV

	StoryModel.instance:setVersionActivityPV(isVersionActivityPV)

	self._showBlur = param and param.blur
	self._hideStartAndEndDark = param and param.hideStartAndEndDark
	self._isSeasonActivityStory = param and param.isSeasonActivityStory
	self._isLeMiTeActivityStory = param and param.isLeiMiTeActivityStory
	self._skipMessageId = param and param.skipMessageId

	if self._isReplay == nil and StoryModel.instance:isStoryFinished(self._curStoryId) then
		self._isReplay = true
	end

	StoryModel.instance:setIsReplay(self._isReplay)
end

function StoryController:getSkipMessageId()
	if self._skipMessageId then
		return self._skipMessageId
	end

	return MessageBoxIdDefine.StorySkipConfirm
end

function StoryController:startStory()
	if self._showBlur then
		StoryModel.instance:setUIActive(true)
	end

	StoryModel.instance:clearStepLine()
	self:statStartStory()

	local firstStep = StoryModel.instance:getStoryFirstSteps()

	if #firstStep == 1 then
		self:playStep(firstStep[1])
		self:dispatchEvent(StoryEvent.StartFirstStep)
	else
		logError("请检查剧情" .. tostring(self._curStoryId) .. "确保有且仅有一个起始步骤")
		self:skipAllStory()
		self:closeStoryView()
	end
end

function StoryController:_checkAudioStart()
	self._start = true
end

function StoryController:_checkAudioEnd()
	local skip = StoryModel.instance:isTypeSkip(StoryEnum.SkipType.AudioFade, self._curStoryId)

	if skip then
		return
	end

	if not self._start then
		return
	end

	self._start = false
end

function StoryController:stopPlotMusic()
	AudioMgr.instance:trigger(AudioEnum.Story.Stop_PlotMusic)
	AudioMgr.instance:trigger(AudioEnum.Story.Stop_Plot_noise)
	self:dispatchEvent(StoryEvent.OnBgmStop)
end

function StoryController:initStoryData(id, callback, callbackObj)
	StoryConfig.instance:loadStoryConfig(id, callback, callbackObj)
	StoryModel.instance:clearData()
end

function StoryController:playStep(stepId)
	logNormal("Play storyId : " .. tostring(self._curStoryId) .. " stepId : " .. tostring(stepId))
	self:statStepStory()

	self._curStepId = stepId

	StoryModel.instance:setCurStepId(self._curStepId)

	local o = {}

	o.stepType = StoryEnum.StepType.Normal
	o.stepId = stepId
	o.storyId = self._curStoryId
	o.branches = {}

	StoryModel.instance:addSkipStepLine(self._curStoryId, stepId, false)
	self:dispatchEvent(StoryEvent.RefreshStep, o)

	if self._mark then
		StoryRpc.instance:sendUpdateStoryRequest(self._curStoryId, self._curStepId, StoryStepModel.instance:getStepFavor(stepId))
	end
end

function StoryController:playStepChoose(stepId)
	local optList = StoryStepModel.instance:getStepListById(stepId).optList

	if #optList < 1 then
		return
	end

	local list = {}
	local index = 0

	for _, opt in ipairs(optList) do
		if opt.conditionType == StoryEnum.OptionConditionType.None then
			local o = {}

			o.name = opt.branchTxts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]
			index = index + 1
			o.index = index
			o.id = opt.followId
			o.stepId = stepId

			table.insert(list, o)
		end
	end

	local o = {}

	o.stepType = StoryEnum.StepType.Interaction
	o.stepId = stepId
	o.branches = list

	self:dispatchEvent(StoryEvent.RefreshStep, o)
end

function StoryController:enterNext()
	StoryModel.instance:addLog(self._curStepId)

	local steps = StoryModel.instance:getFollowSteps(self._curStepId)

	if #steps == 0 then
		self:playFinished()
	else
		local hasBranch = #StoryStepModel.instance:getStepListById(self._curStepId).optList > 0

		if not hasBranch then
			local isBgEffStack = self:_isBgEffStack(steps[1])

			if isBgEffStack then
				self._curStepId = steps[1]

				StoryModel.instance:setCurStepId(self._curStepId)
				self:enterNext()

				return
			end

			local hasChapterEnd = self:_isStepHasChapterEnd(steps[1])

			if not self._isReplay and not self._isLeMiTeActivityStory and hasChapterEnd then
				self:playFinished()
			else
				self:playStep(steps[1])
			end
		else
			self:playStepChoose(self._curStepId)
		end
	end
end

function StoryController:_isBgEffStack(stepId)
	if not stepId then
		return false
	end

	local stepCo = StoryStepModel.instance:getStepListById(stepId)

	if not stepCo then
		return false
	end

	return stepCo.conversation.type == StoryEnum.ConversationType.BgEffStack
end

function StoryController:_isStepHasChapterEnd(stepId)
	local stepCo = StoryStepModel.instance:getStepListById(stepId)

	if #stepCo.navigateList > 0 then
		for _, v in pairs(stepCo.navigateList) do
			if v.navigateType == StoryEnum.NavigateType.ChapterEnd or v.navigateType == StoryEnum.NavigateType.ActivityEnd then
				local skip = StoryModel.instance:isTypeSkip(StoryEnum.SkipType.ChapterEnd, self._curStoryId)

				if skip then
					return true
				end
			end
		end
	end

	return false
end

function StoryController:skipAllStory()
	self:statSkipStory()
	StoryModel.instance:addSkipLog(self._curStepId)

	if self._param and self._param.storyIds then
		for i = 1, #self._param.storyIds do
			if self._param.storyIds[i] ~= self._curStoryId then
				self._curStoryId = self._param.storyIds[i]

				for j = i, 1, -1 do
					table.remove(self._param.storyIds, j)
				end

				self:initStoryData(self._curStoryId, function()
					self:statStartStory()

					self._curStepId = StoryModel.instance:getStoryFirstSteps()[1]

					StoryModel.instance:setCurStepId(self._curStepId)
					self:skipAllStory()
				end)

				return
			end
		end
	end

	self:playFinished(true)
end

function StoryController:skipStory()
	self:statSkipStory()

	local id = StoryModel.instance:getSkipStep(self._curStoryId, self._curStepId)

	StoryModel.instance:addSkipLog(self._curStepId)

	local isSameStep = id == self._curStepId

	self._curStepId = id

	StoryModel.instance:setCurStepId(self._curStepId)

	if #StoryModel.instance:getFollowSteps(id) == 0 then
		local videoList = StoryStepModel.instance:getStepListById(id).videoList

		if #videoList > 0 then
			local produceVideo = false

			for _, v in ipairs(videoList) do
				if v.orderType == StoryEnum.VideoOrderType.Produce then
					produceVideo = true
				end
			end

			if produceVideo and not isSameStep then
				self:playStep(self._curStepId)
				self:playStepChoose(self._curStepId)

				return
			end
		end

		if self._isReplay or self._isSeasonActivityStory then
			if self._param and self._param.storyIds then
				for i = 1, #self._param.storyIds do
					if self._param.storyIds[i] ~= self._curStoryId then
						self._curStoryId = self._param.storyIds[i]

						for j = i, 1, -1 do
							table.remove(self._param.storyIds, j)
						end

						self:initStoryData(self._curStoryId, function()
							self:statStartStory()

							self._curStepId = StoryModel.instance:getStoryFirstSteps()[1]

							StoryModel.instance:setCurStepId(self._curStepId)
							self:skipStory()
						end)

						return
					end
				end
			end
		elseif self._param and self._param.storyIds then
			for i = 1, #self._param.storyIds do
				if self._param.storyIds[i] ~= self._curStoryId then
					self:playFinished(true)
					self:_playNextStory(self._param)

					return
				end
			end
		end

		self:playFinished(true)
	else
		self:playStep(self._curStepId)
		self:playStepChoose(self._curStepId)
	end
end

function StoryController:playFinished(isSkip)
	local needWait = StoryModel.instance:needWaitStoryFinish()
	local act114NoCanFinishStory = not Activity114Model.instance:canFinishStory()

	if needWait or act114NoCanFinishStory then
		self:playStep(self._curStepId)
		StoryRpc.instance:sendUpdateStoryRequest(self._curStoryId, -1, 0)
		self:dispatchEvent(StoryEvent.DialogConFinished, self._curStoryId)
		self:dispatchEvent(StoryEvent.HideTopBtns, true)

		return
	end

	StoryModel.instance:setPlayFnished()

	if self._mark then
		self:setStoryFinished(self._curStoryId)
		StoryRpc.instance:sendUpdateStoryRequest(self._curStoryId, -1, 0)
	end

	self:dispatchEvent(StoryEvent.AllStepFinished, isSkip)
end

function StoryController:setStoryFinished(id)
	DungeonController.instance:onStartLevelOrStoryChange()
	StoryModel.instance:_setStoryFinished(id)
	DungeonController.instance:onEndLevelOrStoryChange()
end

function StoryController:finished(isSkip)
	PostProcessingMgr.instance:setUIActive(false, true)

	local frameRate = SettingsModel.instance:getModelTargetFrameRate()

	SettingsModel.instance:setTargetFrameRate(frameRate)
	ViewMgr.instance:closeView(ViewName.StorySceneView)

	if ViewMgr.instance:isOpen(ViewName.StoryLogView) then
		ViewMgr.instance:closeView(ViewName.StoryLogView, true)
	end

	if not isSkip then
		self:statFinishStory()
	end

	StoryModel.instance:resetStepClickTime()

	local skipStoryIds = {
		100014
	}
	local skip = false

	for _, v in pairs(skipStoryIds) do
		if self._curStoryId == v then
			skip = true
		end
	end

	if not skip then
		self:_checkAudioEnd()
	end

	self:dispatchEvent(StoryEvent.Finish, self._curStoryId)

	if self._showBlur then
		StoryModel.instance:setUIActive(false)
	end

	self:playFinishCallback(isSkip)
end

function StoryController:playFinishCallback(isSkip)
	local callback = self._finishCallback

	self._finishCallback = nil

	if callback then
		callback(self._callbackTarget, self._param, isSkip)
	end
end

function StoryController:closeStoryView()
	PostProcessingMgr.instance:_refreshViewBlur()
	ViewMgr.instance:closeView(ViewName.StoryBackgroundView, nil, false)
end

function StoryController:statStartStory()
	self._viewTime = ServerTime.now()
	self._lastStepTime = self._viewTime
end

function StoryController:statStepStory()
	if not self._lastStepTime then
		return
	end

	local clickTimes = StoryModel.instance:getStepClickTime()
	local duration = ServerTime.now() - self._lastStepTime

	StatController.instance:track(StatEnum.EventName.StoryStepEnd, {
		[StatEnum.EventProperties.StoryId] = tostring(self._curStoryId or ""),
		[StatEnum.EventProperties.StepId] = self._curStepId or 0,
		[StatEnum.EventProperties.IsAuto] = StoryModel.instance:isStoryAuto(),
		[StatEnum.EventProperties.ClickTimes] = clickTimes,
		[StatEnum.EventProperties.Time] = math.floor(1000 * duration),
		[StatEnum.EventProperties.LanguageType] = LangSettings.shortcutTab[GameConfig:GetCurLangType()],
		[StatEnum.EventProperties.VoiceType] = GameConfig:GetCurVoiceShortcut(),
		[StatEnum.EventProperties.Volume] = SDKMgr.instance:getSystemMediaVolume()
	})
	StoryModel.instance:resetStepClickTime()

	self._lastStepTime = ServerTime.now()
end

function StoryController:statSkipStory()
	if not self._viewTime then
		return
	end

	local episodeConfig = self._episodeId and DungeonConfig.instance:getEpisodeCO(self._episodeId)
	local duration = ServerTime.now() - self._viewTime

	StatController.instance:track(StatEnum.EventName.StorySkip, {
		[StatEnum.EventProperties.ChapterId] = tostring(episodeConfig and episodeConfig.chapterId or ""),
		[StatEnum.EventProperties.EpisodeId] = tostring(episodeConfig and episodeConfig.id or ""),
		[StatEnum.EventProperties.StoryId] = tostring(self._curStoryId or ""),
		[StatEnum.EventProperties.Time] = duration,
		[StatEnum.EventProperties.Entrance] = self._isReplay and luaLang("datatrack_entrance_handbook") or luaLang("datatrack_entrance_normal")
	})

	self._viewTime = nil
end

function StoryController:statFinishStory()
	if self._viewTime then
		local duration = ServerTime.now() - self._viewTime
		local episodeConfig = self._episodeId and DungeonConfig.instance:getEpisodeCO(self._episodeId)

		StatController.instance:track(StatEnum.EventName.StoryEnd, {
			[StatEnum.EventProperties.ChapterId] = tostring(episodeConfig and episodeConfig.chapterId or ""),
			[StatEnum.EventProperties.EpisodeId] = tostring(episodeConfig and episodeConfig.id or ""),
			[StatEnum.EventProperties.StoryId] = tostring(self._curStoryId or ""),
			[StatEnum.EventProperties.Time] = duration,
			[StatEnum.EventProperties.Entrance] = self._isReplay and luaLang("datatrack_entrance_handbook") or luaLang("datatrack_entrance_normal")
		})
	end

	self._viewTime = nil
end

function StoryController:openStoryLogView()
	ViewMgr.instance:openView(ViewName.StoryLogView, nil, true)
end

function StoryController:openStoryBranchView(param)
	ViewMgr.instance:openView(ViewName.StoryBranchView, param, true)
end

function StoryController:openStoryPrologueSkipView(param)
	ViewMgr.instance:openView(ViewName.StoryPrologueSkipView, param)
end

function StoryController:closeStoryBranchView()
	ViewMgr.instance:closeView(ViewName.StoryBranchView, true)
end

StoryController.instance = StoryController.New()

return StoryController
