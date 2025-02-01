module("modules.logic.versionactivity1_5.aizila.model.AiZiLaEpsiodeMO", package.seeall)

slot0 = pureTable("AiZiLaEpsiodeMO")

function slot0.init(slot0, slot1, slot2)
	slot0.id = slot1
	slot0.episodeId = slot1
	slot0.activityId = slot2 or VersionActivity1_5Enum.ActivityId.AiZiLa
	slot0.day = 0
	slot0.eventId = 0
	slot0.actionPoint = 0
	slot0.buffIds = {}
	slot0.option = 0
	slot0.optionResultId = 0
	slot0.altitude = 0
	slot0.round = 0
	slot0.costActionPoint = 0
	slot0.enterTimes = 0
	slot0._passRound = 8

	slot0:getConfig()
end

function slot0.getConfig(slot0)
	if not slot0._config then
		slot0._config = AiZiLaConfig.instance:getEpisodeCo(slot0.activityId, slot0.episodeId)
		slot0._targetIds = slot0._config and string.splitToNumber(slot0._config.showTargets, "|") or {}

		if AiZiLaConfig.instance:getPassRoundCo(slot0.activityId, slot0.episodeId) then
			slot0._passRound = slot1.round
		end
	end

	return slot0._config
end

function slot0.updateInfo(slot0, slot1)
	if slot1.actionPoint then
		slot0.actionPoint = slot1.actionPoint
	end

	if slot1.day then
		slot0.day = slot1.day
	end

	if slot1.eventId then
		slot0.eventId = slot1.eventId
	end

	if slot1.buffIds then
		for slot6 = 1, #slot0.buffIds do
			table.remove(slot0.buffIds)
		end

		tabletool.addValues(slot0.buffIds, slot1.buffIds)
	end

	if slot1.option then
		slot0.option = slot1.option
	end

	if slot1.optionResultId then
		slot0.optionResultId = slot1.optionResultId
	end

	if slot1.altitude then
		slot0.altitude = slot1.altitude
	end

	if slot1.round then
		slot0.round = slot1.round
	end

	if slot1.costActionPoint then
		slot0.costActionPoint = slot1.costActionPoint
	end

	if slot1.enterTimes then
		slot0.enterTimes = slot1.enterTimes
	end
end

function slot0.getTargetIds(slot0)
	return slot0._targetIds
end

function slot0.isPass(slot0)
	if slot0._passRound < slot0.round then
		return true
	end

	if slot0._passRound == slot0.round and slot0.eventId ~= 0 and slot0.option ~= 0 and slot0.optionResultId ~= 0 then
		return true
	end

	return false
end

function slot0.isCanSafe(slot0)
	if slot0.actionPoint < 0 then
		return false
	end

	if slot0:isPass() then
		return true
	end

	return false
end

function slot0.getRoundCfg(slot0)
	return AiZiLaConfig.instance:getRoundCo(slot0.activityId, slot0.episodeId, slot0.round)
end

function slot0.getCostActionPoint(slot0)
	return slot0.costActionPoint
end

return slot0
