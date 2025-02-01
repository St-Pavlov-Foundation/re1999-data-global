module("modules.logic.fight.system.work.trigger.FightWorkTriggerSceneEffect", package.seeall)

slot0 = class("FightWorkTriggerSceneEffect", BaseWork)

function slot0.ctor(slot0, slot1, slot2)
	slot0._fightStepMO = slot1
	slot0._actEffectMO = slot2
end

function slot0.onStart(slot0)
	slot0._config = lua_trigger_action.configDict[slot0._actEffectMO.effectNum]

	if GameSceneMgr.instance:getCurScene() and slot1.level:getSceneGo() and FightHelper.getEntity(FightEntityScene.MySideId) then
		if slot0._config.param2 == 0 then
			slot3.effect:removeEffectByEffectName(slot0._config.param1)
		else
			slot3.effect:addGlobalEffect(slot0._config.param1)
		end
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
