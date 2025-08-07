module("modules.logic.sp01.assassin2.outside.view.AssassinStealthGameOverView", package.seeall)

local var_0_0 = class("AssassinStealthGameOverView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclick = gohelper.findChildClickWithAudio(arg_1_0.viewGO, "#simage_Mask", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	arg_1_0._btninfo = gohelper.findChildClickWithAudio(arg_1_0.viewGO, "root/topTab/#btn_info", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	arg_1_0._goinfoUnselect = gohelper.findChild(arg_1_0.viewGO, "root/topTab/#btn_info/#go_infoUnselect")
	arg_1_0._goinfoSelect = gohelper.findChild(arg_1_0.viewGO, "root/topTab/#btn_info/#go_infoSelect")
	arg_1_0._btnevent = gohelper.findChildClickWithAudio(arg_1_0.viewGO, "root/topTab/#btn_event", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	arg_1_0._goeventUnselect = gohelper.findChild(arg_1_0.viewGO, "root/topTab/#btn_event/#go_eventUnselect")
	arg_1_0._goeventSelect = gohelper.findChild(arg_1_0.viewGO, "root/topTab/#btn_event/#go_eventSelect")
	arg_1_0._goinfoView = gohelper.findChild(arg_1_0.viewGO, "root/#go_subView/#go_infoView")
	arg_1_0._gogrids = gohelper.findChild(arg_1_0.viewGO, "root/#go_subView/#go_infoView/mapInfo/#go_map/#go_grids")
	arg_1_0._gogridItem = gohelper.findChild(arg_1_0.viewGO, "root/#go_subView/#go_infoView/mapInfo/#go_map/#go_grids/#go_gridItem")
	arg_1_0._gotowers = gohelper.findChild(arg_1_0.viewGO, "root/#go_subView/#go_infoView/mapInfo/#go_map/#go_towers")
	arg_1_0._gotowerItem = gohelper.findChild(arg_1_0.viewGO, "root/#go_subView/#go_infoView/mapInfo/#go_map/#go_towers/#go_towerItem")
	arg_1_0._gohor = gohelper.findChild(arg_1_0.viewGO, "root/#go_subView/#go_infoView/mapInfo/#go_map/#go_walls/#go_hor")
	arg_1_0._gohorWall = gohelper.findChild(arg_1_0.viewGO, "root/#go_subView/#go_infoView/mapInfo/#go_map/#go_walls/#go_hor/#go_horWall")
	arg_1_0._gover = gohelper.findChild(arg_1_0.viewGO, "root/#go_subView/#go_infoView/mapInfo/#go_map/#go_walls/#go_ver")
	arg_1_0._goverWall = gohelper.findChild(arg_1_0.viewGO, "root/#go_subView/#go_infoView/mapInfo/#go_map/#go_walls/#go_ver/#go_verWall")
	arg_1_0._goreadme = gohelper.findChild(arg_1_0.viewGO, "root/#go_subView/#go_infoView/mapInfo/#go_readme")
	arg_1_0._goreadmeItem = gohelper.findChild(arg_1_0.viewGO, "root/#go_subView/#go_infoView/mapInfo/#go_readme/#go_readmeItem")
	arg_1_0._goselectedgreen = gohelper.findChild(arg_1_0.viewGO, "root/#go_subView/#go_infoView/alarmInfo/green/#go_selected")
	arg_1_0._goselectedred = gohelper.findChild(arg_1_0.viewGO, "root/#go_subView/#go_infoView/alarmInfo/red/#go_selected")
	arg_1_0._goenemyinfolayout = gohelper.findChild(arg_1_0.viewGO, "root/#go_subView/#go_infoView/alarmInfo/layout")
	arg_1_0._goenemyinfoItem = gohelper.findChild(arg_1_0.viewGO, "root/#go_subView/#go_infoView/alarmInfo/layout/#go_enemyInfoItem")
	arg_1_0._goeventView = gohelper.findChild(arg_1_0.viewGO, "root/#go_subView/#go_eventView")
	arg_1_0._simageeventicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#go_subView/#go_eventView/#simage_icon")
	arg_1_0._txteventname = gohelper.findChildText(arg_1_0.viewGO, "root/#go_subView/#go_eventView/name/#txt_name")
	arg_1_0._txteventdesc = gohelper.findChildText(arg_1_0.viewGO, "root/#go_subView/#go_eventView/eff/txt_desc")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_Close", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btninfo:AddClickListener(arg_2_0._btninfoOnClick, arg_2_0)
	arg_2_0._btnevent:AddClickListener(arg_2_0._btneventOnClick, arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btninfo:RemoveClickListener()
	arg_3_0._btnevent:RemoveClickListener()
	arg_3_0._btnClose:RemoveClickListener()
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btninfoOnClick(arg_4_0)
	arg_4_0:setSubViewShow()
	gohelper.setActive(arg_4_0._goinfoSelect, true)
	gohelper.setActive(arg_4_0._goinfoUnselect, false)
	gohelper.setActive(arg_4_0._goeventSelect, false)
	gohelper.setActive(arg_4_0._goeventUnselect, true)
end

function var_0_0._btneventOnClick(arg_5_0)
	arg_5_0:setSubViewShow(true)
	gohelper.setActive(arg_5_0._goinfoSelect, false)
	gohelper.setActive(arg_5_0._goinfoUnselect, true)
	gohelper.setActive(arg_5_0._goeventSelect, true)
	gohelper.setActive(arg_5_0._goeventUnselect, false)
end

function var_0_0._btnCloseOnClick(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._dirGOList = arg_7_0:getUserDataTb_()
	arg_7_0._dirGOList[#arg_7_0._dirGOList + 1] = gohelper.findChild(arg_7_0.viewGO, "root/#go_subView/#go_eventView/moveDir/Dir/up/#go_upLight")
	arg_7_0._dirGOList[#arg_7_0._dirGOList + 1] = gohelper.findChild(arg_7_0.viewGO, "root/#go_subView/#go_eventView/moveDir/Dir/down/#go_downLigth")
	arg_7_0._dirGOList[#arg_7_0._dirGOList + 1] = gohelper.findChild(arg_7_0.viewGO, "root/#go_subView/#go_eventView/moveDir/Dir/left/#go_leftLight")
	arg_7_0._dirGOList[#arg_7_0._dirGOList + 1] = gohelper.findChild(arg_7_0.viewGO, "root/#go_subView/#go_eventView/moveDir/Dir/right/#go_rightLight")

	local var_7_0 = arg_7_0._gogridItem.transform

	arg_7_0.gridWidth = recthelper.getWidth(var_7_0)
	arg_7_0.gridHeight = recthelper.getHeight(var_7_0)
	arg_7_0._setInfoView = nil
	arg_7_0._setEventView = nil
end

function var_0_0.onUpdateParam(arg_8_0)
	arg_8_0._questId = arg_8_0.viewParam and arg_8_0.viewParam.questId

	if arg_8_0._questId then
		if AssassinConfig.instance:getQuestType(arg_8_0._questId) ~= AssassinEnum.QuestType.Stealth then
			logError(string.format("AssassinStealthGameOverView:onUpdateParam error, quest is not stealth, questId:%s", arg_8_0._questId))

			return
		end

		local var_8_0 = AssassinConfig.instance:getQuestParam(arg_8_0._questId)

		arg_8_0._mapId = tonumber(var_8_0)
	else
		arg_8_0._mapId = AssassinStealthGameModel.instance:getMapId()
	end
end

function var_0_0.onOpen(arg_9_0)
	arg_9_0:onUpdateParam()
	arg_9_0:setTabShow()
	arg_9_0:_btninfoOnClick()
end

function var_0_0.setTabShow(arg_10_0)
	local var_10_0 = AssassinStealthGameModel.instance:getEventId()

	gohelper.setActive(arg_10_0._btnevent, not arg_10_0._questId and var_10_0)
end

function var_0_0.setSubViewShow(arg_11_0, arg_11_1)
	if arg_11_1 then
		arg_11_0:setEventView()
	else
		arg_11_0:setInfoView()
	end

	gohelper.setActive(arg_11_0._goinfoView, not arg_11_1)
	gohelper.setActive(arg_11_0._goeventView, arg_11_1)
end

function var_0_0.setEventView(arg_12_0)
	if arg_12_0._setEventView then
		return
	end

	local var_12_0 = AssassinStealthGameModel.instance:getEventId()
	local var_12_1 = AssassinConfig.instance:getEventImg(var_12_0)

	if not string.nilorempty(var_12_1) then
		local var_12_2 = ResUrl.getSp01AssassinSingleBg("stealth/" .. var_12_1)

		arg_12_0._simageeventicon:LoadImage(var_12_2)
	end

	local var_12_3 = AssassinConfig.instance:getEventName(var_12_0)

	arg_12_0._txteventname.text = var_12_3

	local var_12_4 = AssassinConfig.instance:getEventDesc(var_12_0)

	arg_12_0._txteventdesc.text = var_12_4

	local var_12_5 = AssassinStealthGameModel.instance:getEnemyMoveDir()

	for iter_12_0, iter_12_1 in ipairs(arg_12_0._dirGOList) do
		gohelper.setActive(iter_12_1, iter_12_0 == var_12_5)
	end

	arg_12_0._setEventView = true
end

function var_0_0.setInfoView(arg_13_0)
	if arg_13_0._setInfoView then
		return
	end

	arg_13_0:setMap()
	arg_13_0:setReadmeIconList()
	arg_13_0:setAlarmInfo()

	arg_13_0._setInfoView = true
end

function var_0_0.setMap(arg_14_0)
	arg_14_0:clearGridItemList()

	local var_14_0 = AssassinConfig.instance:getStealthGameMapGridList(arg_14_0._mapId)

	gohelper.CreateObjList(arg_14_0, arg_14_0._onCreateGrid, var_14_0, arg_14_0._gogrids, arg_14_0._gogridItem)

	local var_14_1 = AssassinConfig.instance:getStealthGameMapTowerGridList(arg_14_0._mapId)

	gohelper.CreateObjList(arg_14_0, arg_14_0._onCreateTower, var_14_1, arg_14_0._gotowers, arg_14_0._gotowerItem)

	local var_14_2 = AssassinConfig.instance:getStealthGameMapWallList(arg_14_0._mapId)

	gohelper.CreateObjList(arg_14_0, arg_14_0._onCreateVerWall, var_14_2, arg_14_0._gover, arg_14_0._goverWall)

	local var_14_3 = AssassinConfig.instance:getStealthGameMapWallList(arg_14_0._mapId, true)

	gohelper.CreateObjList(arg_14_0, arg_14_0._onCreateHorWall, var_14_3, arg_14_0._gohor, arg_14_0._gohorWall)
end

function var_0_0._onCreateGrid(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	local var_15_0 = arg_15_0:getUserDataTb_()

	var_15_0.go = arg_15_1
	var_15_0.trans = var_15_0.go.transform
	var_15_0.gridId = arg_15_2
	var_15_0.go.name = var_15_0.gridId
	var_15_0.simagegrid = gohelper.findChildSingleImage(var_15_0.go, "#go_content/#simage_grid")
	var_15_0.imageRefreshPoint = gohelper.findChildImage(var_15_0.go, "#go_content/#image_refreshPoint")

	local var_15_1 = AssassinConfig.instance:getStealthGridImg(arg_15_0._mapId, var_15_0.gridId)

	if not string.nilorempty(var_15_1) then
		local var_15_2 = ResUrl.getSp01AssassinSingleBg("stealth/" .. var_15_1)

		var_15_0.simagegrid:LoadImage(var_15_2)
	end

	local var_15_3

	if arg_15_0._questId then
		local var_15_4 = AssassinConfig.instance:getStealthMapMission(arg_15_0._mapId)

		var_15_3 = AssassinConfig.instance:getStealthMissionRefresh(var_15_4)
	else
		local var_15_5 = AssassinStealthGameModel.instance:getMissionId()
		local var_15_6 = AssassinStealthGameModel.instance:isAlertBellRing()
		local var_15_7, var_15_8 = AssassinConfig.instance:getStealthMissionRefresh(var_15_5)

		var_15_3 = var_15_6 and var_15_8 or var_15_7
	end

	local var_15_9 = AssassinConfig.instance:getEnemyRefreshData(var_15_3, var_15_0.gridId)

	if var_15_9 then
		UISpriteSetMgr.instance:setSp01AssassinSprite(var_15_0.imageRefreshPoint, string.format("%s%s", "assassinstealthoverview_legend_enemy_refresh_", var_15_9.index))
	end

	gohelper.setActive(var_15_0.imageRefreshPoint, var_15_9)

	local var_15_10, var_15_11 = AssassinConfig.instance:getGridPos(arg_15_0._mapId, var_15_0.gridId)
	local var_15_12 = (var_15_10 - 1) * arg_15_0.gridWidth
	local var_15_13 = (var_15_11 - 1) * arg_15_0.gridHeight

	recthelper.setAnchor(var_15_0.trans, var_15_12, var_15_13)

	arg_15_0._gridItemList[arg_15_3] = var_15_0
end

function var_0_0._onCreateTower(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_2

	arg_16_1.name = var_16_0

	local var_16_1, var_16_2 = AssassinConfig.instance:getGridPos(arg_16_0._mapId, var_16_0)
	local var_16_3 = (var_16_1 - 1) * arg_16_0.gridWidth
	local var_16_4 = (var_16_2 - 1) * arg_16_0.gridHeight

	recthelper.setAnchor(arg_16_1.transform, var_16_3, var_16_4)
end

function var_0_0._onCreateVerWall(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	arg_17_1.name = arg_17_2

	local var_17_0, var_17_1 = AssassinConfig.instance:getWallPos(arg_17_0._mapId, arg_17_2)
	local var_17_2 = var_17_0 * arg_17_0.gridWidth
	local var_17_3 = (var_17_1 - 1) * arg_17_0.gridHeight

	recthelper.setAnchor(arg_17_1.transform, var_17_2, var_17_3)
end

function var_0_0._onCreateHorWall(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	arg_18_1.name = arg_18_2

	local var_18_0, var_18_1 = AssassinConfig.instance:getWallPos(arg_18_0._mapId, arg_18_2)
	local var_18_2 = (var_18_0 - 1) * arg_18_0.gridWidth
	local var_18_3 = var_18_1 * arg_18_0.gridHeight

	recthelper.setAnchor(arg_18_1.transform, var_18_2, var_18_3)
end

function var_0_0.setReadmeIconList(arg_19_0)
	local var_19_0 = false
	local var_19_1 = AssassinEnum.StealthGamePointType.Tower
	local var_19_2 = {}
	local var_19_3 = AssassinConfig.instance:getStealthGameMapGridList(arg_19_0._mapId)

	for iter_19_0, iter_19_1 in ipairs(var_19_3) do
		local var_19_4 = AssassinConfig.instance:getGridType(arg_19_0._mapId, iter_19_1)

		if not var_19_2[var_19_4] then
			var_19_2[var_19_4] = {
				icon = AssassinConfig.instance:getStealthGameMapGridTypeIcon(var_19_4),
				name = AssassinConfig.instance:getStealthGameMapGridTypeName(var_19_4)
			}
		end

		var_19_0 = var_19_0 or AssassinConfig.instance:isGridHasPointType(arg_19_0._mapId, iter_19_1, var_19_1)
	end

	local var_19_5 = {}

	for iter_19_2, iter_19_3 in pairs(var_19_2) do
		var_19_5[#var_19_5 + 1] = iter_19_3
	end

	if var_19_0 then
		var_19_5[#var_19_5 + 1] = {
			icon = AssassinConfig.instance:getPointTypeSmallIcon(var_19_1),
			name = AssassinConfig.instance:getPointTypeName(var_19_1)
		}
	end

	local var_19_6

	if arg_19_0._questId then
		local var_19_7 = AssassinConfig.instance:getStealthMapMission(arg_19_0._mapId)

		var_19_6 = AssassinConfig.instance:getStealthMissionRefresh(var_19_7)
	else
		local var_19_8 = AssassinStealthGameModel.instance:getMissionId()
		local var_19_9 = AssassinStealthGameModel.instance:isAlertBellRing()
		local var_19_10, var_19_11 = AssassinConfig.instance:getStealthMissionRefresh(var_19_8)

		var_19_6 = var_19_9 and var_19_11 or var_19_10
	end

	if var_19_6 and var_19_6 > 0 then
		local var_19_12 = AssassinConfig.instance:getEnemyRefreshPositionList(var_19_6)
		local var_19_13 = luaLang("assassin_stealth_enemy_refresh_point")

		for iter_19_4, iter_19_5 in ipairs(var_19_12) do
			var_19_5[#var_19_5 + 1] = {
				icon = string.format("%s%s", "assassinstealthoverview_legend_enemy_refresh_", iter_19_4),
				name = var_19_13
			}
		end
	end

	gohelper.CreateObjList(arg_19_0, arg_19_0._onCreateReadmeIcon, var_19_5, arg_19_0._goreadme, arg_19_0._goreadmeItem)
end

function var_0_0._onCreateReadmeIcon(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = gohelper.findChildImage(arg_20_1, "#simage_icon")

	UISpriteSetMgr.instance:setSp01AssassinSprite(var_20_0, arg_20_2.icon)

	gohelper.findChildText(arg_20_1, "#txt_name").text = arg_20_2.name
end

function var_0_0.setAlarmInfo(arg_21_0)
	local var_21_0

	if arg_21_0._questId then
		var_21_0 = AssassinConfig.instance:getStealthMapMission(arg_21_0._mapId)

		gohelper.setActive(arg_21_0._goselectedgreen, false)
		gohelper.setActive(arg_21_0._goselectedred, false)
	else
		var_21_0 = AssassinStealthGameModel.instance:getMissionId()

		local var_21_1 = AssassinStealthGameModel.instance:isAlertBellRing()

		gohelper.setActive(arg_21_0._goselectedgreen, not var_21_1)
		gohelper.setActive(arg_21_0._goselectedred, var_21_1)
	end

	local var_21_2 = {}
	local var_21_3, var_21_4 = AssassinConfig.instance:getStealthMissionRefresh(var_21_0)
	local var_21_5 = AssassinConfig.instance:getEnemyRefreshPositionList(var_21_3)
	local var_21_6 = AssassinConfig.instance:getEnemyRefreshPositionList(var_21_4)
	local var_21_7 = {}

	for iter_21_0, iter_21_1 in ipairs(var_21_6) do
		var_21_7[iter_21_1[1]] = iter_21_1[2]
	end

	for iter_21_2, iter_21_3 in ipairs(var_21_5) do
		local var_21_8 = iter_21_3[1]
		local var_21_9 = iter_21_3[2]

		var_21_2[iter_21_2] = {
			gridId = var_21_8,
			enemyGroup1 = var_21_9,
			enemyGroup2 = var_21_7[var_21_8]
		}
	end

	arg_21_0._totalEnemyRefreshInfoCount = #var_21_2

	if arg_21_0._totalEnemyRefreshInfoCount == 0 then
		local var_21_10 = gohelper.cloneInPlace(arg_21_0._goenemyinfoItem, "emptyItem")
		local var_21_11 = gohelper.findChild(var_21_10, "#go_empty")

		gohelper.setActive(var_21_11, true)

		local var_21_12 = gohelper.findChild(var_21_10, "beforeLayout")

		gohelper.clone(var_21_11, var_21_12)

		local var_21_13 = gohelper.findChild(var_21_10, "afterLayout")

		gohelper.clone(var_21_11, var_21_13)

		local var_21_14 = gohelper.findChild(var_21_10, "#go_enemyItem")

		gohelper.setActive(var_21_14, false)

		local var_21_15 = gohelper.findChild(var_21_10, "icon")

		gohelper.setActive(var_21_15, false)
		gohelper.setActive(var_21_11, false)
		gohelper.setActive(arg_21_0._goenemyinfoItem, false)
	else
		gohelper.CreateObjList(arg_21_0, arg_21_0._onCreateAlarmEnemyInfoItem, var_21_2, arg_21_0._goenemyinfolayout, arg_21_0._goenemyinfoItem)
	end
end

function var_0_0._onCreateAlarmEnemyInfoItem(arg_22_0, arg_22_1, arg_22_2, arg_22_3)
	local var_22_0 = gohelper.findChild(arg_22_1, "#go_enemyItem")

	gohelper.setActive(var_22_0, false)

	local var_22_1 = AssassinConfig.instance:getEnemyListInGroup(arg_22_2.enemyGroup1)
	local var_22_2 = gohelper.findChild(arg_22_1, "beforeLayout")

	gohelper.CreateObjList(arg_22_0, arg_22_0._onCreateEnemyItem, var_22_1, var_22_2, var_22_0)

	local var_22_3 = #var_22_1 > 3 and 0.8 or 1

	transformhelper.setLocalScale(var_22_2.transform, var_22_3, var_22_3, 1)

	local var_22_4 = gohelper.findChildImage(arg_22_1, "icon")
	local var_22_5 = string.format("%s%s", "assassinstealthoverview_legend_enemy_refresh_", arg_22_3)

	UISpriteSetMgr.instance:setSp01AssassinSprite(var_22_4, var_22_5)

	local var_22_6 = AssassinConfig.instance:getEnemyListInGroup(arg_22_2.enemyGroup2)
	local var_22_7 = gohelper.findChild(arg_22_1, "afterLayout")

	gohelper.CreateObjList(arg_22_0, arg_22_0._onCreateEnemyItem, var_22_6, var_22_7, var_22_0)

	local var_22_8 = #var_22_6 > 3 and 0.8 or 1

	transformhelper.setLocalScale(var_22_7.transform, var_22_8, var_22_8, 1)

	local var_22_9 = gohelper.findChild(arg_22_1, "#go_Line")

	gohelper.setActive(var_22_9, arg_22_3 ~= arg_22_0._totalEnemyRefreshInfoCount)
end

function var_0_0._onCreateEnemyItem(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = AssassinConfig.instance:getEnemyHeadIcon(arg_23_2)
	local var_23_1 = gohelper.findChildImage(arg_23_1, "#simage_enemyIcon")

	UISpriteSetMgr.instance:setSp01AssassinSprite(var_23_1, var_23_0)
end

function var_0_0.clearGridItemList(arg_24_0)
	if arg_24_0._gridItemList then
		for iter_24_0, iter_24_1 in ipairs(arg_24_0._gridItemList) do
			iter_24_1.simagegrid:UnLoadImage()
		end
	end

	arg_24_0._gridItemList = {}
end

function var_0_0.onClose(arg_25_0)
	return
end

function var_0_0.onDestroyView(arg_26_0)
	arg_26_0:clearGridItemList()

	arg_26_0._setInfoView = nil
	arg_26_0._setEventView = nil
end

return var_0_0
