module("modules.logic.commonprop.view.CommonPropListItem", package.seeall)

local var_0_0 = class("CommonPropListItem", CommonPropItemIcon)

var_0_0.hasOpen = false

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	var_0_0.super._editableInitView(arg_4_0)
end

function var_0_0.setMOValue(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6, arg_5_7)
	arg_5_0._isEquip = tonumber(arg_5_1) == MaterialEnum.MaterialType.Equip
	arg_5_0._type = arg_5_1
	arg_5_0._id = arg_5_2
	arg_5_0._quantity = arg_5_3
	arg_5_0._uid = arg_5_4
	arg_5_0._isGold = arg_5_6
	arg_5_0._roomBuildingLevel = arg_5_7

	if var_0_0.hasOpen then
		arg_5_0:_playInEffect()
	else
		TaskDispatcher.runDelay(arg_5_0._playInEffect, arg_5_0, 0.06 * arg_5_0._index)
	end

	gohelper.setActive(arg_5_0._nameTxt.gameObject, var_0_0.hasOpen and arg_5_0._isEquip)
	gohelper.setActive(arg_5_0._goequip, var_0_0.hasOpen and arg_5_0._isEquip)
	gohelper.setActive(arg_5_0._goitem, var_0_0.hasOpen and not arg_5_0._isEquip)
end

function var_0_0._playInEffect(arg_6_0)
	local var_6_0, var_6_1 = ItemModel.instance:getItemConfigAndIcon(arg_6_0._type, arg_6_0._id)
	local var_6_2 = var_6_0.rare

	if not var_6_0.rare and (arg_6_0._type == MaterialEnum.MaterialType.PlayerCloth or arg_6_0._type == MaterialEnum.MaterialType.Antique) then
		var_6_2 = 5
	end

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._rareInGos) do
		if iter_6_0 == var_6_2 then
			gohelper.setActive(iter_6_1, true)

			local var_6_3 = iter_6_1:GetComponent(typeof(UnityEngine.Animation))

			if not var_0_0.hasOpen then
				if arg_6_0._index <= 10 then
					gohelper.setActive(iter_6_1, true)
					var_6_3:Play()
				else
					gohelper.setActive(iter_6_1, false)
				end

				TaskDispatcher.runDelay(arg_6_0._setItem, arg_6_0, 0.5)
			else
				gohelper.setActive(iter_6_1, false)
				arg_6_0:_setItem()
			end
		else
			gohelper.setActive(iter_6_1, false)
		end
	end

	arg_6_0:showHighQualityEffect(arg_6_0._type, var_6_0, var_6_2)
end

function var_0_0._setItem(arg_7_0)
	gohelper.setActive(arg_7_0._nameTxt.gameObject, arg_7_0._isEquip)
	gohelper.setActive(arg_7_0._goequip, arg_7_0._isEquip)
	gohelper.setActive(arg_7_0._goitem, not arg_7_0._isEquip)
	gohelper.setActive(arg_7_0._gogold, arg_7_0._isGold)

	if arg_7_0._index == 10 then
		var_0_0.hasOpen = true
	end

	local var_7_0, var_7_1 = ItemModel.instance:getItemConfigAndIcon(arg_7_0._type, arg_7_0._id)

	if arg_7_0._isEquip then
		if not arg_7_0._equipIcon then
			arg_7_0._equipIcon = IconMgr.instance:getCommonEquipIcon(arg_7_0._goequip, 1)

			arg_7_0._equipIcon:addClick()
		end

		arg_7_0._equipIcon:setMOValue(arg_7_0._type, arg_7_0._id, arg_7_0._quantity, arg_7_0._uid)
		arg_7_0._equipIcon:setCantJump(true)
		arg_7_0._equipIcon:isShowRefineLv(true)
		arg_7_0._equipIcon:playEquipAnim(UIAnimationName.Open)

		arg_7_0._nameTxt.text = var_7_0.name
	else
		arg_7_0._itemIcon = arg_7_0._itemIcon or IconMgr.instance:getCommonItemIcon(arg_7_0._goitem)

		arg_7_0._itemIcon:setMOValue(arg_7_0._type, arg_7_0._id, arg_7_0._quantity, arg_7_0._uid, true)
		arg_7_0._itemIcon:refreshDeadline(true)
		arg_7_0._itemIcon:showName()
		arg_7_0._itemIcon:playAnimation()
		arg_7_0._itemIcon:setCantJump(true)

		local var_7_2

		if arg_7_0._type == MaterialEnum.MaterialType.Building and arg_7_0._roomBuildingLevel and arg_7_0._roomBuildingLevel > 0 then
			local var_7_3 = RoomConfig.instance:getLevelGroupConfig(arg_7_0._id, arg_7_0._roomBuildingLevel)

			var_7_2 = var_7_3 and ResUrl.getRoomBuildingPropIcon(var_7_3.icon)
		end

		arg_7_0._itemIcon:setSpecificIcon(var_7_2)
		arg_7_0._itemIcon:setRoomBuildingLevel(arg_7_0._roomBuildingLevel)
	end

	if arg_7_0.callback then
		arg_7_0:callback()
	end
end

function var_0_0.hideName(arg_8_0)
	if arg_8_0._isEquip then
		arg_8_0._nameTxt.text = ""
	elseif arg_8_0._itemIcon then
		arg_8_0._itemIcon:isShowName()
	end
end

function var_0_0.onDestroy(arg_9_0)
	arg_9_0.callback = nil

	TaskDispatcher.cancelTask(arg_9_0._playInEffect, arg_9_0)
	TaskDispatcher.cancelTask(arg_9_0._setItem, arg_9_0)
end

return var_0_0
