module("modules.logic.story.view.StoryMainSceneView", package.seeall)

slot0 = class("StoryMainSceneView", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._str2Id = {}
	slot0._lightMapPath = "scenes/dynamic/%s/lightmaps/%s_%s.tga"
	slot0._effectPath = "scenes/%s/effect/s01_effect_0%s.prefab"
	slot1 = UnityEngine.Shader
	slot0._MainColorId = slot1.PropertyToID("_MainColor")
	slot0._EmissionColorId = slot1.PropertyToID("_EmissionColor")
	slot0._UseSecondMapId = slot1.PropertyToID("_UseSecondMap")
	slot0._UseFirstMapId = slot1.PropertyToID("_UseFirstMap")
	slot0._PercentId = slot1.PropertyToID("_Percent")
	slot0._LightmaplerpId = slot1.PropertyToID("_Lightmaplerp")
	slot0._BloomFactorId = slot1.PropertyToID("_BloomFactor")
	slot0._BloomFactor2Id = slot1.PropertyToID("_BloomFactor2")
	slot0._LuminanceId = slot1.PropertyToID("Luminance")
	slot0._RainId = slot1.PropertyToID("_Rain")
	slot0._RainDistortionFactorId = slot1.PropertyToID("_DistortionFactor")
	slot0._RainEmissionId = slot1.PropertyToID("_Emission")
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
	if slot0._srcLoader then
		slot0._srcLoader:dispose()

		slot0._srcLoader = nil
	end

	if slot0._targetLoader then
		slot0._targetLoader:dispose()

		slot0._targetLoader = nil
	end

	if slot0._effectLoader then
		slot0._effectLoader:dispose()

		slot0._effectLoader = nil
	end
end

function slot0.setSceneId(slot0, slot1)
	slot0._sceneId = slot1
end

function slot0.initSceneGo(slot0, slot1, slot2)
	if slot0._sceneGo then
		return
	end

	slot0._resName = slot2
	slot0._revert = true
	slot0._sceneGo = slot1
	slot0._frameBg = slot0:getSceneNode("s01_obj_a/Anim/Drawing/s01_xiangkuang_d_back")

	gohelper.setActive(slot0._frameBg, false)

	slot3 = slot0:getSceneNode("s01_obj_a/Anim/Effect")
	slot0._effectRoot = slot3.transform
	slot0._effectLightPs = gohelper.findChildComponent(slot3, "m_s01_effect_light", WeatherComp.TypeOfParticleSystem)
	slot0._effectAirPs = gohelper.findChildComponent(slot3, "m_s01_effect_air", WeatherComp.TypeOfParticleSystem)
	slot0._lightSwitch = slot1:GetComponent(WeatherComp.TypeOfLightSwitch)
	slot0._lightMats = {}
	slot0._matsMap = {}
	slot0._rawLightMats = {}
	slot0._rainEffectMat = nil

	for slot8 = 0, slot0._lightSwitch.lightMats.Length - 1 do
		slot9 = slot4[slot8]
		slot10 = UnityEngine.Material.Instantiate(slot9)
		slot10.name = slot9.name
		slot4[slot8] = slot10
		slot11 = string.split(slot10.name, "#")
		slot13 = slot11[2]
		slot0._lightMats[slot12] = slot0._lightMats[slot11[1]] or {}

		table.insert(slot0._lightMats[slot12], slot10)
		table.insert(slot0._rawLightMats, slot10)

		slot0._matsMap[slot10.name] = slot10

		if string.find(slot12, "m_s01_obj_e$") then
			slot0._rainEffectMat = slot10
		end
	end

	slot0:setReport(lua_weather_report.configDict[2])
end

function slot0.setReport(slot0, slot1)
	if slot0._curReport and slot1.id == slot0._curReport.id then
		return
	end

	slot0._prevReport = slot0._curReport
	slot0._curReport = slot1
	slot0.reportLightMode = slot0._curReport.lightMode

	slot0:changeLightEffectColor()
	slot0:startSwitchReport(slot0._prevReport, slot0._curReport)
end

function slot0.changeLightEffectColor(slot0)
	if not slot0._effectLightPs or not slot0._effectAirPs then
		return
	end

	slot1 = MainSceneSwitchController.getLightColor(slot0._curReport.lightMode, slot0._sceneId)
	slot2 = WeatherEnum.EffectAirColor[slot0._curReport.lightMode]
	slot3 = ZProj.ParticleSystemHelper

	slot3.SetStartColor(slot0._effectLightPs, slot1[1] / 255, slot1[2] / 255, slot1[3] / 255, slot1[4] / 255)
	slot3.SetStartColor(slot0._effectAirPs, slot2[1] / 255, slot2[2] / 255, slot2[3] / 255, slot2[4] / 255)
	gohelper.setActive(slot0._effectLightPs, false)
	slot3.SetStartRotation(slot0._effectLightPs, MainSceneSwitchController.getPrefabLightStartRotation(slot0._curReport.lightMode, slot0._sceneId))
	gohelper.setActive(slot0._effectLightPs, true)
end

function slot0.startSwitchReport(slot0, slot1, slot2)
	slot0._speed = 0.5
	slot0._revert = not slot0._revert

	if slot0._revert then
		slot0._startValue = 1
		slot0._targetValue = 0
		slot0._srcReport = slot2
		slot0._targetReport = slot1
	else
		slot0._startValue = 0
		slot0._targetValue = 1
		slot0._srcReport = slot1
		slot0._targetReport = slot2
	end

	slot0._deltaValue = slot0._targetValue - slot0._startValue

	slot0:switchLight(slot0._srcReport and slot0._srcReport.lightMode - 1 or nil, slot0._targetReport.lightMode - 1)
end

function slot0.switchLight(slot0, slot1, slot2)
	slot0:_startLoad(slot1, slot2)
end

function slot0._startLoad(slot0, slot1, slot2)
	TaskDispatcher.cancelTask(slot0._resGC, slot0)

	slot0._reportSrc = slot1
	slot0._reportTarget = slot2

	if slot0._srcLoader then
		slot0._srcLoader:dispose()

		slot0._srcLoader = nil
	end

	if slot0._targetLoader then
		slot0._targetLoader:dispose()

		slot0._targetLoader = nil
	end

	slot3 = slot0._resName
	slot4 = {}
	slot5 = {}
	slot6 = {}

	for slot10, slot11 in pairs(slot0._lightMats) do
		slot12 = slot4[slot10] or {}

		if slot1 then
			slot13 = string.format(slot0._lightMapPath, slot3, slot10, slot1)

			table.insert(slot5, slot13)

			slot12[slot1] = slot13
		end

		slot13 = string.format(slot0._lightMapPath, slot3, slot10, slot2)

		table.insert(slot6, slot13)

		slot12[slot2] = slot13
		slot4[slot10] = slot12
	end

	slot0._lightMapPathPrefix = slot4
	slot0._loadFinishNum = 0

	if #slot5 > 0 then
		slot0._loadMaxNum = 2
		slot0._srcLoader = MultiAbLoader.New()

		slot0._srcLoader:setPathList(slot5)
		slot0._srcLoader:startLoad(slot0._onLoadOneDone, slot0)
	else
		slot0._loadMaxNum = 1
	end

	if #slot6 > 0 then
		slot0._targetLoader = MultiAbLoader.New()

		slot0._targetLoader:setPathList(slot6)
		slot0._targetLoader:startLoad(slot0._onLoadOneDone, slot0)
	end
end

function slot0._onLoadOneDone(slot0)
	slot0._loadFinishNum = slot0._loadFinishNum + 1

	if slot0._loadFinishNum < slot0._loadMaxNum then
		return
	end

	slot0:_loadTexturesFinish(slot0._srcLoader, slot0._targetLoader, slot0._lightMapPathPrefix, slot0._reportSrc, slot0._reportTarget)
end

function slot0._loadTexturesFinish(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = nil

	for slot10, slot11 in pairs(slot3) do
		if slot4 then
			slot12 = slot11[slot4]
			slot6 = slot1:getAssetItem(slot12):GetResource(slot12)
		end

		slot12 = slot11[slot5]
		slot14 = slot2:getAssetItem(slot12):GetResource(slot12)

		for slot18, slot19 in pairs(slot0._lightMats[slot10]) do
			if slot4 then
				slot19:SetTexture(ShaderPropertyId.MainTex, slot6)
			end

			slot19:SetTexture(ShaderPropertyId.MainTexSecond, slot14)
		end
	end

	slot0:_setSceneMatMapCfg(0, 1)
	slot0:_changeBlendValue(slot0._targetValue, true)
	slot0:_changeEffectBlendValue(1, true)
	slot0:_resetMats()
end

function slot0._resetMats(slot0)
	slot0:_resetGoMats(slot0:getSceneNode("s01_obj_a/Anim/Sky"))
	slot0:_resetGoMats(slot0:getSceneNode("s01_obj_a/Anim/Ground"))
	slot0:_resetGoMats(slot0:getSceneNode("s01_obj_a/Anim/Obj"))
end

function slot0._resetGoMats(slot0, slot1)
	if slot1:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer), true) then
		for slot6 = 0, slot2.Length - 1 do
			if slot2[slot6].sharedMaterial and string.split(slot8.name, " ")[1] and slot0._matsMap[slot9] then
				slot7.sharedMaterial = slot0._matsMap[slot9]
			end
		end
	end
end

function slot0._setSceneMatMapCfg(slot0, slot1, slot2)
	if slot1 == 0 and slot2 == 0 then
		logError("useFirst useSecond 不能同时为0！ ")

		return
	end

	for slot6, slot7 in pairs(slot0._rawLightMats) do
		if slot1 == 1 then
			slot7:EnableKeyword("_USEFIRSTMAP_ON")
		else
			slot7:DisableKeyword(slot8)
		end

		if slot2 == 1 then
			slot7:EnableKeyword("_USESECONDMAP_ON")
		else
			slot7:DisableKeyword(slot9)
		end
	end
end

function slot0._changeBlendValue(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot0._rawLightMats) do
		slot7:SetFloat(ShaderPropertyId.ChangeTexture, slot1)
	end

	if slot2 then
		slot0:addAllEffect()
	end
end

function slot0.addAllEffect(slot0)
	slot0:_addWeatherEffect()
end

function slot0._addWeatherEffect(slot0)
	if slot0._prevReport and slot0._prevReport.effect == slot0._curReport.effect then
		slot0:_setDynamicEffectLightStartRotation()

		return
	end

	if slot0._curReport.effect <= 1 then
		return
	end

	if not slot0._effectLoader then
		slot0._effectLoader = PrefabInstantiate.Create(slot0._sceneGo)

		slot0._effectLoader:startLoad(string.format(slot0._effectPath, slot0._resName, slot0._curReport.effect - 1), slot0._effectLoaded, slot0)
	end
end

function slot0._effectLoaded(slot0)
	slot1 = slot0._effectLoader:getInstGO()
	slot1.transform.parent = slot0._effectRoot
	slot0._dynamicEffectLightPs = gohelper.findChildComponent(slot1, "m_s01_effect_light", WeatherComp.TypeOfParticleSystem)

	slot0:_setDynamicEffectLightStartRotation()
end

function slot0._setDynamicEffectLightStartRotation(slot0)
	if slot0._dynamicEffectLightPs then
		gohelper.setActive(slot0._dynamicEffectLightPs, false)
		ZProj.ParticleSystemHelper.SetStartRotation(slot0._dynamicEffectLightPs, MainSceneSwitchController.getEffectLightStartRotation(slot0._curReport.lightMode, slot0._sceneId))
		gohelper.setActive(slot0._dynamicEffectLightPs, true)
	end
end

function slot0._changeEffectBlendValue(slot0, slot1, slot2)
	if not slot0._rainEffectMat then
		return
	end

	slot3 = slot0._prevReport or slot0._curReport
	slot4 = slot0._curReport

	if slot0:_getRainEffectValue(WeatherEnum.RainOn, slot4.effect) == 1 then
		slot0._rainEffectMat:EnableKeyword("_RAIN_ON")
		slot0._rainEffectMat:SetInt(slot0._RainId, slot0:_getRainEffectValue(WeatherEnum.RainValue, slot4.effect))
	elseif slot2 then
		slot0._rainEffectMat:DisableKeyword("_RAIN_ON")
		slot0._rainEffectMat:SetInt(slot0._RainId, slot6)
	end

	slot0._rainEffectMat:SetVector(slot0._RainDistortionFactorId, slot0:lerpVector4(slot0:_getRainEffectValue(WeatherEnum.RainDistortionFactor, slot3.effect), slot0:_getRainEffectValue(WeatherEnum.RainDistortionFactor, slot4.effect), slot1))
	slot0._rainEffectMat:SetVector(slot0._RainEmissionId, slot0:lerpVector4(slot0:_getRainEffectValue(WeatherEnum.RainEmission, slot3.effect), slot0:_getRainEffectValue(WeatherEnum.RainEmission, slot4.effect), slot1))
end

function slot0._getRainEffectValue(slot0, slot1, slot2)
	return slot1[slot2] or slot1[WeatherEnum.Default]
end

function slot0.lerpVector4(slot0, slot1, slot2, slot3)
	slot0._tempVector4 = slot0._tempVector4 or Vector4.New()
	slot0._tempVector4.w = slot1.w + slot3 * (slot2.w - slot1.w)
	slot0._tempVector4.z = slot1.z + slot3 * (slot2.z - slot1.z)
	slot0._tempVector4.y = slot1.y + slot3 * (slot2.y - slot1.y)
	slot0._tempVector4.x = slot1.x + slot3 * (slot2.x - slot1.x)

	return slot0._tempVector4
end

function slot0.getSceneNode(slot0, slot1)
	return gohelper.findChild(slot0._sceneGo, slot1)
end

return slot0
