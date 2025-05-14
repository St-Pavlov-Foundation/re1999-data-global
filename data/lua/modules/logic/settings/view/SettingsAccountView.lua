module("modules.logic.settings.view.SettingsAccountView", package.seeall)

local var_0_0 = class("SettingsAccountView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnaccount = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Scroll View/Viewport/layout/accountInfo/content/#btn_account")
	arg_1_0._btnaccountlogout = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Scroll View/Viewport/layout/accountlogout/content/#btn_accountlogout")
	arg_1_0._btncdkey = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Scroll View/Viewport/layout/cdkey/content/#btn_cdkey")
	arg_1_0._btnexit = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Scroll View/Viewport/layout/other/content/#btn_exit")
	arg_1_0._btnPrivacy = gohelper.findChildClick(arg_1_0.viewGO, "agreement/txtPrivacy")
	arg_1_0._btnPersonal = gohelper.findChildClick(arg_1_0.viewGO, "agreement/txtPersonal")
	arg_1_0._btnThirdParty = gohelper.findChildClick(arg_1_0.viewGO, "agreement/txtThirdParty")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnaccount:AddClickListener(arg_2_0._btnaccountOnClick, arg_2_0)
	arg_2_0._btnaccountlogout:AddClickListener(arg_2_0._btnaccountlogoutOnClick, arg_2_0)
	arg_2_0._btncdkey:AddClickListener(arg_2_0._btncdkeyOnClick, arg_2_0)
	arg_2_0._btnexit:AddClickListener(arg_2_0._btnexitOnClick, arg_2_0)
	arg_2_0._btnPrivacy:AddClickListener(arg_2_0._btnPrivacyOnClick, arg_2_0)
	arg_2_0._btnPersonal:AddClickListener(arg_2_0._btnPersonalOnClick, arg_2_0)
	arg_2_0._btnThirdParty:AddClickListener(arg_2_0._btnThirdPartyOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnaccount:RemoveClickListener()
	arg_3_0._btnaccountlogout:RemoveClickListener()
	arg_3_0._btncdkey:RemoveClickListener()
	arg_3_0._btnexit:RemoveClickListener()
	arg_3_0._btnPrivacy:RemoveClickListener()
	arg_3_0._btnPersonal:RemoveClickListener()
	arg_3_0._btnThirdParty:RemoveClickListener()
end

function var_0_0._btnaccountOnClick(arg_4_0)
	if arg_4_0.isShowUserCenter then
		SDKMgr.instance:showUserCenter()
	end
end

function var_0_0._btnaccountlogoutOnClick(arg_5_0)
	SDKMgr.instance:unregisterSdk()
end

function var_0_0._btncdkeyOnClick(arg_6_0)
	ViewMgr.instance:openView(ViewName.SettingsCdkeyView)
end

function var_0_0._btnexitOnClick(arg_7_0)
	SDKController.instance:openSDKExitView()
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0.goAccountContainer = gohelper.findChild(arg_8_0.viewGO, "Scroll View/Viewport/layout/accountInfo")
	arg_8_0.goCdkContainer = gohelper.findChild(arg_8_0.viewGO, "Scroll View/Viewport/layout/cdkey")
	arg_8_0.goAccountLogoutContainer = gohelper.findChild(arg_8_0.viewGO, "Scroll View/Viewport/layout/accountlogout")

	gohelper.setActive(arg_8_0.goAccountLogoutContainer, false)

	if VersionValidator.instance:isInReviewing() and SLFramework.FrameworkSettings.IsIOSPlayer() then
		gohelper.setActive(arg_8_0.goCdkContainer, false)
	end

	if not HotUpdateVoiceMgr.IsGuoFu then
		gohelper.setActive(arg_8_0._btnPrivacy.gameObject, false)
		gohelper.setActive(arg_8_0._btnPersonal.gameObject, false)
		gohelper.setActive(arg_8_0._btnThirdParty.gameObject, false)
	end

	arg_8_0:addEventCb(SettingsController.instance, SettingsEvent.OnChangeLangTxt, arg_8_0._OnChangeLangTxt, arg_8_0)
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0.isShowUserCenter = SDKMgr.instance:isShowUserCenter()

	gohelper.setActive(arg_10_0.goAccountContainer, arg_10_0.isShowUserCenter)
	logNormal("get sdk showCenter : " .. tostring(arg_10_0.isShowUserCenter))
end

function var_0_0._btnPrivacyOnClick(arg_11_0)
	GameUtil.openURL("https://m.sl916.com/protocol.html")
end

function var_0_0._btnPersonalOnClick(arg_12_0)
	GameUtil.openURL("https://m.sl916.com/collected.html")
end

function var_0_0._btnThirdPartyOnClick(arg_13_0)
	GameUtil.openURL("https://m.sl916.com/personal.html")
end

function var_0_0._OnChangeLangTxt(arg_14_0)
	if LangSettings.instance:isEn() then
		recthelper.setAnchor(arg_14_0._btnPrivacy.transform, -395, -375)
		recthelper.setAnchor(arg_14_0._btnPersonal.transform, 112, -375)
		recthelper.setAnchor(arg_14_0._btnThirdParty.transform, -225, -445)
	else
		recthelper.setAnchor(arg_14_0._btnPrivacy.transform, -457, -445)
		recthelper.setAnchor(arg_14_0._btnPersonal.transform, -122, -445)
		recthelper.setAnchor(arg_14_0._btnThirdParty.transform, -312.67, -445)
	end
end

function var_0_0.onClose(arg_15_0)
	return
end

function var_0_0.onDestroyView(arg_16_0)
	return
end

return var_0_0
