module("modules.logic.weekwalk.view.WeekWalkMap", package.seeall)

slot0 = class("WeekWalkMap", BaseView)

function slot0.onInitView(slot0)
	slot0._gofullscreen = gohelper.findChild(slot0.viewGO, "#go_fullscreen")
	slot0._gotoptipsbg = gohelper.findChild(slot0.viewGO, "#go_main/#go_toptipsbg")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._elementList = slot0:getUserDataTb_()
	slot0._tempVector = Vector3()
	slot0._infoNeedUpdate = WeekWalkModel.instance:infoNeedUpdate()

	slot0:_initMap()
	slot0:_initClick()
end

function slot0._initClick(slot0)
	slot0._click = SLFramework.UGUI.UIClickListener.Get(slot0._gofullscreen)

	slot0._click:AddClickUpListener(slot0._clickUp, slot0)
end

function slot0.setElementDown(slot0, slot1)
	if ViewMgr.instance:isOpen(ViewName.WeekWalkDialogView) or ViewMgr.instance:isOpen(ViewName.WeekWalkTarotView) then
		return
	end

	slot0._elementMouseDown = slot1
end

function slot0._clickUp(slot0)
	slot0._elementMouseDown = nil

	if slot0._elementMouseDown and slot1:isValid() then
		slot1:onClick()
	end
end

function slot0.setScenePosSafety(slot0, slot1, slot2)
	if not slot0._sceneTrans then
		return
	end

	if slot1.x < slot0._mapMinX then
		slot1.x = slot0._mapMinX
	elseif slot0._mapMaxX < slot1.x then
		slot1.x = slot0._mapMaxX
	end

	if slot1.y < slot0._mapMinY then
		slot1.y = slot0._mapMinY
	elseif slot0._mapMaxY < slot1.y then
		slot1.y = slot0._mapMaxY
	end

	if slot2 then
		ZProj.TweenHelper.DOLocalMove(slot0._sceneTrans, slot1.x, slot1.y, 0, 0.26)
	else
		slot0._sceneTrans.localPosition = slot1
	end
end

function slot0._initCamera(slot0)
	slot1 = CameraMgr.instance:getMainCamera()
	slot1.orthographic = true

	transformhelper.setLocalRotation(slot1.transform, 0, 0, 0)

	slot1.orthographicSize = WeekWalkEnum.orthographicSize * GameUtil.getAdapterScale()
end

function slot0._initMap(slot0)
	slot0._sceneRoot = UnityEngine.GameObject.New("WeekWalkMap")
	slot3, slot4, slot5 = transformhelper.getLocalPos(CameraMgr.instance:getMainCameraTrs().parent)

	transformhelper.setLocalPos(slot0._sceneRoot.transform, 0, slot4, 0)
	gohelper.addChild(CameraMgr.instance:getSceneRoot(), slot0._sceneRoot)
end

function slot0.onUpdateParam(slot0)
end

function slot0._showMap(slot0)
	slot0:_changeMap(WeekWalkConfig.instance:getMapConfig(slot0._mapId))
end

function slot0._changeMap(slot0, slot1)
	if not slot1 or slot0._mapCfg == slot1 then
		return
	end

	if not slot0._oldMapLoader then
		slot0._oldMapLoader = slot0._mapLoader
		slot0._oldSceneGo = slot0._sceneGo
		slot0._oldSceneTrans = slot0._sceneTrans
	elseif slot0._mapLoader then
		slot0._mapLoader:dispose()

		slot0._mapLoader = nil
	end

	slot0._mapCfg = slot1
	slot2 = WeekWalkModel.instance:getOldOrNewCurMapInfo()
	slot0._mapLoader = MultiAbLoader.New()

	slot0._mapLoader:addPath(lua_weekwalk_scene.configDict[slot2.sceneId].map)

	slot0._canvasUrl = "ui/viewres/dungeon/chaptermap/chaptermapscenecanvas.prefab"
	slot0._interactiveItemUrl = "ui/viewres/weekwalk/weekwalkmapinteractiveitem.prefab"

	slot0._mapLoader:addPath(slot0._canvasUrl)
	slot0._mapLoader:addPath(slot0._interactiveItemUrl)

	if not WeekWalkModel.isShallowMap(slot2.id) then
		slot0._smokeUrl = "scenes/m_s09_rgmy/prefab/weekwalk_deepdream_smoke01.prefab"

		slot0._mapLoader:addPath(slot0._smokeUrl)
	end

	slot0._mapLoader:startLoad(function (slot0)
		uv0:disposeOldMap()

		uv0._sceneGo = gohelper.clone(uv0._mapLoader:getAssetItem(uv1):GetResource(uv1), uv0._sceneRoot, tostring(uv2.id))

		gohelper.setActive(uv0._sceneGo, true)

		uv0._sceneTrans = uv0._sceneGo.transform
		uv0._backgroundGo = gohelper.findChild(uv0._sceneGo, "root/BackGround")
		uv0._diffuseGo = gohelper.findChild(uv0._sceneGo, "Obj-Plant/all/diffuse")
		uv0._elementRoot = UnityEngine.GameObject.New("elementRoot")

		gohelper.addChild(uv0._sceneGo, uv0._elementRoot)

		if uv0._smokeUrl then
			uv0._smokeGo = gohelper.clone(uv0._mapLoader:getAssetItem(uv0._smokeUrl):GetResource(uv0._smokeUrl), uv0._sceneGo)
			uv0._smokeMaskMat = gohelper.findChild(uv0._smokeGo, "smoke01/1"):GetComponent(typeof(UnityEngine.Renderer)).sharedMaterial

			uv0:_updateSmokeMask()
			transformhelper.setLocalPos(uv0._smokeGo.transform, 0, 0, 0)
		end

		uv0._anim = uv0._sceneGo:GetComponent(typeof(UnityEngine.Animator))

		uv0:_initScene()
		uv0:_initCanvas()
		uv0:_onPlayEnterAnim()
	end)
end

function slot0._playEnterAnim(slot0)
	slot0._isPlayAnim = true

	slot0:_onPlayEnterAnim()
end

function slot0._onPlayEnterAnim(slot0)
	if slot0._anim then
		slot0._anim.enabled = slot0._isPlayAnim

		if gohelper.findChild(slot0._backgroundGo, "bg_static") then
			gohelper.setActive(slot1, not slot0._isPlayAnim)
		end

		if slot0._isPlayAnim and not slot0._infoNeedUpdate then
			slot0:_initElements()
		end
	end
end

function slot0._playBgm(slot0, slot1)
	if not tonumber(slot1) or slot1 <= 0 or slot0._bgmId then
		return
	end

	slot0._bgmId = slot1

	AudioBgmManager.instance:modifyAndPlay(AudioBgmEnum.Layer.WeekWalk, slot0._bgmId, AudioEnum.WeekWalk.stop_sleepwalkingaudio)
end

function slot0._stopBgm(slot0)
	if slot0._bgmId then
		slot0._bgmId = nil

		AudioBgmManager.instance:stopAndClear(AudioBgmEnum.Layer.WeekWalk)
	end
end

function slot0._initCanvas(slot0)
	slot0._sceneCanvasGo = gohelper.clone(slot0._mapLoader:getAssetItem(slot0._canvasUrl):GetResource(slot0._canvasUrl), slot0._sceneGo)
	slot0._sceneCanvas = slot0._sceneCanvasGo:GetComponent("Canvas")
	slot0._sceneCanvas.worldCamera = CameraMgr.instance:getMainCamera()
	slot0._itemPrefab = slot0._mapLoader:getAssetItem(slot0._interactiveItemUrl):GetResource(slot0._interactiveItemUrl)
end

function slot0.getInteractiveItem(slot0)
	slot0._uiGo = gohelper.clone(slot0._itemPrefab, slot0._sceneCanvasGo)
	slot0._interactiveItem = MonoHelper.addLuaComOnceToGo(slot0._uiGo, WeekWalkMapInteractiveItem)

	gohelper.setActive(slot0._uiGo, false)

	return slot0._interactiveItem
end

function slot0._initScene(slot0)
	slot0._mapSize = gohelper.findChild(slot0._sceneGo, "root/size"):GetComponentInChildren(typeof(UnityEngine.BoxCollider)).size
	slot3 = nil
	slot5 = ((GameUtil.getAdapterScale() == 1 or ViewMgr.instance:getUILayer(UILayerName.Hud)) and ViewMgr.instance:getUIRoot()).transform:GetWorldCorners()
	slot6 = slot5[1]
	slot7 = slot5[3]
	slot0._viewWidth = math.abs(slot7.x - slot6.x)
	slot0._viewHeight = math.abs(slot7.y - slot6.y)
	slot0._mapMinX = slot6.x - (slot0._mapSize.x - slot0._viewWidth)
	slot0._mapMaxX = slot6.x
	slot0._mapMinY = slot6.y
	slot0._mapMaxY = slot6.y + slot0._mapSize.y - slot0._viewHeight

	if slot0._oldScenePos then
		slot0._sceneTrans.localPosition = slot0._oldScenePos
	end

	slot0._oldScenePos = nil
end

function slot0._setInitPos(slot0, slot1)
	if not slot0._mapCfg then
		return
	end

	slot3 = string.splitToNumber(slot0._mapCfg.initPos, "#")

	slot0:setScenePosSafety(Vector3(slot3[1], slot3[2], 0), slot1)
end

function slot0.disposeOldMap(slot0)
	if slot0._sceneTrans then
		slot0._oldScenePos = slot0._sceneTrans.localPosition
	else
		slot0._oldScenePos = nil
	end

	if slot0._oldMapLoader then
		slot0._oldMapLoader:dispose()

		slot0._oldMapLoader = nil
	end

	if slot0._oldSceneGo then
		gohelper.destroy(slot0._oldSceneGo)

		slot0._oldSceneGo = nil
	end

	slot0:_clearElements()
	slot0:_stopBgm()
end

function slot0._clearElements(slot0)
	for slot4, slot5 in pairs(slot0._elementList) do
		slot5:dispose()
	end

	slot0._elementList = slot0:getUserDataTb_()
end

function slot0._initElements(slot0)
	slot0:_showElements()
	slot0:_openBattleElement()
end

function slot0._openBattleElement(slot0)
	if not WeekWalkModel.instance:getBattleElementId() then
		return
	end

	WeekWalkModel.instance:setBattleElementId(nil)

	if WeekWalkModel.instance:infoNeedUpdate() then
		return
	end

	if not slot0._elementList[slot1] then
		return
	end

	slot3 = slot2._info
	slot4 = slot3.elementId

	if slot3:getType() == WeekWalkEnum.ElementType.Battle then
		return
	end

	slot0:_OnClickElement(slot2)
end

function slot0._showElements(slot0)
	if WeekWalkView._canShowFinishAnim(slot0._mapId) then
		return
	end

	slot2 = {}

	for slot6, slot7 in ipairs(WeekWalkModel.instance:getOldOrNewElementInfos(slot0._mapId)) do
		if not string.nilorempty(slot7.config.res) then
			slot9 = slot2[slot8] or {}

			if slot7:isAvailable() or slot0._elementList[slot7.elementId] then
				table.insert(slot9, slot7)
			end

			slot2[slot8] = slot9
		end
	end

	slot3 = {}

	for slot7 = #slot1, 1, -1 do
		if not slot8:isAvailable() then
			slot0:_removeElement(slot8, (slot2[slot1[slot7].config.res] and #slot10 or 0) <= 1)
		else
			table.insert(slot3, slot8)
		end
	end

	for slot7 = #slot3, 1, -1 do
		slot0:_addElement(slot8, (slot2[slot3[slot7].config.res] and #slot10 or 0) <= 1)
	end
end

function slot0._addElement(slot0, slot1, slot2)
	if slot1:getType() == WeekWalkEnum.ElementType.General and slot1.config.generalType == WeekWalkEnum.GeneralType.Audio then
		AudioMgr.instance:trigger(tonumber(slot1.config.param))
		WeekwalkRpc.instance:sendWeekwalkGeneralRequest(slot1.elementId)

		return
	end

	if slot0._elementList[slot1.elementId] then
		slot3:updateInfo(slot1)

		return
	end

	slot4 = UnityEngine.GameObject.New(tostring(slot1.elementId))

	gohelper.addChild(slot0._elementRoot, slot4)

	slot3 = MonoHelper.addLuaComOnceToGo(slot4, WeekWalkMapElement, {
		slot1,
		slot0
	})
	slot0._elementList[slot1.elementId] = slot3

	if string.nilorempty(slot3:getResName()) then
		return
	end

	slot7 = nil

	if not gohelper.findChild(slot0._diffuseGo, slot5) then
		slot7 = gohelper.findChild(slot0._backgroundGo, slot5)
	end

	if not slot6 then
		logError(string.format("元件id: %s no resGo:%s", slot1.elementId, slot5))

		return
	end

	slot7 = slot7 or gohelper.clone(slot6, slot4, slot5)

	gohelper.setLayer(slot7, UnityLayer.Scene, true)
	slot3:setItemGo(slot7, slot2)

	if slot1.elementId == 10112 then
		WeekWalkController.instance:dispatchEvent(WeekWalkEvent.GuideShowElement10112)
	end
end

function slot0._removeElement(slot0, slot1, slot2)
	if not slot0._elementList[slot1.elementId] then
		return
	end

	slot0._elementList[slot3] = nil

	slot4:updateInfo(slot1)
	slot4:disappear(slot2)
end

function slot0.onOpen(slot0)
	slot0._mapId = WeekWalkModel.instance:getCurMapId()
	slot0._smokeMaskList = {}
	slot0._smokeMaskOffset = Vector4()

	if GamepadController.instance:isOpen() then
		slot0:addEventCb(GamepadController.instance, GamepadEvent.KeyDown, slot0._onGamepadKeyDown, slot0)
	end

	slot0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnChangeMap, slot0._OnChangeMap, slot0)
	slot0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnClickElement, slot0._OnClickElement, slot0)
	slot0:addEventCb(WeekWalkController.instance, WeekWalkEvent.GuideClickElement, slot0._OnGuideClickElement, slot0)
	slot0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnDialogReply, slot0._OnDialogReply, slot0)
	slot0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnAddSmokeMask, slot0._onAddSmokeMask, slot0)
	slot0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnRemoveSmokeMask, slot0._onRemoveSmokeMask, slot0)
	slot0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnWeekwalkInfoUpdate, slot0._onWeekwalkInfoUpdate, slot0)
	slot0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnWeekwalkResetLayer, slot0._onWeekwalkResetLayer, slot0)
	slot0:addEventCb(WeekWalkController.instance, WeekWalkEvent.OnShowFinishAnimDone, slot0._onShowFinishAnimDone, slot0)
	slot0:addEventCb(MainController.instance, MainEvent.OnSceneClose, slot0._onSceneClose, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	MainCameraMgr.instance:addView(ViewName.WeekWalkView, slot0._initCamera, nil, slot0)
	slot0:_showMap()
end

function slot0._onGamepadKeyDown(slot0, slot1)
	if slot1 == GamepadEnum.KeyCode.A then
		slot2 = CameraMgr.instance:getMainCamera():ScreenPointToRay(GamepadController.instance:getScreenPos())

		for slot8 = 0, UnityEngine.Physics2D.RaycastAll(slot2.origin, slot2.direction).Length - 1 do
			if MonoHelper.getLuaComFromGo(slot3[slot8].transform.parent.gameObject, WeekWalkMapElement) then
				slot10:onDown()

				return
			end
		end
	end
end

function slot0._onSceneClose(slot0)
	slot0:_stopBgm()
end

function slot0._onOpenView(slot0, slot1)
	slot0._elementMouseDown = nil
end

function slot0._onShowFinishAnimDone(slot0)
	slot0:_showElements()
end

function slot0._onWeekwalkResetLayer(slot0)
	slot0:_clearElements()
	slot0:_showElements()
	slot0._sceneGo:GetComponent(typeof(UnityEngine.Animator)):Play("m_s09_rgmy_in", 0, 0)
end

function slot0._onWeekwalkInfoUpdate(slot0)
	slot0:_showElements()
end

function slot0._onAddSmokeMask(slot0, slot1, slot2)
	slot3 = string.split(slot2, "#")
	slot0._smokeMaskList[slot1] = {
		tonumber(slot3[1]),
		tonumber(slot3[2])
	}

	slot0:_updateSmokeMask()
end

function slot0._onRemoveSmokeMask(slot0, slot1)
	slot0._smokeMaskList[slot1] = nil

	slot0:_updateSmokeMask()
end

function slot0._updateSmokeMask(slot0)
	if not slot0._smokeMaskMat then
		return
	end

	slot1 = 0

	for slot5, slot6 in pairs(slot0._smokeMaskList) do
		slot0._smokeMaskOffset.x = slot6[1]
		slot0._smokeMaskOffset.y = slot6[2]

		slot0._smokeMaskMat:SetVector("_TransPos_" .. slot1 + 1, slot0._smokeMaskOffset)
	end

	for slot5 = slot1 + 1, 5 do
		slot0._smokeMaskOffset.x = 1000
		slot0._smokeMaskOffset.y = 1000

		slot0._smokeMaskMat:SetVector("_TransPos_" .. slot5, slot0._smokeMaskOffset)
	end
end

function slot0._OnDialogReply(slot0, slot1)
	if not slot0._elementList[slot1] then
		return
	end

	slot0:_OnClickElement(slot2)
end

function slot0._OnGuideClickElement(slot0, slot1)
	if not tonumber(slot1) then
		return
	end

	if not slot0._elementList[slot2] then
		return
	end

	slot0:_OnClickElement(slot3)
end

function slot0._OnClickElement(slot0, slot1)
	slot3, slot4 = transformhelper.getLocalPos(slot1._go.transform)
	slot3 = slot0._mapMaxX - (slot3 + (string.splitToNumber(slot1._config.offsetPos, "#")[1] or 0)) + slot0._viewWidth / 2
	slot4 = slot0._mapMinY - (slot4 + (slot6[2] or 0)) - slot0._viewHeight / 2 + 2

	slot0:_clickElement(slot1)
end

function slot0._clickElement(slot0, slot1)
	if WeekWalkModel.instance:getCurMapInfo() and slot2.isFinish > 0 then
		slot3, slot4 = slot2:getCurStarInfo()

		if slot3 ~= slot4 then
			AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_completelement)
			WeekWalkController.instance:openWeekWalkResetView()
		end

		return
	end

	slot3 = slot1._info
	slot4 = slot3.elementId

	if slot3:getType() == WeekWalkEnum.ElementType.Battle then
		if WeekWalkModel.instance:getCurMapIsFinish() then
			AudioMgr.instance:trigger(AudioEnum.WeekWalk.play_artificial_ui_completelement)
		else
			AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnopen)
		end

		WeekWalkDialogView.startBattle(slot4)
	elseif slot5 == WeekWalkEnum.ElementType.Respawn then
		-- Nothing
	elseif slot5 == WeekWalkEnum.ElementType.Dialog then
		AudioMgr.instance:trigger(AudioEnum.UI.play_ui_checkpoint_warnopen)
		WeekWalkController.instance:openWeekWalkDialogView(slot1)
	end
end

function slot0._OnChangeMap(slot0, slot1)
	if slot1 == slot0._mapCfg then
		slot0:_setInitPos(true)

		return
	end

	slot0:_changeMap(slot1)
end

function slot0.onClose(slot0)
	slot0:_stopBgm()
end

function slot0.onDestroyView(slot0)
	gohelper.destroy(slot0._sceneRoot)
	slot0:disposeOldMap()

	if slot0._mapLoader then
		slot0._mapLoader:dispose()
	end

	slot0._click:RemoveClickUpListener()
end

return slot0
