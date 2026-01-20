-- chunkname: @modules/logic/rouge2/map/view/choice/Rouge2_MapChoiceView.lua

module("modules.logic.rouge2.map.view.choice.Rouge2_MapChoiceView", package.seeall)

local Rouge2_MapChoiceView = class("Rouge2_MapChoiceView", Rouge2_MapChoiceBaseView)

function Rouge2_MapChoiceView:onInitView()
	Rouge2_MapChoiceView.super.onInitView(self)
end

function Rouge2_MapChoiceView:addEvents()
	Rouge2_MapChoiceView.super.addEvents(self)
	self:addEventCb(Rouge2_MapController.instance, Rouge2_MapEvent.onChoiceFlowDone, self.onChoiceFlowDone, self)
	self:addEventCb(Rouge2_MapController.instance, Rouge2_MapEvent.onChoiceEventChange, self.onChoiceEventChange, self)
	self:addEventCb(Rouge2_MapController.instance, Rouge2_MapEvent.onReceiveChoiceEvent, self.onReceiveChoiceEvent, self)
	self:addEventCb(Rouge2_MapController.instance, Rouge2_MapEvent.onBeforeActorMoveToEnd, self.onBeforeActorMoveToEnd, self)
end

function Rouge2_MapChoiceView:onBeforeActorMoveToEnd()
	self.beforeChangeMap = true
end

function Rouge2_MapChoiceView:onChoiceFlowDone()
	if self.beforeChangeMap or self.nodeMo:isFinishEvent() then
		if not Rouge2_MapDialogueHelper.hasLastSelectDesc(self.nodeMo) then
			self:closeThis()
		else
			self:changeState(Rouge2_MapEnum.ChoiceViewState.Finish)
		end

		return
	end

	if self.hasTweenDialogue then
		self:playChoiceHideAnim()
	else
		self:triggerEventHandle()
	end
end

function Rouge2_MapChoiceView:onReceiveChoiceEvent()
	self:playSelectDialogue()
end

function Rouge2_MapChoiceView:playSelectDialogue()
	if self.beforeChangeMap then
		self:closeThis()

		return
	end

	self:changeState(Rouge2_MapEnum.ChoiceViewState.PlayingDialogue)

	self.hasTweenDialogue = Rouge2_MapDialogueHelper.select(self._dialogueListComp, self.nodeMo, self.onSelectedDescDone, self)

	if self.hasTweenDialogue then
		self:playChoiceHideAnim()
	else
		self:playChoiceShowAnim()
	end
end

function Rouge2_MapChoiceView:onSelectedDescDone()
	if self.nodeMo and self.nodeMo:isFinishEvent() then
		self:changeState(Rouge2_MapEnum.ChoiceViewState.Finish)

		return
	end

	self:triggerEventHandle()
end

function Rouge2_MapChoiceView:triggerEventHandle()
	local curNode = Rouge2_MapModel.instance:getCurNode()

	Rouge2_MapChoiceEventHelper.triggerEventHandleOnChoiceView(curNode)
end

function Rouge2_MapChoiceView:onClickBlockOnFinishState()
	self:triggerEventHandle()
end

function Rouge2_MapChoiceView:onChoiceEventChange(nodeMo)
	if self.beforeChangeMap then
		self:closeThis()

		return
	end

	if nodeMo.nodeId ~= self.nodeMo.nodeId then
		return
	end

	local newEventId = nodeMo.eventId

	if newEventId == self.curEventId then
		if nodeMo:isFinishEvent() then
			self:changeState(Rouge2_MapEnum.ChoiceViewState.Finish)

			return
		end

		self:onChangeDialogueDone()
	else
		self.curEventId = newEventId
		self.eventCo = Rouge2_MapConfig.instance:getRougeEvent(self.curEventId)

		self:changeState(Rouge2_MapEnum.ChoiceViewState.PlayingDialogue)
		Rouge2_MapDialogueHelper.init(self._dialogueListComp, self.nodeMo, self.onChangeDialogueDone, self)
	end

	self:refreshUI()
end

function Rouge2_MapChoiceView:onChangeDialogueDone()
	self:changeState(Rouge2_MapEnum.ChoiceViewState.WaitSelect)
	self:refreshChoice()
	self:playChoiceShowAnim()
end

function Rouge2_MapChoiceView:initViewData()
	self.nodeMo = self.viewParam
	self.curEventId = self.nodeMo.eventId
	self.eventCo = Rouge2_MapConfig.instance:getRougeEvent(self.curEventId)
end

function Rouge2_MapChoiceView:onOpen()
	Rouge2_MapChoiceView.super.onOpen(self)
	self:initViewData()
	self:refreshUI()
	Rouge2_MapDialogueHelper.init(self._dialogueListComp, self.nodeMo, self.onEnterDialogueDone, self)
end

function Rouge2_MapChoiceView:refreshUI()
	local hasBG = not string.nilorempty(self.eventCo.image)

	gohelper.setActive(self._goBG, hasBG)

	if hasBG then
		self._simageFullBG:LoadImage(ResUrl.getRouge2Icon("choice/" .. self.eventCo.image))
	end

	self._txtName.text = self.eventCo.name
end

function Rouge2_MapChoiceView:onEnterDialogueDone()
	self:changeState(Rouge2_MapEnum.ChoiceViewState.WaitSelect)
	self:refreshChoice()
	self:playChoiceShowAnim()
end

function Rouge2_MapChoiceView:refreshChoice()
	local choiceIdList = self.nodeMo.eventMo:getChoiceIdList()

	if not choiceIdList then
		logError("choiceIdList is nil, curNode : " .. tostring(self.nodeMo))

		return
	end

	Rouge2_MapHelper.loadItemWithCustomUpdateFunc(self.goChoiceItem, Rouge2_MapNodeChoiceItem, choiceIdList, self.choiceItemList, self.updateItem, self)
end

function Rouge2_MapChoiceView:updateItem(item, index, choiceId)
	item:update(choiceId, self.nodeMo, index)
end

function Rouge2_MapChoiceView:onDestroyView()
	Rouge2_MapChoiceView.super.onDestroyView(self)
end

return Rouge2_MapChoiceView
