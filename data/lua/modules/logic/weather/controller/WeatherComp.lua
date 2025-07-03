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
end

function var_0_0.doCallback(arg_5_0)
	if not arg_5_0._callbackTarget then
		return
	end

	arg_5_0._callback(arg_5_0._callbackTarget)

	arg_5_0._callback = nil
	arg_5_0._callbackTarget = nil
end

function var_0_0.resetWeatherChangeVoiceFlag(arg_6_0)
	arg_6_0._weatherChangeVoice = false
end

function var_0_0.setLightModel(arg_7_0, arg_7_1)
	arg_7_0._lightModel = arg_7_1
end

function var_0_0.initRoleGo(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	arg_8_0._weatherChangeVoice = false
	arg_8_0._dispatchParam = arg_8_0._dispatchParam or {}

	arg_8_0:_changeRoleGo(arg_8_1, arg_8_2, arg_8_3, true, arg_8_5)

	if arg_8_4 then
		arg_8_0:playWeatherVoice(true)
	end
end

function var_0_0.changeRoleGo(arg_9_0, arg_9_1)
	arg_9_0:_changeRoleGo(arg_9_1.roleGo, arg_9_1.heroId, arg_9_1.sharedMaterial, arg_9_1.heroPlayWeatherVoice, arg_9_1.skinId)
end

function var_0_0.clearMat(arg_10_0)
	arg_10_0._roleSharedMaterial = nil
end

function var_0_0._changeRoleGo(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	arg_11_0._tempRoleParam = nil
	arg_11_0._changeRoleParam = {
		roleGo = arg_11_1,
		heroId = arg_11_2,
		sharedMaterial = arg_11_3,
		heroPlayWeatherVoice = arg_11_4,
		skinId = arg_11_5
	}
	arg_11_0._roleGo = arg_11_1
	arg_11_0._heroId = arg_11_2
	arg_11_0._skinId = arg_11_5
	arg_11_0._heroPlayWeatherVoice = arg_11_4
	arg_11_0._roleSharedMaterial = arg_11_3

	local var_11_0 = arg_11_1:GetComponent(PostProcessingMgr.PPEffectMaskType)

	if var_11_0 then
		arg_11_0._postProcessMask = var_11_0
	else
		arg_11_0._postProcessMask = nil
	end

	arg_11_0:initRoleParam(arg_11_0._curReport)
	arg_11_0:blendRoleLightMode(arg_11_0._targetValue, true)
end

function var_0_0.setRoleMaskEnabled(arg_12_0, arg_12_1)
	if not gohelper.isNil(arg_12_0._postProcessMask) then
		arg_12_0._postProcessMask.enabled = arg_12_1
	end
end

function var_0_0.playWeatherVoice(arg_13_0, arg_13_1)
	if not arg_13_0._weatherController then
		return
	end

	if arg_13_0._weatherChangeVoice or not arg_13_0._heroPlayWeatherVoice then
		return
	end

	local var_13_0 = false
	local var_13_1 = false
	local var_13_2 = arg_13_0._heroId
	local var_13_3 = HeroModel.instance:getVoiceConfig(var_13_2, CharacterEnum.VoiceType.WeatherChange, function(arg_14_0)
		local var_14_0 = string.split(arg_14_0.param, "#")

		for iter_14_0, iter_14_1 in ipairs(var_14_0) do
			local var_14_1 = tonumber(iter_14_1)

			if arg_13_0._prevReport and var_14_1 == arg_13_0._prevReport.id then
				var_13_0 = true
			end

			if var_14_1 == arg_13_0._curReport.id then
				var_13_1 = true
			end
		end

		return var_13_1
	end, arg_13_0._skinId)

	if var_13_3 and #var_13_3 > 0 and (arg_13_1 or var_13_0 == false and var_13_1 or math.random() <= 0.3) then
		local var_13_4 = var_13_3[1]
		local var_13_5 = MainHeroView.getRandomMultiVoice(var_13_4, arg_13_0._heroId, arg_13_0._skinId)

		arg_13_0._dispatchParam[1] = var_13_5
		arg_13_0._dispatchParam[2] = false

		arg_13_0._weatherController:dispatchEvent(WeatherEvent.PlayVoice, arg_13_0._dispatchParam)

		if arg_13_0._dispatchParam[2] then
			arg_13_0._weatherChangeVoice = true
		end
	end
end

function var_0_0.getSceneNode(arg_15_0, arg_15_1)
	return gohelper.findChild(arg_15_0._sceneGo, arg_15_1)
end

function var_0_0.playAnim(arg_16_0, arg_16_1)
	if not arg_16_0._animator then
		local var_16_0 = arg_16_0:getSceneNode("s01_obj_a/Anim")

		if var_16_0 then
			arg_16_0._animator = var_16_0:GetComponent(typeof(UnityEngine.Animator))
		end
	end

	if arg_16_0._animator and arg_16_0._sceneGo.activeInHierarchy then
		arg_16_0._animator:Play(arg_16_1)
	end
end

function var_0_0._onCloseSwitchSceneLoading(arg_17_0)
	arg_17_0:playAnim("s01_character_switch_bg")
end

function var_0_0._onStartSwitchScene(arg_18_0)
	arg_18_0._tempRoleParam = arg_18_0._changeRoleParam

	arg_18_0:onSceneClose()
end

function var_0_0._onSwitchSceneInitFinish(arg_19_0)
	if not arg_19_0._weatherController then
		return
	end

	if arg_19_0._isSceneHide then
		arg_19_0:onSceneHide()
	end

	if arg_19_0._startInitSceneTime then
		local var_19_0 = Time.realtimeSinceStartup - arg_19_0._startInitSceneTime
	end

	MainSceneSwitchController.instance:dispatchEvent(MainSceneSwitchEvent.SwitchSceneInitFinish)
end

function var_0_0._onSwitchSceneFinish(arg_20_0)
	local var_20_0 = GameSceneMgr.instance:getCurScene().level:getSceneGo()

	arg_20_0._startInitSceneTime = Time.realtimeSinceStartup

	arg_20_0:setSceneId(MainSceneSwitchModel.instance:getCurSceneId())
	arg_20_0:initSceneGo(var_20_0, arg_20_0._onSwitchSceneInitFinish, arg_20_0)

	if arg_20_0._tempRoleParam then
		local var_20_1 = arg_20_0._tempRoleParam

		arg_20_0._tempRoleParam = nil

		arg_20_0:_changeRoleGo(var_20_1.roleGo, var_20_1.heroId, var_20_1.sharedMaterial, var_20_1.heroPlayWeatherVoice, var_20_1.skinId)
	end
end

function var_0_0.changeReportId(arg_21_0, arg_21_1, arg_21_2)
	arg_21_0._reportId = arg_21_1
	arg_21_0._reportDeltaTime = arg_21_2

	if arg_21_0._sceneGo then
		arg_21_0:updateReport(false)
	end
end

function var_0_0.setSceneId(arg_22_0, arg_22_1)
	arg_22_0._sceneId = arg_22_1
end

function var_0_0._checkMatTexture(arg_23_0, arg_23_1)
	if arg_23_1:GetTexture(ShaderPropertyId.MainTex) then
		logError(string.format("_checkMatTexture mat:{%s} MainTex is not nil", arg_23_1.name))
	end

	if arg_23_1:GetTexture(ShaderPropertyId.MainTexSecond) then
		logError(string.format("_checkMatTexture mat:{%s} MainTexSecond is not nil", arg_23_1.name))
	end
end

function var_0_0.getSceneGo(arg_24_0)
	return arg_24_0._sceneGo
end

function var_0_0.initSceneGo(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	arg_25_0._revert = true

	if arg_25_0._isMain then
		WeatherModel.instance:initDay(arg_25_0._sceneId)
	end

	arg_25_0._sceneGo = arg_25_1

	local var_25_0 = arg_25_0:getSceneNode("s01_obj_a/Anim/Effect")

	arg_25_0._effectRoot = var_25_0.transform
	arg_25_0._effectLightPs = gohelper.findChildComponent(var_25_0, "m_s01_effect_light", var_0_0.TypeOfParticleSystem)
	arg_25_0._effectAirPs = gohelper.findChildComponent(var_25_0, "m_s01_effect_air", var_0_0.TypeOfParticleSystem)
	arg_25_0._lightSwitch = arg_25_1:GetComponent(var_0_0.TypeOfLightSwitch)
	arg_25_0._callback = arg_25_2
	arg_25_0._callbackTarget = arg_25_3

	local var_25_1 = SLFramework.FrameworkSettings.IsEditor
	local var_25_2 = arg_25_0._lightSwitch.lightMats

	arg_25_0._lightMats = {}
	arg_25_0._matsMap = {}
	arg_25_0._rawLightMats = {}
	arg_25_0._rainEffectMat = nil

	for iter_25_0 = 0, var_25_2.Length - 1 do
		local var_25_3 = var_25_2[iter_25_0]
		local var_25_4 = UnityEngine.Material.Instantiate(var_25_3)

		var_25_4.name = var_25_3.name
		var_25_2[iter_25_0] = var_25_4

		local var_25_5 = string.split(var_25_4.name, "#")
		local var_25_6 = var_25_5[1]
		local var_25_7 = var_25_5[2]

		arg_25_0._lightMats[var_25_6] = arg_25_0._lightMats[var_25_6] or {}

		table.insert(arg_25_0._lightMats[var_25_6], var_25_4)
		table.insert(arg_25_0._rawLightMats, var_25_4)

		arg_25_0._matsMap[var_25_4.name] = var_25_4

		if var_25_1 then
			arg_25_0:_checkMatTexture(var_25_4)
		end

		if string.find(var_25_6, "m_s01_obj_e$") then
			arg_25_0._rainEffectMat = var_25_4
		end
	end

	if not arg_25_0._rainEffectMat then
		logError("WeatherComp initSceneGo no rainEffectMat")
	end

	arg_25_0:_initMatReportSettings()

	if arg_25_0._isMain then
		ViewMgr.instance:registerCallback(ViewEvent.OnCloseFullView, arg_25_0._onCloseFullView, arg_25_0)
		MainController.instance:registerCallback(MainEvent.OnShowSceneNewbieOpen, arg_25_0._OnShowSceneNewbieOpen, arg_25_0)
		arg_25_0._weatherController:updateOtherComps(arg_25_1)
	end

	arg_25_0:updateReport(false)
end

function var_0_0._initMatReportSettings(arg_26_0)
	arg_26_0._matReportSettings = WeatherConfig.instance:getMatReportSettings(arg_26_0._sceneId)

	if SLFramework.FrameworkSettings.IsEditor and arg_26_0._matReportSettings then
		for iter_26_0, iter_26_1 in pairs(arg_26_0._matReportSettings) do
			local var_26_0 = arg_26_0._matsMap[iter_26_0]

			if not var_26_0 then
				logError(string.format("WeatherComp _initMatReportSettings mat:{%s} is nil", iter_26_0))
			elseif var_26_0:GetTexture(ShaderPropertyId.LightMap) then
				logError(string.format("WeatherComp _initMatReportSettings mat:{%s} LightMap is not nil", iter_26_0))
			end
		end
	end
end

function var_0_0._OnShowSceneNewbieOpen(arg_27_0)
	callWithCatch(arg_27_0._playNewbieShowAnim, arg_27_0)
end

function var_0_0._playNewbieShowAnim(arg_28_0)
	arg_28_0:playAnim("s01_character_switch_xingshou")
end

function var_0_0._onCloseFullView(arg_29_0, arg_29_1)
	if not ViewMgr.instance:hasOpenFullView() then
		arg_29_0:_checkReport()
	end
end

function var_0_0.setReportId(arg_30_0, arg_30_1)
	local var_30_0 = lua_weather_report.configDict[arg_30_1]
	local var_30_1 = 60

	if var_30_0 and var_30_1 then
		print(WeatherModel.instance:debug(var_30_0.id, arg_30_0._sceneId))
		arg_30_0:setReport(var_30_0)

		if not arg_30_0._reportEndTime then
			TaskDispatcher.runRepeat(arg_30_0._checkReport, arg_30_0, 60)
		end

		arg_30_0._reportEndTime = os.time() + var_30_1

		if arg_30_0._weatherController then
			arg_30_0._weatherController:dispatchEvent(WeatherEvent.WeatherChanged, var_30_0.id, var_30_1)
		end
	end
end

function var_0_0.updateReport(arg_31_0, arg_31_1)
	local var_31_0, var_31_1 = WeatherModel.instance:getReport()
	local var_31_2, var_31_3 = xpcall(arg_31_0._getWelcomeReport, __G__TRACKBACK__, arg_31_0)

	if var_31_2 and var_31_3 then
		var_31_0 = var_31_3
		var_31_1 = 3600
	end

	if GuideModel.instance:isDoingFirstGuide() then
		var_31_0, var_31_1 = lua_weather_report.configDict[2], 86400
	end

	if arg_31_0._reportId and arg_31_0._reportDeltaTime then
		var_31_0 = lua_weather_report.configDict[arg_31_0._reportId]
		var_31_1 = arg_31_0._reportDeltaTime
	end

	if var_31_0 and var_31_1 then
		print(WeatherModel.instance:debug(var_31_0.id, arg_31_0._sceneId))
		arg_31_0:setReport(var_31_0)

		if not arg_31_0._reportEndTime then
			TaskDispatcher.runRepeat(arg_31_0._checkReport, arg_31_0, 60)
		end

		arg_31_0._reportEndTime = os.time() + var_31_1

		if arg_31_1 and arg_31_0._weatherController then
			arg_31_0._weatherController:dispatchEvent(WeatherEvent.WeatherChanged, var_31_0.id, var_31_1)
		end
	else
		logError(string.format("WeatherComp:updateReport error,curReport:%s,deltaTime:%s", var_31_0, var_31_1))
	end
end

function var_0_0._getWelcomeReport(arg_32_0)
	if not MainThumbnailWork._checkShow() then
		return
	end

	local var_32_0, var_32_1 = CharacterSwitchListModel.instance:getMainHero()
	local var_32_2 = MainHeroView.getWelcomeLikeVoice(CharacterEnum.VoiceType.MainViewWelcome, var_32_0, var_32_1)

	if not var_32_2 then
		return
	end

	local var_32_3 = string.split(var_32_2.time, "#")
	local var_32_4 = string.split(var_32_3[1], ":")
	local var_32_5 = tonumber(var_32_4[1]) < 12

	return (WeatherConfig.instance:getRandomReport(var_32_5 and WeatherEnum.LightModeDuring or WeatherEnum.LightModeDusk, arg_32_0._sceneId))
end

function var_0_0._checkReport(arg_33_0)
	if ViewMgr.instance:hasOpenFullView() then
		return
	end

	if not arg_33_0._isSceneHide and arg_33_0._reportEndTime and arg_33_0._reportEndTime <= os.time() then
		arg_33_0:updateReport(true)
	end
end

function var_0_0.getPrevLightMode(arg_34_0)
	return arg_34_0._prevReport and arg_34_0._prevReport.lightMode
end

function var_0_0.getCurLightMode(arg_35_0)
	return arg_35_0._curReport and arg_35_0._curReport.lightMode
end

function var_0_0._finishAllUpdate(arg_36_0)
	if arg_36_0._effectStartTime then
		arg_36_0:_onEffectUpdateHandler(arg_36_0._effectStartTime + 5)
	end

	if arg_36_0._startTime then
		arg_36_0:_onUpdateHandler(arg_36_0._startTime + 5)
	end
end

function var_0_0.setReport(arg_37_0, arg_37_1)
	if arg_37_0._curReport and arg_37_1.id == arg_37_0._curReport.id then
		return
	end

	if not WeatherConfig.instance:sceneContainReport(arg_37_0._sceneId, arg_37_1.id) then
		logError(string.format("WeatherComp setReport sceneId:%s,reportId:%s,not in scene", arg_37_0._sceneId, arg_37_1.id))

		arg_37_1 = lua_weather_report.configDict[1]
	end

	arg_37_0:_finishAllUpdate()

	arg_37_0._prevReport = arg_37_0._curReport
	arg_37_0._curReport = arg_37_1
	arg_37_0.reportLightMode = arg_37_0._curReport.lightMode

	if arg_37_0._changeReportCallback then
		arg_37_0._changeReportCallback(arg_37_0._changeReportCallbackTarget, arg_37_0._curReport)
	end

	if arg_37_0._prevReport and arg_37_0._prevReport.effect ~= arg_37_0._curReport.effect then
		arg_37_0:removeAllEffect()
	end

	arg_37_0:_playVoice()

	if arg_37_0._prevReport and arg_37_0._prevReport.lightMode == arg_37_0._curReport.lightMode then
		arg_37_0:addAllEffect()
		arg_37_0:startEffectBlend()
		arg_37_0:playWeatherVoice()

		return
	end

	arg_37_0:changeLightEffectColor()
	arg_37_0:initRoleParam(arg_37_0._curReport)
	arg_37_0:startSwitchReport(arg_37_0._prevReport, arg_37_0._curReport)
end

function var_0_0.getCurrReport(arg_38_0)
	return arg_38_0._curReport
end

function var_0_0.startSwitchReport(arg_39_0, arg_39_1, arg_39_2)
	arg_39_0._speed = 0.5
	arg_39_0._revert = not arg_39_0._revert

	if arg_39_0._revert then
		arg_39_0._startValue = 1
		arg_39_0._targetValue = 0
		arg_39_0._srcReport = arg_39_2
		arg_39_0._targetReport = arg_39_1
	else
		arg_39_0._startValue = 0
		arg_39_0._targetValue = 1
		arg_39_0._srcReport = arg_39_1
		arg_39_0._targetReport = arg_39_2
	end

	arg_39_0._deltaValue = arg_39_0._targetValue - arg_39_0._startValue

	arg_39_0:switchLight(arg_39_0._srcReport and arg_39_0._srcReport.lightMode - 1 or nil, arg_39_0._targetReport.lightMode - 1)
end

function var_0_0.switchLight(arg_40_0, arg_40_1, arg_40_2)
	arg_40_0:_startLoad(arg_40_1, arg_40_2)
end

function var_0_0._getSceneResName(arg_41_0)
	return arg_41_0._sceneResName or MainSceneSwitchModel.instance:getCurSceneResName()
end

function var_0_0.setSceneResName(arg_42_0, arg_42_1)
	arg_42_0._sceneResName = arg_42_1
end

function var_0_0._startLoad(arg_43_0, arg_43_1, arg_43_2)
	TaskDispatcher.cancelTask(arg_43_0._resGC, arg_43_0)
	TaskDispatcher.cancelTask(arg_43_0._repeatPlayEffectAndAudio, arg_43_0)

	arg_43_0._reportSrc = arg_43_1
	arg_43_0._reportTarget = arg_43_2

	if arg_43_0._srcLoader then
		arg_43_0._srcLoader:dispose()

		arg_43_0._srcLoader = nil
	end

	if arg_43_0._targetLoader then
		arg_43_0._targetLoader:dispose()

		arg_43_0._targetLoader = nil
	end

	local var_43_0 = arg_43_0:_getSceneResName()
	local var_43_1 = {}
	local var_43_2 = {}
	local var_43_3 = {}

	for iter_43_0, iter_43_1 in pairs(arg_43_0._lightMats) do
		local var_43_4 = var_43_1[iter_43_0] or {}

		if arg_43_1 then
			local var_43_5 = string.format(arg_43_0._lightMapPath, var_43_0, iter_43_0, arg_43_1)

			table.insert(var_43_2, var_43_5)

			var_43_4[arg_43_1] = var_43_5
		end

		local var_43_6 = string.format(arg_43_0._lightMapPath, var_43_0, iter_43_0, arg_43_2)

		table.insert(var_43_3, var_43_6)

		var_43_4[arg_43_2] = var_43_6
		var_43_1[iter_43_0] = var_43_4
	end

	arg_43_0._lightMapPathPrefix = var_43_1
	arg_43_0._loadFinishNum = 0

	if #var_43_2 > 0 then
		arg_43_0._loadMaxNum = 2
		arg_43_0._srcLoader = MultiAbLoader.New()

		arg_43_0._srcLoader:setPathList(var_43_2)
		arg_43_0._srcLoader:startLoad(arg_43_0._onLoadOneDone, arg_43_0)
	else
		arg_43_0._loadMaxNum = 1
	end

	if arg_43_0._matReportSettings and #var_43_3 > 0 then
		for iter_43_2, iter_43_3 in pairs(arg_43_0._matReportSettings) do
			local var_43_7 = iter_43_3[arg_43_0._curReport.lightMode]

			if var_43_7 then
				table.insert(var_43_3, var_43_7)
			end
		end
	end

	if #var_43_3 > 0 then
		arg_43_0._targetLoader = MultiAbLoader.New()

		arg_43_0._targetLoader:setPathList(var_43_3)
		arg_43_0._targetLoader:startLoad(arg_43_0._onLoadOneDone, arg_43_0)
	end
end

function var_0_0._onLoadOneDone(arg_44_0)
	arg_44_0._loadFinishNum = arg_44_0._loadFinishNum + 1

	if arg_44_0._loadFinishNum < arg_44_0._loadMaxNum then
		return
	end

	arg_44_0:_loadTexturesFinish(arg_44_0._srcLoader, arg_44_0._targetLoader, arg_44_0._lightMapPathPrefix, arg_44_0._reportSrc, arg_44_0._reportTarget)
end

function var_0_0._loadTexturesFinish(arg_45_0, arg_45_1, arg_45_2, arg_45_3, arg_45_4, arg_45_5)
	arg_45_0:doCallback()

	local var_45_0

	for iter_45_0, iter_45_1 in pairs(arg_45_3) do
		if arg_45_4 then
			local var_45_1 = iter_45_1[arg_45_4]

			var_45_0 = arg_45_1:getAssetItem(var_45_1):GetResource(var_45_1)
		end

		local var_45_2 = iter_45_1[arg_45_5]
		local var_45_3 = arg_45_2:getAssetItem(var_45_2):GetResource(var_45_2)

		for iter_45_2, iter_45_3 in pairs(arg_45_0._lightMats[iter_45_0]) do
			if arg_45_4 then
				iter_45_3:SetTexture(ShaderPropertyId.MainTex, var_45_0)
			end

			iter_45_3:SetTexture(ShaderPropertyId.MainTexSecond, var_45_3)
		end
	end

	arg_45_0:_setMatReportLightMap(arg_45_2)
	arg_45_0:_setSceneMatMapCfg(1, 1)
	TaskDispatcher.runDelay(arg_45_0._resGC, arg_45_0, 3)

	if arg_45_4 then
		arg_45_0:startLightBlend()
		arg_45_0:startEffectBlend()
	else
		arg_45_0:_changeBlendValue(arg_45_0._targetValue, true)
		arg_45_0:_changeEffectBlendValue(1, true)
		arg_45_0:_updateSceneMatMapCfg()
	end

	arg_45_0:_resetMats()
end

function var_0_0._setMatReportLightMap(arg_46_0, arg_46_1)
	if not arg_46_0._matReportSettings then
		return
	end

	for iter_46_0, iter_46_1 in pairs(arg_46_0._matReportSettings) do
		local var_46_0 = arg_46_0._matsMap[iter_46_0]
		local var_46_1 = iter_46_1[arg_46_0._curReport.lightMode]

		if var_46_1 then
			if var_46_0 then
				local var_46_2 = arg_46_1:getAssetItem(var_46_1)
				local var_46_3 = var_46_2 and var_46_2:GetResource(var_46_1)

				if var_46_3 then
					var_46_0:SetTexture(ShaderPropertyId.LightMap, var_46_3)
				else
					logError(string.format("WeatherComp:_setMatReportLightMap targetTexture is nil, path: %s", var_46_1))
				end
			end
		elseif var_46_0 then
			var_46_0:SetTexture(ShaderPropertyId.LightMap, nil)
		end
	end
end

function var_0_0._resetMats(arg_47_0)
	arg_47_0:_resetGoMats(arg_47_0:getSceneNode("s01_obj_a/Anim/Sky"))
	arg_47_0:_resetGoMats(arg_47_0:getSceneNode("s01_obj_a/Anim/Ground"))
	arg_47_0:_resetGoMats(arg_47_0:getSceneNode("s01_obj_a/Anim/Obj"))
end

function var_0_0._resetGoMats(arg_48_0, arg_48_1)
	local var_48_0 = arg_48_1:GetComponentsInChildren(typeof(UnityEngine.MeshRenderer), true)

	if var_48_0 then
		for iter_48_0 = 0, var_48_0.Length - 1 do
			local var_48_1 = var_48_0[iter_48_0]
			local var_48_2 = var_48_1.sharedMaterial
			local var_48_3 = var_48_2 and string.split(var_48_2.name, " ")[1]

			if var_48_3 and arg_48_0._matsMap[var_48_3] then
				var_48_1.sharedMaterial = arg_48_0._matsMap[var_48_3]
			end
		end
	end
end

function var_0_0.startEffectBlend(arg_49_0)
	arg_49_0._effectStartTime = Time.time

	TaskDispatcher.runRepeat(arg_49_0._onEffectUpdate, arg_49_0, 0.033)
end

function var_0_0._onEffectUpdate(arg_50_0)
	arg_50_0:_onEffectUpdateHandler(Time.time)
end

function var_0_0._onEffectUpdateHandler(arg_51_0, arg_51_1)
	local var_51_0 = (arg_51_1 - arg_51_0._effectStartTime) * arg_51_0._speed
	local var_51_1 = var_51_0 >= 1 or var_51_0 <= 0
	local var_51_2 = var_51_0

	if var_51_1 then
		if var_51_0 > 1 then
			var_51_2 = 1
		elseif var_51_0 < 0 then
			var_51_2 = 0
		end
	end

	if var_51_1 then
		arg_51_0._effectStartTime = nil

		TaskDispatcher.cancelTask(arg_51_0._onEffectUpdate, arg_51_0)
	end

	arg_51_0:_changeEffectBlendValue(var_51_2, var_51_1)
end

function var_0_0._changeEffectBlendValue(arg_52_0, arg_52_1, arg_52_2)
	if not arg_52_0._rainEffectMat then
		return
	end

	local var_52_0 = arg_52_0._prevReport or arg_52_0._curReport
	local var_52_1 = arg_52_0._curReport

	if not var_52_0 or not var_52_1 then
		logError("WeatherComp _changeEffectBlendValue prevReport or curReport is nil")

		return
	end

	local var_52_2 = arg_52_0:_getRainEffectValue(WeatherEnum.RainOn, var_52_1.effect)
	local var_52_3 = arg_52_0:_getRainEffectValue(WeatherEnum.RainValue, var_52_1.effect)

	if var_52_2 == 1 then
		arg_52_0._rainEffectMat:EnableKeyword("_RAIN_ON")
		arg_52_0._rainEffectMat:SetInt(arg_52_0._RainId, var_52_3)
	elseif arg_52_2 then
		arg_52_0._rainEffectMat:DisableKeyword("_RAIN_ON")
		arg_52_0._rainEffectMat:SetInt(arg_52_0._RainId, var_52_3)
	end

	local var_52_4 = arg_52_0:_getRainEffectValue(WeatherEnum.RainDistortionFactor, var_52_0.effect)
	local var_52_5 = arg_52_0:_getRainEffectValue(WeatherEnum.RainDistortionFactor, var_52_1.effect)
	local var_52_6 = arg_52_0:lerpVector4(var_52_4, var_52_5, arg_52_1)

	arg_52_0._rainEffectMat:SetVector(arg_52_0._RainDistortionFactorId, var_52_6)

	local var_52_7 = arg_52_0:_getRainEffectValue(WeatherEnum.RainEmission, var_52_0.effect)
	local var_52_8 = arg_52_0:_getRainEffectValue(WeatherEnum.RainEmission, var_52_1.effect)
	local var_52_9 = arg_52_0:lerpVector4(var_52_7, var_52_8, arg_52_1)

	arg_52_0._rainEffectMat:SetVector(arg_52_0._RainEmissionId, var_52_9)
end

function var_0_0._getRainEffectValue(arg_53_0, arg_53_1, arg_53_2)
	return arg_53_1[arg_53_2] or arg_53_1[WeatherEnum.Default]
end

function var_0_0.startLightBlend(arg_54_0)
	arg_54_0._startTime = Time.time

	TaskDispatcher.runRepeat(arg_54_0._onUpdate, arg_54_0, 0.033)
end

function var_0_0._onUpdate(arg_55_0)
	arg_55_0:_onUpdateHandler(Time.time)
end

function var_0_0._onUpdateHandler(arg_56_0, arg_56_1)
	local var_56_0 = arg_56_0._startValue + arg_56_0._deltaValue * (arg_56_1 - arg_56_0._startTime) * arg_56_0._speed
	local var_56_1 = var_56_0 >= 1 or var_56_0 <= 0
	local var_56_2 = var_56_0

	if var_56_1 then
		if var_56_0 > 1 then
			var_56_2 = 1
		elseif var_56_0 < 0 then
			var_56_2 = 0
		end
	end

	if var_56_1 then
		TaskDispatcher.cancelTask(arg_56_0._onUpdate, arg_56_0)

		arg_56_0._startTime = nil

		arg_56_0:_updateSceneMatMapCfg()
	end

	arg_56_0:_changeBlendValue(var_56_2, var_56_1)
end

function var_0_0._updateSceneMatMapCfg(arg_57_0)
	if arg_57_0._targetValue >= 1 then
		arg_57_0:_setSceneMatMapCfg(0, 1)
	else
		arg_57_0:_setSceneMatMapCfg(1, 0)
	end
end

function var_0_0._setSceneMatMapCfg(arg_58_0, arg_58_1, arg_58_2)
	if arg_58_1 == 0 and arg_58_2 == 0 then
		logError("useFirst useSecond 不能同时为0！ ")

		return
	end

	for iter_58_0, iter_58_1 in pairs(arg_58_0._rawLightMats) do
		local var_58_0 = arg_58_0._UseFirstMapKey

		if arg_58_1 == 1 then
			iter_58_1:EnableKeyword(var_58_0)
		else
			iter_58_1:DisableKeyword(var_58_0)
		end

		local var_58_1 = arg_58_0._UseSecondMapKey

		if arg_58_2 == 1 then
			iter_58_1:EnableKeyword(var_58_1)
		else
			iter_58_1:DisableKeyword(var_58_1)
		end
	end
end

function var_0_0._changeBlendValue(arg_59_0, arg_59_1, arg_59_2)
	for iter_59_0, iter_59_1 in ipairs(arg_59_0._rawLightMats) do
		iter_59_1:SetFloat(ShaderPropertyId.ChangeTexture, arg_59_1)
	end

	if arg_59_2 then
		arg_59_0:addAllEffect()
		arg_59_0:playWeatherVoice()
	end

	arg_59_0:blendRoleLightMode(arg_59_1, arg_59_2)
end

function var_0_0.blendRoleLightMode(arg_60_0, arg_60_1, arg_60_2)
	if arg_60_1 ~= arg_60_0._targetValue then
		if not gohelper.isNil(arg_60_0._roleSharedMaterial) then
			arg_60_0._roleSharedMaterial:SetInt(arg_60_0._UseSecondMapId, 1)
		end
	elseif not gohelper.isNil(arg_60_0._roleSharedMaterial) then
		arg_60_0._roleSharedMaterial:SetInt(arg_60_0._UseSecondMapId, 0)
	end

	if arg_60_0._revert then
		arg_60_1 = 1 - arg_60_1
	end

	if arg_60_0._roleBlendCallback then
		arg_60_0._roleBlendCallback(arg_60_0._roleBlendCallbackTarget, arg_60_0, arg_60_1, arg_60_2)
	end

	if not arg_60_0._roleGo or not arg_60_0._dispatchParam then
		return
	end

	local var_60_0 = arg_60_0:lerpColorIntensity(arg_60_0._srcBloomColor or arg_60_0._targetBloomColor, arg_60_0._targetBloomColor, arg_60_1, true)

	PostProcessingMgr.instance:setLocalBloomColor(var_60_0)

	local var_60_1 = arg_60_0:lerpColorIntensity(arg_60_0._srcMainColor or arg_60_0._targetMainColor, arg_60_0._targetMainColor, arg_60_1)

	if not gohelper.isNil(arg_60_0._roleSharedMaterial) then
		arg_60_0._roleSharedMaterial:SetColor(arg_60_0._MainColorId, var_60_1)
	end

	arg_60_0:_setMainColor(var_60_1)

	local var_60_2 = arg_60_0:lerpColorIntensity(arg_60_0._srcEmissionColor or arg_60_0._targetEmissionColor, arg_60_0._targetEmissionColor, arg_60_1, true)

	if not gohelper.isNil(arg_60_0._roleSharedMaterial) then
		arg_60_0._roleSharedMaterial:SetColor(arg_60_0._EmissionColorId, var_60_2)
	end

	if arg_60_0._lightModel then
		arg_60_0._lightModel:setEmissionColor(var_60_2)
	end

	if arg_60_0._weatherController then
		arg_60_0._dispatchParam[1] = arg_60_1
		arg_60_0._dispatchParam[2] = arg_60_2

		arg_60_0._weatherController:dispatchEvent(WeatherEvent.OnRoleBlend, arg_60_0._dispatchParam)
	end
end

function var_0_0.addRoleBlendCallback(arg_61_0, arg_61_1, arg_61_2)
	arg_61_0._roleBlendCallback = arg_61_1
	arg_61_0._roleBlendCallbackTarget = arg_61_2
end

function var_0_0.addChangeReportCallback(arg_62_0, arg_62_1, arg_62_2, arg_62_3)
	arg_62_0._changeReportCallback = arg_62_1
	arg_62_0._changeReportCallbackTarget = arg_62_2

	if arg_62_3 then
		arg_62_0._changeReportCallback(arg_62_0._changeReportCallbackTarget, arg_62_0._curReport)
	end
end

function var_0_0._setMainColor(arg_63_0, arg_63_1)
	arg_63_0._mainColor = Color.New(arg_63_1.r, arg_63_1.g, arg_63_1.b, arg_63_1.a)

	if arg_63_0._lightModel then
		arg_63_0._lightModel:setMainColor(arg_63_1)
	end
end

function var_0_0.getMainColor(arg_64_0)
	return arg_64_0._mainColor
end

function var_0_0.lerpColorIntensity(arg_65_0, arg_65_1, arg_65_2, arg_65_3, arg_65_4)
	local var_65_0 = arg_65_1[1]
	local var_65_1 = arg_65_1[2]
	local var_65_2 = arg_65_2[1]
	local var_65_3 = arg_65_2[2]
	local var_65_4
	local var_65_5 = 0

	if arg_65_3 <= 0.5 then
		var_65_5 = Mathf.Lerp(var_65_1, 0, arg_65_3 / 0.5)
	else
		var_65_5 = Mathf.Lerp(0, var_65_3, (arg_65_3 - 0.5) / 0.5)
	end

	if arg_65_4 then
		if arg_65_3 <= 0.5 then
			var_65_4 = arg_65_0:lerpColor(var_65_0, arg_65_0._blackColor, arg_65_3 / 0.5, Mathf.Pow(2, var_65_5))
		else
			var_65_4 = arg_65_0:lerpColor(arg_65_0._blackColor, var_65_2, (arg_65_3 - 0.5) / 0.5, Mathf.Pow(2, var_65_5))
		end
	else
		var_65_4 = arg_65_0:lerpColor(var_65_0, var_65_2, arg_65_3, Mathf.Pow(2, var_65_5))
	end

	return var_65_4
end

function var_0_0.lerpColor(arg_66_0, arg_66_1, arg_66_2, arg_66_3, arg_66_4)
	arg_66_0._tempColor = arg_66_0._tempColor or Color.New()
	arg_66_0._tempColor.r, arg_66_0._tempColor.g, arg_66_0._tempColor.b = (arg_66_1.r + arg_66_3 * (arg_66_2.r - arg_66_1.r)) * arg_66_4, (arg_66_1.g + arg_66_3 * (arg_66_2.g - arg_66_1.g)) * arg_66_4, (arg_66_1.b + arg_66_3 * (arg_66_2.b - arg_66_1.b)) * arg_66_4
	arg_66_0._tempColor.a = arg_66_4

	return arg_66_0._tempColor
end

function var_0_0.lerpColorRGBA(arg_67_0, arg_67_1, arg_67_2, arg_67_3)
	arg_67_0._tempColor = arg_67_0._tempColor or Color.New()
	arg_67_0._tempColor.r, arg_67_0._tempColor.g, arg_67_0._tempColor.b, arg_67_0._tempColor.a = arg_67_1.r + arg_67_3 * (arg_67_2.r - arg_67_1.r), arg_67_1.g + arg_67_3 * (arg_67_2.g - arg_67_1.g), arg_67_1.b + arg_67_3 * (arg_67_2.b - arg_67_1.b), arg_67_1.a + arg_67_3 * (arg_67_2.a - arg_67_1.a)

	return arg_67_0._tempColor
end

function var_0_0.lerpVector4(arg_68_0, arg_68_1, arg_68_2, arg_68_3)
	arg_68_0._tempVector4 = arg_68_0._tempVector4 or Vector4.New()
	arg_68_0._tempVector4.x, arg_68_0._tempVector4.y, arg_68_0._tempVector4.z, arg_68_0._tempVector4.w = arg_68_1.x + arg_68_3 * (arg_68_2.x - arg_68_1.x), arg_68_1.y + arg_68_3 * (arg_68_2.y - arg_68_1.y), arg_68_1.z + arg_68_3 * (arg_68_2.z - arg_68_1.z), arg_68_1.w + arg_68_3 * (arg_68_2.w - arg_68_1.w)

	return arg_68_0._tempVector4
end

function var_0_0.changeLightEffectColor(arg_69_0)
	if not arg_69_0._effectLightPs or not arg_69_0._effectAirPs then
		return
	end

	local var_69_0 = MainSceneSwitchController.getLightColor(arg_69_0._curReport.lightMode, arg_69_0._sceneId)
	local var_69_1 = WeatherEnum.EffectAirColor[arg_69_0._curReport.lightMode]
	local var_69_2 = ZProj.ParticleSystemHelper

	var_69_2.SetStartColor(arg_69_0._effectLightPs, var_69_0[1] / 255, var_69_0[2] / 255, var_69_0[3] / 255, var_69_0[4] / 255)
	var_69_2.SetStartColor(arg_69_0._effectAirPs, var_69_1[1] / 255, var_69_1[2] / 255, var_69_1[3] / 255, var_69_1[4] / 255)
	gohelper.setActive(arg_69_0._effectLightPs, false)
	var_69_2.SetStartRotation(arg_69_0._effectLightPs, MainSceneSwitchController.getPrefabLightStartRotation(arg_69_0._curReport.lightMode, arg_69_0._sceneId))
	gohelper.setActive(arg_69_0._effectLightPs, true)
end

function var_0_0.removeAllEffect(arg_70_0)
	arg_70_0:_removeWeatherEffect()
end

function var_0_0._removeWeatherEffect(arg_71_0)
	if arg_71_0._effectLoader then
		arg_71_0._effectLoader:dispose()

		arg_71_0._effectLoader = nil
	end

	arg_71_0._weatherEffectGo = nil

	arg_71_0:_stopWeatherEffectAudio()
end

function var_0_0.addAllEffect(arg_72_0)
	arg_72_0:_addWeatherEffect()

	if arg_72_0._weatherController then
		arg_72_0._weatherController:dispatchEvent(WeatherEvent.LoadPhotoFrameBg)
	end
end

function var_0_0._addWeatherEffect(arg_73_0)
	if arg_73_0._prevReport and arg_73_0._prevReport.effect == arg_73_0._curReport.effect then
		arg_73_0:_setDynamicEffectLightStartRotation()

		return
	end

	if arg_73_0._curReport.effect <= 1 then
		return
	end

	if not arg_73_0._effectLoader then
		arg_73_0._effectLoader = PrefabInstantiate.Create(arg_73_0._sceneGo)

		local var_73_0 = arg_73_0:_getSceneResName()
		local var_73_1 = string.format(arg_73_0._effectPath, var_73_0, arg_73_0._curReport.effect - 1)

		arg_73_0._effectLoader:startLoad(var_73_1, arg_73_0._effectLoaded, arg_73_0)
	end
end

function var_0_0._effectLoaded(arg_74_0)
	local var_74_0 = arg_74_0._effectLoader:getInstGO()

	var_74_0.transform.parent = arg_74_0._effectRoot
	arg_74_0._weatherEffectGo = var_74_0
	arg_74_0._dynamicEffectLightPs = gohelper.findChildComponent(var_74_0, "m_s01_effect_light", var_0_0.TypeOfParticleSystem)

	arg_74_0:_setDynamicEffectLightStartRotation()
	arg_74_0:_playWeatherEffectAudio()
end

function var_0_0._setDynamicEffectLightStartRotation(arg_75_0)
	if not gohelper.isNil(arg_75_0._dynamicEffectLightPs) then
		gohelper.setActive(arg_75_0._dynamicEffectLightPs, false)
		ZProj.ParticleSystemHelper.SetStartRotation(arg_75_0._dynamicEffectLightPs, MainSceneSwitchController.getEffectLightStartRotation(arg_75_0._curReport.lightMode, arg_75_0._sceneId))
		gohelper.setActive(arg_75_0._dynamicEffectLightPs, true)
	end
end

function var_0_0._playVoice(arg_76_0)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Main then
		return
	end

	local var_76_0 = WeatherEnum.LightMode[arg_76_0._curReport.lightMode]
	local var_76_1 = WeatherEnum.EffectMode[arg_76_0._curReport.effect]
	local var_76_2 = arg_76_0._prevEffect ~= arg_76_0._curReport.effect

	arg_76_0._prevEffect = arg_76_0._curReport.effect

	if var_76_2 and var_76_1 then
		if not arg_76_0._isSceneHide then
			var_0_1:setSwitch(arg_76_0:getId("WeatherState"), arg_76_0:getId(var_76_1))
		end

		arg_76_0._curWeatherEffect = var_76_1
		arg_76_0._curWeatherState = arg_76_0._curReport.effect
	end

	local var_76_3 = arg_76_0._prevLightMode ~= arg_76_0._curReport.lightMode

	arg_76_0._prevLightMode = arg_76_0._curReport.lightMode

	if var_76_3 and var_76_0 then
		if not arg_76_0._isSceneHide then
			var_0_1:setSwitch(arg_76_0:getId("Daytimestate"), arg_76_0:getId(var_76_0))
		end

		arg_76_0._curLightMode = var_76_0
	end

	print("===playVoice:", var_76_0, var_76_3, var_76_1, var_76_2)
end

function var_0_0.playWeatherAudio(arg_77_0)
	arg_77_0:_playVoice()
	arg_77_0:_playWeatherEffectAudio()
end

function var_0_0.stopWeatherAudio(arg_78_0)
	arg_78_0._prevLightMode = nil
	arg_78_0._prevEffect = nil
	arg_78_0._curWeatherEffect = nil
	arg_78_0._curWeatherState = nil
	arg_78_0._curLightMode = nil

	arg_78_0:_stopWeatherEffectAudio()
end

function var_0_0.setStateByString(arg_79_0, arg_79_1, arg_79_2)
	var_0_1:setState(arg_79_0:getId(arg_79_1), arg_79_0:getId(arg_79_2))
end

function var_0_0.getId(arg_80_0, arg_80_1)
	local var_80_0 = arg_80_0._str2Id[arg_80_1]

	if not var_80_0 then
		var_80_0 = var_0_1:getIdFromString(arg_80_1)
		arg_80_0._str2Id[arg_80_1] = var_80_0
	end

	return var_80_0
end

function var_0_0.initRoleParam(arg_81_0, arg_81_1)
	local var_81_0, var_81_1 = CharacterSwitchListModel.instance:getMainHero(arg_81_0._randomMainHero)

	arg_81_0._randomMainHero = false

	if not var_81_0 then
		return
	end

	local var_81_2 = HeroModel.instance:getByHeroId(var_81_0)

	if not var_81_2 then
		return
	end

	if not arg_81_0._blackColor then
		arg_81_0._blackColor = Color()
	end

	arg_81_0._srcBloomColor = arg_81_0._targetBloomColor
	arg_81_0._srcMainColor = arg_81_0._targetMainColor
	arg_81_0._srcEmissionColor = arg_81_0._targetEmissionColor
	arg_81_0._srcBloomFactor = arg_81_0._targetBloomFactor
	arg_81_0._srcPercent = arg_81_0._targetPercent
	arg_81_0._srcBloomFactor2 = arg_81_0._targetBloomFactor2
	arg_81_0._srcLuminance = arg_81_0._targetLuminance

	local var_81_3 = SkinConfig.instance:getSkinCo(var_81_1 or var_81_2.skin)

	if var_81_3 then
		local var_81_4 = WeatherConfig.instance:getSkinWeatherParam(var_81_3.weatherParam)

		if var_81_4 then
			local var_81_5 = arg_81_1.lightMode

			arg_81_0._targetBloomColor = arg_81_0:createColorIntensity(var_81_4["bloomColor" .. var_81_5])
			arg_81_0._targetMainColor = arg_81_0:createColorIntensity(var_81_4["mainColor" .. var_81_5])
			arg_81_0._targetEmissionColor = arg_81_0:createColorIntensity(var_81_4["emissionColor" .. var_81_5])
			arg_81_0._targetBloomFactor = WeatherEnum.BloomFactor
			arg_81_0._targetPercent = WeatherEnum.Percent
			arg_81_0._targetBloomFactor2 = WeatherEnum.BloomFactor2[var_81_5]
			arg_81_0._targetLuminance = WeatherEnum.Luminance[var_81_5]
		elseif isDebugBuild then
			local var_81_6 = var_81_3 and tostring(var_81_3.id) or "nil"
			local var_81_7 = var_81_3 and tostring(var_81_3.weatherParam) or "nil"

			logError(string.format("skin_%s 天气参数_%s P皮肤表.xlsx-export_皮肤天气颜色参数 未配置", var_81_6, var_81_7))
		end
	elseif isDebugBuild then
		local var_81_8 = tostring(var_81_2.heroId)
		local var_81_9 = tostring(var_81_1 or var_81_2.skin)

		logError(string.format("hero_%s skin_%s 皮肤id 不存在", var_81_8, var_81_9))
	end
end

function var_0_0.createColorIntensity(arg_82_0, arg_82_1)
	local var_82_0 = string.split(arg_82_1, "#")

	if not var_82_0 or #var_82_0 < 4 then
		logError("createColorIntensity rgbintensity error,report id:" .. arg_82_0._curReport.id .. " rgbintensityStr:" .. arg_82_1)

		return {
			Color.New(),
			0
		}
	end

	local var_82_1 = tonumber(var_82_0[1]) / 255
	local var_82_2 = tonumber(var_82_0[2]) / 255
	local var_82_3 = tonumber(var_82_0[3]) / 255
	local var_82_4 = tonumber(var_82_0[4])
	local var_82_5 = Color.New(var_82_1, var_82_2, var_82_3)

	return {
		var_82_5,
		var_82_4
	}
end

function var_0_0._resGC(arg_83_0)
	if arg_83_0._sceneGo then
		for iter_83_0, iter_83_1 in pairs(arg_83_0._lightMapPathPrefix) do
			for iter_83_2, iter_83_3 in pairs(arg_83_0._lightMats[iter_83_0]) do
				if not arg_83_0._revert then
					iter_83_3:SetTexture(ShaderPropertyId.MainTex, nil)
				else
					iter_83_3:SetTexture(ShaderPropertyId.MainTexSecond, nil)
				end
			end
		end

		if not arg_83_0._revert then
			if arg_83_0._srcLoader then
				arg_83_0._srcLoader:dispose()

				arg_83_0._srcLoader = nil
			end
		elseif arg_83_0._targetLoader then
			arg_83_0._targetLoader:dispose()

			arg_83_0._targetLoader = nil
		end

		SLFramework.UnityHelper.ResGC()
	end
end

function var_0_0._clearMats(arg_84_0)
	if not arg_84_0._rawLightMats then
		return
	end

	for iter_84_0, iter_84_1 in pairs(arg_84_0._rawLightMats) do
		iter_84_1:SetTexture(ShaderPropertyId.MainTex, nil)
		iter_84_1:SetTexture(ShaderPropertyId.MainTexSecond, nil)
	end
end

function var_0_0.onSceneShow(arg_85_0)
	if arg_85_0._isSceneHide == false then
		return
	end

	gohelper.setActive(arg_85_0._sceneGo, true)

	arg_85_0._isSceneHide = false

	if arg_85_0._curWeatherEffect then
		var_0_1:setSwitch(arg_85_0:getId("WeatherState"), arg_85_0:getId(arg_85_0._curWeatherEffect))
	end

	if arg_85_0._curLightMode then
		var_0_1:setSwitch(arg_85_0:getId("Daytimestate"), arg_85_0:getId(arg_85_0._curLightMode))
	end

	arg_85_0:_playWeatherEffectAudio()
end

function var_0_0._playWeatherEffectAudio(arg_86_0)
	arg_86_0:_stopWeatherEffectAudio()

	if arg_86_0._curWeatherState and not gohelper.isNil(arg_86_0._weatherEffectGo) then
		local var_86_0 = WeatherEnum.EffectPlayAudio[arg_86_0._curWeatherState]

		if var_86_0 and not arg_86_0._isSceneHide then
			arg_86_0._stopWeatherEffectAudioId = WeatherEnum.EffectStopAudio[arg_86_0._curWeatherState]

			var_0_1:trigger(var_86_0)
			gohelper.setActive(arg_86_0._weatherEffectGo, false)
			gohelper.setActive(arg_86_0._weatherEffectGo, true)
			TaskDispatcher.cancelTask(arg_86_0._repeatPlayEffectAndAudio, arg_86_0)
			TaskDispatcher.runDelay(arg_86_0._repeatPlayEffectAndAudio, arg_86_0, WeatherEnum.EffectAudioTime[arg_86_0._curWeatherState])
		end
	end
end

function var_0_0.onSceneHide(arg_87_0)
	gohelper.setActive(arg_87_0._sceneGo, false)

	arg_87_0._isSceneHide = true

	arg_87_0:_stopWeatherEffectAudio()
	TaskDispatcher.cancelTask(arg_87_0._repeatPlayEffectAndAudio, arg_87_0)
end

function var_0_0._stopWeatherEffectAudio(arg_88_0)
	if arg_88_0._stopWeatherEffectAudioId then
		var_0_1:trigger(arg_88_0._stopWeatherEffectAudioId)

		arg_88_0._stopWeatherEffectAudioId = nil
	end
end

function var_0_0._repeatPlayEffectAndAudio(arg_89_0)
	arg_89_0:_playWeatherEffectAudio()
end

function var_0_0.onSceneClose(arg_90_0)
	if arg_90_0._isMain then
		arg_90_0:_clearMats()

		arg_90_0._randomMainHero = true
	end

	if arg_90_0._srcLoader then
		arg_90_0._srcLoader:dispose()

		arg_90_0._srcLoader = nil
	end

	if arg_90_0._targetLoader then
		arg_90_0._targetLoader:dispose()

		arg_90_0._targetLoader = nil
	end

	if arg_90_0._effectLoader then
		arg_90_0._effectLoader:dispose()

		arg_90_0._effectLoader = nil
	end

	TaskDispatcher.cancelTask(arg_90_0._onUpdate, arg_90_0)
	TaskDispatcher.cancelTask(arg_90_0._onEffectUpdate, arg_90_0)
	TaskDispatcher.cancelTask(arg_90_0._checkReport, arg_90_0)
	TaskDispatcher.cancelTask(arg_90_0._resGC, arg_90_0)
	TaskDispatcher.cancelTask(arg_90_0._repeatPlayEffectAndAudio, arg_90_0)

	arg_90_0._sceneGo = nil
	arg_90_0._effectRoot = nil
	arg_90_0._lightMats = nil
	arg_90_0._matsMap = nil
	arg_90_0._lightSwitch = nil
	arg_90_0._rawLightMats = nil
	arg_90_0._rainEffectMat = nil
	arg_90_0._roleGo = nil
	arg_90_0._roleSharedMaterial = nil
	arg_90_0._postProcessMask = null
	arg_90_0._curReport = nil
	arg_90_0._prevReport = nil
	arg_90_0._srcReport = nil
	arg_90_0._targetReport = nil
	arg_90_0._animator = nil
	arg_90_0._prevEffect = nil
	arg_90_0._prevLightMode = nil
	arg_90_0._curWeatherEffect = nil
	arg_90_0._curLightMode = nil
	arg_90_0._curWeatherState = nil
	arg_90_0._isSceneHide = nil

	arg_90_0:_stopWeatherEffectAudio()

	arg_90_0._effectLightPs = nil
	arg_90_0._effectAirPs = nil
	arg_90_0._dynamicEffectLightPs = nil
	arg_90_0._heroPlayWeatherVoice = nil
	arg_90_0._lightModel = nil
	arg_90_0._changeRoleParam = nil
	arg_90_0._roleBlendCallback = nil
	arg_90_0._roleBlendCallbackTarget = nil
	arg_90_0._changeReportCallback = nil
	arg_90_0._changeReportCallbackTarget = nil
	arg_90_0._weatherEffectGo = nil
	arg_90_0._startTime = nil
	arg_90_0._effectStartTime = nil
	arg_90_0._reportEndTime = nil

	ViewMgr.instance:unregisterCallback(ViewEvent.OnCloseFullView, arg_90_0._onCloseFullView, arg_90_0)
	MainController.instance:unregisterCallback(MainEvent.OnShowSceneNewbieOpen, arg_90_0._OnShowSceneNewbieOpen, arg_90_0)
end

return var_0_0
