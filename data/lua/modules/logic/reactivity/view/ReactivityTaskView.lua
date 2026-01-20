-- chunkname: @modules/logic/reactivity/view/ReactivityTaskView.lua

module("modules.logic.reactivity.view.ReactivityTaskView", package.seeall)

local ReactivityTaskView = class("ReactivityTaskView", BaseView)
local TASK_ITEM_OPEN_ANIM_TIME = 0.8

function ReactivityTaskView:refreshRemainTime_overseas()
	local actInfoMo = ActivityModel.instance:getActMO(self.actId)
	local str = actInfoMo:getRemainTimeStr3()

	self.txtTime.text = formatLuaLang("remain", str)
end

function ReactivityTaskView:onInitView()
	self.txtTime = gohelper.findChildTextMesh(self.viewGO, "Left/LimitTime/image_LimitTimeBG/#txt_time")
	self._btnactivitystore = gohelper.findChildButtonWithAudio(self.viewGO, "Left/Prop/#btn_shop")
	self._txtstorenum = gohelper.findChildTextMesh(self.viewGO, "Left/Prop/txt_PropName/#txt_PropNum")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ReactivityTaskView:addEvents()
	if self._btnactivitystore then
		self:addClickCb(self._btnactivitystore, self.btnActivityStoreOnClick, self)
	end
end

function ReactivityTaskView:removeEvents()
	return
end

function ReactivityTaskView:_editableInitView()
	self:addEventCb(TaskController.instance, TaskEvent.SuccessGetBonus, self.refreshTask, self)
	self:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, self.refreshTask, self)
	self:addEventCb(TaskController.instance, TaskEvent.UpdateTaskList, self.refreshTask, self)
	self:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshActivityCurrency, self)
end

function ReactivityTaskView:btnActivityStoreOnClick()
	ReactivityController.instance:openReactivityStoreView(self.actId)
end

function ReactivityTaskView:onOpen()
	self.actId = self.viewParam.actId

	TaskDispatcher.runRepeat(self.refreshRemainTime_overseas, self, TimeUtil.OneMinuteSecond)
	self:refreshRemainTime_overseas()
	self:refreshTask()
	self:refreshActivityCurrency()
	UIBlockMgr.instance:startBlock(UIBlockKey.WaitItemAnimeDone)
	TaskDispatcher.runDelay(self._delayEndBlock, self, TASK_ITEM_OPEN_ANIM_TIME)
	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6DungeonEnterTaskView)
end

function ReactivityTaskView:_delayEndBlock()
	UIBlockMgr.instance:endBlock(UIBlockKey.WaitItemAnimeDone)
end

function ReactivityTaskView:refreshActivityCurrency()
	local currencyId = ReactivityModel.instance:getActivityCurrencyId(self.actId)
	local currencyMO = CurrencyModel.instance:getCurrency(currencyId)
	local quantity = currencyMO and currencyMO.quantity or 0

	if self._txtstorenum then
		self._txtstorenum.text = GameUtil.numberDisplay(quantity)
	end
end

function ReactivityTaskView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActMO(self.actId)
	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	if offsetSecond > 0 then
		local dateStr = TimeUtil.SecondToActivityTimeFormat(offsetSecond)

		self.txtTime.text = dateStr
	else
		self.txtTime.text = luaLang("ended")
	end
end

function ReactivityTaskView:refreshTask()
	ReactivityTaskModel.instance:refreshList(self.actId)
end

function ReactivityTaskView:onClose()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	TaskDispatcher.cancelTask(self._delayEndBlock, self)
	self:_delayEndBlock()
	TaskDispatcher.cancelTask(self.refreshRemainTime_overseas, self)
end

function ReactivityTaskView:onDestroyView()
	return
end

return ReactivityTaskView
