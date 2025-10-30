module("projbooter.ui.BootLoadingView", package.seeall)

local var_0_0 = class("BootLoadingView")

var_0_0.AutoChangeBgTime = 10
var_0_0.ClickChangeBgTime = 3
var_0_0.SwitchAnimTime = 0.667

function var_0_0.init(arg_1_0)
	arg_1_0._go = BootResMgr.instance:getLoadingViewGo()
	arg_1_0._rootTr = arg_1_0._go.transform
	arg_1_0._ani = arg_1_0._go:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._progressBar = SLFramework.UGUI.SliderWrap.GetWithPath(arg_1_0._go, "progressBar")

	arg_1_0:setPercent(0)

	local var_1_0 = typeof(UnityEngine.UI.Text)

	arg_1_0._txtPercent = arg_1_0._rootTr:Find("bottom_text/#txt_percent"):GetComponent(var_1_0)
	arg_1_0._txtWarn = arg_1_0._rootTr:Find("bottom_text/#txt_actualnum"):GetComponent(var_1_0)
	arg_1_0._bottomText = arg_1_0._rootTr:Find("bottom_text")
	arg_1_0._goDescribe = arg_1_0._rootTr:Find("describe_text")
	arg_1_0._aniTxt = arg_1_0._goDescribe:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0._txtDescribe1 = arg_1_0._rootTr:Find("describe_text/#txt_describe1"):GetComponent(var_1_0)
	arg_1_0._txtTitle1 = arg_1_0._rootTr:Find("describe_text/#txt_describe1/title/#txt_title"):GetComponent(var_1_0)
	arg_1_0._txtTitleEn1 = arg_1_0._rootTr:Find("describe_text/#txt_describe1/title/#txt_title_en"):GetComponent(var_1_0)
	arg_1_0._txtDescribe2 = arg_1_0._rootTr:Find("describe_text/#txt_describe2"):GetComponent(var_1_0)
	arg_1_0._txtTitle2 = arg_1_0._rootTr:Find("describe_text/#txt_describe2/title/#txt_title"):GetComponent(var_1_0)
	arg_1_0._txtTitleEn2 = arg_1_0._rootTr:Find("describe_text/#txt_describe2/title/#txt_title_en"):GetComponent(var_1_0)
	arg_1_0._txtFix = arg_1_0._rootTr:Find("#btn_fix/txt_fix"):GetComponent(var_1_0)
	arg_1_0._btnFix = SLFramework.UGUI.ButtonWrap.GetWithPath(arg_1_0._go, "#btn_fix")
	arg_1_0._goBg = UnityEngine.GameObject.Find("UIRoot/OriginBg")
	arg_1_0._btnClickBg = SLFramework.UGUI.UIClickListener.Get(arg_1_0._goBg)
	arg_1_0._clickBgEnable = false

	arg_1_0:_setLoadingItem()
	arg_1_0._btnFix:AddClickListener(arg_1_0._onClickFix, arg_1_0)
	arg_1_0._btnClickBg:AddClickListener(arg_1_0._onClickBg, arg_1_0)
	arg_1_0._btnFix.gameObject:SetActive(false)

	arg_1_0._updateHandle = UpdateBeat:CreateListener(arg_1_0._onFrameUpdate, arg_1_0)

	UpdateBeat:AddListener(arg_1_0._updateHandle)

	arg_1_0.hasClickFix = nil
end

function var_0_0._onClickBg(arg_2_0)
	if not arg_2_0._clickBgEnable then
		return
	end

	arg_2_0:_setLoadingItem()
end

function var_0_0._onClickFix(arg_3_0)
	if BootMsgBox.instance:isShow() and BootMsgBox.instance.args and BootMsgBox.instance.args.leftCbObj == arg_3_0 then
		return
	end

	local var_3_0 = {
		title = booterLang("fixed_content"),
		content = booterLang("fixed_content_tips") or "",
		leftMsg = booterLang("cancel")
	}

	var_3_0.leftMsgEn = "CANCEL"

	if BootMsgBox.instance:isShow() then
		local var_3_1 = BootMsgBox.instance.args

		if var_3_1 then
			arg_3_0._preMsgBoxArgs = {}

			for iter_3_0, iter_3_1 in pairs(var_3_1) do
				arg_3_0._preMsgBoxArgs[iter_3_0] = iter_3_1
			end

			var_3_0.leftCb = arg_3_0._cancelFixReturnPrevMsgBox
		end
	else
		var_3_0.leftCb = nil
	end

	var_3_0.leftCbObj = arg_3_0
	var_3_0.rightMsg = booterLang("sure")
	var_3_0.rightMsgEn = "CONFIRM"
	var_3_0.rightCb = arg_3_0.reallyFix
	var_3_0.rightCbObj = arg_3_0

	if string.nilorempty(var_3_0.content) then
		var_3_0.titleAnchorY = 10
	end

	BootMsgBox.instance:show(var_3_0)
end

function var_0_0._cancelFixReturnPrevMsgBox(arg_4_0)
	if arg_4_0._preMsgBoxArgs then
		local var_4_0 = arg_4_0._preMsgBoxArgs

		arg_4_0._preMsgBoxArgs = nil

		BootMsgBox.instance:show(var_4_0)
	end
end

function var_0_0.reallyFix(arg_5_0)
	arg_5_0.hasClickFix = true

	arg_5_0._btnFix.gameObject:SetActive(false)
	HotUpdateMgr.instance:stop()
	HotUpdateVoiceMgr.instance:stop()
	SLFramework.GameLuaEventDispatcher.Instance:ClearAllEvent()
	UnityEngine.PlayerPrefs.DeleteAll()
	SLFramework.GameUpdate.HotUpdateInfoMgr.RemoveLocalVersionFile()
	SLFramework.GameUpdate.OptionalUpdate.Instance:RemoveLocalVersionFile()
	UpdateBeat:Add(arg_5_0._onFrame, arg_5_0)

	arg_5_0._startTime = Time.time
	arg_5_0._hotupdateEvent = SLFramework.GameUpdate.HotUpdateEvent.Instance
	arg_5_0._optionalUpdate = SLFramework.GameUpdate.OptionalUpdate.Instance

	arg_5_0:_logThreadState()
end

local var_0_1 = {
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
	[32] = "WaitSleepJoin",
	[128] = "AbortRequested",
	[64] = "Suspended",
	[256] = "Aborted"
}
local var_0_2 = {
	[8] = true,
	[64] = true,
	[16] = true,
	[256] = true
}

function var_0_0._hasStop(arg_6_0, arg_6_1)
	if arg_6_1 == -1 then
		return true
	end

	for iter_6_0, iter_6_1 in pairs(var_0_2) do
		if bit.band(arg_6_1, iter_6_0) ~= 0 then
			return true
		end
	end
end

function var_0_0._getThreadStateDesc(arg_7_0, arg_7_1)
	if arg_7_1 == -1 then
		return "null"
	end

	if arg_7_1 == 0 then
		return var_0_1[arg_7_1]
	end

	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(var_0_1) do
		if bit.band(arg_7_1, iter_7_0) ~= 0 then
			table.insert(var_7_0, iter_7_1)
		end
	end

	return table.concat(var_7_0, "|")
end

function var_0_0._onFrame(arg_8_0)
	local var_8_0 = Time.time - arg_8_0._startTime

	if arg_8_0._startTime and var_8_0 > 60 then
		logNormal("修复程序等待线程退出超时了")
		UpdateBeat:Remove(arg_8_0._onFrame, arg_8_0)
		arg_8_0:_deleteCache()

		return
	end

	local var_8_1 = arg_8_0._hotupdateEvent.DownloadThreadState
	local var_8_2 = arg_8_0._hotupdateEvent.UnzipThreadState
	local var_8_3 = arg_8_0._optionalUpdate.DownloadThreadState
	local var_8_4 = arg_8_0._optionalUpdate.UnzipThreadState

	if arg_8_0:_hasStop(var_8_1) and arg_8_0:_hasStop(var_8_2) and arg_8_0:_hasStop(var_8_3) and arg_8_0:_hasStop(var_8_4) then
		logNormal(string.format("修复程序等待线程退出完成，耗时%.2fs", var_8_0))
		UpdateBeat:Remove(arg_8_0._onFrame, arg_8_0)
		Timer.New(function()
			arg_8_0:_deleteCache()
		end, 0.5):Start()
	end

	arg_8_0:_logThreadState()
end

function var_0_0._logThreadState(arg_10_0)
	local var_10_0 = arg_10_0._hotupdateEvent.DownloadThreadState
	local var_10_1 = arg_10_0._hotupdateEvent.UnzipThreadState
	local var_10_2 = arg_10_0._optionalUpdate.DownloadThreadState
	local var_10_3 = arg_10_0._optionalUpdate.UnzipThreadState
	local var_10_4 = arg_10_0:_getThreadStateDesc(var_10_0)
	local var_10_5 = arg_10_0:_getThreadStateDesc(var_10_1)
	local var_10_6 = arg_10_0:_getThreadStateDesc(var_10_2)
	local var_10_7 = arg_10_0:_getThreadStateDesc(var_10_3)

	logNormal(string.format("修复程序线程状态 热更下载%d_%s 热更解压%d_%s 语音下载%d_%s 语音解压%d_%s", var_10_0, var_10_4, var_10_1, var_10_5, var_10_2, var_10_6, var_10_3, var_10_7))
end

function var_0_0._deleteCache(arg_11_0)
	arg_11_0:_deleteAllCache()

	local var_11_0 = {
		title = booterLang("fixed_res_finish")
	}

	var_11_0.content = ""
	var_11_0.leftMsg = nil
	var_11_0.leftCb = nil
	var_11_0.leftCbObj = arg_11_0
	var_11_0.rightMsg = booterLang("sure")
	var_11_0.rightMsgEn = "CONFIRM"
	var_11_0.rightCb = arg_11_0.quitGame
	var_11_0.rightCbObj = arg_11_0
	var_11_0.titleAnchorY = 10

	BootMsgBox.instance:show(var_11_0)
end

function var_0_0.quitGame(arg_12_0)
	arg_12_0:_deleteAllCache()
	ProjBooter.instance:quitGame()
end

function var_0_0._deleteAllCache(arg_13_0)
	SLFramework.GameUpdate.HotUpdateInfoMgr.RemoveLocalVersionFile()
	SLFramework.GameUpdate.OptionalUpdate.Instance:RemoveLocalVersionFile()
	SLFramework.FileHelper.ClearDir(SLFramework.FrameworkSettings.PersistentResTmepDir1)
	SLFramework.FileHelper.ClearDir(SLFramework.FrameworkSettings.PersistentResTmepDir2)
	ZProj.GameHelper.DeleteAllCache()

	if BootNativeUtil.isWindows() then
		local var_13_0 = UnityEngine.Application.persistentDataPath
		local var_13_1 = System.Collections.Generic.List_string.New()

		var_13_1:Add(var_13_0 .. "/logicLog")
		var_13_1:Add(var_13_0 .. "/Player.log")
		SLFramework.FileHelper.ClearDirWithIgnore(var_13_0, nil, var_13_1)
	end
end

function var_0_0._setLoadingItem(arg_14_0)
	if not arg_14_0._goOriginBg then
		arg_14_0._goOriginBg = BootResMgr.instance:getOriginBgGo()

		arg_14_0._goOriginBg:SetActive(true)

		arg_14_0._bgAnim = arg_14_0._goOriginBg:GetComponent(typeof(UnityEngine.Animator))
		arg_14_0._imageBg1 = arg_14_0._goOriginBg.transform:Find("originbg1"):GetComponent(typeof(UnityEngine.UI.Image))
		arg_14_0._imageBg2 = arg_14_0._goOriginBg.transform:Find("originbg2"):GetComponent(typeof(UnityEngine.UI.Image))
	end

	arg_14_0._txtFix.text = booterLang("fixed")
	arg_14_0._clickBgEnable = false
	arg_14_0._setIndex = arg_14_0._setIndex and arg_14_0._setIndex + 1 or 1
	arg_14_0._initTime = Time.time

	BootResMgr.instance:getLoadingBg(arg_14_0._setIndex, arg_14_0._setSwitch, arg_14_0)
end

function var_0_0._setSwitch(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = GameConfig:GetCurLangShortcut()

	if arg_15_0._imageBg2.sprite then
		arg_15_0._txtDescribe1.gameObject:SetActive(true)
		arg_15_0._imageBg1.gameObject:SetActive(true)

		arg_15_0._imageBg1.sprite = arg_15_0._imageBg2.sprite
		arg_15_0._txtDescribe1.text = arg_15_0._txtDescribe2.text
		arg_15_0._txtTitle1.text = arg_15_0._txtTitle2.text
		arg_15_0._txtTitleEn1.text = arg_15_0._txtTitleEn2.text
		arg_15_0._hasSetDec1ForAnim = true

		if var_15_0 == "en" then
			arg_15_0._txtTitleEn1.gameObject:SetActive(false)
		else
			arg_15_0._txtTitleEn1.gameObject:SetActive(true)
		end
	else
		arg_15_0:_hideDesc1()
	end

	local var_15_1 = UnityEngine.Sprite.Create(arg_15_1, UnityEngine.Rect.New(0, 0, arg_15_1.width, arg_15_1.height), Vector2.zero)

	arg_15_0._imageBg2.sprite = var_15_1

	arg_15_0._aniTxt:Play("switch", 0, 0)
	arg_15_0._bgAnim:Play("switch", 0, 0)

	arg_15_0._txtDescribe2.text = arg_15_2[var_15_0 .. "Desc"]
	arg_15_0._txtTitle2.text = arg_15_2[var_15_0 .. "Title"]
	arg_15_0._txtTitleEn2.text = arg_15_2.titleen

	if var_15_0 == "en" then
		arg_15_0._txtTitleEn2.gameObject:SetActive(false)
	else
		arg_15_0._txtTitleEn2.gameObject:SetActive(true)
	end

	arg_15_0._initTime = Time.time
end

function var_0_0._onFrameUpdate(arg_16_0)
	if not arg_16_0._initTime then
		return
	end

	local var_16_0 = Time.time

	if arg_16_0._hasSetDec1ForAnim and var_16_0 - arg_16_0._initTime > var_0_0.SwitchAnimTime then
		arg_16_0._hasSetDec1ForAnim = nil

		arg_16_0:_hideDesc1()
	end

	if var_16_0 - arg_16_0._initTime > var_0_0.ClickChangeBgTime then
		arg_16_0:_onEnableClickBg()
	end

	if var_16_0 - arg_16_0._initTime > var_0_0.AutoChangeBgTime then
		arg_16_0:_onAutoChangeBg()
	end
end

function var_0_0._hideDesc1(arg_17_0)
	arg_17_0._txtDescribe1.text = ""
	arg_17_0._txtTitle1.text = ""
	arg_17_0._txtTitleEn1.text = ""

	arg_17_0._txtDescribe1.gameObject:SetActive(false)
	arg_17_0._imageBg1.gameObject:SetActive(false)
end

function var_0_0._onEnableClickBg(arg_18_0)
	if not arg_18_0._clickBgEnable then
		arg_18_0._clickBgEnable = true
	end
end

function var_0_0._onAutoChangeBg(arg_19_0)
	arg_19_0._initTime = Time.time

	arg_19_0:_setLoadingItem()
end

function var_0_0.addEventListeners(arg_20_0)
	return
end

function var_0_0.show(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	arg_21_0:setPercent(arg_21_1)
	arg_21_0:setProgressMsg(arg_21_2)
	arg_21_0:setWarnningMsg(arg_21_3)
	arg_21_0._go:SetActive(true)
end

function var_0_0.showMsg(arg_22_0, arg_22_1, arg_22_2)
	arg_22_0:setProgressMsg(arg_22_1)
	arg_22_0:setWarnningMsg(arg_22_2)
	arg_22_0._go:SetActive(true)
end

function var_0_0.showFixBtn(arg_23_0)
	arg_23_0._btnFix.gameObject:SetActive(true)
end

function var_0_0.setPercent(arg_24_0, arg_24_1)
	arg_24_0._progressBar:SetValue(arg_24_1)
end

function var_0_0.setProgressMsg(arg_25_0, arg_25_1)
	arg_25_0._txtPercent.text = arg_25_1 and arg_25_1 or ""
end

function var_0_0.setWarnningMsg(arg_26_0, arg_26_1)
	arg_26_0._txtWarn.text = arg_26_1 and arg_26_1 or ""
end

function var_0_0.hide(arg_27_0)
	arg_27_0._go:SetActive(false)
end

function var_0_0.playClose(arg_28_0)
	if arg_28_0._ani then
		arg_28_0._ani:Play("close")
	end
end

function var_0_0.dispose(arg_29_0)
	arg_29_0._btnFix:RemoveClickListener()
	arg_29_0._btnClickBg:RemoveClickListener()

	for iter_29_0, iter_29_1 in pairs(arg_29_0) do
		if type(iter_29_1) == "userdata" then
			rawset(arg_29_0, iter_29_0, nil)
		end
	end

	if arg_29_0._updateHandle then
		UpdateBeat:RemoveListener(arg_29_0._updateHandle)

		arg_29_0._updateHandle = nil
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
