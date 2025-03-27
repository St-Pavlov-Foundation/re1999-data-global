module("modules.logic.rouge.view.RougeTeamHeroItem", package.seeall)

slot0 = class("RougeTeamHeroItem", RougeLuaCompBase)

function slot0.init(slot0, slot1)
	uv0.super.init(slot0, slot1)

	slot0._go = slot1
	slot0._heroGOParent = gohelper.findChild(slot1, "hero")
	slot0._heroItem = IconMgr.instance:getCommonHeroItem(slot0._heroGOParent)

	slot0._heroItem:hideFavor(true)
	slot0._heroItem:addClickListener(slot0._onItemClick, slot0)

	slot0._gohp = gohelper.findChild(slot1, "#go_hp")
	slot0._sliderhp = gohelper.findChildSlider(slot1, "#go_hp/#slider_hp")
	slot0._godead = gohelper.findChild(slot1, "#go_dead")
	slot0._goassit = gohelper.findChild(slot1, "assit")
	slot0._goFrame = gohelper.findChild(slot1, "frame_hp")

	slot0:_initCapacity()
	slot0:_initObj(slot1)
	slot0:addEventCb(RougeController.instance, RougeEvent.OnTeamViewSelectedHeroPlayEffect, slot0._onTeamViewSelectedHeroPlayEffect, slot0)
end

function slot0._onTeamViewSelectedHeroPlayEffect(slot0, slot1)
	if not slot0._isSelected then
		return
	end

	if slot1 == RougeEnum.TeamType.Treat then
		gohelper.setActive(gohelper.findChild(slot0._go, "Reply"), true)
		TaskDispatcher.runDelay(slot0._delayPlayHpEffect, slot0, 0.6)

		return
	end

	if slot1 == RougeEnum.TeamType.Revive then
		gohelper.setActive(gohelper.findChild(slot0._go, "Resurrection"), true)
		TaskDispatcher.runDelay(slot0._delayPlayReviveEffect, slot0, 0.6)

		return
	end

	if slot1 == RougeEnum.TeamType.Assignment then
		gohelper.setActive(gohelper.findChild(slot0._go, "Dispatch"), true)

		return
	end
end

function slot0._delayPlayHpEffect(slot0)
	slot0._dotweenId = ZProj.TweenHelper.DOTweenFloat(slot0._hpValue, 1, 1, slot0.everyFrame, nil, slot0)
end

function slot0.everyFrame(slot0, slot1)
	slot0._sliderhp:SetValue(slot1)
end

function slot0._delayPlayReviveEffect(slot0)
	slot0:_updateHp(1000)
end

function slot0._initCapacity(slot0)
	slot0._gopoint = gohelper.findChild(slot0._go, "volume/point")

	gohelper.setActive(slot0._gopoint, false)

	slot0._capacityComp = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._go, RougeCapacityComp)

	slot0._capacityComp:setSpriteType("rouge_team_volume_3", "rouge_team_volume_3")
	slot0._capacityComp:setPoint(slot0._gopoint)
	slot0._capacityComp:initCapacity()
end

function slot0._initObj(slot0, slot1)
	slot0._animator = slot0._heroItem.go:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0._heroItem:onUpdateMO(slot1)

	if slot1.level < RougeHeroGroupBalanceHelper.getHeroBalanceLv(slot1.heroId) then
		slot0._heroItem:setBalanceLv(slot2)
	end

	if RougeController.instance:useHalfCapacity() then
		slot0._capacity = RougeConfig1.instance:getRoleHalfCapacity(slot1.config.rare)
	else
		slot0._capacity = RougeConfig1.instance:getRoleCapacity(slot1.config.rare)
	end

	slot0._capacityComp:updateMaxNum(slot0._capacity)
	slot0:_updateStatus()
	slot0:_updateSelected()
	slot0:tickUpdateDLCs(slot1)
end

function slot0._updateStatus(slot0)
	slot0:_updateHp(RougeTeamListModel.instance:getHp(slot0._mo))
end

function slot0._updateHp(slot0, slot1)
	slot2 = slot1 <= 0

	slot0._heroItem:setInteam(RougeTeamListModel.instance:isInTeam(slot0._mo) and 1 or 0)
	gohelper.setActive(slot0._goassit, RougeTeamListModel.instance:isAssit(slot0._mo))
	gohelper.setActive(slot0._godead, slot2)

	slot0._hpValue = slot1 / 1000

	slot0._sliderhp:SetValue(slot0._hpValue)
	slot0._heroItem:setNewShow(false)
	slot0._heroItem:setDamage(slot2)

	slot0._heroItem._isInjury = false

	gohelper.setActive(slot0._heroItem._maskgray, slot2)
end

function slot0._onItemClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Universal_Click)

	if RougeTeamListModel.instance:getTeamType() ~= RougeEnum.TeamType.View then
		RougeTeamListModel.instance:selectHero(slot0._mo)
		slot0:_updateSelected()
		RougeController.instance:dispatchEvent(RougeEvent.OnTeamViewSelectedHero)

		return
	end

	CharacterController.instance:openCharacterView(slot0._mo, nil, {
		isOwnHero = false,
		hideHomeBtn = true,
		fromHeroDetailView = true,
		hideTrialTip = true
	})
end

function slot0._updateSelected(slot0)
	slot1 = RougeTeamListModel.instance:isHeroSelected(slot0._mo)

	gohelper.setActive(slot0._goFrame, slot1)

	slot0._isSelected = slot1
end

function slot0.onDestroy(slot0)
	if slot0._dotweenId then
		ZProj.TweenHelper.KillById(slot0._dotweenId, false)

		slot0._dotweenId = nil
	end

	TaskDispatcher.cancelTask(slot0._delayPlayHpEffect, slot0)
	uv0.super.onDestroy(slot0)
end

function slot0.getAnimator(slot0)
	return slot0._animator
end

return slot0
