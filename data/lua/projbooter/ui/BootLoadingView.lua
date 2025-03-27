module("projbooter.ui.BootLoadingView", package.seeall)

slot0 = class("BootLoadingView")
slot0.AutoChangeBgTime = 10
slot0.ClickChangeBgTime = 3
slot0.SwitchAnimTime = 0.667

function slot0.init(slot0)
	slot0._go = BootResMgr.instance:getLoadingViewGo()
	slot0._rootTr = slot0._go.transform
	slot0._ani = slot0._go:GetComponent(typeof(UnityEngine.Animator))
	slot0._progressBar = SLFramework.UGUI.SliderWrap.GetWithPath(slot0._go, "progressBar")

	slot0:setPercent(0)

	slot1 = typeof(UnityEngine.UI.Text)
	slot0._txtPercent = slot0._rootTr:Find("bottom_text/#txt_percent"):GetComponent(slot1)
	slot0._txtWarn = slot0._rootTr:Find("bottom_text/#txt_actualnum"):GetComponent(slot1)
	slot0._bottomText = slot0._rootTr:Find("bottom_text")
	slot0._goDescribe = slot0._rootTr:Find("describe_text")
	slot0._aniTxt = slot0._goDescribe:GetComponent(typeof(UnityEngine.Animator))
	slot0._txtDescribe1 = slot0._rootTr:Find("describe_text/#txt_describe1"):GetComponent(slot1)
	slot0._txtTitle1 = slot0._rootTr:Find("describe_text/#txt_describe1/title/#txt_title"):GetComponent(slot1)
	slot0._txtTitleEn1 = slot0._rootTr:Find("describe_text/#txt_describe1/title/#txt_title_en"):GetComponent(slot1)
	slot0._txtDescribe2 = slot0._rootTr:Find("describe_text/#txt_describe2"):GetComponent(slot1)
	slot0._txtTitle2 = slot0._rootTr:Find("describe_text/#txt_describe2/title/#txt_title"):GetComponent(slot1)
	slot0._txtTitleEn2 = slot0._rootTr:Find("describe_text/#txt_describe2/title/#txt_title_en"):GetComponent(slot1)
	slot0._txtFix = slot0._rootTr:Find("#btn_fix/txt_fix"):GetComponent(slot1)
	slot0._btnFix = SLFramework.UGUI.ButtonWrap.GetWithPath(slot0._go, "#btn_fix")
	slot0._goBg = UnityEngine.GameObject.Find("UIRoot/OriginBg")
	slot0._btnClickBg = SLFramework.UGUI.UIClickListener.Get(slot0._goBg)
	slot0._clickBgEnable = false

	slot0:_setLoadingItem()
	slot0._btnFix:AddClickListener(slot0._onClickFix, slot0)
	slot0._btnClickBg:AddClickListener(slot0._onClickBg, slot0)
	slot0._btnFix.gameObject:SetActive(false)

	slot0._updateHandle = UpdateBeat:CreateListener(slot0._onFrameUpdate, slot0)

	UpdateBeat:AddListener(slot0._updateHandle)

	slot0.hasClickFix = nil
end

function slot0._onClickBg(slot0)
	if not slot0._clickBgEnable then
		return
	end

	slot0:_setLoadingItem()
end

function slot0._onClickFix(slot0)
	if BootMsgBox.instance:isShow() and BootMsgBox.instance.args and BootMsgBox.instance.args.leftCbObj == slot0 then
		return
	end

	slot1 = {
		title = booterLang("fixed_content"),
		content = booterLang("fixed_content_tips") or "",
		leftMsg = booterLang("cancel"),
		leftMsgEn = "CANCEL"
	}

	if BootMsgBox.instance:isShow() then
		if BootMsgBox.instance.args then
			slot0._preMsgBoxArgs = {}

			for slot6, slot7 in pairs(slot2) do
				slot0._preMsgBoxArgs[slot6] = slot7
			end

			slot1.leftCb = slot0._cancelFixReturnPrevMsgBox
		end
	else
		slot1.leftCb = nil
	end

	slot1.leftCbObj = slot0
	slot1.rightMsg = booterLang("sure")
	slot1.rightMsgEn = "CONFIRM"
	slot1.rightCb = slot0.reallyFix
	slot1.rightCbObj = slot0

	if string.nilorempty(slot1.content) then
		slot1.titleAnchorY = 10
	end

	BootMsgBox.instance:show(slot1)
end

function slot0._cancelFixReturnPrevMsgBox(slot0)
	if slot0._preMsgBoxArgs then
		slot0._preMsgBoxArgs = nil

		BootMsgBox.instance:show(slot0._preMsgBoxArgs)
	end
end

function slot0.reallyFix(slot0)
	slot0.hasClickFix = true

	slot0._btnFix.gameObject:SetActive(false)
	HotUpdateMgr.instance:stop()
	HotUpdateVoiceMgr.instance:stop()
	UnityEngine.PlayerPrefs.DeleteAll()
	SLFramework.GameUpdate.HotUpdateInfoMgr.RemoveLocalVersionFile()
	SLFramework.GameUpdate.OptionalUpdate.Instance:RemoveLocalVersionFile()
	UpdateBeat:Add(slot0._onFrame, slot0)

	slot0._startTime = Time.time
	slot0._hotupdateEvent = SLFramework.GameUpdate.HotUpdateEvent.Instance
	slot0._optionalUpdate = SLFramework.GameUpdate.OptionalUpdate.Instance

	slot0:_logThreadState()
end

slot1 = {
	[0] = "Running",
	"StopRequested",
	"SuspendRequested",
	nil,
	"Background",
	nil,
	nil,
	nil,
	"Unstarted",
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	nil,
	"Stopped",
	[32.0] = "WaitSleepJoin",
	[128.0] = "AbortRequested",
	[64.0] = "Suspended",
	[256.0] = "Aborted"
}
slot2 = {
	[8.0] = true,
	[64.0] = true,
	[16.0] = true,
	[256.0] = true
}

function slot0._hasStop(slot0, slot1)
	if slot1 == -1 then
		return true
	end

	for slot5, slot6 in pairs(uv0) do
		if bit.band(slot1, slot5) ~= 0 then
			return true
		end
	end
end

function slot0._getThreadStateDesc(slot0, slot1)
	if slot1 == -1 then
		return "null"
	end

	if slot1 == 0 then
		return uv0[slot1]
	end

	slot2 = {}

	for slot6, slot7 in pairs(uv0) do
		if bit.band(slot1, slot6) ~= 0 then
			table.insert(slot2, slot7)
		end
	end

	return table.concat(slot2, "|")
end

function slot0._onFrame(slot0)
	if slot0._startTime and Time.time - slot0._startTime > 60 then
		logNormal("修复程序等待线程退出超时了")
		UpdateBeat:Remove(slot0._onFrame, slot0)
		slot0:_deleteCache()

		return
	end

	if slot0:_hasStop(slot0._hotupdateEvent.DownloadThreadState) and slot0:_hasStop(slot0._hotupdateEvent.UnzipThreadState) and slot0:_hasStop(slot0._optionalUpdate.DownloadThreadState) and slot0:_hasStop(slot0._optionalUpdate.UnzipThreadState) then
		logNormal(string.format("修复程序等待线程退出完成，耗时%.2fs", slot1))
		UpdateBeat:Remove(slot0._onFrame, slot0)
		Timer.New(function ()
			uv0:_deleteCache()
		end, 0.5):Start()
	end

	slot0:_logThreadState()
end

function slot0._logThreadState(slot0)
	slot1 = slot0._hotupdateEvent.DownloadThreadState
	slot2 = slot0._hotupdateEvent.UnzipThreadState
	slot3 = slot0._optionalUpdate.DownloadThreadState
	slot4 = slot0._optionalUpdate.UnzipThreadState

	logNormal(string.format("修复程序线程状态 热更下载%d_%s 热更解压%d_%s 语音下载%d_%s 语音解压%d_%s", slot1, slot0:_getThreadStateDesc(slot1), slot2, slot0:_getThreadStateDesc(slot2), slot3, slot0:_getThreadStateDesc(slot3), slot4, slot0:_getThreadStateDesc(slot4)))
end

function slot0._deleteCache(slot0)
	slot0:_deleteAllCache()
	BootMsgBox.instance:show({
		title = booterLang("fixed_res_finish"),
		content = "",
		leftMsg = nil,
		leftCb = nil,
		leftCbObj = slot0,
		rightMsg = booterLang("sure"),
		rightMsgEn = "CONFIRM",
		rightCb = slot0.quitGame,
		rightCbObj = slot0,
		titleAnchorY = 10
	})
end

function slot0.quitGame(slot0)
	slot0:_deleteAllCache()
	ProjBooter.instance:quitGame()
end

function slot0._deleteAllCache(slot0)
	SLFramework.GameUpdate.HotUpdateInfoMgr.RemoveLocalVersionFile()
	SLFramework.GameUpdate.OptionalUpdate.Instance:RemoveLocalVersionFile()
	SLFramework.FileHelper.ClearDir(SLFramework.FrameworkSettings.PersistentResTmepDir1)
	SLFramework.FileHelper.ClearDir(SLFramework.FrameworkSettings.PersistentResTmepDir2)
	ZProj.GameHelper.DeleteAllCache()

	if BootNativeUtil.isWindows() then
		slot1 = UnityEngine.Application.persistentDataPath
		slot2 = System.Collections.Generic.List_string.New()

		slot2:Add(slot1 .. "/logicLog")
		slot2:Add(slot1 .. "/Player.log")
		SLFramework.FileHelper.ClearDirWithIgnore(slot1, nil, slot2)
	end
end

function slot0._setLoadingItem(slot0)
	if not slot0._goOriginBg then
		slot0._goOriginBg = BootResMgr.instance:getOriginBgGo()

		slot0._goOriginBg:SetActive(true)

		slot0._bgAnim = slot0._goOriginBg:GetComponent(typeof(UnityEngine.Animator))
		slot0._imageBg1 = slot0._goOriginBg.transform:Find("originbg1"):GetComponent(typeof(UnityEngine.UI.Image))
		slot0._imageBg2 = slot0._goOriginBg.transform:Find("originbg2"):GetComponent(typeof(UnityEngine.UI.Image))
	end

	slot0._txtFix.text = booterLang("fixed")
	slot0._clickBgEnable = false
	slot0._setIndex = slot0._setIndex and slot0._setIndex + 1 or 1
	slot0._initTime = Time.time

	BootResMgr.instance:getLoadingBg(slot0._setIndex, slot0._setSwitch, slot0)
end

function slot0._setSwitch(slot0, slot1, slot2)
	if slot0._imageBg2.sprite then
		slot0._txtDescribe1.gameObject:SetActive(true)
		slot0._imageBg1.gameObject:SetActive(true)

		slot0._imageBg1.sprite = slot0._imageBg2.sprite
		slot0._txtDescribe1.text = slot0._txtDescribe2.text
		slot0._txtTitle1.text = slot0._txtTitle2.text
		slot0._txtTitleEn1.text = slot0._txtTitleEn2.text
		slot0._hasSetDec1ForAnim = true

		if GameConfig:GetCurLangShortcut() == "en" then
			slot0._txtTitleEn1.gameObject:SetActive(false)
		else
			slot0._txtTitleEn1.gameObject:SetActive(true)
		end
	else
		slot0:_hideDesc1()
	end

	slot0._imageBg2.sprite = UnityEngine.Sprite.Create(slot1, UnityEngine.Rect.New(0, 0, slot1.width, slot1.height), Vector2.zero)

	slot0._aniTxt:Play("switch", 0, 0)
	slot0._bgAnim:Play("switch", 0, 0)

	slot0._txtDescribe2.text = slot2[slot3 .. "Desc"]
	slot0._txtTitle2.text = slot2[slot3 .. "Title"]
	slot0._txtTitleEn2.text = slot2.titleen

	if slot3 == "en" then
		slot0._txtTitleEn2.gameObject:SetActive(false)
	else
		slot0._txtTitleEn2.gameObject:SetActive(true)
	end

	slot0._initTime = Time.time
end

function slot0._onFrameUpdate(slot0)
	if not slot0._initTime then
		return
	end

	slot1 = Time.time

	if slot0._hasSetDec1ForAnim and uv0.SwitchAnimTime < slot1 - slot0._initTime then
		slot0._hasSetDec1ForAnim = nil

		slot0:_hideDesc1()
	end

	if uv0.ClickChangeBgTime < slot1 - slot0._initTime then
		slot0:_onEnableClickBg()
	end

	if uv0.AutoChangeBgTime < slot1 - slot0._initTime then
		slot0:_onAutoChangeBg()
	end
end

function slot0._hideDesc1(slot0)
	slot0._txtDescribe1.text = ""
	slot0._txtTitle1.text = ""
	slot0._txtTitleEn1.text = ""

	slot0._txtDescribe1.gameObject:SetActive(false)
	slot0._imageBg1.gameObject:SetActive(false)
end

function slot0._onEnableClickBg(slot0)
	if not slot0._clickBgEnable then
		slot0._clickBgEnable = true
	end
end

function slot0._onAutoChangeBg(slot0)
	slot0._initTime = Time.time

	slot0:_setLoadingItem()
end

function slot0.addEventListeners(slot0)
end

function slot0.show(slot0, slot1, slot2, slot3)
	slot0:setPercent(slot1)
	slot0:setProgressMsg(slot2)
	slot0:setWarnningMsg(slot3)
	slot0._go:SetActive(true)
end

function slot0.showMsg(slot0, slot1, slot2)
	slot0:setProgressMsg(slot1)
	slot0:setWarnningMsg(slot2)
	slot0._go:SetActive(true)
end

function slot0.showFixBtn(slot0)
	slot0._btnFix.gameObject:SetActive(true)
end

function slot0.setPercent(slot0, slot1)
	slot0._progressBar:SetValue(slot1)
end

function slot0.setProgressMsg(slot0, slot1)
	slot0._txtPercent.text = slot1 and slot1 or ""
end

function slot0.setWarnningMsg(slot0, slot1)
	slot0._txtWarn.text = slot1 and slot1 or ""
end

function slot0.hide(slot0)
	slot0._go:SetActive(false)
end

function slot0.playClose(slot0)
	if slot0._ani then
		slot0._ani:Play("close")
	end
end

function slot0.dispose(slot0)
	slot0._btnFix:RemoveClickListener()
	slot0._btnClickBg:RemoveClickListener()

	for slot4, slot5 in pairs(slot0) do
		if type(slot5) == "userdata" then
			rawset(slot0, slot4, nil)
		end
	end

	if slot0._updateHandle then
		UpdateBeat:RemoveListener(slot0._updateHandle)

		slot0._updateHandle = nil
	end
end

slot0.instance = slot0.New()

return slot0
