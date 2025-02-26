module("modules.logic.story.model.StoryModel", package.seeall)

slot0 = class("StoryModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._log = {}
	slot0._herocuts = {}
	slot0._hideBtns = false
	slot0.skipFade = false
	slot0._storyStepLines = {}
	slot0._storyState = {}
	slot0._statStepClickTime = 0

	slot0:resetStoryState()
end

function slot0.resetStoryState(slot0)
	slot0._stepLines = {}
	slot0._auto = false
	slot0._isNormalStep = false
	slot0._hide = false
	slot0._textShowing = false
	slot0._enableClick = true
	slot0._needFadeIn = false
	slot0._needFadeOut = false
	slot0._hasBottomEffect = false
	slot0._specialPlayingVideos = {}
	slot0._playingVideos = {}
	slot0._isPlayFinished = false
	slot0._uiActive = false
end

function slot0.setPlayFnished(slot0)
	slot0._isPlayFinished = true
end

function slot0.isPlayFinished(slot0)
	return slot0._isPlayFinished
end

function slot0.clearStepLine(slot0)
	slot0._stepLines = {}
end

function slot0.addSkipStepLine(slot0, slot1, slot2, slot3)
	if not slot0._stepLines[slot1] then
		slot0._stepLines[slot1] = {}

		table.insert(slot0._stepLines[slot1], {
			stepId = slot2,
			skip = slot3
		})

		return
	end

	if slot0._stepLines[slot1][#slot0._stepLines[slot1]].stepId ~= slot2 then
		table.insert(slot0._stepLines[slot1], {
			stepId = slot2,
			skip = slot3
		})
	end
end

function slot0.getStepLine(slot0)
	return slot0._stepLines
end

function slot0.setHideBtns(slot0, slot1)
	slot0._hideBtns = slot1
end

function slot0.getHideBtns(slot0)
	return slot0._hideBtns
end

function slot0.isStoryAuto(slot0)
	return slot0._auto
end

function slot0.setStoryAuto(slot0, slot1)
	slot0._auto = slot1

	StoryController.instance:dispatchEvent(StoryEvent.AutoChange)
end

function slot0.isNormalStep(slot0)
	return slot0._isNormalStep
end

function slot0.setStepNormal(slot0, slot1)
	slot0._isNormalStep = slot1
end

function slot0.isViewHide(slot0)
	return slot0._hide
end

function slot0.setViewHide(slot0, slot1)
	slot0._hide = slot1
end

function slot0.isTextShowing(slot0)
	return slot0._textShowing
end

function slot0.setTextShowing(slot0, slot1)
	slot0._textShowing = slot1
end

function slot0.isEnableClick(slot0)
	return slot0._enableClick
end

function slot0.enableClick(slot0, slot1)
	slot0._enableClick = slot1
end

function slot0.isNeedFadeIn(slot0)
	return slot0._needFadeIn
end

function slot0.setNeedFadeIn(slot0, slot1)
	slot0._needFadeIn = slot1
end

function slot0.isNeedFadeOut(slot0)
	return slot0._needFadeOut
end

function slot0.setNeedFadeOut(slot0, slot1)
	slot0._needFadeOut = slot1
end

function slot0.hasBottomEffect(slot0)
	return slot0._hasBottomEffect
end

function slot0.setHasBottomEffect(slot0, slot1)
	slot0._hasBottomEffect = slot1
end

function slot0.setUIActive(slot0, slot1)
	slot0._uiActive = slot1

	PostProcessingMgr.instance:setUIActive(slot1)
end

function slot0.getUIActive(slot0)
	return slot0._uiActive
end

function slot0.isHeroIconCuts(slot0, slot1)
	if not next(slot0._herocuts) then
		slot0._herocuts = {}

		for slot5, slot6 in pairs(StoryConfig.instance:getStoryCutConfig()) do
			slot0._herocuts[slot6.cutName] = 1
		end
	end

	return slot0._herocuts[slot1]
end

function slot0.setStoryList(slot0, slot1)
	if slot1 then
		slot2 = StoryMo.New()

		slot2:init(slot1)

		slot0._storyState = slot2
	end
end

function slot0.isStoryFinished(slot0, slot1)
	return slot0._storyState and slot0._storyState.finishList and slot0._storyState.finishList[slot1]
end

function slot0._setStoryFinished(slot0, slot1)
	slot0._storyState.finishList[slot1] = true
end

function slot0.updateStoryList(slot0, slot1)
	if not slot0._storyState or not slot0._storyState.finishList or slot0._storyState.finishList[slot1.storyId] then
		return
	end

	slot0._storyState:update(slot1)
end

function slot0.isStoryHasPlayed(slot0, slot1)
	slot2 = false

	if slot0._storyState.finishList[slot1] then
		return true
	end

	for slot6, slot7 in pairs(slot0._storyState.processList) do
		if slot7.storyId == slot1 then
			return true
		end
	end

	return false
end

function slot0.setStoryFirstStep(slot0, slot1)
	slot0._firstStep = slot1
end

function slot0.getStoryFirstSteps(slot0)
	if slot0._firstStep and slot0._firstStep ~= 0 then
		return {
			slot0._firstStep
		}
	end

	if #StoryStepModel.instance:getStepList() == 0 then
		return {}
	end

	if #slot2 == 1 then
		table.insert(slot1, slot2[1].id)

		return slot1
	end

	for slot7, slot8 in pairs(StoryGroupModel.instance:getGroupList()) do
		for slot12, slot13 in ipairs(slot8) do
			if #slot0:getPreSteps(slot13.id) == 0 then
				slot14 = false

				for slot18, slot19 in pairs(slot1) do
					if slot19 == slot13.id then
						slot14 = true
					end
				end

				if not slot14 then
					table.insert(slot1, slot13.id)
				end
			end
		end
	end

	return slot1
end

function slot0.getFollowSteps(slot0, slot1)
	slot2 = {}

	if not StoryGroupModel.instance:getGroupListById(slot1) then
		return {}
	end

	for slot7, slot8 in ipairs(slot3) do
		table.insert(slot2, slot8.branchId)
	end

	return slot2
end

function slot0.getPreSteps(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in ipairs(StoryGroupModel.instance:getGroupList()) do
		for slot12, slot13 in ipairs(slot8) do
			if slot13.branchId == slot1 then
				table.insert(slot2, slot13.id)
			end
		end
	end

	return slot2
end

function slot0.setSpecialVideoPlaying(slot0, slot1)
	for slot6, slot7 in pairs(StoryConfig.instance:getStoryDialogFadeConfig()) do
		if slot1 == slot7.skipvideo then
			table.insert(slot0._specialPlayingVideos, slot1)
		end
	end

	slot0._playingVideos[slot1] = 1

	StoryController.instance:dispatchEvent(StoryEvent.VideoChange, true)
end

function slot0.setSpecialVideoEnd(slot0, slot1)
	for slot5 = #slot0._specialPlayingVideos, 1, -1 do
		if slot0._specialPlayingVideos[slot5] == slot1 then
			table.remove(slot0._specialPlayingVideos, slot5)
		end
	end

	slot0._playingVideos[slot1] = nil

	StoryController.instance:dispatchEvent(StoryEvent.VideoChange, false)
end

function slot0.isPlayingVideo(slot0)
	if slot0._playingVideos then
		for slot4, slot5 in pairs(slot0._playingVideos) do
			return true
		end
	end

	return false
end

function slot0.isSpecialVideoPlaying(slot0)
	return #slot0._specialPlayingVideos > 0
end

function slot0.getSkipStep(slot0, slot1, slot2)
	slot4 = {
		slot2
	}
	slot5 = true

	repeat
		slot3 = slot4[1]

		slot0:addSkipStepLine(slot1, slot3, true)

		if StoryStepModel.instance:getStepListById(slot3) and slot6.videoList and #slot7 > 0 and slot3 ~= slot2 and not slot0._needWait then
			for slot11, slot12 in pairs(slot7) do
				if slot12.orderType == StoryEnum.VideoOrderType.Produce then
					slot5 = false
				end
			end
		end

		if #slot0:getFollowSteps(slot4[1]) < 1 then
			slot5 = false
		end
	until not slot5

	return slot3
end

function slot0.isBranchHasCondition(slot0, slot1)
	slot2 = false
	slot3 = {
		slot1
	}
	slot4 = slot1
	slot5 = true

	repeat
		slot4 = slot3[1]

		if #StoryStepModel.instance:getStepListById(slot1).videoList > 0 then
			for slot10, slot11 in pairs(slot6) do
				if slot11.orderType == StoryEnum.VideoOrderType.Produce then
					slot2 = true
				end
			end
		end

		if #slot0:getFollowSteps(slot4) < 1 then
			slot5 = false
		end
	until not slot5

	return slot2
end

function slot0.addLog(slot0, slot1)
	if slot0._log[#slot0._log] == slot1 then
		return
	end

	if LuaUtil.isTable(slot1) and LuaUtil.isTable(slot0._log[#slot0._log]) and slot0._log[#slot0._log].stepId == slot1.stepId then
		return
	end

	table.insert(slot0._log, slot1)
end

function slot0.getLog(slot0)
	slot1 = {}

	if slot0._log then
		for slot5, slot6 in ipairs(slot0._log) do
			if not StoryStepModel.instance:getStepListById(slot6) then
				table.insert(slot1, slot6)
			elseif slot7.conversation.type ~= StoryEnum.ConversationType.None and slot7.conversation.type ~= StoryEnum.ConversationType.SlideDialog and not string.match(slot7.conversation.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()], "<notShowInLog>") then
				table.insert(slot1, slot6)
			end
		end
	end

	return slot1
end

function slot0.addSkipLog(slot0, slot1)
	slot3 = {
		slot1
	}
	slot4 = true

	repeat
		slot2 = slot3[1]

		slot0:addLog(slot2)

		if StoryStepModel.instance:getStepListById(slot2) and slot5.videoList and #slot6 > 0 then
			for slot10, slot11 in pairs(slot6) do
				if slot11.orderType == StoryEnum.VideoOrderType.Produce then
					slot4 = false
				end
			end
		end

		if #slot0:getFollowSteps(slot3[1]) ~= 1 then
			slot4 = false
		end
	until not slot4
end

function slot0.clearData(slot0)
	slot0._isPlayFinished = false
	slot0._log = {}

	StoryLogListModel.instance:clearData()
end

function slot0.getStoryTxtByVoiceType(slot0, slot1, slot2)
	slot5 = StoryConfig.instance:getStoryTxtDiffConfig()
	slot10 = LanguageEnum.LanguageStoryType2Key[LanguageEnum.LanguageStoryType.EN]

	if slot2 and slot2 ~= 0 and slot5[slot2] and (slot5[slot2][slot4] or slot5[slot2][slot9]) then
		if slot4 ~= slot6 then
			slot3 = string.gsub(slot1, slot11[LanguageEnum.LanguageStoryType2Key[GameLanguageMgr.instance:getLanguageTypeStoryIndex()]], slot11[LanguageEnum.LanguageStoryType2Key[GameLanguageMgr.instance:getVoiceTypeStoryIndex()]])
		end

		return slot3
	end

	slot12 = {}

	for slot16, slot17 in pairs(slot5) do
		if (slot17[slot4] or slot17[slot9]) and math.floor(slot18.id / 100000) < 1 then
			table.insert(slot12, slot18)
		end
	end

	slot13, slot14 = nil

	for slot18, slot19 in pairs(slot12) do
		if not string.nilorempty(slot19[slot8]) then
			slot3 = string.gsub(slot3, slot13, slot19[slot7])
		end
	end

	return slot3
end

function slot0.isTypeSkip(slot0, slot1, slot2)
	if (slot1 == StoryEnum.SkipType.InDarkFade or slot1 == StoryEnum.SkipType.OutDarkFade) and StoryController.instance._hideStartAndEndDark then
		return true
	end

	for slot7, slot8 in pairs(string.splitToNumber(StoryConfig.instance:getStorySkipConfig(slot1).skipDetail, "#")) do
		if slot8 == slot2 then
			return true
		end
	end

	return false
end

function slot0.isPrologueSkipAndGetTxt(slot0, slot1, slot2)
	slot4 = {}

	for slot8, slot9 in pairs(StoryConfig.instance:getStoryPrologueSkipConfig()) do
		for slot14, slot15 in pairs(string.split(slot9.prologues, "|")) do
			if slot1 == string.splitToNumber(slot15, "#")[1] then
				table.insert(slot4, {
					stepId = slot16[2],
					content = slot9.content
				})
			end
		end
	end

	if #slot4 > 0 then
		for slot8 = #slot0._log, 1, -1 do
			for slot12, slot13 in pairs(slot4) do
				if slot13.stepId == slot0._log[slot8] then
					return true, slot13.content
				end
			end
		end
	end

	return false, ""
end

function slot0.isPrologueSkip(slot0, slot1)
	slot2 = {
		{
			100001,
			100002
		},
		{
			100005,
			100006
		},
		{
			100008,
			100015,
			100016,
			100017
		}
	}

	if slot0._skipStoryId and slot0._skipStoryId > 0 then
		slot3 = 0

		for slot7, slot8 in ipairs(slot2) do
			for slot12, slot13 in pairs(slot8) do
				if slot13 == slot0._skipStoryId then
					slot3 = slot7
				end
			end
		end

		if slot3 > 0 and #slot2[slot3] > 0 then
			for slot7, slot8 in pairs(slot2[slot3]) do
				if slot8 == slot1 then
					return true
				end
			end
		end
	end

	return false
end

function slot0.setPrologueSkipId(slot0, slot1)
	slot0._skipStoryId = slot1
end

function slot0.getStoryBranchOpts(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in ipairs(StoryStepModel.instance:getStepListById(slot1).optList) do
		if slot8.conditionType == StoryEnum.OptionConditionType.None then
			table.insert(slot2, slot8)
		end
	end

	return slot2
end

function slot0.addStepClickTime(slot0)
	slot0._statStepClickTime = slot0._statStepClickTime + 1
end

function slot0.hasConfigNotExist(slot0)
	if not StoryStepModel.instance:getStepList() or not next(slot1) then
		logError("剧情step数据异常,请检查数据！")

		return true
	end

	if not StoryGroupModel.instance:getGroupList() or not next(slot2) then
		logError("剧情group数据异常,请检查数据！")

		return true
	end

	return false
end

function slot0.getStepClickTime(slot0)
	return slot0._statStepClickTime
end

function slot0.resetStepClickTime(slot0)
	slot0._statStepClickTime = 0
end

function slot0.needWaitStoryFinish(slot0)
	return slot0._needWait
end

function slot0.setNeedWaitStoryFinish(slot0, slot1)
	slot0._needWait = slot1
end

function slot0.setReplaceHero(slot0, slot1, slot2)
	if not slot0._replaceHeroList then
		slot0._replaceHeroList = {}
	end

	table.insert(slot0._replaceHeroList, {
		initHero = slot1,
		replaceHeroPath = slot2
	})
end

function slot0.getReplaceHeroPath(slot0, slot1)
	if not slot0._replaceHeroList then
		return
	end

	for slot5, slot6 in pairs(slot0._replaceHeroList) do
		if slot1 == slot6.initHero then
			return slot6.replaceHeroPath
		end
	end
end

function slot0.isDirectSkipStory(slot0, slot1)
	if math.floor(slot1 / 100) == 8008 then
		return slot1 % 100 > 4
	end

	return false
end

slot0.instance = slot0.New()

return slot0
