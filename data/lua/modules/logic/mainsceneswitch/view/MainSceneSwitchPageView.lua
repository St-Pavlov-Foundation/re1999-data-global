module("modules.logic.mainsceneswitch.view.MainSceneSwitchPageView", package.seeall)

local var_0_0 = class("MainSceneSwitchPageView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobg1 = gohelper.findChild(arg_1_0.viewGO, "#go_bg1")
	arg_1_0._gobg2 = gohelper.findChild(arg_1_0.viewGO, "#go_bg2")
	arg_1_0._simageFullBG1 = gohelper.findChildSingleImage(arg_1_0._gobg1, "img")
	arg_1_0._simageFullBG2 = gohelper.findChildSingleImage(arg_1_0._gobg2, "img")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._switchTime = CommonConfig.instance:getConstNum(ConstEnum.SceneSwitchPageTime)

	arg_4_0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.ShowSceneInfo, arg_4_0._onShowSceneInfo, arg_4_0)
end

function var_0_0._onShowSceneInfo(arg_5_0, arg_5_1)
	if arg_5_1 == MainSceneSwitchModel.instance:getCurSceneId() then
		arg_5_0:_clearPage()

		return
	end

	arg_5_0:_initPage(arg_5_1)
end

function var_0_0._clearPage(arg_6_0)
	arg_6_0._simageFullBG1:UnLoadImage()
	arg_6_0._simageFullBG2:UnLoadImage()
	gohelper.setActive(arg_6_0._simageFullBG1, false)
	gohelper.setActive(arg_6_0._simageFullBG2, false)
	TaskDispatcher.cancelTask(arg_6_0._switchPage, arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._switchPageFinish, arg_6_0)
end

function var_0_0._initPage(arg_7_0, arg_7_1)
	gohelper.setActive(arg_7_0._simageFullBG1, true)
	gohelper.setActive(arg_7_0._simageFullBG2, true)

	if not arg_7_0._page1 then
		arg_7_0._page1 = {
			img = arg_7_0._simageFullBG1,
			pageGo = arg_7_0._gobg1,
			animator = arg_7_0._gobg1:GetComponent("Animator")
		}
		arg_7_0._page2 = {
			img = arg_7_0._simageFullBG2,
			pageGo = arg_7_0._gobg2,
			animator = arg_7_0._gobg2:GetComponent("Animator")
		}
	end

	arg_7_0._previews = lua_scene_switch.configDict[arg_7_1].previews
	arg_7_0._pageIndex = 1

	arg_7_0:_updatePage()
	TaskDispatcher.cancelTask(arg_7_0._switchPageFinish, arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0._switchPage, arg_7_0)
	TaskDispatcher.runDelay(arg_7_0._switchPage, arg_7_0, arg_7_0._switchTime)
end

function var_0_0._switchPage(arg_8_0)
	TaskDispatcher.runDelay(arg_8_0._switchPageFinish, arg_8_0, MainSceneSwitchEnum.PageSwitchTime)
	arg_8_0._page1.animator:Play("close", 0, 0)
	arg_8_0._page2.animator:Play("open", 0, 0)

	if not arg_8_0._switchClose then
		local var_8_0 = ViewMgr.instance:getOpenViewNameList()

		if var_8_0[#var_8_0] ~= ViewName.MainSwitchView then
			return
		end

		AudioMgr.instance:trigger(AudioEnum.MainSceneSkin.play_ui_main_glitter)
	end
end

function var_0_0._switchPageFinish(arg_9_0)
	arg_9_0._page1, arg_9_0._page2 = arg_9_0._page2, arg_9_0._page1
	arg_9_0._pageIndex = arg_9_0._pageIndex + 1

	if arg_9_0._pageIndex > #arg_9_0._previews then
		arg_9_0._pageIndex = 1
	end

	arg_9_0:_updatePage()
	TaskDispatcher.runDelay(arg_9_0._switchPage, arg_9_0, arg_9_0._switchTime)
end

function var_0_0._updatePage(arg_10_0)
	arg_10_0:_updateOnePage(arg_10_0._page1.img, arg_10_0._pageIndex, 0)
	arg_10_0:_updateOnePage(arg_10_0._page2.img, arg_10_0._pageIndex + 1, 0)
	arg_10_0._page1.animator:Play("open", 0, 0)
	gohelper.setAsFirstSibling(arg_10_0._page2.pageGo)
	arg_10_0._page2.animator:Play("open", 0, 0)
end

function var_0_0._updateOnePage(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if arg_11_2 > #arg_11_0._previews then
		arg_11_2 = 1
	end

	local var_11_0 = ResUrl.getMainSceneSwitchIcon(string.format("mainsceneswitch_randombg%02d", arg_11_0._previews[arg_11_2]))

	arg_11_1:LoadImage(var_11_0)
	recthelper.setAnchorX(arg_11_1.transform.parent, arg_11_3)
end

function var_0_0.onTabSwitchOpen(arg_12_0)
	arg_12_0._switchClose = false
end

function var_0_0.onTabSwitchClose(arg_13_0)
	arg_13_0._switchClose = true
end

function var_0_0.onDestroyView(arg_14_0)
	arg_14_0:_clearPage()
end

return var_0_0
