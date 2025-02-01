module("modules.logic.dungeon.model.RoleStoryDispatchMO", package.seeall)

slot0 = pureTable("RoleStoryDispatchMO")

function slot0.init(slot0, slot1, slot2)
	slot0.id = slot1
	slot0.storyId = slot2
	slot0.config = RoleStoryConfig.instance:getDispatchConfig(slot1)
	slot0.heroIds = {}
	slot0.gainReward = false
	slot0.endTime = 0
end

function slot0.updateInfo(slot0, slot1)
	slot0.endTime = tonumber(slot1.endTime)
	slot0.gainReward = slot1.gainReward
	slot0.heroIds = {}

	for slot5 = 1, #slot1.heroIds do
		slot0.heroIds[slot5] = slot1.heroIds[slot5]
	end

	slot0:clearFinishAnimFlag()
	slot0:clearRefreshAnimFlag()
end

function slot0.updateTime(slot0, slot1)
	slot0.endTime = tonumber(slot1.endTime)
end

function slot0.completeDispatch(slot0)
	slot0.gainReward = true

	slot0:clearRefreshAnimFlag()
end

function slot0.resetDispatch(slot0)
	slot0.endTime = 0
	slot0.heroIds = {}
end

function slot0.getDispatchState(slot0)
	if slot0.gainReward then
		return RoleStoryEnum.DispatchState.Finish
	end

	if slot0.endTime > 0 then
		if ServerTime.now() >= slot0.endTime * 0.001 then
			return RoleStoryEnum.DispatchState.Canget
		else
			return RoleStoryEnum.DispatchState.Dispatching
		end
	end

	if slot0.config.unlockEpisodeId == 0 or DungeonModel.instance:hasPassLevelAndStory(slot1) then
		return RoleStoryEnum.DispatchState.Normal
	end

	return RoleStoryEnum.DispatchState.Locked
end

function slot0.getEffectHeros(slot0)
	if string.nilorempty(slot0.config.effectCondition) then
		return {}
	end

	slot3 = GameUtil.splitString2(slot2, true)
	slot5 = slot3[3]

	if slot3[1][1] == RoleStoryEnum.EffectConditionType.Heros then
		for slot9, slot10 in ipairs(slot5) do
			slot1[slot10] = true
		end
	elseif slot4 == RoleStoryEnum.EffectConditionType.Career then
		slot6 = HeroConfig.instance:getHeroesList()
		slot7 = {
			[slot12] = 1
		}

		for slot11, slot12 in ipairs(slot5) do
			-- Nothing
		end

		for slot11, slot12 in ipairs(slot6) do
			if slot7[slot12.career] then
				slot1[slot12.id] = true
			end
		end
	end

	return slot1
end

function slot0.isMeetEffectCondition(slot0)
	return slot0:checkHerosMeetEffectCondition(slot0.heroIds)
end

function slot0.checkHerosMeetEffectCondition(slot0, slot1)
	if string.nilorempty(slot0.config.effectCondition) then
		return false
	end

	slot3 = GameUtil.splitString2(slot2, true)
	slot5 = slot3[2][1] or 0
	slot6 = slot3[3]

	if slot3[1][1] == RoleStoryEnum.EffectConditionType.Heros then
		slot7 = 0

		for slot11, slot12 in ipairs(slot1) do
			for slot16, slot17 in ipairs(slot6) do
				if slot12 == slot17 then
					slot7 = slot7 + 1

					break
				end
			end
		end

		return slot5 <= slot7
	elseif slot4 == RoleStoryEnum.EffectConditionType.Career then
		slot7 = 0
		slot8 = {
			[slot13] = 1
		}

		for slot12, slot13 in ipairs(slot6) do
			-- Nothing
		end

		for slot12, slot13 in ipairs(slot1) do
			if slot8[HeroConfig.instance:getHeroCO(slot13).career] then
				slot7 = slot7 + 1
			end
		end

		return slot5 <= slot7
	end

	return false
end

function slot0.getEffectAddRewardCount(slot0)
	return ((string.splitToNumber(slot0.config.effect, "_")[2] or 1) - 1) * slot0.config.scoreReward
end

function slot0.getEffectDelTimeCount(slot0)
	return string.splitToNumber(slot0.config.effect, "_")[1] or 0
end

function slot0.isNewFinish(slot0)
	slot1 = slot0:getDispatchState()
	slot0.lastState = slot1

	if slot1 == RoleStoryEnum.DispatchState.Canget and slot0.lastState == RoleStoryEnum.DispatchState.Dispatching then
		return true
	end
end

function slot0.checkFinishAnimIsPlayed(slot0)
	return PlayerPrefsHelper.getNumber(string.format("%s_%s_%s_%s", PlayerModel.instance:getMyUserId(), PlayerPrefsKey.RoleStoryDispatchFinishAnim, slot0.storyId, slot0.id), 0) == 1
end

function slot0.clearFinishAnimFlag(slot0)
	if slot0:getDispatchState() == RoleStoryEnum.DispatchState.Finish then
		return
	end

	PlayerPrefsHelper.setNumber(string.format("%s_%s_%s_%s", PlayerModel.instance:getMyUserId(), PlayerPrefsKey.RoleStoryDispatchFinishAnim, slot0.storyId, slot0.id), 0)
end

function slot0.setFinishAnimFlag(slot0)
	if slot0:getDispatchState() ~= RoleStoryEnum.DispatchState.Finish then
		return
	end

	PlayerPrefsHelper.setNumber(string.format("%s_%s_%s_%s", PlayerModel.instance:getMyUserId(), PlayerPrefsKey.RoleStoryDispatchFinishAnim, slot0.storyId, slot0.id), 1)
end

function slot0.canPlayRefreshAnim(slot0)
	if slot0:getDispatchState() ~= RoleStoryEnum.DispatchState.Normal then
		return
	end

	return PlayerPrefsHelper.getNumber(string.format("%s_%s_%s_%s", PlayerModel.instance:getMyUserId(), PlayerPrefsKey.RoleStoryDispatchRefreshAnim, slot0.storyId, slot0.id), 0) == 0
end

function slot0.clearRefreshAnimFlag(slot0)
	if slot0:getDispatchState() == RoleStoryEnum.DispatchState.Finish or slot1 == RoleStoryEnum.DispatchState.Locked then
		PlayerPrefsHelper.setNumber(string.format("%s_%s_%s_%s", PlayerModel.instance:getMyUserId(), PlayerPrefsKey.RoleStoryDispatchRefreshAnim, slot0.storyId, slot0.id), 0)
	end
end

function slot0.setRefreshAnimFlag(slot0)
	if slot0:getDispatchState() ~= RoleStoryEnum.DispatchState.Normal then
		return
	end

	PlayerPrefsHelper.setNumber(string.format("%s_%s_%s_%s", PlayerModel.instance:getMyUserId(), PlayerPrefsKey.RoleStoryDispatchRefreshAnim, slot0.storyId, slot0.id), 1)
end

return slot0
