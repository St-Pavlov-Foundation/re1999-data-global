module("modules.logic.fight.entity.comp.specialeffect.FightEntitySpecialEffect3070_Ball", package.seeall)

local var_0_0 = class("FightEntitySpecialEffect3070_Ball", FightEntitySpecialEffectBase)

function var_0_0.initClass(arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.SetBuffEffectVisible, arg_1_0._onSetBuffEffectVisible, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, arg_1_0._onBuffUpdate, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.OnSkillPlayStart, arg_1_0._onSkillPlayStart, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, arg_1_0._onSkillPlayFinish, arg_1_0, LuaEventSystem.High)
	arg_1_0:addEventCb(FightController.instance, FightEvent.BeforeEnterStepBehaviour, arg_1_0._onBeforeEnterStepBehaviour, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.BeforeDeadEffect, arg_1_0._onBeforeDeadEffect, arg_1_0)

	arg_1_0._ballEffectList = {}
	arg_1_0._ballEffectUid = {}
	arg_1_0._buffUid2Effect = arg_1_0:getUserDataTb_()
	arg_1_0._ballDestroyPath = {}
	arg_1_0._ballLine = {}
	arg_1_0._uid2BallTween = {}
end

var_0_0.BallPositionLimit3 = {
	{
		0.54,
		0.39,
		0
	},
	{
		-0.75,
		1.64,
		0
	},
	{
		0.7,
		2.45,
		0
	}
}
var_0_0.BallPositionLimit4 = {
	{
		0.54,
		0.39,
		0
	},
	{
		-0.75,
		1.64,
		0
	},
	{
		1.05,
		1.53,
		0
	},
	{
		0.7,
		2.45,
		0
	}
}

local var_0_1 = "default"
local var_0_2 = {
	{
		[var_0_1] = {
			"v1a3_jialabona/jianabona_bd_r_01",
			"v1a3_jialabona/jianabona_bd_01",
			"v1a3_jialabona/jianabona_bd_r_02"
		},
		[307003] = {
			"v2a0_jialabona/jialabona_bd_r_01",
			"v2a0_jialabona/jialabona_bd_01",
			"v2a0_jialabona/jialabona_bd_r_02"
		}
	},
	{
		[var_0_1] = {
			"v1a3_jialabona/jianabona_bd_h_01",
			"v1a3_jialabona/jianabona_bd_01",
			"v1a3_jialabona/jianabona_bd_h_02"
		},
		[307003] = {
			"v2a0_jialabona/jialabona_bd_h_01",
			"v2a0_jialabona/jialabona_bd_01",
			"v2a0_jialabona/jialabona_bd_h_02"
		}
	},
	{
		[var_0_1] = {
			"v1a3_jialabona/jianabona_bd_b_01",
			"v1a3_jialabona/jianabona_bd_01",
			"v1a3_jialabona/jianabona_bd_b_02"
		},
		[307003] = {
			"v2a0_jialabona/jialabona_bd_b_01",
			"v2a0_jialabona/jialabona_bd_01",
			"v2a0_jialabona/jialabona_bd_b_02"
		}
	}
}
local var_0_3 = {
	[307003] = "v2a0_jialabona/jialabona_bd_x_01",
	[var_0_1] = "v1a3_jialabona/jianabona_bd_x_01"
}
local var_0_4 = {
	[var_0_1] = {
		destroy = 4307043,
		create = 4307041,
		move = 4307042
	},
	[307003] = {
		destroy = 430700343,
		create = 430700341,
		move = 430700342
	}
}
local var_0_5 = 4.5
local var_0_6 = 0.25
local var_0_7 = 0
local var_0_8 = 0.1
local var_0_9 = 0
local var_0_10 = 0.8

var_0_0.buffTypeId2EffectPath = {
	[307001211] = var_0_2[1],
	[307001212] = var_0_2[1],
	[307001111] = var_0_2[2],
	[307001112] = var_0_2[2],
	[307001311] = var_0_2[3],
	[307001312] = var_0_2[3]
}

local var_0_11 = Vector3.Distance(Vector3.New(-1.2, 1, 0), Vector3.zero) * 1.1
local var_0_12 = 1

function var_0_0._getPosArr(arg_2_0)
	return arg_2_0._ballPosition
end

function var_0_0._initPosArr(arg_3_0, arg_3_1)
	if not arg_3_0._ballPosition then
		local var_3_0 = lua_skill_buff.configDict[arg_3_1]
		local var_3_1 = lua_skill_bufftype.configDict[var_3_0.typeId]
		local var_3_2 = string.split(var_3_1.includeTypes, "#")[2]

		arg_3_0._ballPosition = LuaUtil.deepCopy(var_0_0["BallPositionLimit" .. var_3_2])

		if arg_3_0._entity:isEnemySide() then
			for iter_3_0, iter_3_1 in ipairs(arg_3_0._ballPosition) do
				arg_3_0._ballPosition[iter_3_0][1] = -arg_3_0._ballPosition[iter_3_0][1]
			end
		end

		return arg_3_0._ballPosition
	end
end

function var_0_0._getFirstPos(arg_4_0)
	if arg_4_0._firstPos then
		return arg_4_0._firstPos
	end

	arg_4_0._firstPos = Vector3.New(arg_4_0:_getPosArr()[1][1], arg_4_0:_getPosArr()[1][2], arg_4_0:_getPosArr()[1][3])

	return arg_4_0._firstPos
end

function var_0_0._ballShowEffect(arg_5_0)
	if arg_5_0._showEffectWrap then
		arg_5_0._showEffectWrap:setActive(false)
		arg_5_0._showEffectWrap:setActive(true)
	else
		arg_5_0._showEffectWrap = arg_5_0._entity.effect:addGlobalEffect(arg_5_0._curEffectPath[2])

		FightRenderOrderMgr.instance:onAddEffectWrap(arg_5_0._entity.id, arg_5_0._showEffectWrap)
		arg_5_0._showEffectWrap:setEffectScale(var_0_10)
	end

	local var_5_0, var_5_1, var_5_2 = FightHelper.getEntityStandPos(arg_5_0._entity:getMO())

	arg_5_0._showEffectWrap:setLocalPos(var_5_0 + arg_5_0:_getPosArr()[1][1], var_5_1 + arg_5_0:_getPosArr()[1][2], var_5_2 + arg_5_0:_getPosArr()[1][3])
end

function var_0_0._ballDestroyEffect(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0._entity.effect:addGlobalEffect(arg_6_1, nil, var_0_12)
	local var_6_1 = arg_6_0._buffUid2Effect[arg_6_2]
	local var_6_2, var_6_3, var_6_4 = transformhelper.getPos(var_6_1.containerTr)

	var_6_0:setWorldPos(var_6_2, var_6_3, var_6_4)
	var_6_0:setEffectScale(var_0_10)
	FightRenderOrderMgr.instance:onAddEffectWrap(arg_6_0._entity.id, var_6_0)
end

function var_0_0._hideBallLineEffect(arg_7_0)
	for iter_7_0, iter_7_1 in ipairs(arg_7_0._ballLine) do
		arg_7_0._ballLine[iter_7_0]:setActive(false, "FightEntitySpecialEffect3070_Ball_ball")
	end
end

function var_0_0._createNewBallLine(arg_8_0)
	local var_8_0 = arg_8_0._entity:getMO()

	for iter_8_0, iter_8_1 in ipairs(arg_8_0._ballEffectList) do
		if not arg_8_0._ballLine[iter_8_0] then
			local var_8_1 = arg_8_0:_getPosArr()[iter_8_0]
			local var_8_2 = arg_8_0:_getPosArr()[iter_8_0 + 1]
			local var_8_3 = var_8_0 and var_0_3[var_8_0.skin] or var_0_3[var_0_1]
			local var_8_4 = arg_8_0._entity.effect:addHangEffect(var_8_3, ModuleEnum.SpineHangPointRoot, nil, nil, arg_8_0:_getFirstPos())

			arg_8_0._ballLine[iter_8_0] = var_8_4

			if iter_8_0 == 1 then
				FightRenderOrderMgr.instance:onAddEffectWrap(arg_8_0._entity.id, var_8_4)
			else
				var_8_4:setRenderOrder(FightRenderOrderMgr.MinSpecialOrder * FightEnum.OrderRegion + 9)
			end

			if var_8_2 then
				local var_8_5 = Vector3.Distance(Vector3.New(var_8_1[1], var_8_1[2], var_8_1[3]), Vector3.New(var_8_2[1], var_8_2[2], var_8_2[3]))

				transformhelper.setLocalScale(var_8_4.containerTr, var_8_5 / var_0_11, 1, 1)
			end
		end
	end
end

function var_0_0._showBallLineEffect(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0._ballEffectList) do
		local var_9_0 = arg_9_0:_getPosArr()[iter_9_0]
		local var_9_1 = arg_9_0:_getPosArr()[iter_9_0 + 1]
		local var_9_2 = arg_9_0._ballLine[iter_9_0]

		if arg_9_0._ballEffectList[iter_9_0 + 1] then
			var_9_2:setActive(true, "FightEntitySpecialEffect3070_Ball_ball")

			local var_9_3 = var_9_1[1] - var_9_0[1]
			local var_9_4 = var_9_1[2] - var_9_0[2]
			local var_9_5 = var_9_1[3] - var_9_0[3]

			var_9_2:setLocalPos(var_9_0[1] + var_9_3 / 2, var_9_0[2] + var_9_4 / 2, var_9_0[3] + var_9_5 / 2)

			local var_9_6 = Vector3.New(var_9_3, var_9_4, 0)
			local var_9_7 = Quaternion.FromToRotation(Vector3.left, var_9_6).eulerAngles.z

			transformhelper.setLocalRotation(var_9_2.containerTr, 0, 0, var_9_7)
		else
			var_9_2:setActive(false, "FightEntitySpecialEffect3070_Ball_ball")
		end
	end
end

function var_0_0._createNewball(arg_10_0)
	local var_10_0 = arg_10_0._entity.effect:addHangEffect(arg_10_0._curEffectPath[1], ModuleEnum.SpineHangPointRoot, nil, nil, arg_10_0:_getFirstPos())
	local var_10_1 = arg_10_0:_getFirstPos()

	var_10_0:setLocalPos(var_10_1.x, var_10_1.y, var_10_1.z)
	FightRenderOrderMgr.instance:onAddEffectWrap(arg_10_0._entity.id, var_10_0)
	table.insert(arg_10_0._ballEffectList, 1, var_10_0)
	table.insert(arg_10_0._ballEffectUid, 1, arg_10_0._curBuffUid)

	arg_10_0._buffUid2Effect[arg_10_0._curBuffUid] = var_10_0
	arg_10_0._ballDestroyPath[var_10_0.uniqueId] = arg_10_0._curEffectPath[3]

	var_10_0:setEffectScale(var_0_10)

	local var_10_2 = arg_10_0._entity:getMO()
	local var_10_3 = var_10_2 and var_0_4[var_10_2.skin] or var_0_4[var_0_1]

	FightAudioMgr.instance:playAudio(var_10_3.create)

	return var_10_0
end

function var_0_0._showNewball(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(arg_11_0._ballEffectList) do
		iter_11_1:setActive(true, "FightEntitySpecialEffect3070_Ball_NewBall")
	end
end

function var_0_0._onBuffUpdate(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	if arg_12_1 ~= arg_12_0._entity.id then
		return
	end

	local var_12_0 = lua_skill_buff.configDict[arg_12_3]
	local var_12_1 = var_0_0.buffTypeId2EffectPath[var_12_0.typeId]

	if var_12_1 then
		local var_12_2 = arg_12_0._entity:getMO()

		var_12_1 = var_12_2 and var_12_1[var_12_2.skin] or var_12_1[var_0_1]

		if arg_12_2 == FightEnum.EffectType.BUFFADD then
			arg_12_0._curBuffUid = arg_12_4
			arg_12_0._curEffectPath = var_12_1

			arg_12_0:_initPosArr(arg_12_3)
			arg_12_0:_releaseBallTween()

			arg_12_0._newBall = arg_12_0:_createNewball()

			arg_12_0._newBall:setActive(false, "FightEntitySpecialEffect3070_Ball_NewBall")
			arg_12_0:_createNewBallLine()

			arg_12_0._aniFlow = FlowSequence.New()

			arg_12_0._aniFlow:addWork(FunctionWork.New(arg_12_0._hideBallLineEffect, arg_12_0))

			if arg_12_0._resetPlayingDestroyEffect then
				arg_12_0._aniFlow:addWork(WorkWaitSeconds.New(var_0_6 / FightModel.instance:getSpeed()))
			end

			arg_12_0._resetPlayingDestroyEffect = nil

			arg_12_0._aniFlow:addWork(WorkWaitSeconds.New(var_0_7 / FightModel.instance:getSpeed()))
			arg_12_0._aniFlow:addWork(FunctionWork.New(arg_12_0._ballShowEffect, arg_12_0))
			arg_12_0._aniFlow:addWork(FunctionWork.New(arg_12_0._showNewball, arg_12_0))
			arg_12_0._aniFlow:addWork(WorkWaitSeconds.New(var_0_8 / FightModel.instance:getSpeed()))

			local var_12_3 = FlowParallel.New()

			for iter_12_0 = 1, #arg_12_0._ballEffectList do
				local var_12_4 = arg_12_0._ballEffectList[iter_12_0]

				if var_12_4 and iter_12_0 > 1 then
					local var_12_5 = arg_12_0:_getPosArr()[iter_12_0]
					local var_12_6 = var_12_4.containerTr
					local var_12_7, var_12_8 = transformhelper.getLocalPos(var_12_6)
					local var_12_9 = Mathf.Sqrt(Mathf.Pow(var_12_7 - var_12_5[1], 2) + Mathf.Pow(var_12_8 - var_12_5[2], 2)) / var_0_5 / FightModel.instance:getSpeed()
					local var_12_10 = arg_12_0._ballEffectUid[iter_12_0]

					arg_12_0._uid2BallTween[var_12_10] = arg_12_0._uid2BallTween[var_12_10] or {}

					local var_12_11 = arg_12_0:getUserDataTb_()

					var_12_11.transform = var_12_6
					var_12_11.flyTime = var_12_9
					var_12_11.x = var_12_5[1]
					var_12_11.y = var_12_5[2]
					var_12_11.index = iter_12_0
					var_12_11.effectWrap = var_12_4

					table.insert(arg_12_0._uid2BallTween[var_12_10], var_12_11)
				end
			end

			for iter_12_1, iter_12_2 in pairs(arg_12_0._uid2BallTween) do
				local var_12_12 = FlowSequence.New()

				for iter_12_3, iter_12_4 in ipairs(iter_12_2) do
					local var_12_13 = FlowParallel.New()
					local var_12_14 = arg_12_0:getUserDataTb_()

					table.insert(var_12_14, iter_12_4.effectWrap)
					table.insert(var_12_14, iter_12_4.index)
					var_12_13:addWork(FunctionWork.New(arg_12_0._refreshBallOrder, arg_12_0, var_12_14))
					var_12_13:addWork(TweenWork.New({
						type = "DOLocalMoveX",
						tr = iter_12_4.transform,
						to = iter_12_4.x,
						t = iter_12_4.flyTime,
						ease = EaseType.OutQuart
					}))
					var_12_13:addWork(TweenWork.New({
						type = "DOLocalMoveY",
						tr = iter_12_4.transform,
						to = iter_12_4.y,
						t = iter_12_4.flyTime,
						ease = EaseType.OutQuart
					}))
					var_12_12:addWork(var_12_13)
				end

				var_12_3:addWork(var_12_12)
			end

			arg_12_0._aniFlow:addWork(var_12_3)
			arg_12_0._aniFlow:addWork(WorkWaitSeconds.New(var_0_9 / FightModel.instance:getSpeed()))
			arg_12_0._aniFlow:addWork(FunctionWork.New(arg_12_0._showBallLineEffect, arg_12_0))
			arg_12_0._aniFlow:addWork(FunctionWork.New(arg_12_0._clearBallTweenData, arg_12_0))
			arg_12_0._aniFlow:start()
		elseif arg_12_2 == FightEnum.EffectType.BUFFDEL then
			for iter_12_5 = #arg_12_0._ballEffectUid, 1, -1 do
				if arg_12_0._ballEffectUid[iter_12_5] == arg_12_4 then
					arg_12_0._uid2BallTween[arg_12_4] = nil

					local var_12_15 = table.remove(arg_12_0._ballEffectList, iter_12_5)

					table.remove(arg_12_0._ballEffectUid, iter_12_5)
					arg_12_0._entity.effect:removeEffect(var_12_15)
					arg_12_0:_ballDestroyEffect(arg_12_0._ballDestroyPath[var_12_15.uniqueId], arg_12_4)

					arg_12_0._playingDestroyEffect = true

					TaskDispatcher.runDelay(arg_12_0._resetPlayingDestroyEffect, arg_12_0, 0.3)

					local var_12_16 = var_12_2 and var_0_4[var_12_2.skin] or var_0_4[var_0_1]

					FightAudioMgr.instance:playAudio(var_12_16.destroy)

					break
				end
			end
		end
	end
end

function var_0_0._refreshBallOrder(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1[1]
	local var_13_1 = arg_13_1[2]

	FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_13_0._entity.id, var_13_0)

	if var_13_1 <= 2 then
		FightRenderOrderMgr.instance:onAddEffectWrap(arg_13_0._entity.id, var_13_0)
	else
		var_13_0:setRenderOrder(FightRenderOrderMgr.MinSpecialOrder * FightEnum.OrderRegion + 10)
	end
end

function var_0_0._clearBallTweenData(arg_14_0)
	arg_14_0._uid2BallTween = {}
end

function var_0_0._resetPlayingDestroyEffect(arg_15_0)
	arg_15_0._playingDestroyEffect = nil
end

function var_0_0._onBeforeEnterStepBehaviour(arg_16_0)
	local var_16_0 = arg_16_0._entity:getMO()

	if var_16_0 then
		local var_16_1 = var_16_0:getBuffDic()

		for iter_16_0, iter_16_1 in pairs(var_16_1) do
			arg_16_0:_onBuffUpdate(arg_16_0._entity.id, FightEnum.EffectType.BUFFADD, iter_16_1.buffId, iter_16_1.uid)
		end
	end
end

function var_0_0._onSetBuffEffectVisible(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if arg_17_0._entity.id == arg_17_1 then
		if arg_17_0._ballEffectList then
			for iter_17_0, iter_17_1 in ipairs(arg_17_0._ballEffectList) do
				iter_17_1:setActive(arg_17_2, arg_17_3 or "FightEntitySpecialEffect3070_Ball")
			end
		end

		if arg_17_0._ballLine then
			for iter_17_2, iter_17_3 in ipairs(arg_17_0._ballLine) do
				iter_17_3:setActive(arg_17_2, arg_17_3 or "FightEntitySpecialEffect3070_Ball")
			end
		end
	end
end

function var_0_0._playMoveAudio(arg_18_0)
	if tabletool.len(arg_18_0._uid2BallTween) > 0 then
		local var_18_0 = arg_18_0._entity:getMO()
		local var_18_1 = var_18_0 and var_0_4[var_18_0.skin] or var_0_4[var_0_1]

		FightAudioMgr.instance:playAudio(var_18_1.move)
	end
end

function var_0_0._onSkillPlayStart(arg_19_0, arg_19_1)
	arg_19_0:_onSetBuffEffectVisible(arg_19_1.id, false, "FightEntitySpecialEffect3070_Ball_PlaySkill")
end

function var_0_0._onSkillPlayFinish(arg_20_0, arg_20_1)
	arg_20_0:_onSetBuffEffectVisible(arg_20_1.id, true, "FightEntitySpecialEffect3070_Ball_PlaySkill")
end

function var_0_0._releaseBallTween(arg_21_0)
	if arg_21_0._aniFlow then
		arg_21_0._aniFlow:stop()

		arg_21_0._aniFlow = nil
	end
end

function var_0_0._releaseBallEffect(arg_22_0)
	if arg_22_0._ballEffectList then
		for iter_22_0, iter_22_1 in pairs(arg_22_0._ballEffectList) do
			arg_22_0._entity.effect:removeEffect(iter_22_1)
			FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_22_0._entity.id, iter_22_1)
		end
	end

	arg_22_0._ballEffectList = nil
	arg_22_0._ballEffectUid = nil

	if arg_22_0._showEffectWrap then
		arg_22_0._entity.effect:removeEffect(arg_22_0._showEffectWrap)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_22_0._entity.id, arg_22_0._showEffectWrap)

		arg_22_0._showEffectWrap = nil
	end
end

function var_0_0._releaseBallLineEffect(arg_23_0)
	if arg_23_0._ballLine then
		for iter_23_0, iter_23_1 in pairs(arg_23_0._ballLine) do
			arg_23_0._entity.effect:removeEffect(iter_23_1)
			FightRenderOrderMgr.instance:onRemoveEffectWrap(arg_23_0._entity.id, iter_23_1)
		end
	end

	arg_23_0._ballLine = nil
end

function var_0_0._onBeforeDeadEffect(arg_24_0, arg_24_1)
	if arg_24_1 == arg_24_0._entity.id then
		arg_24_0:_releaseEffect()
	end
end

function var_0_0._releaseEffect(arg_25_0)
	arg_25_0:_releaseBallTween()
	arg_25_0:_releaseBallEffect()
	arg_25_0:_releaseBallLineEffect()
end

function var_0_0.releaseSelf(arg_26_0)
	TaskDispatcher.cancelTask(arg_26_0._resetPlayingDestroyEffect, arg_26_0)
	arg_26_0:_releaseEffect()
end

return var_0_0
