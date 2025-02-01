module("modules.logic.versionactivity2_0.dungeon.view.graffiti.VersionActivity2_0DungeonGraffitiRewardView", package.seeall)

slot0 = class("VersionActivity2_0DungeonGraffitiRewardView", BaseView)

function slot0.onInitView(slot0)
	slot0._gorewardwindow = gohelper.findChild(slot0.viewGO, "#go_rewardwindow")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_rewardwindow/#btn_close")
	slot0._imageprogressBar = gohelper.findChildImage(slot0.viewGO, "#go_rewardwindow/Content/bg/#image_progressBar")
	slot0._imageprogress = gohelper.findChildImage(slot0.viewGO, "#go_rewardwindow/Content/bg/#image_progressBar/#image_progress")
	slot0._gorewardContent = gohelper.findChild(slot0.viewGO, "#go_rewardwindow/Content/#go_rewardContent")
	slot0._gorewardItem = gohelper.findChild(slot0.viewGO, "#go_rewardwindow/Content/#go_rewardContent/#go_rewarditem")
	slot0._gofinalrewardItem = gohelper.findChild(slot0.viewGO, "#go_rewardwindow/Content/#go_rewardContent/#go_finalrewarditem")
	slot0._gofinalreward = gohelper.findChild(slot0.viewGO, "#go_rewardwindow/Content/#go_rewardContent/#go_finalrewarditem/#go_finalreward")
	slot0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0._gorewardwindow)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0:addEventCb(Activity161Controller.instance, Activity161Event.GetGraffitiReward, slot0.refreshUI, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateMapElementState, slot0.refreshUI, slot0)
	slot0:addEventCb(Activity161Controller.instance, Activity161Event.PlayGraffitiRewardGetAnim, slot0.playHasGetEffect, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0:removeEventCb(Activity161Controller.instance, Activity161Event.GetGraffitiReward, slot0.refreshUI, slot0)
	slot0:removeEventCb(DungeonController.instance, DungeonEvent.OnUpdateMapElementState, slot0.refreshUI, slot0)
	slot0:removeEventCb(Activity161Controller.instance, Activity161Event.PlayGraffitiRewardGetAnim, slot0.playHasGetEffect, slot0)
end

function slot0._btncloseOnClick(slot0)
	slot0._animatorPlayer:Play(UIAnimationName.Close, slot0.onCloseAnimDone, slot0)
	gohelper.setActive(slot0._btnclose.gameObject, false)
end

function slot0.onCloseAnimDone(slot0)
	gohelper.setActive(slot0._gorewardwindow, false)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gorewardwindow, false)
	gohelper.setActive(slot0._gorewardItem, false)

	slot0.rewardItemTab = slot0:getUserDataTb_()
	slot0.stageRewardItems = slot0:getUserDataTb_()
	slot0.finalItemTab = slot0:getUserDataTb_()
end

function slot0.onOpen(slot0)
	slot0.actId = slot0.viewParam.actId
	slot0.allRewardConfig = Activity161Config.instance:getAllRewardCos(slot0.actId)
	slot0.finalRewardList, slot0.finalRewardInfo = Activity161Config.instance:getFinalReward(slot0.actId)
	slot0.lastHasGetRewardMap = tabletool.copy(Activity161Model.instance.curHasGetRewardMap)

	slot0:createRewardItem()
	slot0:createFinalRewardItem()
	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot0:refreshItemState()
	slot0:refreshProgress()
end

function slot0.createRewardItem(slot0)
	slot0.rewardsConfig = tabletool.copy(slot0.allRewardConfig)
	slot0.rewardCount = GameUtil.getTabLen(slot0.rewardsConfig)
	slot0.lastStageRewardConfig = table.remove(slot0.rewardsConfig, #slot0.rewardsConfig)

	for slot4, slot5 in pairs(slot0.rewardsConfig) do
		if not slot0.rewardItemTab[slot4] then
			slot6 = {
				go = gohelper.clone(slot0._gorewardItem, slot0._gorewardContent, "rewardItem" .. slot4),
				config = slot5
			}
			slot0.rewardItemTab[slot4] = slot0:initWholeRewardItemComp(slot6, slot6.go)
		end

		slot0:initRewardItemData(slot6, slot5, slot4)
	end

	if not slot0.rewardItemTab[slot0.rewardCount] then
		slot1 = {
			go = slot0._gofinalrewardItem,
			config = slot0.lastStageRewardConfig
		}
		slot0.rewardItemTab[slot0.rewardCount] = slot0:initWholeRewardItemComp(slot1, slot1.go)
	end

	gohelper.setAsLastSibling(slot1.go)
	slot0:initRewardItemData(slot1, slot0.lastStageRewardConfig, slot0.rewardCount)
end

function slot0.initWholeRewardItemComp(slot0, slot1, slot2)
	slot1.txtpaintedNum = gohelper.findChildTextMesh(slot2, "txt_paintedNum")
	slot1.godarkPoint = gohelper.findChild(slot2, "darkpoint")
	slot1.golightPoint = gohelper.findChild(slot2, "lightpoint")
	slot1.goreward = gohelper.findChild(slot2, "layout/go_reward")

	gohelper.setActive(slot1.goreward, false)

	return slot1
end

function slot0.initRewardItemData(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot1.go, true)

	slot1.txtpaintedNum.text = slot2.paintedNum
	slot4 = {}
	slot4 = (slot3 ~= slot0.rewardCount or slot0.finalRewardList) and GameUtil.splitString2(slot2.bonus, true)

	if not slot0.stageRewardItems[slot3] then
		for slot9, slot10 in ipairs(slot4) do
			slot11 = {
				itemGO = gohelper.cloneInPlace(slot1.goreward, "item" .. tostring(slot9))
			}
			slot11 = slot0:initRewardItemComp(slot11, slot11.itemGO, slot10)

			gohelper.setActive(slot11.itemGO, true)
			slot0:initItemIconInfo(slot11, slot10)
		end

		slot0.stageRewardItems[slot3] = {
			[slot9] = slot11
		}
	end
end

function slot0.createFinalRewardItem(slot0)
	if GameUtil.getTabLen(slot0.finalItemTab) == 0 then
		slot0:initRewardItemComp(slot0.finalItemTab, slot0._gofinalreward, slot0.finalRewardInfo, true)
	end

	slot0:initItemIconInfo(slot0.finalItemTab, slot0.finalRewardInfo)
end

function slot0.initRewardItemComp(slot0, slot1, slot2, slot3, slot4)
	slot1.itemGO = slot2
	slot1.itemRare = gohelper.findChildImage(slot1.itemGO, "item/image_rare")
	slot1.itemIcon = gohelper.findChildSingleImage(slot1.itemGO, "item/simage_icon")
	slot1.itemNum = gohelper.findChildText(slot1.itemGO, "item/txt_num")
	slot1.goHasGet = gohelper.findChild(slot1.itemGO, "go_hasget")
	slot1.goCanGet = gohelper.findChild(slot1.itemGO, "go_canget")
	slot1.goLock = gohelper.findChild(slot1.itemGO, "go_lock")
	slot1.hasGetAnim = slot1.goHasGet:GetComponent(gohelper.Type_Animator)
	slot1.btnClick = gohelper.findChildButtonWithAudio(slot1.itemGO, "item/btn_click")

	slot1.btnClick:AddClickListener(slot0.rewardItemClick, slot0, slot3)

	slot1.isFinalReward = slot4

	return slot1
end

function slot0.initItemIconInfo(slot0, slot1, slot2)
	slot3, slot4 = ItemModel.instance:getItemConfigAndIcon(slot2[1], slot2[2], true)

	slot1.itemIcon:LoadImage(slot4)

	if slot3.rare == 0 then
		gohelper.setActive(slot1.itemRare.gameObject, false)
	elseif slot3.rare < 5 and not slot1.isFinalReward then
		UISpriteSetMgr.instance:setV2a0PaintSprite(slot1.itemRare, "v2a0_paint_rewardbg_" .. slot3.rare)
	end

	slot1.itemNum.text = luaLang("multiple") .. slot2[3]
end

function slot0.rewardItemClick(slot0, slot1)
	MaterialTipController.instance:showMaterialInfo(slot1[1], slot1[2])
end

function slot0.refreshItemState(slot0)
	slot0.curHasGetRewardMap = Activity161Model.instance.curHasGetRewardMap
	slot1 = Activity161Model.instance:getCurPaintedNum()

	for slot5, slot6 in pairs(slot0.rewardItemTab) do
		gohelper.setActive(slot6.godarkPoint, slot1 < slot6.config.paintedNum)
		gohelper.setActive(slot6.golightPoint, slot7 <= slot1)
		SLFramework.UGUI.GuiHelper.SetColor(slot6.txtpaintedNum, slot7 <= slot1 and "#E9842A" or "#666767")
	end

	for slot5, slot6 in pairs(slot0.stageRewardItems) do
		slot7 = slot0.rewardItemTab[slot5].config.paintedNum

		for slot11, slot12 in pairs(slot6) do
			gohelper.setActive(slot12.goHasGet, slot0.curHasGetRewardMap[slot5])
			gohelper.setActive(slot12.goCanGet, not slot0.curHasGetRewardMap[slot5] and slot7 <= slot1)
			gohelper.setActive(slot12.goLock, not slot0.curHasGetRewardMap[slot5] and slot1 < slot7)
		end
	end

	gohelper.setActive(slot0.finalItemTab.goHasGet, slot0.curHasGetRewardMap[slot0.rewardCount])
	gohelper.setActive(slot0.finalItemTab.goCanGet, not slot0.curHasGetRewardMap[slot0.rewardCount] and slot0.lastStageRewardConfig.paintedNum <= slot1)
	gohelper.setActive(slot0.finalItemTab.goLock, not slot0.curHasGetRewardMap[slot0.rewardCount] and slot1 < slot0.lastStageRewardConfig.paintedNum)
end

function slot0.playHasGetEffect(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		for slot11, slot12 in pairs(slot0.stageRewardItems[slot6.rewardId]) do
			gohelper.setActive(slot12.goHasGet, true)
			gohelper.setActive(slot12.goCanGet, false)
			slot12.hasGetAnim:Play("go_hasget_in", 0, 0)
		end

		if slot6.rewardId == slot0.rewardCount then
			gohelper.setActive(slot0.finalItemTab.goHasGet, true)
			gohelper.setActive(slot0.finalItemTab.goCanGet, false)
			slot0.finalItemTab.hasGetAnim:Play("go_hasget_in", 0, 0)
		end
	end

	TaskDispatcher.runDelay(slot0.rewardCanGetClick, slot0, 1)
end

function slot0.rewardCanGetClick(slot0)
	Activity161Rpc.instance:sendAct161GainMilestoneRewardRequest(slot0.actId)
	UIBlockMgr.instance:endBlock("GraffitiRewardViewPlayHasGetEffect")
end

function slot0.refreshProgress(slot0)
	recthelper.setWidth(slot0._imageprogressBar.transform, 66 + 177 * Mathf.Max(0, slot0.rewardCount - 2) + 24 * slot0.rewardCount + 278)

	slot6 = 0
	slot8 = 0
	slot9 = 0
	slot10 = 0
	slot11 = 0

	for slot15, slot16 in pairs(slot0.allRewardConfig) do
		if slot16.paintedNum <= Activity161Model.instance:getCurPaintedNum() then
			slot8 = slot15
			slot9 = slot16.paintedNum
			slot10 = slot16.paintedNum
		elseif slot9 <= slot10 then
			slot10 = slot16.paintedNum

			break
		end
	end

	if slot10 ~= slot9 then
		slot11 = (slot7 - slot9) / (slot10 - slot9)
	end

	if slot8 == 0 then
		slot6 = slot1 * slot7 / slot10
	elseif slot8 >= 1 and slot8 < slot0.rewardCount - 1 then
		slot6 = slot1 + slot2 * (slot8 - 1) + slot8 * slot4 + slot11 * slot2
	elseif slot8 == slot0.rewardCount - 1 then
		slot6 = slot1 + slot2 * (slot8 - 1) + slot8 * slot4 + slot11 * slot3
	elseif slot8 == slot0.rewardCount then
		slot6 = slot5
	end

	recthelper.setWidth(slot0._imageprogress.transform, slot6)
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.rewardCanGetClick, slot0)
	UIBlockMgr.instance:endBlock("GraffitiRewardViewPlayHasGetEffect")
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in pairs(slot0.stageRewardItems) do
		for slot9, slot10 in pairs(slot5) do
			slot10.btnClick:RemoveClickListener()
			slot10.itemIcon:UnLoadImage()
		end
	end

	slot0.finalItemTab.btnClick:RemoveClickListener()
	slot0.finalItemTab.itemIcon:UnLoadImage()
end

return slot0
