module("modules.logic.versionactivity1_6.v1a6_cachot.model.V1a6_CachotModel", package.seeall)

slot0 = class("V1a6_CachotModel", BaseModel)

function slot0.onInit(slot0)
	slot0._rogueStateInfo = nil
	slot0._rogueInfo = nil
	slot0._goodsInfos = nil
	slot0._rogueEndingInfo = nil
end

function slot0.reInit(slot0)
	slot0:onInit()
end

function slot0.getRogueStateInfo(slot0)
	return slot0._rogueStateInfo
end

function slot0.getRogueInfo(slot0)
	return slot0._rogueInfo
end

function slot0.getGoodsInfos(slot0)
	return slot0._goodsInfos
end

function slot0.getTeamInfo(slot0)
	if not slot0._rogueInfo then
		return
	end

	return slot0._rogueInfo.teamInfo
end

function slot0.getRogueEndingInfo(slot0)
	return slot0._rogueEndingInfo
end

function slot0.clearRogueInfo(slot0)
	slot0._rogueInfo = nil

	V1a6_CachotRoomModel.instance:clear()
end

function slot0.updateRogueStateInfo(slot0, slot1)
	slot0._rogueStateInfo = slot0._rogueStateInfo or RogueStateInfoMO.New()

	slot0._rogueStateInfo:init(slot1)
	V1a6_CachotStatController.instance:recordInitHeroGroup()
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnUpdateRogueStateInfo)
end

function slot0.isInRogue(slot0)
	if slot0._rogueInfo then
		return not slot0._rogueInfo.isFinish
	end

	return slot0._rogueStateInfo and slot0._rogueStateInfo.start
end

function slot0.updateRogueInfo(slot0, slot1)
	slot0._rogueInfo = slot0._rogueInfo or RogueInfoMO.New()

	slot0._rogueInfo:init(slot1)
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnUpdateRogueInfo)
end

function slot0.updateTeamInfo(slot0, slot1)
	slot0._rogueInfo:updateTeamInfo(slot1)
end

function slot0.updateGroupBoxStar(slot0, slot1)
	slot0._rogueInfo.teamInfo:updateGroupBoxStar(slot1)
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnUpdateGroupBoxStar)
end

function slot0.updateGoodsInfos(slot0, slot1)
	if not slot1 then
		return
	end

	slot0._goodsInfos = {}

	for slot5, slot6 in ipairs(slot1) do
		slot7 = RogueGoodsInfoMO.New()

		slot7:init(slot6)
		table.insert(slot0._goodsInfos, slot7)
	end

	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnUpdateGoodsInfos)
end

function slot0.updateCollectionsInfos(slot0, slot1)
	if not slot1 then
		return
	end

	slot0._rogueInfo = slot0._rogueInfo or RogueInfoMO.New()

	slot0._rogueInfo:updateCollections(slot1)
	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.OnUpdateCollectionsInfo)
end

function slot0.updateRogueEndingInfo(slot0, slot1)
	slot0._rogueEndingInfo = slot0._rogueEndingInfo or RogueEndingInfoMO.New()

	slot0._rogueEndingInfo:init(slot1)
end

function slot0.clearRogueEndingInfo(slot0)
	slot0._rogueEndingInfo = nil
end

function slot0.setChangeLifes(slot0, slot1)
	slot0._changeLifes = {}

	for slot5, slot6 in ipairs(slot1) do
		slot7 = RogueHeroLifeMO.New()

		slot7:init(slot6)
		table.insert(slot0._changeLifes, slot7)
	end
end

function slot0.getChangeLifes(slot0)
	return slot0._changeLifes
end

function slot0.isReallyOpen(slot0)
	if ActivityModel.instance:getActMO(V1a6_CachotEnum.ActivityId):isOpen() then
		return ActivityConfig.instance:getActivityCo(V1a6_CachotEnum.ActivityId).openId and slot4 ~= 0 and OpenModel.instance:isFunctionUnlock(slot4)
	end
end

function slot0.isOnline(slot0)
	return ActivityModel.instance:getActMO(V1a6_CachotEnum.ActivityId) and ActivityHelper.getActivityStatus(V1a6_CachotEnum.ActivityId, true) == ActivityEnum.ActivityStatus.Normal
end

slot0.instance = slot0.New()

return slot0
