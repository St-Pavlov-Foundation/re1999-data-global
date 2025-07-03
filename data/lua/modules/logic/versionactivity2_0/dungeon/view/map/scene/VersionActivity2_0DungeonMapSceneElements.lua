module("modules.logic.versionactivity2_0.dungeon.view.map.scene.VersionActivity2_0DungeonMapSceneElements", package.seeall)

local var_0_0 = class("VersionActivity2_0DungeonMapSceneElements", BaseView)
local var_0_1 = 0.5
local var_0_2 = 0.5

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gofullscreen = gohelper.findChild(arg_1_0.viewGO, "#go_fullscreen")
	arg_1_0._click = SLFramework.UGUI.UIClickListener.Get(arg_1_0._gofullscreen)
	arg_1_0._goarrow = gohelper.findChild(arg_1_0.viewGO, "#go_arrow")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	if GamepadController.instance:isOpen() then
		arg_2_0:addEventCb(GamepadController.instance, GamepadEvent.KeyDown, arg_2_0.onGamepadKeyDown, arg_2_0)
	end

	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnBeginDragMap, arg_2_0.onBeginDragMap, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnCreateMapRootGoDone, arg_2_0.onCreateMapRootGoDone, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.BeginShowRewardView, arg_2_0.beginShowRewardView, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, arg_2_0.endShowRewardView, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, arg_2_0.onRemoveElement, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.GuideClickElement, arg_2_0.manualClickElement, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnUpdateElementArrow, arg_2_0._updateElementArrow, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnInitElements, arg_2_0.showElements, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, arg_2_0.loadSceneFinish, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnDisposeOldMap, arg_2_0.onDisposeOldMap, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnDisposeScene, arg_2_0.onDisposeScene, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnChangeMap, arg_2_0.onChangeMap, arg_2_0)
	arg_2_0:addEventCb(VersionActivity2_0DungeonController.instance, VersionActivity2_0DungeonEvent.OnClickElement, arg_2_0.onClickElement, arg_2_0)
	arg_2_0:addEventCb(VersionActivity2_0DungeonController.instance, VersionActivity2_0DungeonEvent.OnHideInteractUI, arg_2_0.onHideInteractUI, arg_2_0)
	arg_2_0._click:AddClickUpListener(arg_2_0.onClickUp, arg_2_0)
	arg_2_0._click:AddClickDownListener(arg_2_0.onClickDown, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(GamepadController.instance, GamepadEvent.KeyDown, arg_3_0.onGamepadKeyDown, arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonEvent.OnBeginDragMap, arg_3_0.onBeginDragMap, arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonEvent.OnCreateMapRootGoDone, arg_3_0.onCreateMapRootGoDone, arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonEvent.BeginShowRewardView, arg_3_0.beginShowRewardView, arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, arg_3_0.endShowRewardView, arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, arg_3_0.onRemoveElement, arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonEvent.GuideClickElement, arg_3_0.manualClickElement, arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonMapElementEvent.OnUpdateElementArrow, arg_3_0._updateElementArrow, arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonMapElementEvent.OnInitElements, arg_3_0.showElements, arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, arg_3_0.loadSceneFinish, arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonMapElementEvent.OnDisposeOldMap, arg_3_0.onDisposeOldMap, arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonMapElementEvent.OnDisposeScene, arg_3_0.onDisposeScene, arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonMapElementEvent.OnChangeMap, arg_3_0.onChangeMap, arg_3_0)
	arg_3_0:removeEventCb(VersionActivity2_0DungeonController.instance, VersionActivity2_0DungeonEvent.OnClickElement, arg_3_0.onClickElement, arg_3_0)
	arg_3_0:removeEventCb(VersionActivity2_0DungeonController.instance, VersionActivity2_0DungeonEvent.OnHideInteractUI, arg_3_0.onHideInteractUI, arg_3_0)
	arg_3_0._click:RemoveClickUpListener()
	arg_3_0._click:RemoveClickDownListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._elementCompDict = {}
	arg_4_0._elementCompPoolDict = {}
	arg_4_0._arrowList = {}
	arg_4_0.hadEverySecondTask = false
	arg_4_0.tempPos = Vector3.New(0, 0, 0)
end

function var_0_0.onOpen(arg_5_0)
	return
end

function var_0_0.onGamepadKeyDown(arg_6_0, arg_6_1)
	if arg_6_1 ~= GamepadEnum.KeyCode.A then
		return
	end

	local var_6_0 = GamepadController.instance:getScreenPos()
	local var_6_1 = CameraMgr.instance:getMainCamera():ScreenPointToRay(var_6_0)
	local var_6_2 = UnityEngine.Physics2D.RaycastAll(var_6_1.origin, var_6_1.direction)
	local var_6_3 = var_6_2.Length - 1

	for iter_6_0 = 0, var_6_3 do
		local var_6_4 = var_6_2[iter_6_0]
		local var_6_5 = MonoHelper.getLuaComFromGo(var_6_4.transform.parent.gameObject, VersionActivity2_0DungeonMapElement)

		if var_6_5 then
			var_6_5:_onClickDown()
		end
	end
end

function var_0_0.onBeginDragMap(arg_7_0)
	arg_7_0._clickDown = false
end

function var_0_0.onCreateMapRootGoDone(arg_8_0, arg_8_1)
	if arg_8_0.elementPoolRoot then
		return
	end

	arg_8_0.elementPoolRoot = UnityEngine.GameObject.New("elementPoolRoot")

	gohelper.addChild(arg_8_1, arg_8_0.elementPoolRoot)
	gohelper.setActive(arg_8_0.elementPoolRoot, false)
	transformhelper.setLocalPos(arg_8_0.elementPoolRoot.transform, 0, 0, 0)
end

function var_0_0.loadSceneFinish(arg_9_0, arg_9_1)
	arg_9_0._mapCfg = arg_9_1.mapConfig
	arg_9_0._sceneGo = arg_9_1.mapSceneGo
	arg_9_0._elementRoot = UnityEngine.GameObject.New("elementRoot")

	gohelper.addChild(arg_9_0._sceneGo, arg_9_0._elementRoot)
end

function var_0_0.manualClickElement(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getElementComp(tonumber(arg_10_1))

	if not var_10_0 then
		return
	end

	if not var_10_0:isValid() then
		return
	end

	var_10_0:onClick()
end

function var_0_0.setMouseElementDown(arg_11_0, arg_11_1)
	arg_11_0.mouseDownElement = arg_11_1
end

function var_0_0.getElementComp(arg_12_0, arg_12_1)
	return arg_12_0._elementCompDict[arg_12_1]
end

function var_0_0.onClickElement(arg_13_0, arg_13_1)
	arg_13_0:hideAllElements()
end

function var_0_0.hideAllElements(arg_14_0)
	for iter_14_0, iter_14_1 in pairs(arg_14_0._elementCompDict) do
		iter_14_1:hideElement()
	end

	gohelper.setActive(arg_14_0._goarrow, false)
end

function var_0_0.onHideInteractUI(arg_15_0)
	arg_15_0:showAllElements()
end

function var_0_0.showAllElements(arg_16_0)
	for iter_16_0, iter_16_1 in pairs(arg_16_0._elementCompDict) do
		iter_16_1:showElement()
	end

	gohelper.setActive(arg_16_0._goarrow, true)
end

function var_0_0._updateElementArrow(arg_17_0)
	for iter_17_0, iter_17_1 in pairs(arg_17_0._elementCompDict) do
		arg_17_0:_updateArrow(iter_17_1)
	end
end

function var_0_0.beginShowRewardView(arg_18_0)
	arg_18_0._showRewardView = true
end

function var_0_0.endShowRewardView(arg_19_0)
	arg_19_0._showRewardView = false

	if arg_19_0._needRemoveElementId then
		arg_19_0:_removeElement(arg_19_0._needRemoveElementId)
		TaskDispatcher.runDelay(arg_19_0.showNewElements, arg_19_0, DungeonEnum.ShowNewElementsTimeAfterShowReward)

		arg_19_0._needRemoveElementId = nil
	else
		arg_19_0:showNewElements()
	end
end

function var_0_0.onRemoveElement(arg_20_0, arg_20_1)
	if not arg_20_0._showRewardView or DungeonMapModel.instance:elementIsFinished(arg_20_1) then
		arg_20_0:_removeElement(arg_20_1)
		arg_20_0:showNewElements()
	else
		arg_20_0._needRemoveElementId = arg_20_1
	end

	local var_20_0 = arg_20_0._arrowList[arg_20_1]

	if var_20_0 then
		var_20_0.arrowClick:RemoveClickListener()

		arg_20_0._arrowList[arg_20_1] = nil

		gohelper.destroy(var_20_0.go)
	end
end

function var_0_0._removeElement(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0._elementCompDict[arg_21_1]

	arg_21_0._elementCompDict[arg_21_1] = nil

	if var_21_0 then
		var_21_0:setFinish()

		arg_21_0._elementCompPoolDict[arg_21_1] = var_21_0
	end

	VersionActivity2_0DungeonController.instance:dispatchEvent(VersionActivity2_0DungeonEvent.OnRemoveElement, var_21_0)
end

function var_0_0.showNewElements(arg_22_0)
	local var_22_0 = DungeonMapModel.instance:getNewElements()

	if not var_22_0 then
		return
	end

	local var_22_1 = {}

	for iter_22_0, iter_22_1 in ipairs(var_22_0) do
		local var_22_2 = DungeonConfig.instance:getChapterMapElement(iter_22_1)
		local var_22_3 = Activity161Config.instance:getGraffitiCo(Activity161Model.instance:getActId(), iter_22_1)

		if VersionActivity2_0DungeonConfig.instance:checkElementBelongMapId(var_22_2, arg_22_0._mapCfg.id) and var_22_2.showCamera == 1 and not var_22_3 then
			var_22_1[#var_22_1 + 1] = iter_22_1
		end
	end

	if #var_22_1 <= 0 then
		return
	end

	arg_22_0:_showElementAnim(var_22_1)
	DungeonMapModel.instance:clearNewElements()
end

function var_0_0._showElementAnim(arg_23_0, arg_23_1, arg_23_2)
	if not arg_23_1 or #arg_23_1 <= 0 then
		var_0_0._addAnimElementDone({
			arg_23_0,
			arg_23_2
		})

		return
	end

	arg_23_0:_stopShowSequence()

	arg_23_0._showSequence = FlowSequence.New()

	arg_23_0._showSequence:addWork(TimerWork.New(var_0_2))
	var_0_0._addAnimElementDone({
		arg_23_0,
		arg_23_2
	})
	table.sort(arg_23_1)

	for iter_23_0, iter_23_1 in ipairs(arg_23_1) do
		arg_23_0._showSequence:addWork(FunctionWork.New(var_0_0._doFocusElement, {
			arg_23_0,
			iter_23_1
		}))
		arg_23_0._showSequence:addWork(TimerWork.New(var_0_1))
		arg_23_0._showSequence:addWork(FunctionWork.New(var_0_0._doAddElement, {
			arg_23_0,
			iter_23_1
		}))
		arg_23_0._showSequence:addWork(TimerWork.New(var_0_2))
	end

	arg_23_0._showSequence:registerDoneListener(arg_23_0._stopShowSequence, arg_23_0)
	arg_23_0._showSequence:start()
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivity2_0DungeonEnum.BlockKey.FocusNewElement)
end

function var_0_0._doFocusElement(arg_24_0)
	local var_24_0 = arg_24_0[2]

	VersionActivity2_0DungeonController.instance:dispatchEvent(VersionActivity2_0DungeonEvent.FocusElement, var_24_0, true)
end

function var_0_0._doAddElement(arg_25_0)
	local var_25_0 = arg_25_0[1]
	local var_25_1 = arg_25_0[2]

	var_25_0:_addElementById(var_25_1)

	if not var_25_0._elementCompDict[var_25_1] then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_elementappear)
end

function var_0_0._addAnimElementDone(arg_26_0)
	local var_26_0 = arg_26_0[1]
	local var_26_1 = arg_26_0[2]

	if not var_26_1 or #var_26_1 <= 0 then
		return
	end

	for iter_26_0, iter_26_1 in ipairs(var_26_1) do
		var_26_0:_addElement(iter_26_1)
	end
end

function var_0_0._addElementById(arg_27_0, arg_27_1)
	local var_27_0 = lua_chapter_map_element.configDict[arg_27_1]

	arg_27_0:_addElement(var_27_0)
end

function var_0_0._addElement(arg_28_0, arg_28_1)
	if arg_28_0._elementCompDict[arg_28_1.id] then
		return
	end

	local var_28_0 = arg_28_0._elementCompPoolDict[arg_28_1.id]

	if var_28_0 then
		arg_28_0._elementCompPoolDict[arg_28_1.id] = nil

		gohelper.addChild(arg_28_0._elementRoot, var_28_0._go)
		var_28_0:updatePos()
	else
		local var_28_1 = UnityEngine.GameObject.New(tostring(arg_28_1.id))

		gohelper.addChild(arg_28_0._elementRoot, var_28_1)

		var_28_0 = MonoHelper.addLuaComOnceToGo(var_28_1, VersionActivity2_0DungeonMapElement, {
			arg_28_1,
			arg_28_0
		})
	end

	arg_28_0._elementCompDict[arg_28_1.id] = var_28_0

	if var_28_0:isConfigShowArrow() then
		local var_28_2 = arg_28_0.viewContainer:getSetting().otherRes[3]
		local var_28_3 = arg_28_0:getResInst(var_28_2, arg_28_0._goarrow)
		local var_28_4 = gohelper.findChild(var_28_3, "mesh")
		local var_28_5, var_28_6, var_28_7 = transformhelper.getLocalRotation(var_28_4.transform)
		local var_28_8 = gohelper.getClick(gohelper.findChild(var_28_3, "click"))

		var_28_8:AddClickListener(arg_28_0._arrowClick, arg_28_0, arg_28_1.id)

		local var_28_9 = arg_28_0:getUserDataTb_()

		var_28_9.go = var_28_3
		var_28_9.rotationTrans = var_28_4.transform
		var_28_9.initRotation = {
			var_28_5,
			var_28_6,
			var_28_7
		}
		var_28_9.arrowClick = var_28_8
		arg_28_0._arrowList[arg_28_1.id] = var_28_9

		arg_28_0:_updateArrow(var_28_0)
	end

	VersionActivity2_0DungeonController.instance:dispatchEvent(VersionActivity2_0DungeonEvent.OnAddOneElement, var_28_0)
end

function var_0_0.showElements(arg_29_0)
	if arg_29_0.activityDungeonMo:isHardMode() then
		arg_29_0:recycleAllElements()

		for iter_29_0, iter_29_1 in pairs(arg_29_0._arrowList) do
			iter_29_1.arrowClick:RemoveClickListener()
			gohelper.destroy(iter_29_1.go)
		end

		arg_29_0._arrowList = arg_29_0:getUserDataTb_()

		return
	end

	local var_29_0 = {}
	local var_29_1 = {}
	local var_29_2 = DungeonMapModel.instance:getNewElements()
	local var_29_3 = VersionActivity2_0DungeonModel.instance:getElementCoList(arg_29_0._mapCfg.id)

	for iter_29_2, iter_29_3 in ipairs(var_29_3) do
		local var_29_4 = var_29_2 and tabletool.indexOf(var_29_2, iter_29_3.id)

		if not Activity161Config.instance:getGraffitiCo(Activity161Model.instance:getActId(), iter_29_3.id) then
			if var_29_4 and iter_29_3.showCamera == 1 then
				table.insert(var_29_0, iter_29_3.id)
			else
				table.insert(var_29_1, iter_29_3)
			end
		end
	end

	arg_29_0:_showElementAnim(var_29_0, var_29_1)
	DungeonMapModel.instance:clearNewElements()

	if arg_29_0._initClickElementId then
		arg_29_0:manualClickElement(arg_29_0._initClickElementId)

		arg_29_0._initClickElementId = nil
	end
end

function var_0_0.recycleAllElements(arg_30_0)
	if arg_30_0._elementCompDict then
		for iter_30_0, iter_30_1 in pairs(arg_30_0._elementCompDict) do
			local var_30_0 = iter_30_1:getElementId()

			arg_30_0._elementCompPoolDict[var_30_0] = iter_30_1

			gohelper.addChild(arg_30_0.elementPoolRoot, iter_30_1._go)
		end

		tabletool.clear(arg_30_0._elementCompDict)
	end

	VersionActivity2_0DungeonController.instance:dispatchEvent(VersionActivity2_0DungeonEvent.OnRecycleAllElement)
end

function var_0_0._arrowClick(arg_31_0, arg_31_1)
	arg_31_0.mouseDownElement = nil

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_element_arrow_click)
	VersionActivity2_0DungeonController.instance:dispatchEvent(VersionActivity2_0DungeonEvent.FocusElement, arg_31_1)
end

function var_0_0._updateArrow(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0._arrowList[arg_32_1:getElementId()]

	if not var_32_0 then
		return
	end

	if not arg_32_1:isConfigShowArrow() then
		gohelper.setActive(var_32_0.go, false)

		return
	end

	local var_32_1 = arg_32_1._transform
	local var_32_2 = CameraMgr.instance:getMainCamera():WorldToViewportPoint(var_32_1.position)
	local var_32_3 = var_32_2.x
	local var_32_4 = var_32_2.y
	local var_32_5 = var_32_3 >= 0 and var_32_3 <= 1 and var_32_4 >= 0 and var_32_4 <= 1

	gohelper.setActive(var_32_0.go, not var_32_5)

	if var_32_5 then
		return
	end

	local var_32_6 = math.max(0.02, math.min(var_32_3, 0.98))
	local var_32_7 = math.max(0.035, math.min(var_32_4, 0.965))
	local var_32_8 = recthelper.getWidth(arg_32_0._goarrow.transform)
	local var_32_9 = recthelper.getHeight(arg_32_0._goarrow.transform)

	recthelper.setAnchor(var_32_0.go.transform, var_32_8 * (var_32_6 - 0.5), var_32_9 * (var_32_7 - 0.5))

	local var_32_10 = var_32_0.initRotation

	if var_32_3 >= 0 and var_32_3 <= 1 then
		if var_32_4 < 0 then
			transformhelper.setLocalRotation(var_32_0.rotationTrans, var_32_10[1], var_32_10[2], 180)

			return
		elseif var_32_4 > 1 then
			transformhelper.setLocalRotation(var_32_0.rotationTrans, var_32_10[1], var_32_10[2], 0)

			return
		end
	end

	if var_32_4 >= 0 and var_32_4 <= 1 then
		if var_32_3 < 0 then
			transformhelper.setLocalRotation(var_32_0.rotationTrans, var_32_10[1], var_32_10[2], 270)

			return
		elseif var_32_3 > 1 then
			transformhelper.setLocalRotation(var_32_0.rotationTrans, var_32_10[1], var_32_10[2], 90)

			return
		end
	end

	local var_32_11 = 90 - Mathf.Atan2(var_32_4, var_32_3) * Mathf.Rad2Deg

	transformhelper.setLocalRotation(var_32_0.rotationTrans, var_32_10[1], var_32_10[2], var_32_11)
end

function var_0_0.onClickUp(arg_33_0)
	local var_33_0 = arg_33_0.mouseDownElement

	arg_33_0.mouseDownElement = nil

	if not arg_33_0._clickDown or not var_33_0 then
		return
	end

	local var_33_1 = var_33_0:getElementId()

	if DungeonMapModel.instance:elementIsFinished(var_33_1) then
		return
	end

	if not var_33_0:isValid() then
		return
	end

	var_33_0:onClick()
end

function var_0_0.onClickDown(arg_34_0)
	arg_34_0._clickDown = true
end

function var_0_0.setInitClickElement(arg_35_0, arg_35_1)
	arg_35_0._initClickElementId = arg_35_1
end

function var_0_0.clearElements(arg_36_0)
	if arg_36_0._elementCompDict then
		for iter_36_0, iter_36_1 in pairs(arg_36_0._elementCompDict) do
			iter_36_1:onDestroy()
		end
	end

	if arg_36_0._elementCompPoolDict then
		for iter_36_2, iter_36_3 in pairs(arg_36_0._elementCompPoolDict) do
			iter_36_3:onDestroy()
		end
	end

	arg_36_0._elementRoot = nil

	tabletool.clear(arg_36_0._elementCompDict)
	tabletool.clear(arg_36_0._elementCompPoolDict)
end

function var_0_0.onChangeMap(arg_37_0)
	arg_37_0.hadEverySecondTask = false

	arg_37_0:_stopShowSequence()

	arg_37_0._needRemoveElementId = nil
end

function var_0_0._stopShowSequence(arg_38_0)
	if arg_38_0._showSequence then
		arg_38_0._showSequence:unregisterDoneListener(arg_38_0._stopShowSequence, arg_38_0)
		arg_38_0._showSequence:destroy()

		arg_38_0._showSequence = nil

		UIBlockMgr.instance:endBlock(VersionActivity2_0DungeonEnum.BlockKey.FocusNewElement)
	end
end

function var_0_0.onDisposeScene(arg_39_0)
	arg_39_0:clearElements()
	arg_39_0:_stopShowSequence()

	arg_39_0._needRemoveElementId = nil
end

function var_0_0.onDisposeOldMap(arg_40_0, arg_40_1)
	arg_40_0:recycleAllElements()

	arg_40_0._elementRoot = nil

	for iter_40_0, iter_40_1 in pairs(arg_40_0._arrowList) do
		iter_40_1.arrowClick:RemoveClickListener()
		gohelper.destroy(iter_40_1.go)
	end

	arg_40_0._arrowList = arg_40_0:getUserDataTb_()

	arg_40_0:_stopShowSequence()

	arg_40_0._needRemoveElementId = nil
end

function var_0_0.onClose(arg_41_0)
	return
end

function var_0_0.onDestroyView(arg_42_0)
	arg_42_0:clearElements()
	DungeonMapModel.instance:clearNewElements()
	arg_42_0:_stopShowSequence()
	TaskDispatcher.cancelTask(arg_42_0.showNewElements, arg_42_0)
	arg_42_0:onDisposeOldMap()
end

return var_0_0
