module("modules.logic.scene.fight.comp.FightScenePreviewEntityMgr", package.seeall)

slot0 = class("FightScenePreviewEntityMgr", BaseSceneUnitMgr)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)

	slot0._containerGO = gohelper.findChild(slot0:getCurScene():getSceneContainerGO(), "Entitys")
end

function slot0.spawnEntity(slot0)
	return

	slot2 = "represent2"
	slot4 = FightModel.instance:getFightParam().episodeId and DungeonConfig.instance:getEpisodeCO(slot3)

	if slot4 and DungeonConfig.instance:getChapterCO(slot4.chapterId) and FightEnum.SpecialFaction[slot5.type] then
		slot2 = "represent1"
	end

	if string.nilorempty(lua_battle.configDict[slot1.battleId].monsterGroupIds) then
		return
	end

	slot9 = {}

	for slot14, slot15 in ipairs(string.splitToNumber(slot8, "#")) do
		slot16 = lua_monster_group.configDict[slot15]
		slot17 = slot16.bossId

		if not string.nilorempty(slot16.monster) then
			for slot23, slot24 in ipairs(string.splitToNumber(slot18, "#")) do
				if not lua_monster_skill_template.configDict[lua_monster.configDict[slot24].skillTemplate] then
					logError("怪物表技能模版不存在，怪物id = " .. slot25.id .. ", 模版id = " .. slot25.skillTemplate)
				end

				if not tonumber(slot26[slot2]) or slot27 <= 0 then
					slot27 = tonumber(slot26.represent2)
				end

				if slot27 and slot27 > 0 then
					if FightHelper.isBossId(slot17, slot24) then
						slot0:_spawnFactionEntity(slot27)

						return
					else
						slot9[slot27] = (slot9[slot27] or 0) + 1
					end
				end
			end
		end
	end

	slot12 = 0

	for slot16, slot17 in pairs(slot9) do
		if 0 < slot17 then
			slot11 = slot17
			slot12 = slot16
		elseif slot17 == slot11 and slot16 < slot12 then
			slot12 = slot16
		end
	end

	if slot12 > 0 then
		slot0:_spawnFactionEntity(slot12)
	end
end

function slot0._spawnFactionEntity(slot0, slot1)
	if not (FightEnum.FactionToSkin[slot1] and FightConfig.instance:getSkinCO(slot2)) then
		return
	end

	slot0:_buildTempSpineByName("preview", slot3, FightEnum.EntitySide.EnemySide)
end

function slot0.destroyEntity(slot0)
	slot0:removeAllUnits()
end

function slot0.onSceneClose(slot0)
	uv0.super.onSceneClose(slot0)
end

function slot0._buildTempSpineByName(slot0, slot1, slot2, slot3)
	slot5 = MonoHelper.addLuaComOnceToGo(gohelper.create3d(slot0._containerGO, slot1), FightEntityTemp, slot1)

	slot5:setSide(slot3)
	slot0:addUnit(slot5)
	slot5:loadSpineBySkin(slot2, slot0._onTempSpineLoaded, slot0)
	slot5.spine:changeLookDir(FightHelper.getSpineLookDir(slot3))
	slot5.spine:play(SpineAnimState.idle1, true, true)
	transformhelper.setLocalPos(slot5.go.transform, unpack(cjson.decode(CommonConfig.instance:getConstStr(ConstEnum.HeroGroupPreviewPos))))
	slot5:setSpeed(FightModel.instance:getSpeed())

	return slot5
end

function slot0._onTempSpineLoaded(slot0, slot1, slot2)
	if slot1 then
		GameSceneMgr.instance:getCurScene().bloom:addEntity(slot2)
		FightMsgMgr.sendMsg(FightMsgId.SpineLoadFinish, slot1)
		FightController.instance:dispatchEvent(FightEvent.OnSpineLoaded, slot1)
	end
end

return slot0
