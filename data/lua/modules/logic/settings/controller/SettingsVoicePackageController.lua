module("modules.logic.settings.controller.SettingsVoicePackageController", package.seeall)

local var_0_0 = class("SettingsVoicePackageController", BaseController)

var_0_0.NotDownload = 1
var_0_0.InDownload = 2
var_0_0.NeedUpdate = 3
var_0_0.AlreadyLatest = 4
var_0_0.DownloadFailedToast = 173
var_0_0.NoEnoughDisk = 5
var_0_0.MD5CheckError = 6

function var_0_0.onInit(arg_1_0)
	arg_1_0._httpGetter = nil
	arg_1_0._optionalUpdate = SLFramework.GameUpdate.OptionalUpdate
	arg_1_0._optionalUpdateInst = arg_1_0._optionalUpdate.Instance
	arg_1_0._downLoadStartTime = math.floor(Time.realtimeSinceStartup * 1000)
	arg_1_0._statHotUpdatePerList = {}
	arg_1_0._statHotUpdatePerList[1] = {
		0,
		"start"
	}
	arg_1_0._statHotUpdatePerList[2] = {
		0.2,
		"20%"
	}
	arg_1_0._statHotUpdatePerList[3] = {
		0.4,
		"40%"
	}
	arg_1_0._statHotUpdatePerList[4] = {
		0.6,
		"60%"
	}
	arg_1_0._statHotUpdatePerList[5] = {
		0.8,
		"80%"
	}
	arg_1_0._statHotUpdatePerList[6] = {
		1,
		"100%"
	}
	arg_1_0._statHotUpdatePerNum = 6
	arg_1_0._nowStatHotUpdatePerIndex = 1
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	if not HotUpdateVoiceMgr then
		return
	end

	if not GameConfig.CanHotUpdate then
		return
	end

	arg_3_0._optionalUpdateInst:Register(arg_3_0._optionalUpdate.NotEnoughDiskSpace, arg_3_0._onNotEnoughDiskSpace, arg_3_0)
	arg_3_0._optionalUpdateInst:Register(arg_3_0._optionalUpdate.DownloadStart, arg_3_0._onDownloadStart, arg_3_0)
	arg_3_0._optionalUpdateInst:Register(arg_3_0._optionalUpdate.DownloadProgressRefresh, arg_3_0._onDownloadProgressRefresh, arg_3_0)
	arg_3_0._optionalUpdateInst:Register(arg_3_0._optionalUpdate.DownloadPackFail, arg_3_0._onDownloadPackFail, arg_3_0)
	arg_3_0._optionalUpdateInst:Register(arg_3_0._optionalUpdate.DownloadPackSuccess, arg_3_0._onDownloadPackSuccess, arg_3_0)
	arg_3_0._optionalUpdateInst:Register(arg_3_0._optionalUpdate.PackUnZipFail, arg_3_0._onPackUnZipFail, arg_3_0)
	arg_3_0._optionalUpdateInst:Register(arg_3_0._optionalUpdate.PackItemStateChange, arg_3_0._onPackItemStateChange, arg_3_0)
	ConnectAliveMgr.instance:registerCallback(ConnectEvent.OnReconnectSucc, arg_3_0._onReconnectSucc, arg_3_0)
end

function var_0_0.register(arg_4_0)
	arg_4_0._optionalUpdateInst:Register(arg_4_0._optionalUpdate.NotEnoughDiskSpace, arg_4_0._onNotEnoughDiskSpace, arg_4_0)
	arg_4_0._optionalUpdateInst:Register(arg_4_0._optionalUpdate.DownloadStart, arg_4_0._onDownloadStart, arg_4_0)
	arg_4_0._optionalUpdateInst:Register(arg_4_0._optionalUpdate.DownloadProgressRefresh, arg_4_0._onDownloadProgressRefresh, arg_4_0)
	arg_4_0._optionalUpdateInst:Register(arg_4_0._optionalUpdate.DownloadPackFail, arg_4_0._onDownloadPackFail, arg_4_0)
	arg_4_0._optionalUpdateInst:Register(arg_4_0._optionalUpdate.DownloadPackSuccess, arg_4_0._onDownloadPackSuccess, arg_4_0)
	arg_4_0._optionalUpdateInst:Register(arg_4_0._optionalUpdate.PackUnZipFail, arg_4_0._onPackUnZipFail, arg_4_0)
	arg_4_0._optionalUpdateInst:Register(arg_4_0._optionalUpdate.PackItemStateChange, arg_4_0._onPackItemStateChange, arg_4_0)
end

function var_0_0.reInit(arg_5_0)
	return
end

function var_0_0.getLocalVersionInt(arg_6_0, arg_6_1)
	if not GameConfig.CanHotUpdate then
		return 0
	end

	if not arg_6_0._optionalUpdateInst then
		arg_6_0._optionalUpdate = SLFramework.GameUpdate.OptionalUpdate
		arg_6_0._optionalUpdateInst = arg_6_0._optionalUpdate.Instance
	end

	local var_6_0 = arg_6_0._optionalUpdateInst:GetLocalVersion(arg_6_1)

	if not string.nilorempty(var_6_0) then
		return tonumber(var_6_0)
	end

	return 0
end

function var_0_0.switchVoiceType(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = GameConfig:GetCurVoiceShortcut()
	local var_7_1 = GameLanguageMgr.instance:getStoryIndexByShortCut(arg_7_1)

	PlayerPrefsHelper.setNumber("StoryAudioLanType", var_7_1 - 1)
	GameLanguageMgr.instance:setVoiceTypeByStoryIndex(var_7_1)
	PlayerPrefsHelper.setString(PlayerPrefsKey.VoiceTypeKey_Story, arg_7_1)
	AudioMgr.instance:changeLang(arg_7_1)
	GameConfig:SetCurVoiceType(arg_7_1)

	if arg_7_3 then
		return
	end

	arg_7_0:dispatchEvent(SettingsEvent.OnChangeVoiceType)

	local var_7_2 = {
		current_language = GameConfig:GetCurLangShortcut(),
		entrance = arg_7_2 or "",
		current_voice_pack_list = SettingsVoicePackageModel.instance:getLocalVoiceTypeList() or {},
		current_voice_pack_used = arg_7_1 or "",
		voice_pack_before = var_7_0 or ""
	}

	if arg_7_2 == "in_settings" or arg_7_2 == "in_voiceview" then
		StatController.instance:track(SDKDataTrackMgr.EventName.voice_pack_switch, var_7_2)
	else
		SDKDataTrackMgr.instance:trackVoicePackSwitch(var_7_2)
	end
end

function var_0_0.openVoicePackageView(arg_8_0)
	if not arg_8_0._httpGetter then
		arg_8_0._httpGetter = SettingVoiceHttpGetter.New()

		arg_8_0._httpGetter:start(arg_8_0._onGetVoiceInfoAndOpenView, arg_8_0)
	else
		arg_8_0:_openVoicePackageView()
	end
end

function var_0_0.RequsetVoiceInfo(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_0._httpGetter then
		arg_9_0._httpGetter = SettingVoiceHttpGetter.New()
	end

	arg_9_0._httpGetter:start(function()
		arg_9_0:_onGetVoiceInfo()

		if arg_9_1 then
			arg_9_1(arg_9_2)
		end
	end, arg_9_0)
end

function var_0_0.onSettingVoiceDropDown(arg_11_0)
	if not arg_11_0._httpGetter then
		arg_11_0._httpGetter = SettingVoiceHttpGetter.New()

		arg_11_0._httpGetter:start(arg_11_0._onGetVoiceInfo, arg_11_0)
	end
end

function var_0_0._onGetVoiceInfo(arg_12_0)
	local var_12_0 = arg_12_0._httpGetter:getHttpResult()

	for iter_12_0, iter_12_1 in pairs(var_12_0) do
		local var_12_1 = SettingsVoicePackageModel.instance:getPackInfo(iter_12_0)

		if var_12_1 then
			var_12_1:setLangInfo(iter_12_1)

			if #var_12_1.downloadResList.names > 0 then
				local var_12_2 = var_12_1.downloadResList

				arg_12_0._optionalUpdateInst:InitBreakPointInfo(var_12_2.names, var_12_2.hashs, var_12_2.orders, var_12_2.lengths)

				local var_12_3 = arg_12_0._optionalUpdateInst:GetRecvSize()
				local var_12_4 = tonumber(var_12_3)

				var_12_1:setLocalSize(var_12_4)
				arg_12_0:dispatchEvent(SettingsEvent.OnPackItemStateChange, var_12_1.lang)
			end
		end
	end
end

function var_0_0._onGetVoiceInfoAndOpenView(arg_13_0)
	arg_13_0:_onGetVoiceInfo()
	arg_13_0:_openVoicePackageView()
end

function var_0_0._openVoicePackageView(arg_14_0)
	ViewMgr.instance:openView(ViewName.SettingsVoicePackageView)
end

function var_0_0.getHttpResult(arg_15_0)
	if arg_15_0._httpGetter then
		return arg_15_0._httpGetter:getHttpResult()
	end
end

function var_0_0.getLangSize(arg_16_0, arg_16_1)
	if arg_16_0._httpGetter then
		return arg_16_0._httpGetter:getLangSize(arg_16_1)
	end
end

function var_0_0.tryDownload(arg_17_0, arg_17_1, arg_17_2)
	if ViewMgr.instance:isOpen(ViewName.SettingsVoiceDownloadView) then
		return
	end

	if #arg_17_1.downloadResList.names == 0 then
		if arg_17_0._httpGetter then
			arg_17_0._httpGetter:stop()

			arg_17_0._httpGetter = nil
		end

		arg_17_0:openVoicePackageView()

		return
	end

	if arg_17_2 then
		local var_17_0, var_17_1, var_17_2 = arg_17_1:getLeftSizeMBorGB()

		MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.DownloadVoicePack, MsgBoxEnum.BoxType.Yes_No, function()
			local var_18_0 = {}

			var_18_0.entrance = "voice_list"
			var_18_0.update_amount = arg_17_1:getLeftSizeMBNum()
			var_18_0.download_voice_pack_list = {
				arg_17_1.lang
			}
			var_18_0.current_voice_pack_list = SettingsVoicePackageModel.instance:getLocalVoiceTypeList()
			var_18_0.current_language = GameConfig:GetCurLangShortcut()
			var_18_0.current_voice_pack_used = GameConfig:GetCurVoiceShortcut()

			StatController.instance:track(SDKDataTrackMgr.EventName.voice_pack_download_confirm, var_18_0)
			arg_17_0:startDownload(arg_17_1)
			ViewMgr.instance:openView(ViewName.SettingsVoiceDownloadView, {
				packItemMO = arg_17_1
			})
		end, function()
			return
		end, nil, nil, nil, nil, luaLang(arg_17_1.nameLangId), string.format("%.2f%s", var_17_0, var_17_2))
	else
		arg_17_0:startDownload(arg_17_1)
		ViewMgr.instance:openView(ViewName.SettingsVoiceDownloadView, {
			packItemMO = arg_17_1
		})
	end
end

function var_0_0.getPackItemState(arg_20_0, arg_20_1, arg_20_2)
	return arg_20_0._optionalUpdateInst:GetPackItemState(arg_20_1, arg_20_2)
end

function var_0_0.startDownload(arg_21_0, arg_21_1)
	logNormal("startDownload lang = " .. arg_21_1.lang .. " version = " .. arg_21_1.latestVersion)

	local var_21_0 = arg_21_1.downloadResList
	local var_21_1 = arg_21_1.download_url
	local var_21_2 = arg_21_1.download_url_bak

	arg_21_0._optionalUpdateInst:SetRemoteAssetUrl(var_21_1, var_21_2)
	arg_21_0:_setUseReserveUrl()
	arg_21_0._optionalUpdateInst:StartDownload(arg_21_1.lang, var_21_0.names, var_21_0.hashs, var_21_0.orders, var_21_0.lengths, arg_21_1.latestVersion)
	arg_21_0:_onDownloadPrepareStart(arg_21_1.lang)
end

function var_0_0.stopDownload(arg_22_0, arg_22_1)
	arg_22_0._optionalUpdateInst:StopDownload()
	arg_22_0._optionalUpdateInst:ClearThread()
	arg_22_0:dispatchEvent(SettingsEvent.OnDownloadPackFail, arg_22_1.lang)
end

function var_0_0.startDownloadAll(arg_23_0)
	local var_23_0 = SettingsVoicePackageListModel.instance:getList()

	for iter_23_0, iter_23_1 in pairs(var_23_0) do
		local var_23_1 = iter_23_1:getStatus()

		if var_23_1 == var_0_0.NotDownload or var_23_1 == var_0_0.NeedUpdate then
			arg_23_0:startDownload(iter_23_1)
		end
	end
end

function var_0_0.deleteVoicePack(arg_24_0, arg_24_1)
	local var_24_0 = SettingsVoicePackageModel.instance:getPackInfo(arg_24_1)
	local var_24_1 = {
		current_language = GameConfig:GetCurLangShortcut(),
		current_voice_pack_list = SettingsVoicePackageModel.instance:getLocalVoiceTypeList(),
		current_voice_pack_used = GameConfig:GetCurVoiceShortcut(),
		voice_pack_delete = var_24_0.lang
	}

	StatController.instance:track(SDKDataTrackMgr.EventName.voice_pack_delete, var_24_1)
	var_24_0:setLocalSize(0)
	arg_24_0._optionalUpdateInst:RemovePackInfo(arg_24_1)

	if arg_24_1 == "res-HD" then
		local var_24_2 = SLFramework.FrameworkSettings.PersistentResRootDir .. "/videos/HD"

		SLFramework.FileHelper.ClearDir(var_24_2)
		logNormal("removeVoicePack  hdDir=" .. var_24_2)
	else
		for iter_24_0, iter_24_1 in pairs(OptionPackageEnum.Package) do
			local var_24_3 = HotUpdateOptionPackageMgr.instance:formatLangPackName(arg_24_1, iter_24_1)

			arg_24_0._optionalUpdateInst:RemovePackInfo(var_24_3)
		end

		local var_24_4 = SLFramework.FrameworkSettings.PersistentResRootDir .. "/audios/" .. SLFramework.FrameworkSettings.CurPlatformName .. "/" .. arg_24_1

		SLFramework.FileHelper.ClearDir(var_24_4)

		local var_24_5 = SLFramework.FrameworkSettings.PersistentResRootDir .. "/videos/" .. arg_24_1

		SLFramework.FileHelper.ClearDir(var_24_5)
		logNormal("removeVoicePack  audiosDir=" .. var_24_4)
		logNormal("removeVoicePack  voideoDir=" .. var_24_5)
	end

	ToastController.instance:showToast(183, luaLang(var_24_0.nameLangId))
	SettingsVoicePackageModel.instance:onDeleteVoicePack(arg_24_1)
	arg_24_0:dispatchEvent(SettingsEvent.OnPackItemStateChange, arg_24_1)

	if arg_24_0._httpGetter then
		arg_24_0._httpGetter:stop()

		arg_24_0._httpGetter = nil
	end

	arg_24_0:openVoicePackageView()
end

function var_0_0._onReconnectSucc(arg_25_0)
	if arg_25_0.errorCode then
		local var_25_0 = SLFramework.GameUpdate.FailError

		if arg_25_0.errorCode == var_25_0.NoEnoughDisk or arg_25_0.errorCode == var_25_0.MD5CheckError then
			arg_25_0:_cancelDownload()
		else
			arg_25_0._optionalUpdateInst:RunNextStepAction()
		end

		arg_25_0.errorCode = nil
	end
end

function var_0_0._onDownloadPrepareStart(arg_26_0, arg_26_1)
	logNormal("SettingsVoicePackageController:_onDownloadPrepareStart, packName = " .. arg_26_1)
	arg_26_0:dispatchEvent(SettingsEvent.OnDownloadPrepareStart, arg_26_1)
end

function var_0_0._onDownloadStart(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	logNormal("SettingsVoicePackageController:_onDownloadStart, packName = " .. arg_27_1 .. " curSize = " .. arg_27_2 .. " allSize = " .. arg_27_3)
	SettingsVoicePackageModel.instance:setDownloadProgress(arg_27_1, arg_27_2, arg_27_3)
	arg_27_0:dispatchEvent(SettingsEvent.OnDownloadStart, arg_27_1, arg_27_2, arg_27_3)

	local var_27_0 = SettingsVoicePackageModel.instance:getPackInfo(arg_27_1)

	arg_27_0._nowStatHotUpdatePerIndex = 1
	arg_27_0._downLoadStartTime = math.floor(Time.realtimeSinceStartup * 1000)

	arg_27_0:statHotUpdate(arg_27_2 / arg_27_3, var_27_0)
end

function var_0_0._onDownloadProgressRefresh(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	local var_28_0 = not arg_28_0._prevSize or arg_28_2 ~= arg_28_0._prevSize

	arg_28_0._prevSize = arg_28_2

	if LoginModel.instance:getFailCount() > 0 and var_28_0 then
		LoginModel.instance:resetFailCount()
	end

	logNormal("SettingsVoicePackageController:_onDownloadProgressRefresh, packName = " .. arg_28_1 .. " curSize = " .. arg_28_2 .. " allSize = " .. arg_28_3)
	SettingsVoicePackageModel.instance:setDownloadProgress(arg_28_1, arg_28_2, arg_28_3)
	arg_28_0:dispatchEvent(SettingsEvent.OnDownloadProgressRefresh, arg_28_1, arg_28_2, arg_28_3)

	local var_28_1 = SettingsVoicePackageModel.instance:getPackInfo(arg_28_1)

	if arg_28_0.initFinish == false then
		arg_28_2 = string.format("%0.2f", arg_28_2)
		arg_28_3 = string.format("%0.2f", arg_28_3)

		local var_28_2 = var_28_1.nameLangId
		local var_28_3 = {
			luaLang(var_28_2),
			arg_28_2,
			arg_28_3
		}
		local var_28_4 = GameUtil.getSubPlaceholderLuaLang(luaLang("voice_package_update_2"), var_28_3)

		GameSceneMgr.instance:dispatchEvent(SceneEventName.ShowDownloadInfo, arg_28_2 / arg_28_3, var_28_4)
	end

	arg_28_0:statHotUpdate(arg_28_2 / arg_28_3, var_28_1)
end

function var_0_0.statHotUpdate(arg_29_0, arg_29_1, arg_29_2)
	for iter_29_0 = arg_29_0._nowStatHotUpdatePerIndex, arg_29_0._statHotUpdatePerNum do
		local var_29_0 = arg_29_0._statHotUpdatePerList[iter_29_0]

		if arg_29_1 >= var_29_0[1] then
			local var_29_1 = {
				step = var_29_0[2],
				spend_time = math.floor(Time.realtimeSinceStartup * 1000) - arg_29_0._downLoadStartTime,
				update_amount = arg_29_2:getLeftSizeMBNum(),
				download_voice_pack_list = {
					arg_29_2.lang
				}
			}

			var_29_1.result_msg = "", StatController.instance:track(SDKDataTrackMgr.EventName.voice_pack_downloading, var_29_1)
			arg_29_0._nowStatHotUpdatePerIndex = iter_29_0 + 1
		else
			break
		end
	end
end

function var_0_0._onPackItemStateChange(arg_30_0, arg_30_1)
	logNormal("SettingsVoicePackageController:_onPackItemStateChange, packName = " .. arg_30_1)
	arg_30_0:dispatchEvent(SettingsEvent.OnPackItemStateChange, arg_30_1)
end

function var_0_0._onDownloadPackSuccess(arg_31_0, arg_31_1)
	logNormal("SettingsVoicePackageController:_onDownloadPackSuccess, packName = " .. arg_31_1)
	SettingsVoicePackageModel.instance:onDownloadSucc(arg_31_1)
	arg_31_0:dispatchEvent(SettingsEvent.OnDownloadPackSuccess, arg_31_1)

	if arg_31_0.initFinish == false and arg_31_0.needUpdateMODic[arg_31_1] then
		arg_31_0.allUpdateSize = 0
		arg_31_0.alreadyUpdateSize = arg_31_0.needUpdateMODic[arg_31_1].size
		arg_31_0.needUpdateMODic[arg_31_1] = nil

		for iter_31_0, iter_31_1 in pairs(arg_31_0.needUpdateMODic) do
			arg_31_0.allUpdateSize = arg_31_0.allUpdateSize + iter_31_1.size
		end

		arg_31_0.allUpdateSize = arg_31_0.allUpdateSize / 1024 / 1024

		if arg_31_0.allUpdateSize == 0 then
			arg_31_0:_tryOptionDataInitedCallBack(true)
		end
	end
end

function var_0_0._setUseReserveUrl(arg_32_0)
	require("tolua.reflection")
	tolua.loadassembly("Assembly-CSharp")

	local var_32_0 = typeof(SLFramework.GameUpdate.OptionalUpdate)

	tolua.getfield(var_32_0, "_useReserveUrl", 36):Set(SLFramework.GameUpdate.OptionalUpdate.Instance, LoginModel.instance:getUseBackup())
end

function var_0_0._onDownloadPackFail(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	logNormal("SettingsVoicePackageController:_onDownloadPackFail, packName = " .. arg_33_1 .. " resUrl = " .. arg_33_2 .. " failError = " .. arg_33_3)
	arg_33_0:dispatchEvent(SettingsEvent.OnDownloadPackFail, arg_33_1, arg_33_2, arg_33_3)

	local var_33_0 = SettingsVoicePackageModel.instance:getPackLangName(arg_33_1)

	if arg_33_3 == 5 then
		arg_33_0:_onNotEnoughDiskSpace(arg_33_1)
	else
		LoginModel.instance:inverseUseBackup()
		arg_33_0:_setUseReserveUrl()
		LoginModel.instance:incFailCount()

		if LoginModel.instance:isFailNeedAlert() then
			LoginModel.instance:resetFailAlertCount()

			local var_33_1 = arg_33_0:_getDownloadFailedTip(arg_33_3, arg_33_4)

			if arg_33_0.initFinish == false then
				MessageBoxController.instance:showSystemMsgBoxAndSetBtn(MessageBoxIdDefine.VoiceDownloadCurFailed_1, MsgBoxEnum.BoxType.Yes_No, luaLang("retry"), "RETRY", booterLang("exit"), "EXIT", function()
					arg_33_0._optionalUpdateInst:RunNextStepAction()

					arg_33_0.errorCode = nil
				end, function()
					ProjBooter.instance:quitGame()
				end, nil, nil, nil, nil, var_33_0, var_33_1)
			else
				MessageBoxController.instance:showMsgBoxAndSetBtn(MessageBoxIdDefine.VoiceDownloadCurFailed_1, MsgBoxEnum.BoxType.Yes_No, luaLang("retry"), "RETRY", luaLang("cancel"), "CANCEL", function()
					arg_33_0._optionalUpdateInst:RunNextStepAction()

					arg_33_0.errorCode = nil
				end, function()
					SettingsVoicePackageModel.instance:clearNeedDownloadSize(arg_33_1)
					arg_33_0:_cancelDownload()
				end, nil, nil, nil, nil, var_33_0, var_33_1)
			end
		else
			arg_33_0:_retryDownload()
		end
	end

	local var_33_2 = SettingsVoicePackageModel.instance:getPackInfo(arg_33_1)
	local var_33_3 = {}

	var_33_3.step = ""
	var_33_3.spend_time = math.floor(Time.realtimeSinceStartup * 1000) - arg_33_0._downLoadStartTime
	var_33_3.update_amount = var_33_2:getLeftSizeMBNum()
	var_33_3.download_voice_pack_list = {
		var_33_2.lang
	}
	var_33_3.result_msg = arg_33_0:_getDownloadFailedTip(arg_33_3, arg_33_4)

	StatController.instance:track(SDKDataTrackMgr.EventName.voice_pack_downloading, var_33_3)
end

function var_0_0._retryDownload(arg_38_0)
	arg_38_0._optionalUpdateInst:RunNextStepAction()

	arg_38_0.errorCode = nil
end

function var_0_0._getDownloadFailedTip(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = SLFramework.GameUpdate.FailError

	arg_39_1 = var_39_0.IntToEnum(arg_39_1)
	arg_39_0.errorCode = arg_39_1
	arg_39_2 = arg_39_2 or ""

	if arg_39_1 == var_39_0.DownloadErrer then
		return booterLang("download_fail_download_error")
	elseif arg_39_1 == var_39_0.NotFound then
		return booterLang("download_fail_not_found")
	elseif arg_39_1 == var_39_0.ServerPause then
		return booterLang("download_fail_server_pause")
	elseif arg_39_1 == var_39_0.TimeOut then
		return booterLang("download_fail_time_out")
	elseif arg_39_1 == var_39_0.NoEnoughDisk then
		return booterLang("download_fail_no_enough_disk")
	elseif arg_39_1 == var_39_0.MD5CheckError then
		return booterLang("download_fail_md5_check_error")
	else
		return booterLang("download_fail_other") .. tostring(arg_39_2)
	end
end

function var_0_0._onNotEnoughDiskSpace(arg_40_0, arg_40_1)
	logNormal("SettingsVoicePackageController:_onNotEnoughDiskSpace, packName = " .. arg_40_1)
	arg_40_0:dispatchEvent(SettingsEvent.OnNotEnoughDiskSpace, arg_40_1)

	local var_40_0 = SettingsVoicePackageModel.instance:getPackLangName(arg_40_1)
	local var_40_1 = arg_40_0:_getDownloadFailedTip(var_0_0.NoEnoughDisk)

	if arg_40_0.initFinish == false then
		MessageBoxController.instance:showSystemMsgBoxAndSetBtn(MessageBoxIdDefine.VoiceDownloadCurFailed_3, MsgBoxEnum.BoxType.Yes_No, luaLang("retry"), "RETRY", booterLang("exit"), "EXIT", function()
			arg_40_0._optionalUpdateInst:RunNextStepAction()

			arg_40_0.errorCode = nil
		end, function()
			ProjBooter.instance:quitGame()
		end, nil, nil, nil, nil, var_40_0)
	else
		SettingsVoicePackageModel.instance:clearNeedDownloadSize(arg_40_1)
		GameFacade.showMessageBox(MessageBoxIdDefine.VoiceDownloadCurFailed_3, MsgBoxEnum.BoxType.Yes, function()
			arg_40_0:_cancelDownload()
		end, nil, nil, nil, nil, nil, var_40_0)
	end
end

function var_0_0._onPackUnZipFail(arg_44_0, arg_44_1, arg_44_2)
	logNormal("SettingsVoicePackageController:_onPackUnZipFail, packName = " .. arg_44_1 .. " failReason = " .. arg_44_2)
	arg_44_0:dispatchEvent(SettingsEvent.OnPackUnZipFail, arg_44_1, arg_44_2)

	local var_44_0 = SettingsVoicePackageModel.instance:getPackLangName(arg_44_1)
	local var_44_1 = arg_44_0:_getDownloadFailedTip(var_0_0.MD5CheckError)

	if arg_44_0.initFinish == false then
		MessageBoxController.instance:showSystemMsgBoxAndSetBtn(MessageBoxIdDefine.VoiceDownloadCurFailed_2, MsgBoxEnum.BoxType.Yes_No, luaLang("retry"), "RETRY", booterLang("exit"), "EXIT", function()
			arg_44_0._optionalUpdateInst:RunNextStepAction()

			arg_44_0.errorCode = nil
		end, function()
			ProjBooter.instance:quitGame()
		end, nil, nil, nil, nil, var_44_0)
	else
		SettingsVoicePackageModel.instance:clearNeedDownloadSize(arg_44_1)
		GameFacade.showMessageBox(MessageBoxIdDefine.VoiceDownloadCurFailed_2, MsgBoxEnum.BoxType.Yes, function()
			arg_44_0:_cancelDownload()
		end, nil, nil, nil, nil, nil, var_44_0)
	end
end

function var_0_0._onUnzipProgress(arg_48_0, arg_48_1)
	logNormal("正在解压资源包，请稍后... progress = " .. arg_48_1)

	if tostring(arg_48_1) == "nan" then
		return
	end

	GameSceneMgr.instance:dispatchEvent(SceneEventName.ShowDownloadInfo, arg_48_1, luaLang("voice_package_update_unzip"))
	arg_48_0:dispatchEvent(SettingsEvent.OnUnzipProgressRefresh, arg_48_1)
end

function var_0_0.cancelDownload(arg_49_0)
	arg_49_0:_cancelDownload()
end

function var_0_0._cancelDownload(arg_50_0)
	arg_50_0._optionalUpdateInst:StopDownload()
	arg_50_0._optionalUpdateInst:ClearThread()
	ViewMgr.instance:closeView(ViewName.SettingsVoiceDownloadView)

	arg_50_0.errorCode = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
