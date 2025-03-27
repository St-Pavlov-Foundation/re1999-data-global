module("modules.logic.reactivity.view.ReactivityTaskView", package.seeall)

slot0 = class("ReactivityTaskView", BaseView)
slot1 = 0.8

function slot0.refreshRemainTime_overseas(slot0)
	slot0.txtTime.text = formatLuaLang("remain", ActivityModel.instance:getActMO(slot0.actId):getRemainTimeStr3())
end

function slot0.onInitView(slot0)
	slot0.txtTime = gohelper.findChildTextMesh(slot0.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	slot0._btnactivitystore = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/Prop/#btn_shop")
	slot0._txtstorenum = gohelper.findChildTextMesh(slot0.viewGO, "Left/Prop/txt_PropName/#txt_PropNum")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	if slot0._btnactivitystore then
		slot0:addClickCb(slot0._btnactivitystore, slot0.btnActivityStoreOnClick, slot0)
	end
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, slot0.refreshTask, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0.refreshTask, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, slot0.refreshTask, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.refreshActivityCurrency, slot0)
end

function slot0.btnActivityStoreOnClick(slot0)
	ReactivityController.instance:openReactivityStoreView(slot0.actId)
end

function slot0.onOpen(slot0)
	slot0.actId = slot0.viewParam.actId

	TaskDispatcher.runRepeat(slot0.refreshRemainTime_overseas, slot0, TimeUtil.OneMinuteSecond)
	slot0:refreshRemainTime_overseas()
	slot0:refreshTask()
	slot0:refreshActivityCurrency()
	UIBlockMgr.instance:startBlock(UIBlockKey.WaitItemAnimeDone)
	TaskDispatcher.runDelay(slot0._delayEndBlock, slot0, uv0)
end

function slot0._delayEndBlock(slot0)
	UIBlockMgr.instance:endBlock(UIBlockKey.WaitItemAnimeDone)
end

function slot0.refreshActivityCurrency(slot0)
	if slot0._txtstorenum then
		slot0._txtstorenum.text = GameUtil.numberDisplay(CurrencyModel.instance:getCurrency(ReactivityModel.instance:getActivityCurrencyId(slot0.actId)) and slot2.quantity or 0)
	end
end

function slot0.refreshRemainTime(slot0)
	if ActivityModel.instance:getActMO(slot0.actId):getRealEndTimeStamp() - ServerTime.now() > 0 then
		slot0.txtTime.text = TimeUtil.SecondToActivityTimeFormat(slot2)
	else
		slot0.txtTime.text = luaLang("ended")
	end
end

function slot0.refreshTask(slot0)
	ReactivityTaskModel.instance:refreshList(slot0.actId)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
	TaskDispatcher.cancelTask(slot0._delayEndBlock, slot0)
	slot0:_delayEndBlock()
	TaskDispatcher.cancelTask(slot0.refreshRemainTime_overseas, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
