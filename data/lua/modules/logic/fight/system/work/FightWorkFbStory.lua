module("modules.logic.fight.system.work.FightWorkFbStory", package.seeall)

slot0 = class("FightWorkFbStory", BaseWork)
slot0.Type_EnterWave = 1
slot0.Type_BeforePlaySkill = 2

function slot0.ctor(slot0, slot1, slot2)
	slot0.conditionType = slot1
	slot0.exParam = slot2
	slot0.episodeId = FightModel.instance:getFightParam() and slot3.episodeId
	slot4 = slot0.episodeId and DungeonConfig.instance:getEpisodeCO(slot0.episodeId)
	slot5 = slot4 and string.split(slot4.story, "#")
	slot0.configCondType = slot5 and tonumber(slot5[1])
	slot0.configCondParam = slot5 and slot5[2]
	slot0.configCondStoryId = slot5 and tonumber(slot5[3])
end

function slot0.onStart(slot0)
	if not slot0.configCondType or slot0.conditionType ~= slot0.configCondType then
		slot0:onDone(true)

		return
	end

	if slot0.configCondType == 1 then
		if FightModel.instance:getCurWaveId() ~= tonumber(slot0.configCondParam) then
			slot0:onDone(true)

			return
		end

		slot0:_checkPlayStory()
	elseif slot0.configCondType == 2 then
		if not tonumber(slot0.configCondParam) or not slot0.exParam or slot0.exParam ~= slot1 then
			slot0:onDone(true)

			return
		end

		slot0:_checkPlayStory()
	else
		slot0:onDone(true)
	end
end

function slot0._checkPlayStory(slot0)
	if StoryModel.instance:isStoryFinished(slot0.configCondStoryId) then
		slot0:onDone(true)

		return
	end

	slot0:_setAllEntitysVisible(false)
	StoryController.instance:playStory(slot0.configCondStoryId, {
		mark = true,
		episodeId = slot0.episodeId
	}, slot0._afterPlayStory, slot0)
end

function slot0._afterPlayStory(slot0)
	slot0:_setAllEntitysVisible(true)
	slot0:onDone(true)
end

function slot0._setAllEntitysVisible(slot0, slot1)
	for slot6, slot7 in ipairs(FightHelper.getAllEntitys()) do
		slot7:setActive(slot1)
	end
end

function slot0.checkHasFbStory()
	slot1 = FightModel.instance:getFightParam() and slot0.episodeId
	slot2 = slot1 and DungeonConfig.instance:getEpisodeCO(slot1)

	return slot2 and not string.nilorempty(slot2.story)
end

return slot0
