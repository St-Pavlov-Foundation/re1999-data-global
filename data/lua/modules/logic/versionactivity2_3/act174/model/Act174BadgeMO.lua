module("modules.logic.versionactivity2_3.act174.model.Act174BadgeMO", package.seeall)

slot0 = pureTable("Act174BadgeMO")

function slot0.init(slot0, slot1)
	slot0.config = slot1
	slot0.id = slot1.id
	slot0.count = 0
	slot0.act = false
	slot0.sp = false
end

function slot0.update(slot0, slot1)
	slot0.count = slot1.count
	slot0.act = slot1.act
	slot0.sp = slot1.sp
end

function slot0.getState(slot0)
	if slot0.sp then
		return Activity174Enum.BadgeState.Sp
	elseif slot0.act then
		return Activity174Enum.BadgeState.Light
	end

	return Activity174Enum.BadgeState.Normal
end

return slot0
