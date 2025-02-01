module("modules.logic.fight.system.work.FightWorkRestartAbandon", package.seeall)

slot0 = class("FightWorkRestartAbandon", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0._fightParam = slot1
end

function slot0.onStart(slot0)
	slot0.episode_config = slot0._fightParam:getCurEpisodeConfig()
	slot0.chapter_config = DungeonConfig.instance:getChapterCO(slot0.episode_config.chapterId)

	if _G["FightRestartAbandonType" .. slot0.chapter_config.type] or _G["FightRestartAbandonType" .. (FightRestartSequence.RestartType2Type[slot1] or slot1)] then
		slot0._abandon_class = slot2.New(slot0, slot0._fightParam, slot0.episode_config, slot0.chapter_config)

		if slot0._abandon_class:canRestart() then
			slot0._abandon_class:abandon()
		else
			FightSystem.instance:cancelRestart()
		end
	else
		FightSystem.instance:cancelRestart()
	end
end

function slot0.clearWork(slot0)
	if slot0._abandon_class then
		slot0._abandon_class:releaseEvent()
		slot0._abandon_class:releaseSelf()

		slot0._abandon_class = nil
	end
end

return slot0
