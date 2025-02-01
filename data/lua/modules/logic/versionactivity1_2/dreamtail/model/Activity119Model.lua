module("modules.logic.versionactivity1_2.dreamtail.model.Activity119Model", package.seeall)

slot0 = class("Activity119Model", BaseModel)

function slot0.reInit(slot0)
	slot0.data = nil
	slot0.userData = nil
end

function slot0.getData(slot0)
	if not slot0.data then
		if not string.nilorempty(PlayerPrefsHelper.getString(PlayerPrefsKey.DreamTailKey, "")) then
			slot0.data = cjson.decode(slot2)
			slot0.userData = slot0.data[tostring(PlayerModel.instance:getMyUserId())]

			if slot0.data.activityId ~= VersionActivity1_2Enum.ActivityId.DreamTail then
				slot0.data = nil
				slot0.userData = nil
			end
		end

		if not slot0.data then
			slot0.data = {
				activityId = VersionActivity1_2Enum.ActivityId.DreamTail
			}
		end

		if not slot0.userData then
			slot0.userData = {
				unLockDay = 1,
				lastSelectDay = 1,
				lastSelectModel = 1,
				unLockHardList = {}
			}
			slot0.data[slot1] = slot0.userData

			slot0:saveData()
		end
	end

	return slot0.userData
end

function slot0.saveData(slot0)
	if not slot0.data then
		return
	end

	PlayerPrefsHelper.setString(PlayerPrefsKey.DreamTailKey, cjson.encode(slot0.data))
end

slot0.instance = slot0.New()

return slot0
