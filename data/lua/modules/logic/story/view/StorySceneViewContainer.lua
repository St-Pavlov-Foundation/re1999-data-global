module("modules.logic.story.view.StorySceneViewContainer", package.seeall)

slot0 = class("StorySceneViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}
	slot0._storyMainSceneView = StoryMainSceneView.New()

	table.insert(slot1, slot0._storyMainSceneView)
	table.insert(slot1, StorySceneView.New())

	return slot1
end

function slot0.getStoryMainSceneView(slot0)
	return slot0._storyMainSceneView
end

return slot0
