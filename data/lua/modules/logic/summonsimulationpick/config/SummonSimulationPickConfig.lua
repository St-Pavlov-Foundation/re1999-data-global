module("modules.logic.summonsimulationpick.config.SummonSimulationPickConfig", package.seeall)

slot0 = class("SummonSimulationPickConfig", BaseConfig)
slot0.ACTIVITY_CONFIG_170 = "activity170"

function slot0.reqConfigNames(slot0)
	return {
		slot0.ACTIVITY_CONFIG_170
	}
end

function slot0.onInit(slot0)
	slot0._summonSimulationPickConfig = nil
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == slot0.ACTIVITY_CONFIG_170 then
		slot0._summonSimulationPickConfig = slot2
	end
end

function slot0.getAllConfig(slot0)
	return slot0._summonSimulationPickConfig.configList
end

function slot0.getSummonConfig(slot0)
	return slot0._summonSimulationPickConfig
end

function slot0.getSummonConfigById(slot0, slot1)
	return slot0._summonSimulationPickConfig.configDict[slot1]
end

slot0.instance = slot0.New()

return slot0
