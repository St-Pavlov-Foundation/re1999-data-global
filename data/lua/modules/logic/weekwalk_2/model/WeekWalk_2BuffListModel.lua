module("modules.logic.weekwalk_2.model.WeekWalk_2BuffListModel", package.seeall)

local var_0_0 = class("WeekWalk_2BuffListModel", ListScrollModel)

function var_0_0.getPrevBattleSkillId()
	local var_1_0 = WeekWalk_2Model.instance:getCurMapInfo()
	local var_1_1 = HeroGroupModel.instance.battleId
	local var_1_2 = var_1_0:getBattleInfoByBattleId(var_1_1)
	local var_1_3 = var_1_0:getBattleInfo(var_1_2.index - 1)

	return var_1_3 and var_1_3:getChooseSkillId()
end

function var_0_0.getCurHeroGroupSkillId()
	local var_2_0 = var_0_0._getCurHeroGroupSkillId()

	if var_2_0 then
		local var_2_1 = WeekWalk_2Model.instance:getCurMapInfo():getChooseSkillNum()
		local var_2_2 = WeekWalk_2Model.instance:getInfo():getOptionSkills()
		local var_2_3 = tabletool.indexOf(var_2_2, var_2_0)

		if not var_2_3 or var_2_1 < var_2_3 then
			var_2_0 = nil
		end
	end

	return var_2_0
end

function var_0_0._getCurHeroGroupSkillId()
	local var_3_0 = WeekWalk_2Model.instance:getInfo()
	local var_3_1 = var_3_0 and var_3_0:getHeroGroupSkill(HeroGroupModel.instance.curGroupSelectIndex)

	return var_3_1 ~= var_0_0.getPrevBattleSkillId() and var_3_1 or nil
end

function var_0_0.initBuffList(arg_4_0, arg_4_1)
	local var_4_0 = WeekWalk_2Model.instance:getTimeId()
	local var_4_1 = lua_weekwalk_ver2_time.configDict[var_4_0]
	local var_4_2 = string.split(var_4_1.optionalSkills, "#")
	local var_4_3 = #var_4_2

	if arg_4_1 then
		var_4_3 = WeekWalk_2Model.instance:getCurMapInfo():getChooseSkillNum()
	end

	local var_4_4 = {}

	for iter_4_0, iter_4_1 in ipairs(var_4_2) do
		local var_4_5 = tonumber(iter_4_1)

		if iter_4_0 <= var_4_3 then
			local var_4_6 = lua_weekwalk_ver2_skill.configDict[var_4_5]

			if var_4_6 then
				table.insert(var_4_4, var_4_6)
			end
		else
			break
		end
	end

	arg_4_0.prevBattleSkillId = nil
	arg_4_0.isBattle = arg_4_1

	local var_4_7 = 1

	if arg_4_1 then
		arg_4_0.prevBattleSkillId = var_0_0.getPrevBattleSkillId()

		local var_4_8 = var_0_0.getCurHeroGroupSkillId()

		if arg_4_0.prevBattleSkillId then
			for iter_4_2, iter_4_3 in ipairs(var_4_4) do
				if arg_4_0.prevBattleSkillId == iter_4_3.id then
					table.remove(var_4_4, iter_4_2)
					table.insert(var_4_4, iter_4_3)

					break
				end
			end
		end

		for iter_4_4, iter_4_5 in ipairs(var_4_4) do
			if var_4_8 == iter_4_5.id then
				var_4_7 = iter_4_4

				break
			end
		end
	end

	arg_4_0:setList(var_4_4)
	arg_4_0:selectCell(var_4_7, true)
end

var_0_0.instance = var_0_0.New()

return var_0_0
