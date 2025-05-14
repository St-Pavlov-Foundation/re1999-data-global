module("modules.logic.versionactivity1_6.v1a6_cachot.controller.V1a6_CachotRoomController", package.seeall)

local var_0_0 = class("V1a6_CachotRoomController", BaseController)

function var_0_0.reInit(arg_1_0)
	arg_1_0._isSwitchLevel = nil

	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.RoomViewOpenAnimEnd, arg_1_0._switchLevel, arg_1_0)
end

function var_0_0.addConstEvents(arg_2_0)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.RoomChange, arg_2_0._checkAndSwitchLevel, arg_2_0)
	GameSceneMgr.instance:registerCallback(SceneEventName.OnLevelLoaded, arg_2_0._playRoomViewOpenAnim, arg_2_0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseView, arg_2_0._checkAndSwitchLevel, arg_2_0)
end

function var_0_0._checkAndSwitchLevel(arg_3_0)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Cachot then
		return
	end

	if not V1a6_CachotRoomModel.instance:getRoomIsChange() then
		return
	end

	local var_3_0 = V1a6_CachotModel.instance:getRogueInfo()

	if not var_3_0 then
		return
	end

	if not ViewHelper.instance:checkViewOnTheTop(ViewName.V1a6_CachotRoomView) then
		return
	end

	if PopupController.instance:getPopupCount() > 0 then
		return false
	end

	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.RoomChangeBegin)

	local var_3_1 = V1a6_CachotConfig.instance:getSceneLevelId(var_3_0.sceneId)

	if V1a6_CachotRoomModel.instance:getLayerIsChange() then
		V1a6_CachotRoomModel.instance:clearRoomChangeStatus()
		GameSceneMgr.instance:dispatchEvent(SceneEventName.SetLoadingTypeOnce, GameLoadingState.LoadingCachotChangeView)
		GameSceneMgr.instance:startScene(SceneType.Cachot, 90001, var_3_1, true, true)
	else
		V1a6_CachotRoomModel.instance:clearRoomChangeStatus()
		V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.RoomViewOpenAnimEnd, arg_3_0._switchLevel, arg_3_0)
	end
end

function var_0_0._switchLevel(arg_4_0)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.RoomViewOpenAnimEnd, arg_4_0._switchLevel, arg_4_0)

	local var_4_0 = V1a6_CachotModel.instance:getRogueInfo()

	if not var_4_0 then
		return
	end

	local var_4_1 = V1a6_CachotConfig.instance:getSceneLevelId(var_4_0.sceneId)

	arg_4_0._isSwitchLevel = true

	GameSceneMgr.instance:getCurScene().level:switchLevel(var_4_1)
end

function var_0_0._playRoomViewOpenAnim(arg_5_0, arg_5_1)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Cachot then
		return
	end

	V1a6_CachotController.instance:dispatchEvent(V1a6_CachotEvent.RoomChangePlayAnim, arg_5_0._isSwitchLevel)

	arg_5_0._isSwitchLevel = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
