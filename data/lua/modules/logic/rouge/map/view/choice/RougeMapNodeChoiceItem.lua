module("modules.logic.rouge.map.view.choice.RougeMapNodeChoiceItem", package.seeall)

local var_0_0 = class("RougeMapNodeChoiceItem", RougeMapChoiceBaseItem)

function var_0_0._editableInitView(arg_1_0)
	var_0_0.super._editableInitView(arg_1_0)

	arg_1_0._btnlockdetail = gohelper.findChildButtonWithAudio(arg_1_0.go, "#go_locked/#btn_lockdetail")
	arg_1_0._btnnormaldetail = gohelper.findChildButtonWithAudio(arg_1_0.go, "#go_normal/#btn_normaldetail")
	arg_1_0._btnselectdetail = gohelper.findChildButtonWithAudio(arg_1_0.go, "#go_select/#btn_selectdetail")

	arg_1_0._btnlockdetail:AddClickListener(arg_1_0.onClickDetail, arg_1_0)
	arg_1_0._btnnormaldetail:AddClickListener(arg_1_0.onClickDetail, arg_1_0)
	arg_1_0._btnselectdetail:AddClickListener(arg_1_0.onClickDetail, arg_1_0)
end

function var_0_0.onClickDetail(arg_2_0)
	if not arg_2_0.hadCollection then
		return
	end

	RougeMapController.instance:dispatchEvent(RougeMapEvent.onClickChoiceDetail, arg_2_0.collectionIdList)
end

function var_0_0.onClickSelf(arg_3_0)
	if RougeMapModel.instance:isInteractiving() then
		return
	end

	if RougeMapModel.instance:isPlayingDialogue() then
		return
	end

	if arg_3_0.status == RougeMapEnum.ChoiceStatus.Lock then
		return
	end

	if arg_3_0.status == RougeMapEnum.ChoiceStatus.Select then
		arg_3_0.animator:Play("select", 0, 0)
		TaskDispatcher.cancelTask(arg_3_0.onSelectAnimDone, arg_3_0)
		TaskDispatcher.runDelay(arg_3_0.onSelectAnimDone, arg_3_0, RougeMapEnum.ChoiceSelectAnimDuration)
		UIBlockMgr.instance:startBlock(RougeMapEnum.WaitChoiceItemAnimBlock)
	else
		RougeMapController.instance:dispatchEvent(RougeMapEvent.onChoiceItemStatusChange, arg_3_0.choiceId)
	end
end

function var_0_0.onSelectAnimDone(arg_4_0)
	RougeMapModel.instance:recordCurChoiceEventSelectId(arg_4_0.choiceId)
	RougeRpc.instance:sendRougeChoiceEventRequest(arg_4_0.choiceId)
	UIBlockMgr.instance:endBlock(RougeMapEnum.WaitChoiceItemAnimBlock)
end

function var_0_0.onStatusChange(arg_5_0, arg_5_1)
	if arg_5_0.status == RougeMapEnum.ChoiceStatus.Lock then
		return
	end

	local var_5_0

	if arg_5_1 then
		if arg_5_1 == arg_5_0.choiceId then
			var_5_0 = RougeMapEnum.ChoiceStatus.Select
		else
			var_5_0 = RougeMapEnum.ChoiceStatus.UnSelect
		end
	else
		var_5_0 = RougeMapEnum.ChoiceStatus.Normal
	end

	if var_5_0 == arg_5_0.status then
		return
	end

	arg_5_0.status = var_5_0

	arg_5_0:refreshUI()
end

function var_0_0.update(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	var_0_0.super.update(arg_6_0, arg_6_2)

	arg_6_0.choiceId = arg_6_1
	arg_6_0.choiceCo = lua_rouge_choice.configDict[arg_6_1]
	arg_6_0.nodeMo = arg_6_3

	arg_6_0:buildCollectionIdList()

	arg_6_0.title = arg_6_0.choiceCo.title
	arg_6_0.desc = arg_6_0.choiceCo.desc

	arg_6_0:initStatus()

	if arg_6_0.status == RougeMapEnum.ChoiceStatus.Lock then
		arg_6_0.tip = RougeMapUnlockHelper.getLockTips(arg_6_0.choiceCo.unlockType, arg_6_0.choiceCo.unlockParam)
	else
		arg_6_0.tip = ""
	end

	arg_6_0:refreshUI()
	arg_6_0:playUnlockAnim()
end

function var_0_0.buildCollectionIdList(arg_7_0)
	local var_7_0 = arg_7_0.choiceCo.display

	if not string.nilorempty(var_7_0) then
		arg_7_0.hadCollection = true
		arg_7_0.collectionIdList = string.splitToNumber(var_7_0, "|")

		return
	end

	local var_7_1 = arg_7_0.choiceCo.interactive

	if string.nilorempty(var_7_1) then
		arg_7_0.hadCollection = false
		arg_7_0.collectionIdList = nil

		return
	end

	local var_7_2 = string.splitToNumber(var_7_1, "#")[1]

	if var_7_2 == RougeMapEnum.InteractType.LossNotUniqueCollection then
		local var_7_3 = arg_7_0.nodeMo.interactive9drop

		if var_7_3 == 0 then
			arg_7_0.hadCollection = false
			arg_7_0.collectionIdList = nil
		else
			arg_7_0.hadCollection = true
			arg_7_0.collectionIdList = {
				var_7_3
			}
		end
	elseif var_7_2 == RougeMapEnum.InteractType.StorageCollection then
		local var_7_4 = arg_7_0.nodeMo.interactive10drop

		if var_7_4 == 0 then
			arg_7_0.hadCollection = false
			arg_7_0.collectionIdList = nil
		else
			arg_7_0.hadCollection = true
			arg_7_0.collectionIdList = {
				var_7_4
			}
		end
	elseif var_7_2 == RougeMapEnum.InteractType.LossSpCollection then
		local var_7_5 = arg_7_0.nodeMo.interactive14drop

		if var_7_5 == 0 then
			arg_7_0.hadCollection = false
			arg_7_0.collectionIdList = nil
		else
			arg_7_0.hadCollection = true
			arg_7_0.collectionIdList = {
				var_7_5
			}
		end
	else
		arg_7_0.hadCollection = false
		arg_7_0.collectionIdList = nil
	end
end

function var_0_0.initStatus(arg_8_0)
	if RougeMapUnlockHelper.checkIsUnlock(arg_8_0.choiceCo.unlockType, arg_8_0.choiceCo.unlockParam) then
		arg_8_0.status = RougeMapEnum.ChoiceStatus.Normal
	else
		arg_8_0.status = RougeMapEnum.ChoiceStatus.Lock
	end
end

function var_0_0.refreshLockUI(arg_9_0)
	var_0_0.super.refreshLockUI(arg_9_0)
	gohelper.setActive(arg_9_0._golockdetail, arg_9_0.hadCollection)
end

function var_0_0.refreshNormalUI(arg_10_0)
	var_0_0.super.refreshNormalUI(arg_10_0)
	gohelper.setActive(arg_10_0._gonormaldetail, arg_10_0.hadCollection)
end

function var_0_0.refreshSelectUI(arg_11_0)
	var_0_0.super.refreshSelectUI(arg_11_0)
	gohelper.setActive(arg_11_0._goselectdetail, arg_11_0.hadCollection)
end

function var_0_0.playUnlockAnim(arg_12_0)
	local var_12_0 = arg_12_0.choiceCo.unlockType

	if RougeMapUnlockHelper.UnlockType.ActiveOutGenius ~= var_12_0 then
		return
	end

	if RougeMapController.instance:checkEventChoicePlayedUnlockAnim(arg_12_0.choiceId) then
		return
	end

	if RougeMapUnlockHelper.checkIsUnlock(var_12_0, arg_12_0.choiceCo.unlockParam) then
		arg_12_0.animator:Play("unlock", 0, 0)
		RougeMapController.instance:playedEventChoiceEvent(arg_12_0.choiceId)
	end
end

function var_0_0.destroy(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0.onSelectAnimDone, arg_13_0)
	arg_13_0._btnlockdetail:RemoveClickListener()
	arg_13_0._btnnormaldetail:RemoveClickListener()
	arg_13_0._btnselectdetail:RemoveClickListener()
	var_0_0.super.destroy(arg_13_0)
end

return var_0_0
