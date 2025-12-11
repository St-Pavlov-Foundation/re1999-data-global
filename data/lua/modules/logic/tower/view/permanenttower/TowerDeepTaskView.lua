module("modules.logic.tower.view.permanenttower.TowerDeepTaskView", package.seeall)

local var_0_0 = class("TowerDeepTaskView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btncloseFullView = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_closeFullView")
	arg_1_0._scrolltask = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_task")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncloseFullView:AddClickListener(arg_2_0._btncloseFullViewOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.OnDeepTaskRewardGetFinish, arg_2_0._playGetRewardFinishAnim, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncloseFullView:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.OnDeepTaskRewardGetFinish, arg_3_0._playGetRewardFinishAnim, arg_3_0)
end

var_0_0.TaskMaskTime = 0.65
var_0_0.TaskGetAnimTime = 0.567

function var_0_0._btncloseFullViewOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btncloseOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._taskAnimRemoveItem = ListScrollAnimRemoveItem.Get(arg_6_0.viewContainer.scrollView)

	arg_6_0._taskAnimRemoveItem:setMoveInterval(0)
	arg_6_0._taskAnimRemoveItem:setMoveAnimationTime(var_0_0.TaskMaskTime - var_0_0.TaskGetAnimTime)

	arg_6_0.removeIndexTab = {}
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0._scrolltask.verticalNormalizedPosition = 1

	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_mission_open)
end

function var_0_0._playGetRewardFinishAnim(arg_9_0, arg_9_1)
	if arg_9_1 then
		arg_9_0.removeIndexTab = {
			arg_9_1
		}
	end

	TaskDispatcher.runDelay(arg_9_0.delayPlayFinishAnim, arg_9_0, var_0_0.TaskGetAnimTime)
end

function var_0_0.delayPlayFinishAnim(arg_10_0)
	arg_10_0._taskAnimRemoveItem:removeByIndexs(arg_10_0.removeIndexTab)
end

function var_0_0.onClose(arg_11_0)
	TaskDispatcher.cancelTask(arg_11_0.delayPlayFinishAnim, arg_11_0)
end

function var_0_0.onDestroyView(arg_12_0)
	return
end

return var_0_0
