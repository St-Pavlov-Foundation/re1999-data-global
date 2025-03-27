module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiGameMapNodeItem", package.seeall)

slot0 = class("WuErLiXiGameMapNodeItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._imageicon = gohelper.findChildImage(slot1, "icon")
	slot0._goselected = gohelper.findChild(slot1, "#go_Selected")
	slot0._gounplaceable = gohelper.findChild(slot1, "#go_Unplaceable")
	slot0._goput = gohelper.findChild(slot1, "#go_Put")
	slot0._gohighlight = gohelper.findChild(slot1, "#go_Highlight")
	slot0._goconfirm = gohelper.findChild(slot1, "#go_Confirm")
end

function slot0.setItem(slot0, slot1)
	slot0._nodeMo = slot1

	gohelper.setActive(slot0.go, true)

	slot0.go.name = slot1.x .. "_" .. slot1.y

	slot0:refreshItem()
end

function slot0.hide(slot0)
	gohelper.setActive(slot0.go, false)
end

function slot0.showUnplace(slot0, slot1)
	gohelper.setActive(slot0._gounplaceable, slot1)
end

function slot0.showHightLight(slot0, slot1)
	gohelper.setActive(slot0._gohighlight, slot1 and not slot0._nodeMo:getNodeUnit())
end

function slot0.showPlaceable(slot0, slot1)
	gohelper.setActive(slot0._goconfirm, slot1)
end

function slot0.showPut(slot0, slot1)
	gohelper.setActive(slot0._goput, slot1)
end

function slot0.showSelect(slot0, slot1)
	gohelper.setActive(slot0._goselected, slot1)
end

function slot0.refreshItem(slot0)
	slot1 = WuErLiXiMapModel.instance:getCurSelectUnit()
	slot0._unitMo = slot0._nodeMo:getNodeUnit()

	if slot0._unitMo then
		gohelper.setActive(slot0._goselected, slot1[1] == slot0._unitMo.x and slot1[2] == slot0._unitMo.y)

		if slot0._unitMo.unitType == WuErLiXiEnum.UnitType.SignalStart or slot0._unitMo.unitType == WuErLiXiEnum.UnitType.SignalEnd then
			UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(slot0._imageicon, "v2a4_wuerlixi_node_icon4")

			return
		end
	else
		gohelper.setActive(slot0._goselected, false)
	end

	if WuErLiXiMapModel.instance:isNodeHasInitUnit(slot0._nodeMo) then
		UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(slot0._imageicon, "v2a4_wuerlixi_node_icon5")

		return
	end

	if WuErLiXiMapModel.instance:isNodeHasUnit(slot0._nodeMo) then
		UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(slot0._imageicon, "v2a4_wuerlixi_node_icon2")

		return
	end

	UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(slot0._imageicon, "v2a4_wuerlixi_node_icon1")
end

function slot0.getNodeMo(slot0)
	return slot0._nodeMo
end

function slot0.destroy(slot0)
end

return slot0
