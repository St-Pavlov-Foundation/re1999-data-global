module("modules.logic.fight.view.preview.SkillEditorToolAutoPlaySkillModel", package.seeall)

local var_0_0 = class("SkillEditorToolAutoPlaySkillModel", ListScrollModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._selectList = {}
end

function var_0_0.setSelect(arg_2_0, arg_2_1)
	arg_2_0:_buildCOList()

	local var_2_0 = {}

	for iter_2_0, iter_2_1 in pairs(arg_2_0._dataList) do
		if iter_2_0 ~= SkillEditorMgr.SelectType.Group then
			for iter_2_2, iter_2_3 in ipairs(iter_2_1) do
				if string.find(tostring(iter_2_3.id), arg_2_1) or string.find(tostring(iter_2_3.skinId), arg_2_1) or string.find(iter_2_3.name or "", arg_2_1) or string.find(FightConfig.instance:getSkinCO(iter_2_3.skinId) and FightConfig.instance:getSkinCO(iter_2_3.skinId).name or "", arg_2_1) then
					local var_2_1 = {
						co = iter_2_3,
						type = iter_2_0,
						skinId = iter_2_3.skinId
					}

					table.insert(var_2_0, var_2_1)
				end
			end
		else
			for iter_2_4, iter_2_5 in ipairs(iter_2_1) do
				arg_2_0:_cacheGroupNames()

				local var_2_2 = arg_2_0._groupId2NameDict[iter_2_5.id]

				if var_2_2 and string.find(var_2_2, arg_2_1) then
					local var_2_3 = {
						co = iter_2_5,
						type = iter_2_0,
						skinId = iter_2_5.skinId
					}

					table.insert(var_2_0, var_2_3)
				end
			end
		end
	end

	arg_2_0:setList(var_2_0)
end

function var_0_0._buildCOList(arg_3_0)
	arg_3_0._dataList = {}
	arg_3_0._dataList[SkillEditorMgr.SelectType.Hero] = arg_3_0._dataList[SkillEditorMgr.SelectType.Hero] or {}

	tabletool.addValues(arg_3_0._dataList[SkillEditorMgr.SelectType.Hero], lua_character.configList)

	local var_3_0 = {}
	local var_3_1 = {}

	for iter_3_0, iter_3_1 in ipairs(lua_monster.configList) do
		if not var_3_0[iter_3_1.skinId] then
			var_3_0[iter_3_1.skinId] = true

			table.insert(var_3_1, iter_3_1)
		end
	end

	arg_3_0._dataList[SkillEditorMgr.SelectType.Monster] = arg_3_0._dataList[SkillEditorMgr.SelectType.Monster] or {}
	arg_3_0._dataList[SkillEditorMgr.SelectType.Group] = arg_3_0._dataList[SkillEditorMgr.SelectType.Group] or {}

	tabletool.addValues(arg_3_0._dataList[SkillEditorMgr.SelectType.Monster], var_3_1)
	tabletool.addValues(arg_3_0._dataList[SkillEditorMgr.SelectType.Group], lua_monster_group.configList)
	arg_3_0:_cacheGroupNames()
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

function var_0_0.addSelect(arg_5_0, arg_5_1)
	local var_5_0 = tabletool.indexOf(arg_5_0._selectList, arg_5_1)

	if var_5_0 then
		arg_5_0._list[var_5_0] = arg_5_1
	else
		table.insert(arg_5_0._selectList, arg_5_1)
	end
end

function var_0_0.removeSelect(arg_6_0, arg_6_1)
	tabletool.removeValue(arg_6_0._selectList, arg_6_1)
end

function var_0_0.getSelectList(arg_7_0)
	return arg_7_0._selectList
end

var_0_0.instance = var_0_0.New()

return var_0_0
