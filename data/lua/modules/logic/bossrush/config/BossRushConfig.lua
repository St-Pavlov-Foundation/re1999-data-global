module("modules.logic.bossrush.config.BossRushConfig", package.seeall)

slot0 = class("BossRushConfig", Activity128Config)

function slot0.InfiniteDoubleMaxTimes(slot0)
	return slot0:getConst(2) or 0
end

function slot0.getActivityRewardStr(slot0)
	slot1, slot2 = slot0:getConst(3)

	return slot2
end

function slot0.getIssxIconName(slot0, slot1, slot2)
	return "lssx_" .. lua_monster.configDict[slot0:getFinalMonsterId(slot1, slot2 or 1)].career
end

function slot0.getAssessCo(slot0, slot1, slot2, slot3)
	slot5 = lua_activity128_assess.configList

	for slot10 = #slot5, 1, -1 do
		if slot5[slot10].layer4Assess == (slot3 and 1 or 0) and slot11["needPointBoss" .. tostring(slot1)] <= slot2 then
			return slot11
		end
	end
end

function slot0.getAssessSpriteName(slot0, slot1, slot2, slot3)
	if slot0:getAssessCo(slot1, slot2, slot3) then
		return slot4.spriteName, slot4.level, slot4.strLevel
	end

	return "", -1, ""
end

function slot0.getAssessBattleIconBgName(slot0, slot1, slot2, slot3)
	if slot0:getAssessCo(slot1, slot2, slot3) then
		return slot4.battleIconBg, slot4.level
	end

	return "v1a4_bossrush_ig_tipsbgempty", -1
end

function slot0.getAssessMainBossBgName(slot0, slot1, slot2, slot3)
	if slot0:getAssessCo(slot1, slot2, slot3) then
		return slot4.mainBg, slot4.level
	end

	return "v1a6_bossrush_taskitembg1", -1
end

function slot0.getAssessPointByStrLevel(slot0, slot1, slot2)
	for slot8, slot9 in ipairs(lua_activity128_assess.configList) do
		if slot9.strLevel == slot2 then
			return slot9["needPointBoss" .. tostring(slot1)]
		end
	end

	return 0
end

function slot0.getScoreStr(slot0, slot1, slot2)
	assert(slot1 >= 0)

	slot3 = math.modf(slot1 / 10)
	slot5 = 1
	slot6 = tostring(math.fmod(slot1, 10))
	slot2 = slot2 or ","

	while slot3 > 0 do
		slot4 = math.fmod(slot3, 10)

		if slot5 >= 3 then
			slot6 = slot2 .. slot6
			slot5 = 0
		end

		slot6 = tostring(slot4) .. slot6
		slot3 = math.modf(slot3 / 10)
		slot5 = slot5 + 1
	end

	return slot6
end

function slot0.getBossRushMainItemBossSprite(slot0, slot1)
	return ResUrl.getV1a4BossRushIcon(slot0:getStageCO(slot1).bossRushMainItemBossSprite)
end

function slot0.getResultViewFullBgSImage(slot0, slot1)
	return ResUrl.getV1a4BossRushSinglebg(slot0:getStageCO(slot1).resultViewFullBgSImage)
end

function slot0.getResultViewNameSImage(slot0, slot1)
	return ResUrl.getV1a4BossRushLangPath(slot0:getStageCO(slot1).resultViewNameSImage)
end

function slot0.getBossRushLevelDetailFullBgSimage(slot0, slot1)
	return ResUrl.getV1a4BossRushSinglebg(slot0:getStageCO(slot1).bossRushLevelDetailFullBgSimage)
end

function slot0.getMonsterSkinIdList(slot0, slot1)
	return string.splitToNumber(slot0:getStageCO(slot1).skinIds, "#")
end

function slot0.getMonsterSkinScaleList(slot0, slot1)
	return string.splitToNumber(slot0:getStageCO(slot1).skinScales, "#")
end

function slot0.getMonsterSkinOffsetXYs(slot0, slot1)
	return GameUtil.splitString2(slot0:getStageCO(slot1).skinOffsetXYs, true)
end

function slot0.getQualityBgSpriteName(slot0, slot1)
	return "bg_pinjidi_" .. slot1
end

function slot0.getQualityFrameSpriteName(slot0, slot1)
	return "bg_pinjidi_lanse_" .. slot1
end

slot1 = {
	[0] = "bg_xingjidian",
	"bg_xingjidian_1",
	"bg_xingjidian_dis",
	"bg_xingjidian_1_dis",
	"bg_xingjidian_layer4"
}

function slot0.getRewardStatusSpriteName(slot0, slot1, slot2)
	if slot1 then
		slot3 = 0 + 1
	end

	if not slot2 then
		slot3 = slot3 + 2
	end

	return uv0[slot3]
end

function slot0.getSpriteRewardStatusSpriteName(slot0, slot1)
	return uv0[slot1 and 4 or 2]
end

function slot0.getStageRewardDisplayIndexesList(slot0, slot1)
	return slot0:__getOrCreateStageRewardDisplayIndexesList(slot1)
end

function slot0.__getOrCreateStageRewardDisplayIndexesList(slot0, slot1)
	slot0.__cumulativeDisplayRewards = slot0.__cumulativeDisplayRewards or {}

	if slot0.__cumulativeDisplayRewards[slot1] then
		return slot0.__cumulativeDisplayRewards[slot1]
	end

	slot2 = {}

	for slot7, slot8 in ipairs(slot0:getStageRewardList(slot1)) do
		if slot8.display > 0 then
			slot2[#slot2 + 1] = slot7
		end
	end

	slot0.__cumulativeDisplayRewards[slot1] = slot2

	return slot2
end

function slot0.calcStageRewardProgWidthByListScrollParam(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	return slot0:calcStageRewardProgWidth(slot1, slot2, slot8, slot7, slot4, slot3.cellWidth + slot3.cellSpaceH, slot5, slot6 or slot3.endSpace or 0)
end

function slot0.calcStageRewardProgWidth(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
	if #slot0:getStageRewardList(slot1) == 0 then
		return 0, 0
	end

	slot7 = slot7 or 0
	slot11 = (slot5 or slot4 / 2) + (slot10 - 1) * (slot6 or slot4 + slot3) + (slot8 or 0)
	slot13 = 0

	for slot17, slot18 in ipairs(slot9) do
		if slot18.rewardPointNum <= slot2 then
			slot12 = 0 + (slot17 == 1 and slot5 or slot6)
			slot13 = slot19
		else
			slot12 = slot12 + GameUtil.remap(slot2, slot13, slot19, 0, slot20)

			break
		end
	end

	return math.max(0, slot12 - slot7), slot11
end

function slot0.getBgmViewNames(slot0)
	if not slot0._bgmViews then
		slot0._bgmViews = {
			ViewName.V1a4_BossRushMainView,
			ViewName.V1a4_BossRushLevelDetail,
			ViewName.V1a4_BossRush_ScoreTaskAchievement,
			ViewName.V1a4_BossRush_ScheduleView
		}
	end

	return slot0._bgmViews
end

function slot0.getMonsterResPathList(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in ipairs(uv0.instance:getMonsterSkinIdList(slot1)) do
		if FightConfig.instance:getSkinCO(slot8) then
			table.insert(slot2, ResUrl.getSpineUIPrefab(slot9.spine))
		end
	end

	return slot2
end

function slot0.initEvaluateCo(slot0)
end

function slot0.getEvaluateInfo(slot0, slot1)
	slot2 = slot0:getEvaluateConfig(slot1)

	return slot2.name, slot2.desc
end

function slot0.getActRoleEnhanceCoById(slot0, slot1)
	return slot0:getActRoleEnhance()[slot1]
end

function slot0.getEpisodeCoByEpisodeId(slot0, slot1)
	if lua_activity128_episode.configDict[slot0.__activityId] then
		for slot6, slot7 in pairs(slot2) do
			for slot11, slot12 in pairs(slot7) do
				if slot12.episodeId == slot1 then
					return slot12
				end
			end
		end
	end
end

slot0.instance = slot0.New(VersionActivity2_5Enum.ActivityId.BossRush)

return slot0
