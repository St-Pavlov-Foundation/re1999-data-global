module("modules.logic.versionactivity1_5.aizila.view.AiZiLaEpsiodeDetailView", package.seeall)

local var_0_0 = class("AiZiLaEpsiodeDetailView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._simagePanelBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "LevelPanel/#simage_PanelBG")
	arg_1_0._txtTitleNum = gohelper.findChildText(arg_1_0.viewGO, "LevelPanel/#txt_TitleNum")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "LevelPanel/#txt_Title")
	arg_1_0._simageLevelPic = gohelper.findChildSingleImage(arg_1_0.viewGO, "LevelPanel/#simage_LevelPic")
	arg_1_0._scrollDescr = gohelper.findChildScrollRect(arg_1_0.viewGO, "LevelPanel/#scroll_Descr")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "LevelPanel/#scroll_Descr/Viewport/Content/#txt_Descr")
	arg_1_0._simagePanelBGMask = gohelper.findChildSingleImage(arg_1_0.viewGO, "LevelPanel/#simage_PanelBGMask")
	arg_1_0._scrollrewards = gohelper.findChildScrollRect(arg_1_0.viewGO, "LevelPanel/Reward/#scroll_rewards")
	arg_1_0._gorewards = gohelper.findChild(arg_1_0.viewGO, "LevelPanel/Reward/#scroll_rewards/Viewport/#go_rewards")
	arg_1_0._btnStart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "LevelPanel/Reward/Btn/#btn_Start")
	arg_1_0._gotarget = gohelper.findChild(arg_1_0.viewGO, "LevelPanel/#go_target")
	arg_1_0._gotargetItem = gohelper.findChild(arg_1_0.viewGO, "LevelPanel/#go_target/#go_targetItem")
	arg_1_0._goTargetSelect = gohelper.findChild(arg_1_0.viewGO, "LevelPanel/#go_target/#go_targetItem/#go_TargetSelect")
	arg_1_0._txttargetName = gohelper.findChildText(arg_1_0.viewGO, "LevelPanel/#go_target/#go_targetItem/target/#txt_targetName")
	arg_1_0._txttergetHeight = gohelper.findChildText(arg_1_0.viewGO, "LevelPanel/#go_target/#go_targetItem/target/#txt_tergetHeight")
	arg_1_0._goBackBtns = gohelper.findChild(arg_1_0.viewGO, "#go_BackBtns")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnStart:AddClickListener(arg_2_0._btnStartOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnStart:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnStartOnClick(arg_5_0)
	if arg_5_0._episodeCfg then
		arg_5_0:playViewAnimator("go")
		AiZiLaGameController.instance:enterGame(arg_5_0._episodeCfg.episodeId)
	end
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._animator = arg_6_0.viewGO:GetComponent(AiZiLaEnum.ComponentType.Animator)
	arg_6_0._targetTbList = {
		arg_6_0:_createTargetTB(arg_6_0._gotargetItem)
	}

	for iter_6_0 = #arg_6_0._targetTbList + 1, 3 do
		local var_6_0 = gohelper.cloneInPlace(arg_6_0._gotargetItem)

		table.insert(arg_6_0._targetTbList, arg_6_0:_createTargetTB(var_6_0))
	end

	arg_6_0._goodsItemGo = arg_6_0:getResInst(AiZiLaGoodsItem.prefabPath, arg_6_0.viewGO)

	gohelper.setActive(arg_6_0._goodsItemGo, false)
end

function var_0_0.onUpdateParam(arg_7_0)
	return
end

function var_0_0.playViewAnimator(arg_8_0, arg_8_1)
	if arg_8_0._animator then
		arg_8_0._animator.enabled = true

		arg_8_0._animator:Play(arg_8_1, 0, 0)
	end
end

function var_0_0.onOpen(arg_9_0)
	if arg_9_0.viewContainer then
		NavigateMgr.instance:addEscape(arg_9_0.viewContainer.viewName, arg_9_0._btncloseOnClick, arg_9_0)
	end

	local var_9_0 = arg_9_0.viewParam.episodeId
	local var_9_1 = arg_9_0.viewParam.actId

	arg_9_0._episodeCfg = AiZiLaConfig.instance:getEpisodeCo(var_9_1, var_9_0)

	if arg_9_0._episodeCfg then
		arg_9_0._simageFullBG:LoadImage(string.format("%s.png", arg_9_0._episodeCfg.bgPath))
		arg_9_0._simageLevelPic:LoadImage(string.format("%s.png", arg_9_0._episodeCfg.picture))

		arg_9_0._rewardDataList = AiZiLaHelper.getEpisodeReward(arg_9_0._episodeCfg.showBonus)
	end

	arg_9_0._rewardDataList = arg_9_0._rewardDataList or {}

	arg_9_0:refreshUI()
	AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.ui_wulu_aizila_level_open)
end

function var_0_0.onClose(arg_10_0)
	return
end

function var_0_0.onDestroyView(arg_11_0)
	arg_11_0._simageFullBG:UnLoadImage()
	arg_11_0._simageLevelPic:UnLoadImage()
end

function var_0_0.refreshUI(arg_12_0)
	if arg_12_0._episodeCfg then
		arg_12_0._txtTitleNum.text = arg_12_0._episodeCfg.nameen
		arg_12_0._txtTitle.text = arg_12_0._episodeCfg.name
		arg_12_0._txtDescr.text = arg_12_0._episodeCfg.desc
	end

	gohelper.CreateObjList(arg_12_0, arg_12_0._onShowRewardItem, arg_12_0._rewardDataList, arg_12_0._gorewards, arg_12_0._goodsItemGo, AiZiLaGoodsItem)
	arg_12_0:_refreshTargetTB()
end

function var_0_0._onShowRewardItem(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_1:setShowCount(false)
	arg_13_1:onUpdateMO(arg_13_2)
end

function var_0_0._createTargetTB(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:getUserDataTb_()

	var_14_0.go = arg_14_1
	var_14_0._goTargetSelect = gohelper.findChild(arg_14_1, "#go_TargetSelect")
	var_14_0._txttargetName = gohelper.findChildText(arg_14_1, "target/#txt_targetName")
	var_14_0._txttergetHeight = gohelper.findChildText(arg_14_1, "target/#txt_tergetHeight")

	return var_14_0
end

function var_0_0._updateTargetTB(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	if arg_15_1.targetId ~= arg_15_2 then
		arg_15_1.targetId = arg_15_2

		local var_15_0 = AiZiLaConfig.instance:getEpisodeShowTargetCo(arg_15_1.targetId)

		gohelper.setActive(arg_15_1.go, var_15_0)

		if var_15_0 then
			arg_15_1._txttargetName.text = var_15_0.name
			arg_15_1._txttergetHeight.text = string.format("%sm", var_15_0.elevation)

			SLFramework.UGUI.GuiHelper.SetColor(arg_15_1._txttargetName, var_15_0.colorStr)
			SLFramework.UGUI.GuiHelper.SetColor(arg_15_1._txttergetHeight, var_15_0.colorStr)
		end
	end
end

function var_0_0._refreshTargetTB(arg_16_0)
	local var_16_0 = arg_16_0._episodeCfg and string.splitToNumber(arg_16_0._episodeCfg.showTargets, "|")

	for iter_16_0 = 1, #arg_16_0._targetTbList do
		local var_16_1 = arg_16_0._targetTbList[iter_16_0]
		local var_16_2 = var_16_0 and var_16_0[iter_16_0]

		arg_16_0:_updateTargetTB(var_16_1, var_16_2)
	end
end

return var_0_0
