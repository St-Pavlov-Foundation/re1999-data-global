module("modules.logic.seasonver.act123.view1_9.Season123_1_9DecomposeFilterView", package.seeall)

local var_0_0 = class("Season123_1_9DecomposeFilterView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._gorare = gohelper.findChild(arg_1_0.viewGO, "container/layoutgroup/#go_rare")
	arg_1_0._gorareContainer = gohelper.findChild(arg_1_0.viewGO, "container/layoutgroup/#go_rare/#go_rareContainer")
	arg_1_0._gorareItem = gohelper.findChild(arg_1_0.viewGO, "container/layoutgroup/#go_rare/#go_rareContainer/#go_rareItem")
	arg_1_0._gotag = gohelper.findChild(arg_1_0.viewGO, "container/layoutgroup/#go_tag")
	arg_1_0._scrolltag = gohelper.findChildScrollRect(arg_1_0.viewGO, "container/layoutgroup/#go_tag/#scroll_tag")
	arg_1_0._gotagContainer = gohelper.findChild(arg_1_0.viewGO, "container/layoutgroup/#go_tag/#scroll_tag/Viewport/#go_tagContainer")
	arg_1_0._gotagItem = gohelper.findChild(arg_1_0.viewGO, "container/layoutgroup/#go_tag/#scroll_tag/Viewport/#go_tagContainer/#go_tagItem")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "container/#btn_reset")
	arg_1_0._btnconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "container/#btn_confirm")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
	arg_2_0._btnconfirm:AddClickListener(arg_2_0._btnconfirmOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnreset:RemoveClickListener()
	arg_3_0._btnconfirm:RemoveClickListener()
end

function var_0_0._btncloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btnresetOnClick(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.rareSelectTab) do
		arg_5_0.rareSelectTab[iter_5_0] = false
	end

	for iter_5_2, iter_5_3 in pairs(arg_5_0.tagSelectTab) do
		arg_5_0.tagSelectTab[iter_5_2] = false
	end

	for iter_5_4, iter_5_5 in pairs(arg_5_0.rareItemTab) do
		gohelper.setActive(iter_5_5.goSelected, false)
		gohelper.setActive(iter_5_5.goUnSelected, true)
	end

	for iter_5_6, iter_5_7 in pairs(arg_5_0.tagItemTab) do
		gohelper.setActive(iter_5_7.goSelected, false)
		gohelper.setActive(iter_5_7.goUnSelected, true)
	end
end

function var_0_0._btnconfirmOnClick(arg_6_0)
	Season123DecomposeModel.instance:setRareSelectItem(arg_6_0.rareSelectTab)
	Season123DecomposeModel.instance:setTagSelectItem(arg_6_0.tagSelectTab)
	Season123DecomposeModel.instance:clearCurSelectItem()
	Season123DecomposeModel.instance:initList()
	Season123EquipBookController.instance:dispatchEvent(Season123Event.OnResetBatchDecomposeView)
	Season123EquipBookController.instance:dispatchEvent(Season123Event.OnDecomposeItemSelect)
	arg_6_0:closeThis()
end

function var_0_0._editableInitView(arg_7_0)
	gohelper.setActive(arg_7_0._gorareItem, false)

	arg_7_0.rareItemTab = arg_7_0:getUserDataTb_()
	arg_7_0.rareSelectTab = {}
	arg_7_0.tagItemTab = arg_7_0:getUserDataTb_()
	arg_7_0.tagSelectTab = {}
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0:createRareItem()
	arg_8_0:createTagItem()
	arg_8_0:refreshUI()
end

function var_0_0.refreshUI(arg_9_0)
	arg_9_0:refreshRareSelectUI()
	arg_9_0:refreshTagSelectUI()
end

function var_0_0.refreshRareSelectUI(arg_10_0)
	arg_10_0.rareSelectTab = tabletool.copy(Season123DecomposeModel.instance.rareSelectTab)

	for iter_10_0, iter_10_1 in pairs(arg_10_0.rareItemTab) do
		gohelper.setActive(iter_10_1.goSelected, arg_10_0.rareSelectTab[iter_10_0])
		gohelper.setActive(iter_10_1.goUnSelected, not arg_10_0.rareSelectTab[iter_10_0])
	end
end

function var_0_0.refreshTagSelectUI(arg_11_0)
	arg_11_0.tagSelectTab = tabletool.copy(Season123DecomposeModel.instance.tagSelectTab)

	for iter_11_0, iter_11_1 in pairs(arg_11_0.tagItemTab) do
		local var_11_0 = iter_11_1.data.id

		gohelper.setActive(iter_11_1.goSelected, arg_11_0.tagSelectTab[var_11_0])
		gohelper.setActive(iter_11_1.goUnSelected, not arg_11_0.tagSelectTab[var_11_0])
	end
end

function var_0_0.createRareItem(arg_12_0)
	for iter_12_0 = 5, 1, -1 do
		local var_12_0 = arg_12_0.rareItemTab[iter_12_0]

		if not var_12_0 then
			var_12_0 = {
				rare = iter_12_0,
				go = gohelper.clone(arg_12_0._gorareItem, arg_12_0._gorareContainer, "rare" .. iter_12_0)
			}
			var_12_0.goSelected = gohelper.findChild(var_12_0.go, "selected")
			var_12_0.goUnSelected = gohelper.findChild(var_12_0.go, "unselected")
			var_12_0.icon = gohelper.findChildImage(var_12_0.go, "image_rareicon")
			var_12_0.txt = gohelper.findChildText(var_12_0.go, "tagText")
			var_12_0.click = gohelper.findChildButtonWithAudio(var_12_0.go, "click")
			arg_12_0.rareItemTab[iter_12_0] = var_12_0
		end

		gohelper.setActive(var_12_0.go, true)
		gohelper.setActive(var_12_0.goUnSelected, true)
		gohelper.setActive(var_12_0.goSelected, false)
		UISpriteSetMgr.instance:setSeason123Sprite(var_12_0.icon, "v1a7_season_cardcareer_" .. iter_12_0, true)
		SLFramework.UGUI.GuiHelper.SetColor(var_12_0.txt, "#C1C1C1")

		var_12_0.txt.text = luaLang("Season123Rare_" .. iter_12_0)

		var_12_0.click:AddClickListener(arg_12_0.rareItemOnClick, arg_12_0, iter_12_0)
	end
end

function var_0_0.rareItemOnClick(arg_13_0, arg_13_1)
	arg_13_0:setRareSelectState(arg_13_1)

	local var_13_0 = arg_13_0.rareSelectTab[arg_13_1]

	SLFramework.UGUI.GuiHelper.SetColor(arg_13_0.rareItemTab[arg_13_1].txt, var_13_0 and "#FF7C41" or "#C1C1C1")
	gohelper.setActive(arg_13_0.rareItemTab[arg_13_1].goSelected, var_13_0)
	gohelper.setActive(arg_13_0.rareItemTab[arg_13_1].goUnSelected, not var_13_0)
end

function var_0_0.setRareSelectState(arg_14_0, arg_14_1)
	if arg_14_0.rareSelectTab[arg_14_1] then
		arg_14_0.rareSelectTab[arg_14_1] = false
	else
		arg_14_0.rareSelectTab[arg_14_1] = true
	end
end

function var_0_0.createTagItem(arg_15_0)
	local var_15_0 = Season123DecomposeModel.instance.curActId
	local var_15_1 = Season123Config.instance:getSeasonTagDesc(var_15_0)
	local var_15_2 = arg_15_0:tagItemSort(var_15_1)

	gohelper.CreateObjList(arg_15_0, arg_15_0.tagItemShow, var_15_2, arg_15_0._gotagContainer, arg_15_0._gotagItem)
end

function var_0_0.tagItemSort(arg_16_0, arg_16_1)
	local var_16_0 = {}
	local var_16_1 = tabletool.copy(arg_16_1)

	for iter_16_0, iter_16_1 in pairs(var_16_1) do
		table.insert(var_16_0, iter_16_1)
	end

	table.sort(var_16_0, function(arg_17_0, arg_17_1)
		return arg_17_0.order < arg_17_1.order
	end)

	return var_16_0
end

function var_0_0.tagItemShow(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = {
		data = arg_18_2,
		go = arg_18_1
	}

	var_18_0.goSelected = gohelper.findChild(var_18_0.go, "selected")
	var_18_0.goUnSelected = gohelper.findChild(var_18_0.go, "unselected")
	var_18_0.tagText = gohelper.findChildText(var_18_0.go, "tagText")
	var_18_0.click = gohelper.findChildButtonWithAudio(var_18_0.go, "click")

	var_18_0.click:AddClickListener(arg_18_0.tagItemOnClick, arg_18_0, arg_18_2)
	gohelper.setActive(var_18_0.goSelected, false)
	gohelper.setActive(var_18_0.goUnSelected, true)
	SLFramework.UGUI.GuiHelper.SetColor(var_18_0.tagText, "#C1C1C1")

	var_18_0.tagText.text = arg_18_2.desc
	arg_18_0.tagItemTab[arg_18_2.id] = var_18_0
end

function var_0_0.tagItemOnClick(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1.id

	arg_19_0:setTagSelectState(var_19_0)

	local var_19_1 = arg_19_0.tagSelectTab[var_19_0]

	SLFramework.UGUI.GuiHelper.SetColor(arg_19_0.tagItemTab[var_19_0].tagText, var_19_1 and "#FF7C41" or "#C1C1C1")
	gohelper.setActive(arg_19_0.tagItemTab[var_19_0].goSelected, var_19_1)
	gohelper.setActive(arg_19_0.tagItemTab[var_19_0].goUnSelected, not var_19_1)
end

function var_0_0.setTagSelectState(arg_20_0, arg_20_1)
	if arg_20_0.tagSelectTab[arg_20_1] then
		arg_20_0.tagSelectTab[arg_20_1] = false
	else
		arg_20_0.tagSelectTab[arg_20_1] = true
	end
end

function var_0_0.onClose(arg_21_0)
	return
end

function var_0_0.onDestroyView(arg_22_0)
	for iter_22_0, iter_22_1 in pairs(arg_22_0.rareItemTab) do
		iter_22_1.click:RemoveClickListener()
	end

	for iter_22_2, iter_22_3 in pairs(arg_22_0.tagItemTab) do
		iter_22_3.click:RemoveClickListener()
	end
end

return var_0_0
