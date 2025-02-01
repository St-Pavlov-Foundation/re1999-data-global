module("modules.logic.explore.controller.trigger.ExploreTriggerStory", package.seeall)

slot0 = class("ExploreTriggerStory", ExploreTriggerBase)

function slot0.handle(slot0, slot1)
	slot1 = tonumber(slot1)

	logNormal("触发剧情：" .. slot1)
	StoryController.instance:playStory(slot1, nil, slot0.playStoryEnd, slot0, true)
end

function slot0.playStoryEnd(slot0, slot1)
	slot0:onDone(true)
end

return slot0
