module("modules.logic.fight.entity.comp.skill.FightTLEventBloomMaterial", package.seeall)

local var_0_0 = class("FightTLEventBloomMaterial", FightTimelineTrackItem)

function var_0_0.onTrackStart(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	local var_1_0 = arg_1_3[1]
	local var_1_1 = arg_1_3[2]

	if string.nilorempty(var_1_1) then
		return
	end

	arg_1_0._passNameList = string.split(var_1_1, "#")
	arg_1_0._targetEntitys = nil

	if var_1_0 == "1" then
		arg_1_0._targetEntitys = {}

		table.insert(arg_1_0._targetEntitys, FightHelper.getEntity(arg_1_1.fromId))
	elseif var_1_0 == "2" then
		arg_1_0._targetEntitys = FightHelper.getSkillTargetEntitys(arg_1_1)
	elseif var_1_0 == "3" then
		arg_1_0._targetEntitys = FightHelper.getSideEntitys(FightEnum.EntitySide.MySide, true)
	elseif var_1_0 == "4" then
		arg_1_0._targetEntitys = FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide, true)
	elseif var_1_0 == "5" then
		arg_1_0._targetEntitys = FightHelper.getAllEntitys()
	end

	arg_1_0:_setPassEnable(true)
end

function var_0_0.onTrackEnd(arg_2_0)
	arg_2_0:_clear()
end

function var_0_0._setPassEnable(arg_3_0, arg_3_1)
	local var_3_0 = GameSceneMgr.instance:getCurScene().bloom

	if arg_3_0._targetEntitys then
		for iter_3_0, iter_3_1 in ipairs(arg_3_0._targetEntitys) do
			for iter_3_2, iter_3_3 in ipairs(arg_3_0._passNameList) do
				var_3_0:setSingleEntityPass(iter_3_3, arg_3_1, iter_3_1, "timeline_bloom")
			end
		end
	end
end

function var_0_0._clear(arg_4_0)
	arg_4_0:_setPassEnable(false)

	arg_4_0._targetEntitys = nil
end

function var_0_0.onDestructor(arg_5_0)
	arg_5_0:_clear()
end

return var_0_0
