module("modules.logic.versionactivity1_4.act133.model.Activity133ListMO", package.seeall)

slot0 = pureTable("Activity133ListMO")

function slot0.init(slot0, slot1)
	slot0.actid = slot1.activityId
	slot0.id = slot1.id
	slot0.config = slot1
	slot0.desc = slot1.desc
	slot0.icon = slot1.icon
	slot0.bonus = slot1.bonus
	slot0.needTokens = slot1.needTokens
	slot0.title = slot1.title
	slot0.pos = slot1.pos
end

function slot0.isLock(slot0)
	return false
end

function slot0.isReceived(slot0)
	return Activity133Model.instance:checkBonusReceived(slot0.id)
end

function slot0.getPos(slot0)
	slot1 = string.split(slot0.pos, "#")

	return slot1[1], slot1[2]
end

return slot0
