module("modules.logic.versionactivity2_2.eliminate.view.map.EliminateMapSceneView", package.seeall)

local var_0_0 = class("EliminateMapSceneView", BaseView)

function var_0_0.onOpen(arg_1_0)
	arg_1_0._oldSceneResList = arg_1_0:getUserDataTb_()

	arg_1_0:addEventCb(EliminateMapController.instance, EliminateMapEvent.OnSelectChapterChange, arg_1_0.onSelectChapterChange, arg_1_0)
	arg_1_0:_initSceneRoot()
	arg_1_0:_loadScene()
end

function var_0_0._initSceneRoot(arg_2_0)
	local var_2_0 = CameraMgr.instance:getSceneRoot()

	arg_2_0._sceneRoot = UnityEngine.GameObject.New(arg_2_0.__cname)

	gohelper.addChild(var_2_0, arg_2_0._sceneRoot)

	local var_2_1 = CameraMgr.instance:getMainCameraTrs().parent
	local var_2_2, var_2_3, var_2_4 = transformhelper.getLocalPos(var_2_1)

	transformhelper.setLocalPos(arg_2_0._sceneRoot.transform, 0, var_2_3, 0)
end

function var_0_0.onSelectChapterChange(arg_3_0)
	arg_3_0:_loadScene()
end

function var_0_0._loadScene(arg_4_0)
	arg_4_0.chapterId = arg_4_0.viewContainer.chapterId

	local var_4_0 = UnityEngine.GameObject.New(tostring(arg_4_0.chapterId))

	gohelper.addChild(arg_4_0._sceneRoot, var_4_0)
	table.insert(arg_4_0._oldSceneResList, arg_4_0._chapterRoot)

	arg_4_0._chapterRoot = var_4_0
	arg_4_0._loader = PrefabInstantiate.Create(var_4_0)

	MainCameraMgr.instance:addView(arg_4_0.viewName, arg_4_0._initCamera, nil, arg_4_0)
	arg_4_0._loader:startLoad(arg_4_0:getScenePath(), arg_4_0._onSceneLoadEnd, arg_4_0)
end

function var_0_0.getScenePath(arg_5_0)
	return lua_eliminate_chapter.configDict[arg_5_0.chapterId].map
end

function var_0_0._onSceneLoadEnd(arg_6_0, arg_6_1)
	if arg_6_1 ~= arg_6_0._loader then
		return
	end

	local var_6_0 = arg_6_0._loader:getInstGO()

	var_6_0.name = "Scene"

	transformhelper.setLocalPos(var_6_0.transform, 0, 0, 5)
	arg_6_0:_disposeOldRes()
end

function var_0_0._disposeOldRes(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0._oldSceneResList) do
		gohelper.destroy(iter_7_1)
	end

	arg_7_0._oldSceneResList = arg_7_0:getUserDataTb_()
end

function var_0_0._initCamera(arg_8_0)
	local var_8_0 = CameraMgr.instance:getMainCamera()
	local var_8_1 = GameUtil.getAdapterScale(true)

	var_8_0.orthographic = true
	var_8_0.orthographicSize = 5 * var_8_1
end

function var_0_0.setSceneVisible(arg_9_0, arg_9_1)
	arg_9_0._sceneVisible = arg_9_1

	gohelper.setActive(arg_9_0._sceneRoot, arg_9_1)
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0:_disposeOldRes()

	if arg_10_0._loader then
		arg_10_0._loader:dispose()

		arg_10_0._loader = nil
	end

	if arg_10_0._sceneRoot then
		gohelper.destroy(arg_10_0._sceneRoot)

		arg_10_0._sceneRoot = nil
	end
end

return var_0_0
