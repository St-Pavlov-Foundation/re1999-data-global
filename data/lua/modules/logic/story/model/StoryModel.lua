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
	arg_2_0._isVersionActivityPV = false
	arg_2_0._isReplay = false
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

function var_0_0.isVersionActivityPV(arg_7_0)
	return arg_7_0._isVersionActivityPV
end

function var_0_0.setVersionActivityPV(arg_8_0, arg_8_1)
	arg_8_0._isVersionActivityPV = arg_8_1
end

function var_0_0.isReplay(arg_9_0)
	return arg_9_0._isReplay
end

function var_0_0.setIsReplay(arg_10_0, arg_10_1)
	arg_10_0._isReplay = arg_10_1
end

function var_0_0.addSkipStepLine(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if not arg_11_0._stepLines[arg_11_1] then
		arg_11_0._stepLines[arg_11_1] = {}

		local var_11_0 = {
			stepId = arg_11_2,
			skip = arg_11_3
		}

		table.insert(arg_11_0._stepLines[arg_11_1], var_11_0)

		return
	end

	if arg_11_0._stepLines[arg_11_1][#arg_11_0._stepLines[arg_11_1]].stepId ~= arg_11_2 then
		local var_11_1 = {
			stepId = arg_11_2,
			skip = arg_11_3
		}

		table.insert(arg_11_0._stepLines[arg_11_1], var_11_1)
	end
end

function var_0_0.getStepLine(arg_12_0)
	return arg_12_0._stepLines
end

function var_0_0.setHideBtns(arg_13_0, arg_13_1)
	arg_13_0._hideBtns = arg_13_1
end

function var_0_0.getHideBtns(arg_14_0)
	return arg_14_0._hideBtns
end

function var_0_0.isStoryAuto(arg_15_0)
	return arg_15_0._auto
end

function var_0_0.setStoryAuto(arg_16_0, arg_16_1)
	arg_16_0._auto = arg_16_1

	StoryController.instance:dispatchEvent(StoryEvent.AutoChange)
end

function var_0_0.isNormalStep(arg_17_0)
	return arg_17_0._isNormalStep
end

function var_0_0.setStepNormal(arg_18_0, arg_18_1)
	arg_18_0._isNormalStep = arg_18_1
end

function var_0_0.isViewHide(arg_19_0)
	return arg_19_0._hide
end

function var_0_0.setViewHide(arg_20_0, arg_20_1)
	arg_20_0._hide = arg_20_1
end

function var_0_0.isTextShowing(arg_21_0)
	return arg_21_0._textShowing
end

function var_0_0.setTextShowing(arg_22_0, arg_22_1)
	arg_22_0._textShowing = arg_22_1
end

function var_0_0.isEnableClick(arg_23_0)
	return arg_23_0._enableClick
end

function var_0_0.enableClick(arg_24_0, arg_24_1)
	arg_24_0._enableClick = arg_24_1
end

function var_0_0.isNeedFadeIn(arg_25_0)
	return arg_25_0._needFadeIn
end

function var_0_0.setNeedFadeIn(arg_26_0, arg_26_1)
	arg_26_0._needFadeIn = arg_26_1
end

function var_0_0.isNeedFadeOut(arg_27_0)
	return arg_27_0._needFadeOut
end

function var_0_0.setNeedFadeOut(arg_28_0, arg_28_1)
	arg_28_0._needFadeOut = arg_28_1
end

function var_0_0.hasBottomEffect(arg_29_0)
	return arg_29_0._hasBottomEffect
end

function var_0_0.setHasBottomEffect(arg_30_0, arg_30_1)
	arg_30_0._hasBottomEffect = arg_30_1
end

function var_0_0.setUIActive(arg_31_0, arg_31_1)
	arg_31_0._uiActive = arg_31_1

	PostProcessingMgr.instance:setUIActive(arg_31_1)
end

function var_0_0.getUIActive(arg_32_0)
	return arg_32_0._uiActive
end

function var_0_0.isHeroIconCuts(arg_33_0, arg_33_1)
	if not next(arg_33_0._herocuts) then
		arg_33_0._herocuts = {}

		for iter_33_0, iter_33_1 in pairs(StoryConfig.instance:getStoryCutConfig()) do
			arg_33_0._herocuts[iter_33_1.cutName] = 1
		end
	end

	return arg_33_0._herocuts[arg_33_1]
end

function var_0_0.setStoryList(arg_34_0, arg_34_1)
	if arg_34_1 then
		local var_34_0 = StoryMo.New()

		var_34_0:init(arg_34_1)

		arg_34_0._storyState = var_34_0
	end
end

function var_0_0.isStoryFinished(arg_35_0, arg_35_1)
	return arg_35_0._storyState and arg_35_0._storyState.finishList and arg_35_0._storyState.finishList[arg_35_1]
end

function var_0_0._setStoryFinished(arg_36_0, arg_36_1)
	arg_36_0._storyState.finishList[arg_36_1] = true
end

function var_0_0.updateStoryList(arg_37_0, arg_37_1)
	if not arg_37_0._storyState or not arg_37_0._storyState.finishList or arg_37_0._storyState.finishList[arg_37_1.storyId] then
		return
	end

	arg_37_0._storyState:update(arg_37_1)
end

function var_0_0.isStoryHasPlayed(arg_38_0, arg_38_1)
	local var_38_0 = false

	if arg_38_0._storyState.finishList[arg_38_1] then
		return true
	end

	for iter_38_0, iter_38_1 in pairs(arg_38_0._storyState.processList) do
		if iter_38_1.storyId == arg_38_1 then
			return true
		end
	end

	return false
end

function var_0_0.setStoryFirstStep(arg_39_0, arg_39_1)
	arg_39_0._firstStep = arg_39_1
end

function var_0_0.getStoryFirstSteps(arg_40_0)
	if arg_40_0._firstStep and arg_40_0._firstStep ~= 0 then
		return {
			arg_40_0._firstStep
		}
	end

	local var_40_0 = {}
	local var_40_1 = StoryStepModel.instance:getStepList()

	if #var_40_1 == 0 then
		return var_40_0
	end

	if #var_40_1 == 1 then
		table.insert(var_40_0, var_40_1[1].id)

		return var_40_0
	end

	local var_40_2 = StoryGroupModel.instance:getGroupList()

	for iter_40_0, iter_40_1 in pairs(var_40_2) do
		for iter_40_2, iter_40_3 in ipairs(iter_40_1) do
			if #arg_40_0:getPreSteps(iter_40_3.id) == 0 then
				local var_40_3 = false

				for iter_40_4, iter_40_5 in pairs(var_40_0) do
					if iter_40_5 == iter_40_3.id then
						var_40_3 = true
					end
				end

				if not var_40_3 then
					table.insert(var_40_0, iter_40_3.id)
				end
			end
		end
	end

	return var_40_0
end

function var_0_0.getFollowSteps(arg_41_0, arg_41_1)
	local var_41_0 = {}
	local var_41_1 = StoryGroupModel.instance:getGroupListById(arg_41_1)

	if not var_41_1 then
		return {}
	end

	for iter_41_0, iter_41_1 in ipairs(var_41_1) do
		table.insert(var_41_0, iter_41_1.branchId)
	end

	return var_41_0
end

function var_0_0.getPreSteps(arg_42_0, arg_42_1)
	local var_42_0 = {}
	local var_42_1 = StoryGroupModel.instance:getGroupList()

	for iter_42_0, iter_42_1 in ipairs(var_42_1) do
		for iter_42_2, iter_42_3 in ipairs(iter_42_1) do
			if iter_42_3.branchId == arg_42_1 then
				table.insert(var_42_0, iter_42_3.id)
			end
		end
	end

	return var_42_0
end

function var_0_0.setSpecialVideoPlaying(arg_43_0, arg_43_1)
	local var_43_0 = StoryConfig.instance:getStoryDialogFadeConfig()

	for iter_43_0, iter_43_1 in pairs(var_43_0) do
		if arg_43_1 == iter_43_1.skipvideo then
			table.insert(arg_43_0._specialPlayingVideos, arg_43_1)
		end
	end

	arg_43_0._playingVideos[arg_43_1] = 1

	StoryController.instance:dispatchEvent(StoryEvent.VideoChange, true)
end

function var_0_0.setSpecialVideoEnd(arg_44_0, arg_44_1)
	for iter_44_0 = #arg_44_0._specialPlayingVideos, 1, -1 do
		if arg_44_0._specialPlayingVideos[iter_44_0] == arg_44_1 then
			table.remove(arg_44_0._specialPlayingVideos, iter_44_0)
		end
	end

	arg_44_0._playingVideos[arg_44_1] = nil

	StoryController.instance:dispatchEvent(StoryEvent.VideoChange, false)
end

function var_0_0.isPlayingVideo(arg_45_0)
	if arg_45_0._playingVideos then
		for iter_45_0, iter_45_1 in pairs(arg_45_0._playingVideos) do
			return true
		end
	end

	return false
end

function var_0_0.isSpecialVideoPlaying(arg_46_0)
	return #arg_46_0._specialPlayingVideos > 0
end

function var_0_0.getSkipStep(arg_47_0, arg_47_1, arg_47_2)
	local var_47_0 = arg_47_2
	local var_47_1 = {
		var_47_0
	}
	local var_47_2 = true

	repeat
		var_47_0 = var_47_1[1]

		arg_47_0:addSkipStepLine(arg_47_1, var_47_0, true)

		local var_47_3 = StoryStepModel.instance:getStepListById(var_47_0)
		local var_47_4 = var_47_3 and var_47_3.videoList

		if var_47_4 and #var_47_4 > 0 and var_47_0 ~= arg_47_2 and not arg_47_0._needWait then
			for iter_47_0, iter_47_1 in pairs(var_47_4) do
				if iter_47_1.orderType == StoryEnum.VideoOrderType.Produce then
					var_47_2 = false
				end
			end
		end

		var_47_1 = arg_47_0:getFollowSteps(var_47_1[1])

		if #var_47_1 < 1 then
			var_47_2 = false
		end
	until not var_47_2

	return var_47_0
end

function var_0_0.isBranchHasCondition(arg_48_0, arg_48_1)
	local var_48_0 = false
	local var_48_1 = {
		arg_48_1
	}
	local var_48_2 = arg_48_1
	local var_48_3 = true

	repeat
		local var_48_4 = var_48_1[1]
		local var_48_5 = StoryStepModel.instance:getStepListById(arg_48_1).videoList

		if #var_48_5 > 0 then
			for iter_48_0, iter_48_1 in pairs(var_48_5) do
				if iter_48_1.orderType == StoryEnum.VideoOrderType.Produce then
					var_48_0 = true
				end
			end
		end

		var_48_1 = arg_48_0:getFollowSteps(var_48_4)

		if #var_48_1 < 1 then
			var_48_3 = false
		end
	until not var_48_3

	return var_48_0
end

function var_0_0.addLog(arg_49_0, arg_49_1)
	if arg_49_0._log[#arg_49_0._log] == arg_49_1 then
		return
	end

	if LuaUtil.isTable(arg_49_1) and LuaUtil.isTable(arg_49_0._log[#arg_49_0._log]) and arg_49_0._log[#arg_49_0._log].stepId == arg_49_1.stepId then
		return
	end

	table.insert(arg_49_0._log, arg_49_1)
end

function var_0_0.getLog(arg_50_0)
	local var_50_0 = {}

	if arg_50_0._log then
		for iter_50_0, iter_50_1 in ipairs(arg_50_0._log) do
			local var_50_1 = StoryStepModel.instance:getStepListById(iter_50_1)

			if not var_50_1 then
				table.insert(var_50_0, iter_50_1)
			elseif var_50_1.conversation.type ~= StoryEnum.ConversationType.None and var_50_1.conversation.type ~= StoryEnum.ConversationType.SlideDialog and not string.match(var_50_1.conversation.diaTexts[GameLanguageMgr.instance:getLanguageTypeStoryIndex()], "<notShowInLog>") then
				table.insert(var_50_0, iter_50_1)
			end
		end
	end

	return var_50_0
end

function var_0_0.addSkipLog(arg_51_0, arg_51_1)
	local var_51_0 = arg_51_1
	local var_51_1 = {
		var_51_0
	}
	local var_51_2 = true

	repeat
		local var_51_3 = var_51_1[1]

		arg_51_0:addLog(var_51_3)

		local var_51_4 = StoryStepModel.instance:getStepListById(var_51_3)
		local var_51_5 = var_51_4 and var_51_4.videoList

		if var_51_5 and #var_51_5 > 0 then
			for iter_51_0, iter_51_1 in pairs(var_51_5) do
				if iter_51_1.orderType == StoryEnum.VideoOrderType.Produce then
					var_51_2 = false
				end
			end
		end

		var_51_1 = arg_51_0:getFollowSteps(var_51_1[1])

		if #var_51_1 ~= 1 then
			var_51_2 = false
		end
	until not var_51_2
end

function var_0_0.clearData(arg_52_0)
	arg_52_0._isPlayFinished = false
	arg_52_0._log = {}

	StoryLogListModel.instance:clearData()
end

function var_0_0.getStoryTxtByVoiceType(arg_53_0, arg_53_1, arg_53_2)
	local var_53_0 = arg_53_1
	local var_53_1 = GameLanguageMgr.instance:getLanguageTypeStoryIndex()
	local var_53_2 = StoryConfig.instance:getStoryTxtDiffConfig()
	local var_53_3 = GameLanguageMgr.instance:getVoiceTypeStoryIndex()
	local var_53_4 = LanguageEnum.LanguageStoryType2Key[var_53_3]
	local var_53_5 = LanguageEnum.LanguageStoryType2Key[var_53_1]
	local var_53_6 = LanguageEnum.LanguageStoryType.EN
	local var_53_7 = LanguageEnum.LanguageStoryType2Key[var_53_6]
	local var_53_8 = arg_53_2 and arg_53_2 ~= 0 and var_53_2[arg_53_2] and (var_53_2[arg_53_2][var_53_1] or var_53_2[arg_53_2][var_53_6])

	if var_53_8 then
		if var_53_1 ~= var_53_3 then
			var_53_0 = string.gsub(var_53_0, var_53_8[var_53_5], var_53_8[var_53_4])
		end

		return var_53_0
	end

	local var_53_9 = {}

	for iter_53_0, iter_53_1 in pairs(var_53_2) do
		local var_53_10 = iter_53_1[var_53_1] or iter_53_1[var_53_6]

		if var_53_10 and math.floor(var_53_10.id / 100000) < 1 then
			table.insert(var_53_9, var_53_10)
		end
	end

	local var_53_11
	local var_53_12

	for iter_53_2, iter_53_3 in pairs(var_53_9) do
		local var_53_13 = iter_53_3[var_53_5]
		local var_53_14 = iter_53_3[var_53_4]

		if not string.nilorempty(var_53_13) then
			var_53_0 = string.gsub(var_53_0, var_53_13, var_53_14)
		end
	end

	return var_53_0
end

function var_0_0.isTypeSkip(arg_54_0, arg_54_1, arg_54_2)
	if (arg_54_1 == StoryEnum.SkipType.InDarkFade or arg_54_1 == StoryEnum.SkipType.OutDarkFade) and StoryController.instance._hideStartAndEndDark then
		return true
	end

	local var_54_0 = string.splitToNumber(StoryConfig.instance:getStorySkipConfig(arg_54_1).skipDetail, "#")

	for iter_54_0, iter_54_1 in pairs(var_54_0) do
		if iter_54_1 == arg_54_2 then
			return true
		end
	end

	return false
end

function var_0_0.isPrologueSkipAndGetTxt(arg_55_0, arg_55_1, arg_55_2)
	local var_55_0 = StoryConfig.instance:getStoryPrologueSkipConfig()
	local var_55_1 = {}

	for iter_55_0, iter_55_1 in pairs(var_55_0) do
		local var_55_2 = string.split(iter_55_1.prologues, "|")

		for iter_55_2, iter_55_3 in pairs(var_55_2) do
			local var_55_3 = string.splitToNumber(iter_55_3, "#")

			if arg_55_1 == var_55_3[1] then
				local var_55_4 = {
					stepId = var_55_3[2],
					content = iter_55_1.content
				}

				table.insert(var_55_1, var_55_4)
			end
		end
	end

	if #var_55_1 > 0 then
		for iter_55_4 = #arg_55_0._log, 1, -1 do
			for iter_55_5, iter_55_6 in pairs(var_55_1) do
				if iter_55_6.stepId == arg_55_0._log[iter_55_4] then
					return true, iter_55_6.content
				end
			end
		end
	end

	return false, ""
end

function var_0_0.isPrologueSkip(arg_56_0, arg_56_1)
	local var_56_0 = {
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

	if arg_56_0._skipStoryId and arg_56_0._skipStoryId > 0 then
		local var_56_1 = 0

		for iter_56_0, iter_56_1 in ipairs(var_56_0) do
			for iter_56_2, iter_56_3 in pairs(iter_56_1) do
				if iter_56_3 == arg_56_0._skipStoryId then
					var_56_1 = iter_56_0
				end
			end
		end

		if var_56_1 > 0 and #var_56_0[var_56_1] > 0 then
			for iter_56_4, iter_56_5 in pairs(var_56_0[var_56_1]) do
				if iter_56_5 == arg_56_1 then
					return true
				end
			end
		end
	end

	return false
end

function var_0_0.setPrologueSkipId(arg_57_0, arg_57_1)
	arg_57_0._skipStoryId = arg_57_1
end

function var_0_0.getStoryBranchOpts(arg_58_0, arg_58_1)
	local var_58_0 = {}
	local var_58_1 = StoryStepModel.instance:getStepListById(arg_58_1).optList

	for iter_58_0, iter_58_1 in ipairs(var_58_1) do
		if iter_58_1.conditionType == StoryEnum.OptionConditionType.None then
			table.insert(var_58_0, iter_58_1)
		end
	end

	return var_58_0
end

function var_0_0.addStepClickTime(arg_59_0)
	arg_59_0._statStepClickTime = arg_59_0._statStepClickTime + 1
end

function var_0_0.hasConfigNotExist(arg_60_0)
	local var_60_0 = StoryStepModel.instance:getStepList()

	if not var_60_0 or not next(var_60_0) then
		logError("剧情step数据异常,请检查数据！")

		return true
	end

	local var_60_1 = StoryGroupModel.instance:getGroupList()

	if not var_60_1 or not next(var_60_1) then
		logError("剧情group数据异常,请检查数据！")

		return true
	end

	return false
end

function var_0_0.getStepClickTime(arg_61_0)
	return arg_61_0._statStepClickTime
end

function var_0_0.resetStepClickTime(arg_62_0)
	arg_62_0._statStepClickTime = 0
end

function var_0_0.needWaitStoryFinish(arg_63_0)
	return arg_63_0._needWait
end

function var_0_0.setNeedWaitStoryFinish(arg_64_0, arg_64_1)
	arg_64_0._needWait = arg_64_1
end

function var_0_0.setReplaceHero(arg_65_0, arg_65_1, arg_65_2)
	if not arg_65_0._replaceHeroList then
		arg_65_0._replaceHeroList = {}
	end

	local var_65_0 = {
		initHero = arg_65_1,
		replaceHeroPath = arg_65_2
	}

	table.insert(arg_65_0._replaceHeroList, var_65_0)
end

function var_0_0.getReplaceHeroPath(arg_66_0, arg_66_1)
	if not arg_66_0._replaceHeroList then
		return
	end

	for iter_66_0, iter_66_1 in pairs(arg_66_0._replaceHeroList) do
		if arg_66_1 == iter_66_1.initHero then
			return iter_66_1.replaceHeroPath
		end
	end
end

function var_0_0.isDirectSkipStory(arg_67_0, arg_67_1)
	if math.floor(arg_67_1 / 100) == 8008 then
		return arg_67_1 % 100 > 4
	end

	return false
end

function var_0_0.setCurStoryId(arg_68_0, arg_68_1)
	arg_68_0._curStoryId = arg_68_1
end

function var_0_0.getCurStoryId(arg_69_0)
	return arg_69_0._curStoryId or 0
end

function var_0_0.setCurStepId(arg_70_0, arg_70_1)
	arg_70_0._curStepId = arg_70_1 or 0
end

function var_0_0.getCurStepId(arg_71_0)
	return arg_71_0._curStepId
end

function var_0_0.isStoryPvPause(arg_72_0)
	return arg_72_0._pvPause
end

function var_0_0.setStoryPvPause(arg_73_0, arg_73_1)
	arg_73_0._pvPause = arg_73_1
end

function var_0_0.setLimitNoInteractLock(arg_74_0, arg_74_1)
	arg_74_0._isLimitNoInteractLock = arg_74_1
end

function var_0_0.isLimitNoInteractLock(arg_75_0, arg_75_1)
	if not arg_75_1 or arg_75_1.conversation.type ~= StoryEnum.ConversationType.LimitNoInteract then
		return false
	end

	return arg_75_0._isLimitNoInteractLock
end

var_0_0.instance = var_0_0.New()

return var_0_0
