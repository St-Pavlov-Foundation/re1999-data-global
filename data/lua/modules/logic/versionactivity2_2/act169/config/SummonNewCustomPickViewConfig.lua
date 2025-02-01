module("modules.logic.versionactivity2_2.act169.config.SummonNewCustomPickViewConfig", package.seeall)

slot0 = class("SummonNewCustomPickViewConfig", BaseConfig)
slot0.ACTIVITY_CONFIG_169 = "activity169"

function slot0.reqConfigNames(slot0)
	return {
		slot0.ACTIVITY_CONFIG_169
	}
end

function slot0.onInit(slot0)
	slot0._summonNewPickConfig = nil
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == slot0.ACTIVITY_CONFIG_169 then
		slot0._summonNewPickConfig = slot2
	end
end

function slot0.getAllConfig(slot0)
	return slot0._summonNewPickConfig.configList
end

function slot0.getSummonConfig(slot0)
	return slot0._summonNewPickConfig
end

function slot0.getSummonConfigById(slot0, slot1)
	return slot0._summonNewPickConfig.configDict[slot1]
end

slot0.instance = slot0.New()

return slot0
