-- chunkname: @modules/logic/story/view/StoryBranchView.lua

module("modules.logic.story.view.StoryBranchView", package.seeall)

local StoryBranchView = class("StoryBranchView", BaseView)

function StoryBranchView:onInitView()
	self._scrollselect = gohelper.findChildScrollRect(self.viewGO, "#scroll_select")
	self._golist = gohelper.findChild(self.viewGO, "#scroll_select/Viewport/#go_list")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoryBranchView:addEvents()
	self:addEventCb(StoryController.instance, StoryEvent.OnSelectOptionView, self._onSelectOption, self)
	self:addEventCb(StoryController.instance, StoryEvent.FinishSelectOptionView, self._onFinishSelectOptionView, self)
	self:addEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogSelect, self.OnStoryDialogSelect, self)
end

function StoryBranchView:removeEvents()
	self:removeEventCb(StoryController.instance, StoryEvent.OnSelectOptionView, self._onSelectOption, self)
	self:removeEventCb(StoryController.instance, StoryEvent.FinishSelectOptionView, self._onFinishSelectOptionView, self)
	self:removeEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogSelect, self.OnStoryDialogSelect, self)
end

function StoryBranchView:_editableInitView()
	StoryModel.instance:enableClick(false)

	self._goselectItem = gohelper.findChild(self._golist, "selectitem")
	self._items = self:getUserDataTb_()
	self._itemCount = 0
	self._finishedSelectViewCount = 0
end

function StoryBranchView:onUpdateParam()
	return
end

function StoryBranchView:onOpen()
	self:_refreshView()
end

function StoryBranchView:onClose()
	return
end

function StoryBranchView:OnStoryDialogSelect(index)
	if self._keyTrigger and self._keyTrigger[index] then
		self:onKeySelect(self._keyTrigger[index])
	end
end

function StoryBranchView:_refreshView()
	if #self._items > 0 then
		for _, v in pairs(self._items) do
			v:destroy()
		end

		self._items = {}
	end

	self:_setSelectList()
	self:showKeyTips()
end

function StoryBranchView:_setSelectList()
	for i, v in ipairs(self.viewParam) do
		local item = StorySelectListItem.New()

		item:init(self._goselectItem, v)
		table.insert(self._items, item)
	end

	self._itemCount = #self._items
end

function StoryBranchView:showKeyTips()
	self._keyTrigger = {}

	if self._items then
		local index = 1

		for i, v in ipairs(self._items) do
			if v and v.viewGO.activeSelf then
				local keytips = gohelper.findChild(v.viewGO, "bgdark/#go_pcbtn")

				if keytips then
					PCInputController.instance:showkeyTips(keytips, 0, 0, "Alpha" .. index)
				end

				self._keyTrigger[index] = i
				index = index + 1
			end
		end
	end
end

function StoryBranchView:onKeySelect(index)
	if self._items then
		for i, v in ipairs(self._items) do
			if i == index then
				v:_btnselectOnClick()
			end
		end
	end
end

function StoryBranchView:_onSelectOption(index)
	if self._items then
		for i, v in ipairs(self._items) do
			if i == index then
				v:onSelectOptionView()
			else
				v:onSelectOtherOptionView()
			end
		end
	end
end

function StoryBranchView:_onFinishSelectOptionView(index)
	if self._items then
		for i, v in pairs(self._items) do
			if v:getOptionIndex() == index then
				v:destroy()

				self._finishedSelectViewCount = self._finishedSelectViewCount + 1

				break
			end
		end

		if self._finishedSelectViewCount == self._itemCount then
			self._items = nil

			self:closeThis()
		end
	end
end

function StoryBranchView:onDestroyView()
	StoryModel.instance:enableClick(true)

	if self._items then
		for _, v in pairs(self._items) do
			v:destroy()
		end

		self._items = nil
	end
end

return StoryBranchView
