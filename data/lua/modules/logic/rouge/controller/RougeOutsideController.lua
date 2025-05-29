module("modules.logic.rouge.controller.RougeOutsideController", package.seeall)

local var_0_0 = class("RougeOutsideController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._model = RougeOutsideModel.instance
end

function var_0_0.addConstEvents(arg_2_0)
	OpenController.instance:registerCallback(OpenEvent.GetOpenInfoSuccess, arg_2_0._onGetOpenInfoSuccess, arg_2_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_2_0._onDailyRefresh, arg_2_0)
	RedDotController.instance:registerCallback(RedDotEvent.UpdateRelateDotInfo, arg_2_0._updateRelateDotInfo, arg_2_0)
end

function var_0_0.reInit(arg_3_0)
	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, arg_3_0._updateRelateDotInfo, arg_3_0)
end

function var_0_0._onGetOpenInfoSuccess(arg_4_0)
	local var_4_0 = arg_4_0._model:config():openUnlockId()

	if OpenModel.instance:isFunctionUnlock(var_4_0) then
		return
	end

	OpenController.instance:registerCallback(OpenEvent.NewFuncUnlock, arg_4_0._onNewFuncUnlock, arg_4_0)
end

function var_0_0._updateRelateDotInfo(arg_5_0, arg_5_1)
	if not arg_5_0:isOpen() or not arg_5_1 or not arg_5_1[RedDotEnum.DotNode.RougeDLCNew] then
		return
	end

	RedDotController.instance:unregisterCallback(RedDotEvent.UpdateRelateDotInfo, arg_5_0._updateRelateDotInfo, arg_5_0)
	arg_5_0:initDLCReddotInfo()
end

function var_0_0._onDailyRefresh(arg_6_0)
	if not arg_6_0:isOpen() then
		return
	end

	arg_6_0:sendRpcToGetOutsideInfo()
end

function var_0_0.sendRpcToGetOutsideInfo(arg_7_0)
	local var_7_0 = arg_7_0._model:season()

	RougeOutsideRpc.instance:sendGetRougeOutSideInfoRequest(var_7_0)
end

function var_0_0.checkOutSideStageInfo(arg_8_0)
	return
end

function var_0_0._onNewFuncUnlock(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0._model:config():openUnlockId()
	local var_9_1 = false

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		if iter_9_1 == var_9_0 then
			var_9_1 = true

			break
		end
	end

	if not var_9_1 then
		return
	end

	arg_9_0._model:setIsNewUnlockDifficulty(1, true)
	arg_9_0:sendRpcToGetOutsideInfo()
	arg_9_0:initDLCReddotInfo()
end

function var_0_0.isOpen(arg_10_0)
	return arg_10_0._model:isUnlock()
end

function var_0_0.initDLCReddotInfo(arg_11_0)
	local var_11_0 = arg_11_0:_createDLCReddotInfo(RougeDLCEnum.DLCEnum.DLC_103)
	local var_11_1 = arg_11_0:_createDLCEntryReddotInfo({
		var_11_0
	})
	local var_11_2 = {
		var_11_0,
		var_11_1
	}

	RedDotRpc.instance:clientAddRedDotGroupList(var_11_2, true)
end

function var_0_0._createDLCReddotInfo(arg_12_0, arg_12_1)
	if not arg_12_1 or arg_12_1 == 0 then
		return
	end

	local var_12_0 = arg_12_0:checkIsDLCNotRead(arg_12_1) and 1 or 0

	return {
		id = RedDotEnum.DotNode.RougeDLCNew,
		uid = arg_12_1,
		value = var_12_0
	}
end

function var_0_0.checkIsDLCNotRead(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0:_generateNewReadDLCInLocalKey(arg_13_1)

	return (string.nilorempty(PlayerPrefsHelper.getString(var_13_0, "")))
end

function var_0_0._createDLCEntryReddotInfo(arg_14_0, arg_14_1)
	local var_14_0 = {
		uid = 0,
		value = 0,
		id = RedDotEnum.DotNode.RougeDLCNew
	}

	if arg_14_1 then
		for iter_14_0, iter_14_1 in ipairs(arg_14_1) do
			if iter_14_1.value and iter_14_1.value > 0 then
				var_14_0.value = 1

				break
			end
		end
	end

	return var_14_0
end

function var_0_0.saveNewReadDLCInLocal(arg_15_0, arg_15_1)
	if not arg_15_1 or arg_15_1 == 0 then
		return
	end

	local var_15_0 = arg_15_0:_generateNewReadDLCInLocalKey(arg_15_1)

	PlayerPrefsHelper.setString(var_15_0, "true")
end

function var_0_0._generateNewReadDLCInLocalKey(arg_16_0, arg_16_1)
	return (string.format("%s#%s#%s", PlayerPrefsKey.RougeHasReadDLCId, PlayerModel.instance:getMyUserId(), arg_16_1))
end

var_0_0.instance = var_0_0.New()

return var_0_0
