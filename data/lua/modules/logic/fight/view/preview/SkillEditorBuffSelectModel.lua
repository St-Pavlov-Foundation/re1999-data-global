module("modules.logic.fight.view.preview.SkillEditorBuffSelectModel", package.seeall)

slot0 = class("SkillEditorBuffSelectModel", ListScrollModel)

function slot0.setSelect(slot0, slot1, slot2)
	slot0.attacker = slot1
	slot3 = {}

	for slot7, slot8 in ipairs(lua_skill_buff.configList) do
		if string.find(tostring(slot8.id), slot2) or string.find(slot8.name, slot2) then
			table.insert(slot3, {
				id = slot7,
				co = slot8
			})
		end
	end

	slot0:setList(slot3)
end

slot0.instance = slot0.New()

return slot0
