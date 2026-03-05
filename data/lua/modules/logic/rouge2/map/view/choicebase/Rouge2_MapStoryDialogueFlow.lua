-- chunkname: @modules/logic/rouge2/map/view/choicebase/Rouge2_MapStoryDialogueFlow.lua

module("modules.logic.rouge2.map.view.choicebase.Rouge2_MapStoryDialogueFlow", package.seeall)

local Rouge2_MapStoryDialogueFlow = class("Rouge2_MapStoryDialogueFlow", Rouge2_MapDialogueBaseFlow)

function Rouge2_MapStoryDialogueFlow:onAfterPlay()
	if self._playType ~= Rouge2_MapEnum.DialoguePlayType.Directly then
		self._flow:addWork(FunctionWork.New(self._listComp._onDialogueDone, self._listComp))
		self._flow:addWork(WaitEventWork.New("Rouge2_MapController;Rouge2_MapEvent;onSwitch2SelectChoice"))
	end
end

return Rouge2_MapStoryDialogueFlow
