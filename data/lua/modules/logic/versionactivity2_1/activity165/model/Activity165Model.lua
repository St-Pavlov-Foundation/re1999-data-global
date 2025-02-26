module("modules.logic.versionactivity2_1.activity165.model.Activity165Model", package.seeall)

slot0 = class("Activity165Model", BaseModel)

function slot0.onInit(slot0)
end

function slot0.onInitInfo(slot0)
	slot0._actId = VersionActivity2_1Enum.ActivityId.StoryDeduction

	if ActivityModel.instance:isActOnLine(slot0._actId) then
		Activity165Rpc.instance:sendAct165GetInfoRequest(slot0._actId)
	end
end

function slot0.onGetInfo(slot0, slot1, slot2)
	slot0._actId = slot1

	for slot6, slot7 in pairs(slot2) do
		if slot7.storyId then
			slot0:onGetStoryInfo(slot7)
		end
	end

	slot0:_initAllElements()
end

function slot0.getStoryCount(slot0)
	return 3
end

function slot0.onGetStoryInfo(slot0, slot1)
	slot0:setStoryMo(slot0._actId, slot1)
end

function slot0.onModifyKeywordCallback(slot0, slot1, slot2)
	slot0:getStoryMo(slot1, slot2.storyId):onModifyKeywordCallback(slot2)
end

function slot0.onGenerateEnding(slot0, slot1, slot2, slot3)
end

function slot0.setEndingRedDot(slot0, slot1)
	for slot6, slot7 in pairs(slot0:getStoryMo(slot0._actId, slot1).unlockEndings) do
		GameUtil.playerPrefsSetNumberByUserId(slot0:getEndingRedDotKey(slot6), 1)
	end
end

function slot0.isShowEndingRedDot(slot0, slot1)
	for slot6, slot7 in pairs(slot0:getStoryMo(slot0._actId, slot1).unlockEndings) do
		if GameUtil.playerPrefsGetNumberByUserId(slot0:getEndingRedDotKey(slot6), 0) == 0 then
			return true
		end
	end
end

function slot0.getEndingRedDotIndex(slot0)
	for slot4 = 1, slot0:getStoryCount() do
		if slot0:isShowEndingRedDot(slot4) then
			return slot4
		end
	end
end

function slot0.getEndingRedDotKey(slot0, slot1)
	return slot0:_getStoryPrefsKey("Ending", slot1)
end

function slot0._getStoryPrefsKey(slot0, slot1, slot2)
	return string.format("Activity165_%s_%s_%s", slot1, slot0._actId, slot2)
end

function slot0.onRestart(slot0, slot1, slot2)
	slot0:setStoryMo(slot1, slot2)
end

function slot0.onGetReward(slot0, slot1, slot2, slot3)
	slot0:getStoryMo(slot1, slot2):setclaimRewardCount(slot3)
end

function slot0.getActivityId(slot0)
	return slot0._actId or VersionActivity2_1Enum.ActivityId.StoryDeduction
end

function slot0.setStoryMo(slot0, slot1, slot2)
	slot0:getStoryMo(slot1, slot2.storyId):setMo(slot2)
end

function slot0.getStoryMo(slot0, slot1, slot2)
	if not slot0._storyMoDict then
		slot0._storyMoDict = {}
	end

	if not slot0._storyMoDict[slot1] then
		slot0._storyMoDict[slot1] = {}
	end

	if not slot0._storyMoDict[slot1][slot2] then
		slot3 = Activity165StoryMo.New()

		slot3:onInit(slot1, slot2)

		slot0._storyMoDict[slot1][slot2] = slot3
	end

	return slot3
end

function slot0.getAllActStory(slot0)
	return slot0._storyMoDict and slot0._storyMoDict[slot0._actId] or {}
end

function slot0.hasUnlockStory(slot0)
	if LuaUtil.tableNotEmpty(slot0:getAllActStory()) then
		for slot5, slot6 in pairs(slot1) do
			if slot6.isUnlock then
				return true
			end
		end
	end
end

function slot0.isHasUnlockEnding(slot0)
	if LuaUtil.tableNotEmpty(slot0:getAllActStory()) then
		for slot5, slot6 in pairs(slot1) do
			if slot6:getUnlockEndingCount() > 0 then
				return true
			end
		end
	end
end

function slot0._initAllElements(slot0)
	slot0._elements = {}

	if LuaUtil.tableNotEmpty(slot0:getAllActStory()) then
		for slot5, slot6 in pairs(slot1) do
			tabletool.addValues(slot0._elements, slot6:getElements())
		end
	end
end

function slot0.getAllElements(slot0)
	return slot0._elements
end

function slot0.isShowAct165Reddot(slot0)
	if slot0:getAllActStory() then
		for slot5, slot6 in pairs(slot1) do
			if slot6:isShowReddot() then
				return true
			end
		end
	end

	return false
end

function slot0.setSeparateChars(slot0, slot1)
	slot2 = {}

	if not string.nilorempty(slot1) then
		slot4 = ""

		for slot8 = 1, #string.split(slot1, "\n") do
			if not string.nilorempty(slot3[slot8]) then
				for slot13 = 1, #LuaUtil.getUCharArr(slot3[slot8]) do
					table.insert(slot2, slot4 .. slot9[slot13])
				end

				table.insert(slot2, slot4 .. "\n")
			end
		end
	end

	return slot2
end

function slot0.GMCheckConfig(slot0)
	for slot5, slot6 in pairs(lua_activity165_step.configDict) do
		if slot6.answersKeywordIds == "-1" then
			table.insert({}, slot6.stepId)
		end
	end

	slot0.allRounds = {}
	slot2 = {}

	for slot6, slot7 in pairs(lua_activity165_step.configDict) do
		if not string.nilorempty(slot7.nextStepConditionIds) then
			for slot12, slot13 in pairs(GameUtil.splitString2(slot7.nextStepConditionIds, true)) do
				if not slot0.allRounds[slot6] then
					slot0.allRounds[slot6] = {}
				end

				table.insert(slot0.allRounds[slot6], slot13)

				if not LuaUtil.tableContains(slot2, slot13[2]) then
					table.insert(slot2, slot13[2])
				end
			end
		end
	end

	slot0:GMCheckAllRounds()
end

function slot0.GMCheckAllRounds(slot0)
	for slot4, slot5 in pairs(slot0.allRounds) do
		slot0:GMCheckisSameRound1(slot4, slot5)
	end
end

function slot0.GMCheckisSameRound1(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot2) do
		if LuaUtil.tableNotEmpty(slot7) then
			if not slot0:GMCheckisSameRound2(slot1, slot7, slot7[1]) then
				SLFramework.SLLogger.LogError(string.format("跳转步骤错误: 当前检查：%s步骤%s,\n%s中通过%s的步骤有：\n%s", slot1, slot0:logRound(slot7), slot8, slot1, slot0:logRounds(slot0:GMNextRoundByLast(slot8, slot1))))
			elseif not slot0:GMCheckisSameRound4(slot1, slot7) then
				SLFramework.SLLogger.LogError(string.format("跳转步骤错误: 当前检查：%s步骤%s,请检查%s是否缺少这条路径", slot1, slot0:logRound(slot7), slot7[#slot7]))
			end
		end
	end
end

function slot0.GMCheckisSameRound2(slot0, slot1, slot2, slot3)
	if not slot0.allRounds[slot3] then
		if not Activity165Config.instance:getStepCo(slot0._actId, slot3) or slot5.answersKeywordIds ~= "-1" then
			SLFramework.SLLogger.LogError("跳转步骤错误 " .. slot1 .. "    " .. slot3)

			return false
		else
			return true
		end
	end

	for slot8, slot9 in pairs(slot4) do
		if slot0:GMCheckisSameRound3(2, slot2, slot9) then
			return true
		end
	end

	return false
end

function slot0.GMCheckisSameRound4(slot0, slot1, slot2)
	table.insert({}, slot1)

	slot4 = slot2[#slot2]

	for slot8 = 2, #slot2 - 1 do
		table.insert(slot3, slot2[slot8])
	end

	if slot0.allRounds[slot4] then
		for slot9, slot10 in pairs(slot5) do
			if slot0:GMCheckisSameRound3(1, slot3, slot10) then
				return true
			end
		end
	else
		return true
	end

	return false
end

function slot0.GMNextRoundByLast(slot0, slot1, slot2)
	slot4 = {}

	if slot0.allRounds[slot1] then
		for slot8, slot9 in pairs(slot3) do
			if slot9[#slot9] == slot2 then
				table.insert(slot4, slot9)
			end
		end
	end

	return slot4
end

function slot0.logRounds(slot0, slot1)
	for slot6, slot7 in pairs(slot1) do
		slot2 = "" .. "         " .. slot0:logRound(slot7)
	end

	return slot2
end

function slot0.logRound(slot0, slot1)
	for slot6, slot7 in pairs(slot1) do
		slot2 = "" .. "#" .. slot7
	end

	return slot2
end

function slot0.GMCheckisSameRound3(slot0, slot1, slot2, slot3)
	for slot7 = slot1, #slot2 do
		if slot2[slot7] ~= slot3[slot7] then
			return false
		end
	end

	return true
end

function slot0.isPrintLog(slot0)
	return slot0._isPrintLog
end

function slot0.setPrintLog(slot0, slot1)
	slot0._isPrintLog = slot1
end

function slot0.closeEditView(slot0)
end

slot0.instance = slot0.New()

return slot0
