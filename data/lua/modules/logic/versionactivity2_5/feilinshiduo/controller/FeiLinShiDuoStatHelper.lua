module("modules.logic.versionactivity2_5.feilinshiduo.controller.FeiLinShiDuoStatHelper", package.seeall)

slot0 = class("FeiLinShiDuoStatHelper")

function slot0.ctor(slot0)
	slot0.gameStartTime = 0
	slot0.resetStartTime = 0
	slot0.episodeStartTime = 0
	slot0.curEpisodeId = 0
end

function slot0.initGameStartTime(slot0)
	slot0.gameStartTime = UnityEngine.Time.realtimeSinceStartup
end

function slot0.initResetStartTime(slot0)
	slot0.resetStartTime = UnityEngine.Time.realtimeSinceStartup
end

function slot0.initEpisodeStartTime(slot0, slot1)
	slot0.curEpisodeId = slot1
	slot0.episodeStartTime = UnityEngine.Time.realtimeSinceStartup
end

function slot0.setSceneInfo(slot0, slot1)
	table.insert({}, {
		id = 0,
		x = slot1.transform.localPosition.x,
		y = slot1.transform.localPosition.y
	})

	for slot9, slot10 in pairs(FeiLinShiDuoGameModel.instance:getElementMap()[FeiLinShiDuoEnum.ObjectType.Box]) do
		table.insert(slot2, {
			id = slot10.id,
			x = slot10.pos[1],
			y = slot10.pos[2]
		})
	end

	table.sort(slot2, function (slot0, slot1)
		return slot0.id < slot1.id
	end)

	return slot2
end

function slot0.sendExitGameMap(slot0, slot1)
	if not slot1 then
		return
	end

	StatController.instance:track(StatEnum.EventName.Act185MapExit, {
		[StatEnum.EventProperties.FeiLinShiDuo_ActId] = tostring(FeiLinShiDuoModel.instance:getCurActId()),
		[StatEnum.EventProperties.FeiLinShiDuo_MapId] = tostring(FeiLinShiDuoGameModel.instance:getCurMapId()),
		[StatEnum.EventProperties.FeiLinShiDuo_UseTime] = UnityEngine.Time.realtimeSinceStartup - slot0.gameStartTime,
		[StatEnum.EventProperties.FeiLinShiDuo_IsBlindness] = FeiLinShiDuoGameModel.instance:getBlindnessModeState(),
		[StatEnum.EventProperties.FeiLinShiDuo_SceneInfo] = slot0:setSceneInfo(slot1)
	})
end

function slot0.sendResetGameMap(slot0, slot1)
	if not slot1 then
		return
	end

	StatController.instance:track(StatEnum.EventName.Act185MapReset, {
		[StatEnum.EventProperties.FeiLinShiDuo_ActId] = tostring(FeiLinShiDuoModel.instance:getCurActId()),
		[StatEnum.EventProperties.FeiLinShiDuo_MapId] = tostring(FeiLinShiDuoGameModel.instance:getCurMapId()),
		[StatEnum.EventProperties.FeiLinShiDuo_UseTime] = UnityEngine.Time.realtimeSinceStartup - slot0.resetStartTime,
		[StatEnum.EventProperties.FeiLinShiDuo_IsBlindness] = FeiLinShiDuoGameModel.instance:getBlindnessModeState(),
		[StatEnum.EventProperties.FeiLinShiDuo_SceneInfo] = slot0:setSceneInfo(slot1)
	})
	slot0:initResetStartTime()
end

function slot0.sendMapFinish(slot0, slot1)
	if not slot1 then
		return
	end

	StatController.instance:track(StatEnum.EventName.Act185MapFinish, {
		[StatEnum.EventProperties.FeiLinShiDuo_ActId] = tostring(FeiLinShiDuoModel.instance:getCurActId()),
		[StatEnum.EventProperties.FeiLinShiDuo_MapId] = tostring(FeiLinShiDuoGameModel.instance:getCurMapId()),
		[StatEnum.EventProperties.FeiLinShiDuo_UseTime] = UnityEngine.Time.realtimeSinceStartup - slot0.gameStartTime,
		[StatEnum.EventProperties.FeiLinShiDuo_IsBlindness] = FeiLinShiDuoGameModel.instance:getBlindnessModeState(),
		[StatEnum.EventProperties.FeiLinShiDuo_SceneInfo] = slot0:setSceneInfo(slot1)
	})
end

function slot0.sendDungeonFinish(slot0)
	StatController.instance:track(StatEnum.EventName.Act185DungeonFinish, {
		[StatEnum.EventProperties.FeiLinShiDuo_EpisodeId] = slot0.curEpisodeId,
		[StatEnum.EventProperties.FeiLinShiDuo_EpisodeUseTime] = UnityEngine.Time.realtimeSinceStartup - slot0.episodeStartTime
	})
end

slot0.instance = slot0.New()

return slot0
