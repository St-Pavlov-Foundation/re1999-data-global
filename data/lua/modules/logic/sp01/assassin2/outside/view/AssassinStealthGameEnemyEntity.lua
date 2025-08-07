module("modules.logic.sp01.assassin2.outside.view.AssassinStealthGameEnemyEntity", package.seeall)

local var_0_0 = class("AssassinStealthGameEnemyEntity", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.uid = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0.trans = arg_2_0.go.transform
	arg_2_0.transParent = arg_2_0.trans.parent
	arg_2_0._imagehead = gohelper.findChildImage(arg_2_0.go, "#simage_head")
	arg_2_0._gonormal = gohelper.findChild(arg_2_0.go, "#go_normal")
	arg_2_0._godead = gohelper.findChild(arg_2_0.go, "#go_dead")
	arg_2_0._imagehead2 = gohelper.findChildImage(arg_2_0.go, "#go_dead/#simage_head")
	arg_2_0._gocanRemove = gohelper.findChild(arg_2_0.go, "#go_dead/#go_canRemove")

	local var_2_0 = AssassinConfig.instance:getAssassinActPower(AssassinEnum.HeroAct.HandleBody)
	local var_2_1 = gohelper.findChild(arg_2_0.go, "#go_dead/#go_canRemove/#go_apLayout")

	arg_2_0._removeApComp = MonoHelper.addNoUpdateLuaComOnceToGo(var_2_1, AssassinStealthGameAPComp)

	arg_2_0._removeApComp:setAPCount(var_2_0)

	arg_2_0._gocanClick = gohelper.findChild(arg_2_0.go, "#go_canClick")
	arg_2_0._btnclick = gohelper.findChildClickWithAudio(arg_2_0.go, "#btn_click", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	arg_2_0._effectComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_2_0.go, AssassinStealthGameEffectComp)
	arg_2_0.monsterId = AssassinStealthGameModel.instance:getEnemyMo(arg_2_0.uid, true):getMonsterId()
	arg_2_0.go.name = string.format("%s", arg_2_0.monsterId)

	local var_2_2 = AssassinConfig.instance:getEnemyHeadIcon(arg_2_0.monsterId)

	UISpriteSetMgr.instance:setSp01AssassinSprite(arg_2_0._imagehead, var_2_2)
	UISpriteSetMgr.instance:setSp01AssassinSprite(arg_2_0._imagehead2, var_2_2)

	arg_2_0._godefend = gohelper.findChild(arg_2_0.go, "#go_defend")

	local var_2_3 = AssassinConfig.instance:getEnemyIsNotMove(arg_2_0.monsterId)

	gohelper.setActive(arg_2_0._godefend, var_2_3)

	arg_2_0._goboss = gohelper.findChild(arg_2_0.go, "#go_boss")
	arg_2_0._gotarget = gohelper.findChild(arg_2_0.go, "#go_target")
	arg_2_0._gobuff = gohelper.findChild(arg_2_0.go, "#go_buff")
	arg_2_0._gopetrifact = gohelper.findChild(arg_2_0.go, "#go_buff/#go_petrifact")
	arg_2_0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_2_0.go)

	arg_2_0:refresh()
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0._btnclick:AddClickListener(arg_3_0._btnclickOnClick, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_5_0)
	AssassinStealthGameController.instance:clickEnemyEntity(arg_5_0.uid)
end

function var_0_0.changeParent(arg_6_0, arg_6_1)
	if gohelper.isNil(arg_6_1) then
		return
	end

	arg_6_0.trans:SetParent(arg_6_1)

	arg_6_0.transParent = arg_6_1
end

function var_0_0.refresh(arg_7_0, arg_7_1)
	arg_7_0:refreshStatus()
	arg_7_0:refreshPos()
	arg_7_0:refreshSelected()
	arg_7_0:refreshCanRemove()
	arg_7_0:refreshCanClick()
	arg_7_0:playEffect(arg_7_1)
end

function var_0_0.refreshStatus(arg_8_0)
	local var_8_0 = AssassinStealthGameModel.instance:getEnemyMo(arg_8_0.uid, true):getIsDead()

	if var_8_0 then
		gohelper.setActive(arg_8_0._goboss, false)
		gohelper.setActive(arg_8_0._gonormal, false)
		gohelper.setActive(arg_8_0._gotarget, false)
		gohelper.setActive(arg_8_0._gobuff, false)
	else
		local var_8_1 = AssassinConfig.instance:getEnemyIsBoss(arg_8_0.monsterId)

		gohelper.setActive(arg_8_0._goboss, var_8_1)
		gohelper.setActive(arg_8_0._gonormal, not var_8_1)

		local var_8_2 = false
		local var_8_3 = AssassinStealthGameModel.instance:getMissionId()
		local var_8_4 = AssassinConfig.instance:getTargetEnemies(var_8_3)

		if var_8_4 then
			for iter_8_0, iter_8_1 in ipairs(var_8_4) do
				if iter_8_1 == arg_8_0.monsterId then
					var_8_2 = true

					break
				end
			end
		end

		gohelper.setActive(arg_8_0._gotarget, var_8_2)
		gohelper.setActive(arg_8_0._gobuff, true)
		arg_8_0:refreshBuff()
	end

	gohelper.setActive(arg_8_0._godead, var_8_0)
end

function var_0_0.refreshBuff(arg_9_0)
	local var_9_0 = AssassinStealthGameModel.instance:getEnemyMo(arg_9_0.uid, true)
	local var_9_1 = var_9_0:hasBuffType(AssassinEnum.StealGameBuffType.Petrifaction)

	gohelper.setActive(arg_9_0._gopetrifact, var_9_1)

	local var_9_2 = AssassinConfig.instance:getBuffIdList()

	for iter_9_0, iter_9_1 in ipairs(var_9_2) do
		local var_9_3 = AssassinConfig.instance:getAssassinBuffEffectId(iter_9_1)

		if var_9_0:hasBuff(iter_9_1) then
			arg_9_0:playEffect(var_9_3)
		else
			arg_9_0:removeEffect(var_9_3)
		end
	end
end

function var_0_0.refreshPos(arg_10_0)
	local var_10_0, var_10_1 = AssassinStealthGameModel.instance:getEnemyMo(arg_10_0.uid, true):getPos()
	local var_10_2 = AssassinStealthGameEntityMgr.instance:getGridPointGoPosInEntityLayer(var_10_0, var_10_1, arg_10_0.transParent)

	transformhelper.setLocalPosXY(arg_10_0.trans, var_10_2.x, var_10_2.y)
end

function var_0_0.refreshSelected(arg_11_0)
	return
end

function var_0_0.refreshCanRemove(arg_12_0)
	local var_12_0 = AssassinStealthGameHelper.isSelectedHeroCanRemoveEnemyBody(arg_12_0.uid)

	if arg_12_0._gocanRemove.activeSelf == var_12_0 then
		return
	end

	gohelper.setActive(arg_12_0._gocanRemove, var_12_0)

	if var_12_0 then
		arg_12_0._animatorPlayer:Play("search", nil, arg_12_0)
	end
end

function var_0_0.refreshCanClick(arg_13_0)
	local var_13_0 = AssassinStealthGameHelper.isSelectedHeroCanRemoveEnemyBody(arg_13_0.uid)
	local var_13_1 = AssassinStealthGameHelper.isSelectedHeroCanUseSkillPropToEnemy(arg_13_0.uid)
	local var_13_2 = AssassinStealthGameHelper.isSelectedHeroCanSelectEnemy(arg_13_0.uid)

	gohelper.setActive(arg_13_0._gocanClick, var_13_0 or var_13_1 or var_13_2)
end

function var_0_0.playRemove(arg_14_0)
	arg_14_0._animatorPlayer:Play("close", arg_14_0.destroy, arg_14_0)
end

function var_0_0.playEffect(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4, arg_15_5)
	if arg_15_0._effectComp then
		arg_15_0._effectComp:playEffect(arg_15_1, arg_15_2, arg_15_3, arg_15_4, nil, nil, arg_15_5)
	end
end

function var_0_0.removeEffect(arg_16_0, arg_16_1)
	if not arg_16_0._effectComp or not arg_16_1 or arg_16_1 == 0 then
		return
	end

	arg_16_0._effectComp:removeEffect(arg_16_1)
end

function var_0_0.getLocalPos(arg_17_0)
	return transformhelper.getLocalPos(arg_17_0.trans)
end

function var_0_0.destroy(arg_18_0)
	arg_18_0.go:DestroyImmediate()
end

function var_0_0.onDestroy(arg_19_0)
	arg_19_0.uid = nil
	arg_19_0.monsterId = nil
end

return var_0_0
