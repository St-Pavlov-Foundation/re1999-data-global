module("modules.logic.versionactivity2_7.act191.view.Act191BuffTipView", package.seeall)

local var_0_0 = class("Act191BuffTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goclose = gohelper.findChild(arg_1_0.viewGO, "#go_close")
	arg_1_0.goscrolltip = gohelper.findChild(arg_1_0.viewGO, "#scroll_tip")
	arg_1_0.gocontent = gohelper.findChild(arg_1_0.viewGO, "#scroll_tip/Viewport/Content")
	arg_1_0.gotipitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_tip/Viewport/Content/#go_tipitem")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0.effectTipItemList = {}
	arg_2_0.effectTipItemPool = {}
	arg_2_0.addEffectIdDict = {}
	arg_2_0.rectTrScrollTip = arg_2_0.goscrolltip:GetComponent(gohelper.Type_RectTransform)
	arg_2_0.rectTrViewGo = arg_2_0.viewGO:GetComponent(gohelper.Type_RectTransform)
	arg_2_0.rectTrContent = arg_2_0.gocontent:GetComponent(gohelper.Type_RectTransform)

	gohelper.setActive(arg_2_0.gotipitem, false)

	arg_2_0.closeClick = gohelper.getClickWithDefaultAudio(arg_2_0.goclose)

	arg_2_0.closeClick:AddClickListener(arg_2_0.closeThis, arg_2_0)

	arg_2_0.scrollTip = SLFramework.UGUI.ScrollRectWrap.Get(arg_2_0.goscrolltip)
end

function var_0_0.initViewParam(arg_3_0)
	arg_3_0.effectId = arg_3_0.viewParam.effectId
	arg_3_0.scrollAnchorPos = arg_3_0.viewParam.scrollAnchorPos
	arg_3_0.pivot = arg_3_0.viewParam.pivot
	arg_3_0.clickPosition = arg_3_0.viewParam.clickPosition
	arg_3_0.setScrollPosCallback = arg_3_0.viewParam.setScrollPosCallback
	arg_3_0.setScrollPosCallbackObj = arg_3_0.viewParam.setScrollPosCallbackObj
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0:initViewParam()
	arg_4_0:setScrollPos()
	arg_4_0:calculateMaxHeight()
	arg_4_0:addBuffTip(arg_4_0.effectId)
end

function var_0_0.setScrollPos(arg_5_0)
	if arg_5_0.setScrollPosCallback then
		arg_5_0.setScrollPosCallback(arg_5_0.setScrollPosCallbackObj, arg_5_0.rectTrViewGo, arg_5_0.rectTrScrollTip)

		return
	end

	if arg_5_0.scrollAnchorPos then
		arg_5_0.rectTrScrollTip.pivot = arg_5_0.pivot

		recthelper.setAnchor(arg_5_0.rectTrScrollTip, arg_5_0.scrollAnchorPos.x, arg_5_0.scrollAnchorPos.y)

		return
	end

	local var_5_0 = GameUtil.checkClickPositionInRight(arg_5_0.clickPosition)

	arg_5_0.rectTrScrollTip.pivot = var_5_0 and CommonBuffTipEnum.Pivot.Right or CommonBuffTipEnum.Pivot.Left

	local var_5_1, var_5_2 = recthelper.screenPosToAnchorPos2(arg_5_0.clickPosition, arg_5_0.rectTrViewGo)

	var_5_1 = var_5_0 and var_5_1 - CommonBuffTipEnum.DefaultInterval or var_5_1 + CommonBuffTipEnum.DefaultInterval

	recthelper.setAnchor(arg_5_0.rectTrScrollTip, var_5_1, var_5_2 + CommonBuffTipEnum.DefaultInterval)
end

function var_0_0.calculateMaxHeight(arg_6_0)
	local var_6_0 = recthelper.getHeight(arg_6_0.rectTrViewGo)
	local var_6_1 = recthelper.getAnchorY(arg_6_0.rectTrScrollTip)

	arg_6_0.maxHeight = var_6_0 / 2 + var_6_1 - CommonBuffTipEnum.BottomMargin
end

function var_0_0.addBuffTip(arg_7_0, arg_7_1)
	if arg_7_0.addEffectIdDict[arg_7_1] then
		return
	end

	local var_7_0 = Activity191Config.instance:getEffDescCoByName(arg_7_1)

	if not var_7_0 then
		return
	end

	arg_7_0.addEffectIdDict[arg_7_1] = true

	local var_7_1 = arg_7_0:getTipItem()

	table.insert(arg_7_0.effectTipItemList, var_7_1)
	gohelper.setActive(var_7_1.go, true)
	gohelper.setAsLastSibling(var_7_1.go)

	local var_7_2 = SkillHelper.removeRichTag(arg_7_1)

	var_7_1.txtName.text = var_7_2
	var_7_1.txtDesc.text = Activity191Helper.buildDesc(var_7_0.desc, Activity191Enum.HyperLinkPattern.SkillDesc)

	arg_7_0:refreshScrollHeight()
end

function var_0_0.refreshScrollHeight(arg_8_0)
	ZProj.UGUIHelper.RebuildLayout(arg_8_0.rectTrContent)

	local var_8_0 = recthelper.getHeight(arg_8_0.rectTrContent)
	local var_8_1 = math.min(arg_8_0.maxHeight, var_8_0)

	recthelper.setHeight(arg_8_0.rectTrScrollTip, var_8_1)

	arg_8_0.scrollTip.verticalNormalizedPosition = 0
end

function var_0_0.getTipItem(arg_9_0)
	if #arg_9_0.effectTipItemPool > 0 then
		return table.remove(arg_9_0.effectTipItemPool)
	end

	local var_9_0 = arg_9_0:getUserDataTb_()

	var_9_0.go = gohelper.cloneInPlace(arg_9_0.gotipitem)
	var_9_0.txtName = gohelper.findChildText(var_9_0.go, "title/txt_name")
	var_9_0.txtDesc = gohelper.findChildText(var_9_0.go, "txt_desc")
	var_9_0.goTag = gohelper.findChild(var_9_0.go, "title/txt_name/go_tag")
	var_9_0.txtTag = gohelper.findChildText(var_9_0.go, "title/txt_name/go_tag/bg/txt_tagname")

	SkillHelper.addHyperLinkClick(var_9_0.txtDesc, arg_9_0.onClickHyperLinkText, arg_9_0)

	return var_9_0
end

function var_0_0.onClickHyperLinkText(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0:addBuffTip(arg_10_1)
end

function var_0_0.recycleTipItem(arg_11_0, arg_11_1)
	gohelper.setActive(arg_11_1.go, false)
	table.insert(arg_11_0.effectTipItemPool, arg_11_1)
end

function var_0_0.recycleAllTipItem(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0.effectTipItemList) do
		gohelper.setActive(iter_12_1.go, false)
		table.insert(arg_12_0.effectTipItemPool, iter_12_1)
	end

	tabletool.clear(arg_12_0.effectTipItemList)
end

function var_0_0.onClose(arg_13_0)
	tabletool.clear(arg_13_0.addEffectIdDict)
	arg_13_0:recycleAllTipItem()
end

function var_0_0.onDestroyView(arg_14_0)
	arg_14_0.closeClick:RemoveClickListener()

	arg_14_0.closeClick = nil
end

return var_0_0
