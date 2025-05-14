module("modules.logic.custompickchoice.controller.CustomPickChoiceController", package.seeall)

local var_0_0 = class("CustomPickChoiceController", BaseController)

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

function var_0_0.openCustomPickChoiceView(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6, arg_5_7)
	arg_5_0._pickHandler = arg_5_2
	arg_5_0._pickHandlerObj = arg_5_3
	arg_5_0._showMsgBoxFunc = arg_5_5
	arg_5_0._showMsgBoxFuncObj = arg_5_6

	CustomPickChoiceListModel.instance:initData(arg_5_1, arg_5_7)
	ViewMgr.instance:openView(ViewName.CustomPickChoiceView, arg_5_4)
end

function var_0_0.openNewBiePickChoiceView(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6, arg_6_7)
	arg_6_0._pickHandler = arg_6_2
	arg_6_0._pickHandlerObj = arg_6_3
	arg_6_0._showMsgBoxFunc = arg_6_5
	arg_6_0._showMsgBoxFuncObj = arg_6_6

	CustomPickChoiceListModel.instance:initData(arg_6_1, arg_6_7)
	ViewMgr.instance:openView(ViewName.NewbieCustomPickView, arg_6_4)
end

function var_0_0.onOpenView(arg_7_0)
	arg_7_0:dispatchEvent(CustomPickChoiceEvent.onCustomPickListChanged)
end

function var_0_0.setSelect(arg_8_0, arg_8_1)
	local var_8_0 = CustomPickChoiceListModel.instance:isHeroIdSelected(arg_8_1)
	local var_8_1 = CustomPickChoiceListModel.instance:getSelectCount()
	local var_8_2 = CustomPickChoiceListModel.instance:getMaxSelectCount()

	if not var_8_0 and var_8_2 <= var_8_1 then
		if var_8_2 > 1 then
			GameFacade.showToast(ToastEnum.CustomPickPleaseCancel)

			return
		else
			CustomPickChoiceListModel.instance:clearAllSelect()
		end
	end

	CustomPickChoiceListModel.instance:setSelectId(arg_8_1)
	arg_8_0:dispatchEvent(CustomPickChoiceEvent.onCustomPickListChanged)
end

function var_0_0.tryChoice(arg_9_0, arg_9_1)
	local var_9_0 = CustomPickChoiceListModel.instance:getMaxSelectCount()
	local var_9_1 = CustomPickChoiceListModel.instance:getSelectCount()

	if not var_9_1 or var_9_0 < var_9_1 then
		return false
	end

	if var_9_1 < var_9_0 then
		GameFacade.showToast(ToastEnum.CustomPickMoreSelect)

		return false
	end

	arg_9_0._tmpViewParam = arg_9_1

	if arg_9_0._showMsgBoxFunc then
		if arg_9_0._showMsgBoxFuncObj then
			arg_9_0._showMsgBoxFunc(arg_9_0._showMsgBoxFuncObj, arg_9_0.realChoice, arg_9_0)
		else
			arg_9_0._showMsgBoxFunc(arg_9_0.realChoice, arg_9_0)
		end
	else
		local var_9_2
		local var_9_3 = false
		local var_9_4 = CustomPickChoiceListModel.instance:getSelectIds()

		if var_9_4 then
			for iter_9_0, iter_9_1 in ipairs(var_9_4) do
				local var_9_5 = HeroModel.instance:getByHeroId(iter_9_1)

				if not var_9_3 and var_9_5 then
					var_9_3 = true
				end

				local var_9_6 = HeroConfig.instance:getHeroCO(iter_9_1)

				if var_9_6 then
					local var_9_7 = var_9_6 and var_9_6.name or ""

					if string.nilorempty(var_9_2) then
						var_9_2 = var_9_7
					else
						var_9_2 = GameUtil.getSubPlaceholderLuaLang(luaLang("custompickchoice_select_heros"), {
							var_9_2,
							var_9_7
						})
					end
				end
			end
		end

		local var_9_8 = var_9_3 and MessageBoxIdDefine.CustomPickChoiceHasHero or MessageBoxIdDefine.CustomPickChoiceConfirm

		GameFacade.showMessageBox(var_9_8, MsgBoxEnum.BoxType.Yes_No, arg_9_0.realChoice, nil, nil, arg_9_0, nil, nil, var_9_2)
	end
end

function var_0_0.realChoice(arg_10_0)
	if not arg_10_0._pickHandler then
		return
	end

	local var_10_0 = CustomPickChoiceListModel.instance:getSelectIds()

	arg_10_0._pickHandler(arg_10_0._pickHandlerObj, arg_10_0._tmpViewParam, var_10_0)

	arg_10_0._tmpViewParam = nil
end

function var_0_0.onCloseView(arg_11_0)
	return
end

var_0_0.instance = var_0_0.New()

return var_0_0
