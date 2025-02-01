module("modules.logic.gm.model.GMFightSimulateRightModel", package.seeall)

slot0 = class("GMFightSimulateRightModel", ListScrollModel)

function slot0.setChapterId(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(lua_episode.configList) do
		if slot7.chapterId == slot1 then
			table.insert(slot2, slot7)
		end
	end

	slot0:setList(slot2)
end

slot0.instance = slot0.New()

return slot0
