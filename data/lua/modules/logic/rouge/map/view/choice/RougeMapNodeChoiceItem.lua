module("modules.logic.rouge.map.view.choice.RougeMapNodeChoiceItem", package.seeall)

slot0 = class("RougeMapNodeChoiceItem", RougeMapChoiceBaseItem)

function slot0._editableInitView(slot0)
	uv0.super._editableInitView(slot0)

	slot0._btnlockdetail = gohelper.findChildButtonWithAudio(slot0.go, "#go_locked/#btn_lockdetail")
	slot0._btnnormaldetail = gohelper.findChildButtonWithAudio(slot0.go, "#go_normal/#btn_normaldetail")
	slot0._btnselectdetail = gohelper.findChildButtonWithAudio(slot0.go, "#go_select/#btn_selectdetail")

	slot0._btnlockdetail:AddClickListener(slot0.onClickDetail, slot0)
	slot0._btnnormaldetail:AddClickListener(slot0.onClickDetail, slot0)
	slot0._btnselectdetail:AddClickListener(slot0.onClickDetail, slot0)
end

function slot0.onClickDetail(slot0)
	if not slot0.hadCollection then
		return
	end

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onClickChoiceDetail, slot0.collectionIdList)
end

function slot0.onClickSelf(slot0)
	if RougeMapModel.instance:isInteractiving() then
		return
	end

	if RougeMapModel.instance:isPlayingDialogue() then
		return
	end

	if slot0.status == RougeMapEnum.ChoiceStatus.Lock then
		return
	end

	if slot0.status == RougeMapEnum.ChoiceStatus.Select then
		slot0.animator:Play("select", 0, 0)
		TaskDispatcher.cancelTask(slot0.onSelectAnimDone, slot0)
		TaskDispatcher.runDelay(slot0.onSelectAnimDone, slot0, RougeMapEnum.ChoiceSelectAnimDuration)
		UIBlockMgr.instance:startBlock(RougeMapEnum.WaitChoiceItemAnimBlock)
	else
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onChoiceItemStatusChange, slot0.choiceId)
	end
end

function slot0.onSelectAnimDone(slot0)
	RougeMapModel.instance:recordCurChoiceEventSelectId(slot0.choiceId)
	RougeRpc.instance:sendRougeChoiceEventRequest(slot0.choiceId)
	UIBlockMgr.instance:endBlock(RougeMapEnum.WaitChoiceItemAnimBlock)
end

function slot0.onStatusChange(slot0, slot1)
	if slot0.status == RougeMapEnum.ChoiceStatus.Lock then
		return
	end

	slot2 = nil

	if ((not slot1 or (slot1 ~= slot0.choiceId or RougeMapEnum.ChoiceStatus.Select) and RougeMapEnum.ChoiceStatus.UnSelect) and RougeMapEnum.ChoiceStatus.Normal) == slot0.status then
		return
	end

	slot0.status = slot2

	slot0:refreshUI()
end

function slot0.update(slot0, slot1, slot2, slot3)
	uv0.super.update(slot0, slot2)

	slot0.choiceId = slot1
	slot0.choiceCo = lua_rouge_choice.configDict[slot1]
	slot0.nodeMo = slot3

	slot0:buildCollectionIdList()

	slot0.title = slot0.choiceCo.title
	slot0.desc = slot0.choiceCo.desc

	slot0:initStatus()

	if slot0.status == RougeMapEnum.ChoiceStatus.Lock then
		slot0.tip = RougeMapUnlockHelper.getLockTips(slot0.choiceCo.unlockType, slot0.choiceCo.unlockParam)
	else
		slot0.tip = ""
	end

	slot0:refreshUI()
	slot0:playUnlockAnim()
end

function slot0.buildCollectionIdList(slot0)
	if not string.nilorempty(slot0.choiceCo.display) then
		slot0.hadCollection = true
		slot0.collectionIdList = string.splitToNumber(slot1, "|")

		return
	end

	if string.nilorempty(slot0.choiceCo.interactive) then
		slot0.hadCollection = false
		slot0.collectionIdList = nil

		return
	end

	if string.splitToNumber(slot2, "#")[1] == RougeMapEnum.InteractType.LossNotUniqueCollection then
		if slot0.nodeMo.interactive9drop == 0 then
			slot0.hadCollection = false
			slot0.collectionIdList = nil
		else
			slot0.hadCollection = true
			slot0.collectionIdList = {
				slot4
			}
		end
	elseif slot3 == RougeMapEnum.InteractType.StorageCollection then
		if slot0.nodeMo.interactive10drop == 0 then
			slot0.hadCollection = false
			slot0.collectionIdList = nil
		else
			slot0.hadCollection = true
			slot0.collectionIdList = {
				slot4
			}
		end
	elseif slot3 == RougeMapEnum.InteractType.LossSpCollection then
		if slot0.nodeMo.interactive14drop == 0 then
			slot0.hadCollection = false
			slot0.collectionIdList = nil
		else
			slot0.hadCollection = true
			slot0.collectionIdList = {
				slot4
			}
		end
	else
		slot0.hadCollection = false
		slot0.collectionIdList = nil
	end
end

function slot0.initStatus(slot0)
	if RougeMapUnlockHelper.checkIsUnlock(slot0.choiceCo.unlockType, slot0.choiceCo.unlockParam) then
		slot0.status = RougeMapEnum.ChoiceStatus.Normal
	else
		slot0.status = RougeMapEnum.ChoiceStatus.Lock
	end
end

function slot0.refreshLockUI(slot0)
	uv0.super.refreshLockUI(slot0)
	gohelper.setActive(slot0._golockdetail, slot0.hadCollection)
end

function slot0.refreshNormalUI(slot0)
	uv0.super.refreshNormalUI(slot0)
	gohelper.setActive(slot0._gonormaldetail, slot0.hadCollection)
end

function slot0.refreshSelectUI(slot0)
	uv0.super.refreshSelectUI(slot0)
	gohelper.setActive(slot0._goselectdetail, slot0.hadCollection)
end

function slot0.playUnlockAnim(slot0)
	if RougeMapUnlockHelper.UnlockType.ActiveOutGenius ~= slot0.choiceCo.unlockType then
		return
	end

	if RougeMapController.instance:checkEventChoicePlayedUnlockAnim(slot0.choiceId) then
		return
	end

	if RougeMapUnlockHelper.checkIsUnlock(slot1, slot0.choiceCo.unlockParam) then
		slot0.animator:Play("unlock", 0, 0)
		RougeMapController.instance:playedEventChoiceEvent(slot0.choiceId)
	end
end

function slot0.destroy(slot0)
	TaskDispatcher.cancelTask(slot0.onSelectAnimDone, slot0)
	slot0._btnlockdetail:RemoveClickListener()
	slot0._btnnormaldetail:RemoveClickListener()
	slot0._btnselectdetail:RemoveClickListener()
	uv0.super.destroy(slot0)
end

return slot0
