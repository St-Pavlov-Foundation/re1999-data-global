module("modules.logic.story.model.StoryModel", package.seeall)

local var_0_0 = class("StoryModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._log = {}
	arg_2_0._herocuts = {}
	arg_2_0._hideBtns = false
	arg_2_0.skipFade = false
	arg_2_0._storyStepLines = {}
	arg_2_0._storyState = {}
	arg_2_0._statStepClickTime = 0

	arg_2_0:resetStoryState()
end

function var_0_0.resetStoryState(arg_3_0)
	arg_3_0._stepLines = {}
	arg_3_0._auto = false
	arg_3_0._isNormalStep = false
	arg_3_0._hide = false
	arg_3_0._textShowing = false
	arg_3_0._enableClick = true
	arg_3_0._needFadeIn = false
	arg_3_0._needFadeOut = false
	arg_3_0._hasBottomEffect = false
	arg_3_0._specialPlayingVideos = {}
	arg_3_0._playingVideos = {}
	arg_3_0._isPlayFinished = false
	arg_3_0._uiActive = false
end

function var_0_0.setPlayFnished(arg_4_0)
	arg_4_0._isPlayFinished = true
end

function var_0_0.isPlayFinished(arg_5_0)
	return arg_5_0._isPlayFinished
end

function var_0_0.clearStepLine(arg_6_0)
	arg_6_0._stepLines = {}
end

function var_0_0.addSkipStepLine(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if not arg_7_0._stepLines[arg_7_1] then
		arg_7_0._stepLines[arg_7_1] = {}

		local var_7_0 = {
			stepId = arg_7_2,
			skip = arg_7_3
		}

		table.insert(arg_7_0._stepLines[arg_7_1], var_7_0)

		return
	end

	if arg_7_0._stepLines[arg_7_1][#arg_7_0._stepLines[arg_7_1]].stepId ~= arg_7_2 then
		local var_7_1 = {
			stepId = arg_7_2,
			skip = arg_7_3
		}

		table.insert(arg_7_0._stepLines[arg_7_1], var_7_1)
	end
end

function var_0_0.getStepLine(arg_8_0)
	return arg_8_0._stepLines
end

function var_0_0.setHideBtns(arg_9_0, arg_9_1)
	arg_9_0._hideBtns = arg_9_1
end

function var_0_0.getHideBtns(arg_10_0)
	return arg_10_0._hideBtns
end

function var_0_0.isStoryAuto(arg_11_0)
	return arg_11_0._auto
end

function var_0_0.setStoryAuto(arg_12_0, arg_12_1)
	arg_12_0._auto = arg_12_1

	StoryController.instance:dispatchEvent(StoryEvent.AutoChange)
end

function var_0_0.isNormalStep(arg_13_0)
	return arg_13_0._isNormalStep
end

function var_0_0.setStepNormal(arg_14_0, arg_14_1)
	arg_14_0._isNormalStep = arg_14_1
end

function var_0_0.isViewHide(arg_15_0)
	return arg_15_0._hide
end

function var_0_0.setViewHide(arg_16_0, arg_16_1)
	arg_16_0._hide = arg_16_1
end

function var_0_0.isTextShowing(arg_17_0)
	return arg_17_0._textShowing
end

function var_0_0.setTextShowing(arg_18_0, arg_18_1)
	arg_18_0._textShowing = arg_18_1
end

function var_0_0.isEnableClick(arg_19_0)
	return arg_19_0._enableClick
end

function var_0_0.enableClick(arg_20_0, arg_20_1)
	arg_20_0._enableClick = arg_20_1
end

function var_0_0.isNeedFadeIn(arg_21_0)
	return arg_21_0._needFadeIn
end

function var_0_0.setNeedFadeIn(arg_22_0, arg_22_1)
	arg_22_0._needFadeIn = arg_22_1
end

function var_0_0.isNeedFadeOut(arg_23_0)
	return arg_23_0._needFadeOut
end

function var_0_0.setNeedFadeOut(arg_24_0, arg_24_1)
	arg_24_0._needFadeOut = arg_24_1
end

function var_0_0.hasBottomEffect(arg_25_0)
	return arg_25_0._hasBottomEffect
end

function var_0_0.setHasBottomEffect(arg_26_0, arg_26_1)
	arg_26_0._hasBottomEffect = arg_26_1
end

function var_0_0.setUIActive(arg_27_0, arg_27_1)
	arg_27_0._uiActive = arg_27_1

	PostProcessingMgr.instance:setUIActive(arg_27_1)
end

function var_0_0.getUIActive(arg_28_0)
	return arg_28_0._uiActive
end

function var_0_0.isHeroIconCuts(arg_29_0, arg_29_1)
	if not next(arg_29_0._herocuts) then
		arg_29_0._herocuts = {}

		for iter_29_0, iter_29_1 in pairs(StoryConfig.instance:getStoryCutConfig()) do
			arg_29_0._herocuts[iter_29_1.cutName] = 1
		end
	end

	return arg_29_0._herocuts[arg_29_1]
end

function var_0_0.setStoryList(arg_30_0, arg_30_1)
	if arg_30_1 then
		local var_30_0 = StoryMo.New()

		var_30_0:init(arg_30_1)

		arg_30_0._storyState = var_30_0
	end
end

function var_0_0.isStoryFinished(arg_31_0, arg_31_1)
	return arg_31_0._storyState and arg_31_0._storyState.finishList and arg_31_0._storyState.finishList[arg_31_1]
end

function var_0_0._setStoryFinished(arg_32_0, arg_32_1)
	arg_32_0._storyState.finishList[arg_32_1] = true
end

function var_0_0.updateStoryList(arg_33_0, arg_33_1)
	if not arg_33_0._storyState or not arg_33_0._storyState.finishList or arg_33_0._storyState.finishList[arg_33_1.storyId] then
		return
	end

	arg_33_0._storyState:update(arg_33_1)
end

function var_0_0.isStoryHasPlayed(arg_34_0, arg_34_1)
	local var_34_0 = false

	if arg_34_0._storyState.finishList[arg_34_1] then
		return true
	end

	for iter_34_0, iter_34_1 in pairs(arg_34_0._storyState.processList) do
		if iter_34_1.storyId == arg_34_1 then
			return true
		end
	end

	return false
end

function var_0_0.setStoryFirstStep(arg_35_0, arg_35_1)
	arg_35_0._firstStep = arg_35_1
end

function var_0_0.getStoryFirstSteps(arg_36_0)
	if arg_36_0._firstStep and arg_36_0._firstStep ~= 0 then
		return {
			arg_36_0._firstStep
		}
	end

	local var_36_0 = {}
	local var_36_1 = StoryStepModel.instance:getStepList()

	if #var_36_1 == 0 then
		return var_36_0
	end

	if #var_36_1 == 1 then
		table.insert(var_36_0, var_36_1[1].id)

		return var_36_0
	end

	local var_36_2 = StoryGroupModel.instance:getGroupList()

	for iter_36_0, iter_36_1 in pairs(var_36_2) do
		for iter_36_2, iter_36_3 in ipairs(iter_36_1) do
			if #arg_36_0:getPreSteps(iter_36_3.id) == 0 then
				local var_36_3 = false

				for iter_36_4, iter_36_5 in pairs(var_36_0) do
					if iter_36_5 == iter_36_3.id then
						var_36_3 = true
					end
				end

				if not var_36_3 then
					table.insert(var_36_0, iter_36_3.id)
				end
			end
		end
	end

	return var_36_0
end

function var_0_0.getFollowSteps(arg_37_0, arg_37_1)
	local var_37_0 = {}
	local var_37_1 = StoryGroupModel.instance:getGroupListById(arg_37_1)

	if not var_37_1 then
		return {}
	end

	for iter_37_0, iter_37_1 in ipairs(var_37_1) do
		table.insert(var_37_0, iter_37_1.branchId)
	end

	return var_37_0
end

function var_0_0.getPreSteps(arg_38_0, arg_38_1)
	local var_38_0 = {}
	local var_38_1 = StoryGroupModel.instance:getGroupList()

	for iter_38_0, iter_38_1 in ipairs(var_38_1) do
		for iter_38_2, iter_38_3 in ipairs(iter_38_1) do
			if iter_38_3.branchId == arg_38_1 then
				table.insert(var_38_0, iter_38_3.id)
			end
		end
	end

	return var_38_0
end

function var_0_0.setSpecialVideoPlaying(arg_39_0, arg_39_1)
	local var_39_0 = StoryConfig.instance:getStoryDialogFadeConfig()

	for iter_39_0, iter_39_1 in pairs(var_39_0) do
		if arg_39_1 == iter_39_1.skipvideo then
			table.insert(arg_39_0._specialPlayingVideos, arg_39_1)
		end
	end

	arg_39_0._playingVideos[arg_39_1] = 1

	StoryController.instance:dispatchEvent(StoryEvent.VideoChange, true)
end

function var_0_0.setSpecialVideoEnd(arg_40_0, arg_40_1)
	for iter_40_0 = #arg_40_0._specialPlayingVideos, 1, -1 do
		if arg_40_0._specialPlayingVideos[iter_40_0] == arg_40_1 then
			table.remove(arg_40_0._specialPlayingVideos, iter_40_0)
		end
	end

	arg_40_0._playingVideos[arg_40_1] = nil

	StoryController.instance:dispatchEvent(StoryEvent.VideoChange, false)
end

function var_0_0.isPlayingVideo(arg_41_0)
	if arg_41_0._playingVideos then
		for iter_41_0, iter_41_1 in pairs(arg_41_0._playingVideos) do
			return true
		end
	end

	return false
end

function var_0_0.isSpecialVideoPlaying(arg_42_0)
	return #arg_42_0._specialPlayingVideos > 0
end

function var_0_0.getSkipStep(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = arg_43_2
	local var_43_1 = {
		var_43_0
	}
	local var_43_2 = true

	repeat
		var_43_0 = var_43_1[1]

		arg_43_0:addSkipStepLine(arg_43_1, var_43_0, true)

		local var_43_3 = StoryStepModel.instance:getStepListById(var_43_0)
		local var_43_4 = var_43_3 and var_43_3.videoList

		if var_43_4 and #var_43_4 > 0 and var_43_0 ~= arg_43_2 and not arg_43_0._needWait then
			for iter_43_0, iter_43_1 in pairs(var_43_4) do
				if iter_43_1.orderType == StoryEnum.VideoOrderType.Produce then
					var_43_2 = false
				end
			end
		end

		var_43_1 = arg_43_0:getFollowSteps(var_43_1[1])

		if #var_43_1 < 1 then
			var_43_2 = false
		end
	until not var_43_2

	return var_43_0
end

function var_0_0.isBranchHasCondition(arg_44_0, arg_44_1)
	local var_44_0 = false
	local var_44_1 = {
		arg_44_1
	}
	local var_44_2 = arg_44_1
	local var_44_3 = true

	repeat
		local var_44_4 = var_44_1[1]
		local var_44_5 = StoryStepModel.instance:getStepListById(arg_44_1).videoList

		if #var_44_5 > 0 then
			for iter_44_0, iter_44_1 in pairs(var_44_5) do
				if iter_44_1.orderType == StoryEnum.VideoOrderType.Produce then
					var_44_0 = true
				end
			end
		end

		var_44_1 = arg_44_0:getFollowSteps(var_44_4)

		if #var_44_1 < 1 then
			var_44_3 = false
		end
	until not var_44_3

	return var_44_0
end

function var_0_0.addLog(arg_45_0, arg_45_1)
	if arg_45_0._log[#arg_45_0._log] == arg_45_1 then
		return
	end

	if LuaUtil.isTable(arg_45_1) and LuaUtil.isTable(arg_45_0._log[#arg_45_0._log]) and arg_45_0._log[#arg_45_0._log].stepId == arg_45_1.stepId then
		return
	end

	table.insert(arg_45_0._log, arg_45_1)
end

function var_0_0.getLog(arg_46_0)
	local var_46_0 = {}

	if arg_46_0._log then
		for iter_46_0, iter_46_1 in ipairs(arg_46_0._log) do
			local var_46_1 = StoryStepModel.instance:getStepListById(iter_46_1)

			if not var_46_1 then
				table.insert(var_46_0, iter_46_1)
			elseif var_46_1.conversation.type ~= StoryEnum.ConversationType.None and var_46_1.conversation.type ~= StoryEnum.ConversationType.SlideDialog and not string.match(var_46_1.conversation.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()], "<notShowInLog>") then
				table.insert(var_46_0, iter_46_1)
			end
		end
	end

	return var_46_0
end

function var_0_0.addSkipLog(arg_47_0, arg_47_1)
	local var_47_0 = arg_47_1
	local var_47_1 = {
		var_47_0
	}
	local var_47_2 = true

	repeat
		local var_47_3 = var_47_1[1]

		arg_47_0:addLog(var_47_3)

		local var_47_4 = StoryStepModel.instance:getStepListById(var_47_3)
		local var_47_5 = var_47_4 and var_47_4.videoList

		if var_47_5 and #var_47_5 > 0 then
			for iter_47_0, iter_47_1 in pairs(var_47_5) do
				if iter_47_1.orderType == StoryEnum.VideoOrderType.Produce then
					var_47_2 = false
				end
			end
		end

		var_47_1 = arg_47_0:getFollowSteps(var_47_1[1])

		if #var_47_1 ~= 1 then
			var_47_2 = false
		end
	until not var_47_2
end

function var_0_0.clearData(arg_48_0)
	arg_48_0._isPlayFinished = false
	arg_48_0._log = {}

	StoryLogListModel.instance:clearData()
end

function var_0_0.getStoryTxtByVoiceType(arg_49_0, arg_49_1, arg_49_2)
	local var_49_0 = arg_49_1
	local var_49_1 = GameLanguageMgr.instance:getLanguageTypeStoryIndex()
	local var_49_2 = StoryConfig.instance:getStoryTxtDiffConfig()
	local var_49_3 = GameLanguageMgr.instance:getVoiceTypeStoryIndex()
	local var_49_4 = LanguageEnum.LanguageStoryType2Key[var_49_3]
	local var_49_5 = LanguageEnum.LanguageStoryType2Key[var_49_1]
	local var_49_6 = LanguageEnum.LanguageStoryType.EN
	local var_49_7 = LanguageEnum.LanguageStoryType2Key[var_49_6]
	local var_49_8 = arg_49_2 and arg_49_2 ~= 0 and var_49_2[arg_49_2] and (var_49_2[arg_49_2][var_49_1] or var_49_2[arg_49_2][var_49_6])

	if var_49_8 then
		if var_49_1 ~= var_49_3 then
			var_49_0 = string.gsub(var_49_0, var_49_8[var_49_5], var_49_8[var_49_4])
		end

		return var_49_0
	end

	local var_49_9 = {}

	for iter_49_0, iter_49_1 in pairs(var_49_2) do
		local var_49_10 = iter_49_1[var_49_1] or iter_49_1[var_49_6]

		if var_49_10 and math.floor(var_49_10.id / 100000) < 1 then
			table.insert(var_49_9, var_49_10)
		end
	end

	local var_49_11
	local var_49_12

	for iter_49_2, iter_49_3 in pairs(var_49_9) do
		local var_49_13 = iter_49_3[var_49_5]
		local var_49_14 = iter_49_3[var_49_4]

		if not string.nilorempty(var_49_13) then
			var_49_0 = string.gsub(var_49_0, var_49_13, var_49_14)
		end
	end

	return var_49_0
end

function var_0_0.isTypeSkip(arg_50_0, arg_50_1, arg_50_2)
	if (arg_50_1 == StoryEnum.SkipType.InDarkFade or arg_50_1 == StoryEnum.SkipType.OutDarkFade) and StoryController.instance._hideStartAndEndDark then
		return true
	end

	local var_50_0 = string.splitToNumber(StoryConfig.instance:getStorySkipConfig(arg_50_1).skipDetail, "#")

	for iter_50_0, iter_50_1 in pairs(var_50_0) do
		if iter_50_1 == arg_50_2 then
			return true
		end
	end

	return false
end

function var_0_0.isPrologueSkipAndGetTxt(arg_51_0, arg_51_1, arg_51_2)
	local var_51_0 = StoryConfig.instance:getStoryPrologueSkipConfig()
	local var_51_1 = {}

	for iter_51_0, iter_51_1 in pairs(var_51_0) do
		local var_51_2 = string.split(iter_51_1.prologues, "|")

		for iter_51_2, iter_51_3 in pairs(var_51_2) do
			local var_51_3 = string.splitToNumber(iter_51_3, "#")

			if arg_51_1 == var_51_3[1] then
				local var_51_4 = {
					stepId = var_51_3[2],
					content = iter_51_1.content
				}

				table.insert(var_51_1, var_51_4)
			end
		end
	end

	if #var_51_1 > 0 then
		for iter_51_4 = #arg_51_0._log, 1, -1 do
			for iter_51_5, iter_51_6 in pairs(var_51_1) do
				if iter_51_6.stepId == arg_51_0._log[iter_51_4] then
					return true, iter_51_6.content
				end
			end
		end
	end

	return false, ""
end

function var_0_0.isPrologueSkip(arg_52_0, arg_52_1)
	local var_52_0 = {
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

	if arg_52_0._skipStoryId and arg_52_0._skipStoryId > 0 then
		local var_52_1 = 0

		for iter_52_0, iter_52_1 in ipairs(var_52_0) do
			for iter_52_2, iter_52_3 in pairs(iter_52_1) do
				if iter_52_3 == arg_52_0._skipStoryId then
					var_52_1 = iter_52_0
				end
			end
		end

		if var_52_1 > 0 and #var_52_0[var_52_1] > 0 then
			for iter_52_4, iter_52_5 in pairs(var_52_0[var_52_1]) do
				if iter_52_5 == arg_52_1 then
					return true
				end
			end
		end
	end

	return false
end

function var_0_0.setPrologueSkipId(arg_53_0, arg_53_1)
	arg_53_0._skipStoryId = arg_53_1
end

function var_0_0.getStoryBranchOpts(arg_54_0, arg_54_1)
	local var_54_0 = {}
	local var_54_1 = StoryStepModel.instance:getStepListById(arg_54_1).optList

	for iter_54_0, iter_54_1 in ipairs(var_54_1) do
		if iter_54_1.conditionType == StoryEnum.OptionConditionType.None then
			table.insert(var_54_0, iter_54_1)
		end
	end

	return var_54_0
end

function var_0_0.addStepClickTime(arg_55_0)
	arg_55_0._statStepClickTime = arg_55_0._statStepClickTime + 1
end

function var_0_0.hasConfigNotExist(arg_56_0)
	local var_56_0 = StoryStepModel.instance:getStepList()

	if not var_56_0 or not next(var_56_0) then
		logError("剧情step数据异常,请检查数据！")

		return true
	end

	local var_56_1 = StoryGroupModel.instance:getGroupList()

	if not var_56_1 or not next(var_56_1) then
		logError("剧情group数据异常,请检查数据！")

		return true
	end

	return false
end

function var_0_0.getStepClickTime(arg_57_0)
	return arg_57_0._statStepClickTime
end

function var_0_0.resetStepClickTime(arg_58_0)
	arg_58_0._statStepClickTime = 0
end

function var_0_0.needWaitStoryFinish(arg_59_0)
	return arg_59_0._needWait
end

function var_0_0.setNeedWaitStoryFinish(arg_60_0, arg_60_1)
	arg_60_0._needWait = arg_60_1
end

function var_0_0.setReplaceHero(arg_61_0, arg_61_1, arg_61_2)
	if not arg_61_0._replaceHeroList then
		arg_61_0._replaceHeroList = {}
	end

	local var_61_0 = {
		initHero = arg_61_1,
		replaceHeroPath = arg_61_2
	}

	table.insert(arg_61_0._replaceHeroList, var_61_0)
end

function var_0_0.getReplaceHeroPath(arg_62_0, arg_62_1)
	if not arg_62_0._replaceHeroList then
		return
	end

	for iter_62_0, iter_62_1 in pairs(arg_62_0._replaceHeroList) do
		if arg_62_1 == iter_62_1.initHero then
			return iter_62_1.replaceHeroPath
		end
	end
end

function var_0_0.isDirectSkipStory(arg_63_0, arg_63_1)
	if math.floor(arg_63_1 / 100) == 8008 then
		return arg_63_1 % 100 > 4
	end

	return false
end

var_0_0.instance = var_0_0.New()

return var_0_0
