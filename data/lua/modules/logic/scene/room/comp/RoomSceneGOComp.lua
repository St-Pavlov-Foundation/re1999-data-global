module("modules.logic.scene.room.comp.RoomSceneGOComp", package.seeall)

local var_0_0 = class("RoomSceneGOComp", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._scene = arg_2_0:getCurScene()
	arg_2_0.sceneGO = arg_2_0._scene.level:getSceneGo()
	arg_2_0.groundGO = gohelper.findChild(arg_2_0.sceneGO, "ground")
	arg_2_0.blockRoot = gohelper.findChild(arg_2_0.sceneGO, "ground/blockRoot")
	arg_2_0.buildingRoot = gohelper.findChild(arg_2_0.sceneGO, "ground/buildingRoot")
	arg_2_0.characterRoot = gohelper.findChild(arg_2_0.sceneGO, "ground/characterRoot")
	arg_2_0.resourceRoot = gohelper.findChild(arg_2_0.sceneGO, "ground/resourceRoot")
	arg_2_0.waterRoot = gohelper.findChild(arg_2_0.sceneGO, "ground/waterRoot")
	arg_2_0.planeGO = gohelper.findChild(arg_2_0.sceneGO, "ground/plane")
	arg_2_0.ambientGO = gohelper.findChild(arg_2_0.sceneGO, "ground/ambient")
	arg_2_0.feature = gohelper.findChild(arg_2_0.sceneGO, "ground/feature")
	arg_2_0.initbuildingRoot = gohelper.findChild(arg_2_0.sceneGO, "ground/initbuildingRoot")
	arg_2_0.inventoryRootGO = gohelper.findChild(arg_2_0.sceneGO, "inventoryRoot")
	arg_2_0.canvasGO = gohelper.findChild(arg_2_0.sceneGO, "canvas")
	arg_2_0.virtualCameraGO = gohelper.findChild(arg_2_0.sceneGO, "virtualCamera")
	arg_2_0.virtualCameraXZGO = gohelper.findChild(arg_2_0.sceneGO, "virtualCameraXZ")
	arg_2_0.poolContainerGO = gohelper.findChild(arg_2_0.sceneGO, "poolContainer")
	arg_2_0.directionalLightGO = gohelper.findChild(arg_2_0.sceneGO, "lighting/Directional Light")
	arg_2_0.camerahelperGO = gohelper.findChild(arg_2_0.sceneGO, "camerahelper")
	arg_2_0.fogRoot = gohelper.findChild(arg_2_0.sceneGO, "fogRoot")
	arg_2_0.skyGO = gohelper.findChild(arg_2_0.sceneGO, "virtualCameraXZ/skybox/sky")
	arg_2_0.commonEffectRoot = gohelper.findChild(arg_2_0.sceneGO, "commonEffectRoot")
	arg_2_0.virtualCameraTrs = arg_2_0.virtualCameraGO.transform
	arg_2_0.inventoryRootTrs = arg_2_0.inventoryRootGO.transform
	arg_2_0.virtualCameraXZTrs = arg_2_0.virtualCameraXZGO.transform
	arg_2_0.directionalLightGOTrs = arg_2_0.directionalLightGO.transform
	arg_2_0.vehicleRoot = arg_2_0:_findOrCreateChild(arg_2_0.groundGO, "vehicleRoot")
	arg_2_0.critterRoot = arg_2_0:_findOrCreateChild(arg_2_0.groundGO, "critterRoot")
	arg_2_0.sceneAmbient = arg_2_0.ambientGO:GetComponent(typeof(ZProj.SceneAmbient))
	arg_2_0.sceneCulling = arg_2_0.ambientGO:GetComponent(typeof(SceneCulling))

	if SDKMgr.instance:isEmulator() then
		arg_2_0.sceneCulling.enabled = false
	end

	arg_2_0.sceneShadow = arg_2_0.ambientGO:GetComponent(typeof(SceneShadow))
	arg_2_0._effectParamList = {}
	arg_2_0.sceneAmbientData = arg_2_0.sceneAmbient.data
	arg_2_0._partGODict = {}

	for iter_2_0, iter_2_1 in ipairs(lua_production_part.configList) do
		local var_2_0 = iter_2_1.id
		local var_2_1 = gohelper.findChild(arg_2_0.initbuildingRoot, "part" .. var_2_0)

		if var_2_1 then
			arg_2_0._partGODict[var_2_0] = var_2_1
		end
	end

	if BootNativeUtil.isAndroid() then
		local var_2_2 = UnityEngine.SystemInfo.graphicsDeviceName

		arg_2_0.compatibility = string.find(var_2_2, "^Adreno") or string.find(var_2_2, "^Mali")
		arg_2_0.compatibility = arg_2_0.compatibility or SDKMgr.instance:isEmulator()
	else
		arg_2_0.compatibility = true
	end
end

function var_0_0.getPartGOById(arg_3_0, arg_3_1)
	if arg_3_0._partGODict then
		return arg_3_0._partGODict[arg_3_1]
	end
end

function var_0_0._findOrCreateChild(arg_4_0, arg_4_1, arg_4_2)
	return gohelper.findChild(arg_4_1, arg_4_2) or gohelper.create3d(arg_4_1, arg_4_2)
end

function var_0_0.setupShadowParam(arg_5_0, arg_5_1)
	if arg_5_0.shadowState ~= arg_5_1 then
		local var_5_0 = arg_5_0.sceneShadow

		if var_5_0 ~= nil then
			if arg_5_1 then
				var_5_0.overrideShadowCascadesOption = true
				var_5_0.shadowCascadesOption = UnityEngine.Rendering.Universal.ShadowCascadesOption.NoCascades
				var_5_0.overrideShadowResolution = true
				var_5_0.shadowResolution = 1600
				var_5_0.softShadow = true

				UnityEngine.Shader.EnableKeyword("_PERFORMANCE_HIGH")
				gohelper.setActive(arg_5_0.feature, false)
			else
				var_5_0.overrideShadowCascadesOption = true
				var_5_0.shadowCascadesOption = UnityEngine.Rendering.Universal.ShadowCascadesOption.TwoCascades
				var_5_0.overrideShadowResolution = true
				var_5_0.shadowResolution = 2048
				var_5_0.softShadow = true

				if GameGlobalMgr.instance:getScreenState():getLocalQuality() == ModuleEnum.Performance.High and arg_5_0.compatibility then
					UnityEngine.Shader.DisableKeyword("_PERFORMANCE_HIGH")
					gohelper.setActive(arg_5_0.feature, true)
				end
			end

			var_5_0:ApplyProperty()
		end

		arg_5_0.shadowState = arg_5_1
	end
end

function var_0_0.onSceneClose(arg_6_0)
	arg_6_0.sceneGO = nil
	arg_6_0.groundGO = nil
	arg_6_0.blockRoot = nil
	arg_6_0.buildingRoot = nil
	arg_6_0.characterRoot = nil
	arg_6_0.resourceRoot = nil
	arg_6_0.waterRoot = nil
	arg_6_0.planeGO = nil
	arg_6_0.ambientGO = nil
	arg_6_0.initbuildingRoot = nil
	arg_6_0.inventoryRootGO = nil
	arg_6_0.canvasGO = nil
	arg_6_0.virtualCameraGO = nil
	arg_6_0.virtualCameraXZGO = nil
	arg_6_0.poolContainerGO = nil
	arg_6_0.camerahelperGO = nil
	arg_6_0.fogRoot = nil
	arg_6_0.skyGO = nil
	arg_6_0.commonEffectRoot = nil
	arg_6_0.inventoryRootTrs = nil
	arg_6_0.virtualCameraTrs = nil
	arg_6_0.virtualCameraXZTrs = nil
	arg_6_0.directionalLightGOTrs = nil
	arg_6_0.sceneAmbient = nil
	arg_6_0.sceneShadow = nil
	arg_6_0.vehicleRoot = nil
	arg_6_0.sceneAmbientData = nil

	TaskDispatcher.cancelTask(arg_6_0._onTimeEnd, arg_6_0)

	if arg_6_0._effectParamList then
		for iter_6_0, iter_6_1 in ipairs(arg_6_0._effectParamList) do
			iter_6_1.go = nil
		end

		arg_6_0._effectParamList = nil
	end

	local var_6_0 = arg_6_0._partGODict

	arg_6_0._partGODict = nil

	if var_6_0 then
		for iter_6_2 in pairs(var_6_0) do
			rawset(var_6_0, iter_6_2, nil)
		end
	end
end

function var_0_0.spawnEffect(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	local var_7_0 = RoomGOPool.getInstance(arg_7_1, arg_7_2 or arg_7_0.commonEffectRoot, arg_7_3, arg_7_4)

	if not var_7_0 then
		return nil
	end

	local var_7_1 = {
		go = var_7_0,
		res = arg_7_1
	}

	if arg_7_5 then
		var_7_1.time = arg_7_5 + Time.time
	end

	table.insert(arg_7_0._effectParamList, var_7_1)
	arg_7_0:_updateTimer()

	return var_7_0
end

function var_0_0._updateTimer(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._onTimeEnd, arg_8_0)

	local var_8_0

	for iter_8_0, iter_8_1 in ipairs(arg_8_0._effectParamList) do
		if iter_8_1.time and (not var_8_0 or var_8_0 > iter_8_1.time) then
			var_8_0 = iter_8_1.time
		end
	end

	if var_8_0 then
		TaskDispatcher.runDelay(arg_8_0._onTimeEnd, arg_8_0, var_8_0 - Time.time)
	end
end

function var_0_0._onTimeEnd(arg_9_0)
	local var_9_0 = {}

	for iter_9_0 = #arg_9_0._effectParamList, 1, -1 do
		local var_9_1 = arg_9_0._effectParamList[iter_9_0]

		if var_9_1.time and var_9_1.time <= Time.time then
			RoomGOPool.returnInstance(var_9_1.res, var_9_1.go)

			var_9_1.go = nil

			table.remove(arg_9_0._effectParamList, iter_9_0)
		end
	end

	arg_9_0:_updateTimer()
end

return var_0_0
