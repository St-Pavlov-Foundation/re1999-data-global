module("modules.logic.summon.controller.SummonLuckyBagChoiceController", package.seeall)

local var_0_0 = class("SummonLuckyBagChoiceController", BaseController)

function var_0_0.onOpenView(arg_1_0, arg_1_1, arg_1_2)
	SummonLuckyBagChoiceListModel.instance:initDatas(arg_1_1, arg_1_2)
end

function var_0_0.onCloseView(arg_2_0)
	return
end

function var_0_0.trySendChoice(arg_3_0)
	local var_3_0 = SummonLuckyBagChoiceListModel.instance:getPoolId()
	local var_3_1 = SummonMainModel.instance:getPoolServerMO(var_3_0)

	if not var_3_1 or not var_3_1:isOpening() then
		return false
	end

	local var_3_2 = SummonLuckyBagChoiceListModel.instance:getSelectId()

	if not var_3_2 then
		GameFacade.showToast(ToastEnum.SummonLuckyBagNotSelect)

		return false
	end

	if arg_3_0:isLuckyBagOpened() then
		GameFacade.showToast(ToastEnum.SummonLuckyBagAlreadyReceive)

		return false
	end

	local var_3_3, var_3_4, var_3_5, var_3_6 = arg_3_0:getDuplicatePopUpParam(var_3_2)

	GameFacade.showMessageBox(var_3_3, MsgBoxEnum.BoxType.Yes_No, arg_3_0.realSendChoice, nil, nil, arg_3_0, nil, nil, var_3_4, var_3_5, var_3_6)
end

function var_0_0.realSendChoice(arg_4_0)
	local var_4_0 = SummonLuckyBagChoiceListModel.instance:getSelectId()
	local var_4_1 = SummonLuckyBagChoiceListModel.instance:getLuckyBagId()

	if var_4_0 and var_4_0 ~= 0 then
		SummonRpc.instance:sendOpenLuckyBagRequest(var_4_1, var_4_0)
	end
end

function var_0_0.getDuplicatePopUpParam(arg_5_0, arg_5_1)
	local var_5_0 = HeroModel.instance:getByHeroId(arg_5_1)
	local var_5_1 = HeroConfig.instance:getHeroCO(arg_5_1)
	local var_5_2 = MessageBoxIdDefine.SummonLuckyBagSelectChar
	local var_5_3 = var_5_1 and var_5_1.name or ""
	local var_5_4 = ""
	local var_5_5 = ""

	if var_5_0 and var_5_1 then
		local var_5_6 = {}

		if not HeroModel.instance:isMaxExSkill(arg_5_1, true) then
			local var_5_7 = GameUtil.splitString2(var_5_1.duplicateItem, true)

			var_5_6 = var_5_7 and var_5_7[1] or var_5_6
			var_5_2 = MessageBoxIdDefine.SummonLuckyBagSelectCharRepeat
		else
			var_5_6 = string.splitToNumber(var_5_1.duplicateItem2, "#") or var_5_6
			var_5_5 = var_5_6[3] or ""
			var_5_2 = MessageBoxIdDefine.SummonLuckyBagSelectCharRepeat2
		end

		local var_5_8 = var_5_6[1]
		local var_5_9 = var_5_6[2]

		if var_5_8 and var_5_9 then
			local var_5_10, var_5_11 = ItemModel.instance:getItemConfigAndIcon(var_5_6[1], var_5_6[2])

			var_5_4 = var_5_10 and var_5_10.name or ""
		end
	end

	return var_5_2, var_5_3, var_5_4, var_5_5
end

function var_0_0.isLuckyBagOpened(arg_6_0)
	local var_6_0 = SummonLuckyBagChoiceListModel.instance:getPoolId()
	local var_6_1 = SummonLuckyBagChoiceListModel.instance:getLuckyBagId()

	if SummonLuckyBagModel.instance:isLuckyBagOpened(var_6_0, var_6_1) then
		return true
	end

	return false
end

function var_0_0.setSelect(arg_7_0, arg_7_1)
	SummonLuckyBagChoiceListModel.instance:setSelectId(arg_7_1)
	SummonLuckyBagChoiceListModel.instance:onModelUpdate()
	arg_7_0:dispatchEvent(SummonEvent.onLuckyListChanged)
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
