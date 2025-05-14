module("projbooter.ui.BootVersionView", package.seeall)

local var_0_0 = class("BootVersionView")

function var_0_0.show(arg_1_0)
	if not arg_1_0._go then
		arg_1_0._go = BootResMgr.instance:getVersionViewGo()
		arg_1_0._rootTr = arg_1_0._go.transform
		arg_1_0._txtVersion = arg_1_0._rootTr:Find("#txt_version"):GetComponent(typeof(UnityEngine.UI.Text))
	end

	if arg_1_0._go then
		arg_1_0._go:SetActive(true)

		local var_1_0 = UnityEngine.Application.version
		local var_1_1 = SLFramework.GameUpdate.HotUpdateInfoMgr.LocalResVersionStr
		local var_1_2 = BootNativeUtil.getAppVersion()

		arg_1_0._txtVersion.text = string.format("V%s-%s-%s", var_1_0, var_1_1, tostring(var_1_2))
	end
end

function var_0_0.hide(arg_2_0)
	if arg_2_0._go then
		arg_2_0._go:SetActive(false)
	end
end

function var_0_0.dispose(arg_3_0)
	arg_3_0:hide()

	arg_3_0._go = nil
	arg_3_0._rootTr = nil
	arg_3_0._txtVersion = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
