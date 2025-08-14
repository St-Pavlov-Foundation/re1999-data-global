module("modules.logic.weather.controller.WeatherComp", package.seeall)

local var_0_0 = class("WeatherComp")

var_0_0.TypeOfLightSwitch = typeof(ZProj.SwitchLight)
var_0_0.TypeOfParticleSystem = typeof(UnityEngine.ParticleSystem)

local var_0_1 = AudioMgr.instance

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._weatherController = arg_1_1
	arg_1_0._isMain = arg_1_2

	if arg_1_0._isMain then
		arg_1_0._randomMainHero = true
	end
end

function var_0_0.onInit(arg_2_0)
	arg_2_0._str2Id = {}
	arg_2_0._lightMapPath = "scenes/dynamic/%s/lightmaps/%s_%s.tga"
	arg_2_0._effectPath = "scenes/%s/effect/s01_effect_0%s.prefab"

	local var_2_0 = UnityEngine.Shader

	arg_2_0._MainColorId = var_2_0.PropertyToID("_MainColor")
	arg_2_0._EmissionColorId = var_2_0.PropertyToID("_EmissionColor")
	arg_2_0._UseSecondMapId = var_2_0.PropertyToID("_UseSecondMap")
	arg_2_0._UseFirstMapId = var_2_0.PropertyToID("_UseFirstMap")
	arg_2_0._PercentId = var_2_0.PropertyToID("_Percent")
	arg_2_0._LightmaplerpId = var_2_0.PropertyToID("_Lightmaplerp")
	arg_2_0._BloomFactorId = var_2_0.PropertyToID("_BloomFactor")
	arg_2_0._BloomFactor2Id = var_2_0.PropertyToID("_BloomFactor2")
	arg_2_0._LuminanceId = var_2_0.PropertyToID("Luminance")
	arg_2_0._RainId = var_2_0.PropertyToID("_Rain")
	arg_2_0._RainDistortionFactorId = var_2_0.PropertyToID("_DistortionFactor")
	arg_2_0._RainEmissionId = var_2_0.PropertyToID("_Emission")
	arg_2_0._UseFirstMapKey = "_USEFIRSTMAP_ON"
	arg_2_0._UseSecondMapKey = "_USESECONDMAP_ON"

	if arg_2_0._isMain then
		arg_2_0:onInitFinish()
	end
end

function var_0_0._onApplicationQuit(arg_3_0)
	arg_3_0:_clearMats()
end

function var_0_0.onInitFinish(arg_4_0)
	GameStateMgr.instance:registerCallback(GameStateEvent.OnApplicationQuit, arg_4_0._onApplicationQuit, arg_4_0)
	MainSceneSwitchController.instance:registerCallback(MainSceneSwitchEvent.SwitchSceneFinish, arg_4_0._onSwitchSceneFinish, arg_4_0, LuaEventSystem.High)
	MainSceneSwitchController.instance:registerCallback(MainSceneSwitchEvent.StartSwitchScene, arg_4_0._onStartSwitchScene, arg_4_0)
	MainSceneSwitchController.instance:registerCallback(MainSceneSwitchEvent.CloseSwitchSceneLoading, arg_4_0._onCloseSwitchSceneLoading, arg_4_0)
	GameSceneMgr.instance:registerCallback(SceneEventName.SceneGoChangeVisible, arg_4_0._onSceneGoChangeVisible, arg_4_0)
end

function var_0_0._onSceneGoChangeVisible(arg_5_0, arg_5_1)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main then
		return
	end

	if arg_5_1 then
		arg_5_0:_playWeatherEffectAudio()
	else
		arg_5_0:_stopWeatherEffectAudio()
	end
end

function var_0_0.doCallback(arg_6_0)
	if not arg_6_0._callbackTarget then
		return
	end

	arg_6_0._callback(arg_6_0._callbackTarget)

	arg_6_0._callback = nil
	arg_6_0._callbackTarget = nil
end

function var_0_0.resetWeatherChangeVoiceFlag(arg_7_0)
	arg_7_0._weatherChangeVoice = false
end

function var_0_0.setLightModel(arg_8_0, arg_8_1)
	arg_8_0._lightModel = arg_8_1
end

function var_0_0.initRoleGo(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	arg_9_0._weatherChangeVoice = false
	arg_9_0._dispatchParam = arg_9_0._dispatchParam or {}

	arg_9_0:_changeRoleGo(arg_9_1, arg_9_2, arg_9_3, true, arg_9_5)

	if arg_9_4 then
		arg_9_0:playWeatherVoice(true)
	end
end

function var_0_0.changeRoleGo(arg_10_0, arg_10_1)
	arg_10_0:_changeRoleGo(arg_10_1.roleGo, arg_10_1.heroId, arg_10_1.sharedMaterial, arg_10_1.heroPlayWeatherVoice, arg_10_1.skinId)
end

function var_0_0.clearMat(arg_11_0)
	arg_11_0._roleSharedMaterial = nil
end

function var_0_0._changeRoleGo(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5)
	arg_12_0._tempRoleParam = nil
	arg_12_0._changeRoleParam = {
		roleGo = arg_12_1,
		heroId = arg_12_2,
		sharedMaterial = arg_12_3,
		heroPlayWeatherVoice = arg_12_4,
		skinId = arg_12_5
	}
	arg_12_0._roleGo = arg_12_1
	arg_12_0._heroId = arg_12_2
	arg_12_0._skinId = arg_12_5
	arg_12_0._heroPlayWeatherVoice = arg_12_4
	arg_12_0._roleSharedMaterial = arg_12_3

	local var_12_0 = arg_12_1:GetComponent(PostProcessingMgr.PPEffectMaskType)

	if var_12_0 then
		arg_12_0._postProcessMask = var_12_0
	else
		arg_12_0._postProcessMask = nil
	end

	arg_12_0:initRoleParam(arg_12_0._curReport)
	arg_12_0:blendRoleLightMode(arg_12_0._targetValue, true)
end

function var_0_0.setRoleMaskEnabled(arg_13_0, arg_13_1)
	if not gohelper.isNil(arg_13_0._postProcessMask) then
		arg_13_0._postProcessMask.enabled = arg_13_1
	end
end

function var_0_0.playWeatherVoice(arg_14_0, arg_14_1)
	if not arg_14_0._weatherController then
		return
	end

	if arg_14_0._weatherChangeVoice or not arg_14_0._heroPlayWeatherVoice then
		return
	end

	local var_14_0 = false
	local var_14_1 = false
	local var_14_2 = arg_14_0._heroId
	local var_14_3 = HeroModel.instance:getVoiceConfig(var_14_2, CharacterEnum.VoiceType.WeatherChange, function(arg_15_0)
		local var_15_0 = string.split(arg_15_0.param, "#")

		for iter_15_0, iter_15_1 in ipairs(var_15_0) do
			local var_15_1 = tonumber(iter_15_1)

			if arg_14_0._prevReport and var_15_1 == arg_14_0._prevReport.id then
				var_14_0 = true
			end

			if var_15_1 == arg_14_0._curReport.id then
				var_14_1 = true
			end
		end

		return var_14_1
	end, arg_14_0._skinId)

	if var_14_3 and #var_14_3 > 0 and (arg_14_1 or var_14_0 == false and var_14_1 or math.random() <= 0.3) then
		local var_14_4 = var_14_3[1]
		local var_14_5 = MainHeroView.getRandomMultiVoice(var_14_4, arg_14_0._heroId, arg_14_0._skinId)

		arg_14_0._dispatchParam[1] = var_14_5
		arg_14_0._dispatchParam[2] = false

		arg_14_0._weatherController:dispatchEvent(WeatherEvent.PlayVoice, arg_14_0._dispatchParam)

		if arg_14_0._dispatchParam[2] then
			arg_14_0._weatherChangeVoice = true
		end
	end
end

function var_0_0.getSceneNode(arg_16_0, arg_16_1)
	return gohelper.findChild(arg_16_0._sceneGo, arg_16_1)
end

function var_0_0.playAnim(arg_17_0, arg_17_1)
	if not arg_17_0._animator then
		local var_17_0 = arg_17_0:getSceneNode("s01_obj_a/Anim")

		if var_17_0 then
			arg_17_0._animator = var_17_0:GetComponent(typeof(UnityEngine.Animator))
		end
	end

	if arg_17_0._animator and arg_17_0._sceneGo.activeInHierarchy then
		arg_17_0._animator:Play(arg_17_1)
	end
end

function var_0_0._onCloseSwitchSceneLoading(arg_18_0)
	arg_18_0:playAnim("s01_character_switch_bg")
end

function var_0_0._onStartSwitchScene(arg_19_0)
	arg_19_0._tempRoleParam = arg_19_0._changeRoleParam

	arg_19_0:onSceneClose()

	if arg_19_0._isMain then
		arg_19_0._randomMainHero = false
	end
end

function var_0_0._onSwitchSceneInitFinish(arg_20_0)
	if not arg_20_0._weatherController then
		return
	end

	if arg_20_0._isSceneHide then
		arg_20_0:onSceneHide()
	end

	if arg_20_0._startInitSceneTime then
		local var_20_0 = Time.realtimeSinceStartup - arg_20_0._startInitSceneTime
	end

	MainSceneSwitchController.instance:dispatchEvent(MainSceneSwitchEvent.SwitchSceneInitFinish)
end

function var_0_0._onSwitchSceneFinish(arg_21_0)
	local var_21_0 = GameSceneMgr.instance:getCurScene().level:getSceneGo()

	arg_21_0._startInitSceneTime = Time.realtimeSinceStartup

	arg_21_0:setSceneId(MainSceneSwitchModel.instance:getCurSceneId())
	arg_21_0:initSceneGo(var_21_0, arg_21_0._onSwitchSceneInitFinish, arg_21_0)

	if arg_21_0._tempRoleParam then
		local var_21_1 = arg_21_0._tempRoleParam

		arg_21_0._tempRoleParam = nil

		arg_21_0:_changeRoleGo(var_21_1.roleGo, var_21_1.heroId, var_21_1.sharedMaterial, var_21_1.heroPlayWeatherVoice, var_21_1.skinId)
	end
end

function var_0_0.changeReportId(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0._reportId = arg_22_1
	arg_22_0._reportDeltaTime = arg_22_2

	if arg_22_0._sceneGo then
		arg_22_0:updateReport(false)
	end
end

function var_0_0.setSceneId(arg_23_0, arg_23_1)
	arg_23_0._sceneId = arg_23_1
end

function var_0_0._checkMatTexture(arg_24_0, arg_24_1)
	if arg_24_1:GetTexture(ShaderPropertyId.MainTex) then
		logError(string.format("_checkMatTexture mat:{%s} MainTex is not nil", arg_24_1.name))
	end

	if arg_24_1:GetTexture(ShaderPropertyId.MainTexSecond) then
		logError(string.format("_checkMatTexture mat:{%s} MainTexSecond is not nil", arg_24_1.name))
	end
end

function var_0_0.getSceneGo(arg_25_0)
	return arg_25_0._sceneGo
end

function var_0_0.initSceneGo(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	arg_26_0._revert = true

	if arg_26_0._isMain then
		WeatherModel.instance:initDay(arg_26_0._sceneId)
	end

	arg_26_0._sceneGo = arg_26_1

	local var_26_0 = arg_26_0:getSceneNode("s01_obj_a/Anim/Effect")

	arg_26_0._effectRoot = var_26_0.transform
	arg_26_0._effectLightPs = gohelper.findChildComponent(var_26_0, "m_s01_effect_light", var_0_0.TypeOfParticleSystem)
	arg_26_0._effectAirPs = gohelper.findChildComponent(var_26_0, "m_s01_effect_air", var_0_0.TypeOfParticleSystem)
	arg_26_0._lightSwitch = arg_26_1:GetComponent(var_0_0.TypeOfLightSwitch)
	arg_26_0._callback = arg_26_2
	arg_26_0._callbackTarget = arg_26_3

	local var_26_1 = SLFramework.FrameworkSettings.IsEditor
	local var_26_2 = arg_26_0._lightSwitch.lightMats

	arg_26_0._lightMats = {}
	arg_26_0._matsMap = {}
	arg_26_0._rawLightMats = {}
	arg_26_0._rainEffectMat = nil

	for iter_26_0 = 0, var_26_2.Length - 1 do
		local var_26_3 = var_26_2[iter_26_0]
		local var_26_4 = UnityEngine.Material.Instantiate(var_26_3)

		var_26_4.name = var_26_3.name
		var_26_2[iter_26_0] = var_26_4

		local var_26_5 = string.split(var_26_4.name, "#")
		local var_26_6 = var_26_5[1]
		local var_26_7 = var_26_5[2]

		if not WeatherHelper.skipLightMap(arg_26_0._sceneId, var_26_6) then
			arg_26_0._lightMats[var_26_6] = arg_26_0._lightMats[var_26_6] or {}

			table.insert(arg_26_0._lightMats[var_26_6], var_26_4)
			table.insert(arg_26_0._rawLightMats, var_26_4)
		end

		arg_26_0._matsMap[var_26_4.name] = var_26_4

		if var_26_1 then
			arg_26_0:_checkMatTexture(var_26_4)
		end

		if string.find(var_26_6, "m_s01_obj_e$") then
			arg_26_0._rainEffectMat = var_26_4
		end
	end

	arg_26_0._behaviourContainer = WeatherBehaviourContainer.Create(arg_26_0._sceneGo)

	arg_26_0._behaviourContainer:setSceneId(arg_26_0._sceneId)
	arg_26_0._behaviourContainer:setLightMats(var_26_2)

	if not arg_26_0._rainEffectMat then
		logError("WeatherComp initSceneGo no rainEffectMat")
	end

	arg_26_0:_initMatReportSettings()

	if arg_26_0._isMain then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseFullView, arg_26_0._onCloseFullView, arg_26_0)
		MainController.instance:registerCallback(MainEvent.OnShowSceneNewbieOpen, arg_26_0._OnShowSceneNewbieOpen, arg_26_0)
		arg_26_0._weatherController:updateOtherComps(arg_26_1)
	end

	arg_26_0:updateReport(false)
end

function var_0_0._initMatReportSettings(arg_27_0)
	arg_27_0._matReportSettings = WeatherConfig.instance:getMatReportSettings(arg_27_0._sceneId)

	if SLFramework.FrameworkSettings.IsEditor and arg_27_0._matReportSettings then
		for iter_27_0, iter_27_1 in pairs(arg_27_0._matReportSettings) do
			local var_27_0 = arg_27_0._matsMap[iter_27_0]

			if not var_27_0 then
				logError(string.format("WeatherComp _initMatReportSettings mat:{%s} is nil", iter_27_0))
			elseif var_27_0:GetTexture(ShaderPropertyId.LightMap) then
				logError(string.format("WeatherComp _initMatReportSettings mat:{%s} LightMap is not nil", iter_27_0))
			end
		end
	end
end

function var_0_0._OnShowSceneNewbieOpen(arg_28_0)
	callWithCatch(arg_28_0._playNewbieShowAnim, arg_28_0)
end

function var_0_0._playNewbieShowAnim(arg_29_0)
	arg_29_0:playAnim("s01_character_switch_xingshou")
end

function var_0_0._onCloseFullView(arg_30_0, arg_30_1)
	if not ViewMgr.instance:hasOpenFullView() then
		arg_30_0:_checkReport()
	end
end

function var_0_0.setReportId(arg_31_0, arg_31_1)
	local var_31_0 = lua_weather_report.configDict[arg_31_1]
	local var_31_1 = 60

	if var_31_0 and var_31_1 then
		print(WeatherModel.instance:debug(var_31_0.id, arg_31_0._sceneId))
		arg_31_0:setReport(var_31_0)

		if not arg_31_0._reportEndTime then
			TaskDispatcher.runRepeat(arg_31_0._checkReport, arg_31_0, 60)
		end

		arg_31_0._reportEndTime = os.time() + var_31_1

		if arg_31_0._weatherController then
			arg_31_0._weatherController:dispatchEvent(WeatherEvent.WeatherChanged, var_31_0.id, var_31_1)
		end
	end
end

function var_0_0.updateReport(arg_32_0, arg_32_1)
	local var_32_0, var_32_1 = WeatherModel.instance:getReport()
	local var_32_2, var_32_3 = xpcall(arg_32_0._getWelcomeReport, __G__TRACKBACK__, arg_32_0)

	if var_32_2 and var_32_3 then
		var_32_0 = var_32_3
		var_32_1 = 3600
	end

	if GuideModel.instance:isDoingFirstGuide() then
		var_32_0, var_32_1 = lua_weather_report.configDict[2], 86400
	end

	if arg_32_0._reportId and arg_32_0._reportDeltaTime then
		var_32_0 = lua_weather_report.configDict[arg_32_0._reportId]
		var_32_1 = arg_32_0._reportDeltaTime
	end

	if var_32_0 and var_32_1 then
		print(WeatherModel.instance:debug(var_32_0.id, arg_32_0._sceneId))
		arg_32_0:setReport(var_32_0)

		if not arg_32_0._reportEndTime then
			TaskDispatcher.runRepeat(arg_32_0._checkReport, arg_32_0, 60)
		end

		arg_32_0._reportEndTime = os.time() + var_32_1

		if arg_32_1 and arg_32_0._weatherController then
			arg_32_0._weatherController:dispatchEvent(WeatherEvent.WeatherChanged, var_32_0.id, var_32_1)
		end
	else
		logError(string.format("WeatherComp:updateReport error,curReport:%s,deltaTime:%s", var_32_0, var_32_1))
	end
end

function var_0_0._getWelcomeReport(arg_33_0)
	if not MainThumbnailWork._checkShow() then
		return
	end

	local var_33_0, var_33_1 = CharacterSwitchListModel.instance:getMainHero()
	local var_33_2 = MainHeroView.getWelcomeLikeVoice(CharacterEnum.VoiceType.MainViewWelcome, var_33_0, var_33_1)

	if not var_33_2 then
		return
	end

	local var_33_3 = string.split(var_33_2.time, "#")
	local var_33_4 = string.split(var_33_3[1], ":")
	local var_33_5 = tonumber(var_33_4[1]) < 12

	return (WeatherConfig.instance:getRandomReport(var_33_5 and WeatherEnum.LightModeDuring or WeatherEnum.LightModeDusk, arg_33_0._sceneId))
end

function var_0_0._checkReport(arg_34_0)
	if ViewMgr.instance:hasOpenFullView() then
		return
	end

	if not arg_34_0._isSceneHide and arg_34_0._reportEndTime and arg_34_0._reportEndTime <= os.time() then
		arg_34_0:updateReport(true)
	end
end

function var_0_0.getPrevLightMode(arg_35_0)
	return arg_35_0._prevReport and arg_35_0._prevReport.lightMode
end

function var_0_0.getCurLightMode(arg_36_0)
	return arg_36_0._curReport and arg_36_0._curReport.lightMode
end

function var_0_0._finishAllUpdate(arg_37_0)
	if arg_37_0._effectStartTime then
		arg_37_0:_onEffectUpdateHandler(arg_37_0._effectStartTime + 5)
	end

	if arg_37_0._startTime then
		arg_37_0:_onUpdateHandler(arg_37_0._startTime + 5)
	end
end

function var_0_0.setReport(arg_38_0, arg_38_1)
	if arg_38_0._curReport and arg_38_1.id == arg_38_0._curReport.id then
		return
	end

	if not WeatherConfig.instance:sceneContainReport(arg_38_0._sceneId, arg_38_1.id) then
		logError(string.format("WeatherComp setReport sceneId:%s,reportId:%s,not in scene", arg_38_0._sceneId, arg_38_1.id))

		arg_38_1 = lua_weather_report.configDict[1]
	end

	arg_38_0:_finishAllUpdate()

	arg_38_0._prevReport = arg_38_0._curReport
	arg_38_0._curReport = arg_38_1
	arg_38_0.reportLightMode = arg_38_0._curReport.lightMode

	if arg_38_0._changeReportCallback then
		arg_38_0._changeReportCallback(arg_38_0._changeReportCallbackTarget, arg_38_0._curReport)
	end

	if arg_38_0._prevReport and arg_38_0._prevReport.effect ~= arg_38_0._curReport.effect then
		arg_38_0:removeAllEffect()
	end

	if arg_38_0._behaviourContainer then
		arg_38_0._behaviourContainer:setReport(arg_38_0._prevReport, arg_38_0._curReport)
	end

	arg_38_0:_playVoice()

	if arg_38_0._prevReport and arg_38_0._prevReport.lightMode == arg_38_0._curReport.lightMode then
		arg_38_0:addAllEffect()
		arg_38_0:startEffectBlend()
		arg_38_0:playWeatherVoice()

		return
	end

	arg_38_0:changeLightEffectColor()
	arg_38_0:initRoleParam(arg_38_0._curReport)
	arg_38_0:startSwitchReport(arg_38_0._prevReport, arg_38_0._curReport)
end

function var_0_0.getCurrReport(arg_39_0)
	return arg_39_0._curReport
end

function var_0_0.startSwitchReport(arg_40_0, arg_40_1, arg_40_2)
	arg_40_0._speed = 0.5
	arg_40_0._revert = not arg_40_0._revert

	if arg_40_0._revert then
		arg_40_0._startValue = 1
		arg_40_0._targetValue = 0
		arg_40_0._srcReport = arg_40_2
		arg_40_0._targetReport = arg_40_1
	else
		arg_40_0._startValue = 0
		arg_40_0._targetValue = 1
		arg_40_0._srcReport = arg_40_1
		arg_40_0._targetReport = arg_40_2
	end

	arg_40_0._deltaValue = arg_40_0._targetValue - arg_40_0._startValue

	arg_40_0:switchLight(arg_40_0._srcReport and arg_40_0._srcReport.lightMode - 1 or nil, arg_40_0._targetReport.lightMode - 1)
end

function var_0_0.switchLight(arg_41_0, arg_41_1, arg_41_2)
	arg_41_0:_startLoad(arg_41_1, arg_41_2)
end

function var_0_0._getSceneResName(arg_42_0)
	return arg_42_0._sceneResName or MainSceneSwitchModel.instance:getCurSceneResName()
end

function var_0_0.setSceneResName(arg_43_0, arg_43_1)
	arg_43_0._sceneResName = arg_43_1
end

function var_0_0._startLoad(arg_44_0, arg_44_1, arg_44_2)
	TaskDispatcher.cancelTask(arg_44_0._resGC, arg_44_0)
	TaskDispatcher.cancelTask(arg_44_0._repeatPlayEffectAndAudio, arg_44_0)

	arg_44_0._reportSrc = arg_44_1
	arg_44_0._reportTarget = arg_44_2

	if arg_44_0._srcLoader then
		arg_44_0._srcLoader:dispose()

		arg_44_0._srcLoader = nil
	end

	if arg_44_0._targetLoader then
		arg_44_0._targetLoader:dispose()

		arg_44_0._targetLoader = nil
	end

	local var_44_0 = arg_44_0:_getSceneResName()
	local var_44_1 = {}
	local var_44_2 = {}
	local var_44_3 = {}

	for iter_44_0, iter_44_1 in pairs(arg_44_0._lightMats) do
		local var_44_4 = var_44_1[iter_44_0] or {}

		if arg_44_1 then
			local var_44_5 = string.format(arg_44_0._lightMapPath, var_44_0, WeatherHelper.getResourcePrefix(iter_44_0), arg_44_1)

			if not tabletool.indexOf(var_44_2, var_44_5) then
				table.insert(var_44_2, var_44_5)
			end

			var_44_4[arg_44_1] = var_44_5
		end

		local var_44_6 = string.format(arg_44_0._lightMapPath, var_44_0, WeatherHelper.getResourcePrefix(iter_44_0), arg_44_2)

		if not tabletool.indexOf(var_44_3, var_44_6) then
			table.insert(var_44_3, var_44_6)
		end

		var_44_4[arg_44_2] = var_44_6
		var_44_1[iter_44_0] = var_44_4
	end

	arg_44_0._lightMapPathPrefix = var_44_1
	arg_44_0._loadFinishNum = 0

	if #var_44_2 > 0 then
		arg_44_0._loadMaxNum = 2
		arg_44_0._srcLoader = MultiAbLoader.New()

		arg_44_0._srcLoader:setPathList(var_44_2)
		arg_44_0._srcLoader:startLoad(arg_44_0._onLoadOneDone, arg_44_0)
	else
		arg_44_0._loadMaxNum = 1
	end

	if arg_44_0._matReportSettings and #var_44_3 > 0 then
		for iter_44_2, iter_44_3 in pairs(arg_44_0._matReportSettings) do
			local var_44_7 = iter_44_3[arg_44_0._curReport.lightMode]

			if var_44_7 then
				table.insert(var_44_3, var_44_7)
			end
		end
	end

	if #var_44_3 > 0 then
		arg_44_0._targetLoader = MultiAbLoader.New()

		arg_44_0._targetLoader:setPathList(var_44_3)
		arg_44_0._targetLoader:startLoad(arg_44_0._onLoadOneDone, arg_44_0)
	end
end

function var_0_0._onLoadOneDone(arg_45_0)
	arg_45_0._loadFinishNum = arg_45_0._loadFinishNum + 1

	if arg_45_0._loadFinishNum < arg_45_0._loadMaxNum then
		return
	end

	arg_45_0:_loadTexturesFinish(arg_45_0._srcLoader, arg_45_0._targetLoader, arg_45_0._lightMapPathPrefix, arg_45_0._reportSrc, arg_45_0._reportTarget)
end

function var_0_0._loadTexturesFinish(arg_46_0, arg_46_1, arg_46_2, arg_46_3, arg_46_4, arg_46_5)
	arg_46_0:doCallback()

	local var_46_0

	for iter_46_0, iter_46_1 in pairs(arg_46_3) do
		if arg_46_4 then
			local var_46_1 = iter_46_1[arg_46_4]

			var_46_0 = arg_46_1:getAssetItem(var_46_1):GetResource(var_46_1)
		end

		local var_46_2 = iter_46_1[arg_46_5]
		local var_46_3 = arg_46_2:getAssetItem(var_46_2):GetResource(var_46_2)

		for iter_46_2, iter_46_3 in pairs(arg_46_0._lightMats[iter_46_0]) do
			if arg_46_4 then
				iter_46_3:SetTexture(ShaderPropertyId.MainTex, var_46_0)
			end

			iter_46_3:SetTexture(ShaderPropertyId.MainTexSecond, var_46_3)
		end
	end

	arg_46_0:_setMatReportLightMap(arg_46_2)
	arg_46_0:_setSceneMatMapCfg(1, 1)
	TaskDispatcher.runDelay(arg_46_0._resGC, arg_46_0, 3)

	if arg_46_4 then
		arg_46_0:startLightBlend()
		arg_46_0:startEffectBlend()
	else
		arg_46_0:_changeBlendValue(arg_46_0._targetValue, true)
		arg_46_0:_changeEffectBlendValue(1, true)
		arg_46_0:_updateSceneMatMapCfg()
	end

	arg_46_0:_resetMats()
end

function var_0_0._setMatReportLightMap(arg_47_0, arg_47_1)
	if not arg_47_0._matReportSettings then
		return
	end

	for iter_47_0, iter_47_1 in pairs(arg_47_0._matReportSettings) do
		local var_47_0 = arg_47_0._matsMap[iter_47_0]
		local var_47_1 = iter_47_1[arg_47_0._curReport.lightMode]

		if var_47_1 then
			if var_47_0 then
				local var_47_2 = arg_47_1:getAssetItem(var_47_1)
				local var_47_3 = var_47_2 and var_47_2:GetResource(var_47_1)

				if var_47_3 then
					var_47_0:SetTexture(ShaderPropertyId.LightMap, var_47_3)
				else
					logError(string.format("WeatherComp:_setMatReportLightMap targetTexture is nil, path: %s", var_47_1))
				end
			end
		elseif var_47_0 then
			var_47_0:SetTexture(ShaderPropertyId.LightMap, nil)
		end
	end
end

function var_0_0._resetMats(arg_48_0)
	arg_48_0:_resetGoMats(arg_48_0:getSceneNode("s01_obj_a/Anim/Sky"))
	arg_48_0:_resetGoMats(arg_48_0:getSceneNode("s01_obj_a/Anim/Ground"))
	arg_48_0:_resetGoMats(arg_48_0:getSceneNode("s01_obj_a/Anim/Obj"))
end

function var_0_0._resetGoMats(arg_49_0, arg_49_1)
	local var_49_0 = arg_49_1:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer), true)

	if var_49_0 then
		for iter_49_0 = 0, var_49_0.Length - 1 do
			local var_49_1 = var_49_0[iter_49_0]
			local var_49_2 = var_49_1.sharedMaterial
			local var_49_3 = var_49_2 and string.split(var_49_2.name, " ")[1]

			if var_49_3 and arg_49_0._matsMap[var_49_3] then
				var_49_1.sharedMaterial = arg_49_0._matsMap[var_49_3]
			end
		end
	end
end

function var_0_0.startEffectBlend(arg_50_0)
	arg_50_0._effectStartTime = Time.time

	TaskDispatcher.runRepeat(arg_50_0._onEffectUpdate, arg_50_0, 0.033)
end

function var_0_0._onEffectUpdate(arg_51_0)
	arg_51_0:_onEffectUpdateHandler(Time.time)
end

function var_0_0._onEffectUpdateHandler(arg_52_0, arg_52_1)
	local var_52_0 = (arg_52_1 - arg_52_0._effectStartTime) * arg_52_0._speed
	local var_52_1 = var_52_0 >= 1 or var_52_0 <= 0
	local var_52_2 = var_52_0

	if var_52_1 then
		if var_52_0 > 1 then
			var_52_2 = 1
		elseif var_52_0 < 0 then
			var_52_2 = 0
		end
	end

	if var_52_1 then
		arg_52_0._effectStartTime = nil

		TaskDispatcher.cancelTask(arg_52_0._onEffectUpdate, arg_52_0)
	end

	arg_52_0:_changeEffectBlendValue(var_52_2, var_52_1)
end

function var_0_0._changeEffectBlendValue(arg_53_0, arg_53_1, arg_53_2)
	if not arg_53_0._rainEffectMat then
		return
	end

	local var_53_0 = arg_53_0._prevReport or arg_53_0._curReport
	local var_53_1 = arg_53_0._curReport

	if not var_53_0 or not var_53_1 then
		logError("WeatherComp _changeEffectBlendValue prevReport or curReport is nil")

		return
	end

	local var_53_2 = arg_53_0:_getRainEffectValue(WeatherEnum.RainOn, var_53_1.effect)
	local var_53_3 = arg_53_0:_getRainEffectValue(WeatherEnum.RainValue, var_53_1.effect)

	if var_53_2 == 1 then
		arg_53_0._rainEffectMat:EnableKeyword("_RAIN_ON")
		arg_53_0._rainEffectMat:SetInt(arg_53_0._RainId, var_53_3)
	elseif arg_53_2 then
		arg_53_0._rainEffectMat:DisableKeyword("_RAIN_ON")
		arg_53_0._rainEffectMat:SetInt(arg_53_0._RainId, var_53_3)
	end

	local var_53_4 = arg_53_0:_getRainEffectValue(WeatherEnum.RainDistortionFactor, var_53_0.effect)
	local var_53_5 = arg_53_0:_getRainEffectValue(WeatherEnum.RainDistortionFactor, var_53_1.effect)
	local var_53_6 = arg_53_0:lerpVector4(var_53_4, var_53_5, arg_53_1)

	arg_53_0._rainEffectMat:SetVector(arg_53_0._RainDistortionFactorId, var_53_6)

	local var_53_7 = arg_53_0:_getRainEffectValue(WeatherEnum.RainEmission, var_53_0.effect)
	local var_53_8 = arg_53_0:_getRainEffectValue(WeatherEnum.RainEmission, var_53_1.effect)
	local var_53_9 = arg_53_0:lerpVector4(var_53_7, var_53_8, arg_53_1)

	arg_53_0._rainEffectMat:SetVector(arg_53_0._RainEmissionId, var_53_9)
end

function var_0_0._getRainEffectValue(arg_54_0, arg_54_1, arg_54_2)
	return arg_54_1[arg_54_2] or arg_54_1[WeatherEnum.Default]
end

function var_0_0.startLightBlend(arg_55_0)
	arg_55_0._startTime = Time.time

	TaskDispatcher.runRepeat(arg_55_0._onUpdate, arg_55_0, 0.033)
end

function var_0_0._onUpdate(arg_56_0)
	arg_56_0:_onUpdateHandler(Time.time)
end

function var_0_0._onUpdateHandler(arg_57_0, arg_57_1)
	local var_57_0 = arg_57_0._startValue + arg_57_0._deltaValue * (arg_57_1 - arg_57_0._startTime) * arg_57_0._speed
	local var_57_1 = var_57_0 >= 1 or var_57_0 <= 0
	local var_57_2 = var_57_0

	if var_57_1 then
		if var_57_0 > 1 then
			var_57_2 = 1
		elseif var_57_0 < 0 then
			var_57_2 = 0
		end
	end

	if var_57_1 then
		TaskDispatcher.cancelTask(arg_57_0._onUpdate, arg_57_0)

		arg_57_0._startTime = nil

		arg_57_0:_updateSceneMatMapCfg()
	end

	arg_57_0:_changeBlendValue(var_57_2, var_57_1)
end

function var_0_0._updateSceneMatMapCfg(arg_58_0)
	if arg_58_0._targetValue >= 1 then
		arg_58_0:_setSceneMatMapCfg(0, 1)
	else
		arg_58_0:_setSceneMatMapCfg(1, 0)
	end
end

function var_0_0._setSceneMatMapCfg(arg_59_0, arg_59_1, arg_59_2)
	if arg_59_1 == 0 and arg_59_2 == 0 then
		logError("useFirst useSecond 不能同时为0！ ")

		return
	end

	for iter_59_0, iter_59_1 in pairs(arg_59_0._rawLightMats) do
		local var_59_0 = arg_59_0._UseFirstMapKey

		if arg_59_1 == 1 then
			iter_59_1:EnableKeyword(var_59_0)
		else
			iter_59_1:DisableKeyword(var_59_0)
		end

		local var_59_1 = arg_59_0._UseSecondMapKey

		if arg_59_2 == 1 then
			iter_59_1:EnableKeyword(var_59_1)
		else
			iter_59_1:DisableKeyword(var_59_1)
		end
	end
end

function var_0_0._changeBlendValue(arg_60_0, arg_60_1, arg_60_2)
	for iter_60_0, iter_60_1 in ipairs(arg_60_0._rawLightMats) do
		iter_60_1:SetFloat(ShaderPropertyId.ChangeTexture, arg_60_1)
	end

	if arg_60_2 then
		arg_60_0:addAllEffect()
		arg_60_0:playWeatherVoice()
	end

	arg_60_0:blendRoleLightMode(arg_60_1, arg_60_2)

	if arg_60_0._behaviourContainer then
		arg_60_0._behaviourContainer:changeBlendValue(arg_60_1, arg_60_2, arg_60_0._revert)
	end
end

function var_0_0.blendRoleLightMode(arg_61_0, arg_61_1, arg_61_2)
	if arg_61_1 ~= arg_61_0._targetValue then
		if not gohelper.isNil(arg_61_0._roleSharedMaterial) then
			arg_61_0._roleSharedMaterial:SetInt(arg_61_0._UseSecondMapId, 1)
		end
	elseif not gohelper.isNil(arg_61_0._roleSharedMaterial) then
		arg_61_0._roleSharedMaterial:SetInt(arg_61_0._UseSecondMapId, 0)
	end

	if arg_61_0._revert then
		arg_61_1 = 1 - arg_61_1
	end

	if arg_61_0._roleBlendCallback then
		arg_61_0._roleBlendCallback(arg_61_0._roleBlendCallbackTarget, arg_61_0, arg_61_1, arg_61_2)
	end

	if not arg_61_0._roleGo or not arg_61_0._dispatchParam then
		return
	end

	local var_61_0 = arg_61_0:lerpColorIntensity(arg_61_0._srcBloomColor or arg_61_0._targetBloomColor, arg_61_0._targetBloomColor, arg_61_1, true)

	PostProcessingMgr.instance:setLocalBloomColor(var_61_0)

	local var_61_1 = arg_61_0:lerpColorIntensity(arg_61_0._srcMainColor or arg_61_0._targetMainColor, arg_61_0._targetMainColor, arg_61_1)

	if not gohelper.isNil(arg_61_0._roleSharedMaterial) then
		arg_61_0._roleSharedMaterial:SetColor(arg_61_0._MainColorId, var_61_1)
	end

	arg_61_0:_setMainColor(var_61_1)

	local var_61_2 = arg_61_0:lerpColorIntensity(arg_61_0._srcEmissionColor or arg_61_0._targetEmissionColor, arg_61_0._targetEmissionColor, arg_61_1, true)

	if not gohelper.isNil(arg_61_0._roleSharedMaterial) then
		arg_61_0._roleSharedMaterial:SetColor(arg_61_0._EmissionColorId, var_61_2)
	end

	if arg_61_0._lightModel then
		arg_61_0._lightModel:setEmissionColor(var_61_2)
	end

	if arg_61_0._weatherController then
		arg_61_0._dispatchParam[1] = arg_61_1
		arg_61_0._dispatchParam[2] = arg_61_2

		arg_61_0._weatherController:dispatchEvent(WeatherEvent.OnRoleBlend, arg_61_0._dispatchParam)
	end
end

function var_0_0.addRoleBlendCallback(arg_62_0, arg_62_1, arg_62_2)
	arg_62_0._roleBlendCallback = arg_62_1
	arg_62_0._roleBlendCallbackTarget = arg_62_2
end

function var_0_0.addChangeReportCallback(arg_63_0, arg_63_1, arg_63_2, arg_63_3)
	arg_63_0._changeReportCallback = arg_63_1
	arg_63_0._changeReportCallbackTarget = arg_63_2

	if arg_63_3 then
		arg_63_0._changeReportCallback(arg_63_0._changeReportCallbackTarget, arg_63_0._curReport)
	end
end

function var_0_0._setMainColor(arg_64_0, arg_64_1)
	arg_64_0._mainColor = Color.New(arg_64_1.r, arg_64_1.g, arg_64_1.b, arg_64_1.a)

	if arg_64_0._lightModel then
		arg_64_0._lightModel:setMainColor(arg_64_1)
	end
end

function var_0_0.getMainColor(arg_65_0)
	return arg_65_0._mainColor
end

function var_0_0.lerpColorIntensity(arg_66_0, arg_66_1, arg_66_2, arg_66_3, arg_66_4)
	local var_66_0 = arg_66_1[1]
	local var_66_1 = arg_66_1[2]
	local var_66_2 = arg_66_2[1]
	local var_66_3 = arg_66_2[2]
	local var_66_4
	local var_66_5 = 0

	if arg_66_3 <= 0.5 then
		var_66_5 = Mathf.Lerp(var_66_1, 0, arg_66_3 / 0.5)
	else
		var_66_5 = Mathf.Lerp(0, var_66_3, (arg_66_3 - 0.5) / 0.5)
	end

	if arg_66_4 then
		if arg_66_3 <= 0.5 then
			var_66_4 = arg_66_0:lerpColor(var_66_0, arg_66_0._blackColor, arg_66_3 / 0.5, Mathf.Pow(2, var_66_5))
		else
			var_66_4 = arg_66_0:lerpColor(arg_66_0._blackColor, var_66_2, (arg_66_3 - 0.5) / 0.5, Mathf.Pow(2, var_66_5))
		end
	else
		var_66_4 = arg_66_0:lerpColor(var_66_0, var_66_2, arg_66_3, Mathf.Pow(2, var_66_5))
	end

	return var_66_4
end

function var_0_0.lerpColor(arg_67_0, arg_67_1, arg_67_2, arg_67_3, arg_67_4)
	arg_67_0._tempColor = arg_67_0._tempColor or Color.New()
	arg_67_0._tempColor.r, arg_67_0._tempColor.g, arg_67_0._tempColor.b = (arg_67_1.r + arg_67_3 * (arg_67_2.r - arg_67_1.r)) * arg_67_4, (arg_67_1.g + arg_67_3 * (arg_67_2.g - arg_67_1.g)) * arg_67_4, (arg_67_1.b + arg_67_3 * (arg_67_2.b - arg_67_1.b)) * arg_67_4
	arg_67_0._tempColor.a = arg_67_4

	return arg_67_0._tempColor
end

function var_0_0.lerpColorRGBA(arg_68_0, arg_68_1, arg_68_2, arg_68_3)
	arg_68_0._tempColor = arg_68_0._tempColor or Color.New()
	arg_68_0._tempColor.r, arg_68_0._tempColor.g, arg_68_0._tempColor.b, arg_68_0._tempColor.a = arg_68_1.r + arg_68_3 * (arg_68_2.r - arg_68_1.r), arg_68_1.g + arg_68_3 * (arg_68_2.g - arg_68_1.g), arg_68_1.b + arg_68_3 * (arg_68_2.b - arg_68_1.b), arg_68_1.a + arg_68_3 * (arg_68_2.a - arg_68_1.a)

	return arg_68_0._tempColor
end

function var_0_0.lerpVector4(arg_69_0, arg_69_1, arg_69_2, arg_69_3)
	arg_69_0._tempVector4 = arg_69_0._tempVector4 or Vector4.New()
	arg_69_0._tempVector4.x, arg_69_0._tempVector4.y, arg_69_0._tempVector4.z, arg_69_0._tempVector4.w = arg_69_1.x + arg_69_3 * (arg_69_2.x - arg_69_1.x), arg_69_1.y + arg_69_3 * (arg_69_2.y - arg_69_1.y), arg_69_1.z + arg_69_3 * (arg_69_2.z - arg_69_1.z), arg_69_1.w + arg_69_3 * (arg_69_2.w - arg_69_1.w)

	return arg_69_0._tempVector4
end

function var_0_0.changeLightEffectColor(arg_70_0)
	if not arg_70_0._effectLightPs or not arg_70_0._effectAirPs then
		return
	end

	local var_70_0 = MainSceneSwitchController.getLightColor(arg_70_0._curReport.lightMode, arg_70_0._sceneId)
	local var_70_1 = WeatherEnum.EffectAirColor[arg_70_0._curReport.lightMode]
	local var_70_2 = ZProj.ParticleSystemHelper

	var_70_2.SetStartColor(arg_70_0._effectLightPs, var_70_0[1] / 255, var_70_0[2] / 255, var_70_0[3] / 255, var_70_0[4] / 255)
	var_70_2.SetStartColor(arg_70_0._effectAirPs, var_70_1[1] / 255, var_70_1[2] / 255, var_70_1[3] / 255, var_70_1[4] / 255)
	gohelper.setActive(arg_70_0._effectLightPs, false)
	var_70_2.SetStartRotation(arg_70_0._effectLightPs, MainSceneSwitchController.getPrefabLightStartRotation(arg_70_0._curReport.lightMode, arg_70_0._sceneId))
	gohelper.setActive(arg_70_0._effectLightPs, true)
end

function var_0_0.removeAllEffect(arg_71_0)
	arg_71_0:_removeWeatherEffect()
end

function var_0_0._removeWeatherEffect(arg_72_0)
	if arg_72_0._effectLoader then
		arg_72_0._effectLoader:dispose()

		arg_72_0._effectLoader = nil
	end

	arg_72_0._weatherEffectGo = nil

	arg_72_0:_stopWeatherEffectAudio()
end

function var_0_0.addAllEffect(arg_73_0)
	arg_73_0:_addWeatherEffect()

	if arg_73_0._weatherController then
		arg_73_0._weatherController:dispatchEvent(WeatherEvent.LoadPhotoFrameBg)
	end
end

function var_0_0._addWeatherEffect(arg_74_0)
	if arg_74_0._prevReport and arg_74_0._prevReport.effect == arg_74_0._curReport.effect then
		arg_74_0:_setDynamicEffectLightStartRotation()

		return
	end

	if arg_74_0._curReport.effect <= 1 then
		return
	end

	if not arg_74_0._effectLoader then
		arg_74_0._effectLoader = PrefabInstantiate.Create(arg_74_0._sceneGo)

		local var_74_0 = arg_74_0:_getSceneResName()
		local var_74_1 = string.format(arg_74_0._effectPath, var_74_0, arg_74_0._curReport.effect - 1)

		arg_74_0._effectLoader:startLoad(var_74_1, arg_74_0._effectLoaded, arg_74_0)
	end
end

function var_0_0._effectLoaded(arg_75_0)
	local var_75_0 = arg_75_0._effectLoader:getInstGO()

	var_75_0.transform.parent = arg_75_0._effectRoot
	arg_75_0._weatherEffectGo = var_75_0
	arg_75_0._dynamicEffectLightPs = gohelper.findChildComponent(var_75_0, "m_s01_effect_light", var_0_0.TypeOfParticleSystem)

	arg_75_0:_setDynamicEffectLightStartRotation()
	arg_75_0:_playWeatherEffectAudio()
end

function var_0_0._setDynamicEffectLightStartRotation(arg_76_0)
	if not gohelper.isNil(arg_76_0._dynamicEffectLightPs) then
		gohelper.setActive(arg_76_0._dynamicEffectLightPs, false)
		ZProj.ParticleSystemHelper.SetStartRotation(arg_76_0._dynamicEffectLightPs, MainSceneSwitchController.getEffectLightStartRotation(arg_76_0._curReport.lightMode, arg_76_0._sceneId))
		gohelper.setActive(arg_76_0._dynamicEffectLightPs, true)
	end
end

function var_0_0._playVoice(arg_77_0)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main then
		return
	end

	local var_77_0 = WeatherEnum.LightMode[arg_77_0._curReport.lightMode]
	local var_77_1 = WeatherEnum.EffectMode[arg_77_0._curReport.effect]
	local var_77_2 = arg_77_0._prevEffect ~= arg_77_0._curReport.effect

	arg_77_0._prevEffect = arg_77_0._curReport.effect

	if var_77_2 and var_77_1 then
		if not arg_77_0._isSceneHide then
			var_0_1:setSwitch(arg_77_0:getId("WeatherState"), arg_77_0:getId(var_77_1))
		end

		arg_77_0._curWeatherEffect = var_77_1
		arg_77_0._curWeatherState = arg_77_0._curReport.effect
	end

	local var_77_3 = arg_77_0._prevLightMode ~= arg_77_0._curReport.lightMode

	arg_77_0._prevLightMode = arg_77_0._curReport.lightMode

	if var_77_3 and var_77_0 then
		if not arg_77_0._isSceneHide then
			var_0_1:setSwitch(arg_77_0:getId("Daytimestate"), arg_77_0:getId(var_77_0))
		end

		arg_77_0._curLightMode = var_77_0
	end

	print("===playVoice:", var_77_0, var_77_3, var_77_1, var_77_2)
end

function var_0_0.playWeatherAudio(arg_78_0)
	arg_78_0:_playVoice()
	arg_78_0:_playWeatherEffectAudio()
end

function var_0_0.stopWeatherAudio(arg_79_0)
	arg_79_0._prevLightMode = nil
	arg_79_0._prevEffect = nil
	arg_79_0._curWeatherEffect = nil
	arg_79_0._curWeatherState = nil
	arg_79_0._curLightMode = nil

	arg_79_0:_stopWeatherEffectAudio()
end

function var_0_0.setStateByString(arg_80_0, arg_80_1, arg_80_2)
	var_0_1:setState(arg_80_0:getId(arg_80_1), arg_80_0:getId(arg_80_2))
end

function var_0_0.getId(arg_81_0, arg_81_1)
	local var_81_0 = arg_81_0._str2Id[arg_81_1]

	if not var_81_0 then
		var_81_0 = var_0_1:getIdFromString(arg_81_1)
		arg_81_0._str2Id[arg_81_1] = var_81_0
	end

	return var_81_0
end

function var_0_0.initRoleParam(arg_82_0, arg_82_1)
	local var_82_0, var_82_1 = CharacterSwitchListModel.instance:getMainHero(arg_82_0._randomMainHero)

	arg_82_0._randomMainHero = false

	if not var_82_0 then
		return
	end

	local var_82_2 = HeroModel.instance:getByHeroId(var_82_0)

	if not var_82_2 then
		return
	end

	if not arg_82_0._blackColor then
		arg_82_0._blackColor = Color()
	end

	arg_82_0._srcBloomColor = arg_82_0._targetBloomColor
	arg_82_0._srcMainColor = arg_82_0._targetMainColor
	arg_82_0._srcEmissionColor = arg_82_0._targetEmissionColor
	arg_82_0._srcBloomFactor = arg_82_0._targetBloomFactor
	arg_82_0._srcPercent = arg_82_0._targetPercent
	arg_82_0._srcBloomFactor2 = arg_82_0._targetBloomFactor2
	arg_82_0._srcLuminance = arg_82_0._targetLuminance

	local var_82_3 = SkinConfig.instance:getSkinCo(var_82_1 or var_82_2.skin)

	if var_82_3 then
		local var_82_4 = WeatherConfig.instance:getSkinWeatherParam(var_82_3.weatherParam)

		if var_82_4 then
			local var_82_5 = arg_82_1.lightMode

			arg_82_0._targetBloomColor = arg_82_0:createColorIntensity(var_82_4["bloomColor" .. var_82_5])
			arg_82_0._targetMainColor = arg_82_0:createColorIntensity(var_82_4["mainColor" .. var_82_5])
			arg_82_0._targetEmissionColor = arg_82_0:createColorIntensity(var_82_4["emissionColor" .. var_82_5])
			arg_82_0._targetBloomFactor = WeatherEnum.BloomFactor
			arg_82_0._targetPercent = WeatherEnum.Percent
			arg_82_0._targetBloomFactor2 = WeatherEnum.BloomFactor2[var_82_5]
			arg_82_0._targetLuminance = WeatherEnum.Luminance[var_82_5]
		elseif isDebugBuild then
			local var_82_6 = var_82_3 and tostring(var_82_3.id) or "nil"
			local var_82_7 = var_82_3 and tostring(var_82_3.weatherParam) or "nil"

			logError(string.format("skin_%s 天气参数_%s P皮肤表.xlsx-export_皮肤天气颜色参数 未配置", var_82_6, var_82_7))
		end
	elseif isDebugBuild then
		local var_82_8 = tostring(var_82_2.heroId)
		local var_82_9 = tostring(var_82_1 or var_82_2.skin)

		logError(string.format("hero_%s skin_%s 皮肤id 不存在", var_82_8, var_82_9))
	end
end

function var_0_0.createColorIntensity(arg_83_0, arg_83_1)
	local var_83_0 = string.split(arg_83_1, "#")

	if not var_83_0 or #var_83_0 < 4 then
		logError("createColorIntensity rgbintensity error,report id:" .. arg_83_0._curReport.id .. " rgbintensityStr:" .. arg_83_1)

		return {
			Color.New(),
			0
		}
	end

	local var_83_1 = tonumber(var_83_0[1]) / 255
	local var_83_2 = tonumber(var_83_0[2]) / 255
	local var_83_3 = tonumber(var_83_0[3]) / 255
	local var_83_4 = tonumber(var_83_0[4])
	local var_83_5 = Color.New(var_83_1, var_83_2, var_83_3)

	return {
		var_83_5,
		var_83_4
	}
end

function var_0_0._resGC(arg_84_0)
	if arg_84_0._sceneGo then
		for iter_84_0, iter_84_1 in pairs(arg_84_0._lightMapPathPrefix) do
			for iter_84_2, iter_84_3 in pairs(arg_84_0._lightMats[iter_84_0]) do
				if not arg_84_0._revert then
					iter_84_3:SetTexture(ShaderPropertyId.MainTex, nil)
				else
					iter_84_3:SetTexture(ShaderPropertyId.MainTexSecond, nil)
				end
			end
		end

		if not arg_84_0._revert then
			if arg_84_0._srcLoader then
				arg_84_0._srcLoader:dispose()

				arg_84_0._srcLoader = nil
			end
		elseif arg_84_0._targetLoader then
			arg_84_0._targetLoader:dispose()

			arg_84_0._targetLoader = nil
		end

		SLFramework.UnityHelper.ResGC()
	end
end

function var_0_0._clearMats(arg_85_0)
	if not arg_85_0._rawLightMats then
		return
	end

	for iter_85_0, iter_85_1 in pairs(arg_85_0._rawLightMats) do
		iter_85_1:SetTexture(ShaderPropertyId.MainTex, nil)
		iter_85_1:SetTexture(ShaderPropertyId.MainTexSecond, nil)
	end
end

function var_0_0.onSceneShow(arg_86_0)
	if arg_86_0._isSceneHide == false then
		return
	end

	gohelper.setActive(arg_86_0._sceneGo, true)

	arg_86_0._isSceneHide = false

	if arg_86_0._curWeatherEffect then
		var_0_1:setSwitch(arg_86_0:getId("WeatherState"), arg_86_0:getId(arg_86_0._curWeatherEffect))
	end

	if arg_86_0._curLightMode then
		var_0_1:setSwitch(arg_86_0:getId("Daytimestate"), arg_86_0:getId(arg_86_0._curLightMode))
	end

	arg_86_0:_playWeatherEffectAudio()
end

function var_0_0._playWeatherEffectAudio(arg_87_0, arg_87_1)
	arg_87_0:_stopWeatherEffectAudio()

	if arg_87_0._curWeatherState and not gohelper.isNil(arg_87_0._weatherEffectGo) then
		local var_87_0 = WeatherEnum.EffectPlayAudio[arg_87_0._curWeatherState]

		if var_87_0 and not arg_87_0._isSceneHide then
			arg_87_0._stopWeatherEffectAudioId = WeatherEnum.EffectStopAudio[arg_87_0._curWeatherState]

			var_0_1:trigger(var_87_0)

			if not arg_87_1 then
				gohelper.setActive(arg_87_0._weatherEffectGo, false)
				gohelper.setActive(arg_87_0._weatherEffectGo, true)
			end

			TaskDispatcher.cancelTask(arg_87_0._repeatPlayEffectAndAudio, arg_87_0)
			TaskDispatcher.runDelay(arg_87_0._repeatPlayEffectAndAudio, arg_87_0, WeatherEnum.EffectAudioTime[arg_87_0._curWeatherState])
		end
	end
end

function var_0_0.onSceneHide(arg_88_0)
	gohelper.setActive(arg_88_0._sceneGo, false)

	arg_88_0._isSceneHide = true

	arg_88_0:_stopWeatherEffectAudio()
end

function var_0_0._stopWeatherEffectAudio(arg_89_0)
	if arg_89_0._stopWeatherEffectAudioId then
		var_0_1:trigger(arg_89_0._stopWeatherEffectAudioId)

		arg_89_0._stopWeatherEffectAudioId = nil
	end

	TaskDispatcher.cancelTask(arg_89_0._repeatPlayEffectAndAudio, arg_89_0)
end

function var_0_0._repeatPlayEffectAndAudio(arg_90_0)
	arg_90_0:_playWeatherEffectAudio(true)
end

function var_0_0.onSceneClose(arg_91_0)
	if arg_91_0._isMain then
		arg_91_0:_clearMats()

		arg_91_0._randomMainHero = true
	end

	if arg_91_0._srcLoader then
		arg_91_0._srcLoader:dispose()

		arg_91_0._srcLoader = nil
	end

	if arg_91_0._targetLoader then
		arg_91_0._targetLoader:dispose()

		arg_91_0._targetLoader = nil
	end

	if arg_91_0._effectLoader then
		arg_91_0._effectLoader:dispose()

		arg_91_0._effectLoader = nil
	end

	TaskDispatcher.cancelTask(arg_91_0._onUpdate, arg_91_0)
	TaskDispatcher.cancelTask(arg_91_0._onEffectUpdate, arg_91_0)
	TaskDispatcher.cancelTask(arg_91_0._checkReport, arg_91_0)
	TaskDispatcher.cancelTask(arg_91_0._resGC, arg_91_0)
	TaskDispatcher.cancelTask(arg_91_0._repeatPlayEffectAndAudio, arg_91_0)

	arg_91_0._sceneGo = nil
	arg_91_0._effectRoot = nil
	arg_91_0._lightMats = nil
	arg_91_0._matsMap = nil
	arg_91_0._lightSwitch = nil
	arg_91_0._rawLightMats = nil
	arg_91_0._rainEffectMat = nil
	arg_91_0._roleGo = nil
	arg_91_0._roleSharedMaterial = nil
	arg_91_0._postProcessMask = null
	arg_91_0._curReport = nil
	arg_91_0._prevReport = nil
	arg_91_0._srcReport = nil
	arg_91_0._targetReport = nil
	arg_91_0._animator = nil
	arg_91_0._prevEffect = nil
	arg_91_0._prevLightMode = nil
	arg_91_0._curWeatherEffect = nil
	arg_91_0._curLightMode = nil
	arg_91_0._curWeatherState = nil
	arg_91_0._isSceneHide = nil

	arg_91_0:_stopWeatherEffectAudio()

	arg_91_0._effectLightPs = nil
	arg_91_0._effectAirPs = nil
	arg_91_0._dynamicEffectLightPs = nil
	arg_91_0._heroPlayWeatherVoice = nil
	arg_91_0._lightModel = nil
	arg_91_0._changeRoleParam = nil
	arg_91_0._roleBlendCallback = nil
	arg_91_0._roleBlendCallbackTarget = nil
	arg_91_0._changeReportCallback = nil
	arg_91_0._changeReportCallbackTarget = nil
	arg_91_0._weatherEffectGo = nil
	arg_91_0._startTime = nil
	arg_91_0._effectStartTime = nil
	arg_91_0._reportEndTime = nil

	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseFullView, arg_91_0._onCloseFullView, arg_91_0)
	MainController.instance:unregisterCallback(MainEvent.OnShowSceneNewbieOpen, arg_91_0._OnShowSceneNewbieOpen, arg_91_0)
end

return var_0_0
