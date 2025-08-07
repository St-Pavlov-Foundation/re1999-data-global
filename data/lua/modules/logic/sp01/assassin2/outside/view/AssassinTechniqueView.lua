module("modules.logic.sp01.assassin2.outside.view.AssassinTechniqueView", package.seeall)

local var_0_0 = class("AssassinTechniqueView", BaseView)
local var_0_1 = 1
local var_0_2 = 1
local var_0_3 = 1
local var_0_4 = 0.3
local var_0_5 = 130

local function var_0_6(arg_1_0, arg_1_1)
	local var_1_0 = AssassinConfig.instance:getStealthTechniqueSubTitleId(arg_1_0)
	local var_1_1 = AssassinConfig.instance:getStealthTechniqueSubTitleId(arg_1_1)

	if var_1_0 ~= var_1_1 then
		return var_1_0 < var_1_1
	end

	return arg_1_0 < arg_1_1
end

local function var_0_7(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0[1]
	local var_2_1 = arg_2_1[1]
	local var_2_2 = AssassinConfig.instance:getStealthTechniqueMainTitleId(var_2_0)
	local var_2_3 = AssassinConfig.instance:getStealthTechniqueMainTitleId(var_2_1)

	if var_2_2 ~= var_2_3 then
		return var_2_2 < var_2_3
	end

	return var_2_0 < var_2_1
end

function var_0_0.onInitView(arg_3_0)
	arg_3_0._gocenter = gohelper.findChild(arg_3_0.viewGO, "#go_root/#go_center")
	arg_3_0._simageicon = gohelper.findChildSingleImage(arg_3_0.viewGO, "#go_root/#go_center/content/#simage_icon")
	arg_3_0._txttitle = gohelper.findChildText(arg_3_0.viewGO, "#go_root/#go_center/content/#txt_title")
	arg_3_0._txtdec = gohelper.findChildText(arg_3_0.viewGO, "#go_root/#go_center/content/#txt_dec")
	arg_3_0._btnquit = gohelper.findChildButtonWithAudio(arg_3_0.viewGO, "#go_root/#btn_quit", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	arg_3_0._goleft = gohelper.findChild(arg_3_0.viewGO, "#go_root/left")
	arg_3_0._goscroll = gohelper.findChild(arg_3_0.viewGO, "#go_root/left/scroll_category")
	arg_3_0._gocategorycontent = gohelper.findChild(arg_3_0.viewGO, "#go_root/left/scroll_category/viewport/#go_categorycontent")
	arg_3_0._gostorecategoryitem = gohelper.findChild(arg_3_0.viewGO, "#go_root/left/scroll_category/viewport/#go_categorycontent/#go_storecategoryitem")

	if arg_3_0._editableInitView then
		arg_3_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_4_0)
	arg_4_0._btnquit:AddClickListener(arg_4_0._btnquitOnClick, arg_4_0)
	arg_4_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_4_0._onOpenView, arg_4_0)
end

function var_0_0.removeEvents(arg_5_0)
	arg_5_0._btnquit:RemoveClickListener()
	arg_5_0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_5_0._onOpenView, arg_5_0)
	arg_5_0:clearTab()
end

function var_0_0._btnquitOnClick(arg_6_0)
	if arg_6_0._showTechniqueIdList and #arg_6_0._showTechniqueIdList > 0 then
		arg_6_0:_showNextTechnique()
	else
		arg_6_0:closeThis()
	end
end

function var_0_0._showNextTechnique(arg_7_0)
	local var_7_0

	if not arg_7_0.showIndex then
		arg_7_0.showIndex = var_0_1
	else
		arg_7_0.showIndex = arg_7_0.showIndex + 1
	end

	if arg_7_0._showTechniqueIdList and #arg_7_0._showTechniqueIdList > 0 then
		var_7_0 = arg_7_0._showTechniqueIdList[arg_7_0.showIndex]
	end

	if var_7_0 then
		arg_7_0:_refreshContentData(var_7_0)
	else
		arg_7_0:closeThis()
	end
end

function var_0_0._onMainTabClick(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.index
	local var_8_1 = arg_8_1.subIndex or var_0_3

	if arg_8_0.selectedMainTabIndex == var_8_0 then
		arg_8_0:killTween()

		arg_8_0._btnTweenId = ZProj.TweenHelper.DOTweenFloat(1, 0, var_0_4, arg_8_0._onBtnAniFrameCallback, arg_8_0._btnTweenCloseFinish, arg_8_0)
	else
		local var_8_2 = arg_8_0.mainTabItemList[arg_8_0.selectedMainTabIndex]

		if var_8_2 then
			recthelper.setHeight(var_8_2.trans, var_0_5)
			recthelper.setHeight(var_8_2.transSubTabContent, 0)
		end

		arg_8_0.selectedMainTabIndex = var_8_0

		arg_8_0:_detectBtnState()

		arg_8_0.selectedSubTabIndex = nil

		arg_8_0:_onSubBtnClick(var_8_1)
		arg_8_0:killTween()

		arg_8_0._btnTweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, var_0_4, arg_8_0._onBtnAniFrameCallback, arg_8_0._btnTweenOpenFinished, arg_8_0)
	end
end

function var_0_0._onBtnAniFrameCallback(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0.mainTabItemList[arg_9_0.selectedMainTabIndex]

	if var_9_0 then
		local var_9_1 = arg_9_0.subTabItemHeight[arg_9_0.selectedMainTabIndex] * arg_9_1

		recthelper.setHeight(var_9_0.trans, var_0_5 + var_9_1)
		recthelper.setHeight(var_9_0.transSubTabContent, var_9_1)
	end
end

function var_0_0._btnTweenOpenFinished(arg_10_0)
	local var_10_0 = arg_10_0.mainTabItemList[arg_10_0.selectedMainTabIndex]

	if not var_10_0 then
		return
	end

	local var_10_1 = arg_10_0._transscroll:InverseTransformPoint(var_10_0.trans.position).y + recthelper.getHeight(var_10_0.trans) / 2

	if var_10_1 >= 65 or var_10_1 <= -785 then
		recthelper.setAnchorY(arg_10_0._gocategorycontent.transform, var_0_5 * (arg_10_0.selectedMainTabIndex - 1) - 60)
	end
end

function var_0_0._btnTweenCloseFinish(arg_11_0)
	arg_11_0.selectedMainTabIndex = nil

	arg_11_0:_detectBtnState()
end

function var_0_0._detectBtnState(arg_12_0)
	if not arg_12_0.mainTabItemList then
		return
	end

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.mainTabItemList) do
		local var_12_0 = iter_12_0 == arg_12_0.selectedMainTabIndex

		gohelper.setActive(iter_12_1.goSubTabContent, var_12_0)
		gohelper.setActive(iter_12_1.goSelected, var_12_0)
		gohelper.setActive(iter_12_1.goUnselected, not var_12_0)
	end
end

function var_0_0._onSubBtnClick(arg_13_0, arg_13_1)
	if arg_13_0.selectedSubTabIndex == arg_13_1 then
		return
	end

	arg_13_0.selectedSubTabIndex = arg_13_1

	arg_13_0:_detectSubBtnState()
	arg_13_0:_refreshContentData()
end

function var_0_0._detectSubBtnState(arg_14_0)
	if arg_14_0.subTabItemDict and arg_14_0.subTabItemDict[arg_14_0.selectedMainTabIndex] then
		for iter_14_0, iter_14_1 in ipairs(arg_14_0.subTabItemDict[arg_14_0.selectedMainTabIndex]) do
			local var_14_0 = iter_14_0 == arg_14_0.selectedSubTabIndex

			gohelper.setActive(iter_14_1.goSelected, var_14_0)
			gohelper.setActive(iter_14_1.goUnselected, not var_14_0)
		end
	end
end

function var_0_0._refreshContentData(arg_15_0, arg_15_1)
	local var_15_0

	if arg_15_1 then
		var_15_0 = arg_15_1
	else
		local var_15_1 = arg_15_0.subTabItemDict[arg_15_0.selectedMainTabIndex]
		local var_15_2 = var_15_1 and var_15_1[arg_15_0.selectedSubTabIndex]

		if not var_15_2 then
			return
		end

		var_15_0 = var_15_2.data
	end

	local var_15_3 = AssassinConfig.instance:getStealthTechniqueSubTitle(var_15_0)

	arg_15_0._txttitle.text = var_15_3

	local var_15_4 = AssassinConfig.instance:getStealthTechniquePicture(var_15_0)

	arg_15_0._simageicon:LoadImage(ResUrl.getSp01AssassinSingleBg("help/" .. var_15_4), arg_15_0._afterLoadPicture, arg_15_0)

	local var_15_5 = AssassinConfig.instance:getStealthTechniqueContent(var_15_0)

	arg_15_0._txtdec.text = var_15_5
end

function var_0_0._afterLoadPicture(arg_16_0)
	arg_16_0._imageicon:SetNativeSize()
end

function var_0_0._onOpenView(arg_17_0, arg_17_1)
	if arg_17_1 == ViewName.GuideView then
		arg_17_0:closeThis()
	end
end

function var_0_0._editableInitView(arg_18_0)
	arg_18_0._transscroll = arg_18_0._goscroll.transform
	arg_18_0._imageicon = arg_18_0._simageicon:GetComponent(gohelper.Type_Image)
end

function var_0_0.onUpdateParam(arg_19_0)
	return
end

function var_0_0.onOpen(arg_20_0)
	local var_20_0 = arg_20_0.viewParam and arg_20_0.viewParam.viewParam

	arg_20_0._showTechniqueIdList = AssassinConfig.instance:getMapShowTechniqueList(var_20_0)

	if arg_20_0._showTechniqueIdList and #arg_20_0._showTechniqueIdList > 0 then
		arg_20_0:_showNextTechnique()
		gohelper.setActive(arg_20_0._goleft, false)
	else
		arg_20_0:setMainTabList()

		arg_20_0.selectedMainTabIndex = var_0_2

		local var_20_1 = arg_20_0.mainTabItemList[arg_20_0.selectedMainTabIndex]

		if var_20_1 then
			recthelper.setHeight(var_20_1.trans, var_0_5)
			recthelper.setHeight(var_20_1.transSubTabContent, 0)
		end

		arg_20_0:_detectBtnState()

		arg_20_0.selectedSubTabIndex = nil

		arg_20_0:_onSubBtnClick(var_0_3)
		arg_20_0:_btnTweenCloseFinish()
	end
end

function var_0_0.clearTab(arg_21_0)
	if arg_21_0.mainTabItemList then
		for iter_21_0, iter_21_1 in ipairs(arg_21_0.mainTabItemList) do
			iter_21_1.btnClick:RemoveClickListener()
		end
	end

	arg_21_0.mainTabItemList = {}

	if arg_21_0.subTabItemDict then
		for iter_21_2, iter_21_3 in pairs(arg_21_0.subTabItemDict) do
			for iter_21_4, iter_21_5 in ipairs(iter_21_3) do
				iter_21_5.btnClick:RemoveClickListener()
			end
		end
	end

	arg_21_0.subTabItemDict = {}
	arg_21_0.subTabItemHeight = {}
end

function var_0_0.setMainTabList(arg_22_0)
	arg_22_0:clearTab()

	local var_22_0 = {}
	local var_22_1 = {}
	local var_22_2 = AssassinConfig.instance:getTechniqueIdList()

	for iter_22_0, iter_22_1 in ipairs(var_22_2) do
		local var_22_3 = AssassinConfig.instance:getStealthTechniqueMainTitleId(iter_22_1)

		if var_22_3 ~= 0 then
			if not var_22_1[var_22_3] then
				var_22_1[var_22_3] = {}
			end

			table.insert(var_22_1[var_22_3], iter_22_1)
		end
	end

	for iter_22_2, iter_22_3 in pairs(var_22_1) do
		if #var_22_1[iter_22_2] > 0 then
			table.sort(var_22_1[iter_22_2], var_0_6)
			table.insert(var_22_0, var_22_1[iter_22_2])
		end
	end

	table.sort(var_22_0, var_0_7)
	gohelper.CreateObjList(arg_22_0, arg_22_0._onMainTabShow, var_22_0, arg_22_0._gocategorycontent, arg_22_0._gostorecategoryitem)
end

function var_0_0._onMainTabShow(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = arg_23_0:getUserDataTb_()

	var_23_0.go = arg_23_1
	var_23_0.trans = var_23_0.go.transform
	var_23_0.data = arg_23_2
	var_23_0.goSelected = gohelper.findChild(arg_23_1, "go_selected")
	var_23_0.goUnselected = gohelper.findChild(arg_23_1, "go_unselected")
	var_23_0.goSubTabContent = gohelper.findChild(arg_23_1, "go_childcategory")
	var_23_0.transSubTabContent = var_23_0.goSubTabContent.transform
	var_23_0.btnClick = gohelper.findChildClickWithAudio(var_23_0.go, "clickArea", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)

	var_23_0.btnClick:AddClickListener(arg_23_0._onMainTabClick, arg_23_0, {
		index = arg_23_3
	})

	local var_23_1 = AssassinConfig.instance:getStealthTechniqueMainTitle(arg_23_2[1])
	local var_23_2 = gohelper.findChildTextMesh(arg_23_1, "go_unselected/txt_itemcn1")
	local var_23_3 = gohelper.findChildTextMesh(arg_23_1, "go_selected/txt_itemcn2")

	var_23_2.text = var_23_1
	var_23_3.text = var_23_1
	arg_23_0.subTabPosY = -60
	arg_23_0.subBelongMainTabIndex = arg_23_3

	local var_23_4 = gohelper.findChild(arg_23_1, "go_childcategory/go_childitem")

	gohelper.CreateObjList(arg_23_0, arg_23_0._onSubTabShow, arg_23_2, var_23_0.goSubTabContent, var_23_4)

	arg_23_0.subTabItemHeight[arg_23_3] = math.abs(arg_23_0.subTabPosY + 70)

	table.insert(arg_23_0.mainTabItemList, var_23_0)
end

function var_0_0._onSubTabShow(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = arg_24_0:getUserDataTb_()

	var_24_0.go = arg_24_1
	var_24_0.data = arg_24_2
	var_24_0.goSelected = gohelper.findChild(arg_24_1, "go_selected")
	var_24_0.goUnselected = gohelper.findChild(arg_24_1, "go_unselected")
	var_24_0.btnClick = gohelper.findChildClickWithAudio(var_24_0.go, "clickArea", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)

	var_24_0.btnClick:AddClickListener(arg_24_0._onSubBtnClick, arg_24_0, arg_24_3)

	local var_24_1 = AssassinConfig.instance:getStealthTechniqueSubTitle(arg_24_2)
	local var_24_2 = gohelper.findChildTextMesh(arg_24_1, "go_unselected/txt_itemcn1")
	local var_24_3 = gohelper.findChildTextMesh(arg_24_1, "go_selected/txt_itemcn2")

	var_24_2.text = var_24_1
	var_24_3.text = var_24_1

	recthelper.setAnchorY(arg_24_1.transform, arg_24_0.subTabPosY)

	arg_24_0.subTabPosY = arg_24_0.subTabPosY - 120

	local var_24_4 = arg_24_0.subTabItemDict[arg_24_0.subBelongMainTabIndex]

	if not var_24_4 then
		var_24_4 = {}
		arg_24_0.subTabItemDict[arg_24_0.subBelongMainTabIndex] = var_24_4
	end

	table.insert(var_24_4, var_24_0)
end

function var_0_0.killTween(arg_25_0)
	if arg_25_0._btnTweenId then
		ZProj.TweenHelper.KillById(arg_25_0._btnTweenId)
	end

	arg_25_0._btnTweenId = nil
end

function var_0_0.onClose(arg_26_0)
	arg_26_0:killTween()
end

function var_0_0.onDestroyView(arg_27_0)
	arg_27_0._simageicon:UnLoadImage()
end

return var_0_0
