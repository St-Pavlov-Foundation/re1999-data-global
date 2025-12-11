module("modules.logic.scene.survival.comp.SurvivalSceneCameraComp", package.seeall)

local var_0_0 = class("SurvivalSceneCameraComp", CommonSceneCameraComp)

function var_0_0.onInit(arg_1_0)
	arg_1_0._scene = arg_1_0:getCurScene()
	arg_1_0._rawcameraTrace = CameraMgr.instance:getCameraTrace()
	arg_1_0._cameraTrace = arg_1_0._rawcameraTrace
	arg_1_0._cameraCO = nil
end

function var_0_0._onScreenResize(arg_2_0)
	local var_2_0 = CameraMgr.instance:getFocusTrs()
	local var_2_1, var_2_2, var_2_3 = transformhelper.getPos(var_2_0)

	arg_2_0._cameraTrace:SetTargetFocusPos(var_2_1, var_2_2, var_2_3)

	if arg_2_0._nowFov then
		arg_2_0:setFov(arg_2_0._nowFov)
		arg_2_0._cameraTrace:ApplyDirectly()
	end
end

function var_0_0.onSceneStart(arg_3_0, ...)
	arg_3_0._rawcameraTrace.enabled = false
	arg_3_0._cameraTrace = gohelper.onceAddComponent(arg_3_0._rawcameraTrace, typeof(ZProj.ExploreCameraTrace))

	arg_3_0._cameraTrace:SetEaseTime(SurvivalConst.CameraTraceTime)

	arg_3_0.sceneType = GameSceneMgr.instance:getCurSceneType()

	if arg_3_0.sceneType == SceneType.SurvivalShelter then
		local var_3_0 = SurvivalConfig.instance:getShelterMapCo()

		arg_3_0.mapMinX = var_3_0.minX + 2
		arg_3_0.mapMaxX = var_3_0.maxX - 2
		arg_3_0.mapMinY = var_3_0.minY
		arg_3_0.mapMaxY = var_3_0.maxY - 2
		arg_3_0.maxDis = 10
		arg_3_0.minDis = 4.5
		arg_3_0._mapMaxPitch = 60
		arg_3_0._mapMinPitch = 45
	elseif arg_3_0.sceneType == SceneType.Survival then
		local var_3_1 = SurvivalMapModel.instance:getCurMapCo()

		arg_3_0.mapMinX = var_3_1.minX
		arg_3_0.mapMaxX = var_3_1.maxX
		arg_3_0.mapMinY = var_3_1.minY
		arg_3_0.mapMaxY = var_3_1.maxY
		arg_3_0.maxDis = SurvivalConst.MapCameraParams.MaxDis
		arg_3_0.minDis = SurvivalConst.MapCameraParams.MinDis
	end

	var_0_0.super.onSceneStart(arg_3_0, ...)
end

function var_0_0.onScenePrepared(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0._cameraTrace.EnableTrace = true

	arg_4_0:checkIsInMiasma(true)

	if arg_4_0.sceneType == SceneType.SurvivalShelter then
		arg_4_0:setDistance(10)
		arg_4_0:setRotate(0, 45)

		local var_4_0 = SurvivalShelterModel.instance:getPlayerMo()
		local var_4_1 = var_4_0 and var_4_0:getPos()
		local var_4_2, var_4_3, var_4_4 = SurvivalHelper.instance:hexPointToWorldPoint(var_4_1 and var_4_1.q or 0, var_4_1 and var_4_1.r or 0)
		local var_4_5 = Vector3(var_4_2, var_4_3, var_4_4)

		arg_4_0:setFocus(var_4_5.x, var_4_5.y, var_4_5.z)
	elseif arg_4_0.sceneType == SceneType.Survival then
		local var_4_6 = SurvivalMapModel.instance.save_mapScale

		arg_4_0:setDistance(arg_4_0.maxDis - (arg_4_0.maxDis - arg_4_0.minDis) * var_4_6)

		local var_4_7 = SurvivalMapModel.instance:getSceneMo()
		local var_4_8 = Vector3(var_4_7.player:getWorldPos())

		arg_4_0:setFocus(var_4_8.x, var_4_8.y, var_4_8.z)
	elseif arg_4_0.sceneType == SceneType.SurvivalSummaryAct then
		arg_4_0:setDistance(6)
		arg_4_0:setRotate(0)
		arg_4_0:setPitchAngle(45)

		local var_4_9, var_4_10, var_4_11 = SurvivalHelper.instance:hexPointToWorldPoint(0, 0)

		arg_4_0:setFocus(var_4_9 + 0.5, var_4_10, var_4_11)
		arg_4_0:setFov(35)
	end
end

function var_0_0.setFocus(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = CameraMgr.instance:getFocusTrs()

	transformhelper.setPos(var_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0._cameraTrace:SetTargetFocusPos(arg_5_1, arg_5_2, arg_5_3)
	arg_5_0._cameraTrace:ApplyDirectly()
end

function var_0_0.setFov(arg_6_0, arg_6_1)
	local var_6_0 = 1.7777777777777777 * (UnityEngine.Screen.height / UnityEngine.Screen.width)
	local var_6_1 = math.max(var_6_0, 1)

	arg_6_0._nowFov = arg_6_1

	arg_6_0._cameraTrace:SetTargetFov(arg_6_1 * var_6_1)
end

function var_0_0.checkIsInMiasma(arg_7_0, arg_7_1)
	local var_7_0 = SurvivalMapModel.instance:isInMiasma()

	if arg_7_1 then
		local var_7_1 = var_7_0 and math.random(5) or 0

		if var_7_1 > 2 then
			var_7_1 = var_7_1 - 6
		end

		arg_7_0:setRotate(var_7_1 * 60)
		arg_7_0._cameraTrace:ApplyDirectly()

		arg_7_0._isInMiasma = var_7_0
	elseif arg_7_0._isInMiasma ~= var_7_0 then
		arg_7_0._isInMiasma = var_7_0
	else
		return false
	end

	return true
end

function var_0_0.setRotate(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = arg_8_0._cameraCO and arg_8_0._cameraCO.pitch or 40

	arg_8_0.yaw = arg_8_1

	arg_8_0._cameraTrace:SetTargetRotate(arg_8_1, var_8_0)
end

function var_0_0.setPitchAngle(arg_9_0, arg_9_1)
	arg_9_0._cameraTrace:SetTargetRotate(arg_9_0.yaw, arg_9_1)
end

function var_0_0.onSceneClose(arg_10_0, ...)
	arg_10_0._isInMiasma = false
	arg_10_0._rawcameraTrace.enabled = true

	gohelper.destroy(arg_10_0._cameraTrace)

	arg_10_0._cameraTrace = arg_10_0._rawcameraTrace

	var_0_0.super.onSceneClose(arg_10_0, ...)
end

return var_0_0
