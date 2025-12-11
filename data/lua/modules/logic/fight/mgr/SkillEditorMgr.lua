module("modules.logic.fight.mgr.SkillEditorMgr", package.seeall)

local var_0_0 = class("SkillEditorMgr")

var_0_0.OnSelectEntity = 2020
var_0_0.ShowHeroSelectView = 2021
var_0_0.OnSubHeroEnter = 2022
var_0_0.OnSelectSkill = 2023
var_0_0.OnClickOutline = 2024
var_0_0.OnSelectStance = 2025
var_0_0._onSwitchEnityOrSkill = 2026
var_0_0._StopAutoPlayFlow1 = 2027
var_0_0._StopAutoPlayFlow2 = 2028
var_0_0._OpenAutoPlaySkin = 2029
var_0_0._SelectAutoPlaySkin = 2030
var_0_0.DefaultSceneLevelId = 10801
var_0_0.DefaultHeroId = 3023
var_0_0.DefaultMonsterId = 110401
var_0_0.SelectType = {
	Group = 3,
	Monster = 2,
	MonsterId = 5,
	Hero = 1,
	SubHero = 4
}

function var_0_0.start(arg_1_0)
	arg_1_0.inEditMode = true

	local var_1_0 = FightData.New(FightDef_pb.Fight())

	var_1_0.version = 999

	FightMgr.instance:startFight(var_1_0)
	arg_1_0:InitDefaultData()
	LuaEventSystem.addEventMechanism(arg_1_0)

	UnityEngine.Application.targetFrameRate = 60

	local var_1_1 = lua_scene_level.configList
	local var_1_2 = FightParam.New()
	local var_1_3 = arg_1_0:getSceneLevelId() or var_0_0.DefaultSceneLevelId

	var_1_2:setSceneLevel(var_1_3)
	FightModel.instance:setFightParam(var_1_2)
	arg_1_0:refreshInfo(FightEnum.EntitySide.MySide)
	arg_1_0:AddSubHeroModelData()
	arg_1_0:refreshInfo(FightEnum.EntitySide.EnemySide)
	GameSceneMgr.instance:registerCallback(SceneType.Fight, arg_1_0._onFightSceneStart, arg_1_0)
	FightController.instance:enterFightScene()
end

function var_0_0.InitDefaultData(arg_2_0)
	arg_2_0.stance_count_limit = 3
	arg_2_0.enemy_stance_count_limit = 3
	arg_2_0.stance_id = FightEnum.MySideDefaultStanceId
	arg_2_0.enemy_stance_id = FightEnum.EnemySideDefaultStanceId
	arg_2_0.cur_select_entity_id = nil
	arg_2_0.cur_select_side = FightEnum.EntitySide.MySide
end

function var_0_0.exit(arg_3_0)
	ViewMgr.instance:closeView(ViewName.SkillEditorView)
	ViewMgr.instance:closeView(ViewName.SkillEffectStatView)

	arg_3_0.inEditMode = false
end

function var_0_0._onFightSceneStart(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_2 == 1 then
		GameSceneMgr.instance:unregisterCallback(SceneType.Fight, arg_4_0._onFightSceneStart, arg_4_0)
		ViewMgr.instance:closeAllViews()
		ViewMgr.instance:openView(ViewName.SkillEditorView)
		ViewMgr.instance:openView(ViewName.SkillEffectStatView)
		MainController.instance:dispatchEvent(MainEvent.OnFirstEnterMain)
	end
end

function var_0_0.getSceneLevelId(arg_5_0)
	return PlayerPrefsHelper.getNumber(PlayerPrefsKey.SkillEditorSceneLevelId, nil)
end

function var_0_0.setSceneLevelId(arg_6_0, arg_6_1)
	PlayerPrefsHelper.setNumber(PlayerPrefsKey.SkillEditorSceneLevelId, arg_6_1)
end

function var_0_0.getTypeInfo(arg_7_0, arg_7_1)
	if not arg_7_0._saveTypeR then
		local var_7_0 = PlayerPrefsHelper.getString(PlayerPrefsKey.SkillEditorInfos)

		arg_7_0._saveTypeR = var_0_0.SelectType.Hero
		arg_7_0._saveInfoR = {}
		arg_7_0._saveTypeL = var_0_0.SelectType.Monster
		arg_7_0._saveInfoL = {}

		if string.nilorempty(var_7_0) then
			local var_7_1 = lua_character.configDict[var_0_0.DefaultHeroId]

			arg_7_0._saveInfoR.ids = {
				var_7_1.id
			}
			arg_7_0._saveInfoR.skinIds = {
				var_7_1.skinId
			}

			local var_7_2 = lua_monster.configDict[var_0_0.DefaultMonsterId]

			arg_7_0._saveInfoL.ids = {
				var_7_2.id
			}
			arg_7_0._saveInfoL.skinIds = {
				var_7_2.skinId
			}
		else
			local var_7_3 = string.split(var_7_0, "|")

			arg_7_0._saveTypeR = tonumber(var_7_3[1])

			local var_7_4 = string.split(var_7_3[2], "#")

			arg_7_0._saveInfoR.ids = string.splitToNumber(var_7_4[1], ":")
			arg_7_0._saveInfoR.skinIds = string.splitToNumber(var_7_4[2], ":")
			arg_7_0._saveInfoR.groupId = arg_7_0._saveTypeR == var_0_0.SelectType.Group and tonumber(var_7_4[3])
			arg_7_0._saveTypeL = tonumber(var_7_3[3])

			local var_7_5 = string.split(var_7_3[4], "#")

			arg_7_0._saveInfoL.ids = string.splitToNumber(var_7_5[1], ":")
			arg_7_0._saveInfoL.skinIds = string.splitToNumber(var_7_5[2], ":")
			arg_7_0._saveInfoL.groupId = arg_7_0._saveTypeL == var_0_0.SelectType.Group and tonumber(var_7_5[3])
		end

		arg_7_0.select_sub_hero_id = arg_7_0._saveInfoR.ids[1]
		arg_7_0.select_sub_hero_skin_id = arg_7_0._saveInfoR.skinIds[1]
	end

	if arg_7_1 == FightEnum.EntitySide.MySide then
		return arg_7_0._saveTypeR, arg_7_0._saveInfoR
	else
		return arg_7_0._saveTypeL, arg_7_0._saveInfoL
	end
end

function var_0_0.setTypeInfo(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	if arg_8_1 == FightEnum.EntitySide.MySide then
		arg_8_0._saveTypeR = arg_8_2
		arg_8_0._saveInfoR.ids = arg_8_3
		arg_8_0._saveInfoR.skinIds = arg_8_4
		arg_8_0._saveInfoR.groupId = arg_8_5
	else
		arg_8_0._saveTypeL = arg_8_2
		arg_8_0._saveInfoL.ids = arg_8_3
		arg_8_0._saveInfoL.skinIds = arg_8_4
		arg_8_0._saveInfoL.groupId = arg_8_5
	end

	local var_8_0 = table.concat(arg_8_0._saveInfoR.ids, ":") .. "#" .. table.concat(arg_8_0._saveInfoR.skinIds, ":")

	if arg_8_0._saveTypeR == var_0_0.SelectType.Group then
		var_8_0 = var_8_0 .. "#" .. arg_8_0._saveInfoR.groupId
	end

	local var_8_1 = table.concat(arg_8_0._saveInfoL.ids, ":") .. "#" .. table.concat(arg_8_0._saveInfoL.skinIds, ":")

	if arg_8_0._saveTypeL == var_0_0.SelectType.Group then
		var_8_1 = var_8_1 .. "#" .. arg_8_0._saveInfoL.groupId
	end

	local var_8_2 = string.format("%d|%s|%d|%s", arg_8_0._saveTypeR, var_8_0, arg_8_0._saveTypeL, var_8_1)

	PlayerPrefsHelper.setString(PlayerPrefsKey.SkillEditorInfos, var_8_2)
end

function var_0_0.refreshInfo(arg_9_0, arg_9_1)
	local var_9_0, var_9_1 = arg_9_0:getTypeInfo(arg_9_1)

	arg_9_0:setTypeInfo(arg_9_1, var_9_0, var_9_1.ids, var_9_1.skinIds, var_9_1.groupId)
	arg_9_0:setEntityMOs(arg_9_1, var_9_0, var_9_1.ids, var_9_1.skinIds)
end

function var_0_0.setEntityMOs(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	if arg_10_2 == var_0_0.SelectType.Hero then
		local var_10_0, var_10_1 = FightHelper.buildHeroEntityMOList(arg_10_1, arg_10_3, arg_10_4)

		FightDataHelper.entityMgr:clientTestSetEntity(arg_10_1, var_10_0, var_10_1)
	else
		local var_10_2, var_10_3 = FightHelper.buildMonsterEntityMOList(arg_10_1, arg_10_3)

		FightDataHelper.entityMgr:clientTestSetEntity(arg_10_1, var_10_2, var_10_3)
	end
end

function var_0_0.addSubHero(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = FightEnum.EntitySide.MySide
	local var_11_1, var_11_2 = arg_11_0:getTypeInfo(var_11_0)

	for iter_11_0, iter_11_1 in ipairs(var_11_2.ids) do
		if not lua_character.configDict[iter_11_1] then
			return
		end
	end

	arg_11_0.select_sub_hero_id = arg_11_1
	arg_11_0.select_sub_hero_skin_id = arg_11_2

	var_0_0.instance:rebuildEntitys(var_11_0)
	var_0_0.instance:dispatchEvent(var_0_0.OnSelectEntity, var_11_0)
end

function var_0_0.clearSubHero(arg_12_0)
	arg_12_0.select_sub_hero_id = nil
	arg_12_0.select_sub_hero_model = nil

	local var_12_0 = FightEnum.EntitySide.MySide

	arg_12_0:refreshInfo(var_12_0)
	var_0_0.instance:rebuildEntitys(var_12_0)
	var_0_0.instance:dispatchEvent(var_0_0.OnSelectEntity, var_12_0)
end

function var_0_0.rebuildEntitys(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1 == FightEnum.EntitySide.MySide and SceneTag.UnitPlayer or SceneTag.UnitMonster
	local var_13_1 = GameSceneMgr.instance:getCurScene().entityMgr
	local var_13_2 = var_13_1:getTagUnitDict(var_13_0)

	if var_13_2 then
		for iter_13_0, iter_13_1 in pairs(var_13_2) do
			if iter_13_1.skill then
				iter_13_1.skill:stopSkill()
			end

			FightController.instance:dispatchEvent(FightEvent.BeforeDeadEffect, iter_13_1.id)
		end
	end

	var_13_1:removeUnits(var_13_0)

	local var_13_3 = FightDataHelper.entityMgr:getNormalList(arg_13_1)

	for iter_13_2, iter_13_3 in ipairs(var_13_3) do
		var_13_1:buildSpine(iter_13_3)
	end

	if arg_13_1 == FightEnum.EntitySide.MySide and arg_13_0.select_sub_hero_id then
		arg_13_0:_buildSubHero()
	end
end

function var_0_0.AddSubHeroModelData(arg_14_0)
	if not arg_14_0.select_sub_hero_id then
		return
	end

	local var_14_0, var_14_1 = FightHelper.buildHeroEntityMOList(FightEnum.EntitySide.MySide, {}, {}, {
		arg_14_0.select_sub_hero_id
	}, {
		arg_14_0.select_sub_hero_skin_id
	})

	FightDataHelper.entityMgr:clientSetSubEntityList(FightEnum.EntitySide.MySide, var_14_1)

	arg_14_0.select_sub_hero_model = var_14_1[1]
end

function var_0_0._buildSubHero(arg_15_0)
	arg_15_0:AddSubHeroModelData()

	local var_15_0 = FightDataHelper.entityMgr:getMySubList()

	if var_15_0 then
		for iter_15_0, iter_15_1 in ipairs(var_15_0) do
			GameSceneMgr.instance:getCurScene().entityMgr:buildSubSpine(iter_15_1)
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
