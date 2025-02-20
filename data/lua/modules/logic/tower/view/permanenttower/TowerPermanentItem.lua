module("modules.logic.tower.view.permanenttower.TowerPermanentItem", package.seeall)

slot0 = class("TowerPermanentItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gostage = gohelper.findChild(slot0.viewGO, "go_stage")
	slot0._txtstage = gohelper.findChildText(slot0.viewGO, "go_stage/txt_stage")
	slot0._btnunfold = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_stage/btn_unfold")
	slot0._btnfold = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_stage/btn_fold")
	slot0._golockTip = gohelper.findChild(slot0.viewGO, "go_locktip")
	slot0._txtlockTip = gohelper.findChildText(slot0.viewGO, "go_locktip/txt_lock")
	slot0._goaltitudeContent = gohelper.findChild(slot0.viewGO, "go_altitudeContent")
	slot0._goaltitudeItem = gohelper.findChild(slot0.viewGO, "go_altitudeContent/go_altitudeItem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnunfold:AddClickListener(slot0._btnUnFoldOnClick, slot0)
	slot0._btnfold:AddClickListener(slot0._btnFoldOnClick, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.FoldCurStage, slot0.foldCurStage, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.UnFoldMaxStage, slot0.unfoldeMaxStage, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.PermanentTowerFinishLayer, slot0.playFinishEffect, slot0)
	slot0:addEventCb(TowerController.instance, TowerEvent.PermanentSelectNextLayer, slot0.selectNextLayer, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnunfold:RemoveClickListener()
	slot0._btnfold:RemoveClickListener()
	TaskDispatcher.cancelTask(slot0.refreshLockTip, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.FoldCurStage, slot0.foldCurStage, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.UnFoldMaxStage, slot0.unfoldeMaxStage, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.PermanentTowerFinishLayer, slot0.playFinishEffect, slot0)
	slot0:removeEventCb(TowerController.instance, TowerEvent.PermanentSelectNextLayer, slot0.selectNextLayer, slot0)
end

slot0.animFoldBlock = "TowerPermanentItemAnimFoldBlock"

function slot0.foldCurStage(slot0, slot1)
	if slot0.mo.stage == slot1 then
		slot0:_btnFoldOnClick()
	end
end

function slot0.unfoldeMaxStage(slot0)
	if slot0.mo.stage == slot0.stageCount then
		slot0:_btnUnFoldOnClick()
	end
end

function slot0._btnUnFoldOnClick(slot0)
	if slot0.playingAnim then
		return
	end

	slot0.scrollRect.velocity = Vector2(0, 0)

	TowerPermanentModel.instance:setCurSelectStage(slot0.mo.stage)

	slot0.playingAnim = true

	UIBlockMgr.instance:startBlock(uv0.animFoldBlock)

	slot0.isUnFold = true

	TowerPermanentModel.instance:initStageUnFoldState(slot0.mo.stage)
	slot0:moveToTop()
	slot0:doUnFoldAnim()
end

function slot0._btnFoldOnClick(slot0)
	if slot0.playingAnim then
		return
	end

	slot0.scrollRect.velocity = Vector2(0, 0)
	slot0.isUnFold = false

	slot0.mo:setIsUnFold(false)
	slot0:doFoldAnim()
end

function slot0._btnAltitudeItemClick(slot0, slot1)
	if slot0.altitudeItemTab[slot1.index].isSelect then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_tab_switch)

	slot5 = slot1.index
	slot6 = slot0.mo.stage

	TowerPermanentModel.instance:setCurSelectLayer(slot5, slot6)

	for slot5, slot6 in pairs(slot0.altitudeItemTab) do
		slot0.altitudeItemTab[slot5].isSelect = slot5 == slot1.index

		slot0:refreshSelectUI(slot6, slot0.configList[slot5])
	end

	TowerController.instance:dispatchEvent(TowerEvent.SelectPermanentAltitude)
end

function slot0.selectNextLayer(slot0, slot1)
	if slot0.mo.stage == slot1.stageId then
		slot0:_btnAltitudeItemClick(slot0.configList[slot1.index])
	end
end

slot0.selectFontSize = 40
slot0.unselectFontSize = 28
slot0.selectFontPos = Vector2.New(70, 5)
slot0.normalFontPos = Vector2.New(50, 0)
slot0.finishFontColor = "#D5E2ED"
slot0.selectFontColor = "#FFFFFF"
slot0.unFinishFontColor = "#7E8A95"

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._goaltitudeItem, false)

	slot0.altitudeContentRect = slot0._goaltitudeContent:GetComponent(gohelper.Type_RectTransform)
	slot0.playingAnim = false

	UIBlockMgr.instance:endBlock(uv0.animFoldBlock)

	slot0.stageCount = TowerPermanentModel.instance:getStageCount()
end

function slot0.onUpdateMO(slot0, slot1)
	slot0.mo = slot1
	slot0.isUnFold = slot0.mo:getIsUnFold()
	slot0.scrollRect = slot0._view._csMixScroll.gameObject:GetComponent(typeof(UnityEngine.UI.ScrollRect))

	if not slot0.goScrollContent then
		slot0.scrollCategory = gohelper.findChildScrollRect(slot2, "")
		slot0.rectViewPort = gohelper.findChild(slot2, "Viewport"):GetComponent(gohelper.Type_RectTransform)
		slot0.goScrollContent = gohelper.findChild(slot2, "Viewport/#go_Content")
		slot0.rectScrollContent = slot0.goScrollContent:GetComponent(gohelper.Type_RectTransform)
	end

	slot0.configList = slot0.mo.configList

	slot0:refreshUI()
	slot0:refreshAltitudeContentH()
end

function slot0.refreshUI(slot0)
	slot0._txtstage.text = TowerConfig.instance:getTowerPermanentTimeCo(slot0.mo.stage).name
	slot0.stageCount = TowerPermanentModel.instance:getStageCount()

	gohelper.setActive(slot0._btnunfold.gameObject, not slot0.isUnFold)
	gohelper.setActive(slot0._btnfold.gameObject, slot0.isUnFold and slot0.mo.stage < slot0.stageCount)

	slot2 = tabletool.len(slot0.configList) == 0

	gohelper.setActive(slot0._golockTip, slot2)
	gohelper.setActive(slot0._gostage, not slot2)
	gohelper.setActive(slot0._goaltitudeContent, not slot2)
	TaskDispatcher.cancelTask(slot0.refreshLockTip, slot0)
	TaskDispatcher.runRepeat(slot0.refreshLockTip, slot0, 1)
	slot0:refreshLockTip()

	if not slot2 and slot0.mo.stage == TowerPermanentModel.instance:getCurSelectStage() then
		slot0:createOrRefreshAltitudeItem()
		slot0:moveToTop()
	end
end

function slot0.refreshLockTip(slot0)
	slot0._txtlockTip.text = ""
	slot1, slot2 = slot0.mo:checkIsOnline()

	if tabletool.len(slot0.configList) == 0 then
		if slot1 then
			slot0._txtlockTip.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towerpermanent_stageunlocktip"), {
				TowerConfig.instance:getTowerPermanentTimeCo(slot0.mo.stage - 1).name,
				TowerConfig.instance:getTowerPermanentTimeCo(slot0.mo.stage).name
			})
		else
			slot5, slot6 = TimeUtil.secondToRoughTime2(slot2)
			slot0._txtlockTip.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towerpermanent_timeunlocktip"), {
				slot5,
				slot6,
				slot3.name
			})
		end
	end
end

function slot0.createOrRefreshAltitudeItem(slot0)
	slot0.altitudeItemTab = slot0:getUserDataTb_()
	slot1, slot2 = TowerPermanentModel.instance:getRealSelectStage()

	for slot6, slot7 in pairs(slot0.configList) do
		slot0.altitudeItemTab[slot6] = slot0._view.viewContainer:getTowerPermanentPoolView():createOrGetAltitudeItem(slot7, slot0._btnAltitudeItemClick, slot0)
		slot8.isSelect = slot0.mo.stage == slot1 and slot6 == slot2
		slot8.txtNum.text = string.format("%sM", slot7.layerId * 10)

		slot0:refreshSelectUI(slot8, slot7)
		gohelper.setActive(slot8.go, true)
		slot8.go.transform:SetParent(slot0._goaltitudeContent.transform, false)
		recthelper.setAnchor(slot8.go.transform, 0, 0)
		ZProj.UGUIHelper.RebuildLayout(slot0._goaltitudeContent.transform)
	end

	slot0._view.viewContainer:getTowerPermanentPoolView():recycleAltitudeItem(slot0.configList)
end

function slot0.refreshSelectUI(slot0, slot1, slot2)
	slot3 = slot2.isElite == 1
	slot4 = slot2.layerId <= TowerPermanentModel.instance.curPassLayer

	gohelper.setActive(slot1.goNormal, not slot3)
	gohelper.setActive(slot1.goElite, slot3)
	gohelper.setActive(slot1.goNormalSelect, slot1.isSelect and not slot3)
	gohelper.setActive(slot1.goEliteSelect, slot1.isSelect and slot3)

	slot1.txtNum.fontSize = slot1.isSelect and uv0.selectFontSize or uv0.unselectFontSize
	slot5 = slot1.isSelect and uv0.selectFontPos or uv0.normalFontPos
	slot6 = "#FFFFFF"
	slot1.itemCanvasGroup.alpha = not TowerPermanentModel.instance:checkLayerUnlock(slot2) and not slot1.isSelect and 0.5 or 1

	SLFramework.UGUI.GuiHelper.SetColor(slot1.txtNum, (not slot1.isSelect or uv0.selectFontColor) and (slot4 and uv0.finishFontColor or uv0.unFinishFontColor))
	recthelper.setAnchor(slot1.txtNum.transform, slot5.x, slot5.y)
	gohelper.setActive(slot1.goNormalUnFinish, not slot4 and not slot3 and not slot1.isSelect)
	gohelper.setActive(slot1.goNormalFinish, slot4 and not slot3)
	gohelper.setActive(slot1.goEliteUnFinish, not slot4 and slot3 and not slot1.isSelect)
	gohelper.setActive(slot1.goEliteFinish, slot4 and slot3)
	gohelper.setActive(slot1.goArrow, false)
	gohelper.setActive(slot1.goNormalLock, not slot7 and not slot3 and not slot1.isSelect)
	gohelper.setActive(slot1.goEliteLock, not slot7 and slot3 and not slot1.isSelect)

	if not string.nilorempty(slot2.spReward) then
		transformhelper.setLocalScale(slot1.simageReward.gameObject.transform, 1, 1, 1)
		gohelper.setActive(slot1.goReward, not slot1.isSelect and not slot4)

		slot8 = string.splitToNumber(slot2.spReward, "#")
		slot9, slot10 = ItemModel.instance:getItemConfigAndIcon(slot8[1], slot8[2])

		if slot9.subType == ItemEnum.SubType.Portrait then
			slot10 = ResUrl.getPlayerHeadIcon(slot9.icon)

			transformhelper.setLocalScale(slot1.simageReward.gameObject.transform, 0.7, 0.7, 0.7)
		end

		slot1.simageReward:LoadImage(slot10)
	else
		gohelper.setActive(slot1.goReward, false)
	end
end

function slot0.playFinishEffect(slot0, slot1)
	slot3 = TowerConfig.instance:getPermanentEpisodeCo(slot1).index
	slot4 = nil

	for slot8, slot9 in pairs(slot0.configList) do
		if slot9.layerId == slot1 then
			slot4 = slot0._view.viewContainer:getTowerPermanentPoolView():createOrGetAltitudeItem(slot9, slot0._btnAltitudeItemClick, slot0)

			break
		end
	end

	if not slot4 then
		return
	end

	if slot2.isElite == 1 then
		slot4.animEliteFinish:Play("in", 0, 0)
	else
		slot4.animNormalFinish:Play("in", 0, 0)
	end

	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_single_star)
end

function slot0.refreshAltitudeContentH(slot0)
	if slot0.playingAnim then
		return
	end

	slot0.altitudeContentH = slot0.mo:getAltitudeHeight(slot0.isUnFold)

	recthelper.setHeight(slot0.altitudeContentRect, slot0.altitudeContentH)
end

function slot0.doUnFoldAnim(slot0)
	UIBlockMgr.instance:startBlock(uv0.animFoldBlock)

	slot0.scrollCategory.movementType = 2
	slot0.altitudeContentH = slot0.mo:getAltitudeHeight(slot0.isUnFold)
	slot0._foldAnimTweenId = ZProj.TweenHelper.DOTweenFloat(0, slot0.altitudeContentH, slot0.altitudeContentH * 0.0003, slot0._onFoldTweenFrameCallback, slot0._onUnFoldTweenFinishCallback, slot0, nil)
end

function slot0.doFoldAnim(slot0)
	UIBlockMgr.instance:startBlock(uv0.animFoldBlock)

	slot0.scrollCategory.movementType = 2
	slot0._foldAnimTweenId = ZProj.TweenHelper.DOTweenFloat(slot0.altitudeContentH, 0, slot0.altitudeContentH * 0.0001, slot0._onFoldTweenFrameCallback, slot0._onFoldTweenFinishCallback, slot0, nil)
end

function slot0._onFoldTweenFrameCallback(slot0, slot1)
	slot0.playingAnim = true

	slot0:moveToTop()
	recthelper.setHeight(slot0.rectViewPort, Mathf.Min(TowerEnum.PermanentUI.StageTitleH * (slot0.stageCount - slot0.mo.stage + 1) + (TowerPermanentModel.instance:checkhasLockTip() and TowerEnum.PermanentUI.LockTipH or 0) + slot1, TowerEnum.PermanentUI.ScrollH))
	slot0.mo:overrideStageHeight(slot1)
	recthelper.setHeight(slot0.altitudeContentRect, slot1)
	TowerPermanentModel.instance:onModelUpdate()
end

function slot0._onFoldTweenFinishCallback(slot0)
	slot0.playingAnim = false

	UIBlockMgr.instance:endBlock(uv0.animFoldBlock)
	TowerPermanentModel.instance:setCurSelectStage(slot0.stageCount)
	TowerController.instance:dispatchEvent(TowerEvent.UnFoldMaxStage)
end

function slot0.moveToTop(slot0)
	recthelper.setAnchorY(slot0.rectScrollContent, TowerEnum.PermanentUI.StageTitleH * Mathf.Max(slot0.mo.stage - 2, 0))
end

function slot0._onUnFoldTweenFinishCallback(slot0)
	slot0.playingAnim = false

	UIBlockMgr.instance:endBlock(uv0.animFoldBlock)
	slot0:moveToTop()
	slot0.mo:cleanCurUnFoldingH()
	slot0:refreshAltitudeContentH()
	TowerPermanentModel.instance:onModelUpdate()

	slot0.scrollCategory.movementType = 1
end

function slot0.onDestroy(slot0)
	if slot0._foldAnimTweenId then
		ZProj.TweenHelper.KillById(slot0._foldAnimTweenId)

		slot0._foldAnimTweenId = nil
	end

	TaskDispatcher.cancelTask(slot0.refreshLockTip, slot0)
	UIBlockMgr.instance:endBlock(uv0.animFoldBlock)
end

return slot0
