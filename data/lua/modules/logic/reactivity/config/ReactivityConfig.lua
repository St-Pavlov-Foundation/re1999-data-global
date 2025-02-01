module("modules.logic.reactivity.config.ReactivityConfig", package.seeall)

slot0 = class("ReactivityConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0._retroItemConvertConfig = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"retro_item_convert"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "retro_item_convert" then
		slot0._retroItemConvertConfig = slot2
	end
end

function slot0.getItemConvertList(slot0)
	return slot0._retroItemConvertConfig.configList
end

function slot0.getItemConvertCO(slot0, slot1, slot2)
	if not slot0._retroItemConvertConfig.configDict[slot1] then
		return
	end

	return slot3[slot2]
end

function slot0.checkItemNeedConvert(slot0, slot1, slot2)
	if not slot0:getItemConvertCO(slot1, slot2) then
		return false
	end

	return slot3.limit <= ItemModel.instance:getItemQuantity(slot1, slot2), slot3.price
end

slot0.instance = slot0.New()

return slot0
