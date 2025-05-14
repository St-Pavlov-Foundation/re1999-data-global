module("modules.logic.dungeon.view.DungeonViewAudio", package.seeall)

local var_0_0 = class("DungeonViewAudio", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._scrollchapter = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_story/chapterlist/#scroll_chapter")
	arg_1_0._scrollchapterresource = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_resource/chapterlist/#scroll_chapter_resource")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_4_0._scrollchapter.gameObject)

	arg_4_0:initScrollDragListener(arg_4_0._drag, arg_4_0._scrollchapter)

	arg_4_0._dragResource = SLFramework.UGUI.UIDragListener.Get(arg_4_0._scrollchapterresource.gameObject)

	arg_4_0:initScrollDragListener(arg_4_0._dragResource, arg_4_0._scrollchapterresource)
	arg_4_0:addEventCb(DungeonController.instance, DungeonEvent.OnChangeChapterList, arg_4_0._onChangeChapterList, arg_4_0)
end

function var_0_0._onChangeChapterList(arg_5_0)
	if arg_5_0._curScroll then
		arg_5_0._curScroll:RemoveOnValueChanged()

		arg_5_0._curScroll = nil
	end
end

function var_0_0.initScrollDragListener(arg_6_0, arg_6_1, arg_6_2)
	arg_6_1:AddDragBeginListener(arg_6_0._onDragBegin, arg_6_0, arg_6_2)
	arg_6_1:AddDragListener(arg_6_0._onDrag, arg_6_0, arg_6_2)
	arg_6_1:AddDragEndListener(arg_6_0._onDragEnd, arg_6_0, arg_6_2)
end

function var_0_0.addScrollChangeCallback(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._scrollChangeCallback = arg_7_1
	arg_7_0._scrollChangeCallbackTarget = arg_7_2
end

function var_0_0._onScrollValueChanged(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_0._scrollChangeCallback then
		arg_8_0._scrollChangeCallback(arg_8_0._scrollChangeCallbackTarget)
	end

	local var_8_0 = arg_8_0._curScroll.horizontalNormalizedPosition

	if arg_8_0._curNormalizedPos and var_8_0 >= 0 and var_8_0 <= 1 then
		local var_8_1 = var_8_0 - arg_8_0._curNormalizedPos

		if math.abs(var_8_1) >= arg_8_0._cellCenterPos then
			if var_8_1 > 0 then
				arg_8_0._curNormalizedPos = arg_8_0._curNormalizedPos + arg_8_0._cellCenterPos
			else
				arg_8_0._curNormalizedPos = arg_8_0._curNormalizedPos - arg_8_0._cellCenterPos
			end

			arg_8_0._curNormalizedPos = var_8_0

			DungeonAudio.instance:cardPass()
		end
	end
end

function var_0_0._onDragBegin(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._beginDragScrollNormalizePos = arg_9_1.horizontalNormalizedPosition
	arg_9_0._beginDrag = true

	arg_9_0:initNormalizePos(arg_9_1)
end

function var_0_0.initNormalizePos(arg_10_0, arg_10_1)
	local var_10_0 = recthelper.getWidth(arg_10_1.content)
	local var_10_1 = recthelper.getWidth(arg_10_1.transform)
	local var_10_2 = arg_10_1.content
	local var_10_3 = var_10_2.childCount

	if var_10_3 == 0 then
		return
	end

	local var_10_4 = var_10_2:GetChild(var_10_3 - 1)
	local var_10_5 = recthelper.getWidth(var_10_4)
	local var_10_6 = var_10_0 - var_10_1

	if var_10_6 > 0 then
		arg_10_0._cellCenterPos = 1 / (var_10_6 / var_10_5) / 2
		arg_10_0._curNormalizedPos = arg_10_1.horizontalNormalizedPosition

		if arg_10_0._curScroll then
			arg_10_0._curScroll:RemoveOnValueChanged()

			arg_10_0._curScroll = nil
		end

		arg_10_0._curScroll = arg_10_1

		arg_10_0._curScroll:AddOnValueChanged(arg_10_0._onScrollValueChanged, arg_10_0)
	else
		arg_10_0._curNormalizedPos = nil
	end
end

function var_0_0._onDrag(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0._beginDrag then
		arg_11_0._beginDrag = false

		return
	end

	local var_11_0 = arg_11_2.delta.x
	local var_11_1 = arg_11_1.horizontalNormalizedPosition

	if arg_11_0._beginDragScrollNormalizePos then
		if var_11_1 == arg_11_0._beginDragScrollNormalizePos then
			DungeonAudio.instance:chapterListBoundary()
		elseif var_11_0 > 0 and var_11_1 <= 0 or var_11_0 < 0 and var_11_1 >= 1 then
			DungeonAudio.instance:chapterListBoundary()
		end

		arg_11_0._beginDragScrollNormalizePos = nil
	end
end

function var_0_0._onDragEnd(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0._beginDrag = false
	arg_12_0._beginDragScrollNormalizePos = nil
end

function var_0_0.removeScrollDragListener(arg_13_0, arg_13_1)
	arg_13_1:RemoveDragBeginListener()
	arg_13_1:RemoveDragEndListener()
	arg_13_1:RemoveDragListener()
end

function var_0_0.onClose(arg_14_0)
	if arg_14_0._curScroll then
		arg_14_0._curScroll:RemoveOnValueChanged()
	end

	arg_14_0:removeScrollDragListener(arg_14_0._drag)
	arg_14_0:removeScrollDragListener(arg_14_0._dragResource)

	arg_14_0._scrollChangeCallback = nil
	arg_14_0._scrollChangeCallbackTarget = nil
end

return var_0_0
