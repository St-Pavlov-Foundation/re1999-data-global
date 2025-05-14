module("modules.logic.versionactivity2_0.dungeon.view.graffiti.VersionActivity2_0DungeonGraffitiRewardView", package.seeall)

local var_0_0 = class("VersionActivity2_0DungeonGraffitiRewardView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gorewardwindow = gohelper.findChild(arg_1_0.viewGO, "#go_rewardwindow")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_rewardwindow/#btn_close")
	arg_1_0._imageprogressBar = gohelper.findChildImage(arg_1_0.viewGO, "#go_rewardwindow/Content/bg/#image_progressBar")
	arg_1_0._imageprogress = gohelper.findChildImage(arg_1_0.viewGO, "#go_rewardwindow/Content/bg/#image_progressBar/#image_progress")
	arg_1_0._gorewardContent = gohelper.findChild(arg_1_0.viewGO, "#go_rewardwindow/Content/#go_rewardContent")
	arg_1_0._gorewardItem = gohelper.findChild(arg_1_0.viewGO, "#go_rewardwindow/Content/#go_rewardContent/#go_rewarditem")
	arg_1_0._gofinalrewardItem = gohelper.findChild(arg_1_0.viewGO, "#go_rewardwindow/Content/#go_rewardContent/#go_finalrewarditem")
	arg_1_0._gofinalreward = gohelper.findChild(arg_1_0.viewGO, "#go_rewardwindow/Content/#go_rewardContent/#go_finalrewarditem/#go_finalreward")
	arg_1_0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_1_0._gorewardwindow)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0:addEventCb(Activity161Controller.instance, Activity161Event.GetGraffitiReward, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnUpdateMapElementState, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(Activity161Controller.instance, Activity161Event.PlayGraffitiRewardGetAnim, arg_2_0.playHasGetEffect, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0:removeEventCb(Activity161Controller.instance, Activity161Event.GetGraffitiReward, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(DungeonController.instance, DungeonEvent.OnUpdateMapElementState, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(Activity161Controller.instance, Activity161Event.PlayGraffitiRewardGetAnim, arg_3_0.playHasGetEffect, arg_3_0)
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0._animatorPlayer:Play(UIAnimationName.Close, arg_4_0.onCloseAnimDone, arg_4_0)
	gohelper.setActive(arg_4_0._btnclose.gameObject, false)
end

function var_0_0.onCloseAnimDone(arg_5_0)
	gohelper.setActive(arg_5_0._gorewardwindow, false)
end

function var_0_0._editableInitView(arg_6_0)
	gohelper.setActive(arg_6_0._gorewardwindow, false)
	gohelper.setActive(arg_6_0._gorewardItem, false)

	arg_6_0.rewardItemTab = arg_6_0:getUserDataTb_()
	arg_6_0.stageRewardItems = arg_6_0:getUserDataTb_()
	arg_6_0.finalItemTab = arg_6_0:getUserDataTb_()
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0.actId = arg_7_0.viewParam.actId
	arg_7_0.allRewardConfig = Activity161Config.instance:getAllRewardCos(arg_7_0.actId)
	arg_7_0.finalRewardList, arg_7_0.finalRewardInfo = Activity161Config.instance:getFinalReward(arg_7_0.actId)
	arg_7_0.lastHasGetRewardMap = tabletool.copy(Activity161Model.instance.curHasGetRewardMap)

	arg_7_0:createRewardItem()
	arg_7_0:createFinalRewardItem()
	arg_7_0:refreshUI()
end

function var_0_0.refreshUI(arg_8_0)
	arg_8_0:refreshItemState()
	arg_8_0:refreshProgress()
end

function var_0_0.createRewardItem(arg_9_0)
	arg_9_0.rewardsConfig = tabletool.copy(arg_9_0.allRewardConfig)
	arg_9_0.rewardCount = GameUtil.getTabLen(arg_9_0.rewardsConfig)
	arg_9_0.lastStageRewardConfig = table.remove(arg_9_0.rewardsConfig, #arg_9_0.rewardsConfig)

	for iter_9_0, iter_9_1 in pairs(arg_9_0.rewardsConfig) do
		local var_9_0 = arg_9_0.rewardItemTab[iter_9_0]

		if not var_9_0 then
			var_9_0 = {
				go = gohelper.clone(arg_9_0._gorewardItem, arg_9_0._gorewardContent, "rewardItem" .. iter_9_0),
				config = iter_9_1
			}
			var_9_0 = arg_9_0:initWholeRewardItemComp(var_9_0, var_9_0.go)
			arg_9_0.rewardItemTab[iter_9_0] = var_9_0
		end

		arg_9_0:initRewardItemData(var_9_0, iter_9_1, iter_9_0)
	end

	local var_9_1 = arg_9_0.rewardItemTab[arg_9_0.rewardCount]

	if not var_9_1 then
		var_9_1 = {
			go = arg_9_0._gofinalrewardItem,
			config = arg_9_0.lastStageRewardConfig
		}
		var_9_1 = arg_9_0:initWholeRewardItemComp(var_9_1, var_9_1.go)
		arg_9_0.rewardItemTab[arg_9_0.rewardCount] = var_9_1
	end

	gohelper.setAsLastSibling(var_9_1.go)
	arg_9_0:initRewardItemData(var_9_1, arg_9_0.lastStageRewardConfig, arg_9_0.rewardCount)
end

function var_0_0.initWholeRewardItemComp(arg_10_0, arg_10_1, arg_10_2)
	arg_10_1.txtpaintedNum = gohelper.findChildTextMesh(arg_10_2, "txt_paintedNum")
	arg_10_1.godarkPoint = gohelper.findChild(arg_10_2, "darkpoint")
	arg_10_1.golightPoint = gohelper.findChild(arg_10_2, "lightpoint")
	arg_10_1.goreward = gohelper.findChild(arg_10_2, "layout/go_reward")

	gohelper.setActive(arg_10_1.goreward, false)

	return arg_10_1
end

function var_0_0.initRewardItemData(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	gohelper.setActive(arg_11_1.go, true)

	arg_11_1.txtpaintedNum.text = arg_11_2.paintedNum

	local var_11_0 = {}

	if arg_11_3 == arg_11_0.rewardCount then
		var_11_0 = arg_11_0.finalRewardList
	else
		var_11_0 = GameUtil.splitString2(arg_11_2.bonus, true)
	end

	if not arg_11_0.stageRewardItems[arg_11_3] then
		local var_11_1 = {}

		for iter_11_0, iter_11_1 in ipairs(var_11_0) do
			local var_11_2 = {
				itemGO = gohelper.cloneInPlace(arg_11_1.goreward, "item" .. tostring(iter_11_0))
			}
			local var_11_3 = arg_11_0:initRewardItemComp(var_11_2, var_11_2.itemGO, iter_11_1)

			gohelper.setActive(var_11_3.itemGO, true)
			arg_11_0:initItemIconInfo(var_11_3, iter_11_1)

			var_11_1[iter_11_0] = var_11_3
		end

		arg_11_0.stageRewardItems[arg_11_3] = var_11_1
	end
end

function var_0_0.createFinalRewardItem(arg_12_0)
	if GameUtil.getTabLen(arg_12_0.finalItemTab) == 0 then
		arg_12_0:initRewardItemComp(arg_12_0.finalItemTab, arg_12_0._gofinalreward, arg_12_0.finalRewardInfo, true)
	end

	arg_12_0:initItemIconInfo(arg_12_0.finalItemTab, arg_12_0.finalRewardInfo)
end

function var_0_0.initRewardItemComp(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	arg_13_1.itemGO = arg_13_2
	arg_13_1.itemRare = gohelper.findChildImage(arg_13_1.itemGO, "item/image_rare")
	arg_13_1.itemIcon = gohelper.findChildSingleImage(arg_13_1.itemGO, "item/simage_icon")
	arg_13_1.itemNum = gohelper.findChildText(arg_13_1.itemGO, "item/txt_num")
	arg_13_1.goHasGet = gohelper.findChild(arg_13_1.itemGO, "go_hasget")
	arg_13_1.goCanGet = gohelper.findChild(arg_13_1.itemGO, "go_canget")
	arg_13_1.goLock = gohelper.findChild(arg_13_1.itemGO, "go_lock")
	arg_13_1.hasGetAnim = arg_13_1.goHasGet:GetComponent(gohelper.Type_Animator)
	arg_13_1.btnClick = gohelper.findChildButtonWithAudio(arg_13_1.itemGO, "item/btn_click")

	arg_13_1.btnClick:AddClickListener(arg_13_0.rewardItemClick, arg_13_0, arg_13_3)

	arg_13_1.isFinalReward = arg_13_4

	return arg_13_1
end

function var_0_0.initItemIconInfo(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0, var_14_1 = ItemModel.instance:getItemConfigAndIcon(arg_14_2[1], arg_14_2[2], true)

	arg_14_1.itemIcon:LoadImage(var_14_1)

	if var_14_0.rare == 0 then
		gohelper.setActive(arg_14_1.itemRare.gameObject, false)
	elseif var_14_0.rare < 5 and not arg_14_1.isFinalReward then
		UISpriteSetMgr.instance:setV2a0PaintSprite(arg_14_1.itemRare, "v2a0_paint_rewardbg_" .. var_14_0.rare)
	end

	arg_14_1.itemNum.text = luaLang("multiple") .. arg_14_2[3]
end

function var_0_0.rewardItemClick(arg_15_0, arg_15_1)
	MaterialTipController.instance:showMaterialInfo(arg_15_1[1], arg_15_1[2])
end

function var_0_0.refreshItemState(arg_16_0)
	arg_16_0.curHasGetRewardMap = Activity161Model.instance.curHasGetRewardMap

	local var_16_0 = Activity161Model.instance:getCurPaintedNum()

	for iter_16_0, iter_16_1 in pairs(arg_16_0.rewardItemTab) do
		local var_16_1 = iter_16_1.config.paintedNum

		gohelper.setActive(iter_16_1.godarkPoint, var_16_0 < var_16_1)
		gohelper.setActive(iter_16_1.golightPoint, var_16_1 <= var_16_0)
		SLFramework.UGUI.GuiHelper.SetColor(iter_16_1.txtpaintedNum, var_16_1 <= var_16_0 and "#E9842A" or "#666767")
	end

	for iter_16_2, iter_16_3 in pairs(arg_16_0.stageRewardItems) do
		local var_16_2 = arg_16_0.rewardItemTab[iter_16_2].config.paintedNum

		for iter_16_4, iter_16_5 in pairs(iter_16_3) do
			gohelper.setActive(iter_16_5.goHasGet, arg_16_0.curHasGetRewardMap[iter_16_2])
			gohelper.setActive(iter_16_5.goCanGet, not arg_16_0.curHasGetRewardMap[iter_16_2] and var_16_2 <= var_16_0)
			gohelper.setActive(iter_16_5.goLock, not arg_16_0.curHasGetRewardMap[iter_16_2] and var_16_0 < var_16_2)
		end
	end

	gohelper.setActive(arg_16_0.finalItemTab.goHasGet, arg_16_0.curHasGetRewardMap[arg_16_0.rewardCount])
	gohelper.setActive(arg_16_0.finalItemTab.goCanGet, not arg_16_0.curHasGetRewardMap[arg_16_0.rewardCount] and var_16_0 >= arg_16_0.lastStageRewardConfig.paintedNum)
	gohelper.setActive(arg_16_0.finalItemTab.goLock, not arg_16_0.curHasGetRewardMap[arg_16_0.rewardCount] and var_16_0 < arg_16_0.lastStageRewardConfig.paintedNum)
end

function var_0_0.playHasGetEffect(arg_17_0, arg_17_1)
	for iter_17_0, iter_17_1 in pairs(arg_17_1) do
		local var_17_0 = arg_17_0.stageRewardItems[iter_17_1.rewardId]

		for iter_17_2, iter_17_3 in pairs(var_17_0) do
			gohelper.setActive(iter_17_3.goHasGet, true)
			gohelper.setActive(iter_17_3.goCanGet, false)
			iter_17_3.hasGetAnim:Play("go_hasget_in", 0, 0)
		end

		if iter_17_1.rewardId == arg_17_0.rewardCount then
			gohelper.setActive(arg_17_0.finalItemTab.goHasGet, true)
			gohelper.setActive(arg_17_0.finalItemTab.goCanGet, false)
			arg_17_0.finalItemTab.hasGetAnim:Play("go_hasget_in", 0, 0)
		end
	end

	TaskDispatcher.runDelay(arg_17_0.rewardCanGetClick, arg_17_0, 1)
end

function var_0_0.rewardCanGetClick(arg_18_0)
	Activity161Rpc.instance:sendAct161GainMilestoneRewardRequest(arg_18_0.actId)
	UIBlockMgr.instance:endBlock("GraffitiRewardViewPlayHasGetEffect")
end

function var_0_0.refreshProgress(arg_19_0)
	local var_19_0 = 66
	local var_19_1 = 177
	local var_19_2 = 278
	local var_19_3 = 24
	local var_19_4 = var_19_0 + var_19_1 * Mathf.Max(0, arg_19_0.rewardCount - 2) + var_19_3 * arg_19_0.rewardCount + var_19_2

	recthelper.setWidth(arg_19_0._imageprogressBar.transform, var_19_4)

	local var_19_5 = 0
	local var_19_6 = Activity161Model.instance:getCurPaintedNum()
	local var_19_7 = 0
	local var_19_8 = 0
	local var_19_9 = 0
	local var_19_10 = 0

	for iter_19_0, iter_19_1 in pairs(arg_19_0.allRewardConfig) do
		if var_19_6 >= iter_19_1.paintedNum then
			var_19_7 = iter_19_0
			var_19_8 = iter_19_1.paintedNum
			var_19_9 = iter_19_1.paintedNum
		elseif var_19_8 <= var_19_9 then
			var_19_9 = iter_19_1.paintedNum

			break
		end
	end

	if var_19_9 ~= var_19_8 then
		var_19_10 = (var_19_6 - var_19_8) / (var_19_9 - var_19_8)
	end

	if var_19_7 == 0 then
		var_19_5 = var_19_0 * var_19_6 / var_19_9
	elseif var_19_7 >= 1 and var_19_7 < arg_19_0.rewardCount - 1 then
		var_19_5 = var_19_0 + var_19_1 * (var_19_7 - 1) + var_19_7 * var_19_3 + var_19_10 * var_19_1
	elseif var_19_7 == arg_19_0.rewardCount - 1 then
		var_19_5 = var_19_0 + var_19_1 * (var_19_7 - 1) + var_19_7 * var_19_3 + var_19_10 * var_19_2
	elseif var_19_7 == arg_19_0.rewardCount then
		var_19_5 = var_19_4
	end

	recthelper.setWidth(arg_19_0._imageprogress.transform, var_19_5)
end

function var_0_0.onClose(arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0.rewardCanGetClick, arg_20_0)
	UIBlockMgr.instance:endBlock("GraffitiRewardViewPlayHasGetEffect")
end

function var_0_0.onDestroyView(arg_21_0)
	for iter_21_0, iter_21_1 in pairs(arg_21_0.stageRewardItems) do
		for iter_21_2, iter_21_3 in pairs(iter_21_1) do
			iter_21_3.btnClick:RemoveClickListener()
			iter_21_3.itemIcon:UnLoadImage()
		end
	end

	arg_21_0.finalItemTab.btnClick:RemoveClickListener()
	arg_21_0.finalItemTab.itemIcon:UnLoadImage()
end

return var_0_0
