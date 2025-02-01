module("modules.logic.gm.view.command.GMCommand", package.seeall)

slot0 = class("GMCommand")

function slot0.processCmd(slot0, ...)
	if uv0[slot0] then
		uv0[slot0](...)
	end
end

function slot0.decryptSuccess()
	Role37PuzzleModel.instance:Finish(true)
end

function slot0.dungeon(slot0, slot1)
	slot2 = nil
	slot1 = tonumber(slot1)

	if lua_chapter.configDict[100 + (tonumber(slot0) or 0)] then
		slot2 = DungeonConfig.instance:getChapterNonSpEpisodeCOList(slot3.id) and slot4[slot1] and slot4[slot1].id
	end

	if slot2 then
		GMRpc.instance:sendGMRequest(string.format("set dungeon %d", slot2))
	end
end

function slot0.weather(slot0)
	WeatherController.instance:setReportId(tonumber(slot0))
end

function slot0.printreport()
	if WeatherController.instance._curReport then
		print("report id:", slot0.id)
	end
end

function slot0.mainheromode(slot0)
	if ViewMgr.instance:getContainer(ViewName.MainView) then
		slot2:getMainHeroView():debugShowMode(tonumber(slot0) == 1)
	end
end

function slot0.weekwalksettlement(slot0)
	ViewMgr.instance:closeView(ViewName.GMToolView)

	if tonumber(slot0) == 1 then
		WeekWalkController.instance:openWeekWalkShallowSettlementView()
	end

	if slot1 == 2 then
		WeekWalkController.instance:openWeekWalkDeepLayerNoticeView()
	end

	if slot1 == 3 then
		WeekWalkModel.instance:getInfo().isPopDeepSettle = true

		WeekWalkController.instance:openWeekWalkShallowSettlementView()
	end
end

function slot0.finishLayer(slot0, slot1)
	slot2 = {
		"set weekwalkElement 101 10117 3",
		"set weekwalkElement 102 30130 1",
		"set weekwalkElement 103 50117 3",
		"set weekwalkElement 104 201152 1",
		"set weekwalkElement 105 40412 3",
		"set weekwalkElement 201 10129 2",
		"set weekwalkElement 202 30121 3",
		"set weekwalkElement 203 50218 1",
		"set weekwalkElement 204 201151 1",
		"set weekwalkElement 205 40419 1"
	}
	slot1 = tonumber(slot1)

	if tonumber(slot0) < 1 or slot0 > #slot2 then
		return
	end

	if slot1 < 1 or slot1 > #slot2 then
		return
	end

	for slot6 = slot0, slot1 do
		GMRpc.instance:sendGMRequest(slot2[slot6])
	end
end

function slot0.clearTrialData(slot0)
	if slot0 then
		PlayerPrefsHelper.deleteKey(PlayerPrefsKey.HeroGroupTrial .. tostring(PlayerModel.instance:getMyUserId()) .. slot0)
	else
		for slot4 in pairs(lua_battle.configDict) do
			PlayerPrefsHelper.deleteKey(PlayerPrefsKey.HeroGroupTrial .. tostring(PlayerModel.instance:getMyUserId()) .. slot4)
		end
	end
end

return slot0
