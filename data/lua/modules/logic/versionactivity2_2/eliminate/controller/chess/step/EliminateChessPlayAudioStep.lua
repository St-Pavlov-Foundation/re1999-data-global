module("modules.logic.versionactivity2_2.eliminate.controller.chess.step.EliminateChessPlayAudioStep", package.seeall)

slot0 = class("EliminateChessPlayAudioStep", EliminateChessStepBase)

function slot0.onStart(slot0)
	if EliminateChessModel.instance:getCurPlayAudioCount() > 5 then
		slot1 = 5
	end

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess["ui_youyu_sources_dispel_" .. slot1])
	EliminateChessModel.instance:addCurPlayAudioCount()
	slot0:onDone(true)
end

return slot0
