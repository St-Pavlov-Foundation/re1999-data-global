module("modules.logic.versionactivity1_2.yaxian.controller.game.state.YaXianStateLock", package.seeall)

slot0 = class("YaXianStateLock", YaXianStateBase)

function slot0.start(slot0)
	logNormal("YaXianStateLock start")

	slot0.stateType = YaXianGameEnum.GameStateType.Lock
end

function slot0.onClickPos(slot0, slot1, slot2)
	logNormal("status YaXianStateLock")
end

return slot0
