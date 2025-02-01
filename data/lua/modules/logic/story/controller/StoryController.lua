module("modules.logic.story.controller.StoryController", package.seeall)

slot0 = class("StoryController", BaseController)

function slot0.onInit(slot0)
	slot0._curStoryId = 0
	slot0._curStepId = 0
end

function slot0.reInit(slot0)
	slot0:_checkAudioEnd()
end

function slot0.playStories(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = {
		storyIds = tabletool.copy(slot1)
	}

	if slot2 then
		for slot10, slot11 in pairs(slot2) do
			slot6[slot10] = slot11
		end
	end

	slot6.callback = slot3
	slot6.target = slot4
	slot6.param = slot5

	slot0:_playNextStory(slot6)
end

function slot0._playNextStory(slot0, slot1, slot2)
	slot3 = nil

	if #slot1.storyIds > 0 then
		slot3 = slot1.storyIds[1]
	end

	table.remove(slot1.storyIds, 1)

	if slot3 and not slot2 then
		slot0:playStory(slot3, slot1, slot0._playNextStory, slot0, slot1)
	elseif slot1.callback then
		slot1.callback(slot1.target, slot1.param)
	end
end

function slot0.playStoryByStartStep(slot0, slot1, slot2)
	slot0._mark = false
	slot0._curStoryId = slot1

	slot0:initStoryData(slot1, function ()
		StoryModel.instance:setStoryFirstStep(uv0)
		uv1:dispatchEvent(StoryEvent.Start, uv2)
		ViewMgr.instance:openView(ViewName.StoryBackgroundView, nil, true)
	end)
end

function slot0.playStory(slot0, slot1, slot2, slot3, slot4, slot5)
	PostProcessingMgr.instance:setUIActive(true, true)

	if slot2 and slot2.levelIdDict and slot2.levelIdDict[slot1] and slot6 ~= 0 then
		ViewMgr.instance:openView(ViewName.StorySceneView, {
			levelId = slot6
		}, true)
	end

	slot0:_checkAudioStart()

	if not ViewMgr.instance:isOpen(ViewName.StoryView) then
		ViewMgr.instance:closeAllModalViews()
	end

	slot0._curStoryId = slot1
	slot0._finishCallback = slot3
	slot0._callbackTarget = slot4
	slot0._param = slot5

	slot0:resetStoryParam(slot2)
	slot0:initStoryData(slot1, function ()
		uv0:dispatchEvent(StoryEvent.Start, uv1)

		if StoryModel.instance:hasConfigNotExist() then
			uv0:skipAllStory()
			uv0:closeStoryView()
			uv0:playFinishCallback()

			return
		end

		StoryModel.instance:enableClick(true)

		if ViewMgr.instance:isOpen(ViewName.StoryBackgroundView) then
			uv0:dispatchEvent(StoryEvent.ReOpenStoryView)
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

function slot0.resetStoryParam(slot0, slot1)
	StoryModel.instance:setHideBtns(slot1 and slot1.hideBtn)

	if slot1 and slot1.mark == false then
		slot0._mark = false
	else
		slot0._mark = true
	end

	slot0._episodeId = slot1 and slot1.episodeId
	slot0._isReplay = slot1 and slot1.isReplay
	slot0._isVersionActivityPV = slot1 and slot1.isVersionActivityPV
	slot0._showBlur = slot1 and slot1.blur
	slot0._hideStartAndEndDark = slot1 and slot1.hideStartAndEndDark
	slot0._isSeasonActivityStory = slot1 and slot1.isSeasonActivityStory
	slot0._isLeMiTeActivityStory = slot1 and slot1.isLeiMiTeActivityStory
	slot0._skipMessageId = slot1 and slot1.skipMessageId
	slot0._isReplay = slot1 and slot1.isReplay

	if slot0._isReplay == nil and StoryModel.instance:isStoryFinished(slot0._curStoryId) then
		slot0._isReplay = true
	end

	if slot0._isReplay == nil then
		slot0._isReplay = slot0._isReplay
	end
end

function slot0.isReplay(slot0)
	return slot0._isReplay
end

function slot0.isVersionActivityPV(slot0)
	return slot0._isVersionActivityPV
end

function slot0.getSkipMessageId(slot0)
	if slot0._skipMessageId then
		return slot0._skipMessageId
	end

	return MessageBoxIdDefine.StorySkipConfirm
end

function slot0.startStory(slot0)
	if slot0._showBlur then
		StoryModel.instance:setUIActive(true)
	end

	StoryModel.instance:clearStepLine()
	slot0:statStartStory()

	if #StoryModel.instance:getStoryFirstSteps() == 1 then
		slot0:playStep(slot1[1])
		slot0:dispatchEvent(StoryEvent.StartFirstStep)
	else
		logError("请检查剧情" .. tostring(slot0._curStoryId) .. "确保有且仅有一个起始步骤")
		slot0:skipAllStory()
		slot0:closeStoryView()
	end
end

function slot0._checkAudioStart(slot0)
	slot0._start = true
end

function slot0._checkAudioEnd(slot0)
	if StoryModel.instance:isTypeSkip(StoryEnum.SkipType.AudioFade, uv0.instance._curStoryId) then
		return
	end

	if not slot0._start then
		return
	end

	slot0._start = false
end

function slot0.stopPlotMusic(slot0)
	AudioMgr.instance:trigger(AudioEnum.Story.Stop_PlotMusic)
	AudioMgr.instance:trigger(AudioEnum.Story.Stop_Plot_noise)
	slot0:dispatchEvent(StoryEvent.OnBgmStop)
end

function slot0.initStoryData(slot0, slot1, slot2, slot3)
	StoryConfig.instance:loadStoryConfig(slot1, slot2, slot3)
	StoryModel.instance:clearData()
end

function slot0.playStep(slot0, slot1)
	logNormal("Play storyId : " .. tostring(slot0._curStoryId) .. " stepId : " .. tostring(slot1))
	slot0:statStepStory()

	slot0._curStepId = slot1

	StoryModel.instance:addSkipStepLine(slot0._curStoryId, slot1, false)
	slot0:dispatchEvent(StoryEvent.RefreshStep, {
		stepType = StoryEnum.StepType.Normal,
		stepId = slot1,
		storyId = slot0._curStoryId,
		branches = {}
	})

	if slot0._mark then
		StoryRpc.instance:sendUpdateStoryRequest(slot0._curStoryId, slot0._curStepId, StoryStepModel.instance:getStepFavor(slot1))
	end
end

function slot0.playStepChoose(slot0, slot1)
	if #StoryStepModel.instance:getStepListById(slot1).optList < 1 then
		return
	end

	slot3 = {}

	for slot8, slot9 in ipairs(slot2) do
		if slot9.conditionType == StoryEnum.OptionConditionType.None then
			table.insert(slot3, {
				name = slot9.branchTxts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()],
				index = 0 + 1,
				id = slot9.followId,
				stepId = slot1
			})
		end
	end

	slot0:dispatchEvent(StoryEvent.RefreshStep, {
		stepType = StoryEnum.StepType.Interaction,
		stepId = slot1,
		branches = slot3
	})
end

function slot0.enterNext(slot0)
	StoryModel.instance:addLog(slot0._curStepId)

	if #StoryModel.instance:getFollowSteps(slot0._curStepId) == 0 then
		slot0:playFinished()
	elseif not (#StoryStepModel.instance:getStepListById(slot0._curStepId).optList > 0) then
		if not slot0._isReplay and not slot0._isLeMiTeActivityStory and slot0:_isStepHasChapterEnd(slot1[1]) then
			slot0:playFinished()
		else
			slot0:playStep(slot1[1])
		end
	else
		slot0:playStepChoose(slot0._curStepId)
	end
end

function slot0._isStepHasChapterEnd(slot0, slot1)
	if #StoryStepModel.instance:getStepListById(slot1).navigateList > 0 then
		for slot6, slot7 in pairs(slot2.navigateList) do
			if (slot7.navigateType == StoryEnum.NavigateType.ChapterEnd or slot7.navigateType == StoryEnum.NavigateType.ActivityEnd) and StoryModel.instance:isTypeSkip(StoryEnum.SkipType.ChapterEnd, uv0.instance._curStoryId) then
				return true
			end
		end
	end

	return false
end

function slot0.skipAllStory(slot0)
	slot0:statSkipStory()
	StoryModel.instance:addSkipLog(slot0._curStepId)

	if slot0._param and slot0._param.storyIds then
		for slot4 = 1, #slot0._param.storyIds do
			if slot0._param.storyIds[slot4] ~= slot0._curStoryId then
				slot0._curStoryId = slot0._param.storyIds[slot4]

				for slot8 = slot4, 1, -1 do
					table.remove(slot0._param.storyIds, slot8)
				end

				slot0:initStoryData(slot0._curStoryId, function ()
					uv0:statStartStory()

					uv0._curStepId = StoryModel.instance:getStoryFirstSteps()[1]

					uv0:skipAllStory()
				end)

				return
			end
		end
	end

	slot0:playFinished(true)
end

function slot0.skipStory(slot0)
	slot0:statSkipStory()
	StoryModel.instance:addSkipLog(slot0._curStepId)

	slot2 = StoryModel.instance:getSkipStep(slot0._curStoryId, slot0._curStepId) == slot0._curStepId
	slot0._curStepId = slot1

	if #StoryModel.instance:getFollowSteps(slot1) == 0 then
		if #StoryStepModel.instance:getStepListById(slot1).videoList > 0 then
			slot4 = false

			for slot8, slot9 in ipairs(slot3) do
				if slot9.orderType == StoryEnum.VideoOrderType.Produce then
					slot4 = true
				end
			end

			if slot4 and not slot2 then
				slot0:playStep(slot0._curStepId)
				slot0:playStepChoose(slot0._curStepId)

				return
			end
		end

		if slot0._isReplay or slot0._isSeasonActivityStory then
			if slot0._param and slot0._param.storyIds then
				for slot7 = 1, #slot0._param.storyIds do
					if slot0._param.storyIds[slot7] ~= slot0._curStoryId then
						slot0._curStoryId = slot0._param.storyIds[slot7]

						for slot11 = slot7, 1, -1 do
							table.remove(slot0._param.storyIds, slot11)
						end

						slot0:initStoryData(slot0._curStoryId, function ()
							uv0:statStartStory()

							uv0._curStepId = StoryModel.instance:getStoryFirstSteps()[1]

							uv0:skipStory()
						end)

						return
					end
				end
			end
		elseif slot0._param and slot0._param.storyIds then
			for slot7 = 1, #slot0._param.storyIds do
				if slot0._param.storyIds[slot7] ~= slot0._curStoryId then
					slot0:playFinished(true)
					slot0:_playNextStory(slot0._param)

					return
				end
			end
		end

		slot0:playFinished(true)
	else
		slot0:playStep(slot0._curStepId)
		slot0:playStepChoose(slot0._curStepId)
	end
end

function slot0.playFinished(slot0, slot1)
	if StoryModel.instance:needWaitStoryFinish() or not Activity114Model.instance:canFinishStory() then
		slot0:playStep(slot0._curStepId)
		StoryRpc.instance:sendUpdateStoryRequest(slot0._curStoryId, -1, 0)
		slot0:dispatchEvent(StoryEvent.DialogConFinished, slot0._curStoryId)
		slot0:dispatchEvent(StoryEvent.HideTopBtns, true)

		return
	end

	StoryModel.instance:setPlayFnished()

	if slot0._mark then
		slot0:setStoryFinished(slot0._curStoryId)
		StoryRpc.instance:sendUpdateStoryRequest(slot0._curStoryId, -1, 0)
	end

	slot0:dispatchEvent(StoryEvent.AllStepFinished, slot1)
end

function slot0.setStoryFinished(slot0, slot1)
	DungeonController.instance:onStartLevelOrStoryChange()
	StoryModel.instance:_setStoryFinished(slot1)
	DungeonController.instance:onEndLevelOrStoryChange()
end

function slot0.finished(slot0, slot1)
	PostProcessingMgr.instance:setUIActive(false, true)
	SettingsModel.instance:setTargetFrameRate(SettingsModel.instance:getModelTargetFrameRate())
	ViewMgr.instance:closeView(ViewName.StorySceneView)

	if ViewMgr.instance:isOpen(ViewName.StoryLogView) then
		ViewMgr.instance:closeView(ViewName.StoryLogView, true)
	end

	if not slot1 then
		slot0:statFinishStory()
	end

	StoryModel.instance:resetStepClickTime()

	slot4 = false

	for slot8, slot9 in pairs({
		100014
	}) do
		if slot0._curStoryId == slot9 then
			slot4 = true
		end
	end

	if not slot4 then
		slot0:_checkAudioEnd()
	end

	slot0:dispatchEvent(StoryEvent.Finish, slot0._curStoryId)

	if slot0._showBlur then
		StoryModel.instance:setUIActive(false)
	end

	slot0:playFinishCallback(slot1)
end

function slot0.playFinishCallback(slot0, slot1)
	slot0._finishCallback = nil

	if slot0._finishCallback then
		slot2(slot0._callbackTarget, slot0._param, slot1)
	end
end

function slot0.closeStoryView(slot0)
	PostProcessingMgr.instance:_refreshViewBlur()
	ViewMgr.instance:closeView(ViewName.StoryBackgroundView, nil, false)
end

function slot0.statStartStory(slot0)
	slot0._viewTime = ServerTime.now()
	slot0._lastStepTime = slot0._viewTime
end

function slot0.statStepStory(slot0)
	if not slot0._lastStepTime then
		return
	end

	StatController.instance:track(StatEnum.EventName.StoryStepEnd, {
		[StatEnum.EventProperties.StoryId] = tostring(slot0._curStoryId or ""),
		[StatEnum.EventProperties.StepId] = slot0._curStepId or 0,
		[StatEnum.EventProperties.IsAuto] = StoryModel.instance:isStoryAuto(),
		[StatEnum.EventProperties.ClickTimes] = StoryModel.instance:getStepClickTime(),
		[StatEnum.EventProperties.Time] = math.floor(1000 * (ServerTime.now() - slot0._lastStepTime)),
		[StatEnum.EventProperties.LanguageType] = LangSettings.shortcutTab[GameConfig:GetCurLangType()],
		[StatEnum.EventProperties.VoiceType] = GameConfig:GetCurVoiceShortcut(),
		[StatEnum.EventProperties.Volume] = SDKMgr.instance:getSystemMediaVolume()
	})
	StoryModel.instance:resetStepClickTime()

	slot0._lastStepTime = ServerTime.now()
end

function slot0.statSkipStory(slot0)
	if not slot0._viewTime then
		return
	end

	slot1 = slot0._episodeId and DungeonConfig.instance:getEpisodeCO(slot0._episodeId)

	StatController.instance:track(StatEnum.EventName.StorySkip, {
		[StatEnum.EventProperties.ChapterId] = tostring(slot1 and slot1.chapterId or ""),
		[StatEnum.EventProperties.EpisodeId] = tostring(slot1 and slot1.id or ""),
		[StatEnum.EventProperties.StoryId] = tostring(slot0._curStoryId or ""),
		[StatEnum.EventProperties.Time] = ServerTime.now() - slot0._viewTime,
		[StatEnum.EventProperties.Entrance] = slot0._isReplay and luaLang("datatrack_entrance_handbook") or luaLang("datatrack_entrance_normal")
	})

	slot0._viewTime = nil
end

function slot0.statFinishStory(slot0)
	if slot0._viewTime then
		slot2 = slot0._episodeId and DungeonConfig.instance:getEpisodeCO(slot0._episodeId)

		StatController.instance:track(StatEnum.EventName.StoryEnd, {
			[StatEnum.EventProperties.ChapterId] = tostring(slot2 and slot2.chapterId or ""),
			[StatEnum.EventProperties.EpisodeId] = tostring(slot2 and slot2.id or ""),
			[StatEnum.EventProperties.StoryId] = tostring(slot0._curStoryId or ""),
			[StatEnum.EventProperties.Time] = ServerTime.now() - slot0._viewTime,
			[StatEnum.EventProperties.Entrance] = slot0._isReplay and luaLang("datatrack_entrance_handbook") or luaLang("datatrack_entrance_normal")
		})
	end

	slot0._viewTime = nil
end

function slot0.openStoryLogView(slot0)
	ViewMgr.instance:openView(ViewName.StoryLogView, nil, true)
end

function slot0.openStoryBranchView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.StoryBranchView, slot1, true)
end

function slot0.openStoryPrologueSkipView(slot0, slot1)
	ViewMgr.instance:openView(ViewName.StoryPrologueSkipView, slot1)
end

function slot0.closeStoryBranchView(slot0)
	ViewMgr.instance:closeView(ViewName.StoryBranchView, true)
end

slot0.instance = slot0.New()

return slot0
