module("modules.logic.player.view.PlayerBgComp", package.seeall)

slot0 = class("PlayerBgComp", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._gobg = gohelper.findChild(slot1, "#go_bg")
	slot0._gospine = gohelper.findChild(slot1, "#go_spine")
	slot0._gospine2 = gohelper.findChild(slot1, "dynamiccontainer/#go_spine")
	slot0._black = gohelper.findChild(slot1, "#go_black")
	slot0._uiSpine = GuiSpine.Create(slot0._gospine, true)
	slot0._uiSpine2 = GuiModelAgent.Create(slot0._gospine2, true)
	slot0._bgLoader = PrefabInstantiate.Create(slot0._gobg)
end

function slot0.showBg(slot0, slot1)
	slot0._bgCo = slot1

	slot0:_loadSpine()

	if slot0._bgLoader:getPath() ~= string.format("ui/viewres/player/bg/%s.prefab", slot1.bgEffect) then
		slot0._bgLoader:dispose()
		slot0._bgLoader:startLoad(slot3)
	end

	gohelper.setActive(slot0._black, slot1.item ~= 0)
end

function slot0.setPlayerInfo(slot0, slot1, slot2)
	slot0._otherPlayerInfo = slot1
	slot0._otherPlayerHeroCover = slot2
end

function slot0._loadSpine(slot0)
	gohelper.setActive(slot0._gospine, slot0._bgCo.item == 0)
	gohelper.setActive(slot0._gospine2, slot0._bgCo.item ~= 0)

	if slot0._bgCo.item == 0 then
		if slot0._uiSpine:getResPath() ~= ResUrl.getRolesCgStory(CommonConfig.instance:getConstStr(ConstEnum.PlayerViewSpine)) then
			slot0._uiSpine:setResPath(slot2, slot0._onSpineLoaded, slot0)
		end
	else
		slot1 = nil

		if slot0._otherPlayerHeroCover then
			slot2 = string.splitToNumber(slot0._otherPlayerHeroCover, "#")

			if not lua_skin.configDict[slot2[2]] then
				slot1 = lua_skin[(lua_character.configDict[slot2[1]] or lua_character.configDict[3028]).skinId]
			end
		else
			slot2, slot3 = CharacterSwitchListModel.instance:getMainHero()
			slot4 = HeroModel.instance:getByHeroId(slot2)
			slot1 = SkinConfig.instance:getSkinCo(slot3 or slot4 and slot4.skin)
		end

		if slot1 == slot0._nowSkinCo then
			return
		end

		slot0._nowSkinCo = slot1

		slot0._uiSpine2:setResPath(slot1, slot0._onSpineLoaded2, slot0)

		slot2 = SkinConfig.instance:getSkinOffset(slot1.characterViewOffset)

		recthelper.setAnchor(slot0._gospine2.transform, tonumber(slot2[1]), tonumber(slot2[2]))
		transformhelper.setLocalScale(slot0._gospine2.transform, tonumber(slot2[3]), tonumber(slot2[3]), tonumber(slot2[3]))
	end
end

function slot0._onSpineLoaded(slot0)
	slot0._uiSpine:changeLookDir(SpineLookDir.Left)

	slot1 = slot0._otherPlayerInfo or PlayerModel.instance:getPlayinfo()

	if CommonConfig.instance:getConstNum(ConstEnum.PlayerViewEyeEpisodeId) == slot1.lastEpisodeId or DungeonConfig.instance:isPreEpisodeList(slot2, slot1.lastEpisodeId) then
		slot0._uiSpine:SetAnimation(BaseSpine.FaceTrackIndex, "b_idle", true, 0)
	else
		slot0._uiSpine:SetAnimation(BaseSpine.FaceTrackIndex, "b_idle_1", true, 0)
	end
end

function slot0._onSpineLoaded2(slot0)
	slot0._uiSpine2:setModelVisible(true)
end

function slot0.onDestroy(slot0)
	if slot0._uiSpine then
		gohelper.destroy(slot0._gospine)

		slot0._gospine = nil
		slot0._uiSpine = nil
	end

	if slot0._bgLoader then
		slot0._bgLoader:dispose()

		slot0._bgLoader = nil
	end
end

return slot0
