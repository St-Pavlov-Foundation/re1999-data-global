module("modules.logic.versionactivity1_2.yaxian.view.YaXianRewardItem", package.seeall)

slot0 = class("YaXianRewardItem", UserDataDispose)

function slot0.ctor(slot0, slot1)
	slot0:__onInit()

	slot0.go = slot1
	slot0.transform = slot0.go.transform

	recthelper.setAnchorY(slot0.transform, 0)
end

function slot0.init(slot0)
	slot0.goRewardContent = gohelper.findChild(slot0.go, "#go_rewards")
	slot0.imageStatus = gohelper.findChildImage(slot0.go, "#go_rewards/#image_status")
	slot0.goRewardTemplate = gohelper.findChild(slot0.go, "#go_rewards/#go_reward_template")
	slot0.goImportant = gohelper.findChild(slot0.go, "#go_rewards/#go_important")
	slot0.simageImportantBg = gohelper.findChildSingleImage(slot0.go, "#go_rewards/#go_important/#simage_importbg")
	slot0.txtScore = gohelper.findChildText(slot0.go, "#go_rewards/#txt_score")

	slot0.simageImportantBg:LoadImage(ResUrl.getDungeonIcon("bg_tishidiban"))
	gohelper.setActive(slot0.goRewardTemplate, false)

	slot0.rewardItemList = {}

	slot0:addEventCb(YaXianController.instance, YaXianEvent.OnUpdateBonus, slot0.refreshRewardHasGet, slot0)
end

function slot0.updateData(slot0, slot1, slot2)
	slot0.index = slot1
	slot0.config = slot2
	slot0.isFinish = slot0.config.needScore <= YaXianModel.instance:getScore()
end

function slot0.update(slot0, slot1, slot2)
	slot0:show()
	slot0:updateData(slot1, slot2)

	slot0.txtScore.text = slot0.config.needScore

	slot0:refreshIsImport()
	slot0:refreshStatus()
	slot0:refreshRewards()
	slot0:refreshRewardHasGet(true)
	slot0:calculateAnchorPosX()
	slot0:setAnchorPos()
end

function slot0.updateByTarget(slot0, slot1)
	slot0:updateData(-1, slot1)

	slot0.txtScore.text = slot0.config.needScore

	recthelper.setAnchorX(slot0.transform, 0)
	slot0:refreshStatus()
	slot0:refreshRewards()
	slot0:refreshRewardHasGet(true)
end

function slot0.refreshIsImport(slot0)
	gohelper.setActive(slot0.goImportant, slot0.config.important ~= 0)
end

function slot0.refreshStatus(slot0)
	UISpriteSetMgr.instance:setYaXianSprite(slot0.imageStatus, slot0.isFinish and "icon_zhanluedian_get" or "icon_zhanluedian_lock")
end

function slot0.refreshRewards(slot0)
	slot2, slot3, slot4, slot5, slot6, slot7 = nil

	for slot11, slot12 in ipairs(GameUtil.splitString2(slot0.config.bonus, true)) do
		slot5 = slot12[3]
		slot6, slot7 = ItemModel.instance:getItemConfigAndIcon(slot12[1], slot12[2])

		if not slot0.rewardItemList[slot11] then
			table.insert(slot0.rewardItemList, slot0:createRewardItem())
		end

		slot2.itemConfig = slot6
		slot2.type = slot3
		slot2.id = slot4

		gohelper.setActive(slot2.go, true)
		UISpriteSetMgr.instance:setUiFBSprite(slot2.imageBg, "bg_pinjidi_" .. slot6.rare)
		UISpriteSetMgr.instance:setUiFBSprite(slot2.imageCircle, "bg_pinjidi_lanse_" .. slot6.rare)
		slot2.simageReward:LoadImage(slot7)

		slot2.txtRewardCount.text = string.format("<size=25>x</size>%s", slot5)

		gohelper.setActive(slot2.goHasGet, slot0.isFinish)
	end

	for slot11 = #slot1 + 1, #slot0.rewardItemList do
		gohelper.setActive(slot0.rewardItemList[slot11].go, false)
	end
end

slot1 = Color.New(0.6941177, 0.6941177, 0.6941177, 1)
slot2 = Color.New(1, 1, 1, 1)
slot3 = 0.5
slot4 = 1

function slot0.refreshRewardHasGet(slot0, slot1)
	for slot9, slot10 in ipairs(slot0.rewardItemList) do
		UISpriteSetMgr.instance:getDungeonSprite():setImageAlpha(slot10.imageBg, slot2 and uv2 or uv3)

		slot10.imageReward.color = YaXianModel.instance:hasGetBonus(slot0.config.id) and uv0 or uv1

		gohelper.setActive(slot10.goHasGet, slot2)

		if slot1 then
			slot10.hasGet = slot2
		elseif slot2 and slot2 ~= slot10.hasGet then
			slot10.animator:Play("go_hasget_in")
		end
	end
end

function slot0.createRewardItem(slot0)
	slot1 = slot0:getUserDataTb_()
	slot1.go = gohelper.clone(slot0.goRewardTemplate, slot0.goRewardContent, "reward")
	slot1.imageBg = gohelper.findChildImage(slot1.go, "image_bg")
	slot1.imageCircle = gohelper.findChildImage(slot1.go, "image_circle")
	slot1.simageReward = gohelper.findChildSingleImage(slot1.go, "simage_reward")
	slot1.imageReward = gohelper.findChildImage(slot1.go, "simage_reward")
	slot1.txtRewardCount = gohelper.findChildText(slot1.go, "txt_rewardcount")
	slot1.goHasGet = gohelper.findChild(slot1.go, "go_hasget")
	slot1.animator = slot1.goHasGet:GetComponent(typeof(UnityEngine.Animator))
	slot1.click = gohelper.getClick(slot1.simageReward.gameObject)

	slot1.click:AddClickListener(slot0.onCLickRewardItem, slot0, slot1)

	return slot1
end

function slot0.onCLickRewardItem(slot0, slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
	MaterialTipController.instance:showMaterialInfo(slot1.type, slot1.id)
end

function slot0.calculateAnchorPosX(slot0)
	slot0.anchorPosX = (slot0.index - 1) * (YaXianEnum.RewardEnum.RewardItemWidth + YaXianEnum.RewardEnum.IntervalX) + YaXianEnum.RewardEnum.HalfRewardItemWidth
end

function slot0.setAnchorPos(slot0)
	recthelper.setAnchorX(slot0.transform, slot0.anchorPosX)
end

function slot0.getAnchorPosX(slot0)
	return slot0.anchorPosX
end

function slot0.isImportItem(slot0)
	return slot0.config.important ~= 0
end

function slot0.show(slot0)
	gohelper.setActive(slot0.go, true)
end

function slot0.hide(slot0)
	gohelper.setActive(slot0.go, false)
end

function slot0.onDestroy(slot0)
	slot0.simageImportantBg:UnLoadImage()

	for slot4, slot5 in ipairs(slot0.rewardItemList) do
		slot5.click:RemoveClickListener()
		slot5.simageReward:UnLoadImage()
	end

	slot0.rewardItemList = nil

	slot0:__onDispose()
end

return slot0
