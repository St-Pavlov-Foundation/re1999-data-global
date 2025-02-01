module("modules.logic.turnback.invitation.model.TurnBackInvitationInfoMo", package.seeall)

slot0 = pureTable("TurnBackInvitationInfoMo")

function slot0.ctor(slot0)
	slot0.invitePlayers = {}
end

function slot0.init(slot0, slot1)
	slot0.activityId = slot1.activityId
	slot0.isTurnBack = slot1.isTurnback
	slot0.inviteCode = slot1.inviteCode

	slot0:refreshInvitaPlayerInfo(slot1.invitePlayers)
end

function slot0.refreshInvitaPlayerInfo(slot0, slot1)
	tabletool.clear(slot0.invitePlayers)

	if slot1 and #slot1 > 0 then
		for slot5, slot6 in ipairs(slot1) do
			table.insert(slot0.invitePlayers, {
				name = slot6.name,
				userId = slot6.userId,
				portrait = slot6.portrait
			})
		end
	end
end

return slot0
