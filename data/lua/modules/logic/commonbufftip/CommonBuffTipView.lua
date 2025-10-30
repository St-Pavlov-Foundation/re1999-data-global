module("modules.logic.commonbufftip.CommonBuffTipView", package.seeall)

local var_0_0 = class("CommonBuffTipView", BaseView)

function var_0_0._refreshScrollHeight(arg_1_0)
	local var_1_0 = recthelper.getHeight(arg_1_0.rectTrContent)
	local var_1_1 = math.min(arg_1_0.maxHeight, var_1_0)

	recthelper.setHeight(arg_1_0.rectTrScrollTip, var_1_1)
	arg_1_0:setScrollPos(var_1_1)
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0.goclose = gohelper.findChild(arg_2_0.viewGO, "#go_close")
	arg_2_0.goscrolltip = gohelper.findChild(arg_2_0.viewGO, "#scroll_tip")
	arg_2_0.gocontent = gohelper.findChild(arg_2_0.viewGO, "#scroll_tip/Viewport/Content")
	arg_2_0.gotipitem = gohelper.findChild(arg_2_0.viewGO, "#scroll_tip/Viewport/Content/#go_tipitem")

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	return
end

function var_0_0.removeEvents(arg_4_0)
	return
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0.effectTipItemList = {}
	arg_5_0.effectTipItemPool = {}
	arg_5_0.addEffectIdDict = {}
	arg_5_0.rectTrScrollTip = arg_5_0.goscrolltip:GetComponent(gohelper.Type_RectTransform)
	arg_5_0.rectTrViewGo = arg_5_0.viewGO:GetComponent(gohelper.Type_RectTransform)
	arg_5_0.rectTrContent = arg_5_0.gocontent:GetComponent(gohelper.Type_RectTransform)

	gohelper.setActive(arg_5_0.gotipitem, false)

	arg_5_0.closeClick = gohelper.getClickWithDefaultAudio(arg_5_0.goclose)

	arg_5_0.closeClick:AddClickListener(arg_5_0.closeThis, arg_5_0)

	arg_5_0.scrollTip = SLFramework.UGUI.ScrollRectWrap.Get(arg_5_0.goscrolltip)
end

function var_0_0.setIsShowUI(arg_6_0, arg_6_1)
	if not arg_6_1 then
		arg_6_0:closeThis()
	end
end

function var_0_0.initViewParam(arg_7_0)
	arg_7_0.effectId = arg_7_0.viewParam.effectId
	arg_7_0.scrollAnchorPos = arg_7_0.viewParam.scrollAnchorPos
	arg_7_0.pivot = arg_7_0.viewParam.pivot
	arg_7_0.clickPosition = arg_7_0.viewParam.clickPosition
	arg_7_0.setScrollPosCallback = arg_7_0.viewParam.setScrollPosCallback
	arg_7_0.setScrollPosCallbackObj = arg_7_0.viewParam.setScrollPosCallbackObj
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:initViewParam()
	arg_8_0:setScrollPos()
	arg_8_0:calculateMaxHeight()
	arg_8_0:addBuffTip(arg_8_0.effectId)
	arg_8_0:addEventCb(FightController.instance, FightEvent.SetIsShowUI, arg_8_0.setIsShowUI, arg_8_0)
end

function var_0_0.setScrollPos(arg_9_0, arg_9_1)
	if arg_9_0.setScrollPosCallback then
		arg_9_0.setScrollPosCallback(arg_9_0.setScrollPosCallbackObj, arg_9_0.rectTrViewGo, arg_9_0.rectTrScrollTip)

		return
	end

	if arg_9_0.scrollAnchorPos then
		arg_9_0.rectTrScrollTip.pivot = arg_9_0.pivot

		local var_9_0 = arg_9_0.scrollAnchorPos.y

		if arg_9_1 and arg_9_1 > 540 + var_9_0 then
			var_9_0 = arg_9_1 - 540
		end

		recthelper.setAnchor(arg_9_0.rectTrScrollTip, arg_9_0.scrollAnchorPos.x, var_9_0)

		return
	end

	local var_9_1 = GameUtil.checkClickPositionInRight(arg_9_0.clickPosition)

	arg_9_0.rectTrScrollTip.pivot = var_9_1 and CommonBuffTipEnum.Pivot.Right or CommonBuffTipEnum.Pivot.Left

	local var_9_2, var_9_3 = recthelper.screenPosToAnchorPos2(arg_9_0.clickPosition, arg_9_0.rectTrViewGo)

	var_9_2 = var_9_1 and var_9_2 - CommonBuffTipEnum.DefaultInterval or var_9_2 + CommonBuffTipEnum.DefaultInterval

	recthelper.setAnchor(arg_9_0.rectTrScrollTip, var_9_2, var_9_3 + CommonBuffTipEnum.DefaultInterval)
end

function var_0_0.calculateMaxHeight(arg_10_0)
	local var_10_0 = recthelper.getHeight(arg_10_0.rectTrViewGo)
	local var_10_1 = recthelper.getAnchorY(arg_10_0.rectTrScrollTip)
	local var_10_2 = math.abs(var_10_1)

	arg_10_0.maxHeight = var_10_0 / 2 + var_10_2 - CommonBuffTipEnum.BottomMargin

	if arg_10_0.rectTrScrollTip.pivot.y == 0 then
		arg_10_0.maxHeight = var_10_0 / 2 - var_10_2 - CommonBuffTipEnum.BottomMargin
	end
end

function var_0_0.addBuffTip(arg_11_0, arg_11_1)
	local var_11_0 = tonumber(arg_11_1)

	if arg_11_0.addEffectIdDict[var_11_0] then
		return
	end

	local var_11_1 = lua_skill_eff_desc.configDict[var_11_0]

	if not var_11_1 then
		logError("not found skill_eff_desc , id : " .. tostring(arg_11_1))

		return
	end

	arg_11_0.addEffectIdDict[var_11_0] = true

	local var_11_2 = arg_11_0:getTipItem()

	table.insert(arg_11_0.effectTipItemList, var_11_2)
	gohelper.setActive(var_11_2.go, true)
	gohelper.setAsLastSibling(var_11_2.go)

	local var_11_3 = var_11_1.name
	local var_11_4 = SkillHelper.removeRichTag(var_11_3)

	var_11_2.txtName.text = var_11_4
	var_11_2.txtDesc.text = SkillHelper.getSkillDesc(arg_11_0.viewParam.monsterName, var_11_1)

	local var_11_5 = CommonBuffTipController.instance:getBuffTagName(var_11_3)
	local var_11_6 = not string.nilorempty(var_11_5)

	gohelper.setActive(var_11_2.goTag, var_11_6)

	if var_11_6 then
		var_11_2.txtTag.text = var_11_5
	end

	arg_11_0:refreshScrollHeight()
end

function var_0_0.refreshScrollHeight(arg_12_0)
	ZProj.UGUIHelper.RebuildLayout(arg_12_0.rectTrContent)
	FrameTimerController.onDestroyViewMember(arg_12_0, "_fTimer")

	arg_12_0._fTimer = FrameTimerController.instance:register(arg_12_0._refreshScrollHeight, arg_12_0, 1)

	arg_12_0._fTimer:Start()
end

function var_0_0.getTipItem(arg_13_0)
	if #arg_13_0.effectTipItemPool > 0 then
		return table.remove(arg_13_0.effectTipItemPool)
	end

	local var_13_0 = arg_13_0:getUserDataTb_()

	var_13_0.go = gohelper.cloneInPlace(arg_13_0.gotipitem)
	var_13_0.txtName = gohelper.findChildText(var_13_0.go, "title/txt_name")
	var_13_0.txtDesc = gohelper.findChildText(var_13_0.go, "txt_desc")
	var_13_0.goTag = gohelper.findChild(var_13_0.go, "title/txt_name/go_tag")
	var_13_0.txtTag = gohelper.findChildText(var_13_0.go, "title/txt_name/go_tag/bg/txt_tagname")

	SkillHelper.addHyperLinkClick(var_13_0.txtDesc, arg_13_0.onClickHyperLinkText, arg_13_0)

	return var_13_0
end

function var_0_0.onClickHyperLinkText(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0:addBuffTip(arg_14_1)
end

function var_0_0.recycleTipItem(arg_15_0, arg_15_1)
	gohelper.setActive(arg_15_1.go, false)
	table.insert(arg_15_0.effectTipItemPool, arg_15_1)
end

function var_0_0.recycleAllTipItem(arg_16_0)
	for iter_16_0, iter_16_1 in ipairs(arg_16_0.effectTipItemList) do
		gohelper.setActive(iter_16_1.go, false)
		table.insert(arg_16_0.effectTipItemPool, iter_16_1)
	end

	tabletool.clear(arg_16_0.effectTipItemList)
end

function var_0_0.onClose(arg_17_0)
	FrameTimerController.onDestroyViewMember(arg_17_0, "_fTimer")
	tabletool.clear(arg_17_0.addEffectIdDict)
	arg_17_0:recycleAllTipItem()
	arg_17_0:removeEventCb(FightController.instance, FightEvent.SetIsShowUI, arg_17_0.setIsShowUI, arg_17_0)
end

function var_0_0.onDestroyView(arg_18_0)
	arg_18_0.closeClick:RemoveClickListener()

	arg_18_0.closeClick = nil
end

return var_0_0
