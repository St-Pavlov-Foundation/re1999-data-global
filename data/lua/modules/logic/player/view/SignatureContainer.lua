module("modules.logic.player.view.SignatureContainer", package.seeall)

slot0 = class("SignatureContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, Signature.New())

	return slot1
end

return slot0
