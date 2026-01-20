-- chunkname: @projbooter/ui/BootMsgBox.lua

module("projbooter.ui.BootMsgBox", package.seeall)

local BootMsgBox = class("BootMsgBox")

function BootMsgBox:init()
	self._go = BootResMgr.instance:getMsgBoxGo()
	self._rootTr = self._go.transform

	local txtType = typeof(UnityEngine.UI.Text)

	self._txtTitle = self._rootTr:Find("txtTitle"):GetComponent(txtType)
	self._gotopTipEn = self._rootTr:Find("topTip/txtEn").gameObject
	self._txttopTipCn = self._rootTr:Find("topTip/txtCn"):GetComponent(txtType)
	self._txtContent = self._rootTr:Find("txtContent"):GetComponent(txtType)
	self._leftBtnGo = self._rootTr:Find("btnLeft").gameObject
	self._leftBtn = SLFramework.UGUI.ButtonWrap.Get(self._leftBtnGo)
	self._leftBtnTxt = self._rootTr:Find("btnLeft/Text"):GetComponent(txtType)
	self._leftBtnTxtEn = self._rootTr:Find("btnLeft/Text-EN"):GetComponent(txtType)
	self._rightBtnGo = self._rootTr:Find("btnRight").gameObject
	self._rightBtn = SLFramework.UGUI.ButtonWrap.Get(self._rightBtnGo)
	self._rightBtnTxt = self._rootTr:Find("btnRight/Text"):GetComponent(txtType)
	self._rightBtnTxtEn = self._rootTr:Find("btnRight/Text-EN"):GetComponent(txtType)

	self._leftBtn:AddClickListener(self._onClickLeftBtn, self)
	self._rightBtn:AddClickListener(self._onClickRightBtn, self)
	GamepadBooter.instance:setBootMsgBoxClick(self._onClickRightBtn, self, self._onClickLeftBtn, self)
end

function BootMsgBox:show(args)
	if self._isDisable then
		return
	end

	self.args = args

	local shortcut = GameConfig:GetCurLangShortcut()
	local ishide = true

	if shortcut ~= "zh" then
		ishide = false

		SLFramework.UGUI.RectTrHelper.SetAnchorY(self._leftBtnTxt.transform, 15)
		SLFramework.UGUI.RectTrHelper.SetAnchorY(self._rightBtnTxt.transform, 15)
	end

	self._gotopTipEn:SetActive(ishide)
	self._leftBtnTxtEn.gameObject:SetActive(ishide)
	self._rightBtnTxtEn.gameObject:SetActive(ishide)

	self._txtTitle.text = args.title
	self._txtContent.text = args.content
	self._txttopTipCn.text = booterLang("notice")

	self._leftBtnGo:SetActive(args.leftMsg ~= nil)

	self._leftBtnTxt.text = args.leftMsg and args.leftMsg or ""
	self._leftCb = args.leftCb
	self._leftCbObj = args.leftCbObj

	self._rightBtnGo:SetActive(args.rightMsg ~= nil)

	self._rightBtnTxt.text = args.rightMsg and args.rightMsg or ""
	self._rightCb = args.rightCb
	self._rightCbObj = args.rightCbObj
	self._leftBtnTxtEn.text = args.leftMsgEn or "EXIT"
	self._rightBtnTxtEn.text = args.rightMsgEn or "DOWNLOAD"

	SLFramework.UGUI.RectTrHelper.SetAnchorY(self._txtTitle.transform, args.titleAnchorY or 55)

	if args.rightMsg ~= nil then
		SLFramework.UGUI.RectTrHelper.SetAnchorX(self._leftBtnGo.transform, -247.1)
	else
		SLFramework.UGUI.RectTrHelper.SetAnchorX(self._leftBtnGo.transform, 0)
	end

	if args.leftMsg ~= nil then
		SLFramework.UGUI.RectTrHelper.SetAnchorX(self._rightBtnGo.transform, 246.7)
	else
		SLFramework.UGUI.RectTrHelper.SetAnchorX(self._rightBtnGo.transform, 0)
	end

	self._go:SetActive(true)
end

function BootMsgBox:isShow()
	if self._go then
		return self._go.activeInHierarchy
	end
end

function BootMsgBox:hide()
	self._go:SetActive(false)
end

function BootMsgBox:dispose()
	for k, v in pairs(self) do
		self[k] = nil
	end
end

function BootMsgBox:_onClickLeftBtn()
	self:hide()

	if self._leftCb == nil then
		return
	end

	local cb = self._leftCb
	local obj = self._leftCbObj

	self._leftCb = nil
	self._leftCbObj = nil

	cb(obj)
end

function BootMsgBox:_onClickRightBtn()
	self:hide()

	if self._rightCb == nil then
		return
	end

	local cb = self._rightCb
	local obj = self._rightCbObj

	self._rightCb = nil
	self._rightCbObj = nil

	cb(obj)
end

function BootMsgBox:dispose()
	GamepadBooter.instance:dispose()
	self._leftBtn:RemoveClickListener()
	self._rightBtn:RemoveClickListener()

	for key, value in pairs(self) do
		if type(value) == "userdata" then
			rawset(self, key, nil)
			logNormal("key = " .. tostring(key) .. " value = " .. tostring(value))
		end
	end
end

function BootMsgBox:disable()
	self._isDisable = true
end

function BootMsgBox:setContentText(textStr)
	if self._isDisable then
		return
	end

	self._txtContent.text = textStr
end

BootMsgBox.instance = BootMsgBox.New()

return BootMsgBox
