module("modules.logic.seasonver.act166.view.Season166MainView", package.seeall)

local var_0_0 = class("Season166MainView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goStarCollect = gohelper.findChild(arg_1_0.viewGO, "starCollect")
	arg_1_0._txttotalStarCount = gohelper.findChildText(arg_1_0.viewGO, "starCollect/#txt_totalStarCount")
	arg_1_0._gomainContent = gohelper.findChild(arg_1_0.viewGO, "#go_mainContent")
	arg_1_0._txtremainTime = gohelper.findChildText(arg_1_0.viewGO, "#go_mainContent/title/#txt_remainTime")
	arg_1_0._goprogress = gohelper.findChild(arg_1_0.viewGO, "trainEntrance/progress")
	arg_1_0._goprogressItem = gohelper.findChild(arg_1_0.viewGO, "trainEntrance/progress/#go_progress")
	arg_1_0._goepisodeContent = gohelper.findChild(arg_1_0.viewGO, "trainEntrance/#go_episodeContent")
	arg_1_0._goepisodeItem = gohelper.findChild(arg_1_0.viewGO, "trainEntrance/#go_episodeContent/#go_episodeItem")
	arg_1_0._btntrainClick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "trainEntrance/#btn_trainClick")
	arg_1_0._gohardUnlock = gohelper.findChild(arg_1_0.viewGO, "trainEntrance/#go_hardUnlock")
	arg_1_0._txthardUnlockTime = gohelper.findChildText(arg_1_0.viewGO, "trainEntrance/#go_hardUnlock/#txt_hardUnlockTime")
	arg_1_0._gospotEntrance = gohelper.findChild(arg_1_0.viewGO, "spotEntrance")
	arg_1_0._gospot1 = gohelper.findChild(arg_1_0.viewGO, "spotEntrance/#go_spot1")
	arg_1_0._gospot2 = gohelper.findChild(arg_1_0.viewGO, "spotEntrance/#go_spot2")
	arg_1_0._gospot3 = gohelper.findChild(arg_1_0.viewGO, "spotEntrance/#go_spot3")
	arg_1_0._gospotItem = gohelper.findChild(arg_1_0.viewGO, "spotEntrance/#go_spotItem")
	arg_1_0._btninformation = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_mainContent/#btn_information")
	arg_1_0._imagecoin = gohelper.findChildImage(arg_1_0.viewGO, "#go_mainContent/#btn_information/#image_coin")
	arg_1_0._txtcoinNum = gohelper.findChildText(arg_1_0.viewGO, "#go_mainContent/#btn_information/#txt_coinNum")
	arg_1_0._goinfoReddot = gohelper.findChild(arg_1_0.viewGO, "#go_mainContent/#btn_information/#go_infoReddot")
	arg_1_0._goinfoNewReddot = gohelper.findChild(arg_1_0.viewGO, "#go_mainContent/#btn_information/#go_infoNewReddot")
	arg_1_0._btntalenttree = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_mainContent/#btn_talenttree")
	arg_1_0._gotalentReddot = gohelper.findChild(arg_1_0.viewGO, "#go_mainContent/#btn_talenttree/#go_talentReddot")
	arg_1_0._btnteach = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_mainContent/#btn_teach")
	arg_1_0._goteachNormal = gohelper.findChild(arg_1_0.viewGO, "#go_mainContent/#btn_teach/#go_teachNormal")
	arg_1_0._goteachFinish = gohelper.findChild(arg_1_0.viewGO, "#go_mainContent/#btn_teach/#go_teachFinish")
	arg_1_0._gotopleft = gohelper.findChild(arg_1_0.viewGO, "#go_topleft")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btninformation:AddClickListener(arg_2_0._btninformationOnClick, arg_2_0)
	arg_2_0._btntalenttree:AddClickListener(arg_2_0._btntalenttreeOnClick, arg_2_0)
	arg_2_0._btnteach:AddClickListener(arg_2_0._btnteachOnClick, arg_2_0)
	arg_2_0._btntrainClick:AddClickListener(arg_2_0._btntrainOnClick, arg_2_0)
	arg_2_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_2_0.refreshInformationCoin, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_2_0._onCloseViewFinish, arg_2_0, LuaEventSystem.Low)
	arg_2_0:addEventCb(Season166Controller.instance, Season166Event.TrainViewChangeTrain, arg_2_0.refreshProgressCurEffect, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btninformation:RemoveClickListener()
	arg_3_0._btntalenttree:RemoveClickListener()
	arg_3_0._btnteach:RemoveClickListener()
	arg_3_0._btntrainClick:RemoveClickListener()
	arg_3_0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_3_0.refreshInformationCoin, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_3_0._onCloseViewFinish, arg_3_0, LuaEventSystem.Low)
	arg_3_0:removeEventCb(Season166Controller.instance, Season166Event.TrainViewChangeTrain, arg_3_0.refreshProgressCurEffect, arg_3_0)
end

function var_0_0._btninformationOnClick(arg_4_0)
	ViewMgr.instance:openView(ViewName.Season166InformationMainView, {
		actId = arg_4_0.actId
	})
end

function var_0_0._btntalenttreeOnClick(arg_5_0)
	ViewMgr.instance:openView(ViewName.Season166TalentView)
end

function var_0_0._btnteachOnClick(arg_6_0)
	Season166Controller.instance:enterSeasonTeachView({
		actId = arg_6_0.actId
	})
end

function var_0_0._btntrainOnClick(arg_7_0)
	arg_7_0.isTrainState = true

	arg_7_0:refreshEntranceState()
	Season166Controller.instance:dispatchEvent(Season166Event.MainShowTrainList)
	arg_7_0.viewContainer:getMainSceneView():playTrainAnim(true)
end

function var_0_0._editableInitView(arg_8_0)
	arg_8_0.baseSpotItemTab = arg_8_0:getUserDataTb_()
	arg_8_0.trainItemTab = arg_8_0:getUserDataTb_()
	arg_8_0.trainProgressTab = arg_8_0:getUserDataTb_()

	for iter_8_0 = 1, 6 do
		arg_8_0["_goEpisodePos" .. iter_8_0] = gohelper.findChild(arg_8_0._goepisodeContent, "#go_episodePos" .. iter_8_0)
	end

	gohelper.setActive(arg_8_0._gospotItem, false)
	gohelper.setActive(arg_8_0._goepisodeItem, false)
	gohelper.setActive(arg_8_0._goprogressItem, false)

	arg_8_0.isTrainState = false
end

function var_0_0.onUpdateParam(arg_9_0)
	return
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0.actId = arg_10_0.viewParam.actId
	arg_10_0.infoCoinId = Season166Config.instance:getSeasonConstNum(arg_10_0.actId, Season166Enum.InfoCostId)

	arg_10_0:refreshUI()
	TaskDispatcher.runRepeat(arg_10_0.refreshRemainTime, arg_10_0, 1)
	arg_10_0.viewContainer:getMainSceneView():playInViewAnim(arg_10_0.viewParam.jumpId)

	if arg_10_0.viewParam.jumpId then
		arg_10_0:processSeason166JumpParam(arg_10_0.viewParam)
	end
end

function var_0_0.initBaseSpotItem(arg_11_0)
	local var_11_0 = Season166Config.instance:getSeasonBaseSpotCos(arg_11_0.actId) or {}

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		local var_11_1 = arg_11_0.baseSpotItemTab[iter_11_0]

		if not var_11_1 then
			var_11_1 = {
				pos = arg_11_0["_gospot" .. iter_11_0]
			}
			var_11_1.go = gohelper.clone(arg_11_0._gospotItem, var_11_1.pos, "baseSpotItem" .. iter_11_0)
			var_11_1.item = MonoHelper.addNoUpdateLuaComOnceToGo(var_11_1.go, Season166MainBaseSpotItem, {
				actId = arg_11_0.actId,
				baseId = iter_11_0,
				config = iter_11_1
			})
			arg_11_0.baseSpotItemTab[iter_11_0] = var_11_1
		end

		var_11_1.item:refreshUI()
		gohelper.setActive(var_11_1.go, true)
	end
end

function var_0_0.initTrainEntrance(arg_12_0)
	local var_12_0 = Season166Config.instance:getSeasonTrainCos(arg_12_0.actId)

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		local var_12_1 = arg_12_0.trainItemTab[iter_12_0]

		if not var_12_1 then
			var_12_1 = {
				pos = arg_12_0["_goEpisodePos" .. iter_12_0]
			}
			var_12_1.go = gohelper.clone(arg_12_0._goepisodeItem, var_12_1.pos, "trainItem" .. iter_12_0)
			var_12_1.item = MonoHelper.addNoUpdateLuaComOnceToGo(var_12_1.go, Season166MainTrainItem, {
				actId = arg_12_0.actId,
				trainId = iter_12_0,
				config = iter_12_1
			})
			arg_12_0.trainItemTab[iter_12_0] = var_12_1
		end

		var_12_1.item:refreshUI()
		gohelper.setActive(var_12_1.go, true)
	end

	arg_12_0.viewContainer:getMainSceneView():setTrainItemTab(arg_12_0.trainItemTab)
	arg_12_0.viewContainer:getMainSceneView():refreshTrainEntranceNew()
end

function var_0_0.initTrainProgress(arg_13_0)
	local var_13_0 = Season166Config.instance:getSeasonTrainCos(arg_13_0.actId)

	for iter_13_0 = 1, #var_13_0 do
		local var_13_1 = arg_13_0.trainProgressTab[iter_13_0]

		if not var_13_1 then
			var_13_1 = {
				go = gohelper.clone(arg_13_0._goprogressItem, arg_13_0._goprogress, "progressItem" .. iter_13_0)
			}
			var_13_1.light = gohelper.findChild(var_13_1.go, "light")
			var_13_1.dark = gohelper.findChild(var_13_1.go, "dark")
			var_13_1.imageLight = gohelper.findChildImage(var_13_1.go, "light")
			var_13_1.imageDark = gohelper.findChildImage(var_13_1.go, "dark")
			var_13_1.goCurEffect = gohelper.findChild(var_13_1.go, "go_curEffect")
			var_13_1.config = var_13_0[iter_13_0]
			arg_13_0.trainProgressTab[iter_13_0] = var_13_1

			gohelper.setActive(var_13_1.goCurEffect, false)
		end

		gohelper.setActive(var_13_1.go, true)
	end
end

function var_0_0.refreshUI(arg_14_0)
	arg_14_0:initBaseSpotItem()
	arg_14_0:initTrainEntrance()
	arg_14_0:initTrainProgress()
	arg_14_0:refreshEntranceState()
	arg_14_0:refreshRemainTime()
	arg_14_0:refreshTrainProgress()
	arg_14_0:refreshInformation()
	arg_14_0:refreshInfoReddot()
	arg_14_0:refreshTalentReddot()

	arg_14_0._txttotalStarCount.text = Season166BaseSpotModel.instance:getCurTotalStarCount(arg_14_0.actId)

	local var_14_0 = Season166TeachModel.instance:checkIsAllTeachFinish(arg_14_0.actId)

	gohelper.setActive(arg_14_0._goteachFinish, var_14_0)
end

function var_0_0.refreshEntranceState(arg_15_0)
	arg_15_0.viewContainer:getMainSceneView():playTrainEpisodeAnim(arg_15_0.isTrainState)
	gohelper.setActive(arg_15_0._btntrainClick.gameObject, not arg_15_0.isTrainState)

	local var_15_0, var_15_1 = Season166TrainModel.instance:isHardEpisodeUnlockTime(arg_15_0.actId)

	gohelper.setActive(arg_15_0._gohardUnlock, arg_15_0.isTrainState and not var_15_0 and var_15_1 > 0)

	arg_15_0._txthardUnlockTime.text = not var_15_0 and GameUtil.getSubPlaceholderLuaLang(luaLang("season166_unlockHardEpisodeTime"), {
		var_15_1
	}) or ""

	arg_15_0.viewContainer:setHelpBtnShowState(arg_15_0.isTrainState)
	arg_15_0:setCloseOverrideFunc()
	arg_15_0.viewContainer:getMainSceneView():setTrainLevelBg()
end

function var_0_0.setCloseOverrideFunc(arg_16_0)
	if arg_16_0.isTrainState then
		arg_16_0.isTrainState = false

		arg_16_0.viewContainer:setOverrideCloseClick(arg_16_0.setTrainClose, arg_16_0)
	else
		arg_16_0.viewContainer:setOverrideCloseClick(arg_16_0.closeThis, arg_16_0)
	end
end

function var_0_0.setTrainClose(arg_17_0)
	arg_17_0:refreshEntranceState()
	arg_17_0.viewContainer:getMainSceneView():cleanJumpData()
	arg_17_0.viewContainer:getMainSceneView():playTrainAnim(false)
end

function var_0_0.refreshRemainTime(arg_18_0)
	if not ActivityModel.instance:getActMO(arg_18_0.actId) then
		arg_18_0._txtremainTime.text = ""

		return
	end

	local var_18_0, var_18_1 = Season166Controller.instance:getSeasonEnterCloseTimeStamp(arg_18_0.actId)

	if var_18_1 > 0 then
		local var_18_2 = TimeUtil.SecondToActivityTimeFormat(var_18_1)

		arg_18_0._txtremainTime.text = var_18_2
	else
		arg_18_0._txtremainTime.text = luaLang("ended")

		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)
	end
end

function var_0_0.refreshTrainProgress(arg_19_0)
	local var_19_0 = Season166TrainModel.instance:getCurTrainPassCount(arg_19_0.actId)

	for iter_19_0, iter_19_1 in ipairs(arg_19_0.trainProgressTab) do
		local var_19_1 = Season166TrainModel.instance:checkIsFinish(arg_19_0.actId, iter_19_0)

		gohelper.setActive(iter_19_1.light, var_19_1)
		gohelper.setActive(iter_19_1.dark, not var_19_1)

		local var_19_2 = iter_19_1.config.type == Season166Enum.TrainSpType and "season_main_chapterdifficulticon2" or "season_main_chaptericon2"
		local var_19_3 = iter_19_1.config.type == Season166Enum.TrainSpType and "season_main_chapterdifficulticon1" or "season_main_chaptericon1"

		UISpriteSetMgr.instance:setSeason166Sprite(iter_19_1.imageLight, var_19_2, true)
		UISpriteSetMgr.instance:setSeason166Sprite(iter_19_1.imageDark, var_19_3, true)
	end
end

function var_0_0.refreshProgressCurEffect(arg_20_0, arg_20_1)
	for iter_20_0, iter_20_1 in ipairs(arg_20_0.trainProgressTab) do
		gohelper.setActive(iter_20_1.goCurEffect, iter_20_0 == arg_20_1)

		if iter_20_0 == arg_20_1 then
			transformhelper.setLocalScale(iter_20_1.light.transform, 1.3, 1.3, 1.3)
			transformhelper.setLocalScale(iter_20_1.dark.transform, 1.3, 1.3, 1.3)
		else
			transformhelper.setLocalScale(iter_20_1.light.transform, 1, 1, 1)
			transformhelper.setLocalScale(iter_20_1.dark.transform, 1, 1, 1)
		end
	end
end

function var_0_0.refreshInformation(arg_21_0)
	local var_21_0 = CurrencyConfig.instance:getCurrencyCo(arg_21_0.infoCoinId)
	local var_21_1 = string.format("%s_1", var_21_0 and var_21_0.icon)

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_21_0._imagecoin, var_21_1, true)
	arg_21_0:refreshInformationCoin()
end

function var_0_0.refreshInformationCoin(arg_22_0)
	local var_22_0 = CurrencyModel.instance:getCurrency(arg_22_0.infoCoinId)

	arg_22_0._txtcoinNum.text = GameUtil.numberDisplay(var_22_0.quantity)
end

function var_0_0.processSeason166JumpParam(arg_23_0, arg_23_1)
	if arg_23_1.jumpId == Season166Enum.JumpId.BaseSpotEpisode then
		arg_23_0.isTrainState = false

		local var_23_0 = arg_23_1.jumpParam.baseId

		arg_23_0.baseSpotItemTab[var_23_0].item:onClickBaseSpotItem()
		arg_23_0:refreshEntranceState()
	elseif arg_23_1.jumpId == Season166Enum.JumpId.TrainEpisode then
		arg_23_0.isTrainState = true

		local var_23_1 = arg_23_1.jumpParam.trainId

		arg_23_0.trainItemTab[var_23_1].item:onClickTrainItem()
		arg_23_0:refreshEntranceState()
	elseif arg_23_1.jumpId == Season166Enum.JumpId.MainView then
		arg_23_0.isTrainState = false

		arg_23_0:refreshEntranceState()
	elseif arg_23_1.jumpId == Season166Enum.JumpId.TrainView then
		arg_23_0:_btntrainOnClick()
	elseif arg_23_1.jumpId == Season166Enum.JumpId.TeachView then
		Season166Controller.instance:enterSeasonTeachView({
			actId = arg_23_0.actId
		})
	end
end

function var_0_0._onCloseViewFinish(arg_24_0, arg_24_1)
	if arg_24_1 == ViewName.Season166InformationMainView then
		arg_24_0:refreshInfoReddot()
	end

	if arg_24_1 == ViewName.Season166TalentView then
		arg_24_0:refreshTalentReddot()
	end
end

function var_0_0.refreshInfoReddot(arg_25_0)
	RedDotController.instance:addRedDot(arg_25_0._goinfoReddot, RedDotEnum.DotNode.Season166InformationEnter, nil, arg_25_0.checkInfoReddotShow, arg_25_0)
end

function var_0_0.checkInfoReddotShow(arg_26_0, arg_26_1)
	arg_26_1:defaultRefreshDot()

	if Season166Model.instance:checkHasNewUnlockInfo() then
		gohelper.setActive(arg_26_0._goinfoNewReddot, true)
		gohelper.setActive(arg_26_0._goinfoReddot, false)
	else
		gohelper.setActive(arg_26_0._goinfoNewReddot, false)
		gohelper.setActive(arg_26_0._goinfoReddot, true)
		arg_26_1:showRedDot(RedDotEnum.Style.Normal)
	end
end

function var_0_0.refreshTalentReddot(arg_27_0)
	gohelper.setActive(arg_27_0._gotalentReddot, Season166Model.instance:checkAllHasNewTalent(arg_27_0.actId))
end

function var_0_0.onClose(arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0.refreshRemainTime, arg_28_0)
end

function var_0_0.onDestroyView(arg_29_0)
	return
end

return var_0_0
