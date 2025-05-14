module("modules.logic.rouge.view.RougeTeamHeroItem", package.seeall)

local var_0_0 = class("RougeTeamHeroItem", RougeLuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	var_0_0.super.init(arg_1_0, arg_1_1)

	arg_1_0._go = arg_1_1
	arg_1_0._heroGOParent = gohelper.findChild(arg_1_1, "hero")
	arg_1_0._heroItem = IconMgr.instance:getCommonHeroItem(arg_1_0._heroGOParent)

	arg_1_0._heroItem:hideFavor(true)
	arg_1_0._heroItem:addClickListener(arg_1_0._onItemClick, arg_1_0)

	arg_1_0._gohp = gohelper.findChild(arg_1_1, "#go_hp")
	arg_1_0._sliderhp = gohelper.findChildSlider(arg_1_1, "#go_hp/#slider_hp")
	arg_1_0._godead = gohelper.findChild(arg_1_1, "#go_dead")
	arg_1_0._goassit = gohelper.findChild(arg_1_1, "assit")
	arg_1_0._goFrame = gohelper.findChild(arg_1_1, "frame_hp")

	arg_1_0:_initCapacity()
	arg_1_0:_initObj(arg_1_1)
	arg_1_0:addEventCb(RougeController.instance, RougeEvent.OnTeamViewSelectedHeroPlayEffect, arg_1_0._onTeamViewSelectedHeroPlayEffect, arg_1_0)
end

function var_0_0._onTeamViewSelectedHeroPlayEffect(arg_2_0, arg_2_1)
	if not arg_2_0._isSelected then
		return
	end

	if arg_2_1 == RougeEnum.TeamType.Treat then
		local var_2_0 = gohelper.findChild(arg_2_0._go, "Reply")

		gohelper.setActive(var_2_0, true)
		TaskDispatcher.runDelay(arg_2_0._delayPlayHpEffect, arg_2_0, 0.6)

		return
	end

	if arg_2_1 == RougeEnum.TeamType.Revive then
		local var_2_1 = gohelper.findChild(arg_2_0._go, "Resurrection")

		gohelper.setActive(var_2_1, true)
		TaskDispatcher.runDelay(arg_2_0._delayPlayReviveEffect, arg_2_0, 0.6)

		return
	end

	if arg_2_1 == RougeEnum.TeamType.Assignment then
		local var_2_2 = gohelper.findChild(arg_2_0._go, "Dispatch")

		gohelper.setActive(var_2_2, true)

		return
	end
end

function var_0_0._delayPlayHpEffect(arg_3_0)
	arg_3_0._dotweenId = ZProj.TweenHelper.DOTweenFloat(arg_3_0._hpValue, 1, 1, arg_3_0.everyFrame, nil, arg_3_0)
end

function var_0_0.everyFrame(arg_4_0, arg_4_1)
	arg_4_0._sliderhp:SetValue(arg_4_1)
end

function var_0_0._delayPlayReviveEffect(arg_5_0)
	arg_5_0:_updateHp(1000)
end

function var_0_0._initCapacity(arg_6_0)
	arg_6_0._gopoint = gohelper.findChild(arg_6_0._go, "volume/point")

	gohelper.setActive(arg_6_0._gopoint, false)

	arg_6_0._capacityComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_6_0._go, RougeCapacityComp)

	arg_6_0._capacityComp:setSpriteType("rouge_team_volume_3", "rouge_team_volume_3")
	arg_6_0._capacityComp:setPoint(arg_6_0._gopoint)
	arg_6_0._capacityComp:initCapacity()
end

function var_0_0._initObj(arg_7_0, arg_7_1)
	arg_7_0._animator = arg_7_0._heroItem.go:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	arg_8_0._mo = arg_8_1

	arg_8_0._heroItem:onUpdateMO(arg_8_1)

	local var_8_0 = RougeHeroGroupBalanceHelper.getHeroBalanceLv(arg_8_1.heroId)

	if var_8_0 > arg_8_1.level then
		arg_8_0._heroItem:setBalanceLv(var_8_0)
	end

	if RougeController.instance:useHalfCapacity() then
		arg_8_0._capacity = RougeConfig1.instance:getRoleHalfCapacity(arg_8_1.config.rare)
	else
		arg_8_0._capacity = RougeConfig1.instance:getRoleCapacity(arg_8_1.config.rare)
	end

	arg_8_0._capacityComp:updateMaxNum(arg_8_0._capacity)
	arg_8_0:_updateStatus()
	arg_8_0:_updateSelected()
	arg_8_0:tickUpdateDLCs(arg_8_1)
end

function var_0_0._updateStatus(arg_9_0)
	local var_9_0 = RougeTeamListModel.instance:getHp(arg_9_0._mo)

	arg_9_0:_updateHp(var_9_0)
end

function var_0_0._updateHp(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1 <= 0
	local var_10_1 = RougeTeamListModel.instance:isInTeam(arg_10_0._mo)
	local var_10_2 = RougeTeamListModel.instance:isAssit(arg_10_0._mo)
	local var_10_3 = var_10_1 and 1 or 0

	arg_10_0._heroItem:setInteam(var_10_3)
	gohelper.setActive(arg_10_0._goassit, var_10_2)
	gohelper.setActive(arg_10_0._godead, var_10_0)

	arg_10_0._hpValue = arg_10_1 / 1000

	arg_10_0._sliderhp:SetValue(arg_10_0._hpValue)
	arg_10_0._heroItem:setNewShow(false)
	arg_10_0._heroItem:setDamage(var_10_0)

	arg_10_0._heroItem._isInjury = false

	gohelper.setActive(arg_10_0._heroItem._maskgray, var_10_0)
end

function var_0_0._onItemClick(arg_11_0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if RougeTeamListModel.instance:getTeamType() ~= RougeEnum.TeamType.View then
		RougeTeamListModel.instance:selectHero(arg_11_0._mo)
		arg_11_0:_updateSelected()
		RougeController.instance:dispatchEvent(RougeEvent.OnTeamViewSelectedHero)

		return
	end

	CharacterController.instance:openCharacterView(arg_11_0._mo, nil, {
		isOwnHero = false,
		hideHomeBtn = true,
		fromHeroDetailView = true,
		hideTrialTip = true
	})
end

function var_0_0._updateSelected(arg_12_0)
	local var_12_0 = RougeTeamListModel.instance:isHeroSelected(arg_12_0._mo)

	gohelper.setActive(arg_12_0._goFrame, var_12_0)

	arg_12_0._isSelected = var_12_0
end

function var_0_0.onDestroy(arg_13_0)
	if arg_13_0._dotweenId then
		ZProj.TweenHelper.KillById(arg_13_0._dotweenId, false)

		arg_13_0._dotweenId = nil
	end

	TaskDispatcher.cancelTask(arg_13_0._delayPlayHpEffect, arg_13_0)
	var_0_0.super.onDestroy(arg_13_0)
end

function var_0_0.getAnimator(arg_14_0)
	return arg_14_0._animator
end

return var_0_0
