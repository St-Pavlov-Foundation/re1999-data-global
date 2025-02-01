module("modules.logic.player.model.PlayerClothModel", package.seeall)

slot0 = class("PlayerClothModel", ListScrollModel)

function slot0.onGetInfo(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(lua_cloth.configList) do
		slot8 = PlayerClothMO.New()

		slot8:initFromConfig(slot7)
		table.insert(slot2, slot8)
	end

	slot0:setList(slot2)
	slot0:updateInfo(slot1)
end

function slot0.onPushInfo(slot0, slot1)
	slot0:updateInfo(slot1)
end

function slot0.updateInfo(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if slot0:getById(slot6.clothId) then
			slot7:init(slot6)
		else
			logError("服装配置不存在：" .. slot6.clothId)
		end
	end
end

function slot0.hasCloth(slot0, slot1)
	return slot0:getById(slot1) and slot2.has
end

function slot0.isSatisfy(slot0)
	slot1 = string.splitToNumber(slot0, "#")
	slot3 = slot1[2]

	if slot1[1] and slot2 > 0 and PlayerModel.instance:getPlayinfo().level < slot2 then
		return false
	end

	if slot3 and slot3 > 0 and (not DungeonModel.instance:getEpisodeInfo(slot3) or slot4.star <= DungeonEnum.StarType.None) then
		return false
	end

	return true
end

function slot0.canUse(slot0, slot1)
	return slot0:hasCloth(slot1) and OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.LeadRoleSkill)
end

function slot0.getSpEpisodeClothID(slot0)
	if not (HeroGroupModel.instance.episodeId or FightModel.instance:getFightParam() and FightModel.instance:getFightParam().episodeId) then
		return nil
	end

	slot3 = DungeonConfig.instance:getEpisodeCO(slot1) and lua_battle.configDict[slot2.battleId]

	if slot2.type == DungeonEnum.EpisodeType.Sp and slot3 and not string.nilorempty(slot3.clothSkill) then
		return string.splitToNumber(slot3.clothSkill, "#")[1]
	end

	return nil
end

slot0.instance = slot0.New()

return slot0
