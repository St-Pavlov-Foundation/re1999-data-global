module("modules.logic.versionactivity1_9.fairyland.view.FairyLandScene", package.seeall)

slot0 = class("FairyLandScene", BaseView)

function slot0.onInitView(slot0)
	slot0.seasonCameraLocalPos = Vector3(0, 0, -3.9)
	slot0.seasonCameraOrthographicSize = 5
	slot0.focusCameraOrthographicSize = 2
	slot0.focusTime = 0.45
	slot0.cancelFocusTime = 0.45
	slot0.goRoot = gohelper.findChild(slot0.viewGO, "main/#go_Root")
	slot0.rootTrs = slot0.goRoot.transform
	slot0.stopUpdatePos = false

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(FairyLandController.instance, FairyLandEvent.SetSceneUpdatePos, slot0.onSetSceneUpdatePos, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._camera = CameraMgr.instance:getMainCamera()

	slot0:_initSceneRootNode()
end

function slot0.initCamera(slot0)
	transformhelper.setLocalPos(slot0._camera.transform, 0, 0, -10)

	slot0._camera.orthographic = true
	slot0._camera.orthographicSize = 6.5
end

function slot0._initSceneRootNode(slot0)
	slot0._sceneRoot = UnityEngine.GameObject.New("FairyLandScene")
	slot3, slot4, slot5 = transformhelper.getLocalPos(slot0._camera.transform.parent)

	transformhelper.setLocalPos(slot0._sceneRoot.transform, 0, slot4, 0)
	gohelper.addChild(CameraMgr.instance:getSceneRoot(), slot0._sceneRoot)
	slot0:setSceneVisible(slot0.isVisible or true)
end

function slot0._loadScene(slot0)
	if slot0._sceneGo then
		return
	end

	slot0._sceneGo = slot0.viewContainer:getResInst(slot0.viewContainer:getSetting().otherRes.scene, slot0._sceneRoot)
	slot0._rootGo = gohelper.findChild(slot0._sceneGo, "root")
	slot0._bgRoot = gohelper.findChild(slot0._sceneGo, "root/BackGround").transform
	slot0._bgGo = gohelper.findChild(slot0._sceneGo, "root/BackGround/m_s08_hddt_background")
	slot6 = slot0._bgGo:GetComponent(typeof(UnityEngine.MeshRenderer)).bounds:GetSize()
	slot0.bgX = slot6.x
	slot0.bgY = slot6.y

	gohelper.setActive(slot0._bgGo, false)
	slot0:_loadSceneFinish()
end

function slot0._loadSceneFinish(slot0)
	LateUpdateBeat:Add(slot0._forceUpdatePos, slot0)
	slot0:updateNineBg()
	MainCameraMgr.instance:addView(ViewName.FairyLandView, slot0.autoInitMainViewCamera, nil, slot0)
	FairyLandModel.instance:setPos(FairyLandModel.instance:caleCurStairPos())
	FairyLandController.instance:dispatchEvent(FairyLandEvent.SceneLoadFinish)
end

function slot0.autoInitMainViewCamera(slot0)
	slot0:initCamera()
end

function slot0.onSetSceneUpdatePos(slot0, slot1)
	slot0.stopUpdatePos = slot1
end

function slot0.onOpen(slot0)
	slot0:_loadScene()
end

function slot0._forceUpdatePos(slot0)
	if slot0.stopUpdatePos then
		return
	end

	slot0:updateBgRootPos()
end

function slot0.updateBgRootPos(slot0)
	slot1 = recthelper.uiPosToScreenPos(slot0.rootTrs)

	if slot0.lastScreenPosX and math.abs(slot0.lastScreenPosX - slot1.x) < 0.1 then
		return
	end

	slot0.lastScreenPosX = slot1.x
	slot2, slot3 = recthelper.screenPosToWorldPos3(slot1, nil, slot0._rootGo.transform.position)

	transformhelper.setLocalPos(slot0._bgRoot, slot2 % slot0.bgX - 2, slot3 % slot0.bgY, 0)
end

function slot0.updateNineBg(slot0)
	if not slot0.bgList then
		slot0.bgList = {}
	end

	for slot4 = 0, 8 do
		slot0:setBgPos(slot4)
	end
end

function slot0.caleBgPos(slot0, slot1)
	return (slot1 % 3 - 1) * slot0.bgX, (math.floor(slot1 / 3) - 1) * slot0.bgY
end

function slot0.setBgPos(slot0, slot1)
	slot2, slot3 = slot0:caleBgPos(slot1)

	transformhelper.setLocalPosXY(slot0:getBg(slot1), slot2, slot3)
end

function slot0.getBg(slot0, slot1)
	if not slot0.bgList[slot1] then
		slot3 = gohelper.clone(slot0._bgGo, slot0._bgRoot.gameObject, tostring(slot1))

		gohelper.setActive(slot3, true)

		slot0.bgList[slot1] = slot3.transform
	end

	return slot2
end

function slot0.onClose(slot0)
	LateUpdateBeat:Remove(slot0._forceUpdatePos, slot0)
end

function slot0.setSceneVisible(slot0, slot1)
	if slot1 == slot0.isVisible then
		return
	end

	slot0.isVisible = slot1

	gohelper.setActive(slot0._sceneRoot, slot1 and true or false)
end

function slot0.onDestroyView(slot0)
	gohelper.destroy(slot0._sceneRoot)

	if slot0._mapLoader then
		slot0._mapLoader:dispose()

		slot0._mapLoader = nil
	end
end

return slot0
