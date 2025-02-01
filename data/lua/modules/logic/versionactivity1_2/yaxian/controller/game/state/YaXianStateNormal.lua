module("modules.logic.versionactivity1_2.yaxian.controller.game.state.YaXianStateNormal", package.seeall)

slot0 = class("YaXianStateNormal", YaXianStateBase)

function slot0.start(slot0)
	logNormal("YaXianStateNormal start")

	slot0.stateType = YaXianGameEnum.GameStateType.Normal
end

function slot0.onClickPos(slot0, slot1, slot2)
	if YaXianGameController.instance:getSelectedInteractItem() and not slot3.delete and slot3:getHandler() then
		slot3:getHandler():onSelectPos(slot1, slot2)
	else
		logError("select obj missing!")
	end
end

return slot0
