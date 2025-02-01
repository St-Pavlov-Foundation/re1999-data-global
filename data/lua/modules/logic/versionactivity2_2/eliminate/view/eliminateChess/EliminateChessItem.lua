module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateChessItem", package.seeall)

slot0 = class("EliminateChessItem", LuaCompBase)
slot1 = ZProj.TweenHelper
slot2 = SLFramework.UGUI.UIDragListener

function slot0.init(slot0, slot1)
	slot0._go = slot1
	slot0._tr = slot1.transform
	slot0._select = false
	slot0._ani = slot1:GetComponent(typeof(UnityEngine.Animator))

	if slot0._ani then
		slot0._ani.enabled = true
	end

	slot0._img_select = gohelper.findChild(slot0._go, "#img_select")
	slot0._img_chess = gohelper.findChildImage(slot0._go, "#img_sprite")
	slot0._btnClick = gohelper.findChildButtonWithAudio(slot0._go, "#btn_click")

	slot0._btnClick:AddClickListener(slot0.onClick, slot0)

	slot0._drag = UIDragListenerHelper.New()
	slot0._drag = uv0.Get(slot0._btnClick.gameObject)

	slot0._drag:AddDragBeginListener(slot0._onDragBegin, slot0)
	slot0._drag:AddDragEndListener(slot0._onDragEnd, slot0)
end

function slot0.initData(slot0, slot1)
	slot0._data = slot1

	slot0:updateInfo()
end

function slot0.getData(slot0)
	return slot0._data
end

function slot0.updateInfo(slot0)
	if slot0._data then
		recthelper.setSize(slot0._tr, EliminateEnum.ChessWidth, EliminateEnum.ChessHeight)

		if not string.nilorempty(EliminateConfig.instance:getChessIconPath(slot0._data.id)) then
			UISpriteSetMgr.instance:setV2a2EliminateSprite(slot0._img_chess, slot1, false)
		end

		gohelper.setActiveCanvasGroup(slot0._go, slot2)
		slot0:updatePos()
	end
end

function slot0.updatePos(slot0)
	if slot0._data then
		transformhelper.setLocalPosXY(slot0._tr, (slot0._data.startX - 1) * EliminateEnum.ChessWidth, (slot0._data.startY - 1) * EliminateEnum.ChessHeight)
	end
end

function slot0.onClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_activity_switch)
	EliminateChessController.instance:dispatchEvent(EliminateChessEvent.OnChessSelect, slot0._data.x, slot0._data.y, true)
end

function slot0._onDragBegin(slot0, slot1, slot2)
	slot0._beginDragX = slot2.position.x
	slot0._beginDragY = slot2.position.y

	EliminateChessController.instance:dispatchEvent(EliminateChessEvent.OnChessSelect, slot0._data.x, slot0._data.y, false)
end

function slot3(slot0, slot1, slot2, slot3)
	return math.deg(math.atan2(slot3 - slot1, slot2 - slot0))
end

function slot0.getEndXYByAngle(slot0, slot1, slot2)
	if math.abs(slot1) <= slot2 then
		return slot0._data.x + 1, slot0._data.y
	elseif math.abs(slot1 - 180) <= slot2 or math.abs(slot1 + 180) <= slot2 then
		return slot3 - 1, slot4
	elseif math.abs(slot1 - 90) <= 90 - slot2 then
		return slot3, slot4 + 1
	elseif math.abs(slot1 + 90) <= 90 - slot2 then
		return slot3, slot4 - 1
	end

	return slot3, slot4
end

function slot0._onDragEnd(slot0, slot1, slot2)
	slot6, slot7 = slot0:getEndXYByAngle(uv0(slot0._beginDragX, slot0._beginDragY, slot2.position.x, slot2.position.y), EliminateEnum.ChessDropAngleThreshold)

	if EliminateChessModel.instance:posIsValid(slot6, slot7) then
		EliminateChessController.instance:dispatchEvent(EliminateChessEvent.OnChessSelect, slot6, slot7, false)
	end
end

function slot0.setSelect(slot0, slot1)
	slot0._select = slot1

	gohelper.setActiveCanvasGroup(slot0._img_select, slot0._select)
end

function slot0.toTip(slot0, slot1)
	if not slot1 then
		slot0:playAnimation("idle")
	else
		slot0:playAnimation("hint")
	end
end

function slot0.getGoPos(slot0)
	slot0._chessPosX, slot0._chessPosY = transformhelper.getPos(slot0._img_chess.transform)

	return slot0._chessPosX, slot0._chessPosY
end

function slot0.toDie(slot0, slot1, slot2)
	if slot2 == 1 then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_2EliminateChess.play_ui_youyu_sufubi_skill)
		slot0:playAnimation("skill_sufubi")
	else
		slot0:playAnimation("disappear")
	end

	slot0:getGoPos()
	TaskDispatcher.runDelay(slot0.onDestroy, slot0, slot1)
end

function slot0.toFlyResource(slot0, slot1)
	EliminateChessController.instance:dispatchEvent(EliminateChessEvent.ChessResourceFlyEffect, slot1, slot0._chessPosX, slot0._chessPosY)
end

function slot0.toMove(slot0, slot1, slot2, slot3, slot4)
	uv0.DOLocalMove(slot0._tr, (slot0._data.x - 1) * EliminateEnum.ChessWidth, (slot0._data.y - 1) * EliminateEnum.ChessHeight, 0, slot1, slot0._onMoveEnd, slot0, {
		cb = slot3,
		cbTarget = slot4,
		animType = slot2
	}, EaseType.OutQuart)
end

function slot0._onMoveEnd(slot0, slot1)
	if slot1.animType and slot2 == EliminateEnum.AnimType.init then
		slot0:playAnimation("in")
	end

	if slot2 and slot2 == EliminateEnum.AnimType.drop then
		slot0:playAnimation("add")
	end

	if slot1.cb then
		slot1.cb(slot1.cbTarget)
	end
end

function slot0.playAnimation(slot0, slot1)
	if slot0._ani then
		slot0._ani:Play(slot1, 0, 0)
	end
end

function slot0.clear(slot0)
	if slot0._go then
		EliminateChessItemController.instance:putChessItemGo(slot0._go)
	end

	slot0._img_select = nil
	slot0._img_chess = nil
	slot0._goClick = nil
	slot0._data = nil
	slot0._select = false
	slot0._drag = nil
end

function slot0.onDestroy(slot0, slot1)
	TaskDispatcher.cancelTask(slot0.onDestroy, slot0)

	if slot0._btnClick then
		slot0._btnClick:RemoveClickListener()
	end

	if slot0._drag then
		slot0._drag:RemoveDragEndListener()
		slot0._drag:RemoveDragBeginListener()

		slot0._drag = nil
	end

	if slot0._ani then
		slot0._ani = nil
	end

	slot0:clear()

	if slot1 and slot1.cb then
		slot1.cb(slot1.cbTarget)
	end

	uv0.super.onDestroy(slot0)
end

return slot0
