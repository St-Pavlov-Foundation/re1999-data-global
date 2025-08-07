module("modules.logic.sp01.assassin2.story.littlegame.AssassinDialogWork", package.seeall)

local var_0_0 = class("AssassinDialogWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0._dialogId = arg_1_1
	arg_1_0._callback = arg_1_2
	arg_1_0._callbackObj = arg_1_3
	arg_1_0._callbackParams = arg_1_4
end

function var_0_0.onStart(arg_2_0)
	if not arg_2_0._dialogId then
		arg_2_0:onDone(false)

		return
	end

	VersionActivity2_9DungeonController.instance:openAssassinStoryDialogView(arg_2_0._dialogId, arg_2_0._onDialogDone, arg_2_0)
end

function var_0_0._onDialogDone(arg_3_0)
	if arg_3_0._callback then
		arg_3_0._callback(arg_3_0._callbackObj, arg_3_0._callbackParams)
	end

	arg_3_0:onDone(true)
end

return var_0_0
