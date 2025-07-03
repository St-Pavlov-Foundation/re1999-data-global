module("modules.logic.versionactivity2_7.act191.view.item.Act191HeroGroupItem2", package.seeall)

local var_0_0 = class("Act191HeroGroupItem2", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.handleView = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0.goEmpty = gohelper.findChild(arg_2_1, "go_Empty")
	arg_2_0.goCollection = gohelper.findChild(arg_2_1, "go_Collection")
	arg_2_0.imageRare = gohelper.findChildImage(arg_2_1, "go_Collection/image_Rare")
	arg_2_0.simageIcon = gohelper.findChildSingleImage(arg_2_1, "go_Collection/simage_Icon")
	arg_2_0.btnClick = gohelper.findChildButtonWithAudio(arg_2_1, "btn_Click")
end

function var_0_0.addEventListeners(arg_3_0)
	if arg_3_0.btnClick then
		arg_3_0:addClickCb(arg_3_0.btnClick, arg_3_0.onClick, arg_3_0)
	end
end

function var_0_0.setData(arg_4_0, arg_4_1)
	arg_4_0.itemUid = arg_4_1

	if arg_4_1 and arg_4_1 ~= 0 then
		local var_4_0 = Activity191Model.instance:getActInfo():getGameInfo():getItemInfoInWarehouse(arg_4_1)

		arg_4_0.itemId = var_4_0.itemId

		local var_4_1 = Activity191Config.instance:getCollectionCo(var_4_0.itemId)

		UISpriteSetMgr.instance:setAct174Sprite(arg_4_0.imageRare, "act174_propitembg_" .. var_4_1.rare)
		arg_4_0.simageIcon:LoadImage(ResUrl.getRougeSingleBgCollection(var_4_1.icon))
		gohelper.setActive(arg_4_0.goCollection, true)
		gohelper.setActive(arg_4_0.goEmpty, false)
	else
		arg_4_0.itemId = 0

		gohelper.setActive(arg_4_0.goCollection, false)
		gohelper.setActive(arg_4_0.goEmpty, true)
	end
end

function var_0_0.setIndex(arg_5_0, arg_5_1)
	arg_5_0._index = arg_5_1
end

function var_0_0.onClick(arg_6_0)
	if arg_6_0.handleView and arg_6_0.handleView._nowDragingIndex then
		return
	end

	if arg_6_0.callback then
		arg_6_0.callback(arg_6_0.callbackObj, arg_6_0.itemId)

		return
	end

	local var_6_0 = {
		index = arg_6_0._index
	}

	ViewMgr.instance:openView(ViewName.Act191CollectionEditView, var_6_0)

	if arg_6_0.param then
		Act191StatController.instance:statButtonClick(arg_6_0.param.fromView, string.format("itemClick_%s_%s_%s", arg_6_0.param.type, arg_6_0._index, arg_6_0.itemId))
	end
end

function var_0_0.setExtraParam(arg_7_0, arg_7_1)
	arg_7_0.param = arg_7_1
end

function var_0_0.setOverrideClick(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0.callback = arg_8_1
	arg_8_0.callbackObj = arg_8_2
end

return var_0_0
