module("modules.logic.fight.entity.comp.skill.FightTLEventPlayServerEffect", package.seeall)

local var_0_0 = class("FightTLEventPlayServerEffect", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._list = {}
	arg_1_0.fightStepData = arg_1_1

	if arg_1_3[1] == "1" then
		arg_1_0:_playEffect(FightEnum.EffectType.SUMMONEDDELETE)
	end

	if arg_1_3[2] == "1" then
		arg_1_0:_playEffect(FightEnum.EffectType.MAGICCIRCLEDELETE)
	end

	if arg_1_3[3] == "1" then
		arg_1_0:_playEffect(FightEnum.EffectType.MAGICCIRCLEADD)
	end

	if arg_1_3[4] == "1" then
		arg_1_0:_playEffect(FightEnum.EffectType.MOVE)
	end

	if arg_1_3[5] == "1" then
		arg_1_0:_playEffect(FightEnum.EffectType.MOVEFRONT)
	end

	if arg_1_3[6] == "1" then
		arg_1_0:_playEffect(FightEnum.EffectType.MOVEBACK)
	end

	if arg_1_3[7] == "1" then
		arg_1_0:_playEffect(FightEnum.EffectType.AVERAGELIFE)
	end

	if arg_1_3[8] == "1" then
		arg_1_0:_playEffect(FightEnum.EffectType.BUFFADD)
	end

	if arg_1_3[9] == "1" then
		arg_1_0:_playEffect(FightEnum.EffectType.BUFFDEL)
	end

	if not string.nilorempty(arg_1_3[10]) then
		for iter_1_0, iter_1_1 in ipairs(arg_1_0.fightStepData.actEffect) do
			if iter_1_1.effectType == FightEnum.EffectType.BUFFADD then
				local var_1_0 = iter_1_1.buff.buddId
				local var_1_1 = lua_skill_buff.configDict[var_1_0]
				local var_1_2 = var_1_1 and lua_skill_bufftype.configDict[var_1_1.typeId]

				if var_1_2 and var_1_2.type == tonumber(arg_1_3[10]) then
					local var_1_3 = FightWork2Work.New(FightStepBuilder.ActEffectWorkCls[FightEnum.EffectType.BUFFADD], arg_1_0.fightStepData, iter_1_1)

					var_1_3:onStart()
					table.insert(arg_1_0._list, var_1_3)
				end
			end
		end
	end

	if not string.nilorempty(arg_1_3[11]) then
		for iter_1_2, iter_1_3 in ipairs(arg_1_0.fightStepData.actEffect) do
			if iter_1_3.effectType == FightEnum.EffectType.BUFFDEL then
				local var_1_4 = iter_1_3.buff.buddId
				local var_1_5 = lua_skill_buff.configDict[var_1_4]
				local var_1_6 = var_1_5 and lua_skill_bufftype.configDict[var_1_5.typeId]

				if var_1_6 and var_1_6.type == tonumber(arg_1_3[11]) then
					local var_1_7 = FightWork2Work.New(FightStepBuilder.ActEffectWorkCls[FightEnum.EffectType.BUFFDEL], arg_1_0.fightStepData, iter_1_3)

					var_1_7:onStart()
					table.insert(arg_1_0._list, var_1_7)
				end
			end
		end
	end
end

function var_0_0._playEffect(arg_2_0, arg_2_1)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0.fightStepData.actEffect) do
		if iter_2_1.effectType == arg_2_1 then
			local var_2_0 = FightWork2Work.New(FightStepBuilder.ActEffectWorkCls[arg_2_1], arg_2_0.fightStepData, iter_2_1)

			var_2_0:onStart()
			table.insert(arg_2_0._list, var_2_0)
		end
	end
end

function var_0_0.onTrackEnd(arg_3_0)
	return
end

function var_0_0.onDestructor(arg_4_0)
	if arg_4_0._list then
		for iter_4_0, iter_4_1 in ipairs(arg_4_0._list) do
			iter_4_1:onStop()
		end

		arg_4_0._list = nil
	end
end

return var_0_0
