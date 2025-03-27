module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiGameActUnitItem", package.seeall)

slot0 = class("WuErLiXiGameActUnitItem", LuaCompBase)

function slot0.init(slot0, slot1, slot2)
	slot0.go = slot1
	slot0._goDrag = slot2
	slot0._itemWidth = recthelper.getWidth(slot0.go.transform)
	slot0._imageicon = gohelper.findChildImage(slot1, "icon")
	slot0._gowall = gohelper.findChild(slot1, "icon_wall")
	slot0._imageiconbg = gohelper.findChildImage(slot1, "image_BG")
	slot0._txtcount = gohelper.findChildText(slot1, "txt_count")
	slot0._txtname = gohelper.findChildText(slot1, "#txt_Num")
	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._imageicon.gameObject)

	slot0._drag:AddDragBeginListener(slot0._onBeginDrag, slot0, slot1.transform)
	slot0._drag:AddDragListener(slot0._onDrag, slot0)
	slot0._drag:AddDragEndListener(slot0._onEndDrag, slot0, slot1.transform)

	slot0._bgiconwidthoffset = recthelper.getWidth(slot0._imageiconbg.gameObject.transform) - recthelper.getWidth(slot0._imageicon.gameObject.transform)
end

function slot0._onBeginDrag(slot0, slot1, slot2)
	if WuErLiXiMapModel.instance:getLimitSelectUnitCount(slot0._mo) < 1 then
		return
	end

	gohelper.setActive(slot0._goDrag, false)
	slot0:_setDragItem()
	AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_choose)
	slot0._goDrag.transform:SetParent(slot0.go.transform.parent.parent)

	slot5 = recthelper.screenPosToAnchorPos(slot2.position, slot0._goDrag.transform.parent)

	recthelper.setAnchor(slot0._goDrag.transform, slot5.x, slot5.y)
	transformhelper.setLocalScale(slot0._goDrag.transform, 1, 1, 1)
end

function slot0._setDragItem(slot0)
	slot0._imagedragicon = gohelper.findChildImage(slot0._goDrag, "icon")
	slot0._imagedragiconbg = gohelper.findChildImage(slot0._goDrag, "image_BG")
	slot0._txtdragname = gohelper.findChildText(slot0._goDrag, "#txt_Num")

	UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(slot0._imagedragicon, WuErLiXiHelper.getUnitSpriteName(slot0._mo.type, false))
	UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(slot0._imagedragiconbg, "v2a4_wuerlixi_node_icon2")

	slot0._txtdragname.text = WuErLiXiMapModel.instance:getKeyAndSwitchTagById(slot0._mo.id)

	TaskDispatcher.runDelay(slot0._setDragPos, slot0, 0.05)
end

function slot0._setDragPos(slot0)
	gohelper.setActive(slot0._goDrag, true)
	slot0._imagedragicon:SetNativeSize()
	slot0._imagedragiconbg:SetNativeSize()

	slot1 = recthelper.getWidth(slot0._imagedragicon.gameObject.transform)

	if slot0._mo.type == WuErLiXiEnum.UnitType.SignalMulti then
		if slot0._mo.dir == WuErLiXiEnum.Dir.Up or slot0._mo.dir == WuErLiXiEnum.Dir.Down then
			recthelper.setWidth(slot0._imagedragiconbg.gameObject.transform, slot1 + slot0._bgiconwidthoffset)
			recthelper.setWidth(slot0._goDrag.transform, slot1 + slot0._bgiconwidthoffset)
		else
			recthelper.setHeight(slot0._imagedragiconbg.gameObject.transform, slot1 + slot0._bgiconwidthoffset)
			recthelper.setHeight(slot0._goDrag.transform, slot1 + slot0._bgiconwidthoffset)
		end
	else
		recthelper.setWidth(slot0._goDrag.transform, slot0._itemWidth)
		recthelper.setHeight(slot0._goDrag.transform, slot0._itemWidth)
	end

	transformhelper.setLocalRotation(slot0._imagedragicon.gameObject.transform, 0, 0, -90 * slot0._mo.dir)
end

function slot0._onDrag(slot0, slot1, slot2)
	if WuErLiXiMapModel.instance:getLimitSelectUnitCount(slot0._mo) < 1 then
		return
	end

	slot4 = slot2.position
	slot5 = recthelper.screenPosToAnchorPos(slot4, slot0._goDrag.transform.parent)

	recthelper.setAnchor(slot0._goDrag.transform, slot5.x, slot5.y)
	WuErLiXiMapModel.instance:clearSelectUnit()
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.UnitDraging, slot4, slot0._mo, slot0._mo.type)
end

function slot0._onEndDrag(slot0, slot1, slot2)
	if WuErLiXiMapModel.instance:getLimitSelectUnitCount(slot0._mo) < 1 then
		return
	end

	slot4 = slot2.position
	slot5 = recthelper.screenPosToAnchorPos(slot4, slot0._goDrag.transform.parent)

	recthelper.setAnchor(slot0._goDrag.transform, slot5.x, slot5.y)
	gohelper.setActive(slot0._goDrag, false)
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.ActUnitDragEnd, slot4, slot0._mo)
end

function slot0.setItem(slot0, slot1)
	slot0._mo = slot1

	gohelper.setActive(slot0.go, false)
	UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(slot0._imageicon, WuErLiXiHelper.getUnitSpriteName(slot0._mo.type, false))
	gohelper.setActive(slot0._gowall, slot0._mo.type == WuErLiXiEnum.UnitType.Obstacle)
	TaskDispatcher.runDelay(slot0.setPos, slot0, 0.05)

	slot0._txtcount.text = luaLang("multiple") .. tostring(WuErLiXiMapModel.instance:getLimitSelectUnitCount(slot0._mo))
	slot0._txtname.text = WuErLiXiMapModel.instance:getKeyAndSwitchTagById(slot0._mo.id)
end

function slot0.setPos(slot0)
	gohelper.setActive(slot0.go, true)
	slot0._imageicon:SetNativeSize()
	slot0._imageiconbg:SetNativeSize()

	slot1 = recthelper.getWidth(slot0._imageicon.gameObject.transform)

	if slot0._mo.type == WuErLiXiEnum.UnitType.SignalMulti then
		if slot0._mo.dir == WuErLiXiEnum.Dir.Up or slot0._mo.dir == WuErLiXiEnum.Dir.Down then
			recthelper.setWidth(slot0._imageiconbg.gameObject.transform, slot1 + slot0._bgiconwidthoffset)
			recthelper.setWidth(slot0.go.transform, slot1 + slot0._bgiconwidthoffset)
		else
			recthelper.setHeight(slot0._imageiconbg.gameObject.transform, slot1 + slot0._bgiconwidthoffset)
			recthelper.setHeight(slot0.go.transform, slot1 + slot0._bgiconwidthoffset)
		end
	else
		recthelper.setWidth(slot0.go.transform, slot0._itemWidth)
		recthelper.setHeight(slot0.go.transform, slot0._itemWidth)
	end

	transformhelper.setLocalRotation(slot0._imageicon.gameObject.transform, 0, 0, -90 * slot0._mo.dir)
end

function slot0.resetItem(slot0)
	slot0._txtcount.text = luaLang("multiple") .. tostring(WuErLiXiMapModel.instance:getLimitSelectUnitCount(slot0._mo))
end

function slot0.hide(slot0)
	gohelper.setActive(slot0.go, false)
end

function slot0.refreshCount(slot0)
end

function slot0.destroy(slot0)
	slot0._drag:RemoveDragListener()
	slot0._drag:RemoveDragBeginListener()
	slot0._drag:RemoveDragEndListener()
end

return slot0
