module("modules.logic.story.model.StoryBgZoneMo", package.seeall)

slot0 = pureTable("StoryBgZoneMo")

function slot0.ctor(slot0)
	slot0.path = ""
	slot0.sourcePath = ""
	slot0.offsetX = 0
	slot0.offsetY = 0
end

function slot0.init(slot0, slot1)
	slot0.path = slot1[1]
	slot0.sourcePath = slot1[2]
	slot0.offsetX = slot1[3]
	slot0.offsetY = slot1[4]
end

return slot0
