module("modules.logic.help.view.HelpPageHelpView", package.seeall)

local var_0_0 = class("HelpPageHelpView", HelpView)

function var_0_0.onUpdateParam(arg_1_0)
	return
end

function var_0_0.onOpen(arg_2_0)
	if arg_2_0.viewContainer then
		arg_2_0:addEventCb(arg_2_0.viewContainer, HelpEvent.UIPageTabSelectChange, arg_2_0._onVoideFullScreenChange, arg_2_0)
	end

	arg_2_0._showParam = {}
end

function var_0_0._refreshHelpPage(arg_3_0)
	if arg_3_0._helpItems then
		for iter_3_0, iter_3_1 in pairs(arg_3_0._helpItems) do
			iter_3_1:destroy()
			gohelper.destroy(iter_3_1._go)
		end
	end

	arg_3_0._helpItems = {}

	arg_3_0:_refreshView()
end

function var_0_0.setSelectItem(arg_4_0)
	local var_4_0 = arg_4_0.viewContainer:getSetting().otherRes[1]

	for iter_4_0 = 1, #arg_4_0._pagesCo do
		local var_4_1 = arg_4_0._selectItems[iter_4_0]
		local var_4_2 = 55 * (iter_4_0 - 0.5 * (#arg_4_0._pagesCo + 1))

		if not var_4_1 then
			local var_4_3 = arg_4_0:getResInst(var_4_0, arg_4_0._goslider, "HelpSelectItem")

			var_4_1 = HelpSelectItem.New()

			var_4_1:init({
				go = var_4_3,
				index = iter_4_0,
				config = arg_4_0._pagesCo[iter_4_0],
				pos = var_4_2
			})

			var_4_1._goTrs = var_4_3.transform

			table.insert(arg_4_0._selectItems, var_4_1)
		else
			transformhelper.setLocalPos(var_4_1._goTrs, var_4_2, 0, 0)
			gohelper.setActive(var_4_1._go, true)
		end

		var_4_1:updateItem()
	end

	for iter_4_1 = #arg_4_0._pagesCo + 1, #arg_4_0._selectItems do
		gohelper.setActive(arg_4_0._selectItems[iter_4_1]._go, false)
	end
end

function var_0_0._onlyShowLastGuideQuitBtn(arg_5_0)
	for iter_5_0, iter_5_1 in ipairs(arg_5_0._helpItems) do
		iter_5_1:showQuitBtn(false)
	end
end

function var_0_0._refreshView(arg_6_0)
	arg_6_0._helpId = arg_6_0.viewParam.id
	arg_6_0._pageId = arg_6_0.viewParam.pageId

	if arg_6_0.viewParam.guideId then
		arg_6_0._helpId = tonumber(arg_6_0.viewParam.viewParam)
		arg_6_0._matchGuideId = tonumber(arg_6_0.viewParam.guideId)
		arg_6_0._matchAllPage = arg_6_0.viewParam.matchAllPage
	end

	if not arg_6_0.viewParam.openFromGuide then
		arg_6_0:addEventCb(GuideController.instance, GuideEvent.FinishStep, arg_6_0._onFinishGuideStep, arg_6_0)
	end

	arg_6_0._pagesCo = {}

	if arg_6_0._helpId then
		local var_6_0 = HelpConfig.instance:getHelpCO(arg_6_0._helpId)

		if not var_6_0 then
			logError("请检查帮助说明配置" .. tostring(arg_6_0._helpId) .. "相关配置是否完整！")
		end

		local var_6_1 = string.split(var_6_0.page, "#")

		if #var_6_1 < 1 then
			logError("请检查帮助界面" .. tostring(arg_6_0._helpId) .. "相关配置是否完整！")

			return
		end

		HelpModel.instance:setTargetPageIndex(1)

		for iter_6_0 = 1, #var_6_1 do
			local var_6_2 = HelpConfig.instance:getHelpPageCo(tonumber(var_6_1[iter_6_0]))

			table.insert(arg_6_0._pagesCo, var_6_2)
		end
	elseif arg_6_0._pageId then
		HelpModel.instance:setTargetPageIndex(1)

		local var_6_3 = HelpConfig.instance:getHelpPageCo(arg_6_0._pageId)

		table.insert(arg_6_0._pagesCo, var_6_3)
	end

	if #arg_6_0._pagesCo < 1 then
		logError(string.format("help view(helpId : %s) not found can show pages", arg_6_0._helpId))

		return
	end

	arg_6_0:setSelectItem()
	arg_6_0:setHelpItem()
	arg_6_0:setBtnItem()
	arg_6_0:_onlyShowLastGuideQuitBtn()
	NavigateMgr.instance:addEscape(ViewName.HelpView, arg_6_0.closeThis, arg_6_0)
	FightAudioMgr.instance:obscureBgm(true)
end

function var_0_0._onVoideFullScreenChange(arg_7_0, arg_7_1)
	arg_7_0:setPageTabCfg(arg_7_1)
end

function var_0_0.setPageTabCfg(arg_8_0, arg_8_1)
	if arg_8_1 and arg_8_1.showType == HelpEnum.PageTabShowType.HelpView and arg_8_0._curShowHelpId ~= arg_8_1.helpId then
		arg_8_0._curShowHelpId = arg_8_1.helpId
		arg_8_0._showParam.id = arg_8_1.helpId
		arg_8_0.viewParam = arg_8_0._showParam

		arg_8_0:_refreshHelpPage()
	end
end

return var_0_0
