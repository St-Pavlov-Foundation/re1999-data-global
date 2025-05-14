module("projbooter.ui.BootMsgBox", package.seeall)

local var_0_0 = class("BootMsgBox")

function var_0_0.init(arg_1_0)
	arg_1_0._go = BootResMgr.instance:getMsgBoxGo()
	arg_1_0._rootTr = arg_1_0._go.transform

	local var_1_0 = typeof(UnityEngine.UI.Text)

	arg_1_0._txtTitle = arg_1_0._rootTr:Find("txtTitle"):GetComponent(var_1_0)
	arg_1_0._gotopTipEn = arg_1_0._rootTr:Find("topTip/txtEn").gameObject
	arg_1_0._txttopTipCn = arg_1_0._rootTr:Find("topTip/txtCn"):GetComponent(var_1_0)
	arg_1_0._txtContent = arg_1_0._rootTr:Find("txtContent"):GetComponent(var_1_0)
	arg_1_0._leftBtnGo = arg_1_0._rootTr:Find("btnLeft").gameObject
	arg_1_0._leftBtn = SLFramework.UGUI.ButtonWrap.Get(arg_1_0._leftBtnGo)
	arg_1_0._leftBtnTxt = arg_1_0._rootTr:Find("btnLeft/Text"):GetComponent(var_1_0)
	arg_1_0._leftBtnTxtEn = arg_1_0._rootTr:Find("btnLeft/Text-EN"):GetComponent(var_1_0)
	arg_1_0._rightBtnGo = arg_1_0._rootTr:Find("btnRight").gameObject
	arg_1_0._rightBtn = SLFramework.UGUI.ButtonWrap.Get(arg_1_0._rightBtnGo)
	arg_1_0._rightBtnTxt = arg_1_0._rootTr:Find("btnRight/Text"):GetComponent(var_1_0)
	arg_1_0._rightBtnTxtEn = arg_1_0._rootTr:Find("btnRight/Text-EN"):GetComponent(var_1_0)

	arg_1_0._leftBtn:AddClickListener(arg_1_0._onClickLeftBtn, arg_1_0)
	arg_1_0._rightBtn:AddClickListener(arg_1_0._onClickRightBtn, arg_1_0)
	GamepadBooter.instance:setBootMsgBoxClick(arg_1_0._onClickRightBtn, arg_1_0, arg_1_0._onClickLeftBtn, arg_1_0)
end

function var_0_0.show(arg_2_0, arg_2_1)
	if arg_2_0._isDisable then
		return
	end

	arg_2_0.args = arg_2_1

	local var_2_0 = GameConfig:GetCurLangShortcut()
	local var_2_1 = true

	if var_2_0 ~= "zh" then
		var_2_1 = false

		SLFramework.UGUI.RectTrHelper.SetAnchorY(arg_2_0._leftBtnTxt.transform, 15)
		SLFramework.UGUI.RectTrHelper.SetAnchorY(arg_2_0._rightBtnTxt.transform, 15)
	end

	arg_2_0._gotopTipEn:SetActive(var_2_1)
	arg_2_0._leftBtnTxtEn.gameObject:SetActive(var_2_1)
	arg_2_0._rightBtnTxtEn.gameObject:SetActive(var_2_1)

	arg_2_0._txtTitle.text = arg_2_1.title
	arg_2_0._txtContent.text = arg_2_1.content
	arg_2_0._txttopTipCn.text = booterLang("notice")

	arg_2_0._leftBtnGo:SetActive(arg_2_1.leftMsg ~= nil)

	arg_2_0._leftBtnTxt.text = arg_2_1.leftMsg and arg_2_1.leftMsg or ""
	arg_2_0._leftCb = arg_2_1.leftCb
	arg_2_0._leftCbObj = arg_2_1.leftCbObj

	arg_2_0._rightBtnGo:SetActive(arg_2_1.rightMsg ~= nil)

	arg_2_0._rightBtnTxt.text = arg_2_1.rightMsg and arg_2_1.rightMsg or ""
	arg_2_0._rightCb = arg_2_1.rightCb
	arg_2_0._rightCbObj = arg_2_1.rightCbObj
	arg_2_0._leftBtnTxtEn.text = arg_2_1.leftMsgEn or "EXIT"
	arg_2_0._rightBtnTxtEn.text = arg_2_1.rightMsgEn or "DOWNLOAD"

	SLFramework.UGUI.RectTrHelper.SetAnchorY(arg_2_0._txtTitle.transform, arg_2_1.titleAnchorY or 55)

	if arg_2_1.rightMsg ~= nil then
		SLFramework.UGUI.RectTrHelper.SetAnchorX(arg_2_0._leftBtnGo.transform, -247.1)
	else
		SLFramework.UGUI.RectTrHelper.SetAnchorX(arg_2_0._leftBtnGo.transform, 0)
	end

	if arg_2_1.leftMsg ~= nil then
		SLFramework.UGUI.RectTrHelper.SetAnchorX(arg_2_0._rightBtnGo.transform, 246.7)
	else
		SLFramework.UGUI.RectTrHelper.SetAnchorX(arg_2_0._rightBtnGo.transform, 0)
	end

	arg_2_0._go:SetActive(true)
end

function var_0_0.isShow(arg_3_0)
	if arg_3_0._go then
		return arg_3_0._go.activeInHierarchy
	end
end

function var_0_0.hide(arg_4_0)
	arg_4_0._go:SetActive(false)
end

function var_0_0.dispose(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0) do
		arg_5_0[iter_5_0] = nil
	end
end

function var_0_0._onClickLeftBtn(arg_6_0)
	arg_6_0:hide()

	if arg_6_0._leftCb == nil then
		return
	end

	local var_6_0 = arg_6_0._leftCb
	local var_6_1 = arg_6_0._leftCbObj

	arg_6_0._leftCb = nil
	arg_6_0._leftCbObj = nil

	var_6_0(var_6_1)
end

function var_0_0._onClickRightBtn(arg_7_0)
	arg_7_0:hide()

	if arg_7_0._rightCb == nil then
		return
	end

	local var_7_0 = arg_7_0._rightCb
	local var_7_1 = arg_7_0._rightCbObj

	arg_7_0._rightCb = nil
	arg_7_0._rightCbObj = nil

	var_7_0(var_7_1)
end

function var_0_0.dispose(arg_8_0)
	GamepadBooter.instance:dispose()
	arg_8_0._leftBtn:RemoveClickListener()
	arg_8_0._rightBtn:RemoveClickListener()

	for iter_8_0, iter_8_1 in pairs(arg_8_0) do
		if type(iter_8_1) == "userdata" then
			rawset(arg_8_0, iter_8_0, nil)
			logNormal("key = " .. tostring(iter_8_0) .. " value = " .. tostring(iter_8_1))
		end
	end
end

function var_0_0.disable(arg_9_0)
	arg_9_0._isDisable = true
end

var_0_0.instance = var_0_0.New()

return var_0_0
