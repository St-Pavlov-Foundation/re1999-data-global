module("modules.logic.versionactivity3_1.dungeon.view.map.scene.VersionActivity3_1DungeonMapSceneElements", package.seeall)

local var_0_0 = class("VersionActivity3_1DungeonMapSceneElements", VersionActivityFixedDungeonMapSceneElements)

function var_0_0.addEvents(arg_1_0)
	if GamepadController.instance:isOpen() then
		arg_1_0:addEventCb(GamepadController.instance, GamepadEvent.KeyDown, arg_1_0.onGamepadKeyDown, arg_1_0)
	end

	arg_1_0:addEventCb(DungeonController.instance, DungeonEvent.OnBeginDragMap, arg_1_0.onBeginDragMap, arg_1_0)
	arg_1_0:addEventCb(DungeonController.instance, DungeonEvent.OnCreateMapRootGoDone, arg_1_0.onCreateMapRootGoDone, arg_1_0)
	arg_1_0:addEventCb(DungeonController.instance, DungeonEvent.BeginShowRewardView, arg_1_0.beginShowRewardView, arg_1_0)
	arg_1_0:addEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, arg_1_0.endShowRewardView, arg_1_0)
	arg_1_0:addEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, arg_1_0.onRemoveElement, arg_1_0)
	arg_1_0:addEventCb(DungeonController.instance, DungeonEvent.GuideClickElement, arg_1_0.manualClickElement, arg_1_0)
	arg_1_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnUpdateElementArrow, arg_1_0._updateElementArrow, arg_1_0)
	arg_1_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnInitElements, arg_1_0.showElements, arg_1_0)
	arg_1_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, arg_1_0.loadSceneFinish, arg_1_0)
	arg_1_0:addEventCb(VersionActivityFixedDungeonController.instance, VersionActivity3_1DungeonEvent.V3a1SceneLoadSceneFinish, arg_1_0.onDisposeOldMap, arg_1_0)
	arg_1_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnDisposeScene, arg_1_0.onDisposeScene, arg_1_0)
	arg_1_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnChangeMap, arg_1_0.onChangeMap, arg_1_0)
	arg_1_0:addEventCb(VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OnClickElement, arg_1_0.onClickElement, arg_1_0)
	arg_1_0:addEventCb(VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OnHideInteractUI, arg_1_0.onHideInteractUI, arg_1_0)
	arg_1_0._click:AddClickUpListener(arg_1_0.onClickUp, arg_1_0)
	arg_1_0._click:AddClickDownListener(arg_1_0.onClickDown, arg_1_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_1_0.showNewElements, arg_1_0)
end

function var_0_0.removeEvents(arg_2_0)
	arg_2_0:removeEventCb(GamepadController.instance, GamepadEvent.KeyDown, arg_2_0.onGamepadKeyDown, arg_2_0)
	arg_2_0:removeEventCb(DungeonController.instance, DungeonEvent.OnBeginDragMap, arg_2_0.onBeginDragMap, arg_2_0)
	arg_2_0:removeEventCb(DungeonController.instance, DungeonEvent.OnCreateMapRootGoDone, arg_2_0.onCreateMapRootGoDone, arg_2_0)
	arg_2_0:removeEventCb(DungeonController.instance, DungeonEvent.BeginShowRewardView, arg_2_0.beginShowRewardView, arg_2_0)
	arg_2_0:removeEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, arg_2_0.endShowRewardView, arg_2_0)
	arg_2_0:removeEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, arg_2_0.onRemoveElement, arg_2_0)
	arg_2_0:removeEventCb(DungeonController.instance, DungeonEvent.GuideClickElement, arg_2_0.manualClickElement, arg_2_0)
	arg_2_0:removeEventCb(DungeonController.instance, DungeonMapElementEvent.OnUpdateElementArrow, arg_2_0._updateElementArrow, arg_2_0)
	arg_2_0:removeEventCb(DungeonController.instance, DungeonMapElementEvent.OnInitElements, arg_2_0.showElements, arg_2_0)
	arg_2_0:removeEventCb(DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, arg_2_0.loadSceneFinish, arg_2_0)
	arg_2_0:removeEventCb(VersionActivityFixedDungeonController.instance, VersionActivity3_1DungeonEvent.V3a1SceneLoadSceneFinish, arg_2_0.onDisposeOldMap, arg_2_0)
	arg_2_0:removeEventCb(DungeonController.instance, DungeonMapElementEvent.OnDisposeScene, arg_2_0.onDisposeScene, arg_2_0)
	arg_2_0:removeEventCb(DungeonController.instance, DungeonMapElementEvent.OnChangeMap, arg_2_0.onChangeMap, arg_2_0)
	arg_2_0:removeEventCb(VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OnClickElement, arg_2_0.onClickElement, arg_2_0)
	arg_2_0:removeEventCb(VersionActivityFixedDungeonController.instance, VersionActivityFixedDungeonEvent.OnHideInteractUI, arg_2_0.onHideInteractUI, arg_2_0)
	arg_2_0._click:RemoveClickUpListener()
	arg_2_0._click:RemoveClickDownListener()
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, arg_2_0.showNewElements, arg_2_0)
end

function var_0_0.loadSceneFinish(arg_3_0, arg_3_1)
	arg_3_0._mapCfg = arg_3_1.mapConfig
	arg_3_0._sceneGo = arg_3_1.mapSceneGo
	arg_3_0._elementRoot = UnityEngine.GameObject.New("elementRoot")

	local var_3_0 = gohelper.findChild(arg_3_0._sceneGo, "root")

	gohelper.addChild(var_3_0, arg_3_0._elementRoot)
end

function var_0_0.recycleAllElements(arg_4_0)
	if arg_4_0._elementCompDict then
		for iter_4_0, iter_4_1 in pairs(arg_4_0._elementCompDict) do
			local var_4_0 = iter_4_1:getElementId()

			arg_4_0._elementCompPoolDict[var_4_0] = iter_4_1

			gohelper.addChild(arg_4_0.elementPoolRoot, iter_4_1._go)
			gohelper.setActive(iter_4_1._go, false)
		end

		tabletool.clear(arg_4_0._elementCompDict)
	end

	VersionActivityFixedDungeonController.instance:dispatchEvent(VersionActivityFixedDungeonEvent.OnRecycleAllElement)
end

function var_0_0._addElement(arg_5_0, arg_5_1)
	if arg_5_0._elementCompDict[arg_5_1.id] then
		return
	end

	local var_5_0 = arg_5_0._elementCompPoolDict[arg_5_1.id]

	if var_5_0 then
		arg_5_0._elementCompPoolDict[arg_5_1.id] = nil

		gohelper.addChild(arg_5_0._elementRoot, var_5_0._go)
		var_5_0:updatePos()
	else
		local var_5_1 = UnityEngine.GameObject.New(tostring(arg_5_1.id))

		gohelper.addChild(arg_5_0._elementRoot, var_5_1)

		local var_5_2 = VersionActivityFixedHelper.getVersionActivityDungeonMapElement(arg_5_0._bigVersion, arg_5_0._smallVersion)

		var_5_0 = MonoHelper.addLuaComOnceToGo(var_5_1, var_5_2, {
			arg_5_1,
			arg_5_0
		})
	end

	arg_5_0._elementCompDict[arg_5_1.id] = var_5_0

	gohelper.setActive(var_5_0._go, true)

	if var_5_0:isConfigShowArrow() then
		local var_5_3 = arg_5_0.viewContainer:getSetting().otherRes[3]
		local var_5_4 = arg_5_0:getResInst(var_5_3, arg_5_0._goarrow)
		local var_5_5 = gohelper.findChild(var_5_4, "mesh")
		local var_5_6, var_5_7, var_5_8 = transformhelper.getLocalRotation(var_5_5.transform)
		local var_5_9 = gohelper.getClick(gohelper.findChild(var_5_4, "click"))

		var_5_9:AddClickListener(arg_5_0._arrowClick, arg_5_0, arg_5_1.id)

		local var_5_10 = arg_5_0:getUserDataTb_()

		var_5_10.go = var_5_4
		var_5_10.rotationTrans = var_5_5.transform
		var_5_10.initRotation = {
			var_5_6,
			var_5_7,
			var_5_8
		}
		var_5_10.arrowClick = var_5_9
		arg_5_0._arrowList[arg_5_1.id] = var_5_10

		arg_5_0:_updateArrow(var_5_0)
	end

	VersionActivityFixedDungeonController.instance:dispatchEvent(VersionActivityFixedDungeonEvent.OnAddOneElement, var_5_0)
end

return var_0_0
