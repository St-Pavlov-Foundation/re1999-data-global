module("modules.logic.versionactivity1_9.fairyland.view.FairyLandCompleteView", package.seeall)

local var_0_0 = class("FairyLandCompleteView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "btnClose")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnClose, arg_2_0.onClickClose, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onClickClose(arg_4_0)
	if arg_4_0.canClose then
		arg_4_0:closeThis()
	end
end

function var_0_0.onOpen(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_gudu_decrypt_succeed)
	TaskDispatcher.runDelay(arg_5_0.setCanClose, arg_5_0, 2)

	local var_5_0 = arg_5_0.viewParam or {}
	local var_5_1 = var_5_0.shapeType or 1

	arg_5_0.callback = var_5_0.callback
	arg_5_0.callbackObj = var_5_0.callbackObj

	local var_5_2 = gohelper.findChild(arg_5_0.viewGO, "#go_Complete/#go_Shape" .. tostring(var_5_1))

	gohelper.setActive(var_5_2, true)
end

function var_0_0.setCanClose(arg_6_0)
	arg_6_0.canClose = true
end

function var_0_0.onClose(arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.setCanClose, arg_7_0)

	if arg_7_0.callback then
		arg_7_0.callback(arg_7_0.callbackObj)
	end
end

return var_0_0
