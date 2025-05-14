module("modules.logic.seasonver.act166.view.Season166ToastItem", package.seeall)

local var_0_0 = class("Season166ToastItem", UserDataDispose)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:__onInit()

	arg_1_0._toastItem = arg_1_1
	arg_1_0._toastParams = arg_1_2
	arg_1_0._rootGO = arg_1_0._toastItem:getToastRootByType(ToastItem.ToastType.Season166)

	arg_1_0:_onUpdate()
end

var_0_0.ToastGOName = "Season166ToastItem"

function var_0_0._onUpdate(arg_2_0)
	arg_2_0.viewGO = gohelper.findChild(arg_2_0._rootGO, var_0_0.ToastGOName)

	if not arg_2_0.viewGO then
		local var_2_0 = Season166Controller.instance:tryGetToastAsset(arg_2_0._onToastLoadedCallBack, arg_2_0)

		if var_2_0 then
			arg_2_0.viewGO = gohelper.clone(var_2_0, arg_2_0._rootGO, var_0_0.ToastGOName)
		end
	end

	if arg_2_0.viewGO then
		arg_2_0:initComponents()
		arg_2_0:refreshUI()
	end
end

function var_0_0._onToastLoadedCallBack(arg_3_0, arg_3_1)
	arg_3_0:_onUpdate()
end

function var_0_0.initComponents(arg_4_0)
	if arg_4_0.viewGO then
		arg_4_0._txtToast = gohelper.findChildText(arg_4_0.viewGO, "#go_tips/txt_tips")
		arg_4_0._imageIcon = gohelper.findChildImage(arg_4_0.viewGO, "#go_tips/icon")
	end
end

function var_0_0.refreshUI(arg_5_0)
	arg_5_0._txtToast.text = tostring(arg_5_0._toastParams.toastTip)

	local var_5_0 = arg_5_0._toastParams.icon or 2

	UISpriteSetMgr.instance:setSeason166Sprite(arg_5_0._imageIcon, string.format("season166_result_tipsicon%s", var_5_0))
	arg_5_0._toastItem:setToastType(ToastItem.ToastType.Season166)
end

function var_0_0.dispose(arg_6_0)
	if arg_6_0._toastLoader then
		arg_6_0._toastLoader:dispose()

		arg_6_0._toastLoader = nil
	end

	if arg_6_0._simageAssessIcon then
		arg_6_0._simageAssessIcon:UnLoadImage()
	end

	arg_6_0._toastItem = nil
	arg_6_0._toastParams = nil

	arg_6_0:__onDispose()
end

return var_0_0
