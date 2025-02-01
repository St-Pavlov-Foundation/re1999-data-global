module("modules.logic.rouge.view.RougePickAssistItem", package.seeall)

slot0 = class("RougePickAssistItem", PickAssistItem)

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)
	slot0:_initCapacity()
end

function slot0._initCapacity(slot0)
	slot0._capacityComp = RougeCapacityComp.Add(gohelper.findChild(slot0.viewGO, "volume"), nil, , true)

	slot0._capacityComp:setSpriteType(RougeCapacityComp.SpriteType3, RougeCapacityComp.SpriteType3)
end

function slot0.onUpdateMO(slot0, slot1)
	uv0.super.onUpdateMO(slot0, slot1)

	slot2 = slot0._mo.heroMO

	if slot2.level < RougeHeroGroupBalanceHelper.getHeroBalanceLv(slot2.heroId) then
		slot0._heroItem:setBalanceLv(slot3)
	end

	slot4 = RougeConfig1.instance:getRoleCapacity(slot1.heroMO.config.rare)
	slot0._capacity = slot4

	slot0._capacityComp:updateMaxNum(slot4)
end

function slot0._checkClick(slot0)
	slot1 = RougeController.instance.pickAssistViewParams

	if slot1.totalCapacity < slot1.curCapacity + slot0._capacity then
		GameFacade.showToast(ToastEnum.RougeTeamSelectHeroCapacityFull)

		return false
	end

	return true
end

return slot0
