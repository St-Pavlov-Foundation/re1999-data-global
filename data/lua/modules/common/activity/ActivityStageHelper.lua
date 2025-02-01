module("modules.common.activity.ActivityStageHelper", package.seeall)

slot0 = class("ActivityStageHelper")
slot1 = {}
slot2 = false

function slot0.initActivityStage()
	uv0 = true

	if not string.nilorempty(PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityStageKey), "")) then
		slot2 = nil

		for slot6, slot7 in ipairs(string.split(slot0, ";")) do
			if not string.nilorempty(slot7) then
				slot2 = string.splitToNumber(slot7, "#")
				uv1[slot2[1]] = slot2
			end
		end
	end
end

function slot0.checkActivityStageHasChange(slot0)
	if not uv0 then
		uv1.initActivityStage()
	end

	for slot4, slot5 in ipairs(slot0) do
		if uv1.checkOneActivityStageHasChange(slot5) then
			return true
		end
	end
end

function slot0.checkOneActivityStageHasChange(slot0)
	if not uv0 then
		uv1.initActivityStage()
	end

	if ActivityHelper.getActivityStatus(slot0) ~= ActivityEnum.ActivityStatus.Normal then
		return false
	end

	if not uv2[slot0] then
		return true
	end

	if not ActivityModel.instance:getActivityInfo()[slot0] then
		return false
	end

	return slot2[2] ~= (slot3:isOpen() and 1 or 0) or slot2[3] ~= slot3:getCurrentStage() or slot2[4] ~= (slot3:isUnlock() and 1 or 0)
end

function slot0.recordActivityStage(slot0)
	if not uv0 then
		uv1.initActivityStage()
	end

	for slot4, slot5 in ipairs(slot0) do
		uv1.recordOneActivityStage(slot5)
	end
end

function slot0.recordOneActivityStage(slot0)
	if not uv0 then
		uv1.initActivityStage()
	end

	if not uv1.checkOneActivityStageHasChange(slot0) then
		return
	end

	slot2 = false
	slot5, slot6 = nil

	for slot10, slot11 in ipairs(string.split(PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityStageKey), ""), ";")) do
		if not string.nilorempty(slot11) then
			if string.splitToNumber(slot11, "#") and slot5[1] == slot0 then
				slot2 = true

				table.insert({}, uv1._buildActPlayerPrefsString(slot0))
			else
				table.insert(slot3, slot11)
			end
		end
	end

	if not slot2 then
		table.insert(slot3, uv1._buildActPlayerPrefsString(slot0))
	end

	uv2[slot0] = string.splitToNumber(slot6, "#")

	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.ActivityStageKey), table.concat(slot3, ";"))
	ActivityController.instance:dispatchEvent(ActivityEvent.ChangeActivityStage)
end

function slot0._buildActPlayerPrefsString(slot0)
	if not ActivityModel.instance:getActivityInfo()[slot0] then
		return
	end

	return string.format("%s#%s#%s#%s", slot0, slot1:isOpen() and 1 or 0, slot1:getCurrentStage(), slot1:isUnlock() and 1 or 0)
end

function slot0.clear()
	uv0 = {}
	uv1 = false
end

return slot0
