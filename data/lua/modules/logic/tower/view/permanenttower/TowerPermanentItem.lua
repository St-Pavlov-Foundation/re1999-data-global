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
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnunfold:RemoveClickListener()
	arg_3_0._btnfold:RemoveClickListener()
	TaskDispatcher.cancelTask(arg_3_0.refreshLockTip, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.FoldCurStage, arg_3_0.foldCurStage, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.UnFoldMaxStage, arg_3_0.unfoldeMaxStage, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.PermanentTowerFinishLayer, arg_3_0.playFinishEffect, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.PermanentSelectNextLayer, arg_3_0.selectNextLayer, arg_3_0)
end

var_0_0.animFoldBlock = "TowerPermanentItemAnimFoldBlock"

function var_0_0.foldCurStage(arg_4_0, arg_4_1)
	if arg_4_0.mo.stage == arg_4_1 then
		arg_4_0:_btnFoldOnClick()
	end
end

function var_0_0.unfoldeMaxStage(arg_5_0)
	if arg_5_0.mo.stage == arg_5_0.stageCount then
		arg_5_0:_btnUnFoldOnClick()
	end
end

function var_0_0._btnUnFoldOnClick(arg_6_0)
	if arg_6_0.playingAnim then
		return
	end

	arg_6_0.scrollRect.velocity = Vector2(0, 0)

	TowerPermanentModel.instance:setCurSelectStage(arg_6_0.mo.stage)

	arg_6_0.playingAnim = true

	UIBlockMgr.instance:startBlock(var_0_0.animFoldBlock)

	arg_6_0.isUnFold = true

	TowerPermanentModel.instance:initStageUnFoldState(arg_6_0.mo.stage)
	arg_6_0:moveToTop()
	arg_6_0:doUnFoldAnim()
end

function var_0_0._btnFoldOnClick(arg_7_0)
	if arg_7_0.playingAnim then
		return
	end

	arg_7_0.scrollRect.velocity = Vector2(0, 0)
	arg_7_0.isUnFold = false

	arg_7_0.mo:setIsUnFold(false)
	arg_7_0:doFoldAnim()
end

function var_0_0._btnAltitudeItemClick(arg_8_0, arg_8_1)
	if arg_8_0.altitudeItemTab[arg_8_1.index].isSelect then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_tab_switch)
	TowerPermanentModel.instance:setCurSelectLayer(arg_8_1.index, arg_8_0.mo.stage)

	for iter_8_0, iter_8_1 in pairs(arg_8_0.altitudeItemTab) do
		local var_8_0 = arg_8_0.configList[iter_8_0]
		local var_8_1 = iter_8_0 == arg_8_1.index

		arg_8_0.altitudeItemTab[iter_8_0].isSelect = var_8_1

		arg_8_0:refreshSelectUI(iter_8_1, var_8_0)
	end

	TowerController.instance:dispatchEvent(TowerEvent.SelectPermanentAltitude)
end

function var_0_0.selectNextLayer(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.index
	local var_9_1 = arg_9_1.stageId

	if arg_9_0.mo.stage == var_9_1 then
		arg_9_0:_btnAltitudeItemClick(arg_9_0.configList[var_9_0])
	end
end

var_0_0.selectFontSize = 40
var_0_0.unselectFontSize = 28
var_0_0.selectFontPos = Vector2.New(70, 5)
var_0_0.normalFontPos = Vector2.New(50, 0)
var_0_0.finishFontColor = "#D5E2ED"
var_0_0.selectFontColor = "#FFFFFF"
var_0_0.unFinishFontColor = "#7E8A95"

function var_0_0._editableInitView(arg_10_0)
	gohelper.setActive(arg_10_0._goaltitudeItem, false)

	arg_10_0.altitudeContentRect = arg_10_0._goaltitudeContent:GetComponent(gohelper.Type_RectTransform)
	arg_10_0.playingAnim = false

	UIBlockMgr.instance:endBlock(var_0_0.animFoldBlock)

	arg_10_0.stageCount = TowerPermanentModel.instance:getStageCount()
end

function var_0_0.onUpdateMO(arg_11_0, arg_11_1)
	arg_11_0.mo = arg_11_1
	arg_11_0.isUnFold = arg_11_0.mo:getIsUnFold()

	local var_11_0 = arg_11_0._view._csMixScroll.gameObject

	arg_11_0.scrollRect = var_11_0:GetComponent(typeof(UnityEngine.UI.ScrollRect))

	if not arg_11_0.goScrollContent then
		arg_11_0.scrollCategory = gohelper.findChildScrollRect(var_11_0, "")
		arg_11_0.rectViewPort = gohelper.findChild(var_11_0, "Viewport"):GetComponent(gohelper.Type_RectTransform)
		arg_11_0.goScrollContent = gohelper.findChild(var_11_0, "Viewport/#go_Content")
		arg_11_0.rectScrollContent = arg_11_0.goScrollContent:GetComponent(gohelper.Type_RectTransform)
	end

	arg_11_0.configList = arg_11_0.mo.configList

	arg_11_0:refreshUI()
	arg_11_0:refreshAltitudeContentH()
end

function var_0_0.refreshUI(arg_12_0)
	local var_12_0 = TowerConfig.instance:getTowerPermanentTimeCo(arg_12_0.mo.stage)

	arg_12_0._txtstage.text = var_12_0.name
	arg_12_0.stageCount = TowerPermanentModel.instance:getStageCount()

	gohelper.setActive(arg_12_0._btnunfold.gameObject, not arg_12_0.isUnFold)
	gohelper.setActive(arg_12_0._btnfold.gameObject, arg_12_0.isUnFold and arg_12_0.mo.stage < arg_12_0.stageCount)

	local var_12_1 = tabletool.len(arg_12_0.configList) == 0

	gohelper.setActive(arg_12_0._golockTip, var_12_1)
	gohelper.setActive(arg_12_0._gostage, not var_12_1)
	gohelper.setActive(arg_12_0._goaltitudeContent, not var_12_1)
	TaskDispatcher.cancelTask(arg_12_0.refreshLockTip, arg_12_0)
	TaskDispatcher.runRepeat(arg_12_0.refreshLockTip, arg_12_0, 1)
	arg_12_0:refreshLockTip()

	local var_12_2 = TowerPermanentModel.instance:getCurSelectStage()

	if not var_12_1 and arg_12_0.mo.stage == var_12_2 then
		arg_12_0:createOrRefreshAltitudeItem()
		arg_12_0:moveToTop()
	end
end

function var_0_0.refreshLockTip(arg_13_0)
	arg_13_0._txtlockTip.text = ""

	local var_13_0, var_13_1 = arg_13_0.mo:checkIsOnline()
	local var_13_2 = TowerConfig.instance:getTowerPermanentTimeCo(arg_13_0.mo.stage)

	if tabletool.len(arg_13_0.configList) == 0 then
		if var_13_0 then
			local var_13_3 = TowerConfig.instance:getTowerPermanentTimeCo(arg_13_0.mo.stage - 1)

			arg_13_0._txtlockTip.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towerpermanent_stageunlocktip"), {
				var_13_3.name,
				var_13_2.name
			})
		else
			local var_13_4, var_13_5 = TimeUtil.secondToRoughTime2(var_13_1)

			arg_13_0._txtlockTip.text = GameUtil.getSubPlaceholderLuaLang(luaLang("towerpermanent_timeunlocktip"), {
				var_13_4,
				var_13_5,
				var_13_2.name
			})
		end
	end
end

function var_0_0.createOrRefreshAltitudeItem(arg_14_0)
	arg_14_0.altitudeItemTab = arg_14_0:getUserDataTb_()

	local var_14_0, var_14_1 = TowerPermanentModel.instance:getRealSelectStage()

	for iter_14_0, iter_14_1 in pairs(arg_14_0.configList) do
		local var_14_2 = arg_14_0._view.viewContainer:getTowerPermanentPoolView():createOrGetAltitudeItem(iter_14_1, arg_14_0._btnAltitudeItemClick, arg_14_0)

		arg_14_0.altitudeItemTab[iter_14_0] = var_14_2
		var_14_2.isSelect = arg_14_0.mo.stage == var_14_0 and iter_14_0 == var_14_1
		var_14_2.txtNum.text = string.format("%sM", iter_14_1.layerId * 10)

		arg_14_0:refreshSelectUI(var_14_2, iter_14_1)
		gohelper.setActive(var_14_2.go, true)
		var_14_2.go.transform:SetParent(arg_14_0._goaltitudeContent.transform, false)
		recthelper.setAnchor(var_14_2.go.transform, 0, 0)
		ZProj.UGUIHelper.RebuildLayout(arg_14_0._goaltitudeContent.transform)
	end

	arg_14_0._view.viewContainer:getTowerPermanentPoolView():recycleAltitudeItem(arg_14_0.configList)
end

function var_0_0.refreshSelectUI(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_2.isElite == 1
	local var_15_1 = arg_15_2.layerId <= TowerPermanentModel.instance.curPassLayer

	gohelper.setActive(arg_15_1.goNormal, not var_15_0)
	gohelper.setActive(arg_15_1.goElite, var_15_0)
	gohelper.setActive(arg_15_1.goNormalSelect, arg_15_1.isSelect and not var_15_0)
	gohelper.setActive(arg_15_1.goEliteSelect, arg_15_1.isSelect and var_15_0)

	arg_15_1.txtNum.fontSize = arg_15_1.isSelect and var_0_0.selectFontSize or var_0_0.unselectFontSize

	local var_15_2 = arg_15_1.isSelect and var_0_0.selectFontPos or var_0_0.normalFontPos
	local var_15_3 = "#FFFFFF"

	if arg_15_1.isSelect then
		var_15_3 = var_0_0.selectFontColor
	else
		var_15_3 = var_15_1 and var_0_0.finishFontColor or var_0_0.unFinishFontColor
	end

	local var_15_4 = TowerPermanentModel.instance:checkLayerUnlock(arg_15_2)

	arg_15_1.itemCanvasGroup.alpha = not var_15_4 and not arg_15_1.isSelect and 0.5 or 1

	SLFramework.UGUI.GuiHelper.SetColor(arg_15_1.txtNum, var_15_3)
	recthelper.setAnchor(arg_15_1.txtNum.transform, var_15_2.x, var_15_2.y)
	gohelper.setActive(arg_15_1.goNormalUnFinish, not var_15_1 and not var_15_0 and not arg_15_1.isSelect)
	gohelper.setActive(arg_15_1.goNormalFinish, var_15_1 and not var_15_0)
	gohelper.setActive(arg_15_1.goEliteUnFinish, not var_15_1 and var_15_0 and not arg_15_1.isSelect)
	gohelper.setActive(arg_15_1.goEliteFinish, var_15_1 and var_15_0)
	gohelper.setActive(arg_15_1.goArrow, false)
	gohelper.setActive(arg_15_1.goNormalLock, not var_15_4 and not var_15_0 and not arg_15_1.isSelect)
	gohelper.setActive(arg_15_1.goEliteLock, not var_15_4 and var_15_0 and not arg_15_1.isSelect)

	if not string.nilorempty(arg_15_2.spReward) then
		transformhelper.setLocalScale(arg_15_1.simageReward.gameObject.transform, 1, 1, 1)
		gohelper.setActive(arg_15_1.goReward, not arg_15_1.isSelect and not var_15_1)

		local var_15_5 = string.splitToNumber(arg_15_2.spReward, "#")
		local var_15_6, var_15_7 = ItemModel.instance:getItemConfigAndIcon(var_15_5[1], var_15_5[2])

		if var_15_6.subType == ItemEnum.SubType.Portrait then
			var_15_7 = ResUrl.getPlayerHeadIcon(var_15_6.icon)

			transformhelper.setLocalScale(arg_15_1.simageReward.gameObject.transform, 0.7, 0.7, 0.7)
		end

		arg_15_1.simageReward:LoadImage(var_15_7)
	else
		gohelper.setActive(arg_15_1.goReward, false)
	end
end

function var_0_0.playFinishEffect(arg_16_0, arg_16_1)
	local var_16_0 = TowerConfig.instance:getPermanentEpisodeCo(arg_16_1)
	local var_16_1 = var_16_0.index
	local var_16_2

	for iter_16_0, iter_16_1 in pairs(arg_16_0.configList) do
		if iter_16_1.layerId == arg_16_1 then
			var_16_2 = arg_16_0._view.viewContainer:getTowerPermanentPoolView():createOrGetAltitudeItem(iter_16_1, arg_16_0._btnAltitudeItemClick, arg_16_0)

			break
		end
	end

	if not var_16_2 then
		return
	end

	if var_16_0.isElite == 1 then
		var_16_2.animEliteFinish:Play("in", 0, 0)
	else
		var_16_2.animNormalFinish:Play("in", 0, 0)
	end

	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_single_star)
end

function var_0_0.refreshAltitudeContentH(arg_17_0)
	if arg_17_0.playingAnim then
		return
	end

	arg_17_0.altitudeContentH = arg_17_0.mo:getAltitudeHeight(arg_17_0.isUnFold)

	recthelper.setHeight(arg_17_0.altitudeContentRect, arg_17_0.altitudeContentH)
end

function var_0_0.doUnFoldAnim(arg_18_0)
	UIBlockMgr.instance:startBlock(var_0_0.animFoldBlock)

	arg_18_0.scrollCategory.movementType = 2
	arg_18_0.altitudeContentH = arg_18_0.mo:getAltitudeHeight(arg_18_0.isUnFold)
	arg_18_0._foldAnimTweenId = ZProj.TweenHelper.DOTweenFloat(0, arg_18_0.altitudeContentH, arg_18_0.altitudeContentH * 0.0003, arg_18_0._onFoldTweenFrameCallback, arg_18_0._onUnFoldTweenFinishCallback, arg_18_0, nil)
end

function var_0_0.doFoldAnim(arg_19_0)
	UIBlockMgr.instance:startBlock(var_0_0.animFoldBlock)

	arg_19_0.scrollCategory.movementType = 2
	arg_19_0._foldAnimTweenId = ZProj.TweenHelper.DOTweenFloat(arg_19_0.altitudeContentH, 0, arg_19_0.altitudeContentH * 0.0001, arg_19_0._onFoldTweenFrameCallback, arg_19_0._onFoldTweenFinishCallback, arg_19_0, nil)
end

function var_0_0._onFoldTweenFrameCallback(arg_20_0, arg_20_1)
	arg_20_0.playingAnim = true

	arg_20_0:moveToTop()

	local var_20_0 = TowerPermanentModel.instance:checkhasLockTip() and TowerEnum.PermanentUI.LockTipH or 0
	local var_20_1 = arg_20_0.stageCount - arg_20_0.mo.stage + 1
	local var_20_2 = Mathf.Min(TowerEnum.PermanentUI.StageTitleH * var_20_1 + var_20_0 + arg_20_1, TowerEnum.PermanentUI.ScrollH)

	recthelper.setHeight(arg_20_0.rectViewPort, var_20_2)
	arg_20_0.mo:overrideStageHeight(arg_20_1)
	recthelper.setHeight(arg_20_0.altitudeContentRect, arg_20_1)
	TowerPermanentModel.instance:onModelUpdate()
end

function var_0_0._onFoldTweenFinishCallback(arg_21_0)
	arg_21_0.playingAnim = false

	UIBlockMgr.instance:endBlock(var_0_0.animFoldBlock)
	TowerPermanentModel.instance:setCurSelectStage(arg_21_0.stageCount)
	TowerController.instance:dispatchEvent(TowerEvent.UnFoldMaxStage)
end

function var_0_0.moveToTop(arg_22_0)
	local var_22_0 = TowerEnum.PermanentUI.StageTitleH * Mathf.Max(arg_22_0.mo.stage - 2, 0)

	recthelper.setAnchorY(arg_22_0.rectScrollContent, var_22_0)
end

function var_0_0._onUnFoldTweenFinishCallback(arg_23_0)
	arg_23_0.playingAnim = false

	UIBlockMgr.instance:endBlock(var_0_0.animFoldBlock)
	arg_23_0:moveToTop()
	arg_23_0.mo:cleanCurUnFoldingH()
	arg_23_0:refreshAltitudeContentH()
	TowerPermanentModel.instance:onModelUpdate()

	arg_23_0.scrollCategory.movementType = 1
end

function var_0_0.onDestroy(arg_24_0)
	if arg_24_0._foldAnimTweenId then
		ZProj.TweenHelper.KillById(arg_24_0._foldAnimTweenId)

		arg_24_0._foldAnimTweenId = nil
	end

	TaskDispatcher.cancelTask(arg_24_0.refreshLockTip, arg_24_0)
	UIBlockMgr.instance:endBlock(var_0_0.animFoldBlock)
end

return var_0_0
