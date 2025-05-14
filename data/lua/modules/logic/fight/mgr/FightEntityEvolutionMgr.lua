module("modules.logic.fight.mgr.FightEntityEvolutionMgr", package.seeall)

local var_0_0 = class("FightEntityEvolutionMgr", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0._entityDic = {}
	arg_1_0._entityVisible = {}
	arg_1_0._skinId2Entity = {}
	arg_1_0._skinIds = {}
	arg_1_0._delayReleaseEntity = {}
	arg_1_0._entityMgr = GameSceneMgr.instance:getCurScene().entityMgr

	arg_1_0:com_registMsg(FightMsgId.SetBossEvolution, arg_1_0._onSetBossEvolution)
	arg_1_0:com_registMsg(FightMsgId.PlayTimelineSkill, arg_1_0._onPlayTimelineSkill)
	arg_1_0:com_registMsg(FightMsgId.PlayTimelineSkillFinish, arg_1_0._onPlayTimelineSkillFinish)
	arg_1_0:com_registMsg(FightMsgId.CameraFocusChanged, arg_1_0._onCameraFocusChanged)
	arg_1_0:com_registMsg(FightMsgId.ReleaseAllEntrustedEntity, arg_1_0._onReleaseAllEntrustedEntity)
	arg_1_0:com_registMsg(FightMsgId.SpineLoadFinish, arg_1_0._onSpineLoadFinish)
	arg_1_0:com_registMsg(FightMsgId.IsEvolutionSkin, arg_1_0._onIsEvolutionSkin)
	arg_1_0:com_registFightEvent(FightEvent.BeforeDestroyEntity, arg_1_0._onBeforeDestroyEntity)
end

function var_0_0._onBeforeDestroyEntity(arg_2_0, arg_2_1)
	if arg_2_0._entityDic[arg_2_1.id] == arg_2_1 then
		arg_2_0:_releaseEntity(arg_2_1)

		for iter_2_0, iter_2_1 in ipairs(arg_2_0._delayReleaseEntity) do
			if iter_2_1.entity == arg_2_1 then
				arg_2_0._entityVisible[arg_2_1.id] = 0

				table.remove(arg_2_0._delayReleaseEntity, iter_2_0)
			end
		end
	end
end

function var_0_0._onIsEvolutionSkin(arg_3_0, arg_3_1)
	FightMsgMgr.replyMsg(FightMsgId.IsEvolutionSkin, arg_3_0._skinIds[arg_3_1])
end

function var_0_0._onSetBossEvolution(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_1.id

	if arg_4_0._entityDic[var_4_0] and arg_4_1 ~= arg_4_0._entityDic[var_4_0] then
		arg_4_0:_releaseEntity(arg_4_0._entityDic[var_4_0])
	end

	arg_4_0._entityDic[var_4_0] = arg_4_1
	arg_4_0._entityVisible[var_4_0] = 0

	arg_4_1.spine:play(arg_4_1.spine._curAnimState, true)

	arg_4_0._skinId2Entity[arg_4_2] = arg_4_0._skinId2Entity[arg_4_2] or {}

	table.insert(arg_4_0._skinId2Entity[arg_4_2], arg_4_1)

	arg_4_0._skinIds[arg_4_2] = true
end

function var_0_0._onSpineLoadFinish(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.unitSpawn
	local var_5_1 = var_5_0 and var_5_0:getMO()

	if var_5_1 and arg_5_0._skinId2Entity[var_5_1.skin] then
		for iter_5_0, iter_5_1 in ipairs(arg_5_0._skinId2Entity[var_5_1.skin]) do
			local var_5_2 = iter_5_1.spine
			local var_5_3 = var_5_2 and var_5_2._skeletonAnim and var_5_2._skeletonAnim.state:GetCurrent(0)

			if var_5_3 and arg_5_1._skeletonAnim then
				arg_5_1._skeletonAnim:Jump2Time(var_5_3.TrackTime)
			end

			local var_5_4 = {
				entity = iter_5_1
			}
			local var_5_5 = arg_5_1:getSpineGO()

			var_5_4.spineGO = var_5_5

			transformhelper.setLocalPos(var_5_5.transform, -10000, 0, 0)
			table.insert(arg_5_0._delayReleaseEntity, var_5_4)
		end

		arg_5_0:com_registTimer(arg_5_0._delayRelease, 0.01)

		arg_5_0._skinId2Entity[var_5_1.skin] = nil
	end
end

function var_0_0._delayRelease(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0._delayReleaseEntity) do
		arg_6_0:_releaseEntity(iter_6_1.entity)
		transformhelper.setLocalPos(iter_6_1.spineGO.transform, 0, 0, 0)
	end

	arg_6_0._delayReleaseEntity = {}
end

function var_0_0._onPlayTimelineSkill(arg_7_0)
	for iter_7_0, iter_7_1 in pairs(arg_7_0._entityDic) do
		if not iter_7_1.IS_REMOVED then
			arg_7_0._entityVisible[iter_7_1.id] = (arg_7_0._entityVisible[iter_7_1.id] or 0) + 1

			iter_7_1:setAlpha(0, 0.2)
		end
	end
end

function var_0_0._onPlayTimelineSkillFinish(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0._entityDic) do
		if arg_8_0._entityVisible[iter_8_1.id] then
			arg_8_0._entityVisible[iter_8_1.id] = arg_8_0._entityVisible[iter_8_1.id] - 1

			if arg_8_0._entityVisible[iter_8_1.id] < 0 then
				arg_8_0._entityVisible[iter_8_1.id] = 0
			end
		end

		if arg_8_0._entityVisible[iter_8_1.id] == 0 then
			iter_8_1:setAlpha(1, 0.2)
			arg_8_0._entityMgr:adjustSpineLookRotation(iter_8_1)
		end
	end
end

function var_0_0._onCameraFocusChanged(arg_9_0, arg_9_1)
	if arg_9_1 then
		arg_9_0:_onPlayTimelineSkill()
	else
		arg_9_0:_onPlayTimelineSkillFinish()
	end
end

function var_0_0._releaseEntity(arg_10_0, arg_10_1)
	if arg_10_0._entityDic[arg_10_1.id] then
		arg_10_0._entityMgr:destroyUnit(arg_10_1)

		arg_10_0._entityDic[arg_10_1.id] = nil
		arg_10_0._entityVisible[arg_10_1.id] = nil
	end
end

function var_0_0._releaseAllEntity(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0._entityDic) do
		arg_11_0:_releaseEntity(iter_11_1)
	end

	arg_11_0._skinId2Entity = {}
	arg_11_0._skinIds = {}
	arg_11_0._delayReleaseEntity = {}
end

function var_0_0._onReleaseAllEntrustedEntity(arg_12_0)
	arg_12_0:_releaseAllEntity()
end

function var_0_0.onDestructor(arg_13_0)
	arg_13_0:_releaseAllEntity()
end

return var_0_0
