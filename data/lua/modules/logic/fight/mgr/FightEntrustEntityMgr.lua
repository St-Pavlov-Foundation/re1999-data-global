module("modules.logic.fight.mgr.FightEntrustEntityMgr", package.seeall)

local var_0_0 = class("FightEntrustEntityMgr", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.entityDic = {}
	arg_1_0.entityVisible = {}
	arg_1_0.entityMgr = GameSceneMgr.instance:getCurScene().entityMgr

	arg_1_0:com_registFightEvent(FightEvent.EntrustTempEntity, arg_1_0._onEntrustTempEntity)
	arg_1_0:com_registFightEvent(FightEvent.OnRestartStageBefore, arg_1_0._onRestartStageBefore)
	arg_1_0:com_registFightEvent(FightEvent.OnSkillPlayStart, arg_1_0._onSkillPlayStart)
	arg_1_0:com_registFightEvent(FightEvent.OnSkillPlayFinish, arg_1_0._onSkillPlayFinish)
	arg_1_0:com_registFightEvent(FightEvent.OnCameraFocusChanged, arg_1_0._onCameraFocusChanged)
	arg_1_0:com_registFightEvent(FightEvent.ReleaseAllEntrustedEntity, arg_1_0._releaseAllEntity)
end

function var_0_0._onEntrustTempEntity(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.id

	if arg_2_0.entityDic[var_2_0] then
		arg_2_0:_releaseEntity(arg_2_0.entityDic[var_2_0])
	end

	arg_2_0.entityDic[var_2_0] = arg_2_1
	arg_2_0.entityVisible[var_2_0] = 0

	arg_2_1.spine:play(arg_2_1.spine._curAnimState, true)
end

function var_0_0._onSkillPlayStart(arg_3_0)
	for iter_3_0, iter_3_1 in pairs(arg_3_0.entityDic) do
		arg_3_0.entityVisible[iter_3_1.id] = (arg_3_0.entityVisible[iter_3_1.id] or 0) + 1

		iter_3_1:setVisibleByPos(false)
	end
end

function var_0_0._onSkillPlayFinish(arg_4_0)
	for iter_4_0, iter_4_1 in pairs(arg_4_0.entityDic) do
		if arg_4_0.entityVisible[iter_4_1.id] then
			arg_4_0.entityVisible[iter_4_1.id] = arg_4_0.entityVisible[iter_4_1.id] - 1

			if arg_4_0.entityVisible[iter_4_1.id] < 0 then
				arg_4_0.entityVisible[iter_4_1.id] = 0
			end
		end

		if arg_4_0.entityVisible[iter_4_1.id] == 0 then
			iter_4_1:setVisibleByPos(true)
			arg_4_0.entityMgr:adjustSpineLookRotation(iter_4_1)
		end
	end
end

function var_0_0._onCameraFocusChanged(arg_5_0, arg_5_1)
	if arg_5_1 then
		arg_5_0:_onSkillPlayStart()
	else
		arg_5_0:_onSkillPlayFinish()
	end
end

function var_0_0._releaseEntity(arg_6_0, arg_6_1)
	arg_6_0.entityMgr:removeUnit(arg_6_1:getTag(), arg_6_1.id)

	arg_6_0.entityDic[arg_6_1.id] = nil
	arg_6_0.entityVisible[arg_6_1.id] = nil
end

function var_0_0._releaseAllEntity(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0.entityDic) do
		arg_7_0:_releaseEntity(iter_7_1)
	end
end

function var_0_0._onRestartStageBefore(arg_8_0)
	arg_8_0:_releaseAllEntity()
end

function var_0_0.onDestructor(arg_9_0)
	arg_9_0:_releaseAllEntity()
end

return var_0_0
