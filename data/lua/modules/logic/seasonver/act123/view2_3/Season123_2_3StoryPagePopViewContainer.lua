module("modules.logic.seasonver.act123.view2_3.Season123_2_3StoryPagePopViewContainer", package.seeall)

slot0 = class("Season123_2_3StoryPagePopViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season123_2_3StoryPagePopView.New()
	}
end

function slot0.onContainerClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
