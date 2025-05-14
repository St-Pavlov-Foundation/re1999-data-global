module("modules.logic.scene.fight.comp.FightScenePreviewEntityMgr", package.seeall)

local var_0_0 = class("FightScenePreviewEntityMgr", BaseSceneUnitMgr)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)

	arg_1_0._containerGO = gohelper.findChild(arg_1_0:getCurScene():getSceneContainerGO(), "Entitys")
end

function var_0_0.spawnEntity(arg_2_0)
	do return end

	local var_2_0 = FightModel.instance:getFightParam()
	local var_2_1 = "represent2"
	local var_2_2 = var_2_0.episodeId
	local var_2_3 = var_2_2 and DungeonConfig.instance:getEpisodeCO(var_2_2)
	local var_2_4 = var_2_3 and DungeonConfig.instance:getChapterCO(var_2_3.chapterId)

	if var_2_4 and FightEnum.SpecialFaction[var_2_4.type] then
		var_2_1 = "represent1"
	end

	local var_2_5 = var_2_0.battleId
	local var_2_6 = lua_battle.configDict[var_2_5].monsterGroupIds

	if string.nilorempty(var_2_6) then
		return
	end

	local var_2_7 = {}
	local var_2_8 = string.splitToNumber(var_2_6, "#")

	for iter_2_0, iter_2_1 in ipairs(var_2_8) do
		local var_2_9 = lua_monster_group.configDict[iter_2_1]
		local var_2_10 = var_2_9.bossId
		local var_2_11 = var_2_9.monster

		if not string.nilorempty(var_2_11) then
			local var_2_12 = string.splitToNumber(var_2_11, "#")

			for iter_2_2, iter_2_3 in ipairs(var_2_12) do
				local var_2_13 = lua_monster.configDict[iter_2_3]
				local var_2_14 = lua_monster_skill_template.configDict[var_2_13.skillTemplate]

				if not var_2_14 then
					logError("怪物表技能模版不存在，怪物id = " .. var_2_13.id .. ", 模版id = " .. var_2_13.skillTemplate)
				end

				local var_2_15 = tonumber(var_2_14[var_2_1])

				if not var_2_15 or var_2_15 <= 0 then
					var_2_15 = tonumber(var_2_14.represent2)
				end

				if var_2_15 and var_2_15 > 0 then
					if FightHelper.isBossId(var_2_10, iter_2_3) then
						arg_2_0:_spawnFactionEntity(var_2_15)

						return
					else
						var_2_7[var_2_15] = (var_2_7[var_2_15] or 0) + 1
					end
				end
			end
		end
	end

	local var_2_16 = 0
	local var_2_17 = 0

	for iter_2_4, iter_2_5 in pairs(var_2_7) do
		if var_2_16 < iter_2_5 then
			var_2_16 = iter_2_5
			var_2_17 = iter_2_4
		elseif iter_2_5 == var_2_16 and iter_2_4 < var_2_17 then
			var_2_17 = iter_2_4
		end
	end

	if var_2_17 > 0 then
		arg_2_0:_spawnFactionEntity(var_2_17)
	end
end

function var_0_0._spawnFactionEntity(arg_3_0, arg_3_1)
	local var_3_0 = FightEnum.FactionToSkin[arg_3_1]
	local var_3_1 = var_3_0 and FightConfig.instance:getSkinCO(var_3_0)

	if not var_3_1 then
		return
	end

	arg_3_0:_buildTempSpineByName("preview", var_3_1, FightEnum.EntitySide.EnemySide)
end

function var_0_0.destroyEntity(arg_4_0)
	arg_4_0:removeAllUnits()
end

function var_0_0.onSceneClose(arg_5_0)
	var_0_0.super.onSceneClose(arg_5_0)
end

function var_0_0._buildTempSpineByName(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = gohelper.create3d(arg_6_0._containerGO, arg_6_1)
	local var_6_1 = MonoHelper.addLuaComOnceToGo(var_6_0, FightEntityTemp, arg_6_1)
	local var_6_2 = FightHelper.getSpineLookDir(arg_6_3)

	var_6_1:setSide(arg_6_3)
	arg_6_0:addUnit(var_6_1)
	var_6_1:loadSpineBySkin(arg_6_2, arg_6_0._onTempSpineLoaded, arg_6_0)
	var_6_1.spine:changeLookDir(var_6_2)

	local var_6_3 = SpineAnimState.idle1

	var_6_1.spine:play(var_6_3, true, true)

	local var_6_4 = CommonConfig.instance:getConstStr(ConstEnum.HeroGroupPreviewPos)
	local var_6_5 = cjson.decode(var_6_4)

	transformhelper.setLocalPos(var_6_1.go.transform, unpack(var_6_5))
	var_6_1:setSpeed(FightModel.instance:getSpeed())

	return var_6_1
end

function var_0_0._onTempSpineLoaded(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 then
		GameSceneMgr.instance:getCurScene().bloom:addEntity(arg_7_2)
		FightMsgMgr.sendMsg(FightMsgId.SpineLoadFinish, arg_7_1)
		FightController.instance:dispatchEvent(FightEvent.OnSpineLoaded, arg_7_1)
	end
end

return var_0_0
