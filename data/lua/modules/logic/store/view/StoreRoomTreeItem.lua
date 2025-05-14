module("modules.logic.store.view.StoreRoomTreeItem", package.seeall)

local var_0_0 = class("StoreRoomTreeItem", TreeScrollCell)

function var_0_0.ctor(arg_1_0)
	arg_1_0._rootIndex = nil
	arg_1_0._nodeIndex = nil
	arg_1_0._go = nil
	arg_1_0._view = nil
	arg_1_0._isRoot = nil
	arg_1_0._isNode = nil
	arg_1_0.nodeItemList = {}
	arg_1_0._firstUpdate = true
	arg_1_0._animationStartTime = 0
	arg_1_0.openduration = 0.6
	arg_1_0.closeduration = 0.3
end

function var_0_0.initRoot(arg_2_0)
	local var_2_0 = arg_2_0:getUserDataTb_()

	var_2_0._go = gohelper.findChild(arg_2_0._go, "root")
	var_2_0._gomain = gohelper.findChild(var_2_0._go, "#go_main")
	var_2_0._simagebg = gohelper.findChildSingleImage(var_2_0._go, "#go_main/#simage_bg")
	var_2_0._simageicon = gohelper.findChildSingleImage(var_2_0._go, "#go_main/#simage_icon")
	var_2_0._simagemask = gohelper.findChildSingleImage(var_2_0._go, "#go_main/#simage_mask")
	var_2_0._simagetitle = gohelper.findChildSingleImage(var_2_0._go, "#go_main/#simage_title")
	var_2_0._txttitle = gohelper.findChildText(var_2_0._go, "#go_main/left/#txt_title")
	var_2_0._gotheme = gohelper.findChild(var_2_0._go, "#go_main/left/#txt_title/#go_theme")
	var_2_0._txttype = gohelper.findChildText(var_2_0._go, "#go_main/left/#txt_title/#go_theme/#txt_type")
	var_2_0._goclicktype = gohelper.findChild(var_2_0._go, "#go_main/left/#txt_title/#go_theme/clickArea")
	var_2_0._gotag = gohelper.findChild(var_2_0._go, "#go_main/left/#txt_title/#go_Tag")
	var_2_0._txttag = gohelper.findChildText(var_2_0._go, "#go_main/left/#txt_title/#go_Tag/#txt_Tag")
	var_2_0._txtdesc = gohelper.findChildText(var_2_0._go, "#go_main/left/#txt_desc")
	var_2_0._txthuolinum = gohelper.findChildText(var_2_0._go, "#go_main/left/info/huoli/#txt_huolinum")
	var_2_0._txtblocknum = gohelper.findChildText(var_2_0._go, "#go_main/left/info/dikuai/#txt_dikuainum")
	var_2_0._btnbuy = gohelper.findChildButtonWithAudio(var_2_0._go, "#go_main/right/#btn_buy")
	var_2_0._txtcost1num = gohelper.findChildText(var_2_0._go, "#go_main/right/#btn_buy/bg/cost1/#txt_cost1num")
	var_2_0._imagecost1num = gohelper.findChildImage(var_2_0._go, "#go_main/right/#btn_buy/bg/cost1/icon")
	var_2_0._txtcost2num = gohelper.findChildText(var_2_0._go, "#go_main/right/#btn_buy/bg/cost2/#txt_cost2num")
	var_2_0._imagecost2num = gohelper.findChildImage(var_2_0._go, "#go_main/right/#btn_buy/bg/cost2/icon")
	var_2_0._godiscount = gohelper.findChild(var_2_0._go, "#go_main/right/#go_discount")
	var_2_0._golimit = gohelper.findChild(var_2_0._go, "#go_main/right/#go_limit")
	var_2_0._gohas = gohelper.findChild(var_2_0._go, "#go_main/right/#go_has")
	var_2_0._txtdiscount = gohelper.findChildText(var_2_0._go, "#go_main/right/#go_discount/bg/label/#txt_discount")
	var_2_0._goempty = gohelper.findChild(var_2_0._go, "#go_empty")
	arg_2_0.root = var_2_0

	arg_2_0.root._simagebg:LoadImage(ResUrl.getStoreWildness("img_taozhuang_bg"))
	arg_2_0.root._simagetitle:LoadImage(ResUrl.getStoreWildness("img_deco_1"))
	arg_2_0.root._simagemask:LoadImage(ResUrl.getStoreWildness("mask"))

	var_2_0._gonewtag = gohelper.findChild(var_2_0._go, "#go_main/#go_newtag")
	var_2_0._goremaintime = gohelper.findChild(var_2_0._go, "#go_main/#go_remaintime")
	var_2_0._txtremiantime = gohelper.findChildText(var_2_0._go, "#go_main/#go_remaintime/#txt_remaintime")
	arg_2_0._animator = arg_2_0._go:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.initNode(arg_3_0)
	local var_3_0 = arg_3_0:getUserDataTb_()

	var_3_0._go = gohelper.findChild(arg_3_0._go, "node")
	var_3_0._simagedetailbg = gohelper.findChildSingleImage(var_3_0._go, "#simage_detailbg")
	var_3_0._content = gohelper.findChild(var_3_0._go, "content")
	arg_3_0.node = var_3_0
end

function var_0_0.addEventListeners(arg_4_0)
	return
end

function var_0_0.removeEventListeners(arg_5_0)
	if arg_5_0.root then
		if arg_5_0.root._click then
			arg_5_0.root._click:RemoveClickListener()
		end

		if arg_5_0.root._clickType then
			arg_5_0.root._clickType:RemoveClickListener()
		end

		arg_5_0.root._btnbuy:RemoveClickListener()
		arg_5_0.root._simagebg:UnLoadImage()
		arg_5_0.root._simageicon:UnLoadImage()
		arg_5_0.root._simagemask:UnLoadImage()
		arg_5_0.root._simagetitle:UnLoadImage()
	end

	if next(arg_5_0.nodeItemList) then
		for iter_5_0, iter_5_1 in ipairs(arg_5_0.nodeItemList) do
			iter_5_1.good:onDestroy()
		end

		arg_5_0.nodeItemList = nil
	end
end

function var_0_0._onClick(arg_6_0)
	if arg_6_0._view:isExpand(arg_6_0._rootIndex) then
		AudioMgr.instance:trigger(AudioEnum.HeroGroupUI.Play_UI_Team_Open)

		if arg_6_0.root._mo.treeRootParam then
			StoreController.instance:dispatchEvent(StoreEvent.OpenRoomStoreNode, {
				state = false,
				index = arg_6_0._rootIndex,
				itemHeight = recthelper.getHeight(arg_6_0._go.transform)
			})
		end
	else
		AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_close)

		if arg_6_0.root._mo.treeRootParam then
			StoreController.instance:dispatchEvent(StoreEvent.OpenRoomStoreNode, {
				state = true,
				index = arg_6_0._rootIndex,
				itemHeight = recthelper.getHeight(arg_6_0._go.transform)
			})
		end
	end

	arg_6_0.root._mo:setNewRedDotKey()
end

function var_0_0._onBuyBtn(arg_7_0, arg_7_1)
	if arg_7_1 then
		StoreController.instance:openNormalGoodsView(arg_7_1)
	else
		logError("没找到rootmo")
	end

	arg_7_0.root._mo:setNewRedDotKey()
	arg_7_0:refreshNewTag()
end

function var_0_0._onClickType(arg_8_0)
	if arg_8_0.themeId then
		ViewMgr.instance:openView(ViewName.RoomThemeTipView, {
			type = MaterialEnum.MaterialType.RoomTheme,
			id = arg_8_0.themeId
		})
	end

	arg_8_0.root._mo:setNewRedDotKey()
	arg_8_0:refreshNewTag()
end

function var_0_0._findThemeId(arg_9_0, arg_9_1)
	if not arg_9_1 then
		return
	end

	local var_9_0 = RoomConfig.instance

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		local var_9_1 = var_9_0:getThemeIdByItem(iter_9_1[2], iter_9_1[1])

		if var_9_1 then
			return var_9_1
		end
	end
end

function var_0_0.onSelect(arg_10_0, arg_10_1)
	return
end

function var_0_0.refreshNewTag(arg_11_0)
	local var_11_0 = arg_11_0.root._mo:checkShowNewRedDot()

	gohelper.setActive(arg_11_0.root._gonewtag, var_11_0)

	if var_11_0 then
		recthelper.setAnchorX(arg_11_0.root._txtremiantime.transform, -8)
	else
		recthelper.setAnchorX(arg_11_0.root._txtremiantime.transform, -40)
	end
end

function var_0_0.onUpdateRootMO(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.update

	if arg_12_1.type and arg_12_1.type == 0 then
		gohelper.setActive(arg_12_0.root._gomain, false)
		gohelper.setActive(arg_12_0.root._goempty, true)

		if arg_12_0.root._click then
			arg_12_0.root._click:RemoveClickListener()
		end

		if arg_12_1.update then
			arg_12_0._animationStartTime = Time.time
		end

		arg_12_0:_refreshOpenAnimation()

		arg_12_1.update = false
	else
		gohelper.setActive(arg_12_0.root._gomain, true)
		gohelper.setActive(arg_12_0.root._goempty, false)

		arg_12_0.has = false
		arg_12_0.root._mo = arg_12_1

		gohelper.setActive(arg_12_0.root._btnbuy.gameObject, true)
		gohelper.setActive(arg_12_0.root._gohas, false)
		arg_12_0.root._btnbuy:AddClickListener(arg_12_0._onBuyBtn, arg_12_0, arg_12_0.root._mo)

		arg_12_0.root._click = SLFramework.UGUI.UIClickListener.Get(arg_12_0.root._go)
		arg_12_0.root._clickType = SLFramework.UGUI.UIClickListener.Get(arg_12_0.root._goclicktype)

		arg_12_0.root._click:AddClickListener(arg_12_0._onClick, arg_12_0)
		arg_12_0.root._clickType:AddClickListener(arg_12_0._onClickType, arg_12_0)

		local var_12_1 = StoreConfig.instance:getGoodsConfig(arg_12_1.goodsId)
		local var_12_2 = var_12_1.product
		local var_12_3 = GameUtil.splitString2(var_12_2, true)

		arg_12_0.root._simageicon:LoadImage(var_12_1.bigImg)

		arg_12_0.root._txttitle.text = string.format("「%s」", arg_12_1.goodscn)

		local var_12_4 = GameUtil.splitString2(var_12_1.name)

		arg_12_0.root._txtdesc.text = var_12_4[1][2]

		local var_12_5 = var_12_1.cost

		if string.nilorempty(var_12_5) then
			arg_12_0.root._txtcost1num.text = luaLang("store_free")

			gohelper.setActive(arg_12_0.root._imagecost1num.gameObject, false)
		else
			local var_12_6 = string.split(var_12_5, "|")
			local var_12_7 = var_12_6[arg_12_1.buyCount + 1] or var_12_6[#var_12_6]
			local var_12_8 = string.splitToNumber(var_12_7, "#")
			local var_12_9 = var_12_8[1]
			local var_12_10 = var_12_8[2]

			arg_12_0.cost1Quantity = var_12_8[3]

			local var_12_11, var_12_12 = ItemModel.instance:getItemConfigAndIcon(var_12_9, var_12_10)
			local var_12_13 = var_12_11.icon
			local var_12_14 = string.format("%s_1", var_12_13)

			UISpriteSetMgr.instance:setCurrencyItemSprite(arg_12_0.root._imagecost1num, var_12_14)
			gohelper.setActive(arg_12_0.root._imagecost1num.gameObject, true)

			arg_12_0.root._txtcost1num.text = arg_12_0.cost1Quantity
		end

		local var_12_15 = var_12_1.cost2

		if string.nilorempty(var_12_15) then
			gohelper.setActive(arg_12_0.root._imagecost2num.gameObject, false)
		else
			local var_12_16 = string.split(var_12_15, "|")
			local var_12_17 = var_12_16[arg_12_1.buyCount + 1] or var_12_16[#var_12_16]
			local var_12_18 = string.splitToNumber(var_12_17, "#")
			local var_12_19 = var_12_18[1]
			local var_12_20 = var_12_18[2]

			arg_12_0.cost2Quantity = var_12_18[3]

			local var_12_21, var_12_22 = ItemModel.instance:getItemConfigAndIcon(var_12_19, var_12_20)
			local var_12_23 = var_12_21.icon
			local var_12_24 = string.format("%s_1", var_12_23)

			UISpriteSetMgr.instance:setCurrencyItemSprite(arg_12_0.root._imagecost2num, var_12_24)
			gohelper.setActive(arg_12_0.root._imagecost2num.gameObject, true)

			arg_12_0.root._txtcost2num.text = arg_12_0.cost2Quantity
		end

		gohelper.setActive(arg_12_0.root._godiscount, arg_12_1.config.originalCost > 0)

		if not string.nilorempty(arg_12_0.cost2Quantity) then
			local var_12_25 = arg_12_0.cost2Quantity / arg_12_1.config.originalCost
			local var_12_26 = math.ceil(var_12_25 * 100)

			arg_12_0.root._txtdiscount.text = string.format("-%d%%", 100 - var_12_26)
		end

		local var_12_27 = 0
		local var_12_28 = 0

		for iter_12_0, iter_12_1 in ipairs(var_12_3) do
			arg_12_0.itemType = iter_12_1[1]
			arg_12_0.itemId = iter_12_1[2]
			arg_12_0.itemNum = iter_12_1[3]

			if arg_12_0.itemType == MaterialEnum.MaterialType.BlockPackage then
				if arg_12_0.itemId and arg_12_0.itemNum then
					var_12_27 = var_12_27 + RoomConfig.instance:getBlockPackageFullDegree(arg_12_0.itemId) * arg_12_0.itemNum

					local var_12_29 = RoomConfig.instance:getBlockListByPackageId(arg_12_0.itemId) or {}

					for iter_12_2 = 1, #var_12_29 do
						local var_12_30 = var_12_29[iter_12_2]

						if var_12_30.ownType ~= RoomBlockEnum.OwnType.Special or RoomModel.instance:isHasBlockById(var_12_30.blockId) then
							var_12_28 = var_12_28 + 1
						end
					end

					if var_12_28 < 1 and #var_12_29 >= 1 then
						var_12_28 = 1
					end
				else
					logError("不存在值")
				end
			elseif arg_12_0.itemType == MaterialEnum.MaterialType.Building then
				if arg_12_0.itemId and arg_12_0.itemNum then
					var_12_27 = var_12_27 + RoomConfig.instance:getBuildingConfig(arg_12_0.itemId).buildDegree * arg_12_0.itemNum
				else
					logError("不存在值")
				end
			end
		end

		arg_12_0.root._txthuolinum.text = var_12_27
		arg_12_0.root._txtblocknum.text = var_12_28

		local var_12_31 = arg_12_0:checkChildCanJump(arg_12_1)

		gohelper.setActive(arg_12_0.root._gotheme, not var_12_31)
		gohelper.setActive(arg_12_0.root._gotag, var_12_31)
		gohelper.setActive(arg_12_0.root._golimit, var_12_31)
		gohelper.setActive(arg_12_0.root._btnbuy.gameObject, not var_12_31)

		if not var_12_31 then
			arg_12_0.themeId = arg_12_0:_findThemeId(var_12_3)

			gohelper.setActive(arg_12_0.root._txttype.gameObject, arg_12_0.themeId ~= nil)
			gohelper.setActive(arg_12_0.root._goclicktype, arg_12_0.themeId ~= nil)
		end

		arg_12_0.has = arg_12_1:alreadyHas()

		if arg_12_0.has then
			gohelper.setActive(arg_12_0.root._btnbuy.gameObject, false)
			gohelper.setActive(arg_12_0.root._gohas, true)
			gohelper.setActive(arg_12_0.root._golimit, false)
		end

		local var_12_32 = arg_12_1:checkShowNewRedDot()

		gohelper.setActive(arg_12_0.root._gonewtag, var_12_32)

		if var_12_32 then
			recthelper.setAnchorX(arg_12_0.root._txtremiantime.transform, -8)
		else
			recthelper.setAnchorX(arg_12_0.root._txtremiantime.transform, -40)
		end

		local var_12_33 = arg_12_1:getOfflineTime()
		local var_12_34 = var_12_33 - ServerTime.now()

		gohelper.setActive(arg_12_0.root._goremaintime, var_12_33 > 0)

		if var_12_34 > 3600 then
			local var_12_35, var_12_36 = TimeUtil.secondToRoughTime(var_12_34)

			arg_12_0.root._txtremiantime.text = formatLuaLang("remain", var_12_35 .. var_12_36)
		else
			arg_12_0.root._txtremiantime.text = luaLang("not_enough_one_hour")
		end
	end

	if var_12_0 then
		arg_12_0._animationStartTime = Time.time
	end

	if not arg_12_1.isjump then
		arg_12_0:_refreshOpenAnimation()
	end
end

function var_0_0.onUpdateNodeMO(arg_13_0, arg_13_1)
	arg_13_0.node._simagedetailbg:LoadImage(ResUrl.getStoreWildness("img_zhankai_bg"))

	if next(arg_13_0.nodeItemList) and arg_13_0.nodeItemList.index ~= arg_13_1.rootindex then
		for iter_13_0, iter_13_1 in ipairs(arg_13_0.nodeItemList) do
			iter_13_1.good:onDestroy()
		end

		gohelper.destroyAllChildren(arg_13_0.node._content)

		arg_13_0.nodeItemList = {}
	end

	if #arg_13_0.nodeItemList ~= #arg_13_1 then
		for iter_13_2, iter_13_3 in ipairs(arg_13_0.nodeItemList) do
			iter_13_3.good:onDestroy()
		end

		gohelper.destroyAllChildren(arg_13_0.node._content)

		arg_13_0.nodeItemList = {}
	end

	for iter_13_4, iter_13_5 in ipairs(arg_13_1) do
		local var_13_0 = arg_13_0.nodeItemList[iter_13_4]

		if var_13_0 == nil then
			var_13_0 = {
				parent = arg_13_0.node._content
			}

			local var_13_1 = arg_13_0._view:getResInst("ui/viewres/store/normalstoregoodsitem.prefab", var_13_0.parent, "roomNode" .. iter_13_4)

			var_13_0.good = MonoHelper.addNoUpdateLuaComOnceToGo(var_13_1, NormalStoreGoodsItem)

			var_13_0.good:hideOffflineTime()
			var_13_0.good:init(var_13_1)

			arg_13_0.nodeItemList[iter_13_4] = var_13_0
			arg_13_0.nodeItemList.index = arg_13_1.rootindex
		end

		var_13_0.good:onUpdateMO(iter_13_5)
		gohelper.setActive(var_13_0.go, true)
	end
end

function var_0_0._refreshOpenAnimation(arg_14_0)
	if not arg_14_0._animator or not arg_14_0._animator.gameObject.activeInHierarchy then
		return
	end

	local var_14_0 = arg_14_0:_getAnimationTime()

	arg_14_0._animator.speed = 1

	arg_14_0._animator:Play(UIAnimationName.Open, 0, 0)
	arg_14_0._animator:Update(0)

	local var_14_1 = arg_14_0._animator:GetCurrentAnimatorStateInfo(0).length

	if var_14_1 <= 0 then
		var_14_1 = 1
	end

	arg_14_0._animator:Play(UIAnimationName.Open, 0, (Time.time - var_14_0) / var_14_1)
	arg_14_0._animator:Update(0)
end

function var_0_0._getAnimationTime(arg_15_0)
	if not arg_15_0._animationStartTime then
		return nil
	end

	local var_15_0 = 0.1 * arg_15_0._rootIndex

	return arg_15_0._animationStartTime + var_15_0
end

function var_0_0.checkChildCanJump(arg_16_0, arg_16_1)
	if arg_16_1.children and #arg_16_1.children > 0 then
		for iter_16_0, iter_16_1 in ipairs(arg_16_1.children) do
			if iter_16_1.config.jumpId ~= 0 then
				return true
			end
		end
	end

	return false
end

return var_0_0
