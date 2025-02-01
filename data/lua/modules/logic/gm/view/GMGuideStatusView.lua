module("modules.logic.gm.view.GMGuideStatusView", package.seeall)

slot0 = class("GMGuideStatusView", BaseView)
slot1 = 1
slot2 = 2
slot3 = 3

function slot0.onInitView(slot0)
	slot0._btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/btnClose")
	slot0._btnShow = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/btnShow")
	slot0._btnHide = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/btnHide")
	slot0._rect = gohelper.findChild(slot0.viewGO, "view").transform
	slot0._btnOp = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/title/btnOp")
	slot0._btnScroll = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/title/btnScroll")
	slot0._btnDelete = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/title/btnDelete")
	slot0._btnFinish = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/title/btnFinish")
	slot0._btnReverse = gohelper.findChildButtonWithAudio(slot0.viewGO, "view/title/btnReverse")
	slot0._textBtnReverse = gohelper.findChildText(slot0.viewGO, "view/title/btnReverse/Text")
	slot0._inputSearch = gohelper.findChildTextMeshInputField(slot0.viewGO, "view/title/btnOp/InputField")
end

function slot0.addEvents(slot0)
	slot0._btnClose:AddClickListener(slot0.closeThis, slot0)
	slot0._btnShow:AddClickListener(slot0._onClickShow, slot0)
	slot0._btnHide:AddClickListener(slot0._onClickHide, slot0)
	slot0._btnOp:AddClickListener(slot0._onClickOp, slot0)
	slot0._btnScroll:AddClickListener(slot0._onClickScroll, slot0)
	slot0._btnDelete:AddClickListener(slot0._onClickDelete, slot0)
	slot0._btnFinish:AddClickListener(slot0._onClickFinish, slot0)
	slot0._btnReverse:AddClickListener(slot0._onClicReverse, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnClose:RemoveClickListener()
	slot0._btnShow:RemoveClickListener()
	slot0._btnHide:RemoveClickListener()
	slot0._btnOp:RemoveClickListener()
	slot0._btnScroll:RemoveClickListener()
	slot0._btnDelete:RemoveClickListener()
	slot0._btnFinish:RemoveClickListener()
	slot0._btnReverse:RemoveClickListener()

	if slot0._inputSearch then
		slot0._inputSearch:RemoveOnValueChanged()
		slot0._inputSearch:RemoveOnEndEdit()
	end
end

function slot0.onOpen(slot0)
	slot0._state = uv0

	slot0:_updateBtns()
	TaskDispatcher.runRepeat(slot0._updateUI, slot0, 0.5)
	slot0:_updateBtnReverseText()
end

function slot0.onClose(slot0)
	if slot0._tweenId then
		ZProj.TweenHelper.KillById(slot0._tweenId)

		slot0._tweenId = nil
	end

	TaskDispatcher.cancelTask(slot0._updateUI, slot0)
	TaskDispatcher.cancelTask(slot0._delayCancelForbid, slot0)
	TaskDispatcher.cancelTask(slot0._dealFinishSecond, slot0)
	TaskDispatcher.cancelTask(slot0._onFrameDeleteGuides, slot0)
	UIBlockMgr.instance:endBlock("GMGuideStatusOneKeyFinish")
	GuideController.instance:unregisterCallback(GuideEvent.StartGuide, slot0._onStartGuide, slot0)
	slot0:_delayCancelForbid()
end

function slot0._updateUI(slot0)
	GMGuideStatusModel.instance:updateModel()
end

function slot0._onClickShow(slot0)
	if slot0._state == uv0 then
		slot0._state = uv1
		slot0._tweenId = ZProj.TweenHelper.DOAnchorPosX(slot0._rect, 0, 0.2, slot0._onShow, slot0)
	end
end

function slot0._onShow(slot0)
	slot0._tweenId = nil
	slot0._state = uv0

	slot0:_updateBtns()
end

function slot0._onClickHide(slot0)
	if slot0._state == uv0 then
		slot0._state = uv1
		slot0._tweenId = ZProj.TweenHelper.DOAnchorPosX(slot0._rect, -800, 0.2, slot0._onHide, slot0)
	end
end

function slot0._onClickOp(slot0)
	if slot0._inputSearch then
		slot0._inputSearch:SetText(GMGuideStatusModel.instance:getSearch())
		gohelper.setActive(slot0._inputSearch.gameObject, true)
		slot0._inputSearch:AddOnValueChanged(slot0._onSearchValueChanged, slot0)
		slot0._inputSearch:AddOnEndEdit(slot0._onSearchEndEdit, slot0)
	end
end

function slot0._onSearchValueChanged(slot0, slot1)
	GMGuideStatusModel.instance:setSearch(slot1)
end

function slot0._onSearchEndEdit(slot0, slot1)
	gohelper.setActive(slot0._inputSearch.gameObject, false)
end

function slot0._onClickScroll(slot0)
	slot1 = gohelper.onceAddComponent(gohelper.findChild(slot0.viewGO, "view/scroll"), typeof(UnityEngine.CanvasGroup))
	slot1.blocksRaycasts = not slot1.blocksRaycasts

	GMGuideStatusModel.instance:onClickShowOpBtn()

	gohelper.findChildText(slot0._btnScroll.gameObject, "Text").text = slot1.blocksRaycasts and "点击穿透" or "允许操作"
end

function slot0._onClickDelete(slot0)
	slot0._toDeleteGuides = {}

	for slot5, slot6 in ipairs(GuideModel.instance:getList()) do
		table.insert(slot0._toDeleteGuides, slot6.id)
	end

	TaskDispatcher.runRepeat(slot0._onFrameDeleteGuides, slot0, 0.033)
end

function slot0._onFrameDeleteGuides(slot0)
	if slot0._toDeleteGuides and #slot0._toDeleteGuides > 0 then
		slot1 = table.remove(slot0._toDeleteGuides, 1)

		GMRpc.instance:sendGMRequest("delete guide " .. slot1)
		GuideStepController.instance:clearFlow(slot1)
		GuideModel.instance:remove(GuideModel.instance:getById(slot1))

		if #slot0._toDeleteGuides % 30 == 0 and #slot0._toDeleteGuides > 0 then
			GameFacade.showToast(ToastEnum.IconId, "left:" .. #slot0._toDeleteGuides)
		end
	end

	if not slot0._toDeleteGuides or #slot0._toDeleteGuides == 0 then
		GameFacade.showToast(ToastEnum.IconId, "finish")

		slot0._toDeleteGuides = nil

		TaskDispatcher.cancelTask(slot0._onFrameDeleteGuides, slot0)
	end
end

function slot0._onClickFinish(slot0)
	slot0._needFinishGuides = {}
	slot0._needDelayFinishGuides = {}

	for slot5, slot6 in ipairs(GuideConfig.instance:getGuideList()) do
		if GuideModel.instance:getById(slot6.id) then
			if not slot8.isFinish then
				GuideStepController.instance:clearFlow(slot7)
				table.insert(slot0._needFinishGuides, slot7)
			end
		else
			table.insert(slot0._needDelayFinishGuides, slot7)
		end
	end

	if #slot0._needDelayFinishGuides > 0 then
		slot0._prevForbidStatus = GuideController.instance:isForbidGuides()

		if not slot0._prevForbidStatus then
			GuideController.instance:tempForbidGuides(true)
		end

		GuideController.instance:registerCallback(GuideEvent.StartGuide, slot0._onStartGuide, slot0)
	end

	if #slot0._needFinishGuides > 0 or #slot0._needDelayFinishGuides > 0 then
		slot0:_dealFinishSecond()
		TaskDispatcher.runRepeat(slot0._dealFinishSecond, slot0, 0.01)
	end
end

slot4 = 60

function slot0._dealFinishSecond(slot0)
	slot0._hasSendGuideTimes = slot0._hasSendGuideTimes or {}

	for slot6 = 1, #slot0._hasSendGuideTimes do
		if Time.realtimeSinceStartup - slot0._hasSendGuideTimes[1] > 1 then
			table.remove(slot0._hasSendGuideTimes, 1)
		end
	end

	if #slot0._hasSendGuideTimes < uv0 then
		if #slot0._needFinishGuides > 0 then
			slot0:_sendFinishGuide(table.remove(slot0._needFinishGuides, 1))
		elseif #slot0._needDelayFinishGuides > 0 then
			GuideController.instance:startGudie(table.remove(slot0._needDelayFinishGuides, 1))
			table.insert(slot0._hasSendGuideTimes, slot1)
		end
	end

	if (slot0._needFinishGuides and #slot0._needFinishGuides or 0) + (slot0._needDelayFinishGuides and #slot0._needDelayFinishGuides or 0) > 0 then
		if slot3 % 20 == 0 then
			GameFacade.showToast(ToastEnum.IconId, "left: " .. slot3)
		end

		UIBlockMgr.instance:startBlock("GMGuideStatusOneKeyFinish")
	else
		UIBlockMgr.instance:endBlock("GMGuideStatusOneKeyFinish")
		GameFacade.showToast(ToastEnum.IconId, "finish")
		TaskDispatcher.runDelay(slot0._delayCancelForbid, slot0, 1)
		TaskDispatcher.cancelTask(slot0._dealFinishSecond, slot0)
	end
end

function slot0._onClicReverse(slot0)
	GMGuideStatusModel.instance:onClickReverse()
	slot0:_updateBtnReverseText()
end

function slot0._delayCancelForbid(slot0)
	if not slot0._prevForbidStatus then
		GuideController.instance:tempForbidGuides(false)
	end

	slot0._prevForbidStatus = nil

	GuideController.instance:unregisterCallback(GuideEvent.StartGuide, slot0._onStartGuide, slot0)
end

function slot0._onStartGuide(slot0, slot1)
	GuideStepController.instance:clearFlow(slot1)
	slot0:_sendFinishGuide(slot1)
end

function slot0._sendFinishGuide(slot0, slot1)
	if not GuideModel.instance:getById(slot1) then
		return
	end

	for slot7 = #GuideConfig.instance:getStepList(slot1), 1, -1 do
		if slot3[slot7].keyStep == 1 then
			slot0._hasSendGuideTimes = slot0._hasSendGuideTimes or {}

			table.insert(slot0._hasSendGuideTimes, Time.realtimeSinceStartup)
			GuideRpc.instance:sendFinishGuideRequest(slot1, slot8.stepId)

			break
		end
	end
end

function slot0._updateBtnReverseText(slot0)
	slot0._textBtnReverse.text = GMGuideStatusModel.instance.idReverse and luaLang("p_roombuildingfilterview_raredown") or luaLang("p_roombuildingfilterview_rareup")
end

function slot0._onHide(slot0)
	slot0._tweenId = nil
	slot0._state = uv0

	slot0:_updateBtns()
end

function slot0._updateBtns(slot0)
	gohelper.setActive(slot0._btnShow.gameObject, slot0._state == uv0)
	gohelper.setActive(slot0._btnHide.gameObject, slot0._state == uv1)
end

return slot0
