module("modules.logic.versionactivity2_2.lopera.view.LoperaGameResultView", package.seeall)

slot0 = class("LoperaGameResultView", BaseView)
slot1 = VersionActivity2_2Enum.ActivityId.Lopera

function slot0.onInitView(slot0)
	slot0._simagebg2 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg2")
	slot0._simagebg1 = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg1")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._txtStageNum = gohelper.findChildText(slot0.viewGO, "txtFbName/#txt_classnum")
	slot0._txtStageName = gohelper.findChildText(slot0.viewGO, "txtFbName/#txt_classname")
	slot0._gosuccess = gohelper.findChild(slot0.viewGO, "#go_success")
	slot0._gofail = gohelper.findChild(slot0.viewGO, "#go_fail")
	slot0._txtEventNum = gohelper.findChildText(slot0.viewGO, "targets/#go_targetitem/#txt_Num")
	slot0._txtActionPoint = gohelper.findChildText(slot0.viewGO, "targets/#go_actionpoint/#txt_Num")
	slot0._goTips = gohelper.findChild(slot0.viewGO, "content/Layout/#go_Tips")
	slot0._txtTips = gohelper.findChildText(slot0.viewGO, "Tips/#txt_Tips")
	slot0._scrollItem = gohelper.findChild(slot0.viewGO, "#scroll_List/Viewport/Content/#go_Item")
	slot0._gorewardContent = gohelper.findChild(slot0.viewGO, "#scroll_List/Viewport/Content")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	if slot0:isLockOp() then
		return
	end

	LoperaController.instance:gameResultOver()
end

function slot0._editableInitView(slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._animator = slot0.viewGO:GetComponent(AiZiLaEnum.ComponentType.Animator)

	slot0:addEventCb(LoperaController.instance, LoperaEvent.ExitGame, slot0.onExitGame, slot0)

	if slot0.viewContainer then
		NavigateMgr.instance:addEscape(slot0.viewContainer.viewName, slot0._btncloseOnClick, slot0)
	end

	slot0:_setLockOpTime(1)
	slot0:refreshUI()
end

function slot0.onExitGame(slot0)
	slot0:closeThis()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0.playViewAnimator(slot0, slot1)
	if slot0._animator then
		slot0._animator.enabled = true

		slot0._animator:Play(slot1, 0, 0)
	end
end

function slot0.refreshUI(slot0)
	slot0._isEndLess = Activity168Model.instance:getCurGameState().endlessId > 0
	slot9 = slot5 == LoperaEnum.ResultEnum.PowerUseup and not slot0._isEndLess or slot5 == LoperaEnum.ResultEnum.Quit
	slot10 = Activity168Config.instance:getEpisodeCfg(uv0, Activity168Model.instance:getCurEpisodeId())
	slot0._txtStageName.text = slot10.name
	slot0._txtStageNum.text = slot10.orderId

	gohelper.setActive(slot0._gosuccess, slot0.viewParam.settleReason == LoperaEnum.ResultEnum.Completed or slot0._isEndLess)
	gohelper.setActive(slot0._gofail, slot9)
	AudioMgr.instance:trigger(slot9 and AudioEnum.VersionActivity2_2Lopera.play_ui_pkls_challenge_fail or AudioEnum.VersionActivity2_2Lopera.play_ui_pkls_endpoint_arriva)

	slot0._txtEventNum.text = slot4.cellCount
	slot0._txtActionPoint.text = math.max(0, Activity168Model.instance:getCurActionPoint())

	slot0:refreshAllItems()
end

function slot0.refreshAllItems(slot0)
	slot0._items = {}

	for slot6, slot7 in ipairs(slot0.viewParam.totalItems) do
		slot0._items[#slot0._items + 1] = {
			itemId = slot7.itemId,
			count = slot7.count
		}
	end

	gohelper.CreateObjList(slot0, slot0._createItem, slot0._items, slot0._gorewardContent, slot0._scrollItem, LoperaGoodsItem)
end

function slot0._createItem(slot0, slot1, slot2, slot3)
	slot1:onUpdateData(Activity168Config.instance:getGameItemCfg(uv0, slot2.itemId), slot2.count, slot3)
end

function slot0._setLockOpTime(slot0, slot1)
	slot0._lockTime = Time.time + slot1
end

function slot0.isLockOp(slot0)
	if slot0._lockTime and Time.time < slot0._lockTime then
		return true
	end

	return false
end

return slot0
