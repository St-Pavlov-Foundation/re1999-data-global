module("modules.logic.survival.view.map.SurvivalCommonTipsView", package.seeall)

local var_0_0 = class("SurvivalCommonTipsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goclose = gohelper.findChild(arg_1_0.viewGO, "#go_close")
	arg_1_0.goscrolltip = gohelper.findChild(arg_1_0.viewGO, "#scroll_tip")
	arg_1_0.gocontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_tip/Viewport/Content")
	arg_1_0.gotipitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_tip/Viewport/Content/#go_tipitem")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0.closeClick = gohelper.getClickWithDefaultAudio(arg_2_0.goclose)

	arg_2_0.closeClick:AddClickListener(arg_2_0.closeThis, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0.closeClick:RemoveClickListener()

	arg_3_0.closeClick = nil
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0.rectTrScrollTip = arg_4_0.goscrolltip:GetComponent(gohelper.Type_RectTransform)
	arg_4_0.rectTrViewGo = arg_4_0.viewGO:GetComponent(gohelper.Type_RectTransform)
	arg_4_0.rectTrContent = arg_4_0.gocontent:GetComponent(gohelper.Type_RectTransform)

	gohelper.setActive(arg_4_0.gotipitem, false)

	arg_4_0.scrollTip = SLFramework.UGUI.ScrollRectWrap.Get(arg_4_0.goscrolltip)
	arg_4_0.clickPosition = GamepadController.instance:getMousePosition()

	local var_4_0 = arg_4_0.viewParam.pivot or Vector2()

	arg_4_0.rectTrScrollTip.pivot = var_4_0

	local var_4_1, var_4_2 = recthelper.screenPosToAnchorPos2(arg_4_0.clickPosition, arg_4_0.rectTrViewGo)

	var_4_1 = var_4_0.x > 0 and var_4_1 - CommonBuffTipEnum.DefaultInterval or var_4_1 + CommonBuffTipEnum.DefaultInterval
	var_4_2 = var_4_0.y > 0 and var_4_2 - CommonBuffTipEnum.DefaultInterval or var_4_2 + CommonBuffTipEnum.DefaultInterval

	recthelper.setAnchor(arg_4_0.rectTrScrollTip, var_4_1, var_4_2)

	local var_4_3 = recthelper.getHeight(arg_4_0.rectTrViewGo)
	local var_4_4 = recthelper.getAnchorY(arg_4_0.rectTrScrollTip)
	local var_4_5 = math.abs(var_4_4)

	arg_4_0.maxHeight = var_4_3 / 2 + var_4_5 - CommonBuffTipEnum.BottomMargin

	gohelper.CreateObjList(arg_4_0, arg_4_0._onCreateItem, arg_4_0.viewParam.list, nil, arg_4_0.gotipitem)
	ZProj.UGUIHelper.RebuildLayout(arg_4_0.rectTrContent)

	local var_4_6 = recthelper.getHeight(arg_4_0.rectTrContent)
	local var_4_7 = math.min(arg_4_0.maxHeight, var_4_6)

	recthelper.setHeight(arg_4_0.rectTrScrollTip, var_4_7)

	arg_4_0.scrollTip.verticalNormalizedPosition = 0
end

function var_0_0._onCreateItem(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = gohelper.findChildText(arg_5_1, "title/txt_name")
	local var_5_1 = gohelper.findChildText(arg_5_1, "txt_desc")
	local var_5_2 = gohelper.findChild(arg_5_1, "title/txt_name/go_tag")

	var_5_0.text = arg_5_2.title
	var_5_1.text = arg_5_2.desc

	gohelper.setActive(var_5_2, false)
end

return var_0_0
