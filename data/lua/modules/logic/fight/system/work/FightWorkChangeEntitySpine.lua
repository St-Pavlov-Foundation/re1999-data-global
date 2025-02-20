module("modules.logic.fight.system.work.FightWorkChangeEntitySpine", package.seeall)

slot0 = class("FightWorkChangeEntitySpine", BaseWork)

function slot0.ctor(slot0, slot1, slot2)
	slot0._entity = slot1
	slot0._url = slot2
end

function slot0.onStart(slot0)
	TaskDispatcher.runDelay(slot0._delayDone, slot0, 10)

	slot0._lastSpineObj = slot0._entity.spine:getSpineGO()

	slot0._entity:loadSpine(slot0._onLoaded, slot0, slot0._url)
end

function slot0._onLoaded(slot0)
	if slot0._entity then
		slot0._entity:initHangPointDict()

		if slot0._entity.effect:getHangEffect() then
			for slot5, slot6 in pairs(slot1) do
				slot7 = slot6.effectWrap
				slot9, slot10, slot11 = transformhelper.getLocalPos(slot7.containerTr)

				gohelper.addChild(slot0._entity:getHangPoint(slot6.hangPoint), slot7.containerGO)
				transformhelper.setLocalPos(slot7.containerTr, slot9, slot10, slot11)
			end
		end

		FightMsgMgr.sendMsg(FightMsgId.SpineLoadFinish, slot0._entity.spine)
		FightController.instance:dispatchEvent(FightEvent.OnSpineLoaded, slot0._entity.spine)
	end

	gohelper.destroy(slot0._lastSpineObj)
	slot0:onDone(true)
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
end

return slot0
