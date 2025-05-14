module("modules.logic.mail.view.MailRewardItem", package.seeall)

local var_0_0 = class("MailRewardItem")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0._commonitemcontainer = gohelper.findChild(arg_1_1, "commonitemcontainer")
	arg_1_0._canvasGroup = arg_1_1:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_1_0._txtcount = gohelper.findChildText(arg_1_1, "countbg/count")
	arg_1_0._bg = gohelper.findChild(arg_1_1, "countbg")
end

function var_0_0.addEventListeners(arg_2_0)
	return
end

function var_0_0.removeEventListeners(arg_3_0)
	return
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0._mo = arg_4_1
	arg_4_0.itemType = tonumber(arg_4_0._mo[1])
	arg_4_0.itemId = tonumber(arg_4_0._mo[2])

	local var_4_0 = tonumber(arg_4_0._mo[3])

	if arg_4_0.itemType == MaterialEnum.MaterialType.EquipCard or arg_4_0.itemType == MaterialEnum.MaterialType.Season123EquipCard then
		recthelper.setWidth(arg_4_0.go.transform, 80.69)

		if arg_4_0._commonitem then
			gohelper.setActive(arg_4_0._commonitem.go, false)
		end

		gohelper.setActive(arg_4_0._bg.gameObject, false)

		if not arg_4_0._equipCardItem then
			arg_4_0._equipItemGo = gohelper.create2d(arg_4_0.go, "EquipCard")

			transformhelper.setLocalScale(arg_4_0._equipItemGo.transform, 0.265, 0.265, 0.265)

			arg_4_0._equipCardItem = Season123CelebrityCardItem.New()

			arg_4_0._equipCardItem:init(arg_4_0._equipItemGo, arg_4_0.itemId, {
				noClick = true
			})
		else
			gohelper.setActive(arg_4_0._equipItemGo, true)
			arg_4_0._equipCardItem:reset(nil, nil, arg_4_0.itemId)
		end
	else
		recthelper.setWidth(arg_4_0.go.transform, 115)

		if not arg_4_0._commonitem then
			arg_4_0._commonitem = IconMgr.instance:getCommonPropItemIcon(arg_4_0._commonitemcontainer)
		end

		gohelper.setActive(arg_4_0._equipItemGo, false)
		gohelper.setActive(arg_4_0._commonitem.go, true)
		gohelper.setActive(arg_4_0._bg.gameObject, true)
		arg_4_0._commonitem:setMOValue(arg_4_0.itemType, arg_4_0.itemId, var_4_0, nil, true)
		arg_4_0._commonitem:hideEffect()

		if arg_4_0._commonitem:isEquipIcon() then
			arg_4_0._commonitem:ShowEquipCount(arg_4_0._bg, arg_4_0._txtcount)
			arg_4_0._commonitem:setHideLvAndBreakFlag(true)
			arg_4_0._commonitem:hideEquipLvAndBreak(true)
		else
			arg_4_0._commonitem:isShowCount(false)

			arg_4_0._txtcount.text = tostring(var_4_0)

			arg_4_0._commonitem:showStackableNum2(arg_4_0._bg, arg_4_0._txtcount)
		end
	end

	arg_4_0._canvasGroup.alpha = arg_4_0._mo.state == MailEnum.ReadStatus.Read and 0.5 or 1

	if arg_4_0.itemType == MaterialEnum.MaterialType.Item and lua_item.configDict[arg_4_0.itemId].subType == ItemEnum.SubType.Portrait then
		arg_4_0._commonitem:setFrameMaskable(true)
	end
end

function var_0_0.onDestroy(arg_5_0)
	if arg_5_0._commonitem then
		arg_5_0._commonitem:onDestroy()
	end

	if arg_5_0._equipCardItem then
		arg_5_0._equipCardItem:destroy()
	end

	gohelper.destroy(arg_5_0._equipItemGo)

	arg_5_0._mo = nil
	arg_5_0._commonitem = nil
	arg_5_0._equipCardItem = nil
	arg_5_0._equipItemGo = nil
	arg_5_0.go = nil
	arg_5_0._commonitemcontainer = nil
	arg_5_0._canvasGroup = nil
	arg_5_0._txtcount = nil
	arg_5_0._bg = nil
end

return var_0_0
