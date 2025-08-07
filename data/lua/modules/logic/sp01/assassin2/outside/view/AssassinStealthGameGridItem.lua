module("modules.logic.sp01.assassin2.outside.view.AssassinStealthGameGridItem", package.seeall)

local var_0_0 = class("AssassinStealthGameGridItem", LuaCompBase)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.trans = arg_1_0.go.transform

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0._editableInitView(arg_2_0)
	arg_2_0._gocontent = gohelper.findChild(arg_2_0.go, "#go_content")
	arg_2_0._transcontent = arg_2_0._gocontent.transform
	arg_2_0._simagegrid = gohelper.findChildSingleImage(arg_2_0.go, "#go_content/#simage_grid")
	arg_2_0._transimggrid = arg_2_0._simagegrid.transform
	arg_2_0._goqte = gohelper.findChild(arg_2_0.go, "#go_content/#go_qte")
	arg_2_0._gopointparent = gohelper.findChild(arg_2_0.go, "#go_content/#go_points")
	arg_2_0._gopointitem = gohelper.findChild(arg_2_0.go, "#go_content/#go_points/#go_pointItem")
	arg_2_0._gotrace = gohelper.findChild(arg_2_0.go, "#go_content/#go_trace")
	arg_2_0._transtrace = arg_2_0._gotrace.transform
	arg_2_0._gowarning = gohelper.findChild(arg_2_0.go, "#go_content/#go_warring")
	arg_2_0._goInfoLayout = gohelper.findChild(arg_2_0.go, "#go_content/#go_infoLayout")
	arg_2_0._goEnemyRefresh = gohelper.findChild(arg_2_0.go, "#go_content/#go_infoLayout/#image_legend")
	arg_2_0._imageEnemyRefreshIcon = gohelper.findChildImage(arg_2_0.go, "#go_content/#go_infoLayout/#image_legend")
	arg_2_0._goexpose = gohelper.findChild(arg_2_0.go, "#go_content/#go_infoLayout/#go_expose")
	arg_2_0._txtexpose = gohelper.findChildText(arg_2_0.go, "#go_content/#go_infoLayout/#go_expose/#txt_expose")
	arg_2_0._entranceNodeDict = arg_2_0:getUserDataTb_()

	local var_2_0 = gohelper.findChild(arg_2_0.go, "#go_content/#go_roofEntrance/#go_up")
	local var_2_1 = gohelper.findChild(arg_2_0.go, "#go_content/#go_roofEntrance/#go_down")
	local var_2_2 = gohelper.findChild(arg_2_0.go, "#go_content/#go_roofEntrance/#go_left")
	local var_2_3 = gohelper.findChild(arg_2_0.go, "#go_content/#go_roofEntrance/#go_right")

	arg_2_0._entranceNodeDict[AssassinEnum.RoofEntranceDir.Up] = var_2_0.transform
	arg_2_0._entranceNodeDict[AssassinEnum.RoofEntranceDir.Down] = var_2_1.transform
	arg_2_0._entranceNodeDict[AssassinEnum.RoofEntranceDir.Left] = var_2_2.transform
	arg_2_0._entranceNodeDict[AssassinEnum.RoofEntranceDir.Right] = var_2_3.transform
	arg_2_0._btnclick = gohelper.findChildClickWithAudio(arg_2_0.go, "#go_content/#go_clickParent/#btn_click", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	arg_2_0._gohlicon = gohelper.findChild(arg_2_0.go, "#go_content/#go_clickParent/#btn_click/#go_hlicon")
	arg_2_0._imagehlicon = gohelper.findChildImage(arg_2_0.go, "#go_content/#go_clickParent/#btn_click/#go_hlicon/#image_hlicon")
	arg_2_0._transclick = arg_2_0._btnclick.transform
	arg_2_0._transclickParent = gohelper.findChild(arg_2_0.go, "#go_content/#go_clickParent").transform
	arg_2_0._effectComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_2_0.go, AssassinStealthGameEffectComp)

	arg_2_0:_initPoints()
	arg_2_0:_checkShow()
end

function var_0_0._initPoints(arg_3_0)
	arg_3_0.pointItemList = {}

	local var_3_0 = AssassinConfig.instance:getGridPointPosList()

	gohelper.CreateObjList(arg_3_0, arg_3_0._onCreatePointItem, var_3_0, arg_3_0._gopointparent, arg_3_0._gopointitem)
end

function var_0_0._onCreatePointItem(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	local var_4_0 = arg_4_0:getUserDataTb_()

	var_4_0.go = arg_4_1
	var_4_0.trans = var_4_0.go.transform
	var_4_0.go.name = arg_4_3
	var_4_0.gocontent = gohelper.findChild(var_4_0.go, "#go_pointContent")
	var_4_0.transcontent = var_4_0.gocontent.transform
	var_4_0.imageicon = gohelper.findChildImage(var_4_0.go, "#go_pointContent/#image_icon")
	var_4_0.iconTrans = var_4_0.imageicon.transform
	var_4_0.btn = gohelper.findChildClickWithAudio(var_4_0.go, "#go_pointContent/#image_icon/#btn_click", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	var_4_0.normalhl = gohelper.findChild(var_4_0.go, "#go_pointContent/#image_icon/#btn_click/highlight")
	var_4_0.gardenhl = gohelper.findChild(var_4_0.go, "#go_pointContent/#image_icon/#btn_click/highlight_garden")
	var_4_0.haystackhl = gohelper.findChild(var_4_0.go, "#go_pointContent/#image_icon/#btn_click/highlight_haystack")
	var_4_0.haystackhl1 = gohelper.findChild(var_4_0.go, "#go_pointContent/#image_icon/#btn_click/highlight_haystack_01")

	var_4_0.btn:AddClickListener(arg_4_0._clickPoint, arg_4_0, arg_4_3)
	transformhelper.setLocalPosXY(var_4_0.trans, arg_4_2.x, arg_4_2.y)

	arg_4_0.pointItemList[arg_4_3] = var_4_0
end

function var_0_0.addEventListeners(arg_5_0)
	arg_5_0._btnclick:AddClickListener(arg_5_0._btnclickOnClick, arg_5_0)
end

function var_0_0.removeEventListeners(arg_6_0)
	arg_6_0._btnclick:RemoveClickListener()

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.pointItemList) do
		iter_6_1.btn:RemoveClickListener()
	end
end

function var_0_0._btnclickOnClick(arg_7_0)
	AssassinStealthGameController.instance:clickGridItem(arg_7_0.id)
end

function var_0_0._clickPoint(arg_8_0, arg_8_1)
	AssassinStealthGameController.instance:clickGridItem(arg_8_0.id, arg_8_1)
end

function var_0_0.initData(arg_9_0, arg_9_1)
	arg_9_0.id = arg_9_1
	arg_9_0.go.name = arg_9_0.id
	arg_9_0._goInfoLayout.name = string.format("gridInfo-%s", arg_9_0.id)
end

function var_0_0.setEffParent(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._effectParent = arg_10_1
	arg_10_0._effectParentTrans = arg_10_2
end

function var_0_0.setMap(arg_11_0, arg_11_1)
	arg_11_0.mapId = arg_11_1

	local var_11_0 = arg_11_0:getGoPosition()

	arg_11_0._effPos = arg_11_0._effectParentTrans:InverseTransformPoint(var_11_0)

	arg_11_0:_checkShow()
end

function var_0_0._checkShow(arg_12_0)
	arg_12_0._isShow = AssassinConfig.instance:isShowGrid(arg_12_0.mapId, arg_12_0.id)

	arg_12_0:setGrid()
	arg_12_0:refresh()

	local var_12_0

	if arg_12_0._isShow then
		var_12_0 = AssassinStealthGameEntityMgr.instance:getInfoTrans()
	end

	if gohelper.isNil(var_12_0) then
		var_12_0 = arg_12_0._transcontent
	end

	arg_12_0._goInfoLayout.transform:SetParent(var_12_0, true)
	gohelper.setActive(arg_12_0._gocontent, arg_12_0._isShow)
end

function var_0_0.setGrid(arg_13_0)
	if not arg_13_0._isShow then
		return
	end

	arg_13_0:setGridType()
	arg_13_0:setPoint()
	arg_13_0:setIsEasyExpose()
end

function var_0_0.setGridType(arg_14_0)
	local var_14_0 = AssassinConfig.instance:getStealthGridImg(arg_14_0.mapId, arg_14_0.id)

	if not string.nilorempty(var_14_0) then
		local var_14_1 = ResUrl.getSp01AssassinSingleBg("stealth/" .. var_14_0)

		arg_14_0._simagegrid:LoadImage(var_14_1)
	end

	local var_14_2 = AssassinConfig.instance:getStealthGridRotation(arg_14_0.mapId, arg_14_0.id)

	transformhelper.setLocalRotation(arg_14_0._transimggrid, 0, 0, var_14_2)
end

function var_0_0.setPoint(arg_15_0)
	if not arg_15_0.pointItemList then
		return
	end

	for iter_15_0, iter_15_1 in ipairs(arg_15_0.pointItemList) do
		local var_15_0 = 0
		local var_15_1 = 0
		local var_15_2 = AssassinConfig.instance:getGridPointType(arg_15_0.mapId, arg_15_0.id, iter_15_0)

		if var_15_2 and var_15_2 ~= AssassinEnum.StealthGamePointType.Empty then
			local var_15_3, var_15_4 = AssassinConfig.instance:getPointTypeShowData(arg_15_0.mapId, arg_15_0.id, iter_15_0)

			if var_15_2 == AssassinEnum.StealthGamePointType.Tower then
				local var_15_5 = AssassinEnum.TowerPointPos[iter_15_0]

				var_15_0 = var_15_5 and var_15_5.x or var_15_0
				var_15_1 = var_15_5 and var_15_5.y or var_15_1
				var_15_3 = string.format("%s_%s", var_15_3, iter_15_0)
			elseif var_15_2 == AssassinEnum.StealthGamePointType.Garden then
				gohelper.setActive(iter_15_1.normalhl, false)
				gohelper.setActive(iter_15_1.gardenhl, true)
				gohelper.setActive(iter_15_1.haystackhl, false)
				gohelper.setActive(iter_15_1.haystackhl1, false)
			elseif var_15_2 == AssassinEnum.StealthGamePointType.HayStack then
				gohelper.setActive(iter_15_1.normalhl, false)
				gohelper.setActive(iter_15_1.gardenhl, false)

				local var_15_6 = var_15_3 == "assassin2_stealth_game_haystack_01"

				gohelper.setActive(iter_15_1.haystackhl, not var_15_6)
				gohelper.setActive(iter_15_1.haystackhl1, var_15_6)
			else
				gohelper.setActive(iter_15_1.normalhl, true)
				gohelper.setActive(iter_15_1.gardenhl, false)
				gohelper.setActive(iter_15_1.haystackhl, false)
				gohelper.setActive(iter_15_1.haystackhl1, false)
			end

			UISpriteSetMgr.instance:setSp01AssassinSprite(iter_15_1.imageicon, var_15_3, true)
			transformhelper.setEulerAngles(iter_15_1.transcontent, 0, 0, var_15_4)
			gohelper.setActive(iter_15_1.gocontent, true)
		else
			gohelper.setActive(iter_15_1.gocontent, false)
		end

		transformhelper.setLocalPosXY(iter_15_1.iconTrans, var_15_0, var_15_1)
	end
end

function var_0_0.setIsEasyExpose(arg_16_0)
	local var_16_0 = AssassinConfig.instance:getGridIsEasyExpose(arg_16_0.mapId, arg_16_0.id)

	gohelper.setActive(arg_16_0._gowarning, var_16_0)
end

function var_0_0.changeHighlightClickParent(arg_17_0, arg_17_1)
	if gohelper.isNil(arg_17_1) then
		arg_17_0._transclick:SetParent(arg_17_0._transclickParent)
	else
		arg_17_0._transclick:SetParent(arg_17_1)
	end

	arg_17_0:refreshHighlightPos()
end

function var_0_0.refreshHighlightPos(arg_18_0)
	local var_18_0 = arg_18_0:getGoPosition()
	local var_18_1 = arg_18_0._transclick.parent:InverseTransformPoint(var_18_0)

	transformhelper.setLocalPosXY(arg_18_0._transclick, var_18_1.x, var_18_1.y)
end

function var_0_0.refresh(arg_19_0, arg_19_1)
	arg_19_0:refreshGridCanClick()
	arg_19_0:refreshPointCanClick()
	arg_19_0:refreshIsQteGrid()
	arg_19_0:refreshTrace()
	arg_19_0:refreshEnemyRefreshPoint()
	arg_19_0:refreshTrap()
	arg_19_0:playEffect(arg_19_1)
end

function var_0_0.refreshGridCanClick(arg_20_0)
	if not arg_20_0._isShow then
		return
	end

	local var_20_0 = AssassinStealthGameHelper.isSelectedHeroCanMoveTo(arg_20_0.id)
	local var_20_1 = AssassinStealthGameHelper.isSelectedHeroCanUseSkillPropToGrid(arg_20_0.id)
	local var_20_2 = AssassinStealthGameModel.instance:isHasAliveEnemy(arg_20_0.id)

	if var_20_0 and var_20_2 then
		local var_20_3 = AssassinStealthGameModel.instance:getExposeRate(arg_20_0.id)

		arg_20_0._txtexpose.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("percent"), var_20_3)

		gohelper.setActive(arg_20_0._goexpose, true)
	else
		gohelper.setActive(arg_20_0._goexpose, false)
	end

	if var_20_1 then
		local var_20_4, var_20_5 = AssassinStealthGameModel.instance:getSelectedSkillProp()

		if var_20_5 then
			AssassinHelper.setAssassinSkillIcon(var_20_4, arg_20_0._imagehlicon)
		else
			AssassinHelper.setAssassinItemIcon(var_20_4, arg_20_0._imagehlicon)
		end
	end

	gohelper.setActive(arg_20_0._gohlicon, var_20_1)
	gohelper.setActive(arg_20_0._btnclick, var_20_0 or var_20_1)
end

function var_0_0.refreshPointCanClick(arg_21_0)
	if not arg_21_0._isShow then
		return
	end

	for iter_21_0, iter_21_1 in ipairs(arg_21_0.pointItemList) do
		local var_21_0 = false
		local var_21_1 = AssassinConfig.instance:getGridPointType(arg_21_0.mapId, arg_21_0.id, iter_21_0)

		if var_21_1 and var_21_1 ~= AssassinEnum.StealthGamePointType.Empty then
			var_21_0 = AssassinStealthGameHelper.isSelectedHeroCanMoveTo(arg_21_0.id, iter_21_0)
		end

		gohelper.setActive(iter_21_1.btn, var_21_0)
	end
end

function var_0_0.refreshIsQteGrid(arg_22_0)
	if not arg_22_0._isShow then
		return
	end

	local var_22_0 = false

	if AssassinStealthGameModel.instance:isQTEInteractGrid(arg_22_0.id) then
		var_22_0 = true
	else
		local var_22_1 = AssassinStealthGameModel.instance:getMissionId()

		if var_22_1 and var_22_1 ~= 0 then
			local var_22_2 = AssassinConfig.instance:getStealthMissionType(var_22_1)

			if var_22_2 == AssassinEnum.MissionType.TargetGrid1 or var_22_2 == AssassinEnum.MissionType.TargetGrid2 or var_22_2 == AssassinEnum.MissionType.TargetGrid3 then
				local var_22_3 = AssassinConfig.instance:getStealthMissionParam(var_22_1, true)

				if var_22_3 then
					for iter_22_0, iter_22_1 in ipairs(var_22_3) do
						if iter_22_1 == arg_22_0.id then
							var_22_0 = true

							break
						end
					end
				end
			end
		end
	end

	gohelper.setActive(arg_22_0._goqte, var_22_0)
end

function var_0_0.refreshTrace(arg_23_0)
	local var_23_0
	local var_23_1 = AssassinStealthGameModel.instance:getGridMo(arg_23_0.id)
	local var_23_2 = var_23_1 and var_23_1:getTracePointIndex()

	if var_23_2 and var_23_2 > 0 then
		var_23_0 = arg_23_0:getPointTrans(var_23_2)
	end

	if gohelper.isNil(var_23_0) then
		gohelper.setActive(arg_23_0._gotrace, false)
	else
		arg_23_0._transtrace:SetParent(var_23_0, false)
		gohelper.setActive(arg_23_0._gotrace, true)
	end
end

function var_0_0.refreshEnemyRefreshPoint(arg_24_0)
	local var_24_0
	local var_24_1 = AssassinStealthGameModel.instance:getMissionId()

	if var_24_1 and var_24_1 ~= 0 then
		local var_24_2 = AssassinStealthGameModel.instance:isAlertBellRing()
		local var_24_3, var_24_4 = AssassinConfig.instance:getStealthMissionRefresh(var_24_1)
		local var_24_5 = var_24_2 and var_24_4 or var_24_3

		var_24_0 = AssassinConfig.instance:getEnemyRefreshData(var_24_5, arg_24_0.id)
	end

	if var_24_0 then
		UISpriteSetMgr.instance:setSp01AssassinSprite(arg_24_0._imageEnemyRefreshIcon, string.format("%s%s", "assassinstealthoverview_legend_enemy_refresh_", var_24_0.index))
	end

	gohelper.setActive(arg_24_0._goEnemyRefresh, var_24_0)
end

function var_0_0.refreshTrap(arg_25_0)
	local var_25_0 = AssassinStealthGameModel.instance:getGridMo(arg_25_0.id)

	if not var_25_0 then
		return
	end

	if var_25_0:getHasFog() then
		arg_25_0:playEffect(AssassinEnum.EffectId.GridFog)
	else
		arg_25_0:removeEffect(AssassinEnum.EffectId.GridFog)
	end

	local var_25_1 = AssassinConfig.instance:getTrapTypeList()

	for iter_25_0, iter_25_1 in ipairs(var_25_1) do
		local var_25_2 = AssassinConfig.instance:getAssassinTrapEffectId(iter_25_1[1])

		if var_25_0:hasTrapType(iter_25_0) then
			arg_25_0:playEffect(var_25_2)
		else
			arg_25_0:removeEffect(var_25_2)
		end
	end
end

function var_0_0.playEffect(arg_26_0, arg_26_1, arg_26_2, arg_26_3, arg_26_4, arg_26_5, arg_26_6)
	if arg_26_0._isShow and arg_26_0._effectComp then
		if gohelper.isNil(arg_26_5) then
			arg_26_0._effectComp:playEffect(arg_26_1, arg_26_2, arg_26_3, arg_26_4, arg_26_0._effectParent, arg_26_0._effPos)
		else
			arg_26_0._effectComp:playEffect(arg_26_1, arg_26_2, arg_26_3, arg_26_4, arg_26_5, arg_26_6)
		end
	end
end

function var_0_0.removeEffect(arg_27_0, arg_27_1)
	if not arg_27_0._effectComp or not arg_27_1 or arg_27_1 == 0 then
		return
	end

	arg_27_0._effectComp:removeEffect(arg_27_1)
end

function var_0_0.isShow(arg_28_0)
	return arg_28_0._isShow
end

function var_0_0.getGoPosition(arg_29_0)
	return arg_29_0.trans.position
end

function var_0_0.getPointTrans(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_0.pointItemList[arg_30_1]

	return var_30_0 and var_30_0.trans
end

function var_0_0.getEntranceNodeTrans(arg_31_0, arg_31_1)
	return arg_31_0._entranceNodeDict[arg_31_1]
end

function var_0_0.onDestroy(arg_32_0)
	arg_32_0._simagegrid:UnLoadImage()

	arg_32_0.pointItemList = nil

	gohelper.destroy(arg_32_0._transclick)
	gohelper.destroy(arg_32_0._goInfoLayout)
end

return var_0_0
