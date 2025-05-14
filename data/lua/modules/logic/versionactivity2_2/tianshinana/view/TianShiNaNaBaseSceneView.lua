module("modules.logic.versionactivity2_2.tianshinana.view.TianShiNaNaBaseSceneView", package.seeall)

local var_0_0 = class("TianShiNaNaBaseSceneView", BaseView)

function var_0_0.onOpen(arg_1_0)
	local var_1_0 = CameraMgr.instance:getSceneRoot()

	arg_1_0._sceneRoot = UnityEngine.GameObject.New(arg_1_0.__cname)

	gohelper.setActive(arg_1_0._sceneRoot, false)

	arg_1_0.isLoading = true

	arg_1_0:beforeLoadScene()
	gohelper.addChild(var_1_0, arg_1_0._sceneRoot)

	arg_1_0._loader = PrefabInstantiate.Create(arg_1_0._sceneRoot)

	transformhelper.setLocalPos(arg_1_0._sceneRoot.transform, 0, 5, 0)
	MainCameraMgr.instance:addView(arg_1_0.viewName, arg_1_0._initCamera, nil, arg_1_0)
	arg_1_0._loader:startLoad(arg_1_0:getScenePath(), arg_1_0._onSceneLoadEnd, arg_1_0)
end

function var_0_0.beforeLoadScene(arg_2_0)
	return
end

function var_0_0.getScenePath(arg_3_0)
	return ""
end

function var_0_0._onSceneLoadEnd(arg_4_0)
	local var_4_0 = arg_4_0._loader:getInstGO()

	var_4_0.name = "Scene"

	transformhelper.setLocalPos(var_4_0.transform, 0, 0, 10)
	arg_4_0:onSceneLoaded(var_4_0)

	arg_4_0.isLoading = false

	gohelper.setActive(arg_4_0._sceneRoot, not arg_4_0._isHide)
end

function var_0_0.onSceneLoaded(arg_5_0, arg_5_1)
	return
end

function var_0_0._initCamera(arg_6_0)
	local var_6_0 = CameraMgr.instance:getMainCamera()
	local var_6_1 = GameUtil.getAdapterScale(true)

	var_6_0.orthographic = true
	var_6_0.orthographicSize = 7 * var_6_1
end

function var_0_0.setSceneVisible(arg_7_0, arg_7_1)
	arg_7_0._isHide = not arg_7_1

	gohelper.setActive(arg_7_0._sceneRoot, arg_7_1 and not arg_7_0.isLoading)
end

function var_0_0.onDestroyView(arg_8_0)
	if arg_8_0._loader then
		arg_8_0._loader:dispose()

		arg_8_0._loader = nil
	end

	if arg_8_0._sceneRoot then
		gohelper.destroy(arg_8_0._sceneRoot)

		arg_8_0._sceneRoot = nil
	end
end

return var_0_0
