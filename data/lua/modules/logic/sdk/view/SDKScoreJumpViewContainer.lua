module("modules.logic.sdk.view.SDKScoreJumpViewContainer", package.seeall)

slot0 = class("SDKScoreJumpViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, SDKScoreJumpView.New())

	return slot1
end

return slot0
