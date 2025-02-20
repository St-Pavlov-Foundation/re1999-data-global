module("modules.logic.fight.mgr.SkillEditorMgr", package.seeall)

slot0 = class("SkillEditorMgr")
slot0.OnSelectEntity = 2020
slot0.ShowHeroSelectView = 2021
slot0.OnSubHeroEnter = 2022
slot0.OnSelectSkill = 2023
slot0.OnClickOutline = 2024
slot0.OnSelectStance = 2025
slot0._onSwitchEnityOrSkill = 2026
slot0._StopAutoPlayFlow1 = 2027
slot0._StopAutoPlayFlow2 = 2028
slot0._OpenAutoPlaySkin = 2029
slot0._SelectAutoPlaySkin = 2030
slot0.DefaultSceneLevelId = 10801
slot0.DefaultHeroId = 3023
slot0.DefaultMonsterId = 110401
slot0.SelectType = {
	Group = 3,
	Hero = 1,
	Monster = 2,
	SubHero = 4
}

function slot0.start(slot0)
	slot0.inEditMode = true

	FightMgr.instance:startFight()
	slot0:InitDefaultData()
	LuaEventSystem.addEventMechanism(slot0)

	UnityEngine.Application.targetFrameRate = 60
	slot1 = lua_scene_level.configList
	slot2 = FightParam.New()

	slot2:setSceneLevel(slot0:getSceneLevelId() or uv0.DefaultSceneLevelId)
	FightModel.instance:setFightParam(slot2)
	slot0:refreshInfo(FightEnum.EntitySide.MySide)
	slot0:AddSubHeroModelData()
	slot0:refreshInfo(FightEnum.EntitySide.EnemySide)
	GameSceneMgr.instance:registerCallback(SceneType.Fight, slot0._onFightSceneStart, slot0)
	FightController.instance:enterFightScene()
end

function slot0.InitDefaultData(slot0)
	slot0.stance_count_limit = 3
	slot0.enemy_stance_count_limit = 3
	slot0.stance_id = FightEnum.MySideDefaultStanceId
	slot0.enemy_stance_id = FightEnum.EnemySideDefaultStanceId
	slot0.cur_select_entity_id = nil
	slot0.cur_select_side = FightEnum.EntitySide.MySide
end

function slot0.exit(slot0)
	ViewMgr.instance:closeView(ViewName.SkillEditorView)
	ViewMgr.instance:closeView(ViewName.SkillEffectStatView)

	slot0.inEditMode = false
end

function slot0._onFightSceneStart(slot0, slot1, slot2)
	if slot2 == 1 then
		GameSceneMgr.instance:unregisterCallback(SceneType.Fight, slot0._onFightSceneStart, slot0)
		ViewMgr.instance:closeAllViews()
		ViewMgr.instance:openView(ViewName.SkillEditorView)
		ViewMgr.instance:openView(ViewName.SkillEffectStatView)
		MainController.instance:dispatchEvent(MainEvent.OnFirstEnterMain)
	end
end

function slot0.getSceneLevelId(slot0)
	return PlayerPrefsHelper.getNumber(PlayerPrefsKey.SkillEditorSceneLevelId, nil)
end

function slot0.setSceneLevelId(slot0, slot1)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SkillEditorSceneLevelId, slot1)
end

function slot0.getTypeInfo(slot0, slot1)
	if not slot0._saveTypeR then
		slot0._saveTypeR = uv0.SelectType.Hero
		slot0._saveInfoR = {}
		slot0._saveTypeL = uv0.SelectType.Monster
		slot0._saveInfoL = {}

		if string.nilorempty(PlayerPrefsHelper.getString(PlayerPrefsKey.SkillEditorInfos)) then
			slot3 = lua_character.configDict[uv0.DefaultHeroId]
			slot0._saveInfoR.ids = {
				slot3.id
			}
			slot0._saveInfoR.skinIds = {
				slot3.skinId
			}
			slot4 = lua_monster.configDict[uv0.DefaultMonsterId]
			slot0._saveInfoL.ids = {
				slot4.id
			}
			slot0._saveInfoL.skinIds = {
				slot4.skinId
			}
		else
			slot3 = string.split(slot2, "|")
			slot0._saveTypeR = tonumber(slot3[1])
			slot4 = string.split(slot3[2], "#")
			slot0._saveInfoR.ids = string.splitToNumber(slot4[1], ":")
			slot0._saveInfoR.skinIds = string.splitToNumber(slot4[2], ":")
			slot0._saveInfoR.groupId = slot0._saveTypeR == uv0.SelectType.Group and tonumber(slot4[3])
			slot0._saveTypeL = tonumber(slot3[3])
			slot5 = string.split(slot3[4], "#")
			slot0._saveInfoL.ids = string.splitToNumber(slot5[1], ":")
			slot0._saveInfoL.skinIds = string.splitToNumber(slot5[2], ":")
			slot0._saveInfoL.groupId = slot0._saveTypeL == uv0.SelectType.Group and tonumber(slot5[3])
		end

		slot0.select_sub_hero_id = slot0._saveInfoR.ids[1]
		slot0.select_sub_hero_skin_id = slot0._saveInfoR.skinIds[1]
	end

	if slot1 == FightEnum.EntitySide.MySide then
		return slot0._saveTypeR, slot0._saveInfoR
	else
		return slot0._saveTypeL, slot0._saveInfoL
	end
end

function slot0.setTypeInfo(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot1 == FightEnum.EntitySide.MySide then
		slot0._saveTypeR = slot2
		slot0._saveInfoR.ids = slot3
		slot0._saveInfoR.skinIds = slot4
		slot0._saveInfoR.groupId = slot5
	else
		slot0._saveTypeL = slot2
		slot0._saveInfoL.ids = slot3
		slot0._saveInfoL.skinIds = slot4
		slot0._saveInfoL.groupId = slot5
	end

	if slot0._saveTypeR == uv0.SelectType.Group then
		slot6 = table.concat(slot0._saveInfoR.ids, ":") .. "#" .. table.concat(slot0._saveInfoR.skinIds, ":") .. "#" .. slot0._saveInfoR.groupId
	end

	if slot0._saveTypeL == uv0.SelectType.Group then
		slot7 = table.concat(slot0._saveInfoL.ids, ":") .. "#" .. table.concat(slot0._saveInfoL.skinIds, ":") .. "#" .. slot0._saveInfoL.groupId
	end

	PlayerPrefsHelper.setString(PlayerPrefsKey.SkillEditorInfos, string.format("%d|%s|%d|%s", slot0._saveTypeR, slot6, slot0._saveTypeL, slot7))
end

function slot0.refreshInfo(slot0, slot1)
	slot2, slot3 = slot0:getTypeInfo(slot1)

	slot0:setTypeInfo(slot1, slot2, slot3.ids, slot3.skinIds, slot3.groupId)
	slot0:setEntityMOs(slot1, slot2, slot3.ids, slot3.skinIds)
end

function slot0.setEntityMOs(slot0, slot1, slot2, slot3, slot4)
	if slot2 == uv0.SelectType.Hero then
		slot5, slot6 = FightHelper.buildHeroEntityMOList(slot1, slot3, slot4)

		FightDataHelper.entityMgr:clientTestSetEntity(slot1, slot5, slot6)
	else
		slot5, slot6 = FightHelper.buildMonsterEntityMOList(slot1, slot3)

		FightDataHelper.entityMgr:clientTestSetEntity(slot1, slot5, slot6)
	end
end

function slot0.addSubHero(slot0, slot1, slot2)
	slot4, slot5 = slot0:getTypeInfo(FightEnum.EntitySide.MySide)

	for slot9, slot10 in ipairs(slot5.ids) do
		if not lua_character.configDict[slot10] then
			return
		end
	end

	slot0.select_sub_hero_id = slot1
	slot0.select_sub_hero_skin_id = slot2

	uv0.instance:rebuildEntitys(slot3)
	uv0.instance:dispatchEvent(uv0.OnSelectEntity, slot3)
end

function slot0.clearSubHero(slot0)
	slot0.select_sub_hero_id = nil
	slot0.select_sub_hero_model = nil
	slot1 = FightEnum.EntitySide.MySide

	slot0:refreshInfo(slot1)
	uv0.instance:rebuildEntitys(slot1)
	uv0.instance:dispatchEvent(uv0.OnSelectEntity, slot1)
end

function slot0.rebuildEntitys(slot0, slot1)
	if GameSceneMgr.instance:getCurScene().entityMgr:getTagUnitDict(slot1 == FightEnum.EntitySide.MySide and SceneTag.UnitPlayer or SceneTag.UnitMonster) then
		for slot8, slot9 in pairs(slot4) do
			if slot9.skill then
				slot9.skill:stopSkill()
			end

			FightController.instance:dispatchEvent(FightEvent.BeforeDeadEffect, slot9.id)
		end
	end

	slot3:removeUnits(slot2)

	for slot9, slot10 in ipairs(FightDataHelper.entityMgr:getNormalList(slot1)) do
		slot3:buildSpine(slot10)
	end

	if slot1 == FightEnum.EntitySide.MySide and slot0.select_sub_hero_id then
		slot0:_buildSubHero()
	end
end

function slot0.AddSubHeroModelData(slot0)
	if not slot0.select_sub_hero_id then
		return
	end

	slot1, slot2 = FightHelper.buildHeroEntityMOList(FightEnum.EntitySide.MySide, {}, {}, {
		slot0.select_sub_hero_id
	}, {
		slot0.select_sub_hero_skin_id
	})

	FightDataHelper.entityMgr:clientSetSubEntityList(FightEnum.EntitySide.MySide, slot2)

	slot0.select_sub_hero_model = slot2[1]
end

function slot0._buildSubHero(slot0)
	slot0:AddSubHeroModelData()

	if FightDataHelper.entityMgr:getMySubList() then
		for slot5, slot6 in ipairs(slot1) do
			GameSceneMgr.instance:getCurScene().entityMgr:buildSubSpine(slot6)
		end
	end
end

slot0.instance = slot0.New()

return slot0
