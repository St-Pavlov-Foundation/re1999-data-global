module("modules.logic.dungeon.view.rolestory.RoleStoryActivityChallengeView", package.seeall)

local var_0_0 = class("RoleStoryActivityChallengeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._challengeViewGO = gohelper.findChild(arg_1_0.viewGO, "challengeview")
	arg_1_0.simagemonster = gohelper.findChildSingleImage(arg_1_0._challengeViewGO, "BG/item/Root/#simage_Photo")
	arg_1_0.rewardBg = gohelper.findChildImage(arg_1_0._challengeViewGO, "Info/image_InfoBG2")
	arg_1_0.btnReward = gohelper.findChildButtonWithAudio(arg_1_0._challengeViewGO, "Info/btnReward")
	arg_1_0.simgaReward = gohelper.findChildSingleImage(arg_1_0._challengeViewGO, "Info/btnReward/#image_Reward")
	arg_1_0.txtRewardNum = gohelper.findChildTextMesh(arg_1_0._challengeViewGO, "Info/#txt_RewardNum")
	arg_1_0.goRewardRed = gohelper.findChild(arg_1_0._challengeViewGO, "Info/#go_Reddot")
	arg_1_0.goRewardCanGet = gohelper.findChild(arg_1_0._challengeViewGO, "Info/btnReward/canget")
	arg_1_0.goRewardHasGet = gohelper.findChild(arg_1_0._challengeViewGO, "Info/btnReward/hasget")
	arg_1_0.slider = gohelper.findChildSlider(arg_1_0._challengeViewGO, "Info/Slider")
	arg_1_0.txtProgress = gohelper.findChildTextMesh(arg_1_0._challengeViewGO, "Info/#txt_ScheduleNum")
	arg_1_0.btnStart = gohelper.findChildButtonWithAudio(arg_1_0._challengeViewGO, "#btn_start")
	arg_1_0.simageCost = gohelper.findChildSingleImage(arg_1_0._challengeViewGO, "#btn_start/#simage_icon")
	arg_1_0.txtCostNum = gohelper.findChildTextMesh(arg_1_0._challengeViewGO, "#btn_start/#simage_icon/#txt_num")
	arg_1_0.tipsBtn = gohelper.findChildButtonWithAudio(arg_1_0._challengeViewGO, "tipsbg/tips1/icon")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0.btnStart:AddClickListener(arg_2_0._btnstartOnClick, arg_2_0)
	arg_2_0.btnReward:AddClickListener(arg_2_0._btnrewardOnClick, arg_2_0)
	arg_2_0.tipsBtn:AddClickListener(arg_2_0._btntipsOnClick, arg_2_0)
	arg_2_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.ActStoryChange, arg_2_0._onStoryChange, arg_2_0)
	arg_2_0:addEventCb(RoleStoryController.instance, RoleStoryEvent.GetChallengeBonus, arg_2_0._onGetChallengeBonus, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0.btnStart:RemoveClickListener()
	arg_3_0.btnReward:RemoveClickListener()
	arg_3_0.tipsBtn:RemoveClickListener()
	arg_3_0:removeEventCb(RoleStoryController.instance, RoleStoryEvent.ActStoryChange, arg_3_0._onStoryChange, arg_3_0)
	arg_3_0:removeEventCb(RoleStoryController.instance, RoleStoryEvent.GetChallengeBonus, arg_3_0._onGetChallengeBonus, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0._btntipsOnClick(arg_5_0)
	ViewMgr.instance:openView(ViewName.RoleStoryTipView)
end

function var_0_0._btnstartOnClick(arg_6_0)
	if not arg_6_0.storyMo then
		return
	end

	local var_6_0 = arg_6_0.storyMo.cfg.episodeId
	local var_6_1 = DungeonConfig.instance:getEpisodeCO(var_6_0)
	local var_6_2 = GameUtil.splitString2(var_6_1.cost, true)
	local var_6_3 = 1
	local var_6_4 = {}

	for iter_6_0, iter_6_1 in ipairs(var_6_2) do
		table.insert(var_6_4, {
			type = iter_6_1[1],
			id = iter_6_1[2],
			quantity = iter_6_1[3] * var_6_3
		})
	end

	local var_6_5, var_6_6, var_6_7 = ItemModel.instance:hasEnoughItems(var_6_4)

	if not var_6_6 then
		if RoleStoryModel.instance:checkTodayCanExchange() then
			GameFacade.showToastWithIcon(ToastEnum.RoleStoryTickNoEnough1, var_6_7, var_6_5)
		else
			GameFacade.showToastWithIcon(ToastEnum.RoleStoryTickNoEnough2, var_6_7, var_6_5)
		end

		return
	end

	DungeonFightController.instance:enterFightByBattleId(var_6_1.chapterId, var_6_0, var_6_1.battleId)
end

function var_0_0._btnrewardOnClick(arg_7_0)
	if not arg_7_0.storyMo then
		return
	end

	if arg_7_0.storyMo.wave < arg_7_0.storyMo.maxWave or arg_7_0.storyMo.getChallengeReward then
		local var_7_0 = arg_7_0.storyMo.cfg.challengeBonus
		local var_7_1 = GameUtil.splitString2(var_7_0, true)[1]

		MaterialTipController.instance:showMaterialInfo(var_7_1[1], var_7_1[2])

		return
	end

	HeroStoryRpc.instance:sendGetChallengeBonusRequest()
end

function var_0_0.onUpdateParam(arg_8_0)
	return
end

function var_0_0.onOpen(arg_9_0)
	return
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0._onStoryChange(arg_11_0)
	arg_11_0:refreshView()
end

function var_0_0._onGetChallengeBonus(arg_12_0)
	arg_12_0:refreshProgress()
end

function var_0_0.refreshView(arg_13_0)
	arg_13_0.storyId = RoleStoryModel.instance:getCurActStoryId()
	arg_13_0.storyMo = RoleStoryModel.instance:getById(arg_13_0.storyId)

	if not arg_13_0.storyMo then
		return
	end

	arg_13_0:refreshItem()
	arg_13_0:refreshProgress()
	arg_13_0:refreshCost()
end

function var_0_0.refreshCost(arg_14_0)
	if not arg_14_0.storyMo then
		return
	end

	local var_14_0 = arg_14_0.storyMo.cfg.episodeId
	local var_14_1 = DungeonConfig.instance:getEpisodeCO(var_14_0)

	if not var_14_1 then
		return
	end

	local var_14_2 = GameUtil.splitString2(var_14_1.cost, true)[1]
	local var_14_3 = ItemModel.instance:getItemSmallIcon(var_14_2[2])

	arg_14_0.simageCost:LoadImage(var_14_3)

	arg_14_0.txtCostNum.text = string.format("-%s", var_14_2[3] or 0)
end

function var_0_0.refreshItem(arg_15_0)
	if not arg_15_0.storyMo then
		return
	end

	local var_15_0 = arg_15_0.storyMo.cfg.monster_pic
	local var_15_1 = string.format("singlebg/dungeon/rolestory_photo_singlebg/%s_1.png", var_15_0)

	arg_15_0.simagemonster:LoadImage(var_15_1)
end

function var_0_0.refreshProgress(arg_16_0)
	if not arg_16_0.storyMo then
		return
	end

	local var_16_0 = arg_16_0.storyMo.wave
	local var_16_1 = arg_16_0.storyMo.maxWave
	local var_16_2 = arg_16_0.storyMo.getChallengeReward

	if var_16_2 then
		var_16_0 = var_16_1
	end

	arg_16_0.txtProgress.text = string.format("<color=#c96635>%s</color>/%s", var_16_0, var_16_1)

	arg_16_0.slider:SetValue(var_16_0 / var_16_1)

	local var_16_3 = arg_16_0.storyMo.cfg.challengeBonus
	local var_16_4 = GameUtil.splitString2(var_16_3, true)[1]
	local var_16_5, var_16_6 = ItemModel.instance:getItemConfigAndIcon(var_16_4[1], var_16_4[2])

	UISpriteSetMgr.instance:setUiFBSprite(arg_16_0.rewardBg, "bg_pinjidi_" .. var_16_5.rare)
	arg_16_0.simgaReward:LoadImage(var_16_6)

	arg_16_0.txtRewardNum.text = tostring(var_16_4[3])

	gohelper.setActive(arg_16_0.goRewardRed, var_16_1 <= var_16_0 and not var_16_2)
	gohelper.setActive(arg_16_0.goRewardCanGet, var_16_1 <= var_16_0 and not var_16_2)
	gohelper.setActive(arg_16_0.goRewardHasGet, var_16_2)
end

function var_0_0.onDestroyView(arg_17_0)
	if arg_17_0.simagemonster then
		arg_17_0.simagemonster:UnLoadImage()
	end

	if arg_17_0.simageCost then
		arg_17_0.simageCost:UnLoadImage()
	end
end

return var_0_0
