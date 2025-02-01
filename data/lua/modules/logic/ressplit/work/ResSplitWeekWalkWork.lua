module("modules.logic.ressplit.work.ResSplitWeekWalkWork", package.seeall)

slot0 = class("ResSplitWeekWalkWork", BaseWork)

function slot0.onStart(slot0, slot1)
	for slot7, slot8 in pairs(ResSplitConfig.instance:getAppIncludeConfig()) do
		slot3 = math.max(0, slot8.maxWeekWalk)
	end

	for slot7, slot8 in pairs(lua_weekwalk.configDict) do
		if slot8.layer <= slot3 then
			for slot17, slot18 in ipairs(cjson.decode(SLFramework.FileHelper.ReadText(string.format("Assets/ZProj/Editor/WeekWalk/Map/%s.txt", lua_weekwalk_scene.configDict[slot8.sceneId].mapId))).nodeList) do
				slot19 = WeekwalkElementInfoMO.New()

				slot19:init({
					elementId = slot18.configId
				})

				if slot19.config and slot19:getConfigBattleId() then
					ResSplitHelper.addBattleMonsterSkins(lua_battle.configDict[slot20])
				end
			end
		end
	end

	slot0:onDone(true)
end

return slot0
