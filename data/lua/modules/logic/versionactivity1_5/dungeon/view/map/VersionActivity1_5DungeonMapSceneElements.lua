module("modules.logic.versionactivity1_5.dungeon.view.map.VersionActivity1_5DungeonMapSceneElements", package.seeall)

local var_0_0 = class("VersionActivity1_5DungeonMapSceneElements", BaseView)

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

	arg_4_0.goTimeParentTr = gohelper.findChildComponent(arg_4_0.viewGO, "#go_maptime", typeof(UnityEngine.RectTransform))
	arg_4_0.goTimeContainer = arg_4_0.goTimeParentTr.gameObject
	arg_4_0.goTimeItem = gohelper.findChild(arg_4_0.viewGO, "#go_maptime/#go_timeitem")

	gohelper.setActive(arg_4_0.goTimeItem, false)
	gohelper.setActive(arg_4_0.goTimeContainer, true)

	arg_4_0.hadEverySecondTask = false
	arg_4_0.elementTimeItemDict = {}
	arg_4_0.timeItemPool = {}
	arg_4_0.tempPos = Vector3.New(0, 0, 0)

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

	arg_8_0:addEventCb(DungeonController.instance, DungeonEvent.OnBeginDragMap, arg_8_0.onBeginDragMap, arg_8_0)
	arg_8_0:addEventCb(DungeonController.instance, DungeonEvent.OnCreateMapRootGoDone, arg_8_0.onCreateMapRootGoDone, arg_8_0)
	arg_8_0:addEventCb(DungeonController.instance, DungeonEvent.BeginShowRewardView, arg_8_0.beginShowRewardView, arg_8_0)
	arg_8_0:addEventCb(DungeonController.instance, DungeonEvent.EndShowRewardView, arg_8_0.endShowRewardView, arg_8_0)
	arg_8_0:addEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, arg_8_0.onRemoveElement, arg_8_0)
	arg_8_0:addEventCb(DungeonController.instance, DungeonEvent.OnAddElements, arg_8_0.onAddElements, arg_8_0)
	arg_8_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnLoadSceneFinish, arg_8_0.loadSceneFinish, arg_8_0)
	arg_8_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnInitElements, arg_8_0.showElements, arg_8_0)
	arg_8_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnDisposeOldMap, arg_8_0.onDisposeOldMap, arg_8_0)
	arg_8_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnDisposeScene, arg_8_0.onDisposeScene, arg_8_0)
	arg_8_0:addEventCb(DungeonController.instance, DungeonMapElementEvent.OnChangeMap, arg_8_0.onChangeMap, arg_8_0)
	arg_8_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnMapPosChanged, arg_8_0.onMapPosChanged, arg_8_0)
	arg_8_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnClickElement, arg_8_0.onClickElement, arg_8_0)
	arg_8_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.OnHideInteractUI, arg_8_0.onHideInteractUI, arg_8_0)
	arg_8_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.AddDispatchInfo, arg_8_0.onAddDispatchInfo, arg_8_0)
	arg_8_0:addEventCb(VersionActivity1_5DungeonController.instance, VersionActivity1_5DungeonEvent.RemoveDispatchInfo, arg_8_0.onRemoveDispatchInfo, arg_8_0)
end

function var_0_0.onGamepadKeyDown(arg_9_0, arg_9_1)
	if arg_9_1 == GamepadEnum.KeyCode.A then
		local var_9_0 = CameraMgr.instance:getMainCamera():ScreenPointToRay(GamepadController.instance:getScreenPos())
		local var_9_1 = UnityEngine.Physics2D.RaycastAll(var_9_0.origin, var_9_0.direction)
		local var_9_2 = var_9_1.Length - 1

		for iter_9_0 = 0, var_9_2 do
			local var_9_3 = var_9_1[iter_9_0]
			local var_9_4 = MonoHelper.getLuaComFromGo(var_9_3.transform.parent.gameObject, VersionActivity1_5DungeonMapElement)

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

function var_0_0.onClickElement(arg_14_0, arg_14_1)
	arg_14_0:hideTimeContainer()
	arg_14_0:hideAllElements()
end

function var_0_0.onHideInteractUI(arg_15_0)
	arg_15_0:showTimeContainer()
	arg_15_0:showAllElements()
end

function var_0_0.onCreateMapRootGoDone(arg_16_0, arg_16_1)
	if arg_16_0.elementPoolRoot then
		return
	end

	arg_16_0.elementPoolRoot = UnityEngine.GameObject.New("elementPoolRoot")

	gohelper.addChild(arg_16_1, arg_16_0.elementPoolRoot)
	gohelper.setActive(arg_16_0.elementPoolRoot, false)
	transformhelper.setLocalPos(arg_16_0.elementPoolRoot.transform, 0, 0, 0)
end

function var_0_0.loadSceneFinish(arg_17_0, arg_17_1)
	arg_17_0._mapCfg = arg_17_1.mapConfig
	arg_17_0._sceneGo = arg_17_1.mapSceneGo
	arg_17_0._elementRoot = UnityEngine.GameObject.New("elementRoot")

	gohelper.addChild(arg_17_0._sceneGo, arg_17_0._elementRoot)
end

function var_0_0.onDisposeScene(arg_18_0)
	arg_18_0:clearElements()
end

function var_0_0.onDisposeOldMap(arg_19_0, arg_19_1)
	arg_19_0:recycleAllElements()

	arg_19_0._elementRoot = nil
end

function var_0_0.hideAllElements(arg_20_0)
	for iter_20_0, iter_20_1 in pairs(arg_20_0._elementCompDict) do
		iter_20_1:hideElement()
	end
end

function var_0_0.showAllElements(arg_21_0)
	for iter_21_0, iter_21_1 in pairs(arg_21_0._elementCompDict) do
		iter_21_1:showElement()
	end
end

function var_0_0.clearElements(arg_22_0)
	if arg_22_0._elementCompDict then
		for iter_22_0, iter_22_1 in pairs(arg_22_0._elementCompDict) do
			iter_22_1:onDestroy()
		end
	end

	if arg_22_0._elementCompPoolDict then
		for iter_22_2, iter_22_3 in pairs(arg_22_0._elementCompPoolDict) do
			iter_22_3:onDestroy()
		end
	end

	arg_22_0._elementRoot = nil

	tabletool.clear(arg_22_0._elementCompDict)
	tabletool.clear(arg_22_0._elementCompPoolDict)
end

function var_0_0.recycleAllElements(arg_23_0)
	if arg_23_0._elementCompDict then
		for iter_23_0, iter_23_1 in pairs(arg_23_0._elementCompDict) do
			arg_23_0._elementCompPoolDict[iter_23_1:getElementId()] = iter_23_1

			gohelper.addChild(arg_23_0.elementPoolRoot, iter_23_1._go)
		end

		tabletool.clear(arg_23_0._elementCompDict)
	end

	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnRecycleAllElement)
end

function var_0_0.showElements(arg_24_0)
	if arg_24_0.activityDungeonMo:isHardMode() then
		arg_24_0:recycleAllElements()

		return
	end

	local var_24_0, var_24_1 = VersionActivity1_5DungeonModel.instance:getElementCoList(arg_24_0._mapCfg.id)

	for iter_24_0, iter_24_1 in ipairs(var_24_0) do
		arg_24_0:_addElement(iter_24_1)
	end

	for iter_24_2, iter_24_3 in ipairs(var_24_1) do
		arg_24_0:_addElement(iter_24_3)
	end
end

function var_0_0._addElement(arg_25_0, arg_25_1)
	if arg_25_0._elementCompDict[arg_25_1.id] then
		return
	end

	local var_25_0 = arg_25_0._elementCompPoolDict[arg_25_1.id]

	if var_25_0 then
		arg_25_0._elementCompPoolDict[arg_25_1.id] = nil

		gohelper.addChild(arg_25_0._elementRoot, var_25_0._go)
		var_25_0:updatePos()
		var_25_0:refreshDispatchRemainTime()
	else
		local var_25_1 = UnityEngine.GameObject.New(tostring(arg_25_1.id))

		gohelper.addChild(arg_25_0._elementRoot, var_25_1)

		var_25_0 = MonoHelper.addLuaComOnceToGo(var_25_1, VersionActivity1_5DungeonMapElement, {
			arg_25_1,
			arg_25_0
		})
	end

	arg_25_0._elementCompDict[arg_25_1.id] = var_25_0

	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnAddOneElement, var_25_0)
end

function var_0_0._removeElement(arg_26_0, arg_26_1)
	local var_26_0 = arg_26_0._elementCompDict[arg_26_1]

	var_26_0:setFinish()

	arg_26_0._elementCompDict[arg_26_1] = nil
	arg_26_0._elementCompPoolDict[arg_26_1] = var_26_0

	VersionActivity1_5DungeonController.instance:dispatchEvent(VersionActivity1_5DungeonEvent.OnRemoveElement, var_26_0)
end

function var_0_0._addElementById(arg_27_0, arg_27_1)
	local var_27_0 = lua_chapter_map_element.configDict[arg_27_1]

	arg_27_0:_addElement(var_27_0)
end

function var_0_0.onRemoveElement(arg_28_0, arg_28_1)
	if not arg_28_0._showRewardView then
		arg_28_0:_removeElement(arg_28_1)
	else
		arg_28_0._needRemoveElementId = arg_28_1
	end
end

function var_0_0.onAddElements(arg_29_0, arg_29_1)
	for iter_29_0, iter_29_1 in ipairs(arg_29_1) do
		local var_29_0 = DungeonConfig.instance:getChapterMapElement(iter_29_1)

		if VersionActivity1_5DungeonConfig.instance:checkElementBelongMapId(var_29_0, arg_29_0._mapCfg.id) then
			arg_29_0:_addElement(var_29_0)
		end
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

function var_0_0.addTimeItem(arg_33_0, arg_33_1)
	local var_33_0 = tonumber(arg_33_1:getConfig().param)
	local var_33_1 = VersionActivity1_5DungeonModel.instance:getDispatchMo(var_33_0)

	if not var_33_1 or var_33_1:isFinish() then
		return
	end

	local var_33_2 = arg_33_0:getTimeItem()

	var_33_2.txttime.text = var_33_1:getRemainTimeStr()
	var_33_2.elementComp = arg_33_1
	var_33_2.dispatchMo = var_33_1

	gohelper.setActive(var_33_2.go, true)

	arg_33_0.elementTimeItemDict[var_33_0] = var_33_2

	arg_33_0:setElementTimePos(var_33_2)

	if not arg_33_0.hadEverySecondTask then
		TaskDispatcher.runRepeat(arg_33_0.everySecondCall, arg_33_0, 1)

		arg_33_0.hadEverySecondTask = true
	end
end

function var_0_0.addTimeItemByDispatchId(arg_34_0, arg_34_1)
	for iter_34_0, iter_34_1 in pairs(arg_34_0._elementCompDict) do
		if iter_34_1:isDispatch() and tonumber(iter_34_1:getConfig().param) == arg_34_1 then
			arg_34_0:addTimeItem(iter_34_1)

			return
		end
	end
end

function var_0_0.getTimeItem(arg_35_0)
	if #arg_35_0.timeItemPool ~= 0 then
		return table.remove(arg_35_0.timeItemPool)
	end

	local var_35_0 = arg_35_0:getUserDataTb_()

	var_35_0.go = gohelper.cloneInPlace(arg_35_0.goTimeItem)
	var_35_0.rectTr = var_35_0.go:GetComponent(typeof(UnityEngine.RectTransform))
	var_35_0.txttime = gohelper.findChildText(var_35_0.go, "#txt_time")

	return var_35_0
end

function var_0_0.recycleTimeItem(arg_36_0, arg_36_1)
	arg_36_1.elementComp = nil
	arg_36_1.dispatchMo = nil

	gohelper.setActive(arg_36_1.go, false)
	table.insert(arg_36_0.timeItemPool, arg_36_1)
end

function var_0_0.everySecondCall(arg_37_0)
	local var_37_0 = {}

	for iter_37_0, iter_37_1 in pairs(arg_37_0.elementTimeItemDict) do
		local var_37_1 = iter_37_1.dispatchMo

		if not var_37_1 or var_37_1:isFinish() then
			table.insert(var_37_0, iter_37_0)
		else
			iter_37_1.txttime.text = var_37_1:getRemainTimeStr()
		end
	end

	for iter_37_2, iter_37_3 in ipairs(var_37_0) do
		local var_37_2 = arg_37_0.elementTimeItemDict[iter_37_3]

		var_37_2.elementComp:onDispatchFinish()
		arg_37_0:recycleTimeItem(var_37_2)

		arg_37_0.elementTimeItemDict[iter_37_3] = nil
	end

	if tabletool.len(arg_37_0.elementTimeItemDict) == 0 then
		arg_37_0.hadEverySecondTask = false

		TaskDispatcher.cancelTask(arg_37_0.everySecondCall, arg_37_0)
	end
end

function var_0_0.setElementTimePos(arg_38_0, arg_38_1)
	local var_38_0 = recthelper.worldPosToAnchorPos(arg_38_0:getElementPos(arg_38_1.elementComp:getElementPos()), arg_38_0.goTimeParentTr)

	recthelper.setAnchor(arg_38_1.rectTr, var_38_0.x, var_38_0.y)
end

function var_0_0.onMapPosChanged(arg_39_0)
	arg_39_0:refreshAllElementTimePos()
end

function var_0_0.refreshAllElementTimePos(arg_40_0)
	for iter_40_0, iter_40_1 in pairs(arg_40_0.elementTimeItemDict) do
		arg_40_0:setElementTimePos(iter_40_1)
	end
end

function var_0_0.getElementPos(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
	arg_41_0.tempPos:Set(arg_41_1, arg_41_2 + VersionActivity1_5DungeonEnum.ElementTimeOffsetY, arg_41_3)

	return arg_41_0.tempPos
end

function var_0_0.onChangeMap(arg_42_0)
	for iter_42_0, iter_42_1 in pairs(arg_42_0.elementTimeItemDict) do
		arg_42_0:recycleTimeItem(iter_42_1)
	end

	arg_42_0.elementTimeItemDict = {}
	arg_42_0.hadEverySecondTask = false

	TaskDispatcher.cancelTask(arg_42_0.everySecondCall, arg_42_0)
end

function var_0_0.hideTimeContainer(arg_43_0)
	gohelper.setActive(arg_43_0.goTimeContainer, false)
end

function var_0_0.showTimeContainer(arg_44_0)
	gohelper.setActive(arg_44_0.goTimeContainer, true)
	arg_44_0:refreshAllElementTimePos()
end

function var_0_0.onAddDispatchInfo(arg_45_0, arg_45_1)
	if arg_45_0.elementTimeItemDict[arg_45_1] then
		return
	end

	arg_45_0:addTimeItemByDispatchId(arg_45_1)
end

function var_0_0.onRemoveDispatchInfo(arg_46_0, arg_46_1)
	if not arg_46_0.elementTimeItemDict[arg_46_1] then
		return
	end

	arg_46_0:recycleTimeItem(arg_46_0.elementTimeItemDict[arg_46_1])

	arg_46_0.elementTimeItemDict[arg_46_1] = nil
end

return var_0_0
