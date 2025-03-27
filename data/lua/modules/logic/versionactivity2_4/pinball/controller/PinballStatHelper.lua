module("modules.logic.versionactivity2_4.pinball.controller.PinballStatHelper", package.seeall)

slot0 = class("PinballStatHelper")

function slot0.ctor(slot0)
	slot0._gameBeginDt = 0
	slot0._cityBeginDt = 0
	slot0._useBallList = {}
end

function slot0.resetGameDt(slot0)
	slot0._gameBeginDt = UnityEngine.Time.realtimeSinceStartup
end

function slot0.resetCityDt(slot0)
	slot0._cityBeginDt = UnityEngine.Time.realtimeSinceStartup
end

function slot0.setCurUseBallList(slot0, slot1)
	slot0._useBallList = slot1
end

function slot0.sendGameFinish(slot0)
	if not lua_activity178_episode.configDict[VersionActivity2_4Enum.ActivityId.Pinball][PinballModel.instance.leftEpisodeId] then
		return
	end

	slot3 = {}

	for slot7, slot8 in pairs(PinballModel.instance.gameAddResDict) do
		table.insert(slot3, {
			id = slot7,
			num = slot8
		})
	end

	StatController.instance:track(StatEnum.EventName.act178_game_finish, {
		[StatEnum.EventProperties.EpisodeId_Num] = slot2.id,
		[StatEnum.EventProperties.EpisodeType_Num] = slot2.type,
		[StatEnum.EventProperties.UseTime] = UnityEngine.Time.realtimeSinceStartup - slot0._gameBeginDt,
		[StatEnum.EventProperties.Act178BallList] = slot0._useBallList,
		[StatEnum.EventProperties.Act178RewardInfo] = slot3,
		[StatEnum.EventProperties.Act178CityObj] = slot0:_getCityInfo()
	})
end

function slot0.sendExitCity(slot0)
	StatController.instance:track(StatEnum.EventName.act178_interface_exit, {
		[StatEnum.EventProperties.UseTime] = UnityEngine.Time.realtimeSinceStartup - slot0._cityBeginDt,
		[StatEnum.EventProperties.Act178CityObj] = slot0:_getCityInfo()
	})
end

function slot0.sendResetCity(slot0)
	StatController.instance:track(StatEnum.EventName.act178_reset, {
		[StatEnum.EventProperties.Act178CityObj] = slot0:_getCityInfo()
	})
end

function slot0._getCityInfo(slot0)
	slot1 = {
		wood = PinballModel.instance:getResNum(PinballEnum.ResType.Wood),
		mine = PinballModel.instance:getResNum(PinballEnum.ResType.Mine),
		stone = PinballModel.instance:getResNum(PinballEnum.ResType.Stone),
		food = PinballModel.instance:getResNum(PinballEnum.ResType.Food),
		play = PinballModel.instance:getResNum(PinballEnum.ResType.Play),
		complaint = PinballModel.instance:getResNum(PinballEnum.ResType.Complaint),
		score = PinballModel.instance:getResNum(PinballEnum.ResType.Score),
		day = PinballModel.instance.day,
		building_list = {}
	}

	for slot5, slot6 in pairs(PinballModel.instance._buildingInfo) do
		table.insert(slot1.building_list, string.format("%d_%d", slot6.baseCo.id, slot6.level))
	end

	slot1.talent_list = {}

	for slot5, slot6 in pairs(PinballModel.instance._unlockTalents) do
		table.insert(slot1.talent_list, slot6.co.id)
	end

	return slot1
end

slot0.instance = slot0.New()

return slot0
