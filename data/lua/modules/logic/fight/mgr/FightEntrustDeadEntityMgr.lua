module("modules.logic.fight.mgr.FightEntrustDeadEntityMgr", package.seeall)

local var_0_0 = class("FightEntrustDeadEntityMgr", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.entityDic = {}
	arg_1_0.entityVisible = {}
	arg_1_0.entityMgr = GameSceneMgr.instance:getCurScene().entityMgr

	arg_1_0:com_registFightEvent(FightEvent.EntrustEntity, arg_1_0._onEntrustEntity)
	arg_1_0:com_registFightEvent(FightEvent.OnRestartStageBefore, arg_1_0._onRestartStageBefore)
	arg_1_0:com_registFightEvent(FightEvent.OnSkillPlayStart, arg_1_0._onSkillPlayStart)
	arg_1_0:com_registFightEvent(FightEvent.OnSkillPlayFinish, arg_1_0._onSkillPlayFinish)
	arg_1_0:com_registFightEvent(FightEvent.OnCameraFocusChanged, arg_1_0._onCameraFocusChanged)
	arg_1_0:com_registFightEvent(FightEvent.ReleaseAllEntrustedEntity, arg_1_0._releaseAllEntity)
	arg_1_0:com_registMsg(FightMsgId.GetDeadEntityMgr, arg_1_0.onGetDeadEntityMgr)
end

function var_0_0.onGetDeadEntityMgr(arg_2_0)
	arg_2_0:com_replyMsg(FightMsgId.GetDeadEntityMgr, arg_2_0)
end

function var_0_0._onEntrustEntity(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1.id

	if arg_3_0.entityDic[var_3_0] then
		arg_3_0:_releaseEntity(arg_3_0.entityDic[var_3_0])
	end

	arg_3_0.entityDic[var_3_0] = arg_3_1
	arg_3_0.entityVisible[var_3_0] = 0

	local var_3_1 = arg_3_1:getMO()
	local var_3_2 = lua_fight_dead_entity_mgr.configDict[var_3_1.skin]

	arg_3_1.spine:play(var_3_2.loopActName, true, true)

	ZProj.TransformListener.Get(arg_3_1.go).enabled = false
end

local var_0_1 = {
	["670403_die"] = true
}

function var_0_0._onSkillPlayStart(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	if var_0_1[arg_4_4] then
		return
	end

	for iter_4_0, iter_4_1 in pairs(arg_4_0.entityDic) do
		arg_4_0.entityVisible[iter_4_1.id] = (arg_4_0.entityVisible[iter_4_1.id] or 0) + 1

		iter_4_1:setVisibleByPos(false)
	end
end

function var_0_0._onSkillPlayFinish(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.entityDic) do
		if arg_5_0.entityVisible[iter_5_1.id] then
			arg_5_0.entityVisible[iter_5_1.id] = arg_5_0.entityVisible[iter_5_1.id] - 1

			if arg_5_0.entityVisible[iter_5_1.id] < 0 then
				arg_5_0.entityVisible[iter_5_1.id] = 0
			end
		end

		if arg_5_0.entityVisible[iter_5_1.id] == 0 then
			iter_5_1:setVisibleByPos(true)
			arg_5_0.entityMgr:adjustSpineLookRotation(iter_5_1)
		end
	end
end

function var_0_0._onCameraFocusChanged(arg_6_0, arg_6_1)
	if arg_6_1 then
		arg_6_0:_onSkillPlayStart()
	else
		arg_6_0:_onSkillPlayFinish()
	end
end

function var_0_0._releaseEntity(arg_7_0, arg_7_1)
	arg_7_0.entityMgr:destroyUnit(arg_7_1)

	arg_7_0.entityDic[arg_7_1.id] = nil
	arg_7_0.entityVisible[arg_7_1.id] = nil
end

function var_0_0._releaseAllEntity(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.entityDic) do
		arg_8_0:_releaseEntity(iter_8_1)
	end
end

function var_0_0._onRestartStageBefore(arg_9_0)
	arg_9_0:_releaseAllEntity()
end

function var_0_0.onDestructor(arg_10_0)
	arg_10_0:_releaseAllEntity()
end

return var_0_0
