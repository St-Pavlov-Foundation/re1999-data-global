module("modules.logic.versionactivity2_8.act199.controller.V2a8_SelfSelectSix_PickChoiceController", package.seeall)

local var_0_0 = class("V2a8_SelfSelectSix_PickChoiceController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._pickHandler = nil
	arg_1_0._pickHandlerObj = nil
	arg_1_0._showMsgBoxFunc = nil
	arg_1_0._showMsgBoxFuncObj = nil
	arg_1_0._tmpViewParam = nil
end

function var_0_0.onInitFinish(arg_2_0)
	return
end

function var_0_0.addConstEvents(arg_3_0)
	return
end

function var_0_0.reInit(arg_4_0)
	arg_4_0:onInit()
end

function var_0_0.onOpenView(arg_5_0)
	arg_5_0:dispatchEvent(V2a8_SelfSelectSix_PickChoiceEvent.onCustomPickListChanged)
end

function var_0_0.setSelect(arg_6_0, arg_6_1)
	local var_6_0 = V2a8_SelfSelectSix_PickChoiceListModel.instance:isHeroIdSelected(arg_6_1)
	local var_6_1 = V2a8_SelfSelectSix_PickChoiceListModel.instance:getSelectCount()
	local var_6_2 = V2a8_SelfSelectSix_PickChoiceListModel.instance:getMaxSelectCount()

	if not var_6_0 and var_6_2 <= var_6_1 then
		if var_6_2 > 1 then
			GameFacade.showToast(ToastEnum.CustomPickPleaseCancel)

			return
		else
			V2a8_SelfSelectSix_PickChoiceListModel.instance:clearAllSelect()
		end
	end

	V2a8_SelfSelectSix_PickChoiceListModel.instance:setSelectId(arg_6_1)
	arg_6_0:dispatchEvent(V2a8_SelfSelectSix_PickChoiceEvent.onCustomPickListChanged)
end

function var_0_0.tryChoice(arg_7_0, arg_7_1)
	local var_7_0 = V2a8_SelfSelectSix_PickChoiceListModel.instance:getMaxSelectCount()
	local var_7_1 = V2a8_SelfSelectSix_PickChoiceListModel.instance:getSelectCount()

	if not var_7_1 or var_7_0 < var_7_1 then
		return false
	end

	if var_7_1 < var_7_0 then
		GameFacade.showToast(ToastEnum.NoChoiceHero)

		return false
	end

	arg_7_0._tmpViewParam = arg_7_1

	if arg_7_0._showMsgBoxFunc then
		if arg_7_0._showMsgBoxFuncObj then
			arg_7_0._showMsgBoxFunc(arg_7_0._showMsgBoxFuncObj, arg_7_0.realChoice, arg_7_0)
		else
			arg_7_0._showMsgBoxFunc(arg_7_0.realChoice, arg_7_0)
		end
	else
		local var_7_2
		local var_7_3 = false
		local var_7_4 = V2a8_SelfSelectSix_PickChoiceListModel.instance:getSelectIds()

		if var_7_4 then
			for iter_7_0, iter_7_1 in ipairs(var_7_4) do
				local var_7_5 = HeroModel.instance:getByHeroId(iter_7_1)

				if not var_7_3 and var_7_5 then
					var_7_3 = true
				end

				local var_7_6 = HeroConfig.instance:getHeroCO(iter_7_1)

				if var_7_6 then
					local var_7_7 = var_7_6 and var_7_6.name or ""

					if string.nilorempty(var_7_2) then
						var_7_2 = var_7_7
					else
						var_7_2 = GameUtil.getSubPlaceholderLuaLang(luaLang("custompickchoice_select_heros"), {
							var_7_2,
							var_7_7
						})
					end
				end
			end
		end

		local var_7_8 = var_7_3 and MessageBoxIdDefine.V2a8_SelfSelectSix_PickChoiceHasHero or MessageBoxIdDefine.V2a8_SelfSelectSix_PickChoiceConfirm

		GameFacade.showMessageBox(var_7_8, MsgBoxEnum.BoxType.Yes_No, arg_7_0.realChoice, nil, nil, arg_7_0, nil, nil, var_7_2)
	end
end

function var_0_0.realChoice(arg_8_0)
	local var_8_0 = V2a8_SelfSelectSix_PickChoiceListModel.instance:getActivityId()
	local var_8_1 = V2a8_SelfSelectSix_PickChoiceListModel.instance:getSelectIds()[1]

	Activity199Rpc.instance:sendAct199GainRequest(var_8_0, var_8_1)
end

function var_0_0.onCloseView(arg_9_0)
	return
end

var_0_0.instance = var_0_0.New()

return var_0_0
