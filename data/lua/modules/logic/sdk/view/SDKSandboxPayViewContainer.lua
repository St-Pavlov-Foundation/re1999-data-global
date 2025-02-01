module("modules.logic.sdk.view.SDKSandboxPayViewContainer", package.seeall)

slot0 = class("SDKSandboxPayViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, SDKSandboxPayView.New())

	return slot1
end

return slot0
