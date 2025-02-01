module("modules.logic.settings.view.SettingsAccountView", package.seeall)

slot0 = class("SettingsAccountView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnaccount = gohelper.findChildButtonWithAudio(slot0.viewGO, "Scroll View/Viewport/layout/accountInfo/content/#btn_account")
	slot0._btnaccountlogout = gohelper.findChildButtonWithAudio(slot0.viewGO, "Scroll View/Viewport/layout/accountlogout/content/#btn_accountlogout")
	slot0._btncdkey = gohelper.findChildButtonWithAudio(slot0.viewGO, "Scroll View/Viewport/layout/cdkey/content/#btn_cdkey")
	slot0._btnexit = gohelper.findChildButtonWithAudio(slot0.viewGO, "Scroll View/Viewport/layout/other/content/#btn_exit")
	slot0._btnPrivacy = gohelper.findChildClick(slot0.viewGO, "agreement/txtPrivacy")
	slot0._btnPersonal = gohelper.findChildClick(slot0.viewGO, "agreement/txtPersonal")
	slot0._btnThirdParty = gohelper.findChildClick(slot0.viewGO, "agreement/txtThirdParty")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnaccount:AddClickListener(slot0._btnaccountOnClick, slot0)
	slot0._btnaccountlogout:AddClickListener(slot0._btnaccountlogoutOnClick, slot0)
	slot0._btncdkey:AddClickListener(slot0._btncdkeyOnClick, slot0)
	slot0._btnexit:AddClickListener(slot0._btnexitOnClick, slot0)
	slot0._btnPrivacy:AddClickListener(slot0._btnPrivacyOnClick, slot0)
	slot0._btnPersonal:AddClickListener(slot0._btnPersonalOnClick, slot0)
	slot0._btnThirdParty:AddClickListener(slot0._btnThirdPartyOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnaccount:RemoveClickListener()
	slot0._btnaccountlogout:RemoveClickListener()
	slot0._btncdkey:RemoveClickListener()
	slot0._btnexit:RemoveClickListener()
	slot0._btnPrivacy:RemoveClickListener()
	slot0._btnPersonal:RemoveClickListener()
	slot0._btnThirdParty:RemoveClickListener()
end

function slot0._btnaccountOnClick(slot0)
	if slot0.isShowUserCenter then
		SDKMgr.instance:showUserCenter()
	end
end

function slot0._btnaccountlogoutOnClick(slot0)
	SDKMgr.instance:unregisterSdk()
end

function slot0._btncdkeyOnClick(slot0)
	ViewMgr.instance:openView(ViewName.SettingsCdkeyView)
end

function slot0._btnexitOnClick(slot0)
	SDKController.instance:openSDKExitView()
end

function slot0._editableInitView(slot0)
	slot0.goAccountContainer = gohelper.findChild(slot0.viewGO, "Scroll View/Viewport/layout/accountInfo")
	slot0.goCdkContainer = gohelper.findChild(slot0.viewGO, "Scroll View/Viewport/layout/cdkey")
	slot0.goAccountLogoutContainer = gohelper.findChild(slot0.viewGO, "Scroll View/Viewport/layout/accountlogout")

	gohelper.setActive(slot0.goAccountLogoutContainer, false)

	if VersionValidator.instance:isInReviewing() and SLFramework.FrameworkSettings.IsIOSPlayer() then
		gohelper.setActive(slot0.goCdkContainer, false)
	end

	if not HotUpdateVoiceMgr.IsGuoFu then
		gohelper.setActive(slot0._btnPrivacy.gameObject, false)
		gohelper.setActive(slot0._btnPersonal.gameObject, false)
		gohelper.setActive(slot0._btnThirdParty.gameObject, false)
	end

	slot0:addEventCb(SettingsController.instance, SettingsEvent.OnChangeLangTxt, slot0._OnChangeLangTxt, slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.isShowUserCenter = SDKMgr.instance:isShowUserCenter()

	gohelper.setActive(slot0.goAccountContainer, slot0.isShowUserCenter)
	logNormal("get sdk showCenter : " .. tostring(slot0.isShowUserCenter))
end

function slot0._btnPrivacyOnClick(slot0)
	UnityEngine.Application.OpenURL("https://m.sl916.com/protocol.html")
end

function slot0._btnPersonalOnClick(slot0)
	UnityEngine.Application.OpenURL("https://m.sl916.com/collected.html")
end

function slot0._btnThirdPartyOnClick(slot0)
	UnityEngine.Application.OpenURL("https://m.sl916.com/personal.html")
end

function slot0._OnChangeLangTxt(slot0)
	if LangSettings.instance:isEn() then
		recthelper.setAnchor(slot0._btnPrivacy.transform, -395, -375)
		recthelper.setAnchor(slot0._btnPersonal.transform, 112, -375)
		recthelper.setAnchor(slot0._btnThirdParty.transform, -225, -445)
	else
		recthelper.setAnchor(slot0._btnPrivacy.transform, -457, -445)
		recthelper.setAnchor(slot0._btnPersonal.transform, -122, -445)
		recthelper.setAnchor(slot0._btnThirdParty.transform, -312.67, -445)
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
