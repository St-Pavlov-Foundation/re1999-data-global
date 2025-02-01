module("modules.logic.versionactivity2_2.eliminate.view.eliminateChess.EliminateMainCharacterSkill", package.seeall)

slot0 = class("EliminateMainCharacterSkill", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._gorectMask = gohelper.findChild(slot0.viewGO, "#go_rectMask")
	slot0._txtskillTipDesc = gohelper.findChildText(slot0.viewGO, "#txt_skillTipDesc")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

slot1 = typeof(ZProj.RectMaskHole)
slot2 = SLFramework.UGUI.UIClickListener
slot3 = UnityEngine.EventSystems.EventSystem

function slot0._editableInitView(slot0)
	slot0._rectMaskHole = slot0._gorectMask:GetComponent(uv0)
	slot0._rectMaskHoleTr = slot0._rectMaskHole.transform
	slot0._rectMaskHole.enableClick = false
	slot0._rectMaskHole.enableDrag = false
	slot0._rectMaskHole.enablePress = false
	slot0._rectMaskHole.enableTargetClick = false
	slot0._rectMaskClick = uv1.Get(slot0._gorectMask)

	slot0._rectMaskClick:AddClickListener(slot0.onClick, slot0)
end

function slot0.onClick(slot0)
	slot1 = UnityEngine.Input.mousePosition

	if slot0._pointerEventData == nil then
		slot0._pointerEventData = UnityEngine.EventSystems.PointerEventData.New(uv0.current)
		slot0._raycastResults = System.Collections.Generic.List_UnityEngine_EventSystems_RaycastResult.New()
	end

	slot0._pointerEventData.position = slot1

	if slot0:isInRect(slot0._pointerEventData) then
		slot0:checkAndExecute()
	else
		slot0:rectMaskClick()
	end
end

function slot0.checkAndExecute(slot0)
	if slot0._raycastResults == nil then
		return
	end

	uv0.current:RaycastAll(slot0._pointerEventData, slot0._raycastResults)

	slot1 = slot0._pointerEventData.pointerCurrentRaycast.gameObject

	if EliminateLevelModel.instance:getCurRoundType() == EliminateEnum.RoundType.TeamChess then
		slot0._raycastResults:Clear()
	end

	slot4 = slot0._raycastResults:GetEnumerator()

	while slot4:MoveNext() do
		if slot4.Current.gameObject ~= slot1 and slot6 ~= slot0._gorectMask and not gohelper.isNil(slot6:GetComponent(typeof(UnityEngine.UI.Button))) then
			slot7:OnPointerClick(slot0._pointerEventData)
		end
	end
end

slot4 = Vector2.New(0, 0)
slot5 = UnityEngine.Rect.New(0, 0, 0, 0)

function slot0.isInRect(slot0, slot1)
	if slot0._size == nil or slot0._center == nil then
		return false
	end

	slot5 = slot0._size.x or 0
	slot6 = slot0._size.y or 0

	uv0:Set((slot0._center.x or 0) - slot5 * 0.5, (slot0._center.y or 0) - slot6 * 0.5, slot5, slot6)

	slot7, slot8 = UnityEngine.RectTransformUtility.ScreenPointToLocalPointInRectangle(slot0._rectMaskHoleTr, slot1.position, CameraMgr.instance:getMainCamera(), uv1)

	if slot7 and uv0:Contains(slot8) then
		return true
	end

	return false
end

function slot0.rectMaskClick(slot0)
	if slot0._rectMaskClickCb and slot0._rectMaskClickCbTarget then
		slot0._rectMaskClickCb(slot0._rectMaskClickCbTarget)
	end
end

function slot0.setTargetTrAndHoleSize(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0._rectMaskHole.size = Vector2(slot2, slot3)
	slot7 = Vector2(slot5 or 0, slot4 or -30)
	slot0._center = slot7
	slot0._size = slot6

	slot0._rectMaskHole:SetTarget(slot1, slot7, slot7, nil)
end

function slot0.setCanvas(slot0, slot1)
	slot0._rectMaskHole.mainCanvas = slot1
	slot2 = CameraMgr.instance:getMainCamera()
	slot0._rectMaskHole.mainCamera = slot2
	slot0._rectMaskHole.uiCamera = slot2
end

function slot0.setClickCb(slot0, slot1, slot2)
	slot0._rectMaskClickCb = slot1
	slot0._rectMaskClickCbTarget = slot2
end

function slot0.refreshSkillData(slot0)
	slot0._skillData = EliminateLevelController.instance:getCurSelectSkill()
	slot0._txtskillTipDesc.text = slot0._skillData:getSkillConfig().skillPrompt
end

function slot0.refreshTeamChessSkillData(slot0)
	slot0._txtskillTipDesc.text = luaLang("select_skill_target")
end

function slot0.onDestroyView(slot0)
	if slot0._rectMaskHole then
		slot0._rectMaskHole:InitPointerLuaFunction(nil, )

		slot0._rectMaskHole = nil
	end

	if slot0._rectMaskClick then
		slot0._rectMaskClick:RemoveClickListener()

		slot0._rectMaskClick = nil
		slot0._pointerEventData = nil
		slot0._raycastResults = nil
	end

	slot0._size = nil
	slot0._center = nil
	slot0._rectMaskClickCb = nil
	slot0._rectMaskClickCbTarget = nil
end

return slot0
