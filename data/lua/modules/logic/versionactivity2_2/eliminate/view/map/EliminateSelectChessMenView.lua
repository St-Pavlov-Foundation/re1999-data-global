module("modules.logic.versionactivity2_2.eliminate.view.map.EliminateSelectChessMenView", package.seeall)

local var_0_0 = class("EliminateSelectChessMenView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageFullBG = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_FullBG")
	arg_1_0._golefttop = gohelper.findChild(arg_1_0.viewGO, "#go_lefttop")
	arg_1_0._goSort = gohelper.findChild(arg_1_0.viewGO, "Left/#go_Sort")
	arg_1_0._btnlvrank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#go_Sort/#btn_lvrank")
	arg_1_0._btnrarerank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#go_Sort/#btn_rarerank")
	arg_1_0._btnfaithrank = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#go_Sort/#btn_faithrank")
	arg_1_0._btnclassify = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#go_Sort/#btn_classify")
	arg_1_0._scrollChessList = gohelper.findChildScrollRect(arg_1_0.viewGO, "Left/#scroll_ChessList")
	arg_1_0._goEmpty = gohelper.findChild(arg_1_0.viewGO, "Right/#go_Empty")
	arg_1_0._goDetail = gohelper.findChild(arg_1_0.viewGO, "Right/#go_Detail")
	arg_1_0._imageChessQualityBG = gohelper.findChildImage(arg_1_0.viewGO, "Right/#go_Detail/Info/#image_ChessQualityBG")
	arg_1_0._imageChess = gohelper.findChildImage(arg_1_0.viewGO, "Right/#go_Detail/Info/#image_Chess")
	arg_1_0._goResource = gohelper.findChild(arg_1_0.viewGO, "Right/#go_Detail/Info/#go_Resource")
	arg_1_0._goResourceItem = gohelper.findChild(arg_1_0.viewGO, "Right/#go_Detail/Info/#go_Resource/#go_ResourceItem")
	arg_1_0._imageResourceQuality = gohelper.findChildImage(arg_1_0.viewGO, "Right/#go_Detail/Info/#go_Resource/#go_ResourceItem/#image_ResourceQuality")
	arg_1_0._txtResourceNum = gohelper.findChildText(arg_1_0.viewGO, "Right/#go_Detail/Info/#go_Resource/#go_ResourceItem/#image_ResourceQuality/#txt_ResourceNum")
	arg_1_0._txtFireNum = gohelper.findChildText(arg_1_0.viewGO, "Right/#go_Detail/Info/image_Fire/#txt_FireNum")
	arg_1_0._goStar1 = gohelper.findChild(arg_1_0.viewGO, "Right/#go_Detail/Info/Stars/#go_Star1")
	arg_1_0._txtChessName = gohelper.findChildText(arg_1_0.viewGO, "Right/#go_Detail/Info/#txt_ChessName")
	arg_1_0._txtDescr = gohelper.findChildText(arg_1_0.viewGO, "Right/#go_Detail/Scroll View/Viewport/#txt_Descr")
	arg_1_0._btnAdd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_Detail/#btn_Add")
	arg_1_0._btnOut = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#go_Detail/#btn_Out")
	arg_1_0._goSlot = gohelper.findChild(arg_1_0.viewGO, "Bottom/#go_Slot")
	arg_1_0._btnEnter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Bottom/#btn_Enter")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnlvrank:AddClickListener(arg_2_0._btnlvrankOnClick, arg_2_0)
	arg_2_0._btnrarerank:AddClickListener(arg_2_0._btnrarerankOnClick, arg_2_0)
	arg_2_0._btnfaithrank:AddClickListener(arg_2_0._btnfaithrankOnClick, arg_2_0)
	arg_2_0._btnclassify:AddClickListener(arg_2_0._btnclassifyOnClick, arg_2_0)
	arg_2_0._btnAdd:AddClickListener(arg_2_0._btnAddOnClick, arg_2_0)
	arg_2_0._btnOut:AddClickListener(arg_2_0._btnOutOnClick, arg_2_0)
	arg_2_0._btnEnter:AddClickListener(arg_2_0._btnEnterOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnlvrank:RemoveClickListener()
	arg_3_0._btnrarerank:RemoveClickListener()
	arg_3_0._btnfaithrank:RemoveClickListener()
	arg_3_0._btnclassify:RemoveClickListener()
	arg_3_0._btnAdd:RemoveClickListener()
	arg_3_0._btnOut:RemoveClickListener()
	arg_3_0._btnEnter:RemoveClickListener()
end

function var_0_0._btnlvrankOnClick(arg_4_0)
	EliminateSelectChessMenListModel.instance:setCurSortType(EliminateMapEnum.SortType.Rare)
	arg_4_0:_refreshBtnStatus()
end

function var_0_0._btnrarerankOnClick(arg_5_0)
	EliminateSelectChessMenListModel.instance:setCurSortType(EliminateMapEnum.SortType.Power)
	arg_5_0:_refreshBtnStatus()
end

function var_0_0._btnfaithrankOnClick(arg_6_0)
	EliminateSelectChessMenListModel.instance:setCurSortType(EliminateMapEnum.SortType.Resource)
	arg_6_0:_refreshBtnStatus()
end

function var_0_0._btnclassifyOnClick(arg_7_0)
	if EliminateTeamSelectionModel.instance:isPreset() then
		GameFacade.showToast(ToastEnum.EliminatePresetTip1)

		return
	end

	local var_7_0 = EliminateSelectChessMenListModel.instance:getQuickEdit()

	EliminateSelectChessMenListModel.instance:setQuickEdit(not var_7_0)
	EliminateSelectChessMenListModel.instance:setSelectedChessMen()
	arg_7_0:_refreshQuickEditBtnStatus()
end

function var_0_0._btnAddOnClick(arg_8_0)
	local var_8_0 = EliminateSelectChessMenListModel.instance:getSelectedChessMen()

	if EliminateSelectChessMenListModel.instance:canAddChessMen(var_8_0) then
		EliminateSelectChessMenListModel.instance:addSelectedChessMen(var_8_0)
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_pawn_add)
	else
		GameFacade.showToast(ToastEnum.EliminateAddedFull)
	end
end

function var_0_0._btnOutOnClick(arg_9_0)
	local var_9_0 = EliminateSelectChessMenListModel.instance:getSelectedChessMen()

	EliminateSelectChessMenListModel.instance:removeSelectedChessMen(var_9_0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_mln_receive)
end

function var_0_0._btnEnterOnClick(arg_10_0)
	local var_10_0 = #EliminateSelectChessMenListModel.instance:getAddIds()

	if var_10_0 == 0 then
		GameFacade.showToast(ToastEnum.EliminateAddedEmpty)

		return
	end

	if not EliminateTeamSelectionModel.instance:isPreset() and var_10_0 < EliminateSelectChessMenListModel.instance:getAddMaxCount() then
		GameFacade.showMessageBox(MessageBoxIdDefine.EliminateAddedNotEnough, MsgBoxEnum.BoxType.Yes_No, function()
			arg_10_0:_enterEpisode()
		end)

		return
	end

	arg_10_0:_enterEpisode()
end

function var_0_0._enterEpisode(arg_12_0)
	local var_12_0 = EliminateSelectChessMenListModel.instance:getAddIds()
	local var_12_1 = EliminateTeamSelectionModel.instance:getSelectedEpisodeId()
	local var_12_2 = EliminateTeamSelectionModel.instance:getSelectedCharacterId()

	EliminateLevelController.instance:enterLevel(var_12_1, var_12_2, var_12_0)

	if not EliminateTeamSelectionModel.instance:isPreset() then
		EliminateMapController.setPrefsString(EliminateMapEnum.PrefsKey.RoleSelected, var_12_2)

		local var_12_3 = EliminateSelectChessMenListModel.instance:serializeAddList()

		EliminateMapController.setPrefsString(EliminateMapEnum.PrefsKey.ChessSelected, var_12_3)
	end
end

function var_0_0._initSortNode(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = gohelper.findChild(arg_13_0.viewGO, string.format("Left/#go_Sort/%s/btn1", arg_13_2))
	local var_13_1 = gohelper.findChild(arg_13_0.viewGO, string.format("Left/#go_Sort/%s/btn1/txt/arrow", arg_13_2))
	local var_13_2 = gohelper.findChild(arg_13_0.viewGO, string.format("Left/#go_Sort/%s/btn2", arg_13_2))
	local var_13_3 = gohelper.findChild(arg_13_0.viewGO, string.format("Left/#go_Sort/%s/btn2/txt/arrow", arg_13_2))

	arg_13_0._sortBtnNodeList[arg_13_1] = {
		btn1 = var_13_0,
		btn1ArrowTrans = var_13_1 and var_13_1.transform,
		btn2 = var_13_2,
		btn2ArrowTrans = var_13_3 and var_13_3.transform
	}
end

function var_0_0._refreshBtnStatus(arg_14_0)
	local var_14_0 = EliminateSelectChessMenListModel.instance:getCurSortType()

	for iter_14_0, iter_14_1 in ipairs(arg_14_0._sortBtnNodeList) do
		local var_14_1 = iter_14_0 == var_14_0

		gohelper.setActive(iter_14_1.btn1, not var_14_1)
		gohelper.setActive(iter_14_1.btn2, var_14_1)

		local var_14_2 = EliminateSelectChessMenListModel.instance:getSortState(iter_14_0)

		transformhelper.setLocalScale(iter_14_1.btn1ArrowTrans, 1, var_14_2, 1)
		transformhelper.setLocalScale(iter_14_1.btn2ArrowTrans, 1, var_14_2, 1)
	end
end

function var_0_0._refreshQuickEditBtnStatus(arg_15_0)
	local var_15_0 = EliminateSelectChessMenListModel.instance:getQuickEdit()

	gohelper.setActive(arg_15_0._quickEditBtns.btn1, not var_15_0)
	gohelper.setActive(arg_15_0._quickEditBtns.btn2, var_15_0)
end

function var_0_0._editableInitView(arg_16_0)
	arg_16_0._goStars = gohelper.findChild(arg_16_0.viewGO, "Right/#go_Detail/Info/Stars")
	arg_16_0._sortBtnNodeList = arg_16_0:getUserDataTb_()

	arg_16_0:_initSortNode(EliminateMapEnum.SortType.Rare, "#btn_lvrank")
	arg_16_0:_initSortNode(EliminateMapEnum.SortType.Power, "#btn_rarerank")
	arg_16_0:_initSortNode(EliminateMapEnum.SortType.Resource, "#btn_faithrank")

	arg_16_0._levelList = {}

	for iter_16_0 = 1, 5 do
		table.insert(arg_16_0._levelList, iter_16_0)
	end

	local var_16_0 = "quickEdit"

	arg_16_0:_initSortNode(var_16_0, "#btn_classify")

	arg_16_0._quickEditBtns = arg_16_0._sortBtnNodeList[var_16_0]

	arg_16_0:addEventCb(EliminateMapController.instance, EliminateMapEvent.QuickSelectChessMen, arg_16_0._onQuickSelectChessMen, arg_16_0)
	arg_16_0:addEventCb(EliminateMapController.instance, EliminateMapEvent.SelectChessMen, arg_16_0._onSelectChessMen, arg_16_0)
	arg_16_0:addEventCb(EliminateMapController.instance, EliminateMapEvent.ChangeChessMen, arg_16_0._onChangeChessMen, arg_16_0)
	gohelper.setActive(arg_16_0._goEmpty, true)
	gohelper.setActive(arg_16_0._goDetail, false)
	EliminateSelectChessMenListModel.instance:initList()
	arg_16_0:_initSlots()
	arg_16_0:_updateSlots()
	EliminateLevelController.instance:BgSwitch(EliminateEnum.AudioFightStep.ComeShow)
end

function var_0_0._onQuickSelectChessMen(arg_17_0)
	local var_17_0 = EliminateSelectChessMenListModel.instance:getSelectedChessMen()

	if EliminateSelectChessMenListModel.instance:isInAddList(var_17_0) then
		arg_17_0:_btnOutOnClick()
	else
		arg_17_0:_btnAddOnClick()
	end
end

function var_0_0._onChangeChessMen(arg_18_0)
	arg_18_0:_updateSlots()
	arg_18_0:_onSelectChessMen()
end

function var_0_0._onSelectChessMen(arg_19_0)
	local var_19_0 = EliminateSelectChessMenListModel.instance:getSelectedChessMen()

	gohelper.setActive(arg_19_0._goEmpty, not var_19_0)
	gohelper.setActive(arg_19_0._goDetail, var_19_0)

	if not var_19_0 then
		return
	end

	local var_19_1 = var_19_0.config

	arg_19_0._txtFireNum.text = var_19_1.defaultPower

	local var_19_2 = arg_19_0:_getSkillDesc(var_19_1.skillId)

	arg_19_0._txtDescr.text = EliminateLevelModel.instance.formatString(var_19_2, EliminateTeamChessEnum.PreBattleFormatType)
	arg_19_0._txtChessName.text = var_19_1.name

	arg_19_0:_showOperationBtns()
	UISpriteSetMgr.instance:setV2a2EliminateSprite(arg_19_0._imageChessQualityBG, "v2a2_eliminate_infochess_qualitybg_0" .. var_19_1.level, false)

	local var_19_3 = var_19_0.costList

	gohelper.CreateObjList(arg_19_0, arg_19_0._onItemShow, var_19_3, arg_19_0._goResource, arg_19_0._goResourceItem)
	UISpriteSetMgr.instance:setV2a2ChessSprite(arg_19_0._imageChess, var_19_1.resPic, false)
	gohelper.setActive(arg_19_0._goStar1, false)
end

function var_0_0._getSkillDesc(arg_20_0, arg_20_1)
	local var_20_0 = ""
	local var_20_1 = string.splitToNumber(arg_20_1, "#")

	for iter_20_0, iter_20_1 in ipairs(var_20_1) do
		local var_20_2 = lua_soldier_skill.configDict[iter_20_1]

		var_20_0 = string.nilorempty(var_20_0) and var_20_2.skillDes or var_20_0 .. "\n" .. var_20_2.skillDes
	end

	return var_20_0
end

function var_0_0._onItemShow(arg_21_0, arg_21_1, arg_21_2, arg_21_3)
	local var_21_0 = gohelper.findChildImage(arg_21_1, "#image_ResourceQuality")
	local var_21_1 = gohelper.findChildText(arg_21_1, "#image_ResourceQuality/#txt_ResourceNum")
	local var_21_2 = arg_21_2[1]

	UISpriteSetMgr.instance:setV2a2EliminateSprite(var_21_0, EliminateTeamChessEnum.ResourceTypeToImagePath[var_21_2], false)

	var_21_1.text = arg_21_2[2]
end

function var_0_0._showOperationBtns(arg_22_0)
	local var_22_0 = EliminateSelectChessMenListModel.instance:getSelectedChessMen()
	local var_22_1 = EliminateSelectChessMenListModel.instance:isInAddList(var_22_0)

	if EliminateSelectChessMenListModel.instance:getQuickEdit() or EliminateTeamSelectionModel.instance:isPreset() then
		gohelper.setActive(arg_22_0._btnAdd, false)
		gohelper.setActive(arg_22_0._btnOut, false)

		return
	end

	gohelper.setActive(arg_22_0._btnAdd, not var_22_1)
	gohelper.setActive(arg_22_0._btnOut, var_22_1)
end

function var_0_0._initSlots(arg_23_0)
	arg_23_0._slotList = arg_23_0:getUserDataTb_()

	local var_23_0 = arg_23_0.viewContainer:getSetting().otherRes[2]

	for iter_23_0 = 1, 8 do
		local var_23_1 = arg_23_0:getResInst(var_23_0, arg_23_0._goSlot)
		local var_23_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_23_1, EliminateSelectChessMenSlot)

		arg_23_0._slotList[iter_23_0] = var_23_2

		var_23_2:setIndex(iter_23_0)
	end
end

function var_0_0._updateSlots(arg_24_0)
	for iter_24_0, iter_24_1 in ipairs(arg_24_0._slotList) do
		local var_24_0 = EliminateSelectChessMenListModel.instance:getAddChessMen(iter_24_0)

		iter_24_1:onUpdateMO(var_24_0)
	end
end

function var_0_0.onOpen(arg_25_0)
	arg_25_0:_refreshBtnStatus()
	arg_25_0:_refreshQuickEditBtnStatus()
end

function var_0_0.onClose(arg_26_0)
	return
end

function var_0_0.onDestroyView(arg_27_0)
	EliminateSelectChessMenListModel.instance:clearList()
end

return var_0_0
