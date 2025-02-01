module("modules.logic.versionactivity.view.VersionActivityTaskBonusItem", package.seeall)

slot0 = class("VersionActivityTaskBonusItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1
	slot0.txtIndex = gohelper.findChildText(slot0.viewGO, "index")
	slot0.imagePoint = gohelper.findChildImage(slot0.viewGO, "progress/point")
	slot0.scrollRewards = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_rewards")
	slot0.goRewardRoot = gohelper.findChild(slot0.viewGO, "#scroll_rewards/Viewport/rewardsroot")
	slot0.goFinish = gohelper.findChild(slot0.viewGO, "go_finish")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0._editableInitView(slot0)
	slot0.pointItemList = {}
	slot0.rewardItems = {}
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))

	gohelper.setActive(slot0.imagePoint.gameObject, false)
	gohelper.setActive(slot0.goFinish, false)
	slot0:addEventCb(VersionActivityController.instance, VersionActivityEvent.AddTaskActivityBonus, slot0.addActivityPoints, slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0.co = slot1

	slot0:show()

	slot0.txtIndex.text = string.format("%2d", slot0.co.id)
	slot0.taskActivityMo = TaskModel.instance:getTaskActivityMO(TaskEnum.TaskType.ActivityDungeon)

	slot0:refreshPoints()
	slot0:refreshRewardItems()
end

function slot0.refreshPoints(slot0)
	slot1 = nil
	slot3 = 0

	gohelper.setActive(slot0.goFinish, false)

	if slot0.co.id <= slot0.taskActivityMo.defineId then
		slot3 = slot0.co.needActivity

		gohelper.setActive(slot0.goFinish, true)
	elseif slot0.co.id == slot2.defineId + 1 then
		slot3 = slot2.value - slot2.gainValue
	end

	for slot7 = 1, slot0.co.needActivity do
		if not slot0.pointItemList[slot7] then
			slot1 = slot0:getUserDataTb_()
			slot1.go = gohelper.cloneInPlace(slot0.imagePoint.gameObject)
			slot1.image = slot1.go:GetComponent(gohelper.Type_Image)
			slot1.playGo = gohelper.findChild(slot1.go, "play")

			table.insert(slot0.pointItemList, slot1)
		end

		gohelper.setActive(slot1.go, true)
		gohelper.setActive(slot1.playGo, false)
		UISpriteSetMgr.instance:setVersionActivitySprite(slot1.image, slot7 <= slot3 and "img_li1" or "img_li2")
	end

	for slot7 = slot0.co.needActivity + 1, #slot0.pointItemList do
		gohelper.setActive(slot0.pointItemList[slot7].go, false)
	end
end

function slot0.refreshRewardItems(slot0)
	slot1, slot2 = nil

	for slot7 = 1, #string.split(slot0.co.bonus, "|") do
		slot2 = string.splitToNumber(slot3[slot7], "#")

		if not slot0.rewardItems[slot7] then
			slot1 = IconMgr.instance:getCommonPropItemIcon(slot0.goRewardRoot)

			table.insert(slot0.rewardItems, slot1)
			transformhelper.setLocalScale(slot1.go.transform, 0.62, 0.62, 1)
			slot1:setMOValue(slot2[1], slot2[2], slot2[3], nil, true)
			slot1:setCountFontSize(50)
			slot1:showStackableNum2()
			slot1:isShowEffect(true)
			slot1:setHideLvAndBreakFlag(true)
			slot1:hideEquipLvAndBreak(true)
		else
			slot1:setMOValue(slot2[1], slot2[2], slot2[3], nil, true)
		end

		gohelper.setActive(slot1.go, true)
	end

	for slot7 = #slot3 + 1, #slot0.rewardItems do
		gohelper.setActive(slot0.rewardItems[slot7].go, false)
	end

	slot0.scrollRewards.horizontalNormalizedPosition = 0
end

function slot0.addActivityPoints(slot0)
	if not VersionActivityTaskBonusListModel.instance:checkActivityPointCountHasChange() then
		return
	end

	for slot4 = 1, #slot0.pointItemList do
		if VersionActivityTaskBonusListModel.instance:checkNeedPlayEffect(slot0.co.id, slot4) then
			gohelper.setActive(slot0.pointItemList[slot4].playGo, true)
		end
	end
end

function slot0.playAnimation(slot0, slot1, slot2)
	slot0._animator:Play(slot1, 0, -slot2)
end

function slot0.getAnimator(slot0)
	return slot0._animator
end

function slot0.show(slot0)
	gohelper.setActive(slot0.viewGO, true)
end

function slot0.hide(slot0)
	gohelper.setActive(slot0.viewGO, false)
end

function slot0.onDestroyView(slot0)
end

return slot0
