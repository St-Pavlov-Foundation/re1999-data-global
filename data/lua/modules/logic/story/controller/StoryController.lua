module("modules.logic.story.controller.StoryController", package.seeall)

local var_0_0 = class("StoryController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._curStoryId = 0
	arg_1_0._curStepId = 0
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:_checkAudioEnd()
end

function var_0_0.playStories(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	local var_3_0 = {
		storyIds = tabletool.copy(arg_3_1)
	}

	if arg_3_2 then
		for iter_3_0, iter_3_1 in pairs(arg_3_2) do
			var_3_0[iter_3_0] = iter_3_1
		end
	end

	var_3_0.callback = arg_3_3
	var_3_0.target = arg_3_4
	var_3_0.param = arg_3_5

	arg_3_0:_playNextStory(var_3_0)
end

function var_0_0._playNextStory(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0

	if #arg_4_1.storyIds > 0 then
		var_4_0 = arg_4_1.storyIds[1]
	end

	table.remove(arg_4_1.storyIds, 1)

	if var_4_0 and not arg_4_2 then
		arg_4_0:playStory(var_4_0, arg_4_1, arg_4_0._playNextStory, arg_4_0, arg_4_1)
	elseif arg_4_1.callback then
		arg_4_1.callback(arg_4_1.target, arg_4_1.param)
	end
end

function var_0_0.playStoryByStartStep(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0._mark = false
	arg_5_0._curStoryId = arg_5_1

	arg_5_0:initStoryData(arg_5_1, function()
		StoryModel.instance:setStoryFirstStep(arg_5_2)
		arg_5_0:dispatchEvent(StoryEvent.Start, arg_5_1)
		ViewMgr.instance:openView(ViewName.StoryBackgroundView, nil, true)
	end)
end

function var_0_0.playStory(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	PostProcessingMgr.instance:setUIActive(true, true)

	local var_7_0 = arg_7_2 and arg_7_2.levelIdDict and arg_7_2.levelIdDict[arg_7_1]

	if var_7_0 and var_7_0 ~= 0 then
		ViewMgr.instance:openView(ViewName.StorySceneView, {
			levelId = var_7_0
		}, true)
	end

	arg_7_0:_checkAudioStart()

	if not ViewMgr.instance:isOpen(ViewName.StoryView) then
		ViewMgr.instance:closeAllModalViews()
	end

	arg_7_0._curStoryId = arg_7_1
	arg_7_0._finishCallback = arg_7_3
	arg_7_0._callbackTarget = arg_7_4
	arg_7_0._param = arg_7_5

	arg_7_0:resetStoryParam(arg_7_2)
	arg_7_0:initStoryData(arg_7_1, function()
		StoryModel.instance:setStoryFirstStep(0)
		arg_7_0:dispatchEvent(StoryEvent.Start, arg_7_1)

		if StoryModel.instance:hasConfigNotExist() then
			arg_7_0:skipAllStory()
			arg_7_0:closeStoryView()
			arg_7_0:playFinishCallback()

			return
		end

		StoryModel.instance:enableClick(true)

		if ViewMgr.instance:isOpen(ViewName.StoryBackgroundView) then
			arg_7_0:dispatchEvent(StoryEvent.ReOpenStoryView)
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

function var_0_0.resetStoryParam(arg_9_0, arg_9_1)
	StoryModel.instance:setHideBtns(arg_9_1 and arg_9_1.hideBtn)

	if arg_9_1 and arg_9_1.mark == false then
		arg_9_0._mark = false
	else
		arg_9_0._mark = true
	end

	arg_9_0._episodeId = arg_9_1 and arg_9_1.episodeId
	arg_9_0._isReplay = arg_9_1 and arg_9_1.isReplay

	local var_9_0 = arg_9_1 and arg_9_1.isVersionActivityPV

	StoryModel.instance:setVersionActivityPV(var_9_0)

	arg_9_0._showBlur = arg_9_1 and arg_9_1.blur
	arg_9_0._hideStartAndEndDark = arg_9_1 and arg_9_1.hideStartAndEndDark
	arg_9_0._isSeasonActivityStory = arg_9_1 and arg_9_1.isSeasonActivityStory
	arg_9_0._isLeMiTeActivityStory = arg_9_1 and arg_9_1.isLeiMiTeActivityStory
	arg_9_0._skipMessageId = arg_9_1 and arg_9_1.skipMessageId

	if arg_9_0._isReplay == nil and StoryModel.instance:isStoryFinished(arg_9_0._curStoryId) then
		arg_9_0._isReplay = true
	end

	StoryModel.instance:setIsReplay(arg_9_0._isReplay)
end

function var_0_0.getSkipMessageId(arg_10_0)
	if arg_10_0._skipMessageId then
		return arg_10_0._skipMessageId
	end

	return MessageBoxIdDefine.StorySkipConfirm
end

function var_0_0.startStory(arg_11_0)
	if arg_11_0._showBlur then
		StoryModel.instance:setUIActive(true)
	end

	StoryModel.instance:clearStepLine()
	arg_11_0:statStartStory()

	local var_11_0 = StoryModel.instance:getStoryFirstSteps()

	if #var_11_0 == 1 then
		arg_11_0:playStep(var_11_0[1])
		arg_11_0:dispatchEvent(StoryEvent.StartFirstStep)
	else
		logError("请检查剧情" .. tostring(arg_11_0._curStoryId) .. "确保有且仅有一个起始步骤")
		arg_11_0:skipAllStory()
		arg_11_0:closeStoryView()
	end
end

function var_0_0._checkAudioStart(arg_12_0)
	arg_12_0._start = true
end

function var_0_0._checkAudioEnd(arg_13_0)
	if StoryModel.instance:isTypeSkip(StoryEnum.SkipType.AudioFade, var_0_0.instance._curStoryId) then
		return
	end

	if not arg_13_0._start then
		return
	end

	arg_13_0._start = false
end

function var_0_0.stopPlotMusic(arg_14_0)
	AudioMgr.instance:trigger(AudioEnum.Story.Stop_PlotMusic)
	AudioMgr.instance:trigger(AudioEnum.Story.Stop_Plot_noise)
	arg_14_0:dispatchEvent(StoryEvent.OnBgmStop)
end

function var_0_0.initStoryData(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	StoryConfig.instance:loadStoryConfig(arg_15_1, arg_15_2, arg_15_3)
	StoryModel.instance:clearData()
end

function var_0_0.playStep(arg_16_0, arg_16_1)
	logNormal("Play storyId : " .. tostring(arg_16_0._curStoryId) .. " stepId : " .. tostring(arg_16_1))
	arg_16_0:statStepStory()

	arg_16_0._curStepId = arg_16_1

	local var_16_0 = {
		stepType = StoryEnum.StepType.Normal,
		stepId = arg_16_1,
		storyId = arg_16_0._curStoryId,
		branches = {}
	}

	StoryModel.instance:addSkipStepLine(arg_16_0._curStoryId, arg_16_1, false)
	arg_16_0:dispatchEvent(StoryEvent.RefreshStep, var_16_0)

	if arg_16_0._mark then
		StoryRpc.instance:sendUpdateStoryRequest(arg_16_0._curStoryId, arg_16_0._curStepId, StoryStepModel.instance:getStepFavor(arg_16_1))
	end
end

function var_0_0.playStepChoose(arg_17_0, arg_17_1)
	local var_17_0 = StoryStepModel.instance:getStepListById(arg_17_1).optList

	if #var_17_0 < 1 then
		return
	end

	local var_17_1 = {}
	local var_17_2 = 0

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		if iter_17_1.conditionType == StoryEnum.OptionConditionType.None then
			local var_17_3 = {
				name = iter_17_1.branchTxts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]
			}

			var_17_2 = var_17_2 + 1
			var_17_3.index = var_17_2
			var_17_3.id = iter_17_1.followId
			var_17_3.stepId = arg_17_1

			table.insert(var_17_1, var_17_3)
		end
	end

	local var_17_4 = {
		stepType = StoryEnum.StepType.Interaction,
		stepId = arg_17_1,
		branches = var_17_1
	}

	arg_17_0:dispatchEvent(StoryEvent.RefreshStep, var_17_4)
end

function var_0_0.enterNext(arg_18_0)
	StoryModel.instance:addLog(arg_18_0._curStepId)

	local var_18_0 = StoryModel.instance:getFollowSteps(arg_18_0._curStepId)

	if #var_18_0 == 0 then
		arg_18_0:playFinished()
	elseif not (#StoryStepModel.instance:getStepListById(arg_18_0._curStepId).optList > 0) then
		local var_18_1 = arg_18_0:_isStepHasChapterEnd(var_18_0[1])

		if not arg_18_0._isReplay and not arg_18_0._isLeMiTeActivityStory and var_18_1 then
			arg_18_0:playFinished()
		else
			arg_18_0:playStep(var_18_0[1])
		end
	else
		arg_18_0:playStepChoose(arg_18_0._curStepId)
	end
end

function var_0_0._isStepHasChapterEnd(arg_19_0, arg_19_1)
	local var_19_0 = StoryStepModel.instance:getStepListById(arg_19_1)

	if #var_19_0.navigateList > 0 then
		for iter_19_0, iter_19_1 in pairs(var_19_0.navigateList) do
			if (iter_19_1.navigateType == StoryEnum.NavigateType.ChapterEnd or iter_19_1.navigateType == StoryEnum.NavigateType.ActivityEnd) and StoryModel.instance:isTypeSkip(StoryEnum.SkipType.ChapterEnd, var_0_0.instance._curStoryId) then
				return true
			end
		end
	end

	return false
end

function var_0_0.skipAllStory(arg_20_0)
	arg_20_0:statSkipStory()
	StoryModel.instance:addSkipLog(arg_20_0._curStepId)

	if arg_20_0._param and arg_20_0._param.storyIds then
		for iter_20_0 = 1, #arg_20_0._param.storyIds do
			if arg_20_0._param.storyIds[iter_20_0] ~= arg_20_0._curStoryId then
				arg_20_0._curStoryId = arg_20_0._param.storyIds[iter_20_0]

				for iter_20_1 = iter_20_0, 1, -1 do
					table.remove(arg_20_0._param.storyIds, iter_20_1)
				end

				arg_20_0:initStoryData(arg_20_0._curStoryId, function()
					arg_20_0:statStartStory()

					arg_20_0._curStepId = StoryModel.instance:getStoryFirstSteps()[1]

					arg_20_0:skipAllStory()
				end)

				return
			end
		end
	end

	arg_20_0:playFinished(true)
end

function var_0_0.skipStory(arg_22_0)
	arg_22_0:statSkipStory()

	local var_22_0 = StoryModel.instance:getSkipStep(arg_22_0._curStoryId, arg_22_0._curStepId)

	StoryModel.instance:addSkipLog(arg_22_0._curStepId)

	local var_22_1 = var_22_0 == arg_22_0._curStepId

	arg_22_0._curStepId = var_22_0

	if #StoryModel.instance:getFollowSteps(var_22_0) == 0 then
		local var_22_2 = StoryStepModel.instance:getStepListById(var_22_0).videoList

		if #var_22_2 > 0 then
			local var_22_3 = false

			for iter_22_0, iter_22_1 in ipairs(var_22_2) do
				if iter_22_1.orderType == StoryEnum.VideoOrderType.Produce then
					var_22_3 = true
				end
			end

			if var_22_3 and not var_22_1 then
				arg_22_0:playStep(arg_22_0._curStepId)
				arg_22_0:playStepChoose(arg_22_0._curStepId)

				return
			end
		end

		if arg_22_0._isReplay or arg_22_0._isSeasonActivityStory then
			if arg_22_0._param and arg_22_0._param.storyIds then
				for iter_22_2 = 1, #arg_22_0._param.storyIds do
					if arg_22_0._param.storyIds[iter_22_2] ~= arg_22_0._curStoryId then
						arg_22_0._curStoryId = arg_22_0._param.storyIds[iter_22_2]

						for iter_22_3 = iter_22_2, 1, -1 do
							table.remove(arg_22_0._param.storyIds, iter_22_3)
						end

						arg_22_0:initStoryData(arg_22_0._curStoryId, function()
							arg_22_0:statStartStory()

							arg_22_0._curStepId = StoryModel.instance:getStoryFirstSteps()[1]

							arg_22_0:skipStory()
						end)

						return
					end
				end
			end
		elseif arg_22_0._param and arg_22_0._param.storyIds then
			for iter_22_4 = 1, #arg_22_0._param.storyIds do
				if arg_22_0._param.storyIds[iter_22_4] ~= arg_22_0._curStoryId then
					arg_22_0:playFinished(true)
					arg_22_0:_playNextStory(arg_22_0._param)

					return
				end
			end
		end

		arg_22_0:playFinished(true)
	else
		arg_22_0:playStep(arg_22_0._curStepId)
		arg_22_0:playStepChoose(arg_22_0._curStepId)
	end
end

function var_0_0.playFinished(arg_24_0, arg_24_1)
	local var_24_0 = StoryModel.instance:needWaitStoryFinish()
	local var_24_1 = not Activity114Model.instance:canFinishStory()

	if var_24_0 or var_24_1 then
		arg_24_0:playStep(arg_24_0._curStepId)
		StoryRpc.instance:sendUpdateStoryRequest(arg_24_0._curStoryId, -1, 0)
		arg_24_0:dispatchEvent(StoryEvent.DialogConFinished, arg_24_0._curStoryId)
		arg_24_0:dispatchEvent(StoryEvent.HideTopBtns, true)

		return
	end

	StoryModel.instance:setPlayFnished()

	if arg_24_0._mark then
		arg_24_0:setStoryFinished(arg_24_0._curStoryId)
		StoryRpc.instance:sendUpdateStoryRequest(arg_24_0._curStoryId, -1, 0)
	end

	arg_24_0:dispatchEvent(StoryEvent.AllStepFinished, arg_24_1)
end

function var_0_0.setStoryFinished(arg_25_0, arg_25_1)
	DungeonController.instance:onStartLevelOrStoryChange()
	StoryModel.instance:_setStoryFinished(arg_25_1)
	DungeonController.instance:onEndLevelOrStoryChange()
end

function var_0_0.finished(arg_26_0, arg_26_1)
	PostProcessingMgr.instance:setUIActive(false, true)

	local var_26_0 = SettingsModel.instance:getModelTargetFrameRate()

	SettingsModel.instance:setTargetFrameRate(var_26_0)
	ViewMgr.instance:closeView(ViewName.StorySceneView)

	if ViewMgr.instance:isOpen(ViewName.StoryLogView) then
		ViewMgr.instance:closeView(ViewName.StoryLogView, true)
	end

	if not arg_26_1 then
		arg_26_0:statFinishStory()
	end

	StoryModel.instance:resetStepClickTime()

	local var_26_1 = {
		100014
	}
	local var_26_2 = false

	for iter_26_0, iter_26_1 in pairs(var_26_1) do
		if arg_26_0._curStoryId == iter_26_1 then
			var_26_2 = true
		end
	end

	if not var_26_2 then
		arg_26_0:_checkAudioEnd()
	end

	arg_26_0:dispatchEvent(StoryEvent.Finish, arg_26_0._curStoryId)

	if arg_26_0._showBlur then
		StoryModel.instance:setUIActive(false)
	end

	arg_26_0:playFinishCallback(arg_26_1)
end

function var_0_0.playFinishCallback(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0._finishCallback

	arg_27_0._finishCallback = nil

	if var_27_0 then
		var_27_0(arg_27_0._callbackTarget, arg_27_0._param, arg_27_1)
	end
end

function var_0_0.closeStoryView(arg_28_0)
	PostProcessingMgr.instance:_refreshViewBlur()
	ViewMgr.instance:closeView(ViewName.StoryBackgroundView, nil, false)
end

function var_0_0.statStartStory(arg_29_0)
	arg_29_0._viewTime = ServerTime.now()
	arg_29_0._lastStepTime = arg_29_0._viewTime
end

function var_0_0.statStepStory(arg_30_0)
	if not arg_30_0._lastStepTime then
		return
	end

	local var_30_0 = StoryModel.instance:getStepClickTime()
	local var_30_1 = ServerTime.now() - arg_30_0._lastStepTime

	StatController.instance:track(StatEnum.EventName.StoryStepEnd, {
		[StatEnum.EventProperties.StoryId] = tostring(arg_30_0._curStoryId or ""),
		[StatEnum.EventProperties.StepId] = arg_30_0._curStepId or 0,
		[StatEnum.EventProperties.IsAuto] = StoryModel.instance:isStoryAuto(),
		[StatEnum.EventProperties.ClickTimes] = var_30_0,
		[StatEnum.EventProperties.Time] = math.floor(1000 * var_30_1),
		[StatEnum.EventProperties.LanguageType] = LangSettings.shortcutTab[GameConfig:GetCurLangType()],
		[StatEnum.EventProperties.VoiceType] = GameConfig:GetCurVoiceShortcut(),
		[StatEnum.EventProperties.Volume] = SDKMgr.instance:getSystemMediaVolume()
	})
	StoryModel.instance:resetStepClickTime()

	arg_30_0._lastStepTime = ServerTime.now()
end

function var_0_0.statSkipStory(arg_31_0)
	if not arg_31_0._viewTime then
		return
	end

	local var_31_0 = arg_31_0._episodeId and DungeonConfig.instance:getEpisodeCO(arg_31_0._episodeId)
	local var_31_1 = ServerTime.now() - arg_31_0._viewTime

	StatController.instance:track(StatEnum.EventName.StorySkip, {
		[StatEnum.EventProperties.ChapterId] = tostring(var_31_0 and var_31_0.chapterId or ""),
		[StatEnum.EventProperties.EpisodeId] = tostring(var_31_0 and var_31_0.id or ""),
		[StatEnum.EventProperties.StoryId] = tostring(arg_31_0._curStoryId or ""),
		[StatEnum.EventProperties.Time] = var_31_1,
		[StatEnum.EventProperties.Entrance] = arg_31_0._isReplay and luaLang("datatrack_entrance_handbook") or luaLang("datatrack_entrance_normal")
	})

	arg_31_0._viewTime = nil
end

function var_0_0.statFinishStory(arg_32_0)
	if arg_32_0._viewTime then
		local var_32_0 = ServerTime.now() - arg_32_0._viewTime
		local var_32_1 = arg_32_0._episodeId and DungeonConfig.instance:getEpisodeCO(arg_32_0._episodeId)

		StatController.instance:track(StatEnum.EventName.StoryEnd, {
			[StatEnum.EventProperties.ChapterId] = tostring(var_32_1 and var_32_1.chapterId or ""),
			[StatEnum.EventProperties.EpisodeId] = tostring(var_32_1 and var_32_1.id or ""),
			[StatEnum.EventProperties.StoryId] = tostring(arg_32_0._curStoryId or ""),
			[StatEnum.EventProperties.Time] = var_32_0,
			[StatEnum.EventProperties.Entrance] = arg_32_0._isReplay and luaLang("datatrack_entrance_handbook") or luaLang("datatrack_entrance_normal")
		})
	end

	arg_32_0._viewTime = nil
end

function var_0_0.openStoryLogView(arg_33_0)
	ViewMgr.instance:openView(ViewName.StoryLogView, nil, true)
end

function var_0_0.openStoryBranchView(arg_34_0, arg_34_1)
	ViewMgr.instance:openView(ViewName.StoryBranchView, arg_34_1, true)
end

function var_0_0.openStoryPrologueSkipView(arg_35_0, arg_35_1)
	ViewMgr.instance:openView(ViewName.StoryPrologueSkipView, arg_35_1)
end

function var_0_0.closeStoryBranchView(arg_36_0)
	ViewMgr.instance:closeView(ViewName.StoryBranchView, true)
end

var_0_0.instance = var_0_0.New()

return var_0_0
