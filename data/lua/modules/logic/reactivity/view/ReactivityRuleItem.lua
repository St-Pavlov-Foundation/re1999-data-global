module("modules.logic.reactivity.view.ReactivityRuleItem", package.seeall)

local var_0_0 = class("ReactivityRuleItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.reward1 = arg_1_0:createReward(gohelper.findChild(arg_1_1, "#reward1"))
	arg_1_0.reward2 = arg_1_0:createReward(gohelper.findChild(arg_1_1, "#reward2"))
end

function var_0_0.createReward(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0:getUserDataTb_()

	var_2_0.go = arg_2_1
	var_2_0.imageBg = gohelper.findChildImage(arg_2_1, "image_bg")
	var_2_0.simageReward = gohelper.findChildSingleImage(arg_2_1, "simage_reward")
	var_2_0.imageCircle = gohelper.findChildImage(arg_2_1, "image_circle")
	var_2_0.txtCount = gohelper.findChildTextMesh(arg_2_1, "txt_rewardcount")
	var_2_0.btn = gohelper.findButtonWithAudio(arg_2_1)

	var_2_0.btn:AddClickListener(var_0_0.onClickItem, var_2_0)

	return var_2_0
end

function var_0_0.onClickItem(arg_3_0)
	if not arg_3_0.data then
		return
	end

	MaterialTipController.instance:showMaterialInfo(arg_3_0.data.type, arg_3_0.data.id, false)
end

function var_0_0.addEventListeners(arg_4_0)
	return
end

function var_0_0.removeEventListeners(arg_5_0)
	return
end

function var_0_0.onUpdateMO(arg_6_0, arg_6_1)
	arg_6_0._mo = arg_6_1

	local var_6_0 = {
		quantity = 1,
		type = arg_6_1.typeId,
		id = arg_6_1.itemId
	}
	local var_6_1 = string.splitToNumber(arg_6_1.price, "#")
	local var_6_2 = {
		type = var_6_1[1],
		id = var_6_1[2],
		quantity = var_6_1[3]
	}

	arg_6_0:updateReward(arg_6_0.reward1, var_6_0)
	arg_6_0:updateReward(arg_6_0.reward2, var_6_2)
end

function var_0_0.updateReward(arg_7_0, arg_7_1, arg_7_2)
	arg_7_1.data = arg_7_2
	arg_7_1.txtCount.text = string.format("<size=25>×</size>%s", arg_7_2.quantity)

	local var_7_0, var_7_1 = ItemModel.instance:getItemConfigAndIcon(arg_7_2.type, arg_7_2.id)

	arg_7_1.simageReward:LoadImage(var_7_1)
	UISpriteSetMgr.instance:setUiFBSprite(arg_7_1.imageBg, "bg_pinjidi_" .. var_7_0.rare)
	UISpriteSetMgr.instance:setUiFBSprite(arg_7_1.imageCircle, "bg_pinjidi_lanse_" .. var_7_0.rare)
end

function var_0_0.destoryReward(arg_8_0, arg_8_1)
	arg_8_1.simageReward:UnLoadImage()
	arg_8_1.btn:RemoveClickListener()
end

function var_0_0.onDestroy(arg_9_0)
	arg_9_0:destoryReward(arg_9_0.reward1)
	arg_9_0:destoryReward(arg_9_0.reward2)
end

return var_0_0
