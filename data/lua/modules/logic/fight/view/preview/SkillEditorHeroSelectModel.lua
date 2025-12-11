module("modules.logic.fight.view.preview.SkillEditorHeroSelectModel", package.seeall)

local var_0_0 = class("SkillEditorHeroSelectModel", ListScrollModel)

function var_0_0.setSelect(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.side = arg_1_1
	arg_1_0.selectType = arg_1_2
	arg_1_0.stancePosId = arg_1_3

	local var_1_0 = arg_1_0:_getCOList()
	local var_1_1 = {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		if string.find(tostring(iter_1_1.id), arg_1_4) or string.find(tostring(iter_1_1.skinId), arg_1_4) or string.find(iter_1_1.name or "", arg_1_4) or string.find(FightConfig.instance:getSkinCO(iter_1_1.skinId) and FightConfig.instance:getSkinCO(iter_1_1.skinId).name or "", arg_1_4) then
			local var_1_2 = {
				id = iter_1_0,
				co = iter_1_1
			}

			table.insert(var_1_1, var_1_2)
		elseif arg_1_0.selectType == SkillEditorMgr.SelectType.Group then
			arg_1_0:_cacheGroupNames()

			local var_1_3 = arg_1_0._groupId2NameDict[iter_1_1.id]

			if var_1_3 and string.find(var_1_3, arg_1_4) then
				local var_1_4 = {
					id = iter_1_0,
					co = iter_1_1
				}

				table.insert(var_1_1, var_1_4)
			end
		end
	end

	arg_1_0:setList(var_1_1)
end

function var_0_0._getCOList(arg_2_0)
	if arg_2_0.selectType == SkillEditorMgr.SelectType.Hero then
		return lua_character.configList
	elseif arg_2_0.selectType == SkillEditorMgr.SelectType.SubHero then
		return lua_character.configList
	elseif arg_2_0.selectType == SkillEditorMgr.SelectType.Monster then
		local var_2_0 = {}
		local var_2_1 = {}

		for iter_2_0, iter_2_1 in ipairs(lua_monster.configList) do
			if not var_2_0[iter_2_1.skinId] then
				var_2_0[iter_2_1.skinId] = {}
			end

			if not string.nilorempty(iter_2_1.activeSkill) then
				table.insert(var_2_0[iter_2_1.skinId], 1, iter_2_1)
			else
				table.insert(var_2_0[iter_2_1.skinId], iter_2_1)
			end
		end

		for iter_2_2, iter_2_3 in pairs(var_2_0) do
			table.insert(var_2_1, iter_2_3[1])
		end

		table.sort(var_2_1, function(arg_3_0, arg_3_1)
			return arg_3_0.skinId < arg_3_1.skinId
		end)

		return var_2_1
	elseif arg_2_0.selectType == SkillEditorMgr.SelectType.Group then
		arg_2_0:_cacheGroupNames()

		return lua_monster_group.configList
	elseif arg_2_0.selectType == SkillEditorMgr.SelectType.MonsterId then
		return lua_monster.configList
	end
end

function var_0_0._cacheGroupNames(arg_4_0)
	if arg_4_0._groupId2NameDict then
		return
	end

	arg_4_0._groupId2NameDict = {}

	for iter_4_0, iter_4_1 in ipairs(lua_monster_group.configList) do
		local var_4_0 = string.splitToNumber(iter_4_1.monster, "#")
		local var_4_1 = lua_monster.configDict[var_4_0[1]]

		for iter_4_2 = 2, #var_4_0 do
			if tabletool.indexOf(string.splitToNumber(iter_4_1.bossId, "#"), var_4_0[iter_4_2]) then
				var_4_1 = lua_monster.configDict[var_4_0[iter_4_2]]

				break
			end
		end

		arg_4_0._groupId2NameDict[iter_4_1.id] = var_4_1 and var_4_1.name
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
