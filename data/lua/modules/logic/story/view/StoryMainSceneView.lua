module("modules.logic.story.view.StoryMainSceneView", package.seeall)

local var_0_0 = class("StoryMainSceneView", BaseView)

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
	arg_4_0._str2Id = {}
	arg_4_0._lightMapPath = "scenes/dynamic/%s/lightmaps/%s_%s.tga"
	arg_4_0._effectPath = "scenes/%s/effect/s01_effect_0%s.prefab"

	local var_4_0 = UnityEngine.Shader

	arg_4_0._MainColorId = var_4_0.PropertyToID("_MainColor")
	arg_4_0._EmissionColorId = var_4_0.PropertyToID("_EmissionColor")
	arg_4_0._UseSecondMapId = var_4_0.PropertyToID("_UseSecondMap")
	arg_4_0._UseFirstMapId = var_4_0.PropertyToID("_UseFirstMap")
	arg_4_0._PercentId = var_4_0.PropertyToID("_Percent")
	arg_4_0._LightmaplerpId = var_4_0.PropertyToID("_Lightmaplerp")
	arg_4_0._BloomFactorId = var_4_0.PropertyToID("_BloomFactor")
	arg_4_0._BloomFactor2Id = var_4_0.PropertyToID("_BloomFactor2")
	arg_4_0._LuminanceId = var_4_0.PropertyToID("Luminance")
	arg_4_0._RainId = var_4_0.PropertyToID("_Rain")
	arg_4_0._RainDistortionFactorId = var_4_0.PropertyToID("_DistortionFactor")
	arg_4_0._RainEmissionId = var_4_0.PropertyToID("_Emission")
end

function var_0_0.onOpen(arg_5_0)
	return
end

function var_0_0.onClose(arg_6_0)
	if arg_6_0._srcLoader then
		arg_6_0._srcLoader:dispose()

		arg_6_0._srcLoader = nil
	end

	if arg_6_0._targetLoader then
		arg_6_0._targetLoader:dispose()

		arg_6_0._targetLoader = nil
	end

	if arg_6_0._effectLoader then
		arg_6_0._effectLoader:dispose()

		arg_6_0._effectLoader = nil
	end
end

function var_0_0.setSceneId(arg_7_0, arg_7_1)
	arg_7_0._sceneId = arg_7_1
end

function var_0_0.initSceneGo(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_0._sceneGo then
		return
	end

	arg_8_0._resName = arg_8_2
	arg_8_0._revert = true
	arg_8_0._sceneGo = arg_8_1
	arg_8_0._frameBg = arg_8_0:getSceneNode("s01_obj_a/Anim/Drawing/s01_xiangkuang_d_back")

	gohelper.setActive(arg_8_0._frameBg, false)

	local var_8_0 = arg_8_0:getSceneNode("s01_obj_a/Anim/Effect")

	arg_8_0._effectRoot = var_8_0.transform
	arg_8_0._effectLightPs = gohelper.findChildComponent(var_8_0, "m_s01_effect_light", WeatherComp.TypeOfParticleSystem)
	arg_8_0._effectAirPs = gohelper.findChildComponent(var_8_0, "m_s01_effect_air", WeatherComp.TypeOfParticleSystem)
	arg_8_0._lightSwitch = arg_8_1:GetComponent(WeatherComp.TypeOfLightSwitch)

	local var_8_1 = arg_8_0._lightSwitch.lightMats

	arg_8_0._lightMats = {}
	arg_8_0._matsMap = {}
	arg_8_0._rawLightMats = {}
	arg_8_0._rainEffectMat = nil

	for iter_8_0 = 0, var_8_1.Length - 1 do
		local var_8_2 = var_8_1[iter_8_0]
		local var_8_3 = UnityEngine.Material.Instantiate(var_8_2)

		var_8_3.name = var_8_2.name
		var_8_1[iter_8_0] = var_8_3

		local var_8_4 = string.split(var_8_3.name, "#")
		local var_8_5 = var_8_4[1]
		local var_8_6 = var_8_4[2]

		arg_8_0._lightMats[var_8_5] = arg_8_0._lightMats[var_8_5] or {}

		table.insert(arg_8_0._lightMats[var_8_5], var_8_3)
		table.insert(arg_8_0._rawLightMats, var_8_3)

		arg_8_0._matsMap[var_8_3.name] = var_8_3

		if string.find(var_8_5, "m_s01_obj_e$") then
			arg_8_0._rainEffectMat = var_8_3
		end
	end

	local var_8_7 = lua_weather_report.configDict[2]

	arg_8_0:setReport(var_8_7)
end

function var_0_0.setReport(arg_9_0, arg_9_1)
	if arg_9_0._curReport and arg_9_1.id == arg_9_0._curReport.id then
		return
	end

	arg_9_0._prevReport = arg_9_0._curReport
	arg_9_0._curReport = arg_9_1
	arg_9_0.reportLightMode = arg_9_0._curReport.lightMode

	arg_9_0:changeLightEffectColor()
	arg_9_0:startSwitchReport(arg_9_0._prevReport, arg_9_0._curReport)
end

function var_0_0.changeLightEffectColor(arg_10_0)
	if not arg_10_0._effectLightPs or not arg_10_0._effectAirPs then
		return
	end

	local var_10_0 = MainSceneSwitchController.getLightColor(arg_10_0._curReport.lightMode, arg_10_0._sceneId)
	local var_10_1 = WeatherEnum.EffectAirColor[arg_10_0._curReport.lightMode]
	local var_10_2 = ZProj.ParticleSystemHelper

	var_10_2.SetStartColor(arg_10_0._effectLightPs, var_10_0[1] / 255, var_10_0[2] / 255, var_10_0[3] / 255, var_10_0[4] / 255)
	var_10_2.SetStartColor(arg_10_0._effectAirPs, var_10_1[1] / 255, var_10_1[2] / 255, var_10_1[3] / 255, var_10_1[4] / 255)
	gohelper.setActive(arg_10_0._effectLightPs, false)
	var_10_2.SetStartRotation(arg_10_0._effectLightPs, MainSceneSwitchController.getPrefabLightStartRotation(arg_10_0._curReport.lightMode, arg_10_0._sceneId))
	gohelper.setActive(arg_10_0._effectLightPs, true)
end

function var_0_0.startSwitchReport(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0._speed = 0.5
	arg_11_0._revert = not arg_11_0._revert

	if arg_11_0._revert then
		arg_11_0._startValue = 1
		arg_11_0._targetValue = 0
		arg_11_0._srcReport = arg_11_2
		arg_11_0._targetReport = arg_11_1
	else
		arg_11_0._startValue = 0
		arg_11_0._targetValue = 1
		arg_11_0._srcReport = arg_11_1
		arg_11_0._targetReport = arg_11_2
	end

	arg_11_0._deltaValue = arg_11_0._targetValue - arg_11_0._startValue

	arg_11_0:switchLight(arg_11_0._srcReport and arg_11_0._srcReport.lightMode - 1 or nil, arg_11_0._targetReport.lightMode - 1)
end

function var_0_0.switchLight(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0:_startLoad(arg_12_1, arg_12_2)
end

function var_0_0._startLoad(arg_13_0, arg_13_1, arg_13_2)
	TaskDispatcher.cancelTask(arg_13_0._resGC, arg_13_0)

	arg_13_0._reportSrc = arg_13_1
	arg_13_0._reportTarget = arg_13_2

	if arg_13_0._srcLoader then
		arg_13_0._srcLoader:dispose()

		arg_13_0._srcLoader = nil
	end

	if arg_13_0._targetLoader then
		arg_13_0._targetLoader:dispose()

		arg_13_0._targetLoader = nil
	end

	local var_13_0 = arg_13_0._resName
	local var_13_1 = {}
	local var_13_2 = {}
	local var_13_3 = {}

	for iter_13_0, iter_13_1 in pairs(arg_13_0._lightMats) do
		local var_13_4 = var_13_1[iter_13_0] or {}

		if arg_13_1 then
			local var_13_5 = string.format(arg_13_0._lightMapPath, var_13_0, iter_13_0, arg_13_1)

			table.insert(var_13_2, var_13_5)

			var_13_4[arg_13_1] = var_13_5
		end

		local var_13_6 = string.format(arg_13_0._lightMapPath, var_13_0, iter_13_0, arg_13_2)

		table.insert(var_13_3, var_13_6)

		var_13_4[arg_13_2] = var_13_6
		var_13_1[iter_13_0] = var_13_4
	end

	arg_13_0._lightMapPathPrefix = var_13_1
	arg_13_0._loadFinishNum = 0

	if #var_13_2 > 0 then
		arg_13_0._loadMaxNum = 2
		arg_13_0._srcLoader = MultiAbLoader.New()

		arg_13_0._srcLoader:setPathList(var_13_2)
		arg_13_0._srcLoader:startLoad(arg_13_0._onLoadOneDone, arg_13_0)
	else
		arg_13_0._loadMaxNum = 1
	end

	if #var_13_3 > 0 then
		arg_13_0._targetLoader = MultiAbLoader.New()

		arg_13_0._targetLoader:setPathList(var_13_3)
		arg_13_0._targetLoader:startLoad(arg_13_0._onLoadOneDone, arg_13_0)
	end
end

function var_0_0._onLoadOneDone(arg_14_0)
	arg_14_0._loadFinishNum = arg_14_0._loadFinishNum + 1

	if arg_14_0._loadFinishNum < arg_14_0._loadMaxNum then
		return
	end

	arg_14_0:_loadTexturesFinish(arg_14_0._srcLoader, arg_14_0._targetLoader, arg_14_0._lightMapPathPrefix, arg_14_0._reportSrc, arg_14_0._reportTarget)
end

function var_0_0._loadTexturesFinish(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
	local var_15_0

	for iter_15_0, iter_15_1 in pairs(arg_15_3) do
		if arg_15_4 then
			local var_15_1 = iter_15_1[arg_15_4]

			var_15_0 = arg_15_1:getAssetItem(var_15_1):GetResource(var_15_1)
		end

		local var_15_2 = iter_15_1[arg_15_5]
		local var_15_3 = arg_15_2:getAssetItem(var_15_2):GetResource(var_15_2)

		for iter_15_2, iter_15_3 in pairs(arg_15_0._lightMats[iter_15_0]) do
			if arg_15_4 then
				iter_15_3:SetTexture(ShaderPropertyId.MainTex, var_15_0)
			end

			iter_15_3:SetTexture(ShaderPropertyId.MainTexSecond, var_15_3)
		end
	end

	arg_15_0:_setSceneMatMapCfg(0, 1)
	arg_15_0:_changeBlendValue(arg_15_0._targetValue, true)
	arg_15_0:_changeEffectBlendValue(1, true)
	arg_15_0:_resetMats()
end

function var_0_0._resetMats(arg_16_0)
	arg_16_0:_resetGoMats(arg_16_0:getSceneNode("s01_obj_a/Anim/Sky"))
	arg_16_0:_resetGoMats(arg_16_0:getSceneNode("s01_obj_a/Anim/Ground"))
	arg_16_0:_resetGoMats(arg_16_0:getSceneNode("s01_obj_a/Anim/Obj"))
end

function var_0_0._resetGoMats(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer), true)

	if var_17_0 then
		for iter_17_0 = 0, var_17_0.Length - 1 do
			local var_17_1 = var_17_0[iter_17_0]
			local var_17_2 = var_17_1.sharedMaterial
			local var_17_3 = var_17_2 and string.split(var_17_2.name, " ")[1]

			if var_17_3 and arg_17_0._matsMap[var_17_3] then
				var_17_1.sharedMaterial = arg_17_0._matsMap[var_17_3]
			end
		end
	end
end

function var_0_0._setSceneMatMapCfg(arg_18_0, arg_18_1, arg_18_2)
	if arg_18_1 == 0 and arg_18_2 == 0 then
		logError("useFirst useSecond 不能同时为0！ ")

		return
	end

	for iter_18_0, iter_18_1 in pairs(arg_18_0._rawLightMats) do
		local var_18_0 = "_USEFIRSTMAP_ON"

		if arg_18_1 == 1 then
			iter_18_1:EnableKeyword(var_18_0)
		else
			iter_18_1:DisableKeyword(var_18_0)
		end

		local var_18_1 = "_USESECONDMAP_ON"

		if arg_18_2 == 1 then
			iter_18_1:EnableKeyword(var_18_1)
		else
			iter_18_1:DisableKeyword(var_18_1)
		end
	end
end

function var_0_0._changeBlendValue(arg_19_0, arg_19_1, arg_19_2)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0._rawLightMats) do
		iter_19_1:SetFloat(ShaderPropertyId.ChangeTexture, arg_19_1)
	end

	if arg_19_2 then
		arg_19_0:addAllEffect()
	end
end

function var_0_0.addAllEffect(arg_20_0)
	arg_20_0:_addWeatherEffect()
end

function var_0_0._addWeatherEffect(arg_21_0)
	if arg_21_0._prevReport and arg_21_0._prevReport.effect == arg_21_0._curReport.effect then
		arg_21_0:_setDynamicEffectLightStartRotation()

		return
	end

	if arg_21_0._curReport.effect <= 1 then
		return
	end

	if not arg_21_0._effectLoader then
		arg_21_0._effectLoader = PrefabInstantiate.Create(arg_21_0._sceneGo)

		local var_21_0 = arg_21_0._resName
		local var_21_1 = string.format(arg_21_0._effectPath, var_21_0, arg_21_0._curReport.effect - 1)

		arg_21_0._effectLoader:startLoad(var_21_1, arg_21_0._effectLoaded, arg_21_0)
	end
end

function var_0_0._effectLoaded(arg_22_0)
	local var_22_0 = arg_22_0._effectLoader:getInstGO()

	var_22_0.transform.parent = arg_22_0._effectRoot
	arg_22_0._dynamicEffectLightPs = gohelper.findChildComponent(var_22_0, "m_s01_effect_light", WeatherComp.TypeOfParticleSystem)

	arg_22_0:_setDynamicEffectLightStartRotation()
end

function var_0_0._setDynamicEffectLightStartRotation(arg_23_0)
	if arg_23_0._dynamicEffectLightPs then
		gohelper.setActive(arg_23_0._dynamicEffectLightPs, false)
		ZProj.ParticleSystemHelper.SetStartRotation(arg_23_0._dynamicEffectLightPs, MainSceneSwitchController.getEffectLightStartRotation(arg_23_0._curReport.lightMode, arg_23_0._sceneId))
		gohelper.setActive(arg_23_0._dynamicEffectLightPs, true)
	end
end

function var_0_0._changeEffectBlendValue(arg_24_0, arg_24_1, arg_24_2)
	if not arg_24_0._rainEffectMat then
		return
	end

	local var_24_0 = arg_24_0._prevReport or arg_24_0._curReport
	local var_24_1 = arg_24_0._curReport
	local var_24_2 = arg_24_0:_getRainEffectValue(WeatherEnum.RainOn, var_24_1.effect)
	local var_24_3 = arg_24_0:_getRainEffectValue(WeatherEnum.RainValue, var_24_1.effect)

	if var_24_2 == 1 then
		arg_24_0._rainEffectMat:EnableKeyword("_RAIN_ON")
		arg_24_0._rainEffectMat:SetInt(arg_24_0._RainId, var_24_3)
	elseif arg_24_2 then
		arg_24_0._rainEffectMat:DisableKeyword("_RAIN_ON")
		arg_24_0._rainEffectMat:SetInt(arg_24_0._RainId, var_24_3)
	end

	local var_24_4 = arg_24_0:_getRainEffectValue(WeatherEnum.RainDistortionFactor, var_24_0.effect)
	local var_24_5 = arg_24_0:_getRainEffectValue(WeatherEnum.RainDistortionFactor, var_24_1.effect)
	local var_24_6 = arg_24_0:lerpVector4(var_24_4, var_24_5, arg_24_1)

	arg_24_0._rainEffectMat:SetVector(arg_24_0._RainDistortionFactorId, var_24_6)

	local var_24_7 = arg_24_0:_getRainEffectValue(WeatherEnum.RainEmission, var_24_0.effect)
	local var_24_8 = arg_24_0:_getRainEffectValue(WeatherEnum.RainEmission, var_24_1.effect)
	local var_24_9 = arg_24_0:lerpVector4(var_24_7, var_24_8, arg_24_1)

	arg_24_0._rainEffectMat:SetVector(arg_24_0._RainEmissionId, var_24_9)
end

function var_0_0._getRainEffectValue(arg_25_0, arg_25_1, arg_25_2)
	return arg_25_1[arg_25_2] or arg_25_1[WeatherEnum.Default]
end

function var_0_0.lerpVector4(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	arg_26_0._tempVector4 = arg_26_0._tempVector4 or Vector4.New()
	arg_26_0._tempVector4.x, arg_26_0._tempVector4.y, arg_26_0._tempVector4.z, arg_26_0._tempVector4.w = arg_26_1.x + arg_26_3 * (arg_26_2.x - arg_26_1.x), arg_26_1.y + arg_26_3 * (arg_26_2.y - arg_26_1.y), arg_26_1.z + arg_26_3 * (arg_26_2.z - arg_26_1.z), arg_26_1.w + arg_26_3 * (arg_26_2.w - arg_26_1.w)

	return arg_26_0._tempVector4
end

function var_0_0.getSceneNode(arg_27_0, arg_27_1)
	return gohelper.findChild(arg_27_0._sceneGo, arg_27_1)
end

return var_0_0
