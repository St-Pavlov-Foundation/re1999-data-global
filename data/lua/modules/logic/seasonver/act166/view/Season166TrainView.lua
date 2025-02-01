module("modules.logic.seasonver.act166.view.Season166TrainView", package.seeall)

slot0 = class("Season166TrainView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._txtcurIndex = gohelper.findChildText(slot0.viewGO, "right/title/#txt_curIndex")
	slot0._txttotalIndex = gohelper.findChildText(slot0.viewGO, "right/title/#txt_totalIndex")
	slot0._txttitle = gohelper.findChildText(slot0.viewGO, "right/title/#txt_title")
	slot0._txttitleEn = gohelper.findChildText(slot0.viewGO, "right/title/#txt_titleen")
	slot0._btnleftArrow = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/title/#btn_leftArrow")
	slot0._btnrightArrow = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/title/#btn_rightArrow")
	slot0._txtenemyinfo = gohelper.findChildText(slot0.viewGO, "right/episodeInfo/enemyInfo/#txt_enemyinfo")
	slot0._txtepisodeInfo = gohelper.findChildText(slot0.viewGO, "right/episodeInfo/#txt_episodeInfo")
	slot0._gorewardContent = gohelper.findChild(slot0.viewGO, "right/reward/#go_rewardContent")
	slot0._gorewardItem = gohelper.findChild(slot0.viewGO, "right/reward/#go_rewardContent/#go_rewardItem")
	slot0._btnfight = gohelper.findChildButtonWithAudio(slot0.viewGO, "right/#btn_fight")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnleftArrow:AddClickListener(slot0._btnleftArrowOnClick, slot0)
	slot0._btnrightArrow:AddClickListener(slot0._btnrightArrowOnClick, slot0)
	slot0._btnfight:AddClickListener(slot0._btnfightOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnleftArrow:RemoveClickListener()
	slot0._btnrightArrow:RemoveClickListener()
	slot0._btnfight:RemoveClickListener()
end

function slot0._btnleftArrowOnClick(slot0)
	slot0.trainId = Mathf.Max(slot0.trainId - 1, 1)

	slot0:refreshUI()
end

function slot0._btnrightArrowOnClick(slot0)
	if not slot0.unlockTrainMap[Mathf.Min(slot0.trainId + 1, #slot0.trainConfigList)] then
		GameFacade.showToast(ToastEnum.Season166TrainLock)

		return
	end

	slot0.trainId = slot1

	slot0:refreshUI()
end

function slot0._btnfightOnClick(slot0)
	Season166TrainController.instance:enterTrainFightScene()
end

function slot0._editableInitView(slot0)
	slot0.rightArrowCanvasGroup = slot0._btnrightArrow.gameObject:GetComponent(gohelper.Type_CanvasGroup)
	slot0._animPlayer = SLFramework.AnimatorPlayer.Get(slot0.viewGO)
	slot0.isClickClose = false
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.actId = slot0.viewParam.actId
	slot0.trainId = slot0.viewParam.trainId
	slot0.config = slot0.viewParam.config
	slot0.trainConfigList = Season166Config.instance:getSeasonTrainCos(slot0.actId)
	slot0.unlockTrainMap = Season166TrainModel.instance:getUnlockTrainInfoMap(slot0.actId)

	Season166Controller.instance:dispatchEvent(Season166Event.OpenTrainView, {
		isEnter = true
	})
	slot0:refreshUI()
	slot0.viewContainer:setOverrideCloseClick(slot0.setCloseOverrideFunc, slot0)
end

function slot0.refreshUI(slot0)
	slot0:refreshInfo()
	slot0:refreshReward()
	Season166Controller.instance:dispatchEvent(Season166Event.TrainViewChangeTrain, slot0.trainId)
end

function slot0.refreshInfo(slot0)
	slot0.config = slot0.trainConfigList[slot0.trainId]
	slot0._txtcurIndex.text = string.format("%02d", slot0.trainId)
	slot0._txttotalIndex.text = string.format("%02d", #slot0.trainConfigList)
	slot0._txttitle.text = slot0.config.name
	slot0._txttitleEn.text = slot0.config.nameEn
	slot0._txtepisodeInfo.text = slot0.config.desc
	slot0._txtenemyinfo.text = HeroConfig.instance:getLevelDisplayVariant(slot0.config.level)

	Season166TrainModel.instance:initTrainData(slot0.actId, slot0.trainId)
	gohelper.setActive(slot0._btnleftArrow.gameObject, slot0.trainId > 1)
	gohelper.setActive(slot0._btnrightArrow.gameObject, slot0.trainId < #slot0.trainConfigList)

	slot0.rightArrowCanvasGroup.alpha = slot0.unlockTrainMap[Mathf.Min(slot0.trainId + 1, #slot0.trainConfigList)] and 1 or 0.5
end

function slot0.refreshReward(slot0)
	gohelper.CreateObjList(slot0, slot0.rewardItemShow, string.split(slot0.config.firstBonus, "|"), slot0._gorewardContent, slot0._gorewardItem)
end

function slot0.rewardItemShow(slot0, slot1, slot2, slot3)
	slot6 = IconMgr.instance:getCommonPropItemIcon(gohelper.findChild(slot1, "go_itempos"))
	slot7 = string.splitToNumber(slot2, "#")

	slot6:setMOValue(slot7[1], slot7[2], slot7[3])
	slot6:setHideLvAndBreakFlag(true)
	slot6:hideEquipLvAndBreak(true)
	slot6:setCountFontSize(51)
	gohelper.setActive(gohelper.findChild(slot1, "go_hasget"), Season166TrainModel.instance:checkIsFinish(slot0.actId, slot0.trainId))
end

function slot0.setCloseOverrideFunc(slot0)
	if not slot0.isClickClose then
		slot0._animPlayer:Play("out", slot0.closeThis, slot0)
		Season166Controller.instance:dispatchEvent(Season166Event.CloseTrainView, {
			isEnter = false
		})
		Season166Controller.instance:dispatchEvent(Season166Event.TrainViewChangeTrain)

		slot0.isClickClose = true
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

return slot0
