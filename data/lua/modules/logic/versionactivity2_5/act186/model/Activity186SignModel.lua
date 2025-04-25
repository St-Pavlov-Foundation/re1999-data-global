module("modules.logic.versionactivity2_5.act186.model.Activity186SignModel", package.seeall)

slot0 = class("Activity186SignModel", BaseModel)

function slot0.getSignStatus(slot0, slot1, slot2, slot3)
	if ActivityType101Model.instance:isType101RewardGet(slot1, slot3) then
		return Activity186Enum.SignStatus.Hasget
	end

	if not ActivityType101Model.instance:isType101RewardCouldGet(slot1, slot3) then
		return Activity186Enum.SignStatus.None
	end

	if Activity186Model.instance:getLocalPrefsState(Activity186Enum.LocalPrefsKey.SignMark, slot2, slot3, 0) == 0 then
		return Activity186Enum.SignStatus.Canplay
	end

	return Activity186Enum.SignStatus.Canget
end

slot0.instance = slot0.New()

return slot0
