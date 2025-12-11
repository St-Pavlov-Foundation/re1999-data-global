module("modules.logic.versionactivity2_7.act191.view.item.Act191HeroGroupItem2", package.seeall)

local var_0_0 = class("Act191HeroGroupItem2", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.goEmpty = gohelper.findChild(arg_1_1, "go_Empty")
	arg_1_0.goCollection = gohelper.findChild(arg_1_1, "go_Collection")
	arg_1_0.imageRare = gohelper.findChildImage(arg_1_1, "go_Collection/image_Rare")
	arg_1_0.simageIcon = gohelper.findChildSingleImage(arg_1_1, "go_Collection/simage_Icon")
	arg_1_0.btnClick = gohelper.findChildButtonWithAudio(arg_1_1, "btn_Click")
	arg_1_0.dragging = false
end

function var_0_0.addEventListeners(arg_2_0)
	if arg_2_0.btnClick then
		arg_2_0:addClickCb(arg_2_0.btnClick, arg_2_0.onClick, arg_2_0)
	end
end

function var_0_0.setData(arg_3_0, arg_3_1)
	arg_3_0.itemUid = arg_3_1

	if arg_3_1 and arg_3_1 ~= 0 then
		local var_3_0 = Activity191Model.instance:getActInfo():getGameInfo():getItemInfoInWarehouse(arg_3_1)

		arg_3_0.itemId = var_3_0.itemId

		local var_3_1 = Activity191Config.instance:getCollectionCo(var_3_0.itemId)

		UISpriteSetMgr.instance:setAct174Sprite(arg_3_0.imageRare, "act174_propitembg_" .. var_3_1.rare)
		arg_3_0.simageIcon:LoadImage(ResUrl.getRougeSingleBgCollection(var_3_1.icon))
		gohelper.setActive(arg_3_0.goCollection, true)
		gohelper.setActive(arg_3_0.goEmpty, false)
	else
		arg_3_0.itemId = 0

		gohelper.setActive(arg_3_0.goCollection, false)
		gohelper.setActive(arg_3_0.goEmpty, true)
	end
end

function var_0_0.setIndex(arg_4_0, arg_4_1)
	arg_4_0._index = arg_4_1
end

function var_0_0.onClick(arg_5_0)
	if arg_5_0.dragging then
		return
	end

	if arg_5_0.callback then
		arg_5_0.callback(arg_5_0.callbackObj, arg_5_0.itemId)

		return
	end

	local var_5_0 = {
		index = arg_5_0._index
	}

	ViewMgr.instance:openView(ViewName.Act191CollectionView, var_5_0)

	if arg_5_0.param then
		Act191StatController.instance:statButtonClick(arg_5_0.param.fromView, string.format("itemClick_%s_%s_%s", arg_5_0.param.type, arg_5_0._index, arg_5_0.itemId))
	end
end

function var_0_0.setExtraParam(arg_6_0, arg_6_1)
	arg_6_0.param = arg_6_1
end

function var_0_0.setOverrideClick(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0.callback = arg_7_1
	arg_7_0.callbackObj = arg_7_2
end

function var_0_0.setDrag(arg_8_0, arg_8_1)
	arg_8_0.dragging = arg_8_1
end

return var_0_0
