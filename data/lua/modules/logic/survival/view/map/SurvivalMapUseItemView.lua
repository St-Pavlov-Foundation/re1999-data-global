module("modules.logic.survival.view.map.SurvivalMapUseItemView", package.seeall)

local var_0_0 = class("SurvivalMapUseItemView", BaseView)
local var_0_1 = {
	"BottomRight",
	"Left",
	"Top",
	"Bottom",
	"#go_lefttop"
}
local var_0_2 = 0.6
local var_0_3 = 0.42
local var_0_4 = 7
local var_0_5 = 10
local var_0_6 = Vector2()

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "#go_usedTips")
	arg_1_0._txtTips = gohelper.findChildTextMesh(arg_1_0.viewGO, "#go_usedTips/#txt_usedTips")
	arg_1_0._scrollRectWrap = gohelper.findChildScrollRect(arg_1_0.viewGO, "BottomRight/#go_bag/#scroll")
	arg_1_0._scroll = arg_1_0._scrollRectWrap.gameObject:GetComponent(gohelper.Type_LimitedScrollRect)
	arg_1_0._goviewport = gohelper.findChild(arg_1_0.viewGO, "BottomRight/#go_bag/#scroll/Viewport")
	arg_1_0._goitemroot = gohelper.findChild(arg_1_0.viewGO, "BottomRight/#go_bag/#scroll/Viewport/#go_item")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "BottomRight/#go_bag/#scroll/Viewport/#go_item/item")
	arg_1_0._allUIs = arg_1_0:getUserDataTb_()

	for iter_1_0, iter_1_1 in ipairs(var_0_1) do
		arg_1_0._allUIs[iter_1_0] = gohelper.findChild(arg_1_0.viewGO, iter_1_1)
	end
end

function var_0_0.addEvents(arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapBagUpdate, arg_2_0._refreshQuickItems, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnUseQuickItem, arg_2_0._onUseQuickItem, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnClickTipsBtn, arg_2_0._onClickTipsBtn, arg_2_0)
	arg_2_0.viewContainer:registerCallback(SurvivalEvent.OnClickSurvivalScene, arg_2_0._onSceneClick, arg_2_0)
	arg_2_0._scrollRectWrap:AddOnValueChanged(arg_2_0._onScrollRectValueChanged, arg_2_0)
	CommonDragHelper.instance:registerDragObj(arg_2_0._goviewport, arg_2_0._onBeginDrag, arg_2_0._onDrag, arg_2_0._onEndDrag, nil, arg_2_0, nil, true)
end

function var_0_0.removeEvents(arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapBagUpdate, arg_3_0._refreshQuickItems, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnUseQuickItem, arg_3_0._onUseQuickItem, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnClickTipsBtn, arg_3_0._onClickTipsBtn, arg_3_0)
	arg_3_0.viewContainer:unregisterCallback(SurvivalEvent.OnClickSurvivalScene, arg_3_0._onSceneClick, arg_3_0)
	arg_3_0._scrollRectWrap:RemoveOnValueChanged()
	CommonDragHelper.instance:unregisterDragObj(arg_3_0._goviewport, arg_3_0._onBeginDrag, nil, arg_3_0._onEndDrag, nil, arg_3_0, nil, true)
end

function var_0_0.onOpen(arg_4_0)
	SurvivalMapModel.instance.curUseItem = nil

	gohelper.setActive(arg_4_0._gotips, false)

	arg_4_0._txtTips.text = luaLang("survival_mainview_useitem_tips")

	local var_4_0 = arg_4_0.viewContainer._viewSetting.otherRes.infoView
	local var_4_1 = gohelper.create2d(arg_4_0.viewGO, "#go_info")
	local var_4_2 = arg_4_0:getResInst(var_4_0, var_4_1)

	arg_4_0._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(var_4_2, SurvivalBagInfoPart)

	arg_4_0._infoPanel:setCloseShow(true)
	arg_4_0._infoPanel:updateMo()

	arg_4_0._itemWidth = recthelper.getWidth(arg_4_0._goitem.transform)

	gohelper.setActive(arg_4_0._goitem, false)

	arg_4_0._contentWidth = recthelper.getWidth(arg_4_0._goitemroot.transform)
	arg_4_0._itemPool = arg_4_0:getUserDataTb_()
	arg_4_0._itemInst = arg_4_0:getUserDataTb_()
	arg_4_0._items = arg_4_0:getUserDataTb_()
	arg_4_0._curCenterIndex = 0

	arg_4_0:_refreshQuickItems()
end

function var_0_0._refreshQuickItems(arg_5_0)
	local var_5_0 = {}
	local var_5_1 = SurvivalMapModel.instance:getSceneMo()

	for iter_5_0, iter_5_1 in ipairs(var_5_1.bag.items) do
		if iter_5_1.co.type == SurvivalEnum.ItemType.Quick then
			table.insert(var_5_0, iter_5_1)
		end
	end

	local var_5_2 = 5 - #var_5_0

	if var_5_2 < 0 then
		var_5_2 = 0
	end

	local var_5_3 = math.ceil(var_5_2 / 2)
	local var_5_4 = var_5_2 - var_5_3

	for iter_5_2 = 1, var_5_3 do
		table.insert(var_5_0, 1, SurvivalBagItemMo.Empty)
	end

	for iter_5_3 = 1, var_5_4 do
		table.insert(var_5_0, SurvivalBagItemMo.Empty)
	end

	arg_5_0._showItemDatas = var_5_0

	arg_5_0:onViewPortScroll()
	arg_5_0:showGoNum(arg_5_0._curCenterIndex)
end

function var_0_0._onBeginDrag(arg_6_0, arg_6_1, arg_6_2)
	ZProj.UGUIHelper.PassEvent(arg_6_0._scrollRectWrap.gameObject, arg_6_2, 4)

	if arg_6_0._tweenId then
		ZProj.TweenHelper.KillById(arg_6_0._tweenId)

		arg_6_0._tweenId = nil
	end

	arg_6_0:showGoNum(nil)
	TaskDispatcher.cancelTask(arg_6_0._checkScrollIsEnd, arg_6_0)

	arg_6_0._scroll.inertia = true
end

function var_0_0._onDrag(arg_7_0, arg_7_1, arg_7_2)
	ZProj.UGUIHelper.PassEvent(arg_7_0._scrollRectWrap.gameObject, arg_7_2, 5)
end

function var_0_0._onEndDrag(arg_8_0, arg_8_1, arg_8_2)
	ZProj.UGUIHelper.PassEvent(arg_8_0._scrollRectWrap.gameObject, arg_8_2, 6)

	if math.abs(arg_8_0._scroll.velocity.x) > 100 then
		TaskDispatcher.runRepeat(arg_8_0._checkScrollIsEnd, arg_8_0, 0)
	else
		arg_8_0:doTweenIndex(arg_8_0._curCenterIndex)
	end
end

function var_0_0._checkScrollIsEnd(arg_9_0)
	if math.abs(arg_9_0._scroll.velocity.x) <= 100 then
		TaskDispatcher.cancelTask(arg_9_0._checkScrollIsEnd, arg_9_0)
		arg_9_0:doTweenIndex(arg_9_0._curCenterIndex)
	end
end

function var_0_0._onScrollRectValueChanged(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0:onViewPortScroll()
end

function var_0_0.onViewPortScroll(arg_11_0)
	arg_11_0:inPoolAll()

	local var_11_0 = arg_11_0._goitemroot.transform
	local var_11_1 = -recthelper.getAnchorX(var_11_0)
	local var_11_2 = arg_11_0._itemWidth * var_0_3 + var_0_4
	local var_11_3 = Mathf.Round(var_11_1 / var_11_2)
	local var_11_4 = var_11_3 * var_11_2
	local var_11_5 = math.abs(var_11_1 - var_11_4)
	local var_11_6 = var_0_3

	if var_11_5 <= var_0_5 then
		var_11_6 = var_0_2
	else
		var_11_6 = Mathf.Lerp(var_0_2, var_0_3, (var_11_5 - var_0_5) / (arg_11_0._itemWidth / 2 - var_0_5))
	end

	arg_11_0._curCenterIndex = var_11_3

	arg_11_0:createItem(var_11_4, var_11_6, var_11_3)

	local var_11_7 = var_0_3
	local var_11_8 = var_0_3
	local var_11_9 = var_11_4 - var_11_6 * arg_11_0._itemWidth * 0.5 - var_0_4
	local var_11_10 = var_11_4 + var_11_6 * arg_11_0._itemWidth * 0.5 + var_0_4

	if var_11_4 <= var_11_1 then
		var_11_8 = var_0_3 + var_0_2 - var_11_6
	else
		var_11_7 = var_0_3 + var_0_2 - var_11_6
	end

	local var_11_11 = var_11_3 - 1

	while var_11_1 - var_11_9 < arg_11_0._contentWidth / 2 do
		local var_11_12 = var_11_9 - var_11_7 * arg_11_0._itemWidth * 0.5

		arg_11_0:createItem(var_11_12, var_11_7, var_11_11)

		var_11_11 = var_11_11 - 1
		var_11_9 = var_11_9 - var_11_7 * arg_11_0._itemWidth - var_0_4
		var_11_7 = var_0_3
	end

	local var_11_13 = var_11_3 + 1

	while var_11_10 - var_11_1 < arg_11_0._contentWidth / 2 do
		local var_11_14 = var_11_10 + var_11_8 * arg_11_0._itemWidth * 0.5

		arg_11_0:createItem(var_11_14, var_11_8, var_11_13)

		var_11_13 = var_11_13 + 1
		var_11_10 = var_11_10 + var_11_8 * arg_11_0._itemWidth + var_0_4
		var_11_8 = var_0_3
	end

	arg_11_0:refreshItemActive()

	if arg_11_0._showIndex then
		arg_11_0:showGoNum(arg_11_0._showIndex)
	end
end

function var_0_0.createItem(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = arg_12_0:getFromPool()
	local var_12_1 = var_12_0.transform

	recthelper.setAnchorX(var_12_1, arg_12_1)
	transformhelper.setLocalScale(var_12_1, arg_12_2, arg_12_2, arg_12_2)

	local var_12_2 = gohelper.findChild(var_12_0, "#go_item/inst")
	local var_12_3 = gohelper.findChild(var_12_0, "#go_num")
	local var_12_4 = gohelper.findChildTextMesh(var_12_0, "#go_num/#txt_num")
	local var_12_5 = MonoHelper.getLuaComFromGo(var_12_2, SurvivalBagItem)
	local var_12_6 = arg_12_0:getItemMo(arg_12_3)

	var_12_0.name = "cell" .. arg_12_3

	var_12_5:updateMo(var_12_6)

	var_12_5.___index = arg_12_3
	arg_12_0._items[arg_12_3] = var_12_3
	var_12_4.text = var_12_6.count
end

function var_0_0.getItemMo(arg_13_0, arg_13_1)
	local var_13_0 = #arg_13_0._showItemDatas

	if var_13_0 <= 0 then
		return SurvivalBagItemMo.Empty
	end

	arg_13_1 = arg_13_1 + 3
	arg_13_1 = arg_13_1 % var_13_0

	if arg_13_1 <= 0 then
		arg_13_1 = arg_13_1 + var_13_0
	end

	return arg_13_0._showItemDatas[arg_13_1]
end

function var_0_0.inPoolAll(arg_14_0)
	tabletool.clear(arg_14_0._items)
	tabletool.addValues(arg_14_0._itemPool, arg_14_0._itemInst)
	tabletool.clear(arg_14_0._itemInst)
end

function var_0_0.refreshItemActive(arg_15_0)
	for iter_15_0, iter_15_1 in pairs(arg_15_0._itemPool) do
		recthelper.setAnchorY(iter_15_1.transform, 500)
	end

	for iter_15_2, iter_15_3 in pairs(arg_15_0._itemInst) do
		recthelper.setAnchorY(iter_15_3.transform, 0)
	end
end

function var_0_0.getFromPool(arg_16_0)
	local var_16_0 = table.remove(arg_16_0._itemPool)

	if not var_16_0 then
		var_16_0 = gohelper.cloneInPlace(arg_16_0._goitem)

		gohelper.setActive(var_16_0, true)

		local var_16_1 = arg_16_0.viewContainer:getSetting().otherRes.itemRes
		local var_16_2 = arg_16_0:getResInst(var_16_1, gohelper.findChild(var_16_0, "#go_item"), "inst")
		local var_16_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_16_2, SurvivalBagItem)

		var_16_3:setShowNum(false)
		var_16_3:setClickCallback(arg_16_0._onItemClick, arg_16_0)
		var_16_3:setCanClickEmpty(true)
	end

	table.insert(arg_16_0._itemInst, var_16_0)

	return var_16_0
end

function var_0_0.doTweenIndex(arg_17_0, arg_17_1)
	arg_17_0._scroll.velocity = var_0_6

	arg_17_0._scroll:StopMovement()

	arg_17_0._scroll.inertia = false
	arg_17_0._toIndex = arg_17_1

	local var_17_0 = -(arg_17_0._itemWidth * var_0_3 + var_0_4) * arg_17_1

	arg_17_0._tweenId = ZProj.TweenHelper.DOAnchorPosX(arg_17_0._goitemroot.transform, var_17_0, 0.2, arg_17_0._onTweenEnd, arg_17_0)
end

function var_0_0._onTweenEnd(arg_18_0)
	arg_18_0._scroll:StopMovement()

	arg_18_0._scroll.velocity = var_0_6
	arg_18_0._scroll.inertia = true
	arg_18_0._tweenId = nil

	arg_18_0:showGoNum(arg_18_0._toIndex)

	arg_18_0._toIndex = nil
end

function var_0_0.showGoNum(arg_19_0, arg_19_1)
	if SurvivalMapModel.instance.curUseItem then
		arg_19_0:cancelUseItem()
	end

	for iter_19_0, iter_19_1 in pairs(arg_19_0._items) do
		local var_19_0 = not arg_19_0:getItemMo(iter_19_0):isEmpty()

		gohelper.setActive(iter_19_1, var_19_0 and iter_19_0 == arg_19_1)
	end

	arg_19_0._showIndex = arg_19_1
end

function var_0_0._onItemClick(arg_20_0, arg_20_1)
	if arg_20_0._tweenId or not arg_20_0._showIndex then
		return
	end

	if arg_20_1.___index == arg_20_0._showIndex then
		if arg_20_1._mo == SurvivalMapModel.instance.curUseItem then
			arg_20_0:cancelUseItem()

			return
		end

		if arg_20_1._mo:isEmpty() then
			return
		end

		arg_20_0._infoPanel:updateMo(arg_20_1._mo)
	else
		arg_20_0:doTweenIndex(arg_20_1.___index)
	end
end

function var_0_0._onUseQuickItem(arg_21_0, arg_21_1)
	local var_21_0 = SurvivalMapModel.instance:getCurMapCo().walkables
	local var_21_1 = SurvivalMapModel.instance:getSceneMo().player.pos

	if arg_21_1.co.subType == SurvivalEnum.ItemSubType.Quick_Fly then
		local var_21_2 = (string.splitToNumber(arg_21_1.co.effect, "#") or {})[1] or 0
		local var_21_3 = SurvivalHelper.instance:getAllPointsByDis(var_21_1, var_21_2)

		for iter_21_0 = #var_21_3, 1, -1 do
			if var_21_3[iter_21_0] == var_21_1 or not SurvivalHelper.instance:isHaveNode(var_21_0, var_21_3[iter_21_0]) then
				table.remove(var_21_3, iter_21_0)
			end
		end

		arg_21_0._allCanUsePoints = var_21_3

		for iter_21_1, iter_21_2 in ipairs(var_21_3) do
			SurvivalMapHelper.instance:getScene().pointEffect:setPointEffectType(-1, iter_21_2.q, iter_21_2.r, 2)
		end
	elseif arg_21_1.co.subType == SurvivalEnum.ItemSubType.Quick_ClearFog then
		local var_21_4 = (string.splitToNumber(arg_21_1.co.effect, "#") or {})[1] or 0
		local var_21_5 = SurvivalHelper.instance:getAllPointsByDis(var_21_1, var_21_4)

		for iter_21_3 = #var_21_5, 1, -1 do
			if var_21_5[iter_21_3] == var_21_1 or not SurvivalHelper.instance:isHaveNode(var_21_0, var_21_5[iter_21_3]) then
				table.remove(var_21_5, iter_21_3)
			end
		end

		arg_21_0._allCanUsePoints = var_21_5

		for iter_21_4, iter_21_5 in ipairs(var_21_5) do
			SurvivalMapHelper.instance:getScene().pointEffect:setPointEffectType(-1, iter_21_5.q, iter_21_5.r, 2)
		end
	else
		SurvivalInteriorRpc.instance:sendSurvivalUseItemRequest(arg_21_1.uid, "")

		return
	end

	SurvivalMapModel.instance.curUseItem = arg_21_1

	gohelper.setActive(arg_21_0._gotips, true)

	for iter_21_6, iter_21_7 in ipairs(arg_21_0._allUIs) do
		gohelper.setActive(iter_21_7, false)
	end

	arg_21_0.viewContainer:setCloseFunc(arg_21_0.cancelUseItem, arg_21_0)
end

function var_0_0._onSceneClick(arg_22_0, arg_22_1, arg_22_2)
	if not SurvivalMapModel.instance.curUseItem then
		return
	end

	arg_22_2.use = true

	if tabletool.indexOf(arg_22_0._allCanUsePoints, arg_22_1) then
		SurvivalInteriorRpc.instance:sendSurvivalUseItemRequest(SurvivalMapModel.instance.curUseItem.uid, string.format("%d#%d", arg_22_1.q, arg_22_1.r))
	end

	arg_22_0:cancelUseItem()
end

function var_0_0.cancelUseItem(arg_23_0)
	gohelper.setActive(arg_23_0._gotips, false)
	SurvivalMapHelper.instance:getScene().pointEffect:clearPointsByKey(-1)

	SurvivalMapModel.instance.curUseItem = nil

	for iter_23_0, iter_23_1 in ipairs(arg_23_0._allUIs) do
		gohelper.setActive(iter_23_1, true)
	end

	arg_23_0.viewContainer:setCloseFunc()
end

function var_0_0._onClickTipsBtn(arg_24_0)
	arg_24_0._infoPanel:updateMo()
end

function var_0_0.onDestroyView(arg_25_0)
	if arg_25_0._tweenId then
		ZProj.TweenHelper.KillById(arg_25_0._tweenId)

		arg_25_0._tweenId = nil
	end

	SurvivalMapModel.instance.curUseItem = nil

	TaskDispatcher.cancelTask(arg_25_0._checkScrollIsEnd, arg_25_0)
end

return var_0_0
