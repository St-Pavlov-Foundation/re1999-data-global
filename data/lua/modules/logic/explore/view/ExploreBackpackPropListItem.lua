module("modules.logic.explore.view.ExploreBackpackPropListItem", package.seeall)

slot0 = class("ExploreBackpackPropListItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._goinuse = gohelper.findChild(slot0.go, "#go_inuse")
	slot0._click = gohelper.findChildButton(slot0.go, "#btn_click")

	slot0._click:AddClickListener(slot0._onItemClick, slot0)

	slot0._simagepropicon = gohelper.findChildSingleImage(slot0.go, "#simage_propicon")
	slot0._simageusepropicon = gohelper.findChildSingleImage(slot0.go, "#go_inuse/#simage_propicon")
	slot0._goselect = gohelper.findChild(slot0.go, "#go_selected")
	slot0._txtname = gohelper.findChildTextMesh(slot0.go, "#go_selected/#txt_propname")
	slot0._btnIconDetail = gohelper.findChildButton(slot0.go, "#go_selected/#txt_propname/icon")
end

function slot0.addEventListeners(slot0)
	slot0:addEventCb(ExploreController.instance, ExploreEvent.UseItemChanged, slot0._updateUsing, slot0)
	slot0:addEventCb(ExploreController.instance, ExploreEvent.MapStatusChange, slot0.onMapStatusChange, slot0)
	slot0:addEventCb(ExploreController.instance, ExploreEvent.OnHeroMoveEnd, slot0.onHeroMoveEnd, slot0)
	slot0:addEventCb(ExploreController.instance, ExploreEvent.ExploreLightBallEnterExit, slot0.onLightBallChange, slot0)
	slot0._btnIconDetail:AddClickListener(slot0.onDetailClick, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0:removeEventCb(ExploreController.instance, ExploreEvent.UseItemChanged, slot0._updateUsing, slot0)
	slot0:removeEventCb(ExploreController.instance, ExploreEvent.MapStatusChange, slot0.onMapStatusChange, slot0)
	slot0:removeEventCb(ExploreController.instance, ExploreEvent.OnHeroMoveEnd, slot0.onHeroMoveEnd, slot0)
	slot0:removeEventCb(ExploreController.instance, ExploreEvent.ExploreLightBallEnterExit, slot0.onLightBallChange, slot0)
	slot0._btnIconDetail:RemoveClickListener()
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot2 = ResUrl.getPropItemIcon(slot1.config.icon)

	slot0._simagepropicon:LoadImage(slot2)
	slot0._simageusepropicon:LoadImage(slot2)
	slot0:_updateUsing(ExploreModel.instance:getUseItemUid())

	slot0._txtname.text = slot0._mo.config.name

	slot0:onMapStatusChange(ExploreController.instance:getMap():getNowStatus())
end

function slot0.onLightBallChange(slot0)
	if not slot0._mo then
		return
	end

	if slot0._mo.itemEffect == ExploreEnum.ItemEffect.CreateUnit2 then
		slot0:_updateUsing()
	end
end

function slot0._updateUsing(slot0, slot1)
	if not slot0._mo then
		return
	end

	slot3 = slot1 == slot0._mo.id

	if slot0._mo.itemEffect == ExploreEnum.ItemEffect.CreateUnit2 then
		slot3 = ExploreController.instance:getMap():getUnit(tonumber(slot0._mo.id), true) and true or false
	end

	gohelper.setActive(slot0._goinuse, slot3)
end

function slot0._onItemClick(slot0)
	if slot0._mo.itemEffect == ExploreEnum.ItemEffect.Fix then
		ToastController.instance:showToast(ExploreConstValue.Toast.UseWithFixPrism)

		return
	end

	if not ExploreModel.instance:isHeroInControl() then
		ToastController.instance:showToast(ExploreConstValue.Toast.CantUseItem)

		return
	end

	if ExploreController.instance:getMap():getNowStatus() == ExploreEnum.MapStatus.UseItem then
		slot2:setMapStatus(ExploreEnum.MapStatus.Normal)

		if slot2:getCompByType(ExploreEnum.MapStatus.UseItem):getCurItemMo() == slot0._mo then
			return
		end
	elseif slot2:getNowStatus() == ExploreEnum.MapStatus.MoveUnit then
		ToastController.instance:showToast(ExploreConstValue.Toast.ExploreCantUseItem)

		return
	end

	if slot2:getUnit(tonumber(ExploreModel.instance:getUseItemUid()), true) and slot4:getUnitType() == ExploreEnum.ItemType.PipePot then
		ToastController.instance:showToast(ExploreConstValue.Toast.CantUseItem)

		return
	end

	if ExploreController.instance:getMap():getHero():isMoving() and ExploreMapModel.instance:getNode(ExploreHelper.getKey(slot5.nodePos)).nodeType == ExploreEnum.NodeType.Ice then
		return
	end

	if slot5:isMoving() then
		if not slot5:stopMoving() then
			return
		end

		ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.UseItem)

		slot0._waitHeroMoveEnd = true

		return
	end

	if slot1 == ExploreEnum.ItemEffect.CreateUnit2 and ExploreController.instance:getMap():getUnit(tonumber(slot0._mo.id), true) then
		slot5:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.UseItem, true, true)
		ExploreRpc.instance:sendExploreUseItemRequest(slot0._mo.id, 0, 0)

		return
	end

	if slot1 == ExploreEnum.ItemEffect.Active then
		slot5:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.UseItem, true, true)
	end

	if slot0._mo.isActiveTypeItem then
		ExploreRpc.instance:sendExploreUseItemRequest(slot0._mo.id, 0, 0)
	else
		ExploreController.instance:dispatchEvent(ExploreEvent.DragItemBegin, slot0._mo)
	end
end

function slot0.onHeroMoveEnd(slot0)
	if slot0._waitHeroMoveEnd then
		slot0._waitHeroMoveEnd = nil

		ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.UseItem)
		slot0:_onItemClick()
	end
end

function slot0.onDetailClick(slot0)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.ExploreGetItemView, {
		id = slot0._mo.itemId
	})
end

function slot0.onMapStatusChange(slot0, slot1)
	if slot1 == ExploreEnum.MapStatus.UseItem then
		if ExploreController.instance:getMap():getCompByType(ExploreEnum.MapStatus.UseItem):getCurItemMo() == slot0._mo then
			gohelper.setActive(slot0._goselect, true)
		else
			gohelper.setActive(slot0._goselect, false)
		end
	else
		gohelper.setActive(slot0._goselect, false)
	end
end

function slot0.onDestroyView(slot0)
	slot0._click:RemoveClickListener()

	if slot0._simagepropicon then
		slot0._simagepropicon:UnLoadImage()

		slot0._simagepropicon = nil
	end

	if slot0._simageusepropicon then
		slot0._simageusepropicon:UnLoadImage()

		slot0._simageusepropicon = nil
	end
end

return slot0
