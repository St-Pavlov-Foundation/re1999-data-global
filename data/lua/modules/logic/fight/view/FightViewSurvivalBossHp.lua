module("modules.logic.fight.view.FightViewSurvivalBossHp", package.seeall)

local var_0_0 = class("FightViewSurvivalBossHp", FightViewBossHp)

var_0_0.DefaultOneMaxHp = 10000

function var_0_0.onInitView(arg_1_0)
	var_0_0.super.onInitView(arg_1_0)

	arg_1_0.txtSurvivalHpCount = gohelper.findChildText(arg_1_0.viewGO, "Alpha/bossHp/mask/container/#txt_survival_hp_count")

	gohelper.setActive(arg_1_0.txtSurvivalHpCount.gameObject, true)

	arg_1_0.bgHp = gohelper.findChildImage(arg_1_0.viewGO, "Alpha/bossHp/mask/container/unlimitedhp")
	arg_1_0.bgHpGo = arg_1_0.bgHp.gameObject

	gohelper.setActive(arg_1_0.bgHpGo, true)

	arg_1_0.shieldHp = arg_1_0._imgHpShield

	gohelper.setActive(arg_1_0.shieldHp.gameObject, true)

	arg_1_0.hp = arg_1_0._imgHp

	gohelper.setActive(arg_1_0.hp.gameObject, true)

	arg_1_0.tweenHp = 0
	arg_1_0.tweenShieldHp = 0
	arg_1_0.targetHp = 0
	arg_1_0.targetShieldHp = 0

	local var_1_0 = FightDataHelper.fieldMgr.battleId
	local var_1_1 = lua_battle.configDict[var_1_0]
	local var_1_2 = var_1_1 and var_1_1.bossHpType
	local var_1_3 = not string.nilorempty(var_1_2) and FightStrUtil.instance:getSplitCache(var_1_2, "#")

	arg_1_0.oneMaxHp = var_1_3 and tonumber(var_1_3[2]) or var_0_0.DefaultOneMaxHp
end

function var_0_0._updateUI(arg_2_0)
	if not arg_2_0._bossEntityMO then
		return
	end

	arg_2_0:directUpdateHp()
	arg_2_0:refreshImageIcon()
	arg_2_0:_refreshCareer()
	arg_2_0:_detectBossHpSign()
	arg_2_0:_detectBossMultiHp()
end

function var_0_0.refreshImageIcon(arg_3_0)
	if not arg_3_0._bossEntityMO then
		return
	end

	local var_3_0 = lua_monster.configDict[arg_3_0._bossEntityMO.modelId]
	local var_3_1 = var_3_0 and FightConfig.instance:getSkinCO(var_3_0.skinId)
	local var_3_2 = var_3_1 and var_3_1.headIcon

	if not string.nilorempty(var_3_2) then
		gohelper.setActive(arg_3_0._imgHead.gameObject, true)
		gohelper.getSingleImage(arg_3_0._imgHead.gameObject):LoadImage(ResUrl.monsterHeadIcon(var_3_1.headIcon))

		if var_3_0.heartVariantId ~= 0 then
			IconMaterialMgr.instance:loadMaterialAddSet(IconMaterialMgr.instance:getMaterialPath(var_3_0.heartVariantId), arg_3_0._imgHeadIcon)
		end
	else
		gohelper.setActive(arg_3_0._imgHead.gameObject, false)
	end
end

function var_0_0.directUpdateHp(arg_4_0)
	if not arg_4_0._bossEntityMO then
		return
	end

	local var_4_0 = arg_4_0._bossEntityMO.attrMO.hp
	local var_4_1 = arg_4_0._bossEntityMO.currentHp
	local var_4_2 = math.min(math.max(0, var_4_1), var_4_0)

	arg_4_0.tweenHp = var_4_2
	arg_4_0.targetHp = var_4_2
	arg_4_0.tweenShieldHp = arg_4_0._bossEntityMO.shieldValue
	arg_4_0.targetShieldHp = arg_4_0._bossEntityMO.shieldValue

	arg_4_0:refreshHpAndShield()
	arg_4_0:refreshReduceHP()
end

function var_0_0._tweenFillAmount(arg_5_0, arg_5_1)
	arg_5_0:directUpdateHp()
end

function var_0_0.onCoverPerformanceEntityData(arg_6_0, arg_6_1)
	if not arg_6_0._bossEntityMO or arg_6_1 ~= arg_6_0._bossEntityMO.id then
		return
	end

	arg_6_0:directUpdateHp()
end

var_0_0.HpDuration = 0.5

function var_0_0._onHpChange(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_2 == 0 then
		return
	end

	if not arg_7_0._bossEntityMO then
		return
	end

	if arg_7_1.id ~= arg_7_0._bossEntityMO.id then
		return
	end

	if arg_7_2 < 0 then
		gohelper.setActive(arg_7_0._goHpEffect, true)

		arg_7_0._aniHpEffect.enabled = true
		arg_7_0._aniHpEffect.speed = 1

		arg_7_0._aniHpEffect:Play("hpeffect", 0, 0)
	end

	arg_7_0:clearHpTween()

	local var_7_0 = arg_7_0._bossEntityMO.attrMO.hp

	arg_7_0.targetHp = arg_7_0.targetHp + arg_7_2
	arg_7_0.targetHp = math.min(math.max(0, arg_7_0.targetHp), var_7_0)
	arg_7_0.hpTweenId = ZProj.TweenHelper.DOTweenFloat(arg_7_0.tweenHp, arg_7_0.targetHp, var_0_0.HpDuration, arg_7_0.frameSetHp, arg_7_0.onHpTweenDone, arg_7_0)
end

function var_0_0.frameSetHp(arg_8_0, arg_8_1)
	arg_8_0.tweenHp = arg_8_1

	arg_8_0:refreshHpAndShield()
end

function var_0_0.onHpTweenDone(arg_9_0)
	arg_9_0.tweenHp = arg_9_0.targetHp

	arg_9_0:refreshHpAndShield()
end

function var_0_0._onShieldChange(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_0._bossEntityMO then
		return
	end

	if arg_10_1.id ~= arg_10_0._bossEntityMO.id then
		return
	end

	arg_10_0:clearShieldTween()

	arg_10_0.targetShieldHp = arg_10_0._bossEntityMO.shieldValue
	arg_10_0.shieldTweenId = ZProj.TweenHelper.DOTweenFloat(arg_10_0.tweenShieldHp, arg_10_0.targetShieldHp, var_0_0.HpDuration, arg_10_0.frameSetShield, arg_10_0.onShieldTweenDone, arg_10_0)
end

function var_0_0.frameSetShield(arg_11_0, arg_11_1)
	arg_11_0.tweenShieldHp = arg_11_1

	arg_11_0:refreshHpAndShield()
end

function var_0_0.onShieldTweenDone(arg_12_0)
	arg_12_0.tweenShieldHp = arg_12_0.targetShieldHp

	arg_12_0:refreshHpAndShield()
end

function var_0_0.refreshHpAndShield(arg_13_0)
	local var_13_0, var_13_1 = arg_13_0:_getFillAmount()

	arg_13_0.hp.fillAmount = var_13_0
	arg_13_0.shieldHp.fillAmount = var_13_1

	arg_13_0:_changeShieldPos(var_13_0)
	arg_13_0:refreshHpCount()
	arg_13_0:refreshHpColor()
	arg_13_0:refreshReduceHP()
end

function var_0_0._getFillAmount(arg_14_0)
	if not arg_14_0._bossEntityMO then
		return 0, 0
	end

	local var_14_0 = arg_14_0.oneMaxHp
	local var_14_1 = arg_14_0.tweenHp % var_14_0

	if var_14_1 == 0 and arg_14_0.tweenHp > 0 then
		var_14_1 = var_14_0
	end

	local var_14_2 = var_14_1 / var_14_0
	local var_14_3 = 0

	if var_14_0 >= arg_14_0.tweenShieldHp + var_14_1 then
		var_14_2 = var_14_1 / var_14_0
		var_14_3 = (arg_14_0.tweenShieldHp + var_14_1) / var_14_0
	else
		var_14_2 = var_14_1 / (var_14_1 + arg_14_0.tweenShieldHp)
		var_14_3 = 1
	end

	recthelper.setAnchorX(arg_14_0._hp_container_tran, 0)

	return var_14_2, var_14_3
end

var_0_0.HpCountColor = {
	Shield = "#1A1A1A",
	Normal = "#FFFFFF"
}

function var_0_0.refreshHpCount(arg_15_0)
	local var_15_0 = arg_15_0.tweenHp
	local var_15_1 = math.ceil(var_15_0 / arg_15_0.oneMaxHp)

	arg_15_0.txtSurvivalHpCount.text = "×" .. tostring(var_15_1)

	local var_15_2 = arg_15_0.tweenShieldHp > 0 and var_0_0.HpCountColor.Shield or var_0_0.HpCountColor.Normal

	SLFramework.UGUI.GuiHelper.SetColor(arg_15_0.txtSurvivalHpCount, var_15_2)
end

local var_0_1 = {
	0.3333333333333333,
	0.6666666666666666,
	1
}
local var_0_2 = {
	{
		"#B33E2D",
		"#6F2216"
	},
	{
		"#D9852B",
		"#693700"
	},
	{
		"#69995E",
		"#243B1E"
	}
}

function var_0_0.refreshHpColor(arg_16_0)
	if not arg_16_0._bossEntityMO then
		return
	end

	local var_16_0 = arg_16_0._bossEntityMO
	local var_16_1 = var_16_0.attrMO and var_16_0.attrMO.hp > 0 and var_16_0.attrMO.hp or 1
	local var_16_2 = arg_16_0.tweenHp
	local var_16_3 = arg_16_0:getColor()

	if var_16_2 <= arg_16_0.oneMaxHp then
		SLFramework.UGUI.GuiHelper.SetColor(arg_16_0.hp, var_16_3[1][1])
		gohelper.setActive(arg_16_0.bgHpGo, false)

		return
	end

	local var_16_4 = var_16_2 / var_16_1
	local var_16_5 = 1
	local var_16_6 = arg_16_0:getThreshold()

	for iter_16_0, iter_16_1 in ipairs(var_16_6) do
		if var_16_4 <= iter_16_1 then
			var_16_5 = iter_16_0

			break
		end
	end

	local var_16_7 = arg_16_0:getColor()

	gohelper.setActive(arg_16_0.bgHpGo, true)

	local var_16_8 = var_16_7[var_16_5]

	SLFramework.UGUI.GuiHelper.SetColor(arg_16_0.hp, var_16_8[1])
	SLFramework.UGUI.GuiHelper.SetColor(arg_16_0.bgHp, var_16_8[2])
end

function var_0_0.clearHpTween(arg_17_0)
	if arg_17_0.hpTweenId then
		ZProj.TweenHelper.KillById(arg_17_0.hpTweenId)

		arg_17_0.hpTweenId = nil
	end
end

function var_0_0.clearShieldTween(arg_18_0)
	if arg_18_0.shieldTweenId then
		ZProj.TweenHelper.KillById(arg_18_0.shieldTweenId)

		arg_18_0.shieldTweenId = nil
	end
end

function var_0_0.getThreshold(arg_19_0)
	return var_0_1
end

function var_0_0.getColor(arg_20_0)
	return var_0_2
end

function var_0_0._checkBossAndUpdate(arg_21_0)
	var_0_0.super._checkBossAndUpdate(arg_21_0)

	if not arg_21_0._bossEntityMO then
		arg_21_0:clearShieldTween()
		arg_21_0:clearHpTween()
	end
end

function var_0_0.onDestroyView(arg_22_0)
	arg_22_0:clearShieldTween()
	arg_22_0:clearHpTween()
	var_0_0.super.onDestroyView(arg_22_0)
end

return var_0_0
