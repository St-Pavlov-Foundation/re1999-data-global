module("modules.logic.weekwalk.view.WeekWalkMap", package.seeall)

local var_0_0 = class("WeekWalkMap", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gofullscreen = gohelper.findChild(arg_1_0.viewGO, "#go_fullscreen")
	arg_1_0._gotoptipsbg = gohelper.findChild(arg_1_0.viewGO, "#go_main/#go_toptipsbg")

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
	arg_4_0._elementList = arg_4_0:getUserDataTb_()
	arg_4_0._tempVector = Vector3()
	arg_4_0._infoNeedUpdate = WeekWalkModel.instance:infoNeedUpdate()

	arg_4_0:_initMap()
	arg_4_0:_initClick()
end

function var_0_0._initClick(arg_5_0)
	arg_5_0._click = SLFramework.UGUI.UIClickListener.Get(arg_5_0._gofullscreen)

	arg_5_0._click:AddClickUpListener(arg_5_0._clickUp, arg_5_0)
end

function var_0_0.setElementDown(arg_6_0, arg_6_1)
	if ViewMgr.instance:isOpen(ViewName.WeekWalkDialogView) or ViewMgr.instance:isOpen(ViewName.WeekWalkTarotView) then
		return
	end

	arg_6_0._elementMouseDown = arg_6_1
end

function var_0_0._clickUp(arg_7_0)
	local var_7_0 = arg_7_0._elementMouseDown

	arg_7_0._elementMouseDown = nil

	if var_7_0 and var_7_0:isValid() then
		var_7_0:onClick()
	end
end

function var_0_0.setScenePosSafety(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_0._sceneTrans then
		return
	end

	if arg_8_1.x < arg_8_0._mapMinX then
		arg_8_1.x = arg_8_0._mapMinX
	elseif arg_8_1.x > arg_8_0._mapMaxX then
		arg_8_1.x = arg_8_0._mapMaxX
	end

	if arg_8_1.y < arg_8_0._mapMinY then
		arg_8_1.y = arg_8_0._mapMinY
	elseif arg_8_1.y > arg_8_0._mapMaxY then
		arg_8_1.y = arg_8_0._mapMaxY
	end

	if arg_8_2 then
		ZProj.TweenHelper.DOLocalMove(arg_8_0._sceneTrans, arg_8_1.x, arg_8_1.y, 0, 0.26)
	else
		arg_8_0._sceneTrans.localPosition = arg_8_1
	end
end

function var_0_0._initCamera(arg_9_0)
	local var_9_0 = CameraMgr.instance:getMainCamera()

	var_9_0.orthographic = true

	transformhelper.setLocalRotation(var_9_0.transform, 0, 0, 0)

	local var_9_1 = GameUtil.getAdapterScale()

	var_9_0.orthographicSize = WeekWalkEnum.orthographicSize * var_9_1
end

function var_0_0._initMap(arg_10_0)
	local var_10_0 = CameraMgr.instance:getMainCameraTrs().parent
	local var_10_1 = CameraMgr.instance:getSceneRoot()

	arg_10_0._sceneRoot = UnityEngine.GameObject.New("WeekWalkMap")

	local var_10_2, var_10_3, var_10_4 = transformhelper.getLocalPos(var_10_0)

	transformhelper.setLocalPos(arg_10_0._sceneRoot.transform, 0, var_10_3, 0)
	gohelper.addChild(var_10_1, arg_10_0._sceneRoot)
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0._showMap(arg_12_0)
	local var_12_0 = WeekWalkConfig.instance:getMapConfig(arg_12_0._mapId)

	arg_12_0:_changeMap(var_12_0)
end

function var_0_0._changeMap(arg_13_0, arg_13_1)
	if not arg_13_1 or arg_13_0._mapCfg == arg_13_1 then
		return
	end

	if not arg_13_0._oldMapLoader then
		arg_13_0._oldMapLoader = arg_13_0._mapLoader
		arg_13_0._oldSceneGo = arg_13_0._sceneGo
		arg_13_0._oldSceneTrans = arg_13_0._sceneTrans
	elseif arg_13_0._mapLoader then
		arg_13_0._mapLoader:dispose()

		arg_13_0._mapLoader = nil
	end

	arg_13_0._mapCfg = arg_13_1

	local var_13_0 = WeekWalkModel.instance:getOldOrNewCurMapInfo()
	local var_13_1 = lua_weekwalk_scene.configDict[var_13_0.sceneId].map

	arg_13_0._mapLoader = MultiAbLoader.New()

	arg_13_0._mapLoader:addPath(var_13_1)

	arg_13_0._canvasUrl = "ui/viewres/dungeon/chaptermap/chaptermapscenecanvas.prefab"
	arg_13_0._interactiveItemUrl = "ui/viewres/weekwalk/weekwalkmapinteractiveitem.prefab"

	arg_13_0._mapLoader:addPath(arg_13_0._canvasUrl)
	arg_13_0._mapLoader:addPath(arg_13_0._interactiveItemUrl)

	if not WeekWalkModel.isShallowMap(var_13_0.id) then
		arg_13_0._smokeUrl = "scenes/m_s09_rgmy/prefab/weekwalk_deepdream_smoke01.prefab"

		arg_13_0._mapLoader:addPath(arg_13_0._smokeUrl)
	end

	arg_13_0._mapLoader:startLoad(function(arg_14_0)
		arg_13_0:disposeOldMap()

		local var_14_0 = arg_13_0._mapLoader:getAssetItem(var_13_1):GetResource(var_13_1)

		arg_13_0._sceneGo = gohelper.clone(var_14_0, arg_13_0._sceneRoot, tostring(arg_13_1.id))

		gohelper.setActive(arg_13_0._sceneGo, true)

		arg_13_0._sceneTrans = arg_13_0._sceneGo.transform
		arg_13_0._backgroundGo = gohelper.findChild(arg_13_0._sceneGo, "root/BackGround")
		arg_13_0._diffuseGo = gohelper.findChild(arg_13_0._sceneGo, "Obj-Plant/all/diffuse")
		arg_13_0._elementRoot = UnityEngine.GameObject.New("elementRoot")

		gohelper.addChild(arg_13_0._sceneGo, arg_13_0._elementRoot)

		if arg_13_0._smokeUrl then
			local var_14_1 = arg_13_0._mapLoader:getAssetItem(arg_13_0._smokeUrl):GetResource(arg_13_0._smokeUrl)

			arg_13_0._smokeGo = gohelper.clone(var_14_1, arg_13_0._sceneGo)

			local var_14_2 = gohelper.findChild(arg_13_0._smokeGo, "smoke01/1"):GetComponent(typeof(UnityEngine.Renderer))

			arg_13_0._smokeMaskMat = var_14_2.sharedMaterial

			arg_13_0:_updateSmokeMask()
			transformhelper.setLocalPos(arg_13_0._smokeGo.transform, 0, 0, 0)
		end

		arg_13_0._anim = arg_13_0._sceneGo:GetComponent(typeof(UnityEngine.Animator))

		arg_13_0:_initScene()
		arg_13_0:_initCanvas()
		arg_13_0:_onPlayEnterAnim()
	end)
end

function var_0_0._playEnterAnim(arg_15_0)
	arg_15_0._isPlayAnim = true

	arg_15_0:_onPlayEnterAnim()
end

function var_0_0._onPlayEnterAnim(arg_16_0)
	if arg_16_0._anim then
		arg_16_0._anim.enabled = arg_16_0._isPlayAnim

		local var_16_0 = gohelper.findChild(arg_16_0._backgroundGo, "bg_static")

		if var_16_0 then
			gohelper.setActive(var_16_0, not arg_16_0._isPlayAnim)
		end

		if arg_16_0._isPlayAnim and not arg_16_0._infoNeedUpdate then
			arg_16_0:_initElements()
		end
	end
end

function var_0_0._playBgm(arg_17_0, arg_17_1)
	arg_17_1 = tonumber(arg_17_1)

	if not arg_17_1 or arg_17_1 <= 0 or arg_17_0._bgmId then
		return
	end

	arg_17_0._bgmId = arg_17_1

	AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.WeekWalk, arg_17_0._bgmId, AudioEnum.WeekWalk.stop_sleepwalkingaudio)
end

function var_0_0._stopBgm(arg_18_0)
	if arg_18_0._bgmId then
		arg_18_0._bgmId = nil

		AudioBgmManager.instance:stopAndClear(AudioBgmEnum.Layer.WeekWalk)
	end
end

function var_0_0._initCanvas(arg_19_0)
	local var_19_0 = arg_19_0._mapLoader:getAssetItem(arg_19_0._canvasUrl):GetResource(arg_19_0._canvasUrl)

	arg_19_0._sceneCanvasGo = gohelper.clone(var_19_0, arg_19_0._sceneGo)
	arg_19_0._sceneCanvas = arg_19_0._sceneCanvasGo:GetComponent("Canvas")
	arg_19_0._sceneCanvas.worldCamera = CameraMgr.instance:getMainCamera()
	arg_19_0._itemPrefab = arg_19_0._mapLoader:getAssetItem(arg_19_0._interactiveItemUrl):GetResource(arg_19_0._interactiveItemUrl)
end

function var_0_0.getInteractiveItem(arg_20_0)
	arg_20_0._uiGo = gohelper.clone(arg_20_0._itemPrefab, arg_20_0._sceneCanvasGo)
	arg_20_0._interactiveItem = MonoHelper.addLuaComOnceToGo(arg_20_0._uiGo, WeekWalkMapInteractiveItem)

	gohelper.setActive(arg_20_0._uiGo, false)

	return arg_20_0._interactiveItem
end

function var_0_0._initScene(arg_21_0)
	arg_21_0._mapSize = gohelper.findChild(arg_21_0._sceneGo, "root/size"):GetComponentInChildren(typeof(UnityEngine.BoxCollider)).size

	local var_21_0

	if GameUtil.getAdapterScale() ~= 1 then
		var_21_0 = ViewMgr.instance:getUILayer(UILayerName.Hud)
	else
		var_21_0 = ViewMgr.instance:getUIRoot()
	end

	local var_21_1 = var_21_0.transform:GetWorldCorners()
	local var_21_2 = var_21_1[1]
	local var_21_3 = var_21_1[3]

	arg_21_0._viewWidth = math.abs(var_21_3.x - var_21_2.x)
	arg_21_0._viewHeight = math.abs(var_21_3.y - var_21_2.y)
	arg_21_0._mapMinX = var_21_2.x - (arg_21_0._mapSize.x - arg_21_0._viewWidth)
	arg_21_0._mapMaxX = var_21_2.x
	arg_21_0._mapMinY = var_21_2.y
	arg_21_0._mapMaxY = var_21_2.y + (arg_21_0._mapSize.y - arg_21_0._viewHeight)

	if arg_21_0._oldScenePos then
		arg_21_0._sceneTrans.localPosition = arg_21_0._oldScenePos
	end

	arg_21_0._oldScenePos = nil
end

function var_0_0._setInitPos(arg_22_0, arg_22_1)
	if not arg_22_0._mapCfg then
		return
	end

	local var_22_0 = arg_22_0._mapCfg.initPos
	local var_22_1 = string.splitToNumber(var_22_0, "#")

	arg_22_0:setScenePosSafety(Vector3(var_22_1[1], var_22_1[2], 0), arg_22_1)
end

function var_0_0.disposeOldMap(arg_23_0)
	if arg_23_0._sceneTrans then
		arg_23_0._oldScenePos = arg_23_0._sceneTrans.localPosition
	else
		arg_23_0._oldScenePos = nil
	end

	if arg_23_0._oldMapLoader then
		arg_23_0._oldMapLoader:dispose()

		arg_23_0._oldMapLoader = nil
	end

	if arg_23_0._oldSceneGo then
		gohelper.destroy(arg_23_0._oldSceneGo)

		arg_23_0._oldSceneGo = nil
	end

	arg_23_0:_clearElements()
	arg_23_0:_stopBgm()
end

function var_0_0._clearElements(arg_24_0)
	for iter_24_0, iter_24_1 in pairs(arg_24_0._elementList) do
		iter_24_1:dispose()
	end

	arg_24_0._elementList = arg_24_0:getUserDataTb_()
end

function var_0_0._initElements(arg_25_0)
	arg_25_0:_showElements()
	arg_25_0:_openBattleElement()
end

function var_0_0._openBattleElement(arg_26_0)
	local var_26_0 = WeekWalkModel.instance:getBattleElementId()

	if not var_26_0 then
		return
	end

	WeekWalkModel.instance:setBattleElementId(nil)

	if WeekWalkModel.instance:infoNeedUpdate() then
		return
	end

	local var_26_1 = arg_26_0._elementList[var_26_0]

	if not var_26_1 then
		return
	end

	local var_26_2 = var_26_1._info
	local var_26_3 = var_26_2.elementId

	if var_26_2:getType() == WeekWalkEnum.ElementType.Battle then
		return
	end

	arg_26_0:_OnClickElement(var_26_1)
end

function var_0_0._showElements(arg_27_0)
	if WeekWalkView._canShowFinishAnim(arg_27_0._mapId) then
		return
	end

	local var_27_0 = WeekWalkModel.instance:getOldOrNewElementInfos(arg_27_0._mapId)
	local var_27_1 = {}

	for iter_27_0, iter_27_1 in ipairs(var_27_0) do
		local var_27_2 = iter_27_1.config.res

		if not string.nilorempty(var_27_2) then
			local var_27_3 = var_27_1[var_27_2] or {}

			if iter_27_1:isAvailable() or arg_27_0._elementList[iter_27_1.elementId] then
				table.insert(var_27_3, iter_27_1)
			end

			var_27_1[var_27_2] = var_27_3
		end
	end

	local var_27_4 = {}

	for iter_27_2 = #var_27_0, 1, -1 do
		local var_27_5 = var_27_0[iter_27_2]
		local var_27_6 = var_27_1[var_27_5.config.res]
		local var_27_7 = var_27_6 and #var_27_6 or 0

		if not var_27_5:isAvailable() then
			arg_27_0:_removeElement(var_27_5, var_27_7 <= 1)
		else
			table.insert(var_27_4, var_27_5)
		end
	end

	for iter_27_3 = #var_27_4, 1, -1 do
		local var_27_8 = var_27_4[iter_27_3]
		local var_27_9 = var_27_1[var_27_8.config.res]
		local var_27_10 = var_27_9 and #var_27_9 or 0

		arg_27_0:_addElement(var_27_8, var_27_10 <= 1)
	end
end

function var_0_0._addElement(arg_28_0, arg_28_1, arg_28_2)
	if arg_28_1:getType() == WeekWalkEnum.ElementType.General and arg_28_1.config.generalType == WeekWalkEnum.GeneralType.Audio then
		local var_28_0 = tonumber(arg_28_1.config.param)

		AudioMgr.instance:trigger(var_28_0)
		WeekwalkRpc.instance:sendWeekwalkGeneralRequest(arg_28_1.elementId)

		return
	end

	local var_28_1 = arg_28_0._elementList[arg_28_1.elementId]

	if var_28_1 then
		var_28_1:updateInfo(arg_28_1)

		return
	end

	local var_28_2 = UnityEngine.GameObject.New(tostring(arg_28_1.elementId))

	gohelper.addChild(arg_28_0._elementRoot, var_28_2)

	local var_28_3 = MonoHelper.addLuaComOnceToGo(var_28_2, WeekWalkMapElement, {
		arg_28_1,
		arg_28_0
	})

	arg_28_0._elementList[arg_28_1.elementId] = var_28_3

	local var_28_4 = var_28_3:getResName()

	if string.nilorempty(var_28_4) then
		return
	end

	local var_28_5 = gohelper.findChild(arg_28_0._diffuseGo, var_28_4)
	local var_28_6

	if not var_28_5 then
		var_28_5 = gohelper.findChild(arg_28_0._backgroundGo, var_28_4)
		var_28_6 = var_28_5
	end

	if not var_28_5 then
		logError(string.format("元件id: %s no resGo:%s", arg_28_1.elementId, var_28_4))

		return
	end

	var_28_6 = var_28_6 or gohelper.clone(var_28_5, var_28_2, var_28_4)

	gohelper.setLayer(var_28_6, UnityLayer.Scene, true)
	var_28_3:setItemGo(var_28_6, arg_28_2)

	if arg_28_1.elementId == 10112 then
		WeekWalkController.instance:dispatchEvent(WeekWalkEvent.GuideShowElement10112)
	end
end

function var_0_0._removeElement(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = arg_29_1.elementId
	local var_29_1 = arg_29_0._elementList[var_29_0]

	if not var_29_1 then
		return
	end

	arg_29_0._elementList[var_29_0] = nil

	var_29_1:updateInfo(arg_29_1)
	var_29_1:disappear(arg_29_2)
end

function var_0_0.onOpen(arg_30_0)
	arg_30_0._mapId = WeekWalkModel.instance:getCurMapId()
	arg_30_0._smokeMaskList = {}
	arg_30_0._smokeMaskOffset = Vector4()

	if GamepadController.instance:isOpen() then
		arg_30_0:addEventCb(GamepadController.instance, GamepadEvent.KeyDown, arg_30_0._onGamepadKeyDown, arg_30_0)
	end

	arg_30_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnChangeMap, arg_30_0._OnChangeMap, arg_30_0)
	arg_30_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnClickElement, arg_30_0._OnClickElement, arg_30_0)
	arg_30_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.GuideClickElement, arg_30_0._OnGuideClickElement, arg_30_0)
	arg_30_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnDialogReply, arg_30_0._OnDialogReply, arg_30_0)
	arg_30_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnAddSmokeMask, arg_30_0._onAddSmokeMask, arg_30_0)
	arg_30_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnRemoveSmokeMask, arg_30_0._onRemoveSmokeMask, arg_30_0)
	arg_30_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnWeekwalkInfoUpdate, arg_30_0._onWeekwalkInfoUpdate, arg_30_0)
	arg_30_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnWeekwalkResetLayer, arg_30_0._onWeekwalkResetLayer, arg_30_0)
	arg_30_0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnShowFinishAnimDone, arg_30_0._onShowFinishAnimDone, arg_30_0)
	arg_30_0:addEventCb(MainController.instance, MainEvent.OnSceneClose, arg_30_0._onSceneClose, arg_30_0)
	arg_30_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_30_0._onOpenView, arg_30_0)
	MainCameraMgr.instance:addView(ViewName.WeekWalkView, arg_30_0._initCamera, nil, arg_30_0)
	arg_30_0:_showMap()
end

function var_0_0._onGamepadKeyDown(arg_31_0, arg_31_1)
	if arg_31_1 == GamepadEnum.KeyCode.A then
		local var_31_0 = CameraMgr.instance:getMainCamera():ScreenPointToRay(GamepadController.instance:getScreenPos())
		local var_31_1 = UnityEngine.Physics2D.RaycastAll(var_31_0.origin, var_31_0.direction)
		local var_31_2 = var_31_1.Length - 1

		for iter_31_0 = 0, var_31_2 do
			local var_31_3 = var_31_1[iter_31_0]
			local var_31_4 = MonoHelper.getLuaComFromGo(var_31_3.transform.parent.gameObject, WeekWalkMapElement)

			if var_31_4 then
				var_31_4:onDown()

				return
			end
		end
	end
end

function var_0_0._onSceneClose(arg_32_0)
	arg_32_0:_stopBgm()
end

function var_0_0._onOpenView(arg_33_0, arg_33_1)
	arg_33_0._elementMouseDown = nil
end

function var_0_0._onShowFinishAnimDone(arg_34_0)
	arg_34_0:_showElements()
end

function var_0_0._onWeekwalkResetLayer(arg_35_0)
	arg_35_0:_clearElements()
	arg_35_0:_showElements()
	arg_35_0._sceneGo:GetComponent(typeof(UnityEngine.Animator)):Play("m_s09_rgmy_in", 0, 0)
end

function var_0_0._onWeekwalkInfoUpdate(arg_36_0)
	arg_36_0:_showElements()
end

function var_0_0._onAddSmokeMask(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = string.split(arg_37_2, "#")
	local var_37_1 = tonumber(var_37_0[1])
	local var_37_2 = tonumber(var_37_0[2])

	arg_37_0._smokeMaskList[arg_37_1] = {
		var_37_1,
		var_37_2
	}

	arg_37_0:_updateSmokeMask()
end

function var_0_0._onRemoveSmokeMask(arg_38_0, arg_38_1)
	arg_38_0._smokeMaskList[arg_38_1] = nil

	arg_38_0:_updateSmokeMask()
end

function var_0_0._updateSmokeMask(arg_39_0)
	if not arg_39_0._smokeMaskMat then
		return
	end

	local var_39_0 = 0

	for iter_39_0, iter_39_1 in pairs(arg_39_0._smokeMaskList) do
		var_39_0 = var_39_0 + 1
		arg_39_0._smokeMaskOffset.x = iter_39_1[1]
		arg_39_0._smokeMaskOffset.y = iter_39_1[2]

		arg_39_0._smokeMaskMat:SetVector("_TransPos_" .. var_39_0, arg_39_0._smokeMaskOffset)
	end

	for iter_39_2 = var_39_0 + 1, 5 do
		arg_39_0._smokeMaskOffset.x = 1000
		arg_39_0._smokeMaskOffset.y = 1000

		arg_39_0._smokeMaskMat:SetVector("_TransPos_" .. iter_39_2, arg_39_0._smokeMaskOffset)
	end
end

function var_0_0._OnDialogReply(arg_40_0, arg_40_1)
	local var_40_0 = arg_40_0._elementList[arg_40_1]

	if not var_40_0 then
		return
	end

	arg_40_0:_OnClickElement(var_40_0)
end

function var_0_0._OnGuideClickElement(arg_41_0, arg_41_1)
	local var_41_0 = tonumber(arg_41_1)

	if not var_41_0 then
		return
	end

	local var_41_1 = arg_41_0._elementList[var_41_0]

	if not var_41_1 then
		return
	end

	arg_41_0:_OnClickElement(var_41_1)
end

function var_0_0._OnClickElement(arg_42_0, arg_42_1)
	local var_42_0 = arg_42_1._go
	local var_42_1, var_42_2 = transformhelper.getLocalPos(var_42_0.transform)
	local var_42_3 = arg_42_1._config
	local var_42_4 = string.splitToNumber(var_42_3.offsetPos, "#")
	local var_42_5 = var_42_1 + (var_42_4[1] or 0)
	local var_42_6 = var_42_2 + (var_42_4[2] or 0)
	local var_42_7 = arg_42_0._mapMaxX - var_42_5 + arg_42_0._viewWidth / 2
	local var_42_8 = arg_42_0._mapMinY - var_42_6 - arg_42_0._viewHeight / 2 + 2

	arg_42_0:_clickElement(arg_42_1)
end

function var_0_0._clickElement(arg_43_0, arg_43_1)
	local var_43_0 = WeekWalkModel.instance:getCurMapInfo()

	if var_43_0 and var_43_0.isFinish > 0 then
		local var_43_1, var_43_2 = var_43_0:getCurStarInfo()

		if var_43_1 ~= var_43_2 then
			AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_completelement)
			WeekWalkController.instance:openWeekWalkResetView()
		end

		return
	end

	local var_43_3 = arg_43_1._info
	local var_43_4 = var_43_3.elementId
	local var_43_5 = var_43_3:getType()

	if var_43_5 == WeekWalkEnum.ElementType.Battle then
		if WeekWalkModel.instance:getCurMapIsFinish() then
			AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_completelement)
		else
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnopen)
		end

		WeekWalkDialogView.startBattle(var_43_4)
	elseif var_43_5 == WeekWalkEnum.ElementType.Respawn then
		-- block empty
	elseif var_43_5 == WeekWalkEnum.ElementType.Dialog then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnopen)
		WeekWalkController.instance:openWeekWalkDialogView(arg_43_1)
	end
end

function var_0_0._OnChangeMap(arg_44_0, arg_44_1)
	if arg_44_1 == arg_44_0._mapCfg then
		arg_44_0:_setInitPos(true)

		return
	end

	arg_44_0:_changeMap(arg_44_1)
end

function var_0_0.onClose(arg_45_0)
	arg_45_0:_stopBgm()
end

function var_0_0.onDestroyView(arg_46_0)
	gohelper.destroy(arg_46_0._sceneRoot)
	arg_46_0:disposeOldMap()

	if arg_46_0._mapLoader then
		arg_46_0._mapLoader:dispose()
	end

	arg_46_0._click:RemoveClickUpListener()
end

return var_0_0
