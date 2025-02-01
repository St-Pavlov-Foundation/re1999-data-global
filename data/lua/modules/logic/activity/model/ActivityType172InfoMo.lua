module("modules.logic.activity.model.ActivityType172InfoMo", package.seeall)

slot0 = pureTable("ActivityType172InfoMo")

function slot0.ctor(slot0)
	slot0.useItemTaskIds = {}
end

function slot0.init(slot0, slot1)
	slot0.useItemTaskIds = {}

	for slot5, slot6 in ipairs(slot1) do
		table.insert(slot0.useItemTaskIds, slot6)
	end
end

function slot0.update(slot0, slot1)
	slot0.useItemTaskIds = {}

	for slot5, slot6 in ipairs(slot1) do
		table.insert(slot0.useItemTaskIds, slot6)
	end
end

return slot0
