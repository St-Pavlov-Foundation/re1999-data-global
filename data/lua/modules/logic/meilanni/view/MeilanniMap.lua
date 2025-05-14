module("modules.logic.meilanni.view.MeilanniMap", package.seeall)

local var_0_0 = class("MeilanniMap", BaseView)

function var_0_0.onInitView(arg_1_0)
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
	arg_4_0:_initMap()
end

function var_0_0.setScenePosSafety(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_0._sceneTrans then
		return
	end

	if arg_5_1.x < arg_5_0._mapMinX then
		arg_5_1.x = arg_5_0._mapMinX
	elseif arg_5_1.x > arg_5_0._mapMaxX then
		arg_5_1.x = arg_5_0._mapMaxX
	end

	if arg_5_1.y < arg_5_0._mapMinY then
		arg_5_1.y = arg_5_0._mapMinY
	elseif arg_5_1.y > arg_5_0._mapMaxY then
		arg_5_1.y = arg_5_0._mapMaxY
	end

	if arg_5_2 then
		ZProj.TweenHelper.DOLocalMove(arg_5_0._sceneTrans, arg_5_1.x, arg_5_1.y, 0, 0.26)
	else
		arg_5_0._sceneTrans.localPosition = arg_5_1
	end
end

function var_0_0._initCamera(arg_6_0)
	local var_6_0 = CameraMgr.instance:getMainCamera()

	var_6_0.orthographic = true

	transformhelper.setLocalRotation(var_6_0.transform, 0, 0, 0)

	local var_6_1 = GameUtil.getAdapterScale()

	var_6_0.orthographicSize = MeilanniEnum.orthographicSize * var_6_1
end

function var_0_0._resetCamera(arg_7_0)
	local var_7_0 = CameraMgr.instance:getMainCamera()

	var_7_0.orthographicSize = MeilanniEnum.orthographicSize
	var_7_0.orthographic = false
end

function var_0_0._initMap(arg_8_0)
	local var_8_0 = CameraMgr.instance:getMainCameraTrs().parent
	local var_8_1 = CameraMgr.instance:getSceneRoot()

	arg_8_0._sceneRoot = UnityEngine.GameObject.New("MeilanniMap")

	local var_8_2, var_8_3, var_8_4 = transformhelper.getLocalPos(var_8_0)

	transformhelper.setLocalPos(arg_8_0._sceneRoot.transform, 0, var_8_3, 0)
	gohelper.addChild(var_8_1, arg_8_0._sceneRoot)
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0._showMap(arg_10_0)
	local var_10_0 = arg_10_0._mapInfo:getCurEpisodeInfo().episodeConfig

	arg_10_0:_changeMap(var_10_0)
end

function var_0_0._changeMap(arg_11_0, arg_11_1)
	if arg_11_0._mapCfg == arg_11_1 then
		return
	end

	if not arg_11_0._oldMapLoader then
		arg_11_0._oldMapLoader = arg_11_0._mapLoader
		arg_11_0._oldSceneGo = arg_11_0._sceneGo
		arg_11_0._oldSceneTrans = arg_11_0._sceneTrans
	elseif arg_11_0._mapLoader then
		arg_11_0._mapLoader:dispose()

		arg_11_0._mapLoader = nil
	end

	arg_11_0._mapCfg = arg_11_1

	local var_11_0 = arg_11_1.res

	arg_11_0:_loadMap(var_11_0)
end

function var_0_0._loadMap(arg_12_0, arg_12_1)
	arg_12_0._mapLoader = MultiAbLoader.New()

	arg_12_0._mapLoader:addPath(arg_12_1)
	arg_12_0._mapLoader:startLoad(function(arg_13_0)
		local var_13_0 = arg_12_0._oldSceneGo

		arg_12_0._oldSceneGo = nil

		arg_12_0:disposeOldMap()

		local var_13_1 = arg_12_0._mapLoader:getAssetItem(arg_12_1):GetResource(arg_12_1)

		arg_12_0._sceneGo = gohelper.clone(var_13_1, arg_12_0._sceneRoot)

		gohelper.setActive(arg_12_0._sceneGo, true)

		arg_12_0._sceneTrans = arg_12_0._sceneGo.transform

		arg_12_0:_startFade(var_13_0, arg_12_0._sceneGo)
	end)
end

function var_0_0._startFade(arg_14_0, arg_14_1, arg_14_2)
	if not arg_14_1 then
		return
	end

	arg_14_2:GetComponent(typeof(UnityEngine.Animator)).enabled = false

	gohelper.setAsLastSibling(arg_14_1)

	arg_14_0._oldSceneGoAnim = arg_14_1
	arg_14_0._newSceneGoAnim = arg_14_2
	arg_14_0._oldMats = arg_14_0:_collectMats(arg_14_1)
	arg_14_0._newMats = arg_14_0:_collectMats(arg_14_2)

	arg_14_0:_frameUpdateNew(0)
	arg_14_0:_fadeOld()

	local var_14_0 = 0.5

	TaskDispatcher.runDelay(arg_14_0._fadeNew, arg_14_0, var_14_0)
end

function var_0_0._fadeOld(arg_15_0)
	local var_15_0 = 1
	local var_15_1 = 0
	local var_15_2 = 2

	ZProj.TweenHelper.DOTweenFloat(var_15_0, var_15_1, var_15_2, arg_15_0._frameUpdateOld, arg_15_0._fadeInFinishOld, arg_15_0)
end

function var_0_0._fadeNew(arg_16_0)
	local var_16_0 = 0
	local var_16_1 = 1
	local var_16_2 = 1.5

	ZProj.TweenHelper.DOTweenFloat(var_16_0, var_16_1, var_16_2, arg_16_0._frameUpdateNew, arg_16_0._fadeInFinishNew, arg_16_0)
end

function var_0_0._collectMats(arg_17_0, arg_17_1)
	local var_17_0 = {}
	local var_17_1 = arg_17_1:GetComponentsInChildren(typeof(UnityEngine.Renderer))

	for iter_17_0 = 0, var_17_1.Length - 1 do
		local var_17_2 = var_17_1[iter_17_0].material

		table.insert(var_17_0, var_17_2)
	end

	return var_17_0
end

function var_0_0._updateMatAlpha(arg_18_0, arg_18_1, arg_18_2)
	for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
		if iter_18_1:HasProperty("_MainCol") then
			local var_18_0 = iter_18_1:GetColor("_MainCol")

			var_18_0.a = arg_18_2

			iter_18_1:SetColor("_MainCol", var_18_0)
		end
	end
end

function var_0_0._frameUpdateNew(arg_19_0, arg_19_1)
	arg_19_0:_updateMatAlpha(arg_19_0._newMats, arg_19_1)
end

function var_0_0._fadeInFinishNew(arg_20_0, arg_20_1)
	arg_20_0:_updateMatAlpha(arg_20_0._newMats, 1)

	arg_20_0._newSceneGoAnim = nil
end

function var_0_0._frameUpdateOld(arg_21_0, arg_21_1)
	arg_21_0:_updateMatAlpha(arg_21_0._oldMats, arg_21_1)
end

function var_0_0._fadeInFinishOld(arg_22_0, arg_22_1)
	if arg_22_0._oldSceneGoAnim then
		gohelper.destroy(arg_22_0._oldSceneGoAnim)

		arg_22_0._oldSceneGoAnim = nil
	end
end

function var_0_0._initCanvas(arg_23_0)
	local var_23_0 = arg_23_0._mapLoader:getAssetItem(arg_23_0._canvasUrl):GetResource(arg_23_0._canvasUrl)

	arg_23_0._sceneCanvasGo = gohelper.clone(var_23_0, arg_23_0._sceneGo)
	arg_23_0._sceneCanvas = arg_23_0._sceneCanvasGo:GetComponent("Canvas")
	arg_23_0._sceneCanvas.worldCamera = CameraMgr.instance:getMainCamera()
end

function var_0_0._initScene(arg_24_0)
	arg_24_0._mapSize = gohelper.findChild(arg_24_0._sceneGo, "root/size"):GetComponentInChildren(typeof(UnityEngine.BoxCollider)).size

	local var_24_0

	if GameUtil.getAdapterScale() ~= 1 then
		var_24_0 = ViewMgr.instance:getUILayer(UILayerName.Hud)
	else
		var_24_0 = ViewMgr.instance:getUIRoot()
	end

	local var_24_1 = var_24_0.transform:GetWorldCorners()
	local var_24_2 = var_24_1[1]
	local var_24_3 = var_24_1[3]

	arg_24_0._viewWidth = math.abs(var_24_3.x - var_24_2.x)
	arg_24_0._viewHeight = math.abs(var_24_3.y - var_24_2.y)
	arg_24_0._mapMinX = var_24_2.x - (arg_24_0._mapSize.x - arg_24_0._viewWidth)
	arg_24_0._mapMaxX = var_24_2.x
	arg_24_0._mapMinY = var_24_2.y
	arg_24_0._mapMaxY = var_24_2.y + (arg_24_0._mapSize.y - arg_24_0._viewHeight)

	if arg_24_0._oldScenePos then
		arg_24_0._sceneTrans.localPosition = arg_24_0._oldScenePos
	end

	arg_24_0._oldScenePos = nil
end

function var_0_0._setInitPos(arg_25_0, arg_25_1)
	if not arg_25_0._mapCfg then
		return
	end

	local var_25_0 = arg_25_0._mapCfg.initPos
	local var_25_1 = string.splitToNumber(var_25_0, "#")

	arg_25_0:setScenePosSafety(Vector3(var_25_1[1], var_25_1[2], 0), arg_25_1)
end

function var_0_0.disposeOldMap(arg_26_0)
	if arg_26_0._sceneTrans then
		arg_26_0._oldScenePos = arg_26_0._sceneTrans.localPosition
	else
		arg_26_0._oldScenePos = nil
	end

	if arg_26_0._oldMapLoader then
		arg_26_0._oldMapLoader:dispose()

		arg_26_0._oldMapLoader = nil
	end

	if arg_26_0._oldSceneGo then
		gohelper.destroy(arg_26_0._oldSceneGo)

		arg_26_0._oldSceneGo = nil
	end
end

function var_0_0.onOpen(arg_27_0)
	arg_27_0._mapId = MeilanniModel.instance:getCurMapId()
	arg_27_0._mapInfo = MeilanniModel.instance:getMapInfo(arg_27_0._mapId)

	arg_27_0:addEventCb(MainController.instance, MainEvent.OnSceneClose, arg_27_0._onSceneClose, arg_27_0)
	arg_27_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_27_0._onScreenResize, arg_27_0)
	arg_27_0:addEventCb(MeilanniController.instance, MeilanniEvent.episodeInfoUpdate, arg_27_0._episodeInfoUpdate, arg_27_0)
	arg_27_0:addEventCb(MeilanniController.instance, MeilanniEvent.resetMap, arg_27_0._resetMap, arg_27_0)
	arg_27_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_27_0._onCloseView, arg_27_0)
	arg_27_0:_initCamera()
	arg_27_0:_showMap()
end

function var_0_0._onCloseView(arg_28_0, arg_28_1)
	if arg_28_1 == ViewName.DungeonMapView then
		arg_28_0:_initCamera()
	end
end

function var_0_0._resetMap(arg_29_0)
	arg_29_0:_showMap()
end

function var_0_0._episodeInfoUpdate(arg_30_0)
	MeilanniAnimationController.instance:addDelayCall(arg_30_0._showMap, arg_30_0, nil, MeilanniEnum.changeMapTime, MeilanniAnimationController.changeMapLayer)
end

function var_0_0._onScreenResize(arg_31_0)
	local var_31_0 = CameraMgr.instance:getMainCamera()
	local var_31_1 = GameUtil.getAdapterScale()

	var_31_0.orthographicSize = MeilanniEnum.orthographicSize * var_31_1
end

function var_0_0._onSceneClose(arg_32_0)
	return
end

function var_0_0.onClose(arg_33_0)
	arg_33_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_33_0._onCloseView, arg_33_0)
	arg_33_0:_resetCamera()
end

function var_0_0.onDestroyView(arg_34_0)
	gohelper.destroy(arg_34_0._sceneRoot)
	arg_34_0:disposeOldMap()

	if arg_34_0._mapLoader then
		arg_34_0._mapLoader:dispose()
	end
end

return var_0_0
