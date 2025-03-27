module("modules.logic.guide.controller.GuideInvalidController", package.seeall)

slot0 = class("GuideInvalidController", BaseController)
slot1 = "EndFight"
slot2 = "ActivityEnd"
slot3 = "InvalidCondition"
slot4 = "checkFinishGuide"
slot5 = "FinishElement"
slot6 = "InvalidNotInWindows"

function slot0.addConstEvents(slot0)
	PlayerController.instance:registerCallback(PlayerEvent.PlayerLevelUp, slot0._checkFinishGuideInMainView, slot0)
	GuideController.instance:registerCallback(GuideEvent.StartGuide, slot0._onStartGuide, slot0)
	GuideController.instance:registerCallback(GuideEvent.FinishGuide, slot0._onFinishedGuide, slot0)
	GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, slot0._onEnterOneSceneFinish, slot0)
	FightController.instance:registerCallback(FightEvent.RespBeginFight, slot0._respBeginFight, slot0)
	FightController.instance:registerCallback(FightEvent.OnEndFightForGuide, slot0._onEndFight, slot0)
	ActivityController.instance:registerCallback(ActivityEvent.CheckGuideOnEndActivity, slot0._onActivityEnd, slot0)
end

function slot0.isInvalid(slot0, slot1)
	if not GuideConfig.instance:getGuideCO(slot1) or slot2.isOnline == 0 then
		return true
	end

	if not GuideConfig.instance:getInvalidList(slot1) then
		return false
	end

	slot5 = GuideModel.instance:getById(slot1)

	for slot9, slot10 in ipairs(slot3) do
		if slot10[1] == "PlayerLv" then
			slot4 = tonumber(slot10[2]) <= PlayerModel.instance:getPlayinfo().level
		elseif slot11 == "EpisodeFinish" then
			slot13 = tonumber(slot12)
			slot15 = DungeonConfig.instance:getEpisodeCO(slot13)

			if DungeonModel.instance:getEpisodeInfo(slot13) and DungeonEnum.StarType.None < slot14.star and slot15 then
				if slot15.afterStory > 0 and slot15.afterStory > 0 then
					slot4 = StoryModel.instance:isStoryFinished(slot15.afterStory)
				else
					slot4 = false

					if false then
						slot4 = true
					end
				end
			end
		elseif slot11 == "FinishTask" then
			slot4 = TaskModel.instance:getTaskById(tonumber(slot12)) and slot14.finishCount > 0
		elseif slot11 == "EnterEpisode" then
			slot13 = tonumber(slot12)

			if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
				slot4 = FightModel.instance:getFightParam() and slot14.episodeId and slot13 and slot14.episodeId == slot13
			else
				slot4 = false
			end
		elseif slot11 == "ExitEpisode" then
			slot4 = slot5 ~= nil and GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight
		elseif slot11 == uv0 then
			slot4 = DungeonMapModel.instance:elementIsFinished(tonumber(slot12))
		elseif slot11 == uv1 then
			if slot5 ~= nil then
				slot4 = slot0._hasEndFight
			else
				slot4 = false
			end
		elseif slot11 == uv2 then
			slot4 = GuideInvalidCondition[slot12](slot1, slot10)
		elseif slot11 == uv3 then
			if ActivityModel.instance:getActMO(tonumber(slot12)) then
				slot4 = slot5 ~= nil and ActivityHelper.getActivityStatus(slot13) == ActivityEnum.ActivityStatus.Expired
			end
		else
			slot4 = (slot11 ~= uv4 or not BootNativeUtil.isWindows()) and false
		end

		if slot4 then
			break
		end
	end

	return slot4
end

function slot0._checkFinishGuideInMainView(slot0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Main then
		slot0:_checkFinishGuide()
	end
end

function slot0.hasInvalidGuide(slot0)
	for slot5, slot6 in ipairs(GuideConfig.instance:getGuideList()) do
		if (GuideModel.instance:getById(slot6.id) == nil or not slot8.isFinish) and slot0:isInvalid(slot7) then
			return true
		end
	end

	return false
end

function slot0.checkInvalid(slot0)
	slot0:_checkFinishGuide()
end

function slot0._checkFinishGuide(slot0)
	for slot5, slot6 in ipairs(GuideConfig.instance:getGuideList()) do
		if (GuideModel.instance:getById(slot6.id) == nil or not slot8.isFinish) and slot0:isInvalid(slot7) then
			GuideController.instance:oneKeyFinishGuide(slot7, true)
		end
	end
end

function slot0._onStartGuide(slot0, slot1)
	if not GuideModel.instance:isGMStartGuide(slot1) and (GuideModel.instance:getById(slot1) == nil or not slot2.isFinish) and slot0:isInvalid(slot1) then
		GuideController.instance:oneKeyFinishGuide(slot1, true)
	end
end

function slot0._onFinishedGuide(slot0, slot1)
	for slot6 = 1, #GuideModel.instance:getList() do
		slot7 = slot2[slot6]
		slot10 = GuideConfig.instance:getInvalidList(slot7.id)

		if (slot7 == nil or not slot7.isFinish) and slot10 then
			for slot14, slot15 in ipairs(slot10) do
				slot17 = slot15[2]

				if slot15[1] == uv0 and slot17 == uv1 and GuideInvalidCondition[slot17](slot8, slot15) then
					GuideController.instance:oneKeyFinishGuide(slot8, true)
				end
			end
		end
	end
end

function slot0._onEnterOneSceneFinish(slot0, slot1, slot2)
	if slot1 == SceneType.Fight then
		if SkillEditorMgr and SkillEditorMgr.instance.inEditMode then
			return
		end

		slot0:_checkFinishGuide()

		slot0._hasEnterBattle = true
	else
		if slot0._hasEnterBattle then
			slot0:_checkFinishGuide()
		end

		slot0._hasEnterBattle = nil
	end
end

function slot0._respBeginFight(slot0)
	slot0._hasEndFight = false
end

function slot0._onEndFight(slot0)
	slot0._hasEndFight = true

	for slot5 = 1, #GuideModel.instance:getList() do
		if GuideConfig.instance:getInvalidTypeList(slot1[slot5].id) and tabletool.indexOf(slot7, uv0) and (GuideModel.instance:getById(slot6) == nil or not slot8.isFinish) and slot0:isInvalid(slot6) then
			GuideController.instance:oneKeyFinishGuide(slot6, true)
		end
	end
end

function slot0._onActivityEnd(slot0)
	for slot5 = 1, #GuideModel.instance:getList() do
		if GuideConfig.instance:getInvalidTypeList(slot1[slot5].id) and tabletool.indexOf(slot7, uv0) and (GuideModel.instance:getById(slot6) == nil or not slot8.isFinish) and slot0:isInvalid(slot6) then
			GuideController.instance:oneKeyFinishGuide(slot6, true)
		end
	end
end

slot0.instance = slot0.New()

return slot0
