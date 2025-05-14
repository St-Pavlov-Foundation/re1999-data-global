module("modules.logic.versionactivity2_5.dungeon.view.map.scene.VersionActivity2_5DungeonMapHoleView", package.seeall)

local var_0_0 = class("VersionActivity2_5DungeonMapHoleView", DungeonMapHoleView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, arg_2_0.loadSceneFinish, arg_2_0)
	arg_2_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_2_0.initCameraParam, arg_2_0)
	arg_2_0:addEventCb(VersionActivity2_5DungeonController.instance, VersionActivity2_5DungeonEvent.OnMapPosChanged, arg_2_0.onMapPosChanged, arg_2_0)
	arg_2_0:addEventCb(VersionActivity2_5DungeonController.instance, VersionActivity2_5DungeonEvent.OnAddOneElement, arg_2_0.onAddOneElement, arg_2_0)
	arg_2_0:addEventCb(VersionActivity2_5DungeonController.instance, VersionActivity2_5DungeonEvent.OnRemoveElement, arg_2_0.onRemoveElement, arg_2_0)
	arg_2_0:addEventCb(VersionActivity2_5DungeonController.instance, VersionActivity2_5DungeonEvent.OnRecycleAllElement, arg_2_0.onRecycleAllElement, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, arg_3_0.loadSceneFinish, arg_3_0)
	arg_3_0:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_3_0.initCameraParam, arg_3_0)
	arg_3_0:removeEventCb(VersionActivity2_5DungeonController.instance, VersionActivity2_5DungeonEvent.OnMapPosChanged, arg_3_0.onMapPosChanged, arg_3_0)
	arg_3_0:removeEventCb(VersionActivity2_5DungeonController.instance, VersionActivity2_5DungeonEvent.OnAddOneElement, arg_3_0.onAddOneElement, arg_3_0)
	arg_3_0:removeEventCb(VersionActivity2_5DungeonController.instance, VersionActivity2_5DungeonEvent.OnRemoveElement, arg_3_0.onRemoveElement, arg_3_0)
	arg_3_0:removeEventCb(VersionActivity2_5DungeonController.instance, VersionActivity2_5DungeonEvent.OnRecycleAllElement, arg_3_0.onRecycleAllElement, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.loadSceneFinish(arg_5_0, arg_5_1)
	local var_5_0 = {
		arg_5_1.mapConfig,
		arg_5_1.mapSceneGo
	}

	var_0_0.super.loadSceneFinish(arg_5_0, var_5_0)
end

function var_0_0.onMapPosChanged(arg_6_0, arg_6_1, arg_6_2)
	var_0_0.super.onMapPosChanged(arg_6_0, arg_6_1, arg_6_2)
end

function var_0_0.initCameraParam(arg_7_0)
	var_0_0.super.initCameraParam(arg_7_0)
end

function var_0_0.onAddOneElement(arg_8_0, arg_8_1)
	if arg_8_1 then
		local var_8_0 = arg_8_1:getElementId()

		arg_8_0:_onAddElement(var_8_0)
	end
end

function var_0_0.onRemoveElement(arg_9_0, arg_9_1)
	if arg_9_1 and arg_9_1._config.fragment == 0 then
		local var_9_0 = arg_9_1:getElementId()

		arg_9_0:_onRemoveElement(var_9_0)
	end
end

function var_0_0.onRecycleAllElement(arg_10_0)
	arg_10_0:refreshHoles()
end

return var_0_0
