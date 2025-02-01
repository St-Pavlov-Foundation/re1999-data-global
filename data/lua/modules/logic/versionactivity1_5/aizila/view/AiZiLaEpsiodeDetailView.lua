module("modules.logic.versionactivity1_5.aizila.view.AiZiLaEpsiodeDetailView", package.seeall)

slot0 = class("AiZiLaEpsiodeDetailView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageFullBG = gohelper.findChildSingleImage(slot0.viewGO, "#simage_FullBG")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._simagePanelBG = gohelper.findChildSingleImage(slot0.viewGO, "LevelPanel/#simage_PanelBG")
	slot0._txtTitleNum = gohelper.findChildText(slot0.viewGO, "LevelPanel/#txt_TitleNum")
	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "LevelPanel/#txt_Title")
	slot0._simageLevelPic = gohelper.findChildSingleImage(slot0.viewGO, "LevelPanel/#simage_LevelPic")
	slot0._scrollDescr = gohelper.findChildScrollRect(slot0.viewGO, "LevelPanel/#scroll_Descr")
	slot0._txtDescr = gohelper.findChildText(slot0.viewGO, "LevelPanel/#scroll_Descr/Viewport/Content/#txt_Descr")
	slot0._simagePanelBGMask = gohelper.findChildSingleImage(slot0.viewGO, "LevelPanel/#simage_PanelBGMask")
	slot0._scrollrewards = gohelper.findChildScrollRect(slot0.viewGO, "LevelPanel/Reward/#scroll_rewards")
	slot0._gorewards = gohelper.findChild(slot0.viewGO, "LevelPanel/Reward/#scroll_rewards/Viewport/#go_rewards")
	slot0._btnStart = gohelper.findChildButtonWithAudio(slot0.viewGO, "LevelPanel/Reward/Btn/#btn_Start")
	slot0._gotarget = gohelper.findChild(slot0.viewGO, "LevelPanel/#go_target")
	slot0._gotargetItem = gohelper.findChild(slot0.viewGO, "LevelPanel/#go_target/#go_targetItem")
	slot0._goTargetSelect = gohelper.findChild(slot0.viewGO, "LevelPanel/#go_target/#go_targetItem/#go_TargetSelect")
	slot0._txttargetName = gohelper.findChildText(slot0.viewGO, "LevelPanel/#go_target/#go_targetItem/target/#txt_targetName")
	slot0._txttergetHeight = gohelper.findChildText(slot0.viewGO, "LevelPanel/#go_target/#go_targetItem/target/#txt_tergetHeight")
	slot0._goBackBtns = gohelper.findChild(slot0.viewGO, "#go_BackBtns")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnStart:AddClickListener(slot0._btnStartOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
	slot0._btnStart:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnStartOnClick(slot0)
	if slot0._episodeCfg then
		slot0:playViewAnimator("go")
		AiZiLaGameController.instance:enterGame(slot0._episodeCfg.episodeId)
	end
end

function slot0._editableInitView(slot0)
	slot0._animator = slot0.viewGO:GetComponent(AiZiLaEnum.ComponentType.Animator)
	slot4 = slot0._gotargetItem
	slot0._targetTbList = {
		slot0:_createTargetTB(slot4)
	}

	for slot4 = #slot0._targetTbList + 1, 3 do
		table.insert(slot0._targetTbList, slot0:_createTargetTB(gohelper.cloneInPlace(slot0._gotargetItem)))
	end

	slot0._goodsItemGo = slot0:getResInst(AiZiLaGoodsItem.prefabPath, slot0.viewGO)

	gohelper.setActive(slot0._goodsItemGo, false)
end

function slot0.onUpdateParam(slot0)
end

function slot0.playViewAnimator(slot0, slot1)
	if slot0._animator then
		slot0._animator.enabled = true

		slot0._animator:Play(slot1, 0, 0)
	end
end

function slot0.onOpen(slot0)
	if slot0.viewContainer then
		NavigateMgr.instance:addEscape(slot0.viewContainer.viewName, slot0._btncloseOnClick, slot0)
	end

	slot0._episodeCfg = AiZiLaConfig.instance:getEpisodeCo(slot0.viewParam.actId, slot0.viewParam.episodeId)

	if slot0._episodeCfg then
		slot0._simageFullBG:LoadImage(string.format("%s.png", slot0._episodeCfg.bgPath))
		slot0._simageLevelPic:LoadImage(string.format("%s.png", slot0._episodeCfg.picture))

		slot0._rewardDataList = AiZiLaHelper.getEpisodeReward(slot0._episodeCfg.showBonus)
	end

	slot0._rewardDataList = slot0._rewardDataList or {}

	slot0:refreshUI()
	AudioMgr.instance:trigger(AudioEnum.V1a5AiZiLa.ui_wulu_aizila_level_open)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simageFullBG:UnLoadImage()
	slot0._simageLevelPic:UnLoadImage()
end

function slot0.refreshUI(slot0)
	if slot0._episodeCfg then
		slot0._txtTitleNum.text = slot0._episodeCfg.nameen
		slot0._txtTitle.text = slot0._episodeCfg.name
		slot0._txtDescr.text = slot0._episodeCfg.desc
	end

	gohelper.CreateObjList(slot0, slot0._onShowRewardItem, slot0._rewardDataList, slot0._gorewards, slot0._goodsItemGo, AiZiLaGoodsItem)
	slot0:_refreshTargetTB()
end

function slot0._onShowRewardItem(slot0, slot1, slot2, slot3)
	slot1:setShowCount(false)
	slot1:onUpdateMO(slot2)
end

function slot0._createTargetTB(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.go = slot1
	slot2._goTargetSelect = gohelper.findChild(slot1, "#go_TargetSelect")
	slot2._txttargetName = gohelper.findChildText(slot1, "target/#txt_targetName")
	slot2._txttergetHeight = gohelper.findChildText(slot1, "target/#txt_tergetHeight")

	return slot2
end

function slot0._updateTargetTB(slot0, slot1, slot2, slot3)
	if slot1.targetId ~= slot2 then
		slot1.targetId = slot2
		slot4 = AiZiLaConfig.instance:getEpisodeShowTargetCo(slot1.targetId)

		gohelper.setActive(slot1.go, slot4)

		if slot4 then
			slot1._txttargetName.text = slot4.name
			slot1._txttergetHeight.text = string.format("%sm", slot4.elevation)

			SLFramework.UGUI.GuiHelper.SetColor(slot1._txttargetName, slot4.colorStr)
			SLFramework.UGUI.GuiHelper.SetColor(slot1._txttergetHeight, slot4.colorStr)
		end
	end
end

function slot0._refreshTargetTB(slot0)
	slot1 = slot0._episodeCfg and string.splitToNumber(slot0._episodeCfg.showTargets, "|")

	for slot5 = 1, #slot0._targetTbList do
		slot0:_updateTargetTB(slot0._targetTbList[slot5], slot1 and slot1[slot5])
	end
end

return slot0
