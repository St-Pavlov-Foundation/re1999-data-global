module("modules.logic.investigate.view.InvestigateRoleMultiItem", package.seeall)

slot0 = class("InvestigateRoleMultiItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._simagerole = gohelper.findChildSingleImage(slot0.viewGO, "role")
	slot0._btn1click = gohelper.findChildButtonWithAudio(slot0.viewGO, "role_1/click")
	slot0._btn2click = gohelper.findChildButtonWithAudio(slot0.viewGO, "role_2/click")
	slot0._btn3click = gohelper.findChildButtonWithAudio(slot0.viewGO, "role_3/click")
	slot0._btnallclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_fullimg/click")
	slot0._goprogress = gohelper.findChild(slot0.viewGO, "progress")
	slot0._goprogresitem = gohelper.findChild(slot0.viewGO, "progress/item")
	slot0._goreddot = gohelper.findChild(slot0.viewGO, "reddot")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btn1click:AddClickListener(slot0._btnclick1OnClick, slot0)
	slot0._btn2click:AddClickListener(slot0._btnclick2OnClick, slot0)
	slot0._btn3click:AddClickListener(slot0._btnclick3OnClick, slot0)
	slot0._btnallclick:AddClickListener(slot0._btnclickallOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btn1click:RemoveClickListener()
	slot0._btn2click:RemoveClickListener()
	slot0._btn3click:RemoveClickListener()
	slot0._btnallclick:RemoveClickListener()
end

function slot0._btnclickallOnClick(slot0)
	InvestigateController.instance:openInvestigateOpinionTabView({
		mo = slot0._moList[1],
		moList = slot0._moList
	})
end

function slot0._btnclick3OnClick(slot0)
	if not slot0._isUnlocked then
		return
	end

	InvestigateController.instance:openInvestigateOpinionTabView({
		mo = slot0._moList[3],
		moList = slot0._moList
	})
end

function slot0._btnclick2OnClick(slot0)
	if not slot0._isUnlocked then
		return
	end

	InvestigateController.instance:openInvestigateOpinionTabView({
		mo = slot0._moList[2],
		moList = slot0._moList
	})
end

function slot0._btnclick1OnClick(slot0)
	if not slot0._isUnlocked then
		return
	end

	InvestigateController.instance:openInvestigateOpinionTabView({
		mo = slot0._moList[1],
		moList = slot0._moList
	})
end

function slot0._editableInitView(slot0)
	slot0._gofullimg = gohelper.findChild(slot0.viewGO, "#go_fullimg")
	slot0._goUnFinishedBg = gohelper.findChild(slot0.viewGO, "#simage_bg")

	slot0:addEventCb(InvestigateController.instance, InvestigateEvent.LinkedOpinionSuccess, slot0._onLinkedOpinionSuccess, slot0)

	slot0._gounlock1 = gohelper.findChild(slot0.viewGO, "#unlock1")
	slot0._gounlock2 = gohelper.findChild(slot0.viewGO, "#unlock2")
	slot0._gounlock3 = gohelper.findChild(slot0.viewGO, "#unlock3")

	gohelper.setActive(slot0._gounlock1, false)
	gohelper.setActive(slot0._gounlock2, false)
	gohelper.setActive(slot0._gounlock3, false)
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
	slot0:_initOpinionProgress()
	slot0:_checkFinish()
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._moList = slot1

	slot0:_checkFinish()

	if not slot0._roleList then
		slot0._roleList = slot0:getUserDataTb_()

		for slot5 = 1, #slot1 do
			slot0._roleList[slot5] = {
				role = gohelper.findChildSingleImage(slot0.viewGO, string.format("role_%s", slot5)),
				lock = gohelper.findChild(slot0.viewGO, string.format("role_%s_locked", slot5))
			}
		end
	end

	for slot5, slot6 in ipairs(slot1) do
		slot7 = slot0._roleList[slot5]
		slot8 = slot6.episode == 0 or DungeonModel.instance:hasPassLevel(slot6.episode)

		gohelper.setActive(slot7.role, slot8 and not slot0._isAllFinished)
		gohelper.setActive(slot7.lock, not slot8 and not slot0._isAllFinished)
	end

	slot0._mo = slot1[1]
	slot0._isUnlocked = slot0._mo.episode == 0 or DungeonModel.instance:hasPassLevel(slot0._mo.episode)

	if slot0._isUnlocked and not InvestigateController.hasOnceActionKey(InvestigateEnum.OnceActionType.InfoUnlock, slot0._mo.id) and not slot0._isAllFinished then
		gohelper.setActive(slot0._gounlock1, true)
		gohelper.setActive(slot0._gounlock2, true)
		gohelper.setActive(slot0._gounlock3, true)
		InvestigateController.setOnceActionKey(InvestigateEnum.OnceActionType.InfoUnlock, slot0._mo.id)
	end

	slot0:_initOpinionProgress()
end

function slot0._initOpinionProgress(slot0)
	slot0._progressItemList = slot0:getUserDataTb_()
	slot1 = {}

	for slot5, slot6 in ipairs(slot0._moList) do
		tabletool.addValues(slot1, InvestigateConfig.instance:getInvestigateRelatedClueInfos(slot6.id))
	end

	gohelper.CreateObjList(slot0, slot0._onItemShow, slot1, slot0._goprogress, slot0._goprogresitem)
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

function slot0._allFinished(slot0)
	if not slot0._moList then
		return false
	end

	for slot4, slot5 in ipairs(slot0._moList) do
		if not InvestigateOpinionModel.instance:allOpinionLinked(slot5.id) then
			return false
		end
	end

	return true
end

function slot0._checkFinish(slot0)
	slot0._isAllFinished = slot0:_allFinished()

	gohelper.setActive(slot0._gofullimg, slot0._isAllFinished)
	gohelper.setActive(slot0._goUnFinishedBg, not slot0._isAllFinished)
end

function slot0.onSelect(slot0, slot1)
end

function slot0.onDestroyView(slot0)
end

return slot0
