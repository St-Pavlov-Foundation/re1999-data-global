module("modules.logic.versionactivity2_1.lanshoupa.model.LanShouPaStoryMO", package.seeall)

slot0 = pureTable("LanShouPaStoryMO")

function slot0.init(slot0, slot1, slot2)
	slot0.id = slot2.id or slot1
	slot0.index = slot1
	slot0.storyId = slot2.id
	slot0.config = slot2
end

function slot0.isLocked(slot0)
	if StoryModel.instance:isStoryHasPlayed(slot0.storyId) then
		return false
	end

	return true
end

return slot0
