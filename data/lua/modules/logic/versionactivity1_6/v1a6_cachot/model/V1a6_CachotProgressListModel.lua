module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotProgressListModel", package.seeall)

slot0 = class("V1a6_CachotProgressListModel", MixScrollModel)

function slot0.onInit(slot0)
	slot0._totalScore = nil
	slot0._weekScore = nil
	slot0._curStage = nil
	slot0._nextStageSecond = nil
	slot0._canReceiveRewardList = nil
	slot0._totalRewardCount = 0
end

function slot0.reInit(slot0)
	slot0:onInit()
end

function slot0.initDatas(slot0)
	slot0:onInit()
	slot0:buildProgressData()
	slot0:buildScrollList()
	slot0:checkDoubleStoreRefreshRed()
	slot0:checkRewardStageChangeRed()
end

function slot0.buildProgressData(slot0)
	slot0._totalScore = V1a6_CachotModel.instance:getRogueStateInfo() and slot1.totalScore or 0
	slot0._weekScore = slot1 and slot1.weekScore or 0
	slot0._curStage = slot1 and slot1.stage or 0
	slot0._nextStageSecond = slot1 and tonumber(slot1.nextStageSecond) or 0
	slot0._rewardStateMap = slot0:buildRewardsStateMap(slot1)
end

function slot0.buildRewardsStateMap(slot0, slot1)
	slot2 = {}
	slot3 = slot1 and slot1.getRewards
	slot0._canReceiveRewardList = {}
	slot0._totalRewardCount = 0
	slot0._unLockedRewardCount = 0

	if V1a6_CachotScoreConfig.instance:getConfigList() then
		for slot8, slot9 in ipairs(slot4) do
			slot10 = V1a6_CachotEnum.MilestonesState.Locked

			if slot9.stage <= slot0._curStage then
				if slot9.score <= slot0._totalScore then
					slot11 = tabletool.indexOf(slot3, slot9.id) ~= nil
					slot10 = slot11 and V1a6_CachotEnum.MilestonesState.HasReceived or V1a6_CachotEnum.MilestonesState.CanReceive

					if not slot11 then
						table.insert(slot0._canReceiveRewardList, slot9.id)
					end
				else
					slot10 = V1a6_CachotEnum.MilestonesState.UnFinish
				end

				slot0._unLockedRewardCount = slot0._unLockedRewardCount + 1
			end

			slot2[slot9.id] = slot10
			slot0._totalRewardCount = slot0._totalRewardCount + 1
		end
	end

	return slot2
end

function slot0.buildScrollList(slot0)
	if V1a6_CachotScoreConfig.instance:getConfigList() then
		slot2 = {}

		for slot6, slot7 in ipairs(slot1) do
			slot9 = slot0:getRewardState(slot7.id) == V1a6_CachotEnum.MilestonesState.Locked
			slot10 = V1a6_CachotProgressListMO.New()

			slot10:init(slot6, slot7.id, slot9)
			table.insert(slot2, slot10)

			if slot9 then
				break
			end
		end

		slot0:setList(slot2)
	end
end

slot1 = {
	Unlocked = 2,
	Locked = 1
}

function slot0.getInfoList(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in ipairs(slot0:getList()) do
		table.insert(slot2, SLFramework.UGUI.MixCellInfo.New(slot8.isLocked and uv0.Locked or uv0.Unlocked, slot8:getLineWidth(), slot7))
	end

	return slot2
end

function slot0.getCurGetTotalScore(slot0)
	return slot0._totalScore or 0
end

function slot0.getWeekScore(slot0)
	return slot0._weekScore or 0
end

function slot0.getCurrentStage(slot0)
	return slot0._curStage or 0
end

function slot0.getRewardState(slot0, slot1)
	if slot0._rewardStateMap then
		return slot0._rewardStateMap[slot1] or V1a6_CachotEnum.MilestonesState.Locked
	end
end

function slot0.getCurFinishRewardCount(slot0)
	slot2 = 0
	slot3 = slot0._canReceiveRewardList and #slot0._canReceiveRewardList or 0

	if V1a6_CachotModel.instance:getRogueStateInfo() and slot1.getRewards then
		slot2 = #slot1.getRewards
	end

	return slot3 + slot2
end

function slot0.getTotalRewardCount(slot0)
	return slot0._totalRewardCount or 0
end

function slot0.getUnLockedRewardCount(slot0)
	return slot0._unLockedRewardCount or 0
end

function slot0.isAllRewardUnLocked(slot0)
	return slot0:getTotalRewardCount() <= slot0:getUnLockedRewardCount()
end

function slot0.getHasFinishedMoList(slot0)
	slot1 = {}

	if slot0:getList() then
		for slot6, slot7 in pairs(slot2) do
			if slot0:getRewardState(slot7.id) == V1a6_CachotEnum.MilestonesState.HasReceived then
				table.insert(slot1, slot7)
			end
		end
	end

	return slot1
end

function slot0.getCanReceivePartIdList(slot0)
	return slot0._canReceiveRewardList
end

function slot0.getUnLockNextStageRemainTime(slot0)
	return slot0._nextStageSecond
end

function slot0.updateUnLockNextStageRemainTime(slot0, slot1)
	if slot0._nextStageSecond then
		slot0._nextStageSecond = slot0._nextStageSecond - (tonumber(slot1) or 0)
	end
end

function slot0.checkRed(slot0, slot1, slot2, slot3)
	table.insert({}, {
		id = slot1,
		value = slot2(slot0) and 1 or 0
	})

	if slot3 then
		table.insert(slot4, {
			id = slot3,
			value = slot5 and 1 or 0
		})
	end

	return slot4
end

function slot0.checkRewardStageChangeRed(slot0)
	RedDotRpc.instance:clientAddRedDotGroupList(slot0:checkRed(RedDotEnum.DotNode.V1a6RogueRewardStage, slot0.checkRewardStageChange) or {}, true)
end

function slot0.checkRewardStageChange(slot0)
	if slot0._curStage ~= nil then
		if PlayerPrefsHelper.getNumber(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityStageKey) .. PlayerPrefsKey.V1a6RogueRewardStage, 0) == 0 then
			PlayerPrefsHelper.setNumber(slot1, slot0._curStage)
		elseif slot2 < slot0._curStage then
			return true
		end
	end

	return false
end

function slot0.checkDoubleStoreRefreshRed(slot0)
	RedDotRpc.instance:clientAddRedDotGroupList(slot0:checkRed(RedDotEnum.DotNode.V1a6RogueDoubleScore, slot0.checkDoubleStoreRefresh) or {}, true)
end

function slot0.checkDoubleStoreRefresh(slot0)
	if slot0._weekScore ~= nil then
		if PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityStageKey) .. PlayerPrefsKey.V1a6RogueDoubleScore, "") == "" then
			PlayerPrefsHelper.setNumber(slot1, ServerTime.now())
		elseif slot0._weekScore == 0 and TimeUtil.OneDaySecond * 7 + slot3 < slot2 then
			return true
		end
	end

	return false
end

slot0.instance = slot0.New()

return slot0
