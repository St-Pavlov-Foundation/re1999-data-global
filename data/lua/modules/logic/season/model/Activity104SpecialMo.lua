slot0 = pureTable("Activity104SpecialMo")

function slot0.ctor(slot0)
	slot0.layer = 0
	slot0.state = 0
end

function slot0.init(slot0, slot1)
	slot0.layer = slot1.layer
	slot0.state = slot1.state
end

function slot0.reset(slot0, slot1)
	slot0.layer = slot1.layer
	slot0.state = slot1.state
end

return slot0
