module("modules.logic.store.config.DecorateStoreConfig", package.seeall)

slot0 = class("DecorateStoreConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0._storeDecorateConfig = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"store_decorate"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "store_decorate" then
		slot0._storeDecorateConfig = slot2
	end
end

function slot0.getDecorateConfig(slot0, slot1)
	return slot0._storeDecorateConfig.configDict[slot1]
end

slot0.instance = slot0.New()

return slot0
