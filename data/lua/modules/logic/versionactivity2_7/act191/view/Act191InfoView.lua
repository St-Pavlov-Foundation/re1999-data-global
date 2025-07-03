module("modules.logic.versionactivity2_7.act191.view.Act191InfoView", package.seeall)

local var_0_0 = class("Act191InfoView", BaseView)

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
	if arg_4_0.openViewName then
		arg_4_0:closeTipView()

		return
	end

	arg_4_0:closeThis()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.anim = gohelper.findChild(arg_5_0.viewGO, "right"):GetComponent(gohelper.Type_Animator)
	arg_5_0._txtRule2 = gohelper.findChildText(arg_5_0.viewGO, "right/simage_rightbg/txt_rule2")
	arg_5_0.rightTr = gohelper.findChild(arg_5_0.viewGO, "right").transform
end

function var_0_0.onOpen(arg_6_0)
	Act191StatController.instance:onViewOpen(arg_6_0.viewName)
	arg_6_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_6_0.onViewClose, arg_6_0)

	arg_6_0.actId = Activity191Model.instance:getCurActId()
	arg_6_0.actInfo = Activity191Model.instance:getActInfo()

	arg_6_0:initCharacterItem()
	arg_6_0:initCollectionItem()
	arg_6_0:initBuffItem()
end

function var_0_0.onClose(arg_7_0)
	arg_7_0:closeTipView()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mln_unlock)

	local var_7_0 = arg_7_0.viewContainer:isManualClose()

	Act191StatController.instance:statViewClose(arg_7_0.viewName, var_7_0)
end

function var_0_0.initCharacterItem(arg_8_0)
	arg_8_0.characterItemList = {}

	local var_8_0 = Activity191Config.instance:getShowRoleCoList()

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		local var_8_1 = arg_8_0:getUserDataTb_()

		var_8_1.config = iter_8_1

		local var_8_2 = gohelper.cloneInPlace(arg_8_0._goroleitem)
		local var_8_3 = gohelper.findButtonWithAudio(var_8_2)

		arg_8_0:addClickCb(var_8_3, arg_8_0.clickCharacterItem, arg_8_0, iter_8_0)

		local var_8_4 = gohelper.findChildImage(var_8_2, "rare")

		var_8_1.heroIcon = gohelper.findChildSingleImage(var_8_2, "heroicon")
		var_8_1.goSelect = gohelper.findChild(var_8_2, "go_select")

		var_8_1.heroIcon:LoadImage(Activity191Helper.getHeadIconSmall(iter_8_1))
		UISpriteSetMgr.instance:setAct174Sprite(var_8_4, "act174_roleframe_" .. tostring(iter_8_1.quality))

		arg_8_0.characterItemList[iter_8_0] = var_8_1
	end

	gohelper.setActive(arg_8_0._goroleitem, false)
end

function var_0_0.clickCharacterItem(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.characterItemList[arg_9_1]

	if var_9_0 == arg_9_0.selectItem then
		arg_9_0:closeTipView()
		arg_9_0:refreshSelect()
	else
		if arg_9_0.openViewName and arg_9_0.openViewName ~= ViewName.Act191HeroTipView then
			ViewMgr.instance:closeView(arg_9_0.openViewName, false, true)
		end

		arg_9_0.openViewName = ViewName.Act191HeroTipView

		local var_9_1 = {
			preview = true,
			notShowBg = true,
			heroList = {
				var_9_0.config.id
			},
			pos = arg_9_0.rightTr.position
		}

		Activity191Controller.instance:openHeroTipView(var_9_1)
		arg_9_0:refreshSelect(var_9_0)
	end
end

function var_0_0.initCollectionItem(arg_10_0)
	arg_10_0.collectionItemList = {}

	local var_10_0 = lua_activity191_collection.configList

	table.sort(var_10_0, function(arg_11_0, arg_11_1)
		return arg_11_0.rare < arg_11_1.rare
	end)

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		local var_10_1 = arg_10_0:getUserDataTb_()

		var_10_1.config = iter_10_1

		local var_10_2 = gohelper.cloneInPlace(arg_10_0._gocollectionitem)
		local var_10_3 = gohelper.findButtonWithAudio(var_10_2)

		arg_10_0:addClickCb(var_10_3, arg_10_0.clickCollectionItem, arg_10_0, iter_10_0)

		local var_10_4 = gohelper.findChildImage(var_10_2, "rare")

		var_10_1.collectionIcon = gohelper.findChildSingleImage(var_10_2, "collectionicon")
		var_10_1.goSelect = gohelper.findChild(var_10_2, "go_select")

		UISpriteSetMgr.instance:setAct174Sprite(var_10_4, "act174_propitembg_" .. iter_10_1.rare)
		var_10_1.collectionIcon:LoadImage(ResUrl.getRougeSingleBgCollection(iter_10_1.icon))

		arg_10_0.collectionItemList[iter_10_0] = var_10_1
	end

	gohelper.setActive(arg_10_0._gocollectionitem, false)
end

function var_0_0.clickCollectionItem(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.collectionItemList[arg_12_1]

	if var_12_0 == arg_12_0.selectItem then
		arg_12_0:closeTipView()
		arg_12_0:refreshSelect()
	else
		if arg_12_0.openViewName and arg_12_0.openViewName ~= ViewName.Act191CollectionTipView then
			ViewMgr.instance:closeView(arg_12_0.openViewName, false, true)
		end

		arg_12_0.openViewName = ViewName.Act191CollectionTipView

		local var_12_1 = {
			notShowBg = true,
			itemId = var_12_0.config.id,
			pos = arg_12_0.rightTr.position
		}

		Activity191Controller.instance:openCollectionTipView(var_12_1)
		arg_12_0:refreshSelect(var_12_0)
	end
end

function var_0_0.initBuffItem(arg_13_0)
	arg_13_0.buffItemList = {}

	local var_13_0 = lua_activity191_enhance.configList

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		local var_13_1 = arg_13_0:getUserDataTb_()

		var_13_1.config = iter_13_1

		local var_13_2 = gohelper.cloneInPlace(arg_13_0._gobuffitem)
		local var_13_3 = gohelper.findButtonWithAudio(var_13_2)

		arg_13_0:addClickCb(var_13_3, arg_13_0.clickBuffItem, arg_13_0, iter_13_0)

		local var_13_4 = gohelper.findChildImage(var_13_2, "rare")

		var_13_1.buffIcon = gohelper.findChildSingleImage(var_13_2, "bufficon")

		var_13_1.buffIcon:LoadImage(ResUrl.getAct174BuffIcon(iter_13_1.icon))

		var_13_1.goSelect = gohelper.findChild(var_13_2, "go_select")

		UISpriteSetMgr.instance:setAct174Sprite(var_13_4, "act174_propitembg_3")

		arg_13_0.buffItemList[iter_13_0] = var_13_1
	end

	gohelper.setActive(arg_13_0._gobuffitem, false)
end

function var_0_0.clickBuffItem(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0.buffItemList[arg_14_1]

	if var_14_0 == arg_14_0.selectItem then
		arg_14_0:closeTipView()
		arg_14_0:refreshSelect()
	else
		if arg_14_0.openViewName and arg_14_0.openViewName ~= ViewName.Act191EnhanceTipView then
			ViewMgr.instance:closeView(arg_14_0.openViewName, false, true)
		end

		arg_14_0.openViewName = ViewName.Act191EnhanceTipView

		local var_14_1 = {
			notShowBg = true,
			co = var_14_0.config,
			pos = arg_14_0.rightTr.position
		}

		Activity191Controller.instance:openEnhanceTipView(var_14_1)
		arg_14_0:refreshSelect(var_14_0)
	end
end

function var_0_0.refreshSelect(arg_15_0, arg_15_1)
	if arg_15_0.selectItem then
		gohelper.setActive(arg_15_0.selectItem.goSelect, false)
	end

	if arg_15_1 then
		gohelper.setActive(arg_15_1.goSelect, true)
	end

	arg_15_0.selectItem = arg_15_1
end

function var_0_0.closeTipView(arg_16_0)
	if ViewMgr.instance:isOpen(arg_16_0.openViewName) then
		ViewMgr.instance:closeView(arg_16_0.openViewName, false, true)
	end

	arg_16_0.openViewName = nil
end

function var_0_0.onViewClose(arg_17_0, arg_17_1)
	if arg_17_0.openViewName == arg_17_1 then
		arg_17_0:refreshSelect()

		arg_17_0.openViewName = nil
	end
end

return var_0_0
