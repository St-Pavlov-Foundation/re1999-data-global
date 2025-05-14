module("modules.logic.handbook.view.HandBookCharacterNavigateHandleView", package.seeall)

local var_0_0 = class("HandBookCharacterNavigateHandleView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goParentView = gohelper.findChild(arg_1_0.viewGO, "#go_characterswitch")
	arg_1_0._goSubView = gohelper.findChild(arg_1_0.viewGO, "#go_center")

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

var_0_0.Status = {
	InParentView = 1,
	InSubView = 2
}

function var_0_0._editableInitView(arg_4_0)
	arg_4_0.status = var_0_0.Status.InParentView
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:refreshUI()
	arg_6_0:addEventCb(HandbookController.instance, HandbookController.EventName.OnShowSubCharacterView, arg_6_0.openSubView, arg_6_0)
end

function var_0_0.onCloseBtnClick(arg_7_0)
	if arg_7_0.status == var_0_0.Status.InParentView then
		arg_7_0:closeParentView()

		return
	end

	HandbookController.instance:dispatchEvent(HandbookController.EventName.PlayCharacterSwitchCloseAnim)
	arg_7_0:closeSubView()
end

function var_0_0.openSubView(arg_8_0)
	arg_8_0.status = var_0_0.Status.InSubView

	arg_8_0:refreshUI()
end

function var_0_0.closeSubView(arg_9_0)
	arg_9_0.status = var_0_0.Status.InParentView

	TaskDispatcher.runDelay(arg_9_0.playCharacterSwitchOpenAnim, arg_9_0, 0.267)
end

function var_0_0.playCharacterSwitchOpenAnim(arg_10_0)
	arg_10_0:refreshUI()
	HandbookController.instance:dispatchEvent(HandbookController.EventName.PlayCharacterSwitchOpenAnim)
end

function var_0_0.closeParentView(arg_11_0)
	arg_11_0:closeThis()
end

function var_0_0.refreshUI(arg_12_0)
	gohelper.setActive(arg_12_0._goParentView, arg_12_0.status == var_0_0.Status.InParentView)
	gohelper.setActive(arg_12_0._goSubView, arg_12_0.status == var_0_0.Status.InSubView)
end

function var_0_0.onClose(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0.playCharacterSwitchOpenAnim, arg_13_0)
end

function var_0_0.onDestroyView(arg_14_0)
	arg_14_0:removeEventCb(HandbookController.instance, HandbookController.EventName.OnShowSubCharacterView, arg_14_0.openSubView, arg_14_0)
end

return var_0_0
