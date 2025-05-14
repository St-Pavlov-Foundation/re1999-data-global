module("modules.logic.room.view.record.RoomRecordView", package.seeall)

local var_0_0 = class("RoomRecordView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._animator = arg_1_0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(RoomController.instance, RoomEvent.SwitchRecordView, arg_2_0.switchTabView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(RoomController.instance, RoomEvent.SwitchRecordView, arg_3_0.switchTabView, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_yield_open)
	CritterRpc.instance:sendGetCritterBookInfoRequest()
	RoomRpc.instance:sendGetRoomLogRequest()
end

function var_0_0.switchTabView(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1.animName

	arg_7_0._switchView = arg_7_1.view

	if not var_7_0 then
		return
	end

	arg_7_0._animator.enabled = true

	arg_7_0._animator:Play(var_7_0, 0, 0)
	TaskDispatcher.runDelay(arg_7_0.switchTabViewAfterAnim, arg_7_0, RoomRecordEnum.AnimTime)
end

function var_0_0.switchTabViewAfterAnim(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0.switchTabViewAfterAnim, arg_8_0)

	if not arg_8_0._switchView then
		return
	end

	if arg_8_0._switchView == RoomRecordEnum.View.Task then
		RoomRpc.instance:sendGetTradeTaskInfoRequest(arg_8_0._reallySwitchTabView, arg_8_0)
	else
		arg_8_0:_reallySwitchTabView()
	end
end

function var_0_0._reallySwitchTabView(arg_9_0)
	arg_9_0.viewContainer:selectTabView(arg_9_0._switchView)

	arg_9_0._switchView = nil
end

function var_0_0.onClose(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0.switchTabViewAfterAnim, arg_10_0)
end

function var_0_0.onDestroyView(arg_11_0)
	return
end

return var_0_0
