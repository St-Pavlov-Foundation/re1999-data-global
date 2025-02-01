module("modules.logic.seasonver.act123.view.Season123RecordWindowContainer", package.seeall)

slot0 = class("Season123RecordWindowContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {
		Season123RecordWindow.New()
	}
end

return slot0
