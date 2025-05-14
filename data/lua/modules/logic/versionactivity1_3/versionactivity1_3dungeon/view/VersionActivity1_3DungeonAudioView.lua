module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.view.VersionActivity1_3DungeonAudioView", package.seeall)

local var_0_0 = class("VersionActivity1_3DungeonAudioView", BaseView)

function var_0_0.onInitView(arg_1_0)
	return
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onOpen(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_leimi_theft_open)
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_4_0._onOpenView, arg_4_0)
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_4_0._onCloseView, arg_4_0)
end

function var_0_0._onOpenView(arg_5_0, arg_5_1)
	if arg_5_1 == ViewName.StoryView then
		-- block empty
	end
end

function var_0_0._onCloseView(arg_6_0, arg_6_1)
	if arg_6_1 == ViewName.StoryView then
		-- block empty
	end
end

function var_0_0.onClose(arg_7_0)
	AudioMgr.instance:trigger(AudioEnum.UI.stop_ui_noise_allarea)
	AudioEffectMgr.instance:stopAudio(AudioEnum.Story.Play_Chapter_Start)
end

function var_0_0.onDestroyView(arg_8_0)
	return
end

return var_0_0
