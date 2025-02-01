module("modules.logic.versionactivity1_2.yaxian.controller.game.step.YaXianStepCallEvent", package.seeall)

slot0 = class("YaXianStepCallEvent", YaXianStepBase)

function slot0.start(slot0)
	if YaXianGameController.instance.state then
		slot1:setCurEventByObj(slot0.originData.event)

		slot0._curState = slot1:getCurEvent()
	end

	if slot0._curState then
		YaXianGameController.instance:registerCallback(YaXianEvent.OnStateFinish, slot0.onReceiveFinished, slot0)
	else
		slot0:finish()
	end
end

function slot0.onReceiveFinished(slot0, slot1)
	if slot0._curState and slot0._curState.stateType == slot1 then
		YaXianGameController.instance:unregisterCallback(YaXianEvent.OnStateFinish, slot0.onReceiveFinished, slot0)
		slot0:finish()
	end
end

function slot0.finish(slot0)
	if YaXianGameController.instance.state then
		slot1:disposeEventState()
	end

	uv0.super.finish(slot0)
end

function slot0.dispose(slot0)
	YaXianGameController.instance:unregisterCallback(YaXianEvent.OnStateFinish, slot0.onReceiveFinished, slot0)

	if YaXianGameController.instance.state then
		slot1:disposeEventState()
	end
end

return slot0
