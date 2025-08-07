module("modules.logic.mainuiswitch.view.SwitchMainUIReddotIcon", package.seeall)

local var_0_0 = class("SwitchMainUIReddotIcon", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = IconMgr.instance:_getIconInstance(IconMgrConfig.UrlRedDotIcon, arg_1_1)
	arg_1_0._txtCount = gohelper.findChildText(arg_1_0.go, "type2/#txt_count")
	arg_1_0.typeGoDict = arg_1_0:getUserDataTb_()

	for iter_1_0, iter_1_1 in pairs(RedDotEnum.Style) do
		arg_1_0.typeGoDict[iter_1_1] = gohelper.findChild(arg_1_0.go, "type" .. iter_1_1)

		gohelper.setActive(arg_1_0.typeGoDict[iter_1_1], false)
	end
end

function var_0_0.addEventListeners(arg_2_0)
	MainUISwitchController.instance:registerCallback(MainUISwitchEvent.SwitchMainUI, arg_2_0._onSwitchMainUI, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	MainUISwitchController.instance:unregisterCallback(MainUISwitchEvent.SwitchMainUI, arg_3_0._onSwitchMainUI, arg_3_0)
end

function var_0_0._onSwitchMainUI(arg_4_0, arg_4_1)
	arg_4_0._curMainUIId = arg_4_1

	arg_4_0:defaultRefreshDot()
end

function var_0_0.setId(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0:setMultiId({
		{
			id = arg_5_1,
			uid = arg_5_2
		}
	})

	arg_5_0._curMainUIId = arg_5_3
end

function var_0_0.setMultiId(arg_6_0, arg_6_1)
	arg_6_0.infoDict = {}

	if arg_6_1 then
		for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
			iter_6_1.uid = iter_6_1.uid or 0
			arg_6_0.infoDict[iter_6_1.id] = iter_6_1.uid
		end
	end

	arg_6_0.infoList = arg_6_1
end

function var_0_0.defaultRefreshDot(arg_7_0)
	arg_7_0.show = false

	if arg_7_0.infoList then
		for iter_7_0, iter_7_1 in ipairs(arg_7_0.infoList) do
			arg_7_0.show = RedDotModel.instance:isDotShow(iter_7_1.id, iter_7_1.uid)

			if arg_7_0.show then
				local var_7_0 = RedDotModel.instance:getDotInfoCount(iter_7_1.id, iter_7_1.uid)

				arg_7_0._txtCount.text = var_7_0

				local var_7_1 = RedDotConfig.instance:getRedDotCO(iter_7_1.id).style
				local var_7_2 = MainUISwitchConfig.instance:getUIReddotStyle(arg_7_0._curMainUIId, iter_7_1.id)

				if var_7_2 then
					var_7_1 = var_7_2.style
				end

				arg_7_0:showRedDot(var_7_1)

				return
			end
		end
	end
end

function var_0_0.showRedDot(arg_8_0, arg_8_1)
	gohelper.setActive(arg_8_0.go, arg_8_0.show)

	if arg_8_0.show then
		for iter_8_0, iter_8_1 in pairs(RedDotEnum.Style) do
			gohelper.setActive(arg_8_0.typeGoDict[iter_8_1], arg_8_1 == iter_8_1)
		end
	end
end

return var_0_0
