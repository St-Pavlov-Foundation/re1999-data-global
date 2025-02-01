module("modules.logic.seasonver.act123.utils.Season123ProgressUtils", package.seeall)

slot0 = class("Season123ProgressUtils")

function slot0.isStageUnlock(slot0, slot1)
	if not Season123Model.instance:getActInfo(slot0) then
		return false
	end

	if not Season123Config.instance:getStageCo(slot0, slot1) then
		return false
	end

	if not GameUtil.splitString2(slot3.preCondition, true, "|", "#") then
		return true
	else
		for slot8, slot9 in ipairs(slot4) do
			slot10, slot11, slot12 = uv0.isConditionPass(slot0, slot9, slot1)

			if not slot10 then
				return false, slot11, slot12
			end
		end

		return true
	end
end

function slot0.isConditionPass(slot0, slot1, slot2)
	if #slot1 <= 1 then
		return true
	end

	if slot1[1] == Activity123Enum.PreCondition.StagePass then
		if not Season123Model.instance:getActInfo(slot0) then
			return false
		end

		if not slot4:getStageMO(slot2) then
			return false, Activity123Enum.PreCondition.StagePass
		end
	elseif slot3 == Activity123Enum.PreCondition.OpenTime and ActivityModel.instance:getActMO(slot0):getRealStartTimeStamp() ~= 0 then
		slot6 = ServerTime.now() - slot5
		slot7 = math.ceil(slot6 / TimeUtil.OneDaySecond)
		slot8 = tonumber(slot1[2])
		slot9 = math.max(0, (slot8 - 1) * TimeUtil.OneDaySecond - slot6)

		return slot8 ~= nil and slot8 <= slot7, Activity123Enum.PreCondition.OpenTime, {
			day = slot8 - slot7,
			remainTime = slot9,
			showSec = slot9 < TimeUtil.OneDaySecond
		}
	end

	return true
end

function slot0.getStageProgressStep(slot0, slot1)
	if not Season123Model.instance:getActInfo(slot0) then
		return 0, 0
	end

	if not slot2:getStageMO(slot1) then
		return 0, 0
	end

	return slot2:getStageRewardCount(slot1)
end

function slot0.stageInChallenge(slot0, slot1)
	if not Season123Model.instance:getActInfo(slot0) then
		return false
	end

	return slot2.stage == slot1 and not uv0.checkStageIsFinish(slot0, slot1)
end

function slot0.checkStageIsFinish(slot0, slot1)
	slot4 = Season123Config.instance:getSeasonEpisodeByStage(slot0, slot1)

	if Season123Model.instance:getActInfo(slot0):getStageMO(slot1) and slot4 and #slot4 > 0 and slot3.episodeMap[slot4[#slot4].layer] then
		return slot6:isFinished()
	end

	return false
end

function slot0.getMaxLayer(slot0, slot1)
	if not Season123Config.instance:getSeasonEpisodeStageCos(slot0, slot1) then
		return 0
	end

	for slot7, slot8 in ipairs(slot2) do
		if 0 < slot8.layer then
			slot3 = slot8.layer
		end
	end

	return slot3
end

function slot0.getEmptyLayerName(slot0, slot1)
	return string.format("v1a7_season_img_pic_empty_%s", slot0)
end

function slot0.getResultBg(slot0, slot1)
	return Season123ViewHelper.getIconUrl("singlebg/%s_season_singlebg/level/%s.png", slot0, slot1)
end

return slot0
