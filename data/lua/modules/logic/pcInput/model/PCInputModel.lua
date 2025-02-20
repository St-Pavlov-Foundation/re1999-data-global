module("modules.logic.pcInput.model.PCInputModel", package.seeall)

slot0 = class("PCInputModel", BaseModel)
slot0.Activity = {
	CommonDialog = 11,
	storyDialog = 10,
	room = 4,
	thrityDoor = 2,
	MainActivity = 1,
	battle = 3
}
slot0.Configfield = {
	description = 3,
	key = 4,
	hud = 1,
	editable = 5,
	id = 2
}
slot0.blockField = {
	mlstring = 2,
	hud = 1,
	blockkey = 3
}
slot0.ReplaceField = {
	replace = 2,
	keyName = 1
}
slot0.MainActivityFun = {
	curActivity = 10,
	Room = 13,
	hide = 9,
	activityCenter = 11,
	Role = 14,
	Enter = 12,
	Summon = 15
}
slot0.RoomActivityFun = {
	buy = 9,
	layout = 10,
	hide = 6,
	edit = 12,
	guting = 7,
	place = 11
}
slot0.battleActivityFun = {
	skillUp = 21,
	skillDown = 22,
	showSkill = 20
}
slot0.thrityDoorFun = {
	map = 5,
	Item1 = 7,
	bag = 6
}

function slot0.onInit(slot0)
end

function slot0.checkKeyBinding(slot0)
	if slot0.keyBinding == nil then
		slot0.keyBinding = slot0:load()
	end
end

function slot0.Save(slot0, slot1)
	slot0.keyBinding = slot1

	PlayerPrefsHelper.setString("keyBinding", cjson.encode(slot0.keyBinding))
end

function slot0.load(slot0)
	slot2 = slot0:loadFromConfig()

	if PlayerPrefsHelper.getString("keyBinding") and slot1 ~= "null" then
		return slot0:CheckConfigUpdate(cjson.decode(slot1), slot2)
	end

	return slot2
end

function slot0.CheckConfigUpdate(slot0, slot1, slot2)
	for slot7, slot8 in pairs(LuaUtil.deepCopy(slot2)) do
		for slot12, slot13 in pairs(slot8) do
			if slot1[slot13.hud] and slot1[slot13.hud][slot13.id] then
				getmetatable(slot13).__newindex = nil
				slot13[uv0.Configfield.key] = slot1[slot13.hud][slot13.id][uv0.Configfield.key]
			end
		end
	end

	return slot3
end

function slot0.loadFromConfig(slot0)
	return pcInputConfig.instance:getKeyBinding()
end

function slot0.findActivityById(slot0, slot1)
	for slot5, slot6 in pairs(uv0.Activity) do
		if slot6 == slot1 then
			return slot5
		end
	end

	return nil
end

function slot0.getActivityKeys(slot0, slot1)
	slot0:checkKeyBinding()

	if not slot0:findActivityById(slot1) then
		logError("activity not exist in PCInputModel.Activity")

		return nil
	end

	if not slot0.keyBinding[uv0.Activity[slot2]] then
		logError("activity not exist in keyBinding")

		return nil
	end

	return slot3
end

function slot0.getkeyidBykeyName(slot0, slot1, slot2)
	if slot0:getkeyconfigBykeyName(slot1, slot2) then
		return slot3[2]
	end
end

function slot0.getkeyconfigBykeyName(slot0, slot1, slot2)
	for slot7, slot8 in pairs(slot0:getActivityKeys(slot1)) do
		if slot8[4] == slot2 then
			return slot8
		end
	end
end

function slot0.getThirdDoorMoveKey(slot0)
	slot1 = slot0:getActivityKeys(uv0.Activity.thrityDoor)

	return slot1[1][uv0.Configfield.key], slot1[2][uv0.Configfield.key], slot1[3][uv0.Configfield.key], slot1[4][uv0.Configfield.key]
end

function slot0.getKeyBinding(slot0)
	slot0:checkKeyBinding()

	return slot0.keyBinding
end

function slot0.checkKeyCanModify(slot0, slot1, slot2)
	if slot0.keyBinding[slot1] and pcInputConfig.instance:getKeyBlock()[slot1] then
		for slot9, slot10 in pairs(slot5[uv0.blockField.blockkey]) do
			if slot10 == slot2 then
				return false
			end
		end
	end

	return true
end

function slot0.getKey(slot0, slot1, slot2)
	slot0:checkKeyBinding()

	if slot0.keyBinding[slot1] and slot3[slot2] then
		return slot4[uv0.Configfield.key]
	end

	return ""
end

function slot0.Reset(slot0, slot1)
	slot0.keyBinding[slot1] = slot0:loadFromConfig()[slot1]

	slot0:Save(slot0.keyBinding)
end

function slot0.ReplaceKeyName(slot0, slot1)
	if pcInputConfig.instance:getKeyNameReplace() then
		for slot6, slot7 in pairs(slot2) do
			if slot7[uv0.ReplaceField.keyName] == slot1 then
				return slot7[uv0.ReplaceField.replace]
			end
		end
	end

	return slot1
end

slot0.instance = slot0.New()

return slot0
