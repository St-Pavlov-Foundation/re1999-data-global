module("modules.logic.versionactivity2_1.aergusi.view.AergusiDialogEndView", package.seeall)

local var_0_0 = class("AergusiDialogEndView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._simagedec2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_dec2")
	arg_1_0._simagedec3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_dec3")
	arg_1_0._simagedec1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_dec1")

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
	arg_4_0._viewAnim = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.Activity163.play_ui_wangshi_argus_level_finish)
	arg_6_0:_refreshUI()
	TaskDispatcher.runDelay(arg_6_0._onShowFinished, arg_6_0, 2)
end

function var_0_0._refreshUI(arg_7_0)
	return
end

function var_0_0._onShowFinished(arg_8_0)
	arg_8_0._viewAnim:Play("close", 0, 0)
	TaskDispatcher.runDelay(arg_8_0._realClose, arg_8_0, 0.5)
end

function var_0_0._realClose(arg_9_0)
	if arg_9_0.viewParam.callback then
		arg_9_0.viewParam.callback(arg_9_0.viewParam.callbackObj)
	end

	arg_9_0:closeThis()
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._onShowFinished, arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0._realClose, arg_11_0)
end

return var_0_0
