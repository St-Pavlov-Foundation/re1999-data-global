module("modules.logic.gm.model.GMFightSimulateLeftModel", package.seeall)

slot0 = class("GMFightSimulateLeftModel", ListScrollModel)

function slot0.onOpen(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(lua_chapter.configList) do
		if slot6.type == DungeonEnum.ChapterType.Simulate then
			table.insert(slot1, slot6)
		end
	end

	slot0:setList(slot1)
end

slot0.instance = slot0.New()

return slot0
