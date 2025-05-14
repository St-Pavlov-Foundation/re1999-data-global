module("modules.logic.rouge.map.map.RougeBaseMap", package.seeall)

local var_0_0 = class("RougeBaseMap", UserDataDispose)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0._createDoneFinish = false
	arg_1_0._openViewFinish = ViewMgr.instance:isOpenFinish(ViewName.RougeMapView)

	RougeMapTipPopController.instance:init()
	RougeMapVoiceTriggerController.instance:init()

	arg_1_0.mapGo = arg_1_1

	arg_1_0:initMap()
	arg_1_0:createMapNodeContainer()
	RougeMapController.instance:registerMap(arg_1_0)

	arg_1_0.mapItemList = {}
	arg_1_0.mapItemDict = {}

	arg_1_0:addEventCb(RougeMapController.instance, RougeMapEvent.triggerInteract, arg_1_0.onTriggerInteract, arg_1_0)
	arg_1_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_1_0.onOpenViewFinish, arg_1_0)
	arg_1_0:addEventCb(RougeMapController.instance, RougeMapEvent.onCreateMapDone, arg_1_0.onCreateMapDone, arg_1_0)
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, arg_1_0.onScreenSizeChanged, arg_1_0)
end

function var_0_0.onScreenSizeChanged(arg_2_0)
	arg_2_0:updateCameraSize()
end

function var_0_0.updateCameraSize(arg_3_0)
	local var_3_0 = arg_3_0:getCameraSize()

	RougeMapModel.instance:setCameraSize(var_3_0)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.focusChangeCameraSize)
end

function var_0_0.getCameraSize(arg_4_0)
	return RougeMapModel.instance:getCameraSize()
end

function var_0_0.initMap(arg_5_0)
	arg_5_0.mapTransform = arg_5_0.mapGo.transform

	local var_5_0 = gohelper.findChild(arg_5_0.mapGo, "root/size"):GetComponent(typeof(UnityEngine.BoxCollider)).size

	RougeMapModel.instance:setMapSize(var_5_0)
end

function var_0_0.createMapNodeContainer(arg_6_0)
	arg_6_0.goLayerPiecesContainer = gohelper.create3d(arg_6_0.mapGo, "layerPiecesContainer")
	arg_6_0.trLayerPiecesContainer = arg_6_0.goLayerPiecesContainer.transform

	transformhelper.setLocalPos(arg_6_0.goLayerPiecesContainer.transform, 0, 0, RougeMapEnum.OffsetZ.PiecesContainer)
end

function var_0_0.handleOtherRes(arg_7_0, arg_7_1)
	return
end

function var_0_0.handleDLCRes(arg_8_0, arg_8_1, arg_8_2)
	return
end

function var_0_0.createMap(arg_9_0)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onCreateMapDone)
end

function var_0_0.onCreateMapDone(arg_10_0)
	arg_10_0._createDoneFinish = true

	arg_10_0:startCreateMapDoneFlow()
end

function var_0_0.onOpenViewFinish(arg_11_0, arg_11_1)
	if arg_11_1 == ViewName.RougeMapView then
		arg_11_0._openViewFinish = true

		arg_11_0:startCreateMapDoneFlow()
	end
end

function var_0_0.startCreateMapDoneFlow(arg_12_0)
	if not arg_12_0._createDoneFinish or not arg_12_0._openViewFinish then
		return
	end

	RougeMapModel.instance:setMapState(RougeMapEnum.MapState.WaitFlow)

	arg_12_0.onCreateMapDoneFlow = FlowSequence.New()

	arg_12_0:addStoryFlow()
	arg_12_0.onCreateMapDoneFlow:addWork(WaitPopViewDoneWork.New())
	arg_12_0.onCreateMapDoneFlow:addWork(WaitRougeInteractDoneWork.New())
	arg_12_0.onCreateMapDoneFlow:addWork(WaitRougeCollectionEffectDoneWork.New())
	arg_12_0.onCreateMapDoneFlow:addWork(WaitRougeNodeChangeAnimDoneWork.New())
	arg_12_0.onCreateMapDoneFlow:addWork(WaitRougeActorMoveToEndDoneWork.New())
	arg_12_0.onCreateMapDoneFlow:registerDoneListener(arg_12_0.onCreateMapDoneFlowDone, arg_12_0)
	arg_12_0.onCreateMapDoneFlow:start()
end

function var_0_0.addStoryFlow(arg_13_0)
	if not RougeMapModel.instance:isNormalLayer() then
		return
	end

	local var_13_0 = RougeMapModel.instance:getLayerCo().startStoryId

	if var_13_0 == 0 then
		return
	end

	if StoryModel.instance:isStoryFinished(var_13_0) then
		return
	end

	arg_13_0.onCreateMapDoneFlow:addWork(WaitRougeStoryDoneWork.New(var_13_0))
end

function var_0_0.onCreateMapDoneFlowDone(arg_14_0)
	arg_14_0:clearFlow()
	RougeMapModel.instance:setMapState(RougeMapEnum.MapState.Normal)
	RougeMapController.instance:dispatchEvent(RougeMapEvent.onCreateMapDoneFlowDone)

	if RougeMapModel.instance:isNormalLayer() then
		RougeMapController.instance:dispatchEvent(RougeMapEvent.OnGuideEnterNormalRougeMap)
	elseif RougeMapModel.instance:isMiddle() then
		RougeMapController.instance:dispatchEvent(RougeMapEvent.OnGuideEnterMiddleRougeMap)
	end
end

function var_0_0.onTriggerInteract(arg_15_0)
	RougeMapInteractHelper.triggerInteractive()
end

function var_0_0.getMapItemList(arg_16_0)
	return arg_16_0.mapItemList
end

function var_0_0.addMapItem(arg_17_0, arg_17_1)
	table.insert(arg_17_0.mapItemList, arg_17_1)

	arg_17_0.mapItemDict[arg_17_1.id] = arg_17_1
end

function var_0_0.addMapItemList(arg_18_0, arg_18_1)
	if not arg_18_1 then
		return
	end

	for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
		arg_18_0:addMapItem(iter_18_1)
	end
end

function var_0_0.getMapItem(arg_19_0, arg_19_1)
	return arg_19_0.mapItemDict[arg_19_1]
end

function var_0_0.getActorComp(arg_20_0)
	return arg_20_0.actorComp
end

function var_0_0.getActorPos(arg_21_0)
	return
end

function var_0_0.clearFlow(arg_22_0)
	if arg_22_0.onCreateMapDoneFlow then
		arg_22_0.onCreateMapDoneFlow:destroy()
	end

	arg_22_0.onCreateMapDoneFlow = nil
end

function var_0_0.destroy(arg_23_0)
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, arg_23_0.onScreenSizeChanged, arg_23_0)

	for iter_23_0, iter_23_1 in ipairs(arg_23_0.mapItemList) do
		iter_23_1:destroy()
	end

	arg_23_0.mapItemList = nil
	arg_23_0.mapItemDict = nil

	if arg_23_0.actorComp then
		arg_23_0.actorComp:destroy()
	end

	arg_23_0:clearFlow()
	RougeMapController.instance:unregisterMap()
	arg_23_0:__onDispose()
end

return var_0_0
