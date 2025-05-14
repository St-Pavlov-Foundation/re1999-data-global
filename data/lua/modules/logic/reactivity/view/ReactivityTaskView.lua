module("modules.logic.reactivity.view.ReactivityTaskView", package.seeall)

local var_0_0 = class("ReactivityTaskView", BaseView)
local var_0_1 = 0.8

function var_0_0.refreshRemainTime_overseas(arg_1_0)
	local var_1_0 = ActivityModel.instance:getActMO(arg_1_0.actId):getRemainTimeStr3()

	arg_1_0.txtTime.text = formatLuaLang("remain", var_1_0)
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0.txtTime = gohelper.findChildTextMesh(arg_2_0.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	arg_2_0._btnactivitystore = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "Left/Prop/#btn_shop")
	arg_2_0._txtstorenum = gohelper.findChildTextMesh(arg_2_0.viewGO, "Left/Prop/txt_PropName/#txt_PropNum")

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	if arg_3_0._btnactivitystore then
		arg_3_0:addClickCb(arg_3_0._btnactivitystore, arg_3_0.btnActivityStoreOnClick, arg_3_0)
	end
end

function var_0_0.removeEvents(arg_4_0)
	return
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, arg_5_0.refreshTask, arg_5_0)
	arg_5_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_5_0.refreshTask, arg_5_0)
	arg_5_0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, arg_5_0.refreshTask, arg_5_0)
	arg_5_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_5_0.refreshActivityCurrency, arg_5_0)
end

function var_0_0.btnActivityStoreOnClick(arg_6_0)
	ReactivityController.instance:openReactivityStoreView(arg_6_0.actId)
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0.actId = arg_7_0.viewParam.actId

	TaskDispatcher.runRepeat(arg_7_0.refreshRemainTime_overseas, arg_7_0, TimeUtil.OneMinuteSecond)
	arg_7_0:refreshRemainTime_overseas()
	arg_7_0:refreshTask()
	arg_7_0:refreshActivityCurrency()
	UIBlockMgr.instance:startBlock(UIBlockKey.WaitItemAnimeDone)
	TaskDispatcher.runDelay(arg_7_0._delayEndBlock, arg_7_0, var_0_1)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)

	local var_7_0 = gohelper.findChild(arg_7_0.viewGO, "Left/LimitTime")

	gohelper.setActive(var_7_0, false)
end

function var_0_0._delayEndBlock(arg_8_0)
	UIBlockMgr.instance:endBlock(UIBlockKey.WaitItemAnimeDone)
end

function var_0_0.refreshActivityCurrency(arg_9_0)
	local var_9_0 = ReactivityModel.instance:getActivityCurrencyId(arg_9_0.actId)
	local var_9_1 = CurrencyModel.instance:getCurrency(var_9_0)
	local var_9_2 = var_9_1 and var_9_1.quantity or 0

	if arg_9_0._txtstorenum then
		arg_9_0._txtstorenum.text = GameUtil.numberDisplay(var_9_2)
	end
end

function var_0_0.refreshRemainTime(arg_10_0)
	local var_10_0 = ActivityModel.instance:getActMO(arg_10_0.actId):getRealEndTimeStamp() - ServerTime.now()

	if var_10_0 > 0 then
		local var_10_1 = TimeUtil.SecondToActivityTimeFormat(var_10_0)

		arg_10_0.txtTime.text = var_10_1
	else
		arg_10_0.txtTime.text = luaLang("ended")
	end
end

function var_0_0.refreshTask(arg_11_0)
	ReactivityTaskModel.instance:refreshList(arg_11_0.actId)
end

function var_0_0.onClose(arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0.refreshRemainTime, arg_12_0)
	TaskDispatcher.cancelTask(arg_12_0._delayEndBlock, arg_12_0)
	arg_12_0:_delayEndBlock()
	TaskDispatcher.cancelTask(arg_12_0.refreshRemainTime_overseas, arg_12_0)
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
