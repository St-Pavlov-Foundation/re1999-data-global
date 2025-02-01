module("modules.logic.login.view.FixResTipView", package.seeall)

slot0 = class("FixResTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._btntouchClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_touchClose")
	slot0._simagetipbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_tipbg")
	slot0._txttip = gohelper.findChildText(slot0.viewGO, "centerTip/#txt_tip")
	slot0._toggletip = gohelper.findChildToggle(slot0.viewGO, "centerTip/#toggle_tip")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._btnfix = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_fix")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btntouchClose:AddClickListener(slot0._btntouchCloseOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnfix:AddClickListener(slot0._btnfixOnClick, slot0)
	slot0._toggletip:AddOnValueChanged(slot0._toggleTipOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btntouchClose:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	slot0._btnfix:RemoveClickListener()
	slot0._toggletip:RemoveOnValueChanged()
end

function slot0._btntouchCloseOnClick(slot0)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnfixOnClick(slot0)
	if slot0._toggletip.isOn then
		SLFramework.FileHelper.DeleteFile(SLFramework.ResChecker.OutVersionPath)
		GameFacade.showMessageBox(MessageBoxIdDefine.FixFinished, MsgBoxEnum.BoxType.Yes, function ()
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
	elseif slot0.viewParam.callback then
		slot0.viewParam.callback(slot0.viewParam.callbackObj)
	end

	slot0:closeThis()
end

function slot0._toggleTipOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function slot0._editableInitView(slot0)
	slot0._toggletip.isOn = true

	slot0._simagetipbg:LoadImage(ResUrl.getMessageIcon("bg_tanchuang"))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	NavigateMgr.instance:addEscape(slot0.viewName, slot0._btncloseOnClick, slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagetipbg:UnLoadImage()
end

return slot0
