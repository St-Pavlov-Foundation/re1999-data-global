module("modules.logic.versionactivity1_4.act132.model.Activity132ContentMo", package.seeall)

slot0 = class("Activity132ContentMo")

function slot0.ctor(slot0, slot1)
	slot0.activityId = slot1.activityId
	slot0.contentId = slot1.contentId
	slot0.content = slot1.content
	slot0.condition = slot1.condition
	slot0.unlockDesc = slot1.unlockDesc
	slot0._cfg = slot1
end

function slot0.getUnlockDesc(slot0)
	return slot0._cfg.unlockDesc
end

function slot0.getContent(slot0)
	return slot0._cfg.content
end

return slot0
