module("modules.logic.toughbattle.view.ToughBattleMapScene", package.seeall)

local var_0_0 = class("ToughBattleMapScene", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gofullscreen = gohelper.findChild(arg_1_0.viewGO, "#go_fullscreen")
	arg_1_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_1_0._gofullscreen)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._drag:AddDragBeginListener(arg_2_0._onDragBegin, arg_2_0)
	arg_2_0._drag:AddDragEndListener(arg_2_0._onDragEnd, arg_2_0)
	arg_2_0._drag:AddDragListener(arg_2_0._onDrag, arg_2_0)
	arg_2_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_2_0._onScreenResize, arg_2_0)
	arg_2_0:addEventCb(ToughBattleController.instance, ToughBattleEvent.StageUpdate, arg_2_0.loadMap, arg_2_0)
	arg_2_0:addEventCb(ToughBattleController.instance, ToughBattleEvent.BeginPlayFightSucessAnim, arg_2_0.playSuccAnim, arg_2_0)
	arg_2_0:addEventCb(ToughBattleController.instance, ToughBattleEvent.GuideSetElementsActive, arg_2_0._setElementsActive, arg_2_0)
	arg_2_0:addEventCb(ToughBattleController.instance, ToughBattleEvent.GuideClickElement, arg_2_0._guideClickElement, arg_2_0)
	arg_2_0:addEventCb(ToughBattleController.instance, ToughBattleEvent.GuideFocusElement, arg_2_0._guideFocusElement, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._drag:RemoveDragBeginListener()
	arg_3_0._drag:RemoveDragListener()
	arg_3_0._drag:RemoveDragEndListener()
	arg_3_0:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_3_0._onScreenResize, arg_3_0)
	arg_3_0:removeEventCb(ToughBattleController.instance, ToughBattleEvent.StageUpdate, arg_3_0.loadMap, arg_3_0)
	arg_3_0:removeEventCb(ToughBattleController.instance, ToughBattleEvent.BeginPlayFightSucessAnim, arg_3_0.playSuccAnim, arg_3_0)
	arg_3_0:removeEventCb(ToughBattleController.instance, ToughBattleEvent.GuideSetElementsActive, arg_3_0._setElementsActive, arg_3_0)
	arg_3_0:removeEventCb(ToughBattleController.instance, ToughBattleEvent.GuideClickElement, arg_3_0._guideClickElement, arg_3_0)
	arg_3_0:removeEventCb(ToughBattleController.instance, ToughBattleEvent.GuideFocusElement, arg_3_0._guideFocusElement, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._tempVector = Vector3()
	arg_4_0._dragDeltaPos = Vector3()
	arg_4_0._scenePos = Vector3()

	arg_4_0:_initMapRootNode()
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:loadMap()
	MainCameraMgr.instance:addView(arg_5_0.viewName, arg_5_0._initCamera, nil, arg_5_0)
end

function var_0_0._onScreenResize(arg_6_0)
	if arg_6_0._sceneGo then
		local var_6_0 = CameraMgr.instance:getMainCamera()
		local var_6_1 = GameUtil.getAdapterScale()

		var_6_0.orthographicSize = ToughBattleEnum.DungeonMapCameraSize * var_6_1

		arg_6_0:_initScene()
	end
end

function var_0_0._initCamera(arg_7_0)
	local var_7_0 = CameraMgr.instance:getMainCamera()

	var_7_0.orthographic = true

	local var_7_1 = GameUtil.getAdapterScale()

	var_7_0.orthographicSize = ToughBattleEnum.DungeonMapCameraSize * var_7_1
end

function var_0_0.loadMap(arg_8_0)
	if arg_8_0._mapLoader then
		arg_8_0._oldMapLoader = arg_8_0._mapLoader
	end

	local var_8_0 = arg_8_0:getNowShowStage()
	local var_8_1 = var_8_0 == 1 and ToughBattleEnum.MapId_stage1 or ToughBattleEnum.MapId_stage2

	arg_8_0._mapCfg = lua_chapter_map.configDict[var_8_1]
	arg_8_0._mapLoader = MultiAbLoader.New()

	local var_8_2 = {}

	arg_8_0:buildLoadRes(var_8_2, arg_8_0._mapCfg, var_8_0)

	arg_8_0._sceneUrl = var_8_2[1]
	arg_8_0._mapLightUrl = var_8_2[2]
	arg_8_0._mapEffectUrl = var_8_2[3]

	arg_8_0._mapLoader:addPath(arg_8_0._sceneUrl)
	arg_8_0._mapLoader:addPath(arg_8_0._mapLightUrl)

	if arg_8_0._mapEffectUrl then
		arg_8_0._mapLoader:addPath(arg_8_0._mapEffectUrl)
	end

	arg_8_0._mapLoader:startLoad(arg_8_0._loadSceneFinish, arg_8_0)
end

function var_0_0.buildLoadRes(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	table.insert(arg_9_1, ResUrl.getDungeonMapRes(arg_9_2.res))
	table.insert(arg_9_1, "scenes/m_s08_hddt/scene_prefab/m_s08_hddt_light.prefab")

	if arg_9_3 == 2 then
		table.insert(arg_9_1, "scenes/v1a9_m_s08_hddt/vx/prefab/vx_boss_effect3.prefab")
	end
end

function var_0_0._loadSceneFinish(arg_10_0)
	if arg_10_0._oldMapLoader then
		arg_10_0._oldMapLoader:dispose()

		arg_10_0._oldMapLoader = nil

		gohelper.destroy(arg_10_0._sceneGo)
	end

	local var_10_0 = arg_10_0._sceneUrl
	local var_10_1 = arg_10_0._mapLoader:getAssetItem(var_10_0):GetResource(var_10_0)

	arg_10_0._sceneGo = gohelper.clone(var_10_1, arg_10_0._sceneRoot, arg_10_0._mapCfg.id)
	arg_10_0._sceneTrans = arg_10_0._sceneGo.transform

	arg_10_0:_initScene()
	arg_10_0:_initSceneEffect()
	arg_10_0:_addMapLight()
	arg_10_0:_initElements()
	arg_10_0:_setMapPos()
end

function var_0_0._initSceneEffect(arg_11_0)
	if not arg_11_0._mapEffectUrl then
		return
	end

	local var_11_0 = arg_11_0._mapLoader:getAssetItem(arg_11_0._mapEffectUrl):GetResource(arg_11_0._mapEffectUrl)

	gohelper.clone(var_11_0, arg_11_0._sceneGo)
end

function var_0_0._initScene(arg_12_0)
	local var_12_0 = gohelper.findChild(arg_12_0._sceneGo, "root/size"):GetComponentInChildren(typeof(UnityEngine.BoxCollider))

	arg_12_0._mapSize = var_12_0.size

	local var_12_1 = var_12_0.center
	local var_12_2 = var_12_1.x - arg_12_0._mapSize.x / 2
	local var_12_3 = var_12_1.y + arg_12_0._mapSize.y / 2
	local var_12_4
	local var_12_5 = GameUtil.getAdapterScale()

	if var_12_5 ~= 1 then
		var_12_4 = ViewMgr.instance:getUILayer(UILayerName.Hud)
	else
		var_12_4 = ViewMgr.instance:getUIRoot()
	end

	local var_12_6 = var_12_4.transform:GetWorldCorners()
	local var_12_7 = CameraMgr.instance:getUICamera()
	local var_12_8 = var_12_7 and var_12_7.orthographicSize or 5
	local var_12_9 = ToughBattleEnum.DungeonMapCameraSize / var_12_8
	local var_12_10 = var_12_6[1] * var_12_5 * var_12_9
	local var_12_11 = var_12_6[3] * var_12_5 * var_12_9

	arg_12_0._viewWidth = math.abs(var_12_11.x - var_12_10.x)
	arg_12_0._viewHeight = math.abs(var_12_11.y - var_12_10.y)
	arg_12_0._mapMinX = var_12_10.x - (arg_12_0._mapSize.x - arg_12_0._viewWidth) - var_12_2
	arg_12_0._mapMaxX = var_12_10.x - var_12_2
	arg_12_0._mapMinY = var_12_10.y - var_12_3
	arg_12_0._mapMaxY = var_12_10.y + (arg_12_0._mapSize.y - arg_12_0._viewHeight) - var_12_3
end

function var_0_0._onDragBegin(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0._dragBeginPos = arg_13_0:getDragWorldPos(arg_13_2)

	DungeonController.instance:dispatchEvent(DungeonEvent.OnBeginDragMap)
end

function var_0_0._onDragEnd(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0._dragBeginPos = nil
end

function var_0_0._onDrag(arg_15_0, arg_15_1, arg_15_2)
	if not arg_15_0._dragBeginPos then
		return
	end

	arg_15_0._downElement = nil

	local var_15_0 = arg_15_0:getDragWorldPos(arg_15_2)
	local var_15_1 = var_15_0 - arg_15_0._dragBeginPos

	arg_15_0._dragBeginPos = var_15_0

	arg_15_0._tempVector:Set(arg_15_0._scenePos.x + var_15_1.x, arg_15_0._scenePos.y + var_15_1.y)
	arg_15_0:directSetScenePos(arg_15_0._tempVector)
end

function var_0_0.getDragWorldPos(arg_16_0, arg_16_1)
	local var_16_0 = CameraMgr.instance:getMainCamera()
	local var_16_1 = arg_16_0._gofullscreen.transform.position

	return (SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(arg_16_1.position, var_16_0, var_16_1))
end

function var_0_0._setMapPos(arg_17_0)
	if arg_17_0.tempInitPosX then
		arg_17_0._tempVector:Set(arg_17_0.tempInitPosX, arg_17_0.tempInitPosY, 0)

		arg_17_0.tempInitPosX = nil
		arg_17_0.tempInitPosY = nil
	else
		local var_17_0 = arg_17_0._mapCfg.initPos
		local var_17_1 = string.splitToNumber(var_17_0, "#")

		arg_17_0._tempVector:Set(var_17_1[1], var_17_1[2], 0)
	end

	if arg_17_0.needTween then
		arg_17_0:tweenSetScenePos(arg_17_0._tempVector, arg_17_0._oldScenePos)
	else
		arg_17_0:directSetScenePos(arg_17_0._tempVector)
	end
end

function var_0_0._addMapLight(arg_18_0)
	local var_18_0 = arg_18_0._mapLightUrl
	local var_18_1 = arg_18_0._mapLoader:getAssetItem(var_18_0):GetResource(var_18_0)

	gohelper.clone(var_18_1, arg_18_0._sceneGo)
end

function var_0_0.tweenFinishCallback(arg_19_0)
	arg_19_0._tempVector:Set(arg_19_0._tweenTargetPosX, arg_19_0._tweenTargetPosY, 0)
	arg_19_0:directSetScenePos(arg_19_0._tempVector)
	arg_19_0:onTweenFinish()
end

function var_0_0.directSetScenePos(arg_20_0, arg_20_1)
	arg_20_0._downElement = nil

	local var_20_0, var_20_1 = arg_20_0:getTargetPos(arg_20_1)

	arg_20_0._scenePos.x = var_20_0
	arg_20_0._scenePos.y = var_20_1

	if not arg_20_0._sceneTrans or gohelper.isNil(arg_20_0._sceneTrans) then
		return
	end

	transformhelper.setLocalPos(arg_20_0._sceneTrans, arg_20_0._scenePos.x, arg_20_0._scenePos.y, 0)
end

function var_0_0._initElements(arg_21_0)
	arg_21_0._elementRoot = UnityEngine.GameObject.New("elementRoot")

	gohelper.addChild(arg_21_0._sceneGo, arg_21_0._elementRoot)

	arg_21_0._elementFinishRoot = UnityEngine.GameObject.New("elementRootFinish")

	gohelper.addChild(arg_21_0._sceneGo, arg_21_0._elementFinishRoot)

	arg_21_0.tempInitPosX = nil
	arg_21_0.tempInitPosY = nil
	arg_21_0.needTween = nil
	arg_21_0._finishIcons = {}

	local var_21_0 = arg_21_0:getNowShowStage()
	local var_21_1 = var_21_0 == 1 and ToughBattleEnum.MapId_stage1 or ToughBattleEnum.MapId_stage2
	local var_21_2 = DungeonConfig.instance:getMapElements(var_21_1)
	local var_21_3
	local var_21_4 = arg_21_0:getInfo()

	if var_21_0 == 1 then
		for iter_21_0 = 1, 5 do
			local var_21_5 = arg_21_0:getCo(iter_21_0)

			if var_21_5.guideId and var_21_5.guideId > 0 then
				local var_21_6 = GuideModel.instance:getById(var_21_5.guideId)

				if var_21_6 and var_21_6.isFinish and not tabletool.indexOf(var_21_4.passChallengeIds, var_21_5.id) then
					var_21_3 = iter_21_0

					break
				end
			end
		end
	end

	local var_21_7 = arg_21_0.viewParam.lastFightSuccIndex

	for iter_21_1, iter_21_2 in ipairs(var_21_2) do
		local var_21_8 = tonumber(iter_21_2.param)
		local var_21_9 = arg_21_0:getCo(var_21_8)
		local var_21_10 = tabletool.indexOf(var_21_4.passChallengeIds, var_21_9.id)

		if not var_21_3 or var_21_8 == var_21_3 or var_21_10 then
			if var_21_10 then
				local var_21_11 = UnityEngine.GameObject.New(tostring(iter_21_2.id))

				gohelper.addChild(arg_21_0._elementFinishRoot, var_21_11)

				local var_21_12 = gohelper.create3d(var_21_11, "boss")
				local var_21_13 = gohelper.create3d(var_21_11, "icon")
				local var_21_14 = PrefabInstantiate.Create(var_21_12)
				local var_21_15 = PrefabInstantiate.Create(var_21_13)
				local var_21_16 = ToughBattleEnum.FinishIconPos[var_21_8]

				transformhelper.setLocalPosXY(var_21_13.transform, var_21_16.x, var_21_16.y)
				var_21_14:startLoad("scenes/v1a9_m_s08_hddt/prefab/m_s08_hddt_obj_boss" .. var_21_8 .. ".prefab")
				var_21_15:startLoad("scenes/v1a9_m_s08_hddt/prefab/hddt_icon_toughbattle_wancheng.prefab", var_0_0.onFinishIconLoaded, {
					arg_21_0,
					var_21_8,
					var_21_9.sort == var_21_7,
					var_21_15
				})
			else
				local var_21_17 = UnityEngine.GameObject.New(tostring(iter_21_2.id))

				gohelper.addChild(arg_21_0._elementRoot, var_21_17)
				MonoHelper.addLuaComOnceToGo(var_21_17, ToughBattleMapElement, {
					iter_21_2,
					arg_21_0
				})
			end

			if var_21_8 == var_21_7 then
				local var_21_18 = arg_21_0._mapCfg.initPos
				local var_21_19 = string.splitToNumber(var_21_18, "#")

				arg_21_0._oldScenePos = Vector2(var_21_19[1], var_21_19[2])

				local var_21_20 = string.splitToNumber(iter_21_2.pos, "#")
				local var_21_21 = -var_21_20[1] or 0

				arg_21_0.tempInitPosY, arg_21_0.tempInitPosX = -var_21_20[2] or 0, var_21_21
				arg_21_0.needTween = true
			end
		end
	end

	ToughBattleController.instance:dispatchEvent(ToughBattleEvent.GuideCurStage, var_21_0)
	ToughBattleController.instance:dispatchEvent(ToughBattleEvent.InitFightIndex, tostring(#var_21_4.passChallengeIds + 1))
end

function var_0_0._setElementsActive(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_1 == "true" and true or false

	gohelper.setActive(arg_22_0._elementRoot, var_22_0)
end

function var_0_0._guideFocusElement(arg_23_0, arg_23_1)
	local var_23_0 = tonumber(arg_23_1)
	local var_23_1 = arg_23_0:getNowShowStage() == 1 and ToughBattleEnum.MapId_stage1 or ToughBattleEnum.MapId_stage2
	local var_23_2 = DungeonConfig.instance:getMapElements(var_23_1)

	for iter_23_0, iter_23_1 in ipairs(var_23_2) do
		if var_23_0 == tonumber(iter_23_1.param) then
			local var_23_3 = string.splitToNumber(iter_23_1.pos, "#")
			local var_23_4 = -var_23_3[1] or 0

			arg_23_0.tempInitPosY, arg_23_0.tempInitPosX = -var_23_3[2] or 0, var_23_4
			arg_23_0.needTween = true

			arg_23_0:_setMapPos()

			break
		end
	end
end

function var_0_0._guideClickElement(arg_24_0, arg_24_1)
	local var_24_0 = tonumber(arg_24_1)
	local var_24_1 = arg_24_0:getCo(var_24_0)

	arg_24_0:onEnterFight(var_24_1, var_24_0 == 6 and 2 or 1)
end

function var_0_0.playSuccAnim(arg_25_0)
	if not arg_25_0._finishIcons or not arg_25_0._finishIcons[arg_25_0.viewParam.lastFightSuccIndex] then
		return
	end

	arg_25_0._finishIcons[arg_25_0.viewParam.lastFightSuccIndex]:Play("open", 0, 0)
end

function var_0_0.onFinishIconLoaded(arg_26_0)
	local var_26_0 = arg_26_0[1]
	local var_26_1 = arg_26_0[2]
	local var_26_2 = arg_26_0[3]
	local var_26_3 = arg_26_0[4]:getInstGO():GetComponent(typeof(UnityEngine.Animator))

	var_26_0._finishIcons[var_26_1] = var_26_3

	if var_26_2 then
		var_26_3:Play("open", 0, 0)
	else
		var_26_3:Play("open", 0, 1)
	end
end

function var_0_0.onTweenFinish(arg_27_0)
	return
end

function var_0_0.getInfo(arg_28_0)
	return arg_28_0.viewParam.mode == ToughBattleEnum.Mode.Act and ToughBattleModel.instance:getActInfo() or ToughBattleModel.instance:getStoryInfo()
end

function var_0_0.getNowShowStage(arg_29_0)
	if #arg_29_0:getInfo().passChallengeIds >= 3 and not arg_29_0.viewParam.lastFightSuccIndex then
		return 2
	else
		return 1
	end
end

function var_0_0.setMouseElementUp(arg_30_0, arg_30_1)
	if arg_30_0._downElement ~= arg_30_1 then
		return
	end

	if UIBlockMgr.instance:isBlock() or ZProj.TouchEventMgr.Fobidden then
		return
	end

	if not ViewHelper.instance:checkViewOnTheTop(arg_30_0.viewName) then
		arg_30_0._downElement = false

		return
	end

	if arg_30_0.viewParam.lastFightSuccIndex then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	local var_30_0 = arg_30_1._config
	local var_30_1 = tonumber(var_30_0.param)

	arg_30_0:onEnterFight(arg_30_0:getCo(var_30_1), var_30_1 == 6 and 2 or 1)
end

function var_0_0.getCo(arg_31_0, arg_31_1)
	if arg_31_0.viewParam.mode == ToughBattleEnum.Mode.Act then
		local var_31_0 = arg_31_0:getInfo()
		local var_31_1 = ToughBattleConfig.instance:getCOByDiffcult(var_31_0.currDifficulty)

		if arg_31_1 == 6 then
			return var_31_1.stage2
		else
			return var_31_1.stage1[arg_31_1]
		end
	else
		local var_31_2 = ToughBattleConfig.instance:getStoryCO()

		if arg_31_1 == 6 then
			return var_31_2.stage2
		else
			return var_31_2.stage1[arg_31_1]
		end
	end
end

function var_0_0.setMouseElementDown(arg_32_0, arg_32_1)
	arg_32_0._downElement = arg_32_1
end

function var_0_0.onEnterFight(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_0:getInfo()

	if tabletool.indexOf(var_33_0.passChallengeIds, arg_33_1.id) then
		return
	end

	if arg_33_2 == 1 then
		ViewMgr.instance:openView(ViewName.ToughBattleEnemyInfoView, arg_33_1)
	else
		local var_33_1 = arg_33_1.episodeId
		local var_33_2 = DungeonConfig.instance:getEpisodeCO(var_33_1)

		DungeonFightController.instance:enterFight(var_33_2.chapterId, var_33_1)
	end
end

function var_0_0.tweenSetScenePos(arg_34_0, arg_34_1, arg_34_2)
	arg_34_0._tweenTargetPosX, arg_34_0._tweenTargetPosY = arg_34_0:getTargetPos(arg_34_1)
	arg_34_0._tweenStartPosX, arg_34_0._tweenStartPosY = arg_34_0:getTargetPos(arg_34_2 or arg_34_0._scenePos)

	arg_34_0:killTween()

	arg_34_0.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, DungeonEnum.DefaultTweenMapTime, arg_34_0.tweenFrameCallback, arg_34_0.tweenFinishCallback, arg_34_0)

	arg_34_0:tweenFrameCallback(0)
end

function var_0_0.killTween(arg_35_0)
	if arg_35_0.tweenId then
		ZProj.TweenHelper.KillById(arg_35_0.tweenId)
	end
end

function var_0_0.tweenFrameCallback(arg_36_0, arg_36_1)
	local var_36_0 = Mathf.Lerp(arg_36_0._tweenStartPosX, arg_36_0._tweenTargetPosX, arg_36_1)
	local var_36_1 = Mathf.Lerp(arg_36_0._tweenStartPosY, arg_36_0._tweenTargetPosY, arg_36_1)

	arg_36_0._tempVector:Set(var_36_0, var_36_1, 0)
	arg_36_0:directSetScenePos(arg_36_0._tempVector)
end

function var_0_0.getTargetPos(arg_37_0, arg_37_1)
	local var_37_0 = arg_37_1.x
	local var_37_1 = arg_37_1.y

	if not arg_37_0._mapMinX or not arg_37_0._mapMinY then
		return var_37_0, var_37_1
	end

	if var_37_0 < arg_37_0._mapMinX then
		var_37_0 = arg_37_0._mapMinX
	elseif var_37_0 > arg_37_0._mapMaxX then
		var_37_0 = arg_37_0._mapMaxX
	end

	if var_37_1 < arg_37_0._mapMinY then
		var_37_1 = arg_37_0._mapMinY
	elseif var_37_1 > arg_37_0._mapMaxY then
		var_37_1 = arg_37_0._mapMaxY
	end

	return var_37_0, var_37_1
end

function var_0_0._initMapRootNode(arg_38_0)
	local var_38_0 = CameraMgr.instance:getMainCameraTrs().parent
	local var_38_1 = CameraMgr.instance:getSceneRoot()

	arg_38_0._sceneRoot = UnityEngine.GameObject.New("ToughBattleMapScene")

	local var_38_2, var_38_3, var_38_4 = transformhelper.getLocalPos(var_38_0)

	transformhelper.setLocalPos(arg_38_0._sceneRoot.transform, 0, var_38_3, 0)
	gohelper.addChild(var_38_1, arg_38_0._sceneRoot)
end

function var_0_0.setSceneVisible(arg_39_0, arg_39_1)
	gohelper.setActive(arg_39_0._sceneRoot, arg_39_1)
end

function var_0_0.onClose(arg_40_0)
	if arg_40_0._mapLoader then
		arg_40_0._mapLoader:dispose()

		arg_40_0._mapLoader = nil
	end

	gohelper.destroy(arg_40_0._sceneRoot)
end

return var_0_0
