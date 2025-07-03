module("modules.logic.versionactivity2_7.v2a7_selfselectsix_1.controller.V2a7_SelfSelectSix_PickChoiceController", package.seeall)

local var_0_0 = class("V2a7_SelfSelectSix_PickChoiceController", BaseController)

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

	V2a7_SelfSelectSix_PickChoiceListModel.instance:initData(arg_5_1, arg_5_7)
	ViewMgr.instance:openView(ViewName.V2a7_SelfSelectSix_PickChoiceView, arg_5_4)
end

function var_0_0.onOpenView(arg_6_0)
	arg_6_0:dispatchEvent(V2a7_SelfSelectSix_PickChoiceEvent.onCustomPickListChanged)
end

function var_0_0.setSelect(arg_7_0, arg_7_1)
	local var_7_0 = V2a7_SelfSelectSix_PickChoiceListModel.instance:isHeroIdSelected(arg_7_1)
	local var_7_1 = V2a7_SelfSelectSix_PickChoiceListModel.instance:getSelectCount()
	local var_7_2 = V2a7_SelfSelectSix_PickChoiceListModel.instance:getMaxSelectCount()

	if not var_7_0 and var_7_2 <= var_7_1 then
		if var_7_2 > 1 then
			GameFacade.showToast(ToastEnum.CustomPickPleaseCancel)

			return
		else
			V2a7_SelfSelectSix_PickChoiceListModel.instance:clearAllSelect()
		end
	end

	V2a7_SelfSelectSix_PickChoiceListModel.instance:setSelectId(arg_7_1)
	arg_7_0:dispatchEvent(V2a7_SelfSelectSix_PickChoiceEvent.onCustomPickListChanged)
end

function var_0_0.tryChoice(arg_8_0, arg_8_1)
	local var_8_0 = V2a7_SelfSelectSix_PickChoiceListModel.instance:getMaxSelectCount()
	local var_8_1 = V2a7_SelfSelectSix_PickChoiceListModel.instance:getSelectCount()

	if not var_8_1 or var_8_0 < var_8_1 then
		return false
	end

	if var_8_1 < var_8_0 then
		GameFacade.showToast(ToastEnum.NoChoiceHero)

		return false
	end

	arg_8_0._tmpViewParam = arg_8_1

	if arg_8_0._showMsgBoxFunc then
		if arg_8_0._showMsgBoxFuncObj then
			arg_8_0._showMsgBoxFunc(arg_8_0._showMsgBoxFuncObj, arg_8_0.realChoice, arg_8_0)
		else
			arg_8_0._showMsgBoxFunc(arg_8_0.realChoice, arg_8_0)
		end
	else
		local var_8_2
		local var_8_3 = false
		local var_8_4 = V2a7_SelfSelectSix_PickChoiceListModel.instance:getSelectIds()

		if var_8_4 then
			for iter_8_0, iter_8_1 in ipairs(var_8_4) do
				local var_8_5 = HeroModel.instance:getByHeroId(iter_8_1)

				if not var_8_3 and var_8_5 then
					var_8_3 = true
				end

				local var_8_6 = HeroConfig.instance:getHeroCO(iter_8_1)

				if var_8_6 then
					local var_8_7 = var_8_6 and var_8_6.name or ""

					if string.nilorempty(var_8_2) then
						var_8_2 = var_8_7
					else
						var_8_2 = GameUtil.getSubPlaceholderLuaLang(luaLang("custompickchoice_select_heros"), {
							var_8_2,
							var_8_7
						})
					end
				end
			end
		end

		local var_8_8 = var_8_3 and MessageBoxIdDefine.CustomPickChoiceHasHero or MessageBoxIdDefine.CustomPickChoiceConfirm

		GameFacade.showMessageBox(var_8_8, MsgBoxEnum.BoxType.Yes_No, arg_8_0.realChoice, nil, nil, arg_8_0, nil, nil, var_8_2)
	end
end

function var_0_0.realChoice(arg_9_0)
	if not arg_9_0._pickHandler then
		return
	end

	local var_9_0 = V2a7_SelfSelectSix_PickChoiceListModel.instance:getSelectIds()

	arg_9_0._pickHandler(arg_9_0._pickHandlerObj, arg_9_0._tmpViewParam, var_9_0)

	arg_9_0._tmpViewParam = nil
end

function var_0_0.onCloseView(arg_10_0)
	return
end

var_0_0.instance = var_0_0.New()

return var_0_0
