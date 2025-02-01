module("modules.logic.activity.model.ActivityType101InfoMo", package.seeall)

slot0 = pureTable("ActivityType101InfoMo")

function slot0.ctor(slot0)
	slot0.id = 0
	slot0.state = 0
end

function slot0.init(slot0, slot1)
	slot0.id = slot1.id
	slot0.state = slot1.state
end

return slot0
