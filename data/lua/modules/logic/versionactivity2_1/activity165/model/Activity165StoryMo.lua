module("modules.logic.versionactivity2_1.activity165.model.Activity165StoryMo", package.seeall)

slot0 = class("Activity165StoryMo")

function slot0.ctor(slot0)
	slot0._actId = nil
	slot0.storyId = nil
	slot0.storyCo = nil
	slot0.isUnlock = nil
	slot0._isNewUnlock = nil
	slot0.allKeywordMos = nil
	slot0.stepMoDic = nil
	slot0.unlockSteps = nil
	slot0.firstStepMo = nil
	slot0.finalStepMo = nil
	slot0.curStepIndex = nil
	slot0.stepUseKeywords = nil
	slot0.unlockEndings = nil
	slot0.claimRewardCount = nil
	slot0.endingAllBranch = nil
	slot0.canEndingBranch = nil
	slot0.curUnlockEndingId = nil
	slot0._isShowDialog = nil
	slot0.curStage = nil
	slot0.reviewEnding = nil
	slot0._elements = nil
end

function slot0.onInit(slot0, slot1, slot2)
	slot0._actId = slot1
	slot0.storyId = slot2
	slot0.storyCo = Activity165Config.instance:getStoryCo(slot1, slot2)
	slot0.unlockSteps = {}
	slot0.stepMoDic = {}
	slot0.unlockEndings = {}
	slot0.endingAllBranch = {}
	slot0.canEndingBranch = {}

	slot0:_initKeywordMo()
	slot0:_initStepMo(slot1, slot2)
	slot0:_initElements()
end

function slot0.setMo(slot0, slot1)
	slot0.reviewEnding = nil
	slot2 = slot1 and slot1.storyState == 1

	if not slot0.isUnlock and slot2 and slot0._isInit then
		GameFacade.showToast(ToastEnum.Act165StoryUnlock, slot0:getStoryName())
	end

	slot0.isUnlock = slot2
	slot0._isInit = true
	slot0.unlockEndings = {}
	slot0.claimRewardCount = slot1.gainedEndingCount or 0
	slot0.stepUseKeywords = slot0:_getStepUseKeywords()

	slot0:setCurState(slot1.inferState or 0)

	for slot6 = 1, #slot1.unlockEndingInfos do
		slot8 = {}

		for slot12 = 1, #slot1.unlockEndingInfos[slot6].inferredSteps do
			slot13 = slot7.inferredSteps[slot12]

			table.insert(slot8, {
				stepId = slot13.stepId,
				stepKeywords = slot0:getStepKws(slot13.stepKeywords)
			})
		end

		slot0.unlockEndings[slot7.endingId] = slot8
	end

	slot0.unlockSteps = {}
	slot4 = nil

	for slot8 = 1, #slot1.inferredSteps do
		slot9 = slot1.inferredSteps[slot8].stepId

		table.insert(slot0.unlockSteps, slot9)

		slot4 = slot9
		slot11 = {}

		if #slot1.inferredSteps[slot8].stepKeywords > 0 then
			for slot15 = 1, #slot10 do
				table.insert(slot11, slot10[slot15])
			end
		else
			slot11 = slot0.stepUseKeywords[slot3]
		end

		slot0.stepUseKeywords[slot8] = slot11
	end

	slot0.stepUseKeywords[slot3] = slot0.stepUseKeywords[slot3] or {}
	slot0.finalStepMo = slot0.firstStepMo

	if LuaUtil.tableNotEmpty(slot0.unlockSteps) then
		if slot4 ~= 0 then
			slot0.finalStepMo = slot0.stepMoDic[slot4]
		end

		slot0:checkIsFinishStroy()
	end

	slot0:setCanUnlockRound()
	slot0:_checkNewUnlockStory()
end

function slot0.getStepKws(slot0, slot1)
	slot2 = {}

	for slot6 = 1, #slot1 do
		table.insert(slot2, slot1[slot6])
	end

	return slot2
end

function slot0.getStoryName(slot0, slot1)
	if slot1 then
		return GameUtil.getSubPlaceholderLuaLangOneParam(luaLang(GameUtil.getSubPlaceholderLuaLangTwoParam("act126_story_name_change_size_▩1%s_▩2%s", slot0._actId, slot0.storyId)), slot1)
	elseif slot0.storyCo then
		return slot0.storyCo.name
	end
end

function slot0.getStoryFirstStepMo(slot0)
	return slot0.firstStepMo
end

function slot0.setReviewEnding(slot0, slot1)
	slot0.reviewEnding = slot1

	if slot1 then
		slot2, slot0.reviewStepUseKeywords = slot0:getEndingStepInfo(slot0.reviewEnding)
	end
end

function slot0.onRestart(slot0)
	slot0.finalStepList = {}
	slot0.unlockSteps = {}
	slot0.stepUseKeywords = {}

	for slot4, slot5 in pairs(slot0.stepMoDic) do
		slot5:onReset()
	end

	for slot4, slot5 in pairs(slot0.allKeywordMos) do
		slot5:onReset()
	end

	slot0.canEndingBranch = slot0.endingAllBranch
	slot0.finalStepMo = slot0.firstStepMo

	slot0:setCurState(Activity165Enum.StoryStage.Filling)

	slot0.reviewEnding = nil

	slot0:saveStepUseKeywords()
end

function slot0.checkIsFinishStroy(slot0)
	if slot0.finalStepMo.isEndingStep then
		slot0:setSelectStepIndex()

		if slot0.curStage == Activity165Enum.StoryStage.Filling then
			slot0:finishStroy()
		elseif slot0.curStage == Activity165Enum.StoryStage.Ending then
			slot0.curUnlockEndingId = slot0:getEndingCo().endingId
		end
	end

	return slot1
end

function slot0.finishStroy(slot0)
	slot0:setCurState(Activity165Enum.StoryStage.isEndFill)
	Activity165Controller.instance:dispatchEvent(Activity165Event.canfinishStory)
end

function slot0.setCurState(slot0, slot1)
	slot0.curStage = slot1
end

function slot0._initStepMo(slot0, slot1, slot2)
	slot3 = Activity165Config.instance:getStoryStepCoList(slot1, slot2)

	if not slot0.storyCo then
		return
	end

	slot4 = slot0.storyCo.firstStepId
	slot5 = {}

	if slot3 then
		for slot9, slot10 in pairs(slot3) do
			slot11 = Activity165StepMo.New()

			slot11:onInit(slot0._actId, slot10.stepId, slot0)

			slot0.stepMoDic[slot10.stepId] = slot11

			if slot11.isEndingStep then
				table.insert(slot5, slot10.stepId)
			end
		end

		for slot9, slot10 in pairs(slot0.stepMoDic) do
			if LuaUtil.tableNotEmpty(slot10:getCanEndingRound(slot5)) then
				tabletool.addValues(slot0.endingAllBranch, tabletool.copy(slot11))
			end
		end

		slot0.firstStepMo = slot0.stepMoDic[slot4]
		slot0.firstStepMo.isFirstStep = true
	end

	slot0.canEndingBranch = slot0.endingAllBranch
end

function slot0.getStepMo(slot0, slot1)
	return slot0.stepMoDic[slot1]
end

function slot0.checkIsFinishStep(slot0)
	slot1 = slot0:getKwIdsByStepIndex(slot0.curStepIndex)

	slot0:onModifyKeyword(slot1)

	if not LuaUtil.tableNotEmpty(slot1) then
		return false
	end

	if not LuaUtil.tableNotEmpty(slot0.canEndingBranch) then
		slot0:failUnlockStep()

		return false
	end

	slot2 = nil

	if LuaUtil.tableNotEmpty(slot0.finalStepMo) then
		slot2 = slot0.finalStepMo:getNextStep(slot1)
	end

	if slot2 and slot0:checkNextStep(slot2) then
		slot0:successUnlockStep(slot2, {})

		return true
	else
		slot0:failUnlockStep()

		return false
	end
end

function slot0.checkNextStep(slot0, slot1)
	for slot6, slot7 in pairs(slot0.canEndingBranch) do
		if slot1 == slot7[slot0:unlockStepCount() + 1] then
			return true
		end
	end
end

function slot0.setCanUnlockRound(slot0)
	slot1 = {}

	if not LuaUtil.tableNotEmpty(slot0.unlockSteps) then
		return slot0.endingAllBranch
	end

	for slot5, slot6 in pairs(slot0.canEndingBranch) do
		if slot0:isSameRound(slot6, slot0.unlockSteps) then
			table.insert(slot1, slot6)
		end
	end

	slot0.canEndingBranch = slot1
end

function slot0.isSameRound(slot0, slot1, slot2)
	for slot6 = 1, #slot2 do
		if slot1[slot6] ~= slot2[slot6] then
			return false
		end
	end

	return true
end

function slot0.successUnlockStep(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	slot0:setSelectStepIndex()

	slot0.finalStepMo = slot0:getStepMo(slot1)

	if not slot0.finalStepMo then
		return
	end

	slot0.finalStepMo:setUnlock(true)

	if not LuaUtil.tableContains(slot0.unlockSteps, slot1) then
		table.insert(slot0.unlockSteps, slot1)
	end

	slot0:setCanUnlockRound()

	if Activity165Model.instance:isPrintLog() then
		slot0:logCanRound()
	end

	table.insert(slot2, slot1)

	if not slot0:checkNextIsFixNext(slot2) then
		Activity165Controller.instance:dispatchEvent(Activity165Event.OnFinishStep, slot2)
	end
end

function slot0.logCanRound(slot0)
	slot1 = "当前步骤：" .. slot0.finalStepMo.stepId .. "\n"

	for slot5, slot6 in pairs(slot0.canEndingBranch) do
		for slot10, slot11 in pairs(slot6) do
			slot1 = slot1 .. "#" .. slot11
		end

		slot1 = slot1 .. "\n"
	end

	SLFramework.SLLogger.Log(slot1)
end

function slot0.checkNextIsFixNext(slot0, slot1)
	for slot5, slot6 in pairs(slot0.canEndingBranch) do
		slot7 = slot0:unlockStepCount()
		slot9 = slot6[slot7 + 1]
		slot12 = slot9 and slot0:getStepMo(slot6[slot7]).nextSteps[slot9]

		if slot0:getStepMo(slot9) and slot11.isEndingStep then
			slot0:successUnlockStep(slot9, slot1)

			return true
		end

		if slot12 and LuaUtil.tableNotEmpty(slot12.needKws) then
			for slot17, slot18 in pairs(slot13) do
				if not LuaUtil.tableNotEmpty(slot18) then
					slot0:successUnlockStep(slot9, slot1)

					return true
				end
			end
		end
	end
end

function slot0.failUnlockStep(slot0)
	GameFacade.showToast(ToastEnum.Act165StepFillFail)
	AudioMgr.instance:trigger(AudioEnum.Activity156.play_ui_wangshi_fill_fail)
end

function slot0.getUnlockStepIdList(slot0)
	return slot0.unlockSteps
end

function slot0.getUnlockStepIdRemoveEnding(slot0)
	slot1 = {}

	if slot0.reviewEnding then
		for slot6 = 1, #slot0:getEndingStepInfo(slot0.reviewEnding) do
			if not slot0:getStepMo(slot2[slot6]).isEndingStep and not slot7.isFirstStep then
				table.insert(slot1, slot7.stepId)
			end
		end
	else
		for slot5, slot6 in pairs(slot0.unlockSteps) do
			if not slot0:getStepMo(slot6).isEndingStep and not slot7.isFirstStep then
				table.insert(slot1, slot7.stepId)
			end
		end
	end

	return slot1
end

function slot0.getEndingStepInfo(slot0, slot1)
	slot3 = {}
	slot4 = {}
	slot5 = slot0:getFirstStepId()

	if slot0.unlockEndings[slot1] then
		for slot9, slot10 in pairs(slot2) do
			slot3[slot9] = slot10.stepId
			slot4[slot9] = slot10.stepKeywords
			slot5 = slot10.stepId
		end
	end

	return slot3, slot4, slot5
end

function slot0.getUnlockStepIdRemoveEndingCount(slot0)
	return tabletool.len(slot0:getUnlockStepIdRemoveEnding())
end

function slot0.unlockStepCount(slot0)
	return tabletool.len(slot0.unlockSteps)
end

function slot0.removeUnlockStep(slot0, slot1)
	table.remove(slot0.unlockSteps, slot1)
end

function slot0.setSelectStepIndex(slot0, slot1)
	slot0.curStepIndex = slot1

	slot0:onResfreshKeywordState(slot1)
end

function slot0.getSelectStepIndex(slot0)
	return slot0.curStepIndex
end

function slot0.getSelectStepMo(slot0)
	return slot0:getUnlockStepMoByIndex(slot0.curStepIndex)
end

function slot0.getUnlockStepMoByIndex(slot0, slot1)
	if slot0.unlockSteps[slot1] then
		return slot0:getStepMo(slot2)
	end
end

function slot0.isFillingStep(slot0)
	return slot0.curStepIndex == slot0:unlockStepCount()
end

function slot0.resetStep(slot0)
	slot1 = {}
	slot2 = slot0:getFirstStepId()
	slot3 = nil
	slot4 = {}

	if slot0.curStepIndex then
		for slot8 = 1, slot0.curStepIndex do
			slot4[slot8] = slot0.stepUseKeywords[slot8]

			table.insert(slot1, slot0.unlockSteps[slot8])
		end

		slot3 = slot0.unlockSteps[slot0.curStepIndex]
	else
		slot1 = slot0.unlockSteps
	end

	slot0.stepUseKeywords = slot4

	slot0:setCurState(Activity165Enum.StoryStage.Filling)

	slot0.unlockSteps = slot1
	slot0.finalStepMo = slot0:getStepMo(slot2)
	slot0.canEndingBranch = slot0.endingAllBranch

	slot0:setCanUnlockRound()
	slot0:saveStepUseKeywords()

	if slot3 then
		Activity165Rpc.instance:sendAct165RestartRequest(slot0._actId, slot0.storyId, slot3)
	end
end

function slot0.getFirstStepId(slot0)
	return slot0.firstStepMo.stepId
end

function slot0._initKeywordMo(slot0)
	slot0.allKeywordMos = {}

	if Activity165Config.instance:getStoryKeywordCoList(slot0._actId, slot0.storyId) then
		for slot5, slot6 in pairs(slot1) do
			slot7 = Activity165KeywordMo.New()

			slot7:onInit(slot6)

			slot0.allKeywordMos[slot6.keywordId] = slot7
		end
	end
end

function slot0.getKeywordList(slot0)
	slot1 = {}

	if slot0:getSelectStepMo() then
		slot1 = slot2:getCanUseKeywords()
	end

	return slot1
end

function slot0.getKeywordMo(slot0, slot1)
	return slot0.allKeywordMos[slot1]
end

function slot0.onResfreshKeywordState(slot0, slot1)
	for slot6, slot7 in pairs(slot0.allKeywordMos) do
		slot7:setUsed(LuaUtil.tableContains(slot0:getKwIdsByStepIndex(slot1), slot7.keywordId))
	end
end

function slot0.fillKeyword(slot0, slot1)
	if not LuaUtil.tableContains(slot0:getKwIdsByStepIndex(slot0.curStepIndex), slot1) then
		table.insert(slot2, slot1)

		slot0.stepUseKeywords[slot0.curStepIndex] = slot2
	end

	slot0.allKeywordMos[slot1]:setUsed(true)
end

function slot0.removeUseKeywords(slot0, slot1)
	if LuaUtil.tableContains(slot0:getKwIdsByStepIndex(slot0.curStepIndex), slot1) then
		tabletool.removeValue(slot2, slot1)

		slot0.stepUseKeywords[slot0.curStepIndex] = slot2
	end

	slot0.allKeywordMos[slot1]:setUsed(false)
end

function slot0.onModifyKeyword(slot0, slot1)
	Activity165Rpc.instance:sendAct165ModifyKeywordRequest(slot0._actId, slot0.storyId, slot1 or {})
end

function slot0.onModifyKeywordCallback(slot0, slot1)
end

function slot0.getKwIdsByStepIndex(slot0, slot1)
	if not slot1 then
		return {}
	end

	return slot0.reviewEnding and (slot0.reviewStepUseKeywords and slot0.reviewStepUseKeywords[slot1] or {}) or slot0.stepUseKeywords and slot0.stepUseKeywords[slot1] or {}
end

function slot0.generateStroy(slot0)
	slot1 = slot0:getEndingCo()
	slot0.curUnlockEndingId = slot1.endingId

	slot0:setCurState(Activity165Enum.StoryStage.Ending)
	slot0:UnlockEnding(slot1.endingId)
end

function slot0.getEndingCo(slot0)
	slot1 = slot0.finalStepMo.stepId

	if slot0.reviewEnding then
		slot2, slot3, slot1 = slot0:getEndingStepInfo(slot0.reviewEnding)
	end

	return Activity165Config.instance:getEndingCoByFinalStep(slot0._actId, slot0.storyId, slot1)
end

function slot0.getEndingText(slot0)
	if slot0.reviewEnding then
		slot1, slot2, slot3 = slot0:getEndingStepInfo(slot0.reviewEnding)

		return slot0:getStepMo(slot3).stepCo.text
	else
		if not slot0.finalStepMo then
			return
		end

		if slot0.finalStepMo.isEndingStep then
			return slot0.finalStepMo.stepCo.text
		end

		logError("不是结局步骤  " .. slot0.finalStepMo.stepId)
	end
end

function slot0.getState(slot0)
	return slot0.reviewEnding and Activity165Enum.StoryStage.Ending or slot0.curStage
end

function slot0.UnlockEnding(slot0, slot1)
	slot2 = {}

	for slot6 = 1, #slot0.unlockSteps do
		table.insert(slot2, {
			stepId = slot0.unlockSteps[slot6],
			stepKeywords = slot0.stepUseKeywords[slot6]
		})
	end

	slot0._isShowDialog = slot0.unlockEndings[slot1] == nil
	slot0.unlockEndings[slot1] = slot2

	Activity165Rpc.instance:sendAct165GenerateEndingRequest(slot0._actId, slot0.storyId)

	slot0.curUnlockEndingId = slot1
end

function slot0.getUnlockEndingCount(slot0)
	if LuaUtil.tableNotEmpty(slot0.unlockEndings) then
		return tabletool.len(slot0.unlockEndings)
	end

	return 0
end

function slot0.isShowDialog(slot0)
	return slot0._isShowDialog
end

function slot0.getAllEndingRewardCo(slot0)
	return Activity165Config.instance:getStoryRewardCoList(slot0._actId, slot0.storyId)
end

function slot0.gmCreateEndingStep(slot0)
	slot1 = tabletool.copy(slot0.endingAllBranch[1])

	table.remove(slot1, 1)

	slot0.unlockSteps = slot1
	slot2 = slot1[#slot1]
	slot0.finalStepMo = slot0:getStepMo(slot2)

	slot0:checkIsFinishStroy()

	slot0.curUnlockEndingId = Activity165Config.instance:getEndingCoByFinalStep(slot0._actId, slot0.storyId, slot2).endingId

	slot0:setCurState(Activity165Enum.StoryStage.isEndFill)
	Activity165Controller.instance:dispatchEvent(Activity165Event.refrshEditView)
end

function slot0.getclaimRewardCount(slot0)
	return slot0.claimRewardCount
end

function slot0.setclaimRewardCount(slot0, slot1)
	slot0.claimRewardCount = slot1
end

function slot0.isFinish(slot0)
	return slot0:getUnlockEndingCount() > 0
end

function slot0._initElements(slot0)
	slot0._elements = {}

	if slot0.storyCo then
		if not string.nilorempty(slot0.storyCo.unlockElementIds1) then
			tabletool.addValues(slot0._elements, string.splitToNumber(slot1, "#"))
		end

		if not string.nilorempty(slot0.storyCo.unlockElementIds2) then
			tabletool.addValues(slot0._elements, string.splitToNumber(slot2, "#"))
		end
	end
end

function slot0.getElements(slot0)
	return slot0._elements
end

function slot0.isShowReddot(slot0)
	return slot0._isNewUnlock or slot0:_isShowRewardReddot()
end

function slot0._isShowRewardReddot(slot0)
	return RedDotModel.instance:isDotShow(RedDotEnum.DotNode.Act165HasReward, slot0.storyId)
end

function slot0.isNewUnlock(slot0)
	return slot0._isNewUnlock
end

function slot0.cancelNewUnlockStory(slot0)
	if slot0._isNewUnlock then
		slot0._isNewUnlock = false

		GameUtil.playerPrefsSetNumberByUserId(slot0:_getNewUnlockStoryKey(), 1)
	end
end

function slot0._checkNewUnlockStory(slot0)
	if slot0.isUnlock and GameUtil.playerPrefsGetNumberByUserId(slot0:_getNewUnlockStoryKey(), 0) == 0 then
		slot0._isNewUnlock = true

		return
	end

	slot0._isNewUnlock = false
end

function slot0.saveStepUseKeywords(slot0)
	for slot5, slot6 in pairs(slot0.stepUseKeywords) do
		if slot5 > 1 then
			slot1 = "" .. "|"
		end

		for slot10, slot11 in pairs(slot6) do
			slot1 = slot10 > 1 and slot1 .. "#" .. slot11 or slot1 .. "#" .. slot11 .. slot11
		end
	end

	GameUtil.playerPrefsSetStringByUserId(slot0:_getStepUseKeywordsKey(), slot1)
end

function slot0._getStepUseKeywords(slot0)
	slot2 = {}

	if not string.nilorempty(GameUtil.playerPrefsGetStringByUserId(slot0:_getStepUseKeywordsKey(), "")) then
		slot2 = GameUtil.splitString2(slot1, true)
	end

	return slot2
end

function slot0._getStepUseKeywordsKey(slot0)
	return Activity165Model.instance:_getStoryPrefsKey("StepUseKeywords2", slot0.storyId)
end

function slot0._getNewUnlockStoryKey(slot0)
	return Activity165Model.instance:_getStoryPrefsKey("NewUnlockStory", slot0.storyId)
end

return slot0
