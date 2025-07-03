module("modules.logic.versionactivity2_7.act191.view.item.Act191CollectionEditItem", package.seeall)

local var_0_0 = class("Act191CollectionEditItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.imageRare = gohelper.findChildImage(arg_1_1, "image_Rare")
	arg_1_0.simageIcon = gohelper.findChildSingleImage(arg_1_1, "simage_Icon")
	arg_1_0.simageHeroIcon = gohelper.findChildSingleImage(arg_1_1, "simage_HeroIcon")
	arg_1_0.goSelect = gohelper.findChild(arg_1_1, "go_Select")
	arg_1_0.goNew = gohelper.findChild(arg_1_1, "go_New")
	arg_1_0.btnClick = gohelper.findChildButtonWithAudio(arg_1_1, "btn_Click")
	arg_1_0._animator = arg_1_0.go:GetComponent(typeof(UnityEngine.Animator))
	arg_1_0.isSelect = false
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnClick, arg_2_0._onItemClick, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	return
end

function var_0_0.onUpdateMO(arg_4_0, arg_4_1)
	arg_4_0._mo = arg_4_1
	arg_4_0.itemInfo = Activity191Model.instance:getActInfo():getGameInfo():getItemInfoInWarehouse(arg_4_1.uid)

	local var_4_0 = Activity191Config.instance:getCollectionCo(arg_4_0.itemInfo.itemId)

	UISpriteSetMgr.instance:setAct174Sprite(arg_4_0.imageRare, "act174_propitembg_" .. var_4_0.rare)
	arg_4_0.simageIcon:LoadImage(ResUrl.getRougeSingleBgCollection(var_4_0.icon))

	if arg_4_1.heroId then
		local var_4_1 = Activity191Config.instance:getRoleCoByNativeId(arg_4_1.heroId, 1)
		local var_4_2 = Activity191Helper.getHeadIconSmall(var_4_1)

		arg_4_0.simageHeroIcon:LoadImage(var_4_2)
	end

	gohelper.setActive(arg_4_0.simageHeroIcon, arg_4_1.heroId)
end

function var_0_0.onSelect(arg_5_0, arg_5_1)
	arg_5_0.isSelect = arg_5_1

	gohelper.setActive(arg_5_0.goSelect, arg_5_1)

	if arg_5_1 then
		Activity191Controller.instance:dispatchEvent(Activity191Event.OnClickCollectionGroupItem, arg_5_0._mo)
	end
end

function var_0_0._onItemClick(arg_6_0)
	if not arg_6_0.isSelect then
		arg_6_0._view:selectCell(arg_6_0._index, true)
	end
end

function var_0_0.onDestroy(arg_7_0)
	return
end

function var_0_0.getAnimator(arg_8_0)
	return arg_8_0._animator
end

return var_0_0
