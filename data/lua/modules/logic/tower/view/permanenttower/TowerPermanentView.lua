module("modules.logic.tower.view.permanenttower.TowerPermanentView", package.seeall)

local var_0_0 = class("TowerPermanentView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")
	arg_1_0._scrollcategory = gohelper.findChildScrollRect(arg_1_0.viewGO, "Left/#scroll_category")
	arg_1_0._goViewport = gohelper.findChild(arg_1_0.viewGO, "Left/#scroll_category/Viewport")
	arg_1_0._goContent = gohelper.findChild(arg_1_0.viewGO, "Left/#scroll_category/Viewport/#go_Content")
	arg_1_0._goStageInfo = gohelper.findChild(arg_1_0.viewGO, "Left/#go_stageInfo")
	arg_1_0._txtCurStage = gohelper.findChildText(arg_1_0.viewGO, "Left/#go_stageInfo/#txt_curStage")
	arg_1_0._btnCurStageFold = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#go_stageInfo/#btn_curStageFold")
	arg_1_0._gonormalEpisode = gohelper.findChild(arg_1_0.viewGO, "episode/#go_normalEpisode")
	arg_1_0._gonormalItem = gohelper.findChild(arg_1_0.viewGO, "episode/#go_normalEpisode/#go_normalItem")
	arg_1_0._goeliteEpisode = gohelper.findChild(arg_1_0.viewGO, "episode/#go_eliteEpisode")
	arg_1_0._gocompleted = gohelper.findChild(arg_1_0.viewGO, "episode/layout/#go_completed")
	arg_1_0._animCompleted = arg_1_0._gocompleted:GetComponent(gohelper.Type_Animator)
	arg_1_0._goschedule = gohelper.findChild(arg_1_0.viewGO, "episode/layout/#go_schedule")
	arg_1_0._txtschedule = gohelper.findChildText(arg_1_0.viewGO, "episode/layout/#go_schedule/bg/#txt_Schedule")
	arg_1_0._goreward = gohelper.findChild(arg_1_0.viewGO, "#go_reward")
	arg_1_0._gorewardItem = gohelper.findChild(arg_1_0.viewGO, "#go_reward/#go_rewardItem")
	arg_1_0._simageEnterBg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_Enter/#simage_EnterBG")
	arg_1_0._txtEnterTitle = gohelper.findChildText(arg_1_0.viewGO, "#go_Enter/Title/txt_Title")
	arg_1_0._txtEnterTitleEn = gohelper.findChildText(arg_1_0.viewGO, "#go_Enter/Title/txt_TitleEn")
	arg_1_0._txtTitle = gohelper.findChildText(arg_1_0.viewGO, "Title/txt_Title")
	arg_1_0._txtTitleEn = gohelper.findChildText(arg_1_0.viewGO, "Title/txt_TitleEn")
	arg_1_0._viewAnim = arg_1_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_1_0._godeep = gohelper.findChild(arg_1_0.viewGO, "#go_deep")
	arg_1_0._goepisode = gohelper.findChild(arg_1_0.viewGO, "episode")
	arg_1_0._gotitle = gohelper.findChild(arg_1_0.viewGO, "Title")
	arg_1_0._gorewardBg = gohelper.findChild(arg_1_0.viewGO, "image_RewardBG")
	arg_1_0._goright = gohelper.findChild(arg_1_0.viewGO, "right")
	arg_1_0._goenterDeepGuide = gohelper.findChild(arg_1_0.viewGO, "#go_EnterDeepGuide")
	arg_1_0.enterDeepGuideAnim = arg_1_0._goenterDeepGuide:GetComponent(gohelper.Type_Animator)
	arg_1_0._godeepLayer = gohelper.findChild(arg_1_0.viewGO, "Left/#go_deepLayer")
	arg_1_0._godeepNormal = gohelper.findChild(arg_1_0.viewGO, "Left/#go_deepLayer/#go_deepNormal")
	arg_1_0._godeepSelect = gohelper.findChild(arg_1_0.viewGO, "Left/#go_deepLayer/#go_deepSelect")
	arg_1_0._btndeepLayer = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#go_deepLayer/#btn_deepLayer")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._scrollcategory:AddOnValueChanged(arg_2_0._onScrollChange, arg_2_0)
	arg_2_0._btnCurStageFold:AddClickListener(arg_2_0._btnCurStageFoldOnClick, arg_2_0)
	arg_2_0._btndeepLayer:AddClickListener(arg_2_0._btndeepLayerOnClick, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.SelectPermanentAltitude, arg_2_0.selectPermanentAltitude, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.OnSelectDeepLayer, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.OnTowerResetSubEpisode, arg_2_0.refreshEpisode, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.DailyReresh, arg_2_0.onDailyRefresh, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.OnCloseEnterDeepGuideView, arg_2_0.enterDeepGuideFinish, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._scrollcategory:RemoveOnValueChanged()
	arg_3_0._btnCurStageFold:RemoveClickListener()
	arg_3_0._btndeepLayer:RemoveClickListener()
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.SelectPermanentAltitude, arg_3_0.selectPermanentAltitude, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.OnSelectDeepLayer, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.OnTowerResetSubEpisode, arg_3_0.refreshEpisode, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.DailyReresh, arg_3_0.onDailyRefresh, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.OnCloseEnterDeepGuideView, arg_3_0.enterDeepGuideFinish, arg_3_0)
end

var_0_0.maxStageCount = 6
var_0_0.showNextStageTitleTime = 0.4
var_0_0.selectNextStageTime = 0.7
var_0_0.selectNextLayerTime = 1
var_0_0.animBlockName = "TowerPermanentViewAnimBlock"

function var_0_0._btnEliteEpisodeItemClick(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0.curSelectEpisodeIndex == arg_4_1 then
		return
	end

	local var_4_0 = arg_4_0.episodeIdList[arg_4_1]
	local var_4_1 = arg_4_0.eliteItemTab[arg_4_0.layerConfig.layerId]

	arg_4_0.curSelectEpisodeIndex = arg_4_1

	for iter_4_0, iter_4_1 in pairs(var_4_1) do
		iter_4_1.isSelect = iter_4_0 == arg_4_1

		gohelper.setActive(iter_4_1.goSelect, iter_4_1.isSelect)
		gohelper.setActive(iter_4_1.imageSelectFinishIcon.gameObject, iter_4_1.isFinish)
		gohelper.setActive(iter_4_1.goFinish, iter_4_1.isFinish and not iter_4_1.isSelect)
	end

	TowerPermanentModel.instance:setCurSelectEpisodeId(var_4_0)

	if not arg_4_2 then
		arg_4_0._viewAnim:Play("switchright", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_ripple)
	else
		TowerController.instance:dispatchEvent(TowerEvent.SelectPermanentEpisode)
	end
end

function var_0_0._btnNormalEpisodeItemClick(arg_5_0, arg_5_1)
	arg_5_0.normalEpisodeItem.isSelect = true

	gohelper.setActive(arg_5_0.normalEpisodeItem.goSelect, arg_5_0.normalEpisodeItem.isSelect)
	TowerPermanentModel.instance:setCurSelectEpisodeId(arg_5_1)
	TowerController.instance:dispatchEvent(TowerEvent.SelectPermanentEpisode)
end

function var_0_0._btnCurStageFoldOnClick(arg_6_0)
	arg_6_0.scrollCategoryRect.velocity = Vector2(0, 0)

	local var_6_0 = TowerPermanentModel.instance:getCurSelectStage()

	TowerController.instance:dispatchEvent(TowerEvent.FoldCurStage, var_6_0)
end

function var_0_0._btndeepLayerOnClick(arg_7_0)
	if TowerPermanentDeepModel.instance:getIsSelectDeepCategory() then
		return
	end

	if not TowerPermanentDeepModel.instance:getIsInDeepLayerState() then
		arg_7_0._viewAnim:Play("openenterdeep", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_bubbles)
		AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_mingdi_boss_enter)
	end

	TowerPermanentDeepModel.instance:setInDeepLayerState(true)
	TowerPermanentDeepModel.instance:setIsSelectDeepCategory(true)
	TowerController.instance:dispatchEvent(TowerEvent.OnSelectDeepLayer)

	local var_7_0 = TowerPermanentModel.instance:getCurUnfoldStage()
	local var_7_1, var_7_2 = TowerPermanentModel.instance:getNewtStageAndLayer()

	if var_7_0 == var_7_1 then
		arg_7_0._scrollcategory.verticalNormalizedPosition = 0
	else
		arg_7_0._scrollcategory.verticalNormalizedPosition = 1

		TowerPermanentModel.instance:onModelUpdate()
		TowerController.instance:dispatchEvent(TowerEvent.FoldCurStage, var_7_0)
	end
end

function var_0_0.onDailyRefresh(arg_8_0)
	if TowerPermanentModel.instance:isNewStage() then
		arg_8_0._scrollcategory.verticalNormalizedPosition = 1

		TowerPermanentModel.instance:onModelUpdate()

		local var_8_0 = TowerPermanentModel.instance:getCurUnfoldStage()

		TowerController.instance:dispatchEvent(TowerEvent.FoldCurStage, var_8_0)
	end

	arg_8_0.scrollCategoryRect.velocity = Vector2(0, 0)

	arg_8_0:refreshUI()
end

function var_0_0._editableInitView(arg_9_0)
	arg_9_0._rectContent = arg_9_0._goContent:GetComponent(gohelper.Type_RectTransform)
	arg_9_0._viewportMask2D = arg_9_0._goViewport:GetComponent(gohelper.Type_RectMask2D)
	arg_9_0.scrollCategoryRect = arg_9_0._scrollcategory:GetComponent(typeof(UnityEngine.UI.ScrollRect))
	arg_9_0._animEventWrap = arg_9_0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	arg_9_0._animEventWrap:AddEventListener("switch", arg_9_0.refreshUI, arg_9_0)

	arg_9_0._bgAnim = gohelper.findChild(arg_9_0.viewGO, "Bg"):GetComponent(gohelper.Type_Animator)
	arg_9_0.deepLayerAnim = gohelper.findChildComponent(arg_9_0.viewGO, "Left/#go_deepLayer/#go_deepNormal", gohelper.Type_Animation)
	arg_9_0.eliteItemTab = arg_9_0:getUserDataTb_()
	arg_9_0.eliteItemPosTab = arg_9_0:getUserDataTb_()
	arg_9_0.rewardTab = arg_9_0:getUserDataTb_()
	arg_9_0.eliteBgAnimTab = arg_9_0:getUserDataTb_()

	gohelper.setActive(arg_9_0._goeliteItem, false)
	gohelper.setActive(arg_9_0._gorewardItem, false)

	arg_9_0.tempDeepGuideFinish = false

	for iter_9_0 = 1, var_0_0.maxStageCount do
		local var_9_0 = {
			go = gohelper.findChild(arg_9_0.viewGO, "Bg/" .. iter_9_0 .. "/#go_Elitebg")
		}

		arg_9_0.eliteBgAnimTab[iter_9_0] = var_9_0

		gohelper.setActive(var_9_0.go, false)
	end

	for iter_9_1 = 2, var_0_0.maxStageCount do
		local var_9_1 = {
			go = gohelper.findChild(arg_9_0.viewGO, "episode/#go_eliteEpisode/#go_elite" .. iter_9_1),
			posTab = {}
		}

		for iter_9_2 = 1, iter_9_1 do
			local var_9_2 = gohelper.findChild(var_9_1.go, "go_pos" .. iter_9_2)

			var_9_1.posTab[iter_9_2] = var_9_2
		end

		arg_9_0.eliteItemPosTab[iter_9_1] = var_9_1
	end

	arg_9_0:initNormalEpisodeItem()
	TowerPermanentModel.instance:setCurSelectEpisodeId(0)

	arg_9_0.deepGuideId = TowerDeepConfig.instance:getConstConfigValue(TowerDeepEnum.ConstId.FirstEnterDeepGuideId)
end

function var_0_0.initNormalEpisodeItem(arg_10_0)
	arg_10_0.normalEpisodeItem = arg_10_0:getUserDataTb_()
	arg_10_0.normalEpisodeItem.go = arg_10_0._gonormalItem
	arg_10_0.normalEpisodeItem.imageIcon = gohelper.findChildImage(arg_10_0.normalEpisodeItem.go, "image_icon")
	arg_10_0.normalEpisodeItem.goSelect = gohelper.findChild(arg_10_0.normalEpisodeItem.go, "go_select")
	arg_10_0.normalEpisodeItem.imageSelectIcon = gohelper.findChildImage(arg_10_0.normalEpisodeItem.go, "go_select/image_selectIcon")
	arg_10_0.normalEpisodeItem.imageSelectFinishIcon = gohelper.findChildImage(arg_10_0.normalEpisodeItem.go, "go_select/image_selectFinishIcon")
	arg_10_0.normalEpisodeItem.goFinish = gohelper.findChild(arg_10_0.normalEpisodeItem.go, "go_finish")
	arg_10_0.normalEpisodeItem.imageFinishIcon = gohelper.findChildImage(arg_10_0.normalEpisodeItem.go, "go_finish/image_finishIcon")
	arg_10_0.normalEpisodeItem.txtName = gohelper.findChildText(arg_10_0.normalEpisodeItem.go, "txt_name")
	arg_10_0.normalEpisodeItem.btnClick = gohelper.findChildButtonWithAudio(arg_10_0.normalEpisodeItem.go, "btn_click")
	arg_10_0.normalEpisodeItem.goFinishEffect = gohelper.findChild(arg_10_0.normalEpisodeItem.go, "go_finishEffect")
end

function var_0_0.onUpdateParam(arg_11_0)
	return
end

function var_0_0._onScrollChange(arg_12_0, arg_12_1)
	local var_12_0 = TowerPermanentModel.instance:getCurSelectStage()
	local var_12_1 = TowerPermanentModel.instance:getStageCount()

	gohelper.setActive(arg_12_0._btnCurStageFold.gameObject, var_12_0 < var_12_1)

	local var_12_2 = recthelper.getAnchorY(arg_12_0._rectContent) > (var_12_0 - 1) * TowerEnum.PermanentUI.StageTitleH

	gohelper.setActive(arg_12_0._goStageInfo, var_12_2)

	local var_12_3 = TowerConfig.instance:getTowerPermanentTimeCo(var_12_0)

	arg_12_0._txtCurStage.text = var_12_3.name

	local var_12_4 = var_12_2 and TowerEnum.PermanentUI.StageTitleH or 0

	arg_12_0._viewportMask2D.padding = Vector4(0, 0, -150, var_12_4)
end

function var_0_0.onOpen(arg_13_0)
	arg_13_0.jumpParam = arg_13_0.viewParam or {}

	gohelper.setActive(arg_13_0._goStageInfo, false)
	arg_13_0:refreshUI()

	if arg_13_0.canShowDeep then
		local var_13_0, var_13_1 = TowerPermanentModel.instance:getRealSelectStage()

		arg_13_0:scrollMoveToTargetLayer(var_13_0, var_13_1)
	else
		arg_13_0:scrollMoveToTargetLayer()
	end

	if tabletool.len(arg_13_0.jumpParam) > 0 then
		arg_13_0._viewAnim:Play("opennormal", 0, 0)
	elseif arg_13_0.isDeepLayerUnlock and not arg_13_0.isEnterDeepGuideFinish then
		-- block empty
	else
		arg_13_0._viewAnim:Play(arg_13_0.canShowDeep and "openenterdeep" or "openenter", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_bubbles)

		if arg_13_0.canShowDeep then
			AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_mingdi_boss_enter)
		end
	end

	local var_13_2 = TowerModel.instance:getCurPermanentMo()
	local var_13_3 = TowerPermanentModel.instance:getLocalPassLayer()

	if not var_13_3 or var_13_3 == -1 then
		TowerPermanentModel.instance:setLocalPassLayer(var_13_2.passLayerId)
	end

	if arg_13_0.jumpParam and arg_13_0.jumpParam.episodeId and arg_13_0.layerConfig and arg_13_0.layerConfig.isElite == 1 then
		for iter_13_0, iter_13_1 in ipairs(arg_13_0.episodeIdList) do
			if iter_13_1 == arg_13_0.jumpParam.episodeId then
				arg_13_0:_btnEliteEpisodeItemClick(iter_13_0, true)

				break
			end
		end

		local var_13_4 = TowerPermanentModel.instance:getFirstUnFinishEipsode(arg_13_0.jumpParam.layerId)

		if var_13_4 then
			arg_13_0.nextUnfinishEpisodeId = var_13_4.episodeId

			TaskDispatcher.runDelay(arg_13_0.selectNextEpisode, arg_13_0, 1)
			UIBlockMgr.instance:startBlock(var_0_0.animBlockName)
			UIBlockMgrExtend.setNeedCircleMv(false)
		end
	end

	if arg_13_0.jumpParam and arg_13_0.jumpParam.episodeId and TowerPermanentModel.instance:isNewPassLayer() then
		UIBlockMgr.instance:startBlock(var_0_0.animBlockName)
		UIBlockMgrExtend.setNeedCircleMv(false)
		gohelper.setActive(arg_13_0._gocompleted, false)

		local var_13_5, var_13_6, var_13_7 = TowerPermanentModel.instance:isNewStage()

		if var_13_7 == var_13_6 and var_13_7 > 1 then
			arg_13_0._bgAnim:Play(var_13_7 - 1 .. "to" .. var_13_7, 0, 1)
		end

		for iter_13_2, iter_13_3 in pairs(arg_13_0.rewardTab) do
			gohelper.setActive(iter_13_3.goHasGet, false)
		end

		TaskDispatcher.runDelay(arg_13_0.playFinishEffect, arg_13_0, 1)
	end
end

function var_0_0.playFinishEffect(arg_14_0)
	gohelper.setActive(arg_14_0._gocompleted, arg_14_0.isAllFinish)
	gohelper.setActive(arg_14_0._goschedule, arg_14_0.layerConfig.isElite == 1 and not arg_14_0.isAllFinish)
	arg_14_0._animCompleted:Play("in", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_complete)

	for iter_14_0, iter_14_1 in pairs(arg_14_0.rewardTab) do
		gohelper.setActive(iter_14_1.goHasGet, true)
		iter_14_1.animHasGet:Play("go_hasget_in", 0, 0)
	end

	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_award)
	TowerController.instance:dispatchEvent(TowerEvent.PermanentTowerFinishLayer, arg_14_0.jumpParam.layerId)

	if arg_14_0.isDeepLayerUnlock and not arg_14_0.isEnterDeepGuideFinish then
		gohelper.setActive(arg_14_0._godeepLayer, true)
		arg_14_0.deepLayerAnim:Play()
		TaskDispatcher.runDelay(arg_14_0.enterDeepGuide, arg_14_0, 1)
	else
		local var_14_0, var_14_1, var_14_2 = TowerPermanentModel.instance:isNewStage()

		arg_14_0.isNewStageInfo = {
			isNewStage = var_14_0,
			maxStage = var_14_1
		}

		if var_14_0 then
			arg_14_0._bgAnim:Play(var_14_2 .. "to" .. var_14_1, 0, 0)

			if TowerConfig.instance:getPermanentEpisodeCo(arg_14_0.jumpParam.layerId).isElite == 1 then
				gohelper.setActive(arg_14_0.eliteBgAnimTab[var_14_2].go, true)
			end
		elseif var_14_2 == var_14_1 and var_14_2 > 1 then
			arg_14_0._bgAnim:Play(var_14_2 - 1 .. "to" .. var_14_2, 0, 1)
		end

		arg_14_0:setNewStageAndLayer(var_14_0)

		local var_14_3 = TowerModel.instance:getCurPermanentMo()

		TowerPermanentModel.instance:setLocalPassLayer(var_14_3.passLayerId)
	end
end

function var_0_0.enterDeepGuide(arg_15_0)
	arg_15_0:doEnterDeepGuide(true)
end

function var_0_0.setNewStageAndLayer(arg_16_0, arg_16_1)
	local var_16_0, var_16_1 = TowerPermanentModel.instance:getNewtStageAndLayer()

	arg_16_0.animPermanentEpisodeCo = TowerConfig.instance:getPermanentEpisodeLayerCo(var_16_0, var_16_1)

	if arg_16_1 then
		arg_16_0:refreshEnterTitle(var_16_0)
		TaskDispatcher.runDelay(arg_16_0.showNextStageTitleAnim, arg_16_0, var_0_0.showNextStageTitleTime)
		TaskDispatcher.runDelay(arg_16_0._btnCurStageFoldOnClick, arg_16_0, var_0_0.selectNextStageTime)
		TaskDispatcher.runDelay(arg_16_0.permanentSelectNextLayer, arg_16_0, var_0_0.selectNextStageTime + var_0_0.selectNextLayerTime)
	else
		TaskDispatcher.runDelay(arg_16_0.permanentSelectNextLayer, arg_16_0, var_0_0.selectNextLayerTime)
	end
end

function var_0_0.showNextStageTitleAnim(arg_17_0)
	if arg_17_0.isNewStageInfo and arg_17_0.isNewStageInfo.isNewStage then
		arg_17_0._viewAnim:Play("switchfloor", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_bubbles)
	end
end

function var_0_0.selectNextEpisode(arg_18_0)
	if arg_18_0.nextUnfinishEpisodeId > 0 then
		for iter_18_0, iter_18_1 in ipairs(arg_18_0.episodeIdList) do
			if iter_18_1 == arg_18_0.nextUnfinishEpisodeId then
				arg_18_0:_btnEliteEpisodeItemClick(iter_18_0, false)

				break
			end
		end
	end

	UIBlockMgr.instance:endBlock(var_0_0.animBlockName)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function var_0_0.permanentSelectNextLayer(arg_19_0)
	UIBlockMgr.instance:endBlock(var_0_0.animBlockName)
	UIBlockMgrExtend.setNeedCircleMv(true)
	TowerController.instance:dispatchEvent(TowerEvent.PermanentSelectNextLayer, arg_19_0.animPermanentEpisodeCo)
end

function var_0_0.selectPermanentAltitude(arg_20_0)
	arg_20_0.curSelectEpisodeIndex = 0

	if not arg_20_0.isNewStageInfo or tabletool.len(arg_20_0.isNewStageInfo) == 0 or not arg_20_0.isNewStageInfo.isNewStage then
		arg_20_0._viewAnim:Play(UIAnimationName.Switch, 0, 0)
	else
		arg_20_0.isNewStageInfo = nil

		arg_20_0:refreshUI()
	end
end

function var_0_0.selectUnfinishEpisode(arg_21_0)
	if arg_21_0.layerConfig.isElite == 1 then
		local var_21_0 = TowerPermanentModel.instance:getFirstUnFinishEipsode(arg_21_0.layerConfig.layerId)

		if var_21_0 then
			for iter_21_0, iter_21_1 in ipairs(arg_21_0.episodeIdList) do
				if iter_21_1 == var_21_0.episodeId then
					arg_21_0:_btnEliteEpisodeItemClick(iter_21_0, true)

					break
				end
			end
		end
	end
end

function var_0_0.refreshUI(arg_22_0)
	arg_22_0:refreshDeepLayer()

	if not arg_22_0.canShowDeep then
		arg_22_0:refreshEpisode()
		arg_22_0:refreshReward()
		arg_22_0:selectUnfinishEpisode()
		arg_22_0:refreshStageItemEffect()
		arg_22_0:refreshEnterTitle()
		arg_22_0:doEnterDeepGuide()
	end
end

function var_0_0.refreshDeepLayer(arg_23_0)
	arg_23_0.isDeepLayerUnlock = TowerPermanentDeepModel.instance:checkDeepLayerUnlock()
	arg_23_0.isEnterDeepGuideFinish = TowerPermanentDeepModel.instance:checkEnterDeepLayerGuideFinish() or arg_23_0.tempDeepGuideFinish
	arg_23_0.isInDeepLayer = TowerPermanentDeepModel.instance:getIsInDeepLayerState()
	arg_23_0.canShowDeep = arg_23_0.isDeepLayerUnlock and arg_23_0.isEnterDeepGuideFinish and arg_23_0.isInDeepLayer

	gohelper.setActive(arg_23_0._godeep, arg_23_0.canShowDeep)
	gohelper.setActive(arg_23_0._goepisode, not arg_23_0.canShowDeep)
	gohelper.setActive(arg_23_0._gotitle, not arg_23_0.canShowDeep)
	gohelper.setActive(arg_23_0._gorewardBg, not arg_23_0.canShowDeep)
	gohelper.setActive(arg_23_0._goreward, not arg_23_0.canShowDeep)
	gohelper.setActive(arg_23_0._goright, not arg_23_0.canShowDeep)

	local var_23_0 = TowerPermanentDeepModel.instance:getIsSelectDeepCategory()

	gohelper.setActive(arg_23_0._godeepSelect, var_23_0)
	gohelper.setActive(arg_23_0._godeepNormal, not var_23_0)
end

function var_0_0.doEnterDeepGuide(arg_24_0, arg_24_1)
	arg_24_0.isEnterDeepGuideFinish = TowerPermanentDeepModel.instance:checkEnterDeepLayerGuideFinish()

	if arg_24_0.isDeepLayerUnlock and not arg_24_0.isEnterDeepGuideFinish and (not arg_24_0.jumpParam or not arg_24_0.jumpParam.episodeId or arg_24_1) then
		arg_24_0:_btndeepLayerOnClick()
		TaskDispatcher.runDelay(arg_24_0.realEnterDeepGuide, arg_24_0, 1.5)
	end
end

function var_0_0.realEnterDeepGuide(arg_25_0)
	gohelper.setActive(arg_25_0._goenterDeepGuide, true)
	UIBlockMgr.instance:endBlock(var_0_0.animBlockName)
	UIBlockMgrExtend.setNeedCircleMv(true)
	TaskDispatcher.runDelay(arg_25_0.sendOnEnterDeepGuide, arg_25_0, 0.2)
end

function var_0_0.sendOnEnterDeepGuide(arg_26_0)
	TowerController.instance:dispatchEvent(TowerEvent.OnEnterDeepGuide)
end

function var_0_0.enterDeepGuideFinish(arg_27_0)
	arg_27_0.enterDeepGuideAnim:Play("close", 0, 0)
	arg_27_0.enterDeepGuideAnim:Update(0)
	TaskDispatcher.runDelay(arg_27_0.hideEnterDeepGuide, arg_27_0, 0.5)

	arg_27_0.tempDeepGuideFinish = true

	arg_27_0:refreshUI()
end

function var_0_0.hideEnterDeepGuide(arg_28_0)
	gohelper.setActive(arg_28_0._goenterDeepGuide, false)
end

function var_0_0.refreshStageItemEffect(arg_29_0)
	for iter_29_0 = 1, var_0_0.maxStageCount do
		gohelper.setActive(arg_29_0.eliteBgAnimTab[iter_29_0].go, iter_29_0 == arg_29_0.curStage and arg_29_0.layerConfig.isElite == 1)
	end
end

function var_0_0.refreshEnterTitle(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_1 or arg_30_0.curStage
	local var_30_1 = TowerConfig.instance:getTowerPermanentTimeCo(var_30_0)

	arg_30_0._txtEnterTitle.text = var_30_1.name
	arg_30_0._txtEnterTitleEn.text = var_30_1.nameEn

	arg_30_0._simageEnterBg:LoadImage(ResUrl.getTowerIcon("permanent/towerpermanent_bg" .. Mathf.Min(var_30_0, TowerDeepEnum.MaxNormalBgStage)))
end

function var_0_0.refreshEpisode(arg_31_0)
	local var_31_0, var_31_1 = TowerPermanentModel.instance:getRealSelectStage()

	arg_31_0.curStage = TowerPermanentModel.instance:getCurSelectStage()
	arg_31_0.curLayerIndex = TowerPermanentModel.instance:getCurSelectLayer()
	arg_31_0.realSelectLayerIndex = var_31_1
	arg_31_0.realselectStage = var_31_0
	arg_31_0.layerConfig = TowerConfig.instance:getPermanentEpisodeLayerCo(arg_31_0.realselectStage, arg_31_0.realSelectLayerIndex)
	arg_31_0.isAllFinish = arg_31_0.layerConfig.layerId <= TowerPermanentModel.instance.curPassLayer
	arg_31_0.episodeIdList = string.splitToNumber(arg_31_0.layerConfig.episodeIds, "|")

	local var_31_2 = #arg_31_0.episodeIdList
	local var_31_3 = arg_31_0.layerConfig.isElite == 1

	gohelper.setActive(arg_31_0._gonormalEpisode, not var_31_3)
	gohelper.setActive(arg_31_0._goeliteEpisode, var_31_3)
	gohelper.setActive(arg_31_0._goschedule, var_31_3 and not arg_31_0.isAllFinish)

	local var_31_4 = TowerConfig.instance:getTowerPermanentTimeCo(arg_31_0.curStage)

	arg_31_0._txtTitle.text = var_31_4.name
	arg_31_0._txtTitleEn.text = var_31_4.nameEn

	if arg_31_0.curStage > 1 then
		arg_31_0._bgAnim:Play(arg_31_0.curStage - 1 .. "to" .. arg_31_0.curStage, 0, 1)
	else
		arg_31_0._bgAnim:Play("1idle", 0, 1)
	end

	if var_31_3 then
		local var_31_5 = TowerModel.instance:getCurPermanentMo()
		local var_31_6 = var_31_5:getSubEpisodePassCount(arg_31_0.layerConfig.layerId)

		arg_31_0._txtschedule.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("towerpermanentresultview_schedule"), var_31_6, #arg_31_0.episodeIdList)

		for iter_31_0, iter_31_1 in ipairs(arg_31_0.episodeIdList) do
			local var_31_7 = arg_31_0.viewContainer:getTowerPermanentPoolView():createOrGetEliteEpisodeItem(iter_31_0, arg_31_0._btnEliteEpisodeItemClick, arg_31_0)

			if not arg_31_0.eliteItemTab[arg_31_0.layerConfig.layerId] then
				arg_31_0.eliteItemTab[arg_31_0.layerConfig.layerId] = {}
			end

			arg_31_0.eliteItemTab[arg_31_0.layerConfig.layerId][iter_31_0] = var_31_7

			gohelper.setActive(var_31_7.go, true)

			local var_31_8 = arg_31_0.eliteItemPosTab[var_31_2].posTab[iter_31_0]

			var_31_7.go.transform:SetParent(var_31_8.transform, false)
			recthelper.setAnchor(var_31_7.go.transform, 0, 0)

			local var_31_9 = var_31_5:getSubEpisodeMoByEpisodeId(iter_31_1)

			var_31_7.isFinish = var_31_9 and var_31_9.status == TowerEnum.PassEpisodeState.Pass

			gohelper.setActive(var_31_7.goFinish, var_31_7.isFinish)

			var_31_7.txtName.text = GameUtil.getRomanNums(iter_31_0)

			gohelper.setActive(var_31_7.imageSelectIcon.gameObject, not var_31_7.isFinish)
			gohelper.setActive(var_31_7.imageSelectFinishIcon.gameObject, var_31_7.isFinish)
			gohelper.setActive(var_31_7.goFinishEffect, var_31_7.isFinish)
			UISpriteSetMgr.instance:setTowerPermanentSprite(var_31_7.imageIcon, arg_31_0:getEliteEpisodeIconName(iter_31_0, TowerEnum.PermanentEliteEpisodeState.Normal), true)
			UISpriteSetMgr.instance:setTowerPermanentSprite(var_31_7.imageSelectIcon, arg_31_0:getEliteEpisodeIconName(iter_31_0, TowerEnum.PermanentEliteEpisodeState.NormalSelect), true)
			UISpriteSetMgr.instance:setTowerPermanentSprite(var_31_7.imageSelectFinishIcon, arg_31_0:getEliteEpisodeIconName(iter_31_0, TowerEnum.PermanentEliteEpisodeState.FinishSelect), true)
			UISpriteSetMgr.instance:setTowerPermanentSprite(var_31_7.imageFinishIcon, arg_31_0:getEliteEpisodeIconName(iter_31_0, TowerEnum.PermanentEliteEpisodeState.Finish), true)
		end

		arg_31_0.viewContainer:getTowerPermanentPoolView():recycleEliteEpisodeItem(arg_31_0.episodeIdList)

		for iter_31_2 = 2, 5 do
			gohelper.setActive(arg_31_0.eliteItemPosTab[iter_31_2].go, iter_31_2 == var_31_2)
		end

		if arg_31_0.curSelectEpisodeIndex and arg_31_0.curSelectEpisodeIndex > 0 then
			arg_31_0:_btnEliteEpisodeItemClick(arg_31_0.curSelectEpisodeIndex, true)
		else
			arg_31_0:_btnEliteEpisodeItemClick(1, true)
		end
	else
		UISpriteSetMgr.instance:setTowerPermanentSprite(arg_31_0.normalEpisodeItem.imageIcon, arg_31_0:getEliteEpisodeIconName(1, TowerEnum.PermanentEliteEpisodeState.Normal), true)
		UISpriteSetMgr.instance:setTowerPermanentSprite(arg_31_0.normalEpisodeItem.imageSelectIcon, arg_31_0:getEliteEpisodeIconName(1, TowerEnum.PermanentEliteEpisodeState.NormalSelect), true)
		UISpriteSetMgr.instance:setTowerPermanentSprite(arg_31_0.normalEpisodeItem.imageSelectFinishIcon, arg_31_0:getEliteEpisodeIconName(1, TowerEnum.PermanentEliteEpisodeState.FinishSelect), true)
		UISpriteSetMgr.instance:setTowerPermanentSprite(arg_31_0.normalEpisodeItem.imageFinishIcon, arg_31_0:getEliteEpisodeIconName(1, TowerEnum.PermanentEliteEpisodeState.Finish), true)

		arg_31_0.normalEpisodeItem.txtName.text = "ST - " .. arg_31_0.realSelectLayerIndex

		gohelper.setActive(arg_31_0.normalEpisodeItem.goSelect, true)
		gohelper.setActive(arg_31_0.normalEpisodeItem.imageSelectIcon.gameObject, not arg_31_0.isAllFinish)
		gohelper.setActive(arg_31_0.normalEpisodeItem.imageSelectFinishIcon.gameObject, arg_31_0.isAllFinish)
		gohelper.setActive(arg_31_0.normalEpisodeItem.goFinishEffect, arg_31_0.isAllFinish)
		gohelper.setActive(arg_31_0.normalEpisodeItem.goFinish, false)
		arg_31_0.normalEpisodeItem.btnClick:AddClickListener(arg_31_0._btnNormalEpisodeItemClick, arg_31_0, arg_31_0.episodeIdList[1])
		arg_31_0:_btnNormalEpisodeItemClick(arg_31_0.episodeIdList[1])
	end

	gohelper.setActive(arg_31_0._gocompleted, arg_31_0.isAllFinish)
end

function var_0_0.getEliteEpisodeIconName(arg_32_0, arg_32_1, arg_32_2)
	return string.format("towerpermanent_stage_%d_%d", arg_32_1, arg_32_2)
end

function var_0_0.refreshReward(arg_33_0)
	local var_33_0 = string.split(arg_33_0.layerConfig.firstReward, "|")

	gohelper.CreateObjList(arg_33_0, arg_33_0.rewardItemShow, var_33_0, arg_33_0._goreward, arg_33_0._gorewardItem)
end

function var_0_0.rewardItemShow(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	local var_34_0 = arg_34_0.rewardTab[arg_34_3]

	if not var_34_0 then
		var_34_0 = {
			itemPos = gohelper.findChild(arg_34_1, "go_rewardPos"),
			goHasGet = gohelper.findChild(arg_34_1, "go_rewardGet"),
			animHasGet = gohelper.findChild(arg_34_1, "go_rewardGet/icon/go_hasget"):GetComponent(gohelper.Type_Animator)
		}
		var_34_0.item = IconMgr.instance:getCommonPropItemIcon(var_34_0.itemPos)
		arg_34_0.rewardTab[arg_34_3] = var_34_0
	end

	local var_34_1 = string.splitToNumber(arg_34_2, "#")

	var_34_0.item:setMOValue(var_34_1[1], var_34_1[2], var_34_1[3])
	var_34_0.item:setHideLvAndBreakFlag(true)
	var_34_0.item:hideEquipLvAndBreak(true)
	var_34_0.item:setCountFontSize(51)
	gohelper.setActive(var_34_0.goHasGet, arg_34_0.isAllFinish)
end

function var_0_0.scrollMoveToTargetLayer(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = arg_35_1 or arg_35_0.realselectStage
	local var_35_1 = arg_35_2 or arg_35_0.realSelectLayerIndex
	local var_35_2 = (var_35_0 - 1) * TowerEnum.PermanentUI.StageTitleH + (var_35_1 - 1) * (TowerEnum.PermanentUI.SingleItemH + TowerEnum.PermanentUI.ItemSpaceH)
	local var_35_3 = TowerPermanentModel.instance:getCurContentTotalHeight() - (arg_35_0.isDeepLayerUnlock and TowerEnum.PermanentUI.DeepScrollH or TowerEnum.PermanentUI.ScrollH) + 1
	local var_35_4 = Mathf.Min(var_35_2, var_35_3)

	recthelper.setAnchorY(arg_35_0._goContent.transform, var_35_4)
	arg_35_0:_onScrollChange()
end

function var_0_0.onClose(arg_36_0)
	if arg_36_0.normalEpisodeItem.btnClick then
		arg_36_0.normalEpisodeItem.btnClick:RemoveClickListener()
	end

	TaskDispatcher.cancelTask(arg_36_0.showNextStageTitleAnim, arg_36_0)
	TaskDispatcher.cancelTask(arg_36_0._btnCurStageFoldOnClick, arg_36_0)
	TaskDispatcher.cancelTask(arg_36_0.permanentSelectNextLayer, arg_36_0)
	TaskDispatcher.cancelTask(arg_36_0.playFinishEffect, arg_36_0)
	TaskDispatcher.cancelTask(arg_36_0.selectNextEpisode, arg_36_0)
	TaskDispatcher.cancelTask(arg_36_0.sendOnEnterDeepGuide, arg_36_0)
	TaskDispatcher.cancelTask(arg_36_0.enterDeepGuide, arg_36_0)
	TaskDispatcher.cancelTask(arg_36_0.realEnterDeepGuide, arg_36_0)
	TaskDispatcher.cancelTask(arg_36_0.hideEnterDeepGuide, arg_36_0)
	UIBlockMgr.instance:endBlock(var_0_0.animBlockName)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function var_0_0.onDestroyView(arg_37_0)
	TowerPermanentModel.instance:cleanData()
	arg_37_0._simageEnterBg:UnLoadImage()
	arg_37_0._animEventWrap:RemoveAllEventListener()
	TowerModel.instance:cleanTrialData()
end

return var_0_0
