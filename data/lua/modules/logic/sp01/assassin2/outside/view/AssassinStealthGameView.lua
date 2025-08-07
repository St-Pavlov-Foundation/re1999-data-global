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

	local var_13_0 = arg_13_2 * 0.01

	arg_13_0.curScale = arg_13_0.curScale + var_13_0

	arg_13_0:setLocalScale()
end

function var_0_0._onMouseScrollWheelChange(arg_14_0, arg_14_1)
	local var_14_0 = true
	local var_14_1 = AssassinStealthGameModel.instance:getMapId()
	local var_14_2, var_14_3 = AssassinConfig.instance:getStealthMapForbidScaleGuide(var_14_1)

	if var_14_2 then
		if var_14_3 then
			var_14_0 = GuideModel.instance:isStepFinish(var_14_2, var_14_3)
		else
			var_14_0 = GuideModel.instance:isGuideFinish(var_14_2)
		end
	end

	if not var_14_0 then
		return
	end

	if arg_14_0:checkInGuide() then
		return
	end

	if UIBlockMgr.instance:isBlock() then
		return
	end

	local var_14_4 = ViewMgr.instance:getOpenViewNameList()

	if var_14_4[#var_14_4] ~= arg_14_0.viewName then
		return
	end

	if arg_14_0.tweenId or arg_14_0._gouseItem.activeSelf or arg_14_0._goselectenemy.activeSelf or arg_14_0._goshow.activeSelf then
		return
	end

	arg_14_0.curScale = arg_14_0.curScale + arg_14_1

	arg_14_0:setLocalScale()
end

function var_0_0._btntechniqueOnClick(arg_15_0)
	AssassinController.instance:openAssassinStealthTechniqueView()
end

function var_0_0._onEscBtnClick(arg_16_0)
	if arg_16_0:checkInGuide() then
		return
	end

	AssassinController.instance:openAssassinStealthGamePauseView()
end

function var_0_0._onHeroUpdate(arg_17_0)
	arg_17_0:refreshInteractQTEBtn()
	arg_17_0:refreshHeroHeadItem()
end

function var_0_0._onHeroMove(arg_18_0)
	arg_18_0:refreshInteractQTEBtn()
	arg_18_0:refreshHeroHeadItem()
end

function var_0_0._onSelectedHero(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_1.lastSelectedHeroUid

	if AssassinStealthGameModel.instance:getSelectedHero() then
		arg_19_0:initHeroItem(true, var_19_0)
	else
		arg_19_0:refreshHeroHeadItem(true, var_19_0)
	end

	arg_19_0:refreshInteractQTEBtn()

	local var_19_1 = arg_19_1.needFocus
	local var_19_2 = AssassinStealthGameModel.instance:getSelectedHeroGameMo()

	if var_19_1 and var_19_2 then
		local var_19_3 = var_19_2:getPos()

		arg_19_0:mapFocus2Grid(var_19_3)
	end
end

function var_0_0._onSelectEnemy(arg_20_0, arg_20_1)
	local var_20_0 = AssassinStealthGameModel.instance:getSelectedEnemyGameMo()

	if var_20_0 then
		arg_20_0:_setSelectedEnemyOpItemList()

		if arg_20_1 then
			AssassinStealthGameEntityMgr.instance:changeEnemyParent(arg_20_1)
			AssassinStealthGameEntityMgr.instance:refreshEnemyEntity(arg_20_1)
		end

		local var_20_1 = var_20_0:getPos()

		arg_20_0:mapFocus2Grid(var_20_1, nil, true, arg_20_0._changeSelectedEnemyLayer, arg_20_0)
	else
		AssassinHelper.lockScreen(AssassinEnum.BlockKey.SelectedEnemy, true)

		arg_20_0._oldSelectedEnemy = arg_20_1

		arg_20_0._selectEnemyAnimatorPlayer:Play("close", arg_20_0._hideSelectEnemyGo, arg_20_0)
	end
end

function var_0_0._changeSelectedEnemyLayer(arg_21_0)
	local var_21_0 = AssassinStealthGameModel.instance:getSelectedEnemyGameMo()

	if var_21_0 then
		local var_21_1 = var_21_0:getUid()

		AssassinStealthGameEntityMgr.instance:changeEnemyParent(var_21_1, arg_21_0._transselectenemy)

		local var_21_2, var_21_3 = AssassinStealthGameEntityMgr.instance:getEnemyLocalPos(var_21_1)

		if var_21_2 and var_21_3 then
			transformhelper.setLocalPosXY(arg_21_0._transselectenemywheel, var_21_2, var_21_3)
		end

		gohelper.setActive(arg_21_0._goselectenemy, true)
		arg_21_0._selectEnemyAnimatorPlayer:Play("open", nil, arg_21_0)
	end
end

function var_0_0._setSelectedEnemyOpItemList(arg_22_0)
	local var_22_0 = {}
	local var_22_1
	local var_22_2 = AssassinStealthGameHelper.getSelectedHeroAssassinateActId()

	if var_22_2 then
		local var_22_3 = {
			actId = var_22_2
		}

		var_22_0[#var_22_0 + 1] = var_22_3
	end

	local var_22_4, var_22_5 = AssassinStealthGameHelper.getSelectedHeroAttackActId()

	var_22_0[#var_22_0 + 1] = var_22_4
	var_22_0[#var_22_0 + 1] = var_22_5

	for iter_22_0, iter_22_1 in ipairs(arg_22_0._opItemList) do
		local var_22_6 = var_22_0[iter_22_0]

		if var_22_6 then
			local var_22_7 = var_22_6
			local var_22_8 = false

			if LuaUtil.isTable(var_22_6) then
				var_22_7 = var_22_6.actId
				var_22_8 = true
			end

			AssassinHelper.setAssassinActIcon(var_22_7, iter_22_1.imageicon)

			local var_22_9 = AssassinConfig.instance:getAssassinActPower(var_22_7)

			iter_22_1.apComp:setAPCount(var_22_9)

			iter_22_1.actId = var_22_7
			iter_22_1.isAssassinate = var_22_8
		else
			iter_22_1.actId = nil
			iter_22_1.isAssassinate = nil
		end

		gohelper.setActive(iter_22_1.go, iter_22_1.actId)
	end

	gohelper.CreateObjList(arg_22_0, arg_22_0._onCreateOpReadmeItem, var_22_0, arg_22_0._goopreadmelayout, arg_22_0._goopreadmeItem)
end

function var_0_0._onCreateOpReadmeItem(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	local var_23_0 = arg_23_2

	if LuaUtil.isTable(arg_23_2) then
		var_23_0 = arg_23_2.actId
	end

	local var_23_1 = gohelper.findChildImage(arg_23_1, "#image_icon")

	AssassinHelper.setAssassinActIcon(var_23_0, var_23_1)

	gohelper.findChildText(arg_23_1, "#txt_name").text = AssassinConfig.instance:getAssassinActName(var_23_0)
end

function var_0_0._hideSelectEnemyGo(arg_24_0)
	if arg_24_0._oldSelectedEnemy then
		AssassinStealthGameEntityMgr.instance:changeEnemyParent(arg_24_0._oldSelectedEnemy)
		AssassinStealthGameEntityMgr.instance:refreshEnemyEntity(arg_24_0._oldSelectedEnemy)

		arg_24_0._oldSelectedEnemy = nil
	end

	AssassinHelper.lockScreen(AssassinEnum.BlockKey.SelectedEnemy, false)
	gohelper.setActive(arg_24_0._goselectenemy, false)
end

function var_0_0._onSelectSkillProp(arg_25_0, arg_25_1)
	for iter_25_0, iter_25_1 in ipairs(arg_25_0._heroHeadItemList) do
		iter_25_1:refreshSkillProp()
	end

	local var_25_0, var_25_1 = AssassinStealthGameModel.instance:getSelectedSkillProp()

	if var_25_0 then
		local var_25_2 = ""
		local var_25_3 = ""

		if var_25_1 then
			AssassinHelper.setAssassinSkillIcon(var_25_0, arg_25_0._imageitemicon)

			var_25_2 = AssassinConfig.instance:getAssassinSkillName(var_25_0)
			var_25_3 = AssassinConfig.instance:getAssassinCareerSkillDesc(var_25_0)
		else
			AssassinHelper.setAssassinItemIcon(var_25_0, arg_25_0._imageitemicon)

			var_25_2 = AssassinConfig.instance:getAssassinItemName(var_25_0)
			var_25_3 = AssassinConfig.instance:getAssassinItemStealthEffDesc(var_25_0)
		end

		arg_25_0._txtitemName.text = var_25_2
		arg_25_0._txtitemDesc.text = var_25_3

		gohelper.setActive(arg_25_0._goitemtag, false)
	end

	arg_25_0:_setIsShowUseItem(var_25_0, arg_25_1)
end

function var_0_0._onUseSkillProp(arg_26_0)
	arg_26_0:_setIsShowUseItem(false)
	arg_26_0:changeHeroSkillProp()
end

function var_0_0._setIsShowUseItem(arg_27_0, arg_27_1, arg_27_2)
	if arg_27_1 then
		gohelper.setActive(arg_27_0._gouseItem, true)

		local var_27_0 = AssassinStealthGameEntityMgr.instance:changeSkillPropTargetLayer(arg_27_0._transuseitemtargetlayer) and "assassin_stealth_use_skill_prop_select_target" or "assassin_stealth_use_skill_prop_no_target"

		arg_27_0._txttips.text = luaLang(var_27_0)
	else
		AssassinStealthGameEntityMgr.instance:changeSkillPropTargetLayer(arg_27_0._transuseitemtargetlayer)

		if arg_27_2 then
			arg_27_0:_hideUseItemGo()
		else
			arg_27_0._useItemAnimatorPlayer:Play("close", arg_27_0._hideUseItemGo, arg_27_0)
		end
	end
end

function var_0_0._hideUseItemGo(arg_28_0)
	gohelper.setActive(arg_28_0._gouseItem, false)
end

function var_0_0._showHeroActImg(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = AssassinConfig.instance:getAssassinActShowImg(arg_29_1)

	if string.nilorempty(var_29_0) then
		AssassinStealthGameController.instance:showActImgFinish(arg_29_1, arg_29_2)
	else
		arg_29_0._txtname.text = AssassinConfig.instance:getAssassinActName(arg_29_1)

		AssassinHelper.setAssassinActIcon(arg_29_1, arg_29_0._imageshowicon)

		local var_29_1 = ResUrl.getSp01AssassinSingleBg("stealth/" .. var_29_0)

		arg_29_0._simagepic:LoadImage(var_29_1)

		arg_29_0._showActId = arg_29_1
		arg_29_0._actParam = arg_29_2

		gohelper.setActive(arg_29_0._goshow, true)
		arg_29_0._showAnimatorPlayer:Play("open", arg_29_0._playShowFinished, arg_29_0)

		local var_29_2 = AssassinConfig.instance:getAssassinActAudioId(arg_29_1)

		if var_29_2 and var_29_2 ~= 0 then
			AudioMgr.instance:trigger(var_29_2)
		end
	end
end

function var_0_0._playShowFinished(arg_30_0)
	gohelper.setActive(arg_30_0._goshow, false)
	AssassinStealthGameController.instance:showActImgFinish(arg_30_0._showActId, arg_30_0._actParam)
end

function var_0_0._onHeroGetItem(arg_31_0, arg_31_1, arg_31_2)
	arg_31_0._getItemUid = arg_31_1
	arg_31_0._newItemDict = arg_31_2

	AssassinStealthGameController.instance:selectSkillProp(nil, nil, true)
end

function var_0_0._onShowExposeTip(arg_32_0, arg_32_1)
	local var_32_0 = {}

	for iter_32_0, iter_32_1 in ipairs(arg_32_1) do
		local var_32_1 = AssassinStealthGameModel.instance:getHeroMo(iter_32_1, true)
		local var_32_2 = var_32_1 and var_32_1:getHeroId()
		local var_32_3 = AssassinHeroModel.instance:getAssassinHeroName(var_32_2)

		if not string.nilorempty(var_32_3) then
			var_32_0[#var_32_0 + 1] = var_32_3
		end
	end

	local var_32_4 = luaLang("room_levelup_init_and1")
	local var_32_5 = table.concat(var_32_0, var_32_4)

	arg_32_0._txtexposetips.text = GameUtil.getSubPlaceholderLuaLangOneParam(luaLang("assassin_stealth_expose_tip"), var_32_5)

	gohelper.setActive(arg_32_0._goexposetips, true)
	arg_32_0._exposeAnimatorPlayer:Play("open", arg_32_0._playExposeTipFinished, arg_32_0)
	AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_exposure)
	arg_32_0:refreshHeroHeadItem()
end

function var_0_0._playExposeTipFinished(arg_33_0)
	gohelper.setActive(arg_33_0._goexposetips, false)
	AssassinStealthGameController.instance:dispatchEvent(AssassinEvent.PlayExposeTipFinished)
end

function var_0_0._onPlayerEndTurn(arg_34_0)
	arg_34_0:refreshRound(true)
	arg_34_0:refreshEndPlayerRoundBtn()
end

function var_0_0._beforeEnterFight(arg_35_0)
	local var_35_0, var_35_1 = transformhelper.getLocalPos(arg_35_0._transmap)

	AssassinStealthGameModel.instance:setMapPosRecordOnFight(var_35_0, var_35_1, arg_35_0.curScale)
end

function var_0_0._onCloseView(arg_36_0, arg_36_1)
	if arg_36_1 == ViewName.AssassinStealthGameEventView then
		arg_36_0._bellAnimator:Play("get", 0, 0)
		AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_taskring)
	elseif arg_36_1 == ViewName.AssassinStealthGameGetItemView then
		for iter_36_0, iter_36_1 in ipairs(arg_36_0._heroHeadItemList) do
			iter_36_1:playGetItem(arg_36_0._getItemUid, arg_36_0._newItemDict)
		end

		arg_36_0._getItemUid = nil
		arg_36_0._newItemDict = nil

		AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_getitembag)
	elseif arg_36_1 == ViewName.LoadingView then
		if arg_36_0._needCheckGameRequestAfterCloseLoading then
			AssassinStealthGameController.instance:checkGameRequest()
		end

		arg_36_0._needCheckGameRequestAfterCloseLoading = nil
	end
end

function var_0_0._onBeginNewRound(arg_37_0)
	if AssassinStealthGameController.instance:checkGameState() then
		return
	end

	arg_37_0:refreshRound(true)
	arg_37_0:refreshBell()
	arg_37_0:refreshMoveDir()
	arg_37_0:refreshEndPlayerRoundBtn()
	arg_37_0:changeHeroSkillProp()
	arg_37_0:refreshHeroHeadItem()
end

local var_0_1 = 0.8

function var_0_0._onMissionUpdate(arg_38_0)
	arg_38_0:refreshTarget()
	arg_38_0:_checkMissionProgress()
end

function var_0_0._checkMissionProgress(arg_39_0)
	local var_39_0 = false
	local var_39_1, var_39_2 = AssassinStealthGameModel.instance:getMissionProgress()

	if var_39_2 <= var_39_1 then
		arg_39_0:_cancelFinishMissionTask()
		AssassinHelper.lockScreen(AssassinEnum.BlockKey.FinishMission, true)
		gohelper.setActive(arg_39_0._gostartLight, true)
		TaskDispatcher.runDelay(arg_39_0._onFinishMission, arg_39_0, var_0_1)

		var_39_0 = true
	end

	return var_39_0
end

function var_0_0._onFinishMission(arg_40_0)
	AssassinStealthGameController.instance:finishMission()
	AssassinHelper.lockScreen(AssassinEnum.BlockKey.FinishMission, false)
end

function var_0_0._cancelFinishMissionTask(arg_41_0)
	TaskDispatcher.cancelTask(arg_41_0._onFinishMission, arg_41_0)
	AssassinHelper.lockScreen(AssassinEnum.BlockKey.FinishMission, false)
end

function var_0_0._onMissionChange(arg_42_0)
	local var_42_0 = AssassinStealthGameModel.instance:getMissionId()

	if var_42_0 and var_42_0 > 0 then
		gohelper.setActive(arg_42_0._gochangeMissionEff, false)
		gohelper.setActive(arg_42_0._gochangeMissionEff, true)
		gohelper.setActive(arg_42_0._gostartLight, false)
		AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_nexttask)
		arg_42_0:refreshTarget()
	end

	if arg_42_0._needCheckGameRequest then
		AssassinStealthGameController.instance:checkGameRequest()
	end

	arg_42_0._needCheckGameRequest = nil
end

function var_0_0._onQTEInteractUpdate(arg_43_0)
	arg_43_0:refreshInteractQTEBtn()
end

function var_0_0._onGameSceneRecover(arg_44_0)
	arg_44_0:_resetGameView(false)
end

function var_0_0._onGameSceneRestart(arg_45_0)
	arg_45_0:_resetGameView(false)
end

function var_0_0._onGameChangeMap(arg_46_0)
	arg_46_0:_resetGameView(false)
end

function var_0_0._onAlertLevelChange(arg_47_0)
	arg_47_0:refreshBell()
end

function var_0_0._onTweenMapPos(arg_48_0, arg_48_1, arg_48_2)
	if not arg_48_1 then
		return
	end

	if arg_48_2 then
		local var_48_0, var_48_1 = transformhelper.getLocalPos(arg_48_0._transmap)

		AssassinStealthGameModel.instance:setMapPosRecordOnTurn(var_48_0, var_48_1, arg_48_0.curScale)
	end

	local var_48_2, var_48_3 = transformhelper.getLocalPos(arg_48_0._transmap)
	local var_48_4 = arg_48_1.x or var_48_2
	local var_48_5 = arg_48_1.y or var_48_3

	arg_48_0:tweenMapPos(var_48_4, var_48_5, arg_48_1.scale)
end

function var_0_0._onGuideFocusHero(arg_49_0, arg_49_1)
	local var_49_0 = AssassinStealthGameModel.instance:getSelectedHero()

	arg_49_1 = arg_49_1 and tonumber(arg_49_1)

	arg_49_0:mapFocus2Hero(var_49_0, arg_49_1, true)
end

function var_0_0._editableInitView(arg_50_0)
	AssassinStealthGameController.instance:initBaseMap(arg_50_0._gomap)

	arg_50_0._qteApComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_50_0._goapLayout, AssassinStealthGameAPComp)

	gohelper.setActive(arg_50_0._gotargetTip, false)

	arg_50_0._dirGOList = arg_50_0:getUserDataTb_()
	arg_50_0._dirGOList[#arg_50_0._dirGOList + 1] = gohelper.findChild(arg_50_0.viewGO, "root/#go_bell/image_top")
	arg_50_0._dirGOList[#arg_50_0._dirGOList + 1] = gohelper.findChild(arg_50_0.viewGO, "root/#go_bell/image_bottom")
	arg_50_0._dirGOList[#arg_50_0._dirGOList + 1] = gohelper.findChild(arg_50_0.viewGO, "root/#go_bell/image_left")
	arg_50_0._dirGOList[#arg_50_0._dirGOList + 1] = gohelper.findChild(arg_50_0.viewGO, "root/#go_bell/image_right")
	arg_50_0._opItemList = {}

	gohelper.setActive(arg_50_0._goopItem, false)

	local var_50_0 = arg_50_0._goopLayout.transform
	local var_50_1 = var_50_0.childCount

	for iter_50_0 = 1, var_50_1 do
		local var_50_2 = arg_50_0:getUserDataTb_()
		local var_50_3 = var_50_0:GetChild(iter_50_0 - 1)

		var_50_2.go = gohelper.clone(arg_50_0._goopItem, var_50_3.gameObject, "opItem")
		var_50_2.imageicon = gohelper.findChildImage(var_50_2.go, "#image_icon")

		local var_50_4 = gohelper.findChild(var_50_2.go, "#go_apLayout")

		var_50_2.btnclick = gohelper.findChildClickWithAudio(var_50_2.go, "#btn_click", AudioEnum2_9.StealthGame.play_ui_cikeshang_normalclick)
		var_50_2.apComp = MonoHelper.addNoUpdateLuaComOnceToGo(var_50_4, AssassinStealthGameAPComp)

		var_50_2.btnclick:AddClickListener(arg_50_0._onOpItemClick, arg_50_0, iter_50_0)

		arg_50_0._opItemList[iter_50_0] = var_50_2
	end

	local var_50_5 = arg_50_0.viewGO.transform

	arg_50_0._viewWidth = recthelper.getWidth(var_50_5)
	arg_50_0._viewHeight = recthelper.getHeight(var_50_5)
	arg_50_0.mapWidth = arg_50_0._viewWidth / AssassinEnum.StealthConst.MinMapScale
	arg_50_0.mapHeight = arg_50_0._viewHeight / AssassinEnum.StealthConst.MinMapScale
	arg_50_0._transmap = arg_50_0._gomap.transform
	arg_50_0._transdrag = arg_50_0._godrag.transform
	arg_50_0._drag = SLFramework.UGUI.UIDragListener.Get(arg_50_0._godrag)
	arg_50_0._touchEventMgr = TouchEventMgrHepler.getTouchEventMgr(arg_50_0._godrag)

	arg_50_0._touchEventMgr:SetIgnoreUI(true)

	arg_50_0._useitemdrag = SLFramework.UGUI.UIDragListener.Get(arg_50_0._gouseItem)
	arg_50_0._transselectenemy = arg_50_0._goselectenemy.transform
	arg_50_0._transselectenemywheel = arg_50_0._goselectedwheel.transform
	arg_50_0._transuseitemtargetlayer = arg_50_0._gouseitemtargetlayer.transform

	arg_50_0:setLocalScale()
	arg_50_0:setMapPos(0, 0)

	arg_50_0._animatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_50_0.viewGO)
	arg_50_0._bellAnimator = arg_50_0._gobell:GetComponent(typeof(UnityEngine.Animator))
	arg_50_0._topAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_50_0._gotop)
	arg_50_0._useItemAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_50_0._gouseItem)
	arg_50_0._showAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_50_0._goshow)
	arg_50_0._selectEnemyAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_50_0._goselectenemy)
	arg_50_0._exposeAnimatorPlayer = ZProj.ProjAnimatorPlayer.Get(arg_50_0._goexposetips)

	gohelper.setActive(arg_50_0._gotips, true)
end

function var_0_0.mapFocus2Hero(arg_51_0, arg_51_1, arg_51_2, arg_51_3)
	local var_51_0 = AssassinStealthGameModel.instance:getHeroMo(arg_51_1, true)

	if not var_51_0 then
		return
	end

	local var_51_1 = var_51_0:getPos()

	arg_51_0:mapFocus2Grid(var_51_1, arg_51_2, arg_51_3)
end

function var_0_0.mapFocus2Grid(arg_52_0, arg_52_1, arg_52_2, arg_52_3, arg_52_4, arg_52_5)
	local var_52_0 = AssassinStealthGameEntityMgr.instance:getGridItem(arg_52_1, true)
	local var_52_1 = var_52_0 and var_52_0:getGoPosition()

	if var_52_1 then
		if arg_52_3 then
			AssassinHelper.lockScreen(AssassinEnum.BlockKey.TweenMapPos, true)
		end

		local var_52_2 = arg_52_0._transmap:InverseTransformPoint(var_52_1)

		arg_52_0:tweenMapPos(-var_52_2.x, -var_52_2.y, arg_52_2, arg_52_4, arg_52_5)
	end
end

function var_0_0.setLocalScale(arg_53_0)
	arg_53_0.curScale = Mathf.Clamp(arg_53_0.curScale or 1, AssassinEnum.StealthConst.MinMapScale, AssassinEnum.StealthConst.MaxMapScale)

	transformhelper.setLocalScale(arg_53_0._transmap, arg_53_0.curScale, arg_53_0.curScale, 1)
	transformhelper.setLocalScale(arg_53_0._transselectenemywheel, arg_53_0.curScale, arg_53_0.curScale, 1)
	arg_53_0:calculateDragBorder()
	arg_53_0:setMapPos()
end

function var_0_0.calculateDragBorder(arg_54_0)
	local var_54_0 = arg_54_0.mapWidth * arg_54_0.curScale
	local var_54_1 = arg_54_0.mapHeight * arg_54_0.curScale

	arg_54_0.maxOffsetX = (var_54_0 - arg_54_0._viewWidth) / 2
	arg_54_0.maxOffsetY = (var_54_1 - arg_54_0._viewHeight) / 2
end

function var_0_0.checkInGuide(arg_55_0)
	local var_55_0 = GuideModel.instance:isDoingClickGuide()
	local var_55_1 = GuideController.instance:isForbidGuides()

	if var_55_0 and not var_55_1 then
		return true
	end

	if GuideController.instance:isGuiding() then
		return true
	end
end

function var_0_0.setMapPos(arg_56_0, arg_56_1, arg_56_2)
	if not arg_56_1 or not arg_56_2 then
		arg_56_1, arg_56_2 = transformhelper.getLocalPos(arg_56_0._transmap)
	end

	arg_56_1 = Mathf.Clamp(arg_56_1, -arg_56_0.maxOffsetX, arg_56_0.maxOffsetX)
	arg_56_2 = Mathf.Clamp(arg_56_2, -arg_56_0.maxOffsetY, arg_56_0.maxOffsetY)

	transformhelper.setLocalPosXY(arg_56_0._transmap, arg_56_1, arg_56_2)
	AssassinStealthGameEntityMgr.instance:refreshSkillPropTargetPos()
end

function var_0_0.tweenMapPos(arg_57_0, arg_57_1, arg_57_2, arg_57_3, arg_57_4, arg_57_5)
	if not arg_57_1 or not arg_57_2 then
		AssassinHelper.lockScreen(AssassinEnum.BlockKey.TweenMapPos, false)

		return
	end

	arg_57_0:killTween()

	arg_57_0._tweenMapPosFinishCb = arg_57_4
	arg_57_0._tweenMapPosFinishCbObj = arg_57_5
	arg_57_0._tweenStartPosX, arg_57_0._tweenStartPosY = transformhelper.getLocalPos(arg_57_0._transmap)
	arg_57_0._tweenStartScale = arg_57_0.curScale

	local var_57_0 = true

	if arg_57_3 then
		arg_57_0._tweenTargetPosX = arg_57_1
		arg_57_0._tweenTargetPosY = arg_57_2
		arg_57_0._tweenTargetScale = arg_57_3
		var_57_0 = arg_57_0._tweenTargetScale == arg_57_0.curScale
	else
		arg_57_0._tweenTargetPosX = Mathf.Clamp(arg_57_1, -arg_57_0.maxOffsetX, arg_57_0.maxOffsetX)
		arg_57_0._tweenTargetPosY = Mathf.Clamp(arg_57_2, -arg_57_0.maxOffsetY, arg_57_0.maxOffsetY)
	end

	if arg_57_0._tweenStartPosX == arg_57_0._tweenTargetPosX and arg_57_0._tweenStartPosY == arg_57_0._tweenTargetPosY and var_57_0 then
		arg_57_0:tweenFinishCallback()

		return
	end

	arg_57_0.tweenId = ZProj.TweenHelper.DOTweenFloat(0, 1, AssassinEnum.StealthConst.MapTweenPosTime, arg_57_0.tweenFrameCallback, arg_57_0.tweenFinishCallback, arg_57_0)

	arg_57_0:tweenFrameCallback(0)
end

function var_0_0.tweenFrameCallback(arg_58_0, arg_58_1)
	if arg_58_0._tweenTargetScale then
		arg_58_0.curScale = Mathf.Lerp(arg_58_0._tweenStartScale, arg_58_0._tweenTargetScale, arg_58_1)

		arg_58_0:setLocalScale()
	end

	local var_58_0 = Mathf.Lerp(arg_58_0._tweenStartPosX, arg_58_0._tweenTargetPosX, arg_58_1)
	local var_58_1 = Mathf.Lerp(arg_58_0._tweenStartPosY, arg_58_0._tweenTargetPosY, arg_58_1)

	arg_58_0:setMapPos(var_58_0, var_58_1)
end

function var_0_0.tweenFinishCallback(arg_59_0)
	if arg_59_0._tweenTargetScale then
		arg_59_0.curScale = arg_59_0._tweenTargetScale

		arg_59_0:setLocalScale()
	end

	arg_59_0:setMapPos(arg_59_0._tweenTargetPosX, arg_59_0._tweenTargetPosY)

	if arg_59_0._tweenMapPosFinishCb then
		arg_59_0._tweenMapPosFinishCb(arg_59_0._tweenMapPosFinishCbObj)
	end

	arg_59_0:killTween()
	AssassinHelper.lockScreen(AssassinEnum.BlockKey.TweenMapPos, false)
end

function var_0_0.killTween(arg_60_0)
	if arg_60_0.tweenId then
		ZProj.TweenHelper.KillById(arg_60_0.tweenId)
	end

	arg_60_0.tweenId = nil
	arg_60_0._tweenMapPosFinishCb = nil
	arg_60_0._tweenMapPosFinishCbObj = nil
	arg_60_0._tweenStartPosX = nil
	arg_60_0._tweenStartPosY = nil
	arg_60_0._tweenTargetPosX = nil
	arg_60_0._tweenTargetPosY = nil
	arg_60_0._tweenStartScale = nil
	arg_60_0._tweenTargetScale = nil
end

function var_0_0.onUpdateParam(arg_61_0)
	return
end

function var_0_0.onOpen(arg_62_0)
	local var_62_0 = arg_62_0.viewParam and arg_62_0.viewParam.fightReturn

	arg_62_0:_resetGameView(var_62_0, true)

	local var_62_1 = AssassinStealthGameModel.instance:getMapId()

	AssassinStealthGameController.instance:dispatchEvent(AssassinEvent.TriggerGuideOnEnterStealthGameMap, var_62_1)
end

function var_0_0._resetGameView(arg_63_0, arg_63_1, arg_63_2)
	arg_63_0._needCheckGameRequest = nil
	arg_63_0._needCheckGameRequestAfterCloseLoading = nil

	arg_63_0:killTween()
	gohelper.setActive(arg_63_0._gochangeMissionEff, false)
	gohelper.setActive(arg_63_0._gostartLight, false)
	arg_63_0:initHeroItem()
	arg_63_0:refresh()

	local var_63_0 = AssassinStealthGameModel.instance:getIsNeedRequest()
	local var_63_1 = false

	if arg_63_2 then
		var_63_1 = AssassinStealthGameModel.instance:getGameState() ~= AssassinEnum.GameState.InProgress
	end

	if var_63_0 or arg_63_1 or var_63_1 then
		gohelper.setActive(arg_63_0._gomissionTip, false)
		arg_63_0._animatorPlayer:Play("open2", arg_63_0._afterOpen2Anim, arg_63_0)
	else
		arg_63_0:showTargetTip()
		arg_63_0._animatorPlayer:Play("open1", arg_63_0.showEvent, arg_63_0)
	end

	arg_63_0:_hideUseItemGo()

	local var_63_2
	local var_63_3
	local var_63_4

	if arg_63_1 and arg_63_0.viewParam then
		var_63_2 = arg_63_0.viewParam.mapPosX
		var_63_3 = arg_63_0.viewParam.mapPosY
		var_63_4 = arg_63_0.viewParam.mapScale
	end

	if var_63_4 then
		arg_63_0.curScale = var_63_4

		arg_63_0:setLocalScale()
	end

	if var_63_2 and var_63_3 then
		arg_63_0:setMapPos(var_63_2, var_63_3)
	else
		local var_63_5 = AssassinConfig.instance:getAssassinConst(AssassinEnum.ConstId.RequireAssassinHeroId, true)
		local var_63_6 = AssassinStealthGameModel.instance:getHeroUidByAssassinHeroId(var_63_5)

		arg_63_0:mapFocus2Hero(var_63_6)
	end
end

function var_0_0._afterOpen2Anim(arg_64_0)
	if AssassinStealthGameController.instance:checkGameState() then
		return
	end

	if arg_64_0:_checkMissionProgress() then
		arg_64_0._needCheckGameRequest = true
	elseif ViewMgr.instance:isOpen(ViewName.LoadingView) then
		arg_64_0._needCheckGameRequestAfterCloseLoading = true
	else
		AssassinStealthGameController.instance:checkGameRequest()
	end
end

function var_0_0.initHeroItem(arg_65_0, arg_65_1, arg_65_2)
	arg_65_0._heroHeadItemList = {}

	local var_65_0 = {}
	local var_65_1 = AssassinStealthGameModel.instance:getHeroUidList()
	local var_65_2 = #var_65_1

	for iter_65_0, iter_65_1 in ipairs(var_65_1) do
		var_65_0[iter_65_0] = {
			heroUid = iter_65_1,
			checkSelectedAnim = arg_65_1,
			oldSelectedHeroUid = arg_65_2,
			isLastHeroHead = iter_65_0 == var_65_2
		}
	end

	gohelper.CreateObjList(arg_65_0, arg_65_0._onCreateHeroHeadItem, var_65_0, arg_65_0._goheroLayout, arg_65_0._goheroItem, AssassinStealthGameHeroHeadItem)
end

function var_0_0._onCreateHeroHeadItem(arg_66_0, arg_66_1, arg_66_2, arg_66_3)
	arg_66_1:setData(arg_66_2)

	arg_66_0._heroHeadItemList[arg_66_3] = arg_66_1
end

function var_0_0.showTargetTip(arg_67_0)
	local var_67_0 = AssassinStealthGameModel.instance:getMissionId()

	if var_67_0 <= 0 then
		return
	end

	local var_67_1 = AssassinConfig.instance:getStealthMissionDesc(var_67_0)

	arg_67_0._txtmissionTip.text = var_67_1

	gohelper.setActive(arg_67_0._gomissionTip, false)
	gohelper.setActive(arg_67_0._gomissionTip, true)
	AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_taskin)
end

function var_0_0.showEvent(arg_68_0)
	AssassinController.instance:openAssassinStealthGameEventView()
	AssassinHelper.lockScreen(AssassinEnum.BlockKey.PlayRoundAnim, false)
end

function var_0_0.refresh(arg_69_0)
	arg_69_0:refreshRound()
	arg_69_0:refreshMoveDir()
	arg_69_0:refreshTarget()
	arg_69_0:refreshHeroHeadItem()
	arg_69_0:refreshBell()
	arg_69_0:refreshInteractQTEBtn()
	arg_69_0:refreshEndPlayerRoundBtn()
end

function var_0_0.refreshRound(arg_70_0, arg_70_1)
	local var_70_0 = AssassinStealthGameModel.instance:isPlayerTurn()

	gohelper.setActive(arg_70_0._goplayerturnbg, var_70_0)
	gohelper.setActive(arg_70_0._goenemyturnbg, not var_70_0)

	local var_70_1 = var_70_0 and luaLang("assassin_stealth_game_player_turn") or luaLang("assassin_stealth_game_enemy_turn")

	arg_70_0._txtroundTip.text = var_70_1
	arg_70_0._txtroundTipEff.text = var_70_1

	local var_70_2 = AssassinStealthGameModel.instance:getRound()
	local var_70_3 = AssassinConfig.instance:getAssassinStealthConst(AssassinEnum.StealthConstId.MaxRound)

	arg_70_0._txtround.text = string.format("%s/%s", var_70_2, var_70_3)

	if arg_70_1 then
		if var_70_0 then
			arg_70_0._topAnimatorPlayer:Play("open", arg_70_0.showEvent, arg_70_0)
			AssassinHelper.lockScreen(AssassinEnum.BlockKey.PlayRoundAnim, true)
		else
			arg_70_0._topAnimatorPlayer:Play("open")
		end

		AudioMgr.instance:trigger(AudioEnum2_9.StealthGame.play_ui_cikeshang_foeround)
	end
end

function var_0_0.refreshTarget(arg_71_0)
	local var_71_0 = AssassinStealthGameModel.instance:getMissionId()

	if var_71_0 <= 0 then
		return
	end

	local var_71_1 = AssassinConfig.instance:getStealthMissionDesc(var_71_0)
	local var_71_2, var_71_3 = AssassinStealthGameModel.instance:getMissionProgress()
	local var_71_4 = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("assassin_stealth_game_mission_progress"), var_71_2, var_71_3)

	arg_71_0._txttarget.text = string.format("%s%s", var_71_1, var_71_4)
end

function var_0_0.refreshHeroHeadItem(arg_72_0, arg_72_1, arg_72_2)
	for iter_72_0, iter_72_1 in ipairs(arg_72_0._heroHeadItemList) do
		iter_72_1:refresh(arg_72_1, arg_72_2)
	end
end

function var_0_0.changeHeroSkillProp(arg_73_0)
	for iter_73_0, iter_73_1 in ipairs(arg_73_0._heroHeadItemList) do
		iter_73_1:onSkillPropChange()
	end
end

function var_0_0.refreshBell(arg_74_0)
	local var_74_0 = AssassinStealthGameModel.instance:isAlertBellRing()

	gohelper.setActive(arg_74_0._gogreen, not var_74_0)
	gohelper.setActive(arg_74_0._gored, var_74_0)
	gohelper.setActive(arg_74_0._gobellringmask, var_74_0)
	arg_74_0:_changeBgmState()
end

function var_0_0._changeBgmState(arg_75_0)
	local var_75_0

	if AssassinStealthGameModel.instance:isAlertBellRing() then
		var_75_0 = AudioMgr.instance:getIdFromString("danger")
	else
		var_75_0 = AudioMgr.instance:getIdFromString("explore")
	end

	local var_75_1 = AudioMgr.instance:getIdFromString("dl_music")

	AudioMgr.instance:setState(var_75_1, var_75_0)
end

function var_0_0.refreshInteractQTEBtn(arg_76_0)
	local var_76_0 = AssassinStealthGameHelper.isSelectedHeroCanInteract()

	if var_76_0 then
		local var_76_1 = AssassinStealthGameModel.instance:getSelectedHeroGameMo():getPos()
		local var_76_2 = AssassinStealthGameModel.instance:getGridInteractId(var_76_1)
		local var_76_3 = AssassinConfig.instance:getInteractApCost(var_76_2)

		arg_76_0._qteApComp:setAPCount(var_76_3)
	end

	gohelper.setActive(arg_76_0._btnqte, var_76_0)
end

function var_0_0.refreshEndPlayerRoundBtn(arg_77_0)
	local var_77_0 = AssassinStealthGameModel.instance:isPlayerTurn()

	gohelper.setActive(arg_77_0._btnend, var_77_0)
end

function var_0_0.refreshMoveDir(arg_78_0)
	local var_78_0 = AssassinStealthGameModel.instance:getEnemyMoveDir()

	for iter_78_0, iter_78_1 in ipairs(arg_78_0._dirGOList) do
		gohelper.setActive(iter_78_1, iter_78_0 == var_78_0)
	end
end

function var_0_0.onClose(arg_79_0)
	arg_79_0._simagepic:UnLoadImage()
	arg_79_0:killTween()
	arg_79_0:_cancelFinishMissionTask()

	arg_79_0._needCheckGameRequest = nil
	arg_79_0._needCheckGameRequestAfterCloseLoading = nil

	AssassinHelper.lockScreen(AssassinEnum.BlockKey.TweenMapPos, false)
	AssassinHelper.lockScreen(AssassinEnum.BlockKey.SelectedEnemy, false)
	AssassinHelper.lockScreen(AssassinEnum.BlockKey.FinishMission, false)
	AssassinHelper.lockScreen(AssassinEnum.BlockKey.PlayRoundAnim, false)
end

function var_0_0.onDestroyView(arg_80_0)
	arg_80_0._opItemList = nil
	arg_80_0._heroHeadItemList = nil

	AssassinStealthGameController.instance:onGameViewDestroy()
end

return var_0_0
