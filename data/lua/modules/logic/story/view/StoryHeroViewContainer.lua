module("modules.logic.story.view.StoryHeroViewContainer", package.seeall)

slot0 = class("StoryHeroViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, StoryHeroView.New())

	return slot1
end

return slot0
