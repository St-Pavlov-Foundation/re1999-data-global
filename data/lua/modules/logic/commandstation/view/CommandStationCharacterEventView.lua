-- chunkname: @modules/logic/commandstation/view/CommandStationCharacterEventView.lua

module("modules.logic.commandstation.view.CommandStationCharacterEventView", package.seeall)

local CommandStationCharacterEventView = class("CommandStationCharacterEventView", BaseView)

function CommandStationCharacterEventView:onInitView()
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._goCharacterEvent = gohelper.findChild(self.viewGO, "#go_CharacterEvent")
	self._goCharacterEventPanel = gohelper.findChild(self.viewGO, "#go_CharacterEvent/#go_CharacterEventPanel")
	self._txtName = gohelper.findChildText(self.viewGO, "#go_CharacterEvent/#go_CharacterEventPanel/#txt_Name")
	self._txtTime = gohelper.findChildText(self.viewGO, "#go_CharacterEvent/#go_CharacterEventPanel/#txt_Time")
	self._btnopentimeline = gohelper.findChildButtonWithAudio(self.viewGO, "#go_CharacterEvent/#go_CharacterEventPanel/#btn_opentimeline")
	self._txtDescr = gohelper.findChildText(self.viewGO, "#go_CharacterEvent/#go_CharacterEventPanel/Scroll View/Viewport/#txt_Descr")
	self._btnLeftDisable = gohelper.findChildButtonWithAudio(self.viewGO, "#go_CharacterEvent/#go_CharacterEventPanel/#btn_LeftDisable")
	self._btnLeft = gohelper.findChildButtonWithAudio(self.viewGO, "#go_CharacterEvent/#go_CharacterEventPanel/#btn_Left")
	self._btnRightDisable = gohelper.findChildButtonWithAudio(self.viewGO, "#go_CharacterEvent/#go_CharacterEventPanel/#btn_RightDisable")
	self._btnRight = gohelper.findChildButtonWithAudio(self.viewGO, "#go_CharacterEvent/#go_CharacterEventPanel/#btn_Right")
	self._golefttop = gohelper.findChild(self.viewGO, "#go_lefttop")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommandStationCharacterEventView:addEvents()
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnopentimeline:AddClickListener(self._btnopentimelineOnClick, self)
	self._btnLeftDisable:AddClickListener(self._btnLeftDisableOnClick, self)
	self._btnLeft:AddClickListener(self._btnLeftOnClick, self)
	self._btnRightDisable:AddClickListener(self._btnRightDisableOnClick, self)
	self._btnRight:AddClickListener(self._btnRightOnClick, self)
end

function CommandStationCharacterEventView:removeEvents()
	self._btnclose:RemoveClickListener()
	self._btnopentimeline:RemoveClickListener()
	self._btnLeftDisable:RemoveClickListener()
	self._btnLeft:RemoveClickListener()
	self._btnRightDisable:RemoveClickListener()
	self._btnRight:RemoveClickListener()
end

function CommandStationCharacterEventView:_btnLeftDisableOnClick()
	return
end

function CommandStationCharacterEventView:_btnRightDisableOnClick()
	return
end

function CommandStationCharacterEventView:_btnopentimelineOnClick()
	if self._isOpenTimeline then
		return
	end

	self._isOpenTimeline = not self._isOpenTimeline

	self:_moveTimeline(self._isOpenTimeline and {
		node = self.viewGO,
		leftopNode = self._golefttop
	} or nil)
	CommandStationController.StatCommandStationButtonClick(self.viewName, string.format("btnopentimelineOnClick_%s", self._curCharacterId))
end

function CommandStationCharacterEventView:_moveTimeline(param)
	local isTimelineCharacterMode = param ~= nil

	if isTimelineCharacterMode then
		CommandStationMapModel.instance:setCharacterId(self._curCharacterId)
	else
		CommandStationMapModel.instance:setCharacterId(nil)
	end

	CommandStationMapModel.instance:setTimelineCharacterMode(isTimelineCharacterMode)
	CommandStationController.instance:dispatchEvent(CommandStationEvent.MoveTimeline, param)
	gohelper.setActive(self._btnclose, isTimelineCharacterMode)
	self:_updateBtnState()
end

function CommandStationCharacterEventView:checkClose()
	self:closeThis()
end

function CommandStationCharacterEventView:_btncloseOnClick()
	self:checkClose()
end

function CommandStationCharacterEventView:_btnLeftOnClick()
	self._curIndex = self._curIndex - 1

	if self._curIndex < 1 then
		self._curIndex = #self._eventList
	end

	self:_updateBtnState()
	self:_FocusEvent()
	self:_showSwitchAnim(true)
end

function CommandStationCharacterEventView:_btnRightOnClick()
	self._curIndex = self._curIndex + 1

	if self._curIndex > #self._eventList then
		self._curIndex = 1
	end

	self:_updateBtnState()
	self:_FocusEvent()
	self:_showSwitchAnim(false)
end

function CommandStationCharacterEventView:_editableInitView()
	gohelper.setActive(self._btnclose, false)

	self._isOpenTimeline = false
	self._animator = self.viewGO:GetComponent("Animator")
end

function CommandStationCharacterEventView:_showSwitchAnim(isLeft)
	self._animator.enabled = true

	self._animator:Play(isLeft and "switchleft" or "switchright", 0, 0)
	TaskDispatcher.cancelTask(self._afterSwitchUpdateEventInfo, self)
	TaskDispatcher.runDelay(self._afterSwitchUpdateEventInfo, self, 0.167)
end

function CommandStationCharacterEventView:_afterSwitchUpdateEventInfo()
	self:_updateEventInfo()
end

function CommandStationCharacterEventView:onUpdateParam()
	local eventId = self._eventList[self._curIndex]

	if eventId == self.viewParam.eventId then
		return
	end

	self._animator.enabled = true

	self._animator:Play("switchtime", 0, 0)
	TaskDispatcher.cancelTask(self._showEvent, self)
	TaskDispatcher.runDelay(self._showEvent, self, 0.167)
end

function CommandStationCharacterEventView:onOpen()
	self:_showEvent()
	self:addEventCb(CommandStationController.instance, CommandStationEvent.SelectTimePoint, self._onSelectTimePoint, self)
	self:addEventCb(CommandStationController.instance, CommandStationEvent.EventCreateFinish, self._onEventCreateFinish, self)
end

function CommandStationCharacterEventView:_onEventCreateFinish()
	return
end

function CommandStationCharacterEventView:_onSelectTimePoint(timeId)
	self._timeId = timeId
	self._eventList = CommandStationConfig.instance:getCharacterEventList(self._timeId)

	local isMatch = false

	for i, v in ipairs(self._eventList) do
		if CommandStationConfig.instance:getCharacterIdByEventId(v) == self._curCharacterId then
			self._eventId = v
			isMatch = true

			break
		end
	end

	if not isMatch then
		logError(string.format("CommandStationCharacterEventView _onSelectTimePoint not match timeId:%d, characterId:%d, eventId:%d", self._timeId, self._curCharacterId, self._eventId))
	end

	self:_initEventData()
	self:_FocusEvent()
end

function CommandStationCharacterEventView:_showEvent()
	self._timeId = self.viewParam.timeId
	self._eventId = self.viewParam.eventId
	self._eventList = CommandStationConfig.instance:getCharacterEventList(self._timeId)

	self:_initEventData()
end

function CommandStationCharacterEventView:_initEventData()
	self._minIndex = 1
	self._maxIndex = #self._eventList
	self._curIndex = tabletool.indexOf(self._eventList, self._eventId)

	self:_updateEventInfo()
	self:_updateBtnState()
end

function CommandStationCharacterEventView:_updateBtnState()
	local isTimelineCharacterMode = CommandStationMapModel.instance:isTimelineCharacterMode()
	local showButton = self._maxIndex ~= 1 and not isTimelineCharacterMode

	gohelper.setActive(self._btnLeft.gameObject, showButton)
	gohelper.setActive(self._btnRight.gameObject, showButton)
	gohelper.setActive(self._btnLeftDisable.gameObject, false)
	gohelper.setActive(self._btnRightDisable.gameObject, false)
end

function CommandStationCharacterEventView:_FocusEvent()
	CommandStationController.instance:dispatchEvent(CommandStationEvent.FocusEvent, self._eventList[self._curIndex])
	CommandStationController.instance:dispatchEvent(CommandStationEvent.SelectedEvent, self._eventList[self._curIndex])
end

function CommandStationCharacterEventView:_updateEventInfo()
	local eventId = self._eventList[self._curIndex]
	local eventConfig = lua_copost_character_event.configDict[eventId]

	if not eventConfig then
		return
	end

	local eventTextId = tonumber(eventConfig.eventTextId)
	local eventTxtConfig = eventTextId and lua_copost_event_text.configDict[eventTextId]

	self._txtDescr.text = eventTxtConfig and eventTxtConfig.text

	local characterId = eventConfig.chaId

	self._curCharacterId = characterId

	local characterConfig = lua_copost_character.configDict[characterId]

	self._txtName.text = characterConfig.chaName

	local timeGroup = CommandStationConfig.instance:getTimeGroupByCharacterEventId(eventId)

	if timeGroup then
		local timeConfig = lua_copost_time_point.configDict[timeGroup.id]

		self._txtTime.text = timeConfig and timeConfig.time
	end

	local chaId = eventConfig.chaId

	self._singleImage = self._singleImage or gohelper.findChildSingleImage(self.viewGO, "#go_CharacterEvent/#go_CharacterEventPanel/Head/image_Icon")

	local chaConfig = lua_copost_character.configDict[chaId]

	if chaConfig then
		self._singleImage:LoadImage(ResUrl.getHeadIconSmall(chaConfig.chaPicture), self._singleImageLoadCallback, self)
	end
end

function CommandStationCharacterEventView:_singleImageLoadCallback()
	self._singleImage:GetComponent(gohelper.Type_Image):SetNativeSize()
end

function CommandStationCharacterEventView:onClose()
	CommandStationMapModel.instance:setCharacterId(nil)
	CommandStationMapModel.instance:setTimelineCharacterMode(nil)
	self:_moveTimeline()
	TaskDispatcher.cancelTask(self._afterSwitchUpdateEventInfo, self)
	TaskDispatcher.cancelTask(self._showEvent, self)
end

function CommandStationCharacterEventView:onDestroyView()
	return
end

return CommandStationCharacterEventView
