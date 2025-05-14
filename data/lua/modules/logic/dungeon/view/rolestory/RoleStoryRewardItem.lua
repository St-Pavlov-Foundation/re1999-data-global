module("modules.logic.dungeon.view.rolestory.RoleStoryRewardItem", package.seeall)

local var_0_0 = class("RoleStoryRewardItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._rectTransform = arg_1_0.viewGO.transform
	arg_1_0._gospecial = gohelper.findChild(arg_1_0.viewGO, "#go_special")
	arg_1_0.txtScore = gohelper.findChildTextMesh(arg_1_0.viewGO, "scorebg/#txt_score")
	arg_1_0.normalbg = gohelper.findChild(arg_1_0.viewGO, "scorebg/normalbg")
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

	arg_5_0:refreshReward(arg_5_1)
	arg_5_0:refreshChapter(arg_5_1)
end

function var_0_0.refreshReward(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.config
	local var_6_1 = GameUtil.splitString2(var_6_0.bonus, true) or {}

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
	var_7_0.simagereward = gohelper.findChildSingleImage(var_7_1, "simage_reward")
	var_7_0.imagereward = gohelper.findChildImage(var_7_1, "simage_reward")
	var_7_0.txtrewardcount = gohelper.findChildText(var_7_1, "txt_rewardcount")
	var_7_0.goalreadygot = gohelper.findChild(var_7_1, "go_hasget")
	var_7_0.gocanget = gohelper.findChild(var_7_1, "go_canget")
	var_7_0.btn = gohelper.findChildButtonWithAudio(var_7_1, "btn_click")

	var_7_0.btn:AddClickListener(arg_7_0.onClickItem, arg_7_0, var_7_0)

	var_7_0.rewardAnim = var_7_0.go:GetComponent(typeof(UnityEngine.Animator))

	function var_7_0.onLoadImageCallback(arg_8_0)
		arg_8_0.imagereward:SetNativeSize()
	end

	return var_7_0
end

local var_0_1 = Color.New(1, 1, 1, 1)

function var_0_0.refreshRewardItem(arg_9_0, arg_9_1, arg_9_2)
	arg_9_1.data = arg_9_2

	if not arg_9_2 then
		gohelper.setActive(arg_9_1.go, false)

		return
	end

	gohelper.setActive(arg_9_1.go, true)

	local var_9_0 = arg_9_0.data.config
	local var_9_1 = RoleStoryModel.instance:getRewardState(var_9_0.storyId, var_9_0.id, var_9_0.score)
	local var_9_2, var_9_3 = ItemModel.instance:getItemConfigAndIcon(arg_9_2[1], arg_9_2[2])

	if var_9_2 then
		UISpriteSetMgr.instance:setUiFBSprite(arg_9_1.imagebg, "bg_pinjidi_" .. var_9_2.rare)
	end

	if arg_9_2[1] == MaterialEnum.MaterialType.Equip then
		var_9_3 = ResUrl.getHeroDefaultEquipIcon(var_9_2.icon)
	end

	if var_9_3 then
		arg_9_1.simagereward:LoadImage(var_9_3, arg_9_1.onLoadImageCallback, arg_9_1)
	end

	arg_9_1.txtrewardcount.text = string.format("<size=25>x</size>%s", tostring(arg_9_2[3]))

	gohelper.setActive(arg_9_1.goalreadygot, var_9_1 == 2)
	gohelper.setActive(arg_9_1.gocanget, var_9_1 == 1)

	if var_9_1 == 2 then
		arg_9_1.rewardAnim.enabled = true

		arg_9_1.rewardAnim:Play("dungeoncumulativerewardsitem_receiveenter")
	elseif var_9_1 == 1 then
		arg_9_1.rewardAnim.enabled = true

		arg_9_1.rewardAnim:Play("dungeoncumulativerewardsitem_received")
	else
		arg_9_1.rewardAnim.enabled = false
		arg_9_1.imagereward.color = var_0_1
		arg_9_1.imagebg.color = var_0_1
	end
end

function var_0_0.onClickItem(arg_10_0, arg_10_1)
	if not arg_10_0.data then
		return
	end

	local var_10_0 = arg_10_0.data.config

	if RoleStoryModel.instance:getRewardState(var_10_0.storyId, var_10_0.id, var_10_0.score) == 1 then
		local var_10_1 = {}
		local var_10_2 = RoleStoryConfig.instance:getRewardList(var_10_0.storyId)

		if var_10_2 then
			for iter_10_0, iter_10_1 in ipairs(var_10_2) do
				if RoleStoryModel.instance:getRewardState(iter_10_1.storyId, iter_10_1.id, iter_10_1.score) == 1 then
					table.insert(var_10_1, iter_10_1.id)
				end
			end
		end

		if #var_10_1 > 0 then
			HeroStoryRpc.instance:sendGetScoreBonusRequest(var_10_1)
		end
	elseif arg_10_1.data then
		MaterialTipController.instance:showMaterialInfo(arg_10_1.data[1], arg_10_1.data[2])
	end
end

local var_0_2 = "#DB7D29"
local var_0_3 = "#FFFFFF"
local var_0_4 = 0.86
local var_0_5 = 0.86
local var_0_6 = "#DB7D29"
local var_0_7 = "#8E8E8E"

function var_0_0.refreshChapter(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.data.config
	local var_11_1 = RoleStoryModel.instance:getRewardState(var_11_0.storyId, var_11_0.id, var_11_0.score)
	local var_11_2 = var_11_0.keyReward == 1
	local var_11_3 = "v1a6_cachot_icon_pointdark"
	local var_11_4 = var_0_3
	local var_11_5 = var_0_4
	local var_11_6 = var_0_7

	if var_11_1 == 0 then
		var_11_3 = var_11_2 and "v1a6_cachot_icon_pointdark2" or "v1a6_cachot_icon_pointdark"
	else
		var_11_3 = var_11_2 and "v1a6_cachot_icon_pointlight2" or "v1a6_cachot_icon_pointlight"

		local var_11_7 = var_0_2

		var_11_5 = var_0_5
		var_11_6 = var_0_6
	end

	UISpriteSetMgr.instance:setV1a6CachotSprite(arg_11_0._imagepoint, var_11_3)

	arg_11_0.txtScore.text = string.format("<color=%s>%s</color>", var_11_6, var_11_0.score)
	arg_11_0.txtIndex.text = string.format("<color=%s>%02d</color>", var_11_6, arg_11_0.data.index)

	ZProj.UGUIHelper.SetColorAlpha(arg_11_0.txtIndex, var_11_5)
	gohelper.setActive(arg_11_0._gospecial, var_11_2 and not arg_11_0.data.isTarget)
	gohelper.setActive(arg_11_0.normalbg, var_11_2 and arg_11_0.data.isTarget)
end

function var_0_0._editableInitView(arg_12_0)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	if arg_13_0._rewardItems then
		for iter_13_0, iter_13_1 in pairs(arg_13_0._rewardItems) do
			iter_13_1.btn:RemoveClickListener()
			iter_13_1.simagereward:UnLoadImage()
		end

		arg_13_0._rewardItems = nil
	end
end

return var_0_0
