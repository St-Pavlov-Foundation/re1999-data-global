module("modules.logic.versionactivity2_3.act174.view.Act174MatchViewContainer", package.seeall)

slot0 = class("Act174MatchViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Act174MatchView.New())

	return slot1
end

return slot0
