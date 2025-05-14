module("modules.logic.weekwalk.view.WeekWalkEnemyInfoView", package.seeall)

local var_0_0 = class("WeekWalkEnemyInfoView", BaseView)

function var_0_0.onOpen(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._simagebattlelistbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "go_battlelist/#simage_battlelistbg")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_battlelist/#btn_reset", AudioEnum.WeekWalk.play_artificial_ui_resetmap)
	arg_1_0._mapId = arg_1_0.viewParam.mapId

	arg_1_0._simagebattlelistbg:LoadImage(ResUrl.getWeekWalkBg("bg_zuodi.png"))

	local var_1_0 = WeekWalkModel.instance:getInfo():getMapInfo(arg_1_0._mapId)
	local var_1_1 = var_1_0.battleIds

	if not arg_1_0.viewParam.battleId then
		arg_1_0.viewParam.battleId = var_1_1[1]
	end

	arg_1_0._battleIds = var_1_1
	arg_1_0._mapConfig = WeekWalkConfig.instance:getMapConfig(arg_1_0._mapId)

	if lua_weekwalk_type.configDict[arg_1_0._mapConfig.type].showDetail <= 0 and var_1_0.isFinish <= 0 then
		gohelper.setActive(arg_1_0._btnreset.gameObject, false)
		gohelper.setActive(gohelper.findChild(arg_1_0.viewGO, "go_battlelist"), false)
		arg_1_0:_doUpdateSelectIcon(arg_1_0.viewParam.battleId)

		return
	end

	arg_1_0._gobattlebtntemplate = gohelper.findChild(arg_1_0.viewGO, "go_battlelist/scroll_battle/Viewport/battlelist/#go_battlebtntemplate")
	arg_1_0._btnList = arg_1_0:getUserDataTb_()
	arg_1_0._statusList = arg_1_0:getUserDataTb_()

	local var_1_2 = 5
	local var_1_3 = math.min(var_1_2, #var_1_0.battleInfos)
	local var_1_4 = var_1_0:getStarNumConfig()

	for iter_1_0 = 1, var_1_3 do
		local var_1_5 = gohelper.cloneInPlace(arg_1_0._gobattlebtntemplate).gameObject
		local var_1_6 = gohelper.findChildButton(var_1_5, "btn")
		local var_1_7 = gohelper.findChildText(var_1_5, "txt")
		local var_1_8 = gohelper.findChild(var_1_5, "selectIcon")

		var_1_7.text = "0" .. iter_1_0

		local var_1_9 = var_1_1[iter_1_0]
		local var_1_10 = var_1_0:getBattleInfo(var_1_9)
		local var_1_11 = gohelper.findChild(var_1_5, "star2")
		local var_1_12 = gohelper.findChild(var_1_5, "star3")
		local var_1_13 = var_1_4 <= 2 and var_1_11 or var_1_12

		gohelper.setActive(var_1_11, false)
		gohelper.setActive(var_1_12, false)
		gohelper.setActive(var_1_13, true)

		local var_1_14 = var_1_13.transform
		local var_1_15 = var_1_14.childCount
		local var_1_16 = {
			var_1_8,
			var_1_7
		}
		local var_1_17 = 0

		for iter_1_1 = 1, var_1_15 do
			local var_1_18 = var_1_14:GetChild(iter_1_1 - 1):GetComponentInChildren(gohelper.Type_Image)

			UISpriteSetMgr.instance:setWeekWalkSprite(var_1_18, iter_1_1 <= var_1_10.star and "star_highlight4" or "star_null4", true)
			table.insert(var_1_16, var_1_18)
		end

		var_1_6:AddClickListener(arg_1_0._changeBattleId, arg_1_0, var_1_9)
		gohelper.addUIClickAudio(var_1_6.gameObject, AudioEnum.WeekWalk.play_artificial_ui_checkpointswitch)
		gohelper.setActive(var_1_5, true)
		table.insert(arg_1_0._statusList, var_1_16)
		table.insert(arg_1_0._btnList, var_1_6)
	end

	arg_1_0._btnreset:AddClickListener(arg_1_0._reset, arg_1_0)

	local var_1_19 = WeekWalkConfig.instance:getMapTypeConfig(arg_1_0._mapId).canResetLayer > 0 and ViewMgr.instance:isOpen(ViewName.WeekWalkView)

	if arg_1_0.viewParam.hideResetBtn then
		var_1_19 = false
	end

	gohelper.setActive(arg_1_0._btnreset.gameObject, var_1_19 and false)

	if var_1_19 then
		WeekWalkController.instance:dispatchEvent(WeekWalkEvent.GuideShowResetBtn)
	end

	arg_1_0:_doUpdateSelectIcon(arg_1_0.viewParam.battleId)
end

function var_0_0._reset(arg_2_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.WeekWalkResetLayer, MsgBoxEnum.BoxType.Yes_No, function()
		WeekwalkRpc.instance:sendResetLayerRequest(arg_2_0._mapId)
		arg_2_0:closeThis()
	end)
end

function var_0_0._changeBattleId(arg_4_0, arg_4_1)
	if not arg_4_1 then
		return
	end

	local var_4_0 = arg_4_0.viewContainer:getEnemyInfoView()

	var_4_0._battleId = arg_4_1

	var_4_0:_refreshUI()
	arg_4_0:_updateSelectIcon()
end

function var_0_0._updateSelectIcon(arg_5_0)
	local var_5_0 = arg_5_0.viewContainer:getEnemyInfoView()

	arg_5_0:_doUpdateSelectIcon(var_5_0._battleId)
end

function var_0_0._doUpdateSelectIcon(arg_6_0, arg_6_1)
	arg_6_0.viewContainer:getWeekWalkEnemyInfoViewRule():refreshUI(arg_6_1)

	if not arg_6_0._statusList then
		return
	end

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._battleIds) do
		local var_6_0 = iter_6_1 == arg_6_1
		local var_6_1 = arg_6_0._statusList[iter_6_0]

		if not var_6_1 then
			break
		end

		gohelper.setActive(var_6_1[1], var_6_0)

		if var_6_0 then
			SLFramework.UGUI.GuiHelper.SetColor(var_6_1[2], "#FFFFFF")
			SLFramework.UGUI.GuiHelper.SetColor(var_6_1[3], "#FFFFFF")
			SLFramework.UGUI.GuiHelper.SetColor(var_6_1[4], "#FFFFFF")
		else
			SLFramework.UGUI.GuiHelper.SetColor(var_6_1[2], "#6c6f64")
			SLFramework.UGUI.GuiHelper.SetColor(var_6_1[3], "#C1C5B6")
			SLFramework.UGUI.GuiHelper.SetColor(var_6_1[4], "#C1C5B6")
		end

		if var_6_1[5] then
			SLFramework.UGUI.GuiHelper.SetColor(var_6_1[5], var_6_0 and "#FFFFFF" or "#C1C5B6")
		end
	end
end

function var_0_0.onDestroyView(arg_7_0)
	var_0_0.super.onDestroyView(arg_7_0)

	if arg_7_0._btnList then
		for iter_7_0, iter_7_1 in ipairs(arg_7_0._btnList) do
			iter_7_1:RemoveClickListener()
		end
	end

	arg_7_0._btnreset:RemoveClickListener()
	arg_7_0._simagebattlelistbg:UnLoadImage()
end

return var_0_0
