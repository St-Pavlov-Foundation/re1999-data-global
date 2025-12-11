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
	arg_1_0._gomainitem = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_main/container/#go_mainitem")
	arg_1_0._txttask = gohelper.findChildText(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_main/container/#go_mainitem/#txt_task")
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

	arg_1_0.goMainAnim = arg_1_0._gomain:GetComponent(gohelper.Type_Animation)
	arg_1_0.go_dec2 = gohelper.findChild(arg_1_0._gomain, "#go_dec2")
	arg_1_0.go_score = gohelper.findChild(arg_1_0._gomain, "#go_score")
	arg_1_0.go_rewardinherit = gohelper.findChild(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_main/#go_rewardinherit")
	arg_1_0.txt_score = gohelper.findChildTextMesh(arg_1_0.viewGO, "#scroll_contentlist/viewport/content/#go_main/#go_score/#txt_score")
	arg_1_0.go_fixed_rewardinherititem = gohelper.findChild(arg_1_0.go_rewardinherit, "#go_rewardinherititem")
	arg_1_0.layout = gohelper.findChild(arg_1_0.go_rewardinherit, "layout")
	arg_1_0.go_rewardinherititem = gohelper.findChild(arg_1_0.layout, "#go_rewardinherititem")

	gohelper.setActive(arg_1_0.go_rewardinherititem, false)

	arg_1_0.fixedSelectCell = MonoHelper.addNoUpdateLuaComOnceToGo(arg_1_0.go_fixed_rewardinherititem, SurvivalRewardSelectCell, arg_1_0.viewContainer)
	arg_1_0.customItems = {}
	arg_1_0.isNeedHandbookSelect = SurvivalRewardInheritModel.instance:isNeedHandbookSelect()

	gohelper.setActive(arg_1_0.go_dec2, arg_1_0.isNeedHandbookSelect)
	gohelper.setActive(arg_1_0.go_score, arg_1_0.isNeedHandbookSelect)
	gohelper.setActive(arg_1_0.go_rewardinherit, arg_1_0.isNeedHandbookSelect)
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncheck:AddClickListener(arg_2_0._btncheckOnClick, arg_2_0)
	arg_2_0._btnenter:AddClickListener(arg_2_0._btnenterOnClick, arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnRewardInheritRefresh, arg_2_0.onRewardInheritRefresh, arg_2_0)
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
	0.5
}
local var_0_2 = 2
local var_0_3 = 2
local var_0_4 = 2
local var_0_5 = ZProj.TweenHelper

function var_0_0._btncheckOnClick(arg_5_0)
	return
end

function var_0_0._btnenterOnClick(arg_6_0)
	if arg_6_0.isNeedHandbookSelect then
		local var_6_0, var_6_1 = SurvivalRewardInheritModel.instance:getChooseList()

		SurvivalWeekRpc.instance:sendSurvivalChooseBooty(var_6_1, var_6_0, arg_6_0._onEnterShelter, arg_6_0, true)
	else
		SurvivalController.instance:startNewWeek()
		SurvivalController.instance:enterSurvivalShelterScene()
	end
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

	arg_7_0._allShowGroup = arg_7_0:getUserDataTb_()

	table.insert(arg_7_0._allShowGroup, arg_7_0._canvasGroupDec)
	table.insert(arg_7_0._allShowGroup, arg_7_0._canvasGroupMainTask)
	table.insert(arg_7_0._allShowGroup, arg_7_0._canvasGroupCollection)

	arg_7_0._allShowAnim = arg_7_0:getUserDataTb_()
end

function var_0_0.onOpen(arg_8_0)
	SurvivalRewardInheritModel.instance.selectMo:clear()

	arg_8_0._isFirstPlayer = arg_8_0.viewParam.isFirstPlayer

	if arg_8_0._isFirstPlayer then
		var_0_2 = var_0_3
	else
		var_0_2 = var_0_4
	end

	arg_8_0._progress = 1

	arg_8_0:_initView()
	arg_8_0:_refreshCurProgress()
	arg_8_0:refreshCost()
	arg_8_0:refreshFixedItem()
	arg_8_0:refreshHandbook()
end

function var_0_0._initView(arg_9_0)
	recthelper.setAnchorY(arg_9_0._contentRect, 0)

	arg_9_0._canvasGroupDec.alpha = 0

	arg_9_0:_initTaskView()
	gohelper.setActive(arg_9_0._gosub, false)
	gohelper.setActive(arg_9_0._gocollection, false)
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

function var_0_0.enterNext(arg_12_0)
	if not arg_12_0._canEnterNext then
		return
	end

	if arg_12_0._progress == var_0_2 then
		return
	end

	arg_12_0._progress = arg_12_0._progress + 1

	arg_12_0:_refreshCurProgress()
end

function var_0_0.getContentY(arg_13_0)
	if arg_13_0._allContentY == nil or #arg_13_0._allContentY <= 0 then
		arg_13_0._allContentY = {}

		for iter_13_0 = 1, var_0_2 do
			local var_13_0 = arg_13_0._allShowGO[iter_13_0].transform

			ZProj.UGUIHelper.RebuildLayout(var_13_0)

			local var_13_1 = var_13_0:GetComponent(gohelper.Type_RectTransform)
			local var_13_2 = recthelper.getHeight(var_13_1)

			if var_13_2 ~= 0 then
				table.insert(arg_13_0._allContentY, var_13_2 + 30)
			end
		end
	end

	local var_13_3 = 0
	local var_13_4 = math.min(arg_13_0._progress, #arg_13_0._allContentY)

	for iter_13_1 = 1, var_13_4 do
		var_13_3 = var_13_3 + arg_13_0._allContentY[iter_13_1]
	end

	return var_13_3 - arg_13_0._scrollHeight
end

function var_0_0._refreshCurProgress(arg_14_0)
	arg_14_0._canEnterNext = false

	local var_14_0 = arg_14_0._allShowGO[arg_14_0._progress]
	local var_14_1 = var_0_1[arg_14_0._progress]
	local var_14_2 = arg_14_0:getContentY()

	if var_14_2 > 0 then
		arg_14_0._moveTweenId = var_0_5.DOAnchorPosY(arg_14_0._contentRect, var_14_2, var_14_1)
	end

	if var_14_0 ~= nil then
		arg_14_0._tweenId = var_0_5.DOFadeCanvasGroup(var_14_0, 0, 1, var_14_1, arg_14_0._progressFinish, arg_14_0)
	end

	local var_14_3 = var_14_0.name

	if var_14_3 == "#go_main" then
		for iter_14_0, iter_14_1 in ipairs(arg_14_0._mainTaskItem) do
			if iter_14_1.animation then
				iter_14_1.animation:Play()
			end
		end

		arg_14_0.goMainAnim:Play()
	end

	if var_14_3 == "#go_collection" then
		for iter_14_2, iter_14_3 in pairs(arg_14_0._talentItems) do
			if iter_14_3.animation then
				iter_14_3.animation:Play()
			end
		end
	end
end

function var_0_0._progressFinish(arg_15_0)
	arg_15_0._canEnterNext = true

	local var_15_0 = arg_15_0._allShowGroup[arg_15_0._progress]

	if var_15_0 then
		var_15_0.blocksRaycasts = true
		var_15_0.interactable = true
	end

	gohelper.setActive(arg_15_0._goallClick, arg_15_0._progress ~= var_0_2)
	gohelper.setActive(arg_15_0._btnenter.gameObject, arg_15_0._progress == var_0_2)
end

function var_0_0.onClose(arg_16_0)
	SurvivalOutSideRpc.instance:sendSurvivalOutSideGetInfo()
end

function var_0_0.onDestroyView(arg_17_0)
	if arg_17_0._talentItems then
		for iter_17_0, iter_17_1 in pairs(arg_17_0._talentItems) do
			if iter_17_1.click then
				iter_17_1.click:RemoveClickListener()
			end

			if iter_17_1.btnCheck then
				iter_17_1.btnCheck:RemoveClickListener()
			end
		end
	end

	if arg_17_0._allClick then
		arg_17_0._allClick:RemoveClickListener()

		arg_17_0._allClick = nil
	end

	if arg_17_0._tweenId then
		ZProj.TweenHelper.KillById(arg_17_0._tweenId)

		arg_17_0._tweenId = nil
	end

	if arg_17_0._moveTweenId then
		ZProj.TweenHelper.KillById(arg_17_0._moveTweenId)

		arg_17_0._moveTweenId = nil
	end

	if arg_17_0.inheritMoveTweenId then
		ZProj.TweenHelper.KillById(arg_17_0.inheritMoveTweenId)

		arg_17_0.inheritMoveTweenId = nil
	end
end

function var_0_0._onEnterShelter(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if arg_18_2 == 0 then
		arg_18_0:closeThis()
	end
end

function var_0_0.refreshInheritSelect(arg_19_0)
	local var_19_0 = SurvivalRewardInheritModel.instance.amplifierSelectMo
	local var_19_1 = SurvivalRewardInheritModel.instance.npcSelectMo
	local var_19_2 = var_19_0:getSelectList()
	local var_19_3 = var_19_1:getSelectList()
	local var_19_4 = SurvivalConfig.instance:getHardnessCfg().extendScore
	local var_19_5 = 0

	for iter_19_0, iter_19_1 in ipairs(var_19_2) do
		var_19_5 = var_19_5 + lua_survival_equip.configDict[iter_19_1].extendCost
	end

	for iter_19_2, iter_19_3 in ipairs(var_19_3) do
		var_19_5 = var_19_5 + lua_survival_npc.configDict[iter_19_3].extendCost
	end
end

function var_0_0.onRewardInheritRefresh(arg_20_0)
	arg_20_0:refreshCost()
	arg_20_0:refreshHandbook()
	arg_20_0:refreshFixedItem()
	ZProj.UGUIHelper.RebuildLayout(arg_20_0._contentRect.transform)

	local var_20_0 = -30 - arg_20_0._scrollHeight

	for iter_20_0 = 1, 2 do
		local var_20_1 = arg_20_0._allShowGO[iter_20_0].transform:GetComponent(gohelper.Type_RectTransform)

		var_20_0 = var_20_0 + recthelper.getHeight(var_20_1) + 30
	end

	if var_20_0 > recthelper.getAnchorY(arg_20_0._contentRect.transform) then
		arg_20_0.inheritMoveTweenId = var_0_5.DOAnchorPosY(arg_20_0._contentRect, var_20_0, 0.3)
	end
end

function var_0_0.refreshFixedItem(arg_21_0)
	local var_21_0 = arg_21_0.extendScore - arg_21_0.curExtendScore

	arg_21_0.fixedSelectCell:setData({
		itemId = 1,
		count = var_21_0
	})
end

function var_0_0.refreshCost(arg_22_0)
	arg_22_0.curExtendScore = SurvivalRewardInheritModel.instance:getCurExtendScore()
	arg_22_0.extendScore = SurvivalRewardInheritModel.instance:getExtendScore()
	arg_22_0.txt_score.text = GameUtil.getSubPlaceholderLuaLang(luaLang("SurvivalSelectTalentTreeView_1"), {
		arg_22_0.curExtendScore,
		arg_22_0.extendScore
	})
end

function var_0_0.refreshHandbook(arg_23_0)
	local var_23_0 = SurvivalRewardInheritModel.instance.selectMo.dataList
	local var_23_1 = {}

	tabletool.addValues(var_23_1, var_23_0)
	table.insert(var_23_1, -10)

	local var_23_2 = #arg_23_0.customItems
	local var_23_3 = #var_23_1

	for iter_23_0 = 1, var_23_3 do
		local var_23_4 = var_23_1[iter_23_0]

		if var_23_2 < iter_23_0 then
			local var_23_5 = gohelper.clone(arg_23_0.go_rewardinherititem, arg_23_0.layout)

			gohelper.setActive(var_23_5, true)

			arg_23_0.customItems[iter_23_0] = MonoHelper.addNoUpdateLuaComOnceToGo(var_23_5, SurvivalRewardSelectCell, arg_23_0.viewContainer)
		end

		arg_23_0.customItems[iter_23_0]:setData({
			inheritId = var_23_4
		})
	end

	for iter_23_1 = var_23_3 + 1, var_23_2 do
		arg_23_0.customItems[iter_23_1]:setData(nil)
	end
end

return var_0_0
