module("modules.logic.versionactivity2_3.act174.view.outside.Act174RotationView", package.seeall)

local var_0_0 = class("Act174RotationView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goroleitem = gohelper.findChild(arg_1_0.viewGO, "right/scroll_rule/Viewport/go_content/role/#go_roleitem")
	arg_1_0._gocollectionitem = gohelper.findChild(arg_1_0.viewGO, "right/scroll_rule/Viewport/go_content/collection/#go_collectionitem")
	arg_1_0._gobuffitem = gohelper.findChild(arg_1_0.viewGO, "right/scroll_rule/Viewport/go_content/buff/#go_buffitem")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onClickModalMask(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.anim = gohelper.findChild(arg_5_0.viewGO, "right"):GetComponent(gohelper.Type_Animator)
	arg_5_0._txtRule2 = gohelper.findChildText(arg_5_0.viewGO, "right/simage_rightbg/txt_rule2")
end

function var_0_0.onUpdateParam(arg_6_0)
	return
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0.actId = Activity174Model.instance:getCurActId()
	arg_7_0.actInfo = Activity174Model.instance:getActInfo()

	arg_7_0:refreshSeason()
	arg_7_0:initCharacterItem()
	arg_7_0:initCollectionItem()
	arg_7_0:initBuffItem()
end

function var_0_0.refreshSeason(arg_8_0)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(lua_activity174_season.configList) do
		if iter_8_1.activityId == arg_8_0.actId then
			var_8_0[iter_8_1.season] = iter_8_1
		end
	end

	local var_8_1 = arg_8_0.actInfo.season
	local var_8_2 = var_8_0[var_8_1 + 1]

	if var_8_2 and not string.nilorempty(var_8_2.openTime) then
		local var_8_3 = TimeUtil.stringToTimestamp(var_8_2.openTime) + ServerTime.clientToServerOffset() - ServerTime.now()
		local var_8_4 = TimeUtil.secondsToDDHHMMSS(var_8_3)
		local var_8_5 = luaLang("act174_rotation_rule2")

		arg_8_0._txtRule2.text = GameUtil.getSubPlaceholderLuaLangOneParam(var_8_5, GameUtil.getNum2Chinese(var_8_4))
	end

	gohelper.setActive(arg_8_0._txtRule2, var_8_0[var_8_1 + 1])
end

function var_0_0.onClose(arg_9_0)
	arg_9_0:closeTipView()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mln_unlock)
end

function var_0_0.onDestroyView(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.characterItemList) do
		iter_10_1.heroIcon:UnLoadImage()
	end

	for iter_10_2, iter_10_3 in ipairs(arg_10_0.collectionItemList) do
		iter_10_3.collectionIcon:UnLoadImage()
	end

	for iter_10_4, iter_10_5 in ipairs(arg_10_0.buffItemList) do
		iter_10_5.buffIcon:UnLoadImage()
	end
end

function var_0_0.initCharacterItem(arg_11_0)
	arg_11_0.characterItemList = {}

	local var_11_0 = arg_11_0.actInfo:getRuleHeroCoList()

	table.sort(var_11_0, Activity174Helper.sortActivity174RoleCo)

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		local var_11_1 = arg_11_0:getUserDataTb_()

		var_11_1.config = iter_11_1

		local var_11_2 = gohelper.cloneInPlace(arg_11_0._goroleitem)
		local var_11_3 = gohelper.findButtonWithAudio(var_11_2)

		arg_11_0:addClickCb(var_11_3, arg_11_0.clickCharacterItem, arg_11_0, iter_11_0)

		local var_11_4 = gohelper.findChildImage(var_11_2, "rare")

		var_11_1.heroIcon = gohelper.findChildSingleImage(var_11_2, "heroicon")
		var_11_1.goSelect = gohelper.findChild(var_11_2, "go_select")

		var_11_1.heroIcon:LoadImage(ResUrl.getHeadIconSmall(iter_11_1.skinId))
		UISpriteSetMgr.instance:setCommonSprite(var_11_4, "bgequip" .. tostring(CharacterEnum.Color[iter_11_1.rare]))

		arg_11_0.characterItemList[iter_11_0] = var_11_1
	end

	gohelper.setActive(arg_11_0._goroleitem, false)
end

function var_0_0.clickCharacterItem(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.characterItemList[arg_12_1]

	if var_12_0 == arg_12_0.selectItem then
		arg_12_0:closeTipView()
		arg_12_0:refreshSelect()
	else
		local var_12_1 = {
			type = Activity174Enum.ItemTipType.Character,
			co = var_12_0.config,
			pos = Vector2.New(-470, 0)
		}

		Activity174Controller.instance:openItemTipView(var_12_1)
		arg_12_0:refreshSelect(var_12_0)
	end
end

function var_0_0.initCollectionItem(arg_13_0)
	arg_13_0.collectionItemList = {}

	local var_13_0 = arg_13_0.actInfo:getRuleCollectionCoList()

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		local var_13_1 = arg_13_0:getUserDataTb_()

		var_13_1.config = iter_13_1

		local var_13_2 = gohelper.cloneInPlace(arg_13_0._gocollectionitem)
		local var_13_3 = gohelper.findButtonWithAudio(var_13_2)

		arg_13_0:addClickCb(var_13_3, arg_13_0.clickCollectionItem, arg_13_0, iter_13_0)

		local var_13_4 = gohelper.findChildImage(var_13_2, "rare")

		var_13_1.collectionIcon = gohelper.findChildSingleImage(var_13_2, "collectionicon")
		var_13_1.goSelect = gohelper.findChild(var_13_2, "go_select")

		UISpriteSetMgr.instance:setAct174Sprite(var_13_4, "act174_propitembg_" .. iter_13_1.rare)
		var_13_1.collectionIcon:LoadImage(ResUrl.getRougeSingleBgCollection(iter_13_1.icon))

		arg_13_0.collectionItemList[iter_13_0] = var_13_1
	end

	gohelper.setActive(arg_13_0._gocollectionitem, false)
end

function var_0_0.clickCollectionItem(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.collectionItemList[arg_14_1]

	if var_14_0 == arg_14_0.selectItem then
		arg_14_0:closeTipView()
		arg_14_0:refreshSelect()
	else
		local var_14_1 = {
			type = Activity174Enum.ItemTipType.Collection,
			co = var_14_0.config,
			pos = Vector2.New(-300, 0)
		}

		Activity174Controller.instance:openItemTipView(var_14_1)
		arg_14_0:refreshSelect(var_14_0)
	end
end

function var_0_0.initBuffItem(arg_15_0)
	arg_15_0.buffItemList = {}

	local var_15_0 = arg_15_0.actInfo:getRuleBuffCoList()

	for iter_15_0, iter_15_1 in ipairs(var_15_0) do
		local var_15_1 = arg_15_0:getUserDataTb_()

		var_15_1.config = iter_15_1

		local var_15_2 = gohelper.cloneInPlace(arg_15_0._gobuffitem)
		local var_15_3 = gohelper.findButtonWithAudio(var_15_2)

		arg_15_0:addClickCb(var_15_3, arg_15_0.clickBuffItem, arg_15_0, iter_15_0)

		local var_15_4 = gohelper.findChildImage(var_15_2, "rare")

		var_15_1.buffIcon = gohelper.findChildSingleImage(var_15_2, "bufficon")

		var_15_1.buffIcon:LoadImage(ResUrl.getAct174BuffIcon(iter_15_1.icon))

		var_15_1.goSelect = gohelper.findChild(var_15_2, "go_select")

		UISpriteSetMgr.instance:setAct174Sprite(var_15_4, "act174_propitembg_3")

		arg_15_0.buffItemList[iter_15_0] = var_15_1
	end

	gohelper.setActive(arg_15_0._gobuffitem, false)
end

function var_0_0.clickBuffItem(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0.buffItemList[arg_16_1]

	if var_16_0 == arg_16_0.selectItem then
		arg_16_0:closeTipView()
		arg_16_0:refreshSelect()
	else
		local var_16_1 = {
			type = Activity174Enum.ItemTipType.Buff,
			co = var_16_0.config,
			pos = Vector2.New(-300, 0)
		}

		Activity174Controller.instance:openItemTipView(var_16_1)
		arg_16_0:refreshSelect(var_16_0)
	end
end

function var_0_0.refreshSelect(arg_17_0, arg_17_1)
	if arg_17_0.selectItem then
		gohelper.setActive(arg_17_0.selectItem.goSelect, false)
	end

	if arg_17_1 then
		gohelper.setActive(arg_17_1.goSelect, true)
	end

	arg_17_0.selectItem = arg_17_1
end

function var_0_0.closeTipView(arg_18_0)
	if ViewMgr.instance:isOpen(ViewName.Act174ItemTipView) then
		ViewMgr.instance:closeView(ViewName.Act174ItemTipView, false, true)
	end
end

return var_0_0
