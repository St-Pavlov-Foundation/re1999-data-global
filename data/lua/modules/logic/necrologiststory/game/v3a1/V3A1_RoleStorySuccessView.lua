module("modules.logic.necrologiststory.game.v3a1.V3A1_RoleStorySuccessView", package.seeall)

local var_0_0 = class("V3A1_RoleStorySuccessView", BaseView)

function var_0_0.onInitView(arg_1_0)
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

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0.onClickModalMask(arg_5_0)
	if not arg_5_0.animFinish then
		return
	end

	arg_5_0:closeThis()
end

function var_0_0.onOpen(arg_6_0)
	AudioMgr.instance:trigger(AudioEnum.NecrologistStory.play_ui_tangren_win1)

	arg_6_0.animFinish = false

	TaskDispatcher.runDelay(arg_6_0._onAnimFinish, arg_6_0, 1.5)
end

function var_0_0._onAnimFinish(arg_7_0)
	arg_7_0.animFinish = true
end

function var_0_0.onDestroyView(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._onAnimFinish, arg_8_0)
end

return var_0_0
