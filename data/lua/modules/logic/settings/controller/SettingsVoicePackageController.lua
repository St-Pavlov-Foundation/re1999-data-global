module("modules.logic.settings.controller.SettingsVoicePackageController", package.seeall)

slot0 = class("SettingsVoicePackageController", BaseController)
slot0.NotDownload = 1
slot0.InDownload = 2
slot0.NeedUpdate = 3
slot0.AlreadyLatest = 4
slot0.DownloadFailedToast = 173
slot0.NoEnoughDisk = 5
slot0.MD5CheckError = 6

function slot0.onInit(slot0)
	slot0._httpGetter = nil
	slot0._optionalUpdate = SLFramework.GameUpdate.OptionalUpdate
	slot0._optionalUpdateInst = slot0._optionalUpdate.Instance
	slot0._downLoadStartTime = math.floor(Time.realtimeSinceStartup * 1000)
	slot0._statHotUpdatePerList = {
		{
			0,
			"start"
		},
		{
			0.2,
			"20%"
		},
		{
			0.4,
			"40%"
		},
		{
			0.6,
			"60%"
		},
		{
			0.8,
			"80%"
		},
		{
			1,
			"100%"
		}
	}
	slot0._statHotUpdatePerNum = 6
	slot0._nowStatHotUpdatePerIndex = 1
end

function slot0.onInitFinish(slot0)
end

function slot0.addConstEvents(slot0)
	if not HotUpdateVoiceMgr then
		return
	end

	if not GameConfig.CanHotUpdate then
		return
	end

	slot0._optionalUpdateInst:Register(slot0._optionalUpdate.NotEnoughDiskSpace, slot0._onNotEnoughDiskSpace, slot0)
	slot0._optionalUpdateInst:Register(slot0._optionalUpdate.DownloadStart, slot0._onDownloadStart, slot0)
	slot0._optionalUpdateInst:Register(slot0._optionalUpdate.DownloadProgressRefresh, slot0._onDownloadProgressRefresh, slot0)
	slot0._optionalUpdateInst:Register(slot0._optionalUpdate.DownloadPackFail, slot0._onDownloadPackFail, slot0)
	slot0._optionalUpdateInst:Register(slot0._optionalUpdate.DownloadPackSuccess, slot0._onDownloadPackSuccess, slot0)
	slot0._optionalUpdateInst:Register(slot0._optionalUpdate.PackUnZipFail, slot0._onPackUnZipFail, slot0)
	slot0._optionalUpdateInst:Register(slot0._optionalUpdate.PackItemStateChange, slot0._onPackItemStateChange, slot0)
	ConnectAliveMgr.instance:registerCallback(ConnectEvent.OnReconnectSucc, slot0._onReconnectSucc, slot0)
end

function slot0.register(slot0)
	slot0._optionalUpdateInst:Register(slot0._optionalUpdate.NotEnoughDiskSpace, slot0._onNotEnoughDiskSpace, slot0)
	slot0._optionalUpdateInst:Register(slot0._optionalUpdate.DownloadStart, slot0._onDownloadStart, slot0)
	slot0._optionalUpdateInst:Register(slot0._optionalUpdate.DownloadProgressRefresh, slot0._onDownloadProgressRefresh, slot0)
	slot0._optionalUpdateInst:Register(slot0._optionalUpdate.DownloadPackFail, slot0._onDownloadPackFail, slot0)
	slot0._optionalUpdateInst:Register(slot0._optionalUpdate.DownloadPackSuccess, slot0._onDownloadPackSuccess, slot0)
	slot0._optionalUpdateInst:Register(slot0._optionalUpdate.PackUnZipFail, slot0._onPackUnZipFail, slot0)
	slot0._optionalUpdateInst:Register(slot0._optionalUpdate.PackItemStateChange, slot0._onPackItemStateChange, slot0)
end

function slot0.reInit(slot0)
end

function slot0.getLocalVersionInt(slot0, slot1)
	if not GameConfig.CanHotUpdate then
		return 0
	end

	if not slot0._optionalUpdateInst then
		slot0._optionalUpdate = SLFramework.GameUpdate.OptionalUpdate
		slot0._optionalUpdateInst = slot0._optionalUpdate.Instance
	end

	if not string.nilorempty(slot0._optionalUpdateInst:GetLocalVersion(slot1)) then
		return tonumber(slot2)
	end

	return 0
end

function slot0.switchVoiceType(slot0, slot1, slot2)
	slot4 = GameLanguageMgr.instance:getStoryIndexByShortCut(slot1)

	PlayerPrefsHelper.setNumber("StoryAudioLanType", slot4 - 1)
	GameLanguageMgr.instance:setVoiceTypeByStoryIndex(slot4)
	PlayerPrefsHelper.setString(PlayerPrefsKey.VoiceTypeKey_Story, slot1)
	AudioMgr.instance:changeLang(slot1)
	GameConfig:SetCurVoiceType(slot1)
	slot0:dispatchEvent(SettingsEvent.OnChangeVoiceType)

	if slot2 == "in_settings" then
		StatController.instance:track(SDKDataTrackMgr.EventName.voice_pack_switch, {
			current_language = GameConfig:GetCurLangShortcut(),
			entrance = slot2 or "",
			current_voice_pack_list = SettingsVoicePackageModel.instance:getLocalVoiceTypeList() or {},
			current_voice_pack_used = slot1 or "",
			voice_pack_before = GameConfig:GetCurVoiceShortcut() or ""
		})
	else
		SDKDataTrackMgr.instance:trackVoicePackSwitch(slot5)
	end
end

function slot0.openVoicePackageView(slot0)
	if not slot0._httpGetter then
		slot0._httpGetter = SettingVoiceHttpGetter.New()

		slot0._httpGetter:start(slot0._onGetVoiceInfoAndOpenView, slot0)
	else
		slot0:_openVoicePackageView()
	end
end

function slot0.RequsetVoiceInfo(slot0, slot1, slot2)
	if not slot0._httpGetter then
		slot0._httpGetter = SettingVoiceHttpGetter.New()
	end

	slot0._httpGetter:start(function ()
		uv0:_onGetVoiceInfo()

		if uv1 then
			uv1(uv2)
		end
	end, slot0)
end

function slot0.onSettingVoiceDropDown(slot0)
	if not slot0._httpGetter then
		slot0._httpGetter = SettingVoiceHttpGetter.New()

		slot0._httpGetter:start(slot0._onGetVoiceInfo, slot0)
	end
end

function slot0._onGetVoiceInfo(slot0)
	for slot5, slot6 in pairs(slot0._httpGetter:getHttpResult()) do
		if SettingsVoicePackageModel.instance:getPackInfo(slot5) then
			slot7:setLangInfo(slot6)

			if #slot7.downloadResList.names > 0 then
				slot8 = slot7.downloadResList

				slot0._optionalUpdateInst:InitBreakPointInfo(slot8.names, slot8.hashs, slot8.orders, slot8.lengths)
				slot7:setLocalSize(tonumber(slot0._optionalUpdateInst:GetRecvSize()))
				slot0:dispatchEvent(SettingsEvent.OnPackItemStateChange, slot7.lang)
			end
		end
	end
end

function slot0._onGetVoiceInfoAndOpenView(slot0)
	slot0:_onGetVoiceInfo()
	slot0:_openVoicePackageView()
end

function slot0._openVoicePackageView(slot0)
	ViewMgr.instance:openView(ViewName.SettingsVoicePackageView)
end

function slot0.getHttpResult(slot0)
	if slot0._httpGetter then
		return slot0._httpGetter:getHttpResult()
	end
end

function slot0.getLangSize(slot0, slot1)
	if slot0._httpGetter then
		return slot0._httpGetter:getLangSize(slot1)
	end
end

function slot0.tryDownload(slot0, slot1, slot2)
	if ViewMgr.instance:isOpen(ViewName.SettingsVoiceDownloadView) then
		return
	end

	if #slot1.downloadResList.names == 0 then
		if slot0._httpGetter then
			slot0._httpGetter:stop()

			slot0._httpGetter = nil
		end

		slot0:openVoicePackageView()

		return
	end

	if slot2 then
		slot3, slot4, slot5 = slot1:getLeftSizeMBorGB()

		MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.DownloadVoicePack, MsgBoxEnum.BoxType.Yes_No, function ()
			StatController.instance:track(SDKDataTrackMgr.EventName.voice_pack_download_confirm, {
				entrance = "voice_list",
				update_amount = uv0:getLeftSizeMBNum(),
				download_voice_pack_list = {
					uv0.lang
				},
				current_voice_pack_list = SettingsVoicePackageModel.instance:getLocalVoiceTypeList(),
				current_language = GameConfig:GetCurLangShortcut(),
				current_voice_pack_used = GameConfig:GetCurVoiceShortcut()
			})
			uv1:startDownload(uv0)
			ViewMgr.instance:openView(ViewName.SettingsVoiceDownloadView, {
				packItemMO = uv0
			})
		end, function ()
		end, nil, , , , luaLang(slot1.nameLangId), string.format("%.2f%s", slot3, slot5))
	else
		slot0:startDownload(slot1)
		ViewMgr.instance:openView(ViewName.SettingsVoiceDownloadView, {
			packItemMO = slot1
		})
	end
end

function slot0.getPackItemState(slot0, slot1, slot2)
	return slot0._optionalUpdateInst:GetPackItemState(slot1, slot2)
end

function slot0.startDownload(slot0, slot1)
	logNormal("startDownload lang = " .. slot1.lang .. " version = " .. slot1.latestVersion)

	slot2 = slot1.downloadResList

	slot0._optionalUpdateInst:SetRemoteAssetUrl(slot1.download_url, slot1.download_url_bak)
	slot0:_setUseReserveUrl()
	slot0._optionalUpdateInst:StartDownload(slot1.lang, slot2.names, slot2.hashs, slot2.orders, slot2.lengths, slot1.latestVersion)
	slot0:_onDownloadPrepareStart(slot1.lang)
end

function slot0.stopDownload(slot0, slot1)
	slot0._optionalUpdateInst:StopDownload()
	slot0._optionalUpdateInst:ClearThread()
	slot0:dispatchEvent(SettingsEvent.OnDownloadPackFail, slot1.lang)
end

function slot0.startDownloadAll(slot0)
	for slot5, slot6 in pairs(SettingsVoicePackageListModel.instance:getList()) do
		if slot6:getStatus() == uv0.NotDownload or slot7 == uv0.NeedUpdate then
			slot0:startDownload(slot6)
		end
	end
end

function slot0.deleteVoicePack(slot0, slot1)
	slot2 = SettingsVoicePackageModel.instance:getPackInfo(slot1)

	StatController.instance:track(SDKDataTrackMgr.EventName.voice_pack_delete, {
		current_language = GameConfig:GetCurLangShortcut(),
		current_voice_pack_list = SettingsVoicePackageModel.instance:getLocalVoiceTypeList(),
		current_voice_pack_used = GameConfig:GetCurVoiceShortcut(),
		voice_pack_delete = slot2.lang
	})
	slot2:setLocalSize(0)
	slot0._optionalUpdateInst:RemovePackInfo(slot1)

	if slot1 == "res-HD" then
		slot4 = SLFramework.FrameworkSettings.PersistentResRootDir .. "/videos/HD"

		SLFramework.FileHelper.ClearDir(slot4)
		logNormal("removeVoicePack  hdDir=" .. slot4)
	else
		for slot7, slot8 in pairs(OptionPackageEnum.Package) do
			slot0._optionalUpdateInst:RemovePackInfo(HotUpdateOptionPackageMgr.instance:formatLangPackName(slot1, slot8))
		end

		slot4 = SLFramework.FrameworkSettings.PersistentResRootDir .. "/audios/" .. SLFramework.FrameworkSettings.CurPlatformName .. "/" .. slot1

		SLFramework.FileHelper.ClearDir(slot4)

		slot5 = SLFramework.FrameworkSettings.PersistentResRootDir .. "/videos/" .. slot1

		SLFramework.FileHelper.ClearDir(slot5)
		logNormal("removeVoicePack  audiosDir=" .. slot4)
		logNormal("removeVoicePack  voideoDir=" .. slot5)
	end

	ToastController.instance:showToast(183, luaLang(slot2.nameLangId))
	SettingsVoicePackageModel.instance:onDeleteVoicePack(slot1)
	slot0:dispatchEvent(SettingsEvent.OnPackItemStateChange, slot1)

	if slot0._httpGetter then
		slot0._httpGetter:stop()

		slot0._httpGetter = nil
	end

	slot0:openVoicePackageView()
end

function slot0._onReconnectSucc(slot0)
	if slot0.errorCode then
		if slot0.errorCode == SLFramework.GameUpdate.FailError.NoEnoughDisk or slot0.errorCode == slot1.MD5CheckError then
			slot0:_cancelDownload()
		else
			slot0._optionalUpdateInst:RunNextStepAction()
		end

		slot0.errorCode = nil
	end
end

function slot0._onDownloadPrepareStart(slot0, slot1)
	logNormal("SettingsVoicePackageController:_onDownloadPrepareStart, packName = " .. slot1)
	slot0:dispatchEvent(SettingsEvent.OnDownloadPrepareStart, slot1)
end

function slot0._onDownloadStart(slot0, slot1, slot2, slot3)
	logNormal("SettingsVoicePackageController:_onDownloadStart, packName = " .. slot1 .. " curSize = " .. slot2 .. " allSize = " .. slot3)
	SettingsVoicePackageModel.instance:setDownloadProgress(slot1, slot2, slot3)
	slot0:dispatchEvent(SettingsEvent.OnDownloadStart, slot1, slot2, slot3)

	slot0._nowStatHotUpdatePerIndex = 1
	slot0._downLoadStartTime = math.floor(Time.realtimeSinceStartup * 1000)

	slot0:statHotUpdate(slot2 / slot3, SettingsVoicePackageModel.instance:getPackInfo(slot1))
end

function slot0._onDownloadProgressRefresh(slot0, slot1, slot2, slot3)
	slot0._prevSize = slot2

	if LoginModel.instance:getFailCount() > 0 and (not slot0._prevSize or slot2 ~= slot0._prevSize) then
		LoginModel.instance:resetFailCount()
	end

	logNormal("SettingsVoicePackageController:_onDownloadProgressRefresh, packName = " .. slot1 .. " curSize = " .. slot2 .. " allSize = " .. slot3)
	SettingsVoicePackageModel.instance:setDownloadProgress(slot1, slot2, slot3)
	slot0:dispatchEvent(SettingsEvent.OnDownloadProgressRefresh, slot1, slot2, slot3)

	slot5 = SettingsVoicePackageModel.instance:getPackInfo(slot1)

	if slot0.initFinish == false then
		slot2 = string.format("%0.2f", slot2)
		slot3 = string.format("%0.2f", slot3)

		GameSceneMgr.instance:dispatchEvent(SceneEventName.ShowDownloadInfo, slot2 / slot3, GameUtil.getSubPlaceholderLuaLang(luaLang("voice_package_update_2"), {
			luaLang(slot5.nameLangId),
			slot2,
			slot3
		}))
	end

	slot0:statHotUpdate(slot2 / slot3, slot5)
end

function slot0.statHotUpdate(slot0, slot1, slot2)
	for slot6 = slot0._nowStatHotUpdatePerIndex, slot0._statHotUpdatePerNum do
		if slot0._statHotUpdatePerList[slot6][1] <= slot1 then
			slot9 = {
				step = slot7[2],
				spend_time = math.floor(Time.realtimeSinceStartup * 1000) - slot0._downLoadStartTime,
				update_amount = slot2:getLeftSizeMBNum(),
				download_voice_pack_list = {
					slot2.lang
				}
			}

			StatController.instance:track(SDKDataTrackMgr.EventName.voice_pack_downloading, slot9)

			slot9.result_msg = ""
			slot0._nowStatHotUpdatePerIndex = slot6 + 1
		else
			break
		end
	end
end

function slot0._onPackItemStateChange(slot0, slot1)
	logNormal("SettingsVoicePackageController:_onPackItemStateChange, packName = " .. slot1)
	slot0:dispatchEvent(SettingsEvent.OnPackItemStateChange, slot1)
end

function slot0._onDownloadPackSuccess(slot0, slot1)
	logNormal("SettingsVoicePackageController:_onDownloadPackSuccess, packName = " .. slot1)
	SettingsVoicePackageModel.instance:onDownloadSucc(slot1)
	slot0:dispatchEvent(SettingsEvent.OnDownloadPackSuccess, slot1)

	if slot0.initFinish == false and slot0.needUpdateMODic[slot1] then
		slot0.allUpdateSize = 0
		slot0.alreadyUpdateSize = slot0.needUpdateMODic[slot1].size
		slot0.needUpdateMODic[slot1] = nil

		for slot5, slot6 in pairs(slot0.needUpdateMODic) do
			slot0.allUpdateSize = slot0.allUpdateSize + slot6.size
		end

		slot0.allUpdateSize = slot0.allUpdateSize / 1024 / 1024

		if slot0.allUpdateSize == 0 then
			slot0:_tryOptionDataInitedCallBack(true)
		end
	end
end

function slot0._setUseReserveUrl(slot0)
	require("tolua.reflection")
	tolua.loadassembly("Assembly-CSharp")
	tolua.getfield(typeof(SLFramework.GameUpdate.OptionalUpdate), "_useReserveUrl", 36):Set(SLFramework.GameUpdate.OptionalUpdate.Instance, LoginModel.instance:getUseBackup())
end

function slot0._onDownloadPackFail(slot0, slot1, slot2, slot3, slot4)
	logNormal("SettingsVoicePackageController:_onDownloadPackFail, packName = " .. slot1 .. " resUrl = " .. slot2 .. " failError = " .. slot3)
	slot0:dispatchEvent(SettingsEvent.OnDownloadPackFail, slot1, slot2, slot3)

	slot5 = SettingsVoicePackageModel.instance:getPackLangName(slot1)

	if slot3 == 5 then
		slot0:_onNotEnoughDiskSpace(slot1)
	else
		LoginModel.instance:inverseUseBackup()
		slot0:_setUseReserveUrl()
		LoginModel.instance:incFailCount()

		if LoginModel.instance:isFailNeedAlert() then
			LoginModel.instance:resetFailAlertCount()

			if slot0.initFinish == false then
				MessageBoxController.instance:showSystemMsgBoxAndSetBtn(MessageBoxIdDefine.VoiceDownloadCurFailed_1, MsgBoxEnum.BoxType.Yes_No, luaLang("retry"), "RETRY", booterLang("exit"), "EXIT", function ()
					uv0._optionalUpdateInst:RunNextStepAction()

					uv0.errorCode = nil
				end, function ()
					ProjBooter.instance:quitGame()
				end, nil, , , , slot5, slot0:_getDownloadFailedTip(slot3, slot4))
			else
				MessageBoxController.instance:showMsgBoxAndSetBtn(MessageBoxIdDefine.VoiceDownloadCurFailed_1, MsgBoxEnum.BoxType.Yes_No, luaLang("retry"), "RETRY", luaLang("cancel"), "CANCEL", function ()
					uv0._optionalUpdateInst:RunNextStepAction()

					uv0.errorCode = nil
				end, function ()
					SettingsVoicePackageModel.instance:clearNeedDownloadSize(uv0)
					uv1:_cancelDownload()
				end, nil, , , , slot5, slot6)
			end
		else
			slot0:_retryDownload()
		end
	end

	slot6 = SettingsVoicePackageModel.instance:getPackInfo(slot1)

	StatController.instance:track(SDKDataTrackMgr.EventName.voice_pack_downloading, {
		step = "",
		spend_time = math.floor(Time.realtimeSinceStartup * 1000) - slot0._downLoadStartTime,
		update_amount = slot6:getLeftSizeMBNum(),
		download_voice_pack_list = {
			slot6.lang
		},
		result_msg = slot0:_getDownloadFailedTip(slot3, slot4)
	})
end

function slot0._retryDownload(slot0)
	slot0._optionalUpdateInst:RunNextStepAction()

	slot0.errorCode = nil
end

function slot0._getDownloadFailedTip(slot0, slot1, slot2)
	slot0.errorCode = SLFramework.GameUpdate.FailError.IntToEnum(slot1)
	slot2 = slot2 or ""

	if slot1 == slot3.DownloadErrer then
		return booterLang("download_fail_download_error")
	elseif slot1 == slot3.NotFound then
		return booterLang("download_fail_not_found")
	elseif slot1 == slot3.ServerPause then
		return booterLang("download_fail_server_pause")
	elseif slot1 == slot3.TimeOut then
		return booterLang("download_fail_time_out")
	elseif slot1 == slot3.NoEnoughDisk then
		return booterLang("download_fail_no_enough_disk")
	elseif slot1 == slot3.MD5CheckError then
		return booterLang("download_fail_md5_check_error")
	else
		return booterLang("download_fail_other") .. tostring(slot2)
	end
end

function slot0._onNotEnoughDiskSpace(slot0, slot1)
	logNormal("SettingsVoicePackageController:_onNotEnoughDiskSpace, packName = " .. slot1)
	slot0:dispatchEvent(SettingsEvent.OnNotEnoughDiskSpace, slot1)

	slot3 = slot0:_getDownloadFailedTip(uv0.NoEnoughDisk)

	if slot0.initFinish == false then
		MessageBoxController.instance:showSystemMsgBoxAndSetBtn(MessageBoxIdDefine.VoiceDownloadCurFailed_3, MsgBoxEnum.BoxType.Yes_No, luaLang("retry"), "RETRY", booterLang("exit"), "EXIT", function ()
			uv0._optionalUpdateInst:RunNextStepAction()

			uv0.errorCode = nil
		end, function ()
			ProjBooter.instance:quitGame()
		end, nil, , , , SettingsVoicePackageModel.instance:getPackLangName(slot1))
	else
		SettingsVoicePackageModel.instance:clearNeedDownloadSize(slot1)
		GameFacade.showMessageBox(MessageBoxIdDefine.VoiceDownloadCurFailed_3, MsgBoxEnum.BoxType.Yes, function ()
			uv0:_cancelDownload()
		end, nil, , , , , slot2)
	end
end

function slot0._onPackUnZipFail(slot0, slot1, slot2)
	logNormal("SettingsVoicePackageController:_onPackUnZipFail, packName = " .. slot1 .. " failReason = " .. slot2)
	slot0:dispatchEvent(SettingsEvent.OnPackUnZipFail, slot1, slot2)

	slot4 = slot0:_getDownloadFailedTip(uv0.MD5CheckError)

	if slot0.initFinish == false then
		MessageBoxController.instance:showSystemMsgBoxAndSetBtn(MessageBoxIdDefine.VoiceDownloadCurFailed_2, MsgBoxEnum.BoxType.Yes_No, luaLang("retry"), "RETRY", booterLang("exit"), "EXIT", function ()
			uv0._optionalUpdateInst:RunNextStepAction()

			uv0.errorCode = nil
		end, function ()
			ProjBooter.instance:quitGame()
		end, nil, , , , SettingsVoicePackageModel.instance:getPackLangName(slot1))
	else
		SettingsVoicePackageModel.instance:clearNeedDownloadSize(slot1)
		GameFacade.showMessageBox(MessageBoxIdDefine.VoiceDownloadCurFailed_2, MsgBoxEnum.BoxType.Yes, function ()
			uv0:_cancelDownload()
		end, nil, , , , , slot3)
	end
end

function slot0._onUnzipProgress(slot0, slot1)
	logNormal("正在解压资源包，请稍后... progress = " .. slot1)

	if tostring(slot1) == "nan" then
		return
	end

	GameSceneMgr.instance:dispatchEvent(SceneEventName.ShowDownloadInfo, slot1, luaLang("voice_package_update_unzip"))
	slot0:dispatchEvent(SettingsEvent.OnUnzipProgressRefresh, slot1)
end

function slot0.cancelDownload(slot0)
	slot0:_cancelDownload()
end

function slot0._cancelDownload(slot0)
	slot0._optionalUpdateInst:StopDownload()
	slot0._optionalUpdateInst:ClearThread()
	ViewMgr.instance:closeView(ViewName.SettingsVoiceDownloadView)

	slot0.errorCode = nil
end

slot0.instance = slot0.New()

return slot0
