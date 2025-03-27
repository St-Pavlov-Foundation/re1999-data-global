module("modules.logic.story.view.StoryBranchView", package.seeall)

slot0 = class("StoryBranchView", BaseView)

function slot0.onInitView(slot0)
	slot0._scrollselect = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_select")
	slot0._golist = gohelper.findChild(slot0.viewGO, "#scroll_select/Viewport/#go_list")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.OnSelectOptionView, slot0._onSelectOption, slot0)
	slot0:addEventCb(StoryController.instance, StoryEvent.FinishSelectOptionView, slot0._onFinishSelectOptionView, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogSelect, slot0.OnStoryDialogSelect, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(StoryController.instance, StoryEvent.OnSelectOptionView, slot0._onSelectOption, slot0)
	slot0:removeEventCb(StoryController.instance, StoryEvent.FinishSelectOptionView, slot0._onFinishSelectOptionView, slot0)
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogSelect, slot0.OnStoryDialogSelect, slot0)
end

function slot0._editableInitView(slot0)
	StoryModel.instance:enableClick(false)

	slot0._goselectItem = gohelper.findChild(slot0._golist, "selectitem")
	slot0._items = slot0:getUserDataTb_()
	slot0._itemCount = 0
	slot0._finishedSelectViewCount = 0
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:_refreshView()
end

function slot0.onClose(slot0)
end

function slot0.OnStoryDialogSelect(slot0, slot1)
	if slot0._keyTrigger and slot0._keyTrigger[slot1] then
		slot0:onKeySelect(slot0._keyTrigger[slot1])
	end
end

function slot0._refreshView(slot0)
	if #slot0._items > 0 then
		for slot4, slot5 in pairs(slot0._items) do
			slot5:destroy()
		end

		slot0._items = {}
	end

	slot0:_setSelectList()
	slot0:showKeyTips()
end

function slot0._setSelectList(slot0)
	for slot4, slot5 in ipairs(slot0.viewParam) do
		slot6 = StorySelectListItem.New()

		slot6:init(slot0._goselectItem, slot5)
		table.insert(slot0._items, slot6)
	end

	slot0._itemCount = #slot0._items
end

function slot0.showKeyTips(slot0)
	slot0._keyTrigger = {}

	if slot0._items then
		slot1 = 1

		for slot5, slot6 in ipairs(slot0._items) do
			if slot6 and slot6.viewGO.activeSelf then
				if gohelper.findChild(slot6.viewGO, "bgdark/#go_pcbtn") then
					PCInputController.instance:showkeyTips(slot7, 0, 0, "Alpha" .. slot1)
				end

				slot0._keyTrigger[slot1] = slot5
				slot1 = slot1 + 1
			end
		end
	end
end

function slot0.onKeySelect(slot0, slot1)
	if slot0._items then
		for slot5, slot6 in ipairs(slot0._items) do
			if slot5 == slot1 then
				slot6:_btnselectOnClick()
			end
		end
	end
end

function slot0._onSelectOption(slot0, slot1)
	if slot0._items then
		for slot5, slot6 in ipairs(slot0._items) do
			if slot5 == slot1 then
				slot6:onSelectOptionView()
			else
				slot6:onSelectOtherOptionView()
			end
		end
	end
end

function slot0._onFinishSelectOptionView(slot0, slot1)
	if slot0._items then
		for slot5, slot6 in pairs(slot0._items) do
			if slot6:getOptionIndex() == slot1 then
				slot6:destroy()

				slot0._finishedSelectViewCount = slot0._finishedSelectViewCount + 1

				break
			end
		end

		if slot0._finishedSelectViewCount == slot0._itemCount then
			slot0._items = nil

			slot0:closeThis()
		end
	end
end

function slot0.onDestroyView(slot0)
	StoryModel.instance:enableClick(true)

	if slot0._items then
		for slot4, slot5 in pairs(slot0._items) do
			slot5:destroy()
		end

		slot0._items = nil
	end
end

return slot0
