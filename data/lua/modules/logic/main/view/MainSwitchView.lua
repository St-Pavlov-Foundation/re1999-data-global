module("modules.logic.main.view.MainSwitchView", package.seeall)

local var_0_0 = class("MainSwitchView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gocontainer = gohelper.findChild(arg_1_0.viewGO, "#go_container")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._scrollcategory = gohelper.findChildScrollRect(arg_1_0.viewGO, "Tab/#scroll_category")
	arg_1_0._gocategoryitem1 = gohelper.findChild(arg_1_0.viewGO, "Tab/#scroll_category/categorycontent/#go_categoryitem1")
	arg_1_0._gocategoryitem2 = gohelper.findChild(arg_1_0.viewGO, "Tab/#scroll_category/categorycontent/#go_categoryitem2")
	arg_1_0._gocategoryitem3 = gohelper.findChild(arg_1_0.viewGO, "Tab/#scroll_category/categorycontent/#go_categoryitem3")

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
	arg_4_0._gotab = gohelper.findChild(arg_4_0.viewGO, "Tab")
	arg_4_0._goswitchloading = gohelper.findChild(arg_4_0.viewGO, "loadingmainview")
	arg_4_0._switchAniamtor = arg_4_0._goswitchloading:GetComponent("Animator")
	arg_4_0._rootAnimator = arg_4_0.viewGO:GetComponent("Animator")
	arg_4_0._tabCanvasGroup = arg_4_0._gotab:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_4_0._btnsCanvasGroup = arg_4_0._gobtns:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_4_0._gridLayout = gohelper.findChild(arg_4_0.viewGO, "Tab/#scroll_category/categorycontent"):GetComponent(typeof(UnityEngine.UI.GridLayoutGroup))
	arg_4_0._goreddot3 = gohelper.findChild(arg_4_0._gocategoryitem3, "reddot")
end

function var_0_0.onUpdateParam(arg_5_0)
	return
end

function var_0_0.onOpen(arg_6_0)
	MainSwitchCategoryListModel.instance:initCategoryList()

	arg_6_0._itemList = arg_6_0:getUserDataTb_()

	local var_6_0 = MainSwitchCategoryListModel.instance:getList()

	for iter_6_0, iter_6_1 in ipairs(var_6_0) do
		local var_6_1 = arg_6_0["_gocategoryitem" .. iter_6_0]
		local var_6_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_6_1, MainSwitchCategoryItem)

		var_6_2:onUpdateMO(iter_6_1)

		arg_6_0._itemList[iter_6_0] = var_6_2

		gohelper.setActive(var_6_1, true)
	end

	if #var_6_0 > 2 then
		arg_6_0._gridLayout.cellSize = Vector2(600, 90)
	else
		arg_6_0._gridLayout.cellSize = Vector2(780, 90)
	end

	arg_6_0:checkFightUIReddot()
	arg_6_0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.SwitchCategoryClick, arg_6_0._itemClick, arg_6_0)
	arg_6_0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.SceneSwitchUIVisible, arg_6_0._onSceneSwitchUIVisible, arg_6_0)
	arg_6_0:addEventCb(MainUISwitchController.instance, MainUISwitchEvent.SwitchUIVisible, arg_6_0._onSceneSwitchUIVisible, arg_6_0)
	arg_6_0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.BeforeStartSwitchScene, arg_6_0._onStartSwitchScene, arg_6_0)
	arg_6_0:addEventCb(MainSceneSwitchController.instance, MainSceneSwitchEvent.CloseSwitchSceneLoading, arg_6_0._onCloseSwitchSceneLoading, arg_6_0)
	arg_6_0:addEventCb(FightUISwitchController.instance, FightUISwitchEvent.cancelClassifyReddot, arg_6_0.checkFightUIReddot, arg_6_0)
end

function var_0_0._onStartSwitchScene(arg_7_0)
	gohelper.setActive(arg_7_0._goswitchloading, true)
	arg_7_0._switchAniamtor:Play("open", 0, 0)
end

function var_0_0._onCloseSwitchSceneLoading(arg_8_0)
	arg_8_0._switchAniamtor:Play("close", 0, 0)
end

function var_0_0._onSceneSwitchUIVisible(arg_9_0, arg_9_1)
	arg_9_0._tabCanvasGroup.blocksRaycasts = arg_9_1
	arg_9_0._btnsCanvasGroup.blocksRaycasts = arg_9_1

	arg_9_0._rootAnimator:Play(arg_9_1 and "open" or "close", 0, 0)
end

function var_0_0._itemClick(arg_10_0, arg_10_1)
	arg_10_0.viewContainer:playCloseAnim(arg_10_1)

	for iter_10_0, iter_10_1 in pairs(arg_10_0._itemList) do
		iter_10_1:refreshStatus()
	end
end

function var_0_0.checkFightUIReddot(arg_11_0)
	local var_11_0 = FightUISwitchModel.instance:isNewUnlockStyle()

	gohelper.setActive(arg_11_0._goreddot3, var_11_0)
end

function var_0_0.onClose(arg_12_0)
	return
end

function var_0_0.onDestroyView(arg_13_0)
	return
end

return var_0_0
