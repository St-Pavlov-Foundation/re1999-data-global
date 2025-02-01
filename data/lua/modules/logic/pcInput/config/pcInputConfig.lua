module("modules.logic.pcInput.config.pcInputConfig", package.seeall)

slot0 = class("pcInputConfig", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"key_binding",
		"key_block",
		"key_name_replace"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "key_binding" then
		slot0.key_binding = slot2
	end

	if slot1 == "key_block" then
		slot0.key_block = slot2
	end

	if slot1 == "key_name_replace" then
		slot0.key_name_replace = slot2
	end
end

function slot0.getKeyBinding(slot0)
	return slot0.key_binding.configDict
end

function slot0.getKeyBlock(slot0)
	return slot0.key_block.configDict
end

function slot0.getKeyNameReplace(slot0)
	return slot0.key_name_replace.configDict
end

slot0.instance = slot0.New()

return slot0
