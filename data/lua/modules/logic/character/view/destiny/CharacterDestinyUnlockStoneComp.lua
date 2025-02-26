module("modules.logic.character.view.destiny.CharacterDestinyUnlockStoneComp", package.seeall)

slot0 = class("CharacterDestinyUnlockStoneComp", LuaCompBase)

function slot0.onInitView(slot0)
	slot0._simagefullbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_fullbg")
	slot0._txtdragtip = gohelper.findChildText(slot0.viewGO, "txt_dragtip")
	slot0._gostone = gohelper.findChild(slot0.viewGO, "#go_stone")
	slot0._simagestone = gohelper.findChildSingleImage(slot0.viewGO, "#go_stone/#simage_stone")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.init(slot0, slot1)
	slot0.viewGO = slot1

	slot0:onInitView()
end

function slot0.addEventListeners(slot0)
	slot0:addEvents()
end

function slot0.removeEventListeners(slot0)
	slot0:removeEvents()
end

function slot0._editableInitView(slot0)
	slot0._goeffect = gohelper.findChild(slot0.viewGO, "effectItem")
	slot0._effectItems = slot0:getUserDataTb_()

	for slot4 = 1, CharacterDestinyEnum.EffectItemCount do
		slot5 = slot0:getEffectItem(slot4)
		slot6, slot7 = recthelper.getAnchor(slot5.go.transform)
		slot5.orignAnchor = {
			x = slot6,
			y = slot7
		}
	end

	slot0._imagestone = gohelper.findChildImage(slot0.viewGO, "#go_stone/#simage_stone")
	slot0._imagestone.color = Color(0.5, 0.5, 0.5, 1)
	slot0._linempc = gohelper.findChild(slot0.viewGO, "#go_line"):GetComponent(typeof(ZProj.MaterialPropsCtrl))
	slot0._effectmpc = slot0._goeffect:GetComponent(typeof(ZProj.MaterialPropsCtrl))
end

function slot0._onDragBegin(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	if slot0._isSuccessUnlock[slot1] then
		return
	end

	if not slot0._effectItems[slot1] or not slot3.isCanDrag then
		return
	end

	AudioMgr.instance:trigger(AudioEnum.CharacterDestinyStone.play_ui_resonate_property_click)
end

function slot0._onDrag(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	if slot0._isSuccessUnlock[slot1] then
		return
	end

	if not slot0._effectItems[slot1] or not slot3.isCanDrag then
		return
	end

	slot4 = recthelper.screenPosToAnchorPos(GamepadController.instance:getMousePosition(), slot0.viewGO.transform)

	recthelper.setAnchor(slot3.go.transform, slot4.x, slot4.y)
end

function slot0._onDragEnd(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	if slot0._isSuccessUnlock[slot1] then
		return
	end

	if not slot0._effectItems[slot3] or not slot4.isCanDrag then
		return
	end

	if Vector2.Distance(slot4.go.transform.anchoredPosition, Vector2.zero) < 300 then
		slot0:_finishDrag(slot3)
	else
		slot0:_returnOrginPos(slot3)
	end
end

function slot0._returnOrginPos(slot0, slot1)
	slot2 = slot0._effectItems[slot1]
	slot4 = slot2.orignAnchor
	slot2.tweenId = ZProj.TweenHelper.DOAnchorPos(slot2.go.transform, slot4.x, slot4.y, Mathf.Clamp(Vector2.Distance(slot2.go.transform.anchoredPosition, Vector2(slot4.x, slot4.y)) * 0.001, 0.5, 1))
end

function slot0._finishDrag(slot0, slot1)
	slot2 = slot0._effectItems[slot1]

	slot2.anim:Play(CharacterDestinyEnum.StoneViewAnim.Close, 0, 0)
	gohelper.setActive(slot2.glow, true)

	slot0._isSuccessUnlock[slot1] = true

	TaskDispatcher.runDelay(slot0._checkAllFinish, slot0, 0.9)

	slot2.isCanDrag = false

	AudioMgr.instance:trigger(AudioEnum.CharacterDestinyStone.play_ui_fate_runes_put)
end

function slot0._checkAllFinish(slot0)
	if slot0:_checkAllDragFinish() then
		if slot0._stoneView then
			AudioMgr.instance:trigger(AudioEnum.CharacterDestinyStone.play_ui_fate_lifestone_unlock)
			slot0._stoneView:playUnlockstoneAnim(CharacterDestinyEnum.StoneViewAnim.LevelUp, slot0._onUnlockStone, slot0)
			slot0._stoneView:onUnlockStone()
		else
			slot0:_onUnlockStone()
		end
	end
end

function slot0._onUnlockStone(slot0)
	CharacterDestinyController.instance:onUnlockStone(slot0.heroId, slot0.stoneId)
end

function slot0._checkAllDragFinish(slot0)
	for slot4 = 1, CharacterDestinyEnum.EffectItemCount do
		if not slot0._isSuccessUnlock[slot4] then
			return false
		end
	end

	return true
end

function slot0.onUpdateParam(slot0)
end

function slot0.onUpdateMo(slot0, slot1, slot2)
	slot0._isSuccessUnlock = {}
	slot0.heroId = slot1
	slot0.stoneId = slot2
	slot7 = CharacterDestinyConfig.instance:getDestinyFacetConsumeCo(slot2).icon

	slot0._simagestone:LoadImage(ResUrl.getDestinyIcon(slot7))

	for slot7 = 1, CharacterDestinyEnum.EffectItemCount do
		slot8 = slot0:getEffectItem(slot7)
		slot8.isCanDrag = true

		slot8.anim:Play(CharacterDestinyEnum.StoneViewAnim.Idle, 0, 0)

		if slot8.tweenId then
			ZProj.TweenHelper.KillById(slot8.tweenId)

			slot8.tweenId = nil
		end

		if slot8.orignAnchor then
			recthelper.setAnchor(slot8.go.transform, slot8.orignAnchor.x, slot8.orignAnchor.y)
		end

		if slot0._linempc.color_01 ~= CharacterDestinyEnum.SlotTend[slot3.tend].RuneColor then
			slot0._linempc.color_01 = slot10

			slot0._linempc:SetProps()
		end

		if slot0._effectmpc.color_01 ~= slot10 then
			slot0._effectmpc.color_01 = slot10

			slot0._effectmpc:SetProps()
		end

		gohelper.setActive(slot8.glow, false)
	end

	TaskDispatcher.cancelTask(slot0._checkAllFinish, slot0)
end

function slot0.setStoneView(slot0, slot1)
	slot0._stoneView = slot1
end

function slot0.getEffectItem(slot0, slot1)
	if not slot0._effectItems[slot1] then
		slot3 = gohelper.findChild(slot0._goeffect, slot1)
		slot4 = gohelper.findChild(slot3, "txt")
		slot2 = slot0:getUserDataTb_()
		slot2.go = slot3
		slot2.txt = slot4
		slot2.txtglow = gohelper.findChildImage(slot3, "#txt_glow")
		slot2.drag = SLFramework.UGUI.UIDragListener.Get(slot4.gameObject)

		slot2.drag:AddDragBeginListener(slot0._onDragBegin, slot0, slot1)
		slot2.drag:AddDragListener(slot0._onDrag, slot0, slot1)
		slot2.drag:AddDragEndListener(slot0._onDragEnd, slot0, slot1)

		slot2.anim = slot3:GetComponent(typeof(UnityEngine.Animator))
		slot2.glow = gohelper.findChild(gohelper.findChild(slot0.viewGO, "#go_line/#mesh0" .. slot1), "#glow")
		slot2.isCanDrag = true
		slot0._effectItems[slot1] = slot2
	end

	return slot2
end

function slot0.onClose(slot0)
end

function slot0.onDestroy(slot0)
	for slot4, slot5 in pairs(slot0._effectItems) do
		slot5.drag:RemoveDragBeginListener()
		slot5.drag:RemoveDragListener()
		slot5.drag:RemoveDragEndListener()

		if slot5.tweenId then
			ZProj.TweenHelper.KillById(slot5.tweenId)

			slot5.tweenId = nil
		end
	end

	slot0._simagestone:UnLoadImage()
	TaskDispatcher.cancelTask(slot0._checkAllFinish, slot0)
end

return slot0
