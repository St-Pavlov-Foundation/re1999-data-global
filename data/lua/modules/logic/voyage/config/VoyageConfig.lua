module("modules.logic.voyage.config.VoyageConfig", package.seeall)

slot0 = class("VoyageConfig", Activity1001Config)

function slot0.getTaskList(slot0)
	return slot0:_createOrGetShowTaskList()
end

function slot0.getRewardStrList(slot0, slot1)
	return string.split(slot0:getRewardStr(slot1), "|")
end

slot0.instance = slot0.New(ActivityEnum.Activity.ActivityGiftForTheVoyage)

return slot0
