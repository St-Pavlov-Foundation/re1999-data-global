module("modules.logic.story.view.StorySceneView", package.seeall)

local var_0_0 = class("StorySceneView", BaseView)

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
	arg_4_0._cameraComp = GameSceneMgr.instance:getCurScene().camera
	arg_4_0._sceneRoot = CameraMgr.instance:getSceneRoot()
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:_initScene()
end

function var_0_0.onClose(arg_6_0)
	arg_6_0:_disposeScene()
end

function var_0_0._initScene(arg_7_0)
	local var_7_0 = arg_7_0.viewParam.levelId
	local var_7_1 = lua_scene_level.configDict[var_7_0]

	arg_7_0._sceneContainer = gohelper.create3d(arg_7_0._sceneRoot, "StoryScene")

	if not var_7_1 then
		return
	end

	local var_7_2 = ResUrl.getSceneUrl(var_7_1.resName)

	arg_7_0._sceneLoader = MultiAbLoader.New()

	arg_7_0._sceneLoader:addPath(var_7_2)
	arg_7_0._sceneLoader:startLoad(function(arg_8_0)
		arg_7_0._assetItem = arg_8_0:getAssetItem(var_7_2)

		if not arg_7_0._assetItem then
			return
		end

		arg_7_0._assetItem:Retain()

		local var_8_0 = arg_7_0._assetItem:GetResource(var_7_2)
		local var_8_1 = gohelper.clone(var_8_0, arg_7_0._sceneContainer, var_7_1.resName)

		if var_7_0 == 10101 then
			local var_8_2 = arg_7_0.viewContainer:getStoryMainSceneView()

			if var_8_2 then
				var_8_2:setSceneId(1)
				var_8_2:initSceneGo(var_8_1, var_7_1.resName)
			end
		end
	end)

	local var_7_3 = lua_camera.configDict[var_7_1.cameraId]

	arg_7_0._cameraComp:setCameraTraceEnable(true)
	arg_7_0._cameraComp:resetParam(var_7_3)
	arg_7_0._cameraComp:applyDirectly()
	arg_7_0._cameraComp:setCameraTraceEnable(false)
	PostProcessingMgr.instance:setLocalBloomColor(Color.New(var_7_1.bloomR, var_7_1.bloomG, var_7_1.bloomB, var_7_1.bloomA))
end

function var_0_0._disposeScene(arg_9_0)
	if arg_9_0._sceneContainer then
		gohelper.destroy(arg_9_0._sceneContainer)

		arg_9_0._sceneContainer = nil
	end

	if arg_9_0._assetItem then
		arg_9_0._assetItem:Release()

		arg_9_0._assetItem = nil
	end

	if arg_9_0._sceneLoader then
		arg_9_0._sceneLoader:dispose()

		arg_9_0._sceneLoader = nil
	end

	arg_9_0._cameraComp:setCameraTraceEnable(true)
	arg_9_0._cameraComp:resetParam()
	arg_9_0._cameraComp:applyDirectly()
	arg_9_0._cameraComp:setCameraTraceEnable(false)

	local var_9_0 = GameSceneMgr.instance:getCurLevelId()
	local var_9_1 = lua_scene_level.configDict[var_9_0]

	PostProcessingMgr.instance:setLocalBloomColor(Color.New(var_9_1.bloomR, var_9_1.bloomG, var_9_1.bloomB, var_9_1.bloomA))
end

return var_0_0
