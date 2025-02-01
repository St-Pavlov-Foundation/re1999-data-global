module("modules.logic.versionactivity1_3.chess.model.Activity122StoryMO", package.seeall)

slot0 = pureTable("Activity122StoryMO")

function slot0.init(slot0, slot1, slot2)
	slot0.index = slot1
	slot0.cfg = slot2
	slot0.storyId = slot2.id
end

function slot0.isLocked(slot0)
	if StoryModel.instance:isStoryHasPlayed(slot0.storyId) then
		return false
	end

	return true
end

return slot0
