module("modules.logic.dungeon.view.rolestory.RoleStoryActivityChallengeView", package.seeall)

slot0 = class("RoleStoryActivityChallengeView", BaseView)

function slot0.onInitView(slot0)
	slot0._challengeViewGO = gohelper.findChild(slot0.viewGO, "challengeview")
	slot0.simagemonster = gohelper.findChildSingleImage(slot0._challengeViewGO, "BG/item/Root/#simage_Photo")
	slot0.rewardBg = gohelper.findChildImage(slot0._challengeViewGO, "Info/image_InfoBG2")
	slot0.btnReward = gohelper.findChildButtonWithAudio(slot0._challengeViewGO, "Info/btnReward")
	slot0.simgaReward = gohelper.findChildSingleImage(slot0._challengeViewGO, "Info/btnReward/#image_Reward")
	slot0.txtRewardNum = gohelper.findChildTextMesh(slot0._challengeViewGO, "Info/#txt_RewardNum")
	slot0.goRewardRed = gohelper.findChild(slot0._challengeViewGO, "Info/#go_Reddot")
	slot0.goRewardCanGet = gohelper.findChild(slot0._challengeViewGO, "Info/btnReward/canget")
	slot0.goRewardHasGet = gohelper.findChild(slot0._challengeViewGO, "Info/btnReward/hasget")
	slot0.slider = gohelper.findChildSlider(slot0._challengeViewGO, "Info/Slider")
	slot0.txtProgress = gohelper.findChildTextMesh(slot0._challengeViewGO, "Info/#txt_ScheduleNum")
	slot0.btnStart = gohelper.findChildButtonWithAudio(slot0._challengeViewGO, "#btn_start")
	slot0.simageCost = gohelper.findChildSingleImage(slot0._challengeViewGO, "#btn_start/#simage_icon")
	slot0.txtCostNum = gohelper.findChildTextMesh(slot0._challengeViewGO, "#btn_start/#simage_icon/#txt_num")
	slot0.tipsBtn = gohelper.findChildButtonWithAudio(slot0._challengeViewGO, "tipsbg/tips1/icon")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0.btnStart:AddClickListener(slot0._btnstartOnClick, slot0)
	slot0.btnReward:AddClickListener(slot0._btnrewardOnClick, slot0)
	slot0.tipsBtn:AddClickListener(slot0._btntipsOnClick, slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.ActStoryChange, slot0._onStoryChange, slot0)
	slot0:addEventCb(RoleStoryController.instance, RoleStoryEvent.GetChallengeBonus, slot0._onGetChallengeBonus, slot0)
end

function slot0.removeEvents(slot0)
	slot0.btnStart:RemoveClickListener()
	slot0.btnReward:RemoveClickListener()
	slot0.tipsBtn:RemoveClickListener()
	slot0:removeEventCb(RoleStoryController.instance, RoleStoryEvent.ActStoryChange, slot0._onStoryChange, slot0)
	slot0:removeEventCb(RoleStoryController.instance, RoleStoryEvent.GetChallengeBonus, slot0._onGetChallengeBonus, slot0)
end

function slot0._editableInitView(slot0)
end

function slot0._btntipsOnClick(slot0)
	ViewMgr.instance:openView(ViewName.RoleStoryTipView)
end

function slot0._btnstartOnClick(slot0)
	if not slot0.storyMo then
		return
	end

	slot5 = {}

	for slot9, slot10 in ipairs(GameUtil.splitString2(DungeonConfig.instance:getEpisodeCO(slot0.storyMo.cfg.episodeId).cost, true)) do
		table.insert(slot5, {
			type = slot10[1],
			id = slot10[2],
			quantity = slot10[3] * 1
		})
	end

	slot6, slot7, slot8 = ItemModel.instance:hasEnoughItems(slot5)

	if not slot7 then
		if RoleStoryModel.instance:checkTodayCanExchange() then
			GameFacade.showToastWithIcon(ToastEnum.RoleStoryTickNoEnough1, slot8, slot6)
		else
			GameFacade.showToastWithIcon(ToastEnum.RoleStoryTickNoEnough2, slot8, slot6)
		end

		return
	end

	DungeonFightController.instance:enterFightByBattleId(slot2.chapterId, slot1, slot2.battleId)
end

function slot0._btnrewardOnClick(slot0)
	if not slot0.storyMo then
		return
	end

	if slot0.storyMo.wave < slot0.storyMo.maxWave or slot0.storyMo.getChallengeReward then
		slot3 = GameUtil.splitString2(slot0.storyMo.cfg.challengeBonus, true)[1]

		MaterialTipController.instance:showMaterialInfo(slot3[1], slot3[2])

		return
	end

	HeroStoryRpc.instance:sendGetChallengeBonusRequest()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
end

function slot0.onClose(slot0)
end

function slot0._onStoryChange(slot0)
	slot0:refreshView()
end

function slot0._onGetChallengeBonus(slot0)
	slot0:refreshProgress()
end

function slot0.refreshView(slot0)
	slot0.storyId = RoleStoryModel.instance:getCurActStoryId()
	slot0.storyMo = RoleStoryModel.instance:getById(slot0.storyId)

	if not slot0.storyMo then
		return
	end

	slot0:refreshItem()
	slot0:refreshProgress()
	slot0:refreshCost()
end

function slot0.refreshCost(slot0)
	if not slot0.storyMo then
		return
	end

	if not DungeonConfig.instance:getEpisodeCO(slot0.storyMo.cfg.episodeId) then
		return
	end

	slot4 = GameUtil.splitString2(slot2.cost, true)[1]

	slot0.simageCost:LoadImage(ItemModel.instance:getItemSmallIcon(slot4[2]))

	slot0.txtCostNum.text = string.format("-%s", slot4[3] or 0)
end

function slot0.refreshItem(slot0)
	if not slot0.storyMo then
		return
	end

	slot0.simagemonster:LoadImage(string.format("singlebg/dungeon/rolestory_photo_singlebg/%s_1.png", slot0.storyMo.cfg.monster_pic))
end

function slot0.refreshProgress(slot0)
	if not slot0.storyMo then
		return
	end

	slot1 = slot0.storyMo.wave
	slot2 = slot0.storyMo.maxWave

	if slot0.storyMo.getChallengeReward then
		slot1 = slot2
	end

	slot0.txtProgress.text = string.format("<color=#c96635>%s</color>/%s", slot1, slot2)

	slot0.slider:SetValue(slot1 / slot2)

	slot6 = GameUtil.splitString2(slot0.storyMo.cfg.challengeBonus, true)[1]
	slot7, slot8 = ItemModel.instance:getItemConfigAndIcon(slot6[1], slot6[2])

	UISpriteSetMgr.instance:setUiFBSprite(slot0.rewardBg, "bg_pinjidi_" .. slot7.rare)
	slot0.simgaReward:LoadImage(slot8)

	slot0.txtRewardNum.text = tostring(slot6[3])

	gohelper.setActive(slot0.goRewardRed, slot2 <= slot1 and not slot3)
	gohelper.setActive(slot0.goRewardCanGet, slot2 <= slot1 and not slot3)
	gohelper.setActive(slot0.goRewardHasGet, slot3)
end

function slot0.onDestroyView(slot0)
	if slot0.simagemonster then
		slot0.simagemonster:UnLoadImage()
	end

	if slot0.simageCost then
		slot0.simageCost:UnLoadImage()
	end
end

return slot0
