module("modules.logic.fight.system.work.FightWorkMove", package.seeall)

local var_0_0 = class("FightWorkMove", FightEffectBase)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	if arg_1_1 then
		arg_1_1.custom_ingoreParallelSkill = true
	end

	var_0_0.super.ctor(arg_1_0, arg_1_1, arg_1_2)
end

function var_0_0.onStart(arg_2_0)
	arg_2_0._performanceTime = 0.6 / FightModel.instance:getSpeed()

	arg_2_0:com_registTimer(arg_2_0._delayDone, 5)

	arg_2_0._flow = FlowParallel.New()
	arg_2_0._cacheEntityIds = {}

	local var_2_0 = string.split(arg_2_0.actEffectData.reserveStr, "|")

	if #var_2_0 > 0 then
		AudioMgr.instance:trigger(410000090)

		for iter_2_0, iter_2_1 in ipairs(var_2_0) do
			local var_2_1 = string.split(iter_2_1, "#")[1]
			local var_2_2 = FightDataHelper.entityMgr:getById(var_2_1)

			if var_2_2 then
				local var_2_3 = FightHelper.getEntity(var_2_1)

				if var_2_3 and var_2_3.mover then
					local var_2_4, var_2_5, var_2_6, var_2_7 = FightHelper.getEntityStandPos(var_2_2)
					local var_2_8 = FlowParallel.New()

					var_2_8:addWork(FunctionWork.New(arg_2_0._playEffect, arg_2_0, var_2_3))
					var_2_8:addWork(TweenWork.New({
						type = "DOScale",
						tr = var_2_3.go.transform,
						to = var_2_7,
						t = arg_2_0._performanceTime,
						ease = EaseType.InOutQuad
					}))
					var_2_8:addWork(TweenWork.New({
						from = 0,
						type = "DOTweenFloat",
						to = 1,
						t = arg_2_0._performanceTime,
						frameCb = arg_2_0._onFloat,
						cbObj = arg_2_0,
						param = var_2_3,
						ease = EaseType.InOutQuad
					}))
					var_2_8:addWork(TweenWork.New({
						type = "DOMove",
						tr = var_2_3.go.transform,
						tox = var_2_4,
						toy = var_2_5,
						toz = var_2_6,
						t = arg_2_0._performanceTime,
						ease = EaseType.InOutQuad
					}))
					arg_2_0._flow:addWork(var_2_8)
					table.insert(arg_2_0._cacheEntityIds, var_2_2.id)
				end
			end
		end
	end

	arg_2_0._flow:registerDoneListener(arg_2_0._onFlowDone, arg_2_0)
	arg_2_0._flow:start()
end

function var_0_0._onFlowDone(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0._delayDone(arg_4_0)
	arg_4_0:onDone(true)
end

function var_0_0._playEffect(arg_5_0, arg_5_1)
	if arg_5_1 and arg_5_1.effect then
		local var_5_0 = arg_5_1.effect:addHangEffect("buff/buff_huanwei_jiantou", "mountbody", nil, arg_5_0._performanceTime)

		FightRenderOrderMgr.instance:onAddEffectWrap(arg_5_1.id, var_5_0)
		var_5_0:setLocalPos(0, 0, 0)

		local var_5_1 = arg_5_1.effect:addHangEffect("buff/buff_huanwei_faguang", "mountroot", nil, arg_5_0._performanceTime)

		FightRenderOrderMgr.instance:onAddEffectWrap(arg_5_1.id, var_5_1)
		var_5_1:setLocalPos(0, 0, 0)
	end
end

function var_0_0._onFloat(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_2.go then
		FightController.instance:dispatchEvent(FightEvent.UpdateUIFollower, arg_6_2.id)
	end
end

function var_0_0.clearWork(arg_7_0)
	if arg_7_0._flow then
		arg_7_0._flow:unregisterDoneListener(arg_7_0._onFlowDone, arg_7_0)
		arg_7_0._flow:stop()

		arg_7_0._flow = nil
	end

	if arg_7_0._cacheEntityIds then
		for iter_7_0, iter_7_1 in ipairs(arg_7_0._cacheEntityIds) do
			local var_7_0 = FightHelper.getEntity(iter_7_1)

			if var_7_0 and var_7_0.effect then
				var_7_0.effect:refreshAllEffectLabel1()
			end
		end
	end

	FightRenderOrderMgr.instance:setSortType(FightEnum.RenderOrderType.StandPos)
end

return var_0_0
