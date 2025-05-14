module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiGameMapUnitItem", package.seeall)

local var_0_0 = class("WuErLiXiGameMapUnitItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.go = arg_1_1
	arg_1_0._itemCanvas = gohelper.onceAddComponent(arg_1_0.go, typeof(UnityEngine.CanvasGroup))
	arg_1_0._anim = arg_1_0.go:GetComponent(gohelper.Type_Animator)

	gohelper.setActive(arg_1_0.go, false)

	arg_1_0._itemWidth = recthelper.getWidth(arg_1_0.go.transform)
	arg_1_0._goDrag = arg_1_2
	arg_1_0._nodeItem = {}
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_1, "icon")
	arg_1_0._goiconwallidle = gohelper.findChild(arg_1_1, "icon_wallidle")
	arg_1_0._goiconwallact = gohelper.findChild(arg_1_1, "icon_wallact")
	arg_1_0._goiconendactived = gohelper.findChild(arg_1_1, "icon_endactived")
	arg_1_0._imageiconlock = gohelper.findChildImage(arg_1_1, "icon_lockframe")
	arg_1_0._txtname = gohelper.findChildText(arg_1_1, "#txt_Num")
	arg_1_0._goput = gohelper.findChild(arg_1_1, "#go_Put")
	arg_1_0._click = gohelper.getClick(arg_1_0._imageicon.gameObject)

	arg_1_0._click:AddClickListener(arg_1_0._onNodeClick, arg_1_0)

	arg_1_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_1_0._imageicon.gameObject)

	arg_1_0._drag:AddDragBeginListener(arg_1_0._onBeginDrag, arg_1_0, arg_1_1.transform)
	arg_1_0._drag:AddDragListener(arg_1_0._onDrag, arg_1_0)
	arg_1_0._drag:AddDragEndListener(arg_1_0._onEndDrag, arg_1_0, arg_1_1.transform)

	arg_1_0._bgiconwidthoffset = recthelper.getWidth(arg_1_0._imageiconlock.gameObject.transform) - recthelper.getWidth(arg_1_0._imageicon.gameObject.transform)
end

function var_0_0._onNodeClick(arg_2_0)
	if arg_2_0._unitMo and arg_2_0._nodeMo and arg_2_0._nodeMo.initUnit == 0 then
		WuErLiXiMapModel.instance:setCurSelectUnit(arg_2_0._nodeMo.x, arg_2_0._nodeMo.y)

		local var_2_0 = (arg_2_0._unitMo.dir + 1) % 4

		if WuErLiXiMapModel.instance:isSetDirEnable(arg_2_0._unitMo.unitType, var_2_0, arg_2_0._nodeMo.x, arg_2_0._nodeMo.y) then
			AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_revolve)
			WuErLiXiMapModel.instance:setUnitDir(arg_2_0._nodeMo, var_2_0, arg_2_0._unitMo.dir)
		end

		WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.NodeClicked)
	end
end

function var_0_0._onBeginDrag(arg_3_0, arg_3_1, arg_3_2)
	if not arg_3_0._nodeMo then
		return
	end

	if not arg_3_0._nodeMo.unit then
		return
	end

	if arg_3_0._nodeMo.initUnit > 0 then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_choose)
	gohelper.setActive(arg_3_0._goDrag, false)
	arg_3_0:_setDragItem()
	arg_3_0._goDrag.transform:SetParent(arg_3_0.go.transform.parent.parent)

	local var_3_0 = arg_3_2.position

	WuErLiXiMapModel.instance:clearSelectUnit()

	local var_3_1 = recthelper.screenPosToAnchorPos(var_3_0, arg_3_0._goDrag.transform.parent)

	recthelper.setAnchor(arg_3_0._goDrag.transform, var_3_1.x, var_3_1.y)
	transformhelper.setLocalScale(arg_3_0._goDrag.transform, 1, 1, 1)

	arg_3_0._itemCanvas.alpha = 0
end

function var_0_0._setDragItem(arg_4_0)
	arg_4_0._imagedragicon = gohelper.findChildImage(arg_4_0._goDrag, "icon")
	arg_4_0._imagedragiconbg = gohelper.findChildImage(arg_4_0._goDrag, "image_BG")
	arg_4_0._txtdragname = gohelper.findChildText(arg_4_0._goDrag, "#txt_Num")

	local var_4_0 = WuErLiXiHelper.getUnitSpriteName(arg_4_0._unitMo.unitType, false)

	UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(arg_4_0._imagedragicon, var_4_0)
	UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(arg_4_0._imagedragiconbg, "v2a4_wuerlixi_node_icon2")

	arg_4_0._txtdragname.text = WuErLiXiMapModel.instance:getKeyAndSwitchTagById(arg_4_0._unitMo.id)

	TaskDispatcher.runDelay(arg_4_0._setDragPos, arg_4_0, 0.05)
end

function var_0_0._setDragPos(arg_5_0)
	gohelper.setActive(arg_5_0._goDrag, true)
	arg_5_0._imagedragicon:SetNativeSize()
	arg_5_0._imagedragiconbg:SetNativeSize()

	local var_5_0 = recthelper.getWidth(arg_5_0._imagedragicon.gameObject.transform)

	if arg_5_0._unitMo.unitType == WuErLiXiEnum.UnitType.SignalMulti then
		if arg_5_0._unitMo.dir == WuErLiXiEnum.Dir.Up or arg_5_0._unitMo.dir == WuErLiXiEnum.Dir.Down then
			recthelper.setWidth(arg_5_0._imagedragiconbg.gameObject.transform, var_5_0 + arg_5_0._bgiconwidthoffset)
			recthelper.setWidth(arg_5_0._goDrag.transform, var_5_0 + arg_5_0._bgiconwidthoffset)
		else
			recthelper.setHeight(arg_5_0._imagedragiconbg.gameObject.transform, var_5_0 + arg_5_0._bgiconwidthoffset)
			recthelper.setHeight(arg_5_0._goDrag.transform, var_5_0 + arg_5_0._bgiconwidthoffset)
		end
	else
		recthelper.setWidth(arg_5_0._goDrag.transform, arg_5_0._itemWidth)
		recthelper.setHeight(arg_5_0._goDrag.transform, arg_5_0._itemWidth)
	end

	transformhelper.setLocalRotation(arg_5_0._imagedragicon.gameObject.transform, 0, 0, -90 * arg_5_0._unitMo.dir)
end

function var_0_0._onDrag(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_0._nodeMo then
		return
	end

	if not arg_6_0._nodeMo.unit then
		return
	end

	if arg_6_0._nodeMo.initUnit > 0 then
		return
	end

	local var_6_0 = arg_6_2.position
	local var_6_1 = recthelper.screenPosToAnchorPos(var_6_0, arg_6_0._goDrag.transform.parent)

	recthelper.setAnchor(arg_6_0._goDrag.transform, var_6_1.x, var_6_1.y)
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.UnitDraging, var_6_0, arg_6_0._nodeMo, arg_6_0._unitMo.unitType)
end

function var_0_0._onEndDrag(arg_7_0, arg_7_1, arg_7_2)
	if not arg_7_0._nodeMo then
		return
	end

	if not arg_7_0._nodeMo.unit then
		return
	end

	if arg_7_0._nodeMo.initUnit > 0 then
		return
	end

	local var_7_0 = arg_7_2.position
	local var_7_1 = recthelper.screenPosToAnchorPos(var_7_0, arg_7_0._goDrag.transform.parent)

	recthelper.setAnchor(arg_7_0._goDrag.transform, var_7_1.x, var_7_1.y)
	gohelper.setActive(arg_7_0._goDrag, false)

	arg_7_0._itemCanvas.alpha = 1

	TaskDispatcher.cancelTask(arg_7_0._setDragPos, arg_7_0)
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.NodeUnitDragEnd, var_7_0, arg_7_0._unitMo)
end

function var_0_0.setItem(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_2 then
		logError("请检查配置，并将元件设置在已有的节点上！")

		return
	end

	arg_8_0._unitMo = arg_8_1
	arg_8_0._nodeMo = arg_8_2:getNodeMo()
	arg_8_0._nodeItem = arg_8_2
	arg_8_0.go.name = arg_8_0._nodeMo.x .. "_" .. arg_8_0._nodeMo.y

	local var_8_0 = WuErLiXiHelper.getUnitSpriteName(arg_8_0._unitMo.unitType, arg_8_0._nodeMo:isNodeShowActive())

	UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(arg_8_0._imageicon, var_8_0)
	UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(arg_8_0._imageiconlock, "v2a4_wuerlixi_unit_icon7_1")
	gohelper.setActive(arg_8_0._imageiconlock.gameObject, arg_8_0._unitMo.unitType == WuErLiXiEnum.UnitType.Switch)
	gohelper.setActive(arg_8_0._goiconwallact, arg_8_0._unitMo.unitType == WuErLiXiEnum.UnitType.Obstacle and arg_8_0._nodeMo.initUnit == 0)
	gohelper.setActive(arg_8_0._goiconwallidle, arg_8_0._unitMo.unitType == WuErLiXiEnum.UnitType.Obstacle and arg_8_0._nodeMo.initUnit ~= 0)

	local var_8_1 = arg_8_0._unitMo:isUnitActive()

	gohelper.setActive(arg_8_0._imageicon.gameObject, arg_8_0._unitMo.unitType ~= WuErLiXiEnum.UnitType.Switch or not var_8_1)
	gohelper.setActive(arg_8_0._goiconendactived, var_8_1 and arg_8_0._unitMo.unitType == WuErLiXiEnum.UnitType.SignalEnd)

	if var_8_1 and not arg_8_0._lastActive then
		if arg_8_0._unitMo.unitType == WuErLiXiEnum.UnitType.Switch then
			AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_enable)
			arg_8_0._anim:Play("active", 0, 0)
		elseif arg_8_0._unitMo.unitType == WuErLiXiEnum.UnitType.SignalEnd then
			AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_enable)
			arg_8_0._anim:Play("active", 0, 0)
		elseif arg_8_0._unitMo.unitType == WuErLiXiEnum.UnitType.Key then
			AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_enable)
			arg_8_0._anim:Play("active", 0, 0)
		elseif arg_8_0._unitMo.unitType == WuErLiXiEnum.UnitType.SignalMulti then
			AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_enable)
			arg_8_0._anim:Play("active", 0, 0)
		else
			arg_8_0._anim:Play("idle", 0, 0)
		end
	else
		arg_8_0._anim:Play("idle", 0, 0)
	end

	arg_8_0._lastActive = var_8_1
	arg_8_0._txtname.text = WuErLiXiMapModel.instance:getKeyAndSwitchTagById(arg_8_0._unitMo.id)

	TaskDispatcher.runDelay(arg_8_0.setPos, arg_8_0, 0.05)
end

function var_0_0.setPos(arg_9_0)
	arg_9_0._nodeItem = arg_9_0._nodeItem

	gohelper.setActive(arg_9_0.go, true)
	arg_9_0._imageicon:SetNativeSize()

	arg_9_0.go.transform.position = arg_9_0._nodeItem.go.transform.position

	transformhelper.setLocalRotation(arg_9_0._imageicon.gameObject.transform, 0, 0, -90 * arg_9_0._unitMo.dir)
end

function var_0_0.hide(arg_10_0)
	gohelper.setActive(arg_10_0.go, false)
end

function var_0_0.showPut(arg_11_0, arg_11_1)
	if arg_11_0._unitMo.unitType == WuErLiXiEnum.UnitType.SignalMulti then
		if arg_11_0._unitMo.dir == WuErLiXiEnum.Dir.Up or arg_11_0._unitMo.dir == WuErLiXiEnum.Dir.Down then
			transformhelper.setLocalScale(arg_11_0._goput.transform, 3, 1, 1)
		else
			transformhelper.setLocalScale(arg_11_0._goput.transform, 1, 3, 1)
		end
	else
		transformhelper.setLocalScale(arg_11_0._goput.transform, 1, 1, 1)
	end

	gohelper.setActive(arg_11_0._goput, arg_11_1)
end

function var_0_0.destroy(arg_12_0)
	if arg_12_0.go then
		gohelper.destroy(arg_12_0.go)

		arg_12_0.go = nil
	end

	TaskDispatcher.cancelTask(arg_12_0.setPos, arg_12_0)
	arg_12_0._click:RemoveClickListener()
	arg_12_0._drag:RemoveDragListener()
	arg_12_0._drag:RemoveDragBeginListener()
	arg_12_0._drag:RemoveDragEndListener()
end

return var_0_0
