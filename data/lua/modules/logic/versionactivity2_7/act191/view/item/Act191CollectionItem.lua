module("modules.logic.versionactivity2_7.act191.view.item.Act191CollectionItem", package.seeall)

local var_0_0 = class("Act191CollectionItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.transform = arg_1_1.transform
	arg_1_0.imageRare = gohelper.findChildImage(arg_1_1, "image_Rare")
	arg_1_0.simageIcon = gohelper.findChildSingleImage(arg_1_1, "simage_Icon")
	arg_1_0.goSelect = gohelper.findChild(arg_1_1, "go_Select")
	arg_1_0.goNew = gohelper.findChild(arg_1_1, "go_New")
	arg_1_0.btnClick = gohelper.findChildButtonWithAudio(arg_1_1, "btn_Click")
	arg_1_0.isSelect = false
	arg_1_0.sibling = gohelper.getSibling(arg_1_0.go)
	arg_1_0.dragging = false
	arg_1_0.anim = arg_1_1:GetComponent(gohelper.Type_Animator)
end

function var_0_0.addEventListeners(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnClick, arg_2_0._onItemClick, arg_2_0)
end

function var_0_0._onItemClick(arg_3_0)
	if arg_3_0.dragging then
		return
	end

	Activity191Controller.instance:dispatchEvent(Activity191Event.ClickCollectionItem, arg_3_0.itemInfo.uid, arg_3_0.itemInfo.itemId)
end

function var_0_0.setData(arg_4_0, arg_4_1)
	arg_4_0.itemInfo = arg_4_1

	local var_4_0 = Activity191Config.instance:getCollectionCo(arg_4_1.itemId)

	UISpriteSetMgr.instance:setAct174Sprite(arg_4_0.imageRare, "act174_propitembg_" .. var_4_0.rare)
	arg_4_0.simageIcon:LoadImage(ResUrl.getRougeSingleBgCollection(var_4_0.icon))
end

function var_0_0.setSelect(arg_5_0, arg_5_1)
	arg_5_0.isSelect = arg_5_1

	gohelper.setActive(arg_5_0.goSelect, arg_5_1)
end

function var_0_0.setActive(arg_6_0, arg_6_1)
	gohelper.setActive(arg_6_0.go, arg_6_1)
end

function var_0_0.setDrag(arg_7_0, arg_7_1)
	arg_7_0.dragging = arg_7_1
end

function var_0_0.playAnim(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_2 then
		arg_8_0.anim:Play(arg_8_1, 0, 1)
	else
		arg_8_0.anim:Play(arg_8_1, 0, 0)
	end
end

return var_0_0
