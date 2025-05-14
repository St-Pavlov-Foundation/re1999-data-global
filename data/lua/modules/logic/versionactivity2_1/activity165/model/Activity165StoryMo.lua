module("modules.logic.versionactivity2_1.activity165.model.Activity165StoryMo", package.seeall)

local var_0_0 = class("Activity165StoryMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0._actId = nil
	arg_1_0.storyId = nil
	arg_1_0.storyCo = nil
	arg_1_0.isUnlock = nil
	arg_1_0._isNewUnlock = nil
	arg_1_0.allKeywordMos = nil
	arg_1_0.stepMoDic = nil
	arg_1_0.unlockSteps = nil
	arg_1_0.firstStepMo = nil
	arg_1_0.finalStepMo = nil
	arg_1_0.curStepIndex = nil
	arg_1_0.stepUseKeywords = nil
	arg_1_0.unlockEndings = nil
	arg_1_0.claimRewardCount = nil
	arg_1_0.endingAllBranch = nil
	arg_1_0.canEndingBranch = nil
	arg_1_0.curUnlockEndingId = nil
	arg_1_0._isShowDialog = nil
	arg_1_0.curStage = nil
	arg_1_0.reviewEnding = nil
	arg_1_0._elements = nil
end

function var_0_0.onInit(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._actId = arg_2_1
	arg_2_0.storyId = arg_2_2
	arg_2_0.storyCo = Activity165Config.instance:getStoryCo(arg_2_1, arg_2_2)
	arg_2_0.unlockSteps = {}
	arg_2_0.stepMoDic = {}
	arg_2_0.unlockEndings = {}
	arg_2_0.endingAllBranch = {}
	arg_2_0.canEndingBranch = {}

	arg_2_0:_initKeywordMo()
	arg_2_0:_initStepMo(arg_2_1, arg_2_2)
	arg_2_0:_initElements()
end

function var_0_0.setMo(arg_3_0, arg_3_1)
	arg_3_0.reviewEnding = nil

	local var_3_0 = arg_3_1 and arg_3_1.storyState == 1

	if not arg_3_0.isUnlock and var_3_0 and arg_3_0._isInit then
		GameFacade.showToast(ToastEnum.Act165StoryUnlock, arg_3_0:getStoryName())
	end

	arg_3_0.isUnlock = var_3_0
	arg_3_0._isInit = true
	arg_3_0.unlockEndings = {}
	arg_3_0.claimRewardCount = arg_3_1.gainedEndingCount or 0
	arg_3_0.stepUseKeywords = arg_3_0:_getStepUseKeywords()

	arg_3_0:setCurState(arg_3_1.inferState or 0)

	for iter_3_0 = 1, #arg_3_1.unlockEndingInfos do
		local var_3_1 = arg_3_1.unlockEndingInfos[iter_3_0]
		local var_3_2 = {}

		for iter_3_1 = 1, #var_3_1.inferredSteps do
			local var_3_3 = var_3_1.inferredSteps[iter_3_1]
			local var_3_4 = {
				stepId = var_3_3.stepId,
				stepKeywords = arg_3_0:getStepKws(var_3_3.stepKeywords)
			}

			table.insert(var_3_2, var_3_4)
		end

		arg_3_0.unlockEndings[var_3_1.endingId] = var_3_2
	end

	arg_3_0.unlockSteps = {}

	local var_3_5 = #arg_3_1.inferredSteps
	local var_3_6

	for iter_3_2 = 1, var_3_5 do
		local var_3_7 = arg_3_1.inferredSteps[iter_3_2].stepId

		table.insert(arg_3_0.unlockSteps, var_3_7)

		var_3_6 = var_3_7

		local var_3_8 = arg_3_1.inferredSteps[iter_3_2].stepKeywords
		local var_3_9 = {}

		if #var_3_8 > 0 then
			for iter_3_3 = 1, #var_3_8 do
				table.insert(var_3_9, var_3_8[iter_3_3])
			end
		else
			var_3_9 = arg_3_0.stepUseKeywords[var_3_5]
		end

		arg_3_0.stepUseKeywords[iter_3_2] = var_3_9
	end

	local var_3_10 = arg_3_0.stepUseKeywords[var_3_5] or {}

	arg_3_0.stepUseKeywords[var_3_5] = var_3_10
	arg_3_0.finalStepMo = arg_3_0.firstStepMo

	if LuaUtil.tableNotEmpty(arg_3_0.unlockSteps) then
		if var_3_6 ~= 0 then
			arg_3_0.finalStepMo = arg_3_0.stepMoDic[var_3_6]
		end

		arg_3_0:checkIsFinishStroy()
	end

	arg_3_0:setCanUnlockRound()
	arg_3_0:_checkNewUnlockStory()
end

function var_0_0.getStepKws(arg_4_0, arg_4_1)
	local var_4_0 = {}

	for iter_4_0 = 1, #arg_4_1 do
		table.insert(var_4_0, arg_4_1[iter_4_0])
	end

	return var_4_0
end

function var_0_0.getStoryName(arg_5_0, arg_5_1)
	if arg_5_1 then
		local var_5_0 = GameUtil.getSubPlaceholderLuaLangTwoParam("act126_story_name_change_size_▩1%s_▩2%s", arg_5_0._actId, arg_5_0.storyId)

		return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang(var_5_0), arg_5_1)
	elseif arg_5_0.storyCo then
		return arg_5_0.storyCo.name
	end
end

function var_0_0.getStoryFirstStepMo(arg_6_0)
	return arg_6_0.firstStepMo
end

function var_0_0.setReviewEnding(arg_7_0, arg_7_1)
	arg_7_0.reviewEnding = arg_7_1

	if arg_7_1 then
		local var_7_0, var_7_1 = arg_7_0:getEndingStepInfo(arg_7_0.reviewEnding)

		arg_7_0.reviewStepUseKeywords = var_7_1
	end
end

function var_0_0.onRestart(arg_8_0)
	arg_8_0.finalStepList = {}
	arg_8_0.unlockSteps = {}
	arg_8_0.stepUseKeywords = {}

	for iter_8_0, iter_8_1 in pairs(arg_8_0.stepMoDic) do
		iter_8_1:onReset()
	end

	for iter_8_2, iter_8_3 in pairs(arg_8_0.allKeywordMos) do
		iter_8_3:onReset()
	end

	arg_8_0.canEndingBranch = arg_8_0.endingAllBranch
	arg_8_0.finalStepMo = arg_8_0.firstStepMo

	arg_8_0:setCurState(Activity165Enum.StoryStage.Filling)

	arg_8_0.reviewEnding = nil

	arg_8_0:saveStepUseKeywords()
end

function var_0_0.checkIsFinishStroy(arg_9_0)
	local var_9_0 = arg_9_0.finalStepMo.isEndingStep

	if var_9_0 then
		arg_9_0:setSelectStepIndex()

		if arg_9_0.curStage == Activity165Enum.StoryStage.Filling then
			arg_9_0:finishStroy()
		elseif arg_9_0.curStage == Activity165Enum.StoryStage.Ending then
			arg_9_0.curUnlockEndingId = arg_9_0:getEndingCo().endingId
		end
	end

	return var_9_0
end

function var_0_0.finishStroy(arg_10_0)
	arg_10_0:setCurState(Activity165Enum.StoryStage.isEndFill)
	Activity165Controller.instance:dispatchEvent(Activity165Event.canfinishStory)
end

function var_0_0.setCurState(arg_11_0, arg_11_1)
	arg_11_0.curStage = arg_11_1
end

function var_0_0._initStepMo(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0 = Activity165Config.instance:getStoryStepCoList(arg_12_1, arg_12_2)

	if not arg_12_0.storyCo then
		return
	end

	local var_12_1 = arg_12_0.storyCo.firstStepId
	local var_12_2 = {}

	if var_12_0 then
		for iter_12_0, iter_12_1 in pairs(var_12_0) do
			local var_12_3 = Activity165StepMo.New()

			var_12_3:onInit(arg_12_0._actId, iter_12_1.stepId, arg_12_0)

			arg_12_0.stepMoDic[iter_12_1.stepId] = var_12_3

			if var_12_3.isEndingStep then
				table.insert(var_12_2, iter_12_1.stepId)
			end
		end

		for iter_12_2, iter_12_3 in pairs(arg_12_0.stepMoDic) do
			local var_12_4 = iter_12_3:getCanEndingRound(var_12_2)

			if LuaUtil.tableNotEmpty(var_12_4) then
				local var_12_5 = tabletool.copy(var_12_4)

				tabletool.addValues(arg_12_0.endingAllBranch, var_12_5)
			end
		end

		arg_12_0.firstStepMo = arg_12_0.stepMoDic[var_12_1]
		arg_12_0.firstStepMo.isFirstStep = true
	end

	arg_12_0.canEndingBranch = arg_12_0.endingAllBranch
end

function var_0_0.getStepMo(arg_13_0, arg_13_1)
	return arg_13_0.stepMoDic[arg_13_1]
end

function var_0_0.checkIsFinishStep(arg_14_0)
	local var_14_0 = arg_14_0:getKwIdsByStepIndex(arg_14_0.curStepIndex)

	arg_14_0:onModifyKeyword(var_14_0)

	if not LuaUtil.tableNotEmpty(var_14_0) then
		return false
	end

	if not LuaUtil.tableNotEmpty(arg_14_0.canEndingBranch) then
		arg_14_0:failUnlockStep()

		return false
	end

	local var_14_1

	if LuaUtil.tableNotEmpty(arg_14_0.finalStepMo) then
		var_14_1 = arg_14_0.finalStepMo:getNextStep(var_14_0)
	end

	if var_14_1 and arg_14_0:checkNextStep(var_14_1) then
		local var_14_2 = {}

		arg_14_0:successUnlockStep(var_14_1, var_14_2)

		return true
	else
		arg_14_0:failUnlockStep()

		return false
	end
end

function var_0_0.checkNextStep(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0:unlockStepCount() + 1

	for iter_15_0, iter_15_1 in pairs(arg_15_0.canEndingBranch) do
		if arg_15_1 == iter_15_1[var_15_0] then
			return true
		end
	end
end

function var_0_0.setCanUnlockRound(arg_16_0)
	local var_16_0 = {}

	if not LuaUtil.tableNotEmpty(arg_16_0.unlockSteps) then
		return arg_16_0.endingAllBranch
	end

	for iter_16_0, iter_16_1 in pairs(arg_16_0.canEndingBranch) do
		if arg_16_0:isSameRound(iter_16_1, arg_16_0.unlockSteps) then
			table.insert(var_16_0, iter_16_1)
		end
	end

	arg_16_0.canEndingBranch = var_16_0
end

function var_0_0.isSameRound(arg_17_0, arg_17_1, arg_17_2)
	for iter_17_0 = 1, #arg_17_2 do
		if arg_17_1[iter_17_0] ~= arg_17_2[iter_17_0] then
			return false
		end
	end

	return true
end

function var_0_0.successUnlockStep(arg_18_0, arg_18_1, arg_18_2)
	if not arg_18_1 then
		return
	end

	arg_18_0:setSelectStepIndex()

	arg_18_0.finalStepMo = arg_18_0:getStepMo(arg_18_1)

	if not arg_18_0.finalStepMo then
		return
	end

	arg_18_0.finalStepMo:setUnlock(true)

	if not LuaUtil.tableContains(arg_18_0.unlockSteps, arg_18_1) then
		table.insert(arg_18_0.unlockSteps, arg_18_1)
	end

	arg_18_0:setCanUnlockRound()

	if Activity165Model.instance:isPrintLog() then
		arg_18_0:logCanRound()
	end

	table.insert(arg_18_2, arg_18_1)

	if arg_18_0:checkNextIsFixNext(arg_18_2) then
		-- block empty
	else
		Activity165Controller.instance:dispatchEvent(Activity165Event.OnFinishStep, arg_18_2)
	end
end

function var_0_0.logCanRound(arg_19_0)
	local var_19_0 = "当前步骤：" .. arg_19_0.finalStepMo.stepId .. "\n"

	for iter_19_0, iter_19_1 in pairs(arg_19_0.canEndingBranch) do
		for iter_19_2, iter_19_3 in pairs(iter_19_1) do
			var_19_0 = var_19_0 .. "#" .. iter_19_3
		end

		var_19_0 = var_19_0 .. "\n"
	end

	SLFramework.SLLogger.Log(var_19_0)
end

function var_0_0.checkNextIsFixNext(arg_20_0, arg_20_1)
	for iter_20_0, iter_20_1 in pairs(arg_20_0.canEndingBranch) do
		local var_20_0 = arg_20_0:unlockStepCount()
		local var_20_1 = iter_20_1[var_20_0]
		local var_20_2 = iter_20_1[var_20_0 + 1]
		local var_20_3 = arg_20_0:getStepMo(var_20_1)
		local var_20_4 = arg_20_0:getStepMo(var_20_2)
		local var_20_5 = var_20_2 and var_20_3.nextSteps[var_20_2]

		if var_20_4 and var_20_4.isEndingStep then
			arg_20_0:successUnlockStep(var_20_2, arg_20_1)

			return true
		end

		if var_20_5 then
			local var_20_6 = var_20_5.needKws

			if LuaUtil.tableNotEmpty(var_20_6) then
				for iter_20_2, iter_20_3 in pairs(var_20_6) do
					if not LuaUtil.tableNotEmpty(iter_20_3) then
						arg_20_0:successUnlockStep(var_20_2, arg_20_1)

						return true
					end
				end
			end
		end
	end
end

function var_0_0.failUnlockStep(arg_21_0)
	GameFacade.showToast(ToastEnum.Act165StepFillFail)
	AudioMgr.instance:trigger(AudioEnum.Activity156.play_ui_wangshi_fill_fail)
end

function var_0_0.getUnlockStepIdList(arg_22_0)
	return arg_22_0.unlockSteps
end

function var_0_0.getUnlockStepIdRemoveEnding(arg_23_0)
	local var_23_0 = {}

	if arg_23_0.reviewEnding then
		local var_23_1 = arg_23_0:getEndingStepInfo(arg_23_0.reviewEnding)

		for iter_23_0 = 1, #var_23_1 do
			local var_23_2 = arg_23_0:getStepMo(var_23_1[iter_23_0])

			if not var_23_2.isEndingStep and not var_23_2.isFirstStep then
				table.insert(var_23_0, var_23_2.stepId)
			end
		end
	else
		for iter_23_1, iter_23_2 in pairs(arg_23_0.unlockSteps) do
			local var_23_3 = arg_23_0:getStepMo(iter_23_2)

			if not var_23_3.isEndingStep and not var_23_3.isFirstStep then
				table.insert(var_23_0, var_23_3.stepId)
			end
		end
	end

	return var_23_0
end

function var_0_0.getEndingStepInfo(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0.unlockEndings[arg_24_1]
	local var_24_1 = {}
	local var_24_2 = {}
	local var_24_3 = arg_24_0:getFirstStepId()

	if var_24_0 then
		for iter_24_0, iter_24_1 in pairs(var_24_0) do
			var_24_1[iter_24_0] = iter_24_1.stepId
			var_24_2[iter_24_0] = iter_24_1.stepKeywords
			var_24_3 = iter_24_1.stepId
		end
	end

	return var_24_1, var_24_2, var_24_3
end

function var_0_0.getUnlockStepIdRemoveEndingCount(arg_25_0)
	return (tabletool.len(arg_25_0:getUnlockStepIdRemoveEnding()))
end

function var_0_0.unlockStepCount(arg_26_0)
	return tabletool.len(arg_26_0.unlockSteps)
end

function var_0_0.removeUnlockStep(arg_27_0, arg_27_1)
	table.remove(arg_27_0.unlockSteps, arg_27_1)
end

function var_0_0.setSelectStepIndex(arg_28_0, arg_28_1)
	arg_28_0.curStepIndex = arg_28_1

	arg_28_0:onResfreshKeywordState(arg_28_1)
end

function var_0_0.getSelectStepIndex(arg_29_0)
	return arg_29_0.curStepIndex
end

function var_0_0.getSelectStepMo(arg_30_0)
	return arg_30_0:getUnlockStepMoByIndex(arg_30_0.curStepIndex)
end

function var_0_0.getUnlockStepMoByIndex(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0.unlockSteps[arg_31_1]

	if var_31_0 then
		return arg_31_0:getStepMo(var_31_0)
	end
end

function var_0_0.isFillingStep(arg_32_0)
	return arg_32_0.curStepIndex == arg_32_0:unlockStepCount()
end

function var_0_0.resetStep(arg_33_0)
	local var_33_0 = {}
	local var_33_1 = arg_33_0:getFirstStepId()
	local var_33_2
	local var_33_3 = {}

	if arg_33_0.curStepIndex then
		for iter_33_0 = 1, arg_33_0.curStepIndex do
			var_33_1 = arg_33_0.unlockSteps[iter_33_0]
			var_33_3[iter_33_0] = arg_33_0.stepUseKeywords[iter_33_0]

			table.insert(var_33_0, var_33_1)
		end

		var_33_2 = arg_33_0.unlockSteps[arg_33_0.curStepIndex]
	else
		var_33_0 = arg_33_0.unlockSteps
	end

	arg_33_0.stepUseKeywords = var_33_3

	arg_33_0:setCurState(Activity165Enum.StoryStage.Filling)

	arg_33_0.unlockSteps = var_33_0
	arg_33_0.finalStepMo = arg_33_0:getStepMo(var_33_1)
	arg_33_0.canEndingBranch = arg_33_0.endingAllBranch

	arg_33_0:setCanUnlockRound()
	arg_33_0:saveStepUseKeywords()

	if var_33_2 then
		Activity165Rpc.instance:sendAct165RestartRequest(arg_33_0._actId, arg_33_0.storyId, var_33_2)
	end
end

function var_0_0.getFirstStepId(arg_34_0)
	return arg_34_0.firstStepMo.stepId
end

function var_0_0._initKeywordMo(arg_35_0)
	local var_35_0 = Activity165Config.instance:getStoryKeywordCoList(arg_35_0._actId, arg_35_0.storyId)

	arg_35_0.allKeywordMos = {}

	if var_35_0 then
		for iter_35_0, iter_35_1 in pairs(var_35_0) do
			local var_35_1 = Activity165KeywordMo.New()

			var_35_1:onInit(iter_35_1)

			arg_35_0.allKeywordMos[iter_35_1.keywordId] = var_35_1
		end
	end
end

function var_0_0.getKeywordList(arg_36_0)
	local var_36_0 = {}
	local var_36_1 = arg_36_0:getSelectStepMo()

	if var_36_1 then
		var_36_0 = var_36_1:getCanUseKeywords()
	end

	return var_36_0
end

function var_0_0.getKeywordMo(arg_37_0, arg_37_1)
	return arg_37_0.allKeywordMos[arg_37_1]
end

function var_0_0.onResfreshKeywordState(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_0:getKwIdsByStepIndex(arg_38_1)

	for iter_38_0, iter_38_1 in pairs(arg_38_0.allKeywordMos) do
		local var_38_1 = LuaUtil.tableContains(var_38_0, iter_38_1.keywordId)

		iter_38_1:setUsed(var_38_1)
	end
end

function var_0_0.fillKeyword(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0:getKwIdsByStepIndex(arg_39_0.curStepIndex)

	if not LuaUtil.tableContains(var_39_0, arg_39_1) then
		table.insert(var_39_0, arg_39_1)

		arg_39_0.stepUseKeywords[arg_39_0.curStepIndex] = var_39_0
	end

	arg_39_0.allKeywordMos[arg_39_1]:setUsed(true)
end

function var_0_0.removeUseKeywords(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_0:getKwIdsByStepIndex(arg_40_0.curStepIndex)

	if LuaUtil.tableContains(var_40_0, arg_40_1) then
		tabletool.removeValue(var_40_0, arg_40_1)

		arg_40_0.stepUseKeywords[arg_40_0.curStepIndex] = var_40_0
	end

	arg_40_0.allKeywordMos[arg_40_1]:setUsed(false)
end

function var_0_0.onModifyKeyword(arg_41_0, arg_41_1)
	Activity165Rpc.instance:sendAct165ModifyKeywordRequest(arg_41_0._actId, arg_41_0.storyId, arg_41_1 or {})
end

function var_0_0.onModifyKeywordCallback(arg_42_0, arg_42_1)
	return
end

function var_0_0.getKwIdsByStepIndex(arg_43_0, arg_43_1)
	local var_43_0 = {}

	if not arg_43_1 then
		return var_43_0
	end

	if arg_43_0.reviewEnding then
		var_43_0 = arg_43_0.reviewStepUseKeywords and arg_43_0.reviewStepUseKeywords[arg_43_1] or {}
	else
		var_43_0 = arg_43_0.stepUseKeywords and arg_43_0.stepUseKeywords[arg_43_1] or {}
	end

	return var_43_0
end

function var_0_0.generateStroy(arg_44_0)
	local var_44_0 = arg_44_0:getEndingCo()

	arg_44_0.curUnlockEndingId = var_44_0.endingId

	arg_44_0:setCurState(Activity165Enum.StoryStage.Ending)
	arg_44_0:UnlockEnding(var_44_0.endingId)
end

function var_0_0.getEndingCo(arg_45_0)
	local var_45_0 = arg_45_0.finalStepMo.stepId

	if arg_45_0.reviewEnding then
		local var_45_1, var_45_2, var_45_3 = arg_45_0:getEndingStepInfo(arg_45_0.reviewEnding)

		var_45_0 = var_45_3
	end

	return (Activity165Config.instance:getEndingCoByFinalStep(arg_45_0._actId, arg_45_0.storyId, var_45_0))
end

function var_0_0.getEndingText(arg_46_0)
	if arg_46_0.reviewEnding then
		local var_46_0, var_46_1, var_46_2 = arg_46_0:getEndingStepInfo(arg_46_0.reviewEnding)

		return arg_46_0:getStepMo(var_46_2).stepCo.text
	else
		if not arg_46_0.finalStepMo then
			return
		end

		if arg_46_0.finalStepMo.isEndingStep then
			return arg_46_0.finalStepMo.stepCo.text
		end

		logError("不是结局步骤  " .. arg_46_0.finalStepMo.stepId)
	end
end

function var_0_0.getState(arg_47_0)
	return arg_47_0.reviewEnding and Activity165Enum.StoryStage.Ending or arg_47_0.curStage
end

function var_0_0.UnlockEnding(arg_48_0, arg_48_1)
	local var_48_0 = {}

	for iter_48_0 = 1, #arg_48_0.unlockSteps do
		local var_48_1 = {
			stepId = arg_48_0.unlockSteps[iter_48_0],
			stepKeywords = arg_48_0.stepUseKeywords[iter_48_0]
		}

		table.insert(var_48_0, var_48_1)
	end

	arg_48_0._isShowDialog = arg_48_0.unlockEndings[arg_48_1] == nil
	arg_48_0.unlockEndings[arg_48_1] = var_48_0

	Activity165Rpc.instance:sendAct165GenerateEndingRequest(arg_48_0._actId, arg_48_0.storyId)

	arg_48_0.curUnlockEndingId = arg_48_1
end

function var_0_0.getUnlockEndingCount(arg_49_0)
	if LuaUtil.tableNotEmpty(arg_49_0.unlockEndings) then
		return tabletool.len(arg_49_0.unlockEndings)
	end

	return 0
end

function var_0_0.isShowDialog(arg_50_0)
	return arg_50_0._isShowDialog
end

function var_0_0.getAllEndingRewardCo(arg_51_0)
	return Activity165Config.instance:getStoryRewardCoList(arg_51_0._actId, arg_51_0.storyId)
end

function var_0_0.gmCreateEndingStep(arg_52_0)
	local var_52_0 = tabletool.copy(arg_52_0.endingAllBranch[1])

	table.remove(var_52_0, 1)

	arg_52_0.unlockSteps = var_52_0

	local var_52_1 = var_52_0[#var_52_0]

	arg_52_0.finalStepMo = arg_52_0:getStepMo(var_52_1)

	arg_52_0:checkIsFinishStroy()

	arg_52_0.curUnlockEndingId = Activity165Config.instance:getEndingCoByFinalStep(arg_52_0._actId, arg_52_0.storyId, var_52_1).endingId

	arg_52_0:setCurState(Activity165Enum.StoryStage.isEndFill)
	Activity165Controller.instance:dispatchEvent(Activity165Event.refrshEditView)
end

function var_0_0.getclaimRewardCount(arg_53_0)
	return arg_53_0.claimRewardCount
end

function var_0_0.setclaimRewardCount(arg_54_0, arg_54_1)
	arg_54_0.claimRewardCount = arg_54_1
end

function var_0_0.isFinish(arg_55_0)
	return arg_55_0:getUnlockEndingCount() > 0
end

function var_0_0._initElements(arg_56_0)
	arg_56_0._elements = {}

	if arg_56_0.storyCo then
		local var_56_0 = arg_56_0.storyCo.unlockElementIds1

		if not string.nilorempty(var_56_0) then
			local var_56_1 = string.splitToNumber(var_56_0, "#")

			tabletool.addValues(arg_56_0._elements, var_56_1)
		end

		local var_56_2 = arg_56_0.storyCo.unlockElementIds2

		if not string.nilorempty(var_56_2) then
			local var_56_3 = string.splitToNumber(var_56_2, "#")

			tabletool.addValues(arg_56_0._elements, var_56_3)
		end
	end
end

function var_0_0.getElements(arg_57_0)
	return arg_57_0._elements
end

function var_0_0.isShowReddot(arg_58_0)
	return arg_58_0._isNewUnlock or arg_58_0:_isShowRewardReddot()
end

function var_0_0._isShowRewardReddot(arg_59_0)
	return RedDotModel.instance:isDotShow(RedDotEnum.DotNode.Act165HasReward, arg_59_0.storyId)
end

function var_0_0.isNewUnlock(arg_60_0)
	return arg_60_0._isNewUnlock
end

function var_0_0.cancelNewUnlockStory(arg_61_0)
	if arg_61_0._isNewUnlock then
		arg_61_0._isNewUnlock = false

		GameUtil.playerPrefsSetNumberByUserId(arg_61_0:_getNewUnlockStoryKey(), 1)
	end
end

function var_0_0._checkNewUnlockStory(arg_62_0)
	if arg_62_0.isUnlock and GameUtil.playerPrefsGetNumberByUserId(arg_62_0:_getNewUnlockStoryKey(), 0) == 0 then
		arg_62_0._isNewUnlock = true

		return
	end

	arg_62_0._isNewUnlock = false
end

function var_0_0.saveStepUseKeywords(arg_63_0)
	local var_63_0 = ""

	for iter_63_0, iter_63_1 in pairs(arg_63_0.stepUseKeywords) do
		if iter_63_0 > 1 then
			var_63_0 = var_63_0 .. "|"
		end

		for iter_63_2, iter_63_3 in pairs(iter_63_1) do
			if iter_63_2 > 1 then
				var_63_0 = var_63_0 .. "#" .. iter_63_3
			else
				var_63_0 = var_63_0 .. iter_63_3
			end
		end
	end

	GameUtil.playerPrefsSetStringByUserId(arg_63_0:_getStepUseKeywordsKey(), var_63_0)
end

function var_0_0._getStepUseKeywords(arg_64_0)
	local var_64_0 = GameUtil.playerPrefsGetStringByUserId(arg_64_0:_getStepUseKeywordsKey(), "")
	local var_64_1 = {}

	if not string.nilorempty(var_64_0) then
		var_64_1 = GameUtil.splitString2(var_64_0, true)
	end

	return var_64_1
end

function var_0_0._getStepUseKeywordsKey(arg_65_0)
	return Activity165Model.instance:_getStoryPrefsKey("StepUseKeywords2", arg_65_0.storyId)
end

function var_0_0._getNewUnlockStoryKey(arg_66_0)
	return Activity165Model.instance:_getStoryPrefsKey("NewUnlockStory", arg_66_0.storyId)
end

return var_0_0
