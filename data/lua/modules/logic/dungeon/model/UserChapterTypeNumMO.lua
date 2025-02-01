module("modules.logic.dungeon.model.UserChapterTypeNumMO", package.seeall)

slot0 = pureTable("UserChapterTypeNumMO")

function slot0.init(slot0, slot1)
	slot0.chapterType = slot1.chapterType
	slot0.todayPassNum = slot1.todayPassNum
end

return slot0
