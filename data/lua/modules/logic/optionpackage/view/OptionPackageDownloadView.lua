local var_0_0 = require("framework.helper.gohelper")

module("modules.logic.optionpackage.view.OptionPackageDownloadView", package.seeall)

local var_0_1 = class("OptionPackageDownloadView", BaseView)

function var_0_1.onInitView(arg_1_0)
	arg_1_0._txtpercent = var_0_0.findChildText(arg_1_0.viewGO, "view/progress/#txt_percent")
	arg_1_0._imageprogress = var_0_0.findChildImage(arg_1_0.viewGO, "view/progress/loadingline/#img_progress")
	arg_1_0._goprogress = var_0_0.findChild(arg_1_0.viewGO, "view/progress")
	arg_1_0._gomessgeBox = var_0_0.findChild(arg_1_0.viewGO, "view/#go_messgeBox")
	arg_1_0._txtdesc = var_0_0.findChildText(arg_1_0.viewGO, "view/#go_messgeBox/#txt_desc")
	arg_1_0._btnyes = var_0_0.findChildButtonWithAudio(arg_1_0.viewGO, "view/#go_messgeBox/#btn_yes")
	arg_1_0._btnno = var_0_0.findChildButtonWithAudio(arg_1_0.viewGO, "view/#go_messgeBox/#btn_no")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_1.addEvents(arg_2_0)
	arg_2_0._btnyes:AddClickListener(arg_2_0._btnyesOnClick, arg_2_0)
	arg_2_0._btnno:AddClickListener(arg_2_0._btnnoOnClick, arg_2_0)
end

function var_0_1.removeEvents(arg_3_0)
	arg_3_0._btnyes:RemoveClickListener()
	arg_3_0._btnno:RemoveClickListener()
end

function var_0_1._btnyesOnClick(arg_4_0)
	arg_4_0:_closeInvokeCallback(true)
end

function var_0_1._btnnoOnClick(arg_5_0)
	arg_5_0:_closeInvokeCallback(false)
end

function var_0_1._editableInitView(arg_6_0)
	arg_6_0._goNo = arg_6_0._btnno.gameObject
	arg_6_0._goYes = arg_6_0._btnyes.gameObject
	arg_6_0._txtYes = var_0_0.findChildText(arg_6_0._goYes, "#txt_confirm")
	arg_6_0._txtNo = var_0_0.findChildText(arg_6_0._goNo, "#txt_cancel")
	arg_6_0._txtYesen = var_0_0.findChildText(arg_6_0._goYes, "#txt_seitchen")
	arg_6_0._txtNoen = var_0_0.findChildText(arg_6_0._goNo, "#txt_cancelen")

	arg_6_0:_showMessgeBoxGo(false)
end

function var_0_1.onOpen(arg_7_0)
	arg_7_0:addEventCb(OptionPackageController.instance, OptionPackageEvent.DownloadProgressRefresh, arg_7_0._onDownloadProgress, arg_7_0)
	arg_7_0:addEventCb(OptionPackageController.instance, OptionPackageEvent.UnZipProgressRefresh, arg_7_0._onUnZipProgress, arg_7_0)
	arg_7_0:addEventCb(OptionPackageController.instance, OptionPackageEvent.DownladErrorMsg, arg_7_0._onDownladErrorMsg, arg_7_0)
end

function var_0_1._show(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._imageprogress.fillAmount = arg_8_1
	arg_8_0._txtpercent.text = arg_8_2
end

function var_0_1._onDownloadProgress(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = arg_9_2 / arg_9_3
	local var_9_1 = HotUpdateMgr.fixSizeStr(arg_9_2)
	local var_9_2 = HotUpdateMgr.fixSizeStr(arg_9_3)

	arg_9_0._downProgressS1 = var_9_1
	arg_9_0._downProgressS2 = var_9_2

	local var_9_3

	if UnityEngine.Application.internetReachability == UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork then
		var_9_3 = string.format(booterLang("download_info_wifi"), var_9_1, var_9_2)
	else
		var_9_3 = string.format(booterLang("download_info"), var_9_1, var_9_2)
	end

	arg_9_0:_show(var_9_0, var_9_3)
end

function var_0_1._onUnZipProgress(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0._downProgressS1 or ""
	local var_10_1 = arg_10_0._downProgressS2 or ""
	local var_10_2 = math.floor(100 * arg_10_1 + 0.5)
	local var_10_3

	if UnityEngine.Application.internetReachability == UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork then
		var_10_3 = string.format(booterLang("unziping_progress_wifi"), tostring(var_10_2), var_10_0, var_10_1)
	else
		var_10_3 = string.format(booterLang("unziping_progress"), tostring(var_10_2), var_10_0, var_10_1)
	end

	arg_10_0._txtpercent.text = var_10_3
end

function var_0_1._closeInvokeCallback(arg_11_0, arg_11_1)
	arg_11_0:_showMessgeBoxGo(false)

	local var_11_0 = arg_11_0._errorMsgInfo

	arg_11_0._errorMsgInfo = nil

	if var_11_0 then
		if arg_11_1 == true then
			if var_11_0.yesCallback then
				var_11_0.yesCallback(var_11_0.yesCallbackObj)
			end
		elseif var_11_0.noCallback then
			var_11_0.noCallback(var_11_0.noCallbackObj)
		end
	end
end

function var_0_1._showMessgeBoxGo(arg_12_0, arg_12_1)
	var_0_0.setActive(arg_12_0._gomessgeBox, arg_12_1)
	var_0_0.setActive(arg_12_0._goprogress, arg_12_1 == false)
end

function var_0_1._showErrorUI(arg_13_0)
	arg_13_0:_showMessgeBoxGo(arg_13_0._errorMsgInfo ~= nil)

	if arg_13_0._errorMsgInfo then
		local var_13_0 = arg_13_0._errorMsgInfo.msg

		arg_13_0._txtdesc.text = var_13_0

		local var_13_1 = arg_13_0._errorMsgInfo.yesStr or luaLang("confirm")
		local var_13_2 = arg_13_0._errorMsgInfo.noStr or luaLang("cancel")
		local var_13_3 = arg_13_0._errorMsgInfo.yesStrEn or "CONFIRM"
		local var_13_4 = arg_13_0._errorMsgInfo.noStrEn or "CANCEL"

		arg_13_0._txtYes.text = var_13_1
		arg_13_0._txtNo.text = var_13_2
		arg_13_0._txtYesen.text = var_13_3
		arg_13_0._txtNoen.text = var_13_4
	end
end

function var_0_1._onDownladErrorMsg(arg_14_0, arg_14_1)
	arg_14_0._errorMsgInfo = arg_14_1

	arg_14_0:_showErrorUI()
end

return var_0_1
