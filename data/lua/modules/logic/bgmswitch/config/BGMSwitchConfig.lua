module("modules.logic.bgmswitch.config.BGMSwitchConfig", package.seeall)

slot0 = class("BGMSwitchConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0._bgmswitchconfig = nil
	slot0._bgmtypeconfig = nil
	slot0._bgmeggconfig = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"bgm_switch",
		"bgm_type",
		"bgm_easteregg"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "bgm_switch" then
		slot0._bgmswitchconfig = slot2
	elseif slot1 == "bgm_type" then
		slot0._bgmtypeconfig = slot2
	elseif slot1 == "bgm_easteregg" then
		slot0._bgmeggconfig = slot2
	end
end

function slot0.getBGMSwitchCos(slot0)
	return slot0._bgmswitchconfig.configDict
end

function slot0.getBGMSwitchCO(slot0, slot1)
	return slot0._bgmswitchconfig.configDict[slot1]
end

function slot0.getBGMSwitchCoByAudioId(slot0, slot1)
	for slot5, slot6 in pairs(slot0._bgmswitchconfig.configDict) do
		if slot6.audio == slot1 then
			return slot6
		end
	end
end

function slot0.getBGMTypeCos(slot0)
	return slot0._bgmtypeconfig.configDict
end

function slot0.getBGMTypeCO(slot0, slot1)
	return slot0._bgmtypeconfig.configDict[slot1]
end

function slot0.getBgmEasterEggCos(slot0)
	return slot0._bgmeggconfig.configDict
end

function slot0.getBgmEasterEggCosByType(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in pairs(slot0._bgmeggconfig.configDict) do
		if slot7.type == slot1 then
			table.insert(slot2, slot7)
		end
	end

	return slot2
end

function slot0.getBgmEasterEggCo(slot0, slot1)
	return slot0._bgmeggconfig.configDict[slot1]
end

function slot0.getBgmNames(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1) do
		if uv0.instance:getBGMSwitchCO(slot7) then
			table.insert(slot2, slot8.audioName)
		end
	end

	return slot2
end

function slot0.getBgmName(slot0, slot1)
	return uv0.instance:getBGMSwitchCO(slot1) and slot2.audioName
end

slot0.instance = slot0.New()

return slot0
