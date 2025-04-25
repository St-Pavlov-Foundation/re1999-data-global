module("modules.logic.versionactivity2_5.act186.view.Activity186GameDialogueView", package.seeall)

slot0 = class("Activity186GameDialogueView", BaseView)

function slot0.onInitView(slot0)
	slot0.goRight = gohelper.findChild(slot0.viewGO, "root/right")
	slot0.rightAnim = slot0.goRight:GetComponent(gohelper.Type_Animator)
	slot0.txtDesc = gohelper.findChildTextMesh(slot0.viewGO, "root/right/desc")
	slot0.txtContent = gohelper.findChildTextMesh(slot0.viewGO, "root/#goRole/bottom/#txt_Dialouge")
	slot0.options = {}
	slot0.btnClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/right/#btn_close")
	slot0.goOptions = gohelper.findChild(slot0.viewGO, "root/right/options")
	slot0.goRewards = gohelper.findChild(slot0.viewGO, "root/right/rewards")
	slot0.goReward1 = gohelper.findChild(slot0.viewGO, "root/right/rewards/reward1")
	slot0.txtRewardNum1 = gohelper.findChildTextMesh(slot0.viewGO, "root/right/rewards/reward1/#txt_num")
	slot0.goReward2 = gohelper.findChild(slot0.viewGO, "root/right/rewards/reward2")
	slot0.simageReward2 = gohelper.findChildSingleImage(slot0.viewGO, "root/right/rewards/reward2/icon")
	slot0.txtRewardNum2 = gohelper.findChildTextMesh(slot0.viewGO, "root/right/rewards/reward2/#txt_num")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addClickCb(slot0.btnClose, slot0.onClickBtnClose, slot0)
	slot0:addEventCb(Activity186Controller.instance, Activity186Event.FinishGame, slot0.onFinishGame, slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
end

function slot0.onClickBtnClose(slot0)
	slot0:closeThis()
end

function slot0.onClickOption(slot0, slot1)
	if slot0.gameStatus ~= Activity186Enum.GameStatus.Playing then
		return
	end

	if slot0._selectIndex ~= slot1 then
		slot0._selectIndex = slot1

		slot0:updateSelect()
	end

	if not slot0.questionConfig then
		return
	end

	if slot0.questionConfig["rewardId" .. slot1] == 0 then
		return
	end

	slot0.txtDesc.text = slot0.questionConfig["feedback" .. slot1]
	slot0.txtContent.text = slot0.questionConfig.hanzhangline4

	slot0:showResult(slot2)
	Activity186Rpc.instance:sendFinishAct186ATypeGameRequest(slot0.actId, slot0.gameId, slot2)
end

function slot0.onFinishGame(slot0)
	slot0:checkGameNotOnline()
end

function slot0.checkGameNotOnline(slot0)
	if not Activity186Model.instance:getById(slot0.actId) then
		return
	end

	if not slot1:getGameInfo(slot0.gameId) then
		return
	end

	if not slot1:isGameOnline(slot0.gameId) then
		slot0:closeThis()
	end
end

function slot0.onUpdateParam(slot0)
	slot0:refreshParam()
	slot0:refreshView()
end

function slot0.onOpen(slot0)
	slot0:refreshParam()
	slot0:refreshView()
end

function slot0.refreshParam(slot0)
	slot0.actId = slot0.viewParam.activityId
	slot0.gameId = slot0.viewParam.gameId
	slot0.gameStatus = slot0.viewParam.gameStatus
end

function slot0.refreshView(slot0)
	if slot0.gameStatus == Activity186Enum.GameStatus.Playing then
		slot0:_showDeadline()
		slot0.rightAnim:Play("open")

		slot2 = Activity186Model.instance:getById(slot0.actId):getQuestionConfig(slot0.gameId)
		slot0.questionConfig = slot2
		slot0.txtDesc.text = slot2.question

		AudioMgr.instance:trigger(AudioEnum.Act186.play_ui_mln_unlock)
		slot0:updateOptions(slot2)
	end
end

function slot0.updateOptions(slot0, slot1)
	for slot5 = 1, 3 do
		slot0:updateOption(slot5, slot1)
	end

	slot0:updateSelect()
end

function slot0.updateSelect(slot0)
	for slot4 = 1, 3 do
		gohelper.setActive(slot0:getOrCreateOption(slot4).goNormal, slot0._selectIndex ~= slot4)
		gohelper.setActive(slot5.goSelect, slot0._selectIndex == slot4)
	end
end

function slot0.updateOption(slot0, slot1, slot2)
	slot3 = slot0:getOrCreateOption(slot1)

	if string.nilorempty(slot2["answer" .. slot1]) then
		gohelper.setActive(slot3.go, false)

		return
	end

	gohelper.setActive(slot3.go, true)

	slot3.txtNormal.text = slot4
	slot3.txtSelect.text = slot4
end

function slot0.getOrCreateOption(slot0, slot1)
	if not slot0.options[slot1] then
		slot2 = slot0:getUserDataTb_()
		slot2.go = gohelper.findChild(slot0.viewGO, "root/right/options/item" .. slot1)
		slot2.goNormal = gohelper.findChild(slot2.go, "normal")
		slot2.goSelect = gohelper.findChild(slot2.go, "select")
		slot2.txtNormal = gohelper.findChildTextMesh(slot2.goNormal, "#txt_dec")
		slot2.txtSelect = gohelper.findChildTextMesh(slot2.goSelect, "#txt_dec")
		slot2.btn = gohelper.findButtonWithAudio(slot2.go)

		slot2.btn:AddClickListener(slot0.onClickOption, slot0, slot1)

		slot0.options[slot1] = slot2
	end

	return slot2
end

function slot0.showResult(slot0, slot1)
	slot0.gameStatus = Activity186Enum.GameStatus.Result

	slot0.rightAnim:Play("finish")
	slot0:refreshReward(Activity186Config.instance:getGameRewardConfig(1, slot1).bonus)
end

function slot0.refreshReward(slot0, slot1)
	slot3 = {}

	for slot7, slot8 in ipairs(GameUtil.splitString2(slot1, true)) do
		if slot8[1] ~= 26 then
			table.insert(slot3, slot8)
		end
	end

	slot5 = slot3[2]

	if slot3[1] then
		slot0.txtRewardNum1.text = string.format("×%s", slot4[3])

		gohelper.setActive(slot0.goReward1, true)
	else
		gohelper.setActive(slot0.goReward1, false)
	end

	if slot5 then
		gohelper.setActive(slot0.goReward2, true)

		slot6, slot7 = ItemModel.instance:getItemConfigAndIcon(slot5[1], slot5[2], true)

		slot0.simageReward2:LoadImage(slot7)

		slot0.txtRewardNum2.text = string.format("×%s", slot5[3])
	else
		gohelper.setActive(slot0.goReward2, false)
	end
end

function slot0._showDeadline(slot0)
	slot0:_onRefreshDeadline()
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
	TaskDispatcher.runRepeat(slot0._onRefreshDeadline, slot0, 1)
end

function slot0._onRefreshDeadline(slot0)
	slot0:checkGameNotOnline()
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0._onRefreshDeadline, slot0)

	for slot4, slot5 in ipairs(slot0.options) do
		slot5.btn:RemoveClickListener()
	end
end

return slot0
