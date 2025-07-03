module("modules.logic.versionactivity2_7.coopergarland.view.CooperGarlandGameScene", package.seeall)

local var_0_0 = class("CooperGarlandGameScene", BaseView)
local var_0_1 = 0.83
local var_0_2 = 1.8

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(CooperGarlandController.instance, CooperGarlandEvent.ChangePanelAngle, arg_2_0._onChangePanelAngle, arg_2_0)
	arg_2_0:addEventCb(CooperGarlandController.instance, CooperGarlandEvent.PlayEnterNextRoundAnim, arg_2_0._onPlayEnterNextRoundAnim, arg_2_0)
	arg_2_0:addEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnRemoveModeChange, arg_2_0._onRemoveModeChange, arg_2_0)
	arg_2_0:addEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnResetGame, arg_2_0._onResetGame, arg_2_0)
	arg_2_0:addEventCb(GuideController.instance, GuideEvent.FinishGuide, arg_2_0._onFinishGuide, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	if arg_3_0._panelAnimEvent then
		arg_3_0._panelAnimEvent:RemoveEventListener("panelIn")
	end

	if arg_3_0._sceneAnimEvent then
		arg_3_0._sceneAnimEvent:RemoveEventListener("showBall")
	end

	arg_3_0:removeEventCb(CooperGarlandController.instance, CooperGarlandEvent.ChangePanelAngle, arg_3_0._onChangePanelAngle, arg_3_0)
	arg_3_0:removeEventCb(CooperGarlandController.instance, CooperGarlandEvent.PlayEnterNextRoundAnim, arg_3_0._onPlayEnterNextRoundAnim, arg_3_0)
	arg_3_0:removeEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnRemoveModeChange, arg_3_0._onRemoveModeChange, arg_3_0)
	arg_3_0:removeEventCb(CooperGarlandController.instance, CooperGarlandEvent.OnResetGame, arg_3_0._onResetGame, arg_3_0)
	arg_3_0:removeEventCb(GuideController.instance, GuideEvent.FinishGuide, arg_3_0._onFinishGuide, arg_3_0)
end

function var_0_0._onChangePanelAngle(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	if gohelper.isNil(arg_4_0._transCube) then
		return
	end

	local var_4_0 = GuideModel.instance:isDoingClickGuide()
	local var_4_1 = GuideController.instance:isForbidGuides()
	local var_4_2 = var_4_0 and not var_4_1
	local var_4_3 = CooperGarlandGameModel.instance:getIsStopGame()
	local var_4_4 = CooperGarlandGameModel.instance:getSceneOpenAnimShowBall()

	if not arg_4_4 and (var_4_3 or var_4_2 or not var_4_4) then
		return
	end

	local var_4_5 = arg_4_2 * arg_4_0._cubeMaxAngle
	local var_4_6 = -arg_4_1 * arg_4_0._cubeMaxAngle

	TaskDispatcher.cancelTask(arg_4_0._lerpRotation, arg_4_0)

	if arg_4_3 and arg_4_3 > 0 then
		arg_4_0._targetLerpAngle = {
			x = var_4_5,
			y = var_4_6,
			lerpScale = arg_4_3
		}

		TaskDispatcher.runRepeat(arg_4_0._lerpRotation, arg_4_0, 0.01)
	else
		transformhelper.setLocalRotation(arg_4_0._transCube, var_4_5, var_4_6, 0)
	end
end

function var_0_0._lerpRotation(arg_5_0)
	local var_5_0, var_5_1 = transformhelper.getLocalRotation(arg_5_0._transCube)
	local var_5_2 = arg_5_0._targetLerpAngle and arg_5_0._targetLerpAngle.x
	local var_5_3 = arg_5_0._targetLerpAngle and arg_5_0._targetLerpAngle.y

	if not arg_5_0._targetLerpAngle or var_5_0 == var_5_2 and var_5_1 == var_5_3 then
		arg_5_0._targetLerpAngle = nil

		TaskDispatcher.cancelTask(arg_5_0._lerpRotation, arg_5_0)

		return
	end

	transformhelper.setLocalRotationLerp(arg_5_0._transCube, var_5_2, var_5_3, 0, Time.deltaTime * arg_5_0._targetLerpAngle.lerpScale)
end

function var_0_0._onPlayEnterNextRoundAnim(arg_6_0)
	local var_6_0 = false

	if arg_6_0._sceneAnimator then
		arg_6_0._sceneAnimator:Play("switch", 0, 0)

		var_6_0 = true

		AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.play_ui_pkls_star_light)
	end

	local var_6_1 = CooperGarlandGameModel.instance:getGameId()
	local var_6_2 = CooperGarlandConfig.instance:getCubeSwitchAnim(var_6_1)

	if not string.nilorempty(var_6_2) and arg_6_0._cubeAnimator and arg_6_0._cubeAnimatorPlayer then
		TaskDispatcher.cancelTask(arg_6_0._playCubeSwitchAnim, arg_6_0)
		TaskDispatcher.runDelay(arg_6_0._playCubeSwitchAnim, arg_6_0, var_0_1)

		var_6_0 = true
	end

	if var_6_0 then
		TaskDispatcher.cancelTask(CooperGarlandController.enterNextRound, CooperGarlandController.instance)
		TaskDispatcher.runDelay(CooperGarlandController.enterNextRound, CooperGarlandController.instance, var_0_2)
	else
		CooperGarlandController.instance:enterNextRound()
	end

	arg_6_0:refresh()
end

function var_0_0._playCubeSwitchAnim(arg_7_0)
	local var_7_0 = CooperGarlandGameModel.instance:getGameId()
	local var_7_1 = CooperGarlandConfig.instance:getCubeSwitchAnim(var_7_0)

	arg_7_0._cubeAnimator.enabled = true

	AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.play_ui_yuzhou_cube_turn)
	arg_7_0._cubeAnimatorPlayer:Play(var_7_1, arg_7_0._playCubeAnimFinished, arg_7_0)
end

function var_0_0._onRemoveModeChange(arg_8_0)
	arg_8_0:refresh()
end

function var_0_0._onResetGame(arg_9_0)
	arg_9_0:refresh()
end

function var_0_0._onFinishGuide(arg_10_0, arg_10_1)
	local var_10_0 = CooperGarlandGameModel.instance:getMapId()
	local var_10_1 = CooperGarlandConfig.instance:getStoryCompId(var_10_0, arg_10_1)

	if var_10_1 then
		CooperGarlandGameEntityMgr.instance:removeComp(var_10_1)
		CooperGarlandController.instance:setStopGame(false)
	end
end

function var_0_0._editableInitView(arg_11_0)
	arg_11_0._targetLerpAngle = nil
	arg_11_0._originalFOV = nil
	arg_11_0._cubeMaxAngle = CooperGarlandConfig.instance:getAct192Const(CooperGarlandEnum.ConstId.CubeMaxAngle, true)
	arg_11_0._originalGravity = UnityEngine.Physics.gravity

	local var_11_0 = CooperGarlandConfig.instance:getAct192Const(CooperGarlandEnum.ConstId.Gravity, true)

	UnityEngine.Physics.gravity = Vector3.New(0, 0, var_11_0)

	arg_11_0:createScene()
	MainCameraMgr.instance:addView(arg_11_0.viewName, arg_11_0.initCamera, nil, arg_11_0)
end

function var_0_0.initCamera(arg_12_0)
	local var_12_0 = CameraMgr.instance:getMainCamera()
	local var_12_1 = CameraMgr.instance:getMainCameraTrs()

	if not arg_12_0._originalFOV then
		arg_12_0._originalFOV = var_12_0.fieldOfView
	end

	local var_12_2 = CooperGarlandConfig.instance:getAct192Const(CooperGarlandEnum.ConstId.CameraFOV, true)
	local var_12_3 = 1.7777777777777777 * (UnityEngine.Screen.height / UnityEngine.Screen.width)

	var_12_0.fieldOfView = Mathf.Clamp(var_12_2 * var_12_3, var_12_2, CooperGarlandEnum.Const.CameraMaxFov)

	local var_12_4 = CooperGarlandConfig.instance:getAct192Const(CooperGarlandEnum.ConstId.CameraPosZ, true)

	transformhelper.setLocalPos(var_12_1, 0, 0, var_12_4)
	transformhelper.setLocalRotation(var_12_1, 0, 0, 0)
end

function var_0_0.createScene(arg_13_0)
	local var_13_0 = CameraMgr.instance:getSceneRoot()

	arg_13_0._sceneRoot = UnityEngine.GameObject.New(arg_13_0.__cname)

	gohelper.addChild(var_13_0, arg_13_0._sceneRoot)

	local var_13_1 = CameraMgr.instance:getMainCameraTrs().parent
	local var_13_2, var_13_3, var_13_4 = transformhelper.getLocalPos(var_13_1)

	transformhelper.setLocalPos(arg_13_0._sceneRoot.transform, 0, var_13_3, 0)

	if arg_13_0._loader then
		arg_13_0._loader:dispose()
	end

	arg_13_0._loader = PrefabInstantiate.Create(arg_13_0._sceneRoot)

	local var_13_5 = CooperGarlandGameModel.instance:getGameId()
	local var_13_6 = CooperGarlandConfig.instance:getScenePath(var_13_5)

	if not string.nilorempty(var_13_6) then
		UIBlockMgr.instance:startBlock(CooperGarlandEnum.BlockKey.LoadGameSceneRes)
		arg_13_0._loader:startLoad(var_13_6, arg_13_0._onLoadSceneFinish, arg_13_0)
	end
end

function var_0_0._onLoadSceneFinish(arg_14_0)
	UIBlockMgr.instance:endBlock(CooperGarlandEnum.BlockKey.LoadGameSceneRes)

	if not arg_14_0._loader then
		return
	end

	arg_14_0._sceneGo = arg_14_0._loader:getInstGO()
	arg_14_0._sceneAnimator = arg_14_0._sceneGo:GetComponent(typeof(UnityEngine.Animator))
	arg_14_0._sceneAnimEvent = arg_14_0._sceneGo:GetComponent(gohelper.Type_AnimationEventWrap)

	arg_14_0._sceneAnimEvent:AddEventListener("showBall", arg_14_0._onShowBall, arg_14_0)

	arg_14_0._cubeGo = gohelper.findChild(arg_14_0._sceneGo, "#go_cube")
	arg_14_0._transCube = arg_14_0._cubeGo.transform
	arg_14_0._cubeAnimator = arg_14_0._cubeGo:GetComponent(typeof(UnityEngine.Animator))
	arg_14_0._cubeAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_14_0._cubeGo)

	local var_14_0 = CooperGarlandConfig.instance:getAct192Const(CooperGarlandEnum.ConstId.CubePos)
	local var_14_1 = string.splitToNumber(var_14_0, "#")

	transformhelper.setLocalPos(arg_14_0._transCube, var_14_1[1], var_14_1[2], var_14_1[3])

	arg_14_0._uiNode = gohelper.findChild(arg_14_0._sceneGo, "#go_cube/#go_ui")

	local var_14_2 = gohelper.findChild(arg_14_0._sceneGo, "#go_cube/#go_ball")

	CooperGarlandGameEntityMgr.instance:tryInitMap(arg_14_0._uiNode, var_14_2, arg_14_0._onInitMap, arg_14_0)

	local var_14_3 = "open"
	local var_14_4 = CooperGarlandGameModel.instance:getGameId()
	local var_14_5 = CooperGarlandConfig.instance:getCubeOpenAnim(var_14_4)

	if arg_14_0._cubeAnimatorPlayer and arg_14_0._cubeAnimator then
		if string.nilorempty(var_14_5) then
			arg_14_0:_playCubeAnimFinished()
		else
			var_14_3 = "open1"

			AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.play_ui_yuzhou_cube_turn)
			arg_14_0._cubeAnimatorPlayer:Play(var_14_5, arg_14_0._playCubeAnimFinished, arg_14_0)
		end
	end

	if arg_14_0._sceneAnimator then
		arg_14_0._sceneAnimator:Play(var_14_3, 0, 0)
	end
end

function var_0_0._onInitMap(arg_15_0)
	local var_15_0 = CooperGarlandGameEntityMgr.instance:getPanelGo()

	if gohelper.isNil(var_15_0) then
		return
	end

	arg_15_0._panelCanvas = var_15_0:GetComponent(typeof(UnityEngine.Canvas))

	local var_15_1 = CameraMgr.instance:getMainCamera()

	if var_15_1 then
		arg_15_0._panelCanvas.worldCamera = var_15_1
	end

	arg_15_0._simgPanel = gohelper.findChildSingleImage(var_15_0, "")

	if arg_15_0._simgPanel then
		local var_15_2 = CooperGarlandGameModel.instance:getGameId()
		local var_15_3 = CooperGarlandConfig.instance:getPanelImage(var_15_2)

		arg_15_0._simgPanel:LoadImage(var_15_3)
	end

	arg_15_0._goRemoveModeMask = gohelper.findChild(var_15_0, "#go_removeModeMask")
	arg_15_0._panelAnimEvent = var_15_0:GetComponent(gohelper.Type_AnimationEventWrap)

	arg_15_0._panelAnimEvent:AddEventListener("panelIn", arg_15_0._onPanelIn, arg_15_0)
	arg_15_0:refresh()
end

function var_0_0._playCubeAnimFinished(arg_16_0)
	if arg_16_0._cubeAnimator then
		arg_16_0._cubeAnimator.enabled = false
	end
end

function var_0_0._onPanelIn(arg_17_0)
	AudioMgr.instance:trigger(AudioEnum2_7.CooperGarland.play_ui_yuzhou_level_next)
end

function var_0_0._onShowBall(arg_18_0)
	CooperGarlandGameModel.instance:setSceneOpenAnimShowBall(true)
	CooperGarlandGameEntityMgr.instance:resetBall()
end

function var_0_0.onUpdateParam(arg_19_0)
	return
end

function var_0_0.onOpen(arg_20_0)
	return
end

function var_0_0.refresh(arg_21_0)
	arg_21_0:refreshRemoveModeMask()
end

function var_0_0.refreshRemoveModeMask(arg_22_0)
	local var_22_0 = CooperGarlandGameModel.instance:getIsRemoveMode()

	gohelper.setActive(arg_22_0._goRemoveModeMask, var_22_0)
end

function var_0_0.onClose(arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._lerpRotation, arg_23_0)
	TaskDispatcher.cancelTask(arg_23_0._playCubeSwitchAnim, arg_23_0)
	TaskDispatcher.cancelTask(CooperGarlandController.enterNextRound, CooperGarlandController.instance)
end

function var_0_0.onDestroyView(arg_24_0)
	if arg_24_0._loader then
		arg_24_0._loader:dispose()

		arg_24_0._loader = nil
	end

	if arg_24_0._simgPanel then
		arg_24_0._simgPanel:UnLoadImage()
	end

	if arg_24_0._sceneRoot then
		gohelper.destroy(arg_24_0._sceneRoot)

		arg_24_0._sceneRoot = nil
	end

	arg_24_0:resetCamera()

	UnityEngine.Physics.gravity = arg_24_0._originalGravity
	arg_24_0._originalGravity = nil

	UIBlockMgr.instance:endBlock(CooperGarlandEnum.BlockKey.LoadGameSceneRes)
end

local var_0_3 = 35

function var_0_0.resetCamera(arg_25_0)
	local var_25_0 = CameraMgr.instance:getMainCamera()
	local var_25_1 = CameraMgr.instance:getMainCameraTrs()

	var_25_0.fieldOfView = arg_25_0._originalFOV or var_0_3

	transformhelper.setLocalPos(var_25_1, 0, 0, 0)

	arg_25_0._originalFOV = nil
end

return var_0_0
