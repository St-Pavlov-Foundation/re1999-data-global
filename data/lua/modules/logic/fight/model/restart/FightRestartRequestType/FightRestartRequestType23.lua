module("modules.logic.fight.model.restart.FightRestartRequestType.FightRestartRequestType23", package.seeall)

slot0 = class("FightRestartRequestType23", FightRestartRequestType1)

function slot0.requestFight(slot0)
	slot0._fight_work:onDone(true)

	if FightController.instance:setFightHeroGroup() then
		slot2 = slot0._fightParam

		if not Season123Model.instance:getBattleContext() then
			FightSystem.instance:restartFightFail()

			return
		end

		Activity123Rpc.instance:sendStartAct123BattleRequest(slot3.actId, slot3.layer or -1, slot2.chapterId, slot2.episodeId, slot2, slot2.multiplication, nil, slot2.isReplay, true, slot0.onReceiveStartBattle, slot0)
		AudioMgr.instance:trigger(AudioEnum.UI.Stop_HeroNormalVoc)
	end
end

function slot0.onReceiveStartBattle(slot0, slot1, slot2, slot3)
	if slot2 ~= 0 then
		FightSystem.instance:restartFightFail()

		return
	end
end

return slot0
