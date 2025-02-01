module("modules.logic.dungeon.view.puzzle.DungeonPuzzleOuijaView", package.seeall)

slot0 = class("DungeonPuzzleOuijaView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagebg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_bg")
	slot0._gosplinters = gohelper.findChild(slot0.viewGO, "#go_splinters")
	slot0._simagesplinter1 = gohelper.findChildSingleImage(slot0.viewGO, "#go_splinters/#simage_splinter1")
	slot0._simagesplinter2 = gohelper.findChildSingleImage(slot0.viewGO, "#go_splinters/#simage_splinter2")
	slot0._simagesplinter3 = gohelper.findChildSingleImage(slot0.viewGO, "#go_splinters/#simage_splinter3")
	slot0._goprogressbg = gohelper.findChild(slot0.viewGO, "#go_progressbg")
	slot0._imageprogress = gohelper.findChildImage(slot0.viewGO, "#go_progressbg/#image_progress")
	slot0._goguide = gohelper.findChild(slot0.viewGO, "#go_guide")
	slot0._gotip = gohelper.findChild(slot0.viewGO, "#go_tip")
	slot0._gohoriRotate = gohelper.findChild(slot0.viewGO, "#go_tip/#go_horiRotate")
	slot0._govertiRotate = gohelper.findChild(slot0.viewGO, "#go_tip/#go_vertiRotate")
	slot0._gorotatearea = gohelper.findChild(slot0.viewGO, "#go_rotatearea")
	slot0._gorotateSplinter = gohelper.findChild(slot0.viewGO, "#go_rotatesplinter")
	slot0._simagewholeboat = gohelper.findChildSingleImage(slot0.viewGO, "#simage_wholeboat")
	slot0._gobtns = gohelper.findChild(slot0.viewGO, "#go_btns")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_reset")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
	slot0._rotateSlide:AddDragBeginListener(slot0._onRotateBegin, slot0)
	slot0._rotateSlide:AddDragListener(slot0._onRotate, slot0)
	slot0._rotateSlide:AddDragEndListener(slot0._onRotateEnd, slot0)
	slot0._btnrotatearea:AddClickListener(slot0._onClickRotateArea, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnreset:RemoveClickListener()
	slot0._rotateSlide:RemoveDragBeginListener()
	slot0._rotateSlide:RemoveDragListener()
	slot0._rotateSlide:RemoveDragEndListener()
	slot0._btnrotatearea:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._firstClickView = true
	slot0._firstEnterView = true

	slot0._simagebg:LoadImage(ResUrl.getDungeonPuzzleBg("bg"))
	slot0._simagesplinter1:LoadImage(ResUrl.getDungeonPuzzleBg("suipian_1"))
	slot0._simagesplinter2:LoadImage(ResUrl.getDungeonPuzzleBg("suipian_2"))
	slot0._simagesplinter3:LoadImage(ResUrl.getDungeonPuzzleBg("suipian_3"))
	slot0._simagewholeboat:LoadImage(ResUrl.getDungeonPuzzleBg("img_boat"))

	slot0._anim = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._goGlow = gohelper.findChild(slot0.viewGO, "glow")
	slot0._goGlowPro = gohelper.findChild(slot0.viewGO, "glow/jidutiao")
	slot0._glowCanvas = slot0._goGlow:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._btnrotatearea = gohelper.getClickWithAudio(slot0._gorotatearea)
	slot0._rotateSlide = SLFramework.UGUI.UIDragListener.Get(slot0._gorotatearea)
	slot0._beginTime = 0

	slot0:_getSplinterTrans()
end

function slot0._btnresetOnClick(slot0)
	GameFacade.showMessageBox(MessageBoxIdDefine.DungeonPuzzleResetGame, MsgBoxEnum.BoxType.Yes_No, function ()
		uv0:_resetGame()
	end)
end

function slot0._onClickRotateArea(slot0)
	if slot0._firstClickView then
		slot0._anim.enabled = false

		gohelper.setActive(slot0._goguide, false)
		gohelper.setActive(slot0._btnreset.gameObject, true)
		gohelper.setActive(slot0._gotip, false)
		gohelper.setActive(slot0._goGlow, true)

		slot0._glowCanvas.alpha = 0
		slot0._firstClickView = false
	end
end

function slot0._onRotateBegin(slot0, slot1, slot2)
	slot0:_onClickRotateArea()

	if slot0._beginTime == 0 then
		slot0._beginTime = os.time()
	end
end

function slot0._onRotate(slot0, slot1, slot2)
	slot3 = slot2.delta
	slot0._moveX = Mathf.Clamp(slot3.x, -5, 5)
	slot0._moveY = Mathf.Clamp(slot3.y, -5, 5)
	slot4, slot5, slot6 = transformhelper.getLocalRotation(slot0._gorotateSplinter.transform)
	slot0._gorotateSplinter.transform.rotation = Quaternion.Euler(0, slot5 + slot0._moveX * slot0._rotateSpeed, slot6 + slot0._moveY * slot0._rotateSpeed)

	slot0:_refreshUI()
	slot0:_setSplinterPos()
end

function slot0._onRotateEnd(slot0, slot1, slot2)
end

function slot0._getSplinterPosRate(slot0)
end

function slot0._getSplinterTrans(slot0)
	slot0._splinter1PosX, slot0._splinter1PosY = recthelper.getAnchor(slot0._simagesplinter1.gameObject.transform)
	slot0._splinter2PosX, slot0._splinter2PosY = recthelper.getAnchor(slot0._simagesplinter2.gameObject.transform)
	slot0._splinter3PosX, slot0._splinter3PosY = recthelper.getAnchor(slot0._simagesplinter3.gameObject.transform)
	slot0._splinterRotY = 0
	slot0._splinterRotZ = 0
	slot0._splinter2RotY = 0
	slot0._splinter2RotZ = 0
	slot0._splinter3RotY = 0
	slot0._splinter3RotZ = 0
end

function slot0._setSplinterPos(slot0)
	slot1, slot2, slot3 = transformhelper.getLocalRotation(slot0._gorotateSplinter.transform)

	if slot0._moveX ~= 0 then
		if slot2 >= 0 and slot2 <= 90 then
			slot0._splinter1PosX = Mathf.Lerp(slot0.splinterInfoTab[1].pointTab[1].points[1], slot0.splinterInfoTab[1].pointTab[2].points[1], slot2 / 90)
			slot0._splinter2PosX = Mathf.Lerp(slot0.splinterInfoTab[3].pointTab[1].points[1], slot0.splinterInfoTab[3].pointTab[2].points[1], slot2 / 90)
			slot0._splinter2PosY = Mathf.Lerp(slot0.splinterInfoTab[3].pointTab[1].points[2], slot0.splinterInfoTab[3].pointTab[2].points[2], slot2 / 90)
			slot0._splinter3PosX = Mathf.Lerp(slot0.splinterInfoTab[5].pointTab[1].points[1], slot0.splinterInfoTab[5].pointTab[2].points[1], slot2 / 90)
			slot0._splinter3PosY = Mathf.Lerp(slot0.splinterInfoTab[5].pointTab[1].points[2], slot0.splinterInfoTab[5].pointTab[2].points[2], slot2 / 90)
		elseif slot2 > 90 and slot2 <= 180 then
			slot0._splinter1PosX = Mathf.Lerp(slot0.splinterInfoTab[1].pointTab[2].points[1], slot0.splinterInfoTab[1].pointTab[3].points[1], (slot2 - 90) / 90)
			slot0._splinter2PosX = Mathf.Lerp(slot0.splinterInfoTab[3].pointTab[2].points[1], slot0.splinterInfoTab[3].pointTab[3].points[1], (slot2 - 90) / 90)
			slot0._splinter2PosY = Mathf.Lerp(slot0.splinterInfoTab[3].pointTab[2].points[2], slot0.splinterInfoTab[3].pointTab[3].points[2], (slot2 - 90) / 90)
			slot0._splinter3PosX = Mathf.Lerp(slot0.splinterInfoTab[5].pointTab[2].points[1], slot0.splinterInfoTab[5].pointTab[3].points[1], (slot2 - 90) / 90)
			slot0._splinter3PosY = Mathf.Lerp(slot0.splinterInfoTab[5].pointTab[2].points[2], slot0.splinterInfoTab[5].pointTab[3].points[2], (slot2 - 90) / 90)
		elseif slot2 > 180 and slot2 <= 270 then
			slot0._splinter1PosX = Mathf.Lerp(slot0.splinterInfoTab[1].pointTab[3].points[1], slot0.splinterInfoTab[1].pointTab[4].points[1], (slot2 - 180) / 90)
			slot0._splinter2PosX = Mathf.Lerp(slot0.splinterInfoTab[3].pointTab[3].points[1], slot0.splinterInfoTab[3].pointTab[4].points[1], (slot2 - 180) / 90)
			slot0._splinter2PosY = Mathf.Lerp(slot0.splinterInfoTab[3].pointTab[3].points[2], slot0.splinterInfoTab[3].pointTab[4].points[2], (slot2 - 180) / 90)
			slot0._splinter3PosX = Mathf.Lerp(slot0.splinterInfoTab[5].pointTab[3].points[1], slot0.splinterInfoTab[5].pointTab[4].points[1], (slot2 - 180) / 90)
			slot0._splinter3PosY = Mathf.Lerp(slot0.splinterInfoTab[5].pointTab[3].points[2], slot0.splinterInfoTab[5].pointTab[4].points[2], (slot2 - 180) / 90)
		elseif slot2 > 270 and slot2 <= 360 then
			slot0._splinter1PosX = Mathf.Lerp(slot0.splinterInfoTab[1].pointTab[4].points[1], slot0.splinterInfoTab[1].pointTab[1].points[1], (slot2 - 270) / 90)
			slot0._splinter2PosX = Mathf.Lerp(slot0.splinterInfoTab[3].pointTab[4].points[1], slot0.splinterInfoTab[3].pointTab[1].points[1], (slot2 - 270) / 90)
			slot0._splinter2PosY = Mathf.Lerp(slot0.splinterInfoTab[3].pointTab[4].points[2], slot0.splinterInfoTab[3].pointTab[1].points[2], (slot2 - 270) / 90)
			slot0._splinter3PosX = Mathf.Lerp(slot0.splinterInfoTab[5].pointTab[4].points[1], slot0.splinterInfoTab[5].pointTab[1].points[1], (slot2 - 270) / 90)
			slot0._splinter3PosY = Mathf.Lerp(slot0.splinterInfoTab[5].pointTab[4].points[2], slot0.splinterInfoTab[5].pointTab[1].points[2], (slot2 - 270) / 90)
		end
	end

	if slot0._moveY ~= 0 then
		if slot3 >= 0 and slot3 <= 90 then
			slot0._splinter1PosY = Mathf.Lerp(slot0.splinterInfoTab[2].pointTab[1].points[2], slot0.splinterInfoTab[2].pointTab[2].points[2], slot3 / 90)
			slot0._splinterRotZ = Mathf.Lerp(slot0.splinterInfoTab[9].pointTab[1].points[1], slot0.splinterInfoTab[9].pointTab[2].points[1], slot3 / 90)
			slot0._splinter2RotZ = Mathf.Lerp(slot0.splinterInfoTab[10].pointTab[1].points[1], slot0.splinterInfoTab[10].pointTab[2].points[1], slot3 / 90)
			slot0._splinter3RotZ = Mathf.Lerp(slot0.splinterInfoTab[11].pointTab[1].points[1], slot0.splinterInfoTab[11].pointTab[2].points[1], slot3 / 90)
		elseif slot3 > 90 and slot3 <= 180 then
			slot0._splinter1PosY = Mathf.Lerp(slot0.splinterInfoTab[2].pointTab[2].points[2], slot0.splinterInfoTab[2].pointTab[3].points[2], (slot3 - 90) / 90)
			slot0._splinterRotZ = Mathf.Lerp(slot0.splinterInfoTab[9].pointTab[2].points[1], slot0.splinterInfoTab[9].pointTab[3].points[1], (slot3 - 90) / 90)
			slot0._splinter2RotZ = Mathf.Lerp(slot0.splinterInfoTab[10].pointTab[2].points[1], slot0.splinterInfoTab[10].pointTab[3].points[1], (slot3 - 90) / 90)
			slot0._splinter3RotZ = Mathf.Lerp(slot0.splinterInfoTab[11].pointTab[2].points[1], slot0.splinterInfoTab[11].pointTab[3].points[1], (slot3 - 90) / 90)
		elseif slot3 > 180 and slot3 <= 270 then
			slot0._splinter1PosY = Mathf.Lerp(slot0.splinterInfoTab[2].pointTab[3].points[2], slot0.splinterInfoTab[2].pointTab[4].points[2], (slot3 - 180) / 90)
			slot0._splinterRotZ = Mathf.Lerp(slot0.splinterInfoTab[9].pointTab[3].points[1], slot0.splinterInfoTab[9].pointTab[4].points[1], (slot3 - 180) / 90)
			slot0._splinter2RotZ = Mathf.Lerp(slot0.splinterInfoTab[10].pointTab[3].points[1], slot0.splinterInfoTab[10].pointTab[4].points[1], (slot3 - 180) / 90)
			slot0._splinter3RotZ = Mathf.Lerp(slot0.splinterInfoTab[11].pointTab[3].points[1], slot0.splinterInfoTab[11].pointTab[4].points[1], (slot3 - 180) / 90)
		elseif slot3 > 270 and slot3 <= 360 then
			slot0._splinter1PosY = Mathf.Lerp(slot0.splinterInfoTab[2].pointTab[4].points[2], slot0.splinterInfoTab[2].pointTab[1].points[2], (slot3 - 270) / 90)
			slot0._splinterRotZ = Mathf.Lerp(slot0.splinterInfoTab[9].pointTab[4].points[1], slot0.splinterInfoTab[9].pointTab[1].points[1], (slot3 - 270) / 90)
			slot0._splinter2RotZ = Mathf.Lerp(slot0.splinterInfoTab[10].pointTab[4].points[1], slot0.splinterInfoTab[10].pointTab[1].points[1], (slot3 - 270) / 90)
			slot0._splinter3RotZ = Mathf.Lerp(slot0.splinterInfoTab[11].pointTab[4].points[1], slot0.splinterInfoTab[11].pointTab[1].points[1], (slot3 - 270) / 90)
		end
	end

	recthelper.setAnchor(slot0._simagesplinter1.gameObject.transform, slot0._splinter1PosX, slot0._splinter1PosY)
	recthelper.setAnchor(slot0._simagesplinter2.gameObject.transform, slot0._splinter2PosX, slot0._splinter2PosY)
	recthelper.setAnchor(slot0._simagesplinter3.gameObject.transform, slot0._splinter3PosX, slot0._splinter3PosY)

	slot0._simagesplinter1.gameObject.transform.rotation = Quaternion.Euler(0, slot0._splinterRotY, slot0._splinterRotZ)
	slot0._simagesplinter2.gameObject.transform.rotation = Quaternion.Euler(0, slot0._splinter2RotY, slot0._splinter2RotZ)
	slot0._simagesplinter3.gameObject.transform.rotation = Quaternion.Euler(0, slot0._splinter3RotY, slot0._splinter3RotZ)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0._proWidth = recthelper.getWidth(slot0._imageprogress.gameObject.transform)
	slot0._glowProWidth = recthelper.getWidth(slot0._goGlowPro.transform)

	slot0:_initData()
end

function slot0._resetGame(slot0)
	slot0:_cleanData()
	slot0:_initData()
end

function slot0._initData(slot0)
	gohelper.setActive(slot0._goguide, false)
	gohelper.setActive(slot0._gorotatearea, false)
	gohelper.setActive(slot0._btnreset.gameObject, false)

	slot0._glowCanvas.alpha = 0

	if slot0._firstEnterView then
		slot0._anim:Play(UIAnimationName.Open, 0, 0)
		TaskDispatcher.runDelay(slot0._showGuideTip, slot0, 2.167)

		slot0._firstEnterView = false
	else
		slot0:_showGuideTip()
	end

	slot0:_initConfig()

	slot0._rotateSpeed = slot0.splinterInfoTab[8].pointTab[1].points[1]
	slot0._hFinishRate = 0
	slot0._vFinishRate = 0
	slot0._initRotateY = tonumber(slot0.splinterInfoTab[7].pointTab[1].points[1])
	slot0._initRotateZ = tonumber(slot0.splinterInfoTab[7].pointTab[1].points[2])
	slot0._gorotateSplinter.transform.rotation = Quaternion.Euler(0, slot0._initRotateY, slot0._initRotateZ)

	slot0:_setSplinterPos()
	slot0:_refreshUI()
end

function slot0._showGuideTip(slot0)
	AudioMgr.instance:trigger(AudioEnum.PuzzleOuija.play_ui_checkpoint_boat_tips)
	gohelper.setActive(slot0._goguide, true)
	TaskDispatcher.runDelay(slot0._canOperate, slot0, 1)
end

function slot0._canOperate(slot0)
	gohelper.setActive(slot0._gorotatearea, true)
end

function slot0._initConfig(slot0)
	slot0._elementConfig = lua_chapter_map_element.configDict[slot0.viewParam.id]
	slot0.splinterInfoTab = {}

	for slot5, slot6 in ipairs(string.split(slot0._elementConfig.param, "|")) do
		slot0.splinterInfoTab[slot5] = {
			pointTab = string.split(slot6, "#")
		}

		for slot11, slot12 in ipairs(slot0.splinterInfoTab[slot5].pointTab) do
			slot0.splinterInfoTab[slot5].pointTab[slot11] = {
				points = string.split(slot12, ",")
			}
		end
	end
end

function slot0._refreshUI(slot0)
	slot1 = slot0:_setFinshRate()

	slot0:_setGlowEffect(slot1)
	recthelper.setWidth(slot0._imageprogress.gameObject.transform, slot1 * slot0._proWidth)
	recthelper.setWidth(slot0._goGlowPro.transform, slot1 * slot0._glowProWidth)

	if slot1 == 1 then
		slot0:_setFinishState()
		AudioMgr.instance:trigger(AudioEnum.PuzzleOuija.play_ui_checkpoint_boat_connection)
	end
end

function slot0._setGlowEffect(slot0, slot1)
	if slot1 >= 0.8 and slot1 <= 0.9 then
		slot0._glowCanvas.alpha = Mathf.Lerp(0, 0.5, (slot1 - 0.8) * 10)
	elseif slot1 > 0.9 and slot1 <= 1 then
		slot0._glowCanvas.alpha = Mathf.Lerp(0.5, 1, (slot1 - 0.9) * 10)
	else
		slot0._glowCanvas.alpha = 0
	end
end

function slot0._setFinshRate(slot0)
	slot1, slot2, slot3 = transformhelper.getLocalRotation(slot0._gorotateSplinter.transform)
	slot0._hFinishRate = slot0:_getFinishRate(slot2, 5, slot0._initRotateY)
	slot0._vFinishRate = slot0:_getFinishRate(slot3, 5, slot0._initRotateZ)

	return slot0._hFinishRate / 2 + slot0._vFinishRate / 2
end

function slot0._getFinishRate(slot0, slot1, slot2, slot3)
	if slot1 < 180 and slot1 - slot2 <= 0 then
		return 1
	elseif slot1 > 180 and 360 - slot1 - slot2 <= 0 then
		return 1
	elseif slot3 < slot1 then
		return (slot1 - slot3) / (360 - slot3 - slot2)
	else
		return (slot3 - slot1) / (slot3 - slot2)
	end
end

function slot0._showRotateTipIcon(slot0)
	if os.time() - slot0._beginTime < 60 then
		return
	end

	gohelper.setActive(slot0._gotip, true)

	if Mathf.Abs(slot0._hFinishRate / 2 - 0.5) > 0 then
		gohelper.setActive(slot0._gohoriRotate, true)
		gohelper.setActive(slot0._govertiRotate, false)
	elseif Mathf.Abs(slot0._vFinishRate / 2 - 0.5) > 0 then
		gohelper.setActive(slot0._gohoriRotate, false)
		gohelper.setActive(slot0._govertiRotate, true)
	else
		gohelper.setActive(slot0._gohoriRotate, false)
		gohelper.setActive(slot0._govertiRotate, false)
	end
end

function slot0._setFinishState(slot0)
	gohelper.setActive(slot0._gorotatearea, false)
	gohelper.setActive(slot0._btnreset.gameObject, false)
	SLFramework.UGUI.GuiHelper.SetColor(slot0._imageprogress, "#d9a06f")

	slot0._anim.enabled = true

	slot0._anim:Play("finish", 0, 0)
	GameFacade.showToast(ToastEnum.DungeonPuzzle2)
	DungeonRpc.instance:sendPuzzleFinishRequest(slot0.viewParam.id)
end

function slot0._cleanData(slot0)
	TaskDispatcher.cancelTask(slot0._showGuideTip, slot0)
	TaskDispatcher.cancelTask(slot0._canOperate, slot0)

	slot0._firstClickView = true
	slot0._anim.enabled = true
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._showGuideTip, slot0)
	TaskDispatcher.cancelTask(slot0._canOperate, slot0)
end

function slot0.onCloseFinish(slot0)
	DungeonController.instance:dispatchEvent(DungeonEvent.OnClickElement, slot0.viewParam.id)
end

function slot0.onDestroyView(slot0)
	slot0._simagebg:UnLoadImage()
	slot0._simagesplinter1:UnLoadImage()
	slot0._simagesplinter2:UnLoadImage()
	slot0._simagesplinter3:UnLoadImage()
	slot0._simagewholeboat:UnLoadImage()
end

return slot0
