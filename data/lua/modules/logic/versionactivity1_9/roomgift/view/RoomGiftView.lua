module("modules.logic.versionactivity1_9.roomgift.view.RoomGiftView", package.seeall)

local var_0_0 = class("RoomGiftView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._txtLimitTime = gohelper.findChildText(arg_1_0.viewGO, "LimitTime/image_LimitTimeBG/#txt_LimitTime")

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
	local var_6_0 = arg_6_0.viewParam.parent

	if var_6_0 then
		gohelper.addChild(var_6_0, arg_6_0.viewGO)
	end

	arg_6_0:_refreshTimeTick()
	TaskDispatcher.cancelTask(arg_6_0._refreshTimeTick, arg_6_0)
	TaskDispatcher.runRepeat(arg_6_0._refreshTimeTick, arg_6_0, TimeUtil.OneMinuteSecond)
end

function var_0_0._refreshTimeTick(arg_7_0)
	arg_7_0._txtLimitTime.text = ActivityHelper.getActivityRemainTimeStr(ActivityEnum.Activity.RoomGift)
end

function var_0_0.onClose(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._refreshTimeTick, arg_8_0)
end

function var_0_0.onDestroyView(arg_9_0)
	return
end

return var_0_0
