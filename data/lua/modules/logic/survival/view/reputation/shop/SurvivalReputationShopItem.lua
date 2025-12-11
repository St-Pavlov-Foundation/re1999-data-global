module("modules.logic.survival.view.reputation.shop.SurvivalReputationShopItem", package.seeall)

local var_0_0 = class("SurvivalReputationShopItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0.go_freeItem = gohelper.findChild(arg_1_0.viewGO, "normal/reward/#go_item")
	arg_1_0.survivalreputationshopbagitem = gohelper.findChild(arg_1_0.viewGO, "normal/layout/survivalreputationshopbagitem")
	arg_1_0.goGoods = gohelper.findChild(arg_1_0.viewGO, "normal/layout")
	arg_1_0.image_level = gohelper.findChildImage(arg_1_0.viewGO, "normal/#image_level")
	arg_1_0.go_lock = gohelper.findChild(arg_1_0.viewGO, "lock")
	arg_1_0.simage_panel = gohelper.findChildSingleImage(arg_1_0.viewGO, "normal/#simage_panel")
	arg_1_0.lockPlayer = SLFramework.AnimatorPlayer.Get(arg_1_0.go_lock)

	gohelper.setActive(arg_1_0.survivalreputationshopbagitem, false)

	arg_1_0.customItems = {}
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnReceiveSurvivalReputationRewardReply, arg_2_0.onReceiveSurvivalReputationRewardReply, arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnShopItemUpdate, arg_2_0._onShopItemUpdate, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	return
end

function var_0_0.onReceiveSurvivalReputationRewardReply(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.reputationId
	local var_4_1 = arg_4_1.level

	if var_4_0 == arg_4_0.prop.reputationId and var_4_1 == arg_4_0.posLevel then
		arg_4_0:refreshFreeItem()
		arg_4_0.freeSurvivalBagItem:playGainReputationFreeReward()
	end
end

function var_0_0._onShopItemUpdate(arg_5_0, arg_5_1, arg_5_2)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0.customItems) do
		if iter_5_1.survivalShopItemMo.uid == arg_5_2.uid then
			iter_5_1:refreshBagItem(arg_5_2)
		end
	end
end

function var_0_0.initInternal(arg_6_0, arg_6_1, arg_6_2)
	var_0_0.super.initInternal(arg_6_0, arg_6_1, arg_6_2)
end

function var_0_0.updateMo(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.survivalReputationShopView = arg_7_2
	arg_7_0.viewContainer = arg_7_1.viewContainer
	arg_7_0.index = arg_7_1.index
	arg_7_0.posLevel = arg_7_0.index
	arg_7_0.survivalReputationPropMo = arg_7_1.survivalReputationPropMo
	arg_7_0.prop = arg_7_0.survivalReputationPropMo.prop
	arg_7_0.reputationLevel = arg_7_0.prop.reputationLevel
	arg_7_0.reputationCfg = SurvivalConfig.instance:getReputationCfgById(arg_7_0.prop.reputationId, arg_7_0.reputationLevel)
	arg_7_0.reputationType = arg_7_0.reputationCfg.type
	arg_7_0.survivalShopMo = arg_7_0.survivalReputationPropMo.survivalShopMo
	arg_7_0.shopId = arg_7_0.survivalShopMo.id
	arg_7_0.shops = arg_7_0.survivalShopMo:getReputationShopItemByGroupId(arg_7_0.posLevel)
	arg_7_0.isLock = arg_7_0.survivalShopMo:isReputationShopLevelLock(arg_7_0.posLevel)

	if arg_7_1.isPlayLockAnim then
		gohelper.setActive(arg_7_0.go_lock, true)
		arg_7_0.lockPlayer:Play("close", arg_7_0.onLockAnimEnd, arg_7_0)
	else
		gohelper.setActive(arg_7_0.go_lock, arg_7_0.isLock)
	end

	local var_7_0 = "survival_reputationshop_panel_" .. arg_7_0.posLevel

	arg_7_0.simage_panel:LoadImage(ResUrl.getSurvivalShopItemLevelIcon(var_7_0))
	arg_7_0:refreshFreeItem()

	local var_7_1 = arg_7_0.shops
	local var_7_2 = #arg_7_0.customItems
	local var_7_3 = #var_7_1

	for iter_7_0 = 1, var_7_3 do
		local var_7_4 = var_7_1[iter_7_0]

		if var_7_2 < iter_7_0 then
			local var_7_5 = gohelper.clone(arg_7_0.survivalreputationshopbagitem, arg_7_0.goGoods)

			gohelper.setActive(var_7_5, true)

			arg_7_0.customItems[iter_7_0] = MonoHelper.addNoUpdateLuaComOnceToGo(var_7_5, SurvivalReputationShopBagItem)
		end

		local var_7_6 = {
			viewContainer = arg_7_0.viewContainer,
			survivalShopItemMo = var_7_4,
			onClickCallBack = arg_7_0.onClickShopItem,
			onClickContext = arg_7_0
		}

		arg_7_0.customItems[iter_7_0]:updateMo(var_7_6)
	end

	local var_7_7 = string.format("survival_level_icon_%s", arg_7_0.posLevel)

	UISpriteSetMgr.instance:setSurvivalSprite(arg_7_0.image_level, var_7_7)
end

function var_0_0.onLockAnimEnd(arg_8_0)
	gohelper.setActive(arg_8_0.go_lock, false)
end

function var_0_0.onClickShopItem(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.survivalShopItemMo.count <= 0

	arg_9_0.survivalReputationShopView:showInfoPanel(arg_9_1.survivalBagItem, arg_9_1.survivalShopItemMo, arg_9_0.shopId, arg_9_0.survivalShopMo.shopType, arg_9_0.isLock or var_9_0)
end

function var_0_0.onClickFree(arg_10_0)
	if not arg_10_0.isLock and not arg_10_0.isGainFreeReward then
		SurvivalWeekRpc.instance:sendSurvivalReputationRewardRequest(arg_10_0.prop.reputationId, arg_10_0.posLevel)
	elseif arg_10_0.isLock or arg_10_0.isGainFreeReward then
		arg_10_0.survivalReputationShopView:showInfoPanel(arg_10_0.freeSurvivalBagItem, arg_10_0.freeItemMo, nil, nil, arg_10_0.isLock)
	end
end

function var_0_0.refreshFreeItem(arg_11_0)
	arg_11_0.isGainFreeReward = arg_11_0.survivalReputationPropMo:isGainFreeReward(arg_11_0.posLevel)

	if not arg_11_0.freeItemMo then
		arg_11_0.freeItemMo = SurvivalBagItemMo.New()
	end

	if not arg_11_0.freeSurvivalBagItem then
		local var_11_0 = arg_11_0.viewContainer:getSetting().otherRes.survivalmapbagitem
		local var_11_1 = arg_11_0.viewContainer:getResInst(var_11_0, arg_11_0.go_freeItem)

		arg_11_0.freeSurvivalBagItem = MonoHelper.addNoUpdateLuaComOnceToGo(var_11_1, SurvivalBagItem)

		arg_11_0.freeSurvivalBagItem:setClickCallback(arg_11_0.onClickFree, arg_11_0)
	end

	local var_11_2 = SurvivalConfig.instance:getShopFreeReward(arg_11_0.prop.reputationId, arg_11_0.posLevel)

	if var_11_2 then
		arg_11_0.freeItemMo:init({
			id = var_11_2[1],
			count = var_11_2[2]
		})
		gohelper.setActive(arg_11_0.freeSurvivalBagItem.go, true)
		arg_11_0.freeSurvivalBagItem:updateMo(arg_11_0.freeItemMo, {
			jumpAdd = true
		})
		arg_11_0.freeSurvivalBagItem:setReputationShopStyle({
			isShowFreeReward = true,
			isCanGet = not arg_11_0.isLock and not arg_11_0.isGainFreeReward,
			isReceive = arg_11_0.isGainFreeReward
		})
	else
		gohelper.setActive(arg_11_0.freeSurvivalBagItem.go, false)
	end
end

return var_0_0
