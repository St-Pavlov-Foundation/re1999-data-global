module("modules.logic.versionactivity3_1.gaosiniao.view.V3a1_GaoSiNiao_TaskView", package.seeall)

local var_0_0 = class("V3a1_GaoSiNiao_TaskView", CorvusTaskView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._scrollTaskList = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_TaskList")
	arg_1_0._simagelangtxt = gohelper.findChildSingleImage(arg_1_0.viewGO, "Left/LimitTime/#simage_langtxt")
	arg_1_0._txtlimittime = gohelper.findChildText(arg_1_0.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_limittime")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")

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
	var_0_0.super.onUpdateParam(arg_5_0)
	arg_5_0:_showLeftTime()
	TaskDispatcher.cancelTask(arg_5_0._showLeftTime, arg_5_0)
	TaskDispatcher.runRepeat(arg_5_0._showLeftTime, arg_5_0, TimeUtil.OneMinuteSecond)
end

function var_0_0.onOpen(arg_6_0)
	var_0_0.super.onOpen(arg_6_0)
end

function var_0_0.onOpenFinish(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
end

function var_0_0.onClose(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._showLeftTime, arg_8_0)
	var_0_0.super.onClose(arg_8_0)
end

function var_0_0.onDestroyView(arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._showLeftTime, arg_9_0)
	var_0_0.super.onDestroyView(arg_9_0)
end

function var_0_0._showLeftTime(arg_10_0)
	arg_10_0._txtlimittime.text = arg_10_0:getActivityRemainTimeStr()
end

function var_0_0._refresh(arg_11_0)
	arg_11_0:_setTaskList()
end

return var_0_0
