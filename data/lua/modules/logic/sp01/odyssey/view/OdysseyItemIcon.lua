module("modules.logic.sp01.odyssey.view.OdysseyItemIcon", package.seeall)

local var_0_0 = class("OdysseyItemIcon", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.param = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0:__onInit()

	arg_2_0.go = arg_2_1
	arg_2_0._imageRare = gohelper.findChildImage(arg_2_0.go, "rare")
	arg_2_0._simageIcon = gohelper.findChildSingleImage(arg_2_0.go, "icon")
	arg_2_0._goExpIcon = gohelper.findChild(arg_2_0.go, "expIcon")
	arg_2_0._goTalentIcon = gohelper.findChild(arg_2_0.go, "talentIcon")
	arg_2_0._goUnknowSuitIcon = gohelper.findChild(arg_2_0.go, "unknowSuitIcon")
	arg_2_0._goCount = gohelper.findChild(arg_2_0.go, "countbg")
	arg_2_0._txtCount = gohelper.findChildText(arg_2_0.go, "count")
	arg_2_0._goSuit = gohelper.findChild(arg_2_0.go, "suit")
	arg_2_0._imageSuit = gohelper.findChildImage(arg_2_0.go, "suit/image_suitIcon")
	arg_2_0._goHero = gohelper.findChild(arg_2_0.go, "hero")
	arg_2_0._simageHeroIcon = gohelper.findChildSingleImage(arg_2_0.go, "hero/simage_heroIcon")
	arg_2_0._btnClick = gohelper.findChildButtonWithAudio(arg_2_0.go, "click")
	arg_2_0.fontSize = arg_2_0._txtCount.fontSize
	arg_2_0.countBgScale = transformhelper.getLocalScale(arg_2_0._goCount.transform)
end

function var_0_0.addEventListeners(arg_3_0)
	arg_3_0._btnClick:AddClickListener(arg_3_0.onClick, arg_3_0)
end

function var_0_0.removeEventListeners(arg_4_0)
	arg_4_0._btnClick:RemoveClickListener()
end

function var_0_0.onClick(arg_5_0)
	if arg_5_0.rewardItemType == OdysseyEnum.RewardItemType.OuterItem then
		if arg_5_0.type and arg_5_0.type > 0 and arg_5_0.itemId and arg_5_0.itemId > 0 then
			MaterialTipController.instance:showMaterialInfo(arg_5_0.type, arg_5_0.itemId)
		end
	else
		local var_5_0 = {
			itemId = arg_5_0.itemId,
			clickPos = GamepadController.instance:getMousePosition()
		}

		OdysseyController.instance:showItemTipView(var_5_0)
	end
end

function var_0_0.initRewardItemInfo(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_1 == OdysseyEnum.RewardItemType.Item then
		arg_6_0:initItemInfo(arg_6_1, arg_6_2, arg_6_3)
	elseif arg_6_1 == OdysseyEnum.RewardItemType.OuterItem then
		arg_6_0:initOuterItemInfo(arg_6_1, arg_6_2, arg_6_3)
	elseif arg_6_1 == OdysseyEnum.RewardItemType.Exp then
		arg_6_0:showExpItem(arg_6_2)
	elseif arg_6_1 == OdysseyEnum.RewardItemType.Talent then
		arg_6_0:showTalentItem(arg_6_2)
	end
end

function var_0_0.initItemInfo(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0:hideItemIcon()
	gohelper.setActive(arg_7_0._simageIcon, true)
	gohelper.setActive(arg_7_0._btnClick.gameObject, true)

	arg_7_0.rewardItemType = arg_7_1
	arg_7_0.itemId = arg_7_2
	arg_7_0.itemCount = arg_7_3
	arg_7_0.itemConfig = OdysseyConfig.instance:getItemConfig(arg_7_0.itemId)

	if arg_7_0.itemConfig.type == OdysseyEnum.ItemType.Item then
		arg_7_0._simageIcon:LoadImage(ResUrl.getSp01OdysseyItemSingleBg(arg_7_0.itemConfig.icon))
	elseif arg_7_0.itemConfig.type == OdysseyEnum.ItemType.Equip then
		arg_7_0._simageIcon:LoadImage(ResUrl.getSp01OdysseyItemSingleBg(arg_7_0.itemConfig.icon))
	end

	UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(arg_7_0._imageRare, "odyssey_item_quality" .. arg_7_0.itemConfig.rare)

	arg_7_0._txtCount.text = arg_7_0.itemCount

	arg_7_0:refreshItemEquipState()
	arg_7_0:setFontScale()
end

function var_0_0.initOuterItemInfo(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0:hideItemIcon()
	gohelper.setActive(arg_8_0._simageIcon, true)
	gohelper.setActive(arg_8_0._btnClick.gameObject, true)

	arg_8_0.rewardItemType = arg_8_1
	arg_8_0.type = arg_8_2.type
	arg_8_0.itemId = arg_8_2.id
	arg_8_0.itemCount = arg_8_3
	arg_8_0.itemConfig, arg_8_0.iconUrl = ItemModel.instance:getItemConfigAndIcon(arg_8_0.type, arg_8_0.itemId, true)

	arg_8_0._simageIcon:LoadImage(arg_8_0.iconUrl)
	UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(arg_8_0._imageRare, "odyssey_item_quality" .. OdysseyEnum.OuterItemRareColor[arg_8_0.itemConfig.rare])

	arg_8_0._txtCount.text = arg_8_0.itemCount

	arg_8_0:setFontScale()
end

function var_0_0.showTalentItem(arg_9_0, arg_9_1)
	arg_9_0:hideItemIcon()
	gohelper.setActive(arg_9_0._goTalentIcon, true)

	arg_9_0._txtCount.text = arg_9_1

	local var_9_0 = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.TalentItemRare)

	UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(arg_9_0._imageRare, "odyssey_item_quality" .. tonumber(var_9_0.value))
	arg_9_0:setFontScale()
end

function var_0_0.showExpItem(arg_10_0, arg_10_1)
	arg_10_0:hideItemIcon()
	gohelper.setActive(arg_10_0._goExpIcon, true)

	arg_10_0._txtCount.text = arg_10_1

	local var_10_0 = OdysseyConfig.instance:getConstConfig(OdysseyEnum.ConstId.ExpItemRare)

	UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(arg_10_0._imageRare, "odyssey_item_quality" .. tonumber(var_10_0.value))
	arg_10_0:setFontScale()
end

function var_0_0.showUnknowSuitIcon(arg_11_0, arg_11_1)
	arg_11_0:hideItemIcon()
	gohelper.setActive(arg_11_0._goUnknowSuitIcon, true)
	UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(arg_11_0._imageRare, "odyssey_item_quality" .. arg_11_1)
	arg_11_0:setShowCountState(false)
end

function var_0_0.hideItemIcon(arg_12_0)
	gohelper.setActive(arg_12_0._simageIcon, false)
	gohelper.setActive(arg_12_0._goSuit, false)
	gohelper.setActive(arg_12_0._goHero, false)
	gohelper.setActive(arg_12_0._goExpIcon, false)
	gohelper.setActive(arg_12_0._goTalentIcon, false)
	gohelper.setActive(arg_12_0._goUnknowSuitIcon, false)
	gohelper.setActive(arg_12_0._btnClick.gameObject, false)
end

function var_0_0.refreshItemEquipState(arg_13_0)
	local var_13_0 = arg_13_0.itemConfig.type == OdysseyEnum.ItemType.Equip

	gohelper.setActive(arg_13_0._goHero, var_13_0 and false)

	local var_13_1 = arg_13_0.itemConfig.type == OdysseyEnum.ItemType.Equip

	gohelper.setActive(arg_13_0._goSuit, var_13_1)

	if var_13_1 then
		local var_13_2 = OdysseyConfig.instance:getEquipSuitConfig(arg_13_0.itemConfig.suitId)

		UISpriteSetMgr.instance:setSp01OdysseyDungeonSprite(arg_13_0._imageSuit, var_13_2.icon)
	end
end

function var_0_0.setFontScale(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.go.transform.parent
	local var_14_1 = var_14_0 and transformhelper.getLocalScale(var_14_0) or 1

	transformhelper.setLocalScale(arg_14_0._goCount.transform, arg_14_0.countBgScale, arg_14_1 or arg_14_0.countBgScale / var_14_1, arg_14_0.countBgScale)

	arg_14_0._txtCount.fontSize = arg_14_0.fontSize * (arg_14_1 or 1 / var_14_1)
end

function var_0_0.setShowCountState(arg_15_0, arg_15_1)
	gohelper.setActive(arg_15_0._goCount, arg_15_1)
	gohelper.setActive(arg_15_0._txtCount.gameObject, arg_15_1)
end

function var_0_0.destroy(arg_16_0)
	arg_16_0:__onDispose()
	arg_16_0._simageIcon:UnLoadImage()
end

return var_0_0
