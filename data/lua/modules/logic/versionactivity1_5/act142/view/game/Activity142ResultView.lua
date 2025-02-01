module("modules.logic.versionactivity1_5.act142.view.game.Activity142ResultView", package.seeall)

slot0 = class("Activity142ResultView", BaseView)

function slot0.onInitView(slot0)
	slot0._txtclassnum = gohelper.findChildText(slot0.viewGO, "txtFbName/#txt_classnum")
	slot0._txtclassname = gohelper.findChildText(slot0.viewGO, "txtFbName/#txt_classname")
	slot0._goMainTargetItem = gohelper.findChild(slot0.viewGO, "targets/#go_targetitem0")
	slot0._gotargetitem = gohelper.findChild(slot0.viewGO, "targets/#go_targetitem")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")

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
	slot0:_btnquitgameOnClick()
end

function slot0._onEscape(slot0)
	slot0:_btnquitgameOnClick()
end

function slot0._btnquitgameOnClick(slot0)
	Va3ChessController.instance:reGetActInfo(slot0._gameResultQuit, slot0)
end

function slot0._gameResultQuit(slot0)
	slot0:closeThis()
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameResultQuit)
end

function slot0._editableInitView(slot0)
	slot0._targetItemList = {}

	gohelper.setActive(slot0._gotargetitem, false)
	gohelper.setActive(slot0._goMainTargetItem, false)
	NavigateMgr.instance:addEscape(slot0.viewName, slot0._onEscape, slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot2 = Va3ChessModel.instance:getEpisodeId()

	if Va3ChessModel.instance:getActId() ~= nil and slot2 ~= nil then
		slot0._episodeCfg = Va3ChessConfig.instance:getEpisodeCo(slot1, slot2)
	end

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	if not slot0._episodeCfg then
		return
	end

	slot0._txtclassname.text = slot0._episodeCfg.name
	slot0._txtclassnum.text = slot0._episodeCfg.orderId

	slot0:refreshTaskConditions()
end

function slot0.refreshTaskConditions(slot0)
	if not slot0._episodeCfg then
		return
	end

	slot1 = slot0._episodeCfg.mainConfition

	slot0:refreshTaskItem(slot0:getOrCreateTaskItem(#string.split(slot1, "|"), true), slot1, slot0._episodeCfg.mainConditionStr, true)

	if not string.nilorempty(slot0._episodeCfg.extStarCondition) then
		slot0:refreshTaskItem(slot0:getOrCreateTaskItem(slot3 + 1), slot0._episodeCfg.extStarCondition, slot0._episodeCfg.conditionStr, true)
	end
end

function slot0.getOrCreateTaskItem(slot0, slot1, slot2)
	if not slot0._targetItemList[slot1] then
		slot3 = slot0:getUserDataTb_()
		slot3.go = gohelper.cloneInPlace(slot2 and slot0._goMainTargetItem or slot0._gotargetitem, "taskitem_" .. tostring(slot1))
		slot3.txtTaskDesc = gohelper.findChildText(slot3.go, "txt_taskdesc")
		slot3.goFinish = gohelper.findChild(slot3.go, "result/go_finish")
		slot3.goUnFinish = gohelper.findChild(slot3.go, "result/go_unfinish")
		slot3.goResult = gohelper.findChild(slot3.go, "result")
		slot0._targetItemList[slot1] = slot3
	end

	return slot3
end

function slot0.refreshTaskItem(slot0, slot1, slot2, slot3, slot4)
	gohelper.setActive(slot1.go, true)

	slot1.txtTaskDesc.text = slot3
	slot5 = slot4 and not string.nilorempty(slot2)

	gohelper.setActive(slot1.goResult, slot5)

	if slot5 then
		slot7 = Activity142Helper.checkConditionIsFinish(slot2, Va3ChessModel.instance:getActId())

		gohelper.setActive(slot1.goFinish, slot7)
		gohelper.setActive(slot1.goUnFinish, not slot7)
	end
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	NavigateMgr.instance:removeEscape(slot0.viewName, slot0._onEscape, slot0)
end

return slot0
