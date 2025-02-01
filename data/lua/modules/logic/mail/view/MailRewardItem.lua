module("modules.logic.mail.view.MailRewardItem", package.seeall)

slot0 = class("MailRewardItem")

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._commonitemcontainer = gohelper.findChild(slot1, "commonitemcontainer")
	slot0._canvasGroup = slot1:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._txtcount = gohelper.findChildText(slot1, "countbg/count")
	slot0._bg = gohelper.findChild(slot1, "countbg")
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0.itemType = tonumber(slot0._mo[1])
	slot0.itemId = tonumber(slot0._mo[2])
	slot2 = tonumber(slot0._mo[3])

	if slot0.itemType == MaterialEnum.MaterialType.EquipCard or slot0.itemType == MaterialEnum.MaterialType.Season123EquipCard then
		recthelper.setWidth(slot0.go.transform, 80.69)

		if slot0._commonitem then
			gohelper.setActive(slot0._commonitem.go, false)
		end

		gohelper.setActive(slot0._bg.gameObject, false)

		if not slot0._equipCardItem then
			slot0._equipItemGo = gohelper.create2d(slot0.go, "EquipCard")

			transformhelper.setLocalScale(slot0._equipItemGo.transform, 0.265, 0.265, 0.265)

			slot0._equipCardItem = Season123CelebrityCardItem.New()

			slot0._equipCardItem:init(slot0._equipItemGo, slot0.itemId, {
				noClick = true
			})
		else
			gohelper.setActive(slot0._equipItemGo, true)
			slot0._equipCardItem:reset(nil, , slot0.itemId)
		end
	else
		recthelper.setWidth(slot0.go.transform, 115)

		if not slot0._commonitem then
			slot0._commonitem = IconMgr.instance:getCommonPropItemIcon(slot0._commonitemcontainer)
		end

		gohelper.setActive(slot0._equipItemGo, false)
		gohelper.setActive(slot0._commonitem.go, true)
		gohelper.setActive(slot0._bg.gameObject, true)
		slot0._commonitem:setMOValue(slot0.itemType, slot0.itemId, slot2, nil, true)
		slot0._commonitem:hideEffect()

		if slot0._commonitem:isEquipIcon() then
			slot0._commonitem:ShowEquipCount(slot0._bg, slot0._txtcount)
			slot0._commonitem:setHideLvAndBreakFlag(true)
			slot0._commonitem:hideEquipLvAndBreak(true)
		else
			slot0._commonitem:isShowCount(false)

			slot0._txtcount.text = tostring(slot2)

			slot0._commonitem:showStackableNum2(slot0._bg, slot0._txtcount)
		end
	end

	slot0._canvasGroup.alpha = slot0._mo.state == MailEnum.ReadStatus.Read and 0.5 or 1

	if slot0.itemType == MaterialEnum.MaterialType.Item and lua_item.configDict[slot0.itemId].subType == ItemEnum.SubType.Portrait then
		slot0._commonitem:setFrameMaskable(true)
	end
end

function slot0.onDestroy(slot0)
	if slot0._commonitem then
		slot0._commonitem:onDestroy()
	end

	if slot0._equipCardItem then
		slot0._equipCardItem:destroy()
	end

	gohelper.destroy(slot0._equipItemGo)

	slot0._mo = nil
	slot0._commonitem = nil
	slot0._equipCardItem = nil
	slot0._equipItemGo = nil
	slot0.go = nil
	slot0._commonitemcontainer = nil
	slot0._canvasGroup = nil
	slot0._txtcount = nil
	slot0._bg = nil
end

return slot0
