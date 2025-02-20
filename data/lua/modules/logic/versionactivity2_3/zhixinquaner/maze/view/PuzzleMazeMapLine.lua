module("modules.logic.versionactivity2_3.zhixinquaner.maze.view.PuzzleMazeMapLine", package.seeall)

slot0 = class("PuzzleMazeMapLine", PuzzleMazeBaseLine)
slot0.SwitchOffIconUrl = "duandian_1"

function slot0.ctor(slot0, slot1, slot2, slot3)
	uv0.super.ctor(slot0, slot1)

	slot0._fillOrigin_left = slot2
	slot0._fillOrigin_right = slot3
	slot0._width, slot0._height = PuzzleMazeDrawModel.instance:getUIGridSize()
	slot0._gomap = gohelper.findChild(slot0.go, "#go_map")
	slot0._gopath = gohelper.findChild(slot0.go, "#go_path")
	slot0._goswitch = gohelper.findChild(slot0.go, "#go_map/#go_switch")
	slot0._imageindex = gohelper.findChildImage(slot0.go, "#go_map/#go_switch/#image_index")
	slot0._imagecontent = gohelper.findChildImage(slot0.go, "#go_map/#go_switch/#image_content")
	slot0._switchAnim = gohelper.findChildComponent(slot0.go, "#go_map/#go_switch", gohelper.Type_Animator)

	gohelper.setActive(slot0._gomap, true)
	gohelper.setActive(slot0._gopath, false)
end

function slot0.onInit(slot0, slot1, slot2, slot3, slot4)
	uv0.super.onInit(slot0, slot1, slot2, slot3, slot4)
	slot0:addEventCb(PuzzleMazeDrawController.instance, PuzzleEvent.SwitchLineState, slot0.onSwitchLine, slot0)

	slot5, slot6 = PuzzleMazeDrawModel.instance:getLineAnchor(slot1, slot2, slot3, slot4)

	recthelper.setAnchor(slot0.go.transform, slot5, slot6)
	slot0:_setIcon()
end

function slot0._setIcon(slot0)
	slot3 = slot1 == PuzzleEnum.LineState.Switch_On

	if PuzzleMazeDrawModel.instance:getMapLineState(slot0.x1, slot0.y1, slot0.x2, slot0.y2) == PuzzleEnum.LineState.Switch_Off then
		slot5 = PuzzleMazeDrawModel.instance:getInteractLineCtrl(slot0.x1, slot0.y1, slot0.x2, slot0.y2) and slot4.group

		if slot5 and PuzzleEnum.InteractIndexIcon[slot5] then
			UISpriteSetMgr.instance:setV2a3ZhiXinQuanErSprite(slot0._imageindex, slot6)
		end

		UISpriteSetMgr.instance:setV2a3ZhiXinQuanErSprite(slot0._imagecontent, uv0.SwitchOffIconUrl)
	end

	if slot2 or slot3 then
		gohelper.setActive(slot0._goswitch, true)
		slot0._switchAnim:Play(slot2 and "none" or "disappear", 0, 0)
	else
		gohelper.setActive(slot0._goswitch, false)
	end
end

function slot0.onSwitchLine(slot0, slot1, slot2, slot3, slot4)
	if slot1 ~= slot0.x1 or slot2 ~= slot0.y1 or slot0.x2 ~= slot3 or slot0.y2 ~= slot4 then
		return
	end

	slot0:_setIcon()
end

return slot0
