module("modules.logic.dungeon.model.UserDungeonMO", package.seeall)

slot0 = pureTable("UserDungeonMO")

function slot0.init(slot0, slot1)
	slot0.chapterId = slot1.chapterId
	slot0.episodeId = slot1.episodeId
	slot0.star = slot1.star
	slot0.challengeCount = slot1.challengeCount
	slot0.hasRecord = slot1.hasRecord
	slot0.todayPassNum = slot1.todayPassNum
	slot0.todayTotalNum = slot1.todayTotalNum
end

function slot0.initFromManual(slot0, slot1, slot2, slot3, slot4)
	slot0.chapterId = slot1
	slot0.episodeId = slot2
	slot0.star = slot3
	slot0.challengeCount = slot4
	slot0._manual = true
	slot0.isNew = true
	slot0.hasRecord = false
	slot0.todayPassNum = 0
	slot0.todayTotalNum = DungeonConfig.instance:getEpisodeCO(slot2).dayNum
end

return slot0
