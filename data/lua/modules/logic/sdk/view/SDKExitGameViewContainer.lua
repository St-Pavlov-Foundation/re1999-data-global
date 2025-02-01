module("modules.logic.sdk.view.SDKExitGameViewContainer", package.seeall)

slot0 = class("SDKExitGameViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, SDKExitGameView.New())

	return slot1
end

return slot0
