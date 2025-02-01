module("modules.logic.seasonver.act166.view.Season166MainView", package.seeall)

slot0 = class("Season166MainView", BaseView)

function slot0.onInitView(slot0)
	slot0._goStarCollect = gohelper.findChild(slot0.viewGO, "starCollect")
	slot0._txttotalStarCount = gohelper.findChildText(slot0.viewGO, "starCollect/#txt_totalStarCount")
	slot0._gomainContent = gohelper.findChild(slot0.viewGO, "#go_mainContent")
	slot0._txtremainTime = gohelper.findChildText(slot0.viewGO, "#go_mainContent/title/#txt_remainTime")
	slot0._goprogress = gohelper.findChild(slot0.viewGO, "trainEntrance/progress")
	slot0._goprogressItem = gohelper.findChild(slot0.viewGO, "trainEntrance/progress/#go_progress")
	slot0._goepisodeContent = gohelper.findChild(slot0.viewGO, "trainEntrance/#go_episodeContent")
	slot0._goepisodeItem = gohelper.findChild(slot0.viewGO, "trainEntrance/#go_episodeContent/#go_episodeItem")
	slot0._btntrainClick = gohelper.findChildButtonWithAudio(slot0.viewGO, "trainEntrance/#btn_trainClick")
	slot0._gohardUnlock = gohelper.findChild(slot0.viewGO, "trainEntrance/#go_hardUnlock")
	slot0._txthardUnlockTime = gohelper.findChildText(slot0.viewGO, "trainEntrance/#go_hardUnlock/#txt_hardUnlockTime")
	slot0._gospotEntrance = gohelper.findChild(slot0.viewGO, "spotEntrance")
	slot0._gospot1 = gohelper.findChild(slot0.viewGO, "spotEntrance/#go_spot1")
	slot0._gospot2 = gohelper.findChild(slot0.viewGO, "spotEntrance/#go_spot2")
	slot0._gospot3 = gohelper.findChild(slot0.viewGO, "spotEntrance/#go_spot3")
	slot0._gospotItem = gohelper.findChild(slot0.viewGO, "spotEntrance/#go_spotItem")
	slot0._btninformation = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_mainContent/#btn_information")
	slot0._imagecoin = gohelper.findChildImage(slot0.viewGO, "#go_mainContent/#btn_information/#image_coin")
	slot0._txtcoinNum = gohelper.findChildText(slot0.viewGO, "#go_mainContent/#btn_information/#txt_coinNum")
	slot0._goinfoReddot = gohelper.findChild(slot0.viewGO, "#go_mainContent/#btn_information/#go_infoReddot")
	slot0._goinfoNewReddot = gohelper.findChild(slot0.viewGO, "#go_mainContent/#btn_information/#go_infoNewReddot")
	slot0._btntalenttree = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_mainContent/#btn_talenttree")
	slot0._gotalentReddot = gohelper.findChild(slot0.viewGO, "#go_mainContent/#btn_talenttree/#go_talentReddot")
	slot0._btnteach = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_mainContent/#btn_teach")
	slot0._goteachNormal = gohelper.findChild(slot0.viewGO, "#go_mainContent/#btn_teach/#go_teachNormal")
	slot0._goteachFinish = gohelper.findChild(slot0.viewGO, "#go_mainContent/#btn_teach/#go_teachFinish")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btninformation:AddClickListener(slot0._btninformationOnClick, slot0)
	slot0._btntalenttree:AddClickListener(slot0._btntalenttreeOnClick, slot0)
	slot0._btnteach:AddClickListener(slot0._btnteachOnClick, slot0)
	slot0._btntrainClick:AddClickListener(slot0._btntrainOnClick, slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0.refreshUI, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.refreshInformationCoin, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0, LuaEventSystem.Low)
	slot0:addEventCb(Season166Controller.instance, Season166Event.TrainViewChangeTrain, slot0.refreshProgressCurEffect, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btninformation:RemoveClickListener()
	slot0._btntalenttree:RemoveClickListener()
	slot0._btnteach:RemoveClickListener()
	slot0._btntrainClick:RemoveClickListener()
	slot0:removeEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0.refreshUI, slot0)
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.refreshInformationCoin, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseViewFinish, slot0, LuaEventSystem.Low)
	slot0:removeEventCb(Season166Controller.instance, Season166Event.TrainViewChangeTrain, slot0.refreshProgressCurEffect, slot0)
end

function slot0._btninformationOnClick(slot0)
	ViewMgr.instance:openView(ViewName.Season166InformationMainView, {
		actId = slot0.actId
	})
end

function slot0._btntalenttreeOnClick(slot0)
	ViewMgr.instance:openView(ViewName.Season166TalentView)
end

function slot0._btnteachOnClick(slot0)
	Season166Controller.instance:enterSeasonTeachView({
		actId = slot0.actId
	})
end

function slot0._btntrainOnClick(slot0)
	slot0.isTrainState = true

	slot0:refreshEntranceState()
	Season166Controller.instance:dispatchEvent(Season166Event.MainShowTrainList)
	slot0.viewContainer:getMainSceneView():playTrainAnim(true)
end

function slot0._editableInitView(slot0)
	slot0.baseSpotItemTab = slot0:getUserDataTb_()
	slot0.trainItemTab = slot0:getUserDataTb_()
	slot0.trainProgressTab = slot0:getUserDataTb_()

	for slot4 = 1, 6 do
		slot0["_goEpisodePos" .. slot4] = gohelper.findChild(slot0._goepisodeContent, "#go_episodePos" .. slot4)
	end

	gohelper.setActive(slot0._gospotItem, false)
	gohelper.setActive(slot0._goepisodeItem, false)
	gohelper.setActive(slot0._goprogressItem, false)

	slot0.isTrainState = false
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.actId = slot0.viewParam.actId
	slot0.infoCoinId = Season166Config.instance:getSeasonConstNum(slot0.actId, Season166Enum.InfoCostId)

	slot0:refreshUI()
	TaskDispatcher.runRepeat(slot0.refreshRemainTime, slot0, 1)
	slot0.viewContainer:getMainSceneView():playInViewAnim(slot0.viewParam.jumpId)

	if slot0.viewParam.jumpId then
		slot0:processSeason166JumpParam(slot0.viewParam)
	end
end

function slot0.initBaseSpotItem(slot0)
	for slot5, slot6 in ipairs(Season166Config.instance:getSeasonBaseSpotCos(slot0.actId) or {}) do
		if not slot0.baseSpotItemTab[slot5] then
			slot7 = {
				pos = slot0["_gospot" .. slot5]
			}
			slot7.go = gohelper.clone(slot0._gospotItem, slot7.pos, "baseSpotItem" .. slot5)
			slot7.item = MonoHelper.addNoUpdateLuaComOnceToGo(slot7.go, Season166MainBaseSpotItem, {
				actId = slot0.actId,
				baseId = slot5,
				config = slot6
			})
			slot0.baseSpotItemTab[slot5] = slot7
		end

		slot7.item:refreshUI()
		gohelper.setActive(slot7.go, true)
	end
end

function slot0.initTrainEntrance(slot0)
	for slot5, slot6 in ipairs(Season166Config.instance:getSeasonTrainCos(slot0.actId)) do
		if not slot0.trainItemTab[slot5] then
			slot7 = {
				pos = slot0["_goEpisodePos" .. slot5]
			}
			slot7.go = gohelper.clone(slot0._goepisodeItem, slot7.pos, "trainItem" .. slot5)
			slot7.item = MonoHelper.addNoUpdateLuaComOnceToGo(slot7.go, Season166MainTrainItem, {
				actId = slot0.actId,
				trainId = slot5,
				config = slot6
			})
			slot0.trainItemTab[slot5] = slot7
		end

		slot7.item:refreshUI()
		gohelper.setActive(slot7.go, true)
	end

	slot0.viewContainer:getMainSceneView():setTrainItemTab(slot0.trainItemTab)
	slot0.viewContainer:getMainSceneView():refreshTrainEntranceNew()
end

function slot0.initTrainProgress(slot0)
	for slot5 = 1, #Season166Config.instance:getSeasonTrainCos(slot0.actId) do
		if not slot0.trainProgressTab[slot5] then
			slot6 = {
				go = gohelper.clone(slot0._goprogressItem, slot0._goprogress, "progressItem" .. slot5)
			}
			slot6.light = gohelper.findChild(slot6.go, "light")
			slot6.dark = gohelper.findChild(slot6.go, "dark")
			slot6.imageLight = gohelper.findChildImage(slot6.go, "light")
			slot6.imageDark = gohelper.findChildImage(slot6.go, "dark")
			slot6.goCurEffect = gohelper.findChild(slot6.go, "go_curEffect")
			slot6.config = slot1[slot5]
			slot0.trainProgressTab[slot5] = slot6

			gohelper.setActive(slot6.goCurEffect, false)
		end

		gohelper.setActive(slot6.go, true)
	end
end

function slot0.refreshUI(slot0)
	slot0:initBaseSpotItem()
	slot0:initTrainEntrance()
	slot0:initTrainProgress()
	slot0:refreshEntranceState()
	slot0:refreshRemainTime()
	slot0:refreshTrainProgress()
	slot0:refreshInformation()
	slot0:refreshInfoReddot()
	slot0:refreshTalentReddot()

	slot0._txttotalStarCount.text = Season166BaseSpotModel.instance:getCurTotalStarCount(slot0.actId)

	gohelper.setActive(slot0._goteachFinish, Season166TeachModel.instance:checkIsAllTeachFinish(slot0.actId))
end

function slot0.refreshEntranceState(slot0)
	slot0.viewContainer:getMainSceneView():playTrainEpisodeAnim(slot0.isTrainState)
	gohelper.setActive(slot0._btntrainClick.gameObject, not slot0.isTrainState)

	slot1, slot2 = Season166TrainModel.instance:isHardEpisodeUnlockTime(slot0.actId)

	gohelper.setActive(slot0._gohardUnlock, slot0.isTrainState and not slot1 and slot2 > 0)

	slot0._txthardUnlockTime.text = not slot1 and GameUtil.getSubPlaceholderLuaLang(luaLang("season166_unlockHardEpisodeTime"), {
		slot2
	}) or ""

	slot0.viewContainer:setHelpBtnShowState(slot0.isTrainState)
	slot0:setCloseOverrideFunc()
	slot0.viewContainer:getMainSceneView():setTrainLevelBg()
end

function slot0.setCloseOverrideFunc(slot0)
	if slot0.isTrainState then
		slot0.isTrainState = false

		slot0.viewContainer:setOverrideCloseClick(slot0.setTrainClose, slot0)
	else
		slot0.viewContainer:setOverrideCloseClick(slot0.closeThis, slot0)
	end
end

function slot0.setTrainClose(slot0)
	slot0:refreshEntranceState()
	slot0.viewContainer:getMainSceneView():cleanJumpData()
	slot0.viewContainer:getMainSceneView():playTrainAnim(false)
end

function slot0.refreshRemainTime(slot0)
	if not ActivityModel.instance:getActMO(slot0.actId) then
		slot0._txtremainTime.text = ""

		return
	end

	slot2, slot3 = Season166Controller.instance:getSeasonEnterCloseTimeStamp(slot0.actId)

	if slot3 > 0 then
		slot0._txtremainTime.text = TimeUtil.SecondToActivityTimeFormat(slot3)
	else
		slot0._txtremainTime.text = luaLang("ended")

		MessageBoxController.instance:showSystemMsgBox(MessageBoxIdDefine.EndActivity, MsgBoxEnum.BoxType.Yes, ActivityLiveMgr.yesCallback)
	end
end

function slot0.refreshTrainProgress(slot0)
	slot1 = Season166TrainModel.instance:getCurTrainPassCount(slot0.actId)

	for slot5, slot6 in ipairs(slot0.trainProgressTab) do
		slot7 = Season166TrainModel.instance:checkIsFinish(slot0.actId, slot5)

		gohelper.setActive(slot6.light, slot7)
		gohelper.setActive(slot6.dark, not slot7)
		UISpriteSetMgr.instance:setSeason166Sprite(slot6.imageLight, slot6.config.type == Season166Enum.TrainSpType and "season_main_chapterdifficulticon2" or "season_main_chaptericon2", true)
		UISpriteSetMgr.instance:setSeason166Sprite(slot6.imageDark, slot6.config.type == Season166Enum.TrainSpType and "season_main_chapterdifficulticon1" or "season_main_chaptericon1", true)
	end
end

function slot0.refreshProgressCurEffect(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.trainProgressTab) do
		gohelper.setActive(slot6.goCurEffect, slot5 == slot1)

		if slot5 == slot1 then
			transformhelper.setLocalScale(slot6.light.transform, 1.3, 1.3, 1.3)
			transformhelper.setLocalScale(slot6.dark.transform, 1.3, 1.3, 1.3)
		else
			transformhelper.setLocalScale(slot6.light.transform, 1, 1, 1)
			transformhelper.setLocalScale(slot6.dark.transform, 1, 1, 1)
		end
	end
end

function slot0.refreshInformation(slot0)
	UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imagecoin, string.format("%s_1", CurrencyConfig.instance:getCurrencyCo(slot0.infoCoinId) and slot1.icon), true)
	slot0:refreshInformationCoin()
end

function slot0.refreshInformationCoin(slot0)
	slot0._txtcoinNum.text = GameUtil.numberDisplay(CurrencyModel.instance:getCurrency(slot0.infoCoinId).quantity)
end

function slot0.processSeason166JumpParam(slot0, slot1)
	if slot1.jumpId == Season166Enum.JumpId.BaseSpotEpisode then
		slot0.isTrainState = false

		slot0.baseSpotItemTab[slot1.jumpParam.baseId].item:onClickBaseSpotItem()
		slot0:refreshEntranceState()
	elseif slot1.jumpId == Season166Enum.JumpId.TrainEpisode then
		slot0.isTrainState = true

		slot0.trainItemTab[slot1.jumpParam.trainId].item:onClickTrainItem()
		slot0:refreshEntranceState()
	elseif slot1.jumpId == Season166Enum.JumpId.MainView then
		slot0.isTrainState = false

		slot0:refreshEntranceState()
	elseif slot1.jumpId == Season166Enum.JumpId.TrainView then
		slot0:_btntrainOnClick()
	elseif slot1.jumpId == Season166Enum.JumpId.TeachView then
		Season166Controller.instance:enterSeasonTeachView({
			actId = slot0.actId
		})
	end
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.Season166InformationMainView then
		slot0:refreshInfoReddot()
	end

	if slot1 == ViewName.Season166TalentView then
		slot0:refreshTalentReddot()
	end
end

function slot0.refreshInfoReddot(slot0)
	RedDotController.instance:addRedDot(slot0._goinfoReddot, RedDotEnum.DotNode.Season166InformationEnter, nil, slot0.checkInfoReddotShow, slot0)
end

function slot0.checkInfoReddotShow(slot0, slot1)
	slot1:defaultRefreshDot()

	if Season166Model.instance:checkHasNewUnlockInfo() then
		gohelper.setActive(slot0._goinfoNewReddot, true)
		gohelper.setActive(slot0._goinfoReddot, false)
	else
		gohelper.setActive(slot0._goinfoNewReddot, false)
		gohelper.setActive(slot0._goinfoReddot, true)
		slot1:showRedDot(RedDotEnum.Style.Normal)
	end
end

function slot0.refreshTalentReddot(slot0)
	gohelper.setActive(slot0._gotalentReddot, Season166Model.instance:checkAllHasNewTalent(slot0.actId))
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.refreshRemainTime, slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
