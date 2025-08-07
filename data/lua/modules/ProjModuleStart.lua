module("modules.ProjModuleStart", package.seeall)

local var_0_0 = class("ProjModuleStart")

function var_0_0.start(arg_1_0)
	logNormal("ProjModuleStart:start()!!!")
	arg_1_0:addCrashsightSceneData()

	if GameResMgr.IsFromEditorDir or VersionValidator.instance:isInReviewing() and BootNativeUtil.isIOS() then
		if VersionValidator.instance:isInReviewing() and BootNativeUtil.isIOS() then
			SLFramework.FileHelper.ClearDir(SLFramework.FrameworkSettings.PersistentResRootDir .. "/bundles")
			SLFramework.FileHelper.ClearDir(SLFramework.FrameworkSettings.PersistentResRootDir .. "/videos")
			SLFramework.FileHelper.ClearDir(SLFramework.FrameworkSettings.PersistentResRootDir .. "/audios")
		end

		arg_1_0:init()
	else
		BootLoadingView.instance:show(0.9, booterLang("loading_res"))
		arg_1_0:resCheck()
	end
end

function var_0_0.resCheck(arg_2_0)
	setNeedLoadModule("modules.reschecker.MassHotUpdateMgr", "MassHotUpdateMgr")
	setNeedLoadModule("modules.reschecker.ResCheckMgr", "ResCheckMgr")
	setNeedLoadModule("modules.common.others.SDKDataTrackExt", "SDKDataTrackExt")
	setNeedLoadModule("modules.logic.defines.PlayerPrefsKey", "PlayerPrefsKey")
	SDKDataTrackExt.activateExtend()
	ResCheckMgr.instance:startCheck(arg_2_0.onResCheckFinish, arg_2_0)
end

function var_0_0.onResCheckFinish(arg_3_0, arg_3_1)
	logNormal("ProjModuleStart:onResCheckFinish")

	if arg_3_1 then
		arg_3_0:init()
	else
		arg_3_0:loadUnmatchRes()
	end
end

function var_0_0.loadUnmatchRes(arg_4_0)
	MassHotUpdateMgr.instance:loadUnmatchRes(arg_4_0.loadUnmatchResFinish, arg_4_0)
end

function var_0_0.loadUnmatchResFinish(arg_5_0)
	logNormal("ProjModuleStart:loadUnmatchResFinish")
	arg_5_0:init()
end

function var_0_0.init(arg_6_0)
	arg_6_0:addCrashsightResCheckerV()
	logNormal("ProjModuleStart:init()!!!")
	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.resource_load)
	GameResMgr:InitAbDependencies(arg_6_0.onAbDependenciesInited, arg_6_0)
	BootLoadingView.instance:show(0.2, booterLang("loading_res"))
end

function var_0_0.addCrashsightSceneData(arg_7_0)
	local var_7_0 = SLFramework.GameUpdate.HotUpdateInfoMgr.LocalResVersionStr

	CrashSightAgent.AddSceneData("K#resVersion", var_7_0)
end

function var_0_0.addCrashsightResCheckerV(arg_8_0)
	local var_8_0 = SLFramework.FileHelper.ReadText(SLFramework.ResChecker.OutVersionPath)

	if string.nilorempty(var_8_0) then
		var_8_0 = "0"
	end

	CrashSightAgent.AddSceneData("K#resCheckerV", var_8_0)
end

function var_0_0.onAbDependenciesInited(arg_9_0)
	logNormal("ProjModuleStart:onAbDependenciesInited()!!!")
	arg_9_0:initFramework()
	arg_9_0:initModuleLogic()
end

function var_0_0.initFramework(arg_10_0)
	addGlobalModule("framework.require_framework")
	addGlobalModule("modules.setting.require_proto")
	addGlobalModule("modules.setting.require_modules")
	TaskDispatcher.init()
	FrameworkExtend.init()
end

function var_0_0.initModuleLogic(arg_11_0)
	GameBranchMgr.instance:init()

	local var_11_0 = addGlobalModule("modules.setting.module_mvc", "module_mvc")

	ModuleMgr.instance:init(var_11_0, arg_11_0._onModuleIniFinish, arg_11_0)
end

function var_0_0._onModuleIniFinish(arg_12_0)
	if BootLoadingView.instance.hasClickFix then
		return
	end

	addGlobalModule("modules.setting.module_views_preloader", "module_views_preloader")

	local var_12_0 = addGlobalModule("modules.setting.module_views", "module_views")

	ViewMgr.instance:init(var_12_0)
	FullScreenViewLimitMgr.instance:init()
	SLFramework.TimeWatch.Instance:Start()
	ConfigMgr.instance:init("configs/excel2json/json_", "modules.configs.excel2json.lua_", "configs/datacfg_")
	ConfigMgr.instance:loadConfigs(arg_12_0._onAllConfigLoaded, arg_12_0)
end

function var_0_0._onAllConfigLoaded(arg_13_0)
	LangSettings.instance:init()
	LangSettings.instance:loadLangConfig(arg_13_0._onLangConfigLoaded, arg_13_0)
end

function var_0_0._onLangConfigLoaded(arg_14_0)
	if BootLoadingView.instance.hasClickFix then
		return
	end

	LangSettings.instance:init()
	LangSettings.instance:loadLangConfig(arg_14_0._onLangConfigLoaded, arg_14_0)
end

function var_0_0._onLangConfigLoaded(arg_15_0)
	if BootLoadingView.instance.hasClickFix then
		return
	end

	local var_15_0 = GameResMgr.IsFromEditorDir and "direct" or "bundle"
	local var_15_1 = ConfigMgr.instance._isAllToOne and "allToOne" or "oneToOne"

	logNormal(var_15_0 .. " " .. var_15_1 .. " load configs cost time: " .. SLFramework.TimeWatch.Instance:Watch() .. " s")
	SLFramework.LanguageMgr.Instance:Init(arg_15_0._onLangSettingsInit, arg_15_0)
end

function var_0_0._onLangSettingsInit(arg_16_0)
	if BootLoadingView.instance.hasClickFix then
		return
	end

	logNormal("_onLangSettingsInit, 多语言资源列表加载完成！")
	ConstResLoader.instance:startLoad(arg_16_0._onConstResLoaded, arg_16_0)
end

function var_0_0._onConstResLoaded(arg_17_0)
	if BootLoadingView.instance.hasClickFix then
		return
	end

	logNormal("OnConstResLoaded, 常驻内存的资源加载完毕了！")
	SLFramework.LanguageMgr.Instance:RegisterLangImageSetter(arg_17_0._loadLangImage, arg_17_0)
	SLFramework.LanguageMgr.Instance:RegisterLangSpriteSetImageSetter(arg_17_0._loadLangSpriteSetImage, arg_17_0)
	SLFramework.LanguageMgr.Instance:RegisterLangTxtSetter(arg_17_0._loadLangTxt, arg_17_0)
	SLFramework.LanguageMgr.Instance:RegisterLangCaptionsSetter(arg_17_0._loadLangCaptions, arg_17_0)
	AudioMgr.instance:init(arg_17_0._onAudioInited, arg_17_0)
end

function var_0_0._onAudioInited(arg_18_0, arg_18_1)
	if BootLoadingView.instance.hasClickFix then
		return
	end

	if not arg_18_1 then
		logError("ProjModuleStart._onAudioInited ret = " .. tostring(arg_18_1))
	end

	AudioMgr.instance:initSoundVolume()
	AudioMgr.instance:changeEarMode()
	BootLoadingView.instance:show(0.99, booterLang("loading_res"))
	CameraMgr.instance:initCamera(arg_18_0._onCameraInit, arg_18_0)
end

function var_0_0._onCameraInit(arg_19_0)
	if BootLoadingView.instance.hasClickFix then
		return
	end

	GameGlobalMgr.instance:initLangFont()
	VoiceChooseMgr.instance:start(arg_19_0._onVoiceChoose, arg_19_0)
end

function var_0_0._onVoiceChoose(arg_20_0)
	if BootLoadingView.instance.hasClickFix then
		return
	end

	logNormal("_onVoiceChoose！")
	arg_20_0:startLogic()
end

function var_0_0._loadLangImage(arg_21_0, arg_21_1, arg_21_2)
	arg_21_1:LoadImage(arg_21_2)
end

function var_0_0._loadLangSpriteSetImage(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	arg_22_1:LoadImage(arg_22_2, arg_22_3)
end

function var_0_0._loadLangTxt(arg_23_0, arg_23_1, arg_23_2)
	if arg_23_1 then
		local var_23_0 = gohelper.getDynamicSizeText and gohelper.getDynamicSizeText(arg_23_1.gameObject) or nil

		if var_23_0 then
			var_23_0.text = luaLang(arg_23_2)
		elseif arg_23_1.text then
			arg_23_1.text = luaLang(arg_23_2)
		end
	end
end

function var_0_0._loadLangCaptions(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	if arg_24_3 then
		local var_24_0 = LangSettings.instance:getCurLang()
		local var_24_1 = false

		for iter_24_0 = 1, arg_24_3.Length do
			if arg_24_3[iter_24_0 - 1] == var_24_0 then
				var_24_1 = true

				gohelper.setActive(arg_24_1.gameObject, true)

				return
			end
		end

		gohelper.setActive(arg_24_1.gameObject, var_24_1)
	else
		gohelper.setActive(arg_24_1.gameObject, LangSettings.instance:langCaptionsActive())
	end
end

function var_0_0.startLogic(arg_25_0)
	if BootLoadingView.instance.hasClickFix then
		return
	end

	local var_25_0 = addGlobalModule("modules.setting.module_cmd", "module_cmd")

	ServerTime.init()
	LuaSocketMgr.instance:init(system_cmd, var_25_0)
	PreReciveLogicMsg.instance:init()
	GameSceneMgr.instance:init()
	GameGlobalMgr.instance:init()
	NavigateMgr.instance:init()
	ConnectAliveMgr.instance:init()
	IconMaterialMgr.instance:init()
	ActivityLiveMgr.instance:init()
	TMPDynamicSizeTextMgr.instance:init()
	EnterActivityViewOnExitFightSceneHelper.activeExtend()
	ConnectAliveMgr.instance:setNonResendCmds({
		24032
	})
	BootLoadingView.instance:show(1, booterLang("loading_res_complete"))
	BootLoadingView.instance:addEventListeners()
	SDKDataTrackMgr.instance:trackResourceLoadFinishEvent(SDKDataTrackMgr.Result.success)
	StatViewController.instance:init()
	GameBranchMgr.instance:inject()
	BootLoadingView.instance:playClose()

	if VersionValidator.instance:isInReviewing() and BootNativeUtil.isIOS() and GameChannelConfig.isGpGlobal() then
		local var_25_1 = GameConfig:GetCurLangType()

		if var_25_1 ~= BootLangEnum.en and var_25_1 ~= BootLangEnum.zh then
			LangSettings.instance:SetCurLangType(GameConfig:GetDefaultLangShortcut(), function()
				LoginController.instance:login()
			end)
		else
			TaskDispatcher.runDelay(function()
				LoginController.instance:login()
			end, nil, 0.167)
		end
	else
		TaskDispatcher.runDelay(function()
			LoginController.instance:login()
		end, nil, 0.167)
	end
end

var_0_0.instance = var_0_0.New()

var_0_0.instance:start()

return var_0_0
