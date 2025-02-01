module("modules.logic.versionactivity1_5.aizila.model.AiZiLaEquipMO", package.seeall)

slot0 = pureTable("AiZiLaEquipMO")

function slot0.init(slot0, slot1, slot2, slot3)
	slot0.id = slot1
	slot0.typeId = slot1
	slot0._equipId = slot2 or 0
	slot0.activityId = slot3 or VersionActivity1_5Enum.ActivityId.AiZiLa
	slot0._needUpdateConfig = true
end

function slot0.getConfig(slot0)
	if slot0._needUpdateConfig then
		slot0._needUpdateConfig = false
		slot0._config = AiZiLaConfig.instance:getEquipCo(slot0.activityId, slot0._equipId)
		slot0._nexConfig = AiZiLaConfig.instance:getEquipCoByPreId(slot0.activityId, slot0._equipId, slot0.typeId)
		slot0._costParams = AiZiLaHelper.getCostParams(slot0._nexConfig)
	end

	return slot0._config
end

function slot0.getNextConfig(slot0)
	slot0:getConfig()

	return slot0._nexConfig
end

function slot0.isMaxLevel(slot0)
	return slot0:getNextConfig() == nil
end

function slot0.isCanUpLevel(slot0)
	slot0:getConfig()

	if slot0:isMaxLevel() or slot0._costParams == nil then
		return false
	end

	return AiZiLaHelper.checkCostParams(slot0._costParams)
end

function slot0.getCostParams(slot0)
	slot0:getConfig()

	return slot0._costParams
end

function slot0.updateInfo(slot0, slot1)
	if slot0._equipId ~= slot1 then
		slot0._equipId = slot1
		slot0._needUpdateConfig = true
	end
end

return slot0
