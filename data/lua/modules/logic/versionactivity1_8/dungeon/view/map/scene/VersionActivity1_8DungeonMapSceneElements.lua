module("modules.logic.versionactivity1_8.dungeon.view.map.scene.VersionActivity1_8DungeonMapSceneElements", package.seeall)

local var_0_0 = class("VersionActivity1_8DungeonMapSceneElements", BaseView)
local var_0_1 = 0.5
local var_0_2 = 0.5

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gofullscreen = gohelper.findChild(arg_1_0.viewGO, "#go_fullscreen")
	arg_1_0._click = SLFramework.UGUI.UIClickListener.Get(arg_1_0._gofullscreen)
	arg_1_0.goTimeParentTr = gohelper.findChildComponent(arg_1_0.viewGO, "#go_maptime", typeof(UnityEngine.RectTransform))
	arg_1_0.goTimeContainer = arg_1_0.goTimeParentTr.gameObject
	arg_1_0.goTimeItem = gohelper.findChild(arg_1_0.viewGO, "#go_maptime/#go_timeitem")
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
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnMapPosChanged, arg_2_0.onMapPosChanged, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnClickElement, arg_2_0.onClickElement, arg_2_0)
	arg_2_0:addEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnHideInteractUI, arg_2_0.onHideInteractUI, arg_2_0)
	arg_2_0:addEventCb(Activity157Controller.instance, Activity157Event.Act157ChangeInProgressMissionGroup, arg_2_0.onChangeInProgressMissionGroup, arg_2_0)
	arg_2_0:addEventCb(Activity157Controller.instance, Activity157Event.Act157RepairComponent, arg_2_0._onRepairComponent, arg_2_0)
	arg_2_0:addEventCb(DispatchController.instance, DispatchEvent.AddDispatchInfo, arg_2_0.onAddDispatchInfo, arg_2_0)
	arg_2_0:addEventCb(DispatchController.instance, DispatchEvent.RemoveDispatchInfo, arg_2_0.onRemoveDispatchInfo, arg_2_0)
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
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
	arg_3_0:removeEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnMapPosChanged, arg_3_0.onMapPosChanged, arg_3_0)
	arg_3_0:removeEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnClickElement, arg_3_0.onClickElement, arg_3_0)
	arg_3_0:removeEventCb(VersionActivity1_8DungeonController.instance, VersionActivity1_8DungeonEvent.OnHideInteractUI, arg_3_0.onHideInteractUI, arg_3_0)
	arg_3_0:removeEventCb(Activity157Controller.instance, Activity157Event.Act157ChangeInProgressMissionGroup, arg_3_0.onChangeInProgressMissionGroup, arg_3_0)
	arg_3_0:removeEventCb(Activity157Controller.instance, Activity157Event.Act157RepairComponent, arg_3_0._onRepairComponent, arg_3_0)
	arg_3_0:removeEventCb(DispatchController.instance, DispatchEvent.AddDispatchInfo, arg_3_0.onAddDispatchInfo, arg_3_0)
	arg_3_0:removeEventCb(DispatchController.instance, DispatchEvent.RemoveDispatchInfo, arg_3_0.onRemoveDispatchInfo, arg_3_0)
	arg_3_0._click:RemoveClickUpListener()
	arg_3_0._click:RemoveClickDownListener()
end

function var_0_0.onGamepadKeyDown(arg_4_0, arg_4_1)
	if arg_4_1 ~= GamepadEnum.KeyCode.A then
		return
	end

	local var_4_0 = GamepadController.instance:getScreenPos()
	local var_4_1 = CameraMgr.instance:getMainCamera():ScreenPointToRay(var_4_0)
	local var_4_2 = UnityEngine.Physics2D.RaycastAll(var_4_1.origin, var_4_1.direction)
	local var_4_3 = var_4_2.Length - 1

	for iter_4_0 = 0, var_4_3 do
		local var_4_4 = var_4_2[iter_4_0]
		local var_4_5 = MonoHelper.getLuaComFromGo(var_4_4.transform.parent.gameObject, VersionActivity1_8DungeonMapElement)

		if var_4_5 then
			var_4_5:_onClickDown()
		end
	end
end

function var_0_0.onBeginDragMap(arg_5_0)
	arg_5_0._clickDown = false
end

function var_0_0.onCreateMapRootGoDone(arg_6_0, arg_6_1)
	if arg_6_0.elementPoolRoot then
		return
	end

	arg_6_0.elementPoolRoot = UnityEngine.GameObject.New("elementPoolRoot")

	gohelper.addChild(arg_6_1, arg_6_0.elementPoolRoot)
	gohelper.setActive(arg_6_0.elementPoolRoot, false)
	transformhelper.setLocalPos(arg_6_0.elementPoolRoot.transform, 0, 0, 0)
end

function var_0_0.beginShowRewardView(arg_7_0)
	arg_7_0._showRewardView = true
end

function var_0_0.endShowRewardView(arg_8_0)
	arg_8_0._showRewardView = false

	if arg_8_0._needRemoveElementId then
		arg_8_0:_removeElement(arg_8_0._needRemoveElementId)
		TaskDispatcher.runDelay(arg_8_0.showNewElements, arg_8_0, DungeonEnum.ShowNewElementsTimeAfterShowReward)

		arg_8_0._needRemoveElementId = nil
	else
		arg_8_0:showNewElements()
	end
end

function var_0_0.showNewElements(arg_9_0)
	local var_9_0 = DungeonMapModel.instance:getNewElements()

	if not var_9_0 then
		return
	end

	local var_9_1 = {}

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		local var_9_2 = DungeonConfig.instance:getChapterMapElement(iter_9_1)

		if VersionActivity1_8DungeonConfig.instance:checkElementBelongMapId(var_9_2, arg_9_0._mapCfg.id) and var_9_2.showCamera == 1 then
			var_9_1[#var_9_1 + 1] = iter_9_1
		end
	end

	if #var_9_1 <= 0 then
		return
	end

	arg_9_0:_showElementAnim(var_9_1)
	DungeonMapModel.instance:clearNewElements()
end

function var_0_0.onRemoveElement(arg_10_0, arg_10_1)
	if not arg_10_0._showRewardView then
		arg_10_0:_removeElement(arg_10_1)
		arg_10_0:showNewElements()
	else
		arg_10_0._needRemoveElementId = arg_10_1
	end

	local var_10_0 = arg_10_0._arrowList[arg_10_1]

	if var_10_0 then
		var_10_0.arrowClick:RemoveClickListener()

		arg_10_0._arrowList[arg_10_1] = nil

		gohelper.destroy(var_10_0.go)
	end
end

function var_0_0.manualClickElement(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0:getElementComp(tonumber(arg_11_1))

	if not var_11_0 then
		return
	end

	if not var_11_0:isValid() then
		return
	end

	var_11_0:onClick()
end

function var_0_0._updateElementArrow(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0._elementCompDict) do
		arg_12_0:_updateArrow(iter_12_1)
	end
end

function var_0_0.showElements(arg_13_0)
	if arg_13_0.activityDungeonMo:isHardMode() then
		arg_13_0:recycleAllElements()

		return
	end

	local var_13_0 = {}
	local var_13_1 = {}
	local var_13_2 = DungeonMapModel.instance:getNewElements()
	local var_13_3 = VersionActivity1_8DungeonModel.instance:isNotShowNewElement()
	local var_13_4 = VersionActivity1_8DungeonModel.instance:getElementCoList(arg_13_0._mapCfg.id)

	for iter_13_0, iter_13_1 in ipairs(var_13_4) do
		if var_13_2 and tabletool.indexOf(var_13_2, iter_13_1.id) and iter_13_1.showCamera == 1 then
			if not var_13_3 then
				table.insert(var_13_0, iter_13_1.id)
			end
		else
			table.insert(var_13_1, iter_13_1)
		end
	end

	arg_13_0:_showElementAnim(var_13_0, var_13_1)

	if var_13_3 then
		VersionActivity1_8DungeonModel.instance:setIsNotShowNewElement(false)
	else
		DungeonMapModel.instance:clearNewElements()
	end

	if arg_13_0._initClickElementId then
		arg_13_0:manualClickElement(arg_13_0._initClickElementId)

		arg_13_0._initClickElementId = nil
	end
end

function var_0_0._showElementAnim(arg_14_0, arg_14_1, arg_14_2)
	if not arg_14_1 or #arg_14_1 <= 0 then
		var_0_0._addAnimElementDone({
			arg_14_0,
			arg_14_2
		})

		return
	end

	arg_14_0:_stopShowSequence()

	arg_14_0._showSequence = FlowSequence.New()

	arg_14_0._showSequence:addWork(TimerWork.New(var_0_2))
	table.sort(arg_14_1)

	for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
		arg_14_0._showSequence:addWork(FunctionWork.New(var_0_0._doFocusElement, {
			arg_14_0,
			iter_14_1
		}))
		arg_14_0._showSequence:addWork(TimerWork.New(var_0_1))
		arg_14_0._showSequence:addWork(FunctionWork.New(var_0_0._doAddElement, {
			arg_14_0,
			iter_14_1
		}))
		arg_14_0._showSequence:addWork(TimerWork.New(var_0_2))
	end

	arg_14_0._showSequence:addWork(FunctionWork.New(var_0_0._addAnimElementDone, {
		arg_14_0,
		arg_14_2
	}))
	arg_14_0._showSequence:registerDoneListener(arg_14_0._stopShowSequence, arg_14_0)
	arg_14_0._showSequence:start()
	UIBlockMgrExtend.setNeedCircleMv(false)
	UIBlockMgr.instance:startBlock(VersionActivity1_8DungeonEnum.BlockKey.FocusNewElement)
end

function var_0_0._doFocusElement(arg_15_0)
	local var_15_0 = arg_15_0[2]

	VersionActivity1_8DungeonController.instance:dispatchEvent(VersionActivity1_8DungeonEvent.FocusElement, var_15_0, true)
end

function var_0_0._doAddElement(arg_16_0)
	local var_16_0 = arg_16_0[1]
	local var_16_1 = arg_16_0[2]

	var_16_0:_addElementById(var_16_1)

	if not var_16_0._elementCompDict[var_16_1] then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_elementappear)
end

function var_0_0._addAnimElementDone(arg_17_0)
	local var_17_0 = arg_17_0[1]
	local var_17_1 = arg_17_0[2]

	if not var_17_1 or #var_17_1 <= 0 then
		return
	end

	for iter_17_0, iter_17_1 in ipairs(var_17_1) do
		var_17_0:_addElement(iter_17_1)
	end
end

function var_0_0._stopShowSequence(arg_18_0)
	if arg_18_0._showSequence then
		arg_18_0._showSequence:unregisterDoneListener(arg_18_0._stopShowSequence, arg_18_0)
		arg_18_0._showSequence:destroy()

		arg_18_0._showSequence = nil

		UIBlockMgr.instance:endBlock(VersionActivity1_8DungeonEnum.BlockKey.FocusNewElement)
	end
end

function var_0_0.loadSceneFinish(arg_19_0, arg_19_1)
	arg_19_0._mapCfg = arg_19_1.mapConfig
	arg_19_0._sceneGo = arg_19_1.mapSceneGo
	arg_19_0._elementRoot = UnityEngine.GameObject.New("elementRoot")

	gohelper.addChild(arg_19_0._sceneGo, arg_19_0._elementRoot)
end

function var_0_0.onDisposeOldMap(arg_20_0, arg_20_1)
	arg_20_0:recycleAllElements()

	arg_20_0._elementRoot = nil

	for iter_20_0, iter_20_1 in pairs(arg_20_0._arrowList) do
		iter_20_1.arrowClick:RemoveClickListener()
		gohelper.destroy(iter_20_1.go)
	end

	arg_20_0._arrowList = arg_20_0:getUserDataTb_()

	arg_20_0:_stopShowSequence()

	arg_20_0._needRemoveElementId = nil
	arg_20_0._waitCloseFactoryView = false
end

function var_0_0.onDisposeScene(arg_21_0)
	arg_21_0:clearElements()
	arg_21_0:_stopShowSequence()

	arg_21_0._needRemoveElementId = nil
	arg_21_0._waitCloseFactoryView = false
end

function var_0_0.onChangeMap(arg_22_0)
	for iter_22_0, iter_22_1 in pairs(arg_22_0.elementTimeItemDict) do
		arg_22_0:recycleTimeItem(iter_22_1)
	end

	arg_22_0.elementTimeItemDict = {}
	arg_22_0.hadEverySecondTask = false

	TaskDispatcher.cancelTask(arg_22_0.everySecondCall, arg_22_0)
	arg_22_0:_stopShowSequence()

	arg_22_0._needRemoveElementId = nil
	arg_22_0._waitCloseFactoryView = false
end

function var_0_0._onCloseView(arg_23_0)
	if arg_23_0._waitCloseFactoryView then
		local var_23_0 = ViewMgr.instance:isOpen(ViewName.VersionActivity1_8FactoryMapView)
		local var_23_1 = ViewMgr.instance:isOpen(ViewName.VersionActivity1_8FactoryBlueprintView)

		if not var_23_0 and not var_23_1 then
			arg_23_0:showNewElements()

			arg_23_0._waitCloseFactoryView = false
		end
	end
end

function var_0_0.onMapPosChanged(arg_24_0)
	arg_24_0:refreshAllElementTimePos()
end

function var_0_0.onClickElement(arg_25_0, arg_25_1)
	arg_25_0:hideTimeContainer()
	arg_25_0:hideAllElements()
end

function var_0_0.hideTimeContainer(arg_26_0)
	gohelper.setActive(arg_26_0.goTimeContainer, false)
end

function var_0_0.onHideInteractUI(arg_27_0)
	arg_27_0:showTimeContainer()
	arg_27_0:showAllElements()
end

function var_0_0.showTimeContainer(arg_28_0)
	gohelper.setActive(arg_28_0.goTimeContainer, true)
	arg_28_0:refreshAllElementTimePos()
end

function var_0_0.onChangeInProgressMissionGroup(arg_29_0)
	arg_29_0:_updateElementArrow()
end

function var_0_0._onRepairComponent(arg_30_0, arg_30_1)
	if not arg_30_1 then
		return
	end

	local var_30_0 = ViewMgr.instance:isOpen(ViewName.VersionActivity1_8FactoryMapView)
	local var_30_1 = ViewMgr.instance:isOpen(ViewName.VersionActivity1_8FactoryBlueprintView)

	if var_30_0 or var_30_1 then
		arg_30_0._waitCloseFactoryView = true
	else
		arg_30_0:showNewElements()
	end
end

function var_0_0.onAddDispatchInfo(arg_31_0, arg_31_1)
	if arg_31_0.elementTimeItemDict[arg_31_1] then
		return
	end

	arg_31_0:addTimeItemByDispatchId(arg_31_1)
end

function var_0_0.onRemoveDispatchInfo(arg_32_0, arg_32_1)
	if not arg_32_0.elementTimeItemDict[arg_32_1] then
		return
	end

	arg_32_0:recycleTimeItem(arg_32_0.elementTimeItemDict[arg_32_1])

	arg_32_0.elementTimeItemDict[arg_32_1] = nil
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

function var_0_0._editableInitView(arg_35_0)
	arg_35_0._elementCompDict = {}
	arg_35_0._elementCompPoolDict = {}
	arg_35_0._arrowList = {}
	arg_35_0.hadEverySecondTask = false
	arg_35_0.elementTimeItemDict = {}
	arg_35_0.timeItemPool = {}
	arg_35_0.tempPos = Vector3.New(0, 0, 0)

	gohelper.setActive(arg_35_0.goTimeItem, false)
	gohelper.setActive(arg_35_0.goTimeContainer, true)
end

function var_0_0.onOpen(arg_36_0)
	return
end

function var_0_0.setInitClickElement(arg_37_0, arg_37_1)
	arg_37_0._initClickElementId = arg_37_1
end

function var_0_0.setMouseElementDown(arg_38_0, arg_38_1)
	arg_38_0.mouseDownElement = arg_38_1
end

function var_0_0.getElementComp(arg_39_0, arg_39_1)
	return arg_39_0._elementCompDict[arg_39_1]
end

function var_0_0.hideAllElements(arg_40_0)
	for iter_40_0, iter_40_1 in pairs(arg_40_0._elementCompDict) do
		iter_40_1:hideElement()
	end

	gohelper.setActive(arg_40_0._goarrow, false)
end

function var_0_0.showAllElements(arg_41_0)
	for iter_41_0, iter_41_1 in pairs(arg_41_0._elementCompDict) do
		iter_41_1:showElement()
	end

	gohelper.setActive(arg_41_0._goarrow, true)
end

function var_0_0._addElementById(arg_42_0, arg_42_1)
	local var_42_0 = lua_chapter_map_element.configDict[arg_42_1]

	arg_42_0:_addElement(var_42_0)
end

function var_0_0._addElement(arg_43_0, arg_43_1)
	if arg_43_0._elementCompDict[arg_43_1.id] then
		return
	end

	local var_43_0 = arg_43_0._elementCompPoolDict[arg_43_1.id]

	if var_43_0 then
		arg_43_0._elementCompPoolDict[arg_43_1.id] = nil

		gohelper.addChild(arg_43_0._elementRoot, var_43_0._go)
		var_43_0:updatePos()
		var_43_0:refreshDispatchRemainTime()
	else
		local var_43_1 = UnityEngine.GameObject.New(tostring(arg_43_1.id))

		gohelper.addChild(arg_43_0._elementRoot, var_43_1)

		var_43_0 = MonoHelper.addLuaComOnceToGo(var_43_1, VersionActivity1_8DungeonMapElement, {
			arg_43_1,
			arg_43_0
		})
	end

	arg_43_0._elementCompDict[arg_43_1.id] = var_43_0

	if var_43_0:isConfigShowArrow() then
		local var_43_2 = arg_43_0.viewContainer:getSetting().otherRes[3]
		local var_43_3 = arg_43_0:getResInst(var_43_2, arg_43_0._goarrow)
		local var_43_4 = gohelper.findChild(var_43_3, "mesh")
		local var_43_5, var_43_6, var_43_7 = transformhelper.getLocalRotation(var_43_4.transform)
		local var_43_8 = gohelper.getClick(gohelper.findChild(var_43_3, "click"))

		var_43_8:AddClickListener(arg_43_0._arrowClick, arg_43_0, arg_43_1.id)

		local var_43_9 = arg_43_0:getUserDataTb_()

		var_43_9.go = var_43_3
		var_43_9.rotationTrans = var_43_4.transform
		var_43_9.initRotation = {
			var_43_5,
			var_43_6,
			var_43_7
		}
		var_43_9.arrowClick = var_43_8
		arg_43_0._arrowList[arg_43_1.id] = var_43_9

		arg_43_0:_updateArrow(var_43_0)
	end

	VersionActivity1_8DungeonController.instance:dispatchEvent(VersionActivity1_8DungeonEvent.OnAddOneElement, var_43_0)
end

function var_0_0._arrowClick(arg_44_0, arg_44_1)
	arg_44_0.mouseDownElement = nil

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_element_arrow_click)
	VersionActivity1_8DungeonController.instance:dispatchEvent(VersionActivity1_8DungeonEvent.FocusElement, arg_44_1)
end

function var_0_0._updateArrow(arg_45_0, arg_45_1)
	local var_45_0 = arg_45_0._arrowList[arg_45_1:getElementId()]

	if not var_45_0 then
		return
	end

	if not arg_45_1:showArrow() then
		gohelper.setActive(var_45_0.go, false)

		return
	end

	local var_45_1 = arg_45_1._transform
	local var_45_2 = CameraMgr.instance:getMainCamera():WorldToViewportPoint(var_45_1.position)
	local var_45_3 = var_45_2.x
	local var_45_4 = var_45_2.y
	local var_45_5 = var_45_3 >= 0 and var_45_3 <= 1 and var_45_4 >= 0 and var_45_4 <= 1

	gohelper.setActive(var_45_0.go, not var_45_5)

	if var_45_5 then
		return
	end

	local var_45_6 = math.max(0.02, math.min(var_45_3, 0.98))
	local var_45_7 = math.max(0.035, math.min(var_45_4, 0.965))
	local var_45_8 = recthelper.getWidth(arg_45_0._goarrow.transform)
	local var_45_9 = recthelper.getHeight(arg_45_0._goarrow.transform)

	recthelper.setAnchor(var_45_0.go.transform, var_45_8 * (var_45_6 - 0.5), var_45_9 * (var_45_7 - 0.5))

	local var_45_10 = var_45_0.initRotation

	if var_45_3 >= 0 and var_45_3 <= 1 then
		if var_45_4 < 0 then
			transformhelper.setLocalRotation(var_45_0.rotationTrans, var_45_10[1], var_45_10[2], 180)

			return
		elseif var_45_4 > 1 then
			transformhelper.setLocalRotation(var_45_0.rotationTrans, var_45_10[1], var_45_10[2], 0)

			return
		end
	end

	if var_45_4 >= 0 and var_45_4 <= 1 then
		if var_45_3 < 0 then
			transformhelper.setLocalRotation(var_45_0.rotationTrans, var_45_10[1], var_45_10[2], 270)

			return
		elseif var_45_3 > 1 then
			transformhelper.setLocalRotation(var_45_0.rotationTrans, var_45_10[1], var_45_10[2], 90)

			return
		end
	end

	local var_45_11 = 90 - Mathf.Atan2(var_45_4, var_45_3) * Mathf.Rad2Deg

	transformhelper.setLocalRotation(var_45_0.rotationTrans, var_45_10[1], var_45_10[2], var_45_11)
end

function var_0_0._removeElement(arg_46_0, arg_46_1)
	local var_46_0 = arg_46_0._elementCompDict[arg_46_1]

	arg_46_0._elementCompDict[arg_46_1] = nil

	if var_46_0 then
		var_46_0:setFinish()

		arg_46_0._elementCompPoolDict[arg_46_1] = var_46_0
	end

	VersionActivity1_8DungeonController.instance:dispatchEvent(VersionActivity1_8DungeonEvent.OnRemoveElement, var_46_0)
end

function var_0_0.recycleAllElements(arg_47_0)
	if arg_47_0._elementCompDict then
		for iter_47_0, iter_47_1 in pairs(arg_47_0._elementCompDict) do
			local var_47_0 = iter_47_1:getElementId()

			arg_47_0._elementCompPoolDict[var_47_0] = iter_47_1

			gohelper.addChild(arg_47_0.elementPoolRoot, iter_47_1._go)
		end

		tabletool.clear(arg_47_0._elementCompDict)
	end

	VersionActivity1_8DungeonController.instance:dispatchEvent(VersionActivity1_8DungeonEvent.OnRecycleAllElement)
end

function var_0_0.clearElements(arg_48_0)
	if arg_48_0._elementCompDict then
		for iter_48_0, iter_48_1 in pairs(arg_48_0._elementCompDict) do
			iter_48_1:onDestroy()
		end
	end

	if arg_48_0._elementCompPoolDict then
		for iter_48_2, iter_48_3 in pairs(arg_48_0._elementCompPoolDict) do
			iter_48_3:onDestroy()
		end
	end

	arg_48_0._elementRoot = nil

	tabletool.clear(arg_48_0._elementCompDict)
	tabletool.clear(arg_48_0._elementCompPoolDict)
end

function var_0_0.everySecondCall(arg_49_0)
	local var_49_0 = {}

	for iter_49_0, iter_49_1 in pairs(arg_49_0.elementTimeItemDict) do
		local var_49_1 = iter_49_1.dispatchMo

		if not var_49_1 or var_49_1:isFinish() then
			table.insert(var_49_0, iter_49_0)
		else
			iter_49_1.txttime.text = var_49_1:getRemainTimeStr()
		end
	end

	for iter_49_2, iter_49_3 in ipairs(var_49_0) do
		local var_49_2 = arg_49_0.elementTimeItemDict[iter_49_3]

		var_49_2.elementComp:onDispatchFinish()
		arg_49_0:recycleTimeItem(var_49_2)

		arg_49_0.elementTimeItemDict[iter_49_3] = nil
	end

	if tabletool.len(arg_49_0.elementTimeItemDict) == 0 then
		arg_49_0.hadEverySecondTask = false

		TaskDispatcher.cancelTask(arg_49_0.everySecondCall, arg_49_0)
	end
end

function var_0_0.addTimeItemByDispatchId(arg_50_0, arg_50_1)
	for iter_50_0, iter_50_1 in pairs(arg_50_0._elementCompDict) do
		if iter_50_1:isDispatch() and tonumber(iter_50_1:getConfig().param) == arg_50_1 then
			arg_50_0:addTimeItem(iter_50_1)

			return
		end
	end
end

function var_0_0.addTimeItem(arg_51_0, arg_51_1)
	local var_51_0 = arg_51_1:getElementId()
	local var_51_1 = tonumber(arg_51_1:getConfig().param)
	local var_51_2 = DispatchModel.instance:getDispatchMo(var_51_0, var_51_1)

	if not var_51_2 or var_51_2:isFinish() then
		return
	end

	local var_51_3 = arg_51_0:getTimeItem()

	var_51_3.txttime.text = var_51_2:getRemainTimeStr()
	var_51_3.elementComp = arg_51_1
	var_51_3.dispatchMo = var_51_2

	gohelper.setActive(var_51_3.go, true)

	arg_51_0.elementTimeItemDict[var_51_1] = var_51_3

	arg_51_0:setElementTimePos(var_51_3)

	if not arg_51_0.hadEverySecondTask then
		TaskDispatcher.runRepeat(arg_51_0.everySecondCall, arg_51_0, 1)

		arg_51_0.hadEverySecondTask = true
	end
end

function var_0_0.getTimeItem(arg_52_0)
	if #arg_52_0.timeItemPool ~= 0 then
		return table.remove(arg_52_0.timeItemPool)
	end

	local var_52_0 = arg_52_0:getUserDataTb_()

	var_52_0.go = gohelper.cloneInPlace(arg_52_0.goTimeItem)
	var_52_0.rectTr = var_52_0.go:GetComponent(typeof(UnityEngine.RectTransform))
	var_52_0.txttime = gohelper.findChildText(var_52_0.go, "#txt_time")

	return var_52_0
end

function var_0_0.recycleTimeItem(arg_53_0, arg_53_1)
	arg_53_1.elementComp = nil
	arg_53_1.dispatchMo = nil

	gohelper.setActive(arg_53_1.go, false)
	table.insert(arg_53_0.timeItemPool, arg_53_1)
end

function var_0_0.refreshAllElementTimePos(arg_54_0)
	for iter_54_0, iter_54_1 in pairs(arg_54_0.elementTimeItemDict) do
		arg_54_0:setElementTimePos(iter_54_1)
	end
end

function var_0_0.setElementTimePos(arg_55_0, arg_55_1)
	local var_55_0, var_55_1, var_55_2 = arg_55_1.elementComp:getElementPos()
	local var_55_3 = arg_55_0:getElementTimePos(var_55_0, var_55_1, var_55_2)
	local var_55_4 = recthelper.worldPosToAnchorPos(var_55_3, arg_55_0.goTimeParentTr)

	recthelper.setAnchor(arg_55_1.rectTr, var_55_4.x, var_55_4.y)
end

function var_0_0.getElementTimePos(arg_56_0, arg_56_1, arg_56_2, arg_56_3)
	arg_56_0.tempPos:Set(arg_56_1, arg_56_2 + VersionActivity1_8DungeonEnum.ElementTimeOffsetY, arg_56_3)

	return arg_56_0.tempPos
end

function var_0_0.onClose(arg_57_0)
	TaskDispatcher.cancelTask(arg_57_0.everySecondCall, arg_57_0)
end

function var_0_0.onDestroyView(arg_58_0)
	arg_58_0:clearElements()
	DungeonMapModel.instance:clearNewElements()
	arg_58_0:_stopShowSequence()
	TaskDispatcher.cancelTask(arg_58_0.showNewElements, arg_58_0)
end

return var_0_0
