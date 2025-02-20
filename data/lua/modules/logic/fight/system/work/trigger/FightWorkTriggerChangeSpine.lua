module("modules.logic.fight.system.work.trigger.FightWorkTriggerChangeSpine", package.seeall)

slot0 = class("FightWorkTriggerChangeSpine", BaseWork)

function slot0.ctor(slot0, slot1, slot2)
	slot0._fightStepMO = slot1
	slot0._actEffectMO = slot2
end

function slot0.onStart(slot0)
	slot0._config = lua_trigger_action.configDict[slot0._actEffectMO.effectNum]
	slot0._tarEntity = FightHelper.getEnemyEntityByMonsterId(tonumber(slot0._config.param1))

	if slot0._tarEntity and slot0._tarEntity.spine then
		TaskDispatcher.runDelay(slot0._delayDone, slot0, 20)

		slot0._lastSpineObj = slot0._tarEntity.spine:getSpineGO()

		slot0._tarEntity:loadSpine(slot0._onLoaded, slot0, string.format("roles/%s.prefab", slot0._config.param2))

		return
	end

	slot0:_delayDone()
end

function slot0._onLoaded(slot0)
	if slot0._tarEntity then
		FightMsgMgr.sendMsg(FightMsgId.SpineLoadFinish, slot0._tarEntity.spine)
		FightController.instance:dispatchEvent(FightEvent.OnSpineLoaded, slot0._tarEntity.spine)
	end

	slot0:_delayDone()
end

function slot0._delayDone(slot0)
	if slot0._tarEntity then
		slot0._tarEntity:initHangPointDict()
	end

	if slot0._tarEntity.effect:getHangEffect() then
		for slot5, slot6 in pairs(slot1) do
			slot7 = slot6.effectWrap
			slot9, slot10, slot11 = transformhelper.getLocalPos(slot7.containerTr)

			gohelper.addChild(slot0._tarEntity:getHangPoint(slot6.hangPoint), slot7.containerGO)
			transformhelper.setLocalPos(slot7.containerTr, slot9, slot10, slot11)
		end
	end

	gohelper.destroy(slot0._lastSpineObj)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
end

return slot0
