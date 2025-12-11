module("modules.logic.tower.view.permanenttower.TowerPermanentItem", package.seeall)

local var_0_0 = class("TowerPermanentItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gostage = gohelper.findChild(arg_1_0.viewGO, "go_stage")
	arg_1_0._txtstage = gohelper.findChildText(arg_1_0.viewGO, "go_stage/txt_stage")
	arg_1_0._btnunfold = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_stage/btn_unfold")
	arg_1_0._btnfold = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_stage/btn_fold")
	arg_1_0._golockTip = gohelper.findChild(arg_1_0.viewGO, "go_locktip")
	arg_1_0._txtlockTip = gohelper.findChildText(arg_1_0.viewGO, "go_locktip/txt_lock")
	arg_1_0._goaltitudeContent = gohelper.findChild(arg_1_0.viewGO, "go_altitudeContent")
	arg_1_0._goaltitudeItem = gohelper.findChild(arg_1_0.viewGO, "go_altitudeContent/go_altitudeItem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnunfold:AddClickListener(arg_2_0._btnUnFoldOnClick, arg_2_0)
	arg_2_0._btnfold:AddClickListener(arg_2_0._btnFoldOnClick, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.FoldCurStage, arg_2_0.foldCurStage, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.UnFoldMaxStage, arg_2_0.unfoldeMaxStage, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.PermanentTowerFinishLayer, arg_2_0.playFinishEffect, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.PermanentSelectNextLayer, arg_2_0.selectNextLayer, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.OnSelectDeepLayer, arg_2_0.onSelectDeepLayer, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnunfold:RemoveClickListener()
	arg_3_0._btnfold:RemoveClickListener()
	TaskDispatcher.cancelTask(arg_3_0.refreshLockTip, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.FoldCurStage, arg_3_0.foldCurStage, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.UnFoldMaxStage, arg_3_0.unfoldeMaxStage, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.PermanentTowerFinishLayer, arg_3_0.playFinishEffect, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.PermanentSelectNextLayer, arg_3_0.selectNextLayer, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.OnSelectDeepLayer, arg_3_0.onSelectDeepLayer, arg_3_0)
end

var_0_0.animFoldBlock = "TowerPermanentItemAnimFoldBlock"

function var_0_0.foldCurStage(arg_4_0, arg_4_1)
	if arg_4_0.mo.stage == arg_4_1 then
		arg_4_0:doFoldOnClick()
	end
end

function var_0_0.unfoldeMaxStage(arg_5_0)
	if arg_5_0.mo.stage == arg_5_0.stageCount then
		arg_5_0:doUnFoldOnClick()
	end
end

function var_0_0._btnUnFoldOnClick(arg_6_0)
	arg_6_0:doUnFoldOnClick()
	TowerPermanentDeepModel.instance:setIsSelectDeepCategory(false)
end

function var_0_0.doUnFoldOnClick(arg_7_0)
	if arg_7_0.playingAnim then
		return
	end

	arg_7_0.scrollRect.velocity = Vector2(0, 0)

	TowerPermanentModel.instance:setCurSelectStage(arg_7_0.mo.stage)

	arg_7_0.playingAnim = true

	UIBlockMgr.instance:startBlock(var_0_0.animFoldBlock)

	arg_7_0.isUnFold = true

	TowerPermanentModel.instance:initStageUnFoldState(arg_7_0.mo.stage)
	arg_7_0:moveToTop()
	arg_7_0:doUnFoldAnim()
end

function var_0_0._btnFoldOnClick(arg_8_0)
	arg_8_0:doFoldOnClick()
	TowerPermanentDeepModel.instance:setIsSelectDeepCategory(false)
end

function var_0_0.doFoldOnClick(arg_9_0)
	if arg_9_0.playingAnim then
		return
	end

	arg_9_0.scrollRect.velocity = Vector2(0, 0)
	arg_9_0.isUnFold = false

	arg_9_0.mo:setIsUnFold(false)
	arg_9_0:doFoldAnim()
end

function var_0_0._btnAltitudeItemClick(arg_10_0, arg_10_1)
	if arg_10_0.altitudeItemTab[arg_10_1.index].isSelect then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_tab_switch)
	TowerPermanentModel.instance:setCurSelectLayer(arg_10_1.index, arg_10_0.mo.stage)

	for iter_10_0, iter_10_1 in pairs(arg_10_0.altitudeItemTab) do
		local var_10_0 = arg_10_0.configList[iter_10_0]
		local var_10_1 = iter_10_0 == arg_10_1.index

		arg_10_0.altitudeItemTab[iter_10_0].isSelect = var_10_1

		arg_10_0:refreshSelectUI(iter_10_1, var_10_0)
	end

	TowerPermanentDeepModel.instance:setInDeepLayerState(false)
	TowerPermanentDeepModel.instance:setIsSelectDeepCategory(false)
	TowerController.instance:dispatchEvent(TowerEvent.SelectPermanentAltitude)
end

function var_0_0.onSelectDeepLayer(arg_11_0)
	if not arg_11_0.altitudeItemTab or not next(arg_11_0.altitudeItemTab) then
		return
	end

	for iter_11_0, iter_11_1 in pairs(arg_11_0.altitudeItemTab) do
		local var_11_0 = arg_11_0.configList[iter_11_0]

		arg_11_0.altitudeItemTab[iter_11_0].isSelect = false

		if var_11_0 then
			arg_11_0:refreshSelectUI(iter_11_1, var_11_0)
		end
	end
end

function var_0_0.selectNextLayer(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1.index
	local var_12_1 = arg_12_1.stageId

	if arg_12_0.mo.stage == var_12_1 then
		arg_12_0:_btnAltitudeItemClick(arg_12_0.configList[var_12_0])
	end
end

var_0_0.selectFontSize = 40
var_0_0.unselectFontSize = 28
var_0_0.selectFontPos = Vector2.New(70, 5)
var_0_0.normalFontPos = Vector2.New(50, 0)
var_0_0.finishFontColor = "#D5E2ED"
var_0_0.selectFontColor = "#FFFFFF"
var_0_0.unFinishFontColor = "#7E8A95"

function var_0_0._editableInitView(arg_13_0)
	gohelper.setActive(arg_13_0._goaltitudeItem, false)

	arg_13_0.altitudeContentRect = arg_13_0._goaltitudeContent:GetComponent(gohelper.Type_RectTransform)
	arg_13_0.playingAnim = false

	UIBlockMgr.instance:endBlock(var_0_0.animFoldBlock)

	arg_13_0.stageCount = TowerPermanentModel.instance:getStageCount()
end

function var_0_0.onUpdateMO(arg_14_0, arg_14_1)
	arg_14_0.mo = arg_14_1
	arg_14_0.isUnFold = arg_14_0.mo:getIsUnFold()

	local var_14_0 = arg_14_0._view._csMixScroll.gameObject

	arg_14_0.scrollRect = var_14_0:GetComponent(typeof(UnityEngine.UI.ScrollRect))

	if not arg_14_0.goScrollContent then
		arg_14_0.scrollCategory = gohelper.findChildScrollRect(var_14_0, "")
		arg_14_0.rectViewPort = gohelper.findChild(var_14_0, "Viewport"):GetComponent(gohelper.Type_RectTransform)
		arg_14_0.goScrollContent = gohelper.findChild(var_14_0, "Viewport/#go_Content")
		arg_14_0.rectScrollContent = arg_14_0.goScrollContent:GetComponent(gohelper.Type_RectTransform)
	end

	arg_14_0.configList = arg_14_0.mo.configList

	arg_14_0:refreshUI()
	arg_14_0:refreshAltitudeContentH()
end

function var_0_0.refreshUI(arg_15_0)
	arg_15_0.isDeepLayerUnlock = TowerPermanentDeepModel.instance:checkDeepLayerUnlock()

	local var_15_0 = TowerConfig.instance:getTowerPermanentTimeCo(arg_15_0.mo.stage)

	arg_15_0._txtstage.text = var_15_0.name
	arg_15_0.stageCount = TowerPermanentModel.instance:getStageCount()

	gohelper.setActive(arg_15_0._btnunfold.gameObject, not arg_15_0.isUnFold)
	gohelper.setActive(arg_15_0._btnfold.gameObject, arg_15_0.isUnFold and arg_15_0.mo.stage < arg_15_0.stageCount)

	local var_15_1 = tabletool.len(arg_15_0.configList) == 0

	gohelper.setActive(arg_15_0._golockTip, var_15_1)
	gohelper.setActive(arg_15_0._gostage, not var_15_1)
	gohelper.setActive(arg_15_0._goaltitudeContent, not var_15_1)
	TaskDispatcher.cancelTask(arg_15_0.refreshLockTip, arg_15_0)
	TaskDispatcher.runRepeat(arg_15_0.refreshLockTip, arg_15_0, 1)
	arg_15_0:refreshLockTip()

	local var_15_2 = TowerPermanentModel.instance:getCurSelectStage()

	if not var_15_1 and arg_15_0.mo.stage == var_15_2 then
		arg_15_0:createOrRefreshAltitudeItem()
		arg_15_0:moveToTop()
	end
end

function var_0_0.refreshLockTip(arg_16_0)
	arg_16_0._txtlockTip.text = ""

	local var_16_0, var_16_1 = arg_16_0.mo:checkIsOnline()
	local var_16_2 = TowerConfig.instance:getTowerPermanentTimeCo(arg_16_0.mo.stage)

	if tabletool.len(arg_16_0.configList) == 0 then
		if var_16_0 then
			local var_16_3 = TowerConfig.instance:getTowerPermanentTimeCo(arg_16_0.mo.stage - 1)

			arg_16_0._txtlockTip.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towerpermanent_stageunlocktip"), {
				var_16_3.name,
				var_16_2.name
			})
		else
			local var_16_4, var_16_5 = TimeUtil.secondToRoughTime2(var_16_1)

			arg_16_0._txtlockTip.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towerpermanent_timeunlocktip"), {
				var_16_4,
				var_16_5,
				var_16_2.name
			})
		end
	end
end

function var_0_0.createOrRefreshAltitudeItem(arg_17_0)
	arg_17_0.altitudeItemTab = arg_17_0:getUserDataTb_()

	local var_17_0, var_17_1 = TowerPermanentModel.instance:getRealSelectStage()
	local var_17_2 = TowerPermanentDeepModel.instance:getIsInDeepLayerState()

	for iter_17_0, iter_17_1 in pairs(arg_17_0.configList) do
		local var_17_3 = arg_17_0._view.viewContainer:getTowerPermanentPoolView():createOrGetAltitudeItem(iter_17_1, arg_17_0._btnAltitudeItemClick, arg_17_0)

		arg_17_0.altitudeItemTab[iter_17_0] = var_17_3
		var_17_3.isSelect = arg_17_0.mo.stage == var_17_0 and iter_17_0 == var_17_1 and not var_17_2
		var_17_3.txtNum.text = string.format("%sM", iter_17_1.layerId * 10)

		arg_17_0:refreshSelectUI(var_17_3, iter_17_1)
		gohelper.setActive(var_17_3.go, true)
		var_17_3.go.transform:SetParent(arg_17_0._goaltitudeContent.transform, false)
		recthelper.setAnchor(var_17_3.go.transform, 0, 0)
		ZProj.UGUIHelper.RebuildLayout(arg_17_0._goaltitudeContent.transform)
	end

	arg_17_0._view.viewContainer:getTowerPermanentPoolView():recycleAltitudeItem(arg_17_0.configList)
end

function var_0_0.refreshSelectUI(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_2.isElite == 1
	local var_18_1 = arg_18_2.layerId <= TowerPermanentModel.instance.curPassLayer

	gohelper.setActive(arg_18_1.goNormal, not var_18_0)
	gohelper.setActive(arg_18_1.goElite, var_18_0)
	gohelper.setActive(arg_18_1.goNormalSelect, arg_18_1.isSelect and not var_18_0)
	gohelper.setActive(arg_18_1.goEliteSelect, arg_18_1.isSelect and var_18_0)

	arg_18_1.txtNum.fontSize = arg_18_1.isSelect and var_0_0.selectFontSize or var_0_0.unselectFontSize

	local var_18_2 = arg_18_1.isSelect and var_0_0.selectFontPos or var_0_0.normalFontPos
	local var_18_3 = "#FFFFFF"

	if arg_18_1.isSelect then
		var_18_3 = var_0_0.selectFontColor
	else
		var_18_3 = var_18_1 and var_0_0.finishFontColor or var_0_0.unFinishFontColor
	end

	local var_18_4 = TowerPermanentModel.instance:checkLayerUnlock(arg_18_2)

	arg_18_1.itemCanvasGroup.alpha = not var_18_4 and not arg_18_1.isSelect and 0.5 or 1

	SLFramework.UGUI.GuiHelper.SetColor(arg_18_1.txtNum, var_18_3)
	recthelper.setAnchor(arg_18_1.txtNum.transform, var_18_2.x, var_18_2.y)
	gohelper.setActive(arg_18_1.goNormalUnFinish, not var_18_1 and not var_18_0 and not arg_18_1.isSelect)
	gohelper.setActive(arg_18_1.goNormalFinish, var_18_1 and not var_18_0)
	gohelper.setActive(arg_18_1.goEliteUnFinish, not var_18_1 and var_18_0 and not arg_18_1.isSelect)
	gohelper.setActive(arg_18_1.goEliteFinish, var_18_1 and var_18_0)
	gohelper.setActive(arg_18_1.goArrow, false)
	gohelper.setActive(arg_18_1.goNormalLock, not var_18_4 and not var_18_0 and not arg_18_1.isSelect)
	gohelper.setActive(arg_18_1.goEliteLock, not var_18_4 and var_18_0 and not arg_18_1.isSelect)

	if not string.nilorempty(arg_18_2.spReward) then
		transformhelper.setLocalScale(arg_18_1.simageReward.gameObject.transform, 1, 1, 1)
		gohelper.setActive(arg_18_1.goReward, not arg_18_1.isSelect and not var_18_1)

		local var_18_5 = string.splitToNumber(arg_18_2.spReward, "#")
		local var_18_6, var_18_7 = ItemModel.instance:getItemConfigAndIcon(var_18_5[1], var_18_5[2])

		if var_18_6.subType == ItemEnum.SubType.Portrait then
			var_18_7 = ResUrl.getPlayerHeadIcon(var_18_6.icon)

			transformhelper.setLocalScale(arg_18_1.simageReward.gameObject.transform, 0.7, 0.7, 0.7)
		end

		arg_18_1.simageReward:LoadImage(var_18_7)
	else
		gohelper.setActive(arg_18_1.goReward, false)
	end
end

function var_0_0.playFinishEffect(arg_19_0, arg_19_1)
	local var_19_0 = TowerConfig.instance:getPermanentEpisodeCo(arg_19_1)
	local var_19_1 = var_19_0.index
	local var_19_2

	for iter_19_0, iter_19_1 in pairs(arg_19_0.configList) do
		if iter_19_1.layerId == arg_19_1 then
			var_19_2 = arg_19_0._view.viewContainer:getTowerPermanentPoolView():createOrGetAltitudeItem(iter_19_1, arg_19_0._btnAltitudeItemClick, arg_19_0)

			break
		end
	end

	if not var_19_2 then
		return
	end

	if var_19_0.isElite == 1 then
		var_19_2.animEliteFinish:Play("in", 0, 0)
	else
		var_19_2.animNormalFinish:Play("in", 0, 0)
	end

	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_single_star)
end

function var_0_0.refreshAltitudeContentH(arg_20_0)
	if arg_20_0.playingAnim then
		return
	end

	arg_20_0.altitudeContentH = arg_20_0.mo:getAltitudeHeight(arg_20_0.isUnFold)

	recthelper.setHeight(arg_20_0.altitudeContentRect, arg_20_0.altitudeContentH)
end

function var_0_0.doUnFoldAnim(arg_21_0)
	UIBlockMgr.instance:startBlock(var_0_0.animFoldBlock)

	arg_21_0.scrollCategory.movementType = 2
	arg_21_0.altitudeContentH = arg_21_0.mo:getAltitudeHeight(arg_21_0.isUnFold)
	arg_21_0._foldAnimTweenId = ZProj.TweenHelper.DOTweenFloat(0, arg_21_0.altitudeContentH, arg_21_0.altitudeContentH * 0.0003, arg_21_0._onFoldTweenFrameCallback, arg_21_0._onUnFoldTweenFinishCallback, arg_21_0, nil)
end

function var_0_0.doFoldAnim(arg_22_0)
	UIBlockMgr.instance:startBlock(var_0_0.animFoldBlock)

	arg_22_0.scrollCategory.movementType = 2
	arg_22_0._foldAnimTweenId = ZProj.TweenHelper.DOTweenFloat(arg_22_0.altitudeContentH, 0, arg_22_0.altitudeContentH * 0.0001, arg_22_0._onFoldTweenFrameCallback, arg_22_0._onFoldTweenFinishCallback, arg_22_0, nil)
end

function var_0_0._onFoldTweenFrameCallback(arg_23_0, arg_23_1)
	arg_23_0.playingAnim = true

	arg_23_0:moveToTop()

	local var_23_0 = TowerPermanentModel.instance:checkhasLockTip() and TowerEnum.PermanentUI.LockTipH or 0
	local var_23_1 = arg_23_0.stageCount - arg_23_0.mo.stage + 1
	local var_23_2 = Mathf.Min(TowerEnum.PermanentUI.StageTitleH * var_23_1 + var_23_0 + arg_23_1, arg_23_0.isDeepLayerUnlock and TowerEnum.PermanentUI.DeepScrollH or TowerEnum.PermanentUI.ScrollH)

	recthelper.setHeight(arg_23_0.rectViewPort, var_23_2)
	arg_23_0.mo:overrideStageHeight(arg_23_1)
	recthelper.setHeight(arg_23_0.altitudeContentRect, arg_23_1)
	TowerPermanentModel.instance:onModelUpdate()
end

function var_0_0._onFoldTweenFinishCallback(arg_24_0)
	arg_24_0.playingAnim = false

	UIBlockMgr.instance:endBlock(var_0_0.animFoldBlock)
	TowerPermanentModel.instance:setCurSelectStage(arg_24_0.stageCount)
	TowerController.instance:dispatchEvent(TowerEvent.UnFoldMaxStage)
end

function var_0_0.moveToTop(arg_25_0)
	local var_25_0 = TowerEnum.PermanentUI.StageTitleH * Mathf.Max(arg_25_0.mo.stage - 2, 0)

	recthelper.setAnchorY(arg_25_0.rectScrollContent, var_25_0)
end

function var_0_0._onUnFoldTweenFinishCallback(arg_26_0)
	arg_26_0.playingAnim = false

	UIBlockMgr.instance:endBlock(var_0_0.animFoldBlock)
	arg_26_0:moveToTop()
	arg_26_0.mo:cleanCurUnFoldingH()
	arg_26_0:refreshAltitudeContentH()
	TowerPermanentModel.instance:onModelUpdate()

	arg_26_0.scrollCategory.movementType = 1

	if TowerPermanentDeepModel.instance:getIsSelectDeepCategory() then
		arg_26_0.scrollCategory.verticalNormalizedPosition = 0
	end
end

function var_0_0.onDestroy(arg_27_0)
	if arg_27_0._foldAnimTweenId then
		ZProj.TweenHelper.KillById(arg_27_0._foldAnimTweenId)

		arg_27_0._foldAnimTweenId = nil
	end

	TaskDispatcher.cancelTask(arg_27_0.refreshLockTip, arg_27_0)
	UIBlockMgr.instance:endBlock(var_0_0.animFoldBlock)
end

return var_0_0
