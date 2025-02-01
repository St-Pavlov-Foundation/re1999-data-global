module("modules.logic.mail.model.MailRewardListModel", package.seeall)

slot0 = class("MailRewardListModel", ListScrollModel)

function slot0.setRewardList(slot0, slot1)
	slot0._moList = {}

	if slot1 then
		for slot5, slot6 in pairs(slot1) do
			table.insert(slot0._moList, slot6)
		end
	end

	slot0:setList(slot0._moList)
end

slot0.instance = slot0.New()

return slot0
