module("modules.common.global.screen.GameScreenBrightness", package.seeall)

slot0 = class("GameScreenBrightness")

function slot0.ctor(slot0)
	if BootNativeUtil.isAndroid() or BootNativeUtil.isIOS() then
		slot0:_setScreenLightingOff(false)
		GameSceneMgr.instance:registerCallback(SceneEventName.EnterSceneFinish, slot0._onEnterOneSceneFinish, slot0)
		StoryController.instance:registerCallback(StoryEvent.RefreshStep, slot0._onRefreshState, slot0)
		StoryController.instance:registerCallback(StoryEvent.Auto, slot0._refreshAutoState, slot0)
		StoryController.instance:registerCallback(StoryEvent.Finish, slot0._onStoryFinished, slot0)
		StoryController.instance:registerCallback(StoryEvent.Log, slot0._refreshAutoState, slot0)
		SettingsController.instance:registerCallback(SettingsEvent.OnChangeEnergyMode, slot0._onChangeEnergyMode, slot0)
	end
end

function slot0._onChangeEnergyMode(slot0)
	slot0:_setScreenLightingOff(GameSceneMgr.instance:getCurSceneType() == SceneType.Fight)
end

function slot0._onEnterOneSceneFinish(slot0, slot1, slot2)
	slot0:_setScreenLightingOff(slot1 == SceneType.Fight)
end

function slot0._onRefreshState(slot0, slot1)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		return
	end

	if #slot1.branches > 0 then
		slot0:_setScreenLightingOff(true)

		return
	end

	slot0._stepCo = StoryStepModel.instance:getStepListById(slot1.stepId)

	slot0:_refreshAutoState()
end

function slot0._refreshAutoState(slot0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		return
	end

	if StoryModel.instance:isStoryAuto() then
		slot0:_setScreenLightingOff(true)

		return
	end

	slot3 = false

	if slot0._stepCo and (slot0._stepCo.conversation.type == StoryEnum.ConversationType.None or slot0._stepCo.conversation.type == StoryEnum.ConversationType.ScreenDialog or slot0._stepCo.conversation.type == StoryEnum.ConversationType.NoInteract) then
		slot3 = true
	end

	slot0:_setScreenLightingOff(slot3)
end

function slot0._onStoryFinished(slot0)
	if GameSceneMgr.instance:getCurSceneType() == SceneType.Fight then
		return
	end

	slot0:_setScreenLightingOff(false)
end

function slot0._setScreenLightingOff(slot0, slot1)
	if SettingsModel.instance:getEnergyMode() == 0 then
		SDKMgr.instance:setScreenLightingOff(true)
	else
		SDKMgr.instance:setScreenLightingOff(slot1)
	end
end

return slot0
