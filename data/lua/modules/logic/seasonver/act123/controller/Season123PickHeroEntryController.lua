module("modules.logic.seasonver.act123.controller.Season123PickHeroEntryController", package.seeall)

local var_0_0 = class("Season123PickHeroEntryController", BaseController)

function var_0_0.onOpenView(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	Season123PickHeroEntryModel.instance:init(arg_1_1, arg_1_2)
end

function var_0_0.onCloseView(arg_2_0)
	Season123PickHeroEntryModel.instance:release()
end

function var_0_0.openPickHeroView(arg_3_0, arg_3_1)
	local var_3_0

	if arg_3_1 then
		local var_3_1 = Season123PickHeroEntryModel.instance:getByIndex(arg_3_1)

		if var_3_1 and var_3_1.heroMO then
			var_3_0 = var_3_1.heroMO.uid
		end
	end

	ViewMgr.instance:openView(Season123Controller.instance:getPickHeroViewName(), {
		actId = Season123PickHeroEntryModel.instance.activityId,
		stage = Season123PickHeroEntryModel.instance.stage,
		finishCall = arg_3_0.handlePickOver,
		finishCallObj = arg_3_0,
		entryMOList = Season123PickHeroEntryModel.instance:getList(),
		selectHeroUid = var_3_0
	})
end

function var_0_0.openPickSupportView(arg_4_0, arg_4_1)
	local var_4_0 = Season123PickHeroEntryModel.instance:getSupportPosMO()
	local var_4_1

	if var_4_0 and var_4_0.isSupport then
		local var_4_2 = var_4_0.heroUid
	end

	local var_4_3 = Season123PickAssistController.instance:checkCanRefresh()

	if arg_4_1 and var_4_3 then
		arg_4_0.tmpIsRecordRefreshTime = true

		DungeonRpc.instance:sendRefreshAssistRequest(DungeonEnum.AssistType.Season123, arg_4_0._openPickSupportViewAfterRpc, arg_4_0)
	else
		arg_4_0:_openPickSupportViewAfterRpc()
	end
end

function var_0_0._openPickSupportViewAfterRpc(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_0.tmpIsRecordRefreshTime then
		Season123PickAssistController.instance:recordAssistRefreshTime()
	end

	arg_5_0.tmpIsRecordRefreshTime = nil

	ShaderKeyWordMgr.enableKeyWordAutoDisable(ShaderKeyWordMgr.CLIPALPHA, 1)
	ViewMgr.instance:openView(Season123Controller.instance:getPickAssistViewName(), {
		actId = Season123PickHeroEntryModel.instance.activityId,
		finishCall = arg_5_0.handlePickSupport,
		finishCallObj = arg_5_0,
		selectedHeroUid = Season123PickHeroEntryModel.instance:getSupporterHeroUid()
	})
end

function var_0_0.cancelSupport(arg_6_0)
	local var_6_0 = Season123PickHeroEntryModel.instance:getSupportPosMO()

	if var_6_0 and var_6_0.isSupport then
		var_6_0:setEmpty()
	end

	arg_6_0:notifyView()
	Season123PickHeroEntryModel.instance:clearLastSupportHero()
end

function var_0_0.selectMainEquips(arg_7_0, arg_7_1)
	local var_7_0 = Season123Controller.instance:getEquipHeroViewName()

	ViewMgr.instance:openView(var_7_0, {
		actId = Season123PickHeroEntryModel.instance.activityId,
		stage = Season123PickHeroEntryModel.instance.stage,
		slot = arg_7_1,
		callback = arg_7_0.handleSelectMainCard,
		callbackObj = arg_7_0,
		equipUidList = Season123PickHeroEntryModel.instance:getMainCardList()
	})
end

function var_0_0.handlePickOver(arg_8_0, arg_8_1)
	Season123PickHeroEntryModel.instance:savePickHeroDatas(arg_8_1)
	arg_8_0:notifyView()
end

function var_0_0.handlePickSupport(arg_9_0, arg_9_1)
	Season123PickHeroEntryModel.instance:setPickAssistData(arg_9_1)
	arg_9_0:notifyView()
end

function var_0_0.handleSelectMainCard(arg_10_0, arg_10_1)
	Season123PickHeroEntryModel.instance:setMainEquips(arg_10_1)
	arg_10_0:notifyView()
end

function var_0_0.sendEnterStage(arg_11_0)
	local var_11_0 = Season123PickHeroEntryModel.instance:getSelectCount()
	local var_11_1 = Season123PickHeroEntryModel.instance:getLimitCount()

	if var_11_0 < 1 then
		logNormal(string.format("hero count not fit : %s/%s", var_11_0, var_11_1))
		GameFacade.showToast(ToastEnum.Season123PickHeroCountErr)

		return
	end

	if var_11_0 < var_11_1 then
		GameFacade.showMessageBox(MessageBoxIdDefine.Season123MemberNotEnough, MsgBoxEnum.BoxType.Yes_No, arg_11_0.confirmSendEnterStage, nil, nil, arg_11_0)

		return
	end

	local var_11_2 = Season123PickHeroEntryModel.instance:getHeroUidList()
	local var_11_3 = Season123PickHeroEntryModel.instance:getMainCardList()

	Activity123Rpc.instance:sendAct123EnterStageRequest(Season123PickHeroEntryModel.instance.activityId, Season123PickHeroEntryModel.instance.stage, var_11_2, var_11_3)
	Season123PickHeroEntryModel.instance:flushSelectionToLocal()
	Season123ShowHeroModel.instance:clearPlayHeroDieAnim(Season123PickHeroEntryModel.instance.stage)
end

function var_0_0.confirmSendEnterStage(arg_12_0)
	local var_12_0 = Season123PickHeroEntryModel.instance:getHeroUidList()
	local var_12_1 = Season123PickHeroEntryModel.instance:getMainCardList()

	Activity123Rpc.instance:sendAct123EnterStageRequest(Season123PickHeroEntryModel.instance.activityId, Season123PickHeroEntryModel.instance.stage, var_12_0, var_12_1)
	Season123PickHeroEntryModel.instance:flushSelectionToLocal()
	Season123ShowHeroModel.instance:clearPlayHeroDieAnim(Season123PickHeroEntryModel.instance.stage)
end

function var_0_0.notifyView(arg_13_0)
	Season123Controller.instance:dispatchEvent(Season123Event.PickEntryRefresh)
end

var_0_0.instance = var_0_0.New()

return var_0_0
