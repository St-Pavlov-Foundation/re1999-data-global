module("modules.logic.summon.controller.SummonCustomPickChoiceController", package.seeall)

local var_0_0 = class("SummonCustomPickChoiceController", BaseController)

function var_0_0.onOpenView(arg_1_0, arg_1_1)
	SummonCustomPickChoiceListModel.instance:initDatas(arg_1_1)
	arg_1_0:dispatchEvent(SummonEvent.onCustomPickListChanged)
end

function var_0_0.onCloseView(arg_2_0)
	return
end

function var_0_0.trySendChoice(arg_3_0)
	local var_3_0 = SummonCustomPickChoiceListModel.instance:getPoolId()
	local var_3_1 = SummonMainModel.instance:getPoolServerMO(var_3_0)

	if not var_3_1 or not var_3_1:isOpening() then
		return false
	end

	local var_3_2 = SummonCustomPickChoiceListModel.instance:getSelectIds()

	if not var_3_2 then
		return false
	end

	local var_3_3 = SummonCustomPickChoiceListModel.instance:getMaxSelectCount()

	if var_3_3 > #var_3_2 then
		if var_3_3 == 1 then
			GameFacade.showToast(ToastEnum.SummonCustomPickOneMoreSelect)
		end

		if var_3_3 == 2 then
			GameFacade.showToast(ToastEnum.SummonCustomPickTwoMoreSelect)
		end

		if var_3_3 == 3 then
			GameFacade.showToast(ToastEnum.SummonCustomPickThreeMoreSelect)
		end

		return false
	end

	local var_3_4 = arg_3_0:getSelectHeroNameStr(var_3_2)
	local var_3_5, var_3_6 = arg_3_0:getConfirmParam(var_3_2)

	if SummonConfig.instance:isStrongCustomChoice(var_3_0) then
		arg_3_0:realSendChoice()
	else
		GameFacade.showMessageBox(var_3_5, MsgBoxEnum.BoxType.Yes_No, arg_3_0.realSendChoice, nil, nil, arg_3_0, nil, nil, var_3_4, var_3_6)
	end
end

function var_0_0.realSendChoice(arg_4_0)
	local var_4_0 = SummonCustomPickChoiceListModel.instance:getPoolId()

	if SummonConfig.instance:isStrongCustomChoice(var_4_0) then
		local var_4_1 = SummonCustomPickChoiceListModel.instance:getSelectIds()

		SummonRpc.instance:sendChooseEnhancedPoolHeroRequest(var_4_0, var_4_1[1])
	else
		local var_4_2 = SummonCustomPickChoiceListModel.instance:getSelectIds()

		SummonRpc.instance:sendChooseDoubleUpHeroRequest(var_4_0, var_4_2)
	end
end

function var_0_0.getSelectHeroNameStr(arg_5_0, arg_5_1)
	local var_5_0 = ""

	for iter_5_0 = 1, #arg_5_1 do
		local var_5_1 = HeroConfig.instance:getHeroCO(arg_5_1[iter_5_0])

		if iter_5_0 == 1 then
			var_5_0 = var_5_1.name
		else
			var_5_0 = var_5_0 .. luaLang("sep_overseas") .. var_5_1.name
		end
	end

	return var_5_0
end

function var_0_0.getConfirmParam(arg_6_0, arg_6_1)
	local var_6_0 = SummonCustomPickChoiceListModel.instance:getPoolId()
	local var_6_1 = SummonConfig.instance:getSummonPool(var_6_0)

	if var_6_1.type == SummonEnum.Type.StrongCustomOnePick then
		return MessageBoxIdDefine.SummonStrongCustomPickConfirm, var_6_1.nameCn
	else
		return MessageBoxIdDefine.SummonCustomPickConfirm, var_6_1.nameCn
	end
end

function var_0_0.setSelect(arg_7_0, arg_7_1)
	local var_7_0 = SummonCustomPickChoiceListModel.instance:getSelectIds()
	local var_7_1 = SummonCustomPickChoiceListModel.instance:getMaxSelectCount()

	if var_7_1 == 1 then
		SummonCustomPickChoiceListModel.instance:clearSelectIds()
	elseif not SummonCustomPickChoiceListModel.instance:isHeroIdSelected(arg_7_1) and var_7_1 <= #var_7_0 then
		if var_7_1 == 1 then
			GameFacade.showToast(ToastEnum.SummonCustomPickOnePleaseCancel)
		end

		if var_7_1 == 2 then
			GameFacade.showToast(ToastEnum.SummonCustomPickTwoPleaseCancel)
		end

		if var_7_1 == 3 then
			GameFacade.showToast(ToastEnum.SummonCustomPickThreePleaseCancel)
		end

		return
	end

	SummonCustomPickChoiceListModel.instance:setSelectId(arg_7_1)
	arg_7_0:dispatchEvent(SummonEvent.onCustomPickListChanged)
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
