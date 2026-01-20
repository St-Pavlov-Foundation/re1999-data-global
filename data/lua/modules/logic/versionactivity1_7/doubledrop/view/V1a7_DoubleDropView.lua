-- chunkname: @modules/logic/versionactivity1_7/doubledrop/view/V1a7_DoubleDropView.lua

module("modules.logic.versionactivity1_7.doubledrop.view.V1a7_DoubleDropView", package.seeall)

local V1a7_DoubleDropView = class("V1a7_DoubleDropView", BaseView)

function V1a7_DoubleDropView:onInitView()
	self._txtTime = gohelper.findChildTextMesh(self.viewGO, "go_time/#go_deadline2/#txt_deadline2")
	self._txtDesc = gohelper.findChildTextMesh(self.viewGO, "go_desc/#scroll_desc/Viewport/#txt_desc")
	self._txtTotalTimes = gohelper.findChildTextMesh(self.viewGO, "go_times/go_total/#txt_totaltimes")
	self._goToday = gohelper.findChild(self.viewGO, "go_times/go_today")
	self._txtTotalDayTimes = gohelper.findChildTextMesh(self.viewGO, "go_times/go_today/#txt_totalday")
	self._btnJump = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_jump")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V1a7_DoubleDropView:addEvents()
	self:addClickCb(self._btnJump, self._onClickJump, self)
end

function V1a7_DoubleDropView:removeEvents()
	self:removeClickCb(self._btnJump)
end

function V1a7_DoubleDropView:_editableInitView()
	return
end

function V1a7_DoubleDropView:onUpdateParam()
	self.actId = self.viewParam.actId

	self:refresh()
end

function V1a7_DoubleDropView:onOpen()
	StatController.instance:track(StatEnum.EventName.EnterDoubleEquip)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mln_page_turn)

	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)

	self.actId = self.viewParam.actId

	self:refresh()
end

function V1a7_DoubleDropView:refresh()
	local actId = self.actId
	local act153Mo = DoubleDropModel.instance:getById(actId)
	local totalUseTimes = act153Mo and act153Mo.totalCount or 0
	local totalTimes = act153Mo and act153Mo.config and act153Mo.config.totalLimit or 0
	local totalRemainTime = totalTimes - totalUseTimes

	if totalRemainTime > 0 then
		self._txtTotalTimes.text = string.format("<color=#DE9854>%s</color>/%s", totalRemainTime, totalTimes)
	else
		self._txtTotalTimes.text = string.format("<color=#BF2E11>%s</color>/%s", totalRemainTime, totalTimes)
	end

	local dailyRemainTime, todayTimes = DoubleDropModel.instance:getDailyRemainTimes(actId)

	if dailyRemainTime > 0 then
		self._txtTotalDayTimes.text = string.format("<color=#DE9854>%s</color>/%s", dailyRemainTime, todayTimes)
	else
		self._txtTotalDayTimes.text = string.format("<color=#BF2E11>%s</color>/%s", dailyRemainTime, todayTimes)
	end

	gohelper.setActive(self._goToday, totalRemainTime > 0)

	local actCo = ActivityConfig.instance:getActivityCo(actId)

	self._txtDesc.text = actCo and actCo.actDesc or ""

	self:refreshRemainTime()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, 1)
end

function V1a7_DoubleDropView:refreshRemainTime()
	local actInfoMo = ActivityModel.instance:getActMO(self.actId)

	if not actInfoMo then
		return
	end

	local offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()

	if offsetSecond > 0 then
		local dateStr = TimeUtil.SecondToActivityTimeFormat(offsetSecond)

		self._txtTime.text = dateStr
	else
		self._txtTime.text = luaLang("ended")
	end
end

function V1a7_DoubleDropView:_onClickJump()
	GameFacade.jump(3601)
end

function V1a7_DoubleDropView:onClose()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

function V1a7_DoubleDropView:onDestroyView()
	return
end

return V1a7_DoubleDropView
