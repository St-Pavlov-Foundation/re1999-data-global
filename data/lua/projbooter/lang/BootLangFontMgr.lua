module("projbooter.lang.BootLangFontMgr", package.seeall)

local var_0_0 = class("BootLangFontMgr")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0._font = arg_1_1

	ZProj.LangFontAssetMgr.Instance:SetLuaCallback(arg_1_0._setFontAsset, arg_1_0)
end

function var_0_0._setFontAsset(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_2 then
		arg_2_1.text.font = arg_2_0._font
	end
end

function var_0_0.dispose(arg_3_0)
	arg_3_0._font = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
