module("modules.logic.sp01.assassin2.outside.view.AssassinStealthGameView", package.seeall)

local var_0_0 = class("AssassinStealthGameView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gobellringmask = gohelper.findChild(arg_1_0.viewGO, "root/simage_redmask")
	arg_1_0._godrag = gohelper.findChild(arg_1_0.viewGO, "root/#go_drag")
	arg_1_0._gomap = gohelper.findChild(arg_1_0.viewGO, "root/#go_drag/#go_map")
	arg_1_0._gotop = gohelper.findChild(arg_1_0.viewGO, "root/top")
	arg_1_0._txtroundTip = gohelper.findChildText(arg_1_0.viewGO, "root/top/#txt_roundTip")
	arg_1_0._txtroundTipEff = gohelper.findChildText(arg_1_0.viewGO, "root/top/#txt_roundTipeff")
	arg_1_0._txtround = gohelper.findChildText(arg_1_0.viewGO, "root/top/#txt_round")
	arg_1_0._goplayerturnbg = gohelper.findChild(arg_1_0.viewGO, "root/top/go_roundBG/image_player")
	arg_1_0._goenemyturnbg = gohelper.findChild(arg_1_0.viewGO, "root/top/go_roundBG/image_enemy")
	arg_1_0._gobell = gohelper.findChild(arg_1_0.viewGO, "root/#go_bell")
	arg_1_0._btnbell = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_bell/#btn_bell", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	arg_1_0._gogreen = gohelper.findChild(arg_1_0.viewGO, "root/#go_bell/#go_green")
	arg_1_0._gored = gohelper.findChild(arg_1_0.viewGO, "root/#go_bell/#go_red")
	arg_1_0._btnqte = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_qte", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	arg_1_0._goapLayout = gohelper.findChild(arg_1_0.viewGO, "root/#btn_qte/#go_apLayout")
	arg_1_0._btnend = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_end", AudioEnum2_9.StealthGame.play_ui_cikeshang_overround)
	arg_1_0._gostartLight = gohelper.findChild(arg_1_0.viewGO, "root/target/start/#go_startLight")
	arg_1_0._txttarget = gohelper.findChildText(arg_1_0.viewGO, "root/target/#txt_target")
	arg_1_0._gochangeMissionEff = gohelper.findChild(arg_1_0.viewGO, "root/target/#saoguang")
	arg_1_0._goheroLayout = gohelper.findChild(arg_1_0.viewGO, "root/#go_heroLayout")
	arg_1_0._goheroItem = gohelper.findChild(arg_1_0.viewGO, "root/#go_heroLayout/#go_heroItem")
	arg_1_0._btntechnique = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_topleft/#btn_technique")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "root/tips")
	arg_1_0._gouseItem = gohelper.findChild(arg_1_0.viewGO, "root/tips/#go_useItem")
	arg_1_0._btnuseitemmask = gohelper.findChildClickWithAudio(arg_1_0.viewGO, "root/tips/#go_useItem/mask", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	arg_1_0._gouseitemtargetlayer = gohelper.findChild(arg_1_0.viewGO, "root/tips/#go_useItem/#go_targetLayer")
	arg_1_0._txttips = gohelper.findChildText(arg_1_0.viewGO, "root/tips/#go_useItem/#go_tip/#txt_tips")
	arg_1_0._imageitemicon = gohelper.findChildImage(arg_1_0.viewGO, "root/tips/#go_useItem/#go_itemInfo/#simage_icon")
	arg_1_0._txtitemName = gohelper.findChildText(arg_1_0.viewGO, "root/tips/#go_useItem/#go_itemInfo/#txt_itemName")
	arg_1_0._goitemtag = gohelper.findChild(arg_1_0.viewGO, "root/tips/#go_useItem/#go_itemInfo/#txt_itemName/tag")
	arg_1_0._txttag = gohelper.findChildText(arg_1_0.viewGO, "root/tips/#go_useItem/#go_itemInfo/#txt_itemName/tag/#txt_tag")
	arg_1_0._txtitemDesc = gohelper.findChildText(arg_1_0.viewGO, "root/tips/#go_useItem/#go_itemInfo/#txt_itemDesc")
	arg_1_0._goshow = gohelper.findChild(arg_1_0.viewGO, "root/tips/#go_show")
	arg_1_0._simagepic = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/tips/#go_show/#skill/#simage_pic")
	arg_1_0._txtname = gohelper.findChildText(arg_1_0.viewGO, "root/tips/#go_show/#txt_name")
	arg_1_0._imageshowicon = gohelper.findChildImage(arg_1_0.viewGO, "root/tips/#go_show/#txt_name/#image_icon")
	arg_1_0._gomissionTip = gohelper.findChild(arg_1_0.viewGO, "root/tips/#go_mission")
	arg_1_0._txtmissionTip = gohelper.findChildText(arg_1_0.viewGO, "root/tips/#go_mission/root/#txt_Mission")
	arg_1_0._goselectenemy = gohelper.findChild(arg_1_0.viewGO, "root/tips/#go_selectEnemy")
	arg_1_0._btnselectenemymask = gohelper.findChildClickWithAudio(arg_1_0.viewGO, "root/tips/#go_selectEnemy/mask", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
	arg_1_0._goselectedwheel = gohelper.findChild(arg_1_0.viewGO, "root/tips/#go_selectEnemy/#go_selected")
	arg_1_0._goopItem = gohelper.findChild(arg_1_0.viewGO, "root/tips/#go_selectEnemy/#go_selected/#go_opItem")
	arg_1_0._goopLayout = gohelper.findChild(arg_1_0.viewGO, "root/tips/#go_selectEnemy/#go_selected/#go_opLayout")
	arg_1_0._goopreadmelayout = gohelper.findChild(arg_1_0.viewGO, "root/tips/#go_selectEnemy/layout")
	arg_1_0._goopreadmeItem = gohelper.findChild(arg_1_0.viewGO, "root/tips/#go_selectEnemy/layout/#go_item")
	arg_1_0._goexposetips = gohelper.findChild(arg_1_0.viewGO, "root/tips/#go_expose")
	arg_1_0._txtexposetips = gohelper.findChildText(arg_1_0.viewGO, "root/tips/#go_expose/#go_tip/#txt_tips")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnbell:AddClickListener(arg_2_0._btnbellOnClick, arg_2_0)
	arg_2_0._btnqte:AddClickListener(arg_2_0._btnqteOnClick, arg_2_0)
	arg_2_0._btnend:AddClickListener(arg_2_0._btnendOnClick, arg_2_0)
	arg_2_0._btnselectenemymask:AddClickListener(arg_2_0._btnselectenemymaskOnClick, arg_2_0)
	arg_2_0._btnuseitemmask:AddClickListener(arg_2_0._btnuseitemmaskOnClick, arg_2_0)
	arg_2_0._drag:AddDragBeginListener(arg_2_0._onBeginDragMap, arg_2_0)
	arg_2_0._drag:AddDragListener(arg_2_0._onDragMap, arg_2_0)
	arg_2_0._drag:AddDragEndListener(arg_2_0._onEndDragMap, arg_2_0)
	arg_2_0._useitemdrag:AddDragBeginListener(arg_2_0._onBeginDragMap, arg_2_0)
	arg_2_0._useitemdrag:AddDragListener(arg_2_0._onDragMap, arg_2_0)
	arg_2_0._useitemdrag:AddDragEndListener(arg_2_0._onEndDragMap, arg_2_0)
	arg_2_0._touchEventMgr:SetOnMultiDragCb(arg_2_0._onMultiDrag, arg_2_0)
	arg_2_0._touchEventMgr:SetScrollWheelCb(arg_2_0._onMouseScrollWheelChange, arg_2_0)
	arg_2_0._btntechnique:AddClickListener(arg_2_0._btntechniqueOnClick, arg_2_0)
	arg_2_0:addEventCb(AssassinStealthGameController.instance, AssassinEvent.OnHeroUpdate, arg_2_0._onHeroUpdate, arg_2_0)
	arg_2_0:addEventCb(AssassinStealthGameController.instance, AssassinEvent.OnHeroMove, arg_2_0._onHeroMove, arg_2_0)
	arg_2_0:addEventCb(AssassinStealthGameController.instance, AssassinEvent.OnStealthGameSelectHero, arg_2_0._onSelectedHero, arg_2_0)
	arg_2_0:addEventCb(AssassinStealthGameController.instance, AssassinEvent.OnStealthGameSelectEnemy, arg_2_0._onSelectEnemy, arg_2_0)
	arg_2_0:addEventCb(AssassinStealthGameController.instance, AssassinEvent.OnSelectSkillProp, arg_2_0._onSelectSkillProp, arg_2_0)
	arg_2_0:addEventCb(AssassinStealthGameController.instance, AssassinEvent.OnUseSkillProp, arg_2_0._onUseSkillProp, arg_2_0)
	arg_2_0:addEventCb(AssassinStealthGameController.instance, AssassinEvent.ShowHeroActImg, arg_2_0._showHeroActImg, arg_2_0)
	arg_2_0:addEventCb(AssassinStealthGameController.instance, AssassinEvent.OnHeroGetItem, arg_2_0._onHeroGetItem, arg_2_0)
	arg_2_0:addEventCb(AssassinStealthGameController.instance, AssassinEvent.ShowExposeTip, arg_2_0._onShowExposeTip, arg_2_0)
	arg_2_0:addEventCb(AssassinStealthGameController.instance, AssassinEvent.OnPlayerEndTurn, arg_2_0._onPlayerEndTurn, arg_2_0)
	arg_2_0:addEventCb(AssassinStealthGameController.instance, AssassinEvent.BeforeEnterFight, arg_2_0._beforeEnterFight, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseView, arg_2_0)
	arg_2_0:addEventCb(AssassinStealthGameController.instance, AssassinEvent.OnBeginNewRound, arg_2_0._onBeginNewRound, arg_2_0)
	arg_2_0:addEventCb(AssassinStealthGameController.instance, AssassinEvent.OnMissionUpdate, arg_2_0._onMissionUpdate, arg_2_0)
	arg_2_0:addEventCb(AssassinStealthGameController.instance, AssassinEvent.OnMissionChange, arg_2_0._onMissionChange, arg_2_0)
	arg_2_0:addEventCb(AssassinStealthGameController.instance, AssassinEvent.OnQTEInteractUpdate, arg_2_0._onQTEInteractUpdate, arg_2_0)
	arg_2_0:addEventCb(AssassinStealthGameController.instance, AssassinEvent.OnGameSceneRecover, arg_2_0._onGameSceneRecover, arg_2_0)
	arg_2_0:addEventCb(AssassinStealthGameController.instance, AssassinEvent.OnGameSceneRestart, arg_2_0._onGameSceneRestart, arg_2_0)
	arg_2_0:addEventCb(AssassinStealthGameController.instance, AssassinEvent.OnGameChangeMap, arg_2_0._onGameChangeMap, arg_2_0)
	arg_2_0:addEventCb(AssassinStealthGameController.instance, AssassinEvent.OnChangeAlertLevel, arg_2_0._onAlertLevelChange, arg_2_0)
	arg_2_0:addEventCb(AssassinStealthGameController.instance, AssassinEvent.TweenStealthMapPos, arg_2_0._onTweenMapPos, arg_2_0)
	arg_2_0:addEventCb(AssassinStealthGameController.instance, AssassinEvent.GuidFocusStealthGameHero, arg_2_0._onGuideFocusHero, arg_2_0)
	NavigateMgr.instance:addEscape(arg_2_0.viewName, arg_2_0._onEscBtnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnbell:RemoveClickListener()
	arg_3_0._btnqte:RemoveClickListener()
	arg_3_0._btnend:RemoveClickListener()
	arg_3_0._btnselectenemymask:RemoveClickListener()
	arg_3_0._btnuseitemmask:RemoveClickListener()
	arg_3_0._drag:RemoveDragBeginListener()
	arg_3_0._drag:RemoveDragListener()
	arg_3_0._drag:RemoveDragEndListener()
	arg_3_0._useitemdrag:RemoveDragBeginListener()
	arg_3_0._useitemdrag:RemoveDragListener()
	arg_3_0._useitemdrag:RemoveDragEndListener()

	for iter_3_0, iter_3_1 in ipairs(arg_3_0._opItemList) do
		iter_3_1.btnclick:RemoveClickListener()
	end

	if arg_3_0._touchEventMgr then
		TouchEventMgrHepler.remove(arg_3_0._touchEventMgr)

		arg_3_0._touchEventMgr = nil
	end

	arg_3_0._btntechnique:RemoveClickListener()
	arg_3_0:removeEventCb(AssassinStealthGameController.instance, AssassinEvent.OnHeroUpdate, arg_3_0._onHeroUpdate, arg_3_0)
	arg_3_0:removeEventCb(AssassinStealthGameController.instance, AssassinEvent.OnHeroMove, arg_3_0._onHeroMove, arg_3_0)
	arg_3_0:removeEventCb(AssassinStealthGameController.instance, AssassinEvent.OnStealthGameSelectHero, arg_3_0._onSelectedHero, arg_3_0)
	arg_3_0:removeEventCb(AssassinStealthGameController.instance, AssassinEvent.OnStealthGameSelectEnemy, arg_3_0._onSelectEnemy, arg_3_0)
	arg_3_0:removeEventCb(AssassinStealthGameController.instance, AssassinEvent.OnSelectSkillProp, arg_3_0._onSelectSkillProp, arg_3_0)
	arg_3_0:removeEventCb(AssassinStealthGameController.instance, AssassinEvent.OnUseSkillProp, arg_3_0._onUseSkillProp, arg_3_0)
	arg_3_0:removeEventCb(AssassinStealthGameController.instance, AssassinEvent.ShowHeroActImg, arg_3_0._showHeroActImg, arg_3_0)
	arg_3_0:removeEventCb(AssassinStealthGameController.instance, AssassinEvent.OnHeroGetItem, arg_3_0._onHeroGetItem, arg_3_0)
	arg_3_0:removeEventCb(AssassinStealthGameController.instance, AssassinEvent.ShowExposeTip, arg_3_0._onShowExposeTip, arg_3_0)
	arg_3_0:removeEventCb(AssassinStealthGameController.instance, AssassinEvent.OnPlayerEndTurn, arg_3_0._onPlayerEndTurn, arg_3_0)
	arg_3_0:removeEventCb(AssassinStealthGameController.instance, AssassinEvent.BeforeEnterFight, arg_3_0._beforeEnterFight, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseView, arg_3_0)
	arg_3_0:removeEventCb(AssassinStealthGameController.instance, AssassinEvent.OnBeginNewRound, arg_3_0._onBeginNewRound, arg_3_0)
	arg_3_0:removeEventCb(AssassinStealthGameController.instance, AssassinEvent.OnMissionUpdate, arg_3_0._onMissionUpdate, arg_3_0)
	arg_3_0:removeEventCb(AssassinStealthGameController.instance, AssassinEvent.OnMissionChange, arg_3_0._onMissionChange, arg_3_0)
	arg_3_0:removeEventCb(AssassinStealthGameController.instance, AssassinEvent.OnQTEInteractUpdate, arg_3_0._onQTEInteractUpdate, arg_3_0)
	arg_3_0:removeEventCb(AssassinStealthGameController.instance, AssassinEvent.OnGameSceneRecover, arg_3_0._onGameSceneRecover, arg_3_0)
	arg_3_0:removeEventCb(AssassinStealthGameController.instance, AssassinEvent.OnGameSceneRestart, arg_3_0._onGameSceneRestart, arg_3_0)
	arg_3_0:removeEventCb(AssassinStealthGameController.instance, AssassinEvent.OnGameChangeMap, arg_3_0._onGameChangeMap, arg_3_0)
	arg_3_0:removeEventCb(AssassinStealthGameController.instance, AssassinEvent.OnChangeAlertLevel, arg_3_0._onAlertLevelChange, arg_3_0)
	arg_3_0:removeEventCb(AssassinStealthGameController.instance, AssassinEvent.TweenStealthMapPos, arg_3_0._onTweenMapPos, arg_3_0)
	arg_3_0:removeEventCb(AssassinStealthGameController.instance, AssassinEvent.GuidFocusStealthGameHero, arg_3_0._onGuideFocusHero, arg_3_0)
end

function var_0_0._btnbellOnClick(arg_4_0)
	AssassinController.instance:openAssassinStealthGameOverView()
end

function var_0_0._btnqteOnClick(arg_5_0)
	AssassinStealthGameController.instance:heroInteract()
end

function var_0_0._btnendOnClick(arg_6_0)
	AssassinStealthGameController.instance:playerEndTurn()
end

function var_0_0._btnselectenemymaskOnClick(arg_7_0)
	AssassinStealthGameController.instance:selectEnemy()
end

function var_0_0._btnuseitemmaskOnClick(arg_8_0)
	AssassinStealthGameController.instance:selectSkillProp()
end

function var_0_0._onOpItemClick(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0._opItemList[arg_9_1]
	local var_9_1 = var_9_0 and var_9_0.actId

	if not var_9_1 then
		return
	end

	if var_9_0.isAssassinate then
		AssassinStealthGameController.instance:heroAssassinate(var_9_1)
	else
		AssassinStealthGameController.instance:heroAttack(var_9_1)
	end
end

function var_0_0._onBeginDragMap(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._startDragPos = recthelper.screenPosToAnchorPos(arg_10_2.position, arg_10_0._transdrag)
	arg_10_0._startMapPosX, arg_10_0._startMapPosY = transformhelper.getLocalPos(arg_10_0._transmap)
end

function var_0_0._onDragMap(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0._multiDragging or not arg_11_0._startDragPos then
		return
	end

	local var_11_0 = recthelper.screenPosToAnchorPos(arg_11_2.position, arg_11_0._transdrag) - arg_11_0._startDragPos
	local var_11_1 = arg_11_0._startMapPosX + var_11_0.x
	local var_11_2 = arg_11_0._startMapPosY + var_11_0.y

	arg_11_0:setMapPos(var_11_1, var_11_2)
end

function var_0_0._onEndDragMap(arg_12_0, arg_12_1, arg_12_2)
	arg_12_0._multiDragging = false
	arg_12_0._startDragPos = nil
end

function var_0_0._onMultiDrag(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0._multiDragging = true

	if not arg_13_0:_checkCanScale() then
		return
	end

	local var_13_0 = arg_13_2 * 0.01

	arg_13_0.curScale = arg_13_0.curScale + var_13_0

	arg_13_0:setLocalScale()
end

function var_0_0._onMouseScrollWheelChange(arg_14_0, arg_14_1)
	if not arg_14_0:_checkCanScale() then
		return
	end

	arg_14_0.curScale = arg_14_0.curScale + arg_14_1

	arg_14_0:setLocalScale()
end

function var_0_0._checkCanScale(arg_15_0)
	local var_15_0 = true
	local var_15_1 = AssassinStealthGameModel.instance:getMapId()
	local var_15_2, var_15_3 = AssassinConfig.instance:getStealthMapForbidScaleGuide(var_15_1)

	if var_15_2 then
		if var_15_3 then
			var_15_0 = GuideModel.instance:isStepFinish(var_15_2, var_15_3)
		else
			var_15_0 = GuideModel.instance:isGuideFinish(var_15_2)
		end
	end

	if not var_15_0 then
		return false
	end

	if arg_15_0:checkInGuide() then
		return false
	end

	if UIBlockMgr.instance:isBlock() then
		return false
	end

	local var_15_4 = ViewMgr.instance:getOpenViewNameList()

	if var_15_4[#var_15_4] ~= arg_15_0.viewName then
		return false
	end

	if arg_15_0.tweenId or arg_15_0._gouseItem.activeSelf or arg_15_0._goselectenemy.activeSelf or arg_15_0._goshow.activeSelf then
		return false
	end

	return true
end

function var_0_0._btntechniqueOnClick(arg_16_0)
	AssassinController.instance:openAssassinStealthTechniqueView()
end

function var_0_0._onEscBtnClick(arg_17_0)
	if arg_17_0:checkInGuide() then
		return
	end

	AssassinController.instance:openAssassinStealthGamePauseView()
end

function var_0_0._onHeroUpdate(arg_18_0)
	arg_18_0:refreshInteractQTEBtn()
	arg_18_0:refreshHeroHeadItem()
end

function var_0_0._onHeroMove(arg_19_0)
	arg_19_0:refreshInteractQTEBtn()
	arg_19_0:refreshHeroHeadItem()
end

function var_0_0._onSelectedHero(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1.lastSelectedHeroUid

	if AssassinStealthGameModel.instance:getSelectedHero() then
		arg_20_0:initHeroItem(true, var_20_0)
	else
		arg_20_0:refreshHeroHeadItem(true, var_20_0)
	end

	arg_20_0:refreshInteractQTEBtn()

	local var_20_1 = arg_20_1.needFocus
	local var_20_2 = AssassinStealthGameModel.instance:getSelectedHeroGameMo()

	if var_20_1 and var_20_2 then
		local var_20_3 = var_20_2:getPos()

		arg_20_0:mapFocus2Grid(var_20_3)
	end
end

function var_0_0._onSelectEnemy(arg_21_0, arg_21_1)
	local var_21_0 = AssassinStealthGameModel.instance:getSelectedEnemyGameMo()

	if var_21_0 then
		arg_21_0:_setSelectedEnemyOpItemList()

		if arg_21_1 then
			AssassinStealthGameEntityMgr.instance:changeEnemyParent(arg_21_1)
			AssassinStealthGameEntityMgr.instance:refreshEnemyEntity(arg_21_1)
		end

		local var_21_1 = var_21_0:getPos()

		arg_21_0:mapFocus2Grid(var_21_1, nil, true, arg_21_0._changeSelectedEnemyLayer, arg_21_0)
	else
		AssassinHelper.lockScreen(AssassinEnum.BlockKey.SelectedEnemy, true)

		arg_21_0._oldSelectedEnemy = arg_21_1

		arg_21_0._selectEnemyAnimatorPlayer:Play("close", arg_21_0._hideSelectEnemyGo, arg_21_0)
	end
end

function var_0_0._changeSelectedEnemyLayer(arg_22_0)
	local var_22_0 = AssassinStealthGameModel.instance:getSelectedEnemyGameMo()

	if var_22_0 then
		local var_22_1 = var_22_0:getUid()

		AssassinStealthGameEntityMgr.instance:changeEnemyParent(var_22_1, arg_22_0._transselectenemy)

		local var_22_2, var_22_3 = AssassinStealthGameEntityMgr.instance:getEnemyLocalPos(var_22_1)

		if var_22_2 and var_22_3 then
			transformhelper.setLocalPosXY(arg_22_0._transselectenemywheel, var_22_2, var_22_3)
		end

		gohelper.setActive(arg_22_0._goselectenemy, true)
		arg_22_0._selectEnemyAnimatorPlayer:Play("open", nil, arg_22_0)
	end
end

function var_0_0._setSelectedEnemyOpItemList(arg_23_0)
	local var_23_0 = {}
	local var_23_1
	local var_23_2 = AssassinStealthGameHelper.getSelectedHeroAssassinateActId()

	if var_23_2 then
		local var_23_3 = {
			actId = var_23_2
		}

		var_23_0[#var_23_0 + 1] = var_23_3
	end

	local var_23_4, var_23_5 = AssassinStealthGameHelper.getSelectedHeroAttackActId()

	var_23_0[#var_23_0 + 1] = var_23_4
	var_23_0[#var_23_0 + 1] = var_23_5

	for iter_23_0, iter_23_1 in ipairs(arg_23_0._opItemList) do
		local var_23_6 = var_23_0[iter_23_0]

		if var_23_6 then
			local var_23_7 = var_23_6
			local var_23_8 = false

			if LuaUtil.isTable(var_23_6) then
				var_23_7 = var_23_6.actId
				var_23_8 = true
			end

			AssassinHelper.setAssassinActIcon(var_23_7, iter_23_1.imageicon)

			local var_23_9 = AssassinConfig.instance:getAssassinActPower(var_23_7)

			iter_23_1.apComp:setAPCount(var_23_9)

			iter_23_1.actId = var_23_7
			iter_23_1.isAssassinate = var_23_8
		else
			iter_23_1.actId = nil
			iter_23_1.isAssassinate = nil
		end

		gohelper.setActive(iter_23_1.go, iter_23_1.actId)
	end

	gohelper.CreateObjList(arg_23_0, arg_23_0._onCreateOpReadmeItem, var_23_0, arg_23_0._goopreadmelayout, arg_23_0._goopreadmeItem)
end

function var_0_0._onCreateOpReadmeItem(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = arg_24_2

	if LuaUtil.isTable(arg_24_2) then
		var_24_0 = arg_24_2.actId
	end

	local var_24_1 = gohelper.findChildImage(arg_24_1, "#image_icon")

	AssassinHelper.setAssassinActIcon(var_24_0, var_24_1)

	gohelper.findChildText(arg_24_1, "#txt_name").text = AssassinConfig.instance:getAssassinActName(var_24_0)
end

function var_0_0._hideSelectEnemyGo(arg_25_0)
	if arg_25_0._oldSelectedEnemy then
		AssassinStealthGameEntityMgr.instance:changeEnemyParent(arg_25_0._oldSelectedEnemy)
		AssassinStealthGameEntityMgr.instance:refreshEnemyEntity(arg_25_0._oldSelectedEnemy)

		arg_25_0._oldSelectedEnemy = nil
	end

	AssassinHelper.lockScreen(AssassinEnum.BlockKey.SelectedEnemy, false)
	gohelper.setActive(arg_25_0._goselectenemy, false)
end

function var_0_0._onSelectSkillProp(arg_26_0, arg_26_1)
	for iter_26_0, iter_26_1 in ipairs(arg_26_0._heroHeadItemList) do
		iter_26_1:refreshSkillProp()
	end

	local var_26_0, var_26_1 = AssassinStealthGameModel.instance:getSelectedSkillProp()

	if var_26_0 then
		local var_26_2 = ""
		local var_26_3 = ""

		if var_26_1 then
			AssassinHelper.setAssassinSkillIcon(var_26_0, arg_26_0._imageitemicon)

			var_26_2 = AssassinConfig.instance:getAssassinSkillName(var_26_0)
			var_26_3 = AssassinConfig.instance:getAssassinCareerSkillDesc(var_26_0)
		else
			AssassinHelper.setAssassinItemIcon(var_26_0, arg_26_0._imageitemicon)

			var_26_2 = AssassinConfig.instance:getAssassinItemName(var_26_0)
			var_26_3 = AssassinConfig.instance:getAssassinItemStealthEffDesc(var_26_0)
		end

		arg_26_0._txtitemName.text = var_26_2
		arg_26_0._txtitemDesc.text = var_26_3

		gohelper.setActive(arg_26_0._goitemtag, false)
	end

	arg_26_0:_setIsShowUseItem(var_26_0, arg_26_1)
end

function var_0_0._onUseSkillProp(arg_27_0)
	arg_27_0:_setIsShowUseItem(false)
	arg_27_0:changeHeroSkillProp()
end

function var_0_0._setIsShowUseItem(arg_28_0, arg_28_1, arg_28_2)
	if arg_28_1 then
		gohelper.setActive(arg_28_0._gouseItem, true)

		local var_28_0 = AssassinStealthGameEntityMgr.instance:changeSkillPropTargetLayer(arg_28_0._transuseitemtargetlayer) and "assassin_stealth_use_skill_prop_select_target" or "assassin_stealth_use_skill_prop_no_target"

		arg_28_0._txttips.text = luaLang(var_28_0)
	else
		AssassinStealthGameEntityMgr.instance:changeSkillPropTargetLayer(arg_28_0._transuseitemtargetlayer)

		if arg_28_2 then
			arg_28_0:_hideUseItemGo()
		else
			arg_28_0._useItemAnimatorPlayer:Play("close", arg_28_0._hideUseItemGo, arg_28_0)
		end
	end
end

function var_0_0._hideUseItemGo(arg_29_0)
	gohelper.setActive(arg_29_0._gouseItem, false)
end

function var_0_0._showHeroActImg(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = AssassinConfig.instance:getAssassinActShowImg(arg_30_1)

	if string.nilorempty(var_30_0) then
		AssassinStealthGameController.instance:showActImgFinish(arg_30_1, arg_30_2)
	else
		arg_30_0._txtname.text = AssassinConfig.instance:getAssassinActName(arg_30_1)

		AssassinHelper.setAssassinActIcon(arg_30_1, arg_30_0._imageshowicon)

		local var_30_1 = ResUrl.getSp01AssassinSingleBg("stealth/" .. var_30_0)

		arg_30_0._simagepic:LoadImage(var_30_1)

		arg_30_0._showActId = arg_30_1
		arg_30_0._actParam = arg_30_2

		gohelper.setActive(arg_30_0._goshow, true)
		arg_30_0._showAnimatorPlayer:Play("open", arg_30_0._playShowFinished, arg_30_0)

		local var_30_2 = AssassinConfig.instance:getAssassinActAudioId(arg_30_1)

		if var_30_2 and var_30_2 ~= 0 then
			AudioMgr.instance:trigger(var_30_2)
		end
	end
end

function var_0_0._playShowFinished(arg_31_0)
	gohelper.setActive(arg_31_0._goshow, false)
	AssassinStealthGameController.instance:showActImgFinish(arg_31_0._showActId, arg_31_0._actParam)
end

function var_0_0._onHeroGetItem(arg_32_0, arg_32_1, arg_32_2)
	arg_32_0._getItemUid = arg_32_1
	arg_32_0._newItemDict = arg_32_2

	AssassinStealthGameController.instance:selectSkillProp(nil, nil, true)
end

function var_0_0._onShowExposeTip(arg_33_0, arg_33_1)
	local var_33_0 = {}

	for iter_33_0, iter_33_1 in ipairs(arg_33_1) do
		local var_33_1 = AssassinStealthGameModel.instance:getHeroMo(iter_33_1, true)
		local var_33_2 = var_33_1 and var_33_1:getHeroId()
		local var_33_3 = AssassinHeroModel.instance:getAssassinHeroName(var_33_2)

		if not string.nilorempty(var_33_3) then
			var_33_0[#var_33_0 + 1] = var_33_3
		end
	end

	local var_33_4 = luaLang("room_levelup_init_and1")
	local var_33_5 = table.concat(var_33_0, var_33_4)

	arg_33_0._txtexposetips.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("assassin_stealth_expose_tip"), var_33_5)

	gohelper.setActive(arg_33_0._goexposetips, true)
	arg_33_0._exposeAnimatorPlayer:Play("open", arg_33_0._playExposeTipFinished, arg_33_0)
	AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_exposure)
	arg_33_0:refreshHeroHeadItem()
end

function var_0_0._playExposeTipFinished(arg_34_0)
	gohelper.setActive(arg_34_0._goexposetips, false)
	AssassinStealthGameController.instance:dispatchEvent(AssassinEvent.PlayExposeTipFinished)
end

function var_0_0._onPlayerEndTurn(arg_35_0)
	arg_35_0:refreshRound(true)
	arg_35_0:refreshEndPlayerRoundBtn()
end

function var_0_0._beforeEnterFight(arg_36_0)
	local var_36_0, var_36_1 = transformhelper.getLocalPos(arg_36_0._transmap)

	AssassinStealthGameModel.instance:setMapPosRecordOnFight(var_36_0, var_36_1, arg_36_0.curScale)
end

function var_0_0._onCloseView(arg_37_0, arg_37_1)
	if arg_37_1 == ViewName.AssassinStealthGameEventView then
		arg_37_0._bellAnimator:Play("get", 0, 0)
		AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_taskring)
	elseif arg_37_1 == ViewName.AssassinStealthGameGetItemView then
		for iter_37_0, iter_37_1 in ipairs(arg_37_0._heroHeadItemList) do
			iter_37_1:playGetItem(arg_37_0._getItemUid, arg_37_0._newItemDict)
		end

		arg_37_0._getItemUid = nil
		arg_37_0._newItemDict = nil

		AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_getitembag)
	elseif arg_37_1 == ViewName.LoadingView then
		if arg_37_0._needCheckGameRequestAfterCloseLoading then
			AssassinStealthGameController.instance:checkGameRequest()
		end

		arg_37_0._needCheckGameRequestAfterCloseLoading = nil
	end
end

function var_0_0._onBeginNewRound(arg_38_0)
	if AssassinStealthGameController.instance:checkGameState() then
		return
	end

	arg_38_0:refreshRound(true)
	arg_38_0:refreshBell()
	arg_38_0:refreshMoveDir()
	arg_38_0:refreshEndPlayerRoundBtn()
	arg_38_0:changeHeroSkillProp()
	arg_38_0:refreshHeroHeadItem()
end

local var_0_1 = 0.8

function var_0_0._onMissionUpdate(arg_39_0)
	arg_39_0:refreshTarget()
	arg_39_0:_checkMissionProgress()
end

function var_0_0._checkMissionProgress(arg_40_0)
	local var_40_0 = false
	local var_40_1, var_40_2 = AssassinStealthGameModel.instance:getMissionProgress()

	if var_40_2 <= var_40_1 then
		arg_40_0:_cancelFinishMissionTask()
		AssassinHelper.lockScreen(AssassinEnum.BlockKey.FinishMission, true)
		gohelper.setActive(arg_40_0._gostartLight, true)
		TaskDispatcher.runDelay(arg_40_0._onFinishMission, arg_40_0, var_0_1)

		var_40_0 = true
	end

	return var_40_0
end

function var_0_0._onFinishMission(arg_41_0)
	AssassinStealthGameController.instance:finishMission()
	AssassinHelper.lockScreen(AssassinEnum.BlockKey.FinishMission, false)
end

function var_0_0._cancelFinishMissionTask(arg_42_0)
	TaskDispatcher.cancelTask(arg_42_0._onFinishMission, arg_42_0)
	AssassinHelper.lockScreen(AssassinEnum.BlockKey.FinishMission, false)
end

function var_0_0._onMissionChange(arg_43_0)
	local var_43_0 = AssassinStealthGameModel.instance:getMissionId()

	if var_43_0 and var_43_0 > 0 then
		gohelper.setActive(arg_43_0._gochangeMissionEff, false)
		gohelper.setActive(arg_43_0._gochangeMissionEff, true)
		gohelper.setActive(arg_43_0._gostartLight, false)
		AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_nexttask)
		arg_43_0:refreshTarget()
	end

	if arg_43_0._needCheckGameRequest then
		AssassinStealthGameController.instance:checkGameRequest()
	end

	arg_43_0._needCheckGameRequest = nil
end

function var_0_0._onQTEInteractUpdate(arg_44_0)
	arg_44_0:refreshInteractQTEBtn()
end

function var_0_0._onGameSceneRecover(arg_45_0)
	arg_45_0:_resetGameView(false)
end

function var_0_0._onGameSceneRestart(arg_46_0)
	arg_46_0:_resetGameView(false)
end

function var_0_0._onGameChangeMap(arg_47_0)
	arg_47_0:_resetGameView(false)
end

function var_0_0._onAlertLevelChange(arg_48_0)
	arg_48_0:refreshBell()
end

function var_0_0._onTweenMapPos(arg_49_0, arg_49_1, arg_49_2)
	if not arg_49_1 then
		return
	end

	if arg_49_2 then
		local var_49_0, var_49_1 = transformhelper.getLocalPos(arg_49_0._transmap)

		AssassinStealthGameModel.instance:setMapPosRecordOnTurn(var_49_0, var_49_1, arg_49_0.curScale)
	end

	local var_49_2, var_49_3 = transformhelper.getLocalPos(arg_49_0._transmap)
	local var_49_4 = arg_49_1.x or var_49_2
	local var_49_5 = arg_49_1.y or var_49_3

	arg_49_0:tweenMapPos(var_49_4, var_49_5, arg_49_1.scale)
end

function var_0_0._onGuideFocusHero(arg_50_0, arg_50_1)
	local var_50_0 = AssassinStealthGameModel.instance:getSelectedHero()

	arg_50_1 = arg_50_1 and tonumber(arg_50_1)

	arg_50_0:mapFocus2Hero(var_50_0, arg_50_1, true)
end

function var_0_0._editableInitView(arg_51_0)
	AssassinStealthGameController.instance:initBaseMap(arg_51_0._gomap)

	arg_51_0._qteApComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_51_0._goapLayout, AssassinStealthGameAPComp)

	gohelper.setActive(arg_51_0._gotargetTip, false)

	arg_51_0._dirGOList = arg_51_0:getUserDataTb_()
	arg_51_0._dirGOList[#arg_51_0._dirGOList + 1] = gohelper.findChild(arg_51_0.viewGO, "root/#go_bell/image_top")
	arg_51_0._dirGOList[#arg_51_0._dirGOList + 1] = gohelper.findChild(arg_51_0.viewGO, "root/#go_bell/image_bottom")
	arg_51_0._dirGOList[#arg_51_0._dirGOList + 1] = gohelper.findChild(arg_51_0.viewGO, "root/#go_bell/image_left")
	arg_51_0._dirGOList[#arg_51_0._dirGOList + 1] = gohelper.findChild(arg_51_0.viewGO, "root/#go_bell/image_right")
	arg_51_0._opItemList = {}

	gohelper.setActive(arg_51_0._goopItem, false)

	local var_51_0 = arg_51_0._goopLayout.transform
	local var_51_1 = var_51_0.childCount

	for iter_51_0 = 1, var_51_1 do
		local var_51_2 = arg_51_0:getUserDataTb_()
		local var_51_3 = var_51_0:GetChild(iter_51_0 - 1)

		var_51_2.go = gohelper.clone(arg_51_0._goopItem, var_51_3.gameObject, "opItem")
		var_51_2.imageicon = gohelper.findChildImage(var_51_2.go, "#image_icon")

		local var_51_4 = gohelper.findChild(var_51_2.go, "#go_apLayout")

		var_51_2.btnclick = gohelper.findChildClickWithAudio(var_51_2.go, "#btn_click", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
		var_51_2.apComp = MonoHelper.addNoUpdateLuaComOnceToGo(var_51_4, AssassinStealthGameAPComp)

		var_51_2.btnclick:AddClickListener(arg_51_0._onOpItemClick, arg_51_0, iter_51_0)

		arg_51_0._opItemList[iter_51_0] = var_51_2
	end

	local var_51_5 = arg_51_0.viewGO.transform

	arg_51_0._viewWidth = recthelper.getWidth(var_51_5)
	arg_51_0._viewHeight = recthelper.getHeight(var_51_5)
	arg_51_0.mapWidth = arg_51_0._viewWidth / AssassinEnum.StealthConst.MinMapScale
	arg_51_0.mapHeight = arg_51_0._viewHeight / AssassinEnum.StealthConst.MinMapScale
	arg_51_0._transmap = arg_51_0._gomap.transform
	arg_51_0._transdrag = arg_51_0._godrag.transform
	arg_51_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_51_0._godrag)
	arg_51_0._touchEventMgr = TouchEventMgrHepler.getTouchEventMgr(arg_51_0._godrag)

	arg_51_0._touchEventMgr:SetIgnoreUI(true)

	arg_51_0._useitemdrag = SLFramework.UGUI.UIDragListener.Get(arg_51_0._gouseItem)
	arg_51_0._transselectenemy = arg_51_0._goselectenemy.transform
	arg_51_0._transselectenemywheel = arg_51_0._goselectedwheel.transform
	arg_51_0._transuseitemtargetlayer = arg_51_0._gouseitemtargetlayer.transform

	arg_51_0:setLocalScale()
	arg_51_0:setMapPos(0, 0)

	arg_51_0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_51_0.viewGO)
	arg_51_0._bellAnimator = arg_51_0._gobell:GetComponent(typeof(UnityEngine.Animator))
	arg_51_0._topAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_51_0._gotop)
	arg_51_0._useItemAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_51_0._gouseItem)
	arg_51_0._showAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_51_0._goshow)
	arg_51_0._selectEnemyAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_51_0._goselectenemy)
	arg_51_0._exposeAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_51_0._goexposetips)

	gohelper.setActive(arg_51_0._gotips, true)
end

function var_0_0.mapFocus2Hero(arg_52_0, arg_52_1, arg_52_2, arg_52_3)
	local var_52_0 = AssassinStealthGameModel.instance:getHeroMo(arg_52_1, true)

	if not var_52_0 then
		return
	end

	local var_52_1 = var_52_0:getPos()

	arg_52_0:mapFocus2Grid(var_52_1, arg_52_2, arg_52_3)
end

function var_0_0.mapFocus2Grid(arg_53_0, arg_53_1, arg_53_2, arg_53_3, arg_53_4, arg_53_5)
	local var_53_0 = AssassinStealthGameEntityMgr.instance:getGridItem(arg_53_1, true)
	local var_53_1 = var_53_0 and var_53_0:getGoPosition()

	if var_53_1 then
		if arg_53_3 then
			AssassinHelper.lockScreen(AssassinEnum.BlockKey.TweenMapPos, true)
		end

		local var_53_2 = arg_53_0._transmap:InverseTransformPoint(var_53_1)

		arg_53_0:tweenMapPos(-var_53_2.x, -var_53_2.y, arg_53_2, arg_53_4, arg_53_5)
	end
end

function var_0_0.setLocalScale(arg_54_0)
	arg_54_0.curScale = Mathf.Clamp(arg_54_0.curScale or 1, AssassinEnum.StealthConst.MinMapScale, AssassinEnum.StealthConst.MaxMapScale)

	transformhelper.setLocalScale(arg_54_0._transmap, arg_54_0.curScale, arg_54_0.curScale, 1)
	transformhelper.setLocalScale(arg_54_0._transselectenemywheel, arg_54_0.curScale, arg_54_0.curScale, 1)
	arg_54_0:calculateDragBorder()
	arg_54_0:setMapPos()
end

function var_0_0.calculateDragBorder(arg_55_0)
	local var_55_0 = arg_55_0.mapWidth * arg_55_0.curScale
	local var_55_1 = arg_55_0.mapHeight * arg_55_0.curScale

	arg_55_0.maxOffsetX = (var_55_0 - arg_55_0._viewWidth) / 2
	arg_55_0.maxOffsetY = (var_55_1 - arg_55_0._viewHeight) / 2
end

function var_0_0.checkInGuide(arg_56_0)
	local var_56_0 = GuideModel.instance:isDoingClickGuide()
	local var_56_1 = GuideController.instance:isForbidGuides()

	if var_56_0 and not var_56_1 then
		return true
	end

	if GuideController.instance:isGuiding() then
		return true
	end
end

function var_0_0.setMapPos(arg_57_0, arg_57_1, arg_57_2)
	if not arg_57_1 or not arg_57_2 then
		arg_57_1, arg_57_2 = transformhelper.getLocalPos(arg_57_0._transmap)
	end

	arg_57_1 = Mathf.Clamp(arg_57_1, -arg_57_0.maxOffsetX, arg_57_0.maxOffsetX)
	arg_57_2 = Mathf.Clamp(arg_57_2, -arg_57_0.maxOffsetY, arg_57_0.maxOffsetY)

	transformhelper.setLocalPosXY(arg_57_0._transmap, arg_57_1, arg_57_2)
	AssassinStealthGameEntityMgr.instance:refreshSkillPropTargetPos()
end

function var_0_0.tweenMapPos(arg_58_0, arg_58_1, arg_58_2, arg_58_3, arg_58_4, arg_58_5)
	if not arg_58_1 or not arg_58_2 then
		AssassinHelper.lockScreen(AssassinEnum.BlockKey.TweenMapPos, false)

		return
	end

	arg_58_0:killTween()

	arg_58_0._tweenMapPosFinishCb = arg_58_4
	arg_58_0._tweenMapPosFinishCbObj = arg_58_5
	arg_58_0._tweenStartPosX, arg_58_0._tweenStartPosY = transformhelper.getLocalPos(arg_58_0._transmap)
	arg_58_0._tweenStartScale = arg_58_0.curScale

	local var_58_0 = true

	if arg_58_3 then
		arg_58_0._tweenTargetPosX = arg_58_1
		arg_58_0._tweenTargetPosY = arg_58_2
		arg_58_0._tweenTargetScale = arg_58_3
		var_58_0 = arg_58_0._tweenTargetScale == arg_58_0.curScale
	else
		arg_58_0._tweenTargetPosX = Mathf.Clamp(arg_58_1, -arg_58_0.maxOffsetX, arg_58_0.maxOffsetX)
		arg_58_0._tweenTargetPosY = Mathf.Clamp(arg_58_2, -arg_58_0.maxOffsetY, arg_58_0.maxOffsetY)
	end

	if arg_58_0._tweenStartPosX == arg_58_0._tweenTargetPosX and arg_58_0._tweenStartPosY == arg_58_0._tweenTargetPosY and var_58_0 then
		arg_58_0:tweenFinishCallback()

		return
	end

	arg_58_0.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, AssassinEnum.StealthConst.MapTweenPosTime, arg_58_0.tweenFrameCallback, arg_58_0.tweenFinishCallback, arg_58_0)

	arg_58_0:tweenFrameCallback(0)
end

function var_0_0.tweenFrameCallback(arg_59_0, arg_59_1)
	if arg_59_0._tweenTargetScale then
		arg_59_0.curScale = Mathf.Lerp(arg_59_0._tweenStartScale, arg_59_0._tweenTargetScale, arg_59_1)

		arg_59_0:setLocalScale()
	end

	local var_59_0 = Mathf.Lerp(arg_59_0._tweenStartPosX, arg_59_0._tweenTargetPosX, arg_59_1)
	local var_59_1 = Mathf.Lerp(arg_59_0._tweenStartPosY, arg_59_0._tweenTargetPosY, arg_59_1)

	arg_59_0:setMapPos(var_59_0, var_59_1)
end

function var_0_0.tweenFinishCallback(arg_60_0)
	if arg_60_0._tweenTargetScale then
		arg_60_0.curScale = arg_60_0._tweenTargetScale

		arg_60_0:setLocalScale()
	end

	arg_60_0:setMapPos(arg_60_0._tweenTargetPosX, arg_60_0._tweenTargetPosY)

	if arg_60_0._tweenMapPosFinishCb then
		arg_60_0._tweenMapPosFinishCb(arg_60_0._tweenMapPosFinishCbObj)
	end

	arg_60_0:killTween()
	AssassinHelper.lockScreen(AssassinEnum.BlockKey.TweenMapPos, false)
end

function var_0_0.killTween(arg_61_0)
	if arg_61_0.tweenId then
		ZProj.TweenHelper.KillById(arg_61_0.tweenId)
	end

	arg_61_0.tweenId = nil
	arg_61_0._tweenMapPosFinishCb = nil
	arg_61_0._tweenMapPosFinishCbObj = nil
	arg_61_0._tweenStartPosX = nil
	arg_61_0._tweenStartPosY = nil
	arg_61_0._tweenTargetPosX = nil
	arg_61_0._tweenTargetPosY = nil
	arg_61_0._tweenStartScale = nil
	arg_61_0._tweenTargetScale = nil
end

function var_0_0.onUpdateParam(arg_62_0)
	return
end

function var_0_0.onOpen(arg_63_0)
	local var_63_0 = arg_63_0.viewParam and arg_63_0.viewParam.fightReturn

	arg_63_0:_resetGameView(var_63_0, true)

	local var_63_1 = AssassinStealthGameModel.instance:getMapId()

	AssassinStealthGameController.instance:dispatchEvent(AssassinEvent.TriggerGuideOnEnterStealthGameMap, var_63_1)
end

function var_0_0._resetGameView(arg_64_0, arg_64_1, arg_64_2)
	arg_64_0._needCheckGameRequest = nil
	arg_64_0._needCheckGameRequestAfterCloseLoading = nil

	arg_64_0:killTween()
	gohelper.setActive(arg_64_0._gochangeMissionEff, false)
	gohelper.setActive(arg_64_0._gostartLight, false)
	arg_64_0:initHeroItem()
	arg_64_0:refresh()

	local var_64_0 = AssassinStealthGameModel.instance:getIsNeedRequest()
	local var_64_1 = false

	if arg_64_2 then
		var_64_1 = AssassinStealthGameModel.instance:getGameState() ~= AssassinEnum.GameState.InProgress
	end

	if var_64_0 or arg_64_1 or var_64_1 then
		gohelper.setActive(arg_64_0._gomissionTip, false)
		arg_64_0._animatorPlayer:Play("open2", arg_64_0._afterOpen2Anim, arg_64_0)
	else
		arg_64_0:showTargetTip()
		arg_64_0._animatorPlayer:Play("open1", arg_64_0.showEvent, arg_64_0)
	end

	arg_64_0:_hideUseItemGo()

	local var_64_2
	local var_64_3
	local var_64_4

	if arg_64_1 and arg_64_0.viewParam then
		var_64_2 = arg_64_0.viewParam.mapPosX
		var_64_3 = arg_64_0.viewParam.mapPosY
		var_64_4 = arg_64_0.viewParam.mapScale
	end

	if var_64_4 then
		arg_64_0.curScale = var_64_4

		arg_64_0:setLocalScale()
	end

	if var_64_2 and var_64_3 then
		arg_64_0:setMapPos(var_64_2, var_64_3)
	else
		local var_64_5 = AssassinConfig.instance:getAssassinConst(AssassinEnum.ConstId.RequireAssassinHeroId, true)
		local var_64_6 = AssassinStealthGameModel.instance:getHeroUidByAssassinHeroId(var_64_5)

		arg_64_0:mapFocus2Hero(var_64_6)
	end
end

function var_0_0._afterOpen2Anim(arg_65_0)
	if AssassinStealthGameController.instance:checkGameState() then
		return
	end

	if arg_65_0:_checkMissionProgress() then
		arg_65_0._needCheckGameRequest = true
	elseif ViewMgr.instance:isOpen(ViewName.LoadingView) then
		arg_65_0._needCheckGameRequestAfterCloseLoading = true
	else
		AssassinStealthGameController.instance:checkGameRequest()
	end
end

function var_0_0.initHeroItem(arg_66_0, arg_66_1, arg_66_2)
	arg_66_0._heroHeadItemList = {}

	local var_66_0 = {}
	local var_66_1 = AssassinStealthGameModel.instance:getHeroUidList()
	local var_66_2 = #var_66_1

	for iter_66_0, iter_66_1 in ipairs(var_66_1) do
		var_66_0[iter_66_0] = {
			heroUid = iter_66_1,
			checkSelectedAnim = arg_66_1,
			oldSelectedHeroUid = arg_66_2,
			isLastHeroHead = iter_66_0 == var_66_2
		}
	end

	gohelper.CreateObjList(arg_66_0, arg_66_0._onCreateHeroHeadItem, var_66_0, arg_66_0._goheroLayout, arg_66_0._goheroItem, AssassinStealthGameHeroHeadItem)
end

function var_0_0._onCreateHeroHeadItem(arg_67_0, arg_67_1, arg_67_2, arg_67_3)
	arg_67_1:setData(arg_67_2)

	arg_67_0._heroHeadItemList[arg_67_3] = arg_67_1
end

function var_0_0.showTargetTip(arg_68_0)
	local var_68_0 = AssassinStealthGameModel.instance:getMissionId()

	if var_68_0 <= 0 then
		return
	end

	local var_68_1 = AssassinConfig.instance:getStealthMissionDesc(var_68_0)

	arg_68_0._txtmissionTip.text = var_68_1

	gohelper.setActive(arg_68_0._gomissionTip, false)
	gohelper.setActive(arg_68_0._gomissionTip, true)
	AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_taskin)
end

function var_0_0.showEvent(arg_69_0)
	AssassinController.instance:openAssassinStealthGameEventView()
	AssassinHelper.lockScreen(AssassinEnum.BlockKey.PlayRoundAnim, false)
end

function var_0_0.refresh(arg_70_0)
	arg_70_0:refreshRound()
	arg_70_0:refreshMoveDir()
	arg_70_0:refreshTarget()
	arg_70_0:refreshHeroHeadItem()
	arg_70_0:refreshBell()
	arg_70_0:refreshInteractQTEBtn()
	arg_70_0:refreshEndPlayerRoundBtn()
end

function var_0_0.refreshRound(arg_71_0, arg_71_1)
	local var_71_0 = AssassinStealthGameModel.instance:isPlayerTurn()

	gohelper.setActive(arg_71_0._goplayerturnbg, var_71_0)
	gohelper.setActive(arg_71_0._goenemyturnbg, not var_71_0)

	local var_71_1 = var_71_0 and luaLang("assassin_stealth_game_player_turn") or luaLang("assassin_stealth_game_enemy_turn")

	arg_71_0._txtroundTip.text = var_71_1
	arg_71_0._txtroundTipEff.text = var_71_1

	local var_71_2 = AssassinStealthGameModel.instance:getRound()
	local var_71_3 = AssassinConfig.instance:getAssassinStealthConst(AssassinEnum.StealthConstId.MaxRound)

	arg_71_0._txtround.text = string.format("%s/%s", var_71_2, var_71_3)

	if arg_71_1 then
		if var_71_0 then
			arg_71_0._topAnimatorPlayer:Play("open", arg_71_0.showEvent, arg_71_0)
			AssassinHelper.lockScreen(AssassinEnum.BlockKey.PlayRoundAnim, true)
		else
			arg_71_0._topAnimatorPlayer:Play("open")
		end

		AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_foeround)
	end
end

function var_0_0.refreshTarget(arg_72_0)
	local var_72_0 = AssassinStealthGameModel.instance:getMissionId()

	if var_72_0 <= 0 then
		return
	end

	local var_72_1 = AssassinConfig.instance:getStealthMissionDesc(var_72_0)
	local var_72_2, var_72_3 = AssassinStealthGameModel.instance:getMissionProgress()
	local var_72_4 = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("assassin_stealth_game_mission_progress"), var_72_2, var_72_3)

	arg_72_0._txttarget.text = string.format("%s%s", var_72_1, var_72_4)
end

function var_0_0.refreshHeroHeadItem(arg_73_0, arg_73_1, arg_73_2)
	for iter_73_0, iter_73_1 in ipairs(arg_73_0._heroHeadItemList) do
		iter_73_1:refresh(arg_73_1, arg_73_2)
	end
end

function var_0_0.changeHeroSkillProp(arg_74_0)
	for iter_74_0, iter_74_1 in ipairs(arg_74_0._heroHeadItemList) do
		iter_74_1:onSkillPropChange()
	end
end

function var_0_0.refreshBell(arg_75_0)
	local var_75_0 = AssassinStealthGameModel.instance:isAlertBellRing()

	gohelper.setActive(arg_75_0._gogreen, not var_75_0)
	gohelper.setActive(arg_75_0._gored, var_75_0)
	gohelper.setActive(arg_75_0._gobellringmask, var_75_0)
	arg_75_0:_changeBgmState()
end

function var_0_0._changeBgmState(arg_76_0)
	local var_76_0

	if AssassinStealthGameModel.instance:isAlertBellRing() then
		var_76_0 = AudioMgr.instance:getIdFromString("danger")
	else
		var_76_0 = AudioMgr.instance:getIdFromString("explore")
	end

	local var_76_1 = AudioMgr.instance:getIdFromString("dl_music")

	AudioMgr.instance:setState(var_76_1, var_76_0)
end

function var_0_0.refreshInteractQTEBtn(arg_77_0)
	local var_77_0 = AssassinStealthGameHelper.isSelectedHeroCanInteract()

	if var_77_0 then
		local var_77_1 = AssassinStealthGameModel.instance:getSelectedHeroGameMo():getPos()
		local var_77_2 = AssassinStealthGameModel.instance:getGridInteractId(var_77_1)
		local var_77_3 = AssassinConfig.instance:getInteractApCost(var_77_2)

		arg_77_0._qteApComp:setAPCount(var_77_3)
	end

	gohelper.setActive(arg_77_0._btnqte, var_77_0)
end

function var_0_0.refreshEndPlayerRoundBtn(arg_78_0)
	local var_78_0 = AssassinStealthGameModel.instance:isPlayerTurn()

	gohelper.setActive(arg_78_0._btnend, var_78_0)
end

function var_0_0.refreshMoveDir(arg_79_0)
	local var_79_0 = AssassinStealthGameModel.instance:getEnemyMoveDir()

	for iter_79_0, iter_79_1 in ipairs(arg_79_0._dirGOList) do
		gohelper.setActive(iter_79_1, iter_79_0 == var_79_0)
	end
end

function var_0_0.onClose(arg_80_0)
	arg_80_0._simagepic:UnLoadImage()
	arg_80_0:killTween()
	arg_80_0:_cancelFinishMissionTask()

	arg_80_0._needCheckGameRequest = nil
	arg_80_0._needCheckGameRequestAfterCloseLoading = nil

	AssassinHelper.lockScreen(AssassinEnum.BlockKey.TweenMapPos, false)
	AssassinHelper.lockScreen(AssassinEnum.BlockKey.SelectedEnemy, false)
	AssassinHelper.lockScreen(AssassinEnum.BlockKey.FinishMission, false)
	AssassinHelper.lockScreen(AssassinEnum.BlockKey.PlayRoundAnim, false)
end

function var_0_0.onDestroyView(arg_81_0)
	arg_81_0._opItemList = nil
	arg_81_0._heroHeadItemList = nil

	AssassinStealthGameController.instance:onGameViewDestroy()
end

return var_0_0
