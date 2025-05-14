module("modules.logic.scene.explore.comp.ExploreAudioComp", package.seeall)

local var_0_0 = class("ExploreAudioComp", BaseSceneComp)

function var_0_0.onSceneStart(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.audioManagerGo = gohelper.find("AudioManager")
	arg_1_0.focusGo = CameraMgr.instance:getFocusTrs().gameObject

	gohelper.enableAkListener(arg_1_0.audioManagerGo, false)
	gohelper.enableAkListener(arg_1_0.focusGo, true)

	arg_1_0._allLoopAudioIds = {}
end

function var_0_0.onTriggerAudio(arg_2_0, arg_2_1, arg_2_2)
	if not arg_2_0._allLoopAudioIds[arg_2_1] then
		arg_2_0._allLoopAudioIds[arg_2_1] = {}
	end

	arg_2_0._allLoopAudioIds[arg_2_1][arg_2_2] = true
end

function var_0_0.stopAudioByUnit(arg_3_0, arg_3_1)
	if not arg_3_0._allLoopAudioIds[arg_3_1] then
		return
	end

	for iter_3_0 in pairs(arg_3_0._allLoopAudioIds[arg_3_1]) do
		AudioMgr.instance:stopPlayingID(iter_3_0)
	end

	arg_3_0._allLoopAudioIds[arg_3_1] = nil
end

function var_0_0.onSceneClose(arg_4_0)
	for iter_4_0 in pairs(arg_4_0._allLoopAudioIds) do
		arg_4_0:stopAudioByUnit(iter_4_0)
	end

	arg_4_0._allLoopAudioIds = {}

	gohelper.enableAkListener(arg_4_0.audioManagerGo, true)
	gohelper.enableAkListener(arg_4_0.focusGo, false)

	arg_4_0.audioManagerGo = nil
	arg_4_0.focusGo = nil
end

return var_0_0
