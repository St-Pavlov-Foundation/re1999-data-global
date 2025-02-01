module("modules.logic.story.controller.StoryGCController", package.seeall)

slot0 = class("StoryGCController", BaseController)
slot1 = 3
slot2 = 10
slot3 = 1
slot4 = 2
slot5 = 3
slot6 = 4
slot7 = 5

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.addConstEvents(slot0)
	StoryController.instance:registerCallback(StoryEvent.Start, slot0._onStart, slot0)
	StoryController.instance:registerCallback(StoryEvent.Finish, slot0._onFinish, slot0)
	StoryController.instance:registerCallback(StoryEvent.RefreshStep, slot0._onStep, slot0)
	StoryController.instance:registerCallback(StoryEvent.OnBgmStop, slot0._onTriggerBgmStop, slot0)
	StoryController.instance:registerCallback(StoryEvent.VideoStart, slot0._onVideoStart, slot0)
end

function slot0._onStart(slot0, slot1)
	slot0._storyId = slot1
	slot0._markUseDict = {}
	slot0._markUseList = {}
	slot0._usingList = {}
	slot0._currBg = nil
	slot0._videoStepCountDown = nil
	slot0._stepCount = 0

	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight and FightModel.instance:isFinish() then
		logNormal("战斗内播放战后剧情，清理战斗资源")
		FightFloatMgr.instance:dispose()
		ViewMgr.instance:closeView(ViewName.FightSkillSelectView, true)
		GameSceneMgr.instance:getScene(SceneType.Fight).entityMgr:removeAllUnits()
		FightPreloadController.instance:dispose()
		FightRoundPreloadController.instance:dispose()
		GameGCMgr.instance:dispatchEvent(GameGCEvent.DelayFullGC, 1, slot0)
	end
end

function slot0._onFinish(slot0, slot1)
	slot0._storyId = nil
	slot0._markUseDict = {}
	slot0._markUseList = {}
	slot0._usingList = {}
	slot0._currBg = nil

	GameGCMgr.instance:dispatchEvent(GameGCEvent.AudioGC, slot0)
	GameGCMgr.instance:dispatchEvent(GameGCEvent.CancelDelayAudioGC, slot0)
end

function slot0._onStep(slot0, slot1)
	slot2 = slot1.stepType
	slot3 = slot1.stepId
	slot0._stepId = slot3
	slot4 = slot1.branches
	slot0._usingList = {}
	slot5 = slot3 and StoryStepModel.instance:getStepListById(slot3)

	if slot5 and slot5.bg and slot6.transType ~= StoryEnum.BgTransType.Keep then
		if not slot0._markUseDict[slot6.bgImg] then
			slot0._markUseDict[slot6.bgImg] = true
			slot7 = {
				type = uv0,
				path = slot6.bgImg
			}

			table.insert(slot0._markUseList, slot7)
			table.insert(slot0._usingList, slot7)

			slot0._currBg = slot6.bgImg
		elseif slot0._currBg then
			table.insert(slot0._usingList, {
				type = uv0,
				path = slot0._currBg
			})
		end
	elseif slot0._currBg then
		table.insert(slot0._usingList, {
			type = uv0,
			path = slot0._currBg
		})
	end

	for slot11, slot12 in ipairs(slot5 and slot5.heroList) do
		if not slot0._markUseDict[StoryHeroLibraryModel.instance:getStoryLibraryHeroByIndex(slot12.heroIndex).type == 0 and slot13.prefab or slot13.live2dPrefab] then
			slot0._markUseDict[slot15] = true
			slot16 = {
				type = slot14 and uv1 or uv2,
				path = slot15
			}

			table.insert(slot0._markUseList, slot16)
			table.insert(slot0._usingList, slot16)
		end
	end

	for slot12, slot13 in ipairs(slot5 and slot5.effList) do
		if not slot0._markUseDict[slot13.effect] then
			slot0._markUseDict[slot13.effect] = true
			slot14 = {
				type = uv3,
				path = slot13.effect
			}

			table.insert(slot0._markUseList, slot14)
			table.insert(slot0._usingList, slot14)
		end
	end

	slot12 = false

	if #(slot5 and slot5.videoList) > 0 then
		slot0._videoStepCountDown = 5
	elseif slot0._videoStepCountDown then
		slot0._videoStepCountDown = slot0._videoStepCountDown - 1

		if slot0._videoStepCountDown <= 0 then
			slot0._videoStepCountDown = nil
			slot12 = true
		end
	end

	slot0:_checkGC(slot12)
end

function slot0._onVideoStart(slot0, slot1, slot2)
	slot0:_checkGC(true)
end

function slot0._checkGC(slot0, slot1)
	if uv0 <= #slot0._markUseList - #slot0._usingList or slot1 then
		slot0._markUseList = {}

		for slot7, slot8 in ipairs(slot0._usingList) do
			if slot8.path then
				slot0._markUseDict[slot8.path] = true

				table.insert(slot0._markUseList, slot8)
			end
		end

		GameGCMgr.instance:dispatchEvent(GameGCEvent.StoryGC, slot0)
	end

	slot0._stepCount = slot0._stepCount + 1

	if slot0._stepCount % uv1 == 0 then
		GameGCMgr.instance:dispatchEvent(GameGCEvent.AudioGC, slot0)
	end
end

function slot0._onTriggerBgmStop(slot0)
	GameGCMgr.instance:dispatchEvent(GameGCEvent.DelayAudioGC, 0.5, slot0)
end

slot0.instance = slot0.New()

return slot0
