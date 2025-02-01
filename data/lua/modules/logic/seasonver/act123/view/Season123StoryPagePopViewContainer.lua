module("modules.logic.seasonver.act123.view.Season123StoryPagePopViewContainer", package.seeall)

slot0 = class("Season123StoryPagePopViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season123StoryPagePopView.New()
	}
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
