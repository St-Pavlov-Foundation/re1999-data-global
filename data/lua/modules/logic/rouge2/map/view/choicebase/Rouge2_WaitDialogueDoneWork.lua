-- chunkname: @modules/logic/rouge2/map/view/choicebase/Rouge2_WaitDialogueDoneWork.lua

module("modules.logic.rouge2.map.view.choicebase.Rouge2_WaitDialogueDoneWork", package.seeall)

local Rouge2_WaitDialogueDoneWork = class("Rouge2_WaitDialogueDoneWork", BaseWork)

function Rouge2_WaitDialogueDoneWork:ctor()
	return
end

function Rouge2_WaitDialogueDoneWork:onStart()
	local isPlaying = Rouge2_MapModel.instance:isPlayingDialogue()

	if not isPlaying then
		self:onDone(true)

		return
	end

	Rouge2_MapController.instance:registerCallback(Rouge2_MapEvent.onChoiceDialogueDone, self._onDialogueDone, self)
end

function Rouge2_WaitDialogueDoneWork:_onDialogueDone()
	Rouge2_MapController.instance:unregisterCallback(Rouge2_MapEvent.onChoiceDialogueDone, self._onDialogueDone, self)
	self:onDone(true)
end

function Rouge2_WaitDialogueDoneWork:clearWork()
	Rouge2_MapController.instance:unregisterCallback(Rouge2_MapEvent.onChoiceDialogueDone, self._onDialogueDone, self)
end

return Rouge2_WaitDialogueDoneWork
