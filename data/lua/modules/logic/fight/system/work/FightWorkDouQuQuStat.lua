module("modules.logic.fight.system.work.FightWorkDouQuQuStat", package.seeall)

slot0 = class("FightWorkDouQuQuStat", FightWorkItem)

function slot0.onStart(slot0)
	if FightDataModel.instance.douQuQuMgr.isRecord then
		slot0:onDone(true)

		return
	end

	slot2 = {
		[StatEnum.EventProperties.DouQuQuFightActivityId] = tostring(Activity174Model.instance:getCurActId() or 12304),
		[StatEnum.EventProperties.DouQuQuFightUseTime] = ServerTime.now() - uv0.startTime,
		[StatEnum.EventProperties.DouQuQuFightTotalRound] = slot1.round or -1,
		[StatEnum.EventProperties.DouQuQuFightResult] = slot1.param.win[slot1.index] and "成功" or "失败",
		[StatEnum.EventProperties.DouQuQuFightPlayerTeamInfo] = {},
		[StatEnum.EventProperties.DouQuQuFightEnemyTeamInfo] = {}
	}

	slot0:_setTeamData(slot2[StatEnum.EventProperties.DouQuQuFightPlayerTeamInfo], slot1.param.player[slot1.index])
	slot0:_setTeamData(slot2[StatEnum.EventProperties.DouQuQuFightEnemyTeamInfo], slot1.param.enemy[slot1.index])
	StatController.instance:track(StatEnum.EventName.DouQuQuFight, slot2)
	slot0:onDone(true)
end

function slot0._setTeamData(slot0, slot1, slot2)
	for slot8, slot9 in ipairs(slot2.battleHeroInfo) do
		table.insert(slot1, {
			team_id = FightDataModel.instance.douQuQuMgr.index,
			hero = slot9.heroId,
			item = slot9.itemId,
			skill = slot9.priorSkill
		})
	end
end

return slot0
