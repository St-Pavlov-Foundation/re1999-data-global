module("modules.logic.help.view.HelpView", package.seeall)

local var_0_0 = class("HelpView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goslider = gohelper.findChild(arg_1_0.viewGO, "#go_slider")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._scrollcontent = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_content")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "#go_content")
	arg_1_0._btnleft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_left")
	arg_1_0._btnright = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_right")
	arg_1_0._goscroll = gohelper.findChild(arg_1_0.viewGO, "#go_scroll")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnleft:AddClickListener(arg_2_0._btnleftOnClick, arg_2_0)
	arg_2_0._btnright:AddClickListener(arg_2_0._btnrightOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnleft:RemoveClickListener()
	arg_3_0._btnright:RemoveClickListener()
end

function var_0_0._btnleftOnClick(arg_4_0)
	HelpModel.instance:setTargetPageIndex(HelpModel.instance:getTargetPageIndex() - 1)
	arg_4_0:selectHelpItem()
end

function var_0_0._btnrightOnClick(arg_5_0)
	HelpModel.instance:setTargetPageIndex(HelpModel.instance:getTargetPageIndex() + 1)
	arg_5_0:selectHelpItem()
end

function var_0_0._editableInitView(arg_6_0)
	gohelper.addUIClickAudio(arg_6_0._btnleft.gameObject, AudioEnum.UI.Play_UI_help_switch)
	gohelper.addUIClickAudio(arg_6_0._btnright.gameObject, AudioEnum.UI.Play_UI_help_switch)

	arg_6_0._selectItems = {}
	arg_6_0._helpItems = {}
	arg_6_0._space = recthelper.getWidth(arg_6_0.viewGO.transform) + 80
	arg_6_0._scroll = SLFramework.UGUI.UIDragListener.Get(arg_6_0._goscroll)

	arg_6_0._scroll:AddDragBeginListener(arg_6_0._onScrollDragBegin, arg_6_0)
	arg_6_0._scroll:AddDragEndListener(arg_6_0._onScrollDragEnd, arg_6_0)

	arg_6_0._viewClick = gohelper.getClick(arg_6_0._gocontent)

	arg_6_0._viewClick:AddClickListener(arg_6_0._onClickView, arg_6_0)
	arg_6_0:addEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_6_0._onScreenResize, arg_6_0)
end

function var_0_0._onScreenResize(arg_7_0)
	arg_7_0._space = recthelper.getWidth(arg_7_0.viewGO.transform) + 80

	if arg_7_0._helpItems then
		for iter_7_0 = 1, #arg_7_0._helpItems do
			local var_7_0 = arg_7_0._space * (iter_7_0 - 1)

			arg_7_0._helpItems[iter_7_0]:updatePos(var_7_0)
		end
	end

	local var_7_1 = (1 - HelpModel.instance:getTargetPageIndex()) * arg_7_0._space

	recthelper.setAnchorX(arg_7_0._gocontent.transform, var_7_1)
end

function var_0_0._onScrollDragBegin(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._scrollStartPos = arg_8_2.position
end

function var_0_0._onScrollDragEnd(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_2.position
	local var_9_1 = var_9_0.x - arg_9_0._scrollStartPos.x
	local var_9_2 = var_9_0.y - arg_9_0._scrollStartPos.y

	if math.abs(var_9_1) < math.abs(var_9_2) then
		return
	end

	if var_9_1 > 100 and arg_9_0._btnleft.gameObject.activeInHierarchy then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_help_switch)
		HelpModel.instance:setTargetPageIndex(HelpModel.instance:getTargetPageIndex() - 1)
		arg_9_0:selectHelpItem()
	elseif var_9_1 < -100 and arg_9_0._btnright.gameObject.activeInHierarchy then
		AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_help_switch)
		HelpModel.instance:setTargetPageIndex(HelpModel.instance:getTargetPageIndex() + 1)
		arg_9_0:selectHelpItem()
	end
end

function var_0_0._onClickView(arg_10_0)
	if arg_10_0.viewParam.guideId then
		arg_10_0:_btnrightOnClick()
	end
end

function var_0_0.onUpdateParam(arg_11_0)
	if arg_11_0._helpItems then
		for iter_11_0, iter_11_1 in pairs(arg_11_0._helpItems) do
			iter_11_1:destroy()
			gohelper.destroy(iter_11_1._go)
		end
	end

	arg_11_0._helpItems = {}

	arg_11_0:_refreshView()
end

function var_0_0.onOpen(arg_12_0)
	arg_12_0:_refreshView()
end

function var_0_0._refreshView(arg_13_0)
	arg_13_0._helpId = arg_13_0.viewParam.id
	arg_13_0._pageId = arg_13_0.viewParam.pageId

	if arg_13_0.viewParam.guideId then
		arg_13_0._helpId = tonumber(arg_13_0.viewParam.viewParam)
		arg_13_0._matchGuideId = tonumber(arg_13_0.viewParam.guideId)
		arg_13_0._matchAllPage = arg_13_0.viewParam.matchAllPage
	end

	if not arg_13_0.viewParam.openFromGuide then
		arg_13_0:addEventCb(GuideController.instance, GuideEvent.FinishStep, arg_13_0._onFinishGuideStep, arg_13_0)
	end

	arg_13_0._pagesCo = {}

	if arg_13_0._helpId then
		local var_13_0 = HelpConfig.instance:getHelpCO(arg_13_0._helpId)

		if not var_13_0 then
			logError("请检查帮助说明配置" .. tostring(arg_13_0._helpId) .. "相关配置是否完整！")
		end

		local var_13_1 = string.split(var_13_0.page, "#")

		if #var_13_1 < 1 then
			logError("请检查帮助界面" .. tostring(arg_13_0._helpId) .. "相关配置是否完整！")

			return
		end

		HelpModel.instance:setTargetPageIndex(1)

		for iter_13_0 = 1, #var_13_1 do
			local var_13_2 = HelpConfig.instance:getHelpPageCo(tonumber(var_13_1[iter_13_0]))

			if arg_13_0._matchAllPage then
				if HelpController.instance:canShowPage(var_13_2) or var_13_2.unlockGuideId == arg_13_0._matchGuideId then
					table.insert(arg_13_0._pagesCo, var_13_2)
				end
			elseif arg_13_0._matchGuideId then
				if var_13_2.unlockGuideId == arg_13_0._matchGuideId then
					table.insert(arg_13_0._pagesCo, var_13_2)
				end
			elseif HelpController.instance:canShowPage(var_13_2) then
				table.insert(arg_13_0._pagesCo, var_13_2)
			end
		end
	elseif arg_13_0._pageId then
		HelpModel.instance:setTargetPageIndex(1)

		local var_13_3 = HelpConfig.instance:getHelpPageCo(arg_13_0._pageId)

		table.insert(arg_13_0._pagesCo, var_13_3)
	end

	if #arg_13_0._pagesCo < 1 then
		logError(string.format("help view(helpId : %s) not found can show pages", arg_13_0._helpId))
		arg_13_0:closeThis()

		return
	end

	arg_13_0:setSelectItem()
	arg_13_0:setHelpItem()
	arg_13_0:setBtnItem()
	arg_13_0:setBtnShow()
	arg_13_0:_onlyShowLastGuideQuitBtn()
	NavigateMgr.instance:addEscape(ViewName.HelpView, arg_13_0.closeThis, arg_13_0)
	FightAudioMgr.instance:obscureBgm(true)
end

function var_0_0._onFinishGuideStep(arg_14_0)
	arg_14_0:closeThis()
end

function var_0_0._onlyShowLastGuideQuitBtn(arg_15_0)
	if arg_15_0.viewParam.guideId or arg_15_0.viewParam.auto then
		for iter_15_0, iter_15_1 in ipairs(arg_15_0._helpItems) do
			iter_15_1:showQuitBtn(iter_15_0 == #arg_15_0._helpItems)
		end
	end
end

function var_0_0.onOpenFinish(arg_16_0)
	HelpModel.instance:setShowedHelp(arg_16_0._helpId)
	HelpController.instance:dispatchEvent(HelpEvent.RefreshHelp)
end

function var_0_0.setSelectItem(arg_17_0)
	local var_17_0 = arg_17_0.viewContainer:getSetting().otherRes[1]

	for iter_17_0 = 1, #arg_17_0._pagesCo do
		local var_17_1 = arg_17_0:getResInst(var_17_0, arg_17_0._goslider, "HelpSelectItem")
		local var_17_2 = HelpSelectItem.New()

		var_17_2:init({
			go = var_17_1,
			index = iter_17_0,
			config = arg_17_0._pagesCo[iter_17_0],
			pos = 55 * (iter_17_0 - 0.5 * (#arg_17_0._pagesCo + 1))
		})
		var_17_2:updateItem()
		table.insert(arg_17_0._selectItems, var_17_2)
	end
end

function var_0_0.setHelpItem(arg_18_0)
	for iter_18_0 = 1, #arg_18_0._pagesCo do
		if arg_18_0._pagesCo[iter_18_0].type == HelpEnum.HelpType.Normal then
			local var_18_0 = arg_18_0.viewContainer:getSetting().otherRes[2]
			local var_18_1 = arg_18_0:getResInst(var_18_0, arg_18_0._gocontent, "HelpContentItem")
			local var_18_2 = HelpContentItem.New()

			var_18_2:init({
				go = var_18_1,
				index = iter_18_0,
				config = arg_18_0._pagesCo[iter_18_0],
				pos = arg_18_0._space * (iter_18_0 - 1)
			})
			var_18_2:updateItem()
			table.insert(arg_18_0._helpItems, var_18_2)
		elseif arg_18_0._pagesCo[iter_18_0].type == HelpEnum.HelpType.VersionActivity then
			local var_18_3 = arg_18_0.viewContainer:getSetting().otherRes[3]
			local var_18_4 = arg_18_0:getResInst(var_18_3, arg_18_0._gocontent, "HelpVAContentItem")
			local var_18_5 = HelpVersionActivityContentItem.New()

			var_18_5:init({
				go = var_18_4,
				index = iter_18_0,
				config = arg_18_0._pagesCo[iter_18_0],
				pos = arg_18_0._space * (iter_18_0 - 1)
			})
			var_18_5:updateItem()
			table.insert(arg_18_0._helpItems, var_18_5)
		end
	end
end

function var_0_0.setBtnItem(arg_19_0)
	local var_19_0 = HelpModel.instance:getTargetPageIndex()

	gohelper.setActive(arg_19_0._btnright.gameObject, var_19_0 < #arg_19_0._pagesCo)
	gohelper.setActive(arg_19_0._btnleft.gameObject, var_19_0 > 1)
end

function var_0_0.setBtnShow(arg_20_0)
	local var_20_0 = HelpModel.instance:getTargetPageIndex()
	local var_20_1 = arg_20_0._pagesCo[var_20_0]

	if var_20_1 and not string.nilorempty(var_20_1.icon) then
		arg_20_0.viewContainer:setBtnShow(false)
	else
		arg_20_0.viewContainer:setBtnShow(true)
	end
end

function var_0_0.selectHelpItem(arg_21_0)
	for iter_21_0, iter_21_1 in pairs(arg_21_0._selectItems) do
		iter_21_1:updateItem()
	end

	local var_21_0 = (1 - HelpModel.instance:getTargetPageIndex()) * arg_21_0._space

	ZProj.TweenHelper.DOAnchorPosX(arg_21_0._gocontent.transform, var_21_0, 0.25)
	arg_21_0:setBtnItem()
	arg_21_0:setBtnShow()
end

function var_0_0.onClose(arg_22_0)
	arg_22_0:removeEventCb(GuideController.instance, GuideEvent.FinishStep, arg_22_0._onFinishGuideStep, arg_22_0)
	FightAudioMgr.instance:obscureBgm(false)
end

function var_0_0.onDestroyView(arg_23_0)
	if arg_23_0._selectItems then
		for iter_23_0, iter_23_1 in pairs(arg_23_0._selectItems) do
			iter_23_1:destroy()
		end

		arg_23_0._selectItems = nil
	end

	if arg_23_0._helpItems then
		for iter_23_2, iter_23_3 in pairs(arg_23_0._helpItems) do
			iter_23_3:destroy()
		end

		arg_23_0._helpItems = nil
	end

	arg_23_0._scroll:RemoveDragBeginListener()
	arg_23_0._scroll:RemoveDragEndListener()
	arg_23_0._viewClick:RemoveClickListener()
	arg_23_0:removeEventCb(GameGlobalMgr.instance, GameStateEvent.OnScreenResize, arg_23_0._onScreenResize, arg_23_0)
end

return var_0_0
