module("modules.logic.versionactivity1_6.dungeon.view.map.VersionActivity1_6DungeonMapSceneElements", package.seeall)

local var_0_0 = class("VersionActivity1_6DungeonMapSceneElements", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gofullscreen = gohelper.findChild(arg_1_0.viewGO, "#go_fullscreen")
	arg_1_0._goarrow = gohelper.findChild(arg_1_0.viewGO, "#go_arrow")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._elementCompDict = {}
	arg_4_0._elementCompPoolDict = {}
	arg_4_0._click = SLFramework.UGUI.UIClickListener.Get(arg_4_0._gofullscreen)

	arg_4_0._click:AddClickDownListener(arg_4_0.onClickDown, arg_4_0)
	arg_4_0._click:AddClickUpListener(arg_4_0.onClickUp, arg_4_0)
	arg_4_0:customAddEvent()
end

function var_0_0.onOpen(arg_5_0)
	return
end

function var_0_0.onClose(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0.everySecondCall, arg_6_0)
end

function var_0_0.onDestroyView(arg_7_0)
	arg_7_0:clearElements()
	arg_7_0._click:RemoveClickDownListener()
	arg_7_0._click:RemoveClickUpListener()
end

function var_0_0.customAddEvent(arg_8_0)
	if GamepadController.instance:isOpen() then
		arg_8_0:addEventCb(GamepadController.instance, GamepadEvent.KeyDown, arg_8_0.onGamepadKeyDown, arg_8_0)
	end

	arg_8_0:addEventCb(DungeonController.instance, DungeonEvent.BeginShowRewardView, arg_8_0.beginShowRewardView, arg_8_0)
	arg_8_0:addEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, arg_8_0.endShowRewardView, arg_8_0)
	arg_8_0:addEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, arg_8_0.onRemoveElement, arg_8_0)
	arg_8_0:addEventCb(DungeonController.instance, DungeonEvent.GuideClickElement, arg_8_0.manualClickElement, arg_8_0)
	arg_8_0:addEventCb(VersionActivity1_6DungeonController.instance, DungeonEvent.OnBeginDragMap, arg_8_0.onBeginDragMap, arg_8_0)
	arg_8_0:addEventCb(VersionActivity1_6DungeonController.instance, DungeonEvent.OnCreateMapRootGoDone, arg_8_0.onCreateMapRootGoDone, arg_8_0)
	arg_8_0:addEventCb(VersionActivity1_6DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, arg_8_0.loadSceneFinish, arg_8_0)
	arg_8_0:addEventCb(VersionActivity1_6DungeonController.instance, DungeonMapElementEvent.OnInitElements, arg_8_0.showElements, arg_8_0)
	arg_8_0:addEventCb(VersionActivity1_6DungeonController.instance, DungeonMapElementEvent.OnDisposeOldMap, arg_8_0.onDisposeOldMap, arg_8_0)
	arg_8_0:addEventCb(VersionActivity1_6DungeonController.instance, DungeonMapElementEvent.OnDisposeScene, arg_8_0.onDisposeScene, arg_8_0)
	arg_8_0:addEventCb(VersionActivity1_6DungeonController.instance, DungeonMapElementEvent.OnChangeMap, arg_8_0.onChangeMap, arg_8_0)
end

function var_0_0.onGamepadKeyDown(arg_9_0, arg_9_1)
	if arg_9_1 == GamepadEnum.KeyCode.A then
		local var_9_0 = CameraMgr.instance:getMainCamera():ScreenPointToRay(GamepadController.instance:getScreenPos())
		local var_9_1 = UnityEngine.Physics2D.RaycastAll(var_9_0.origin, var_9_0.direction)
		local var_9_2 = var_9_1.Length - 1

		for iter_9_0 = 0, var_9_2 do
			local var_9_3 = var_9_1[iter_9_0]
			local var_9_4 = MonoHelper.getLuaComFromGo(var_9_3.transform.parent.gameObject, VersionActivity1_6DungeonMapElement)

			if var_9_4 then
				var_9_4:_onClickDown()

				return
			end
		end
	end
end

function var_0_0.setMouseElementDown(arg_10_0, arg_10_1)
	arg_10_0.mouseDownElement = arg_10_1
end

function var_0_0.onBeginDragMap(arg_11_0)
	arg_11_0._clickDown = false
end

function var_0_0.onClickDown(arg_12_0)
	arg_12_0._clickDown = true
end

function var_0_0.onClickUp(arg_13_0)
	local var_13_0 = arg_13_0.mouseDownElement

	arg_13_0.mouseDownElement = nil

	if not arg_13_0._clickDown then
		return
	end

	if not var_13_0 then
		return
	end

	local var_13_1 = var_13_0:getElementId()

	if DungeonMapModel.instance:elementIsFinished(var_13_1) then
		return
	end

	if not var_13_0:isValid() then
		return
	end

	var_13_0:onClick()
end

function var_0_0.manualClickElement(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getElementComp(tonumber(arg_14_1))

	if not var_14_0 then
		return
	end

	if not var_14_0:isValid() then
		return
	end

	var_14_0:onClick()
end

function var_0_0.onClickElement(arg_15_0, arg_15_1)
	arg_15_0:hideTimeContainer()
	arg_15_0:hideAllElements()
end

function var_0_0.onHideInteractUI(arg_16_0)
	arg_16_0:showTimeContainer()
	arg_16_0:showAllElements()
end

function var_0_0.onCreateMapRootGoDone(arg_17_0, arg_17_1)
	if arg_17_0.elementPoolRoot then
		return
	end

	arg_17_0.elementPoolRoot = UnityEngine.GameObject.New("elementPoolRoot")

	gohelper.addChild(arg_17_1, arg_17_0.elementPoolRoot)
	gohelper.setActive(arg_17_0.elementPoolRoot, false)
	transformhelper.setLocalPos(arg_17_0.elementPoolRoot.transform, 0, 0, 0)
end

function var_0_0.loadSceneFinish(arg_18_0, arg_18_1)
	arg_18_0._mapCfg = arg_18_1.mapConfig
	arg_18_0._sceneGo = arg_18_1.mapSceneGo
	arg_18_0._elementRoot = UnityEngine.GameObject.New("elementRoot")

	gohelper.addChild(arg_18_0._sceneGo, arg_18_0._elementRoot)
end

function var_0_0.onDisposeScene(arg_19_0)
	arg_19_0:clearElements()
end

function var_0_0.onDisposeOldMap(arg_20_0, arg_20_1)
	arg_20_0:recycleAllElements()

	arg_20_0._elementRoot = nil
end

function var_0_0.hideAllElements(arg_21_0)
	for iter_21_0, iter_21_1 in pairs(arg_21_0._elementCompDict) do
		iter_21_1:hideElement()
	end
end

function var_0_0.showAllElements(arg_22_0)
	for iter_22_0, iter_22_1 in pairs(arg_22_0._elementCompDict) do
		iter_22_1:showElement()
	end
end

function var_0_0.clearElements(arg_23_0)
	if arg_23_0._elementCompDict then
		for iter_23_0, iter_23_1 in pairs(arg_23_0._elementCompDict) do
			iter_23_1:onDestroy()
		end
	end

	if arg_23_0._elementCompPoolDict then
		for iter_23_2, iter_23_3 in pairs(arg_23_0._elementCompPoolDict) do
			iter_23_3:onDestroy()
		end
	end

	arg_23_0._elementRoot = nil

	tabletool.clear(arg_23_0._elementCompDict)
	tabletool.clear(arg_23_0._elementCompPoolDict)
end

function var_0_0.recycleAllElements(arg_24_0)
	if arg_24_0._elementCompDict then
		for iter_24_0, iter_24_1 in pairs(arg_24_0._elementCompDict) do
			arg_24_0._elementCompPoolDict[iter_24_1:getElementId()] = iter_24_1

			gohelper.addChild(arg_24_0.elementPoolRoot, iter_24_1._go)
		end

		tabletool.clear(arg_24_0._elementCompDict)
	end

	VersionActivity1_6DungeonController.instance:dispatchEvent(VersionActivity1_6DungeonEvent.OnRecycleAllElement)
end

function var_0_0.showElements(arg_25_0)
	if arg_25_0.activityDungeonMo:isHardMode() then
		arg_25_0:recycleAllElements()

		return
	end

	local var_25_0 = OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Act_60102)

	if arg_25_0._mapCfg and var_25_0 then
		local var_25_1 = Activity149Config.instance:getAct149BossMapElementByMapId(arg_25_0._mapCfg.id)

		if var_25_1 then
			local var_25_2 = VersionActivity1_6DungeonEnum.DungeonBossElementHideObjPaths

			for iter_25_0, iter_25_1 in ipairs(var_25_2) do
				local var_25_3 = gohelper.findChild(arg_25_0._sceneGo, iter_25_1)

				gohelper.setActive(var_25_3, false)
			end

			arg_25_0:_addElement(var_25_1)
		end
	end
end

function var_0_0._addElement(arg_26_0, arg_26_1)
	if arg_26_0._elementCompDict[arg_26_1.id] then
		return
	end

	local var_26_0 = arg_26_0._elementCompPoolDict[arg_26_1.id]

	if var_26_0 then
		arg_26_0._elementCompPoolDict[arg_26_1.id] = nil

		gohelper.addChild(arg_26_0._elementRoot, var_26_0._go)
		var_26_0:updatePos()
	else
		local var_26_1 = UnityEngine.GameObject.New(tostring(arg_26_1.id))

		gohelper.addChild(arg_26_0._elementRoot, var_26_1)

		var_26_0 = MonoHelper.addLuaComOnceToGo(var_26_1, VersionActivity1_6DungeonMapElement, {
			arg_26_1,
			arg_26_0
		})
	end

	arg_26_0._elementCompDict[arg_26_1.id] = var_26_0

	VersionActivity1_6DungeonController.instance:dispatchEvent(VersionActivity1_6DungeonEvent.OnAddOneElement, var_26_0)
end

function var_0_0._removeElement(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0._elementCompDict[arg_27_1]

	var_27_0:setFinish()

	arg_27_0._elementCompDict[arg_27_1] = nil
	arg_27_0._elementCompPoolDict[arg_27_1] = var_27_0

	VersionActivity1_6DungeonController.instance:dispatchEvent(VersionActivity1_6DungeonEvent.OnRemoveElement, var_27_0)
end

function var_0_0._addElementById(arg_28_0, arg_28_1)
	local var_28_0 = lua_chapter_map_element.configDict[arg_28_1]

	arg_28_0:_addElement(var_28_0)
end

function var_0_0.onRemoveElement(arg_29_0, arg_29_1)
	if not arg_29_0._showRewardView then
		arg_29_0:_removeElement(arg_29_1)
	else
		arg_29_0._needRemoveElementId = arg_29_1
	end
end

function var_0_0.getElementComp(arg_30_0, arg_30_1)
	return arg_30_0._elementCompDict[arg_30_1]
end

function var_0_0.beginShowRewardView(arg_31_0)
	arg_31_0._showRewardView = true
end

function var_0_0.endShowRewardView(arg_32_0)
	arg_32_0._showRewardView = false

	if arg_32_0._needRemoveElementId then
		arg_32_0:_removeElement(arg_32_0._needRemoveElementId)

		arg_32_0._needRemoveElementId = nil
	end
end

function var_0_0.onChangeMap(arg_33_0)
	return
end

return var_0_0
