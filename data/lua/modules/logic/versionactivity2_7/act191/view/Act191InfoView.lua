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

function var_0_0.onClickModalMask(arg_2_0)
	if arg_2_0.openViewName then
		arg_2_0:closeTipView()

		return
	end

	arg_2_0:closeThis()
end

function var_0_0._editableInitView(arg_3_0)
	arg_3_0.anim = gohelper.findChild(arg_3_0.viewGO, "right"):GetComponent(gohelper.Type_Animator)
	arg_3_0._txtRule2 = gohelper.findChildText(arg_3_0.viewGO, "right/simage_rightbg/txt_rule2")
	arg_3_0.rightTr = gohelper.findChild(arg_3_0.viewGO, "right").transform
end

function var_0_0.onOpen(arg_4_0)
	Act191StatController.instance:onViewOpen(arg_4_0.viewName)
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_4_0.onViewClose, arg_4_0)

	arg_4_0.actId = Activity191Model.instance:getCurActId()
	arg_4_0.actInfo = Activity191Model.instance:getActInfo()

	arg_4_0:initCharacterItem()
	arg_4_0:initCollectionItem()
	arg_4_0:initBuffItem()
end

function var_0_0.onClose(arg_5_0)
	arg_5_0:closeTipView()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_mln_unlock)

	local var_5_0 = arg_5_0.viewContainer:isManualClose()

	Act191StatController.instance:statViewClose(arg_5_0.viewName, var_5_0)
end

function var_0_0.initCharacterItem(arg_6_0)
	arg_6_0.characterItemList = {}

	local var_6_0 = Activity191Config.instance:getShowRoleCoList(arg_6_0.actId)

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		local var_6_1 = arg_6_0:getUserDataTb_()

		var_6_1.config = iter_6_1

		local var_6_2 = gohelper.cloneInPlace(arg_6_0._goroleitem)
		local var_6_3 = gohelper.findButtonWithAudio(var_6_2)

		arg_6_0:addClickCb(var_6_3, arg_6_0.clickCharacterItem, arg_6_0, iter_6_0)

		local var_6_4 = gohelper.findChildImage(var_6_2, "rare")

		var_6_1.heroIcon = gohelper.findChildSingleImage(var_6_2, "heroicon")
		var_6_1.goSelect = gohelper.findChild(var_6_2, "go_select")

		var_6_1.heroIcon:LoadImage(Activity191Helper.getHeadIconSmall(iter_6_1))
		UISpriteSetMgr.instance:setAct174Sprite(var_6_4, "act174_roleframe_" .. tostring(iter_6_1.quality))

		arg_6_0.characterItemList[iter_6_0] = var_6_1
	end

	gohelper.setActive(arg_6_0._goroleitem, false)
end

function var_0_0.clickCharacterItem(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0.characterItemList[arg_7_1]

	if var_7_0 == arg_7_0.selectItem then
		arg_7_0:closeTipView()
		arg_7_0:refreshSelect()
	else
		if arg_7_0.openViewName and arg_7_0.openViewName ~= ViewName.Act191HeroTipView then
			ViewMgr.instance:closeView(arg_7_0.openViewName, false, true)
		end

		arg_7_0.openViewName = ViewName.Act191HeroTipView

		local var_7_1 = {
			preview = true,
			notShowBg = true,
			heroList = {
				var_7_0.config.id
			},
			pos = arg_7_0.rightTr.position
		}

		Activity191Controller.instance:openHeroTipView(var_7_1)
		arg_7_0:refreshSelect(var_7_0)
	end
end

function var_0_0.initCollectionItem(arg_8_0)
	arg_8_0.collectionItemList = {}

	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(lua_activity191_collection.configList) do
		if iter_8_1.activityId == arg_8_0.actId then
			var_8_0[#var_8_0 + 1] = iter_8_1
		end
	end

	table.sort(var_8_0, function(arg_9_0, arg_9_1)
		return arg_9_0.rare < arg_9_1.rare
	end)

	for iter_8_2, iter_8_3 in ipairs(var_8_0) do
		local var_8_1 = arg_8_0:getUserDataTb_()

		var_8_1.config = iter_8_3

		local var_8_2 = gohelper.cloneInPlace(arg_8_0._gocollectionitem)
		local var_8_3 = gohelper.findButtonWithAudio(var_8_2)

		arg_8_0:addClickCb(var_8_3, arg_8_0.clickCollectionItem, arg_8_0, iter_8_2)

		local var_8_4 = gohelper.findChildImage(var_8_2, "rare")

		var_8_1.collectionIcon = gohelper.findChildSingleImage(var_8_2, "collectionicon")
		var_8_1.goSelect = gohelper.findChild(var_8_2, "go_select")

		UISpriteSetMgr.instance:setAct174Sprite(var_8_4, "act174_propitembg_" .. iter_8_3.rare)
		var_8_1.collectionIcon:LoadImage(ResUrl.getRougeSingleBgCollection(iter_8_3.icon))

		arg_8_0.collectionItemList[iter_8_2] = var_8_1
	end

	gohelper.setActive(arg_8_0._gocollectionitem, false)
end

function var_0_0.clickCollectionItem(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.collectionItemList[arg_10_1]

	if var_10_0 == arg_10_0.selectItem then
		arg_10_0:closeTipView()
		arg_10_0:refreshSelect()
	else
		if arg_10_0.openViewName and arg_10_0.openViewName ~= ViewName.Act191CollectionTipView then
			ViewMgr.instance:closeView(arg_10_0.openViewName, false, true)
		end

		arg_10_0.openViewName = ViewName.Act191CollectionTipView

		local var_10_1 = {
			notShowBg = true,
			itemId = var_10_0.config.id,
			pos = arg_10_0.rightTr.position
		}

		Activity191Controller.instance:openCollectionTipView(var_10_1)
		arg_10_0:refreshSelect(var_10_0)
	end
end

function var_0_0.initBuffItem(arg_11_0)
	arg_11_0.buffItemList = {}

	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(lua_activity191_enhance.configList) do
		if iter_11_1.activityId == arg_11_0.actId then
			var_11_0[#var_11_0 + 1] = iter_11_1
		end
	end

	for iter_11_2, iter_11_3 in ipairs(var_11_0) do
		local var_11_1 = arg_11_0:getUserDataTb_()

		var_11_1.config = iter_11_3

		local var_11_2 = gohelper.cloneInPlace(arg_11_0._gobuffitem)
		local var_11_3 = gohelper.findButtonWithAudio(var_11_2)

		arg_11_0:addClickCb(var_11_3, arg_11_0.clickBuffItem, arg_11_0, iter_11_2)

		local var_11_4 = gohelper.findChildImage(var_11_2, "rare")

		var_11_1.buffIcon = gohelper.findChildSingleImage(var_11_2, "bufficon")

		var_11_1.buffIcon:LoadImage(ResUrl.getAct174BuffIcon(iter_11_3.icon))

		var_11_1.goSelect = gohelper.findChild(var_11_2, "go_select")

		UISpriteSetMgr.instance:setAct174Sprite(var_11_4, "act174_propitembg_3")

		arg_11_0.buffItemList[iter_11_2] = var_11_1
	end

	gohelper.setActive(arg_11_0._gobuffitem, false)
end

function var_0_0.clickBuffItem(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0.buffItemList[arg_12_1]

	if var_12_0 == arg_12_0.selectItem then
		arg_12_0:closeTipView()
		arg_12_0:refreshSelect()
	else
		if arg_12_0.openViewName and arg_12_0.openViewName ~= ViewName.Act191EnhanceTipView then
			ViewMgr.instance:closeView(arg_12_0.openViewName, false, true)
		end

		arg_12_0.openViewName = ViewName.Act191EnhanceTipView

		local var_12_1 = {
			notShowBg = true,
			co = var_12_0.config,
			pos = arg_12_0.rightTr.position
		}

		Activity191Controller.instance:openEnhanceTipView(var_12_1)
		arg_12_0:refreshSelect(var_12_0)
	end
end

function var_0_0.refreshSelect(arg_13_0, arg_13_1)
	if arg_13_0.selectItem then
		gohelper.setActive(arg_13_0.selectItem.goSelect, false)
	end

	if arg_13_1 then
		gohelper.setActive(arg_13_1.goSelect, true)
	end

	arg_13_0.selectItem = arg_13_1
end

function var_0_0.closeTipView(arg_14_0)
	if ViewMgr.instance:isOpen(arg_14_0.openViewName) then
		ViewMgr.instance:closeView(arg_14_0.openViewName, false, true)
	end

	arg_14_0.openViewName = nil
end

function var_0_0.onViewClose(arg_15_0, arg_15_1)
	if arg_15_0.openViewName == arg_15_1 then
		arg_15_0:refreshSelect()

		arg_15_0.openViewName = nil
	end
end

return var_0_0
