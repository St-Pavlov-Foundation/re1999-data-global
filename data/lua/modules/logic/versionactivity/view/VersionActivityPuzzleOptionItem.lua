module("modules.logic.versionactivity.view.VersionActivityPuzzleOptionItem", package.seeall)

local var_0_0 = class("VersionActivityPuzzleOptionItem", UserDataDispose)

function var_0_0.onInitView(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1
	arg_1_0.parentView = arg_1_2
	arg_1_0.txtInfo = gohelper.findChildText(arg_1_1, "info")
	arg_1_0.head = gohelper.findChild(arg_1_0.go, "head")
	arg_1_0.txtLineIndex = gohelper.findChildText(arg_1_0.go, "head/txt_index")
	arg_1_0.bgLineIndex = gohelper.findChildImage(arg_1_0.go, "head/bg")

	if not arg_1_2.isFinish then
		arg_1_0.drag = SLFramework.UGUI.UIDragListener.Get(arg_1_0.go)

		arg_1_0.drag:AddDragBeginListener(arg_1_0._onDragBegin, arg_1_0)
		arg_1_0.drag:AddDragEndListener(arg_1_0._onDragEnd, arg_1_0)
		arg_1_0.drag:AddDragListener(arg_1_0._onDrag, arg_1_0)
	end
end

function var_0_0.updateInfo(arg_2_0, arg_2_1, arg_2_2)
	gohelper.setActive(arg_2_0.go, true)

	arg_2_0.txtInfo.text = arg_2_1
	arg_2_0.info = arg_2_1
	arg_2_0.answerIndex = arg_2_2

	gohelper.setActive(arg_2_0.head, false)

	local var_2_0 = (arg_2_0.answerIndex - 1) % 4

	if var_2_0 == 2 then
		gohelper.setActive(arg_2_0.head, true)

		arg_2_0.txtLineIndex.text = math.ceil(arg_2_0.answerIndex / 4)

		local var_2_1 = math.ceil(arg_2_0.answerIndex / 4)

		UISpriteSetMgr.instance:setActivityPuzzle(arg_2_0.bgLineIndex, var_2_1, true)
	end

	local var_2_2 = 2
	local var_2_3 = 350

	if var_2_0 == 0 or var_2_0 == 2 then
		var_2_2, var_2_3 = 30, 290
	end

	transformhelper.setLocalPosXY(arg_2_0.txtInfo.transform, var_2_2, 0)
	recthelper.setWidth(arg_2_0.txtInfo.transform, var_2_3)
end

function var_0_0.hide(arg_3_0)
	gohelper.setActive(arg_3_0.go, false)
end

function var_0_0._onDragBegin(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.parentView:onDragItemDragBegin(arg_4_2, arg_4_0.info, arg_4_0.answerIndex)
end

function var_0_0._onDrag(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.parentView:onDragItemDragging(arg_5_2)
end

function var_0_0._onDragEnd(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.parentView:onDragItemDragEnd(arg_6_2)
end

function var_0_0.unUse(arg_7_0)
	arg_7_0.txtInfo.text = arg_7_0.info
end

function var_0_0.matchCorrect(arg_8_0)
	arg_8_0.txtInfo.text = string.format("<color=%s>%s</color>", VersionActivityEnum.PuzzleColorEnum.MatchCorrectColor, arg_8_0.info)
end

function var_0_0.matchError(arg_9_0)
	arg_9_0.txtInfo.text = string.format("<color=%s>%s</color>", VersionActivityEnum.PuzzleColorEnum.MatchErrorColor, arg_9_0.info)
end

function var_0_0.getScreenPos(arg_10_0)
	return recthelper.uiPosToScreenPos(arg_10_0.go.transform)
end

function var_0_0.onDestroy(arg_11_0)
	if arg_11_0.drag then
		arg_11_0.drag:RemoveDragListener()
		arg_11_0.drag:RemoveDragBeginListener()
		arg_11_0.drag:RemoveDragEndListener()

		arg_11_0.drag = nil
	end

	arg_11_0:__onDispose()
end

return var_0_0
