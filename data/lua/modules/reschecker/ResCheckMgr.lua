module("modules.reschecker.ResCheckMgr", package.seeall)

slot0 = class("ResCheckMgr")

function slot0.ctor(slot0)
end

function slot0.startCheck(slot0, slot1, slot2)
	slot0.cb = slot1
	slot0.cbObj = slot2

	if tostring(tonumber(BootNativeUtil.getAppVersion())) == SLFramework.FileHelper.ReadText(SLFramework.ResChecker.OutVersionPath) then
		logNormal("ResCheckMgr pass, is not first init")
		slot0:doCallBack(true)

		return
	end

	SLFramework.TimeWatch.Instance:Start()

	slot0.eventDispatcher = SLFramework.GameLuaEventDispatcher.Instance

	slot0.eventDispatcher:AddListener(slot0.eventDispatcher.ResChecker_Finish, slot0.onCheckFinish, slot0)
	slot0.eventDispatcher:AddListener(slot0.eventDispatcher.ResChecker_Progress, slot0.onCheckProgress, slot0)

	slot5 = slot0:_getAllLocalLang()
	slot6, slot7 = slot0:_getDLCInfo(slot5)

	SLFramework.ResChecker.Instance:CheckAllRes(slot5, slot6, slot7)
end

function slot0.onCheckProgress(slot0, slot1, slot2)
	logNormal("ResCheckMgr:onCheckProgress, 检查进度 doneFileNum = " .. slot1 .. " allFileNum = " .. slot2)
	BootLoadingView.instance:show(slot1 / slot2, string.format(booterLang("rescheker"), slot1, slot2))
end

function slot0.onCheckFinish(slot0, slot1, slot2)
	logNormal("ResCheckMgr:onCheckFinish:allPass = " .. tostring(slot1) .. " #allSize = " .. tonumber(tostring(slot2)) .. " #cost time: " .. SLFramework.TimeWatch.Instance:Watch() .. " s")

	if slot1 then
		slot0:doCallBack(true)
	elseif UnityEngine.Application.internetReachability == UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork then
		slot0:doCallBack()
	else
		BootMsgBox.instance:show({
			title = booterLang("hotupdate"),
			content = string.format(booterLang("hotupdate_info"), HotUpdateMgr.instance:_fixSizeStr(slot2)),
			leftMsg = booterLang("exit"),
			leftCb = slot0._quitGame,
			leftCbObj = slot0,
			rightMsg = booterLang("download"),
			rightCb = slot0.doCallBack,
			rightCbObj = slot0
		})
	end
end

function slot0.doCallBack(slot0, slot1)
	if slot0.eventDispatcher then
		slot0.eventDispatcher:RemoveListener(slot0.eventDispatcher.ResChecker_Finish)
		slot0.eventDispatcher:RemoveListener(slot0.eventDispatcher.ResChecker_Progress)
	end

	if slot1 then
		slot0:markLastCheckAppVersion()
	end

	if slot0.cb then
		slot0.cb(slot0.cbObj, slot1)
	end
end

function slot0.markLastCheckAppVersion(slot0)
	logNormal("ResCheckMgr:markLastCheckAppVersion")
	SLFramework.FileHelper.WriteTextToPath(SLFramework.ResChecker.OutVersionPath, BootNativeUtil.getAppVersion())
end

function slot0._quitGame(slot0)
	logNormal("ResCheckMgr:_quitGame, 退出游戏！")
	ProjBooter.instance:quitGame()
end

function slot0._getAllLocalLang(slot0)
	SLFramework.GameUpdate.OptionalUpdate.Instance:Init()

	slot2 = {}

	for slot8 = 1, #HotUpdateVoiceMgr.instance:getSupportVoiceLangs() do
		if slot3[slot8] == GameConfig:GetDefaultVoiceShortcut() or not string.nilorempty(slot1:GetLocalVersion(slot9)) or not BootVoiceView.instance:isFirstDownloadDone() then
			table.insert(slot2, slot9)
		end
	end

	return slot2
end

function slot0._getDLCInfo(slot0, slot1)
	slot3 = {}

	for slot7, slot8 in ipairs(HotUpdateOptionPackageMgr.instance:getPackageNameList()) do
		table.insert(slot3, HotUpdateOptionPackageMgr.instance:formatLangPackName("res", slot8))

		slot12 = HotUpdateOptionPackageMgr.instance
		slot12 = slot12.formatLangPackName

		table.insert(slot3, slot12(slot12, "media", slot8))

		for slot12, slot13 in ipairs(slot1) do
			table.insert(slot3, HotUpdateOptionPackageMgr.instance:formatLangPackName(slot13, slot8))
		end
	end

	return #slot3 > 0, slot3
end

slot0.instance = slot0.New()

return slot0
