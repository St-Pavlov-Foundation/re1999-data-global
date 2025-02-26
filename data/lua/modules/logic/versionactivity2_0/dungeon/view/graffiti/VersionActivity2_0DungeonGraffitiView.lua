module("modules.logic.versionactivity2_0.dungeon.view.graffiti.VersionActivity2_0DungeonGraffitiView", package.seeall)

slot0 = class("VersionActivity2_0DungeonGraffitiView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg")
	slot0._scrollgraffiti = gohelper.findChildScrollRect(slot0.viewGO, "#scroll_graffiti")
	slot0._gograffitiContent = gohelper.findChild(slot0.viewGO, "#scroll_graffiti/Viewport/#go_graffitiContent")
	slot0._btnreward = gohelper.findChildButtonWithAudio(slot0.viewGO, "rewardInfo/#btn_reward")
	slot0._txtrewardState = gohelper.findChildText(slot0.viewGO, "rewardInfo/#btn_reward/#txt_rewardstate")
	slot0._btnrewardIcon = gohelper.findChildButtonWithAudio(slot0.viewGO, "rewardInfo/finalreward/#btn_rewardicon")
	slot0._imagerewardrare = gohelper.findChildImage(slot0.viewGO, "rewardInfo/finalreward/#image_rewardrare")
	slot0._simagerewardicon = gohelper.findChildSingleImage(slot0.viewGO, "rewardInfo/finalreward/#simage_rewardicon")
	slot0._txtrewardnum = gohelper.findChildText(slot0.viewGO, "rewardInfo/finalreward/#txt_rewardnum")
	slot0._gorewardhasget = gohelper.findChild(slot0.viewGO, "rewardInfo/finalreward/#go_rewardhasget")
	slot0._imageprogress = gohelper.findChildImage(slot0.viewGO, "rewardInfo/#btn_reward/progressbar/#image_progress")
	slot0._txtprogress = gohelper.findChildText(slot0.viewGO, "rewardInfo/#btn_reward/#txt_progress")
	slot0._btnrightjump = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_rightjump")
	slot0._btnleftjump = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_leftjump")
	slot0._gorewardwindow = gohelper.findChild(slot0.viewGO, "#go_rewardwindow")
	slot0._gorewardReddot = gohelper.findChild(slot0.viewGO, "rewardInfo/#btn_reward/#go_RedDot")
	slot0._goCangetEffect = gohelper.findChild(slot0.viewGO, "rewardInfo/finalreward/#receive")
	slot0._goCloseRewardWindow = gohelper.findChild(slot0.viewGO, "#go_rewardwindow/#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnreward:AddClickListener(slot0._btnrewardOnClick, slot0)
	slot0._btnrewardIcon:AddClickListener(slot0._btnrewardIconOnClick, slot0)
	slot0._btnrightjump:AddClickListener(slot0._btnrightjumpOnClick, slot0)
	slot0._btnleftjump:AddClickListener(slot0._btnleftjumpOnClick, slot0)
	slot0._scrollgraffiti:AddOnValueChanged(slot0.refreshJumpBtnShow, slot0)
	slot0:addEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, slot0.refreshUI, slot0)
	slot0:addEventCb(Activity161Controller.instance, Activity161Event.RefreshGraffitiView, slot0.refreshUI, slot0)
	slot0:addEventCb(Activity161Controller.instance, Activity161Event.GetGraffitiReward, slot0.refreshReward, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnreward:RemoveClickListener()
	slot0._btnrewardIcon:RemoveClickListener()
	slot0._btnrightjump:RemoveClickListener()
	slot0._btnleftjump:RemoveClickListener()
	slot0._scrollgraffiti:RemoveOnValueChanged()
	slot0:removeEventCb(DungeonController.instance, DungeonEvent.OnRemoveElement, slot0.refreshUI, slot0)
	slot0:removeEventCb(Activity161Controller.instance, Activity161Event.RefreshGraffitiView, slot0.refreshUI, slot0)
	slot0:removeEventCb(Activity161Controller.instance, Activity161Event.GetGraffitiReward, slot0.refreshReward, slot0)
end

slot0.clickLeftJump = 0
slot0.clickRightJump = 1

function slot0._btnrewardOnClick(slot0)
	gohelper.setActive(slot0._gorewardwindow, true)
	gohelper.setActive(slot0._goCloseRewardWindow, true)

	slot0.ishaveUnGetReward, slot0.canGetRewardList = Activity161Model.instance:ishaveUnGetReward()

	if slot0.ishaveUnGetReward then
		TaskDispatcher.runDelay(slot0.showGetRewardEffect, slot0, 0.5)
		UIBlockMgr.instance:startBlock("GraffitiRewardViewPlayHasGetEffect")
	end
end

function slot0.showGetRewardEffect(slot0)
	Activity161Controller.instance:dispatchEvent(Activity161Event.PlayGraffitiRewardGetAnim, slot0.canGetRewardList)
end

function slot0._btnrewardIconOnClick(slot0)
end

function slot0._btnrightjumpOnClick(slot0)
	slot0:moveToNeedUnlockPicture(uv0.clickRightJump)
end

function slot0._btnleftjumpOnClick(slot0)
	slot0:moveToNeedUnlockPicture(uv0.clickLeftJump)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._btnleftjump.gameObject, false)
	gohelper.setActive(slot0._btnrightjump.gameObject, false)

	slot0.screenWidth = gohelper.getUIScreenWidth()
	slot0._transGraffitiContent = slot0._gograffitiContent:GetComponent(gohelper.Type_RectTransform)
	slot0.scrollGraffitiRect = slot0._scrollgraffiti.gameObject:GetComponent(typeof(UnityEngine.UI.ScrollRect))
	slot0._contentWidth = recthelper.getWidth(slot0._transGraffitiContent)
	slot0.maxScrollPos = slot0._contentWidth - slot0.screenWidth
	slot0.jumpLeftElementId = 0
	slot0.jumpRightElementId = 0
	slot0.graffitiItemPath = slot0.viewContainer:getSetting().otherRes[1]
	slot0.unlockStateTab = slot0:getUserDataTb_()
	slot0.saveUnlockStateTab = slot0:getUserDataTb_()
	slot0.materialTab = slot0:getUserDataTb_()
	slot0.picturesTab = slot0:getUserDataTb_()

	RedDotController.instance:addRedDot(slot0._gorewardReddot, RedDotEnum.DotNode.V2a0GraffitiReward, Activity161Model.instance:getActId())
end

function slot0.onOpen(slot0)
	slot0.actId = slot0.viewParam.actId
	slot0.graffitiCount = Activity161Config.instance:getGraffitiCount(slot0.actId)

	slot0:loadGraffitiMaterial()
	slot0:refreshUI()
	slot0:refreshUnlockState()
	slot0:moveToFirstCanDrawGraffiti()
end

function slot0.loadGraffitiMaterial(slot0)
	table.insert(slot0.materialTab, slot0.viewContainer:getRes(slot0.viewContainer:getSetting().otherRes[2]))
	table.insert(slot0.materialTab, slot0.viewContainer:getRes(slot0.viewContainer:getSetting().otherRes[3]))
end

function slot0.refreshUI(slot0)
	slot0:initPictures()
	slot0:refreshReward()
	slot0:refreshJumpBtnShow()
end

function slot0.initPictures(slot0)
	for slot5, slot6 in pairs(Activity161Config.instance.graffitiPicList) do
		if not slot0.picturesTab[slot6.elementId] then
			slot7 = {
				go = gohelper.findChild(slot0.viewGO, "#scroll_graffiti/Viewport/#go_graffitiContent/#go_picture" .. slot5)
			}
			slot7.itemGO = slot0.viewContainer:getResInst(slot0.graffitiItemPath, slot7.go)
			slot7.item = MonoHelper.addNoUpdateLuaComOnceToGo(slot7.itemGO, VersionActivity2_0DungeonGraffitiItem)
			slot7.rect = slot7.go:GetComponent(gohelper.Type_RectTransform)
			slot7.width = recthelper.getWidth(slot7.rect)
			slot7.anchorX = recthelper.getAnchorX(slot7.rect)
			slot7.config = slot6
			slot7.index = slot5
			slot0.picturesTab[slot6.elementId] = slot7

			slot7.item:initData(slot0.actId, slot6.elementId, slot0.materialTab)
		end

		slot7.mo = Activity161Model.instance.graffitiInfoMap[slot6.elementId]
		slot0.unlockStateTab[slot6.elementId] = Activity161Model.instance:isUnlockState(slot7.mo)

		slot7.item:refreshItem()
	end
end

function slot0.moveToNeedUnlockPicture(slot0, slot1)
	if slot1 == uv0.clickRightJump then
		recthelper.setAnchorX(slot0._transGraffitiContent, -Mathf.Min(slot0.maxScrollPos, slot0.picturesTab[slot0.jumpRightElementId].anchorX + slot0.picturesTab[slot0.jumpRightElementId].width / 2 - slot0.screenWidth / 2))
	else
		recthelper.setAnchorX(slot0._transGraffitiContent, -Mathf.Max(0, slot0.picturesTab[slot0.jumpLeftElementId].anchorX + slot0.picturesTab[slot0.jumpLeftElementId].width / 2 - slot0.screenWidth / 2))
	end

	slot0.scrollGraffitiRect.velocity = Vector2(0, 0)
end

function slot0.moveToFirstCanDrawGraffiti(slot0)
	slot0.curCanDrawItems = Activity161Model.instance:getItemsByState(Activity161Enum.graffitiState.Normal)

	if #slot0.curCanDrawItems > 0 then
		for slot5 = 1, #slot0.curCanDrawItems do
			slot6 = slot0.curCanDrawItems[slot5].id
			slot1 = Mathf.Min(slot0.maxScrollPos, slot0.picturesTab[slot6].anchorX - slot0.screenWidth / 2 + slot0.picturesTab[slot6].width / 2)
		end

		recthelper.setAnchorX(slot0._transGraffitiContent, -slot1)
	end
end

function slot0.refreshJumpBtnShow(slot0)
	slot0.curNeedUnlockItems = Activity161Model.instance:getItemsByState(Activity161Enum.graffitiState.ToUnlock)
	slot0.jumpRightElementId = 0
	slot0.jumpLeftElementId = 0

	for slot5 = 1, #slot0.curNeedUnlockItems do
		slot6 = slot0.curNeedUnlockItems[slot5].id

		if Mathf.Abs(slot0.picturesTab[slot6].anchorX - -recthelper.getAnchorX(slot0._transGraffitiContent)) > slot0.screenWidth - slot0.picturesTab[slot6].width / 3 and slot7 > 0 then
			slot0.jumpRightElementId = slot0.jumpRightElementId == 0 and slot6 or Mathf.Min(slot0.jumpRightElementId, slot6)
		elseif Mathf.Abs(slot7) > slot0.picturesTab[slot6].width * 2 / 3 and slot7 < 0 then
			slot0.jumpLeftElementId = slot0.jumpLeftElementId == 0 and slot6 or Mathf.Max(slot0.jumpLeftElementId, slot6)
		end
	end

	gohelper.setActive(slot0._btnleftjump.gameObject, slot0.jumpLeftElementId ~= 0)
	gohelper.setActive(slot0._btnrightjump.gameObject, slot0.jumpRightElementId ~= 0)
end

function slot0.refreshReward(slot0)
	slot1, slot2 = Activity161Config.instance:getFinalReward(slot0.actId)
	slot0.finalRewardType = slot2[1]
	slot0.finalRewardId = slot2[2]
	slot3, slot4 = ItemModel.instance:getItemConfigAndIcon(slot0.finalRewardType, slot0.finalRewardId, true)

	slot0._simagerewardicon:LoadImage(slot4)
	gohelper.setActive(slot0._imagerewardrare.gameObject, slot3.rare > 0)

	slot0._txtrewardnum.text = luaLang("multiple") .. slot2[3]
	slot6 = Activity161Config.instance:getAllRewardCos(slot0.actId)

	if Activity161Model.instance:getCurPaintedNum() == slot6[#slot6].paintedNum then
		slot0._txtprogress.text = string.format("<color=#fe864c>%s/%s</color>", slot5, slot7)
	elseif slot5 == 0 then
		slot0._txtprogress.text = string.format("%s/%s", slot5, slot7)
	else
		slot0._txtprogress.text = string.format("<color=#fe864c>%s</color>/%s", slot5, slot7)
	end

	slot0._imageprogress.fillAmount = slot5 / slot7
	slot0._txtrewardState.text = Activity161Model.instance:getFinalRewardHasGetState() and luaLang("graffiti_rewardhasget") or luaLang("graffiti_rewardprogress")
	slot8 = Activity161Model.instance:ishaveUnGetReward()

	gohelper.setActive(slot0._goCangetEffect, false)
end

function slot0.getCurRewardCanGetStage(slot0)
	slot1 = 0

	for slot7, slot8 in pairs(Activity161Config.instance:getAllRewardCos(slot0.actId)) do
		if slot8.paintedNum <= GameUtil.getTabLen(Activity161Model.instance:getItemsByState(Activity161Enum.graffitiState.IsFinished)) then
			slot1 = slot7
		end
	end

	return slot1
end

function slot0.refreshUnlockState(slot0)
	slot2 = {}

	if not string.nilorempty(PlayerPrefsHelper.getString(slot0:getLocalKey(), "")) then
		for slot6, slot7 in ipairs(cjson.decode(slot1)) do
			slot8 = string.split(slot7, "|")
			slot0.saveUnlockStateTab[tonumber(slot8[1])] = tonumber(slot8[2])
		end
	end

	for slot6, slot7 in pairs(slot0.picturesTab) do
		if GameUtil.getTabLen(slot0.saveUnlockStateTab) == 0 then
			slot7.item:refreshUnlockState(false)
		else
			slot7.item:refreshUnlockState(slot0.saveUnlockStateTab[slot6])
		end
	end

	slot0:saveUnlockState()
end

function slot0.getLocalKey(slot0)
	return "DungeonGraffitiUnlock" .. "#" .. tostring(slot0.actId) .. "#" .. tostring(PlayerModel.instance:getPlayinfo().userId)
end

function slot0.saveUnlockState(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0.unlockStateTab) do
		table.insert(slot1, string.format("%s|%s", slot5, slot6))
	end

	PlayerPrefsHelper.setString(slot0:getLocalKey(), cjson.encode(slot1))
end

function slot0.onClose(slot0)
	slot0:saveUnlockState()
	TaskDispatcher.cancelTask(slot0.showGetRewardEffect, slot0)
	UIBlockMgr.instance:endBlock("GraffitiRewardViewPlayHasGetEffect")

	if slot0.loader then
		slot0.loader:dispose()

		slot0.loader = nil
	end
end

function slot0.onDestroyView(slot0)
	slot0._simagerewardicon:UnLoadImage()
end

return slot0
