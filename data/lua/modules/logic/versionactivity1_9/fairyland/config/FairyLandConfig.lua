module("modules.logic.versionactivity1_9.fairyland.config.FairyLandConfig", package.seeall)

slot0 = class("FairyLandConfig", BaseConfig)

function slot0.ctor(slot0)
end

function slot0.reqConfigNames(slot0)
	return {
		"fairyland_puzzle",
		"fairyland_puzzle_talk",
		"fairy_land_element",
		"fairyland_text"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "fairyland_puzzle" then
		slot0._fairlyLandPuzzleConfig = slot2
	elseif slot1 == "fairyland_puzzle_talk" then
		slot0:_initDialog()
	elseif slot1 == "fairy_land_element" then
		slot0._fairlyLandElementConfig = slot2
	end
end

function slot0.getFairlyLandPuzzleConfig(slot0, slot1)
	return slot0._fairlyLandPuzzleConfig.configDict[slot1]
end

function slot0.getTalkStepConfig(slot0, slot1, slot2)
	return slot0:getTalkConfig(slot1) and slot3[slot2]
end

function slot0.getElements(slot0)
	return slot0._fairlyLandElementConfig.configList
end

function slot0.getElementConfig(slot0, slot1)
	return slot0._fairlyLandElementConfig.configDict[slot1]
end

function slot0._initDialog(slot0)
	slot0._dialogList = {}
	slot1 = nil

	for slot6, slot7 in ipairs(lua_fairyland_puzzle_talk.configList) do
		if not slot0._dialogList[slot7.id] then
			slot1 = 0
			slot0._dialogList[slot7.id] = {}
		end

		if slot7.type == "selector" then
			slot8[slot1] = slot8[tonumber(slot7.param)] or {}
		elseif slot7.type == "selectorend" then
			slot1 = slot2
		else
			slot8[slot1] = slot8[slot1] or {}

			table.insert(slot8[slot1], slot7)
		end
	end
end

function slot0.getDialogConfig(slot0, slot1, slot2)
	return slot0._dialogList[slot1] and slot3[slot2]
end

function slot0.addTextDict(slot0, slot1, slot2, slot3)
	if not slot3[slot2] then
		slot3[slot2] = {}
	end

	table.insert(slot4, slot1)
end

slot0.instance = slot0.New()

return slot0
