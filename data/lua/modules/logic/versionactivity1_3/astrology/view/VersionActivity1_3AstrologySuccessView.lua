module("modules.logic.versionactivity1_3.astrology.view.VersionActivity1_3AstrologySuccessView", package.seeall)

local var_0_0 = class("VersionActivity1_3AstrologySuccessView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goSuccess = gohelper.findChild(arg_1_0.viewGO, "#go_Success")
	arg_1_0._simageSuccessBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Success/#simage_SuccessBG")
	arg_1_0._simageSuccessCircleDec = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Success/#simage_SuccessCircleDec")
	arg_1_0._simageSuccessTitle = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Success/#simage_SuccessTitle")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._simageSuccessBG:LoadImage(ResUrl.getV1a3AstrologySinglebg("v1a3_astrology_successtitlebg"))
	TaskDispatcher.cancelTask(arg_5_0._onAminDone, arg_5_0)
	TaskDispatcher.runDelay(arg_5_0._onAminDone, arg_5_0, 3.5)
end

function var_0_0._onAminDone(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity1_3.play_ui_molu_astrology_success)
end

function var_0_0.onClose(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._onAminDone, arg_9_0)
end

function var_0_0.onDestroyView(arg_10_0)
	arg_10_0._simageSuccessBG:UnLoadImage()
end

return var_0_0
