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

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._scrollcategory:AddOnValueChanged(arg_2_0._onScrollChange, arg_2_0)
	arg_2_0._btnCurStageFold:AddClickListener(arg_2_0._btnCurStageFoldOnClick, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.SelectPermanentAltitude, arg_2_0.selectPermanentAltitude, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.OnTowerResetSubEpisode, arg_2_0.refreshEpisode, arg_2_0)
	arg_2_0:addEventCb(TowerController.instance, TowerEvent.DailyReresh, arg_2_0.onDailyRefresh, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._scrollcategory:RemoveOnValueChanged()
	arg_3_0._btnCurStageFold:RemoveClickListener()
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.SelectPermanentAltitude, arg_3_0.selectPermanentAltitude, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.OnTowerResetSubEpisode, arg_3_0.refreshEpisode, arg_3_0)
	arg_3_0:removeEventCb(TowerController.instance, TowerEvent.DailyReresh, arg_3_0.onDailyRefresh, arg_3_0)
end

var_0_0.maxStageCount = 5
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

function var_0_0.onDailyRefresh(arg_7_0)
	if TowerPermanentModel.instance:isNewStage() then
		arg_7_0._scrollcategory.verticalNormalizedPosition = 1

		TowerPermanentModel.instance:onModelUpdate()

		local var_7_0 = TowerPermanentModel.instance:getCurUnfoldStage()

		TowerController.instance:dispatchEvent(TowerEvent.FoldCurStage, var_7_0)
	end

	arg_7_0.scrollCategoryRect.velocity = Vector2(0, 0)

	arg_7_0:refreshUI()
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0._rectContent = arg_8_0._goContent:GetComponent(gohelper.Type_RectTransform)
	arg_8_0._viewportMask2D = arg_8_0._goViewport:GetComponent(gohelper.Type_RectMask2D)
	arg_8_0.scrollCategoryRect = arg_8_0._scrollcategory:GetComponent(typeof(UnityEngine.UI.ScrollRect))
	arg_8_0._animEventWrap = arg_8_0.viewGO:GetComponent(typeof(ZProj.AnimationEventWrap))

	arg_8_0._animEventWrap:AddEventListener("switch", arg_8_0.refreshUI, arg_8_0)

	arg_8_0._bgAnim = gohelper.findChild(arg_8_0.viewGO, "Bg"):GetComponent(gohelper.Type_Animator)
	arg_8_0.eliteItemTab = arg_8_0:getUserDataTb_()
	arg_8_0.eliteItemPosTab = arg_8_0:getUserDataTb_()
	arg_8_0.rewardTab = arg_8_0:getUserDataTb_()
	arg_8_0.eliteBgAnimTab = arg_8_0:getUserDataTb_()

	gohelper.setActive(arg_8_0._goeliteItem, false)
	gohelper.setActive(arg_8_0._gorewardItem, false)

	for iter_8_0 = 1, var_0_0.maxStageCount do
		local var_8_0 = {
			go = gohelper.findChild(arg_8_0.viewGO, "Bg/" .. iter_8_0 .. "/#go_Elitebg")
		}

		arg_8_0.eliteBgAnimTab[iter_8_0] = var_8_0

		gohelper.setActive(var_8_0.go, false)
	end

	for iter_8_1 = 2, var_0_0.maxStageCount do
		local var_8_1 = {
			go = gohelper.findChild(arg_8_0.viewGO, "episode/#go_eliteEpisode/#go_elite" .. iter_8_1),
			posTab = {}
		}

		for iter_8_2 = 1, iter_8_1 do
			local var_8_2 = gohelper.findChild(var_8_1.go, "go_pos" .. iter_8_2)

			var_8_1.posTab[iter_8_2] = var_8_2
		end

		arg_8_0.eliteItemPosTab[iter_8_1] = var_8_1
	end

	arg_8_0:initNormalEpisodeItem()
	TowerPermanentModel.instance:setCurSelectEpisodeId(0)
end

function var_0_0.initNormalEpisodeItem(arg_9_0)
	arg_9_0.normalEpisodeItem = arg_9_0:getUserDataTb_()
	arg_9_0.normalEpisodeItem.go = arg_9_0._gonormalItem
	arg_9_0.normalEpisodeItem.imageIcon = gohelper.findChildImage(arg_9_0.normalEpisodeItem.go, "image_icon")
	arg_9_0.normalEpisodeItem.goSelect = gohelper.findChild(arg_9_0.normalEpisodeItem.go, "go_select")
	arg_9_0.normalEpisodeItem.imageSelectIcon = gohelper.findChildImage(arg_9_0.normalEpisodeItem.go, "go_select/image_selectIcon")
	arg_9_0.normalEpisodeItem.imageSelectFinishIcon = gohelper.findChildImage(arg_9_0.normalEpisodeItem.go, "go_select/image_selectFinishIcon")
	arg_9_0.normalEpisodeItem.goFinish = gohelper.findChild(arg_9_0.normalEpisodeItem.go, "go_finish")
	arg_9_0.normalEpisodeItem.imageFinishIcon = gohelper.findChildImage(arg_9_0.normalEpisodeItem.go, "go_finish/image_finishIcon")
	arg_9_0.normalEpisodeItem.txtName = gohelper.findChildText(arg_9_0.normalEpisodeItem.go, "txt_name")
	arg_9_0.normalEpisodeItem.btnClick = gohelper.findChildButtonWithAudio(arg_9_0.normalEpisodeItem.go, "btn_click")
	arg_9_0.normalEpisodeItem.goFinishEffect = gohelper.findChild(arg_9_0.normalEpisodeItem.go, "go_finishEffect")
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0._onScrollChange(arg_11_0, arg_11_1)
	local var_11_0 = TowerPermanentModel.instance:getCurSelectStage()
	local var_11_1 = TowerPermanentModel.instance:getStageCount()

	gohelper.setActive(arg_11_0._btnCurStageFold.gameObject, var_11_0 < var_11_1)

	local var_11_2 = recthelper.getAnchorY(arg_11_0._rectContent) > (var_11_0 - 1) * TowerEnum.PermanentUI.StageTitleH

	gohelper.setActive(arg_11_0._goStageInfo, var_11_2)

	local var_11_3 = TowerConfig.instance:getTowerPermanentTimeCo(var_11_0)

	arg_11_0._txtCurStage.text = var_11_3.name

	local var_11_4 = var_11_2 and TowerEnum.PermanentUI.StageTitleH or 0

	arg_11_0._viewportMask2D.padding = Vector4(0, 0, -150, var_11_4)
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0.jumpParam = arg_12_0.viewParam or {}

	if tabletool.len(arg_12_0.jumpParam) > 0 then
		arg_12_0._viewAnim:Play("opennormal", 0, 0)
	else
		arg_12_0._viewAnim:Play("openenter", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_bubbles)
	end

	gohelper.setActive(arg_12_0._goStageInfo, false)
	arg_12_0:refreshUI()
	arg_12_0:scrollMoveToTargetLayer()

	local var_12_0 = TowerModel.instance:getCurPermanentMo()
	local var_12_1 = TowerPermanentModel.instance:getLocalPassLayer()

	if not var_12_1 or var_12_1 == -1 then
		TowerPermanentModel.instance:setLocalPassLayer(var_12_0.passLayerId)
	end

	if arg_12_0.jumpParam and arg_12_0.jumpParam.episodeId and arg_12_0.layerConfig.isElite == 1 then
		for iter_12_0, iter_12_1 in ipairs(arg_12_0.episodeIdList) do
			if iter_12_1 == arg_12_0.jumpParam.episodeId then
				arg_12_0:_btnEliteEpisodeItemClick(iter_12_0, true)

				break
			end
		end

		local var_12_2 = TowerPermanentModel.instance:getFirstUnFinishEipsode(arg_12_0.jumpParam.layerId)

		if var_12_2 then
			arg_12_0.nextUnfinishEpisodeId = var_12_2.episodeId

			TaskDispatcher.runDelay(arg_12_0.selectNextEpisode, arg_12_0, 1)
			UIBlockMgr.instance:startBlock(var_0_0.animBlockName)
			UIBlockMgrExtend.setNeedCircleMv(false)
		end
	end

	if arg_12_0.jumpParam and arg_12_0.jumpParam.episodeId and TowerPermanentModel.instance:isNewPassLayer() then
		UIBlockMgr.instance:startBlock(var_0_0.animBlockName)
		UIBlockMgrExtend.setNeedCircleMv(false)
		gohelper.setActive(arg_12_0._gocompleted, false)

		local var_12_3, var_12_4, var_12_5 = TowerPermanentModel.instance:isNewStage()

		if var_12_5 == var_12_4 and var_12_5 > 1 then
			arg_12_0._bgAnim:Play(var_12_5 - 1 .. "to" .. var_12_5, 0, 1)
		end

		for iter_12_2, iter_12_3 in pairs(arg_12_0.rewardTab) do
			gohelper.setActive(iter_12_3.goHasGet, false)
		end

		TaskDispatcher.runDelay(arg_12_0.playFinishEffect, arg_12_0, 1)
	end
end

function var_0_0.playFinishEffect(arg_13_0)
	gohelper.setActive(arg_13_0._gocompleted, arg_13_0.isAllFinish)
	gohelper.setActive(arg_13_0._goschedule, arg_13_0.layerConfig.isElite == 1 and not arg_13_0.isAllFinish)
	arg_13_0._animCompleted:Play("in", 0, 0)
	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_complete)

	for iter_13_0, iter_13_1 in pairs(arg_13_0.rewardTab) do
		gohelper.setActive(iter_13_1.goHasGet, true)
		iter_13_1.animHasGet:Play("go_hasget_in", 0, 0)
	end

	AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_award)
	TowerController.instance:dispatchEvent(TowerEvent.PermanentTowerFinishLayer, arg_13_0.jumpParam.layerId)

	local var_13_0, var_13_1, var_13_2 = TowerPermanentModel.instance:isNewStage()

	arg_13_0.isNewStageInfo = {
		isNewStage = var_13_0,
		maxStage = var_13_1
	}

	if var_13_0 then
		arg_13_0._bgAnim:Play(var_13_2 .. "to" .. var_13_1, 0, 0)

		if TowerConfig.instance:getPermanentEpisodeCo(arg_13_0.jumpParam.layerId).isElite == 1 then
			gohelper.setActive(arg_13_0.eliteBgAnimTab[var_13_2].go, true)
		end
	elseif var_13_2 == var_13_1 and var_13_2 > 1 then
		arg_13_0._bgAnim:Play(var_13_2 - 1 .. "to" .. var_13_2, 0, 1)
	end

	arg_13_0:setNewStageAndLayer(var_13_0)

	local var_13_3 = TowerModel.instance:getCurPermanentMo()

	TowerPermanentModel.instance:setLocalPassLayer(var_13_3.passLayerId)
end

function var_0_0.setNewStageAndLayer(arg_14_0, arg_14_1)
	local var_14_0, var_14_1 = TowerPermanentModel.instance:getNewtStageAndLayer()

	arg_14_0.animPermanentEpisodeCo = TowerConfig.instance:getPermanentEpisodeLayerCo(var_14_0, var_14_1)

	if arg_14_1 then
		arg_14_0:refreshEnterTitle(var_14_0)
		TaskDispatcher.runDelay(arg_14_0.showNextStageTitleAnim, arg_14_0, var_0_0.showNextStageTitleTime)
		TaskDispatcher.runDelay(arg_14_0._btnCurStageFoldOnClick, arg_14_0, var_0_0.selectNextStageTime)
		TaskDispatcher.runDelay(arg_14_0.permanentSelectNextLayer, arg_14_0, var_0_0.selectNextStageTime + var_0_0.selectNextLayerTime)
	else
		TaskDispatcher.runDelay(arg_14_0.permanentSelectNextLayer, arg_14_0, var_0_0.selectNextLayerTime)
	end
end

function var_0_0.showNextStageTitleAnim(arg_15_0)
	if arg_15_0.isNewStageInfo and arg_15_0.isNewStageInfo.isNewStage then
		arg_15_0._viewAnim:Play("switchfloor", 0, 0)
		AudioMgr.instance:trigger(AudioEnum.Tower.play_ui_fight_bubbles)
	end
end

function var_0_0.selectNextEpisode(arg_16_0)
	if arg_16_0.nextUnfinishEpisodeId > 0 then
		for iter_16_0, iter_16_1 in ipairs(arg_16_0.episodeIdList) do
			if iter_16_1 == arg_16_0.nextUnfinishEpisodeId then
				arg_16_0:_btnEliteEpisodeItemClick(iter_16_0, false)

				break
			end
		end
	end

	UIBlockMgr.instance:endBlock(var_0_0.animBlockName)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function var_0_0.permanentSelectNextLayer(arg_17_0)
	UIBlockMgr.instance:endBlock(var_0_0.animBlockName)
	UIBlockMgrExtend.setNeedCircleMv(true)
	TowerController.instance:dispatchEvent(TowerEvent.PermanentSelectNextLayer, arg_17_0.animPermanentEpisodeCo)
end

function var_0_0.selectPermanentAltitude(arg_18_0)
	arg_18_0.curSelectEpisodeIndex = 0

	if not arg_18_0.isNewStageInfo or tabletool.len(arg_18_0.isNewStageInfo) == 0 or not arg_18_0.isNewStageInfo.isNewStage then
		arg_18_0._viewAnim:Play(UIAnimationName.Switch, 0, 0)
	else
		arg_18_0.isNewStageInfo = nil

		arg_18_0:refreshUI()
	end
end

function var_0_0.selectUnfinishEpisode(arg_19_0)
	if arg_19_0.layerConfig.isElite == 1 then
		local var_19_0 = TowerPermanentModel.instance:getFirstUnFinishEipsode(arg_19_0.layerConfig.layerId)

		if var_19_0 then
			for iter_19_0, iter_19_1 in ipairs(arg_19_0.episodeIdList) do
				if iter_19_1 == var_19_0.episodeId then
					arg_19_0:_btnEliteEpisodeItemClick(iter_19_0, true)

					break
				end
			end
		end
	end
end

function var_0_0.refreshUI(arg_20_0)
	arg_20_0:refreshEpisode()
	arg_20_0:refreshReward()
	arg_20_0:selectUnfinishEpisode()
	arg_20_0:refreshEnterTitle()
	arg_20_0:refreshStageItemEffect()
end

function var_0_0.refreshStageItemEffect(arg_21_0)
	for iter_21_0 = 1, var_0_0.maxStageCount do
		gohelper.setActive(arg_21_0.eliteBgAnimTab[iter_21_0].go, iter_21_0 == arg_21_0.curStage and arg_21_0.layerConfig.isElite == 1)
	end
end

function var_0_0.refreshEnterTitle(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_1 or arg_22_0.curStage
	local var_22_1 = TowerConfig.instance:getTowerPermanentTimeCo(var_22_0)

	arg_22_0._txtEnterTitle.text = var_22_1.name
	arg_22_0._txtEnterTitleEn.text = var_22_1.nameEn

	arg_22_0._simageEnterBg:LoadImage(ResUrl.getTowerIcon("permanent/towerpermanent_bg" .. var_22_0))
end

function var_0_0.refreshEpisode(arg_23_0)
	local var_23_0, var_23_1 = TowerPermanentModel.instance:getRealSelectStage()

	arg_23_0.curStage = TowerPermanentModel.instance:getCurSelectStage()
	arg_23_0.curLayerIndex = TowerPermanentModel.instance:getCurSelectLayer()
	arg_23_0.realSelectLayerIndex = var_23_1
	arg_23_0.realselectStage = var_23_0
	arg_23_0.layerConfig = TowerConfig.instance:getPermanentEpisodeLayerCo(arg_23_0.realselectStage, arg_23_0.realSelectLayerIndex)
	arg_23_0.isAllFinish = arg_23_0.layerConfig.layerId <= TowerPermanentModel.instance.curPassLayer
	arg_23_0.episodeIdList = string.splitToNumber(arg_23_0.layerConfig.episodeIds, "|")

	local var_23_2 = #arg_23_0.episodeIdList
	local var_23_3 = arg_23_0.layerConfig.isElite == 1

	gohelper.setActive(arg_23_0._gonormalEpisode, not var_23_3)
	gohelper.setActive(arg_23_0._goeliteEpisode, var_23_3)
	gohelper.setActive(arg_23_0._goschedule, var_23_3 and not arg_23_0.isAllFinish)

	local var_23_4 = TowerConfig.instance:getTowerPermanentTimeCo(arg_23_0.curStage)

	arg_23_0._txtTitle.text = var_23_4.name
	arg_23_0._txtTitleEn.text = var_23_4.nameEn

	if arg_23_0.curStage > 1 then
		arg_23_0._bgAnim:Play(arg_23_0.curStage - 1 .. "to" .. arg_23_0.curStage, 0, 1)
	else
		arg_23_0._bgAnim:Play("1idle", 0, 1)
	end

	if var_23_3 then
		local var_23_5 = TowerModel.instance:getCurPermanentMo()
		local var_23_6 = var_23_5:getSubEpisodePassCount(arg_23_0.layerConfig.layerId)

		arg_23_0._txtschedule.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("towerpermanentresultview_schedule"), var_23_6, #arg_23_0.episodeIdList)

		for iter_23_0, iter_23_1 in ipairs(arg_23_0.episodeIdList) do
			local var_23_7 = arg_23_0.viewContainer:getTowerPermanentPoolView():createOrGetEliteEpisodeItem(iter_23_0, arg_23_0._btnEliteEpisodeItemClick, arg_23_0)

			if not arg_23_0.eliteItemTab[arg_23_0.layerConfig.layerId] then
				arg_23_0.eliteItemTab[arg_23_0.layerConfig.layerId] = {}
			end

			arg_23_0.eliteItemTab[arg_23_0.layerConfig.layerId][iter_23_0] = var_23_7

			gohelper.setActive(var_23_7.go, true)

			local var_23_8 = arg_23_0.eliteItemPosTab[var_23_2].posTab[iter_23_0]

			var_23_7.go.transform:SetParent(var_23_8.transform, false)
			recthelper.setAnchor(var_23_7.go.transform, 0, 0)

			local var_23_9 = var_23_5:getSubEpisodeMoByEpisodeId(iter_23_1)

			var_23_7.isFinish = var_23_9 and var_23_9.status == TowerEnum.PassEpisodeState.Pass

			gohelper.setActive(var_23_7.goFinish, var_23_7.isFinish)

			var_23_7.txtName.text = GameUtil.getRomanNums(iter_23_0)

			gohelper.setActive(var_23_7.imageSelectIcon.gameObject, not var_23_7.isFinish)
			gohelper.setActive(var_23_7.imageSelectFinishIcon.gameObject, var_23_7.isFinish)
			gohelper.setActive(var_23_7.goFinishEffect, var_23_7.isFinish)
			UISpriteSetMgr.instance:setTowerPermanentSprite(var_23_7.imageIcon, arg_23_0:getEliteEpisodeIconName(iter_23_0, TowerEnum.PermanentEliteEpisodeState.Normal), true)
			UISpriteSetMgr.instance:setTowerPermanentSprite(var_23_7.imageSelectIcon, arg_23_0:getEliteEpisodeIconName(iter_23_0, TowerEnum.PermanentEliteEpisodeState.NormalSelect), true)
			UISpriteSetMgr.instance:setTowerPermanentSprite(var_23_7.imageSelectFinishIcon, arg_23_0:getEliteEpisodeIconName(iter_23_0, TowerEnum.PermanentEliteEpisodeState.FinishSelect), true)
			UISpriteSetMgr.instance:setTowerPermanentSprite(var_23_7.imageFinishIcon, arg_23_0:getEliteEpisodeIconName(iter_23_0, TowerEnum.PermanentEliteEpisodeState.Finish), true)
		end

		arg_23_0.viewContainer:getTowerPermanentPoolView():recycleEliteEpisodeItem(arg_23_0.episodeIdList)

		for iter_23_2 = 2, 5 do
			gohelper.setActive(arg_23_0.eliteItemPosTab[iter_23_2].go, iter_23_2 == var_23_2)
		end

		if arg_23_0.curSelectEpisodeIndex and arg_23_0.curSelectEpisodeIndex > 0 then
			arg_23_0:_btnEliteEpisodeItemClick(arg_23_0.curSelectEpisodeIndex, true)
		else
			arg_23_0:_btnEliteEpisodeItemClick(1, true)
		end
	else
		UISpriteSetMgr.instance:setTowerPermanentSprite(arg_23_0.normalEpisodeItem.imageIcon, arg_23_0:getEliteEpisodeIconName(1, TowerEnum.PermanentEliteEpisodeState.Normal), true)
		UISpriteSetMgr.instance:setTowerPermanentSprite(arg_23_0.normalEpisodeItem.imageSelectIcon, arg_23_0:getEliteEpisodeIconName(1, TowerEnum.PermanentEliteEpisodeState.NormalSelect), true)
		UISpriteSetMgr.instance:setTowerPermanentSprite(arg_23_0.normalEpisodeItem.imageSelectFinishIcon, arg_23_0:getEliteEpisodeIconName(1, TowerEnum.PermanentEliteEpisodeState.FinishSelect), true)
		UISpriteSetMgr.instance:setTowerPermanentSprite(arg_23_0.normalEpisodeItem.imageFinishIcon, arg_23_0:getEliteEpisodeIconName(1, TowerEnum.PermanentEliteEpisodeState.Finish), true)

		arg_23_0.normalEpisodeItem.txtName.text = "ST - " .. arg_23_0.realSelectLayerIndex

		gohelper.setActive(arg_23_0.normalEpisodeItem.goSelect, true)
		gohelper.setActive(arg_23_0.normalEpisodeItem.imageSelectIcon.gameObject, not arg_23_0.isAllFinish)
		gohelper.setActive(arg_23_0.normalEpisodeItem.imageSelectFinishIcon.gameObject, arg_23_0.isAllFinish)
		gohelper.setActive(arg_23_0.normalEpisodeItem.goFinishEffect, arg_23_0.isAllFinish)
		gohelper.setActive(arg_23_0.normalEpisodeItem.goFinish, false)
		arg_23_0.normalEpisodeItem.btnClick:AddClickListener(arg_23_0._btnNormalEpisodeItemClick, arg_23_0, arg_23_0.episodeIdList[1])
		arg_23_0:_btnNormalEpisodeItemClick(arg_23_0.episodeIdList[1])
	end

	gohelper.setActive(arg_23_0._gocompleted, arg_23_0.isAllFinish)
end

function var_0_0.getEliteEpisodeIconName(arg_24_0, arg_24_1, arg_24_2)
	return string.format("towerpermanent_stage_%d_%d", arg_24_1, arg_24_2)
end

function var_0_0.refreshReward(arg_25_0)
	local var_25_0 = string.split(arg_25_0.layerConfig.firstReward, "|")

	gohelper.CreateObjList(arg_25_0, arg_25_0.rewardItemShow, var_25_0, arg_25_0._goreward, arg_25_0._gorewardItem)
end

function var_0_0.rewardItemShow(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = arg_26_0.rewardTab[arg_26_3]

	if not var_26_0 then
		var_26_0 = {
			itemPos = gohelper.findChild(arg_26_1, "go_rewardPos"),
			goHasGet = gohelper.findChild(arg_26_1, "go_rewardGet"),
			animHasGet = gohelper.findChild(arg_26_1, "go_rewardGet/icon/go_hasget"):GetComponent(gohelper.Type_Animator)
		}
		var_26_0.item = IconMgr.instance:getCommonPropItemIcon(var_26_0.itemPos)
		arg_26_0.rewardTab[arg_26_3] = var_26_0
	end

	local var_26_1 = string.splitToNumber(arg_26_2, "#")

	var_26_0.item:setMOValue(var_26_1[1], var_26_1[2], var_26_1[3])
	var_26_0.item:setHideLvAndBreakFlag(true)
	var_26_0.item:hideEquipLvAndBreak(true)
	var_26_0.item:setCountFontSize(51)
	gohelper.setActive(var_26_0.goHasGet, arg_26_0.isAllFinish)
end

function var_0_0.scrollMoveToTargetLayer(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_1 or arg_27_0.realselectStage
	local var_27_1 = arg_27_2 or arg_27_0.realSelectLayerIndex
	local var_27_2 = (var_27_0 - 1) * TowerEnum.PermanentUI.StageTitleH + (var_27_1 - 1) * (TowerEnum.PermanentUI.SingleItemH + TowerEnum.PermanentUI.ItemSpaceH)
	local var_27_3 = TowerPermanentModel.instance:getCurContentTotalHeight() - TowerEnum.PermanentUI.ScrollH + 1
	local var_27_4 = Mathf.Min(var_27_2, var_27_3)

	recthelper.setAnchorY(arg_27_0._goContent.transform, var_27_4)
	arg_27_0:_onScrollChange()
end

function var_0_0.onClose(arg_28_0)
	if arg_28_0.normalEpisodeItem.btnClick then
		arg_28_0.normalEpisodeItem.btnClick:RemoveClickListener()
	end

	TaskDispatcher.cancelTask(arg_28_0.showNextStageTitleAnim, arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0._btnCurStageFoldOnClick, arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0.permanentSelectNextLayer, arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0.playFinishEffect, arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0.selectNextEpisode, arg_28_0)
	UIBlockMgr.instance:endBlock(var_0_0.animBlockName)
	UIBlockMgrExtend.setNeedCircleMv(true)
end

function var_0_0.onDestroyView(arg_29_0)
	TowerPermanentModel.instance:cleanData()
	arg_29_0._simageEnterBg:UnLoadImage()
	arg_29_0._animEventWrap:RemoveAllEventListener()
	TowerModel.instance:cleanTrialData()
end

return var_0_0
