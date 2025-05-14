module("modules.logic.versionactivity1_5.peaceulu.view.PeaceUluProgressItem", package.seeall)

local var_0_0 = class("PeaceUluProgressItem", MixScrollCell)

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
end

function var_0_0.onStart(arg_2_0)
	return
end

function var_0_0.onDestroyView(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0._rewarditems) do
		iter_3_1.simagereward:UnLoadImage()

		if iter_3_1.btnclick then
			iter_3_1.btnclick:RemoveClickListener()
		end
	end
end

function var_0_0.removeEventListeners(arg_4_0)
	return
end

function var_0_0.initMo(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.mo = arg_5_2
	arg_5_0.index = arg_5_1
	arg_5_0.targetNum = string.split(arg_5_0.mo.needProgress, "#")[3]
	arg_5_0._txtfinished.text = arg_5_0.targetNum
	arg_5_0._txtnormal.text = arg_5_0.targetNum

	arg_5_0:rewardItem()
end

function var_0_0.refreshProgress(arg_6_0)
	local var_6_0 = PeaceUluModel.instance:checkGetReward(arg_6_0.mo.id)

	arg_6_0:refreshRewardItems(var_6_0)
	gohelper.setActive(arg_6_0._gonormal, not var_6_0)
	gohelper.setActive(arg_6_0._gofinished, var_6_0)
end

function var_0_0.rewardItem(arg_7_0)
	local var_7_0 = arg_7_0.mo.bonus
	local var_7_1 = string.split(var_7_0, "|")

	arg_7_0._rewarditems = {}

	gohelper.setActive(arg_7_0._gorewardtemplate, false)

	for iter_7_0 = 1, #var_7_1 do
		local var_7_2 = string.splitToNumber(var_7_1[iter_7_0], "#")
		local var_7_3 = arg_7_0:getUserDataTb_()
		local var_7_4 = gohelper.clone(arg_7_0._gorewardtemplate, arg_7_0._goitem, "reward_" .. tostring(iter_7_0))

		var_7_3.imagebg = gohelper.findChildImage(var_7_4, "image_bg")
		var_7_3.imagecircle = gohelper.findChildImage(var_7_4, "image_circle")
		var_7_3.simagereward = gohelper.findChildSingleImage(var_7_4, "simage_reward")
		var_7_3.txtrewardcount = gohelper.findChildText(var_7_4, "txt_rewardcount")
		var_7_3.txtpointvalue = gohelper.findChildText(var_7_4, "txt_pointvalue")
		var_7_3.imagereward = var_7_3.simagereward:GetComponent(gohelper.Type_Image)
		var_7_3.goalreadygot = gohelper.findChild(var_7_4, "go_hasget")
		var_7_3.btnclick = gohelper.findChildButtonWithAudio(var_7_4, "btn_click")
		var_7_3.go = var_7_4
		var_7_3.rewardCfg = var_7_2
		var_7_3.itemCfg, var_7_3.iconPath = ItemModel.instance:getItemConfigAndIcon(var_7_2[1], var_7_2[2])

		gohelper.setActive(var_7_3.go, true)
		UISpriteSetMgr.instance:setUiFBSprite(var_7_3.imagebg, "bg_pinjidi_" .. var_7_3.itemCfg.rare)
		UISpriteSetMgr.instance:setUiFBSprite(var_7_3.imagecircle, "bg_pinjidi_lanse_" .. var_7_3.itemCfg.rare)
		table.insert(arg_7_0._rewarditems, var_7_3)
	end
end

function var_0_0.onClickRewardItem(arg_8_0, arg_8_1)
	if arg_8_1 then
		MaterialTipController.instance:showMaterialInfo(arg_8_1[1], arg_8_1[2])
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

	arg_10_1.txtrewardcount.text = "×" .. tostring(arg_10_1.rewardCfg[3])

	arg_10_1.btnclick:RemoveClickListener()
	arg_10_1.btnclick:AddClickListener(arg_10_0.onClickRewardItem, arg_10_0, arg_10_1.rewardCfg)
	gohelper.setActive(arg_10_1.goalreadygot, arg_10_2)

	local var_10_3 = arg_10_1.go:GetComponent(typeof(UnityEngine.Animator))

	if arg_10_2 then
		var_10_3:Play("dungeoncumulativerewardsitem_received")
	end
end

return var_0_0
