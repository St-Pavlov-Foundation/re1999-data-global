module("modules.logic.dungeon.view.puzzle.DungeonPuzzleOuijaView", package.seeall)

local var_0_0 = class("DungeonPuzzleOuijaView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_bg")
	arg_1_0._gosplinters = gohelper.findChild(arg_1_0.viewGO, "#go_splinters")
	arg_1_0._simagesplinter1 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_splinters/#simage_splinter1")
	arg_1_0._simagesplinter2 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_splinters/#simage_splinter2")
	arg_1_0._simagesplinter3 = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_splinters/#simage_splinter3")
	arg_1_0._goprogressbg = gohelper.findChild(arg_1_0.viewGO, "#go_progressbg")
	arg_1_0._imageprogress = gohelper.findChildImage(arg_1_0.viewGO, "#go_progressbg/#image_progress")
	arg_1_0._goguide = gohelper.findChild(arg_1_0.viewGO, "#go_guide")
	arg_1_0._gotip = gohelper.findChild(arg_1_0.viewGO, "#go_tip")
	arg_1_0._gohoriRotate = gohelper.findChild(arg_1_0.viewGO, "#go_tip/#go_horiRotate")
	arg_1_0._govertiRotate = gohelper.findChild(arg_1_0.viewGO, "#go_tip/#go_vertiRotate")
	arg_1_0._gorotatearea = gohelper.findChild(arg_1_0.viewGO, "#go_rotatearea")
	arg_1_0._gorotateSplinter = gohelper.findChild(arg_1_0.viewGO, "#go_rotatesplinter")
	arg_1_0._simagewholeboat = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_wholeboat")
	arg_1_0._gobtns = gohelper.findChild(arg_1_0.viewGO, "#go_btns")
	arg_1_0._btnreset = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_reset")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnreset:AddClickListener(arg_2_0._btnresetOnClick, arg_2_0)
	arg_2_0._rotateSlide:AddDragBeginListener(arg_2_0._onRotateBegin, arg_2_0)
	arg_2_0._rotateSlide:AddDragListener(arg_2_0._onRotate, arg_2_0)
	arg_2_0._rotateSlide:AddDragEndListener(arg_2_0._onRotateEnd, arg_2_0)
	arg_2_0._btnrotatearea:AddClickListener(arg_2_0._onClickRotateArea, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnreset:RemoveClickListener()
	arg_3_0._rotateSlide:RemoveDragBeginListener()
	arg_3_0._rotateSlide:RemoveDragListener()
	arg_3_0._rotateSlide:RemoveDragEndListener()
	arg_3_0._btnrotatearea:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._firstClickView = true
	arg_4_0._firstEnterView = true

	arg_4_0._simagebg:LoadImage(ResUrl.getDungeonPuzzleBg("bg"))
	arg_4_0._simagesplinter1:LoadImage(ResUrl.getDungeonPuzzleBg("suipian_1"))
	arg_4_0._simagesplinter2:LoadImage(ResUrl.getDungeonPuzzleBg("suipian_2"))
	arg_4_0._simagesplinter3:LoadImage(ResUrl.getDungeonPuzzleBg("suipian_3"))
	arg_4_0._simagewholeboat:LoadImage(ResUrl.getDungeonPuzzleBg("img_boat"))

	arg_4_0._anim = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._goGlow = gohelper.findChild(arg_4_0.viewGO, "glow")
	arg_4_0._goGlowPro = gohelper.findChild(arg_4_0.viewGO, "glow/jidutiao")
	arg_4_0._glowCanvas = arg_4_0._goGlow:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_4_0._btnrotatearea = gohelper.getClickWithAudio(arg_4_0._gorotatearea)
	arg_4_0._rotateSlide = SLFramework.UGUI.UIDragListener.Get(arg_4_0._gorotatearea)
	arg_4_0._beginTime = 0

	arg_4_0:_getSplinterTrans()
end

function var_0_0._btnresetOnClick(arg_5_0)
	GameFacade.showMessageBox(MessageBoxIdDefine.DungeonPuzzleResetGame, MsgBoxEnum.BoxType.Yes_No, function()
		arg_5_0:_resetGame()
	end)
end

function var_0_0._onClickRotateArea(arg_7_0)
	if arg_7_0._firstClickView then
		arg_7_0._anim.enabled = false

		gohelper.setActive(arg_7_0._goguide, false)
		gohelper.setActive(arg_7_0._btnreset.gameObject, true)
		gohelper.setActive(arg_7_0._gotip, false)
		gohelper.setActive(arg_7_0._goGlow, true)

		arg_7_0._glowCanvas.alpha = 0
		arg_7_0._firstClickView = false
	end
end

function var_0_0._onRotateBegin(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0:_onClickRotateArea()

	if arg_8_0._beginTime == 0 then
		arg_8_0._beginTime = os.time()
	end
end

function var_0_0._onRotate(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_2.delta

	arg_9_0._moveX = Mathf.Clamp(var_9_0.x, -5, 5)
	arg_9_0._moveY = Mathf.Clamp(var_9_0.y, -5, 5)

	local var_9_1, var_9_2, var_9_3 = transformhelper.getLocalRotation(arg_9_0._gorotateSplinter.transform)
	local var_9_4 = var_9_2 + arg_9_0._moveX * arg_9_0._rotateSpeed
	local var_9_5 = var_9_3 + arg_9_0._moveY * arg_9_0._rotateSpeed
	local var_9_6 = Quaternion.Euler(0, var_9_4, var_9_5)

	arg_9_0._gorotateSplinter.transform.rotation = var_9_6

	arg_9_0:_refreshUI()
	arg_9_0:_setSplinterPos()
end

function var_0_0._onRotateEnd(arg_10_0, arg_10_1, arg_10_2)
	return
end

function var_0_0._getSplinterPosRate(arg_11_0)
	return
end

function var_0_0._getSplinterTrans(arg_12_0)
	arg_12_0._splinter1PosX, arg_12_0._splinter1PosY = recthelper.getAnchor(arg_12_0._simagesplinter1.gameObject.transform)
	arg_12_0._splinter2PosX, arg_12_0._splinter2PosY = recthelper.getAnchor(arg_12_0._simagesplinter2.gameObject.transform)
	arg_12_0._splinter3PosX, arg_12_0._splinter3PosY = recthelper.getAnchor(arg_12_0._simagesplinter3.gameObject.transform)
	arg_12_0._splinterRotY = 0
	arg_12_0._splinterRotZ = 0
	arg_12_0._splinter2RotY = 0
	arg_12_0._splinter2RotZ = 0
	arg_12_0._splinter3RotY = 0
	arg_12_0._splinter3RotZ = 0
end

function var_0_0._setSplinterPos(arg_13_0)
	local var_13_0, var_13_1, var_13_2 = transformhelper.getLocalRotation(arg_13_0._gorotateSplinter.transform)

	if arg_13_0._moveX ~= 0 then
		if var_13_1 >= 0 and var_13_1 <= 90 then
			arg_13_0._splinter1PosX = Mathf.Lerp(arg_13_0.splinterInfoTab[1].pointTab[1].points[1], arg_13_0.splinterInfoTab[1].pointTab[2].points[1], var_13_1 / 90)
			arg_13_0._splinter2PosX = Mathf.Lerp(arg_13_0.splinterInfoTab[3].pointTab[1].points[1], arg_13_0.splinterInfoTab[3].pointTab[2].points[1], var_13_1 / 90)
			arg_13_0._splinter2PosY = Mathf.Lerp(arg_13_0.splinterInfoTab[3].pointTab[1].points[2], arg_13_0.splinterInfoTab[3].pointTab[2].points[2], var_13_1 / 90)
			arg_13_0._splinter3PosX = Mathf.Lerp(arg_13_0.splinterInfoTab[5].pointTab[1].points[1], arg_13_0.splinterInfoTab[5].pointTab[2].points[1], var_13_1 / 90)
			arg_13_0._splinter3PosY = Mathf.Lerp(arg_13_0.splinterInfoTab[5].pointTab[1].points[2], arg_13_0.splinterInfoTab[5].pointTab[2].points[2], var_13_1 / 90)
		elseif var_13_1 > 90 and var_13_1 <= 180 then
			arg_13_0._splinter1PosX = Mathf.Lerp(arg_13_0.splinterInfoTab[1].pointTab[2].points[1], arg_13_0.splinterInfoTab[1].pointTab[3].points[1], (var_13_1 - 90) / 90)
			arg_13_0._splinter2PosX = Mathf.Lerp(arg_13_0.splinterInfoTab[3].pointTab[2].points[1], arg_13_0.splinterInfoTab[3].pointTab[3].points[1], (var_13_1 - 90) / 90)
			arg_13_0._splinter2PosY = Mathf.Lerp(arg_13_0.splinterInfoTab[3].pointTab[2].points[2], arg_13_0.splinterInfoTab[3].pointTab[3].points[2], (var_13_1 - 90) / 90)
			arg_13_0._splinter3PosX = Mathf.Lerp(arg_13_0.splinterInfoTab[5].pointTab[2].points[1], arg_13_0.splinterInfoTab[5].pointTab[3].points[1], (var_13_1 - 90) / 90)
			arg_13_0._splinter3PosY = Mathf.Lerp(arg_13_0.splinterInfoTab[5].pointTab[2].points[2], arg_13_0.splinterInfoTab[5].pointTab[3].points[2], (var_13_1 - 90) / 90)
		elseif var_13_1 > 180 and var_13_1 <= 270 then
			arg_13_0._splinter1PosX = Mathf.Lerp(arg_13_0.splinterInfoTab[1].pointTab[3].points[1], arg_13_0.splinterInfoTab[1].pointTab[4].points[1], (var_13_1 - 180) / 90)
			arg_13_0._splinter2PosX = Mathf.Lerp(arg_13_0.splinterInfoTab[3].pointTab[3].points[1], arg_13_0.splinterInfoTab[3].pointTab[4].points[1], (var_13_1 - 180) / 90)
			arg_13_0._splinter2PosY = Mathf.Lerp(arg_13_0.splinterInfoTab[3].pointTab[3].points[2], arg_13_0.splinterInfoTab[3].pointTab[4].points[2], (var_13_1 - 180) / 90)
			arg_13_0._splinter3PosX = Mathf.Lerp(arg_13_0.splinterInfoTab[5].pointTab[3].points[1], arg_13_0.splinterInfoTab[5].pointTab[4].points[1], (var_13_1 - 180) / 90)
			arg_13_0._splinter3PosY = Mathf.Lerp(arg_13_0.splinterInfoTab[5].pointTab[3].points[2], arg_13_0.splinterInfoTab[5].pointTab[4].points[2], (var_13_1 - 180) / 90)
		elseif var_13_1 > 270 and var_13_1 <= 360 then
			arg_13_0._splinter1PosX = Mathf.Lerp(arg_13_0.splinterInfoTab[1].pointTab[4].points[1], arg_13_0.splinterInfoTab[1].pointTab[1].points[1], (var_13_1 - 270) / 90)
			arg_13_0._splinter2PosX = Mathf.Lerp(arg_13_0.splinterInfoTab[3].pointTab[4].points[1], arg_13_0.splinterInfoTab[3].pointTab[1].points[1], (var_13_1 - 270) / 90)
			arg_13_0._splinter2PosY = Mathf.Lerp(arg_13_0.splinterInfoTab[3].pointTab[4].points[2], arg_13_0.splinterInfoTab[3].pointTab[1].points[2], (var_13_1 - 270) / 90)
			arg_13_0._splinter3PosX = Mathf.Lerp(arg_13_0.splinterInfoTab[5].pointTab[4].points[1], arg_13_0.splinterInfoTab[5].pointTab[1].points[1], (var_13_1 - 270) / 90)
			arg_13_0._splinter3PosY = Mathf.Lerp(arg_13_0.splinterInfoTab[5].pointTab[4].points[2], arg_13_0.splinterInfoTab[5].pointTab[1].points[2], (var_13_1 - 270) / 90)
		end
	end

	if arg_13_0._moveY ~= 0 then
		if var_13_2 >= 0 and var_13_2 <= 90 then
			arg_13_0._splinter1PosY = Mathf.Lerp(arg_13_0.splinterInfoTab[2].pointTab[1].points[2], arg_13_0.splinterInfoTab[2].pointTab[2].points[2], var_13_2 / 90)
			arg_13_0._splinterRotZ = Mathf.Lerp(arg_13_0.splinterInfoTab[9].pointTab[1].points[1], arg_13_0.splinterInfoTab[9].pointTab[2].points[1], var_13_2 / 90)
			arg_13_0._splinter2RotZ = Mathf.Lerp(arg_13_0.splinterInfoTab[10].pointTab[1].points[1], arg_13_0.splinterInfoTab[10].pointTab[2].points[1], var_13_2 / 90)
			arg_13_0._splinter3RotZ = Mathf.Lerp(arg_13_0.splinterInfoTab[11].pointTab[1].points[1], arg_13_0.splinterInfoTab[11].pointTab[2].points[1], var_13_2 / 90)
		elseif var_13_2 > 90 and var_13_2 <= 180 then
			arg_13_0._splinter1PosY = Mathf.Lerp(arg_13_0.splinterInfoTab[2].pointTab[2].points[2], arg_13_0.splinterInfoTab[2].pointTab[3].points[2], (var_13_2 - 90) / 90)
			arg_13_0._splinterRotZ = Mathf.Lerp(arg_13_0.splinterInfoTab[9].pointTab[2].points[1], arg_13_0.splinterInfoTab[9].pointTab[3].points[1], (var_13_2 - 90) / 90)
			arg_13_0._splinter2RotZ = Mathf.Lerp(arg_13_0.splinterInfoTab[10].pointTab[2].points[1], arg_13_0.splinterInfoTab[10].pointTab[3].points[1], (var_13_2 - 90) / 90)
			arg_13_0._splinter3RotZ = Mathf.Lerp(arg_13_0.splinterInfoTab[11].pointTab[2].points[1], arg_13_0.splinterInfoTab[11].pointTab[3].points[1], (var_13_2 - 90) / 90)
		elseif var_13_2 > 180 and var_13_2 <= 270 then
			arg_13_0._splinter1PosY = Mathf.Lerp(arg_13_0.splinterInfoTab[2].pointTab[3].points[2], arg_13_0.splinterInfoTab[2].pointTab[4].points[2], (var_13_2 - 180) / 90)
			arg_13_0._splinterRotZ = Mathf.Lerp(arg_13_0.splinterInfoTab[9].pointTab[3].points[1], arg_13_0.splinterInfoTab[9].pointTab[4].points[1], (var_13_2 - 180) / 90)
			arg_13_0._splinter2RotZ = Mathf.Lerp(arg_13_0.splinterInfoTab[10].pointTab[3].points[1], arg_13_0.splinterInfoTab[10].pointTab[4].points[1], (var_13_2 - 180) / 90)
			arg_13_0._splinter3RotZ = Mathf.Lerp(arg_13_0.splinterInfoTab[11].pointTab[3].points[1], arg_13_0.splinterInfoTab[11].pointTab[4].points[1], (var_13_2 - 180) / 90)
		elseif var_13_2 > 270 and var_13_2 <= 360 then
			arg_13_0._splinter1PosY = Mathf.Lerp(arg_13_0.splinterInfoTab[2].pointTab[4].points[2], arg_13_0.splinterInfoTab[2].pointTab[1].points[2], (var_13_2 - 270) / 90)
			arg_13_0._splinterRotZ = Mathf.Lerp(arg_13_0.splinterInfoTab[9].pointTab[4].points[1], arg_13_0.splinterInfoTab[9].pointTab[1].points[1], (var_13_2 - 270) / 90)
			arg_13_0._splinter2RotZ = Mathf.Lerp(arg_13_0.splinterInfoTab[10].pointTab[4].points[1], arg_13_0.splinterInfoTab[10].pointTab[1].points[1], (var_13_2 - 270) / 90)
			arg_13_0._splinter3RotZ = Mathf.Lerp(arg_13_0.splinterInfoTab[11].pointTab[4].points[1], arg_13_0.splinterInfoTab[11].pointTab[1].points[1], (var_13_2 - 270) / 90)
		end
	end

	recthelper.setAnchor(arg_13_0._simagesplinter1.gameObject.transform, arg_13_0._splinter1PosX, arg_13_0._splinter1PosY)
	recthelper.setAnchor(arg_13_0._simagesplinter2.gameObject.transform, arg_13_0._splinter2PosX, arg_13_0._splinter2PosY)
	recthelper.setAnchor(arg_13_0._simagesplinter3.gameObject.transform, arg_13_0._splinter3PosX, arg_13_0._splinter3PosY)

	arg_13_0._simagesplinter1.gameObject.transform.rotation = Quaternion.Euler(0, arg_13_0._splinterRotY, arg_13_0._splinterRotZ)
	arg_13_0._simagesplinter2.gameObject.transform.rotation = Quaternion.Euler(0, arg_13_0._splinter2RotY, arg_13_0._splinter2RotZ)
	arg_13_0._simagesplinter3.gameObject.transform.rotation = Quaternion.Euler(0, arg_13_0._splinter3RotY, arg_13_0._splinter3RotZ)
end

function var_0_0.onUpdateParam(arg_14_0)
	return
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0._proWidth = recthelper.getWidth(arg_15_0._imageprogress.gameObject.transform)
	arg_15_0._glowProWidth = recthelper.getWidth(arg_15_0._goGlowPro.transform)

	arg_15_0:_initData()
end

function var_0_0._resetGame(arg_16_0)
	arg_16_0:_cleanData()
	arg_16_0:_initData()
end

function var_0_0._initData(arg_17_0)
	gohelper.setActive(arg_17_0._goguide, false)
	gohelper.setActive(arg_17_0._gorotatearea, false)
	gohelper.setActive(arg_17_0._btnreset.gameObject, false)

	arg_17_0._glowCanvas.alpha = 0

	if arg_17_0._firstEnterView then
		arg_17_0._anim:Play(UIAnimationName.Open, 0, 0)
		TaskDispatcher.runDelay(arg_17_0._showGuideTip, arg_17_0, 2.167)

		arg_17_0._firstEnterView = false
	else
		arg_17_0:_showGuideTip()
	end

	arg_17_0:_initConfig()

	arg_17_0._rotateSpeed = arg_17_0.splinterInfoTab[8].pointTab[1].points[1]
	arg_17_0._hFinishRate = 0
	arg_17_0._vFinishRate = 0
	arg_17_0._initRotateY = tonumber(arg_17_0.splinterInfoTab[7].pointTab[1].points[1])
	arg_17_0._initRotateZ = tonumber(arg_17_0.splinterInfoTab[7].pointTab[1].points[2])
	arg_17_0._gorotateSplinter.transform.rotation = Quaternion.Euler(0, arg_17_0._initRotateY, arg_17_0._initRotateZ)

	arg_17_0:_setSplinterPos()
	arg_17_0:_refreshUI()
end

function var_0_0._showGuideTip(arg_18_0)
	AudioMgr.instance:trigger(AudioEnum.PuzzleOuija.play_ui_checkpoint_boat_tips)
	gohelper.setActive(arg_18_0._goguide, true)
	TaskDispatcher.runDelay(arg_18_0._canOperate, arg_18_0, 1)
end

function var_0_0._canOperate(arg_19_0)
	gohelper.setActive(arg_19_0._gorotatearea, true)
end

function var_0_0._initConfig(arg_20_0)
	arg_20_0._elementConfig = lua_chapter_map_element.configDict[arg_20_0.viewParam.id]

	local var_20_0 = string.split(arg_20_0._elementConfig.param, "|")

	arg_20_0.splinterInfoTab = {}

	for iter_20_0, iter_20_1 in ipairs(var_20_0) do
		arg_20_0.splinterInfoTab[iter_20_0] = {}

		local var_20_1 = string.split(iter_20_1, "#")

		arg_20_0.splinterInfoTab[iter_20_0].pointTab = var_20_1

		for iter_20_2, iter_20_3 in ipairs(arg_20_0.splinterInfoTab[iter_20_0].pointTab) do
			local var_20_2 = string.split(iter_20_3, ",")

			arg_20_0.splinterInfoTab[iter_20_0].pointTab[iter_20_2] = {}
			arg_20_0.splinterInfoTab[iter_20_0].pointTab[iter_20_2].points = var_20_2
		end
	end
end

function var_0_0._refreshUI(arg_21_0)
	local var_21_0 = arg_21_0:_setFinshRate()

	arg_21_0:_setGlowEffect(var_21_0)
	recthelper.setWidth(arg_21_0._imageprogress.gameObject.transform, var_21_0 * arg_21_0._proWidth)
	recthelper.setWidth(arg_21_0._goGlowPro.transform, var_21_0 * arg_21_0._glowProWidth)

	if var_21_0 == 1 then
		arg_21_0:_setFinishState()
		AudioMgr.instance:trigger(AudioEnum.PuzzleOuija.play_ui_checkpoint_boat_connection)
	end
end

function var_0_0._setGlowEffect(arg_22_0, arg_22_1)
	if arg_22_1 >= 0.8 and arg_22_1 <= 0.9 then
		arg_22_0._glowCanvas.alpha = Mathf.Lerp(0, 0.5, (arg_22_1 - 0.8) * 10)
	elseif arg_22_1 > 0.9 and arg_22_1 <= 1 then
		arg_22_0._glowCanvas.alpha = Mathf.Lerp(0.5, 1, (arg_22_1 - 0.9) * 10)
	else
		arg_22_0._glowCanvas.alpha = 0
	end
end

function var_0_0._setFinshRate(arg_23_0)
	local var_23_0, var_23_1, var_23_2 = transformhelper.getLocalRotation(arg_23_0._gorotateSplinter.transform)

	arg_23_0._hFinishRate = arg_23_0:_getFinishRate(var_23_1, 5, arg_23_0._initRotateY)
	arg_23_0._vFinishRate = arg_23_0:_getFinishRate(var_23_2, 5, arg_23_0._initRotateZ)

	return arg_23_0._hFinishRate / 2 + arg_23_0._vFinishRate / 2
end

function var_0_0._getFinishRate(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	if arg_24_1 < 180 and arg_24_1 - arg_24_2 <= 0 then
		return 1
	elseif arg_24_1 > 180 and 360 - arg_24_1 - arg_24_2 <= 0 then
		return 1
	elseif arg_24_3 < arg_24_1 then
		return (arg_24_1 - arg_24_3) / (360 - arg_24_3 - arg_24_2)
	else
		return (arg_24_3 - arg_24_1) / (arg_24_3 - arg_24_2)
	end
end

function var_0_0._showRotateTipIcon(arg_25_0)
	if os.time() - arg_25_0._beginTime < 60 then
		return
	end

	gohelper.setActive(arg_25_0._gotip, true)

	if Mathf.Abs(arg_25_0._hFinishRate / 2 - 0.5) > 0 then
		gohelper.setActive(arg_25_0._gohoriRotate, true)
		gohelper.setActive(arg_25_0._govertiRotate, false)
	elseif Mathf.Abs(arg_25_0._vFinishRate / 2 - 0.5) > 0 then
		gohelper.setActive(arg_25_0._gohoriRotate, false)
		gohelper.setActive(arg_25_0._govertiRotate, true)
	else
		gohelper.setActive(arg_25_0._gohoriRotate, false)
		gohelper.setActive(arg_25_0._govertiRotate, false)
	end
end

function var_0_0._setFinishState(arg_26_0)
	gohelper.setActive(arg_26_0._gorotatearea, false)
	gohelper.setActive(arg_26_0._btnreset.gameObject, false)
	SLFramework.UGUI.GuiHelper.SetColor(arg_26_0._imageprogress, "#d9a06f")

	arg_26_0._anim.enabled = true

	arg_26_0._anim:Play("finish", 0, 0)
	GameFacade.showToast(ToastEnum.DungeonPuzzle2)
	DungeonRpc.instance:sendPuzzleFinishRequest(arg_26_0.viewParam.id)
end

function var_0_0._cleanData(arg_27_0)
	TaskDispatcher.cancelTask(arg_27_0._showGuideTip, arg_27_0)
	TaskDispatcher.cancelTask(arg_27_0._canOperate, arg_27_0)

	arg_27_0._firstClickView = true
	arg_27_0._anim.enabled = true
end

function var_0_0.onClose(arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0._showGuideTip, arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0._canOperate, arg_28_0)
end

function var_0_0.onCloseFinish(arg_29_0)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnClickElement, arg_29_0.viewParam.id)
end

function var_0_0.onDestroyView(arg_30_0)
	arg_30_0._simagebg:UnLoadImage()
	arg_30_0._simagesplinter1:UnLoadImage()
	arg_30_0._simagesplinter2:UnLoadImage()
	arg_30_0._simagesplinter3:UnLoadImage()
	arg_30_0._simagewholeboat:UnLoadImage()
end

return var_0_0
