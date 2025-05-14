module("modules.logic.versionactivity2_2.eliminate.controller.chess.step.EliminateChessPlayAudioStep", package.seeall)

local var_0_0 = class("EliminateChessPlayAudioStep", EliminateChessStepBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = EliminateChessModel.instance:getCurPlayAudioCount()

	if var_1_0 > 5 then
		var_1_0 = 5
	end

	local var_1_1 = "ui_youyu_sources_dispel_" .. var_1_0
	local var_1_2 = AudioEnum.VersionActivity2_2EliminateChess[var_1_1]

	AudioMgr.instance:trigger(var_1_2)
	EliminateChessModel.instance:addCurPlayAudioCount()
	arg_1_0:onDone(true)
end

return var_0_0
