module("modules.logic.rouge.view.RougeInitTeamView", package.seeall)

local var_0_0 = class("RougeInitTeamView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagefullbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_fullbg")
	arg_1_0._gopoint = gohelper.findChild(arg_1_0.viewGO, "Title/bg/volume/#go_point")
	arg_1_0._txtnum = gohelper.findChildText(arg_1_0.viewGO, "Title/bg/volume/#txt_num")
	arg_1_0._goprogress = gohelper.findChild(arg_1_0.viewGO, "#go_progress")
	arg_1_0._gocontent = gohelper.findChild(arg_1_0.viewGO, "Scroll View/Viewport/#go_content")
	arg_1_0._goitem1 = gohelper.findChild(arg_1_0.viewGO, "Scroll View/Viewport/#go_content/#go_item1")
	arg_1_0._goitem2 = gohelper.findChild(arg_1_0.viewGO, "Scroll View/Viewport/#go_content/#go_item2")
	arg_1_0._btnhelp = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#btn_help")
	arg_1_0._gounselect = gohelper.findChild(arg_1_0.viewGO, "Left/#btn_help/#go_unselect")
	arg_1_0._goselected = gohelper.findChild(arg_1_0.viewGO, "Left/#btn_help/#go_selected")
	arg_1_0._gofull = gohelper.findChild(arg_1_0.viewGO, "Left/#btn_help/#go_full")
	arg_1_0._btnstart = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_start")
	arg_1_0._godifficultytips = gohelper.findChild(arg_1_0.viewGO, "#go_difficultytips")
	arg_1_0._txtdifficulty = gohelper.findChildText(arg_1_0.viewGO, "#go_difficultytips/#txt_difficulty")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnhelp:AddClickListener(arg_2_0._btnhelpOnClick, arg_2_0)
	arg_2_0._btnstart:AddClickListener(arg_2_0._btnstartOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnhelp:RemoveClickListener()
	arg_3_0._btnstart:RemoveClickListener()
end

function var_0_0._btnhelpOnClick(arg_4_0)
	if arg_4_0._helpState == RougeEnum.HelpState.Full then
		if arg_4_0._capacityFull then
			GameFacade.showToast(ToastEnum.RougeTeamSelectHeroCapacityFull)

			return
		end

		if arg_4_0._heroFull then
			GameFacade.showToast(ToastEnum.RougeTeamFull)

			return
		end

		return
	end

	if arg_4_0._helpState == RougeEnum.HelpState.Selected then
		arg_4_0._assistMo = nil

		arg_4_0:_modifyHeroGroup()

		return
	end

	RougeController.instance:setPickAssistViewParams(arg_4_0._curCapacity, arg_4_0._maxCapacity)
	PickAssistController.instance:openPickAssistView(PickAssistEnum.Type.Rouge, 1, nil, arg_4_0._onPickHandler, arg_4_0, true)
end

function var_0_0._onPickHandler(arg_5_0, arg_5_1)
	if not arg_5_1 then
		arg_5_0._assistMo = nil

		return
	end

	local var_5_0 = arg_5_0._assistMo and arg_5_0._assistMo.id or arg_5_0:_getAssistIndex(arg_5_1.heroMO.heroId)

	if not var_5_0 then
		return
	end

	arg_5_0._assistMo = arg_5_0._assistMo or RougeAssistHeroSingleGroupMO.New()

	arg_5_0._assistMo:init(var_5_0, arg_5_1.heroMO.uid, arg_5_1.heroMO)
	arg_5_0:_modifyHeroGroup()
end

function var_0_0._getAssistIndex(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0._heroItemList) do
		local var_6_0 = RougeHeroSingleGroupModel.instance:getById(iter_6_0):getHeroMO()

		if var_6_0 and var_6_0.heroId == arg_6_1 and arg_6_1 then
			RougeHeroSingleGroupModel.instance:removeFrom(iter_6_0)

			return iter_6_0
		end
	end

	for iter_6_2, iter_6_3 in ipairs(arg_6_0._heroItemList) do
		if not RougeHeroSingleGroupModel.instance:getById(iter_6_2):getHeroMO() then
			return iter_6_2
		end
	end
end

function var_0_0._checkHelpState(arg_7_0)
	if arg_7_0._assistMo then
		arg_7_0:_updateHelpState(RougeEnum.HelpState.Selected)

		return
	end

	arg_7_0._capacityFull = arg_7_0._curCapacity >= arg_7_0._maxCapacity
	arg_7_0._heroFull = arg_7_0._heroNum >= RougeEnum.InitTeamHeroNum

	if arg_7_0._capacityFull or arg_7_0._heroFull then
		arg_7_0:_updateHelpState(RougeEnum.HelpState.Full)

		return
	end

	arg_7_0:_updateHelpState(RougeEnum.HelpState.UnSelected)
end

function var_0_0._updateHelpState(arg_8_0, arg_8_1)
	arg_8_0._helpState = arg_8_1

	gohelper.setActive(arg_8_0._gounselect, arg_8_1 == RougeEnum.HelpState.UnSelected)
	gohelper.setActive(arg_8_0._goselected, arg_8_1 == RougeEnum.HelpState.Selected)
	gohelper.setActive(arg_8_0._gofull, arg_8_1 == RougeEnum.HelpState.Full)
end

function var_0_0._btnstartOnClick(arg_9_0)
	local var_9_0 = RougeConfig1.instance:season()
	local var_9_1 = {}
	local var_9_2 = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_0._heroItemList) do
		local var_9_3 = RougeHeroSingleGroupModel.instance:getById(iter_9_0):getHeroMO()

		if var_9_3 then
			table.insert(var_9_1, var_9_3.heroId)
			table.insert(var_9_2, var_9_3)
		end
	end

	local var_9_4 = arg_9_0._assistMo and arg_9_0._assistMo.heroUid
	local var_9_5 = arg_9_0._assistMo

	RougeRpc.instance:sendEnterRougeSelectHeroesRequest(var_9_0, var_9_1, var_9_4, function(arg_10_0, arg_10_1, arg_10_2)
		if arg_10_1 ~= 0 then
			return
		end

		RougeController.instance:enterRouge()
		RougeMapModel.instance:setFirstEnterMap(true)
		RougeStatController.instance:selectInitHeroGroup(var_9_2, var_9_5)
	end)
end

function var_0_0._editableInitView(arg_11_0)
	arg_11_0._heroNum = 0

	arg_11_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, arg_11_0._onCloseOtherView, arg_11_0)
	arg_11_0:_initHeroItemList()
	arg_11_0:_updateHeroList()
	arg_11_0:_initPageProgress()
end

function var_0_0._initPageProgress(arg_12_0)
	local var_12_0 = RougePageProgress
	local var_12_1 = arg_12_0.viewContainer:getResInst(RougeEnum.ResPath.rougepageprogress, arg_12_0._goprogress, var_12_0.__cname)

	arg_12_0._pageProgress = MonoHelper.addNoUpdateLuaComOnceToGo(var_12_1, var_12_0)

	arg_12_0._pageProgress:setData()
end

function var_0_0._initHeroItemList(arg_13_0)
	arg_13_0._heroItemList = arg_13_0:getUserDataTb_()

	local var_13_0 = arg_13_0.viewContainer:getSetting().otherRes[1]
	local var_13_1 = arg_13_0.viewContainer:getRes(var_13_0)

	for iter_13_0 = 1, RougeEnum.InitTeamHeroNum do
		local var_13_2 = gohelper.cloneInPlace(iter_13_0 % 2 == 1 and arg_13_0._goitem1 or arg_13_0._goitem2)

		var_13_2.name = "item_" .. tostring(iter_13_0)

		gohelper.setActive(var_13_2, true)

		local var_13_3 = MonoHelper.addNoUpdateLuaComOnceToGo(var_13_2, RougeInitTeamHeroItem)

		var_13_3:setIndex(iter_13_0)
		var_13_3:setRougeInitTeamView(arg_13_0)
		var_13_3:setHeroItem(var_13_1)
		table.insert(arg_13_0._heroItemList, var_13_3)
	end
end

function var_0_0._updateHeroList(arg_14_0)
	local var_14_0 = 0
	local var_14_1 = 0
	local var_14_2 = 0

	arg_14_0._heroNum = 0

	local var_14_3 = false

	for iter_14_0, iter_14_1 in ipairs(arg_14_0._heroItemList) do
		local var_14_4 = RougeHeroSingleGroupModel.instance:getById(iter_14_0)
		local var_14_5 = false

		if arg_14_0._assistMo and arg_14_0._assistMo.id == iter_14_0 then
			var_14_4 = arg_14_0._assistMo
			var_14_5 = true
		end

		local var_14_6 = var_14_4:getHeroMO()
		local var_14_7 = arg_14_0._isModify and var_14_6 and iter_14_1:getHeroMo() ~= var_14_6

		iter_14_1:setTrialValue(var_14_5)
		iter_14_1:onUpdateMO(var_14_4)

		if var_14_7 then
			iter_14_1:showSelectEffect()
		end

		if var_14_6 then
			arg_14_0._heroNum = arg_14_0._heroNum + 1
		end

		var_14_0 = var_14_0 + iter_14_1:getCapacity()

		if var_14_5 then
			var_14_1 = iter_14_1:getCapacity()
		else
			var_14_2 = var_14_2 + iter_14_1:getCapacity()
		end
	end

	arg_14_0._assistCapacity = var_14_1
	arg_14_0._noneAssistCurCapacity = var_14_2

	arg_14_0:_updateCurNum(var_14_0)
end

function var_0_0.getAssistCapacity(arg_15_0)
	return arg_15_0._assistCapacity
end

function var_0_0.getAssistPos(arg_16_0)
	return arg_16_0._assistMo and arg_16_0._assistMo.id or nil
end

function var_0_0.getAssistHeroId(arg_17_0)
	return arg_17_0._assistMo and arg_17_0._assistMo.heroId or nil
end

function var_0_0._updateCurNum(arg_18_0, arg_18_1)
	arg_18_0._curCapacity = arg_18_1

	if arg_18_0._capacityComp then
		arg_18_0._capacityComp:updateCurNum(arg_18_1)
	end

	gohelper.setActive(arg_18_0._btnstart, arg_18_1 ~= 0)
end

function var_0_0.onUpdateParam(arg_19_0)
	return
end

function var_0_0.onOpen(arg_20_0)
	arg_20_0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, arg_20_0._modifyHeroGroup, arg_20_0)

	local var_20_0 = RougeModel.instance:getStyle()

	arg_20_0._styleConfig = RougeConfig1.instance:getStyleConfig(var_20_0)

	arg_20_0:_initCapacity()
	arg_20_0:_initDifficultyTips()
	arg_20_0:_updateHelpState(RougeEnum.HelpState.UnSelected)
end

function var_0_0._initDifficultyTips(arg_21_0)
	local var_21_0 = RougeModel.instance:getDifficulty()

	arg_21_0._txtdifficulty.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rougefactionview_txtDifficultyTiitle"), RougeConfig1.instance:getDifficultyCOTitle(var_21_0))

	local var_21_1 = RougeConfig1.instance:getRougeDifficultyViewStyleIndex(var_21_0)
	local var_21_2 = gohelper.findChild(arg_21_0._godifficultytips, "red")
	local var_21_3 = gohelper.findChild(arg_21_0._godifficultytips, "orange")
	local var_21_4 = gohelper.findChild(arg_21_0._godifficultytips, "green")

	gohelper.setActive(var_21_4, var_21_1 == 1)
	gohelper.setActive(var_21_3, var_21_1 == 2)
	gohelper.setActive(var_21_2, var_21_1 == 3)
end

function var_0_0._initCapacity(arg_22_0)
	arg_22_0._maxCapacity = RougeModel.instance:getTeamCapacity()

	gohelper.setActive(arg_22_0._gopoint, false)

	arg_22_0._capacityComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_22_0.viewGO, RougeCapacityComp)

	arg_22_0._capacityComp:setMaxNum(arg_22_0._maxCapacity)
	arg_22_0._capacityComp:setPoint(arg_22_0._gopoint)
	arg_22_0._capacityComp:setTxt(arg_22_0._txtnum)
	arg_22_0._capacityComp:initCapacity()
	arg_22_0._capacityComp:showChangeEffect(true)
end

function var_0_0.getCapacityProgress(arg_23_0)
	return arg_23_0._curCapacity, arg_23_0._maxCapacity
end

function var_0_0.getNoneAssistCapacityProgress(arg_24_0)
	return arg_24_0._noneAssistCurCapacity, arg_24_0._maxCapacity
end

function var_0_0.onOpenFinish(arg_25_0)
	ViewMgr.instance:closeView(ViewName.RougeFactionView)
	arg_25_0:_checkFocusCurView()
end

function var_0_0._modifyHeroGroup(arg_26_0)
	arg_26_0._isModify = true

	arg_26_0:_updateHeroList()

	arg_26_0._isModify = false

	arg_26_0:_checkHelpState()
end

function var_0_0.onClose(arg_27_0)
	return
end

function var_0_0.onDestroyView(arg_28_0)
	return
end

function var_0_0._onCloseOtherView(arg_29_0)
	arg_29_0:_checkFocusCurView()
end

function var_0_0._checkFocusCurView(arg_30_0)
	local var_30_0 = ViewMgr.instance:getOpenViewNameList()

	if var_30_0[#var_30_0] == ViewName.RougeInitTeamView then
		RougeController.instance:dispatchEvent(RougeEvent.FocusOnView, "RougeInitTeamView")
	end
end

return var_0_0
