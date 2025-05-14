module("modules.logic.versionactivity1_8.dungeon.view.factory.VersionActivity1_8FactoryBlueprintView", package.seeall)

local var_0_0 = class("VersionActivity1_8FactoryBlueprintView", BaseView)
local var_0_1 = 1

function var_0_0.onInitView(arg_1_0)
	arg_1_0._factoryAnimator = gohelper.findChildComponent(arg_1_0.viewGO, "factory", typeof(UnityEngine.Animator))

	local var_1_0 = gohelper.findChild(arg_1_0.viewGO, "factory")

	arg_1_0._factoryAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(var_1_0)
	arg_1_0._gocomposite = gohelper.findChild(arg_1_0.viewGO, "factory/#go_composite")
	arg_1_0._btncomposite = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "factory/#go_composite")
	arg_1_0._btnbubble = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "factory/#btn_bubble", AudioEnum.UI.Act157GetBubbleReward)
	arg_1_0._gobubble = gohelper.findChild(arg_1_0.viewGO, "factory/#btn_bubble")
	arg_1_0._simagecangeticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "factory/#btn_bubble/icon")
	arg_1_0._gobubbletime = gohelper.findChild(arg_1_0.viewGO, "factory/#btn_bubble/finishing/time")
	arg_1_0._txtbubbletime = gohelper.findChildText(arg_1_0.viewGO, "factory/#btn_bubble/finishing/time/#txt_time")
	arg_1_0._gobubblenum = gohelper.findChild(arg_1_0.viewGO, "factory/#btn_bubble/finishing/num")
	arg_1_0._txtbubblenum = gohelper.findChildText(arg_1_0.viewGO, "factory/#btn_bubble/finishing/num/#txt_num")
	arg_1_0._gobubblecanget = gohelper.findChild(arg_1_0.viewGO, "factory/#btn_bubble/canget")
	arg_1_0._gorewardwindow = gohelper.findChild(arg_1_0.viewGO, "#go_rewardwindow")
	arg_1_0._rewardwindowAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_1_0._gorewardwindow)
	arg_1_0._btnclosereward = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "#go_rewardwindow")
	arg_1_0._sliderreward = gohelper.findChildSlider(arg_1_0.viewGO, "#go_rewardwindow/#go_progress/slider")
	arg_1_0._btnreward = gohelper.findChildClickWithDefaultAudio(arg_1_0.viewGO, "#btn_reward")
	arg_1_0._btnrewardAnimator = gohelper.findChildComponent(arg_1_0.viewGO, "#btn_reward", typeof(UnityEngine.Animator))
	arg_1_0._goRewardReddot = gohelper.findChild(arg_1_0.viewGO, "#btn_reward/#go_reddot")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnbubble:AddClickListener(arg_2_0._btnbubbleOnClick, arg_2_0)
	arg_2_0._btncomposite:AddClickListener(arg_2_0._btncompositeOnClick, arg_2_0)
	arg_2_0._btnreward:AddClickListener(arg_2_0._btnrewardOnClick, arg_2_0)
	arg_2_0._btnclosereward:AddClickListener(arg_2_0._btncloserewardOnClick, arg_2_0)
	arg_2_0:addEventCb(Activity157Controller.instance, Activity157Event.Act157RepairComponent, arg_2_0.onRepairComponent, arg_2_0)
	arg_2_0:addEventCb(Activity157Controller.instance, Activity157Event.Act157RefreshFactoryProduction, arg_2_0.refreshBubble, arg_2_0)
	arg_2_0:addEventCb(Activity157Controller.instance, Activity157Event.Act157OnGetComponentReward, arg_2_0.onGetRepairReward, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnbubble:RemoveClickListener()
	arg_3_0._btncomposite:RemoveClickListener()
	arg_3_0._btnreward:RemoveClickListener()
	arg_3_0._btnclosereward:RemoveClickListener()
	arg_3_0:removeEventCb(Activity157Controller.instance, Activity157Event.Act157RepairComponent, arg_3_0.onRepairComponent, arg_3_0)
	arg_3_0:removeEventCb(Activity157Controller.instance, Activity157Event.Act157RefreshFactoryProduction, arg_3_0.refreshBubble, arg_3_0)
	arg_3_0:removeEventCb(Activity157Controller.instance, Activity157Event.Act157OnGetComponentReward, arg_3_0.onGetRepairReward, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
end

function var_0_0._btnbubbleOnClick(arg_4_0)
	Activity157Controller.instance:getFactoryProduction()
end

function var_0_0._btncompositeOnClick(arg_5_0)
	if Activity157Model.instance:getIsFirstComponentRepair() then
		Activity157Controller.instance:openCompositeView()
	else
		GameFacade.showToast(ToastEnum.V1a8Activity157NotUnlockFactoryBlueprint)
	end
end

function var_0_0._btnrewardOnClick(arg_6_0)
	arg_6_0:refreshRewardProgress()
	gohelper.setActive(arg_6_0._gorewardwindow, true)
	arg_6_0._rewardwindowAnimatorPlayer:Play("open")

	local var_6_0 = Activity157Model.instance:getLastArchiveRewardComponent()

	if var_6_0 then
		Activity157Rpc.instance:sendAct157GainMilestoneRewardRequest(arg_6_0.actId, var_6_0, arg_6_0.refreshRewardProgress, arg_6_0)
	end
end

function var_0_0._btncloserewardOnClick(arg_7_0)
	arg_7_0._rewardwindowAnimatorPlayer:Play("close", arg_7_0.hideRewardWindow, arg_7_0)
end

function var_0_0.hideRewardWindow(arg_8_0)
	gohelper.setActive(arg_8_0._gorewardwindow, false)
end

function var_0_0.onRepairComponent(arg_9_0)
	local var_9_0 = ViewMgr.instance:getOpenViewNameList()

	if var_9_0[#var_9_0] ~= arg_9_0.viewName then
		arg_9_0._waitOnRepairComponent = true
	else
		arg_9_0._waitOnRepairComponent = false

		arg_9_0:checkFactoryAnim()
		arg_9_0:refresh()
	end
end

function var_0_0.onGetRepairReward(arg_10_0, arg_10_1)
	arg_10_0._rewardsMaterials = arg_10_1

	arg_10_0:refreshRepairReward(true)
end

function var_0_0._onCloseView(arg_11_0, arg_11_1)
	if not arg_11_0._waitOnRepairComponent then
		return
	end

	local var_11_0 = ViewMgr.instance:getOpenViewNameList()

	if var_11_0[#var_11_0] ~= arg_11_0.viewName then
		return
	end

	arg_11_0:onRepairComponent()

	if Activity157Model.instance:getIsFirstComponentRepair() then
		Activity157Controller.instance:dispatchEvent(Activity157Event.GuideHasRepairFirstComponent)
	end

	arg_11_0._waitOnRepairComponent = false
end

function var_0_0._editableInitView(arg_12_0)
	arg_12_0.actId = Activity157Model.instance:getActId()

	local var_12_0 = Activity157Config.instance:getComponentIdList(arg_12_0.actId)
	local var_12_1 = #var_12_0

	arg_12_0.partItemList = {}
	arg_12_0.rewardWindowItemList = {}

	for iter_12_0 = 1, var_12_1 do
		local var_12_2 = var_12_0[iter_12_0]
		local var_12_3 = gohelper.findChild(arg_12_0.viewGO, "factory/part_" .. iter_12_0)

		if var_12_3 then
			local var_12_4 = MonoHelper.addNoUpdateLuaComOnceToGo(var_12_3, VersionActivity1_8FactoryBlueprintPartItem, var_12_2)

			table.insert(arg_12_0.partItemList, var_12_4)
		end

		local var_12_5 = gohelper.findChild(arg_12_0.viewGO, "#go_rewardwindow/#go_progress/point/" .. iter_12_0)
		local var_12_6 = gohelper.findChild(arg_12_0.viewGO, "#go_rewardwindow/layout/item" .. iter_12_0)

		if var_12_6 then
			local var_12_7 = VersionActivity1_8FactoryBlueprintRewardItem.New(var_12_6, var_12_2, var_12_5)

			table.insert(arg_12_0.rewardWindowItemList, var_12_7)
		end
	end

	local var_12_8 = Activity157Config.instance:getAct157Const(arg_12_0.actId, Activity157Enum.ConstId.FactoryCompositeCost)
	local var_12_9 = var_12_8 and string.splitToNumber(var_12_8, "#")

	if var_12_9 then
		local var_12_10, var_12_11 = ItemModel.instance:getItemConfigAndIcon(var_12_9[1], var_12_9[2])

		if var_12_11 then
			arg_12_0._simagecangeticon:LoadImage(var_12_11)
		end
	end

	arg_12_0:hideRewardWindow()
	RedDotController.instance:addRedDot(arg_12_0._goRewardReddot, RedDotEnum.DotNode.V1a8DungeonFactoryRepairReward, arg_12_0.actId, arg_12_0.checkRewardReddot, arg_12_0)
end

function var_0_0.checkRewardReddot(arg_13_0, arg_13_1)
	arg_13_1:defaultRefreshDot()

	if arg_13_1.show then
		arg_13_0._btnrewardAnimator:Play("receive", 0, 0)
	else
		arg_13_0._btnrewardAnimator:Play("open", 0, 1)
	end
end

function var_0_0.onUpdateParam(arg_14_0)
	return
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0:checkFactoryAnim()
	arg_15_0:refresh()
	arg_15_0:everySecondCall()
	TaskDispatcher.runRepeat(arg_15_0.everySecondCall, arg_15_0, 1)
	AudioMgr.instance:trigger(AudioEnum.UI.Act157OpenBlueprintView)

	if Activity157Model.instance:getIsFirstComponentRepair() then
		Activity157Controller.instance:dispatchEvent(Activity157Event.GuideHasRepairFirstComponent)
	end
end

function var_0_0.checkFactoryAnim(arg_16_0)
	if not Activity157Model.instance:isAllComponentRepair() then
		return
	end

	local var_16_0 = VersionActivity1_8DungeonEnum.PlayerPrefsKey.IsPlayedBlueprintAllFinish

	if Activity157Model.instance:getHasPlayedAnim(var_16_0) then
		arg_16_0._factoryAnimator:Play("loop")
	else
		arg_16_0._factoryAnimator:Play("finish", 0, 0)
		Activity157Model.instance:setHasPlayedAnim(var_16_0)
	end
end

function var_0_0.refreshRewardProgress(arg_17_0)
	local var_17_0 = 0
	local var_17_1 = Activity157Model.instance:getLastHasGotRewardComponent()

	if var_17_1 then
		local var_17_2 = Activity157Config.instance:getComponentIdList(arg_17_0.actId)
		local var_17_3 = #var_17_2

		for iter_17_0, iter_17_1 in ipairs(var_17_2) do
			if var_17_1 == iter_17_1 then
				var_17_0 = (iter_17_0 - 1) / (var_17_3 - 1)

				break
			end
		end
	end

	arg_17_0._sliderreward:SetValue(math.max(var_17_0, 0))
end

function var_0_0.refresh(arg_18_0)
	if Activity157Model.instance:getIsFirstComponentRepair() then
		local var_18_0 = Activity157Model.instance:isAllComponentRepair()

		gohelper.setActive(arg_18_0._gocomposite, not var_18_0)
		arg_18_0.viewContainer:setCurrencyType({
			CurrencyEnum.CurrencyType.V1a8FactoryPart,
			CurrencyEnum.CurrencyType.V1a8FactoryRawMat
		})
	else
		gohelper.setActive(arg_18_0._gocomposite, false)
		arg_18_0.viewContainer:setCurrencyType({
			CurrencyEnum.CurrencyType.V1a8FactoryPart
		})
	end

	arg_18_0:refreshPartItem()
	arg_18_0:refreshBubble()
	arg_18_0:refreshRepairReward()
end

function var_0_0.refreshPartItem(arg_19_0)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0.partItemList) do
		iter_19_1:refresh()
	end
end

function var_0_0.refreshBubble(arg_20_0)
	local var_20_0 = Activity157Model.instance:getFactoryNextRecoverCountdown()
	local var_20_1 = string.nilorempty(var_20_0)
	local var_20_2 = Activity157Model.instance:getFactoryProductionNum()
	local var_20_3 = var_20_2 > 0
	local var_20_4 = not var_20_3 and var_20_1

	gohelper.setActive(arg_20_0._gobubble, not var_20_4)

	if var_20_4 then
		return
	end

	arg_20_0:refreshBubbleTime()

	local var_20_5 = Activity157Config.instance:getAct157FactoryProductCapacity(arg_20_0.actId, Activity157Enum.ConstId.FactoryProductCapacity)
	local var_20_6 = var_20_5 <= var_20_2

	gohelper.setActive(arg_20_0._gobubblecanget, var_20_6)
	gohelper.setActive(arg_20_0._gobubblenum, not var_20_6)

	if var_20_6 then
		return
	end

	local var_20_7 = "#F5744D"

	if var_20_3 then
		var_20_7 = "#88CB7F"
	end

	arg_20_0._txtbubblenum.text = string.format("<color=%s>%s</color>/%s", var_20_7, var_20_2, var_20_5)
end

function var_0_0.refreshBubbleTime(arg_21_0)
	local var_21_0 = Activity157Model.instance:getFactoryNextRecoverCountdown()
	local var_21_1 = string.nilorempty(var_21_0)
	local var_21_2 = Activity157Model.instance:getFactoryProductionNum() >= Activity157Config.instance:getAct157FactoryProductCapacity(arg_21_0.actId, Activity157Enum.ConstId.FactoryProductCapacity)
	local var_21_3 = not var_21_1 and not var_21_2

	gohelper.setActive(arg_21_0._gobubbletime, var_21_3)

	if var_21_1 then
		return
	end

	arg_21_0._txtbubbletime.text = var_21_0
end

function var_0_0.refreshRepairReward(arg_22_0, arg_22_1)
	for iter_22_0, iter_22_1 in ipairs(arg_22_0.rewardWindowItemList) do
		iter_22_1:refresh(arg_22_1)
	end

	if arg_22_0._rewardsMaterials then
		AudioMgr.instance:trigger(AudioEnum.RewardPoint.play_ui_track_achievement_single)
		TaskDispatcher.cancelTask(arg_22_0._showMaterials, arg_22_0)
		UIBlockMgr.instance:startBlock(VersionActivity1_8DungeonEnum.BlockKey.GetComponentRepairReward)
		TaskDispatcher.runDelay(arg_22_0._showMaterials, arg_22_0, var_0_1)
	end
end

function var_0_0._showMaterials(arg_23_0)
	RoomController.instance:popUpRoomBlockPackageView(arg_23_0._rewardsMaterials)
	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.CommonPropView, arg_23_0._rewardsMaterials)

	arg_23_0._rewardsMaterials = nil

	UIBlockMgr.instance:endBlock(VersionActivity1_8DungeonEnum.BlockKey.GetComponentRepairReward)
end

function var_0_0.everySecondCall(arg_24_0)
	arg_24_0:refreshBubbleTime()
end

function var_0_0.onClose(arg_25_0)
	TaskDispatcher.cancelTask(arg_25_0.everySecondCall, arg_25_0)

	arg_25_0._waitOnRepairComponent = false

	UIBlockMgr.instance:endBlock(VersionActivity1_8DungeonEnum.BlockKey.GetComponentRepairReward)
end

function var_0_0.onDestroyView(arg_26_0)
	for iter_26_0, iter_26_1 in ipairs(arg_26_0.partItemList) do
		iter_26_1:destroy()
	end

	for iter_26_2, iter_26_3 in ipairs(arg_26_0.rewardWindowItemList) do
		iter_26_3:destroy()
	end

	arg_26_0._simagecangeticon:UnLoadImage()
end

return var_0_0
