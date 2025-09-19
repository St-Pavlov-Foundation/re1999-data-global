module("modules.logic.survival.view.shelter.SurvivalHardView", package.seeall)

local var_0_0 = class("SurvivalHardView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.btnnext = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/Right/#btn_Next")
	arg_1_0.btnleft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Left")
	arg_1_0.btnright = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Right")
	arg_1_0.goFrame1 = gohelper.findChild(arg_1_0.viewGO, "#simage_Frame1")
	arg_1_0.goFrame2 = gohelper.findChild(arg_1_0.viewGO, "#simage_Frame2")
	arg_1_0.goFrame3 = gohelper.findChild(arg_1_0.viewGO, "#simage_Frame3")
	arg_1_0.txtDifficulty = gohelper.findChildTextMesh(arg_1_0.viewGO, "Panel/Left/image_DifficultyBG/txt_Difficulty")
	arg_1_0.txtDesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "Panel/Left/#txt_Desc")
	arg_1_0.simageLevelPic = gohelper.findChildSingleImage(arg_1_0.viewGO, "Panel/Left/#simage_LevelPic")
	arg_1_0.goItemPanel = gohelper.findChild(arg_1_0.viewGO, "Panel/Left/#go_ItemPanel")
	arg_1_0.selectPanelCanvasGroup = gohelper.onceAddComponent(arg_1_0.goItemPanel, typeof(UnityEngine.CanvasGroup))
	arg_1_0.btnEmpty = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/Right/#go_Empty")
	arg_1_0.goScroll = gohelper.findChild(arg_1_0.viewGO, "Panel/Right/#scroll_List")
	arg_1_0.goDifficultyAssess = gohelper.findChild(arg_1_0.viewGO, "Panel/Right/image_DifficultyAssessBG")
	arg_1_0.txtDifficultyAssess = gohelper.findChildTextMesh(arg_1_0.viewGO, "Panel/Right/image_DifficultyAssessBG/txt_DifficultyAssess")
	arg_1_0.tabItems = {}

	for iter_1_0 = 1, 3 do
		arg_1_0:createTab(iter_1_0)
	end

	arg_1_0.lineItems = {}
	arg_1_0.goHardItem = gohelper.findChild(arg_1_0.viewGO, "Panel/Left/#go_ItemPanel/#scroll_List/Viewport/Content/#go_SmallItem")
	arg_1_0.goLineItem = gohelper.findChild(arg_1_0.viewGO, "Panel/Left/#go_ItemPanel/#scroll_List/Viewport/Content/#go_Item")
	arg_1_0.animator = arg_1_0.viewGO:GetComponent(gohelper.Type_Animator)

	arg_1_0:setPanelVisible(false)
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnnext, arg_2_0.onClickNext, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnleft, arg_2_0.onClickLeft, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnright, arg_2_0.onClickRight, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnEmpty, arg_2_0.onClickEmpty, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0.btnnext)
	arg_3_0:removeClickCb(arg_3_0.btnleft)
	arg_3_0:removeClickCb(arg_3_0.btnright)
	arg_3_0:removeClickCb(arg_3_0.btnEmpty)
end

function var_0_0.onClickNext(arg_4_0)
	SurvivalDifficultyModel.instance:sendDifficultyChoose()
end

function var_0_0.onClickLeft(arg_5_0)
	local var_5_0 = SurvivalDifficultyModel.instance:changeDifficultyIndex(-1)

	arg_5_0:playAnim(var_5_0)
	UIBlockHelper.instance:startBlock(arg_5_0.viewName, 0.167, arg_5_0.viewName)
	TaskDispatcher.runDelay(arg_5_0.refreshView, arg_5_0, 0.167)
end

function var_0_0.onClickRight(arg_6_0)
	local var_6_0 = SurvivalDifficultyModel.instance:changeDifficultyIndex(1)

	arg_6_0:playAnim(var_6_0)
	UIBlockHelper.instance:startBlock(arg_6_0.viewName, 0.167, arg_6_0.viewName)
	TaskDispatcher.runDelay(arg_6_0.refreshView, arg_6_0, 0.167)
end

function var_0_0.onClickEmpty(arg_7_0)
	arg_7_0.inSelectCustom = true

	arg_7_0:refreshView()
end

function var_0_0.onClickTab(arg_8_0, arg_8_1)
	if not SurvivalDifficultyModel.instance:setCustomSelectIndex(arg_8_1) then
		return
	end

	local var_8_0 = "switch_buff"

	arg_8_0:playAnim(var_8_0)
	UIBlockHelper.instance:startBlock(arg_8_0.viewName, 0.167, arg_8_0.viewName)
	TaskDispatcher.runDelay(arg_8_0.refreshView, arg_8_0, 0.167)
end

function var_0_0.onClickGrid(arg_9_0, arg_9_1)
	if not arg_9_1.config.id then
		return
	end

	local var_9_0 = SurvivalModel.instance:getOutSideInfo()

	if not (var_9_0 and var_9_0:isUnlockDifficulty(arg_9_1.config.id) or false) then
		if string.nilorempty(arg_9_1.config.lockDesc) then
			GameFacade.showToast(ToastEnum.SeasonEquipUnlock)
		else
			GameFacade.showToastString(arg_9_1.config.lockDesc)
		end

		return
	end

	if SurvivalDifficultyModel.instance:selectCustomDifficulty(arg_9_1.config.id) then
		arg_9_0:refreshNextBtn()
		arg_9_0:refreshTab()
		arg_9_0:refreshLine(arg_9_1.line, arg_9_1.line.data)
		arg_9_0:refreshDifficultyList()
		arg_9_0:refreshAssess()
	end
end

function var_0_0.createTab(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0:getUserDataTb_()

	var_10_0.index = arg_10_1
	var_10_0.go = gohelper.findChild(arg_10_0.viewGO, string.format("Panel/Left/#go_ItemPanel/Tab/#go_Tab%s", arg_10_1))
	var_10_0.goSelect = gohelper.findChild(var_10_0.go, "#go_TabSelected")
	var_10_0.goUnSelect = gohelper.findChild(var_10_0.go, "#go_TabUnSelected")
	var_10_0.txtSelectNum = gohelper.findChildTextMesh(var_10_0.goSelect, "#txt_Num")
	var_10_0.txtUnSelectNum = gohelper.findChildTextMesh(var_10_0.goUnSelect, "#txt_Num")
	var_10_0.btn = gohelper.findButtonWithAudio(var_10_0.go)

	var_10_0.btn:AddClickListener(arg_10_0.onClickTab, arg_10_0, arg_10_1)

	arg_10_0.tabItems[arg_10_1] = var_10_0
end

function var_0_0.onOpen(arg_11_0)
	SurvivalDifficultyModel.instance:refreshDifficulty()
	arg_11_0:refreshView()
end

function var_0_0.refreshView(arg_12_0)
	if SurvivalDifficultyModel.instance:isCustomDifficulty() then
		arg_12_0:refreshCustomView()
	else
		arg_12_0:refreshNormalView()
	end
end

function var_0_0.refreshCustomView(arg_13_0)
	local var_13_0 = SurvivalDifficultyModel.instance:getDifficultyId()

	arg_13_0.simageLevelPic:LoadImage("singlebg/survival_singlebg/difficulty/survivalselectdifficulty_levelpic_01.png")
	arg_13_0:refreshCustomPanel()
	arg_13_0:refreshPanel(var_13_0)
end

function var_0_0.refreshCustomPanel(arg_14_0)
	local var_14_0 = SurvivalDifficultyModel.instance:getDifficultyShowList()
	local var_14_1 = next(var_14_0) == nil and not arg_14_0.inSelectCustom

	arg_14_0:setPanelVisible(not var_14_1)
	gohelper.setActive(arg_14_0.btnEmpty, var_14_1)
	gohelper.setActive(arg_14_0.goScroll, not var_14_1)
	arg_14_0:refreshNextBtn()

	if not var_14_1 then
		arg_14_0:refreshTab()
		arg_14_0:refreshGridList()
		arg_14_0:refreshDifficultyList()
	end
end

function var_0_0.refreshNextBtn(arg_15_0)
	if not SurvivalDifficultyModel.instance:isCustomDifficulty() then
		ZProj.UGUIHelper.SetGrayscale(arg_15_0.btnnext.gameObject, false)

		return
	end

	local var_15_0 = SurvivalDifficultyModel.instance:getDifficultyShowList()
	local var_15_1 = next(var_15_0) == nil

	ZProj.UGUIHelper.SetGrayscale(arg_15_0.btnnext.gameObject, var_15_1)
end

function var_0_0.refreshNormalView(arg_16_0)
	local var_16_0 = SurvivalDifficultyModel.instance:getDifficultyId()

	arg_16_0.simageLevelPic:LoadImage(string.format("singlebg/survival_singlebg/difficulty/survivalselectdifficulty_levelpic_0%s.png", var_16_0))
	arg_16_0:setPanelVisible(false)
	gohelper.setActive(arg_16_0.btnEmpty, false)
	gohelper.setActive(arg_16_0.goScroll, true)
	arg_16_0:refreshNextBtn()
	arg_16_0:refreshDifficultyList()
	arg_16_0:refreshPanel(var_16_0)
end

function var_0_0.refreshPanel(arg_17_0, arg_17_1)
	local var_17_0 = lua_survival_hardness_mod.configDict[arg_17_1]

	arg_17_0.txtDifficulty.text = var_17_0.name
	arg_17_0.txtDesc.text = var_17_0.desc

	arg_17_0:refreshFrame(arg_17_1)
	arg_17_0:refreshAssess()

	local var_17_1, var_17_2 = SurvivalDifficultyModel.instance:getArrowStatus()

	gohelper.setActive(arg_17_0.btnleft, var_17_1)
	gohelper.setActive(arg_17_0.btnright, var_17_2)
end

function var_0_0.refreshFrame(arg_18_0, arg_18_1)
	gohelper.setActive(arg_18_0.goFrame1, arg_18_1 == 2)
	gohelper.setActive(arg_18_0.goFrame2, arg_18_1 == 3)
	gohelper.setActive(arg_18_0.goFrame3, arg_18_1 == 4)
end

function var_0_0.refreshAssess(arg_19_0)
	local var_19_0 = SurvivalDifficultyModel.instance:getDifficultyAssess()

	arg_19_0.txtDifficultyAssess.text = formatLuaLang("survivalselectdifficultyview_txt_assess", var_19_0)
end

function var_0_0.refreshDifficultyList(arg_20_0)
	SurvivalDifficultyModel.instance:refreshDifficultyShowList()
end

function var_0_0.refreshTab(arg_21_0)
	local var_21_0 = SurvivalDifficultyModel.instance:getCustomSelectIndex()

	for iter_21_0, iter_21_1 in ipairs(arg_21_0.tabItems) do
		local var_21_1 = var_21_0 == iter_21_0

		gohelper.setActive(iter_21_1.goSelect, var_21_1)
		gohelper.setActive(iter_21_1.goUnSelect, not var_21_1)

		local var_21_2 = SurvivalDifficultyModel.instance:getCustomDifficultyAssess(iter_21_0)

		iter_21_1.txtSelectNum.text = var_21_2
		iter_21_1.txtUnSelectNum.text = var_21_2
	end
end

function var_0_0.refreshGridList(arg_22_0)
	local var_22_0 = SurvivalDifficultyModel.instance:getCustomSelectIndex()
	local var_22_1 = SurvivalDifficultyModel.instance.customDifficultyList[var_22_0]
	local var_22_2 = {}

	for iter_22_0, iter_22_1 in pairs(var_22_1) do
		table.insert(var_22_2, {
			subtype = iter_22_0,
			list = iter_22_1
		})
	end

	table.sort(var_22_2, SortUtil.keyLower("subtype"))

	for iter_22_2 = 1, math.max(#arg_22_0.lineItems, #var_22_2) do
		local var_22_3 = arg_22_0.lineItems[iter_22_2]

		if not var_22_3 then
			var_22_3 = arg_22_0:getUserDataTb_()
			var_22_3.index = iter_22_2
			var_22_3.go = gohelper.cloneInPlace(arg_22_0.goLineItem, tostring(iter_22_2))
			var_22_3.goEvent = gohelper.findChild(var_22_3.go, "#go_EvenBG")
			var_22_3.goGrid = gohelper.findChild(var_22_3.go, "Grid")
			var_22_3.items = arg_22_0:getUserDataTb_()
			arg_22_0.lineItems[iter_22_2] = var_22_3
		end

		arg_22_0:refreshLine(var_22_3, var_22_2[iter_22_2])
	end
end

function var_0_0.refreshLine(arg_23_0, arg_23_1, arg_23_2)
	arg_23_1.data = arg_23_2

	if not arg_23_2 then
		gohelper.setActive(arg_23_1.go, false)

		return
	end

	gohelper.setActive(arg_23_1.go, true)

	local var_23_0 = arg_23_2.list

	gohelper.setActive(arg_23_1.goEvent, arg_23_1.index % 2 == 0)

	for iter_23_0 = 1, math.max(#arg_23_1.items, #var_23_0) do
		if not arg_23_1.items[iter_23_0] then
			local var_23_1 = arg_23_0:getUserDataTb_()

			var_23_1.go = gohelper.clone(arg_23_0.goHardItem, arg_23_1.goGrid, tostring(iter_23_0))
			var_23_1.imageQuality = gohelper.findChildImage(var_23_1.go, "#image_Quality")
			var_23_1.goQuality = var_23_1.imageQuality.gameObject
			var_23_1.goSelected = gohelper.findChild(var_23_1.go, "#go_Selected")
			var_23_1.goIcon = gohelper.findChild(var_23_1.go, "image_Icon")
			var_23_1.simageIcon = gohelper.findChildSingleImage(var_23_1.go, "image_Icon")
			var_23_1.btn = gohelper.findButtonWithAudio(var_23_1.go)

			var_23_1.btn:AddClickListener(arg_23_0.onClickGrid, arg_23_0, var_23_1)

			var_23_1.line = arg_23_1
			arg_23_1.items[iter_23_0] = var_23_1
		end

		arg_23_0:refreshGridItem(arg_23_1.items[iter_23_0], var_23_0[iter_23_0])
	end
end

function var_0_0.refreshGridItem(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = SurvivalModel.instance:getOutSideInfo()

	arg_24_1.config = arg_24_2

	local var_24_1 = arg_24_2.id == nil

	gohelper.setActive(arg_24_1.go, true)

	if var_24_1 then
		gohelper.setActive(arg_24_1.goIcon, false)
		UISpriteSetMgr.instance:setSurvivalSprite(arg_24_1.imageQuality, "survivalselectdifficulty_item_empty")
		gohelper.setActive(arg_24_1.goSelected, false)

		return
	end

	gohelper.setActive(arg_24_1.goIcon, true)

	local var_24_2 = var_24_0 and var_24_0:isUnlockDifficulty(arg_24_2.id) or false

	UISpriteSetMgr.instance:setSurvivalSprite(arg_24_1.imageQuality, string.format("survivalselectdifficulty_item_quality_%s", arg_24_2.level))

	local var_24_3 = string.format("singlebg/survival_singlebg/difficulty/difficulticon/%s.png", arg_24_2.icon)

	arg_24_1.simageIcon:LoadImage(var_24_3)
	ZProj.UGUIHelper.SetGrayscale(arg_24_1.goIcon, not var_24_2)
	ZProj.UGUIHelper.SetGrayscale(arg_24_1.goQuality, not var_24_2)

	local var_24_4 = SurvivalDifficultyModel.instance:isSelectCustomDifficulty(arg_24_2.id)

	gohelper.setActive(arg_24_1.goSelected, var_24_2 and var_24_4)
end

function var_0_0.playAnim(arg_25_0, arg_25_1)
	if not arg_25_1 then
		return
	end

	arg_25_0.animator:Play(arg_25_1, 0, 0)
end

function var_0_0.setPanelVisible(arg_26_0, arg_26_1)
	if arg_26_0.isPanelVisible == arg_26_1 then
		return
	end

	arg_26_0.isPanelVisible = arg_26_1

	gohelper.setActive(arg_26_0.goItemPanel, arg_26_1)
end

function var_0_0.onClose(arg_27_0)
	arg_27_0.simageLevelPic:UnLoadImage()

	for iter_27_0, iter_27_1 in ipairs(arg_27_0.tabItems) do
		iter_27_1.btn:RemoveClickListener()
	end

	for iter_27_2, iter_27_3 in ipairs(arg_27_0.lineItems) do
		for iter_27_4, iter_27_5 in ipairs(iter_27_3.items) do
			iter_27_5.btn:RemoveClickListener()
			iter_27_5.simageIcon:UnLoadImage()
		end
	end

	TaskDispatcher.cancelTask(arg_27_0.refreshView, arg_27_0)
end

return var_0_0
