module("modules.logic.toughbattle.model.ToughBattleModel", package.seeall)

slot0 = class("ToughBattleModel", BaseModel)

function slot0.onInit(slot0)
	slot0._isActOnline = false
	slot0._actInfo = nil
	slot0._storyInfo = nil
	slot0._isJumpToActElement = false
end

function slot0.reInit(slot0)
	slot0:onInit()
end

function slot0.getIsJumpActElement(slot0)
	return slot0._isJumpToActElement
end

function slot0.setIsJumpActElement(slot0, slot1)
	slot0._isJumpToActElement = slot1
end

function slot0.getActIsOnline(slot0)
	return slot0._isActOnline
end

function slot0.setActOffLine(slot0)
	slot0._isActOnline = false
	slot0._actInfo = nil
end

function slot0.onGetActInfo(slot0, slot1)
	slot0._isActOnline = true
	slot0._actInfo = slot1

	ToughBattleController.instance:dispatchEvent(ToughBattleEvent.ToughBattleActChange)
end

function slot0.getActInfo(slot0)
	return slot0._actInfo
end

function slot0.isDropActItem(slot0)
	if not slot0:getActIsOnline() then
		return true
	end

	return #slot0._actInfo.enterDifficulty < 3
end

function slot0.onGetStoryInfo(slot0, slot1)
	slot0._storyInfo = slot1
end

function slot0.getStoryInfo(slot0)
	return slot0._storyInfo
end

function slot0.isStoryFinish(slot0)
	if not slot0._storyInfo then
		return false
	end

	return slot0._storyInfo.openChallenge and #slot0._storyInfo.passChallengeIds >= 4
end

function slot0.getEpisodeId(slot0)
	if not FightModel.instance:getFightParam() then
		return false
	end

	if not slot1.episodeId then
		return false
	end

	if not ToughBattleConfig.instance:getCoByEpisodeId(slot2) then
		return false
	end

	return slot2
end

function slot0.getAddTrialHeros(slot0)
	if not slot0:getEpisodeId() then
		return false
	end

	if not ToughBattleConfig.instance:getCoByEpisodeId(slot1) then
		return false
	end

	slot4 = {}

	if ToughBattleConfig.instance:isActEpisodeId(slot1) then
		if not slot0:getActInfo() then
			return false
		end

		for slot9, slot10 in ipairs(slot5.passChallengeIds) do
			if lua_activity158_challenge.configDict[slot10] and slot11.heroId > 0 and lua_siege_battle_hero.configDict[slot11.heroId] and slot12.type == ToughBattleEnum.HeroType.Hero then
				table.insert(slot4, tonumber(slot12.param))
			end
		end
	else
		if not slot0:getStoryInfo() then
			return false
		end

		for slot9, slot10 in ipairs(slot5.passChallengeIds) do
			if lua_siege_battle.configDict[slot10] and slot11.heroId > 0 and lua_siege_battle_hero.configDict[slot11.heroId] and slot12.type == ToughBattleEnum.HeroType.Hero then
				table.insert(slot4, tonumber(slot12.param))
			end
		end
	end

	if not slot4[1] then
		return false
	end

	return slot4
end

slot0.instance = slot0.New()

return slot0
