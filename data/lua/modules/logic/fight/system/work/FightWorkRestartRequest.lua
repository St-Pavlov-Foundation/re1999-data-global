module("modules.logic.fight.system.work.FightWorkRestartRequest", package.seeall)

slot0 = class("FightWorkRestartRequest", BaseWork)

function slot0.ctor(slot0, slot1)
	slot0._fightParam = slot1
end

function slot0.onStart(slot0)
	slot0.episode_config = slot0._fightParam:getCurEpisodeConfig()
	slot0.chapter_config = DungeonConfig.instance:getChapterCO(slot0.episode_config.chapterId)

	if _G["FightRestartRequestType" .. slot0.chapter_config.type] or _G["FightRestartRequestType" .. (FightRestartSequence.RestartType2Type[slot1] or slot1)] then
		slot0._request_class = slot2.New(slot0, slot0._fightParam, slot0.episode_config, slot0.chapter_config)

		if slot0._request_class.requestFight then
			slot0._request_class:requestFight()
		else
			FightSystem.instance:cancelRestart()
		end
	else
		FightSystem.instance:cancelRestart()
	end
end

function slot0.clearWork(slot0)
	if slot0._request_class then
		slot0._request_class:releaseSelf()

		slot0._request_class = nil
	end
end

return slot0
