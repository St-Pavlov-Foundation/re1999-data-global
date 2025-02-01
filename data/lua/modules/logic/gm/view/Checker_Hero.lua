module("modules.logic.gm.view.Checker_Hero", package.seeall)

class("Checker_Hero", Checker_Base).Type = {
	Live2d = 1,
	Spine = 0
}
slot1 = {}
slot2 = {
	[ResUrl.getRolesPrefabStory(slot7.verticalDrawing)] = slot7.id
}

for slot6, slot7 in ipairs(lua_skin.configList) do
	slot9 = slot7.characterId

	if not string.nilorempty(slot7.verticalDrawing) then
		-- Nothing
	end

	if not string.nilorempty(slot7.live2d) then
		slot2[ResUrl.getLightLive2d(slot7.live2d)] = slot8
	end

	slot1[slot9] = slot1[slot9] or {}

	table.insert(slot1[slot9], slot7)
end

function slot3(slot0)
	return lua_character_voice.configDict[slot0]
end

function slot4(slot0, slot1)
	return uv0[slot0][slot1]
end

function slot5(slot0)
	return assert(tonumber(string.match(string.match(slot0, ".+/([^/]*%.%w+)$"), "(%w+)")), "invalid resPath: " .. slot0)
end

function slot6(slot0, slot1)
	if not slot0 or not slot1 then
		return false
	end

	if string.nilorempty(slot0.skins) then
		return false
	end

	return string.find(slot2, slot1)
end

function slot7(slot0)
	if slot0.class.__cname == "GuiSpine" or slot1 == "LightSpine" then
		return uv0.Type.Spine, slot0, slot0:getResPath()
	elseif slot1 == "GuiLive2d" or slot1 == "LightLive2d" then
		return uv0.Type.Live2d, slot0, slot0:getResPath()
	end
end

function slot8(slot0)
	if not slot0._curModel then
		return
	end

	return uv0(slot1)
end

function slot9(slot0)
	if not slot0 then
		return
	end

	if slot0.class.__cname ~= "GuiModelAgent" and false then
		-- Nothing
	end

	return uv0(slot0)

	if uv0(slot0) then
		return uv1(slot0)
	end
end

function slot0.ctor(slot0, slot1)
	Checker_Base.ctor(slot0)
	slot0:reset(slot1)
end

function slot0.reset(slot0, slot1)
	slot0._heroId = slot1
	slot0._heroCO = HeroConfig.instance:getHeroCO(slot1)
	slot0._resPath = ""
	slot0._skinId = false
end

function slot0._logError(slot0, slot1)
	return string.format("%s%s(%s)", slot1 or "", slot0:heroName(), tostring(slot0:heroId()))
end

function slot0.exec(slot0, slot1, slot2)
	if slot2 then
		slot0:reset(slot2)
	end

	slot3, slot4, slot0._resPath = uv0(slot1)

	if not slot3 or not slot4 then
		slot0:_logError("[_getInfoFromObj]: ")

		return
	end

	if slot3 == uv1.Type.Spine then
		slot0:_onExec_Spine(slot4)
	elseif slot3 == uv1.Type.Live2d then
		slot0:_onExec_Live2d(slot4)
	else
		assert(false, "unsupported Checker_Hero.Type!! type=" .. tostring(slot3))
	end
end

function slot0._onExec_Spine(slot0, slot1)
	assert(false, "please override this function!")
end

function slot0._onExec_Live2d(slot0, slot1)
	assert(false, "please override this function!")
end

function slot0.heroId(slot0)
	return slot0._heroId
end

function slot0.heroCO(slot0)
	return slot0._heroCO
end

function slot0.heroName(slot0)
	return slot0._heroCO.name
end

function slot0.resPath(slot0)
	return slot0._resPath
end

function slot0.skinId(slot0)
	assert(not string.nilorempty(slot0._resPath), "please call exec first!!")

	if not slot0._skinId then
		slot0._skinId = uv0[slot0._resPath] or uv1(slot0._resPath)
	end

	return slot0._skinId
end

function slot0.characterVoiceCO(slot0)
	return uv0(slot0._heroId)
end

function slot0.characterSkinCO(slot0)
	return uv0[slot0._heroId][slot0:skinId()]
end

function slot0.skincharacterVoiceCOList(slot0)
	return slot0:_skincharacterVoiceCOList(slot0:skinId())
end

function slot0.heroMO(slot0)
	return HeroModel.instance:getByHeroId(slot0._heroId)
end

function slot0.heroMOSkinId(slot0)
	if slot0:heroMO() then
		return slot1.skin
	end
end

function slot0.heroMOSkinCO(slot0)
	if slot0:heroMOSkinId() then
		return uv0[slot0._heroId][slot1]
	end
end

function slot0.heroMOSkincharacterVoiceCOList(slot0)
	return slot0:_skincharacterVoiceCOList(slot0:heroMOSkinId())
end

function slot0._skincharacterVoiceCOList(slot0, slot1)
	if not slot1 then
		return {}
	end

	for slot7, slot8 in pairs(slot0:characterVoiceCO()) do
		if uv0(slot8, slot1) then
			table.insert(slot2, slot8)
		end
	end

	return slot2
end

return slot0
