module("modules.logic.survival.view.shelter.SurvivalShelterRewardItem", package.seeall)

local var_0_0 = class("SurvivalShelterRewardItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._rectTransform = arg_1_0.viewGO.transform
	arg_1_0._gospecial = gohelper.findChild(arg_1_0.viewGO, "#go_special")
	arg_1_0.txtScore = gohelper.findChildTextMesh(arg_1_0.viewGO, "#txt_score")
	arg_1_0.goScoreBg = gohelper.findChild(arg_1_0.viewGO, "#go_special/scorebg")
	arg_1_0.goScoreBgGrey = gohelper.findChild(arg_1_0.viewGO, "#go_special/scorebg_grey")
	arg_1_0.txtIndex = gohelper.findChildTextMesh(arg_1_0.viewGO, "#txt_index")
	arg_1_0._imagepoint = gohelper.findChildImage(arg_1_0.viewGO, "#image_point")
	arg_1_0._goRewardParent = gohelper.findChild(arg_1_0.viewGO, "#go_item")
	arg_1_0._rectRewardParent = arg_1_0._goRewardParent.transform
	arg_1_0._goRewardTemplate = gohelper.findChild(arg_1_0.viewGO, "#go_item/#go_rewarditem")

	gohelper.setActive(arg_1_0._goRewardTemplate, false)

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

function var_0_0.refresh(arg_4_0, arg_4_1)
	if arg_4_1 then
		arg_4_0:onUpdateMO(arg_4_1)
		gohelper.setActive(arg_4_0.viewGO, true)
	else
		arg_4_0.data = nil

		gohelper.setActive(arg_4_0.viewGO, false)
	end
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	arg_5_0.data = arg_5_1
	arg_5_0.config = arg_5_1

	arg_5_0:refreshReward()
	arg_5_0:refreshChapter()
end

function var_0_0.refreshReward(arg_6_0)
	local var_6_0 = arg_6_0.config
	local var_6_1 = DungeonConfig.instance:getRewardItems(tonumber(var_6_0.reward))

	if not arg_6_0._rewardItems then
		arg_6_0._rewardItems = {}
	end

	for iter_6_0 = 1, math.max(#arg_6_0._rewardItems, #var_6_1) do
		local var_6_2 = var_6_1[iter_6_0]
		local var_6_3 = arg_6_0._rewardItems[iter_6_0]

		if not var_6_3 then
			var_6_3 = arg_6_0:createRewardItem(iter_6_0)
			arg_6_0._rewardItems[iter_6_0] = var_6_3
		end

		arg_6_0:refreshRewardItem(var_6_3, var_6_2)
	end
end

function var_0_0.createRewardItem(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getUserDataTb_()
	local var_7_1 = gohelper.clone(arg_7_0._goRewardTemplate, arg_7_0._goRewardParent, "reward_" .. tostring(arg_7_1))

	var_7_0.go = var_7_1
	var_7_0.imagebg = gohelper.findChildImage(var_7_1, "bg")
	var_7_0.txtrewardcount = gohelper.findChildText(var_7_1, "txt_rewardcount")
	var_7_0.goalreadygot = gohelper.findChild(var_7_1, "go_hasget")
	var_7_0.gocanget = gohelper.findChild(var_7_1, "go_canget")
	var_7_0.btn = gohelper.findChildButtonWithAudio(var_7_1, "btn_click")

	var_7_0.btn:AddClickListener(arg_7_0.onClickItem, arg_7_0, var_7_0)

	var_7_0.rewardAnim = var_7_0.go:GetComponent(typeof(UnityEngine.Animator))
	var_7_0.goSp = gohelper.findChild(var_7_1, "reward_sp")
	var_7_0.goNormal = gohelper.findChild(var_7_1, "goreward")

	return var_7_0
end

local var_0_1 = Color.New(1, 1, 1, 1)

function var_0_0.refreshRewardItem(arg_8_0, arg_8_1, arg_8_2)
	arg_8_1.data = arg_8_2

	if not arg_8_2 then
		gohelper.setActive(arg_8_1.go, false)

		return
	end

	gohelper.setActive(arg_8_1.go, true)

	local var_8_0 = arg_8_0.config
	local var_8_1 = SurvivalModel.instance:getRewardState(var_8_0.id, var_8_0.score)
	local var_8_2, var_8_3 = ItemModel.instance:getItemConfigAndIcon(arg_8_2[1], arg_8_2[2])

	if var_8_2 then
		UISpriteSetMgr.instance:setSurvivalSprite(arg_8_1.imagebg, "survival_shelter_reward_quality_" .. var_8_2.rare)
	end

	if not arg_8_1.itemIcon then
		arg_8_1.itemIcon = IconMgr.instance:getCommonPropItemIcon(arg_8_1.goNormal)
	end

	arg_8_1.itemIcon:setMOValue(arg_8_2[1], arg_8_2[2], arg_8_2[3], nil, true)

	if arg_8_2[1] == MaterialEnum.MaterialType.Equip then
		arg_8_1.itemIcon._equipIcon:_overrideLoadIconFunc(EquipHelper.getEquipDefaultIconLoadPath, arg_8_1.itemIcon._equipIcon)
		arg_8_1.itemIcon._equipIcon:_loadIconImage()
	end

	arg_8_1.itemIcon:isShowQuality(false)
	arg_8_1.itemIcon:isShowCount(false)
	arg_8_1.itemIcon:hideEquipLvAndBreak(true)

	arg_8_1.txtrewardcount.text = string.format("<size=25>x</size>%s", tostring(arg_8_2[3]))

	gohelper.setActive(arg_8_1.goalreadygot, var_8_1 == 2)

	local var_8_4 = var_8_1 == 1

	gohelper.setActive(arg_8_1.gocanget, var_8_4)

	local var_8_5 = arg_8_2[2] == 672801

	gohelper.setActive(arg_8_1.goSp, var_8_5)
	gohelper.setActive(arg_8_1.goNormal, not var_8_5)

	if var_8_1 == 2 then
		arg_8_1.rewardAnim.enabled = true

		arg_8_1.rewardAnim:Play("dungeoncumulativerewardsitem_receiveenter")
	elseif var_8_1 == 1 then
		arg_8_1.rewardAnim.enabled = true

		arg_8_1.rewardAnim:Play("dungeoncumulativerewardsitem_received")
	else
		arg_8_1.rewardAnim.enabled = false
		arg_8_1.imagebg.color = var_0_1
	end
end

function var_0_0.onClickItem(arg_9_0, arg_9_1)
	if not arg_9_0.config then
		return
	end

	local var_9_0 = arg_9_0.config

	if SurvivalModel.instance:getRewardState(var_9_0.id, var_9_0.score) == 1 then
		SurvivalOutSideRpc.instance:sendSurvivalOutSideGainReward(0)
	elseif arg_9_1.data then
		MaterialTipController.instance:showMaterialInfo(arg_9_1.data[1], arg_9_1.data[2])
	end
end

local var_0_2 = "#8C1603"
local var_0_3 = "#000000"
local var_0_4 = "#994C3D"
local var_0_5 = "#333333"

function var_0_0.refreshChapter(arg_10_0)
	local var_10_0 = arg_10_0.config
	local var_10_1 = SurvivalModel.instance:getRewardState(var_10_0.id, var_10_0.score)
	local var_10_2 = var_10_0.special == 1
	local var_10_3 = "survival_shelter_reward_point2_0"
	local var_10_4 = var_0_3
	local var_10_5 = var_0_5
	local var_10_6 = var_10_1 == 0

	if var_10_6 then
		var_10_3 = var_10_2 and "survival_shelter_reward_point1_0" or "survival_shelter_reward_point2_0"
	else
		var_10_3 = var_10_2 and "survival_shelter_reward_point1_1" or "survival_shelter_reward_point2_1"

		local var_10_7 = var_0_2

		var_10_5 = var_0_4
	end

	UISpriteSetMgr.instance:setSurvivalSprite(arg_10_0._imagepoint, var_10_3)

	arg_10_0.txtScore.text = string.format("<color=%s>%s</color>", var_10_5, var_10_0.score)
	arg_10_0.txtIndex.text = string.format("<color=%s>%02d</color>", var_10_5, arg_10_0._index)

	gohelper.setActive(arg_10_0._gospecial, var_10_2)

	if var_10_2 then
		gohelper.setActive(arg_10_0.goScoreBg, not var_10_6)
		gohelper.setActive(arg_10_0.goScoreBgGrey, var_10_6)
	end
end

function var_0_0._editableInitView(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	if arg_12_0._rewardItems then
		for iter_12_0, iter_12_1 in pairs(arg_12_0._rewardItems) do
			iter_12_1.btn:RemoveClickListener()
		end

		arg_12_0._rewardItems = nil
	end
end

return var_0_0
