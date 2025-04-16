module("modules.ProjModuleStart", package.seeall)

slot0 = class("ProjModuleStart")

function slot0.start(slot0)
	logNormal("ProjModuleStart:start()!!!")
	slot0:addCrashsightSceneData()

	if GameResMgr.IsFromEditorDir or VersionValidator.instance:isInReviewing() and BootNativeUtil.isIOS() then
		if VersionValidator.instance:isInReviewing() and BootNativeUtil.isIOS() then
			SLFramework.FileHelper.ClearDir(SLFramework.FrameworkSettings.PersistentResRootDir .. "/bundles")
			SLFramework.FileHelper.ClearDir(SLFramework.FrameworkSettings.PersistentResRootDir .. "/videos")
			SLFramework.FileHelper.ClearDir(SLFramework.FrameworkSettings.PersistentResRootDir .. "/audios")
		end

		slot0:init()
	else
		BootLoadingView.instance:show(0.9, booterLang("loading_res"))
		slot0:resCheck()
	end
end

function slot0.resCheck(slot0)
	setNeedLoadModule("modules.reschecker.MassHotUpdateMgr", "MassHotUpdateMgr")
	setNeedLoadModule("modules.reschecker.ResCheckMgr", "ResCheckMgr")
	ResCheckMgr.instance:startCheck(slot0.onResCheckFinish, slot0)
end

function slot0.onResCheckFinish(slot0, slot1)
	logNormal("ProjModuleStart:onResCheckFinish")

	if slot1 then
		slot0:init()
	else
		slot0:loadUnmatchRes()
	end
end

function slot0.loadUnmatchRes(slot0)
	MassHotUpdateMgr.instance:loadUnmatchRes(slot0.loadUnmatchResFinish, slot0)
end

function slot0.loadUnmatchResFinish(slot0)
	logNormal("ProjModuleStart:loadUnmatchResFinish")
	slot0:init()
end

function slot0.init(slot0)
	logNormal("ProjModuleStart:init()!!!")
	SDKDataTrackMgr.instance:track(SDKDataTrackMgr.EventName.resource_load)
	GameResMgr:InitAbDependencies(slot0.onAbDependenciesInited, slot0)
	BootLoadingView.instance:show(0.2, booterLang("loading_res"))
end

function slot0.addCrashsightSceneData(slot0)
	CrashSightAgent.AddSceneData("K#resVersion", SLFramework.GameUpdate.HotUpdateInfoMgr.LocalResVersionStr)
end

function slot0.onAbDependenciesInited(slot0)
	logNormal("ProjModuleStart:onAbDependenciesInited()!!!")
	slot0:initFramework()
	slot0:initModuleLogic()
end

function slot0.initFramework(slot0)
	addGlobalModule("framework.require_framework")
	addGlobalModule("modules.setting.require_proto")
	addGlobalModule("modules.setting.require_modules")
	TaskDispatcher.init()
	FrameworkExtend.init()
end

function slot0.initModuleLogic(slot0)
	GameBranchMgr.instance:init()
	ModuleMgr.instance:init(addGlobalModule("modules.setting.module_mvc", "module_mvc"), slot0._onModuleIniFinish, slot0)
end

function slot0._onModuleIniFinish(slot0)
	if BootLoadingView.instance.hasClickFix then
		return
	end

	addGlobalModule("modules.setting.module_views_preloader", "module_views_preloader")
	ViewMgr.instance:init(addGlobalModule("modules.setting.module_views", "module_views"))
	FullScreenViewLimitMgr.instance:init()
	SLFramework.TimeWatch.Instance:Start()
	ConfigMgr.instance:init("configs/excel2json/json_", "modules.configs.excel2json.lua_", "configs/datacfg_")
	ConfigMgr.instance:loadConfigs(slot0._onAllConfigLoaded, slot0)
end

function slot0._onAllConfigLoaded(slot0)
	if BootLoadingView.instance.hasClickFix then
		return
	end

	LangSettings.instance:init()
	LangSettings.instance:loadLangConfig(slot0._onLangConfigLoaded, slot0)
end

function slot0._onLangConfigLoaded(slot0)
	if BootLoadingView.instance.hasClickFix then
		return
	end

	logNormal((GameResMgr.IsFromEditorDir and "direct" or "bundle") .. " " .. (ConfigMgr.instance._isAllToOne and "allToOne" or "oneToOne") .. " load configs cost time: " .. SLFramework.TimeWatch.Instance:Watch() .. " s")
	SLFramework.LanguageMgr.Instance:Init(slot0._onLangSettingsInit, slot0)
end

function slot0._onLangSettingsInit(slot0)
	if BootLoadingView.instance.hasClickFix then
		return
	end

	logNormal("_onLangSettingsInit, 多语言资源列表加载完成！")
	ConstResLoader.instance:startLoad(slot0._onConstResLoaded, slot0)
end

function slot0._onConstResLoaded(slot0)
	if BootLoadingView.instance.hasClickFix then
		return
	end

	logNormal("OnConstResLoaded, 常驻内存的资源加载完毕了！")
	SLFramework.LanguageMgr.Instance:RegisterLangImageSetter(slot0._loadLangImage, slot0)
	SLFramework.LanguageMgr.Instance:RegisterLangSpriteSetImageSetter(slot0._loadLangSpriteSetImage, slot0)
	SLFramework.LanguageMgr.Instance:RegisterLangTxtSetter(slot0._loadLangTxt, slot0)
	SLFramework.LanguageMgr.Instance:RegisterLangCaptionsSetter(slot0._loadLangCaptions, slot0)
	AudioMgr.instance:init(slot0._onAudioInited, slot0)
end

function slot0._onAudioInited(slot0, slot1)
	if BootLoadingView.instance.hasClickFix then
		return
	end

	if not slot1 then
		logError("ProjModuleStart._onAudioInited ret = " .. tostring(slot1))
	end

	AudioMgr.instance:initSoundVolume()
	AudioMgr.instance:changeEarMode()
	BootLoadingView.instance:show(0.99, booterLang("loading_res"))
	CameraMgr.instance:initCamera(slot0._onCameraInit, slot0)
end

function slot0._onCameraInit(slot0)
	if BootLoadingView.instance.hasClickFix then
		return
	end

	GameGlobalMgr.instance:initLangFont()
	VoiceChooseMgr.instance:start(slot0._onVoiceChoose, slot0)
end

function slot0._onVoiceChoose(slot0)
	if BootLoadingView.instance.hasClickFix then
		return
	end

	logNormal("_onVoiceChoose！")
	slot0:startLogic()
end

function slot0._loadLangImage(slot0, slot1, slot2)
	slot1:LoadImage(slot2)
end

function slot0._loadLangSpriteSetImage(slot0, slot1, slot2, slot3)
	slot1:LoadImage(slot2, slot3)
end

function slot0._loadLangTxt(slot0, slot1, slot2)
	if slot1 then
		if gohelper.getDynamicSizeText and gohelper.getDynamicSizeText(slot1.gameObject) or nil then
			slot3.text = luaLang(slot2)
		elseif slot1.text then
			slot1.text = luaLang(slot2)
		end
	end
end

function slot0._loadLangCaptions(slot0, slot1, slot2, slot3)
	if slot3 then
		slot5 = false

		for slot9 = 1, slot3.Length do
			if slot3[slot9 - 1] == LangSettings.instance:getCurLang() then
				slot5 = true

				gohelper.setActive(slot1.gameObject, true)

				return
			end
		end

		gohelper.setActive(slot1.gameObject, slot5)
	else
		gohelper.setActive(slot1.gameObject, LangSettings.instance:langCaptionsActive())
	end
end

function slot0.startLogic(slot0)
	if BootLoadingView.instance.hasClickFix then
		return
	end

	ServerTime.init()
	LuaSocketMgr.instance:init(system_cmd, addGlobalModule("modules.setting.module_cmd", "module_cmd"))
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
		if GameConfig:GetCurLangType() ~= BootLangEnum.en and slot2 ~= BootLangEnum.zh then
			LangSettings.instance:SetCurLangType(GameConfig:GetDefaultLangShortcut(), function ()
				LoginController.instance:login()
			end)
		else
			TaskDispatcher.runDelay(function ()
				LoginController.instance:login()
			end, nil, 0.167)
		end
	else
		TaskDispatcher.runDelay(function ()
			LoginController.instance:login()
		end, nil, 0.167)
	end
end

slot0.instance = slot0.New()

slot0.instance:start()

return slot0
