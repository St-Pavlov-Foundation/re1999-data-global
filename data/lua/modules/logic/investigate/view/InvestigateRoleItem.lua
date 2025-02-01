module("modules.logic.investigate.view.InvestigateRoleItem", package.seeall)

slot0 = class("InvestigateRoleItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._simagerole = gohelper.findChildSingleImage(slot0.viewGO, "role")
	slot0._golocked = gohelper.findChild(slot0.viewGO, "locked")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "clickarea")
	slot0._goprogress = gohelper.findChild(slot0.viewGO, "progress")
	slot0._goprogresitem = gohelper.findChild(slot0.viewGO, "progress/item")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "reddot")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	if not slot0._isUnlocked then
		return
	end

	InvestigateController.instance:openInvestigateOpinionTabView({
		mo = slot0._mo
	})
end

function slot0._editableInitView(slot0)
	slot0._gounlockEffect = gohelper.findChild(slot0.viewGO, "#unlock")

	slot0:addEventCb(InvestigateController.instance, InvestigateEvent.LinkedOpinionSuccess, slot0._onLinkedOpinionSuccess, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseViewCall, slot0)
end

function slot0._onCloseViewCall(slot0, slot1)
	if slot1 == ViewName.InvestigateOpinionTabView then
		-- Nothing
	end
end

function slot0._isShowRedDot(slot0)
	return slot0._isUnlocked and InvestigateController.showInfoRedDot(slot0._mo.id)
end

function slot0._onLinkedOpinionSuccess(slot0)
	slot0:_updateProgress()
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1
	slot0._isUnlocked = slot1.episode == 0 or DungeonModel.instance:hasPassLevel(slot1.episode)

	gohelper.setActive(slot0._simagerole, slot0._isUnlocked)
	gohelper.setActive(slot0._golocked, not slot0._isUnlocked)

	if slot0._isUnlocked and not InvestigateController.hasOnceActionKey(InvestigateEnum.OnceActionType.InfoUnlock, slot0._mo.id) then
		gohelper.setActive(slot0._gounlockEffect, slot0._isUnlocked)
		InvestigateController.setOnceActionKey(InvestigateEnum.OnceActionType.InfoUnlock, slot0._mo.id)
	end

	if slot0._isUnlocked then
		slot0._simagerole:LoadImage(slot1.icon)
	end

	slot0:_initOpinionProgress()
end

function slot0._initOpinionProgress(slot0)
	slot0._progressItemList = slot0:getUserDataTb_()

	gohelper.CreateObjList(slot0, slot0._onItemShow, InvestigateConfig.instance:getInvestigateRelatedClueInfos(slot0._mo.id), slot0._goprogress, slot0._goprogresitem)
	slot0:_updateProgress()
end

function slot0._onItemShow(slot0, slot1, slot2, slot3)
	slot4 = slot0:getUserDataTb_()
	slot0._progressItemList[slot3] = slot4
	slot4.unfinished = gohelper.findChild(slot1, "unfinished")
	slot4.finished = gohelper.findChild(slot1, "finished")
	slot4.light = gohelper.findChild(slot1, "light")
	slot4.reddot = gohelper.findChild(slot1, "reddot")
	slot4.config = slot2
end

function slot0._updateProgress(slot0)
	for slot4, slot5 in ipairs(slot0._progressItemList) do
		slot6 = slot5.config.id
		slot7 = InvestigateOpinionModel.instance:getLinkedStatus(slot6)

		gohelper.setActive(slot5.unfinished, not slot7)
		gohelper.setActive(slot5.finished, slot7)
		gohelper.setActive(slot5.reddot, InvestigateOpinionModel.instance:isUnlocked(slot6) and slot0._isUnlocked and not slot7)
	end
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
end

return slot0
