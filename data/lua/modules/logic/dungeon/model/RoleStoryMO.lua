module("modules.logic.dungeon.model.RoleStoryMO", package.seeall)

slot0 = pureTable("RoleStoryMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1
	slot0.progress = 0
	slot0.getReward = false
	slot0.cfg = RoleStoryConfig.instance:getStoryById(slot1)
	slot0.order = slot0.cfg.order
	slot0.maxProgress, slot0.episodeCount = slot0:caleMaxProgress()
	slot0.hasUnlock = false
	slot0.startTime = 0
	slot0.endTime = 0
	slot0.startTimeResident = 0
	slot0.endTimeResident = 0
	slot0.rewards = GameUtil.splitString2(slot0.cfg.bonus, true)
	slot0.getScoreBonus = {}
	slot0.score = 0
	slot0.addscore = 0
	slot0.wave = 0
	slot0.maxWave = 1
	slot0.getChallengeReward = false

	slot0:refreshOrder()

	slot0.dispatchDict = {}
	slot0._dispatchHeroDict = {}
end

function slot0.getCost(slot0)
	if slot0:isActTime() then
		slot1 = string.splitToNumber(slot0.cfg.unlock, "#")

		return slot1[1], slot1[2], slot1[3]
	end

	slot1 = string.splitToNumber(slot0.cfg.permanentUnlock, "#")

	return slot1[1], slot1[2], slot1[3]
end

function slot0.updateInfo(slot0, slot1)
	slot0.progress = slot1.progress
	slot0.getReward = slot1.getReward
	slot0.hasUnlock = slot1.unlock
	slot0.getScoreBonus = {}
	slot5 = slot1.getScoreBonus

	slot0:addScoreBonus(slot5)

	slot0.score = slot1.score
	slot0.wave = slot1.challengeWave
	slot0.maxWave = slot1.challengeMaxWave
	slot0.getChallengeReward = slot1.getChallengeReward

	slot0:refreshOrder()

	slot0.dispatchDict = {}

	for slot5 = 1, #slot1.dispatchInfos do
		slot0:updateDispatch(slot1.dispatchInfos[slot5])
	end

	slot0:updateDispatchHeroDict()
end

function slot0.updateDispatch(slot0, slot1)
	if not slot1 then
		return
	end

	slot0:getDispatchMo(slot1.id):updateInfo(slot1)
end

function slot0.updateDispatchTime(slot0, slot1)
	if not slot1 then
		return
	end

	slot7 = slot1

	slot0:getDispatchMo(slot1.dispatchId):updateTime(slot7)

	for slot7 = 1, #slot1.dispatchInfos do
		slot0:updateDispatch(slot1.dispatchInfos[slot7])
	end

	slot0:updateDispatchHeroDict()
end

function slot0.resetDispatch(slot0, slot1)
	slot0:getDispatchMo(slot1.dispatchId):resetDispatch()
	slot0:updateDispatchHeroDict()
end

function slot0.completeDispatch(slot0, slot1)
	slot0:getDispatchMo(slot1.dispatchId):completeDispatch()
	slot0:updateDispatchHeroDict()
end

function slot0.updateTime(slot0, slot1)
	slot0.startTime = slot1.startTime
	slot0.endTime = slot1.endTime
	slot0.startTimeResident = slot1.startTimeResident
	slot0.endTimeResident = slot1.endTimeResident
end

function slot0.updateScore(slot0, slot1)
	slot0.addscore = slot1.score - slot0.score
	slot0.score = slot1.score
	slot0.wave = slot1.wave
	slot0.maxWave = slot1.maxWave
end

function slot0.refreshOrder(slot0)
	slot0.getRewardOrder = slot0.getReward and 0 or 1
end

function slot0.caleMaxProgress(slot0)
	slot3 = 0
	slot4 = 0

	if DungeonConfig.instance:getChapterEpisodeCOList(slot0.cfg.chapterId) then
		for slot8, slot9 in ipairs(slot2) do
			slot3 = slot3 + 1
			slot4 = slot4 + 1
		end
	end

	return slot3, slot4
end

function slot0.canGetReward(slot0)
	if not slot0.hasUnlock then
		return false
	end

	if slot0.getReward then
		return false
	end

	if slot0.progress and slot0.maxProgress then
		return slot0.maxProgress <= slot0.progress
	end

	return false
end

function slot0.getActTime(slot0)
	return slot0.startTime, slot0.endTime
end

function slot0.getResidentTime(slot0)
	return slot0.startTimeResident, slot0.endTimeResident
end

function slot0.isActTime(slot0)
	return slot0.startTime <= ServerTime.now() and slot1 <= slot0.endTime
end

function slot0.isResidentTime(slot0)
	return slot0.startTimeResident <= ServerTime.now() and slot1 <= slot0.endTimeResident
end

function slot0.addScoreBonus(slot0, slot1)
	if slot1 then
		for slot5 = 1, #slot1 do
			slot0.getScoreBonus[slot1[slot5]] = true
		end
	end
end

function slot0.isBonusHasGet(slot0, slot1)
	return slot0.getScoreBonus[slot1]
end

function slot0.getScore(slot0)
	return slot0.score
end

function slot0.getAddScore(slot0)
	return slot0.addscore
end

function slot0.hasScoreReward(slot0)
	slot1 = false

	if RoleStoryConfig.instance:getRewardList(slot0.id) then
		for slot6, slot7 in ipairs(slot2) do
			if slot7.score <= slot0.score and not slot0:isBonusHasGet(slot7.id) then
				slot1 = true

				break
			end
		end
	end

	return slot1
end

function slot0.getDispatchMo(slot0, slot1)
	if not slot0.dispatchDict[slot1] then
		slot2 = RoleStoryDispatchMO.New()

		slot2:init(slot1, slot0.id)

		slot0.dispatchDict[slot1] = slot2
	end

	return slot2
end

function slot0.getDispatchState(slot0, slot1)
	if slot0:getDispatchMo(slot1) then
		return slot2:getDispatchState()
	end
end

function slot0.getNormalDispatchList(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0.dispatchDict) do
		if slot6.config.type == RoleStoryEnum.DispatchType.Normal then
			table.insert(slot1, slot6)
		end
	end

	return slot1
end

function slot0.isScoreFull(slot0)
	if not (RoleStoryConfig.instance:getRewardList(slot0.id) and slot1[#slot1]) then
		return true
	end

	return slot2.score <= slot0.score
end

function slot0.updateDispatchHeroDict(slot0)
	slot0._dispatchHeroDict = {}

	for slot4, slot5 in pairs(slot0.dispatchDict) do
		if slot5:getDispatchState() ~= RoleStoryEnum.DispatchState.Finish then
			for slot9, slot10 in pairs(slot5.heroIds) do
				slot0._dispatchHeroDict[slot10] = true
			end
		end
	end
end

function slot0.isHeroDispatching(slot0, slot1)
	return slot0._dispatchHeroDict[slot1]
end

function slot0.hasNewDispatchFinish(slot0)
	slot1 = false

	for slot5, slot6 in pairs(slot0.dispatchDict) do
		if slot6:isNewFinish() then
			slot1 = true
		end
	end

	return slot1
end

function slot0.canPlayNormalDispatchUnlockAnim(slot0)
	return PlayerPrefsHelper.getNumber(string.format("%s_%s_%s", PlayerModel.instance:getMyUserId(), PlayerPrefsKey.RoleStoryDispatchUnlockAnim, slot0.id), 0) == 0
end

function slot0.setPlayNormalDispatchUnlockAnimFlag(slot0)
	PlayerPrefsHelper.setNumber(string.format("%s_%s_%s", PlayerModel.instance:getMyUserId(), PlayerPrefsKey.RoleStoryDispatchUnlockAnim, slot0.id), 1)
end

return slot0
