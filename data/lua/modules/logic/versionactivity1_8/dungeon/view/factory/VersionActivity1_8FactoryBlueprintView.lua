module("modules.logic.versionactivity1_8.dungeon.view.factory.VersionActivity1_8FactoryBlueprintView", package.seeall)

slot0 = class("VersionActivity1_8FactoryBlueprintView", BaseView)
slot1 = 1

function slot0.onInitView(slot0)
	slot0._factoryAnimator = gohelper.findChildComponent(slot0.viewGO, "factory", typeof(UnityEngine.Animator))
	slot0._factoryAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(gohelper.findChild(slot0.viewGO, "factory"))
	slot0._gocomposite = gohelper.findChild(slot0.viewGO, "factory/#go_composite")
	slot0._btncomposite = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "factory/#go_composite")
	slot0._btnbubble = gohelper.findChildButtonWithAudio(slot0.viewGO, "factory/#btn_bubble", AudioEnum.UI.Act157GetBubbleReward)
	slot0._gobubble = gohelper.findChild(slot0.viewGO, "factory/#btn_bubble")
	slot0._simagecangeticon = gohelper.findChildSingleImage(slot0.viewGO, "factory/#btn_bubble/icon")
	slot0._gobubbletime = gohelper.findChild(slot0.viewGO, "factory/#btn_bubble/finishing/time")
	slot0._txtbubbletime = gohelper.findChildText(slot0.viewGO, "factory/#btn_bubble/finishing/time/#txt_time")
	slot0._gobubblenum = gohelper.findChild(slot0.viewGO, "factory/#btn_bubble/finishing/num")
	slot0._txtbubblenum = gohelper.findChildText(slot0.viewGO, "factory/#btn_bubble/finishing/num/#txt_num")
	slot0._gobubblecanget = gohelper.findChild(slot0.viewGO, "factory/#btn_bubble/canget")
	slot0._gorewardwindow = gohelper.findChild(slot0.viewGO, "#go_rewardwindow")
	slot0._rewardwindowAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(slot0._gorewardwindow)
	slot0._btnclosereward = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "#go_rewardwindow")
	slot0._sliderreward = gohelper.findChildSlider(slot0.viewGO, "#go_rewardwindow/#go_progress/slider")
	slot0._btnreward = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "#btn_reward")
	slot0._btnrewardAnimator = gohelper.findChildComponent(slot0.viewGO, "#btn_reward", typeof(UnityEngine.Animator))
	slot0._goRewardReddot = gohelper.findChild(slot0.viewGO, "#btn_reward/#go_reddot")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnbubble:AddClickListener(slot0._btnbubbleOnClick, slot0)
	slot0._btncomposite:AddClickListener(slot0._btncompositeOnClick, slot0)
	slot0._btnreward:AddClickListener(slot0._btnrewardOnClick, slot0)
	slot0._btnclosereward:AddClickListener(slot0._btncloserewardOnClick, slot0)
	slot0:addEventCb(Activity157Controller.instance, Activity157Event.Act157RepairComponent, slot0.onRepairComponent, slot0)
	slot0:addEventCb(Activity157Controller.instance, Activity157Event.Act157RefreshFactoryProduction, slot0.refreshBubble, slot0)
	slot0:addEventCb(Activity157Controller.instance, Activity157Event.Act157OnGetComponentReward, slot0.onGetRepairReward, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnbubble:RemoveClickListener()
	slot0._btncomposite:RemoveClickListener()
	slot0._btnreward:RemoveClickListener()
	slot0._btnclosereward:RemoveClickListener()
	slot0:removeEventCb(Activity157Controller.instance, Activity157Event.Act157RepairComponent, slot0.onRepairComponent, slot0)
	slot0:removeEventCb(Activity157Controller.instance, Activity157Event.Act157RefreshFactoryProduction, slot0.refreshBubble, slot0)
	slot0:removeEventCb(Activity157Controller.instance, Activity157Event.Act157OnGetComponentReward, slot0.onGetRepairReward, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
end

function slot0._btnbubbleOnClick(slot0)
	Activity157Controller.instance:getFactoryProduction()
end

function slot0._btncompositeOnClick(slot0)
	if Activity157Model.instance:getIsFirstComponentRepair() then
		Activity157Controller.instance:openCompositeView()
	else
		GameFacade.showToast(ToastEnum.V1a8Activity157NotUnlockFactoryBlueprint)
	end
end

function slot0._btnrewardOnClick(slot0)
	slot0:refreshRewardProgress()
	gohelper.setActive(slot0._gorewardwindow, true)
	slot0._rewardwindowAnimatorPlayer:Play("open")

	if Activity157Model.instance:getLastArchiveRewardComponent() then
		Activity157Rpc.instance:sendAct157GainMilestoneRewardRequest(slot0.actId, slot1, slot0.refreshRewardProgress, slot0)
	end
end

function slot0._btncloserewardOnClick(slot0)
	slot0._rewardwindowAnimatorPlayer:Play("close", slot0.hideRewardWindow, slot0)
end

function slot0.hideRewardWindow(slot0)
	gohelper.setActive(slot0._gorewardwindow, false)
end

function slot0.onRepairComponent(slot0)
	slot1 = ViewMgr.instance:getOpenViewNameList()

	if slot1[#slot1] ~= slot0.viewName then
		slot0._waitOnRepairComponent = true
	else
		slot0._waitOnRepairComponent = false

		slot0:checkFactoryAnim()
		slot0:refresh()
	end
end

function slot0.onGetRepairReward(slot0, slot1)
	slot0._rewardsMaterials = slot1

	slot0:refreshRepairReward(true)
end

function slot0._onCloseView(slot0, slot1)
	if not slot0._waitOnRepairComponent then
		return
	end

	slot2 = ViewMgr.instance:getOpenViewNameList()

	if slot2[#slot2] ~= slot0.viewName then
		return
	end

	slot0:onRepairComponent()

	if Activity157Model.instance:getIsFirstComponentRepair() then
		Activity157Controller.instance:dispatchEvent(Activity157Event.GuideHasRepairFirstComponent)
	end

	slot0._waitOnRepairComponent = false
end

function slot0._editableInitView(slot0)
	slot0.actId = Activity157Model.instance:getActId()
	slot0.partItemList = {}
	slot0.rewardWindowItemList = {}

	for slot6 = 1, #Activity157Config.instance:getComponentIdList(slot0.actId) do
		if gohelper.findChild(slot0.viewGO, "factory/part_" .. slot6) then
			table.insert(slot0.partItemList, MonoHelper.addNoUpdateLuaComOnceToGo(slot8, VersionActivity1_8FactoryBlueprintPartItem, slot1[slot6]))
		end

		if gohelper.findChild(slot0.viewGO, "#go_rewardwindow/layout/item" .. slot6) then
			table.insert(slot0.rewardWindowItemList, VersionActivity1_8FactoryBlueprintRewardItem.New(slot10, slot7, gohelper.findChild(slot0.viewGO, "#go_rewardwindow/#go_progress/point/" .. slot6)))
		end
	end

	if Activity157Config.instance:getAct157Const(slot0.actId, Activity157Enum.ConstId.FactoryCompositeCost) and string.splitToNumber(slot3, "#") then
		slot5, slot6 = ItemModel.instance:getItemConfigAndIcon(slot4[1], slot4[2])

		if slot6 then
			slot0._simagecangeticon:LoadImage(slot6)
		end
	end

	slot0:hideRewardWindow()
	RedDotController.instance:addRedDot(slot0._goRewardReddot, RedDotEnum.DotNode.V1a8DungeonFactoryRepairReward, slot0.actId, slot0.checkRewardReddot, slot0)
end

function slot0.checkRewardReddot(slot0, slot1)
	slot1:defaultRefreshDot()

	if slot1.show then
		slot0._btnrewardAnimator:Play("receive", 0, 0)
	else
		slot0._btnrewardAnimator:Play("open", 0, 1)
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:checkFactoryAnim()
	slot0:refresh()
	slot0:everySecondCall()
	TaskDispatcher.runRepeat(slot0.everySecondCall, slot0, 1)
	AudioMgr.instance:trigger(AudioEnum.UI.Act157OpenBlueprintView)

	if Activity157Model.instance:getIsFirstComponentRepair() then
		Activity157Controller.instance:dispatchEvent(Activity157Event.GuideHasRepairFirstComponent)
	end
end

function slot0.checkFactoryAnim(slot0)
	if not Activity157Model.instance:isAllComponentRepair() then
		return
	end

	if Activity157Model.instance:getHasPlayedAnim(VersionActivity1_8DungeonEnum.PlayerPrefsKey.IsPlayedBlueprintAllFinish) then
		slot0._factoryAnimator:Play("loop")
	else
		slot0._factoryAnimator:Play("finish", 0, 0)
		Activity157Model.instance:setHasPlayedAnim(slot2)
	end
end

function slot0.refreshRewardProgress(slot0)
	slot1 = 0

	if Activity157Model.instance:getLastHasGotRewardComponent() then
		slot3 = Activity157Config.instance:getComponentIdList(slot0.actId)

		for slot8, slot9 in ipairs(slot3) do
			if slot2 == slot9 then
				slot1 = (slot8 - 1) / (#slot3 - 1)

				break
			end
		end
	end

	slot0._sliderreward:SetValue(math.max(slot1, 0))
end

function slot0.refresh(slot0)
	if Activity157Model.instance:getIsFirstComponentRepair() then
		gohelper.setActive(slot0._gocomposite, not Activity157Model.instance:isAllComponentRepair())
		slot0.viewContainer:setCurrencyType({
			CurrencyEnum.CurrencyType.V1a8FactoryPart,
			CurrencyEnum.CurrencyType.V1a8FactoryRawMat
		})
	else
		gohelper.setActive(slot0._gocomposite, false)
		slot0.viewContainer:setCurrencyType({
			CurrencyEnum.CurrencyType.V1a8FactoryPart
		})
	end

	slot0:refreshPartItem()
	slot0:refreshBubble()
	slot0:refreshRepairReward()
end

function slot0.refreshPartItem(slot0)
	for slot4, slot5 in ipairs(slot0.partItemList) do
		slot5:refresh()
	end
end

function slot0.refreshBubble(slot0)
	slot5 = not (Activity157Model.instance:getFactoryProductionNum() > 0) and string.nilorempty(Activity157Model.instance:getFactoryNextRecoverCountdown())

	gohelper.setActive(slot0._gobubble, not slot5)

	if slot5 then
		return
	end

	slot0:refreshBubbleTime()

	slot7 = Activity157Config.instance:getAct157FactoryProductCapacity(slot0.actId, Activity157Enum.ConstId.FactoryProductCapacity) <= slot3

	gohelper.setActive(slot0._gobubblecanget, slot7)
	gohelper.setActive(slot0._gobubblenum, not slot7)

	if slot7 then
		return
	end

	slot8 = "#F5744D"

	if slot4 then
		slot8 = "#88CB7F"
	end

	slot0._txtbubblenum.text = string.format("<color=%s>%s</color>/%s", slot8, slot3, slot6)
end

function slot0.refreshBubbleTime(slot0)
	slot2 = string.nilorempty(Activity157Model.instance:getFactoryNextRecoverCountdown())

	gohelper.setActive(slot0._gobubbletime, not slot2 and not (Activity157Config.instance:getAct157FactoryProductCapacity(slot0.actId, Activity157Enum.ConstId.FactoryProductCapacity) <= Activity157Model.instance:getFactoryProductionNum()))

	if slot2 then
		return
	end

	slot0._txtbubbletime.text = slot1
end

function slot0.refreshRepairReward(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.rewardWindowItemList) do
		slot6:refresh(slot1)
	end

	if slot0._rewardsMaterials then
		AudioMgr.instance:trigger(AudioEnum.RewardPoint.play_ui_track_achievement_single)
		TaskDispatcher.cancelTask(slot0._showMaterials, slot0)
		UIBlockMgr.instance:startBlock(VersionActivity1_8DungeonEnum.BlockKey.GetComponentRepairReward)
		TaskDispatcher.runDelay(slot0._showMaterials, slot0, uv0)
	end
end

function slot0._showMaterials(slot0)
	RoomController.instance:popUpRoomBlockPackageView(slot0._rewardsMaterials)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, slot0._rewardsMaterials)

	slot0._rewardsMaterials = nil

	UIBlockMgr.instance:endBlock(VersionActivity1_8DungeonEnum.BlockKey.GetComponentRepairReward)
end

function slot0.everySecondCall(slot0)
	slot0:refreshBubbleTime()
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.everySecondCall, slot0)

	slot0._waitOnRepairComponent = false

	UIBlockMgr.instance:endBlock(VersionActivity1_8DungeonEnum.BlockKey.GetComponentRepairReward)
end

function slot0.onDestroyView(slot0)
	for slot4, slot5 in ipairs(slot0.partItemList) do
		slot5:destroy()
	end

	for slot4, slot5 in ipairs(slot0.rewardWindowItemList) do
		slot5:destroy()
	end

	slot0._simagecangeticon:UnLoadImage()
end

return slot0
