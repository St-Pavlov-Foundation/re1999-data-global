module("modules.logic.versionactivity2_3.act174.view.Act174BuffTipViewContainer", package.seeall)

slot0 = class("Act174BuffTipViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Act174BuffTipView.New())

	return slot1
end

return slot0
