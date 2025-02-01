module("modules.logic.fight.view.preview.SkillEditorSceneSelectModel", package.seeall)

slot0 = class("SkillEditorSceneSelectModel", ListScrollModel)

function slot0.setSelect(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in ipairs(lua_scene_level.configList) do
		slot9 = lua_scene.configDict[slot8.sceneId]

		if string.find(tostring(slot8.id), slot1) or slot9 and string.find(slot9.name or "", slot1) then
			table.insert(slot2, {
				id = slot7,
				co = slot8
			})
		end
	end

	slot0:setList(slot2)
end

slot0.instance = slot0.New()

return slot0
