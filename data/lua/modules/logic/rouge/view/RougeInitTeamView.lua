module("modules.logic.rouge.view.RougeInitTeamView", package.seeall)

slot0 = class("RougeInitTeamView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg")
	slot0._gopoint = gohelper.findChild(slot0.viewGO, "Title/bg/volume/#go_point")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "Title/bg/volume/#txt_num")
	slot0._goprogress = gohelper.findChild(slot0.viewGO, "#go_progress")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "Scroll View/Viewport/#go_content")
	slot0._goitem1 = gohelper.findChild(slot0.viewGO, "Scroll View/Viewport/#go_content/#go_item1")
	slot0._goitem2 = gohelper.findChild(slot0.viewGO, "Scroll View/Viewport/#go_content/#go_item2")
	slot0._btnhelp = gohelper.findChildButtonWithAudio(slot0.viewGO, "Left/#btn_help")
	slot0._gounselect = gohelper.findChild(slot0.viewGO, "Left/#btn_help/#go_unselect")
	slot0._goselected = gohelper.findChild(slot0.viewGO, "Left/#btn_help/#go_selected")
	slot0._gofull = gohelper.findChild(slot0.viewGO, "Left/#btn_help/#go_full")
	slot0._btnstart = gohelper.findChildButtonWithAudio(slot0.viewGO, "Right/#btn_start")
	slot0._godifficultytips = gohelper.findChild(slot0.viewGO, "#go_difficultytips")
	slot0._txtdifficulty = gohelper.findChildText(slot0.viewGO, "#go_difficultytips/#txt_difficulty")
	slot0._golefttop = gohelper.findChild(slot0.viewGO, "#go_lefttop")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnhelp:AddClickListener(slot0._btnhelpOnClick, slot0)
	slot0._btnstart:AddClickListener(slot0._btnstartOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnhelp:RemoveClickListener()
	slot0._btnstart:RemoveClickListener()
end

function slot0._btnhelpOnClick(slot0)
	if slot0._helpState == RougeEnum.HelpState.Full then
		if slot0._capacityFull then
			GameFacade.showToast(ToastEnum.RougeTeamSelectHeroCapacityFull)

			return
		end

		if slot0._heroFull then
			GameFacade.showToast(ToastEnum.RougeTeamFull)

			return
		end

		return
	end

	if slot0._helpState == RougeEnum.HelpState.Selected then
		slot0._assistMo = nil

		slot0:_modifyHeroGroup()

		return
	end

	RougeController.instance:setPickAssistViewParams(slot0._curCapacity, slot0._maxCapacity)
	PickAssistController.instance:openPickAssistView(PickAssistEnum.Type.Rouge, 1, nil, slot0._onPickHandler, slot0, true)
end

function slot0._onPickHandler(slot0, slot1)
	if not slot1 then
		slot0._assistMo = nil

		return
	end

	if not (slot0._assistMo and slot0._assistMo.id or slot0:_getAssistIndex(slot1.heroMO.heroId)) then
		return
	end

	slot0._assistMo = slot0._assistMo or RougeAssistHeroSingleGroupMO.New()

	slot0._assistMo:init(slot2, slot1.heroMO.uid, slot1.heroMO)
	slot0:_modifyHeroGroup()
end

function slot0._getAssistIndex(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._heroItemList) do
		if RougeHeroSingleGroupModel.instance:getById(slot5):getHeroMO() and slot8.heroId == slot1 and slot1 then
			RougeHeroSingleGroupModel.instance:removeFrom(slot5)

			return slot5
		end
	end

	for slot5, slot6 in ipairs(slot0._heroItemList) do
		if not RougeHeroSingleGroupModel.instance:getById(slot5):getHeroMO() then
			return slot5
		end
	end
end

function slot0._checkHelpState(slot0)
	if slot0._assistMo then
		slot0:_updateHelpState(RougeEnum.HelpState.Selected)

		return
	end

	slot0._capacityFull = slot0._maxCapacity <= slot0._curCapacity
	slot0._heroFull = RougeEnum.InitTeamHeroNum <= slot0._heroNum

	if slot0._capacityFull or slot0._heroFull then
		slot0:_updateHelpState(RougeEnum.HelpState.Full)

		return
	end

	slot0:_updateHelpState(RougeEnum.HelpState.UnSelected)
end

function slot0._updateHelpState(slot0, slot1)
	slot0._helpState = slot1

	gohelper.setActive(slot0._gounselect, slot1 == RougeEnum.HelpState.UnSelected)
	gohelper.setActive(slot0._goselected, slot1 == RougeEnum.HelpState.Selected)
	gohelper.setActive(slot0._gofull, slot1 == RougeEnum.HelpState.Full)
end

function slot0._btnstartOnClick(slot0)
	slot1 = RougeConfig1.instance:season()
	slot2 = {}

	for slot7, slot8 in ipairs(slot0._heroItemList) do
		if RougeHeroSingleGroupModel.instance:getById(slot7):getHeroMO() then
			table.insert(slot2, slot10.heroId)
			table.insert({}, slot10)
		end
	end

	slot5 = slot0._assistMo

	RougeRpc.instance:sendEnterRougeSelectHeroesRequest(slot1, slot2, slot0._assistMo and slot0._assistMo.heroUid, function (slot0, slot1, slot2)
		if slot1 ~= 0 then
			return
		end

		RougeController.instance:enterRouge()
		RougeMapModel.instance:setFirstEnterMap(true)
		RougeStatController.instance:selectInitHeroGroup(uv0, uv1)
	end)
end

function slot0._editableInitView(slot0)
	slot0._heroNum = 0

	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseViewFinish, slot0._onCloseOtherView, slot0)
	slot0:_initHeroItemList()
	slot0:_updateHeroList()
	slot0:_initPageProgress()
end

function slot0._initPageProgress(slot0)
	slot1 = RougePageProgress
	slot0._pageProgress = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.viewContainer:getResInst(RougeEnum.ResPath.rougepageprogress, slot0._goprogress, slot1.__cname), slot1)

	slot0._pageProgress:setData()
end

function slot0._initHeroItemList(slot0)
	slot0._heroItemList = slot0:getUserDataTb_()

	for slot6 = 1, RougeEnum.InitTeamHeroNum do
		slot7 = gohelper.cloneInPlace(slot6 % 2 == 1 and slot0._goitem1 or slot0._goitem2)
		slot7.name = "item_" .. tostring(slot6)

		gohelper.setActive(slot7, true)

		slot8 = MonoHelper.addNoUpdateLuaComOnceToGo(slot7, RougeInitTeamHeroItem)

		slot8:setIndex(slot6)
		slot8:setRougeInitTeamView(slot0)
		slot8:setHeroItem(slot0.viewContainer:getRes(slot0.viewContainer:getSetting().otherRes[1]))
		table.insert(slot0._heroItemList, slot8)
	end
end

function slot0._updateHeroList(slot0)
	slot1 = 0
	slot2 = 0
	slot3 = 0
	slot0._heroNum = 0
	slot4 = false

	for slot8, slot9 in ipairs(slot0._heroItemList) do
		slot10 = RougeHeroSingleGroupModel.instance:getById(slot8)
		slot4 = false

		if slot0._assistMo and slot0._assistMo.id == slot8 then
			slot10 = slot0._assistMo
			slot4 = true
		end

		slot11 = slot10:getHeroMO()

		slot9:setTrialValue(slot4)
		slot9:onUpdateMO(slot10)

		if slot0._isModify and slot11 and slot9:getHeroMo() ~= slot11 then
			slot9:showSelectEffect()
		end

		if slot11 then
			slot0._heroNum = slot0._heroNum + 1
		end

		slot1 = slot1 + slot9:getCapacity()

		if slot4 then
			slot2 = slot9:getCapacity()
		else
			slot3 = slot3 + slot9:getCapacity()
		end
	end

	slot0._assistCapacity = slot2
	slot0._noneAssistCurCapacity = slot3

	slot0:_updateCurNum(slot1)
end

function slot0.getAssistCapacity(slot0)
	return slot0._assistCapacity
end

function slot0.getAssistPos(slot0)
	return slot0._assistMo and slot0._assistMo.id or nil
end

function slot0.getAssistHeroId(slot0)
	return slot0._assistMo and slot0._assistMo.heroId or nil
end

function slot0._updateCurNum(slot0, slot1)
	slot0._curCapacity = slot1

	if slot0._capacityComp then
		slot0._capacityComp:updateCurNum(slot1)
	end

	gohelper.setActive(slot0._btnstart, slot1 ~= 0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(HeroGroupController.instance, HeroGroupEvent.OnModifyHeroGroup, slot0._modifyHeroGroup, slot0)

	slot0._styleConfig = RougeConfig1.instance:getStyleConfig(RougeModel.instance:getStyle())

	slot0:_initCapacity()
	slot0:_initDifficultyTips()
	slot0:_updateHelpState(RougeEnum.HelpState.UnSelected)
end

function slot0._initDifficultyTips(slot0)
	slot1 = RougeModel.instance:getDifficulty()
	slot0._txtdifficulty.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("rougefactionview_txtDifficultyTiitle"), RougeConfig1.instance:getDifficultyCOTitle(slot1))

	gohelper.setActive(gohelper.findChild(slot0._godifficultytips, "green"), RougeConfig1.instance:getRougeDifficultyViewStyleIndex(slot1) == 1)
	gohelper.setActive(gohelper.findChild(slot0._godifficultytips, "orange"), slot2 == 2)
	gohelper.setActive(gohelper.findChild(slot0._godifficultytips, "red"), slot2 == 3)
end

function slot0._initCapacity(slot0)
	slot0._maxCapacity = RougeModel.instance:getTeamCapacity()

	gohelper.setActive(slot0._gopoint, false)

	slot0._capacityComp = MonoHelper.addNoUpdateLuaComOnceToGo(slot0.viewGO, RougeCapacityComp)

	slot0._capacityComp:setMaxNum(slot0._maxCapacity)
	slot0._capacityComp:setPoint(slot0._gopoint)
	slot0._capacityComp:setTxt(slot0._txtnum)
	slot0._capacityComp:initCapacity()
	slot0._capacityComp:showChangeEffect(true)
end

function slot0.getCapacityProgress(slot0)
	return slot0._curCapacity, slot0._maxCapacity
end

function slot0.getNoneAssistCapacityProgress(slot0)
	return slot0._noneAssistCurCapacity, slot0._maxCapacity
end

function slot0.onOpenFinish(slot0)
	ViewMgr.instance:closeView(ViewName.RougeFactionView)
	slot0:_checkFocusCurView()
end

function slot0._modifyHeroGroup(slot0)
	slot0._isModify = true

	slot0:_updateHeroList()

	slot0._isModify = false

	slot0:_checkHelpState()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
end

function slot0._onCloseOtherView(slot0)
	slot0:_checkFocusCurView()
end

function slot0._checkFocusCurView(slot0)
	slot1 = ViewMgr.instance:getOpenViewNameList()

	if slot1[#slot1] == ViewName.RougeInitTeamView then
		RougeController.instance:dispatchEvent(RougeEvent.FocusOnView, "RougeInitTeamView")
	end
end

return slot0
