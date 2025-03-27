module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiGameMapUnitItem", package.seeall)

slot0 = class("WuErLiXiGameMapUnitItem", LuaCompBase)

function slot0.init(slot0, slot1, slot2)
	slot0.go = slot1
	slot0._itemCanvas = gohelper.onceAddComponent(slot0.go, typeof(UnityEngine.CanvasGroup))
	slot0._anim = slot0.go:GetComponent(gohelper.Type_Animator)

	gohelper.setActive(slot0.go, false)

	slot0._itemWidth = recthelper.getWidth(slot0.go.transform)
	slot0._goDrag = slot2
	slot0._nodeItem = {}
	slot0._imageicon = gohelper.findChildImage(slot1, "icon")
	slot0._goiconwallidle = gohelper.findChild(slot1, "icon_wallidle")
	slot0._goiconwallact = gohelper.findChild(slot1, "icon_wallact")
	slot0._goiconendactived = gohelper.findChild(slot1, "icon_endactived")
	slot0._imageiconlock = gohelper.findChildImage(slot1, "icon_lockframe")
	slot0._txtname = gohelper.findChildText(slot1, "#txt_Num")
	slot0._goput = gohelper.findChild(slot1, "#go_Put")
	slot0._click = gohelper.getClick(slot0._imageicon.gameObject)

	slot0._click:AddClickListener(slot0._onNodeClick, slot0)

	slot0._drag = SLFramework.UGUI.UIDragListener.Get(slot0._imageicon.gameObject)

	slot0._drag:AddDragBeginListener(slot0._onBeginDrag, slot0, slot1.transform)
	slot0._drag:AddDragListener(slot0._onDrag, slot0)
	slot0._drag:AddDragEndListener(slot0._onEndDrag, slot0, slot1.transform)

	slot0._bgiconwidthoffset = recthelper.getWidth(slot0._imageiconlock.gameObject.transform) - recthelper.getWidth(slot0._imageicon.gameObject.transform)
end

function slot0._onNodeClick(slot0)
	if slot0._unitMo and slot0._nodeMo and slot0._nodeMo.initUnit == 0 then
		WuErLiXiMapModel.instance:setCurSelectUnit(slot0._nodeMo.x, slot0._nodeMo.y)

		if WuErLiXiMapModel.instance:isSetDirEnable(slot0._unitMo.unitType, (slot0._unitMo.dir + 1) % 4, slot0._nodeMo.x, slot0._nodeMo.y) then
			AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_revolve)
			WuErLiXiMapModel.instance:setUnitDir(slot0._nodeMo, slot1, slot0._unitMo.dir)
		end

		WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.NodeClicked)
	end
end

function slot0._onBeginDrag(slot0, slot1, slot2)
	if not slot0._nodeMo then
		return
	end

	if not slot0._nodeMo.unit then
		return
	end

	if slot0._nodeMo.initUnit > 0 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_choose)
	gohelper.setActive(slot0._goDrag, false)
	slot0:_setDragItem()
	slot0._goDrag.transform:SetParent(slot0.go.transform.parent.parent)
	WuErLiXiMapModel.instance:clearSelectUnit()

	slot4 = recthelper.screenPosToAnchorPos(slot2.position, slot0._goDrag.transform.parent)

	recthelper.setAnchor(slot0._goDrag.transform, slot4.x, slot4.y)
	transformhelper.setLocalScale(slot0._goDrag.transform, 1, 1, 1)

	slot0._itemCanvas.alpha = 0
end

function slot0._setDragItem(slot0)
	slot0._imagedragicon = gohelper.findChildImage(slot0._goDrag, "icon")
	slot0._imagedragiconbg = gohelper.findChildImage(slot0._goDrag, "image_BG")
	slot0._txtdragname = gohelper.findChildText(slot0._goDrag, "#txt_Num")

	UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(slot0._imagedragicon, WuErLiXiHelper.getUnitSpriteName(slot0._unitMo.unitType, false))
	UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(slot0._imagedragiconbg, "v2a4_wuerlixi_node_icon2")

	slot0._txtdragname.text = WuErLiXiMapModel.instance:getKeyAndSwitchTagById(slot0._unitMo.id)

	TaskDispatcher.runDelay(slot0._setDragPos, slot0, 0.05)
end

function slot0._setDragPos(slot0)
	gohelper.setActive(slot0._goDrag, true)
	slot0._imagedragicon:SetNativeSize()
	slot0._imagedragiconbg:SetNativeSize()

	slot1 = recthelper.getWidth(slot0._imagedragicon.gameObject.transform)

	if slot0._unitMo.unitType == WuErLiXiEnum.UnitType.SignalMulti then
		if slot0._unitMo.dir == WuErLiXiEnum.Dir.Up or slot0._unitMo.dir == WuErLiXiEnum.Dir.Down then
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

	transformhelper.setLocalRotation(slot0._imagedragicon.gameObject.transform, 0, 0, -90 * slot0._unitMo.dir)
end

function slot0._onDrag(slot0, slot1, slot2)
	if not slot0._nodeMo then
		return
	end

	if not slot0._nodeMo.unit then
		return
	end

	if slot0._nodeMo.initUnit > 0 then
		return
	end

	slot3 = slot2.position
	slot4 = recthelper.screenPosToAnchorPos(slot3, slot0._goDrag.transform.parent)

	recthelper.setAnchor(slot0._goDrag.transform, slot4.x, slot4.y)
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.UnitDraging, slot3, slot0._nodeMo, slot0._unitMo.unitType)
end

function slot0._onEndDrag(slot0, slot1, slot2)
	if not slot0._nodeMo then
		return
	end

	if not slot0._nodeMo.unit then
		return
	end

	if slot0._nodeMo.initUnit > 0 then
		return
	end

	slot3 = slot2.position
	slot4 = recthelper.screenPosToAnchorPos(slot3, slot0._goDrag.transform.parent)

	recthelper.setAnchor(slot0._goDrag.transform, slot4.x, slot4.y)
	gohelper.setActive(slot0._goDrag, false)

	slot0._itemCanvas.alpha = 1

	TaskDispatcher.cancelTask(slot0._setDragPos, slot0)
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.NodeUnitDragEnd, slot3, slot0._unitMo)
end

function slot0.setItem(slot0, slot1, slot2)
	if not slot2 then
		logError("请检查配置，并将元件设置在已有的节点上！")

		return
	end

	slot0._unitMo = slot1
	slot0._nodeMo = slot2:getNodeMo()
	slot0._nodeItem = slot2
	slot0.go.name = slot0._nodeMo.x .. "_" .. slot0._nodeMo.y

	UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(slot0._imageicon, WuErLiXiHelper.getUnitSpriteName(slot0._unitMo.unitType, slot0._nodeMo:isNodeShowActive()))
	UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(slot0._imageiconlock, "v2a4_wuerlixi_unit_icon7_1")
	gohelper.setActive(slot0._imageiconlock.gameObject, slot0._unitMo.unitType == WuErLiXiEnum.UnitType.Switch)
	gohelper.setActive(slot0._goiconwallact, slot0._unitMo.unitType == WuErLiXiEnum.UnitType.Obstacle and slot0._nodeMo.initUnit == 0)
	gohelper.setActive(slot0._goiconwallidle, slot0._unitMo.unitType == WuErLiXiEnum.UnitType.Obstacle and slot0._nodeMo.initUnit ~= 0)

	slot4 = slot0._unitMo:isUnitActive()

	gohelper.setActive(slot0._imageicon.gameObject, slot0._unitMo.unitType ~= WuErLiXiEnum.UnitType.Switch or not slot4)
	gohelper.setActive(slot0._goiconendactived, slot4 and slot0._unitMo.unitType == WuErLiXiEnum.UnitType.SignalEnd)

	if slot4 and not slot0._lastActive then
		if slot0._unitMo.unitType == WuErLiXiEnum.UnitType.Switch then
			AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_enable)
			slot0._anim:Play("active", 0, 0)
		elseif slot0._unitMo.unitType == WuErLiXiEnum.UnitType.SignalEnd then
			AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_enable)
			slot0._anim:Play("active", 0, 0)
		elseif slot0._unitMo.unitType == WuErLiXiEnum.UnitType.Key then
			AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_enable)
			slot0._anim:Play("active", 0, 0)
		elseif slot0._unitMo.unitType == WuErLiXiEnum.UnitType.SignalMulti then
			AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_enable)
			slot0._anim:Play("active", 0, 0)
		else
			slot0._anim:Play("idle", 0, 0)
		end
	else
		slot0._anim:Play("idle", 0, 0)
	end

	slot0._lastActive = slot4
	slot0._txtname.text = WuErLiXiMapModel.instance:getKeyAndSwitchTagById(slot0._unitMo.id)

	TaskDispatcher.runDelay(slot0.setPos, slot0, 0.05)
end

function slot0.setPos(slot0)
	slot0._nodeItem = slot0._nodeItem

	gohelper.setActive(slot0.go, true)
	slot0._imageicon:SetNativeSize()

	slot0.go.transform.position = slot0._nodeItem.go.transform.position

	transformhelper.setLocalRotation(slot0._imageicon.gameObject.transform, 0, 0, -90 * slot0._unitMo.dir)
end

function slot0.hide(slot0)
	gohelper.setActive(slot0.go, false)
end

function slot0.showPut(slot0, slot1)
	if slot0._unitMo.unitType == WuErLiXiEnum.UnitType.SignalMulti then
		if slot0._unitMo.dir == WuErLiXiEnum.Dir.Up or slot0._unitMo.dir == WuErLiXiEnum.Dir.Down then
			transformhelper.setLocalScale(slot0._goput.transform, 3, 1, 1)
		else
			transformhelper.setLocalScale(slot0._goput.transform, 1, 3, 1)
		end
	else
		transformhelper.setLocalScale(slot0._goput.transform, 1, 1, 1)
	end

	gohelper.setActive(slot0._goput, slot1)
end

function slot0.destroy(slot0)
	if slot0.go then
		gohelper.destroy(slot0.go)

		slot0.go = nil
	end

	TaskDispatcher.cancelTask(slot0.setPos, slot0)
	slot0._click:RemoveClickListener()
	slot0._drag:RemoveDragListener()
	slot0._drag:RemoveDragBeginListener()
	slot0._drag:RemoveDragEndListener()
end

return slot0
