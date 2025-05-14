module("modules.logic.dungeon.view.rolestory.RoleStoryDispatchTalkTween", package.seeall)

local var_0_0 = class("RoleStoryDispatchTalkTween", UserDataDispose)

function var_0_0.ctor(arg_1_0)
	arg_1_0:__onInit()
end

function var_0_0.playTalkTween(arg_2_0, arg_2_1)
	arg_2_0:clearTween()

	arg_2_0.talkList = arg_2_1

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.talkList) do
		iter_2_1:clearText()
	end

	arg_2_0.playIndex = 0

	arg_2_0:playNext()

	arg_2_0.playingId = AudioMgr.instance:trigger(AudioEnum.UI.play_activitystorysfx_shiji_type)
end

function var_0_0.playNext(arg_3_0)
	local var_3_0 = arg_3_0.playIndex + 1
	local var_3_1 = arg_3_0.talkList[var_3_0]

	if var_3_1 then
		arg_3_0.playIndex = var_3_0

		var_3_1:startTween(arg_3_0.playNext, arg_3_0)
	else
		arg_3_0:finishTween()
	end
end

function var_0_0.finishTween(arg_4_0)
	arg_4_0:stopAudio()
end

function var_0_0.clearTween(arg_5_0)
	if arg_5_0.talkList then
		for iter_5_0, iter_5_1 in ipairs(arg_5_0.talkList) do
			iter_5_1:killTween()
		end
	end

	arg_5_0:stopAudio()
end

function var_0_0.stopAudio(arg_6_0)
	if arg_6_0.playingId and arg_6_0.playingId > 0 then
		AudioMgr.instance:stopPlayingID(arg_6_0.playingId)

		arg_6_0.playingId = nil
	end
end

function var_0_0.destroy(arg_7_0)
	arg_7_0:clearTween()
	arg_7_0:__onDispose()
end

return var_0_0
