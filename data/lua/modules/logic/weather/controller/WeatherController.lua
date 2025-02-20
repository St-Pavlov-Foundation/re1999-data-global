module("modules.logic.weather.controller.WeatherController", package.seeall)

slot0 = class("WeatherController", BaseController)
slot0.TypeOfLightSwitch = typeof(ZProj.SwitchLight)
slot0.TypeOfParticleSystem = typeof(UnityEngine.ParticleSystem)
slot1 = AudioMgr.instance

function slot0.onInit(slot0)
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

	slot0:reInit()
	GameStateMgr.instance:registerCallback(GameStateEvent.OnApplicationQuit, slot0._onApplicationQuit, slot0)
end

function slot0._onApplicationQuit(slot0)
	slot0:_clearMats()
end

function slot0.onInitFinish(slot0)
	MainSceneSwitchController.instance:registerCallback(MainSceneSwitchEvent.SwitchSceneFinish, slot0._onSwitchSceneFinish, slot0, LuaEventSystem.High)
	MainSceneSwitchController.instance:registerCallback(MainSceneSwitchEvent.StartSwitchScene, slot0._onStartSwitchScene, slot0)
	MainSceneSwitchController.instance:registerCallback(MainSceneSwitchEvent.CloseSwitchSceneLoading, slot0._onCloseSwitchSceneLoading, slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
end

function slot0.doCallback(slot0)
	if not slot0._callbackTarget then
		return
	end

	slot0._callback(slot0._callbackTarget)

	slot0._callback = nil
	slot0._callbackTarget = nil
end

function slot0.resetWeatherChangeVoiceFlag(slot0)
	slot0._weatherChangeVoice = false
end

function slot0.setLightModel(slot0, slot1)
	slot0._lightModel = slot1
end

function slot0.initRoleGo(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0._weatherChangeVoice = false
	slot0._dispatchParam = slot0._dispatchParam or {}

	slot0:_changeRoleGo(slot1, slot2, slot3, true, slot5)

	if slot4 then
		slot0:playWeatherVoice(true)
	end
end

function slot0.changeRoleGo(slot0, slot1)
	slot0:_changeRoleGo(slot1.roleGo, slot1.heroId, slot1.sharedMaterial, slot1.heroPlayWeatherVoice, slot1.skinId)
end

function slot0.clearMat(slot0)
	slot0._roleSharedMaterial = nil
end

function slot0._changeRoleGo(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0._tempRoleParam = nil
	slot0._changeRoleParam = {
		roleGo = slot1,
		heroId = slot2,
		sharedMaterial = slot3,
		heroPlayWeatherVoice = slot4,
		skinId = slot5
	}
	slot0._roleGo = slot1
	slot0._heroId = slot2
	slot0._skinId = slot5
	slot0._heroPlayWeatherVoice = slot4
	slot0._roleSharedMaterial = slot3

	if slot1:GetComponent(PostProcessingMgr.PPEffectMaskType) then
		slot0._postProcessMask = slot6
	else
		slot0._postProcessMask = nil
	end

	slot0:initRoleParam(slot0._curReport)
	slot0:blendRoleLightMode(slot0._targetValue, true)
end

function slot0.setRoleMaskEnabled(slot0, slot1)
	if not gohelper.isNil(slot0._postProcessMask) then
		slot0._postProcessMask.enabled = slot1
	end
end

function slot0.playWeatherVoice(slot0, slot1)
	if slot0._weatherChangeVoice or not slot0._heroPlayWeatherVoice then
		return
	end

	if HeroModel.instance:getVoiceConfig(slot0._heroId, CharacterEnum.VoiceType.WeatherChange, function (slot0)
		for slot5, slot6 in ipairs(string.split(slot0.param, "#")) do
			slot7 = tonumber(slot6)

			if uv0._prevReport and slot7 == uv0._prevReport.id then
				uv1 = true
			end

			if slot7 == uv0._curReport.id then
				uv2 = true
			end
		end

		return uv2
	end, slot0._skinId) and #slot5 > 0 and (slot1 or false == false and false or math.random() <= 0.3) then
		slot0._dispatchParam[1] = slot5[1]
		slot0._dispatchParam[2] = false

		slot0:dispatchEvent(WeatherEvent.PlayVoice, slot0._dispatchParam)

		if slot0._dispatchParam[2] then
			slot0._weatherChangeVoice = true
		end
	end
end

function slot0.getSceneNode(slot0, slot1)
	return gohelper.findChild(slot0._sceneGo, slot1)
end

function slot0.playAnim(slot0, slot1)
	if not slot0._animator and slot0:getSceneNode("s01_obj_a/Anim") then
		slot0._animator = slot2:GetComponent(typeof(UnityEngine.Animator))
	end

	if slot0._animator and slot0._sceneGo.activeInHierarchy then
		slot0._animator:Play(slot1)
	end
end

function slot0._onCloseSwitchSceneLoading(slot0)
	slot0:playAnim("s01_character_switch_bg")
end

function slot0._onStartSwitchScene(slot0)
	slot0._tempRoleParam = slot0._changeRoleParam

	slot0:onSceneClose()
end

function slot0._onSwitchSceneInitFinish(slot0)
	slot1 = slot0._startInitSceneTime and Time.realtimeSinceStartup - slot0._startInitSceneTime

	MainSceneSwitchController.instance:dispatchEvent(MainSceneSwitchEvent.SwitchSceneInitFinish)
end

function slot0._onSwitchSceneFinish(slot0)
	slot0._startInitSceneTime = Time.realtimeSinceStartup

	slot0:initSceneGo(GameSceneMgr.instance:getCurScene().level:getSceneGo(), slot0._onSwitchSceneInitFinish, slot0)

	if slot0._tempRoleParam then
		slot3 = slot0._tempRoleParam
		slot0._tempRoleParam = nil

		slot0:_changeRoleGo(slot3.roleGo, slot3.heroId, slot3.sharedMaterial, slot3.heroPlayWeatherVoice, slot3.skinId)
	end
end

function slot0.initSceneGo(slot0, slot1, slot2, slot3)
	slot0._revert = true

	WeatherModel.instance:initDay()

	slot0._sceneGo = slot1
	slot4 = slot0:getSceneNode("s01_obj_a/Anim/Effect")
	slot0._effectRoot = slot4.transform
	slot0._effectLightPs = gohelper.findChildComponent(slot4, "m_s01_effect_light", uv0.TypeOfParticleSystem)
	slot9 = uv0.TypeOfParticleSystem
	slot0._effectAirPs = gohelper.findChildComponent(slot4, "m_s01_effect_air", slot9)
	slot0._lightSwitch = slot1:GetComponent(uv0.TypeOfLightSwitch)
	slot0._callback = slot2
	slot0._callbackTarget = slot3
	slot0._lightMats = {}
	slot0._matsMap = {}
	slot0._rawLightMats = {}
	slot0._rainEffectMat = nil

	for slot9 = 0, slot0._lightSwitch.lightMats.Length - 1 do
		slot11 = string.split(slot5[slot9].name, "#")
		slot13 = slot11[2]
		slot0._lightMats[slot12] = slot0._lightMats[slot11[1]] or {}

		table.insert(slot0._lightMats[slot12], slot10)
		table.insert(slot0._rawLightMats, slot10)

		slot0._matsMap[slot10.name] = slot10

		if string.find(slot12, "m_s01_obj_e$") then
			slot0._rainEffectMat = slot10
		end
	end

	if not slot0._rainEffectMat then
		logError("WeatherController initSceneGo no rainEffectMat")
	end

	if SLFramework.FrameworkSettings.IsEditor and not slot0:getSceneNode("s01_obj_a/Anim/Obj/s01_obj_b") then
		logError("WeatherController initSceneGo no s01_obj_b")
	end

	slot0._randomMainHero = true

	slot0:updateReport(false)
	ViewMgr.instance:registerCallback(ViewEvent.OnCloseFullView, slot0._onCloseFullView, slot0)
	MainController.instance:registerCallback(MainEvent.OnShowSceneNewbieOpen, slot0._OnShowSceneNewbieOpen, slot0)
end

function slot0._OnShowSceneNewbieOpen(slot0)
	callWithCatch(slot0._playNewbieShowAnim, slot0)
end

function slot0._playNewbieShowAnim(slot0)
	slot0:playAnim("s01_character_switch_xingshou")
end

function slot0._onCloseFullView(slot0, slot1)
	if not ViewMgr.instance:hasOpenFullView() then
		slot0:_checkReport()
	end
end

function slot0.setReportId(slot0, slot1)
	slot3 = 60

	if lua_weather_report.configDict[slot1] and slot3 then
		print(WeatherModel.instance:debug(slot2.id))
		slot0:setReport(slot2)

		if not slot0._reportEndTime then
			TaskDispatcher.runRepeat(slot0._checkReport, slot0, 60)
		end

		slot0._reportEndTime = os.time() + slot3

		slot0:dispatchEvent(WeatherEvent.WeatherChanged, slot2.id, slot3)
	end
end

function slot0.updateReport(slot0, slot1)
	slot2, slot3 = WeatherModel.instance:getReport()

	if slot2 == nil then
		WeatherModel.instance:resetDay()

		slot2, slot3 = WeatherModel.instance:getReport()
	end

	if slot0:_getWelcomeReport() then
		slot2 = slot4
		slot3 = 3600
	end

	if GuideModel.instance:isDoingFirstGuide() then
		slot3 = 86400
		slot2 = lua_weather_report.configDict[2]
	end

	if slot2 and slot3 then
		print(WeatherModel.instance:debug(slot2.id))
		slot0:setReport(slot2)

		if not slot0._reportEndTime then
			TaskDispatcher.runRepeat(slot0._checkReport, slot0, 60)
		end

		slot0._reportEndTime = os.time() + slot3

		if slot1 then
			slot0:dispatchEvent(WeatherEvent.WeatherChanged, slot2.id, slot3)
		end
	end
end

function slot0._getWelcomeReport(slot0)
	if not MainThumbnailWork._checkShow() then
		return
	end

	slot1, slot2 = CharacterSwitchListModel.instance:getMainHero()

	if not MainHeroView.getWelcomeLikeVoice(CharacterEnum.VoiceType.MainViewWelcome, slot1, slot2) then
		return
	end

	return WeatherConfig.instance:getRandomReport(tonumber(string.split(string.split(slot3.time, "#")[1], ":")[1]) < 12 and WeatherEnum.LightModeDuring or WeatherEnum.LightModeDusk)
end

function slot0._checkReport(slot0)
	if ViewMgr.instance:hasOpenFullView() then
		return
	end

	if slot0._reportEndTime and slot0._reportEndTime <= os.time() then
		slot0:updateReport(true)
	end
end

function slot0.getPrevLightMode(slot0)
	return slot0._prevReport and slot0._prevReport.lightMode
end

function slot0.getCurLightMode(slot0)
	return slot0._curReport and slot0._curReport.lightMode
end

function slot0.setReport(slot0, slot1)
	if slot0._curReport and slot1.id == slot0._curReport.id then
		return
	end

	slot0._prevReport = slot0._curReport
	slot0._curReport = slot1
	slot0.reportLightMode = slot0._curReport.lightMode

	if slot0._prevReport and slot0._prevReport.effect ~= slot0._curReport.effect then
		slot0:removeAllEffect()
	end

	slot0:_playVoice()

	if slot0._prevReport and slot0._prevReport.lightMode == slot0._curReport.lightMode then
		slot0:addAllEffect()
		slot0:startEffectBlend()
		slot0:playWeatherVoice()

		return
	end

	slot0:changeLightEffectColor()
	slot0:initRoleParam(slot0._curReport)
	slot0:startSwitchReport(slot0._prevReport, slot0._curReport)
end

function slot0.getCurrReport(slot0)
	return slot0._curReport
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

	slot3 = MainSceneSwitchModel.instance:getCurSceneResName()
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
	slot0:doCallback()

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

	slot0:_setSceneMatMapCfg(1, 1)
	TaskDispatcher.runDelay(slot0._resGC, slot0, 3)

	if slot4 then
		slot0:startLightBlend()
		slot0:startEffectBlend()
	else
		slot0:_changeBlendValue(slot0._targetValue, true)
		slot0:_changeEffectBlendValue(1, true)
	end

	slot0:_resetMats()
end

function slot0._resetMats(slot0)
	slot0:_resetGoMats(slot0:getSceneNode("s01_obj_a/Anim/Sky"))
	slot0:_resetGoMats(slot0:getSceneNode("s01_obj_a/Anim/Ground"))
	slot0:_resetGoMats(slot0:getSceneNode("s01_obj_a/Anim/Obj"))
end

function slot0._resetGoMats(slot0, slot1)
	if slot1:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer)) then
		for slot6 = 0, slot2.Length - 1 do
			if slot2[slot6].sharedMaterial and string.split(slot8.name, " ")[1] and slot0._matsMap[slot9] then
				slot7.sharedMaterial = slot0._matsMap[slot9]
			end
		end
	end
end

function slot0.startEffectBlend(slot0)
	slot0._effectStartTime = Time.time

	TaskDispatcher.runRepeat(slot0._onEffectUpdate, slot0, 0.033)
end

function slot0._onEffectUpdate(slot0)
	slot3 = slot1

	if (Time.time - slot0._effectStartTime) * slot0._speed >= 1 or slot1 <= 0 then
		if slot1 > 1 then
			slot3 = 1
		elseif slot1 < 0 then
			slot3 = 0
		end
	end

	slot0:_changeEffectBlendValue(slot3, slot2)

	if slot2 then
		TaskDispatcher.cancelTask(slot0._onEffectUpdate, slot0)
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

function slot0.startLightBlend(slot0)
	slot0._startTime = Time.time

	TaskDispatcher.runRepeat(slot0._onUpdate, slot0, 0.033)
end

function slot0._onUpdate(slot0)
	slot3 = slot1

	if slot0._startValue + slot0._deltaValue * (Time.time - slot0._startTime) * slot0._speed >= 1 or slot1 <= 0 then
		if slot1 > 1 then
			slot3 = 1
		elseif slot1 < 0 then
			slot3 = 0
		end
	end

	slot0:_changeBlendValue(slot3, slot2)

	if slot2 then
		TaskDispatcher.cancelTask(slot0._onUpdate, slot0)

		if slot0._targetValue >= 1 then
			slot0:_setSceneMatMapCfg(0, 1)
		else
			slot0:_setSceneMatMapCfg(1, 0)
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
		slot0:playWeatherVoice()
	end

	slot0:blendRoleLightMode(slot1, slot2)
end

function slot0.blendRoleLightMode(slot0, slot1, slot2)
	if not slot0._roleGo or not slot0._dispatchParam then
		return
	end

	if slot1 ~= slot0._targetValue then
		if not gohelper.isNil(slot0._roleSharedMaterial) then
			slot0._roleSharedMaterial:SetInt(slot0._UseSecondMapId, 1)
		end
	elseif not gohelper.isNil(slot0._roleSharedMaterial) then
		slot0._roleSharedMaterial:SetInt(slot0._UseSecondMapId, 0)
	end

	if slot0._revert then
		slot1 = 1 - slot1
	end

	PostProcessingMgr.instance:setLocalBloomColor(slot0:lerpColorIntensity(slot0._srcBloomColor or slot0._targetBloomColor, slot0._targetBloomColor, slot1, true))

	slot4 = slot0:lerpColorIntensity(slot0._srcMainColor or slot0._targetMainColor, slot0._targetMainColor, slot1)

	if not gohelper.isNil(slot0._roleSharedMaterial) then
		slot0._roleSharedMaterial:SetColor(slot0._MainColorId, slot4)
	end

	slot0:_setMainColor(slot4)

	if not gohelper.isNil(slot0._roleSharedMaterial) then
		slot0._roleSharedMaterial:SetColor(slot0._EmissionColorId, slot0:lerpColorIntensity(slot0._srcEmissionColor or slot0._targetEmissionColor, slot0._targetEmissionColor, slot1, true))
	end

	if slot0._lightModel then
		slot0._lightModel:setEmissionColor(slot5)
	end

	slot0._dispatchParam[1] = slot1
	slot0._dispatchParam[2] = slot2

	slot0:dispatchEvent(WeatherEvent.OnRoleBlend, slot0._dispatchParam)
end

function slot0._setMainColor(slot0, slot1)
	slot0._mainColor = Color.New(slot1.r, slot1.g, slot1.b, slot1.a)

	if slot0._lightModel then
		slot0._lightModel:setMainColor(slot1)
	end
end

function slot0.getMainColor(slot0)
	return slot0._mainColor
end

function slot0.lerpColorIntensity(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot1[1]
	slot7 = slot2[1]
	slot9 = nil
	slot10 = 0
	slot10 = (slot3 > 0.5 or Mathf.Lerp(slot1[2], 0, slot3 / 0.5)) and Mathf.Lerp(0, slot2[2], (slot3 - 0.5) / 0.5)

	return (not slot4 or (slot3 > 0.5 or slot0:lerpColor(slot5, slot0._blackColor, slot3 / 0.5, Mathf.Pow(2, slot10))) and slot0:lerpColor(slot0._blackColor, slot7, (slot3 - 0.5) / 0.5, Mathf.Pow(2, slot10))) and slot0:lerpColor(slot5, slot7, slot3, Mathf.Pow(2, slot10))
end

function slot0.lerpColor(slot0, slot1, slot2, slot3, slot4)
	slot0._tempColor = slot0._tempColor or Color.New()
	slot0._tempColor.b = (slot1.b + slot3 * (slot2.b - slot1.b)) * slot4
	slot0._tempColor.g = (slot1.g + slot3 * (slot2.g - slot1.g)) * slot4
	slot0._tempColor.r = (slot1.r + slot3 * (slot2.r - slot1.r)) * slot4
	slot0._tempColor.a = slot4

	return slot0._tempColor
end

function slot0.lerpColorRGBA(slot0, slot1, slot2, slot3)
	slot0._tempColor = slot0._tempColor or Color.New()
	slot0._tempColor.a = slot1.a + slot3 * (slot2.a - slot1.a)
	slot0._tempColor.b = slot1.b + slot3 * (slot2.b - slot1.b)
	slot0._tempColor.g = slot1.g + slot3 * (slot2.g - slot1.g)
	slot0._tempColor.r = slot1.r + slot3 * (slot2.r - slot1.r)

	return slot0._tempColor
end

function slot0.lerpVector4(slot0, slot1, slot2, slot3)
	slot0._tempVector4 = slot0._tempVector4 or Vector4.New()
	slot0._tempVector4.w = slot1.w + slot3 * (slot2.w - slot1.w)
	slot0._tempVector4.z = slot1.z + slot3 * (slot2.z - slot1.z)
	slot0._tempVector4.y = slot1.y + slot3 * (slot2.y - slot1.y)
	slot0._tempVector4.x = slot1.x + slot3 * (slot2.x - slot1.x)

	return slot0._tempVector4
end

function slot0.changeLightEffectColor(slot0)
	if not slot0._effectLightPs or not slot0._effectAirPs then
		return
	end

	slot1 = MainSceneSwitchController.getLightColor(slot0._curReport.lightMode)
	slot2 = WeatherEnum.EffectAirColor[slot0._curReport.lightMode]
	slot3 = ZProj.ParticleSystemHelper

	slot3.SetStartColor(slot0._effectLightPs, slot1[1] / 255, slot1[2] / 255, slot1[3] / 255, slot1[4] / 255)
	slot3.SetStartColor(slot0._effectAirPs, slot2[1] / 255, slot2[2] / 255, slot2[3] / 255, slot2[4] / 255)
	gohelper.setActive(slot0._effectLightPs, false)
	slot3.SetStartRotation(slot0._effectLightPs, MainSceneSwitchController.getPrefabLightStartRotation(slot0._curReport.lightMode))
	gohelper.setActive(slot0._effectLightPs, true)
end

function slot0.removeAllEffect(slot0)
	slot0:_removeWeatherEffect()
end

function slot0._removeWeatherEffect(slot0)
	if slot0._effectLoader then
		slot0._effectLoader:dispose()

		slot0._effectLoader = nil
	end
end

function slot0.addAllEffect(slot0)
	slot0:_addWeatherEffect()
	slot0:dispatchEvent(WeatherEvent.LoadPhotoFrameBg)
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

		slot0._effectLoader:startLoad(string.format(slot0._effectPath, MainSceneSwitchModel.instance:getCurSceneResName(), slot0._curReport.effect - 1), slot0._effectLoaded, slot0)
	end
end

function slot0._effectLoaded(slot0)
	slot1 = slot0._effectLoader:getInstGO()
	slot1.transform.parent = slot0._effectRoot
	slot0._dynamicEffectLightPs = gohelper.findChildComponent(slot1, "m_s01_effect_light", uv0.TypeOfParticleSystem)

	slot0:_setDynamicEffectLightStartRotation()
end

function slot0._setDynamicEffectLightStartRotation(slot0)
	if slot0._dynamicEffectLightPs then
		gohelper.setActive(slot0._dynamicEffectLightPs, false)
		ZProj.ParticleSystemHelper.SetStartRotation(slot0._dynamicEffectLightPs, MainSceneSwitchController.getEffectLightStartRotation(slot0._curReport.lightMode))
		gohelper.setActive(slot0._dynamicEffectLightPs, true)
	end
end

function slot0._playVoice(slot0)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main then
		return
	end

	slot1 = WeatherEnum.LightMode[slot0._curReport.lightMode]
	slot2 = WeatherEnum.EffectMode[slot0._curReport.effect]
	slot0._prevEffect = slot0._curReport.effect

	if slot0._prevEffect ~= slot0._curReport.effect and slot2 then
		uv0:setSwitch(slot0:getId("WeatherState"), slot0:getId(slot2))
	end

	slot0._prevLightMode = slot0._curReport.lightMode

	if slot0._prevLightMode ~= slot0._curReport.lightMode and slot1 then
		uv0:setSwitch(slot0:getId("Daytimestate"), slot0:getId(slot1))
	end

	print("===playVoice:", slot1, slot4, slot2, slot3)
end

function slot0.playWeatherAudio(slot0)
	slot0:_playVoice()
end

function slot0.stopWeatherAudio(slot0)
	slot0._prevLightMode = nil
	slot0._prevEffect = nil
end

function slot0.setStateByString(slot0, slot1, slot2)
	uv0:setState(slot0:getId(slot1), slot0:getId(slot2))
end

function slot0.getId(slot0, slot1)
	if not slot0._str2Id[slot1] then
		slot0._str2Id[slot1] = uv0:getIdFromString(slot1)
	end

	return slot2
end

function slot0.initRoleParam(slot0, slot1)
	slot2, slot3 = CharacterSwitchListModel.instance:getMainHero(slot0._randomMainHero)
	slot0._randomMainHero = false

	if not slot2 then
		return
	end

	if not HeroModel.instance:getByHeroId(slot2) then
		return
	end

	if not slot0._blackColor then
		slot0._blackColor = Color()
	end

	slot0._srcBloomColor = slot0._targetBloomColor
	slot0._srcMainColor = slot0._targetMainColor
	slot0._srcEmissionColor = slot0._targetEmissionColor
	slot0._srcBloomFactor = slot0._targetBloomFactor
	slot0._srcPercent = slot0._targetPercent
	slot0._srcBloomFactor2 = slot0._targetBloomFactor2
	slot0._srcLuminance = slot0._targetLuminance

	if SkinConfig.instance:getSkinCo(slot3 or slot4.skin) then
		if WeatherConfig.instance:getSkinWeatherParam(slot5.weatherParam) then
			slot7 = slot1.lightMode
			slot0._targetBloomColor = slot0:createColorIntensity(slot6["bloomColor" .. slot7])
			slot0._targetMainColor = slot0:createColorIntensity(slot6["mainColor" .. slot7])
			slot0._targetEmissionColor = slot0:createColorIntensity(slot6["emissionColor" .. slot7])
			slot0._targetBloomFactor = WeatherEnum.BloomFactor
			slot0._targetPercent = WeatherEnum.Percent
			slot0._targetBloomFactor2 = WeatherEnum.BloomFactor2[slot7]
			slot0._targetLuminance = WeatherEnum.Luminance[slot7]
		elseif isDebugBuild then
			logError(string.format("skin_%s 天气参数_%s P皮肤表.xlsx-export_皮肤天气颜色参数 未配置", slot5 and tostring(slot5.id) or "nil", slot5 and tostring(slot5.weatherParam) or "nil"))
		end
	elseif isDebugBuild then
		logError(string.format("hero_%s skin_%s 皮肤id 不存在", tostring(slot4.heroId), tostring(slot3 or slot4.skin)))
	end
end

function slot0.createColorIntensity(slot0, slot1)
	if not string.split(slot1, "#") or #slot2 < 4 then
		logError("createColorIntensity rgbintensity error,report id:" .. slot0._curReport.id .. " rgbintensityStr:" .. slot1)

		return {
			Color.New(),
			0
		}
	end

	return {
		Color.New(tonumber(slot2[1]) / 255, tonumber(slot2[2]) / 255, tonumber(slot2[3]) / 255),
		tonumber(slot2[4])
	}
end

function slot0._resGC(slot0)
	if slot0._sceneGo then
		for slot4, slot5 in pairs(slot0._lightMapPathPrefix) do
			for slot9, slot10 in pairs(slot0._lightMats[slot4]) do
				if not slot0._revert then
					slot10:SetTexture(ShaderPropertyId.MainTex, nil)
				else
					slot10:SetTexture(ShaderPropertyId.MainTexSecond, nil)
				end
			end
		end

		if not slot0._revert then
			if slot0._srcLoader then
				slot0._srcLoader:dispose()

				slot0._srcLoader = nil
			end
		elseif slot0._targetLoader then
			slot0._targetLoader:dispose()

			slot0._targetLoader = nil
		end

		SLFramework.UnityHelper.ResGC()
	end
end

function slot0._clearMats(slot0)
	if not slot0._rawLightMats then
		return
	end

	for slot4, slot5 in pairs(slot0._rawLightMats) do
		slot5:SetTexture(ShaderPropertyId.MainTex, nil)
		slot5:SetTexture(ShaderPropertyId.MainTexSecond, nil)
	end
end

function slot0.onSceneClose(slot0)
	slot0:_clearMats()

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

	TaskDispatcher.cancelTask(slot0._onUpdate, slot0)
	TaskDispatcher.cancelTask(slot0._onEffectUpdate, slot0)
	TaskDispatcher.cancelTask(slot0._checkReport, slot0)
	TaskDispatcher.cancelTask(slot0._resGC, slot0)

	slot0._sceneGo = nil
	slot0._effectRoot = nil
	slot0._lightMats = nil
	slot0._matsMap = nil
	slot0._lightSwitch = nil
	slot0._rawLightMats = nil
	slot0._rainEffectMat = nil
	slot0._roleGo = nil
	slot0._roleSharedMaterial = nil
	slot0._postProcessMask = null
	slot0._curReport = nil
	slot0._prevReport = nil
	slot0._srcReport = nil
	slot0._targetReport = nil
	slot0._animator = nil
	slot0._prevEffect = nil
	slot0._prevLightMode = nil
	slot0._effectLightPs = nil
	slot0._effectAirPs = nil
	slot0._dynamicEffectLightPs = nil
	slot0._heroPlayWeatherVoice = nil
	slot0._lightModel = nil
	slot0._changeRoleParam = nil

	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseFullView, slot0._onCloseFullView, slot0)
	MainController.instance:unregisterCallback(MainEvent.OnShowSceneNewbieOpen, slot0._OnShowSceneNewbieOpen, slot0)
end

slot0.instance = slot0.New()

return slot0
