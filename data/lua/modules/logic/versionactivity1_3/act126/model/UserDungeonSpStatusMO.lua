module("modules.logic.versionactivity1_3.act126.model.UserDungeonSpStatusMO", package.seeall)

slot0 = pureTable("UserDungeonSpStatusMO")

function slot0.init(slot0, slot1)
	slot0.chapterId = slot1.chapterId
	slot0.episodeId = slot1.episodeId
	slot0.status = slot1.status
	slot0.refreshTime = slot1.refreshTime
end

return slot0
