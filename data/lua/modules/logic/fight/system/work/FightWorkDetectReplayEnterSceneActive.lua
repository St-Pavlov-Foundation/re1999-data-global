module("modules.logic.fight.system.work.FightWorkDetectReplayEnterSceneActive", package.seeall)

slot0 = class("FightWorkDetectReplayEnterSceneActive", BaseWork)

function slot0.onStart(slot0)
	if FightReplayModel.instance:isReplay() and lua_fight_replay_enter_scene_root_active.configDict[FightModel.instance:getBattleId()] and slot2[FightModel.instance:getCurWaveId()] and GameSceneMgr.instance:getCurScene() then
		if slot3.level:getSceneGo() then
			for slot9 = 0, slot4.transform.childCount - 1 do
				slot10 = slot4.transform:GetChild(slot9)

				gohelper.setActive(slot10.gameObject, slot10.name == slot2.activeRootName)
			end
		end

		if not string.nilorempty(slot2.switch) then
			slot3.bgm._cur_switch = slot2.switch

			slot3.bgm:_switchMonsterGroup()
		end
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
