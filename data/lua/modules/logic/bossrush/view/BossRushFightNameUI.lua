module("modules.logic.bossrush.view.BossRushFightNameUI", package.seeall)

local var_0_0 = class("BossRushFightNameUI", FightNameUI)

function var_0_0._onLoaded(arg_1_0)
	var_0_0.super._onLoaded(arg_1_0)

	arg_1_0._topHp = gohelper.findChildImage(arg_1_0._uiGO, "layout/top/hp/container/#img_unlimitedtophp")
	arg_1_0._botHp = gohelper.findChildImage(arg_1_0._uiGO, "layout/top/hp/container/#img_unlimitedbothp")

	arg_1_0:_checkBoss()

	if arg_1_0.isBoss then
		if arg_1_0._imgHp then
			gohelper.setActive(arg_1_0._imgHp.gameObject, false)
		end

		local var_1_0 = arg_1_0:_getFillAmount()
		local var_1_1 = 0.5 / FightModel.instance:getUISpeed()

		arg_1_0._imgHp = arg_1_0._topHp
		arg_1_0._imgHp.fillAmount = var_1_0
		arg_1_0._unlimitHp = BossRushModel.instance._unlimitHp

		if arg_1_0._unlimitHp then
			arg_1_0:_onChangeUnlimitedHpColor(arg_1_0._unlimitHp.index)
			ZProj.TweenHelper.KillByObj(arg_1_0._imgHp)

			if var_1_0 > arg_1_0._unlimitHp.fillAmount then
				ZProj.TweenHelper.DOFillAmount(arg_1_0._imgHp, arg_1_0._unlimitHp.fillAmount, var_1_1)
			else
				arg_1_0._imgHp.fillAmount = arg_1_0._unlimitHp.fillAmount
			end

			gohelper.setActive(arg_1_0._botHp.gameObject, true)
		else
			gohelper.setActive(arg_1_0._botHp.gameObject, false)
			SLFramework.UGUI.GuiHelper.SetColor(arg_1_0._topHp, "#9C4F30")
		end

		gohelper.setActive(arg_1_0._topHp.gameObject, true)
	else
		gohelper.setActive(arg_1_0._topHp.gameObject, false)
		gohelper.setActive(arg_1_0._botHp.gameObject, false)
	end

	BossRushController.instance:registerCallback(BossRushEvent.OnUnlimitedHp, arg_1_0._onUnlimitedHp, arg_1_0)
end

function var_0_0.beforeDestroy(arg_2_0)
	var_0_0.super.beforeDestroy(arg_2_0)
	BossRushController.instance:unregisterCallback(BossRushEvent.OnUnlimitedHp, arg_2_0._onUnlimitedHp, arg_2_0)
end

function var_0_0._checkBoss(arg_3_0)
	local var_3_0 = FightModel.instance:getCurMonsterGroupId()
	local var_3_1 = var_3_0 and lua_monster_group.configDict[var_3_0]
	local var_3_2 = var_3_1 and not string.nilorempty(var_3_1.bossId) and var_3_1.bossId or nil
	local var_3_3 = arg_3_0.entity:getMO():getCO().id

	arg_3_0.isBoss = FightHelper.isBossId(var_3_2, var_3_3)
end

function var_0_0._onChangeUnlimitedHpColor(arg_4_0, arg_4_1)
	if not arg_4_0.isBoss then
		return
	end

	local var_4_0, var_4_1 = BossRushModel.instance:getUnlimitedTopAndBotHpColor(arg_4_1)

	SLFramework.UGUI.GuiHelper.SetColor(arg_4_0._topHp, var_4_0)
	SLFramework.UGUI.GuiHelper.SetColor(arg_4_0._botHp, var_4_1)
	gohelper.setActive(arg_4_0._botHp.gameObject, true)
end

function var_0_0._onUnlimitedHp(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0.isBoss then
		arg_5_0._unlimitHp = BossRushModel.instance._unlimitHp

		ZProj.TweenHelper.KillByObj(arg_5_0._imgHp)

		if arg_5_0._unlimitHp then
			local var_5_0 = arg_5_0._topHp.fillAmount
			local var_5_1 = 0.5 / FightModel.instance:getUISpeed()

			if var_5_0 < var_5_0 then
				arg_5_0._topHp.fillAmount = 1
			end

			ZProj.TweenHelper.DOFillAmount(arg_5_0._imgHp, arg_5_2, var_5_1)
			arg_5_0:_onChangeUnlimitedHpColor(arg_5_1)
			gohelper.setActive(arg_5_0._botHp.gameObject, true)
		else
			gohelper.setActive(arg_5_0._botHp.gameObject, false)
		end
	end
end

return var_0_0
