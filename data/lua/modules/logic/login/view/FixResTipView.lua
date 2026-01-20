-- chunkname: @modules/logic/login/view/FixResTipView.lua

module("modules.logic.login.view.FixResTipView", package.seeall)

local FixResTipView = class("FixResTipView", BaseView)

function FixResTipView:onInitView()
	self._btntouchClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_touchClose")
	self._simagetipbg = gohelper.findChildSingleImage(self.viewGO, "#simage_tipbg")
	self._txttip = gohelper.findChildText(self.viewGO, "centerTip/#txt_tip")
	self._toggletip = gohelper.findChildToggle(self.viewGO, "centerTip/#toggle_tip")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._btnfix = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_fix")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function FixResTipView:addEvents()
	self._btntouchClose:AddClickListener(self._btntouchCloseOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnfix:AddClickListener(self._btnfixOnClick, self)
	self._toggletip:AddOnValueChanged(self._toggleTipOnClick, self)
end

function FixResTipView:removeEvents()
	self._btntouchClose:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btnfix:RemoveClickListener()
	self._toggletip:RemoveOnValueChanged()
end

function FixResTipView:_btntouchCloseOnClick()
	return
end

function FixResTipView:_btncloseOnClick()
	self:closeThis()
end

function FixResTipView:_btnfixOnClick()
	if self._toggletip.isOn then
		PlayerPrefsHelper.setNumber(PlayerPrefsKey.Manual_FixRes, 1)

		if ResCheckMgr.instance.DeleteOutVersion then
			ResCheckMgr.instance:DeleteOutVersion()
		else
			SLFramework.FileHelper.DeleteFile(SLFramework.ResChecker.OutVersionPath)
			SLFramework.FileHelper.DeleteFile(SLFramework.ResChecker.OutVersionPath .. "_mass")
		end

		GameFacade.showMessageBox(MessageBoxIdDefine.FixFinished, MsgBoxEnum.BoxType.Yes, function()
			PlayerPrefsHelper.save()

			if BootNativeUtil.isAndroid() then
				if SDKMgr.restartGame ~= nil then
					SDKMgr.instance:restartGame()
				else
					ProjBooter.instance:quitGame()
				end
			else
				ProjBooter.instance:quitGame()
			end
		end)
	elseif self.viewParam.callback then
		self.viewParam.callback(self.viewParam.callbackObj)
	end

	self:closeThis()
end

function FixResTipView:_toggleTipOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function FixResTipView:_editableInitView()
	self._toggletip.isOn = true

	self._simagetipbg:LoadImage(ResUrl.getMessageIcon("bg_tanchuang"))
end

function FixResTipView:onUpdateParam()
	return
end

function FixResTipView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	NavigateMgr.instance:addEscape(self.viewName, self._btncloseOnClick, self)
end

function FixResTipView:onClose()
	return
end

function FixResTipView:onDestroyView()
	self._simagetipbg:UnLoadImage()
end

return FixResTipView
