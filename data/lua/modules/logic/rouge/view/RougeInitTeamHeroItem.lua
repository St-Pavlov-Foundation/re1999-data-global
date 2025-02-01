module("modules.logic.rouge.view.RougeInitTeamHeroItem", package.seeall)

slot0 = class("RougeInitTeamHeroItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._clickGO = gohelper.findChild(slot1, "clickarea")
	slot0._emptyGO = gohelper.findChild(slot1, "empty")
	slot0._selectedEffect = gohelper.findChild(slot1, "selectedeffect")
	slot0._clickThis = gohelper.getClick(slot0._clickGO)
	slot0._heroGOParent = gohelper.findChild(slot1, "heroitem")
end

function slot0.setIndex(slot0, slot1)
	slot0._index = slot1
end

function slot0.setRougeInitTeamView(slot0, slot1)
	slot0._teamView = slot1
end

function slot0.setHeroItem(slot0, slot1)
	slot0._heroItemGo = gohelper.clone(slot1, slot0._heroGOParent)

	gohelper.setActive(gohelper.findChild(slot0._heroItemGo, "#go_hp"), false)

	slot0._heroItem = IconMgr.instance:getCommonHeroItem(gohelper.findChild(slot0._heroItemGo, "hero"))

	slot0._heroItem:hideFavor(true)

	slot0._heroAnimator = slot0._heroItem.go:GetComponent(typeof(UnityEngine.Animator))

	slot0:_initCapacity()
end

function slot0._initCapacity(slot0)
	slot0._capacityComp = RougeCapacityComp.Add(gohelper.findChild(slot0._heroItemGo, "volume"), nil, , true)

	slot0._capacityComp:setSpriteType(RougeCapacityComp.SpriteType3, RougeCapacityComp.SpriteType3)
end

function slot0.addEventListeners(slot0)
	slot0._clickThis:AddClickListener(slot0._onClickThis, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._clickThis:RemoveClickListener()
end

function slot0.getHeroMo(slot0)
	return slot0._heroMO
end

function slot0.onUpdateMO(slot0, slot1)
	slot0.mo = slot1
	slot0._heroMO = slot1:getHeroMO()
	slot2 = slot0._heroMO ~= nil

	gohelper.setActive(slot0._emptyGO, not slot2)
	gohelper.setActive(slot0._heroGOParent, slot2)

	slot0._capacity = 0

	if slot2 then
		slot0._heroItem:onUpdateMO(slot0._heroMO)
		slot0._heroItem:setNewShow(false)

		slot0._capacity = RougeController.instance:getRoleStyleCapacity(slot0._heroMO)

		slot0._capacityComp:updateMaxNum(slot0._capacity)

		if slot0._heroMO.level < RougeHeroGroupBalanceHelper.getHeroBalanceLv(slot0._heroMO.heroId) then
			slot0._heroItem:setBalanceLv(slot3)
		end

		slot0:updateTrialTag()
	end
end

function slot0.setTrialValue(slot0, slot1)
	slot0._isTrial = slot1
end

function slot0.updateTrialTag(slot0)
	slot1 = nil

	if slot0._isTrial then
		slot1 = luaLang("herogroup_trial_tag0")
	end

	slot0._heroItem:setTrialTxt(slot1)
end

function slot0.showSelectEffect(slot0)
	slot0._heroAnimator:Play(UIAnimationName.Idle, 0, 0)
	gohelper.setActive(slot0._selectedEffect, false)
	gohelper.setActive(slot0._selectedEffect, true)
end

function slot0.getCapacity(slot0)
	return slot0._capacity
end

function slot0._onClickThis(slot0)
	if slot0._isTrial then
		return
	end

	slot1, slot2 = slot0._teamView:getCapacityProgress()

	if slot2 <= slot1 and not slot0._heroMO then
		GameFacade.showToast(ToastEnum.RougeTeamSelectHeroCapacityFull)

		return
	end

	slot0:_openRougeHeroGroupEditView(slot0.mo.id)
end

function slot0._openRougeHeroGroupEditView(slot0, slot1)
	slot2, slot3 = slot0._teamView:getNoneAssistCapacityProgress()

	ViewMgr.instance:openView(ViewName.RougeHeroGroupEditView, {
		singleGroupMOId = slot1,
		originalHeroUid = RougeHeroSingleGroupModel.instance:getHeroUid(slot1),
		equips = {
			"0"
		},
		heroGroupEditType = RougeEnum.HeroGroupEditType.Init,
		selectHeroCapacity = slot0._capacity,
		curCapacity = slot2,
		totalCapacity = slot3,
		assistCapacity = slot0._teamView:getAssistCapacity(),
		assistPos = slot0._teamView:getAssistPos(),
		assistHeroId = slot0._teamView:getAssistHeroId()
	})
end

function slot0.onDestroy(slot0)
	slot0._teamView = nil
end

return slot0
