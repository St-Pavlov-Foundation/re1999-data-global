module("modules.logic.seasonver.act123.view1_9.Season123_1_9StoryPagePopViewContainer", package.seeall)

slot0 = class("Season123_1_9StoryPagePopViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season123_1_9StoryPagePopView.New()
	}
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
