module("modules.logic.settings.model.SettingsKeyListModel", package.seeall)

slot0 = class("SettingsKeyListModel", ListScrollModel)

function slot0.Init(slot0)
	slot0._keyMaps = PCInputController.instance:getKeyMap()
end

function slot0.SetActivity(slot0, slot1)
	slot0:clear()

	if slot0._keyMaps[slot1] then
		slot3 = {}

		for slot7, slot8 in ipairs(slot2) do
			if slot8[PCInputModel.Configfield.editable] == 1 then
				table.insert(slot3, {
					id = slot8[PCInputModel.Configfield.id],
					value = slot8
				})
			end
		end

		table.sort(slot3, function (slot0, slot1)
			return slot0.id < slot1.id
		end)
		slot0:setList(slot3)
	end
end

function slot0.Reset(slot0, slot1)
	PCInputModel.instance:Reset(slot1)

	slot0._keyMaps = PCInputController.instance:getKeyMap()

	slot0:SetActivity(slot1)
end

function slot0.modifyKey(slot0, slot1, slot2, slot3)
	if not slot0._keyMaps[slot1] or not slot4[slot2] then
		logError("SettingsKeyListModel:modifyKey error, activityId = %s, keyId = %s", slot1, slot2)

		return
	end

	slot4[slot2][PCInputModel.Configfield.key] = slot3

	slot0:SetActivity(slot1)
	slot0:saveKeyMap()
	SettingsController.instance:dispatchEvent(SettingsEvent.OnKeyTipsChange)
end

function slot0.checkDunplicateKey(slot0, slot1, slot2)
	if not slot0._keyMaps[slot1] then
		logError("SettingsKeyListModel:checkDunplicateKey error, activityId = %s, keyId = %s", slot1, slot2)

		return
	end

	for slot7, slot8 in pairs(slot3) do
		if slot8[PCInputModel.Configfield.key] == slot2 then
			return slot8
		end
	end

	return nil
end

function slot0.saveKeyMap(slot0)
	PCInputController.instance:saveKeyMap(slot0._keyMaps)
end

slot0.instance = slot0.New()

return slot0
