module("modules.logic.tower.view.permanenttower.TowerPermanentView", package.seeall)

slot0 = class("TowerPermanentView", BaseView)

function slot0.onInitView(slot0)
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")
	slot0._scrollcategory = gohelper.findChildScrollRect(slot0.viewGO, "Left/#scroll_category")
	slot0._goViewport = gohelper.findChild(slot0.viewGO, "Left/#scroll_category/Viewport")
	slot0._goContent = gohelper.findChild(slot0.viewGO, "Left/#scroll_category/Viewport/#go_Content")
	slot0._goStageInfo = gohelper.findChild(slot0.viewGO, "Left/#go_stageInfo")
	slot0._txtCurStage = gohelper.findChildText(slot0.viewGO, "Left/#go_stageInfo/#txt_curStage")
	slot0._btnCurStageFold = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#go_stageInfo/#btn_curStageFold")
	slot0._gonormalEpisode = gohelper.findChild(slot0.viewGO, "episode/#go_normalEpisode")
	slot0._gonormalItem = gohelper.findChild(slot0.viewGO, "episode/#go_normalEpisode/#go_normalItem")
	slot0._goeliteEpisode = gohelper.findChild(slot0.viewGO, "episode/#go_eliteEpisode")
	slot0._gocompleted = gohelper.findChild(slot0.viewGO, "episode/layout/#go_completed")
	slot0._animCompleted = slot0._gocompleted:GetComponent(gohelper.Type_Animator)
	slot0._goschedule = gohelper.findChild(slot0.viewGO, "episode/layout/#go_schedule")
	slot0._txtschedule = gohelper.findChildText(slot0.viewGO, "episode/layout/#go_schedule/bg/#txt_Schedule")
	slot0._goreward = gohelper.findChild(slot0.viewGO, "#go_reward")
	slot0._gorewardItem = gohelper.findChild(slot0.viewGO, "#go_reward/#go_rewardItem")
	slot0._simageEnterBg = gohelper.findChildSingleImage(slot0.viewGO, "#go_Enter/#simage_EnterBG")
	slot0._txtEnterTitle = gohelper.findChildText(slot0.viewGO, "#go_Enter/Title/txt_Title")
	slot0._txtEnterTitleEn = gohelper.findChildText(slot0.viewGO, "#go_Enter/Title/txt_TitleEn")
	slot0._txtTitle = gohelper.findChildText(slot0.viewGO, "Title/txt_Title")
	slot0._txtTitleEn = gohelper.findChildText(slot0.viewGO, "Title/txt_TitleEn")
	slot0._viewAnim = slot0.viewGO:GetComponent(gohelper.Type_Animator)

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._scrollcategory:AddOnValueChanged(slot0._onScrollChange, slot0)
	slot0._btnCurStageFold:AddClickListener(slot0._btnCurStageFoldOnClick, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.SelectPermanentAltitude, slot0.selectPermanentAltitude, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.OnTowerResetSubEpisode, slot0.refreshEpisode, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.DailyReresh, slot0.onDailyRefresh, slot0)
end

function slot0.removeEvents(slot0)
	slot0._scrollcategory:RemoveOnValueChanged()
	slot0._btnCurStageFold:RemoveClickListener()
	slot0:removeEventCb(TowerController.instance, TowerEvent.SelectPermanentAltitude, slot0.selectPermanentAltitude, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.OnTowerResetSubEpisode, slot0.refreshEpisode, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.DailyReresh, slot0.onDailyRefresh, slot0)
end

slot0.maxStageCount = 5
slot0.showNextStageTitleTime = 0.4
slot0.selectNextStageTime = 0.7
slot0.selectNextLayerTime = 1
slot0.animBlockName = "TowerPermanentViewAnimBlock"

function slot0._btnEliteEpisodeItemClick(slot0, slot1, slot2)
	if slot0.curSelectEpisodeIndex == slot1 then
		return
	end

	slot3 = slot0.episodeIdList[slot1]
	slot0.curSelectEpisodeIndex = slot1

	for slot8, slot9 in pairs(slot0.eliteItemTab[slot0.layerConfig.layerId]) do
		slot9.isSelect = slot8 == slot1

		gohelper.setActive(slot9.goSelect, slot9.isSelect)
		gohelper.setActive(slot9.imageSelectFinishIcon.gameObject, slot9.isFinish)
		gohelper.setActive(slot9.goFinish, slot9.isFinish and not slot9.isSelect)
	end

	TowerPermanentModel.instance:setCurSelectEpisodeId(slot3)

	if not slot2 then
		slot0._viewAnim:Play("switchright", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_ripple)
	else
		TowerController.instance:dispatchEvent(TowerEvent.SelectPermanentEpisode)
	end
end

function slot0._btnNormalEpisodeItemClick(slot0, slot1)
	slot0.normalEpisodeItem.isSelect = true

	gohelper.setActive(slot0.normalEpisodeItem.goSelect, slot0.normalEpisodeItem.isSelect)
	TowerPermanentModel.instance:setCurSelectEpisodeId(slot1)
	TowerController.instance:dispatchEvent(TowerEvent.SelectPermanentEpisode)
end

function slot0._btnCurStageFoldOnClick(slot0)
	slot0.scrollCategoryRect.velocity = Vector2(0, 0)

	TowerController.instance:dispatchEvent(TowerEvent.FoldCurStage, TowerPermanentModel.instance:getCurSelectStage())
end

function slot0.onDailyRefresh(slot0)
	if TowerPermanentModel.instance:isNewStage() then
		slot0._scrollcategory.verticalNormalizedPosition = 1

		TowerPermanentModel.instance:onModelUpdate()
		TowerController.instance:dispatchEvent(TowerEvent.FoldCurStage, TowerPermanentModel.instance:getCurUnfoldStage())
	end

	slot0.scrollCategoryRect.velocity = Vector2(0, 0)

	slot0:refreshUI()
end

function slot0._editableInitView(slot0)
	slot0._rectContent = slot0._goContent:GetComponent(gohelper.Type_RectTransform)
	slot0._viewportMask2D = slot0._goViewport:GetComponent(gohelper.Type_RectMask2D)
	slot0.scrollCategoryRect = slot0._scrollcategory:GetComponent(typeof(UnityEngine.UI.ScrollRect))
	slot0._animEventWrap = slot0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))
	slot4 = slot0.refreshUI

	slot0._animEventWrap:AddEventListener("switch", slot4, slot0)

	slot0._bgAnim = gohelper.findChild(slot0.viewGO, "Bg"):GetComponent(gohelper.Type_Animator)
	slot0.eliteItemTab = slot0:getUserDataTb_()
	slot0.eliteItemPosTab = slot0:getUserDataTb_()
	slot0.rewardTab = slot0:getUserDataTb_()
	slot0.eliteBgAnimTab = slot0:getUserDataTb_()

	gohelper.setActive(slot0._goeliteItem, false)
	gohelper.setActive(slot0._gorewardItem, false)

	for slot4 = 1, uv0.maxStageCount do
		slot5 = {
			go = gohelper.findChild(slot0.viewGO, "Bg/" .. slot4 .. "/#go_Elitebg")
		}
		slot0.eliteBgAnimTab[slot4] = slot5

		gohelper.setActive(slot5.go, false)
	end

	for slot4 = 2, uv0.maxStageCount do
		slot5 = {
			go = gohelper.findChild(slot0.viewGO, "episode/#go_eliteEpisode/#go_elite" .. slot9),
			posTab = {}
		}
		slot9 = slot4

		for slot9 = 1, slot4 do
			slot5.posTab[slot9] = gohelper.findChild(slot5.go, "go_pos" .. slot9)
		end

		slot0.eliteItemPosTab[slot4] = slot5
	end

	slot0:initNormalEpisodeItem()
	TowerPermanentModel.instance:setCurSelectEpisodeId(0)
end

function slot0.initNormalEpisodeItem(slot0)
	slot0.normalEpisodeItem = slot0:getUserDataTb_()
	slot0.normalEpisodeItem.go = slot0._gonormalItem
	slot0.normalEpisodeItem.imageIcon = gohelper.findChildImage(slot0.normalEpisodeItem.go, "image_icon")
	slot0.normalEpisodeItem.goSelect = gohelper.findChild(slot0.normalEpisodeItem.go, "go_select")
	slot0.normalEpisodeItem.imageSelectIcon = gohelper.findChildImage(slot0.normalEpisodeItem.go, "go_select/image_selectIcon")
	slot0.normalEpisodeItem.imageSelectFinishIcon = gohelper.findChildImage(slot0.normalEpisodeItem.go, "go_select/image_selectFinishIcon")
	slot0.normalEpisodeItem.goFinish = gohelper.findChild(slot0.normalEpisodeItem.go, "go_finish")
	slot0.normalEpisodeItem.imageFinishIcon = gohelper.findChildImage(slot0.normalEpisodeItem.go, "go_finish/image_finishIcon")
	slot0.normalEpisodeItem.txtName = gohelper.findChildText(slot0.normalEpisodeItem.go, "txt_name")
	slot0.normalEpisodeItem.btnClick = gohelper.findChildButtonWithAudio(slot0.normalEpisodeItem.go, "btn_click")
	slot0.normalEpisodeItem.goFinishEffect = gohelper.findChild(slot0.normalEpisodeItem.go, "go_finishEffect")
end

function slot0.onUpdateParam(slot0)
end

function slot0._onScrollChange(slot0, slot1)
	gohelper.setActive(slot0._btnCurStageFold.gameObject, TowerPermanentModel.instance:getCurSelectStage() < TowerPermanentModel.instance:getStageCount())

	slot5 = recthelper.getAnchorY(slot0._rectContent) > (slot2 - 1) * TowerEnum.PermanentUI.StageTitleH

	gohelper.setActive(slot0._goStageInfo, slot5)

	slot0._txtCurStage.text = TowerConfig.instance:getTowerPermanentTimeCo(slot2).name
	slot0._viewportMask2D.padding = Vector4(0, 0, -150, slot5 and TowerEnum.PermanentUI.StageTitleH or 0)
end

function slot0.onOpen(slot0)
	slot0.jumpParam = slot0.viewParam or {}

	if tabletool.len(slot0.jumpParam) > 0 then
		slot0._viewAnim:Play("opennormal", 0, 0)
	else
		slot0._viewAnim:Play("openenter", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_bubbles)
	end

	gohelper.setActive(slot0._goStageInfo, false)
	slot0:refreshUI()
	slot0:scrollMoveToTargetLayer()

	if not TowerPermanentModel.instance:getLocalPassLayer() or slot2 == -1 then
		TowerPermanentModel.instance:setLocalPassLayer(TowerModel.instance:getCurPermanentMo().passLayerId)
	end

	if slot0.jumpParam and slot0.jumpParam.episodeId and slot0.layerConfig.isElite == 1 then
		for slot6, slot7 in ipairs(slot0.episodeIdList) do
			if slot7 == slot0.jumpParam.episodeId then
				slot0:_btnEliteEpisodeItemClick(slot6, true)

				break
			end
		end

		if TowerPermanentModel.instance:getFirstUnFinishEipsode(slot0.jumpParam.layerId) then
			slot0.nextUnfinishEpisodeId = slot3.episodeId

			TaskDispatcher.runDelay(slot0.selectNextEpisode, slot0, 1)
			UIBlockMgr.instance:startBlock(uv0.animBlockName)
			UIBlockMgrExtend.setNeedCircleMv(false)
		end
	end

	if slot0.jumpParam and slot0.jumpParam.episodeId and TowerPermanentModel.instance:isNewPassLayer() then
		UIBlockMgr.instance:startBlock(uv0.animBlockName)
		UIBlockMgrExtend.setNeedCircleMv(false)
		gohelper.setActive(slot0._gocompleted, false)

		slot3, slot4, slot5 = TowerPermanentModel.instance:isNewStage()

		if slot5 == slot4 and slot5 > 1 then
			slot0._bgAnim:Play(slot5 - 1 .. "to" .. slot5, 0, 1)
		end

		for slot9, slot10 in pairs(slot0.rewardTab) do
			gohelper.setActive(slot10.goHasGet, false)
		end

		TaskDispatcher.runDelay(slot0.playFinishEffect, slot0, 1)
	end
end

function slot0.playFinishEffect(slot0)
	gohelper.setActive(slot0._gocompleted, slot0.isAllFinish)
	gohelper.setActive(slot0._goschedule, slot0.layerConfig.isElite == 1 and not slot0.isAllFinish)
	slot0._animCompleted:Play("in", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_complete)

	for slot4, slot5 in pairs(slot0.rewardTab) do
		gohelper.setActive(slot5.goHasGet, true)
		slot5.animHasGet:Play("go_hasget_in", 0, 0)
	end

	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_award)
	TowerController.instance:dispatchEvent(TowerEvent.PermanentTowerFinishLayer, slot0.jumpParam.layerId)

	slot1, slot2, slot3 = TowerPermanentModel.instance:isNewStage()
	slot0.isNewStageInfo = {
		isNewStage = slot1,
		maxStage = slot2
	}

	if slot1 then
		slot0._bgAnim:Play(slot3 .. "to" .. slot2, 0, 0)

		if TowerConfig.instance:getPermanentEpisodeCo(slot0.jumpParam.layerId).isElite == 1 then
			gohelper.setActive(slot0.eliteBgAnimTab[slot3].go, true)
		end
	elseif slot3 == slot2 and slot3 > 1 then
		slot0._bgAnim:Play(slot3 - 1 .. "to" .. slot3, 0, 1)
	end

	slot0:setNewStageAndLayer(slot1)
	TowerPermanentModel.instance:setLocalPassLayer(TowerModel.instance:getCurPermanentMo().passLayerId)
end

function slot0.setNewStageAndLayer(slot0, slot1)
	slot2, slot3 = TowerPermanentModel.instance:getNewtStageAndLayer()
	slot0.animPermanentEpisodeCo = TowerConfig.instance:getPermanentEpisodeLayerCo(slot2, slot3)

	if slot1 then
		slot0:refreshEnterTitle(slot2)
		TaskDispatcher.runDelay(slot0.showNextStageTitleAnim, slot0, uv0.showNextStageTitleTime)
		TaskDispatcher.runDelay(slot0._btnCurStageFoldOnClick, slot0, uv0.selectNextStageTime)
		TaskDispatcher.runDelay(slot0.permanentSelectNextLayer, slot0, uv0.selectNextStageTime + uv0.selectNextLayerTime)
	else
		TaskDispatcher.runDelay(slot0.permanentSelectNextLayer, slot0, uv0.selectNextLayerTime)
	end
end

function slot0.showNextStageTitleAnim(slot0)
	if slot0.isNewStageInfo and slot0.isNewStageInfo.isNewStage then
		slot0._viewAnim:Play("switchfloor", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_bubbles)
	end
end

function slot0.selectNextEpisode(slot0)
	if slot0.nextUnfinishEpisodeId > 0 then
		for slot4, slot5 in ipairs(slot0.episodeIdList) do
			if slot5 == slot0.nextUnfinishEpisodeId then
				slot0:_btnEliteEpisodeItemClick(slot4, false)

				break
			end
		end
	end

	UIBlockMgr.instance:endBlock(uv0.animBlockName)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function slot0.permanentSelectNextLayer(slot0)
	UIBlockMgr.instance:endBlock(uv0.animBlockName)
	UIBlockMgrExtend.setNeedCircleMv(true)
	TowerController.instance:dispatchEvent(TowerEvent.PermanentSelectNextLayer, slot0.animPermanentEpisodeCo)
end

function slot0.selectPermanentAltitude(slot0)
	slot0.curSelectEpisodeIndex = 0

	if not slot0.isNewStageInfo or tabletool.len(slot0.isNewStageInfo) == 0 or not slot0.isNewStageInfo.isNewStage then
		slot0._viewAnim:Play(UIAnimationName.Switch, 0, 0)
	else
		slot0.isNewStageInfo = nil

		slot0:refreshUI()
	end
end

function slot0.selectUnfinishEpisode(slot0)
	if slot0.layerConfig.isElite == 1 and TowerPermanentModel.instance:getFirstUnFinishEipsode(slot0.layerConfig.layerId) then
		for slot5, slot6 in ipairs(slot0.episodeIdList) do
			if slot6 == slot1.episodeId then
				slot0:_btnEliteEpisodeItemClick(slot5, true)

				break
			end
		end
	end
end

function slot0.refreshUI(slot0)
	slot0:refreshEpisode()
	slot0:refreshReward()
	slot0:selectUnfinishEpisode()
	slot0:refreshEnterTitle()
	slot0:refreshStageItemEffect()
end

function slot0.refreshStageItemEffect(slot0)
	for slot4 = 1, uv0.maxStageCount do
		gohelper.setActive(slot0.eliteBgAnimTab[slot4].go, slot4 == slot0.curStage and slot0.layerConfig.isElite == 1)
	end
end

function slot0.refreshEnterTitle(slot0, slot1)
	slot2 = slot1 or slot0.curStage
	slot3 = TowerConfig.instance:getTowerPermanentTimeCo(slot2)
	slot0._txtEnterTitle.text = slot3.name
	slot0._txtEnterTitleEn.text = slot3.nameEn

	slot0._simageEnterBg:LoadImage(ResUrl.getTowerIcon("permanent/towerpermanent_bg" .. slot2))
end

function slot0.refreshEpisode(slot0)
	slot0.realselectStage, slot0.realSelectLayerIndex = TowerPermanentModel.instance:getRealSelectStage()
	slot0.curStage = TowerPermanentModel.instance:getCurSelectStage()
	slot0.curLayerIndex = TowerPermanentModel.instance:getCurSelectLayer()
	slot0.layerConfig = TowerConfig.instance:getPermanentEpisodeLayerCo(slot0.realselectStage, slot0.realSelectLayerIndex)
	slot0.isAllFinish = slot0.layerConfig.layerId <= TowerPermanentModel.instance.curPassLayer
	slot0.episodeIdList = string.splitToNumber(slot0.layerConfig.episodeIds, "|")
	slot3 = #slot0.episodeIdList
	slot4 = slot0.layerConfig.isElite == 1

	gohelper.setActive(slot0._gonormalEpisode, not slot4)
	gohelper.setActive(slot0._goeliteEpisode, slot4)
	gohelper.setActive(slot0._goschedule, slot4 and not slot0.isAllFinish)

	slot5 = TowerConfig.instance:getTowerPermanentTimeCo(slot0.curStage)
	slot0._txtTitle.text = slot5.name
	slot0._txtTitleEn.text = slot5.nameEn

	if slot0.curStage > 1 then
		slot0._bgAnim:Play(slot0.curStage - 1 .. "to" .. slot0.curStage, 0, 1)
	else
		slot0._bgAnim:Play("1idle", 0, 1)
	end

	if slot4 then
		slot11 = TowerModel.instance:getCurPermanentMo():getSubEpisodePassCount(slot0.layerConfig.layerId)
		slot12 = #slot0.episodeIdList
		slot0._txtschedule.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("towerpermanentresultview_schedule"), slot11, slot12)

		for slot11, slot12 in ipairs(slot0.episodeIdList) do
			slot13 = slot0.viewContainer:getTowerPermanentPoolView():createOrGetEliteEpisodeItem(slot11, slot0._btnEliteEpisodeItemClick, slot0)

			if not slot0.eliteItemTab[slot0.layerConfig.layerId] then
				slot0.eliteItemTab[slot0.layerConfig.layerId] = {}
			end

			slot0.eliteItemTab[slot0.layerConfig.layerId][slot11] = slot13

			gohelper.setActive(slot13.go, true)
			slot13.go.transform:SetParent(slot0.eliteItemPosTab[slot3].posTab[slot11].transform, false)
			recthelper.setAnchor(slot13.go.transform, 0, 0)

			slot13.isFinish = slot6:getSubEpisodeMoByEpisodeId(slot12) and slot15.status == TowerEnum.PassEpisodeState.Pass

			gohelper.setActive(slot13.goFinish, slot13.isFinish)

			slot13.txtName.text = GameUtil.getRomanNums(slot11)

			gohelper.setActive(slot13.imageSelectIcon.gameObject, not slot13.isFinish)
			gohelper.setActive(slot13.imageSelectFinishIcon.gameObject, slot13.isFinish)
			gohelper.setActive(slot13.goFinishEffect, slot13.isFinish)
			UISpriteSetMgr.instance:setTowerPermanentSprite(slot13.imageIcon, slot0:getEliteEpisodeIconName(slot11, TowerEnum.PermanentEliteEpisodeState.Normal), true)
			UISpriteSetMgr.instance:setTowerPermanentSprite(slot13.imageSelectIcon, slot0:getEliteEpisodeIconName(slot11, TowerEnum.PermanentEliteEpisodeState.NormalSelect), true)
			UISpriteSetMgr.instance:setTowerPermanentSprite(slot13.imageSelectFinishIcon, slot0:getEliteEpisodeIconName(slot11, TowerEnum.PermanentEliteEpisodeState.FinishSelect), true)
			UISpriteSetMgr.instance:setTowerPermanentSprite(slot13.imageFinishIcon, slot0:getEliteEpisodeIconName(slot11, TowerEnum.PermanentEliteEpisodeState.Finish), true)
		end

		slot0.viewContainer:getTowerPermanentPoolView():recycleEliteEpisodeItem(slot0.episodeIdList)

		for slot11 = 2, 5 do
			gohelper.setActive(slot0.eliteItemPosTab[slot11].go, slot11 == slot3)
		end

		if slot0.curSelectEpisodeIndex and slot0.curSelectEpisodeIndex > 0 then
			slot0:_btnEliteEpisodeItemClick(slot0.curSelectEpisodeIndex, true)
		else
			slot0:_btnEliteEpisodeItemClick(1, true)
		end
	else
		UISpriteSetMgr.instance:setTowerPermanentSprite(slot0.normalEpisodeItem.imageIcon, slot0:getEliteEpisodeIconName(1, TowerEnum.PermanentEliteEpisodeState.Normal), true)
		UISpriteSetMgr.instance:setTowerPermanentSprite(slot0.normalEpisodeItem.imageSelectIcon, slot0:getEliteEpisodeIconName(1, TowerEnum.PermanentEliteEpisodeState.NormalSelect), true)
		UISpriteSetMgr.instance:setTowerPermanentSprite(slot0.normalEpisodeItem.imageSelectFinishIcon, slot0:getEliteEpisodeIconName(1, TowerEnum.PermanentEliteEpisodeState.FinishSelect), true)
		UISpriteSetMgr.instance:setTowerPermanentSprite(slot0.normalEpisodeItem.imageFinishIcon, slot0:getEliteEpisodeIconName(1, TowerEnum.PermanentEliteEpisodeState.Finish), true)

		slot0.normalEpisodeItem.txtName.text = "ST - " .. slot0.realSelectLayerIndex

		gohelper.setActive(slot0.normalEpisodeItem.goSelect, true)
		gohelper.setActive(slot0.normalEpisodeItem.imageSelectIcon.gameObject, not slot0.isAllFinish)
		gohelper.setActive(slot0.normalEpisodeItem.imageSelectFinishIcon.gameObject, slot0.isAllFinish)
		gohelper.setActive(slot0.normalEpisodeItem.goFinishEffect, slot0.isAllFinish)
		gohelper.setActive(slot0.normalEpisodeItem.goFinish, false)
		slot0.normalEpisodeItem.btnClick:AddClickListener(slot0._btnNormalEpisodeItemClick, slot0, slot0.episodeIdList[1])
		slot0:_btnNormalEpisodeItemClick(slot0.episodeIdList[1])
	end

	gohelper.setActive(slot0._gocompleted, slot0.isAllFinish)
end

function slot0.getEliteEpisodeIconName(slot0, slot1, slot2)
	return string.format("towerpermanent_stage_%d_%d", slot1, slot2)
end

function slot0.refreshReward(slot0)
	gohelper.CreateObjList(slot0, slot0.rewardItemShow, string.split(slot0.layerConfig.firstReward, "|"), slot0._goreward, slot0._gorewardItem)
end

function slot0.rewardItemShow(slot0, slot1, slot2, slot3)
	if not slot0.rewardTab[slot3] then
		slot4 = {
			itemPos = gohelper.findChild(slot1, "go_rewardPos"),
			goHasGet = gohelper.findChild(slot1, "go_rewardGet"),
			animHasGet = gohelper.findChild(slot1, "go_rewardGet/icon/go_hasget"):GetComponent(gohelper.Type_Animator)
		}
		slot4.item = IconMgr.instance:getCommonPropItemIcon(slot4.itemPos)
		slot0.rewardTab[slot3] = slot4
	end

	slot5 = string.splitToNumber(slot2, "#")

	slot4.item:setMOValue(slot5[1], slot5[2], slot5[3])
	slot4.item:setHideLvAndBreakFlag(true)
	slot4.item:hideEquipLvAndBreak(true)
	slot4.item:setCountFontSize(51)
	gohelper.setActive(slot4.goHasGet, slot0.isAllFinish)
end

function slot0.scrollMoveToTargetLayer(slot0, slot1, slot2)
	recthelper.setAnchorY(slot0._goContent.transform, Mathf.Min(((slot1 or slot0.realselectStage) - 1) * TowerEnum.PermanentUI.StageTitleH + ((slot2 or slot0.realSelectLayerIndex) - 1) * (TowerEnum.PermanentUI.SingleItemH + TowerEnum.PermanentUI.ItemSpaceH), TowerPermanentModel.instance:getCurContentTotalHeight() - TowerEnum.PermanentUI.ScrollH + 1))
	slot0:_onScrollChange()
end

function slot0.onClose(slot0)
	if slot0.normalEpisodeItem.btnClick then
		slot0.normalEpisodeItem.btnClick:RemoveClickListener()
	end

	TaskDispatcher.cancelTask(slot0.showNextStageTitleAnim, slot0)
	TaskDispatcher.cancelTask(slot0._btnCurStageFoldOnClick, slot0)
	TaskDispatcher.cancelTask(slot0.permanentSelectNextLayer, slot0)
	TaskDispatcher.cancelTask(slot0.playFinishEffect, slot0)
	TaskDispatcher.cancelTask(slot0.selectNextEpisode, slot0)
	UIBlockMgr.instance:endBlock(uv0.animBlockName)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function slot0.onDestroyView(slot0)
	TowerPermanentModel.instance:cleanData()
	slot0._simageEnterBg:UnLoadImage()
	slot0._animEventWrap:RemoveAllEventListener()
end

return slot0
