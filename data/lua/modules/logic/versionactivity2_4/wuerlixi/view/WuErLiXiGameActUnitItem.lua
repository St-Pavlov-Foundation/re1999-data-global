module("modules.logic.versionactivity2_4.wuerlixi.view.WuErLiXiGameActUnitItem", package.seeall)

local var_0_0 = class("WuErLiXiGameActUnitItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.go = arg_1_1
	arg_1_0._goDrag = arg_1_2
	arg_1_0._itemWidth = recthelper.getWidth(arg_1_0.go.transform)
	arg_1_0._imageicon = gohelper.findChildImage(arg_1_1, "icon")
	arg_1_0._gowall = gohelper.findChild(arg_1_1, "icon_wall")
	arg_1_0._imageiconbg = gohelper.findChildImage(arg_1_1, "image_BG")
	arg_1_0._txtcount = gohelper.findChildText(arg_1_1, "txt_count")
	arg_1_0._txtname = gohelper.findChildText(arg_1_1, "#txt_Num")
	arg_1_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_1_0._imageicon.gameObject)

	arg_1_0._drag:AddDragBeginListener(arg_1_0._onBeginDrag, arg_1_0, arg_1_1.transform)
	arg_1_0._drag:AddDragListener(arg_1_0._onDrag, arg_1_0)
	arg_1_0._drag:AddDragEndListener(arg_1_0._onEndDrag, arg_1_0, arg_1_1.transform)

	arg_1_0._bgiconwidthoffset = recthelper.getWidth(arg_1_0._imageiconbg.gameObject.transform) - recthelper.getWidth(arg_1_0._imageicon.gameObject.transform)
end

function var_0_0._onBeginDrag(arg_2_0, arg_2_1, arg_2_2)
	if WuErLiXiMapModel.instance:getLimitSelectUnitCount(arg_2_0._mo) < 1 then
		return
	end

	gohelper.setActive(arg_2_0._goDrag, false)
	arg_2_0:_setDragItem()
	AudioMgr.instance:trigger(AudioEnum.WuErLiXi.play_ui_diqiu_choose)
	arg_2_0._goDrag.transform:SetParent(arg_2_0.go.transform.parent.parent)

	local var_2_0 = arg_2_2.position
	local var_2_1 = recthelper.screenPosToAnchorPos(var_2_0, arg_2_0._goDrag.transform.parent)

	recthelper.setAnchor(arg_2_0._goDrag.transform, var_2_1.x, var_2_1.y)
	transformhelper.setLocalScale(arg_2_0._goDrag.transform, 1, 1, 1)
end

function var_0_0._setDragItem(arg_3_0)
	arg_3_0._imagedragicon = gohelper.findChildImage(arg_3_0._goDrag, "icon")
	arg_3_0._imagedragiconbg = gohelper.findChildImage(arg_3_0._goDrag, "image_BG")
	arg_3_0._txtdragname = gohelper.findChildText(arg_3_0._goDrag, "#txt_Num")

	local var_3_0 = WuErLiXiHelper.getUnitSpriteName(arg_3_0._mo.type, false)

	UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(arg_3_0._imagedragicon, var_3_0)
	UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(arg_3_0._imagedragiconbg, "v2a4_wuerlixi_node_icon2")

	arg_3_0._txtdragname.text = WuErLiXiMapModel.instance:getKeyAndSwitchTagById(arg_3_0._mo.id)

	TaskDispatcher.runDelay(arg_3_0._setDragPos, arg_3_0, 0.05)
end

function var_0_0._setDragPos(arg_4_0)
	gohelper.setActive(arg_4_0._goDrag, true)
	arg_4_0._imagedragicon:SetNativeSize()
	arg_4_0._imagedragiconbg:SetNativeSize()

	local var_4_0 = recthelper.getWidth(arg_4_0._imagedragicon.gameObject.transform)

	if arg_4_0._mo.type == WuErLiXiEnum.UnitType.SignalMulti then
		if arg_4_0._mo.dir == WuErLiXiEnum.Dir.Up or arg_4_0._mo.dir == WuErLiXiEnum.Dir.Down then
			recthelper.setWidth(arg_4_0._imagedragiconbg.gameObject.transform, var_4_0 + arg_4_0._bgiconwidthoffset)
			recthelper.setWidth(arg_4_0._goDrag.transform, var_4_0 + arg_4_0._bgiconwidthoffset)
		else
			recthelper.setHeight(arg_4_0._imagedragiconbg.gameObject.transform, var_4_0 + arg_4_0._bgiconwidthoffset)
			recthelper.setHeight(arg_4_0._goDrag.transform, var_4_0 + arg_4_0._bgiconwidthoffset)
		end
	else
		recthelper.setWidth(arg_4_0._goDrag.transform, arg_4_0._itemWidth)
		recthelper.setHeight(arg_4_0._goDrag.transform, arg_4_0._itemWidth)
	end

	transformhelper.setLocalRotation(arg_4_0._imagedragicon.gameObject.transform, 0, 0, -90 * arg_4_0._mo.dir)
end

function var_0_0._onDrag(arg_5_0, arg_5_1, arg_5_2)
	if WuErLiXiMapModel.instance:getLimitSelectUnitCount(arg_5_0._mo) < 1 then
		return
	end

	local var_5_0 = arg_5_2.position
	local var_5_1 = recthelper.screenPosToAnchorPos(var_5_0, arg_5_0._goDrag.transform.parent)

	recthelper.setAnchor(arg_5_0._goDrag.transform, var_5_1.x, var_5_1.y)
	WuErLiXiMapModel.instance:clearSelectUnit()
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.UnitDraging, var_5_0, arg_5_0._mo, arg_5_0._mo.type)
end

function var_0_0._onEndDrag(arg_6_0, arg_6_1, arg_6_2)
	if WuErLiXiMapModel.instance:getLimitSelectUnitCount(arg_6_0._mo) < 1 then
		return
	end

	local var_6_0 = arg_6_2.position
	local var_6_1 = recthelper.screenPosToAnchorPos(var_6_0, arg_6_0._goDrag.transform.parent)

	recthelper.setAnchor(arg_6_0._goDrag.transform, var_6_1.x, var_6_1.y)
	gohelper.setActive(arg_6_0._goDrag, false)
	WuErLiXiController.instance:dispatchEvent(WuErLiXiEvent.ActUnitDragEnd, var_6_0, arg_6_0._mo)
end

function var_0_0.setItem(arg_7_0, arg_7_1)
	arg_7_0._mo = arg_7_1

	gohelper.setActive(arg_7_0.go, false)

	local var_7_0 = WuErLiXiHelper.getUnitSpriteName(arg_7_0._mo.type, false)

	UISpriteSetMgr.instance:setV2a4WuErLiXiSprite(arg_7_0._imageicon, var_7_0)
	gohelper.setActive(arg_7_0._gowall, arg_7_0._mo.type == WuErLiXiEnum.UnitType.Obstacle)
	TaskDispatcher.runDelay(arg_7_0.setPos, arg_7_0, 0.05)

	local var_7_1 = WuErLiXiMapModel.instance:getLimitSelectUnitCount(arg_7_0._mo)

	arg_7_0._txtcount.text = luaLang("multiple") .. tostring(var_7_1)
	arg_7_0._txtname.text = WuErLiXiMapModel.instance:getKeyAndSwitchTagById(arg_7_0._mo.id)
end

function var_0_0.setPos(arg_8_0)
	gohelper.setActive(arg_8_0.go, true)
	arg_8_0._imageicon:SetNativeSize()
	arg_8_0._imageiconbg:SetNativeSize()

	local var_8_0 = recthelper.getWidth(arg_8_0._imageicon.gameObject.transform)

	if arg_8_0._mo.type == WuErLiXiEnum.UnitType.SignalMulti then
		if arg_8_0._mo.dir == WuErLiXiEnum.Dir.Up or arg_8_0._mo.dir == WuErLiXiEnum.Dir.Down then
			recthelper.setWidth(arg_8_0._imageiconbg.gameObject.transform, var_8_0 + arg_8_0._bgiconwidthoffset)
			recthelper.setWidth(arg_8_0.go.transform, var_8_0 + arg_8_0._bgiconwidthoffset)
		else
			recthelper.setHeight(arg_8_0._imageiconbg.gameObject.transform, var_8_0 + arg_8_0._bgiconwidthoffset)
			recthelper.setHeight(arg_8_0.go.transform, var_8_0 + arg_8_0._bgiconwidthoffset)
		end
	else
		recthelper.setWidth(arg_8_0.go.transform, arg_8_0._itemWidth)
		recthelper.setHeight(arg_8_0.go.transform, arg_8_0._itemWidth)
	end

	transformhelper.setLocalRotation(arg_8_0._imageicon.gameObject.transform, 0, 0, -90 * arg_8_0._mo.dir)
end

function var_0_0.resetItem(arg_9_0)
	local var_9_0 = WuErLiXiMapModel.instance:getLimitSelectUnitCount(arg_9_0._mo)

	arg_9_0._txtcount.text = luaLang("multiple") .. tostring(var_9_0)
end

function var_0_0.hide(arg_10_0)
	gohelper.setActive(arg_10_0.go, false)
end

function var_0_0.refreshCount(arg_11_0)
	return
end

function var_0_0.destroy(arg_12_0)
	arg_12_0._drag:RemoveDragListener()
	arg_12_0._drag:RemoveDragBeginListener()
	arg_12_0._drag:RemoveDragEndListener()
end

return var_0_0
