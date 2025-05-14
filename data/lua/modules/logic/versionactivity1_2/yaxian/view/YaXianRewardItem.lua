module("modules.logic.versionactivity1_2.yaxian.view.YaXianRewardItem", package.seeall)

local var_0_0 = class("YaXianRewardItem", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1
	arg_1_0.transform = arg_1_0.go.transform

	recthelper.setAnchorY(arg_1_0.transform, 0)
end

function var_0_0.init(arg_2_0)
	arg_2_0.goRewardContent = gohelper.findChild(arg_2_0.go, "#go_rewards")
	arg_2_0.imageStatus = gohelper.findChildImage(arg_2_0.go, "#go_rewards/#image_status")
	arg_2_0.goRewardTemplate = gohelper.findChild(arg_2_0.go, "#go_rewards/#go_reward_template")
	arg_2_0.goImportant = gohelper.findChild(arg_2_0.go, "#go_rewards/#go_important")
	arg_2_0.simageImportantBg = gohelper.findChildSingleImage(arg_2_0.go, "#go_rewards/#go_important/#simage_importbg")
	arg_2_0.txtScore = gohelper.findChildText(arg_2_0.go, "#go_rewards/#txt_score")

	arg_2_0.simageImportantBg:LoadImage(ResUrl.getDungeonIcon("bg_tishidiban"))
	gohelper.setActive(arg_2_0.goRewardTemplate, false)

	arg_2_0.rewardItemList = {}

	arg_2_0:addEventCb(YaXianController.instance, YaXianEvent.OnUpdateBonus, arg_2_0.refreshRewardHasGet, arg_2_0)
end

function var_0_0.updateData(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.index = arg_3_1
	arg_3_0.config = arg_3_2
	arg_3_0.isFinish = arg_3_0.config.needScore <= YaXianModel.instance:getScore()
end

function var_0_0.update(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:show()
	arg_4_0:updateData(arg_4_1, arg_4_2)

	arg_4_0.txtScore.text = arg_4_0.config.needScore

	arg_4_0:refreshIsImport()
	arg_4_0:refreshStatus()
	arg_4_0:refreshRewards()
	arg_4_0:refreshRewardHasGet(true)
	arg_4_0:calculateAnchorPosX()
	arg_4_0:setAnchorPos()
end

function var_0_0.updateByTarget(arg_5_0, arg_5_1)
	arg_5_0:updateData(-1, arg_5_1)

	arg_5_0.txtScore.text = arg_5_0.config.needScore

	recthelper.setAnchorX(arg_5_0.transform, 0)
	arg_5_0:refreshStatus()
	arg_5_0:refreshRewards()
	arg_5_0:refreshRewardHasGet(true)
end

function var_0_0.refreshIsImport(arg_6_0)
	gohelper.setActive(arg_6_0.goImportant, arg_6_0.config.important ~= 0)
end

function var_0_0.refreshStatus(arg_7_0)
	UISpriteSetMgr.instance:setYaXianSprite(arg_7_0.imageStatus, arg_7_0.isFinish and "icon_zhanluedian_get" or "icon_zhanluedian_lock")
end

function var_0_0.refreshRewards(arg_8_0)
	local var_8_0 = GameUtil.splitString2(arg_8_0.config.bonus, true)
	local var_8_1
	local var_8_2
	local var_8_3
	local var_8_4
	local var_8_5
	local var_8_6

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		local var_8_7, var_8_8, var_8_9 = iter_8_1[1], iter_8_1[2], iter_8_1[3]
		local var_8_10, var_8_11 = ItemModel.instance:getItemConfigAndIcon(var_8_7, var_8_8)
		local var_8_12 = arg_8_0.rewardItemList[iter_8_0]

		if not var_8_12 then
			var_8_12 = arg_8_0:createRewardItem()

			table.insert(arg_8_0.rewardItemList, var_8_12)
		end

		var_8_12.itemConfig = var_8_10
		var_8_12.type = var_8_7
		var_8_12.id = var_8_8

		gohelper.setActive(var_8_12.go, true)
		UISpriteSetMgr.instance:setUiFBSprite(var_8_12.imageBg, "bg_pinjidi_" .. var_8_10.rare)
		UISpriteSetMgr.instance:setUiFBSprite(var_8_12.imageCircle, "bg_pinjidi_lanse_" .. var_8_10.rare)
		var_8_12.simageReward:LoadImage(var_8_11)

		var_8_12.txtRewardCount.text = string.format("<size=25>x</size>%s", var_8_9)

		gohelper.setActive(var_8_12.goHasGet, arg_8_0.isFinish)
	end

	for iter_8_2 = #var_8_0 + 1, #arg_8_0.rewardItemList do
		gohelper.setActive(arg_8_0.rewardItemList[iter_8_2].go, false)
	end
end

local var_0_1 = Color.New(0.6941177, 0.6941177, 0.6941177, 1)
local var_0_2 = Color.New(1, 1, 1, 1)
local var_0_3 = 0.5
local var_0_4 = 1

function var_0_0.refreshRewardHasGet(arg_9_0, arg_9_1)
	local var_9_0 = YaXianModel.instance:hasGetBonus(arg_9_0.config.id)
	local var_9_1 = var_9_0 and var_0_1 or var_0_2
	local var_9_2 = var_9_0 and var_0_3 or var_0_4
	local var_9_3 = UISpriteSetMgr.instance:getDungeonSprite()

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.rewardItemList) do
		var_9_3:setImageAlpha(iter_9_1.imageBg, var_9_2)

		iter_9_1.imageReward.color = var_9_1

		gohelper.setActive(iter_9_1.goHasGet, var_9_0)

		if arg_9_1 then
			iter_9_1.hasGet = var_9_0
		elseif var_9_0 and var_9_0 ~= iter_9_1.hasGet then
			iter_9_1.animator:Play("go_hasget_in")
		end
	end
end

function var_0_0.createRewardItem(arg_10_0)
	local var_10_0 = arg_10_0:getUserDataTb_()

	var_10_0.go = gohelper.clone(arg_10_0.goRewardTemplate, arg_10_0.goRewardContent, "reward")
	var_10_0.imageBg = gohelper.findChildImage(var_10_0.go, "image_bg")
	var_10_0.imageCircle = gohelper.findChildImage(var_10_0.go, "image_circle")
	var_10_0.simageReward = gohelper.findChildSingleImage(var_10_0.go, "simage_reward")
	var_10_0.imageReward = gohelper.findChildImage(var_10_0.go, "simage_reward")
	var_10_0.txtRewardCount = gohelper.findChildText(var_10_0.go, "txt_rewardcount")
	var_10_0.goHasGet = gohelper.findChild(var_10_0.go, "go_hasget")
	var_10_0.animator = var_10_0.goHasGet:GetComponent(typeof(UnityEngine.Animator))
	var_10_0.click = gohelper.getClick(var_10_0.simageReward.gameObject)

	var_10_0.click:AddClickListener(arg_10_0.onCLickRewardItem, arg_10_0, var_10_0)

	return var_10_0
end

function var_0_0.onCLickRewardItem(arg_11_0, arg_11_1)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	MaterialTipController.instance:showMaterialInfo(arg_11_1.type, arg_11_1.id)
end

function var_0_0.calculateAnchorPosX(arg_12_0)
	arg_12_0.anchorPosX = (arg_12_0.index - 1) * (YaXianEnum.RewardEnum.RewardItemWidth + YaXianEnum.RewardEnum.IntervalX) + YaXianEnum.RewardEnum.HalfRewardItemWidth
end

function var_0_0.setAnchorPos(arg_13_0)
	recthelper.setAnchorX(arg_13_0.transform, arg_13_0.anchorPosX)
end

function var_0_0.getAnchorPosX(arg_14_0)
	return arg_14_0.anchorPosX
end

function var_0_0.isImportItem(arg_15_0)
	return arg_15_0.config.important ~= 0
end

function var_0_0.show(arg_16_0)
	gohelper.setActive(arg_16_0.go, true)
end

function var_0_0.hide(arg_17_0)
	gohelper.setActive(arg_17_0.go, false)
end

function var_0_0.onDestroy(arg_18_0)
	arg_18_0.simageImportantBg:UnLoadImage()

	for iter_18_0, iter_18_1 in ipairs(arg_18_0.rewardItemList) do
		iter_18_1.click:RemoveClickListener()
		iter_18_1.simageReward:UnLoadImage()
	end

	arg_18_0.rewardItemList = nil

	arg_18_0:__onDispose()
end

return var_0_0
