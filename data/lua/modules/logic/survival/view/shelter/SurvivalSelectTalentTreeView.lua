module("modules.logic.survival.view.shelter.SurvivalSelectTalentTreeView", package.seeall)

local var_0_0 = class("SurvivalSelectTalentTreeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._simageMask = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_Mask")
	arg_1_0._simagePanelBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "Panel/#simage_PanelBG")
	arg_1_0._simagePanelBG2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "Panel/#simage_PanelBG2")
	arg_1_0._goallClick = gohelper.findChild(arg_1_0.viewGO, "#go_allClick")
	arg_1_0._scrollcontentlist = gohelper.findChildScrollRect(arg_1_0.viewGO, "#scroll_contentlist")
	arg_1_0._godec = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_dec")
	arg_1_0._txtdec = gohelper.findChildText(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_dec/#txt_dec")
	arg_1_0._gomain = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_main")
	arg_1_0._txtmain = gohelper.findChildText(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_main/#txt_main")
	arg_1_0._gomainitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_main/#go_mainitem")
	arg_1_0._txttask = gohelper.findChildText(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_main/#go_mainitem/#txt_task")
	arg_1_0._gosub = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_sub")
	arg_1_0._txtsub = gohelper.findChildText(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_sub/#txt_sub")
	arg_1_0._gosubitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_sub/#go_subitem")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_sub/#go_subitem/#txt_num")
	arg_1_0._gocollection = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_collection")
	arg_1_0._txtcollection = gohelper.findChildText(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_collection/#txt_collection")
	arg_1_0._gocollectionitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_collection/layout/#go_collectionitem")
	arg_1_0._txtchoice = gohelper.findChildText(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_collection/layout/#go_collectionitem/#txt_choice")
	arg_1_0._btncheck = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_collection/layout/#go_collectionitem/#btn_check")
	arg_1_0._txtbase = gohelper.findChildText(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_collection/#txt_base")
	arg_1_0._btnenter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_enter")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncheck:AddClickListener(arg_2_0._btncheckOnClick, arg_2_0)
	arg_2_0._btnenter:AddClickListener(arg_2_0._btnenterOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncheck:RemoveClickListener()
	arg_3_0._btnenter:RemoveClickListener()
end

function var_0_0._btnselectOnClick(arg_4_0)
	return
end

local var_0_1 = {
	0.5,
	0.5,
	0.5
}
local var_0_2 = 3
local var_0_3 = 2
local var_0_4 = 3
local var_0_5 = ZProj.TweenHelper

function var_0_0._btncheckOnClick(arg_5_0)
	return
end

function var_0_0._btnenterOnClick(arg_6_0)
	if arg_6_0._isFirstPlayer then
		SurvivalController.instance:startNewWeek()
		SurvivalController.instance:enterSurvivalShelterScene()

		return
	end

	if arg_6_0.selectHard == nil then
		return
	end

	SurvivalWeekRpc.instance:sendSurvivalStartWeekChooseTalent(arg_6_0.selectHard, arg_6_0._onEnterShelter, arg_6_0)
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._allClick = gohelper.findChildClickWithAudio(arg_7_0.viewGO, "#go_allClick")

	arg_7_0._allClick:AddClickListener(arg_7_0.enterNext, arg_7_0)

	arg_7_0._canvasGroupDec = arg_7_0._godec:GetComponent(gohelper.Type_CanvasGroup)
	arg_7_0._canvasGroupCollection = arg_7_0._gocollection:GetComponent(gohelper.Type_CanvasGroup)
	arg_7_0._canvasGroupSub = arg_7_0._gosub:GetComponent(gohelper.Type_CanvasGroup)
	arg_7_0._canvasGroupMainTask = arg_7_0._gomain:GetComponent(gohelper.Type_CanvasGroup)
	arg_7_0._contentRect = gohelper.findChild(arg_7_0.viewGO, "#scroll_contentlist/viewport/content").transform:GetComponent(gohelper.Type_RectTransform)

	local var_7_0 = arg_7_0._scrollcontentlist.transform:GetComponent(gohelper.Type_RectTransform)

	arg_7_0._scrollHeight = recthelper.getHeight(var_7_0)
	arg_7_0._allShowGO = arg_7_0:getUserDataTb_()

	table.insert(arg_7_0._allShowGO, arg_7_0._godec)
	table.insert(arg_7_0._allShowGO, arg_7_0._gomain)
	table.insert(arg_7_0._allShowGO, arg_7_0._gocollection)

	arg_7_0._allShowGroup = arg_7_0:getUserDataTb_()

	table.insert(arg_7_0._allShowGroup, arg_7_0._canvasGroupDec)
	table.insert(arg_7_0._allShowGroup, arg_7_0._canvasGroupMainTask)
	table.insert(arg_7_0._allShowGroup, arg_7_0._canvasGroupCollection)

	arg_7_0._allShowAnim = arg_7_0:getUserDataTb_()
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0._isFirstPlayer = arg_8_0.viewParam.isFirstPlayer

	if arg_8_0._isFirstPlayer then
		var_0_2 = var_0_3
	else
		var_0_2 = var_0_4
	end

	arg_8_0._progress = 1

	arg_8_0:_initView()
	arg_8_0:_refreshCurProgress()
end

function var_0_0._initView(arg_9_0)
	recthelper.setAnchorY(arg_9_0._contentRect, 0)

	arg_9_0._canvasGroupDec.alpha = 0

	arg_9_0:_initTaskView()

	if not arg_9_0._isFirstPlayer then
		arg_9_0:_initTalentTree()
	end

	gohelper.setActive(arg_9_0._gosub, false)
	gohelper.setActive(arg_9_0._gocollection, not arg_9_0._isFirstPlayer)
	gohelper.setActive(arg_9_0._btnenter.gameObject, false)
end

function var_0_0._initTaskView(arg_10_0)
	arg_10_0:_initTaskItem(SurvivalEnum.TaskModule.MainTask)

	arg_10_0._canvasGroupMainTask.alpha = 0
end

function var_0_0._initTaskItem(arg_11_0, arg_11_1)
	local var_11_0 = SurvivalTaskModel.instance:getTaskList(arg_11_1)

	if arg_11_0._mainTaskItem == nil then
		arg_11_0._mainTaskItem = arg_11_0:getUserDataTb_()
	end

	if arg_11_0._subTaskItem == nil then
		arg_11_0._subTaskItem = arg_11_0:getUserDataTb_()
	end

	local var_11_1 = 1

	for iter_11_0, iter_11_1 in pairs(var_11_0) do
		local var_11_2 = arg_11_0._mainTaskItem[iter_11_0]

		if arg_11_1 == SurvivalEnum.TaskModule.SubTask then
			var_11_2 = arg_11_0._subTaskItem[iter_11_0]
		end

		if var_11_2 == nil then
			local var_11_3

			if arg_11_1 == SurvivalEnum.TaskModule.MainTask then
				var_11_3 = gohelper.cloneInPlace(arg_11_0._gomainitem, iter_11_1.id)
			end

			if arg_11_1 == SurvivalEnum.TaskModule.SubTask then
				var_11_3 = gohelper.cloneInPlace(arg_11_0._gosubitem, iter_11_1.id)
			end

			var_11_2 = arg_11_0:getUserDataTb_()
			var_11_2.go = var_11_3
			var_11_2.animation = var_11_3:GetComponent(gohelper.Type_Animation)
			var_11_2.txtTask = gohelper.findChildText(var_11_2.go, "#txt_task")
			var_11_2.bg = gohelper.findChild(var_11_2.go, "bg")

			if arg_11_1 == SurvivalEnum.TaskModule.SubTask then
				var_11_2.numTxt = gohelper.findChildText(var_11_2.go, "#txt_num")
				var_11_2.numTxt.text = var_11_1
			end

			gohelper.setActive(var_11_2.go, true)

			if arg_11_1 == SurvivalEnum.TaskModule.MainTask then
				arg_11_0._mainTaskItem[iter_11_0] = var_11_2
			end

			if arg_11_1 == SurvivalEnum.TaskModule.SubTask then
				arg_11_0._subTaskItem[iter_11_0] = var_11_2
			end
		end

		if iter_11_1.co ~= nil then
			var_11_2.txtTask.text = iter_11_1:getDesc()
		end

		gohelper.setActive(var_11_2.bg, var_11_1 == 1)

		var_11_1 = var_11_1 + 1
	end
end

function var_0_0._initTalentTree(arg_12_0)
	local var_12_0 = SurvivalConfig.instance:getAllTalentGroupCos()

	if arg_12_0._talentItems == nil then
		arg_12_0._talentItems = arg_12_0:getUserDataTb_()
	end

	for iter_12_0 = 1, #var_12_0 do
		local var_12_1 = var_12_0[iter_12_0]

		if var_12_1.choose == 1 and arg_12_0._talentItems[var_12_1.id] == nil then
			local var_12_2 = gohelper.cloneInPlace(arg_12_0._gocollectionitem, var_12_1.id)
			local var_12_3 = arg_12_0:getUserDataTb_()

			var_12_3.talentId = var_12_1.id
			var_12_3.go = var_12_2
			var_12_3.animation = var_12_2:GetComponent(gohelper.Type_Animation)
			var_12_3.sImage = gohelper.findChildSingleImage(var_12_2, "collection")

			var_12_3.sImage:LoadImage(ResUrl.getSurvivalTalentIcon(var_12_1.icon))

			var_12_3.goSelect = gohelper.findChildClickWithAudio(var_12_2, "go_select")
			var_12_3.txtChoice = gohelper.findChildText(var_12_2, "#txt_choice")
			var_12_3.txtNum = gohelper.findChildText(var_12_2, "#txt_num")
			var_12_3.click = gohelper.findChildClickWithAudio(var_12_2, "go_click")
			var_12_3.btnCheck = gohelper.findChildButtonWithAudio(var_12_2, "#btn_check")

			var_12_3.click:AddClickListener(arg_12_0.refreshSelect, arg_12_0, var_12_3.talentId)
			var_12_3.btnCheck:AddClickListener(function()
				ViewMgr.instance:openView(ViewName.SurvivalTalentOverView, {
					talentCo = var_12_1
				})
			end, nil)

			local var_12_4 = ""
			local var_12_5 = SurvivalModel.instance:getOutSideInfo()

			if var_12_5 then
				local var_12_6 = var_12_5.talentBox:getTalentGroup(var_12_1.id)
				local var_12_7 = #var_12_6:getEquipTalents()
				local var_12_8 = var_12_6:getTalentCos()
				local var_12_9 = tabletool.len(var_12_8)

				var_12_4 = var_12_7 .. "/" .. var_12_9
			end

			var_12_3.txtChoice.text = var_12_1.name
			var_12_3.txtNum.text = var_12_4

			gohelper.setActive(var_12_3.goSelect, false)
			gohelper.setActive(var_12_3.go, true)

			arg_12_0._talentItems[var_12_1.id] = var_12_3
		end
	end

	arg_12_0:refreshSelect()

	arg_12_0._canvasGroupCollection.alpha = 0
end

function var_0_0.refreshSelect(arg_14_0, arg_14_1)
	local var_14_0

	if arg_14_1 ~= nil then
		local var_14_1 = lua_survival_talent_group.configDict[arg_14_1]

		arg_14_0._txtbase.text = var_14_1.desc
		var_14_0 = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("survivalceremonyopeningview_txt_1"), var_14_1.name)

		AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_binansuo_draw)
	else
		var_14_0 = luaLang("survivalceremonyopeningview_txt_2")
	end

	if var_14_0 then
		arg_14_0._txtcollection.text = var_14_0
	end

	if arg_14_0._talentItems then
		for iter_14_0, iter_14_1 in pairs(arg_14_0._talentItems) do
			if iter_14_1.goSelect then
				gohelper.setActive(iter_14_1.goSelect, iter_14_0 == arg_14_1)
			end
		end
	end

	if arg_14_0.selectHard == nil and arg_14_1 ~= nil then
		local var_14_2 = arg_14_0._gocollection.transform:GetComponent(gohelper.Type_RectTransform)
		local var_14_3 = recthelper.getHeight(var_14_2)

		arg_14_0._allContentY[#arg_14_0._allContentY] = var_14_3 + 30 + 17

		local var_14_4 = arg_14_0:getContentY()

		arg_14_0._tweenId = var_0_5.DOAnchorPosY(arg_14_0._contentRect, var_14_4, 0.1)
	end

	arg_14_0.selectHard = arg_14_1

	gohelper.setActive(arg_14_0._btnenter.gameObject, arg_14_0.selectHard ~= nil)
	gohelper.setActive(arg_14_0._txtbase.gameObject, arg_14_0.selectHard ~= nil)
end

function var_0_0.enterNext(arg_15_0)
	if not arg_15_0._canEnterNext then
		return
	end

	if arg_15_0._progress == var_0_2 then
		return
	end

	arg_15_0._progress = arg_15_0._progress + 1

	arg_15_0:_refreshCurProgress()
end

function var_0_0.getContentY(arg_16_0)
	if arg_16_0._allContentY == nil or #arg_16_0._allContentY <= 0 then
		arg_16_0._allContentY = {}

		for iter_16_0 = 1, var_0_2 do
			local var_16_0 = arg_16_0._allShowGO[iter_16_0].transform

			ZProj.UGUIHelper.RebuildLayout(var_16_0)

			local var_16_1 = var_16_0:GetComponent(gohelper.Type_RectTransform)
			local var_16_2 = recthelper.getHeight(var_16_1)

			if var_16_2 ~= 0 then
				table.insert(arg_16_0._allContentY, var_16_2 + 30)
			end
		end
	end

	local var_16_3 = 0
	local var_16_4 = math.min(arg_16_0._progress, #arg_16_0._allContentY)

	for iter_16_1 = 1, var_16_4 do
		var_16_3 = var_16_3 + arg_16_0._allContentY[iter_16_1]
	end

	return var_16_3 - arg_16_0._scrollHeight
end

function var_0_0._refreshCurProgress(arg_17_0)
	arg_17_0._canEnterNext = false

	local var_17_0 = arg_17_0._allShowGO[arg_17_0._progress]
	local var_17_1 = var_0_1[arg_17_0._progress]
	local var_17_2 = arg_17_0:getContentY()

	if var_17_2 > 0 then
		arg_17_0._moveTweenId = var_0_5.DOAnchorPosY(arg_17_0._contentRect, var_17_2, var_17_1)
	end

	if var_17_0 ~= nil then
		arg_17_0._tweenId = var_0_5.DOFadeCanvasGroup(var_17_0, 0, 1, var_17_1, arg_17_0._progressFinish, arg_17_0)
	end

	local var_17_3 = var_17_0.name

	if var_17_3 == "#go_main" then
		for iter_17_0, iter_17_1 in ipairs(arg_17_0._mainTaskItem) do
			if iter_17_1.animation then
				iter_17_1.animation:Play()
			end
		end
	end

	if var_17_3 == "#go_collection" then
		for iter_17_2, iter_17_3 in pairs(arg_17_0._talentItems) do
			if iter_17_3.animation then
				iter_17_3.animation:Play()
			end
		end
	end
end

function var_0_0._progressFinish(arg_18_0)
	arg_18_0._canEnterNext = true

	local var_18_0 = arg_18_0._allShowGroup[arg_18_0._progress]

	if var_18_0 then
		var_18_0.blocksRaycasts = true
		var_18_0.interactable = true
	end

	gohelper.setActive(arg_18_0._goallClick, arg_18_0._progress ~= var_0_2)

	if arg_18_0._isFirstPlayer then
		gohelper.setActive(arg_18_0._btnenter.gameObject, arg_18_0._progress == var_0_2)
	end
end

function var_0_0.onClose(arg_19_0)
	SurvivalOutSideRpc.instance:sendSurvivalOutSideGetInfo()
end

function var_0_0.onDestroyView(arg_20_0)
	if arg_20_0._talentItems then
		for iter_20_0, iter_20_1 in pairs(arg_20_0._talentItems) do
			if iter_20_1.click then
				iter_20_1.click:RemoveClickListener()
			end

			if iter_20_1.btnCheck then
				iter_20_1.btnCheck:RemoveClickListener()
			end
		end
	end

	if arg_20_0._allClick then
		arg_20_0._allClick:RemoveClickListener()

		arg_20_0._allClick = nil
	end

	if arg_20_0._tweenId then
		ZProj.TweenHelper.KillById(arg_20_0._tweenId)

		arg_20_0._tweenId = nil
	end

	if arg_20_0._moveTweenId then
		ZProj.TweenHelper.KillById(arg_20_0._moveTweenId)

		arg_20_0._moveTweenId = nil
	end
end

function var_0_0._onEnterShelter(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	if arg_21_2 == 0 then
		arg_21_0:closeThis()
		SurvivalController.instance:enterSurvivalShelterScene()
	end
end

return var_0_0
