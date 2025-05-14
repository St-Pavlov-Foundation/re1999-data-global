module("modules.logic.versionactivity1_4.act134.view.Activity134BonusItem", package.seeall)

local var_0_0 = class("Activity134BonusItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._txtnormal = gohelper.findChildText(arg_1_0.viewGO, "normal/#txt_normal")
	arg_1_0._txtfinished = gohelper.findChildText(arg_1_0.viewGO, "finished/#txt_finished")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "#go_item")
	arg_1_0._gorewardtemplate = gohelper.findChild(arg_1_0._goitem, "#reward")
	arg_1_0._gonormal = gohelper.findChild(arg_1_0.viewGO, "normal")
	arg_1_0._gofinished = gohelper.findChild(arg_1_0.viewGO, "finished")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end

	arg_1_0:addEventListeners()
end

function var_0_0.onStart(arg_2_0)
	return
end

function var_0_0.onDestroyView(arg_3_0)
	arg_3_0:removeEventListeners()
end

function var_0_0.addEventListeners(arg_4_0)
	return
end

function var_0_0.removeEventListeners(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0._rewarditems) do
		iter_5_1.btn:RemoveClickListener()
		iter_5_1.simagereward:UnLoadImage()
	end
end

function var_0_0.initMo(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0.mo = arg_6_2
	arg_6_0.co = arg_6_2.config
	arg_6_0.index = arg_6_1
	arg_6_0._txtnormal.text = arg_6_2.needTokensQuantity
	arg_6_0._txtfinished.text = arg_6_2.needTokensQuantity

	arg_6_0:rewardItem()
end

function var_0_0.refreshProgress(arg_7_0)
	local var_7_0 = arg_7_0.mo.status == Activity134Enum.StroyStatus.Finish

	arg_7_0:refreshRewardItems(var_7_0)
	gohelper.setActive(arg_7_0._gonormal, not var_7_0)
	gohelper.setActive(arg_7_0._gofinished, var_7_0)
end

function var_0_0.rewardItem(arg_8_0)
	local var_8_0 = arg_8_0.co.bonus
	local var_8_1 = string.split(var_8_0, "|")

	arg_8_0._rewarditems = {}

	gohelper.setActive(arg_8_0._gorewardtemplate, false)

	for iter_8_0 = 1, #var_8_1 do
		local var_8_2 = string.splitToNumber(var_8_1[iter_8_0], "#")
		local var_8_3 = arg_8_0:getUserDataTb_()
		local var_8_4 = gohelper.clone(arg_8_0._gorewardtemplate, arg_8_0._goitem, "reward_" .. tostring(iter_8_0))

		var_8_3.imagebg = gohelper.findChildImage(var_8_4, "image_bg")
		var_8_3.imagecircle = gohelper.findChildImage(var_8_4, "image_circle")
		var_8_3.simagereward = gohelper.findChildSingleImage(var_8_4, "simage_reward")
		var_8_3.txtrewardcount = gohelper.findChildText(var_8_4, "txt_rewardcount")
		var_8_3.txtpointvalue = gohelper.findChildText(var_8_4, "txt_pointvalue")
		var_8_3.imagereward = var_8_3.simagereward:GetComponent(gohelper.Type_Image)
		var_8_3.btn = gohelper.findChildClick(var_8_4, "simage_reward")
		var_8_3.goalreadygot = gohelper.findChild(var_8_4, "go_hasget")

		var_8_3.btn:AddClickListener(arg_8_0.onClickItem, arg_8_0, var_8_3)

		var_8_3.go = var_8_4
		var_8_3.rewardCfg = var_8_2
		var_8_3.itemCfg, var_8_3.iconPath = ItemModel.instance:getItemConfigAndIcon(var_8_2[1], var_8_2[2])

		gohelper.setActive(var_8_3.go, true)
		UISpriteSetMgr.instance:setUiFBSprite(var_8_3.imagebg, "bg_pinjidi_" .. var_8_3.itemCfg.rare)
		UISpriteSetMgr.instance:setUiFBSprite(var_8_3.imagecircle, "bg_pinjidi_lanse_" .. var_8_3.itemCfg.rare)
		table.insert(arg_8_0._rewarditems, var_8_3)
	end
end

function var_0_0.refreshRewardItems(arg_9_0, arg_9_1)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0._rewarditems) do
		arg_9_0:refreshRewardUIItem(iter_9_1, arg_9_1)
	end
end

local var_0_1 = Color.New(0.6941177, 0.6941177, 0.6941177, 1)
local var_0_2 = Color.New(1, 1, 1, 1)
local var_0_3 = Color.New(1, 1, 1, 0.5)
local var_0_4 = Color.New(1, 1, 1, 1)
local var_0_5 = Color.New(0.4235, 0.4235, 0.4235, 1)
local var_0_6 = Color.New(0.9411, 0.9411, 0.9411, 1)

function var_0_0.refreshRewardUIItem(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_2 and var_0_1 or var_0_2
	local var_10_1 = arg_10_2 and var_0_3 or var_0_4
	local var_10_2 = arg_10_2 and var_0_5 or var_0_6

	arg_10_1.imagereward.color = var_10_0
	arg_10_1.imagebg.color = var_10_1
	arg_10_1.txtrewardcount.color = var_10_2

	arg_10_1.simagereward:LoadImage(arg_10_1.iconPath)

	arg_10_1.txtrewardcount.text = tostring(arg_10_1.rewardCfg[3])

	gohelper.setActive(arg_10_1.goalreadygot, arg_10_2)

	local var_10_3 = arg_10_1.go:GetComponent(typeof(UnityEngine.Animator))

	if arg_10_2 then
		var_10_3:Play("dungeoncumulativerewardsitem_received")
	end
end

function var_0_0.onClickItem(arg_11_0, arg_11_1)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	MaterialTipController.instance:showMaterialInfo(arg_11_1.rewardCfg[1], arg_11_1.rewardCfg[2])
end

return var_0_0
