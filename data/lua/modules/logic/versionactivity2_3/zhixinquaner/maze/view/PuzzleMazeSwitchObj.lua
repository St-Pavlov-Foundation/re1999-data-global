module("modules.logic.versionactivity2_3.zhixinquaner.maze.view.PuzzleMazeSwitchObj", package.seeall)

slot0 = class("PuzzleMazeSwitchObj", PuzzleMazeBaseObj)

function slot0.ctor(slot0, slot1)
	uv0.super.ctor(slot0, slot1)

	slot0._image = gohelper.findChildImage(slot0.go, "#image_content")
	slot0._imageindex = gohelper.findChildImage(slot0.go, "#image_index")
	slot0._gointeractEffect = gohelper.findChild(slot0.go, "vx_tips")
	slot0._goarriveEffect = gohelper.findChild(slot0.go, "vx_smoke")
	slot0._btnswitch = gohelper.findChildButtonWithAudio(slot0.go, "#btn_switch")

	slot0._btnswitch:AddClickListener(slot0._btnswitchOnClick, slot0)

	slot0._isSwitched = false

	slot0:addEventCb(PuzzleMazeDrawController.instance, PuzzleEvent.OnBeginDragPawn, slot0._onBeginDragPawn, slot0)
	slot0:addEventCb(PuzzleMazeDrawController.instance, PuzzleEvent.OnEndDragPawn, slot0._onEndDragPawn, slot0)
	slot0:addEventCb(PuzzleMazeDrawController.instance, PuzzleEvent.InitGameDone, slot0._initGameDone, slot0)
	slot0:addEventCb(PuzzleMazeDrawController.instance, PuzzleEvent.OnSimulatePlaneDone, slot0._onSimulatePlaneDone, slot0)
end

function slot0.onInit(slot0, slot1)
	uv0.super.onInit(slot0, slot1)

	slot0._isSwitched = false

	gohelper.setActive(slot0._btnswitch.gameObject, false)
	slot0:_setInteractIndex()
end

function slot0.onEnter(slot0)
	uv0.super.onEnter(slot0)
	slot0:_tryRecyclePlane()
end

function slot0._setIcon(slot0, slot1)
	uv0.super._setIcon(slot0, slot0._isSwitched)
	ZProj.UGUIHelper.SetGrayscale(slot0._image.gameObject, not slot0._isSwitched)
	gohelper.setActive(slot0._goarriveEffect, slot0._isSwitched)
end

function slot0._getIcon(slot0)
	return slot0._image
end

function slot0._onBeginDragPawn(slot0)
	gohelper.setActive(slot0._btnswitch.gameObject, false)
end

function slot0._onEndDragPawn(slot0)
	slot0:_checkIfSwitchBtnVisible()
end

function slot0._initGameDone(slot0)
	slot0:_checkIfSwitchBtnVisible()
end

function slot0._setInteractIndex(slot0)
	slot1 = slot0.mo and slot0.mo.group

	if slot1 and PuzzleEnum.InteractIndexIcon[slot1] then
		UISpriteSetMgr.instance:setV2a3ZhiXinQuanErSprite(slot0._imageindex, slot2)
	end
end

function slot0._checkIfSwitchBtnVisible(slot0)
	if PuzzleMazeDrawController.instance:hasAlertObj() then
		return
	end

	slot4 = slot0:_isPawnAround() and PuzzleMazeDrawModel.instance:isCanFlyPlane()

	gohelper.setActive(slot0._btnswitch.gameObject, slot4)
	gohelper.setActive(slot0._gointeractEffect, slot4)
end

function slot0._isPawnAround(slot0)
	if not slot0.mo or not slot0.mo.x or not slot0.mo.y then
		return
	end

	slot1, slot2 = PuzzleMazeDrawController.instance:getLastPos()

	if not slot1 or not slot2 then
		return
	end

	return math.abs(slot0.mo.x - slot1) + math.abs(slot0.mo.y - slot2) == 1
end

function slot0._btnswitchOnClick(slot0)
	slot0._isSwitched = true

	gohelper.setActive(slot0._btnswitch.gameObject, false)
	gohelper.setActive(slot0._gointeractEffect, false)
	PuzzleMazeDrawController.instance:interactSwitchObj(slot0.mo.x, slot0.mo.y)
end

function slot0._tryRecyclePlane(slot0)
	if PuzzleMazeDrawController.instance:hasAlertObj() or not slot0._isSwitched then
		return
	end

	slot2, slot3 = PuzzleMazeDrawModel.instance:getCurPlanePos()

	if slot0.mo and slot0.mo.x == slot2 and slot0.mo.y == slot3 then
		slot0._isSwitched = false

		slot0:_setIcon()
		PuzzleMazeDrawController.instance:recyclePlane()
		AudioMgr.instance:trigger(AudioEnum.UI.Act176_RecyclePlane)
	end
end

function slot0._onSimulatePlaneDone(slot0)
	slot0:_setIcon()
	AudioMgr.instance:trigger(AudioEnum.UI.Act176_SwitchOn)
end

function slot0.destroy(slot0)
	slot0._btnswitch:RemoveClickListener()
	uv0.super.destroy(slot0)
end

return slot0
