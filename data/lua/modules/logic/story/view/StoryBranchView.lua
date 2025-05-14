module("modules.logic.story.view.StoryBranchView", package.seeall)

local var_0_0 = class("StoryBranchView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollselect = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_select")
	arg_1_0._golist = gohelper.findChild(arg_1_0.viewGO, "#scroll_select/Viewport/#go_list")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(StoryController.instance, StoryEvent.OnSelectOptionView, arg_2_0._onSelectOption, arg_2_0)
	arg_2_0:addEventCb(StoryController.instance, StoryEvent.FinishSelectOptionView, arg_2_0._onFinishSelectOptionView, arg_2_0)
	arg_2_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogSelect, arg_2_0.OnStoryDialogSelect, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(StoryController.instance, StoryEvent.OnSelectOptionView, arg_3_0._onSelectOption, arg_3_0)
	arg_3_0:removeEventCb(StoryController.instance, StoryEvent.FinishSelectOptionView, arg_3_0._onFinishSelectOptionView, arg_3_0)
	arg_3_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyStoryDialogSelect, arg_3_0.OnStoryDialogSelect, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	StoryModel.instance:enableClick(false)

	arg_4_0._goselectItem = gohelper.findChild(arg_4_0._golist, "selectitem")
	arg_4_0._items = arg_4_0:getUserDataTb_()
	arg_4_0._itemCount = 0
	arg_4_0._finishedSelectViewCount = 0
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:_refreshView()
end

function var_0_0.onClose(arg_7_0)
	return
end

function var_0_0.OnStoryDialogSelect(arg_8_0, arg_8_1)
	if arg_8_0._keyTrigger and arg_8_0._keyTrigger[arg_8_1] then
		arg_8_0:onKeySelect(arg_8_0._keyTrigger[arg_8_1])
	end
end

function var_0_0._refreshView(arg_9_0)
	if #arg_9_0._items > 0 then
		for iter_9_0, iter_9_1 in pairs(arg_9_0._items) do
			iter_9_1:destroy()
		end

		arg_9_0._items = {}
	end

	arg_9_0:_setSelectList()
	arg_9_0:showKeyTips()
end

function var_0_0._setSelectList(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.viewParam) do
		local var_10_0 = StorySelectListItem.New()

		var_10_0:init(arg_10_0._goselectItem, iter_10_1)
		table.insert(arg_10_0._items, var_10_0)
	end

	arg_10_0._itemCount = #arg_10_0._items
end

function var_0_0.showKeyTips(arg_11_0)
	arg_11_0._keyTrigger = {}

	if arg_11_0._items then
		local var_11_0 = 1

		for iter_11_0, iter_11_1 in ipairs(arg_11_0._items) do
			if iter_11_1 and iter_11_1.viewGO.activeSelf then
				local var_11_1 = gohelper.findChild(iter_11_1.viewGO, "bgdark/#go_pcbtn")

				if var_11_1 then
					PCInputController.instance:showkeyTips(var_11_1, 0, 0, "Alpha" .. var_11_0)
				end

				arg_11_0._keyTrigger[var_11_0] = iter_11_0
				var_11_0 = var_11_0 + 1
			end
		end
	end
end

function var_0_0.onKeySelect(arg_12_0, arg_12_1)
	if arg_12_0._items then
		for iter_12_0, iter_12_1 in ipairs(arg_12_0._items) do
			if iter_12_0 == arg_12_1 then
				iter_12_1:_btnselectOnClick()
			end
		end
	end
end

function var_0_0._onSelectOption(arg_13_0, arg_13_1)
	if arg_13_0._items then
		for iter_13_0, iter_13_1 in ipairs(arg_13_0._items) do
			if iter_13_0 == arg_13_1 then
				iter_13_1:onSelectOptionView()
			else
				iter_13_1:onSelectOtherOptionView()
			end
		end
	end
end

function var_0_0._onFinishSelectOptionView(arg_14_0, arg_14_1)
	if arg_14_0._items then
		for iter_14_0, iter_14_1 in pairs(arg_14_0._items) do
			if iter_14_1:getOptionIndex() == arg_14_1 then
				iter_14_1:destroy()

				arg_14_0._finishedSelectViewCount = arg_14_0._finishedSelectViewCount + 1

				break
			end
		end

		if arg_14_0._finishedSelectViewCount == arg_14_0._itemCount then
			arg_14_0._items = nil

			arg_14_0:closeThis()
		end
	end
end

function var_0_0.onDestroyView(arg_15_0)
	StoryModel.instance:enableClick(true)

	if arg_15_0._items then
		for iter_15_0, iter_15_1 in pairs(arg_15_0._items) do
			iter_15_1:destroy()
		end

		arg_15_0._items = nil
	end
end

return var_0_0
