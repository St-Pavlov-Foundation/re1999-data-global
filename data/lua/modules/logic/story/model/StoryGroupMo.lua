module("modules.logic.story.model.StoryGroupMo", package.seeall)

slot0 = pureTable("StoryGroupMo")

function slot0.ctor(slot0)
	slot0.id = 0
	slot0.branchId = 0
	slot0.branchName = ""
end

function slot0.init(slot0, slot1)
	slot0.id = slot1[1]
	slot0.branchId = slot1[2]
	slot0.branchName = slot1[3]
end

return slot0
