module("modules.logic.turnback.invitation.view.TurnBackInvitationMainViewContainer", package.seeall)

slot0 = class("TurnBackInvitationMainViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	slot1 = {}

	table.insert(slot1, TurnBackInvitationMainView.New())

	return slot1
end

return slot0
