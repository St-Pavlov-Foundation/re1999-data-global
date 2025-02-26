module("modules.logic.guide.controller.action.impl.GuideActionFightVictory", package.seeall)

slot0 = class("GuideActionFightVictory", BaseGuideAction)
slot1 = 2.5

function slot0.onStart(slot0, slot1)
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.Fight then
		slot0:onDone(true)

		return
	end

	slot0._playVictoryList = {}
	slot6 = uv0

	TaskDispatcher.runDelay(slot0._onVictoryEnd, slot0, slot6)

	for slot6, slot7 in ipairs(FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, true)) do
		if slot7.spine:hasAnimation(SpineAnimState.victory) then
			slot0._victoryActName = FightHelper.processEntityActionName(slot7, SpineAnimState.victory)

			slot7.spine:addAnimEventCallback(slot0._onAnimEvent, slot0, slot7)
			slot7.spine:play(slot0._victoryActName, false, true, true)

			if slot7.nameUI then
				slot7.nameUI:setActive(false)
			end

			table.insert(slot0._playVictoryList, slot7)
		end
	end

	slot0:onDone(true)
end

function slot0._onAnimEvent(slot0, slot1, slot2, slot3, slot4)
	if slot1 == slot0._victoryActName and slot2 == SpineAnimEvent.ActionComplete then
		slot5 = slot4

		slot5:resetAnimState()
		slot5.spine:removeAnimEventCallback(slot0._onAnimEvent, slot0)
	end
end

function slot0._onVictoryEnd(slot0)
	for slot4, slot5 in ipairs(slot0._playVictoryList) do
		slot5:resetAnimState()
		slot5.spine:removeAnimEventCallback(slot0._onAnimEvent, slot0)
	end
end

function slot0.onDestroy(slot0)
	uv0.super.onDestroy(slot0)
	TaskDispatcher.cancelTask(slot0._onVictoryEnd, slot0)

	slot0._playVictoryList = nil
end

return slot0
