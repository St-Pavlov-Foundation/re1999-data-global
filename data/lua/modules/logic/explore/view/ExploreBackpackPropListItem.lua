module("modules.logic.explore.view.ExploreBackpackPropListItem", package.seeall)

local var_0_0 = class("ExploreBackpackPropListItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._goinuse = gohelper.findChild(arg_1_0.go, "#go_inuse")
	arg_1_0._click = gohelper.findChildButton(arg_1_0.go, "#btn_click")

	arg_1_0._click:AddClickListener(arg_1_0._onItemClick, arg_1_0)

	arg_1_0._simagepropicon = gohelper.findChildSingleImage(arg_1_0.go, "#simage_propicon")
	arg_1_0._simageusepropicon = gohelper.findChildSingleImage(arg_1_0.go, "#go_inuse/#simage_propicon")
	arg_1_0._goselect = gohelper.findChild(arg_1_0.go, "#go_selected")
	arg_1_0._txtname = gohelper.findChildTextMesh(arg_1_0.go, "#go_selected/#txt_propname")
	arg_1_0._btnIconDetail = gohelper.findChildButton(arg_1_0.go, "#go_selected/#txt_propname/icon")
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addEventCb(ExploreController.instance, ExploreEvent.UseItemChanged, arg_2_0._updateUsing, arg_2_0)
	arg_2_0:addEventCb(ExploreController.instance, ExploreEvent.MapStatusChange, arg_2_0.onMapStatusChange, arg_2_0)
	arg_2_0:addEventCb(ExploreController.instance, ExploreEvent.OnHeroMoveEnd, arg_2_0.onHeroMoveEnd, arg_2_0)
	arg_2_0:addEventCb(ExploreController.instance, ExploreEvent.ExploreLightBallEnterExit, arg_2_0.onLightBallChange, arg_2_0)
	arg_2_0._btnIconDetail:AddClickListener(arg_2_0.onDetailClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0:removeEventCb(ExploreController.instance, ExploreEvent.UseItemChanged, arg_3_0._updateUsing, arg_3_0)
	arg_3_0:removeEventCb(ExploreController.instance, ExploreEvent.MapStatusChange, arg_3_0.onMapStatusChange, arg_3_0)
	arg_3_0:removeEventCb(ExploreController.instance, ExploreEvent.OnHeroMoveEnd, arg_3_0.onHeroMoveEnd, arg_3_0)
	arg_3_0:removeEventCb(ExploreController.instance, ExploreEvent.ExploreLightBallEnterExit, arg_3_0.onLightBallChange, arg_3_0)
	arg_3_0._btnIconDetail:RemoveClickListener()
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0._mo = arg_4_1

	local var_4_0 = ResUrl.getPropItemIcon(arg_4_1.config.icon)

	arg_4_0._simagepropicon:LoadImage(var_4_0)
	arg_4_0._simageusepropicon:LoadImage(var_4_0)
	arg_4_0:_updateUsing(ExploreModel.instance:getUseItemUid())

	arg_4_0._txtname.text = arg_4_0._mo.config.name

	arg_4_0:onMapStatusChange(ExploreController.instance:getMap():getNowStatus())
end

function var_0_0.onLightBallChange(arg_5_0)
	if not arg_5_0._mo then
		return
	end

	if arg_5_0._mo.itemEffect == ExploreEnum.ItemEffect.CreateUnit2 then
		arg_5_0:_updateUsing()
	end
end

function var_0_0._updateUsing(arg_6_0, arg_6_1)
	if not arg_6_0._mo then
		return
	end

	local var_6_0 = arg_6_0._mo.itemEffect
	local var_6_1 = arg_6_1 == arg_6_0._mo.id

	if var_6_0 == ExploreEnum.ItemEffect.CreateUnit2 then
		var_6_1 = ExploreController.instance:getMap():getUnit(tonumber(arg_6_0._mo.id), true) and true or false
	end

	gohelper.setActive(arg_6_0._goinuse, var_6_1)
end

function var_0_0._onItemClick(arg_7_0)
	local var_7_0 = arg_7_0._mo.itemEffect

	if var_7_0 == ExploreEnum.ItemEffect.Fix then
		ToastController.instance:showToast(ExploreConstValue.Toast.UseWithFixPrism)

		return
	end

	if not ExploreModel.instance:isHeroInControl() then
		ToastController.instance:showToast(ExploreConstValue.Toast.CantUseItem)

		return
	end

	local var_7_1 = ExploreController.instance:getMap()

	if var_7_1:getNowStatus() == ExploreEnum.MapStatus.UseItem then
		local var_7_2 = var_7_1:getCompByType(ExploreEnum.MapStatus.UseItem):getCurItemMo()

		var_7_1:setMapStatus(ExploreEnum.MapStatus.Normal)

		if var_7_2 == arg_7_0._mo then
			return
		end
	elseif var_7_1:getNowStatus() == ExploreEnum.MapStatus.MoveUnit then
		ToastController.instance:showToast(ExploreConstValue.Toast.ExploreCantUseItem)

		return
	end

	local var_7_3 = ExploreModel.instance:getUseItemUid()
	local var_7_4 = var_7_1:getUnit(tonumber(var_7_3), true)

	if var_7_4 and var_7_4:getUnitType() == ExploreEnum.ItemType.PipePot then
		ToastController.instance:showToast(ExploreConstValue.Toast.CantUseItem)

		return
	end

	local var_7_5 = ExploreController.instance:getMap():getHero()

	if var_7_5:isMoving() then
		local var_7_6 = var_7_5.nodePos
		local var_7_7 = ExploreHelper.getKey(var_7_6)

		if ExploreMapModel.instance:getNode(var_7_7).nodeType == ExploreEnum.NodeType.Ice then
			return
		end
	end

	if var_7_5:isMoving() then
		if not var_7_5:stopMoving() then
			return
		end

		ExploreModel.instance:setHeroControl(false, ExploreEnum.HeroLock.UseItem)

		arg_7_0._waitHeroMoveEnd = true

		return
	end

	if var_7_0 == ExploreEnum.ItemEffect.CreateUnit2 and ExploreController.instance:getMap():getUnit(tonumber(arg_7_0._mo.id), true) then
		var_7_5:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.UseItem, true, true)
		ExploreRpc.instance:sendExploreUseItemRequest(arg_7_0._mo.id, 0, 0)

		return
	end

	if var_7_0 == ExploreEnum.ItemEffect.Active then
		var_7_5:setHeroStatus(ExploreAnimEnum.RoleAnimStatus.UseItem, true, true)
	end

	if arg_7_0._mo.isActiveTypeItem then
		ExploreRpc.instance:sendExploreUseItemRequest(arg_7_0._mo.id, 0, 0)
	else
		ExploreController.instance:dispatchEvent(ExploreEvent.DragItemBegin, arg_7_0._mo)
	end
end

function var_0_0.onHeroMoveEnd(arg_8_0)
	if arg_8_0._waitHeroMoveEnd then
		arg_8_0._waitHeroMoveEnd = nil

		ExploreModel.instance:setHeroControl(true, ExploreEnum.HeroLock.UseItem)
		arg_8_0:_onItemClick()
	end
end

function var_0_0.onDetailClick(arg_9_0)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.ExploreGetItemView, {
		id = arg_9_0._mo.itemId
	})
end

function var_0_0.onMapStatusChange(arg_10_0, arg_10_1)
	if arg_10_1 == ExploreEnum.MapStatus.UseItem then
		if ExploreController.instance:getMap():getCompByType(ExploreEnum.MapStatus.UseItem):getCurItemMo() == arg_10_0._mo then
			gohelper.setActive(arg_10_0._goselect, true)
		else
			gohelper.setActive(arg_10_0._goselect, false)
		end
	else
		gohelper.setActive(arg_10_0._goselect, false)
	end
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0._click:RemoveClickListener()

	if arg_11_0._simagepropicon then
		arg_11_0._simagepropicon:UnLoadImage()

		arg_11_0._simagepropicon = nil
	end

	if arg_11_0._simageusepropicon then
		arg_11_0._simageusepropicon:UnLoadImage()

		arg_11_0._simageusepropicon = nil
	end
end

return var_0_0
