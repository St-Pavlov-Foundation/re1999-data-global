module("modules.logic.seasonver.act166.view.information.Season166InformationMainView", package.seeall)

slot0 = class("Season166InformationMainView", BaseView)

function slot0.onInitView(slot0)
	slot0.reportItems = {}
	slot0.btnReward = gohelper.findChildButtonWithAudio(slot0.viewGO, "Reward/#btn_Reward")
	slot0.txtRewardNum = gohelper.findChildTextMesh(slot0.viewGO, "Reward/#txt_RewardNum")
	slot0.slider = gohelper.findChildImage(slot0.viewGO, "Reward/#go_Slider")
	slot0.gorewardReddot = gohelper.findChild(slot0.viewGO, "Reward/#go_rewardReddot")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0.btnReward, slot0.onClickReward, slot0)
	slot0:addEventCb(Season166Controller.instance, Season166Event.OnInformationUpdate, slot0.onInformationUpdate, slot0)
	slot0:addEventCb(Season166Controller.instance, Season166Event.OnAnalyInfoSuccess, slot0.onAnalyInfoSuccess, slot0)
	slot0:addEventCb(Season166Controller.instance, Season166Event.OnGetInfoBonus, slot0.onGetInfoBonus, slot0)
	slot0:addEventCb(Season166Controller.instance, Season166Event.OnGetInformationBonus, slot0.onGetInformationBonus, slot0)
	slot0:addEventCb(Season166Controller.instance, Season166Event.ClickInfoReportItem, slot0.setLocalUnlockState, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onViewClose, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0.localUnlockStateTab = slot0:getUserDataTb_()
end

function slot0.onClickReward(slot0)
	ViewMgr.instance:openView(ViewName.Season166InformationRewardView, {
		actId = slot0.actId
	})
end

function slot0.onUpdateParam(slot0)
end

function slot0.onAnalyInfoSuccess(slot0)
	slot0:refreshUI()
end

function slot0.onGetInfoBonus(slot0)
	slot0:refreshUI()
end

function slot0.onInformationUpdate(slot0)
	slot0:refreshUI()
end

function slot0.onGetInformationBonus(slot0)
	slot0:refreshUI()
end

function slot0.onOpen(slot0)
	slot0.actId = slot0.viewParam.actId

	slot0:refreshUI()
	RedDotController.instance:addRedDot(slot0.gorewardReddot, RedDotEnum.DotNode.Season166InfoBigReward)
end

function slot0.refreshUI(slot0)
	if not slot0.actId then
		return
	end

	if ViewMgr.instance:isOpen(ViewName.Season166InformationAnalyView) then
		return
	end

	slot0:refreshReport()

	slot2, slot3 = Season166Model.instance:getActInfo(slot0.actId):getBonusNum()
	slot0.txtRewardNum.text = string.format("<color=#de9754>%s</color>/%s", slot2, slot3)
	slot0.slider.fillAmount = slot2 / slot3

	slot0:refreshItemUnlockState()
end

function slot0.refreshReport(slot0)
	slot5 = #(Season166Config.instance:getSeasonInfos(slot0.actId) or {})

	for slot5 = 1, math.max(slot5, #slot0.reportItems) do
		if not slot0.reportItems[slot5] and gohelper.findChild(slot0.viewGO, string.format("Report%s", slot5)) then
			slot0.reportItems[slot5] = MonoHelper.addNoUpdateLuaComOnceToGo(slot7, Season166InformationReportItem)
		end

		if slot6 then
			slot6:refreshUI(slot1[slot5])
		end
	end
end

function slot0.refreshItemUnlockState(slot0)
	slot2 = Season166Model.instance:getLocalPrefsTab(Season166Enum.ReportUnlockAnimLocalSaveKey)
	slot3 = Season166Model.instance:getLocalPrefsTab(Season166Enum.ReportFinishAnimLocalSaveKey)

	for slot7, slot8 in pairs(slot0.reportItems) do
		if GameUtil.getTabLen(Season166Model.instance:getLocalUnlockState(Season166Enum.InforMainLocalSaveKey)) == 0 then
			slot8:refreshUnlockState(false)

			slot0.localUnlockStateTab[slot7] = Season166Enum.LockState
		else
			slot9 = slot1[slot7]

			slot8:refreshUnlockState(slot9)

			slot0.localUnlockStateTab[slot7] = slot9
		end

		slot8:refreshUnlockAnimState(slot2)
		slot8:refreshFinishAnimState(slot3)
	end

	slot0:saveUnlockState()
end

function slot0.saveUnlockState(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.localUnlockStateTab) do
		table.insert(slot1, string.format("%s|%s", slot5, slot6))
	end

	Season166Controller.instance:savePlayerPrefs(Season166Enum.InforMainLocalSaveKey, cjson.encode(slot1))
end

function slot0.setLocalUnlockState(slot0, slot1)
	slot0.localUnlockStateTab[slot1.infoId] = slot1.unlockState

	slot0:saveUnlockState()
end

function slot0._onViewClose(slot0, slot1)
	if slot1 == ViewName.Season166InformationAnalyView then
		slot0:refreshUI()
	end
end

function slot0.onClose(slot0)
	slot0:saveUnlockState()
end

function slot0.onDestroyView(slot0)
end

return slot0
