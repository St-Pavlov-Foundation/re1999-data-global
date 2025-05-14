module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogStartView", package.seeall)

local var_0_0 = class("AergusiDialogStartView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._simagedec2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_dec2")
	arg_1_0._simagedec1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_dec1")
	arg_1_0._simagedec3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_dec3")
	arg_1_0._txtdesc = gohelper.findChildText(arg_1_0.viewGO, "txt_dec1")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.Activity163.play_ui_wangshi_argus_level_ask)
	arg_6_0:_refreshUI()
	TaskDispatcher.runDelay(arg_6_0._onShowFinished, arg_6_0, 2)
end

function var_0_0._refreshUI(arg_7_0)
	local var_7_0 = AergusiConfig.instance:getEvidenceConfig(arg_7_0.viewParam.groupId)

	arg_7_0._txtdesc.text = var_7_0.conditionStr
end

function var_0_0._onShowFinished(arg_8_0)
	arg_8_0:closeThis()
end

function var_0_0.onClose(arg_9_0)
	return
end

function var_0_0.onDestroyView(arg_10_0)
	if arg_10_0.viewParam.callback then
		arg_10_0.viewParam.callback(arg_10_0.viewParam.callbackObj)
	end

	TaskDispatcher.cancelTask(arg_10_0._onShowFinished, arg_10_0)
end

return var_0_0
