module("modules.logic.versionactivity2_0.dungeon.view.graffiti.VersionActivity2_0DungeonGraffitiView", package.seeall)

local var_0_0 = class("VersionActivity2_0DungeonGraffitiView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._scrollgraffiti = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_graffiti")
	arg_1_0._gograffitiContent = gohelper.findChild(arg_1_0.viewGO, "#scroll_graffiti/Viewport/#go_graffitiContent")
	arg_1_0._btnreward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rewardInfo/#btn_reward")
	arg_1_0._txtrewardState = gohelper.findChildText(arg_1_0.viewGO, "rewardInfo/#btn_reward/#txt_rewardstate")
	arg_1_0._btnrewardIcon = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "rewardInfo/finalreward/#btn_rewardicon")
	arg_1_0._imagerewardrare = gohelper.findChildImage(arg_1_0.viewGO, "rewardInfo/finalreward/#image_rewardrare")
	arg_1_0._simagerewardicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "rewardInfo/finalreward/#simage_rewardicon")
	arg_1_0._txtrewardnum = gohelper.findChildText(arg_1_0.viewGO, "rewardInfo/finalreward/#txt_rewardnum")
	arg_1_0._gorewardhasget = gohelper.findChild(arg_1_0.viewGO, "rewardInfo/finalreward/#go_rewardhasget")
	arg_1_0._imageprogress = gohelper.findChildImage(arg_1_0.viewGO, "rewardInfo/#btn_reward/progressbar/#image_progress")
	arg_1_0._txtprogress = gohelper.findChildText(arg_1_0.viewGO, "rewardInfo/#btn_reward/#txt_progress")
	arg_1_0._btnrightjump = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_rightjump")
	arg_1_0._btnleftjump = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_leftjump")
	arg_1_0._gorewardwindow = gohelper.findChild(arg_1_0.viewGO, "#go_rewardwindow")
	arg_1_0._gorewardReddot = gohelper.findChild(arg_1_0.viewGO, "rewardInfo/#btn_reward/#go_RedDot")
	arg_1_0._goCangetEffect = gohelper.findChild(arg_1_0.viewGO, "rewardInfo/finalreward/#receive")
	arg_1_0._goCloseRewardWindow = gohelper.findChild(arg_1_0.viewGO, "#go_rewardwindow/#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreward:AddClickListener(arg_2_0._btnrewardOnClick, arg_2_0)
	arg_2_0._btnrewardIcon:AddClickListener(arg_2_0._btnrewardIconOnClick, arg_2_0)
	arg_2_0._btnrightjump:AddClickListener(arg_2_0._btnrightjumpOnClick, arg_2_0)
	arg_2_0._btnleftjump:AddClickListener(arg_2_0._btnleftjumpOnClick, arg_2_0)
	arg_2_0._scrollgraffiti:AddOnValueChanged(arg_2_0.refreshJumpBtnShow, arg_2_0)
	arg_2_0:addEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(Activity161Controller.instance, Activity161Event.RefreshGraffitiView, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(Activity161Controller.instance, Activity161Event.GetGraffitiReward, arg_2_0.refreshReward, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreward:RemoveClickListener()
	arg_3_0._btnrewardIcon:RemoveClickListener()
	arg_3_0._btnrightjump:RemoveClickListener()
	arg_3_0._btnleftjump:RemoveClickListener()
	arg_3_0._scrollgraffiti:RemoveOnValueChanged()
	arg_3_0:removeEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(Activity161Controller.instance, Activity161Event.RefreshGraffitiView, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(Activity161Controller.instance, Activity161Event.GetGraffitiReward, arg_3_0.refreshReward, arg_3_0)
end

var_0_0.clickLeftJump = 0
var_0_0.clickRightJump = 1

function var_0_0._btnrewardOnClick(arg_4_0)
	gohelper.setActive(arg_4_0._gorewardwindow, true)
	gohelper.setActive(arg_4_0._goCloseRewardWindow, true)

	arg_4_0.ishaveUnGetReward, arg_4_0.canGetRewardList = Activity161Model.instance:ishaveUnGetReward()

	if arg_4_0.ishaveUnGetReward then
		TaskDispatcher.runDelay(arg_4_0.showGetRewardEffect, arg_4_0, 0.5)
		UIBlockMgr.instance:startBlock("GraffitiRewardViewPlayHasGetEffect")
	end
end

function var_0_0.showGetRewardEffect(arg_5_0)
	Activity161Controller.instance:dispatchEvent(Activity161Event.PlayGraffitiRewardGetAnim, arg_5_0.canGetRewardList)
end

function var_0_0._btnrewardIconOnClick(arg_6_0)
	return
end

function var_0_0._btnrightjumpOnClick(arg_7_0)
	arg_7_0:moveToNeedUnlockPicture(var_0_0.clickRightJump)
end

function var_0_0._btnleftjumpOnClick(arg_8_0)
	arg_8_0:moveToNeedUnlockPicture(var_0_0.clickLeftJump)
end

function var_0_0._editableInitView(arg_9_0)
	gohelper.setActive(arg_9_0._btnleftjump.gameObject, false)
	gohelper.setActive(arg_9_0._btnrightjump.gameObject, false)

	arg_9_0.screenWidth = gohelper.getUIScreenWidth()
	arg_9_0._transGraffitiContent = arg_9_0._gograffitiContent:GetComponent(gohelper.Type_RectTransform)
	arg_9_0.scrollGraffitiRect = arg_9_0._scrollgraffiti.gameObject:GetComponent(typeof(UnityEngine.UI.ScrollRect))
	arg_9_0._contentWidth = recthelper.getWidth(arg_9_0._transGraffitiContent)
	arg_9_0.maxScrollPos = arg_9_0._contentWidth - arg_9_0.screenWidth
	arg_9_0.jumpLeftElementId = 0
	arg_9_0.jumpRightElementId = 0
	arg_9_0.graffitiItemPath = arg_9_0.viewContainer:getSetting().otherRes[1]
	arg_9_0.unlockStateTab = arg_9_0:getUserDataTb_()
	arg_9_0.saveUnlockStateTab = arg_9_0:getUserDataTb_()
	arg_9_0.materialTab = arg_9_0:getUserDataTb_()
	arg_9_0.picturesTab = arg_9_0:getUserDataTb_()

	RedDotController.instance:addRedDot(arg_9_0._gorewardReddot, RedDotEnum.DotNode.V2a0GraffitiReward, Activity161Model.instance:getActId())
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0.actId = arg_10_0.viewParam.actId
	arg_10_0.graffitiCount = Activity161Config.instance:getGraffitiCount(arg_10_0.actId)

	arg_10_0:loadGraffitiMaterial()
	arg_10_0:refreshUI()
	arg_10_0:refreshUnlockState()
	arg_10_0:moveToFirstCanDrawGraffiti()
end

function var_0_0.loadGraffitiMaterial(arg_11_0)
	local var_11_0 = arg_11_0.viewContainer:getSetting().otherRes[2]
	local var_11_1 = arg_11_0.viewContainer:getSetting().otherRes[3]
	local var_11_2 = arg_11_0.viewContainer:getRes(var_11_0)
	local var_11_3 = arg_11_0.viewContainer:getRes(var_11_1)

	table.insert(arg_11_0.materialTab, var_11_2)
	table.insert(arg_11_0.materialTab, var_11_3)
end

function var_0_0.refreshUI(arg_12_0)
	arg_12_0:initPictures()
	arg_12_0:refreshReward()
	arg_12_0:refreshJumpBtnShow()
end

function var_0_0.initPictures(arg_13_0)
	local var_13_0 = Activity161Config.instance.graffitiPicList

	for iter_13_0, iter_13_1 in pairs(var_13_0) do
		local var_13_1 = arg_13_0.picturesTab[iter_13_1.elementId]

		if not var_13_1 then
			var_13_1 = {
				go = gohelper.findChild(arg_13_0.viewGO, "#scroll_graffiti/Viewport/#go_graffitiContent/#go_picture" .. iter_13_0)
			}
			var_13_1.itemGO = arg_13_0.viewContainer:getResInst(arg_13_0.graffitiItemPath, var_13_1.go)
			var_13_1.item = MonoHelper.addNoUpdateLuaComOnceToGo(var_13_1.itemGO, VersionActivity2_0DungeonGraffitiItem)
			var_13_1.rect = var_13_1.go:GetComponent(gohelper.Type_RectTransform)
			var_13_1.width = recthelper.getWidth(var_13_1.rect)
			var_13_1.anchorX = recthelper.getAnchorX(var_13_1.rect)
			var_13_1.config = iter_13_1
			var_13_1.index = iter_13_0
			arg_13_0.picturesTab[iter_13_1.elementId] = var_13_1

			var_13_1.item:initData(arg_13_0.actId, iter_13_1.elementId, arg_13_0.materialTab)
		end

		var_13_1.mo = Activity161Model.instance.graffitiInfoMap[iter_13_1.elementId]
		arg_13_0.unlockStateTab[iter_13_1.elementId] = Activity161Model.instance:isUnlockState(var_13_1.mo)

		var_13_1.item:refreshItem()
	end
end

function var_0_0.moveToNeedUnlockPicture(arg_14_0, arg_14_1)
	if arg_14_1 == var_0_0.clickRightJump then
		local var_14_0 = arg_14_0.picturesTab[arg_14_0.jumpRightElementId].anchorX + arg_14_0.picturesTab[arg_14_0.jumpRightElementId].width / 2 - arg_14_0.screenWidth / 2
		local var_14_1 = Mathf.Min(arg_14_0.maxScrollPos, var_14_0)

		recthelper.setAnchorX(arg_14_0._transGraffitiContent, -var_14_1)
	else
		local var_14_2 = arg_14_0.picturesTab[arg_14_0.jumpLeftElementId].anchorX + arg_14_0.picturesTab[arg_14_0.jumpLeftElementId].width / 2 - arg_14_0.screenWidth / 2
		local var_14_3 = Mathf.Max(0, var_14_2)

		recthelper.setAnchorX(arg_14_0._transGraffitiContent, -var_14_3)
	end

	arg_14_0.scrollGraffitiRect.velocity = Vector2(0, 0)
end

function var_0_0.moveToFirstCanDrawGraffiti(arg_15_0)
	arg_15_0.curCanDrawItems = Activity161Model.instance:getItemsByState(Activity161Enum.graffitiState.Normal)

	if #arg_15_0.curCanDrawItems > 0 then
		local var_15_0 = arg_15_0.maxScrollPos

		for iter_15_0 = 1, #arg_15_0.curCanDrawItems do
			local var_15_1 = arg_15_0.curCanDrawItems[iter_15_0].id
			local var_15_2 = arg_15_0.picturesTab[var_15_1].anchorX - arg_15_0.screenWidth / 2 + arg_15_0.picturesTab[var_15_1].width / 2

			var_15_0 = Mathf.Min(var_15_0, var_15_2)
		end

		recthelper.setAnchorX(arg_15_0._transGraffitiContent, -var_15_0)
	end
end

function var_0_0.refreshJumpBtnShow(arg_16_0)
	local var_16_0 = -recthelper.getAnchorX(arg_16_0._transGraffitiContent)

	arg_16_0.curNeedUnlockItems = Activity161Model.instance:getItemsByState(Activity161Enum.graffitiState.ToUnlock)
	arg_16_0.jumpRightElementId = 0
	arg_16_0.jumpLeftElementId = 0

	for iter_16_0 = 1, #arg_16_0.curNeedUnlockItems do
		local var_16_1 = arg_16_0.curNeedUnlockItems[iter_16_0].id
		local var_16_2 = arg_16_0.picturesTab[var_16_1].anchorX - var_16_0

		if Mathf.Abs(var_16_2) > arg_16_0.screenWidth - arg_16_0.picturesTab[var_16_1].width / 3 and var_16_2 > 0 then
			arg_16_0.jumpRightElementId = arg_16_0.jumpRightElementId == 0 and var_16_1 or Mathf.Min(arg_16_0.jumpRightElementId, var_16_1)
		elseif Mathf.Abs(var_16_2) > arg_16_0.picturesTab[var_16_1].width * 2 / 3 and var_16_2 < 0 then
			arg_16_0.jumpLeftElementId = arg_16_0.jumpLeftElementId == 0 and var_16_1 or Mathf.Max(arg_16_0.jumpLeftElementId, var_16_1)
		end
	end

	gohelper.setActive(arg_16_0._btnleftjump.gameObject, arg_16_0.jumpLeftElementId ~= 0)
	gohelper.setActive(arg_16_0._btnrightjump.gameObject, arg_16_0.jumpRightElementId ~= 0)
end

function var_0_0.refreshReward(arg_17_0)
	local var_17_0, var_17_1 = Activity161Config.instance:getFinalReward(arg_17_0.actId)

	arg_17_0.finalRewardType = var_17_1[1]
	arg_17_0.finalRewardId = var_17_1[2]

	local var_17_2, var_17_3 = ItemModel.instance:getItemConfigAndIcon(arg_17_0.finalRewardType, arg_17_0.finalRewardId, true)

	arg_17_0._simagerewardicon:LoadImage(var_17_3)
	gohelper.setActive(arg_17_0._imagerewardrare.gameObject, var_17_2.rare > 0)

	arg_17_0._txtrewardnum.text = luaLang("multiple") .. var_17_1[3]

	local var_17_4 = Activity161Model.instance:getCurPaintedNum()
	local var_17_5 = Activity161Config.instance:getAllRewardCos(arg_17_0.actId)
	local var_17_6 = var_17_5[#var_17_5].paintedNum

	if var_17_4 == var_17_6 then
		arg_17_0._txtprogress.text = string.format("<color=#fe864c>%s/%s</color>", var_17_4, var_17_6)
	elseif var_17_4 == 0 then
		arg_17_0._txtprogress.text = string.format("%s/%s", var_17_4, var_17_6)
	else
		arg_17_0._txtprogress.text = string.format("<color=#fe864c>%s</color>/%s", var_17_4, var_17_6)
	end

	arg_17_0._imageprogress.fillAmount = var_17_4 / var_17_6
	arg_17_0._txtrewardState.text = Activity161Model.instance:getFinalRewardHasGetState() and luaLang("graffiti_rewardhasget") or luaLang("graffiti_rewardprogress")

	local var_17_7 = Activity161Model.instance:ishaveUnGetReward()

	gohelper.setActive(arg_17_0._goCangetEffect, false)
end

function var_0_0.getCurRewardCanGetStage(arg_18_0)
	local var_18_0 = 0
	local var_18_1 = GameUtil.getTabLen(Activity161Model.instance:getItemsByState(Activity161Enum.graffitiState.IsFinished))
	local var_18_2 = Activity161Config.instance:getAllRewardCos(arg_18_0.actId)

	for iter_18_0, iter_18_1 in pairs(var_18_2) do
		if var_18_1 >= iter_18_1.paintedNum then
			var_18_0 = iter_18_0
		end
	end

	return var_18_0
end

function var_0_0.refreshUnlockState(arg_19_0)
	local var_19_0 = PlayerPrefsHelper.getString(arg_19_0:getLocalKey(), "")
	local var_19_1 = {}

	if not string.nilorempty(var_19_0) then
		local var_19_2 = cjson.decode(var_19_0)

		for iter_19_0, iter_19_1 in ipairs(var_19_2) do
			local var_19_3 = string.split(iter_19_1, "|")
			local var_19_4 = tonumber(var_19_3[1])
			local var_19_5 = tonumber(var_19_3[2])

			arg_19_0.saveUnlockStateTab[var_19_4] = var_19_5
		end
	end

	for iter_19_2, iter_19_3 in pairs(arg_19_0.picturesTab) do
		if GameUtil.getTabLen(arg_19_0.saveUnlockStateTab) == 0 then
			iter_19_3.item:refreshUnlockState(false)
		else
			local var_19_6 = arg_19_0.saveUnlockStateTab[iter_19_2]

			iter_19_3.item:refreshUnlockState(var_19_6)
		end
	end

	arg_19_0:saveUnlockState()
end

function var_0_0.getLocalKey(arg_20_0)
	return "DungeonGraffitiUnlock" .. "#" .. tostring(arg_20_0.actId) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

function var_0_0.saveUnlockState(arg_21_0)
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in pairs(arg_21_0.unlockStateTab) do
		local var_21_1 = string.format("%s|%s", iter_21_0, iter_21_1)

		table.insert(var_21_0, var_21_1)
	end

	PlayerPrefsHelper.setString(arg_21_0:getLocalKey(), cjson.encode(var_21_0))
end

function var_0_0.onClose(arg_22_0)
	arg_22_0:saveUnlockState()
	TaskDispatcher.cancelTask(arg_22_0.showGetRewardEffect, arg_22_0)
	UIBlockMgr.instance:endBlock("GraffitiRewardViewPlayHasGetEffect")

	if arg_22_0.loader then
		arg_22_0.loader:dispose()

		arg_22_0.loader = nil
	end
end

function var_0_0.onDestroyView(arg_23_0)
	arg_23_0._simagerewardicon:UnLoadImage()
end

return var_0_0
