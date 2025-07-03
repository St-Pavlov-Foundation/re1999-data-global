module("modules.logic.fight.view.FightViewBossHpBloodReward", package.seeall)

local var_0_0 = class("FightViewBossHpBloodReward", FightBaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.hpImg = gohelper.findChildImage(arg_1_0.viewGO, "Root/bossHp/Alpha/bossHp/mask/container/imgHp")
	arg_1_0.signRoot = gohelper.findChild(arg_1_0.viewGO, "Root/bossHp/Alpha/bossHp/mask/container/imgHp/imgSignHpContainer")
	arg_1_0.signItem = gohelper.findChild(arg_1_0.viewGO, "Root/bossHp/Alpha/bossHp/mask/container/imgHp/imgSignHpContainer/imgSignHpItem")
	arg_1_0.hpEffect = gohelper.findChild(arg_1_0.viewGO, "Root/bossHp/Alpha/bossHp/#hpeffect")

	gohelper.setActive(arg_1_0.hpEffect, false)
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:com_registFightEvent(FightEvent.UpdateFightParam, arg_2_0.onUpdateFightParam)
	arg_2_0:com_registFightEvent(FightEvent.PlayTimelineHit, arg_2_0.onPlayTimelineHit)
	arg_2_0:com_registFightEvent(FightEvent.AfterCorrectData, arg_2_0.onAfterCorrectData)

	arg_2_0.tweenComp = arg_2_0:addComponent(FightTweenComponent)
end

function var_0_0.onConstructor(arg_3_0, arg_3_1)
	arg_3_0.data = arg_3_1
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0.invokedEffect = {}
	arg_4_0.bgWidth = recthelper.getWidth(arg_4_0.signRoot.transform)
	arg_4_0.halfWidth = arg_4_0.bgWidth / 2
	arg_4_0.itemDataList = GameUtil.splitString2(arg_4_0.data.bloodReward, true)

	arg_4_0:refreshItems()
	arg_4_0:refreshHp()
end

function var_0_0.onAfterCorrectData(arg_5_0)
	arg_5_0:refreshItems()

	local var_5_0 = (FightDataHelper.fieldMgr.param[FightParamData.ParamKey.ACT191_CUR_HP_RATE] or 0) / 1000

	arg_5_0.tweenComp:DOFillAmount(arg_5_0.hpImg, var_5_0, 0.2)
end

function var_0_0.onPlayTimelineHit(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_2.side ~= FightEnum.EntitySide.EnemySide then
		return
	end

	gohelper.setActive(arg_6_0.hpEffect, false)
	gohelper.setActive(arg_6_0.hpEffect, true)
	arg_6_0:com_registSingleTimer(arg_6_0.hideEffect, 0.5)

	local var_6_0 = 0

	for iter_6_0, iter_6_1 in ipairs(arg_6_1.actEffect) do
		if not iter_6_1:isDone() and not arg_6_0.invokedEffect[iter_6_1.clientId] and iter_6_1.effectType == FightEnum.EffectType.FIGHTPARAMCHANGE then
			local var_6_1 = GameUtil.splitString2(iter_6_1.reserveStr, true)

			for iter_6_2, iter_6_3 in ipairs(var_6_1) do
				if iter_6_3[1] == FightParamData.ParamKey.ACT191_CUR_HP_RATE then
					var_6_0 = var_6_0 + iter_6_3[2]
					arg_6_0.invokedEffect[iter_6_1.clientId] = true
				end
			end
		end
	end

	if var_6_0 ~= 0 then
		arg_6_0:refreshHp(arg_6_0.hpImg.fillAmount + var_6_0 / 1000)
	end
end

function var_0_0.hideEffect(arg_7_0)
	gohelper.setActive(arg_7_0.hpEffect, false)
end

function var_0_0.refreshHp(arg_8_0, arg_8_1)
	arg_8_1 = arg_8_1 or (FightDataHelper.fieldMgr.param[FightParamData.ParamKey.ACT191_CUR_HP_RATE] or 0) / 1000

	arg_8_0.tweenComp:DOFillAmount(arg_8_0.hpImg, arg_8_1, 0.2)
end

function var_0_0.onUpdateFightParam(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5)
	if arg_9_1 == FightParamData.ParamKey.ACT191_MIN_HP_RATE then
		arg_9_0:refreshItems()
	elseif arg_9_1 == FightParamData.ParamKey.ACT191_CUR_HP_RATE and not arg_9_0.invokedEffect[arg_9_5.clientId] then
		arg_9_0:refreshHp()
	end
end

function var_0_0.refreshItems(arg_10_0)
	gohelper.CreateObjList(arg_10_0, arg_10_0.onItemShow, arg_10_0.itemDataList, arg_10_0.signRoot, arg_10_0.signItem)
end

function var_0_0.onItemShow(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = gohelper.findChild(arg_11_1, "unfinish")
	local var_11_1 = gohelper.findChild(arg_11_1, "finished")
	local var_11_2 = FightDataHelper.fieldMgr.param[FightParamData.ParamKey.ACT191_MIN_HP_RATE]
	local var_11_3 = arg_11_2[1]

	if var_11_2 <= var_11_3 then
		gohelper.setActive(var_11_0, false)
		gohelper.setActive(var_11_1, true)
	else
		gohelper.setActive(var_11_0, true)
		gohelper.setActive(var_11_1, false)
	end

	local var_11_4 = var_11_3 / 1000 * arg_11_0.bgWidth - arg_11_0.halfWidth

	recthelper.setAnchorX(arg_11_1.transform, var_11_4)
end

return var_0_0
