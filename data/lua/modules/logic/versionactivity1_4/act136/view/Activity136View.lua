-- chunkname: @modules/logic/versionactivity1_4/act136/view/Activity136View.lua

module("modules.logic.versionactivity1_4.act136.view.Activity136View", package.seeall)

local Activity136View = class("Activity136View", BaseView)

function Activity136View:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._txtremainTime = gohelper.findChildText(self.viewGO, "timebg/#txt_remainTime")
	self._goUninvite = gohelper.findChild(self.viewGO, "#go_inviteContent/#go_uninvite")
	self._btnInvite = gohelper.findChildButton(self.viewGO, "#go_inviteContent/#go_uninvite/#btn_invite")
	self._goInvited = gohelper.findChild(self.viewGO, "#go_inviteContent/#go_invited")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Activity136View:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnInvite:AddClickListener(self._btnInviteOnClick, self)
	Activity136Controller.instance:registerCallback(Activity136Event.ActivityDataUpdate, self.refresh, self)
end

function Activity136View:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnInvite:RemoveClickListener()
	Activity136Controller.instance:unregisterCallback(Activity136Event.ActivityDataUpdate, self.refresh, self)
end

function Activity136View:_editableInitView()
	return
end

function Activity136View:_btncloseOnClick()
	self:closeThis()
end

function Activity136View:_btnInviteOnClick()
	Activity136Controller.instance:openActivity136ChoiceView()
end

function Activity136View:onOpen()
	self:refresh()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	TaskDispatcher.runRepeat(self.refreshRemainTime, self, TimeUtil.OneMinuteSecond)
end

function Activity136View:refresh()
	self:refreshStatus()
	self:refreshRemainTime()
end

function Activity136View:refreshStatus()
	local hasReceive = Activity136Model.instance:hasReceivedCharacter()

	gohelper.setActive(self._goInvited, hasReceive)
	gohelper.setActive(self._goUninvite, not hasReceive)
end

function Activity136View:refreshRemainTime()
	local actId = Activity136Controller.instance:actId()
	local actInfoMo = ActivityModel.instance:getActMO(actId)
	local timeStr, isEnd = self:_getRemainTimeStr(actInfoMo)

	self._txtremainTime.text = string.format(luaLang("remain"), timeStr)

	if isEnd then
		TaskDispatcher.cancelTask(self.refreshRemainTime, self)
	end
end

function Activity136View:onClose()
	if self.viewParam and self.viewParam.callback then
		self.viewParam.callback(self.viewParam.callbackObj)
	end

	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

function Activity136View:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshRemainTime, self)
end

function Activity136View:_getRemainTimeStr(actInfoMo)
	local offsetSecond

	if actInfoMo then
		offsetSecond = actInfoMo:getRealEndTimeStamp() - ServerTime.now()
	end

	if not offsetSecond or offsetSecond <= 0 then
		return luaLang("turnback_end"), true
	end

	local day, hour, min, _ = TimeUtil.secondsToDDHHMMSS(offsetSecond)

	if day > 0 then
		local time_day = luaLang("time_day")

		if LangSettings.instance:isEn() then
			time_day = time_day .. " "
		end

		return (day .. time_day) .. hour .. luaLang("time_hour2")
	end

	if hour > 0 then
		return hour .. luaLang("time_hour2")
	end

	if min <= 0 then
		min = "<1"
	end

	return min .. luaLang("time_minute2")
end

return Activity136View
