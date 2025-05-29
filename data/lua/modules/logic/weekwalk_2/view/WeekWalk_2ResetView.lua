module("modules.logic.weekwalk_2.view.WeekWalk_2ResetView", package.seeall)

local var_0_0 = class("WeekWalk_2ResetView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageline = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_line")
	arg_1_0._goprogress = gohelper.findChild(arg_1_0.viewGO, "#go_progress")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "levelinfo/#simage_bg")
	arg_1_0._txtlevelname = gohelper.findChildText(arg_1_0.viewGO, "levelinfo/#go_selectlevel/#txt_levelname")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "levelinfo/#go_empty")
	arg_1_0._gounselectlevel = gohelper.findChild(arg_1_0.viewGO, "levelinfo/#go_unselectlevel")
	arg_1_0._gounfinishlevel = gohelper.findChild(arg_1_0.viewGO, "levelinfo/#go_unfinishlevel")
	arg_1_0._gorevive = gohelper.findChild(arg_1_0.viewGO, "levelinfo/#go_revive")
	arg_1_0._goroles = gohelper.findChild(arg_1_0.viewGO, "levelinfo/#go_roles")
	arg_1_0._goheroitem = gohelper.findChild(arg_1_0.viewGO, "levelinfo/#go_roles/#go_heroitem")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "levelinfo/#btn_reset")
	arg_1_0._goselectlevel = gohelper.findChild(arg_1_0.viewGO, "levelinfo/#go_selectlevel")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreset:RemoveClickListener()
end

function var_0_0._btnresetOnClick(arg_4_0)
	if not arg_4_0._selectedBattleItem then
		return
	end

	if arg_4_0._selectedBattleItem:getBattleInfo().star <= 0 then
		return
	end

	local var_4_0 = 0

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._battleItemList) do
		local var_4_1 = iter_4_1 == arg_4_0._selectedBattleItem

		var_4_0 = iter_4_1:getBattleInfo().battleId

		if var_4_1 then
			break
		end
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.WeekWalkResetLayerBattle, MsgBoxEnum.BoxType.Yes_No, function()
		Weekwalk_2Rpc.instance:sendWeekwalkVer2ResetLayerRequest(arg_4_0._mapId, var_4_0, arg_4_0.closeThis, arg_4_0)
	end, nil, nil, nil, nil, nil, arg_4_0:_getBattleName())
end

function var_0_0._editableInitView(arg_6_0)
	gohelper.addUIClickAudio(arg_6_0._btnreset.gameObject, AudioEnum.UI.UI_vertical_first_tabs_click)

	arg_6_0._resetBtnCanvasGroup = gohelper.onceAddComponent(arg_6_0._btnreset.gameObject, typeof(UnityEngine.CanvasGroup))
	arg_6_0._mapInfo = WeekWalk_2Model.instance:getCurMapInfo()
	arg_6_0._sceneConfig = arg_6_0._mapInfo.sceneConfig
	arg_6_0._mapId = arg_6_0._mapInfo.id
	arg_6_0._heroItemList = nil

	arg_6_0._simagebg:LoadImage(ResUrl.getWeekWalkBg("dreamrewardbg.png"))
	arg_6_0._simageline:LoadImage(ResUrl.getWeekWalkBg("hw2.png"))

	arg_6_0._needShowHeros = true

	gohelper.setActive(arg_6_0._gorevive, arg_6_0._needShowHeros)
	gohelper.setActive(arg_6_0._goempty, not arg_6_0._needShowHeros)

	if arg_6_0._needShowHeros then
		arg_6_0:_showHeros()
	end

	arg_6_0:_showBattleList()
	arg_6_0:_initFinishStatus()
	arg_6_0:_showCurLevel()
end

function var_0_0._showCurLevel(arg_7_0)
	local var_7_0 = 1
	local var_7_1 = arg_7_0._mapInfo.battleInfos

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		local var_7_2 = iter_7_0

		if iter_7_1.star <= 0 then
			break
		end
	end
end

function var_0_0._initFinishStatus(arg_8_0)
	gohelper.setActive(arg_8_0._goselectlevel, false)

	local var_8_0 = arg_8_0._mapInfo:getHasStarIndex()

	arg_8_0._resetBtnCanvasGroup.alpha = 0.3

	if var_8_0 <= 0 then
		gohelper.setActive(arg_8_0._gounfinishlevel, true)

		return
	end

	gohelper.setActive(arg_8_0._gounselectlevel, true)
end

function var_0_0._showBattleList(arg_9_0)
	arg_9_0._battleItemList = arg_9_0:getUserDataTb_()

	local var_9_0 = arg_9_0._mapInfo.battleInfos

	for iter_9_0, iter_9_1 in ipairs(var_9_0) do
		local var_9_1 = arg_9_0.viewContainer:getSetting().otherRes[1]
		local var_9_2 = arg_9_0:getResInst(var_9_1, arg_9_0._goprogress)
		local var_9_3 = MonoHelper.addLuaComOnceToGo(var_9_2, WeekWalk_2ResetBattleItem, {
			arg_9_0,
			iter_9_1,
			iter_9_0,
			var_9_0
		})

		table.insert(arg_9_0._battleItemList, var_9_3)
	end
end

function var_0_0.selectBattleItem(arg_10_0, arg_10_1)
	if arg_10_0._selectedBattleItem == arg_10_1 then
		arg_10_0._selectedBattleItem = nil
	else
		arg_10_0._selectedBattleItem = arg_10_1
	end

	local var_10_0

	for iter_10_0, iter_10_1 in ipairs(arg_10_0._battleItemList) do
		local var_10_1 = iter_10_1 == arg_10_0._selectedBattleItem

		if var_10_1 then
			var_10_0 = iter_10_0

			arg_10_0:_showSelectBattleInfo(arg_10_1, iter_10_0)
		end

		iter_10_1:setSelect(var_10_1)
		iter_10_1:setFakedReset(var_10_0, var_10_1)
	end

	gohelper.setActive(arg_10_0._gounselectlevel, not arg_10_0._selectedBattleItem)

	if arg_10_0._needShowHeros then
		arg_10_0:_showHeros()
	end

	if not arg_10_0._selectedBattleItem then
		arg_10_0._resetBtnCanvasGroup.alpha = 0.3

		gohelper.setActive(arg_10_0._goselectlevel, false)
	end
end

function var_0_0._showSelectBattleInfo(arg_11_0, arg_11_1, arg_11_2)
	arg_11_0._battleIndex = arg_11_2

	gohelper.setActive(arg_11_0._goselectlevel, true)

	arg_11_0._txtlevelname.text = arg_11_0:_getBattleName()

	gohelper.setActive(arg_11_0._gounselectlevel, false)

	arg_11_0._resetBtnCanvasGroup.alpha = 1

	if arg_11_0._needShowHeros then
		arg_11_0:_showHeros()
	end
end

function var_0_0._showHeros(arg_12_0)
	if not arg_12_0._heroItemList then
		arg_12_0._heroItemList = arg_12_0:getUserDataTb_()

		for iter_12_0 = 1, 4 do
			local var_12_0 = gohelper.cloneInPlace(arg_12_0._goheroitem)

			gohelper.setActive(var_12_0, true)

			local var_12_1 = arg_12_0:getUserDataTb_()

			var_12_1._goempty = gohelper.findChild(var_12_0, "go_empty")
			var_12_1._gohero = gohelper.findChild(var_12_0, "go_hero")
			var_12_1._simageheroicon = gohelper.findChildSingleImage(var_12_0, "go_hero/simage_heroicon")
			var_12_1._imagecareer = gohelper.findChildImage(var_12_0, "go_hero/image_career")
			arg_12_0._heroItemList[iter_12_0] = var_12_1
		end
	end

	local var_12_2 = arg_12_0._selectedBattleItem and arg_12_0._selectedBattleItem:getPrevBattleInfo()
	local var_12_3 = var_12_2 and var_12_2.heroIds

	for iter_12_1, iter_12_2 in ipairs(arg_12_0._heroItemList) do
		local var_12_4 = var_12_3 and var_12_3[iter_12_1]
		local var_12_5 = arg_12_0._heroItemList[iter_12_1]

		gohelper.setActive(var_12_5._goempty, not var_12_4)
		gohelper.setActive(var_12_5._gohero, var_12_4)

		if var_12_4 then
			local var_12_6 = HeroConfig.instance:getHeroCO(var_12_4)
			local var_12_7 = SkinConfig.instance:getSkinCo(var_12_6.skinId)

			var_12_5._simageheroicon:LoadImage(ResUrl.getHeadIconSmall(var_12_7.headIcon))
			UISpriteSetMgr.instance:setCommonSprite(var_12_5._imagecareer, "lssx_" .. var_12_6.career)
		end
	end
end

function var_0_0._getBattleName(arg_13_0)
	return string.format("%s-0%s", arg_13_0._sceneConfig.battleName, arg_13_0._battleIndex)
end

function var_0_0.onOpen(arg_14_0)
	return
end

function var_0_0.onClose(arg_15_0)
	return
end

function var_0_0.onDestroyView(arg_16_0)
	if arg_16_0._heroItemList then
		for iter_16_0, iter_16_1 in ipairs(arg_16_0._heroItemList) do
			iter_16_1._simageheroicon:UnLoadImage()
		end
	end

	arg_16_0._simagebg:UnLoadImage()
	arg_16_0._simageline:UnLoadImage()
end

return var_0_0
