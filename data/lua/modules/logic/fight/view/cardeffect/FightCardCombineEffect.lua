module("modules.logic.fight.view.cardeffect.FightCardCombineEffect", package.seeall)

local var_0_0 = class("FightCardCombineEffect", BaseWork)
local var_0_1 = "ui/viewres/fight/ui_effect_dna_d.prefab"
local var_0_2 = 1
local var_0_3 = 0.033 * var_0_2

function var_0_0.onStart(arg_1_0, arg_1_1)
	FightDataHelper.tempMgr.combineCount = FightDataHelper.tempMgr.combineCount + 1

	local var_1_0 = FightDataHelper.tempMgr.combineCount * 0.2

	arg_1_0._dt = var_0_3 / (FightModel.instance:getUISpeed() + var_1_0)

	local var_1_1 = arg_1_1.cards
	local var_1_2 = arg_1_1.combineIndex

	arg_1_0._sequence = FlowSequence.New()

	local var_1_3 = arg_1_1.handCardItemList[var_1_2]
	local var_1_4 = arg_1_1.handCardItemList[var_1_2 + 1]

	var_1_3:setASFDActive(false)
	var_1_4:setASFDActive(false)

	arg_1_0._universalCombineId = FightEnum.UniversalCard[var_1_3.cardInfoMO.skillId] or FightEnum.UniversalCard[var_1_4.cardInfoMO.skillId]

	local var_1_5
	local var_1_6 = gohelper.create2d(var_1_3.tr.parent.gameObject, "Combine")

	arg_1_0._combineContainerGO = var_1_6

	local var_1_7, var_1_8, var_1_9 = transformhelper.getPos(var_1_3.tr)
	local var_1_10, var_1_11, var_1_12 = transformhelper.getPos(var_1_4.tr)

	transformhelper.setPos(var_1_6.transform, (var_1_7 + var_1_10) * 0.5, var_1_8, var_1_9)

	local var_1_13 = gohelper.create2d(var_1_6, "CombineMask1")
	local var_1_14 = gohelper.create2d(var_1_6, "CombineMask2")

	transformhelper.setPos(var_1_13.transform, transformhelper.getPos(var_1_3.tr))
	transformhelper.setPos(var_1_14.transform, transformhelper.getPos(var_1_4.tr))
	recthelper.setSize(var_1_13.transform, 185, 272)
	recthelper.setSize(var_1_14.transform, 185, 272)
	gohelper.onceAddComponent(var_1_13, gohelper.Type_Image)
	gohelper.onceAddComponent(var_1_14, gohelper.Type_Image)

	gohelper.onceAddComponent(var_1_13, typeof(UnityEngine.UI.Mask)).showMaskGraphic = false
	gohelper.onceAddComponent(var_1_14, typeof(UnityEngine.UI.Mask)).showMaskGraphic = false

	local var_1_15 = gohelper.clone(var_1_3.go, var_1_13)
	local var_1_16 = gohelper.clone(var_1_4.go, var_1_14)
	local var_1_17 = var_1_15.transform
	local var_1_18 = var_1_16.transform

	gohelper.setActive(var_1_3.go, false)
	gohelper.setActive(var_1_4.go, false)

	var_1_15.transform.anchorMin = Vector2.New(1, 0.5)
	var_1_15.transform.anchorMax = Vector2.New(1, 0.5)
	var_1_16.transform.anchorMin = Vector2.New(0, 0.5)
	var_1_16.transform.anchorMax = Vector2.New(0, 0.5)

	recthelper.setAnchorX(var_1_17, -92.5)
	recthelper.setAnchorX(var_1_18, 92.5)
	var_0_0._resetImages(var_1_15)
	var_0_0._resetImages(var_1_16)

	local var_1_19 = arg_1_0:_createEffect(var_1_6, FightPreloadViewWork.ui_effect_dna_c)

	var_1_19.name = "CombineEffect"

	transformhelper.setPos(var_1_3.tr, (var_1_7 + var_1_10) * 0.5, var_1_8, var_1_9)
	gohelper.setActive(gohelper.findChild(var_1_15, "foranim/restrain"), false)
	gohelper.setActive(gohelper.findChild(var_1_16, "foranim/restrain"), false)
	gohelper.setActive(gohelper.findChild(var_1_15, "foranim/spEffect"), false)
	gohelper.setActive(gohelper.findChild(var_1_16, "foranim/spEffect"), false)
	gohelper.setActive(gohelper.findChild(var_1_15, "foranim/lock"), false)
	gohelper.setActive(gohelper.findChild(var_1_16, "foranim/lock"), false)

	local var_1_20 = recthelper.getWidth(var_1_13.transform)
	local var_1_21 = FlowParallel.New()

	var_1_21:addWork(TweenWork.New({
		toz = 5,
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = var_1_17,
		t = arg_1_0._dt * 2
	}))
	var_1_21:addWork(TweenWork.New({
		toz = -5,
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = var_1_18,
		t = arg_1_0._dt * 2
	}))
	var_1_21:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = var_1_17,
		to = -var_1_20 * 0.58,
		t = arg_1_0._dt
	}))
	var_1_21:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = var_1_18,
		to = var_1_20 * 0.58,
		t = arg_1_0._dt
	}))
	arg_1_0._sequence:addWork(var_1_21)

	local var_1_22 = FlowParallel.New()

	var_1_22:addWork(TweenWork.New({
		toz = -5,
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = var_1_17,
		t = arg_1_0._dt * 2
	}))
	var_1_22:addWork(TweenWork.New({
		toz = 5,
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = var_1_18,
		t = arg_1_0._dt * 2
	}))
	var_1_22:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = var_1_17,
		to = -var_1_20 * 0.65,
		t = arg_1_0._dt
	}))
	var_1_22:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = var_1_18,
		to = var_1_20 * 0.65,
		t = arg_1_0._dt
	}))
	arg_1_0._sequence:addWork(var_1_22)

	local var_1_23 = FlowParallel.New()

	var_1_23:addWork(TweenWork.New({
		toz = 5,
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = var_1_17,
		t = arg_1_0._dt * 2
	}))
	var_1_23:addWork(TweenWork.New({
		toz = -5,
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = var_1_18,
		t = arg_1_0._dt * 2
	}))
	var_1_23:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = var_1_17,
		to = -var_1_20 * 0.68,
		t = arg_1_0._dt
	}))
	var_1_23:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = var_1_18,
		to = var_1_20 * 0.68,
		t = arg_1_0._dt
	}))
	arg_1_0._sequence:addWork(var_1_23)

	local var_1_24 = FlowParallel.New()

	var_1_24:addWork(TweenWork.New({
		toz = -5,
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = var_1_17,
		t = arg_1_0._dt * 2
	}))
	var_1_24:addWork(TweenWork.New({
		toz = 5,
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = var_1_18,
		t = arg_1_0._dt * 2
	}))
	var_1_24:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = var_1_17,
		to = -var_1_20 * 0.7,
		t = arg_1_0._dt
	}))
	var_1_24:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = var_1_18,
		to = var_1_20 * 0.7,
		t = arg_1_0._dt
	}))
	arg_1_0._sequence:addWork(var_1_24)

	local var_1_25 = FlowParallel.New()

	var_1_25:addWork(TweenWork.New({
		toz = 5,
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = var_1_17,
		t = arg_1_0._dt * 2
	}))
	var_1_25:addWork(TweenWork.New({
		toz = -5,
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = var_1_18,
		t = arg_1_0._dt * 2
	}))
	var_1_25:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = var_1_17,
		to = -var_1_20 * 0.7,
		t = arg_1_0._dt
	}))
	var_1_25:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = var_1_18,
		to = var_1_20 * 0.7,
		t = arg_1_0._dt
	}))
	arg_1_0._sequence:addWork(var_1_25)
	arg_1_0._sequence:addWork(FunctionWork.New(function()
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_FigthCombineCard)
	end))

	local var_1_26 = FlowParallel.New()

	var_1_26:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = var_1_17,
		to = -var_1_20 * 1.5,
		t = arg_1_0._dt * 5
	}))
	var_1_26:addWork(TweenWork.New({
		type = "DOAnchorPosX",
		tr = var_1_18,
		to = var_1_20 * 1.5,
		t = arg_1_0._dt * 5
	}))
	var_1_26:addWork(TweenWork.New({
		toz = 0,
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = var_1_17,
		t = arg_1_0._dt * 5
	}))
	var_1_26:addWork(TweenWork.New({
		toz = 0,
		type = "DORotate",
		tox = 0,
		toy = 0,
		tr = var_1_18,
		t = arg_1_0._dt * 5
	}))
	arg_1_0._sequence:addWork(var_1_26)

	local var_1_27 = FightCardDataHelper.combineCanAddExpoint(var_1_1, var_1_1[var_1_2], var_1_1[var_1_2 + 1])

	var_1_1[var_1_2] = FightCardDataHelper.combineCardForPerformance(var_1_1[var_1_2], var_1_1[var_1_2 + 1])
	var_1_1[var_1_2].combineCanAddExpoint = var_1_27

	table.remove(var_1_1, var_1_2 + 1)
	arg_1_0._sequence:addWork(FunctionWork.New(function()
		local var_3_0 = var_0_0.getCardPosXList(arg_1_1.handCardItemList)

		FightController.instance:dispatchEvent(FightEvent.UpdateHandCards, var_1_1)

		for iter_3_0 = 1, #arg_1_1.handCardItemList - 1 do
			local var_3_1 = arg_1_1.handCardItemList[iter_3_0]
			local var_3_2 = var_3_0[iter_3_0 <= var_1_2 and iter_3_0 or iter_3_0 + 1]

			recthelper.setAnchorX(var_3_1.tr, var_3_2)
		end

		var_1_19.transform:SetParent(arg_1_1.handCardItemList[var_1_2].tr.parent, true)
		gohelper.destroy(var_1_6)

		local var_3_3 = arg_1_1.handCardItemList[var_1_2].go
		local var_3_4 = gohelper.findChild(var_3_3, "foranim/cardeffect")

		gohelper.setActive(var_3_4, true)
	end))

	local var_1_28 = FightCardDataHelper.canCombineCardListForPerformance(var_1_1)
	local var_1_29 = FightModel.instance:getCurStage()

	if not (var_1_29 == FightEnum.Stage.Distribute or var_1_29 == FightEnum.Stage.FillCard) or var_1_28 then
		arg_1_0._sequence:addWork(var_0_0.buildCombineEndFlow(var_1_2, var_1_2, #var_1_1, arg_1_1.handCardItemList))
	end

	arg_1_0._sequence:registerDoneListener(arg_1_0._onCombineCardDone, arg_1_0)
	arg_1_0._sequence:start(arg_1_1)
end

function var_0_0._onCombineCardDone(arg_4_0)
	arg_4_0._sequence:unregisterDoneListener(arg_4_0._onCombineCardDone, arg_4_0)

	local var_4_0 = arg_4_0.context.combineIndex
	local var_4_1 = arg_4_0.context.handCardItemList[var_4_0]
	local var_4_2 = arg_4_0.context.handCardItemList[var_4_0 + 1]

	if var_4_1 then
		var_4_1:setASFDActive(true)
	end

	if var_4_2 then
		var_4_2:setASFDActive(true)
	end

	if arg_4_0._universalCombineId then
		arg_4_0:_createUniversalCombineEffect()
	else
		arg_4_0:onDone(true)
	end
end

function var_0_0.onStop(arg_5_0)
	if arg_5_0._sequence and arg_5_0._sequence.status == WorkStatus.Running then
		arg_5_0._sequence:stop()
	end

	var_0_0.super.onStop(arg_5_0)
end

function var_0_0.getCardPosXList(arg_6_0)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_0) do
		table.insert(var_6_0, recthelper.getAnchorX(iter_6_1.tr))
	end

	return var_6_0
end

function var_0_0.buildCombineEndFlow(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = var_0_3 / FightModel.instance:getUISpeed()
	local var_7_1 = FlowParallel.New()

	if arg_7_0 then
		local var_7_2 = arg_7_3[arg_7_0]

		if var_7_2 then
			local var_7_3 = FlowSequence.New()
			local var_7_4 = FightViewHandCard.calcCardPosX(arg_7_0)

			var_7_3:addWork(FunctionWork.New(function()
				transformhelper.setLocalRotation(var_7_2.tr, 0, -90, 0)
			end))
			var_7_3:addWork(TweenWork.New({
				toz = 0,
				type = "DORotate",
				tox = 0,
				toy = -45,
				tr = var_7_2.tr,
				t = 1 * var_7_0
			}))
			var_7_3:addWork(TweenWork.New({
				toz = 0,
				type = "DORotate",
				tox = 0,
				toy = 0,
				tr = var_7_2.tr,
				t = 1 * var_7_0
			}))
			var_7_3:addWork(TweenWork.New({
				type = "DOAnchorPos",
				toy = 0,
				tr = var_7_2.tr,
				tox = var_7_4,
				t = var_7_0 * 4
			}))
			var_7_3:addWork(FunctionWork.New(function()
				local var_9_0 = var_7_2.go
				local var_9_1 = gohelper.findChild(var_9_0, "foranim/cardeffect")

				gohelper.setActive(var_9_1, false)
				gohelper.destroy(gohelper.findChild(var_7_2.tr.parent.gameObject, "CombineEffect"))
			end))
			var_7_1:addWork(var_7_3)
		else
			logError("合牌位置错误：" .. arg_7_0)
		end
	end

	if arg_7_1 > 0 then
		for iter_7_0 = arg_7_1, arg_7_2 do
			if iter_7_0 ~= arg_7_0 then
				local var_7_5 = arg_7_3[iter_7_0]
				local var_7_6 = FlowSequence.New()
				local var_7_7 = (3 + iter_7_0 - arg_7_1) * var_7_0

				if var_7_7 > 0 then
					var_7_6:addWork(WorkWaitSeconds.New(var_7_7))
				end

				local var_7_8 = FightViewHandCard.calcCardPosX(iter_7_0)

				var_7_6:addWork(TweenWork.New({
					type = "DOAnchorPos",
					toy = 0,
					tr = var_7_5.tr,
					tox = var_7_8,
					t = var_7_0 * 4
				}))
				var_7_1:addWork(var_7_6)
			end
		end
	end

	return var_7_1
end

function var_0_0._createEffect(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = gohelper.create2d(arg_10_1, arg_10_2)

	arg_10_0:_load(var_10_0, arg_10_2)

	return var_10_0
end

function var_0_0._load(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = PrefabInstantiate.Create(arg_11_1)

	var_11_0:startLoad(arg_11_2, function()
		local var_12_0 = var_11_0:getInstGO():GetComponent(typeof(ZProj.EffectOrderContainer))

		if var_12_0 then
			var_12_0:SetBaseOrder(2)
		end
	end)
end

function var_0_0._createUniversalCombineEffect(arg_13_0)
	local var_13_0 = arg_13_0.context.handCardItemList[arg_13_0.context.combineIndex]
	local var_13_1 = gohelper.findChild(var_13_0.go, "combineUpEffect") or gohelper.create2d(var_13_0.go, "combineUpEffect")

	arg_13_0._combineUpEffectLoader = PrefabInstantiate.Create(var_13_1)

	arg_13_0._combineUpEffectLoader:startLoad(var_0_1, function(arg_14_0)
		local var_14_0 = FightCardDataHelper.getSkillLv(var_13_0.cardInfoMO.uid, var_13_0.cardInfoMO.skillId)
		local var_14_1 = arg_14_0:getInstGO()

		gohelper.onceAddComponent(var_14_1, typeof(ZProj.EffectTimeScale)):SetTimeScale(FightModel.instance:getUISpeed())
		gohelper.setActive(gohelper.findChild(var_14_1, "ani/star02"), var_14_0 >= 2)
		gohelper.setActive(gohelper.findChild(var_14_1, "ani/star03"), var_14_0 >= 3)
	end)
	TaskDispatcher.runDelay(arg_13_0._combineUpEffectDone, arg_13_0, 0.5 / FightModel.instance:getUISpeed())
end

function var_0_0._combineUpEffectDone(arg_15_0)
	if arg_15_0._combineUpEffectLoader then
		arg_15_0._combineUpEffectLoader:dispose()
	end

	arg_15_0._combineUpEffectLoader = nil

	arg_15_0:onDone(true)
end

function var_0_0.clearWork(arg_16_0)
	if arg_16_0._combineContainerGO then
		gohelper.destroy(arg_16_0._combineContainerGO)

		arg_16_0._combineContainerGO = nil
	end

	if arg_16_0._combineUpEffectLoader then
		arg_16_0._combineUpEffectLoader:dispose()
	end

	arg_16_0._combineUpEffectLoader = nil

	TaskDispatcher.cancelTask(arg_16_0._combineUpEffectDone, arg_16_0)
end

function var_0_0._resetImages(arg_17_0)
	if not gohelper.isNil(arg_17_0) then
		local var_17_0 = arg_17_0:GetComponentsInChildren(gohelper.Type_Image)

		for iter_17_0 = 0, var_17_0.Length - 1 do
			var_17_0[iter_17_0].maskable = true
		end
	end
end

return var_0_0
