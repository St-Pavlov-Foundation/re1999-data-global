module("modules.logic.scene.room.comp.RoomSceneGOComp", package.seeall)

slot0 = class("RoomSceneGOComp", BaseSceneComp)

function slot0.onInit(slot0)
end

function slot0.init(slot0, slot1, slot2)
	slot0._scene = slot0:getCurScene()
	slot0.sceneGO = slot0._scene.level:getSceneGo()
	slot0.groundGO = gohelper.findChild(slot0.sceneGO, "ground")
	slot0.blockRoot = gohelper.findChild(slot0.sceneGO, "ground/blockRoot")
	slot0.buildingRoot = gohelper.findChild(slot0.sceneGO, "ground/buildingRoot")
	slot0.characterRoot = gohelper.findChild(slot0.sceneGO, "ground/characterRoot")
	slot0.resourceRoot = gohelper.findChild(slot0.sceneGO, "ground/resourceRoot")
	slot0.waterRoot = gohelper.findChild(slot0.sceneGO, "ground/waterRoot")
	slot0.planeGO = gohelper.findChild(slot0.sceneGO, "ground/plane")
	slot0.ambientGO = gohelper.findChild(slot0.sceneGO, "ground/ambient")
	slot0.feature = gohelper.findChild(slot0.sceneGO, "ground/feature")
	slot0.initbuildingRoot = gohelper.findChild(slot0.sceneGO, "ground/initbuildingRoot")
	slot0.inventoryRootGO = gohelper.findChild(slot0.sceneGO, "inventoryRoot")
	slot0.canvasGO = gohelper.findChild(slot0.sceneGO, "canvas")
	slot0.virtualCameraGO = gohelper.findChild(slot0.sceneGO, "virtualCamera")
	slot0.virtualCameraXZGO = gohelper.findChild(slot0.sceneGO, "virtualCameraXZ")
	slot0.poolContainerGO = gohelper.findChild(slot0.sceneGO, "poolContainer")
	slot0.directionalLightGO = gohelper.findChild(slot0.sceneGO, "lighting/Directional Light")
	slot0.camerahelperGO = gohelper.findChild(slot0.sceneGO, "camerahelper")
	slot0.fogRoot = gohelper.findChild(slot0.sceneGO, "fogRoot")
	slot0.skyGO = gohelper.findChild(slot0.sceneGO, "virtualCameraXZ/skybox/sky")
	slot0.commonEffectRoot = gohelper.findChild(slot0.sceneGO, "commonEffectRoot")
	slot0.virtualCameraTrs = slot0.virtualCameraGO.transform
	slot0.inventoryRootTrs = slot0.inventoryRootGO.transform
	slot0.virtualCameraXZTrs = slot0.virtualCameraXZGO.transform
	slot0.directionalLightGOTrs = slot0.directionalLightGO.transform
	slot0.vehicleRoot = slot0:_findOrCreateChild(slot0.groundGO, "vehicleRoot")
	slot0.critterRoot = slot0:_findOrCreateChild(slot0.groundGO, "critterRoot")
	slot0.sceneAmbient = slot0.ambientGO:GetComponent(typeof(ZProj.SceneAmbient))
	slot0.sceneCulling = slot0.ambientGO:GetComponent(typeof(SceneCulling))

	if SDKMgr.instance:isEmulator() then
		slot0.sceneCulling.enabled = false
	end

	slot6 = SceneShadow
	slot0.sceneShadow = slot0.ambientGO:GetComponent(typeof(slot6))
	slot0._effectParamList = {}
	slot0.sceneAmbientData = slot0.sceneAmbient.data
	slot0._partGODict = {}

	for slot6, slot7 in ipairs(lua_production_part.configList) do
		if gohelper.findChild(slot0.initbuildingRoot, "part" .. slot7.id) then
			slot0._partGODict[slot8] = slot9
		end
	end

	if BootNativeUtil.isAndroid() then
		slot0.compatibility = string.find(UnityEngine.SystemInfo.graphicsDeviceName, "^Adreno") or string.find(slot3, "^Mali")
		slot0.compatibility = slot0.compatibility or SDKMgr.instance:isEmulator()
	else
		slot0.compatibility = true
	end
end

function slot0.getPartGOById(slot0, slot1)
	if slot0._partGODict then
		return slot0._partGODict[slot1]
	end
end

function slot0._findOrCreateChild(slot0, slot1, slot2)
	return gohelper.findChild(slot1, slot2) or gohelper.create3d(slot1, slot2)
end

function slot0.setupShadowParam(slot0, slot1)
	if slot0.shadowState ~= slot1 then
		if slot0.sceneShadow ~= nil then
			if slot1 then
				slot2.overrideShadowCascadesOption = true
				slot2.shadowCascadesOption = UnityEngine.Rendering.Universal.ShadowCascadesOption.NoCascades
				slot2.overrideShadowResolution = true
				slot2.shadowResolution = 1600
				slot2.softShadow = true

				UnityEngine.Shader.EnableKeyword("_PERFORMANCE_HIGH")
				gohelper.setActive(slot0.feature, false)
			else
				slot2.overrideShadowCascadesOption = true
				slot2.shadowCascadesOption = UnityEngine.Rendering.Universal.ShadowCascadesOption.TwoCascades
				slot2.overrideShadowResolution = true
				slot2.shadowResolution = 2048
				slot2.softShadow = true

				if GameGlobalMgr.instance:getScreenState():getLocalQuality() == ModuleEnum.Performance.High and slot0.compatibility then
					UnityEngine.Shader.DisableKeyword("_PERFORMANCE_HIGH")
					gohelper.setActive(slot0.feature, true)
				end
			end

			slot2:ApplyProperty()
		end

		slot0.shadowState = slot1
	end
end

function slot0.onSceneClose(slot0)
	slot0.sceneGO = nil
	slot0.groundGO = nil
	slot0.blockRoot = nil
	slot0.buildingRoot = nil
	slot0.characterRoot = nil
	slot0.resourceRoot = nil
	slot0.waterRoot = nil
	slot0.planeGO = nil
	slot0.ambientGO = nil
	slot0.initbuildingRoot = nil
	slot0.inventoryRootGO = nil
	slot0.canvasGO = nil
	slot0.virtualCameraGO = nil
	slot0.virtualCameraXZGO = nil
	slot0.poolContainerGO = nil
	slot0.camerahelperGO = nil
	slot0.fogRoot = nil
	slot0.skyGO = nil
	slot0.commonEffectRoot = nil
	slot0.inventoryRootTrs = nil
	slot0.virtualCameraTrs = nil
	slot0.virtualCameraXZTrs = nil
	slot0.directionalLightGOTrs = nil
	slot0.sceneAmbient = nil
	slot0.sceneShadow = nil
	slot0.vehicleRoot = nil
	slot0.sceneAmbientData = nil

	TaskDispatcher.cancelTask(slot0._onTimeEnd, slot0)

	if slot0._effectParamList then
		for slot4, slot5 in ipairs(slot0._effectParamList) do
			slot5.go = nil
		end

		slot0._effectParamList = nil
	end

	slot0._partGODict = nil

	if slot0._partGODict then
		for slot5 in pairs(slot1) do
			rawset(slot1, slot5, nil)
		end
	end
end

function slot0.spawnEffect(slot0, slot1, slot2, slot3, slot4, slot5)
	if not RoomGOPool.getInstance(slot1, slot2 or slot0.commonEffectRoot, slot3, slot4) then
		return nil
	end

	if slot5 then
		-- Nothing
	end

	table.insert(slot0._effectParamList, {
		go = slot6,
		res = slot1,
		time = slot5 + Time.time
	})
	slot0:_updateTimer()

	return slot6
end

function slot0._updateTimer(slot0)
	TaskDispatcher.cancelTask(slot0._onTimeEnd, slot0)

	slot1 = nil

	for slot5, slot6 in ipairs(slot0._effectParamList) do
		if slot6.time and (not slot1 or slot6.time < slot1) then
			slot1 = slot6.time
		end
	end

	if slot1 then
		TaskDispatcher.runDelay(slot0._onTimeEnd, slot0, slot1 - Time.time)
	end
end

function slot0._onTimeEnd(slot0)
	slot1 = {}

	for slot5 = #slot0._effectParamList, 1, -1 do
		if slot0._effectParamList[slot5].time and slot6.time <= Time.time then
			RoomGOPool.returnInstance(slot6.res, slot6.go)

			slot6.go = nil

			table.remove(slot0._effectParamList, slot5)
		end
	end

	slot0:_updateTimer()
end

return slot0
