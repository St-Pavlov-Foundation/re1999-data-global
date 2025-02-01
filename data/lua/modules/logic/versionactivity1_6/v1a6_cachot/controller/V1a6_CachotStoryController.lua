module("modules.logic.versionactivity1_6.v1a6_cachot.controller.V1a6_CachotStoryController", package.seeall)

slot0 = class("V1a6_CachotStoryController", BaseController)

function slot0.onInit(slot0)
end

function slot0.reInit(slot0)
end

function slot0.addConstEvents(slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, slot0.checkPlayStory, slot0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.CheckPlayStory, slot0.onSwitchLevel, slot0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnFinishGame, slot0.onFinishGame, slot0)
end

function slot0.checkPlayStory(slot0, slot1, slot2)
	if slot1 == ViewName.V1a6_CachotMainView then
		if V1a6_CachotConfig.instance:getConstConfig(V1a6_CachotEnum.Const.StoryNode1).value and slot3 ~= 0 and not StoryModel.instance:isStoryFinished(tonumber(slot3)) then
			StoryController.instance:playStory(tonumber(slot3), {
				mark = true,
				isReplay = false
			}, nil, slot0)
		end
	end
end

function slot0.onSwitchLevel(slot0, slot1)
	slot2 = nil

	if not V1a6_CachotModel.instance:getRogueInfo() then
		return
	end

	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Cachot then
		return
	end

	if slot3.layer == 1 and V1a6_CachotRoomConfig.instance:checkNextRoomIsLastRoom(slot3.room) then
		slot2 = V1a6_CachotConfig.instance:getConstConfig(V1a6_CachotEnum.Const.StoryNode2).value
	elseif slot3.layer == 2 and V1a6_CachotRoomConfig.instance:checkNextRoomIsLastRoom(slot3.room) then
		slot2 = V1a6_CachotConfig.instance:getConstConfig(V1a6_CachotEnum.Const.StoryNode4).value
	end

	if slot2 and slot2 ~= 0 and not StoryModel.instance:isStoryFinished(tonumber(slot2)) then
		StoryController.instance:playStory(tonumber(slot2), {
			mark = true,
			isReplay = false
		}, nil, slot0)
	end
end

function slot0.onFinishGame(slot0, slot1)
	if lua_rogue_ending.configDict[slot1] and slot2.storyId and slot3 ~= 0 then
		StoryController.instance:playStory(slot3, nil, slot0._jump2CachotEndingView, slot0)
	else
		logError(string.format("cannot find endingConfig or storyConfig, endingId = %s, storyId = %s", slot1, slot3))
		slot0:_jump2CachotEndingView()
	end
end

function slot0._jump2CachotEndingView(slot0)
	V1a6_CachotController.instance:openV1a6_CachotEndingView()
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0
