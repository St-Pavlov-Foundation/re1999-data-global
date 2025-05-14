module("modules.logic.versionactivity1_9.fairyland.view.FairyLandScene", package.seeall)

local var_0_0 = class("FairyLandScene", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.seasonCameraLocalPos = Vector3(0, 0, -3.9)
	arg_1_0.seasonCameraOrthographicSize = 5
	arg_1_0.focusCameraOrthographicSize = 2
	arg_1_0.focusTime = 0.45
	arg_1_0.cancelFocusTime = 0.45
	arg_1_0.goRoot = gohelper.findChild(arg_1_0.viewGO, "main/#go_Root")
	arg_1_0.rootTrs = arg_1_0.goRoot.transform
	arg_1_0.stopUpdatePos = false

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(FairyLandController.instance, FairyLandEvent.SetSceneUpdatePos, arg_2_0.onSetSceneUpdatePos, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._camera = CameraMgr.instance:getMainCamera()

	arg_4_0:_initSceneRootNode()
end

function var_0_0.initCamera(arg_5_0)
	transformhelper.setLocalPos(arg_5_0._camera.transform, 0, 0, -10)

	arg_5_0._camera.orthographic = true
	arg_5_0._camera.orthographicSize = 6.5
end

function var_0_0._initSceneRootNode(arg_6_0)
	local var_6_0 = arg_6_0._camera.transform.parent
	local var_6_1 = CameraMgr.instance:getSceneRoot()

	arg_6_0._sceneRoot = UnityEngine.GameObject.New("FairyLandScene")

	local var_6_2, var_6_3, var_6_4 = transformhelper.getLocalPos(var_6_0)

	transformhelper.setLocalPos(arg_6_0._sceneRoot.transform, 0, var_6_3, 0)
	gohelper.addChild(var_6_1, arg_6_0._sceneRoot)
	arg_6_0:setSceneVisible(arg_6_0.isVisible or true)
end

function var_0_0._loadScene(arg_7_0)
	if arg_7_0._sceneGo then
		return
	end

	local var_7_0 = arg_7_0.viewContainer:getSetting().otherRes.scene

	arg_7_0._sceneGo = arg_7_0.viewContainer:getResInst(var_7_0, arg_7_0._sceneRoot)
	arg_7_0._rootGo = gohelper.findChild(arg_7_0._sceneGo, "root")
	arg_7_0._bgRoot = gohelper.findChild(arg_7_0._sceneGo, "root/BackGround").transform
	arg_7_0._bgGo = gohelper.findChild(arg_7_0._sceneGo, "root/BackGround/m_s08_hddt_background")

	local var_7_1 = arg_7_0._bgGo:GetComponent(typeof(UnityEngine.MeshRenderer)).bounds:GetSize()

	arg_7_0.bgX = var_7_1.x
	arg_7_0.bgY = var_7_1.y

	gohelper.setActive(arg_7_0._bgGo, false)
	arg_7_0:_loadSceneFinish()
end

function var_0_0._loadSceneFinish(arg_8_0)
	LateUpdateBeat:Add(arg_8_0._forceUpdatePos, arg_8_0)
	arg_8_0:updateNineBg()
	MainCameraMgr.instance:addView(ViewName.FairyLandView, arg_8_0.autoInitMainViewCamera, nil, arg_8_0)

	local var_8_0 = FairyLandModel.instance:caleCurStairPos()

	FairyLandModel.instance:setPos(var_8_0)
	FairyLandController.instance:dispatchEvent(FairyLandEvent.SceneLoadFinish)
end

function var_0_0.autoInitMainViewCamera(arg_9_0)
	arg_9_0:initCamera()
end

function var_0_0.onSetSceneUpdatePos(arg_10_0, arg_10_1)
	arg_10_0.stopUpdatePos = arg_10_1
end

function var_0_0.onOpen(arg_11_0)
	arg_11_0:_loadScene()
end

function var_0_0._forceUpdatePos(arg_12_0)
	if arg_12_0.stopUpdatePos then
		return
	end

	arg_12_0:updateBgRootPos()
end

function var_0_0.updateBgRootPos(arg_13_0)
	local var_13_0 = recthelper.uiPosToScreenPos(arg_13_0.rootTrs)

	if arg_13_0.lastScreenPosX and math.abs(arg_13_0.lastScreenPosX - var_13_0.x) < 0.1 then
		return
	end

	arg_13_0.lastScreenPosX = var_13_0.x

	local var_13_1, var_13_2 = recthelper.screenPosToWorldPos3(var_13_0, nil, arg_13_0._rootGo.transform.position)
	local var_13_3 = var_13_1 % arg_13_0.bgX
	local var_13_4 = var_13_2 % arg_13_0.bgY

	transformhelper.setLocalPos(arg_13_0._bgRoot, var_13_3 - 2, var_13_4, 0)
end

function var_0_0.updateNineBg(arg_14_0)
	if not arg_14_0.bgList then
		arg_14_0.bgList = {}
	end

	for iter_14_0 = 0, 8 do
		arg_14_0:setBgPos(iter_14_0)
	end
end

function var_0_0.caleBgPos(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_1 % 3
	local var_15_1 = math.floor(arg_15_1 / 3)
	local var_15_2 = (var_15_0 - 1) * arg_15_0.bgX
	local var_15_3 = (var_15_1 - 1) * arg_15_0.bgY

	return var_15_2, var_15_3
end

function var_0_0.setBgPos(arg_16_0, arg_16_1)
	local var_16_0, var_16_1 = arg_16_0:caleBgPos(arg_16_1)
	local var_16_2 = arg_16_0:getBg(arg_16_1)

	transformhelper.setLocalPosXY(var_16_2, var_16_0, var_16_1)
end

function var_0_0.getBg(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.bgList[arg_17_1]

	if not var_17_0 then
		local var_17_1 = gohelper.clone(arg_17_0._bgGo, arg_17_0._bgRoot.gameObject, tostring(arg_17_1))

		gohelper.setActive(var_17_1, true)

		var_17_0 = var_17_1.transform
		arg_17_0.bgList[arg_17_1] = var_17_0
	end

	return var_17_0
end

function var_0_0.onClose(arg_18_0)
	LateUpdateBeat:Remove(arg_18_0._forceUpdatePos, arg_18_0)
end

function var_0_0.setSceneVisible(arg_19_0, arg_19_1)
	if arg_19_1 == arg_19_0.isVisible then
		return
	end

	arg_19_0.isVisible = arg_19_1

	gohelper.setActive(arg_19_0._sceneRoot, arg_19_1 and true or false)
end

function var_0_0.onDestroyView(arg_20_0)
	gohelper.destroy(arg_20_0._sceneRoot)

	if arg_20_0._mapLoader then
		arg_20_0._mapLoader:dispose()

		arg_20_0._mapLoader = nil
	end
end

return var_0_0
