module("modules.logic.versionactivity1_9.heroinvitation.model.HeroInvitationListModel", package.seeall)

slot0 = class("HeroInvitationListModel", ListScrollModel)

function slot0.refreshList(slot0)
	slot1 = HeroInvitationConfig.instance:getInvitationList()
	slot0.count = #slot1
	slot0.finishCount = 0
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		if HeroInvitationModel.instance:getInvitationState(slot7.id) == HeroInvitationEnum.InvitationState.Finish then
			slot0.finishCount = slot0.finishCount + 1
		end

		table.insert(slot2, slot7)
	end

	table.sort(slot2, SortUtil.keyLower("id"))
	slot0:setList(slot2)
end

slot0.instance = slot0.New()

return slot0
