module("modules.logic.handbook.view.HandbookCGView", package.seeall)

local var_0_0 = class("HandbookCGView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._simagelbwz4 = gohelper.findChildSingleImage(arg_1_0.viewGO, "icon/#simage_lbwz4")
	arg_1_0._btnchange = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_change")
	arg_1_0._scrollcg = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_cg")
	arg_1_0.verticalScrollPixelList = {}
	arg_1_0._lastSelectId = nil
	arg_1_0._ischanged = false

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._scrollcg:AddOnValueChanged(arg_2_0._onValueChange, arg_2_0)
	arg_2_0._btnchange:AddClickListener(arg_2_0._btnchangeOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._scrollcg:RemoveOnValueChanged()
	arg_3_0._btnchange:RemoveClickListener()
end

function var_0_0._btnchangeOnClick(arg_4_0)
	HandbookController.instance:openStoryView()
end

function var_0_0._editableInitView(arg_5_0)
	arg_5_0._simagebg:LoadImage(ResUrl.getHandbookBg("full/bg_lb"))
	arg_5_0._simagelbwz4:LoadImage(ResUrl.getHandbookBg("bg_lbwz4"))
	gohelper.addUIClickAudio(arg_5_0._btnchange.gameObject, AudioEnum.UI.play_ui_screenplay_plot_switch)

	arg_5_0._selectItemList = {}
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenViewFinish, arg_6_0._onOpenViewFinish, arg_6_0)

	arg_6_0._csScroll = arg_6_0.viewContainer:getCsScroll()._csMixScroll

	arg_6_0:_refreshBtnList()

	arg_6_0._scrollcg.verticalNormalizedPosition = 1
end

function var_0_0._refreshBtnList(arg_7_0)
	for iter_7_0 = 1, 2 do
		local var_7_0 = arg_7_0._selectItemList[iter_7_0]

		if not var_7_0 then
			var_7_0 = arg_7_0:getUserDataTb_()
			var_7_0.go = gohelper.findChild(arg_7_0.viewGO, "#scroll_btnlist/viewport/content/item" .. iter_7_0)
			var_7_0.gobeselected = gohelper.findChild(var_7_0.go, "beselected")
			var_7_0.gounselected = gohelper.findChild(var_7_0.go, "unselected")
			var_7_0.chapternamecn1 = gohelper.findChildText(var_7_0.go, "beselected/chapternamecn")
			var_7_0.chapternameen1 = gohelper.findChildText(var_7_0.go, "beselected/chapternameen")
			var_7_0.chapternamecn2 = gohelper.findChildText(var_7_0.go, "unselected/chapternamecn")
			var_7_0.chapternameen2 = gohelper.findChildText(var_7_0.go, "unselected/chapternameen")
			var_7_0.btnclick = gohelper.findChildButtonWithAudio(var_7_0.go, "btnclick", AudioEnum.UI.Play_UI_Universal_Click)

			var_7_0.btnclick:AddClickListener(arg_7_0._btnclickOnClick, arg_7_0, var_7_0)
			table.insert(arg_7_0._selectItemList, var_7_0)
		end

		var_7_0.selectId = iter_7_0

		gohelper.setActive(var_7_0.go, true)
	end

	if #arg_7_0._selectItemList > 0 then
		arg_7_0:_btnclickOnClick(arg_7_0._selectItemList[1])
	else
		HandbookCGTripleListModel.instance:clearStoryList()
	end
end

function var_0_0._btnclickOnClick(arg_8_0, arg_8_1)
	arg_8_0._ischanged = true

	local var_8_0 = arg_8_1.selectId

	if arg_8_0._lastSelectId == var_8_0 then
		return
	else
		arg_8_0._lastSelectId = var_8_0
	end

	local var_8_1 = {}
	local var_8_2 = {}

	if var_8_0 == HandbookEnum.CGType.Dungeon then
		var_8_2 = HandbookConfig.instance:getDungeonCGList()
	elseif var_8_0 == HandbookEnum.CGType.Role then
		var_8_2 = HandbookConfig.instance:getRoleCGList()
	end

	var_8_1.cgList = var_8_2
	var_8_1.cgType = var_8_0

	HandbookCGTripleListModel.instance:setCGList(var_8_1)

	for iter_8_0, iter_8_1 in ipairs(arg_8_0._selectItemList) do
		gohelper.setActive(iter_8_1.gobeselected, var_8_0 == iter_8_1.selectId)
		gohelper.setActive(iter_8_1.gounselected, var_8_0 ~= iter_8_1.selectId)
	end

	local var_8_3 = arg_8_0.verticalScrollPixelList[arg_8_0._lastSelectId]

	if var_8_3 then
		arg_8_0._csScroll.VerticalScrollPixel = var_8_3
	else
		arg_8_0._scrollcg.verticalNormalizedPosition = 1
	end

	arg_8_0._ischanged = false
end

function var_0_0._onValueChange(arg_9_0)
	if arg_9_0._ischanged then
		return
	end

	arg_9_0.verticalScrollPixelList[arg_9_0._lastSelectId] = arg_9_0._csScroll.VerticalScrollPixel
end

function var_0_0._onOpenViewFinish(arg_10_0, arg_10_1)
	if arg_10_1 == ViewName.HandbookStoryView then
		ViewMgr.instance:closeView(ViewName.HandbookCGView, true)
	end
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(arg_12_0._selectItemList) do
		iter_12_1.btnclick:RemoveClickListener()
	end

	arg_12_0._simagebg:UnLoadImage()
	arg_12_0._simagelbwz4:UnLoadImage()
end

return var_0_0
