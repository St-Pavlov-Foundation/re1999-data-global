module("modules.logic.versionactivity2_4.pinball.view.PinballCitySceneView", package.seeall)

slot0 = class("PinballCitySceneView", PinballBaseSceneView)

function slot0.onInitView(slot0)
	slot0._gobuildingui = gohelper.findChild(slot0.viewGO, "#go_buildingui")
	slot0._gofull = gohelper.findChild(slot0.viewGO, "#go_full")
	slot0._clickFull = gohelper.findChildClick(slot0.viewGO, "#go_full")
end

function slot0.addEvents(slot0)
	slot0._touchEventMgr = TouchEventMgrHepler.getTouchEventMgr(slot0._gofull)

	slot0._touchEventMgr:SetIgnoreUI(true)
	slot0._touchEventMgr:SetScrollWheelCb(slot0.onMouseScrollWheelChange, slot0)

	if BootNativeUtil.isMobilePlayer() then
		slot0._touchEventMgr:SetOnMultiDragCb(slot0.onMultDrag, slot0)
	end

	slot0._clickFull:AddClickListener(slot0._onClickFull, slot0)
	CommonDragHelper.instance:registerDragObj(slot0._gofull, slot0._beginDrag, slot0._onDrag, slot0._endDrag, nil, slot0, nil, true)
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, slot0.calcSceneBoard, slot0)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseViewFinish, slot0._tweenToMainCity, slot0)
	PinballController.instance:registerCallback(PinballEvent.TweenToHole, slot0._tweenToHole, slot0)
end

function slot0.removeEvents(slot0)
	slot0._clickFull:RemoveClickListener()
	CommonDragHelper.instance:unregisterDragObj(slot0._gofull)
	GameGlobalMgr.instance:unregisterCallback(GameStateEvent.OnScreenResize, slot0.calcSceneBoard, slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseViewFinish, slot0._tweenToMainCity, slot0)
	PinballController.instance:unregisterCallback(PinballEvent.TweenToHole, slot0._tweenToHole, slot0)
end

function slot0.beforeLoadScene(slot0)
	slot0._sceneTrans = slot0._sceneRoot.transform
	slot0._buildingRoot = gohelper.create3d(slot0._sceneRoot, "Building")
end

function slot0.onSceneLoaded(slot0, slot1)
	slot0._scale = PinballConst.Const105

	transformhelper.setLocalScale(slot0._sceneTrans, slot0._scale, slot0._scale, 1)

	slot0._sceneGo = slot1

	slot0:calcSceneBoard()
	slot0:placeBuildings()
	slot0:setScenePosSafety(slot0:getMainPos())
end

function slot0.placeBuildings(slot0)
	slot0._buildings = {}

	for slot6, slot7 in pairs(PinballConfig.instance:getAllHoleCo(VersionActivity2_4Enum.ActivityId.Pinball)) do
		slot9 = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.create3d(slot0._buildingRoot, tostring(slot6)), PinballBuildingEntity)

		slot9:initCo(slot7)
		slot9:setUI(slot0:getResInst(slot0.viewContainer._viewSetting.otherRes.menu, slot0._gobuildingui, "UI_" .. slot6))
		slot9:setUIScale(slot0._scale)
		table.insert(slot0._buildings, slot9)
	end
end

function slot0.calcSceneBoard(slot0)
	slot0._mapMinX = -10
	slot0._mapMaxX = 10
	slot0._mapMinY = -10
	slot0._mapMaxY = 10

	if not slot0._sceneGo then
		return
	end

	if not gohelper.findChild(slot0._sceneGo, "BackGround/size") then
		return
	end

	if not slot1:GetComponentInChildren(typeof(UnityEngine.BoxCollider)) then
		return
	end

	slot3 = slot1.transform.lossyScale
	slot0._mapSize = slot2.size
	slot0._mapSize.x = slot0._mapSize.x * slot3.x
	slot0._mapSize.y = slot0._mapSize.y * slot3.y
	slot4 = nil
	slot5 = slot5 * 7 / 5
	slot6 = ((GameUtil.getAdapterScale() == 1 or ViewMgr.instance:getUILayer(UILayerName.Hud)) and ViewMgr.instance:getUIRoot()).transform:GetWorldCorners()
	slot7 = slot6[1] * slot5
	slot8 = slot6[3] * slot5
	slot0._viewWidth = math.abs(slot8.x - slot7.x)
	slot0._viewHeight = math.abs(slot8.y - slot7.y)
	slot9 = 5.8
	slot10 = slot2.center
	slot0._mapMinX = slot7.x - (slot0._mapSize.x / 2 - slot0._viewWidth) - slot10.x * slot3.x
	slot0._mapMaxX = slot7.x + slot0._mapSize.x / 2 - slot10.x * slot3.x
	slot0._mapMinY = slot7.y - slot0._mapSize.y / 2 + slot9 - slot10.y * slot3.y
	slot0._mapMaxY = slot7.y + slot0._mapSize.y / 2 - slot0._viewHeight + slot9 - slot10.y * slot3.y
end

function slot0.onMouseScrollWheelChange(slot0, slot1)
	slot0:_setScale(slot0._scale + slot1 * PinballConst.Const103)
end

function slot0.onMultDrag(slot0, slot1, slot2)
	slot0:_setScale(slot0._scale + slot2 * 0.01 * PinballConst.Const104)
end

function slot0._setScale(slot0, slot1)
	if not slot0._sceneGo then
		return
	end

	if not ViewHelper.instance:checkViewOnTheTop(ViewName.PinballCityView) then
		return
	end

	if Mathf.Clamp(slot1, PinballConst.Const101, PinballConst.Const102) == slot0._scale then
		return
	end

	slot0._targetPos.x = slot0._targetPos.x / slot0._scale * slot1
	slot0._targetPos.y = slot0._targetPos.y / slot0._scale * slot1
	slot0._scale = slot1
	slot5 = slot0._scale
	slot6 = 1

	transformhelper.setLocalScale(slot0._sceneTrans, slot0._scale, slot5, slot6)
	slot0:calcSceneBoard()
	slot0:setScenePosSafety(slot0._targetPos)

	for slot5, slot6 in pairs(slot0._buildings) do
		slot6:setUIScale(slot0._scale)
	end
end

function slot0._tweenToMainCity(slot0, slot1)
	if slot1 ~= ViewName.PinballDayEndView then
		return
	end

	if not slot0:getMainPos() then
		return
	end

	slot0._fromPos = slot0._targetPos
	slot0._toPos = slot2
	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.3, slot0._onTween, slot0._onTweenFinish, slot0)
end

function slot0._tweenToHole(slot0, slot1)
	if not slot0:getHolePos(tonumber(slot1) or PinballModel.instance.guideHole or 1) then
		return
	end

	slot0._fromPos = slot0._targetPos
	slot0._toPos = slot2
	slot0._tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, 0.3, slot0._onTween, slot0._onTweenFinish, slot0)
end

function slot0.getMainPos(slot0)
	if not slot0._buildings then
		return
	end

	slot1 = nil

	for slot5, slot6 in pairs(slot0._buildings) do
		if slot6:isMainCity() then
			slot1 = -slot6.trans.localPosition
			slot1.y = slot1.y + 5.8
		end
	end

	return slot1
end

function slot0.getHolePos(slot0, slot1)
	if not slot0._buildings then
		return
	end

	slot2 = nil

	for slot6, slot7 in pairs(slot0._buildings) do
		if slot7.co.index == slot1 then
			slot2 = -slot7.trans.localPosition
			slot2.y = slot2.y + 5.8
		end
	end

	return slot2
end

function slot0._onTween(slot0, slot1)
	slot0:setScenePosSafety(Vector3.Lerp(slot0._fromPos, slot0._toPos, slot1))
end

function slot0._onTweenFinish(slot0)
	slot0._tweenId = nil
end

slot1 = Vector3()

function slot0._onClickFull(slot0)
	if slot0._isDrag then
		return
	end

	if not slot0._buildings then
		return
	end

	slot0.viewContainer:dispatchEvent(PinballEvent.ClickScene)

	for slot7, slot8 in pairs(slot0._buildings) do
		slot3 = slot8:tryClick(recthelper.screenPosToWorldPos(GamepadController.instance:getMousePosition(), CameraMgr.instance:getMainCamera(), uv0), slot0._scale) or nil
	end

	PinballController.instance:dispatchEvent(PinballEvent.OnClickBuilding, slot3 or 0)
end

function slot0._beginDrag(slot0, slot1, slot2)
	slot0._isDrag = true
end

function slot0._endDrag(slot0, slot1, slot2)
	slot0._isDrag = false
end

function slot0._onDrag(slot0, slot1, slot2)
	if not slot0._targetPos then
		return
	end

	if UnityEngine.Input.touchCount > 1 then
		return
	end

	slot3 = CameraMgr.instance:getMainCamera()
	slot6 = SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(slot2.position, slot3, uv0) - SLFramework.UGUI.RectTrHelper.ScreenPosToWorldPos(slot2.position - slot2.delta, slot3, uv0)
	slot6.z = 0

	slot0:setScenePosSafety(slot0._targetPos:Add(slot6))
end

function slot0.setScenePosSafety(slot0, slot1)
	if not slot0._mapMinX then
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

	slot0._targetPos = slot1
	slot0._sceneTrans.localPosition = slot1
end

function slot0.getScenePath(slot0)
	return "scenes/v2a4_m_s12_ttsz_jshd/scenes_prefab/v2a4_m_s12_ttsz_jshd_p.prefab"
end

function slot0.onClose(slot0)
	uv0.super.onClose(slot0)

	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end
end

return slot0
