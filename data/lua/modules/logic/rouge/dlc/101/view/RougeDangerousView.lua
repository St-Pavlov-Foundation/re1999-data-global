module("modules.logic.rouge.dlc.101.view.RougeDangerousView", package.seeall)

local var_0_0 = class("RougeDangerousView", BaseView)

var_0_0.OpenViewDuration = 2.5

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagedecbg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_decbg1")
	arg_1_0._simagedecbg2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_decbg2")
	arg_1_0._simagedecbg3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_decbg3")
	arg_1_0._simagedecbg4 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_decbg4")
	arg_1_0._simagedecbg5 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_decbg5")
	arg_1_0._simagetitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_title")

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
	arg_6_0:_delay2CloseView()
	AudioMgr.instance:trigger(AudioEnum.UI.OpenRougeDangerousView)
end

function var_0_0._delay2CloseView(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.closeThis, arg_7_0)
	TaskDispatcher.runDelay(arg_7_0.closeThis, arg_7_0, var_0_0.OpenViewDuration)
end

function var_0_0.onClose(arg_8_0)
	return
end

function var_0_0.onDestroyView(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0.closeThis, arg_9_0)
end

return var_0_0
