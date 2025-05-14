module("modules.logic.bossrush.view.BossRushFightViewBossHp", package.seeall)

local var_0_0 = class("BossRushFightViewBossHp", FightViewBossHp)

function var_0_0.onInitView(arg_1_0)
	FightViewBossHp.onInitView(arg_1_0)

	arg_1_0._gounlimited = gohelper.findChild(arg_1_0.viewGO, "Alpha/bossHp/mask/container/imgHp/#go_unlimited")
	arg_1_0._imgunlimited = gohelper.findChildImage(arg_1_0.viewGO, "Alpha/bossHp/mask/container/unlimitedhp")

	local var_1_0 = gohelper.findChild(arg_1_0._gounlimited, "vx_hp")

	arg_1_0._vxColor = {
		[BossRushEnum.HpColor.Red] = gohelper.findChild(var_1_0, "red"),
		[BossRushEnum.HpColor.Orange] = gohelper.findChild(var_1_0, "orange"),
		[BossRushEnum.HpColor.Yellow] = gohelper.findChild(var_1_0, "yellow"),
		[BossRushEnum.HpColor.Green] = gohelper.findChild(var_1_0, "green"),
		[BossRushEnum.HpColor.Blue] = gohelper.findChild(var_1_0, "blue"),
		[BossRushEnum.HpColor.Purple] = gohelper.findChild(var_1_0, "purple")
	}
end

local var_0_1 = "ui/viewres/bossrush/bossrushfightviewbosshpext.prefab"

function var_0_0.onOpen(arg_2_0)
	arg_2_0._damage = 0

	arg_2_0:_resetUnlimitedHp()
	var_0_0.super.onOpen(arg_2_0)
end

function var_0_0.onClose(arg_3_0)
	var_0_0.super.onClose(arg_3_0)
	arg_3_0:_resetUnlimitedHp()
end

function var_0_0._onHpChange(arg_4_0, arg_4_1, arg_4_2)
	var_0_0.super._onHpChange(arg_4_0, arg_4_1, arg_4_2)

	if arg_4_2 ~= 0 and arg_4_0._bossEntityMO and arg_4_1.id == arg_4_0._bossEntityMO.id then
		if arg_4_0._isUnlimitedHp then
			arg_4_0._damage = arg_4_0._damage + arg_4_2

			arg_4_0:_checkUnlimitedHp()
		else
			arg_4_0._damage = 0
		end
	end
end

function var_0_0._checkUnlimitedHp(arg_5_0)
	local var_5_0 = arg_5_0:_getFinalBossHp()
	local var_5_1 = Mathf.Abs(arg_5_0._damage / var_5_0)
	local var_5_2 = Mathf.Floor(var_5_1)
	local var_5_3 = Mathf.Abs(arg_5_0._damage) % var_5_0
	local var_5_4 = 0.5 / FightModel.instance:getUISpeed()
	local var_5_5 = (var_5_0 - var_5_3) / var_5_0

	arg_5_0._unlimitedFillAmount = var_5_5

	ZProj.TweenHelper.KillByObj(arg_5_0._imgHp)

	if var_5_5 > arg_5_0._imgHp.fillAmount and arg_5_0._curShield == 0 then
		local var_5_6 = arg_5_0._imgHp.fillAmount + var_5_5
		local var_5_7 = arg_5_0._imgHp.fillAmount / var_5_6 * var_5_4

		arg_5_0._unlimitedTime2 = var_5_4 - var_5_7

		ZProj.TweenHelper.DOFillAmount(arg_5_0._imgHp, 0, var_5_7)

		if arg_5_0._curShield == 0 then
			ZProj.TweenHelper.KillByObj(arg_5_0._imgHpShield)

			arg_5_0._imgHpShield.fillAmount = 0
		end

		TaskDispatcher.cancelTask(arg_5_0._onEndTween, arg_5_0)
		TaskDispatcher.runDelay(arg_5_0._onEndTween, arg_5_0, var_5_7)
	else
		ZProj.TweenHelper.DOFillAmount(arg_5_0._imgHp, var_5_5, var_5_4)
		BossRushModel.instance:syncUnlimitedHp(nil, var_5_5)
	end
end

function var_0_0._onEndTween(arg_6_0)
	local var_6_0, var_6_1 = arg_6_0:_getFillAmount()

	if arg_6_0._unlimitedFillAmount then
		var_6_0 = arg_6_0._unlimitedFillAmount

		arg_6_0:_changeUnlimitedHpColor(arg_6_0._unlimitedHpNum + 1, var_6_0)
		ZProj.TweenHelper.KillByObj(arg_6_0._imgHp)

		arg_6_0._imgHp.fillAmount = 1

		ZProj.TweenHelper.DOFillAmount(arg_6_0._imgHp, var_6_0, arg_6_0._unlimitedTime2 or 0.5)
	end

	arg_6_0:_changeShieldPos(var_6_0)
	ZProj.TweenHelper.KillByObj(arg_6_0._imgHpShield)

	arg_6_0._imgHpShield.fillAmount = var_6_1
end

function var_0_0._updateUI(arg_7_0)
	var_0_0.super._updateUI(arg_7_0)

	if arg_7_0._unlimitedHpNum and arg_7_0._unlimitedHpNum > 0 then
		local var_7_0 = arg_7_0:_getFinalBossHp()
		local var_7_1 = Mathf.Abs(arg_7_0._damage) % var_7_0
		local var_7_2 = var_7_0 - arg_7_0._curHp

		if arg_7_0._curHp ~= var_7_0 - var_7_1 then
			arg_7_0._damage = -(var_7_0 * arg_7_0._unlimitedHpNum + var_7_2)
		end
	end
end

function var_0_0._detectBossMultiHp(arg_8_0)
	local var_8_0 = BossRushModel.instance:getMultiHpInfo()
	local var_8_1 = var_8_0.multiHpIdx
	local var_8_2 = var_8_0.multiHpNum

	if not arg_8_0._hpMultiAni or var_8_1 == 0 then
		arg_8_0._hpMultiAni = {}
	end

	gohelper.setActive(arg_8_0._multiHpRoot, var_8_2 > 1)

	if var_8_2 > 1 then
		arg_8_0:com_createObjList(arg_8_0._onMultiHpItemShow, var_8_2, arg_8_0._multiHpItemContent, arg_8_0._multiHpItem)
	end

	gohelper.setActive(arg_8_0._multiHpItem.gameObject, true)

	local var_8_3 = gohelper.findChild(arg_8_0._multiHpItem.gameObject, "hp_unlimited")
	local var_8_4 = gohelper.findChild(arg_8_0._multiHpItem.gameObject, "hp")

	gohelper.setActive(var_8_3, true)
	gohelper.setActive(var_8_4, false)
	arg_8_0._multiHpItem.transform:SetSiblingIndex(0)

	if not arg_8_0._lastMultiHpIdx or arg_8_0._lastMultiHpIdx ~= var_8_1 then
		arg_8_0:_oneHpClear(var_8_1 - var_8_2 + 1)
	end

	arg_8_0._lastMultiHpIdx = var_8_1

	if arg_8_0._imgHp.fillAmount == 0 then
		ZProj.TweenHelper.KillByObj(arg_8_0._imgHp)

		arg_8_0._imgHp.fillAmount = 1
	end
end

local var_0_2 = "idle"
local var_0_3 = "close"

function var_0_0._onMultiHpItemShow(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_3 == 1 then
		gohelper.setActive(arg_9_1, false)
	else
		local var_9_0 = BossRushModel.instance:getMultiHpInfo()
		local var_9_1 = var_9_0.multiHpIdx
		local var_9_2 = var_9_0.multiHpNum
		local var_9_3 = gohelper.findChild(arg_9_1, "hp")
		local var_9_4 = arg_9_1:GetComponent(typeof(UnityEngine.Animator))
		local var_9_5 = arg_9_3 <= var_9_2 - var_9_1

		if not arg_9_0._hpMultiAni[arg_9_3] then
			gohelper.setActive(var_9_3, var_9_5)

			arg_9_0._hpMultiAni[arg_9_3] = var_9_5 and var_0_2 or var_0_3
		else
			local var_9_6 = var_9_5 and var_0_2 or var_0_3

			if arg_9_0._hpMultiAni[arg_9_3] ~= var_9_6 then
				arg_9_0._hpMultiAni[arg_9_3] = var_9_6

				var_9_4:Play(arg_9_0._hpMultiAni[arg_9_3])
			end
		end
	end
end

function var_0_0._changeUnlimitedHpColor(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0, var_10_1, var_10_2 = BossRushModel.instance:getUnlimitedTopAndBotHpColor(arg_10_1)

	SLFramework.UGUI.GuiHelper.SetColor(arg_10_0._imgHp, var_10_0)
	SLFramework.UGUI.GuiHelper.SetColor(arg_10_0._imgunlimited, var_10_1)

	for iter_10_0, iter_10_1 in ipairs(arg_10_0._vxColor) do
		gohelper.setActive(iter_10_1, iter_10_0 == var_10_2)
	end

	BossRushModel.instance:syncUnlimitedHp(arg_10_1, arg_10_2)
	BossRushController.instance:dispatchEvent(BossRushEvent.OnUnlimitedHp, arg_10_1, arg_10_2)
end

function var_0_0._oneHpClear(arg_11_0, arg_11_1)
	arg_11_0._unlimitedHpNum = arg_11_1

	if arg_11_0._unlimitedHpNum >= 0 then
		arg_11_0._isUnlimitedHp = true

		gohelper.setActive(arg_11_0._gounlimited, true)
		gohelper.setActive(arg_11_0._imgunlimited.gameObject, true)
	end

	if arg_11_0._unlimitedHpNum == 0 then
		ZProj.TweenHelper.KillByObj(arg_11_0._imgHp)

		arg_11_0._imgHp.fillAmount = 1

		arg_11_0:_changeUnlimitedHpColor(arg_11_0._unlimitedHpNum, 1)
	end
end

function var_0_0._getFinalBossHp(arg_12_0)
	local var_12_0 = arg_12_0._bossEntityMO

	if var_12_0 then
		return var_12_0.attrMO and var_12_0.attrMO.hp > 0 and var_12_0.attrMO.hp or 1
	end
end

function var_0_0._resetUnlimitedHp(arg_13_0)
	arg_13_0._unlimitedHpNum = nil
	arg_13_0._isUnlimitedHp = nil

	ZProj.TweenHelper.KillByObj(arg_13_0._imgHp)
	TaskDispatcher.cancelTask(arg_13_0._onEndTween, arg_13_0)
	gohelper.setActive(arg_13_0._gounlimited, false)
	gohelper.setActive(arg_13_0._imgunlimited, false)
	BossRushModel.instance:resetUnlimitedHp()
end

function var_0_0._onMonsterChange(arg_14_0, arg_14_1, arg_14_2)
	var_0_0.super._onMonsterChange(arg_14_0, arg_14_1, arg_14_2)

	if arg_14_2 then
		BossRushController.instance:_refreshCurBossHP()
	end
end

return var_0_0
