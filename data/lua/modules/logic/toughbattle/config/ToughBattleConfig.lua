module("modules.logic.toughbattle.config.ToughBattleConfig", package.seeall)

slot0 = class("ToughBattleConfig", BaseConfig)

function slot0.onInit(slot0)
	slot0._diffcultToCOs = nil
	slot0._storyCOs = nil
	slot0._allActEpisodeIds = nil
	slot0._episodeIdToCO = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"activity158_challenge",
		"activity158_const",
		"activity158_evaluate",
		"siege_battle",
		"siege_battle_word",
		"siege_battle_hero"
	}
end

function slot0.getRoundDesc(slot0, slot1)
	for slot5, slot6 in ipairs(lua_activity158_evaluate.configList) do
		if slot1 <= slot6.round then
			return slot6.desc
		end
	end

	return ""
end

function slot0.isActEleCo(slot0, slot1)
	if not slot1 then
		return false
	end

	if slot1.type ~= DungeonEnum.ElementType.ToughBattle then
		return false
	end

	if (tonumber(slot1.param) or 0) ~= 0 then
		return true
	end

	return false
end

function slot0.getConstValue(slot0, slot1, slot2)
	slot3 = ""

	if lua_activity158_const.configDict[slot1] then
		slot3 = slot4.value
	end

	if slot2 then
		return tonumber(slot3) or 0
	else
		return slot3
	end
end

function slot0._initActInfo(slot0)
	if not slot0._episodeIdToCO then
		slot0._allActEpisodeIds = {}
		slot0._episodeIdToCO = {}

		for slot4, slot5 in ipairs(lua_activity158_challenge.configList) do
			slot0._allActEpisodeIds[slot5.episodeId] = true
			slot0._episodeIdToCO[slot5.episodeId] = slot5
		end

		for slot4, slot5 in ipairs(lua_siege_battle.configList) do
			slot0._episodeIdToCO[slot5.episodeId] = slot5
		end
	end
end

function slot0.isActStage2EpisodeId(slot0, slot1)
	if not slot0:getCoByEpisodeId(slot1) then
		return false
	end

	return slot2.stage == 2 and slot0._allActEpisodeIds[slot2.episodeId]
end

function slot0.isStage1EpisodeId(slot0, slot1)
	if not slot0:getCoByEpisodeId(slot1) then
		return false
	end

	return slot2.stage == 1
end

function slot0.isActEpisodeId(slot0, slot1)
	slot0:_initActInfo()

	return slot0._allActEpisodeIds[slot1]
end

function slot0.getCoByEpisodeId(slot0, slot1)
	slot0:_initActInfo()

	return slot0._episodeIdToCO[slot1]
end

function slot0.getCOByDiffcult(slot0, slot1)
	if not slot0._diffcultToCOs then
		slot0._diffcultToCOs = {}

		for slot5, slot6 in ipairs(lua_activity158_challenge.configList) do
			slot0._diffcultToCOs[slot6.difficulty] = slot0._diffcultToCOs[slot6.difficulty] or {}

			if slot6.stage == 2 then
				slot7.stage2 = slot6
			else
				if not slot7.stage1 then
					slot7.stage1 = {}
				end

				slot7.stage1[slot6.sort] = slot6
			end
		end
	end

	return slot0._diffcultToCOs[slot1]
end

function slot0.getStoryCO(slot0)
	if not slot0._storyCOs then
		slot0._storyCOs = {}

		for slot4, slot5 in ipairs(lua_siege_battle.configList) do
			if slot5.stage == 2 then
				slot0._storyCOs.stage2 = slot5
			else
				if not slot0._storyCOs.stage1 then
					slot0._storyCOs.stage1 = {}
				end

				slot0._storyCOs.stage1[slot5.sort] = slot5
			end
		end
	end

	return slot0._storyCOs
end

slot0.instance = slot0.New()

return slot0
