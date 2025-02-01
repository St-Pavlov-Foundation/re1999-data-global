module("modules.common.work.PlayStoryWork", package.seeall)

slot0 = class("PlayStoryWork", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0.storyId = slot1
end

function slot0.onStart(slot0)
	StoryController.instance:playStory(slot0.storyId, nil, slot0.onPlayStoryDone, slot0)
end

function slot0.onPlayStoryDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
