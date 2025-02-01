module("modules.logic.versionactivity1_6.v1a6_cachot.controller.V1a6_CachotRoomController", package.seeall)

slot0 = class("V1a6_CachotRoomController", BaseController)

function slot0.reInit(slot0)
	slot0._isSwitchLevel = nil

	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.RoomViewOpenAnimEnd, slot0._switchLevel, slot0)
end

function slot0.addConstEvents(slot0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.RoomChange, slot0._checkAndSwitchLevel, slot0)
	GameSceneMgr.instance:registerCallback(SceneEventName.OnLevelLoaded, slot0._playRoomViewOpenAnim, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, slot0._checkAndSwitchLevel, slot0)
end

function slot0._checkAndSwitchLevel(slot0)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Cachot then
		return
	end

	if not V1a6_CachotRoomModel.instance:getRoomIsChange() then
		return
	end

	if not V1a6_CachotModel.instance:getRogueInfo() then
		return
	end

	if not ViewHelper.instance:checkViewOnTheTop(ViewName.V1a6_CachotRoomView) then
		return
	end

	if PopupController.instance:getPopupCount() > 0 then
		return false
	end

	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.RoomChangeBegin)

	if V1a6_CachotRoomModel.instance:getLayerIsChange() then
		V1a6_CachotRoomModel.instance:clearRoomChangeStatus()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.LoadingCachotChangeView)
		GameSceneMgr.instance:startScene(SceneType.Cachot, 90001, V1a6_CachotConfig.instance:getSceneLevelId(slot1.sceneId), true, true)
	else
		V1a6_CachotRoomModel.instance:clearRoomChangeStatus()
		V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.RoomViewOpenAnimEnd, slot0._switchLevel, slot0)
	end
end

function slot0._switchLevel(slot0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.RoomViewOpenAnimEnd, slot0._switchLevel, slot0)

	if not V1a6_CachotModel.instance:getRogueInfo() then
		return
	end

	slot0._isSwitchLevel = true

	GameSceneMgr.instance:getCurScene().level:switchLevel(V1a6_CachotConfig.instance:getSceneLevelId(slot1.sceneId))
end

function slot0._playRoomViewOpenAnim(slot0, slot1)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Cachot then
		return
	end

	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.RoomChangePlayAnim, slot0._isSwitchLevel)

	slot0._isSwitchLevel = nil
end

slot0.instance = slot0.New()

return slot0
