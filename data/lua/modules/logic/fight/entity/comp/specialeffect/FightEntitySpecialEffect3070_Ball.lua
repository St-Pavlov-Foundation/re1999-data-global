module("modules.logic.fight.entity.comp.specialeffect.FightEntitySpecialEffect3070_Ball", package.seeall)

slot0 = class("FightEntitySpecialEffect3070_Ball", FightEntitySpecialEffectBase)

function slot0.initClass(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.SetBuffEffectVisible, slot0._onSetBuffEffectVisible, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, slot0._onBuffUpdate, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0, LuaEventSystem.High)
	slot0:addEventCb(FightController.instance, FightEvent.BeforeEnterStepBehaviour, slot0._onBeforeEnterStepBehaviour, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.BeforeDeadEffect, slot0._onBeforeDeadEffect, slot0)

	slot0._ballEffectList = {}
	slot0._ballEffectUid = {}
	slot0._buffUid2Effect = slot0:getUserDataTb_()
	slot0._ballDestroyPath = {}
	slot0._ballLine = {}
	slot0._uid2BallTween = {}
end

slot0.BallPositionLimit3 = {
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
slot0.BallPositionLimit4 = {
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
slot1 = "default"
slot2 = {
	{
		[slot1] = {
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
		[slot1] = {
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
		[slot1] = {
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
slot3 = {
	[307003.0] = "v2a0_jialabona/jialabona_bd_x_01",
	[slot1] = "v1a3_jialabona/jianabona_bd_x_01"
}
slot4 = {
	[slot1] = {
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
slot5 = 4.5
slot6 = 0.25
slot7 = 0
slot8 = 0.1
slot9 = 0
slot10 = 0.8
slot0.buffTypeId2EffectPath = {
	[307001211] = slot2[1],
	[307001212] = slot2[1],
	[307001111] = slot2[2],
	[307001112] = slot2[2],
	[307001311] = slot2[3],
	[307001312] = slot2[3]
}
slot11 = Vector3.Distance(Vector3.New(-1.2, 1, 0), Vector3.zero) * 1.1
slot12 = 1

function slot0._getPosArr(slot0)
	return slot0._ballPosition
end

function slot0._initPosArr(slot0, slot1)
	if not slot0._ballPosition then
		slot0._ballPosition = LuaUtil.deepCopy(uv0["BallPositionLimit" .. string.split(lua_skill_bufftype.configDict[lua_skill_buff.configDict[slot1].typeId].includeTypes, "#")[2]])

		if slot0._entity:isEnemySide() then
			for slot8, slot9 in ipairs(slot0._ballPosition) do
				slot0._ballPosition[slot8][1] = -slot0._ballPosition[slot8][1]
			end
		end

		return slot0._ballPosition
	end
end

function slot0._getFirstPos(slot0)
	if slot0._firstPos then
		return slot0._firstPos
	end

	slot0._firstPos = Vector3.New(slot0:_getPosArr()[1][1], slot0:_getPosArr()[1][2], slot0:_getPosArr()[1][3])

	return slot0._firstPos
end

function slot0._ballShowEffect(slot0)
	if slot0._showEffectWrap then
		slot0._showEffectWrap:setActive(false)
		slot0._showEffectWrap:setActive(true)
	else
		slot0._showEffectWrap = slot0._entity.effect:addGlobalEffect(slot0._curEffectPath[2])

		FightRenderOrderMgr.instance:onAddEffectWrap(slot0._entity.id, slot0._showEffectWrap)
		slot0._showEffectWrap:setEffectScale(uv0)
	end

	slot1, slot2, slot3 = FightHelper.getEntityStandPos(slot0._entity:getMO())

	slot0._showEffectWrap:setLocalPos(slot1 + slot0:_getPosArr()[1][1], slot2 + slot0:_getPosArr()[1][2], slot3 + slot0:_getPosArr()[1][3])
end

function slot0._ballDestroyEffect(slot0, slot1, slot2)
	slot3 = slot0._entity.effect:addGlobalEffect(slot1, nil, uv0)
	slot5, slot6, slot7 = transformhelper.getPos(slot0._buffUid2Effect[slot2].containerTr)

	slot3:setWorldPos(slot5, slot6, slot7)
	slot3:setEffectScale(uv1)
	FightRenderOrderMgr.instance:onAddEffectWrap(slot0._entity.id, slot3)
end

function slot0._hideBallLineEffect(slot0)
	for slot4, slot5 in ipairs(slot0._ballLine) do
		slot0._ballLine[slot4]:setActive(false, "FightEntitySpecialEffect3070_Ball_ball")
	end
end

function slot0._createNewBallLine(slot0)
	slot1 = slot0._entity:getMO()

	for slot5, slot6 in ipairs(slot0._ballEffectList) do
		if not slot0._ballLine[slot5] then
			slot8 = slot0:_getPosArr()[slot5]
			slot9 = slot0:_getPosArr()[slot5 + 1]
			slot0._ballLine[slot5] = slot0._entity.effect:addHangEffect(slot1 and uv0[slot1.skin] or uv0[uv1], ModuleEnum.SpineHangPointRoot, nil, , slot0:_getFirstPos())

			if slot5 == 1 then
				FightRenderOrderMgr.instance:onAddEffectWrap(slot0._entity.id, slot7)
			else
				slot7:setRenderOrder(FightRenderOrderMgr.MinSpecialOrder * FightEnum.OrderRegion + 9)
			end

			if slot9 then
				transformhelper.setLocalScale(slot7.containerTr, Vector3.Distance(Vector3.New(slot8[1], slot8[2], slot8[3]), Vector3.New(slot9[1], slot9[2], slot9[3])) / uv2, 1, 1)
			end
		end
	end
end

function slot0._showBallLineEffect(slot0)
	for slot4, slot5 in ipairs(slot0._ballEffectList) do
		slot6 = slot0:_getPosArr()[slot4]
		slot7 = slot0:_getPosArr()[slot4 + 1]
		slot8 = slot0._ballLine[slot4]

		if slot0._ballEffectList[slot4 + 1] then
			slot8:setActive(true, "FightEntitySpecialEffect3070_Ball_ball")

			slot10 = slot7[1] - slot6[1]
			slot11 = slot7[2] - slot6[2]

			slot8:setLocalPos(slot6[1] + slot10 / 2, slot6[2] + slot11 / 2, slot6[3] + (slot7[3] - slot6[3]) / 2)
			transformhelper.setLocalRotation(slot8.containerTr, 0, 0, Quaternion.FromToRotation(Vector3.left, Vector3.New(slot10, slot11, 0)).eulerAngles.z)
		else
			slot8:setActive(false, "FightEntitySpecialEffect3070_Ball_ball")
		end
	end
end

function slot0._createNewball(slot0)
	slot1 = slot0._entity.effect:addHangEffect(slot0._curEffectPath[1], ModuleEnum.SpineHangPointRoot, nil, , slot0:_getFirstPos())
	slot2 = slot0:_getFirstPos()

	slot1:setLocalPos(slot2.x, slot2.y, slot2.z)
	FightRenderOrderMgr.instance:onAddEffectWrap(slot0._entity.id, slot1)
	table.insert(slot0._ballEffectList, 1, slot1)
	table.insert(slot0._ballEffectUid, 1, slot0._curBuffUid)

	slot0._buffUid2Effect[slot0._curBuffUid] = slot1
	slot0._ballDestroyPath[slot1.uniqueId] = slot0._curEffectPath[3]

	slot1:setEffectScale(uv0)
	FightAudioMgr.instance:playAudio((slot0._entity:getMO() and uv1[slot3.skin] or uv1[uv2]).create)

	return slot1
end

function slot0._showNewball(slot0)
	for slot4, slot5 in ipairs(slot0._ballEffectList) do
		slot5:setActive(true, "FightEntitySpecialEffect3070_Ball_NewBall")
	end
end

function slot0._onBuffUpdate(slot0, slot1, slot2, slot3, slot4)
	if slot1 ~= slot0._entity.id then
		return
	end

	if uv0.buffTypeId2EffectPath[lua_skill_buff.configDict[slot3].typeId] then
		if slot2 == FightEnum.EffectType.BUFFADD then
			slot0._curBuffUid = slot4
			slot0._curEffectPath = slot0._entity:getMO() and slot6[slot7.skin] or slot6[uv1]

			slot0:_initPosArr(slot3)
			slot0:_releaseBallTween()

			slot0._newBall = slot0:_createNewball()

			slot0._newBall:setActive(false, "FightEntitySpecialEffect3070_Ball_NewBall")
			slot0:_createNewBallLine()

			slot0._aniFlow = FlowSequence.New()

			slot0._aniFlow:addWork(FunctionWork.New(slot0._hideBallLineEffect, slot0))

			if slot0._resetPlayingDestroyEffect then
				slot0._aniFlow:addWork(WorkWaitSeconds.New(uv2 / FightModel.instance:getSpeed()))
			end

			slot0._resetPlayingDestroyEffect = nil

			slot0._aniFlow:addWork(WorkWaitSeconds.New(uv3 / FightModel.instance:getSpeed()))
			slot0._aniFlow:addWork(FunctionWork.New(slot0._ballShowEffect, slot0))
			slot0._aniFlow:addWork(FunctionWork.New(slot0._showNewball, slot0))

			slot12 = FightModel.instance:getSpeed()

			slot0._aniFlow:addWork(WorkWaitSeconds.New(uv4 / slot12))

			slot8 = FlowParallel.New()

			for slot12 = 1, #slot0._ballEffectList do
				if slot0._ballEffectList[slot12] and slot12 > 1 then
					slot14 = slot0:_getPosArr()[slot12]
					slot16, slot17 = transformhelper.getLocalPos(slot13.containerTr)
					slot0._uid2BallTween[slot20] = slot0._uid2BallTween[slot0._ballEffectUid[slot12]] or {}
					slot21 = slot0:getUserDataTb_()
					slot21.transform = slot15
					slot21.flyTime = Mathf.Sqrt(Mathf.Pow(slot16 - slot14[1], 2) + Mathf.Pow(slot17 - slot14[2], 2)) / uv5 / FightModel.instance:getSpeed()
					slot21.x = slot14[1]
					slot21.y = slot14[2]
					slot21.index = slot12
					slot21.effectWrap = slot13

					table.insert(slot0._uid2BallTween[slot20], slot21)
				end
			end

			for slot12, slot13 in pairs(slot0._uid2BallTween) do
				slot14 = FlowSequence.New()

				for slot18, slot19 in ipairs(slot13) do
					slot20 = FlowParallel.New()
					slot21 = slot0:getUserDataTb_()

					table.insert(slot21, slot19.effectWrap)
					table.insert(slot21, slot19.index)
					slot20:addWork(FunctionWork.New(slot0._refreshBallOrder, slot0, slot21))
					slot20:addWork(TweenWork.New({
						type = "DOLocalMoveX",
						tr = slot19.transform,
						to = slot19.x,
						t = slot19.flyTime,
						ease = EaseType.OutQuart
					}))
					slot20:addWork(TweenWork.New({
						type = "DOLocalMoveY",
						tr = slot19.transform,
						to = slot19.y,
						t = slot19.flyTime,
						ease = EaseType.OutQuart
					}))
					slot14:addWork(slot20)
				end

				slot8:addWork(slot14)
			end

			slot0._aniFlow:addWork(slot8)
			slot0._aniFlow:addWork(WorkWaitSeconds.New(uv6 / FightModel.instance:getSpeed()))
			slot0._aniFlow:addWork(FunctionWork.New(slot0._showBallLineEffect, slot0))
			slot0._aniFlow:addWork(FunctionWork.New(slot0._clearBallTweenData, slot0))
			slot0._aniFlow:start()
		elseif slot2 == FightEnum.EffectType.BUFFDEL then
			for slot11 = #slot0._ballEffectUid, 1, -1 do
				if slot0._ballEffectUid[slot11] == slot4 then
					slot0._uid2BallTween[slot4] = nil
					slot12 = table.remove(slot0._ballEffectList, slot11)

					table.remove(slot0._ballEffectUid, slot11)
					slot0._entity.effect:removeEffect(slot12)
					slot0:_ballDestroyEffect(slot0._ballDestroyPath[slot12.uniqueId], slot4)

					slot0._playingDestroyEffect = true

					TaskDispatcher.runDelay(slot0._resetPlayingDestroyEffect, slot0, 0.3)
					FightAudioMgr.instance:playAudio((slot7 and uv7[slot7.skin] or uv7[uv1]).destroy)

					break
				end
			end
		end
	end
end

function slot0._refreshBallOrder(slot0, slot1)
	FightRenderOrderMgr.instance:onRemoveEffectWrap(slot0._entity.id, slot1[1])

	if slot1[2] <= 2 then
		FightRenderOrderMgr.instance:onAddEffectWrap(slot0._entity.id, slot2)
	else
		slot2:setRenderOrder(FightRenderOrderMgr.MinSpecialOrder * FightEnum.OrderRegion + 10)
	end
end

function slot0._clearBallTweenData(slot0)
	slot0._uid2BallTween = {}
end

function slot0._resetPlayingDestroyEffect(slot0)
	slot0._playingDestroyEffect = nil
end

function slot0._onBeforeEnterStepBehaviour(slot0)
	if slot0._entity:getMO() then
		for slot6, slot7 in pairs(slot1:getBuffDic()) do
			slot0:_onBuffUpdate(slot0._entity.id, FightEnum.EffectType.BUFFADD, slot7.buffId, slot7.uid)
		end
	end
end

function slot0._onSetBuffEffectVisible(slot0, slot1, slot2, slot3)
	if slot0._entity.id == slot1 then
		if slot0._ballEffectList then
			for slot7, slot8 in ipairs(slot0._ballEffectList) do
				slot8:setActive(slot2, slot3 or "FightEntitySpecialEffect3070_Ball")
			end
		end

		if slot0._ballLine then
			for slot7, slot8 in ipairs(slot0._ballLine) do
				slot8:setActive(slot2, slot3 or "FightEntitySpecialEffect3070_Ball")
			end
		end
	end
end

function slot0._playMoveAudio(slot0)
	if tabletool.len(slot0._uid2BallTween) > 0 then
		FightAudioMgr.instance:playAudio((slot0._entity:getMO() and uv0[slot1.skin] or uv0[uv1]).move)
	end
end

function slot0._onSkillPlayStart(slot0, slot1)
	slot0:_onSetBuffEffectVisible(slot1.id, false, "FightEntitySpecialEffect3070_Ball_PlaySkill")
end

function slot0._onSkillPlayFinish(slot0, slot1)
	slot0:_onSetBuffEffectVisible(slot1.id, true, "FightEntitySpecialEffect3070_Ball_PlaySkill")
end

function slot0._releaseBallTween(slot0)
	if slot0._aniFlow then
		slot0._aniFlow:stop()

		slot0._aniFlow = nil
	end
end

function slot0._releaseBallEffect(slot0)
	if slot0._ballEffectList then
		for slot4, slot5 in pairs(slot0._ballEffectList) do
			slot0._entity.effect:removeEffect(slot5)
			FightRenderOrderMgr.instance:onRemoveEffectWrap(slot0._entity.id, slot5)
		end
	end

	slot0._ballEffectList = nil
	slot0._ballEffectUid = nil

	if slot0._showEffectWrap then
		slot0._entity.effect:removeEffect(slot0._showEffectWrap)
		FightRenderOrderMgr.instance:onRemoveEffectWrap(slot0._entity.id, slot0._showEffectWrap)

		slot0._showEffectWrap = nil
	end
end

function slot0._releaseBallLineEffect(slot0)
	if slot0._ballLine then
		for slot4, slot5 in pairs(slot0._ballLine) do
			slot0._entity.effect:removeEffect(slot5)
			FightRenderOrderMgr.instance:onRemoveEffectWrap(slot0._entity.id, slot5)
		end
	end

	slot0._ballLine = nil
end

function slot0._onBeforeDeadEffect(slot0, slot1)
	if slot1 == slot0._entity.id then
		slot0:_releaseEffect()
	end
end

function slot0._releaseEffect(slot0)
	slot0:_releaseBallTween()
	slot0:_releaseBallEffect()
	slot0:_releaseBallLineEffect()
end

function slot0.releaseSelf(slot0)
	TaskDispatcher.cancelTask(slot0._resetPlayingDestroyEffect, slot0)
	slot0:_releaseEffect()
end

return slot0
