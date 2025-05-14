module("modules.logic.versionactivity2_2.lopera.view.LoperaLevelView", package.seeall)

local var_0_0 = class("LoperaLevelView", BaseView)
local var_0_1 = "<sprite=0>"
local var_0_2 = {
	SelectDir = 1,
	OptionDesc = 3,
	SelectOption = 2
}
local var_0_3 = LoperaEnum.MapCfgIdx
local var_0_4 = LoperaEnum.DirEnum
local var_0_5 = VersionActivity2_2Enum.ActivityId.Lopera
local var_0_6 = "singlebg/v2a2_lopera_singlebg/"
local var_0_7 = "v2a2_lopera_levelmap1.png"
local var_0_8 = "<color=#403933>%s</color>"
local var_0_9 = "<color=#b25712>%s</color>"
local var_0_10 = 1.5
local var_0_11 = 0.75
local var_0_12 = "LoperaLevelViewMovingBlock"
local var_0_13 = 150

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goDir = gohelper.findChild(arg_1_0.viewGO, "#go_Compass")
	arg_1_0._btnN = gohelper.findChildClick(arg_1_0._goDir, "Compass/ClickArea/clickN")
	arg_1_0._btnW = gohelper.findChildClick(arg_1_0._goDir, "Compass/ClickArea/clickW")
	arg_1_0._btnE = gohelper.findChildClick(arg_1_0._goDir, "Compass/ClickArea/clickE")
	arg_1_0._btnS = gohelper.findChildClick(arg_1_0._goDir, "Compass/ClickArea/clickS")
	arg_1_0._goNPress = gohelper.findChild(arg_1_0._goDir, "Compass/#go_CompassFG1/#go_N")
	arg_1_0._goWPress = gohelper.findChild(arg_1_0._goDir, "Compass/#go_CompassFG1/#go_W")
	arg_1_0._goEPress = gohelper.findChild(arg_1_0._goDir, "Compass/#go_CompassFG1/#go_E")
	arg_1_0._goSPress = gohelper.findChild(arg_1_0._goDir, "Compass/#go_CompassFG1/#go_S")
	arg_1_0._goNNormal = gohelper.findChild(arg_1_0._goDir, "Compass/#go_CompassFG2/#go_N")
	arg_1_0._goWNormal = gohelper.findChild(arg_1_0._goDir, "Compass/#go_CompassFG2/#go_W")
	arg_1_0._goENormal = gohelper.findChild(arg_1_0._goDir, "Compass/#go_CompassFG2/#go_E")
	arg_1_0._goSNormal = gohelper.findChild(arg_1_0._goDir, "Compass/#go_CompassFG2/#go_S")
	arg_1_0._txtPowerCostNum = gohelper.findChildText(arg_1_0._goDir, "image_PowerIcon/#txt_PowerNum")
	arg_1_0._btnAlchemy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Smelt")
	arg_1_0._goSmeltRed = gohelper.findChild(arg_1_0.viewGO, "#btn_Smelt/#go_reddot")
	arg_1_0._goSmeltBtn = gohelper.findChild(arg_1_0.viewGO, "#btn_Smelt")
	arg_1_0._goOption = gohelper.findChild(arg_1_0.viewGO, "#go_Question")
	arg_1_0._goOptionItemRoot = gohelper.findChild(arg_1_0._goOption, "List")
	arg_1_0._goOptionItem = gohelper.findChild(arg_1_0._goOption, "List/#go_Item")
	arg_1_0._bgRoot = gohelper.findChild(arg_1_0.viewGO, "BG")
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "BG/bg")
	arg_1_0._simagebg1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "BG/bg1")
	arg_1_0._bgAnimator = arg_1_0._bgRoot:GetComponent(gohelper.Type_Animator)
	arg_1_0._textLocation = gohelper.findChildText(arg_1_0.viewGO, "TargetList/Title/image_TitleBG/#txt_Title")
	arg_1_0._goLocationEffect = gohelper.findChild(arg_1_0.viewGO, "TargetList/Title/vx_hint1")
	arg_1_0._textStageName = gohelper.findChildText(arg_1_0.viewGO, "TargetList/Title/image_TitleBG/txt_TitleEn")
	arg_1_0._textActionPoint = gohelper.findChildText(arg_1_0.viewGO, "TargetList/mainTarget/#txt_TargetDesc")
	arg_1_0._gpActionPointEffect = gohelper.findChild(arg_1_0.viewGO, "TargetList/mainTarget/vx_hint2")
	arg_1_0._eventDescRoot = gohelper.findChild(arg_1_0.viewGO, "#go_Descr")
	arg_1_0._btnEventDesc = gohelper.findChildButtonWithAudio(arg_1_0._eventDescRoot, "btn_descClose")
	arg_1_0._btnEventDescViewPort = gohelper.findChildButtonWithAudio(arg_1_0._eventDescRoot, "Scroll View/Viewport")
	arg_1_0._textEventDesc = gohelper.findChildText(arg_1_0.viewGO, "#go_Descr/Scroll View/Viewport/#txt_Descr")
	arg_1_0._goDescArrow = gohelper.findChild(arg_1_0.viewGO, "#go_Descr/#go_ArrowTips")
	arg_1_0._goBuff = gohelper.findChild(arg_1_0.viewGO, "#btn_State")
	arg_1_0._btnState = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_State")
	arg_1_0._goBuffItemRoot = gohelper.findChild(arg_1_0.viewGO, "#btn_State/#go_StateBG")
	arg_1_0._goBuffInfoItem = gohelper.findChild(arg_1_0.viewGO, "#btn_State/#go_StateBG/#txt_State")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnN:AddClickListener(arg_2_0._onClickDir, arg_2_0, var_0_4.North)
	arg_2_0._btnN:AddClickDownListener(arg_2_0._onClickDirDown, arg_2_0, var_0_4.North)
	arg_2_0._btnN:AddClickUpListener(arg_2_0._onClickDirUp, arg_2_0, var_0_4.North)
	arg_2_0._btnW:AddClickListener(arg_2_0._onClickDir, arg_2_0, var_0_4.West)
	arg_2_0._btnW:AddClickDownListener(arg_2_0._onClickDirDown, arg_2_0, var_0_4.West)
	arg_2_0._btnW:AddClickUpListener(arg_2_0._onClickDirUp, arg_2_0, var_0_4.West)
	arg_2_0._btnE:AddClickListener(arg_2_0._onClickDir, arg_2_0, var_0_4.East)
	arg_2_0._btnE:AddClickDownListener(arg_2_0._onClickDirDown, arg_2_0, var_0_4.East)
	arg_2_0._btnE:AddClickUpListener(arg_2_0._onClickDirUp, arg_2_0, var_0_4.East)
	arg_2_0._btnS:AddClickListener(arg_2_0._onClickDir, arg_2_0, var_0_4.South)
	arg_2_0._btnS:AddClickDownListener(arg_2_0._onClickDirDown, arg_2_0, var_0_4.South)
	arg_2_0._btnS:AddClickUpListener(arg_2_0._onClickDirUp, arg_2_0, var_0_4.South)
	arg_2_0._btnAlchemy:AddClickListener(arg_2_0._onClickAlchemy, arg_2_0)
	arg_2_0._btnEventDesc:AddClickListener(arg_2_0._onClickOptionResult, arg_2_0)
	arg_2_0._btnEventDescViewPort:AddClickListener(arg_2_0._onClickOptionResult, arg_2_0)
	arg_2_0._btnState:AddClickListener(arg_2_0._onClickBtnState, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnN:RemoveClickListener()
	arg_3_0._btnN:RemoveClickDownListener()
	arg_3_0._btnN:RemoveClickUpListener()
	arg_3_0._btnW:RemoveClickListener()
	arg_3_0._btnW:RemoveClickDownListener()
	arg_3_0._btnW:RemoveClickUpListener()
	arg_3_0._btnE:RemoveClickListener()
	arg_3_0._btnE:RemoveClickDownListener()
	arg_3_0._btnE:RemoveClickUpListener()
	arg_3_0._btnS:RemoveClickListener()
	arg_3_0._btnS:RemoveClickDownListener()
	arg_3_0._btnS:RemoveClickUpListener()
	arg_3_0._btnAlchemy:RemoveClickListener()
	arg_3_0._btnEventDesc:RemoveClickListener()
	arg_3_0._btnEventDescViewPort:RemoveClickListener()
	arg_3_0._btnState:RemoveClickListener()
end

function var_0_0._onClickAlchemy(arg_4_0)
	LoperaController.instance:openSmeltView()
end

function var_0_0._onClickDir(arg_5_0, arg_5_1)
	if not arg_5_0._moveAbleDirs[arg_5_1] then
		return
	end

	arg_5_0._dir = arg_5_1

	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Lopera.play_ui_common_click)
	LoperaController.instance:moveToDir(arg_5_1)
end

function var_0_0._onClickDirDown(arg_6_0, arg_6_1)
	if not arg_6_0._moveAbleDirs[arg_6_1] then
		return
	end

	gohelper.setActive(arg_6_0._dirBtnPressStatsGos[arg_6_1], true)
end

function var_0_0._onClickDirUp(arg_7_0, arg_7_1)
	if not arg_7_0._moveAbleDirs[arg_7_1] then
		return
	end

	gohelper.setActive(arg_7_0._dirBtnPressStatsGos[arg_7_1], false)
end

function var_0_0._onClickOptionResult(arg_8_0)
	if arg_8_0._curState == var_0_2.OptionDesc then
		if arg_8_0._isShowingDescTyping then
			arg_8_0._isShowingDescTyping = false

			if arg_8_0._tweenId then
				ZProj.TweenHelper.KillById(arg_8_0._tweenId, true)

				arg_8_0._tweenId = nil
			end

			if arg_8_0._moveRectTweenId then
				ZProj.TweenHelper.KillById(arg_8_0._moveRectTweenId)

				arg_8_0._moveRectTweenId = nil
			end

			arg_8_0._textEventDesc.text = arg_8_0._descContent

			local var_8_0 = arg_8_0._textEventDesc.preferredHeight

			if var_8_0 > var_0_13 then
				local var_8_1 = arg_8_0._textEventDesc.transform

				recthelper.setHeight(var_8_1, var_8_0 - var_0_13)
			end
		else
			arg_8_0:_changeLevelState(var_0_2.SelectDir)
		end
	end
end

function var_0_0._onClickBtnState(arg_9_0)
	gohelper.setActive(arg_9_0._goBuffItemRoot, not arg_9_0._goBuffItemRoot.activeSelf)
end

function var_0_0.onOpen(arg_10_0)
	local var_10_0 = arg_10_0.viewParam

	arg_10_0:addEventCb(LoperaController.instance, LoperaEvent.ExitGame, arg_10_0.onExitGame, arg_10_0)
	arg_10_0:addEventCb(LoperaController.instance, LoperaEvent.EpisodeMove, arg_10_0._onMoveInEpisode, arg_10_0)
	arg_10_0:addEventCb(LoperaController.instance, LoperaEvent.SelectOption, arg_10_0._onSelectedOption, arg_10_0)
	arg_10_0:addEventCb(LoperaController.instance, LoperaEvent.EpisodeFinish, arg_10_0._onGetToDestination, arg_10_0)
	arg_10_0:addEventCb(LoperaController.instance, LoperaEvent.ComposeDone, arg_10_0._onSmeltResult, arg_10_0)

	arg_10_0._redDotComp = RedDotController.instance:addNotEventRedDot(arg_10_0._goSmeltRed, arg_10_0._hasSmeltRed, arg_10_0)

	local var_10_1 = Activity168Model.instance:getCurGameState()

	arg_10_0._curEventId = var_10_1.eventId
	arg_10_0._curActionPoint = Activity168Model.instance:getCurActionPoint()
	arg_10_0._moveAbleDirs = {}
	arg_10_0._endLessId = var_10_1.endlessId
	arg_10_0._isEndLess = arg_10_0._endLessId > 0
	arg_10_0._curEpisode = Activity168Model.instance:getCurEpisodeId()

	local var_10_2 = Activity168Config.instance:getEpisodeCfg(var_0_5, arg_10_0._curEpisode)

	arg_10_0:_initBgView()

	arg_10_0._dirBtnNormalStateGos = arg_10_0:getUserDataTb_()
	arg_10_0._dirBtnNormalStateGos[var_0_4.North] = arg_10_0._goNNormal
	arg_10_0._dirBtnNormalStateGos[var_0_4.South] = arg_10_0._goSNormal
	arg_10_0._dirBtnNormalStateGos[var_0_4.West] = arg_10_0._goWNormal
	arg_10_0._dirBtnNormalStateGos[var_0_4.East] = arg_10_0._goENormal
	arg_10_0._dirBtnPressStatsGos = arg_10_0:getUserDataTb_()
	arg_10_0._dirBtnPressStatsGos[var_0_4.North] = arg_10_0._goNPress
	arg_10_0._dirBtnPressStatsGos[var_0_4.South] = arg_10_0._goSPress
	arg_10_0._dirBtnPressStatsGos[var_0_4.West] = arg_10_0._goWPress
	arg_10_0._dirBtnPressStatsGos[var_0_4.East] = arg_10_0._goEPress

	arg_10_0:_resetDirPressState()

	arg_10_0._showTipsRoundNum = Activity168Config.instance:getConstCfg(var_0_5, 6).value1

	if arg_10_0._curEventId ~= 0 then
		arg_10_0._curState = var_10_1.option <= 0 and var_0_2.SelectOption or var_0_2.SelectDir
	else
		arg_10_0._curState = var_0_2.SelectDir
	end

	local var_10_3 = var_10_1.round == 1

	if arg_10_0._isEndLess then
		-- block empty
	else
		local var_10_4 = var_10_2.mapId

		arg_10_0._curMapCfg = Activity168Config.instance:getMapCfg(var_10_4)
		arg_10_0._curCellIdx = (var_10_3 and Activity168Config.instance:getMapStartCell() or Activity168Config.instance:getMapCellByCoord({
			var_10_1.x,
			var_10_1.y
		}))[var_0_3.id] + 1
	end

	if var_10_3 then
		GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.Version2_2LoperaPlayStory, "")
	end

	arg_10_0:_initLeftInfoView()
	arg_10_0:updatePowerInfoView()
	arg_10_0:updateLocationInfoView()
	arg_10_0:_changeLevelState(arg_10_0._curState)
end

function var_0_0.onExitGame(arg_11_0)
	arg_11_0:closeThis()
end

function var_0_0.updateStateView(arg_12_0)
	if arg_12_0._redDotComp then
		arg_12_0._redDotComp:refreshRedDot()
	end

	if Activity168Model.instance:getCurActionPoint() ~= arg_12_0._curActionPoint then
		arg_12_0:updatePowerInfoView()
	end

	arg_12_0._curActionPoint = Activity168Model.instance:getCurActionPoint()

	if arg_12_0._curState == var_0_2.SelectDir then
		gohelper.setActive(arg_12_0._goDir, true)
		gohelper.setActive(arg_12_0._goOption, false)
		gohelper.setActive(arg_12_0._eventDescRoot, false)
		arg_12_0:updateLeftInfoView()
		arg_12_0:_resetDirPressState()
		arg_12_0:updateDirView()

		local var_12_0 = Activity168Config.instance:getConstCfg(var_0_5, LoperaEnum.OriStepCostId).value1

		if Activity168Model.instance:getCurMoveCost(var_12_0) <= arg_12_0._curActionPoint then
			arg_12_0:refreshDestinationTips()
		end
	elseif arg_12_0._curState == var_0_2.SelectOption then
		arg_12_0:_refreshOptionStateView()
	elseif arg_12_0._curState == var_0_2.OptionDesc then
		gohelper.setActive(arg_12_0._goOption, false)
		arg_12_0:updateOptionReusltDescView()
		arg_12_0:updateLeftInfoView()
	end
end

function var_0_0._refreshOptionStateView(arg_13_0)
	gohelper.setActive(arg_13_0._goDir, false)
	gohelper.setActive(arg_13_0._eventDescRoot, true)
	arg_13_0:updateLeftInfoView()
	arg_13_0:updateEventDescView()
	arg_13_0:createEventOptions()
	arg_13_0:_playEventAni()
	TaskDispatcher.runDelay(arg_13_0._delayShowOptionList, arg_13_0, var_0_11)
end

function var_0_0._delayShowOptionList(arg_14_0)
	gohelper.setActive(arg_14_0._goOption, true)
end

function var_0_0._initLeftInfoView(arg_15_0)
	arg_15_0._curEpisode = Activity168Model.instance:getCurEpisodeId()

	local var_15_0 = Activity168Config.instance:getEpisodeCfg(var_0_5, arg_15_0._curEpisode)

	arg_15_0._textStageName.text = var_15_0.orderId
end

function var_0_0.updateLeftInfoView(arg_16_0)
	arg_16_0:updateBuffInfoView()
end

function var_0_0.updatePowerInfoView(arg_17_0)
	local var_17_0 = Activity168Model.instance:getCurActionPoint()

	var_17_0 = var_17_0 < 0 and 0 or var_17_0

	local var_17_1 = string.format(" <color=#ffd06b>%s</color>", var_17_0)
	local var_17_2 = formatLuaLang("remain", var_17_1)

	arg_17_0._textActionPoint.text = var_17_2

	gohelper.setActive(arg_17_0._gpActionPointEffect, false)
	gohelper.setActive(arg_17_0._gpActionPointEffect, true)
	arg_17_0:_playViewAudio(AudioEnum.VersionActivity2_2Lopera.play_ui_molu_exit_appear)
end

function var_0_0.updateLocationInfoView(arg_18_0)
	if arg_18_0._isEndLess then
		arg_18_0._textLocation.text = luaLang("p_v2a2_lopera_endless_location")
	else
		local var_18_0 = arg_18_0._curMapCfg[arg_18_0._curCellIdx]

		arg_18_0._textLocation.text = var_18_0[var_0_3.name]

		if not string.nilorempty(arg_18_0._textLocation.text) then
			local var_18_1 = Activity168Config.instance:getEpisodeCfg(var_0_5, arg_18_0._curEpisode).mapId
			local var_18_2 = string.format("LoperaLevelView_%s_%s", var_18_1, var_18_0[var_0_3.id])

			arg_18_0._textLocation.text = luaLang(var_18_2)
		end

		gohelper.setActive(arg_18_0._goLocationEffect, false)
		gohelper.setActive(arg_18_0._goLocationEffect, true)
		arg_18_0:_playViewAudio(AudioEnum.VersionActivity2_2Lopera.play_ui_checkpoint_elementappear)
	end
end

function var_0_0.updateBuffInfoView(arg_19_0)
	local var_19_0 = Activity168Model.instance:getCurGameState().buffs
	local var_19_1 = {}

	for iter_19_0, iter_19_1 in ipairs(var_19_0) do
		local var_19_2 = {
			id = iter_19_1.id,
			round = iter_19_1.round,
			ext = iter_19_1.ext
		}

		var_19_1[#var_19_1 + 1] = var_19_2
	end

	gohelper.setActive(arg_19_0._goBuff, #var_19_1 > 0)
	gohelper.CreateObjList(arg_19_0, arg_19_0._createBuffItem, var_19_1, arg_19_0._goBuffItemRoot, arg_19_0._goBuffInfoItem)
end

function var_0_0._createBuffItem(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = gohelper.onceAddComponent(arg_20_1, gohelper.Type_TextMesh)
	local var_20_1 = Activity168Config.instance:getOptionEffectCfg(arg_20_2.id).effectParams
	local var_20_2 = string.splitToNumber(var_20_1, "#")[1]
	local var_20_3 = var_20_2 > 0 and "+" .. var_20_2 or var_20_2
	local var_20_4 = arg_20_2.round
	local var_20_5 = luaLang("lopera_buff_info_desc1")
	local var_20_6 = {
		var_20_3,
		var_20_4
	}

	var_20_0.text = GameUtil.getSubPlaceholderLuaLang(var_20_5, var_20_6)
end

function var_0_0.updateDirView(arg_21_0)
	local var_21_0

	if arg_21_0._isEndLess then
		var_21_0 = Activity168Model.instance:getCurGameState().dirs
	else
		local var_21_1 = arg_21_0._curMapCfg[arg_21_0._curCellIdx][var_0_3.dir]

		var_21_0 = string.splitToNumber(var_21_1, "#")
	end

	for iter_21_0, iter_21_1 in ipairs(arg_21_0._dirBtnNormalStateGos) do
		gohelper.setActive(iter_21_1, false)
	end

	arg_21_0._moveAbleDirs = {}

	for iter_21_2, iter_21_3 in ipairs(var_21_0) do
		arg_21_0._moveAbleDirs[iter_21_3] = true

		gohelper.setActive(arg_21_0._dirBtnNormalStateGos[iter_21_3], true)
	end

	local var_21_2 = Activity168Config.instance:getConstCfg(var_0_5, LoperaEnum.OriStepCostId).value1
	local var_21_3 = Activity168Model.instance:getCurMoveCost(var_21_2)

	arg_21_0._txtPowerCostNum.text = var_21_3 <= 0 and 0 or "-" .. math.abs(var_21_3)
end

function var_0_0._resetDirPressState(arg_22_0)
	for iter_22_0, iter_22_1 in pairs(arg_22_0._dirBtnPressStatsGos) do
		gohelper.setActive(iter_22_1, false)
	end
end

function var_0_0._initBgView(arg_23_0)
	local var_23_0

	gohelper.setActive(arg_23_0._bgRoot, true)

	if arg_23_0._isEndLess then
		local var_23_1 = Activity168Config.instance:getEndlessLevelCfg(var_0_5, arg_23_0._endLessId).scene

		var_23_0 = var_0_6 .. var_23_1 .. ".png"
	else
		var_23_0 = var_0_6 .. var_0_7
	end

	if var_23_0 then
		arg_23_0._simagebg:LoadImage(var_23_0)
		arg_23_0._simagebg1:LoadImage(var_23_0)
	end
end

function var_0_0.updateEventDescView(arg_24_0)
	local var_24_0 = Activity168Config.instance:getEventCfg(VersionActivity2_2Enum.ActivityId.Lopera, arg_24_0._curEventId)
	local var_24_1 = ""

	if var_24_0 then
		var_24_1 = string.format(var_0_8, var_24_0.name)
	end

	arg_24_0:beginShowDescContent(var_24_1)
	gohelper.setActive(arg_24_0._goDescArrow, false)
	gohelper.setActive(arg_24_0._btnEventDesc.gameObject, false)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Lopera.play_ui_mIn_unlock)
end

function var_0_0.beginShowDescContent(arg_25_0, arg_25_1)
	arg_25_0._isShowingDescTyping = true
	arg_25_0._descContent = arg_25_1
	arg_25_0._tweenTime = 0
	arg_25_0._separateChars = arg_25_0:getSeparateChars(arg_25_1)

	local var_25_0 = #arg_25_0._separateChars
	local var_25_1 = var_25_0 * 0.02

	arg_25_0:_destroyTween()

	arg_25_0._tweenId = ZProj.TweenHelper.DOTweenFloat(1, var_25_0, var_25_1, arg_25_0._onTweenFrameCallback, arg_25_0._onTypingTweenFinish, arg_25_0, nil, EaseType.Linear)
end

function var_0_0._onTweenFrameCallback(arg_26_0, arg_26_1)
	if arg_26_0._finsihShowTxt or arg_26_1 - arg_26_0._tweenTime < 1 then
		return
	end

	if arg_26_1 <= #arg_26_0._separateChars then
		local var_26_0 = math.floor(arg_26_1)

		arg_26_0._textEventDesc.text = arg_26_0._separateChars[var_26_0]

		local var_26_1 = arg_26_0._textEventDesc.preferredHeight

		if var_26_1 > var_0_13 and not arg_26_0._moveRectTweenId then
			local var_26_2 = arg_26_0._textEventDesc.transform

			arg_26_0._moveRectTweenId = ZProj.TweenHelper.DOLocalMoveY(var_26_2, var_26_1 - var_0_13, 0.25, nil, nil)

			recthelper.setHeight(var_26_2, var_26_1 - var_0_13)
		end
	else
		arg_26_0._textEventDesc.text = arg_26_0._descContent
	end

	arg_26_0._tweenTime = arg_26_1
end

function var_0_0._onTypingTweenFinish(arg_27_0)
	arg_27_0:_destroyTween()

	arg_27_0._isShowingDescTyping = false
	arg_27_0._textEventDesc.text = arg_27_0._descContent
end

function var_0_0.updateOptionReusltDescView(arg_28_0)
	local var_28_0 = Activity168Config.instance:getEventOptionCfg(VersionActivity2_2Enum.ActivityId.Lopera, arg_28_0._curOptionId)

	if not var_28_0 then
		return
	end

	local var_28_1 = ""
	local var_28_2 = string.format(var_0_8, var_28_0.desc)
	local var_28_3 = Activity168Config.instance:getOptionEffectCfg(var_28_0.effectId)

	if var_28_3 then
		var_28_2 = var_28_2 .. "\n" .. luaLang("lopera_event_effect_title")

		if var_28_3.effectType == LoperaEnum.EffectType.ActionPointChange then
			var_28_2 = var_28_2 .. var_0_1 .. var_28_3.effectParams
		else
			local var_28_4 = string.splitToNumber(var_28_3.effectParams, "#")
			local var_28_5 = var_28_4[1] > 0 and "+" .. var_28_4[1] or var_28_4[1]
			local var_28_6 = var_28_4[2]
			local var_28_7 = luaLang("lopera_event_effect_buff_info")
			local var_28_8 = {
				var_0_1,
				var_28_5,
				var_28_6
			}
			local var_28_9 = GameUtil.getSubPlaceholderLuaLang(var_28_7, var_28_8)

			var_28_2 = var_28_2 .. var_28_9
		end
	end

	local var_28_10 = Activity168Model.instance:getItemChangeDict()

	if var_28_10 then
		local var_28_11 = ""

		for iter_28_0, iter_28_1 in pairs(var_28_10) do
			local var_28_12 = Activity168Config.instance:getGameItemCfg(var_0_5, iter_28_0)

			if iter_28_1 > 0 then
				var_28_11 = var_28_11 .. (var_28_11 == "" and "" or luaLang("sep_overseas")) .. var_28_12.name .. luaLang("multiple") .. iter_28_1
			end
		end

		local var_28_13 = string.format(var_0_9, var_28_11)

		var_28_2 = var_28_2 .. "\n" .. luaLang("p_seasonsettlementview_rewards") .. var_28_13
	end

	arg_28_0:beginShowDescContent(var_28_2)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Lopera.play_ui_mIn_unlock)
	gohelper.setActive(arg_28_0._goDescArrow, false)
	gohelper.setActive(arg_28_0._goDescArrow, true)
	gohelper.setActive(arg_28_0._btnEventDesc.gameObject, true)
end

function var_0_0.createEventOptions(arg_29_0)
	local var_29_0 = {
		0
	}
	local var_29_1 = Activity168Config.instance:getEventCfg(VersionActivity2_2Enum.ActivityId.Lopera, arg_29_0._curEventId)
	local var_29_2 = string.splitToNumber(var_29_1.optionIds, "#")

	for iter_29_0, iter_29_1 in ipairs(var_29_2) do
		local var_29_3 = Activity168Config.instance:getEventOptionCfg(VersionActivity2_2Enum.ActivityId.Lopera, iter_29_1)

		var_29_0[#var_29_0 + 1] = var_29_3
	end

	gohelper.CreateObjList(arg_29_0, arg_29_0._createOption, var_29_0, arg_29_0._goOptionItemRoot, arg_29_0._goOptionItem, LoperaLevelOptionItem, 2)
end

function var_0_0._createOption(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	arg_30_1:onUpdateMO(arg_30_2)

	arg_30_1._view = arg_30_0
end

function var_0_0._changeLevelState(arg_31_0, arg_31_1)
	arg_31_0._curState = arg_31_1

	if arg_31_0._waitPopResult then
		arg_31_0:_onGetToDestination(arg_31_0._resultParams)

		arg_31_0._waitPopResult = nil
	end

	arg_31_0:updateStateView()
end

function var_0_0.refreshDestinationTips(arg_32_0)
	local var_32_0 = {}
	local var_32_1 = Activity168Model.instance:getCurGameState().round

	if arg_32_0._isEndLess then
		if var_32_1 ~= 1 then
			return
		end

		var_32_0.isEndLess = arg_32_0._isEndLess

		ViewMgr.instance:openView(ViewName.LoperaLevelTipsView, var_32_0)

		return
	end

	if arg_32_0._curMapCfg[arg_32_0._curCellIdx][var_0_3.destination] then
		return
	end

	var_32_0.mapId = Activity168Config.instance:getEpisodeCfg(var_0_5, arg_32_0._curEpisode).mapId

	if var_32_1 == 1 then
		var_32_0.isBeginning = true

		ViewMgr.instance:openView(ViewName.LoperaLevelTipsView, var_32_0)
	elseif var_32_1 > 0 and var_32_1 % arg_32_0._showTipsRoundNum == 0 and not arg_32_0._isEndLess then
		var_32_0.cellIdx = arg_32_0._curCellIdx

		ViewMgr.instance:openView(ViewName.LoperaLevelTipsView, var_32_0)
	end
end

function var_0_0.refreshFinishTips(arg_33_0)
	local var_33_0 = {
		mapId = Activity168Config.instance:getEpisodeCfg(var_0_5, arg_33_0._curEpisode).mapId
	}

	var_33_0.isFinished = true

	if ViewMgr.instance:isOpen(ViewName.LoperaLevelTipsView) then
		ViewMgr.instance:closeView(ViewName.LoperaLevelTipsView)
	end

	ViewMgr.instance:openView(ViewName.LoperaLevelTipsView, var_33_0)
end

function var_0_0._onGetToDestination(arg_34_0, arg_34_1)
	gohelper.setActive(arg_34_0._goSmeltBtn, false)

	arg_34_0._resultParams = arg_34_1

	if arg_34_0._curState == var_0_2.OptionDesc then
		arg_34_0._waitPopResult = true

		return
	end

	local var_34_0 = arg_34_1.settleReason

	if LoperaEnum.ResultEnum.Quit == var_34_0 then
		return
	elseif LoperaEnum.ResultEnum.PowerUseup == var_34_0 then
		LoperaController.instance:openGameResultView(arg_34_1)

		return
	end

	if arg_34_0._playingMoving then
		TaskDispatcher.runDelay(arg_34_0._doFinishAction, arg_34_0, var_0_10)
	else
		arg_34_0:_doFinishAction()
	end
end

function var_0_0._doFinishAction(arg_35_0)
	if arg_35_0._isEndLess then
		LoperaController.instance:openGameResultView(arg_35_0._resultParams)
	else
		arg_35_0:_playFinishStory()
	end
end

function var_0_0._playFinishStory(arg_36_0)
	local var_36_0 = Activity168Config.instance:getMapEndCell()[var_0_3.storyId]

	if var_36_0 == 0 then
		arg_36_0:_onFinishStoryEnd()
	else
		StoryController.instance:playStory(var_36_0, nil, arg_36_0._onFinishStoryEnd, arg_36_0)

		arg_36_0._playingCellStory = true
	end
end

function var_0_0._onFinishStoryEnd(arg_37_0)
	arg_37_0._playingCellStory = false

	LoperaController.instance:openGameResultView(arg_37_0._resultParams)
	arg_37_0:refreshFinishTips()
end

function var_0_0._onMoveInEpisode(arg_38_0)
	UIBlockMgr.instance:startBlock(var_0_12)
	arg_38_0:_playMoveAni()
	TaskDispatcher.runDelay(arg_38_0._onMoveEnd, arg_38_0, var_0_10)
end

function var_0_0._playMoveAni(arg_39_0)
	arg_39_0._playingMoving = true

	local var_39_0 = true
	local var_39_1

	if arg_39_0._isEndLess then
		var_39_1 = true
	else
		local var_39_2 = arg_39_0._curMapCfg[arg_39_0._curCellIdx][var_0_3.coord]
		local var_39_3 = arg_39_0:_addDirCoord(var_39_2, arg_39_0._dir)

		var_39_1 = not Activity168Config.instance:getMapCellByCoord(var_39_3)[var_0_3.destination]
	end

	if var_39_1 then
		if arg_39_0._endLessId == 2 then
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Lopera.play_ui_youyu_steps_wood)
		else
			AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2Lopera.play_ui_youyu_steps_jungle)
		end
	end

	arg_39_0._bgAnimator:Play("move", 0, 0)
end

function var_0_0._playEventAni(arg_40_0)
	arg_40_0._bgAnimator:Play("wiggle", 0, 0)
end

function var_0_0._onMoveEnd(arg_41_0)
	UIBlockMgr.instance:endBlock(var_0_12)

	arg_41_0._playingMoving = false
	arg_41_0._curEventId = Activity168Model.instance:getCurGameState().eventId

	if arg_41_0._isEndLess then
		local var_41_0 = arg_41_0._curEventId and arg_41_0._curEventId ~= 0 and var_0_2.SelectOption or var_0_2.SelectDir

		arg_41_0:_changeLevelState(var_41_0)
	else
		local var_41_1 = arg_41_0._curMapCfg[arg_41_0._curCellIdx][var_0_3.coord]
		local var_41_2 = arg_41_0:_addDirCoord(var_41_1, arg_41_0._dir)
		local var_41_3 = Activity168Config.instance:getMapCellByCoord(var_41_2)

		arg_41_0._curCellIdx = var_41_3[var_0_3.id] + 1

		local var_41_4 = var_41_3[var_0_3.storyId]
		local var_41_5 = var_41_3[var_0_3.storyEvent]
		local var_41_6 = Activity168Model.instance:getCurGameState().round
		local var_41_7 = true

		if var_41_4 and var_41_4 ~= 0 and var_41_5 == 0 and not var_41_3[var_0_3.destination] then
			local var_41_8 = GameUtil.playerPrefsGetStringByUserId(PlayerPrefsKey.Version2_2LoperaPlayStory, "")
			local var_41_9 = string.splitToNumber(var_41_8, "#")

			for iter_41_0, iter_41_1 in pairs(var_41_9) do
				if iter_41_1 == var_41_4 then
					var_41_7 = false

					break
				end
			end

			if var_41_3[var_0_3.start] and var_41_6 > 1 then
				var_41_7 = false
			end

			if var_41_7 then
				local var_41_10 = var_41_8 .. "#" .. var_41_4

				GameUtil.playerPrefsSetStringByUserId(PlayerPrefsKey.Version2_2LoperaPlayStory, var_41_10)
				StoryController.instance:playStory(var_41_4, nil, arg_41_0._onPlayCellStoryEnd, arg_41_0)

				arg_41_0._playingCellStory = true
			else
				arg_41_0:_onPlayCellStoryEnd()
			end
		elseif arg_41_0._curEventId and arg_41_0._curEventId ~= 0 then
			arg_41_0:_changeLevelState(var_0_2.SelectOption)
		else
			arg_41_0:_changeLevelState(var_0_2.SelectDir)
		end

		arg_41_0:updateLocationInfoView()
	end
end

function var_0_0._onPlayCellStoryEnd(arg_42_0)
	arg_42_0._playingCellStory = false

	arg_42_0:_changeLevelState(var_0_2.SelectOption)
end

function var_0_0._onSelectedOption(arg_43_0)
	local var_43_0 = Activity168Model.instance:getCurGameState()

	if arg_43_0._isEndLess then
		arg_43_0._curOptionId = var_43_0.option
	else
		arg_43_0._curOptionId = var_43_0.option

		local var_43_1 = arg_43_0._curMapCfg[arg_43_0._curCellIdx]

		if var_43_1 and var_43_1[var_0_3.storyId] and var_43_1[var_0_3.storyId] ~= 0 then
			local var_43_2 = var_43_1[var_0_3.storyId]
			local var_43_3 = var_43_1[var_0_3.storyEvent]

			if arg_43_0._curEventId == var_43_3 then
				StoryController.instance:playStory(var_43_2, nil, nil, arg_43_0)
			end
		end
	end

	arg_43_0:_changeLevelState(var_0_2.OptionDesc)
end

function var_0_0._hasSmeltRed(arg_44_0)
	return LoperaController.instance:checkAnyComposable()
end

function var_0_0._onSmeltResult(arg_45_0)
	if arg_45_0._redDotComp then
		arg_45_0._redDotComp:refreshRedDot()
	end
end

function var_0_0._playViewAudio(arg_46_0, arg_46_1)
	if arg_46_0._playingCellStory then
		return
	end

	local var_46_0 = ViewMgr.instance:getOpenViewNameList()
	local var_46_1 = var_46_0[#var_46_0]

	if var_46_1 ~= ViewName.LoperaLevelView and var_46_1 ~= ViewName.LoperaLevelTipsView then
		return
	end

	AudioMgr.instance:trigger(arg_46_1)
end

function var_0_0._addDirCoord(arg_47_0, arg_47_1, arg_47_2)
	local var_47_0 = {
		arg_47_1[1],
		arg_47_1[2]
	}

	if arg_47_2 == var_0_4.North then
		var_47_0[2] = var_47_0[2] + 1
	end

	if arg_47_2 == var_0_4.South then
		var_47_0[2] = var_47_0[2] - 1
	end

	if arg_47_2 == var_0_4.West then
		var_47_0[1] = var_47_0[1] - 1
	end

	if arg_47_2 == var_0_4.East then
		var_47_0[1] = var_47_0[1] + 1
	end

	return var_47_0
end

function var_0_0.getSeparateChars(arg_48_0, arg_48_1)
	local var_48_0 = {}

	if not string.nilorempty(arg_48_1) then
		local var_48_1 = string.split(arg_48_1, "\n")
		local var_48_2 = ""

		for iter_48_0 = 1, #var_48_1 do
			local var_48_3 = false

			if not string.nilorempty(var_48_1[iter_48_0]) then
				local var_48_4 = LuaUtil.getUCharArr(var_48_1[iter_48_0])

				for iter_48_1 = 1, #var_48_4 do
					if var_48_4[iter_48_1] == "<" then
						var_48_3 = true
					elseif var_48_4[iter_48_1] == ">" then
						var_48_3 = false
					end

					var_48_2 = var_48_2 .. var_48_4[iter_48_1]

					if not var_48_3 then
						table.insert(var_48_0, var_48_2)
					end
				end

				var_48_2 = var_48_2 .. "\n"

				table.insert(var_48_0, var_48_2)
			end
		end
	end

	return var_48_0
end

function var_0_0._destroyTween(arg_49_0)
	if arg_49_0._tweenId then
		ZProj.TweenHelper.KillById(arg_49_0._tweenId)

		arg_49_0._tweenId = nil
	end

	if arg_49_0._moveRectTweenId then
		ZProj.TweenHelper.KillById(arg_49_0._moveRectTweenId)

		arg_49_0._moveRectTweenId = nil
	end
end

function var_0_0.onDestroyView(arg_50_0)
	arg_50_0._simagebg:UnLoadImage()
	arg_50_0._simagebg1:UnLoadImage()
	TaskDispatcher.cancelTask(arg_50_0._doFinishAction, arg_50_0)
	TaskDispatcher.cancelTask(arg_50_0._onMoveEnd, arg_50_0)
	TaskDispatcher.cancelTask(arg_50_0._delayShowOptionList, arg_50_0)
	arg_50_0:_destroyTween()
end

return var_0_0
